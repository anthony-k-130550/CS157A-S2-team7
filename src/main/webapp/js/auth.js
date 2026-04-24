// REGISTER
const registerForm = document.getElementById("registerForm");

if (registerForm) {

registerForm.addEventListener("submit", function(e) {

e.preventDefault();

let fullname = document.getElementById("fullname").value;
let email = document.getElementById("email").value;
let password = document.getElementById("password").value;
let department = document.getElementById("department").value;
let role = document.getElementById("role").value;

let users = JSON.parse(localStorage.getItem("users")) || [];

// check duplicate email
let exists = users.find(user => user.email === email);

if (exists) {
document.getElementById("message").innerText = "Email already registered";
return;
}

let newUser = {
fullname,
email,
password,
department,
role
};

users.push(newUser);

localStorage.setItem("users", JSON.stringify(users));

document.getElementById("message").innerText = "Account created successfully";

registerForm.reset();

});
}


// LOGIN
const loginForm = document.getElementById("loginForm");

if (loginForm) {

loginForm.addEventListener("submit", function(e){

e.preventDefault();

let email = document.getElementById("loginEmail").value;
let password = document.getElementById("loginPassword").value;

let users = JSON.parse(localStorage.getItem("users")) || [];

let user = users.find(u => u.email === email && u.password === password);

if (!user){
document.getElementById("loginMessage").innerText = "Invalid email or password";
return;
}

document.getElementById("loginMessage").innerText = "Login successful!";

});
}