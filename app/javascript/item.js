function item() {

  const price  = document.getElementById("item-price");
  price.addEventListener("keyup", () => {
    const commission = Math.floor(price.value * 0.1);
    const tax  = document.getElementById("add-tax-price");
      tax.innerHTML = `${commission}`;
    const profit  = document.getElementById("profit");
      profit.innerHTML = `${price.value - commission}`;
  });

}


window.addEventListener('load', item);