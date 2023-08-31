// Toggle mobile navigation
function toggleNav() {
    var navLinks = document.querySelector('.nav-links');
    navLinks.classList.toggle('active');
}

document.addEventListener('DOMContentLoaded', function () {
    const skillsCategory = document.getElementById('skills-category');
    const educationCategory = document.getElementById('education-category');
    const militaryCategory = document.getElementById('military-category');

    skillsCategory.addEventListener('click', () => toggleCategory(skillsCategory));
    educationCategory.addEventListener('click', () => toggleCategory(educationCategory));
    militaryCategory.addEventListener('click', () => toggleCategory(militaryCategory));

    function toggleCategory(category) {
        const categories = document.querySelectorAll('.category');
        categories.forEach(cat => {
            if (cat === category) {
                cat.classList.toggle('active');
            } else {
                cat.classList.remove('active');
            }
        });
    }
});

