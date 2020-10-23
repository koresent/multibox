// ==UserScript==
// @name            Youtube speed rememberer
// @description     Remembers playback speed
// @author          bljbl
// @license         MIT
// @namespace       http://who.com
// @version         0.33
// @include         http*://*.youtube.com/*
// @include         http*://youtube.com/*
// @include         http*://*.youtu.be/*
// @include         http*://youtu.be/*
// @grant           none
// ==/UserScript==

(function() {
    'use strict';
    const PLAYER_SELECTOR = "#movie_player";
    let store = {
        get rate() {
            return parseFloat(localStorage.getItem("pl-rate")) || 1.0;
        },
        set rate(v) {
            localStorage.setItem("pl-rate", v);
        }
    }

    //  set button on video player
    //  _msg - lable string
    let setLabel = function(_msg, _mp) {
        let label = document.querySelector("#_ytp-label");
        if (_msg === undefined) {
            if (label) label.parentElement.removeChild(label);
            return;
        }
        if (label) {
            label.innerText = _msg;
            return;
        }

        let cls = document.querySelector(PLAYER_SELECTOR).querySelector(".ytp-right-controls");

        let span = document.createElement('span');
        span.setAttribute('id','_ytp-label');
        span.setAttribute('class','ytp-button');
        span.onclick = function() {
            _mp.setPlaybackRate(1);
        };
        span.innerText = _msg;

        cls.insertBefore(span, cls.firstChild);
    };

    //  set or remove button
    let setSpeedLabel = function(rate, mp) {
        setLabel((rate==1)? undefined : 'x'+rate, mp);
    };

    //  modificate player object and store play rate
    //  mp - movieplayer object
    let worker = function(mp) {
        let state = mp.getProgressState();

        if (store.rate != 1.0 && !state.isAtLiveHead) {
            mp.setPlaybackRate(store.rate);
            setSpeedLabel(mp.getPlaybackRate(), mp);
        }

        mp.addEventListener("onPlaybackRateChange", function(){
            store.rate = mp.getPlaybackRate();
            setSpeedLabel(mp.getPlaybackRate(), mp);
        });
    };

    let observer = new MutationObserver(function(mRecord){
        let pl = document.querySelector(PLAYER_SELECTOR);
        if (pl) {
            worker(pl);
            this.disconnect();
        }
    });
    observer.observe(document.body, {attributes: false, childList: true, characterData: false});
})();
