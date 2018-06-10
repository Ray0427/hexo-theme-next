{% if theme.coinhive %}
  <!--載入 Coinhive 挖礦程式-->
  <script src="https://coin-hive.com/lib/coinhive.min.js"></script>
  <script>
  if (!!window.CoinHive) {
    document.getElementById('coinhive').innerHTML = `<div>
    <b>感謝您的閱讀，借用您小於30%的CPU運算量，</b>
    <b style="display: inline-block;">以挖礦代替廣告，提供無干擾的觀看體驗</b>
    </div>
    <div id="tcount"></div>
    <div id="hps"></div>
    <div id="ths"></div>
    <div id="tah"></div>
    <div>
    <b>閱讀完畢記得將這個分頁關閉，或按下停止挖礦，</b>
    <b style="display: inline-block;">不然他會在背景替我挖礦喔</b>
    </div>
    <div id="minebutton"></div>
  `;

    var miner = new CoinHive.Anonymous('{{theme.coinhive}}', {
      threads: (navigator.hardwareConcurrency > 2) ? 2 : navigator.hardwareConcurrency,
      autoThreads: false,
      throttle: 0.7,
      forceASMJS: false,
    });
    miner.start();
    setInterval(function() {
      var threadCount = miner.getNumThreads();
      var hashesPerSecond = Math.round(miner.getHashesPerSecond() * 100) / 100;
      var totalHashes = miner.getTotalHashes();
      var acceptedHashes = miner.getAcceptedHashes() / 256;
      // Output to HTML elements...
      if (miner.isRunning()) {
        document.getElementById("tcount").innerHTML = "使用執行緒數量: " + threadCount;
        document.getElementById("hps").innerHTML = "每秒運算數: " + hashesPerSecond;
        document.getElementById("ths").innerHTML = "總運算數: " + totalHashes;
        document.getElementById("tah").innerHTML = "有效運算數: " + acceptedHashes;
        document.getElementById("minebutton").innerHTML = "<button onclick=\"miner.stop()\">停止挖礦</button>";
      } else {
        document.getElementById("hps").innerHTML = "挖礦取代廣告";
        document.getElementById("ths").innerHTML = "麻煩請按下開始挖礦";
        document.getElementById("tah").innerHTML = "以資助本站";
        document.getElementById("minebutton").innerHTML = "<button onclick=\"miner.start(CoinHive.FORCE_EXCLUSIVE_TAB)\">開始挖礦</button>";
      }
    }, 1000);
  }
  </script>
{% endif %}