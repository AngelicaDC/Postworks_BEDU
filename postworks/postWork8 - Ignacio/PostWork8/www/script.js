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

    // Documentacion
    container = document.querySelector('#shiny-tab-postworks .row .box');
    container.classList.add('html-container');
    console.log(container);


    fetch('postworks.html').then(r=>r.text()).then(html => {
        container.innerHTML = html;
    });
}