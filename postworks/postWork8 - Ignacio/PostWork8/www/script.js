window.onload = function() {
    // Mover las imagenes
    imgContainer = document.querySelector('#shiny-tab-PW3 .box-body');
    imgs = imgContainer.querySelectorAll('img');

    nwContainer = document.createElement('div');
    nwContainer.classList.add('img-container');
    
    imgs.forEach(i => {
        nwContainer.innerHTML += i.outerHTML;
        i.remove();
    });
    
    imgContainer.appendChild(nwContainer); 

    console.log(nwContainer.innerHTML);
}