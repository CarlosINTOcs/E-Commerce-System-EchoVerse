document.addEventListener('DOMContentLoaded', function() {
	const infoIcons = document.querySelectorAll('.info-icon');
    
	infoIcons.forEach(function(icon) {
		icon.addEventListener('mouseover', function() {
			const category = this.getAttribute('data-category');
			const tooltip = this.nextElementSibling;
			tooltip.textContent = getCategoryInfo(category);
			tooltip.style.display = 'block';
		});
		icon.addEventListener('mouseout', function() {
			const tooltip = this.nextElementSibling;
			tooltip.style.display = 'none';
		});
	});
    
	function getCategoryInfo(category) {
		const info = {
			'SEDAN': 'A sedan is a passenger car in a three-box configuration with separate compartments for engine, passenger, and cargo.',
			'COUPE': 'A coupe is a passenger car with a sloping rear roofline and two doors.',
			'SUV': 'SUV stands for Sport Utility Vehicle, offering higher ground clearance and all-wheel drive.',
			'TRUCK': 'Trucks are designed to transport cargo and often have higher payload capacities.',
			'HATCHBACK': 'A hatchback is a car with a hatch-type rear door that opens upwards.',
			'CONVERTIBLE': 'Convertibles have a retractable roof, allowing them to convert between open-top and closed-top configurations.',
			'MINIVAN':'Minivan usually means more capability; luxury minivans can be more comfortable when people are sitting, otherwise they carry more goods.',
			'Sport': 'Sport cars are designed for performance, featuring powerful engines and agile handling.'
		};
		return info[category] || 'No additional information available for this category.';
	}
    
	//Carousel Functionality
	const carouselImages = document.querySelectorAll('.carousel-image');
	const leftBtn = document.querySelector('.left-btn');
	const rightBtn = document.querySelector('.right-btn');
	let currentIndex = 0;
	const totalImages = carouselImages.length;
	let carouselInterval;

	//init carousel
	function initCarousel() {
		carouselImages.forEach((img, index) => {
			if(index === 0) {
				img.classList.add('active');
			} else {
				img.classList.remove('active');
			}
		});
		startCarousel();
	}

	//start automatic carousel
	function startCarousel() {
		carouselInterval = setInterval(() => {
			moveToNextImage();
		}, 3000);//3 second
	}

	//stop automatic carousel
	function stopCarousel() {
		clearInterval(carouselInterval);
	}

	//move to next image
	function moveToNextImage() {
		carouselImages[currentIndex].classList.remove('active');
		currentIndex = (currentIndex + 1) % totalImages;
		carouselImages[currentIndex].classList.add('active');
	}

	//move to previous image
	function moveToPrevImage() {
		carouselImages[currentIndex].classList.remove('active');
		currentIndex = (currentIndex - 1 + totalImages) % totalImages;
		carouselImages[currentIndex].classList.add('active');
	}

	//event listeners for buttons
	rightBtn.addEventListener('click', () => {
		stopCarousel();
		moveToNextImage();
		startCarousel();
	});

	leftBtn.addEventListener('click', () => {
		stopCarousel();
		moveToPrevImage();
		startCarousel();
	});

	//init the carousel on page load
	initCarousel();
});
