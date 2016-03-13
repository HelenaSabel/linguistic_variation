
function checkboxes() {
    var inputs = document.querySelectorAll('input[type="checkbox"]');
    for (var i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener('change', changeCriteria, false);
    }
}

function changeCriteria() {
    
    var id = this.getAttribute('value');
    var dels = document.querySelectorAll('del');
    var adds = document.querySelectorAll('ins');
    var apostrophes = document.getElementsByClassName('supplied');
    
    switch (id) {
        case 'del':
        
        if (this.checked == true) { for (var i = 0; i < dels.length; i++) {
                dels[i].classList.remove('hide');
                
                if (dels[i].classList.contains('underdot')) {
                    var letters = dels[i].textContent.split('');
                    var output = '';
                    for (var j = 0; j < letters.length; j++) {
                        output += (letters[j] + '&#803;');
                    }
                    dels[i].innerHTML = output;
                }
                if (dels[i].classList.contains('multiple-overstrike')) {
                    var letters = dels[i].textContent.split('');
                    var output2 = '';
                    for (var y = 0; y < letters.length; j++) {
                        output += (letters[y] + '&#824;');
                    }
                    dels[i].innerHTML = output2;
                }
                
                if (dels[i].classList.contains('scrape')) {
                    dels[i].style.opacity = '0.9';
                }
            }
        } else { for (var i = 0; i < dels.length; i++) {
                dels[i].classList.add('hide');
            }
        }
        
        break;
        
        case 'add':
        
        if (this.checked == true) {
            
            for (var i = 0; i < adds.length; i++) {
                adds[i].classList.add('enhance');
            }
        } else { for (var i = 0; i < adds.length; i++) {
                adds[i].classList.remove('enhance')
            }
        }
        
        break;
        
        case 'apostrophe':
        
        if (this.checked == false) {
            
            for (var i = 0; i < apostrophes.length; i++) {
                apostrophes[i].classList.add('hide');
            }
        } else {
            for (var i = 0; i < apostrophes.length; i++) {
                apostrophes[i].classList.remove('hide');
            }
        }
    }
}

window.addEventListener('load', checkboxes, false);