// ①jsを動かす記述
window.addEventListener("load",function(){
  
  // ②価格入力欄のID属性を取得し、priceInputに代入
  const priceInput = document.getElementById("item-price") 
  
  // ③上記で入れた変数priceInputに対してのイベント発火条件を記述
  priceInput.addEventListener("input",function(){

    // ④ priceInputの中で入力された値を取り出して変数priceに代入
  const price = document.getElementById("item-price").value

  // ⑤変数priceに対して計算し、tax(出品手数料)とprofit(販売利益)を定義し代入
  const tax = price * 0.1
  const profit = price - tax

  // ⑥手数料部分には変数taxの値を入れる
      const taxForm = document.getElementById("add-tax-price")
      taxForm.textContent = Math.floor(tax)
      // Math.floor() 小数点の切り捨て

      // ⑦利益部分に変数profitの値を入れる
      const profitForm = document.getElementById("profit")
      profitForm.textContent = Math.ceil(profit)
      // ceil 小数点の切り上げ
      
  })
});
