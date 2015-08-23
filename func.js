function AdHide() {
	var elements = document.all;
	for (var k = 0; k < elements.length; ++k) {
		if (elements[k].style.position == "fixed" &&
			elements[k].style.right == "0px" &&
			elements[k].style.top == "0px") {
			elements[k].style.display = 'none';
			break;
		}
	}
}

function ShowInfo(target,text) {
	obj=document.getElementById(target);
	obj.href="javascript:ShowInfo('"+target+"','"+obj.text+"')";
	obj.innerHTML=text;
}
