// Toggle mobile navigation
function toggleNav() {
    var navLinks = document.querySelector('.nav-links');
    navLinks.classList.toggle('active');
}

document.addEventListener('DOMContentLoaded', function () {
    const categories = document.querySelectorAll('.category');
    let lastClickedCategory = null;

    categories.forEach(category => {
        category.addEventListener('click', () => toggleCategory(category));
    });

    function toggleCategory(category) {
        if (lastClickedCategory === category) {
            category.classList.toggle('active');
        } else {
            categories.forEach(cat => {
                cat.classList.remove('active');
            });
            category.classList.add('active');
        }

        lastClickedCategory = category;
    }
});
