function ShowEmail() {
    text ="tehnick-8";
    text+="@";
    text+="yandex.ru";
    obj=document.getElementById("email");
    obj.href="mailto:"+text;
    obj.innerHTML=text;
}

function ShowJID() {
    text ="tehnick-8";
    text+="@";
    text+="jabber.ru";
    obj=document.getElementById("jid");
    obj.innerHTML=text;
}

function ShowMatrixID() {
    text ="@";
    text+="tehnick";
    text+=":";
    text+="matrix.org";
    obj=document.getElementById("mxid");
    obj.innerHTML=text;
}

function ShowTelegramID() {
    text ="@";
    text+="tehnick";
    obj=document.getElementById("telegramid");
    obj.innerHTML=text;
}

