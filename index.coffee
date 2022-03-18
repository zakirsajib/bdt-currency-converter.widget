# bdt-currency-converter
# author : zakir sajib
# email: zakirsajib@gmail.com
# Website: https://zsresume.netlify.app/

# HOWTO
# replace the fromXXX and to variables with the corresponding currencies

# Change APi key here: line # 76
# http://api.exchangeratesapi.io/v1/latest?access_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxx

# enjoy!

command    : ""
fromEUR    : "EUR"
fromUSD    : "USD"
fromGBP    : "GBP"
to         : "BDT"
refreshFrequency: 15 * 60 * 1000

style: """
  top: 460px
  left: 20px
  text-align: center
  background: rgba(#000, 0.5)
  padding 10px 10px 0px
  border-radius 5px
  font-family Helvetica
  width: 300px

  .container
    display: flex
    flex-direction: row
    justify-content: space-between
    align-items: center

  h3
    font-size: 14px
    color: rgba(#fff, .8)
    text-shadow: 0 1px 0px rgba(#000, .7)
    margin: 0 0 15px;
    letter-spacing: 2px
  span
    font-size: 12px
    font-weight: bold
    border-radius: 8px
    letter-spacing: 4px
    color: green
    position: relative
    bottom: 10px
"""

render: (input) ->
    """
    <div class="container">
      <div class="col">
        <h3>#{@fromEUR}-#{@to}</h3>
        <span id='eur'>To be replaced</span><br>
      </div>
      <div class="col">
        <h3>#{@fromUSD}-#{@to}</h3>
        <span id='usd'>To be replaced</span><br>
      </div>
      <div class="col">
        <h3>#{@fromGBP}-#{@to}</h3>
        <span id='gbp'>To be replaced</span>
      </div>
    </div>
    """
# This api does not support Currency Convertion as it is free to use



update : (input, domEl) ->
  $.ajax dataType: "jsonp",
  url:"http://api.exchangeratesapi.io/v1/latest?access_key=ENTERAPIKEYHERE",
  success: ( data ) =>
    @replaceRate(data)

replaceRate : (data) ->
  $domEl = $("##{@id}")

  $bdt = data.rates.BDT
  $usd = data.rates.USD
  $gbp = data.rates.GBP

  if !$bdt
    $domEl.hide()
  else
    #Euro
    $euro = (Math.round($bdt * 100) / 100)
    $domEl.find('#eur').html($euro)
    # To get USD to BDT Value, divide first from Euro to USD and then with Euro to BDT
    $usd = (Math.round($bdt/$usd * 100) / 100)
    $domEl.find('#usd').html($usd)
    # To get GBP to BDT Value, divide first from Euro to GBP and then with Euro to BDT.
    $gbp = (Math.round($bdt/$gbp * 100) / 100)
    $domEl.find('#gbp').html($gbp)
