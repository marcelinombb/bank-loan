const BASE_URL = "http://localhost/bank-loan/";

function loadForm() {
    let rightColumn = document.querySelector("#right-column").innerHTML = loginForm();
}

function loginForm() {
    let form;

    form = `<div class="d-flex flex-column" id="sign-form">
    <h2>Entrar</h2>
    <form>
    <div class="form-group">
        <label for="sign-cpf">CPF</label>
        <input type="password" class="form-control" id="sign-cpf" required="required" placeholder="Insira nome">
    </div>

    <div class="form-group">
        <label for="sign-pass">Senha</label>
        <input type="text" class="form-control" id="sign-pass" required="required" placeholder="Insira CPF">
    </div>
    
    <button type="submit" class="btn submit-account" onclick="login()">Entrar</button>
    </form>
    </div>`

    return form;
}

function login() {
    document.querySelector('#sign-form').addEventListener('submit', event => {
        event.preventDefault();
    });

    let pass = document.querySelector("#sign-cpf").value;
    let cpf = document.querySelector("#sign-pass").value;

    if ((cpf !== '') && (pass !== '')) {
        let data = {
            cpf: cpf,
            pass: pass
        };

        let options = {
            method: 'POST',
            body: JSON.stringify(data),
            headers: {
                'Content-Type': 'application/json'
            }
        };

        if ((data.cpf.length !== 0)) {
            const URL = BASE_URL + 'auth/login';
            fetch(URL, options).then(response => response.json())
                    .then(data => {
                        if (data.success === true) {
                            window.location = BASE_URL + 'home/home';
                        } else {

                            let message = "authentication failed";
                            let modal = document.querySelector('#auth-alert');

                            modal.querySelector('#alert-class').classList.add('alert-warning');
                            modal.querySelector('#alert-class').textContent = message;
                            $('#auth-alert').modal('show');
                        }

                    })
                    .catch(error => {
                        console.log(error);
                    });
        }
    }
}