$("#send_sms").on("click",function(){
  if($("#verify_mobile").val() == ""){
    appendNotice("手机号不能为空!")
    return;
  }
  $(this).addClass("disabled");
  sum_seconds = 30;
  interval = setInterval(function(){
    sum_seconds -= 1;
    $("#send_sms").val("请等待("+sum_seconds+")").addClass("disabled");
    if(sum_seconds == 0){
      clearInterval(interval);
      $("#send_sms").val("重新获取").removeClass("disabled");
    }
  },1000);
  params = $("#registration_form").serialize();
  $.ajax({
    type: 'post',
    url: '/users/send_sms',
    dataType: 'json',
    data: params,
    success: function(data){
        console.info(data);
        result = data['SubmitResult'];
        if(result['code'] == "2"){
            appendNotice("短信发送成功!")
        }else if(result['code'] == '4086'){
            appendNotice("提交失败，同一个手机号码发送频率太频繁!请稍后再试！")
        }else if(result['code'] == '4085'){
            appendNotice("同一手机号码验证码短信发送量超出5条!")
        }else{
           clearInterval(interval);
           $("#send_sms").val("获取验证码").removeClass("disabled")
           appendNotice(result['msg'])
        }
    },
    error: function(e){
        alert("短信服务商出错!请联系短信平台服务商！")
    }
  });
})

$("#sms_verify").on("click",function(){
  if($("#verify_mobile").val() == ""){
    appendNotice("手机号不能为空!")
    return;
  }
  if($("#verify_sms_verify_number").val() == ""){
    appendNotice("验证码不能为空!")
    return;
  }
  params = $("#registration_form").serialize();
  $("#registration_form").submit();

})