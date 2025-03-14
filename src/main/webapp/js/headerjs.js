    window.addEventListener('scroll', function () {
    var navbar = document.querySelector('.navbar');
    var topBarHeight = document.querySelector('.top-bar').offsetHeight;
    if (window.scrollY > topBarHeight) {
    navbar.classList.add('fixed-navbar');
} else {
    navbar.classList.remove('fixed-navbar');
}
});
