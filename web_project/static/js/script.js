// Toggle mobile navigation
function toggleNav() {
    var navLinks = document.querySelector('.nav-links');
    navLinks.classList.toggle('active');
}
 
document.addEventListener('DOMContentLoaded', function () {
    const categories = document.querySelectorAll('.category');

    categories.forEach(category => {
        const toggleButton = category.querySelector('.category-toggle-button');
        toggleButton.addEventListener('click', () => toggleCategory(category));
    });

    function toggleCategory(category) {
        const categoryContent = category.querySelector('.category-content');
        const toggleButton = category.querySelector('.category-toggle-button');
        
        categoryContent.classList.toggle('active');
        toggleButton.textContent = categoryContent.classList.contains('active') ? 'Close' : 'Open';
    }
});
