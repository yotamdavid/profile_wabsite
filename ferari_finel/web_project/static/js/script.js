// Toggle mobile navigation
function toggleNav() {
    var navLinks = document.querySelector('.nav-links');
    navLinks.classList.toggle('active');
}

// Toggle project description on click
function toggleDescription(card) {
    var projectDesc = card.querySelector('.project-description');
    var projectDescHidden = card.querySelector('.project-description-hidden');
    var learnMoreLink = card.querySelector('.learn-more');

    projectDesc.classList.toggle('hidden');
    projectDescHidden.classList.toggle('visible');
    learnMoreLink.classList.toggle('hidden');
}

// Initialize by hiding additional descriptions
var projectCards = document.querySelectorAll('.project-card');
projectCards.forEach(function(card) {
    var projectDesc = card.querySelector('.project-description');
    var projectDescHidden = card.querySelector('.project-description-hidden');
    var learnMoreLink = card.querySelector('.learn-more');

    projectDescHidden.classList.add('visible');
    projectDesc.classList.remove('hidden');
    learnMoreLink.classList.remove('hidden');
});

