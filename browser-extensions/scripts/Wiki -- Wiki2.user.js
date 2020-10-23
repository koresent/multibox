// ==UserScript==
// @name         Wiki -> Wiki2
// @namespace    //
// @version      1.0
// @description  Auto redirection
// @author       Koresent
// @include      https://ru.wikipedia.org/*
// @include      https://en.wikipedia.org/*
// @run-at document-start
// ==/UserScript==

if (window.location.hostname == "ru.wikipedia.org") {
    window.location.href = "https://wiki2.org/ru" + window.location.pathname.replace('/wiki', '');
}
if (window.location.hostname == "en.wikipedia.org") {
    window.location.href = "https://wiki2.org/en" + window.location.pathname.replace('/wiki', '');
}