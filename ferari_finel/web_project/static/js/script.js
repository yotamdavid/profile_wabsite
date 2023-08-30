// Toggle mobile navigation
function toggleNav() {
    var navLinks = document.querySelector('.nav-links');
    navLinks.classList.toggle('active');
}

// Flip project card on hover
function rotateCard(card) {
    card.classList.toggle('flipped');

    // Toggle the visibility of project descriptions
    var projectDesc = card.querySelector('.project-description');
    var projectDescFlipped = card.querySelector('.project-description-flipped');

    if (card.classList.contains('flipped')) {
        projectDesc.style.display = 'none';
        projectDescFlipped.style.display = 'block';
    } else {
        projectDesc.style.display = 'block';
        projectDescFlipped.style.display = 'none';
    }
}

// Initialize by hiding flipped descriptions
var projectCards = document.querySelectorAll('.project-card');
projectCards.forEach(function(card) {
    var projectDesc = card.querySelector('.project-description');
    var projectDescFlipped = card.querySelector('.project-description-flipped');
    projectDesc.style.display = 'block';
    projectDescFlipped.style.display = 'none';
});
