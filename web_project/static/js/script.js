// Toggle mobile navigation
function toggleNav() {
    var navLinks = document.querySelector('.nav-links');
    navLinks.classList.toggle('active');
}
 
document.addEventListener('DOMContentLoaded', function () {
    const skillsCategory = document.getElementById('skills-category');
    const educationCategory = document.getElementById('education-category');
    const militaryCategory = document.getElementById('military-category');

    skillsCategory.addEventListener('click', () => showCategoryInfo(skillsCategory));
    educationCategory.addEventListener('click', () => showCategoryInfo(educationCategory));
    militaryCategory.addEventListener('click', () => showCategoryInfo(militaryCategory));

    function showCategoryInfo(category) {
        const categories = document.querySelectorAll('.category');
        categories.forEach(cat => {
            cat.classList.remove('active');
        });

        category.classList.add('active');
    }
});
