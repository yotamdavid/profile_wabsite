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

document.addEventListener('DOMContentLoaded', function () {
    const contactForm = document.getElementById('contact-form');

    contactForm.addEventListener('submit', function (event) {
        event.preventDefault();

        const formData = new FormData(contactForm);
        const formDataObject = {};
        
        formData.forEach((value, key) => {
            formDataObject[key] = value;
        });

        // Send formDataObject to server or process it as needed
        console.log(formDataObject);

        // Reset the form
        contactForm.reset();
    });
});
