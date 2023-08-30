// Toggle mobile navigation
function toggleNav() {
    var navLinks = document.querySelector('.nav-links');
    navLinks.classList.toggle('active');
}

document.addEventListener('DOMContentLoaded', function () {
    const categories = document.querySelectorAll('.category');

    categories.forEach(category => {
        const categoryCheckbox = category.querySelector('.category-toggle');

        categoryCheckbox.addEventListener('change', () => {
            categories.forEach(cat => {
                if (cat !== category) {
                    cat.classList.remove('category-active');
                }
            });
            
            category.classList.toggle('category-active', categoryCheckbox.checked);
        });
    });
});

