
//需要注入的js方法
//输入框值改变
function inputDidInput(input) {
    //向原生发送消息, 并传递
    window.webkit.messageHandlers.JSBridge.postMessage({id:"searchKey",value:input.target.value});
}

//点击搜索按钮
function clickBtn(btn) {
    //向原生发送消息, 并传递
    var input = document.getElementById("searchKey");
    //输入框的值
    var searchKey = input.value
    window.webkit.messageHandlers.JSBridge.postMessage({id:"sumit",value:searchKey});
}
function demoFun() {
    //获取输入框
    var input_keyword = document.getElementById("searchKey");
    //添加输入事件
    input_keyword.addEventListener('input',inputDidInput)
    //输入框的值
    input_keyword.value = "Placeholder_searchKey"

    //获取button
    var button = document.getElementById("sumit");
    button.addEventListener('click', clickBtn);
  
}
//注入成功后先调用执行
demoFun();

