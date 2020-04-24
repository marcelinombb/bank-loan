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
        <input type="text" class="form-control" id="sign-cpf" required="required" placeholder="Insira cpf">
    </div>

    <div class="form-group">
        <label for="sign-pass">Senha</label>
        <input type="password" class="form-control" id="sign-pass" required="required" placeholder="Insira senha">
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

    let cpf = document.querySelector("#sign-cpf").value;
    let pass = document.querySelector("#sign-pass").value;

    if ((cpf.length > 0) && (pass.length > 0)) {
        
        const client = {
            cpf: cpf,
            pass: pass
        };

        const options = {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json;charset=utf-8'
            },
            body: JSON.stringify(client)
        };
            
       const URL = BASE_URL + 'auth/login';
            
        fetch(URL, options)
        .then(response => response.json())
        .then(data => {
            
            if (data.success === true) {
                window.location = BASE_URL + 'home';
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
        })
        
    }
}

function signup() {
    document.querySelector('#signup-form').addEventListener('submit', event => {
        event.preventDefault();
    });

    let name = document.querySelector("#client-name").value;
    let cpf = document.querySelector("#client-cpf").value;
    let pass = document.querySelector("#client-pass").value;

    if ((cpf.length > 0) && (pass.length > 0) && (name.length > 0)) {
        
        const client = {
            name: name,
            cpf: cpf,
            pass: pass
        };

        const options = {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json;charset=utf-8'
            },
            body: JSON.stringify(client)
        };
            
       const URL = BASE_URL + 'register/register';
            
        fetch(URL, options)
        .then(response => {
            return response.text();
        })
        .then(res => {
            document.getElementById('create-account').innerHTML = res;
        })
        .catch(error => {
            console.log(error);
        })
        
    }
}