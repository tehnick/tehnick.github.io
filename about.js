function ShowEMail() {
    text ="tehnick-8";
    text+="@";
    text+="yandex.ru";
    obj=document.getElementById("e-mail");
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
