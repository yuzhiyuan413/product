$("#send_sms").on("click",function(){
  if($("#verify_mobile").val() == ""){
    // alert("手机号不能为空!");
    appendNotice("手机号不能为空!")
    // $("#notice_msg").html("手机号不能为空!");
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
            // alert("短信发送成功！");
            // $("#notice_msg").html("短信发送成功！");
            appendNotice("短信发送成功!")
            //#notice show
        }else{
           clearInterval(interval);
           $("#send_sms").val("获取验证码").removeClass("disabled")
           // alert(result['msg']);
           // $("#notice_msg").html(result['msg']);
           appendNotice(result['msg'])
           //#notice show
        }
    },
    error: function(e){
        alert("出错!")
    }
  });
})


  // $("#sms_verify").on 'click', ->
  //   $("#new_by_mobile_div").showLoading();
  //   param = $('#sms_register_from').serialize()
  //   url = '/users/sms_verify'
  //   $.ajax
  //     url: url,
  //     async:false,
  //     method: 'post',
  //     dataType: 'json',
  //     data: param,
  //     success: (data) ->
  //       console.info(data)
  //       result = data['SubmitResult']
  //       if result['code'] == '2'
  //         location.href = "/users/invitation/accept?invitation_token="+result['invitation_token']
  //         #$("#verify_invitation_token").val result['invitation_token']
  //       else
  //         showNotice result['msg']
  //       $("#new_by_mobile_div").hideLoading();
  //     error: (msg) ->
  //       $("#new_by_mobile_div").hideLoading();
  //       showNotice "error"

$("#sms_verify").on("click",function(){
  params = $("#registration_form").serialize();

})