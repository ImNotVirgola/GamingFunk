let debounceTimer;
let currentSelection = -1;
let suggestionsList = [];

// Funzione principale per fetch dei suggerimenti
function fetchSuggestions() {
    const input = document.getElementById("searchInput");
    const query = input.value.trim();

    clearTimeout(debounceTimer);

    if (query.length < 1) {
        hideSuggestions();
        showHistory();
        resetCatalogo();
        return;
    }

    debounceTimer = setTimeout(() => {
        fetch(`suggerimenti?term=${encodeURIComponent(query)}`)
            .then(response => {
                if (!response.ok) throw new Error("Errore nella risposta");
                return response.json();
            })
            .then(data => {
                suggestionsList = data;
                currentSelection = -1;

                const suggestionsDiv = document.getElementById("suggestions");

                if (!data || data.length === 0) {
                    hideSuggestions();
                    return;
                }

                suggestionsDiv.innerHTML = data.map((sug, index) =>
                    `<div class="suggestion-item" data-index="${index}" onclick="selezionaSuggerimento('${escapeHtml(sug)}')">${escapeHtml(sug)}</div>`
                ).join("");

                suggestionsDiv.style.display = "block";
            })
            .catch(err => {
                console.error("Errore nel recupero suggerimenti:", err);
                hideSuggestions();
            });
    }, 300);
}

// Nasconde i suggerimenti
function hideSuggestions() {
    const suggestionsDiv = document.getElementById("suggestions");
    suggestionsDiv.innerHTML = "";
    suggestionsDiv.style.display = "none";
    currentSelection = -1;
}

// Ripristina il catalogo iniziale
function resetCatalogo() {
    fetch(window.location.href)
        .then(res => res.text())
        .then(html => {
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, "text/html");
            const nuovoCatalogo = doc.getElementById("catalogo-container");
            document.getElementById("catalogo-container").innerHTML = nuovoCatalogo.innerHTML;
        });
}

// Seleziona un suggerimento e cerca
function selezionaSuggerimento(suggerimento) {
    const input = document.getElementById("searchInput");
    input.value = suggerimento;
    hideSuggestions();
    input.scrollIntoView({ behavior: 'smooth', block: 'start' });

    const term = suggerimento;
    saveSearch(term);
    cercaProdotto(term);

    currentSelection = -1;
    suggestionsList = [];
}

// Funzione per la ricerca lato server
function cercaProdotto(term) {
    fetch('cerca?term=' + encodeURIComponent(term))
        .then(res => {
            if (!res.ok) throw new Error("Errore nella risposta");
            return res.json();
        })
        .then(prodotti => {
            const container = document.getElementById("catalogo-container");
            if (prodotti.length === 0) {
                container.innerHTML = "<p>Nessun prodotto trovato.</p>";
                return;
            }
            container.innerHTML = prodotti.map(p => `
                <div class="prodotto" data-nome="${p.nome.toLowerCase()}">
                    <img src="${p.pathImmagine}" alt="${p.nome}">
                    <h2>${p.nome}</h2>
                    <p class="prezzo">€ ${p.prezzo}</p>
                    <form action="aggiungi-al-carrello" method="post">
                        <input type="hidden" name="id" value="${p.idProdotto}">
                        <input type="hidden" name="nome" value="${p.nome}">
                        <input type="hidden" name="prezzo" value="${p.prezzo}">
                        <button type="submit" class="btn aggiungi-carrello">Aggiungi al carrello</button>
                    </form>
                </div>
            `).join("");
        })
        .catch(err => {
            console.error("Errore nella ricerca:", err);
            document.getElementById("catalogo-container").innerHTML = "<p>Errore nella ricerca.</p>";
        });
}

// Escape HTML per prevenire XSS
function escapeHtml(str) {
    return str.replace(/[&<>"'`]/g, m => ({
        '&': '&amp;',
        '<': '<',
        '>': '>',
        '"': '&quot;',
        "'": '&#39;',
        '`': '&#x60;'
    }[m]));
}

// Salva la cronologia delle ricerche
function saveSearch(term) {
    let history = JSON.parse(localStorage.getItem("searchHistory") || "[]");
    if (!history.includes(term)) {
        history.unshift(term);
        if (history.length > 5) history.pop();
        localStorage.setItem("searchHistory", JSON.stringify(history));
    }
}

// Mostra la cronologia delle ricerche
/*function showHistory() {
    const history = JSON.parse(localStorage.getItem("searchHistory") || "[]");
    const suggestionsDiv = document.getElementById("suggestions");
    if (history.length > 0) {
        suggestionsDiv.innerHTML = history.map(term =>
            `<div class="suggestion-item" onclick="selezionaSuggerimento('${term}')">🔍 ${term}</div>`
        ).join("");
        suggestionsDiv.style.display = "block";
    }
}*/
/*function showHistory() {
    const history = JSON.parse(localStorage.getItem("searchHistory") || "[]");
    const suggestionsDiv = document.getElementById("suggestions");
    if (history.length === 0) return;

    suggestionsDiv.innerHTML = history.map((term, index) => `
        <div class="suggestion-item" onclick="selezionaSuggerimento('${term}')">
            🔍 ${term}
            <span class="remove-btn" onclick="rimuoviDallaCronologia(event, '${term}')"> &times; </span>
        </div>
    `).join("");

    suggestionsDiv.style.display = "block";
}*/
function showHistory() {
    const history = JSON.parse(localStorage.getItem("searchHistory") || "[]");
    const suggestionsDiv = document.getElementById("suggestions");
    if (history.length === 0) return;

    suggestionsDiv.innerHTML = history.map((term, index) => `
        <div class="suggestion-item" onclick="selezionaSuggerimento('${term}')">
            <span>🔍 ${term}</span>
            <span class="remove-btn" onclick="rimuoviDallaCronologia(event, '${term}')">&times;</span>
        </div>
    `).join("");

    suggestionsDiv.style.display = "block";
}

// Gestione tasti ↑ ↓ ↵ per navigare i suggerimenti
function handleKeyDown(event) {
    const suggestions = document.getElementById("suggestions");
    if (!suggestions || suggestions.style.display !== "block") return;

    const items = suggestions.querySelectorAll(".suggestion-item");
    if (!items.length) return;

    if (event.key === "ArrowDown") {
        event.preventDefault(); // Evita lo scroll della pagina
        currentSelection = (currentSelection + 1) % items.length;
        highlightItem(items);
    } else if (event.key === "ArrowUp") {
        event.preventDefault(); // Evita lo scroll della pagina
        currentSelection = (currentSelection - 1 + items.length) % items.length;
        highlightItem(items);
    } else if (event.key === "Enter") {
        if (currentSelection >= 0) {
            const selected = items[currentSelection].innerText.replace("🔍 ", "");
            selezionaSuggerimento(selected);
        }
    }
}

// Evidenzia l'elemento corrente
function highlightItem(items) {
    items.forEach((item, index) => {
        item.style.backgroundColor = "";
        item.style.color = "";
    });

    if (items[currentSelection]) {
        items[currentSelection].style.backgroundColor = "#2E2E4D";
        items[currentSelection].style.color = "#E6E300";
        items[currentSelection].scrollIntoView({ block: "nearest", behavior: "smooth" });
    }
}

/*function rimuoviDallaCronologia(event, term) {
    event.stopPropagation(); // Evita di attivare il click su .suggestion-item

    let history = JSON.parse(localStorage.getItem("searchHistory") || "[]");
    history = history.filter(t => t !== term); // Rimuove il termine selezionato
    localStorage.setItem("searchHistory", JSON.stringify(history));

    showHistory(); // Aggiorna la lista
}*/

function rimuoviDallaCronologia(event, term) {
    event.stopPropagation();

    let history = JSON.parse(localStorage.getItem("searchHistory") || "[]");
    history = history.filter(t => t !== term);
    localStorage.setItem("searchHistory", JSON.stringify(history));

    const suggestionsDiv = document.getElementById("suggestions");

    if (history.length === 0) {
        suggestionsDiv.style.display = "none"; // Nascondi subito il menu
    } else {
        showHistory(); // Aggiorna la lista
    }

    document.getElementById("searchInput").focus(); // Mantiene il focus
}

// Nasconde i suggerimenti se clicco fuori
document.addEventListener('click', function (e) {
    const suggestions = document.getElementById("suggestions");
    const input = document.getElementById("searchInput");

    if (!input.contains(e.target) && !suggestions.contains(e.target)) {
        hideSuggestions();
    }
});

// Ascoltatore tastiera
document.getElementById("searchInput").addEventListener("keydown", handleKeyDown);