// Toggle mobile navigation
function toggleNav() {
    var navLinks = document.querySelector('.nav-links');
    navLinks.classList.toggle('active');
}

document.addEventListener('DOMContentLoaded', function () {
    const categoryTitles = document.querySelectorAll('.category-title');
    
    categoryTitles.forEach(title => {
        title.addEventListener('click', () => toggleCategory(title));
    });
    
    function toggleCategory(title) {
        const categories = document.querySelectorAll('.category');
        categories.forEach(cat => {
            if (cat.querySelector('.category-title') !== title) {
                cat.classList.remove('active');
            }
        });
        
        const category = title.parentNode;
        category.classList.toggle('active');
    }
});
