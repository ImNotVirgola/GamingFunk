<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione - GamingFunk</title>
    <link href="css/register.css" rel="stylesheet" type="text/css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-left">
            <img src="images/logo/logo.png" alt="Logo" class="logo">
        </div>
        <div class="navbar-center">
            <a href="catalogo.jsp">Catalogo</a>
            <a href="CommunityServlet">Community</a>
            <a href="blog.jsp">Blog</a>
            <a href="carrello.jsp">Carrello</a>
        </div>
        <div class="navbar-right"></div>
    </nav>

    <!-- Contenitore principale -->
    <div class="container">
        <h1>📝 Registrazione</h1>

        <!-- Messaggio di errore (visibile solo se presente) -->
        <%
		    String errorMessage = null;
		    session = request.getSession(false);
		    if (session != null) {
		        errorMessage = (String) session.getAttribute("errorMessage");
		        session.removeAttribute("errorMessage");
		    }
		%>
		<div class="error-message" id="error-message">
		    <%= (errorMessage != null) ? errorMessage : "" %>
		</div>


        <!-- Form di registrazione -->
        <form class="register-form" action="register" method="post">
            <!-- Layout a due colonne -->
            <div class="form-grid">
                <!-- Colonna Sinistra -->
                <div class="form-column">
                    <div class="form-group">
                        <label for="nome">Nome:</label>
                        <input type="text" id="nome" name="nome" placeholder= "Es. Mario" required>
                    </div>
                    <div class="form-group">
                        <label for="cognome">Cognome:</label>
                        <input type="text" id="cognome" name="cognome" placeholder= "Es. Rossi" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" placeholder= "Es. prova@example.it" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" placeholder= "Inserire una password" required>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Conferma Password:</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder= "Confermare la password inserita nel campo precedente" required>
                    </div>
                </div>

                <!-- Colonna Destra -->
                <div class="form-column">
                    <div class="form-group">
                        <label for="indirizzo">Indirizzo:</label>
                        <input type="text" id="indirizzo" name="indirizzo" placeholder= "Es. Via Roma, 10">
                    </div>
                    <div class="form-group">
                        <label for="citta">Città:</label>
                        <input type="text" id="citta" name="citta" placeholder= "Es. Roma">
                    </div>
                    <div class="form-group">
                        <label for="provincia">Provincia:</label>
                        <input type="text" id="provincia" name="provincia" placeholder= "Es. RM">
                    </div>
                    <div class="form-group">
                        <label for="cap">CAP:</label>
                        <input type="text" id="cap" name="cap" placeholder= "Es. 00100">
                    </div>
                </div>
            </div>

            <!-- Link al login e pulsante di invio -->
            <div class="form-footer">
            <!-- Requisiti password -->
				<div id="password-requirements" class="password-checklist" align = "left">
				    <p><span id="check-uppercase">❌</span> Almeno una lettera maiuscola</p>
				    <p><span id="check-lowercase">❌</span> Almeno una lettera minuscola</p>
				    <p><span id="check-number">❌</span> Almeno un numero</p>
				    <p><span id="check-special">❌</span> Almeno un carattere speciale</p>
				</div>
                <div class="link">
                    Hai già un account? <a href="${pageContext.request.contextPath}/login.jsp">Accedi qui</a>.
                </div>
                <button type="submit" class="btn">Registrati</button>
            </div>
        </form>
		</div>
		<script type="text/javascript">
			document.addEventListener("DOMContentLoaded", function () {
			    const url = "/GamingFunk";
			    const emailInput = document.getElementById("email");
			    const errorDiv = document.getElementById("error-message");
			
			    emailInput.addEventListener("blur", function () {
			        const email = emailInput.value;
			        if (!email) return;
			
			        fetch(url + "/verificaEmail?email=" + encodeURIComponent(email))
			            .then(response => response.json())
			            .then(data => {
			                // Pulisce eventuali timer precedenti
			                if (errorDiv.timerId) clearTimeout(errorDiv.timerId);
			
			                // Imposta messaggio e colore
			                if (data.esiste) {
			                    errorDiv.textContent = "❌ Questa email è già registrata.";
			                    errorDiv.style.backgroundColor = "#FF4D4D";
			                } else {
			                    errorDiv.textContent = "✅ Email disponibile.";
			                    errorDiv.style.backgroundColor = "#77DD77";
			                }
			
			                // Mostra con classe "visible"
			                errorDiv.classList.add("visible");
			                errorDiv.style.display = "block"; // (in caso venga nascosto da blocchi precedenti)
			
			                // Nasconde con effetto dopo 3 secondi
			                errorDiv.timerId = setTimeout(() => {
			                    errorDiv.classList.remove("visible");
			                    setTimeout(() => {
			                        errorDiv.style.display = "none";
			                    }, 400); // combacia con il tempo della transizione CSS
			                }, 3000);
			            })
			            .catch(error => {
			                console.error("Errore nella verifica email:", error);
			            });
			    });
			});
			
			const passwordInput = document.getElementById("password");
			const checkUpper = document.getElementById("check-uppercase");
			const checkLower = document.getElementById("check-lowercase");
			const checkNumber = document.getElementById("check-number");
			const checkSpecial = document.getElementById("check-special");
			
			passwordInput.addEventListener("input", function () {
			    const value = passwordInput.value;
			
			    // Regex di controllo
			    const hasUpper = /[A-Z]/.test(value);
			    const hasLower = /[a-z]/.test(value);
			    const hasNumber = /[0-9]/.test(value);
			    const hasSpecial = /[^A-Za-z0-9]/.test(value);
			
			    checkUpper.textContent = hasUpper ? "✅" : "❌";
			    checkLower.textContent = hasLower ? "✅" : "❌";
			    checkNumber.textContent = hasNumber ? "✅" : "❌";
			    checkSpecial.textContent = hasSpecial ? "✅" : "❌";
			});
		</script>
</body>
</html>