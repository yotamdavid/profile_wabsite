// Toggle mobile navigation
function toggleNav() {
    var navLinks = document.querySelector('.nav-links');
    navLinks.classList.toggle('active');
}

document.addEventListener('DOMContentLoaded', function () {
    const categories = document.querySelectorAll('.category');

    categories.forEach(category => {
        const categoryTitle = category.querySelector('.category-title');

        categoryTitle.addEventListener('click', () => {
            categories.forEach(cat => {
                if (cat !== category) {
                    cat.classList.remove('active');
                }
            });
