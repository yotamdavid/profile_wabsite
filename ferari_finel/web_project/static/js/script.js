// Toggle mobile navigation
function toggleNav() {
    var navLinks = document.querySelector('.nav-links');
    navLinks.classList.toggle('active');
}

// Flip project card on hover
function rotateCard(card) {
    card.classList.toggle('flipped');
}

// Initialize by hiding flipped descriptions
var projectCards = document.querySelectorAll('.project-card');
projectCards.forEach(function(card) {
    var projectDesc = card.querySelector('.project-description');
    var projectDescFlipped = card.querySelector('.project-description-flipped');
    projectDesc.style.display = 'block';
    projectDescFlipped.style.display = 'none';
});

// Toggle the visibility of project descriptions initially
function toggleInitialDesc(card) {
    var projectDesc = card.querySelector('.project-description');
    var projectDescFlipped = card.querySelector('.project-description-flipped');
    projectDesc.style.display = 'block';
    projectDescFlipped.style.display = 'none';
}

var initialCards = document.querySelectorAll('.project-card');
initialCards.forEach(toggleInitialDesc);
