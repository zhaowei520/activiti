<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					<form action="commerce/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="COMMERCE_ID" id="COMMERCE_ID" value="${pd.COMMERCE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">签单人:</td>
								<td id="juese">
								<select class="chosen-select form-control" name="SALER" id="SALER" data-placeholder="请选择签单人" style="vertical-align:top;" style="width:98%;" >
								<option value=""></option>
								<c:forEach items="${userList}" var="user">
									<option value="${user.USERNAME }" <c:if test="${user.USERNAME == pd.SALER }">selected</c:if>>${user.USERNAME }</option>
								</c:forEach>
								</select>
								</td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否验资:</td>
								<td id="juese">
								<select class="chosen-select form-control" name="IS_CHECK_MONEY" id="IS_CHECK_MONEY" data-placeholder="请选择是否验资" style="vertical-align:top;" style="width:98%;" >
									<option value=""></option>
									<option value="是" <c:if test="${'是' == pd.IS_CHECK_MONEY }">selected</c:if>>是</option>
									<option value="否" <c:if test="${'否' == pd.IS_CHECK_MONEY }">selected</c:if>>否</option>
								</select>
								</td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">客户（委托人）姓名:</td>
								<td><input type="text" name="CUSTOMER" id="CUSTOMER" value="${pd.CUSTOMER}" maxlength="255" placeholder="这里输入客户（委托人）姓名" title="客户（委托人）姓名" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">委托人联系方式:</td>
								<td><input type="text" name="CUSTOMER_TEL" id="CUSTOMER_TEL" value="${pd.CUSTOMER_TEL}" maxlength="255" placeholder="这里输入委托人联系方式" title="委托人联系方式" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">紧急联系人:</td>
								<td><input type="text" name="EMERGENCY_CONTACT" id="EMERGENCY_CONTACT" value="${pd.EMERGENCY_CONTACT}" maxlength="255" placeholder="这里输入紧急联系人" title="紧急联系人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">紧急联系人联系方式:</td>
								<td><input type="text" name="EMERGENCY_TEL" id="EMERGENCY_TEL" value="${pd.EMERGENCY_TEL}" maxlength="255" placeholder="这里输入紧急联系人联系方式" title="紧急联系人联系方式" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">注册区域:</td>
								<td><input type="text" name="REGISTER_AREA" id="REGISTER_AREA" value="${pd.REGISTER_AREA}" maxlength="255" placeholder="这里输入注册区域" title="注册区域" style="width:98%;"/></td>
							</tr>
						
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">注册地址:</td>
								<td id="juese">
								<select class="chosen-select form-control" name="REGISTER_ADDRESS" id="REGISTER_ADDRESS" data-placeholder="请选择注册地址" style="vertical-align:top;" style="width:98%;" >
									<option value=""></option>
									<option value="客户提供" <c:if test="${'客户提供' == pd.REGISTER_ADDRESS }">selected</c:if>>客户提供</option>
									<option value="成信宏提供" <c:if test="${'成信宏提供' == pd.REGISTER_ADDRESS }">selected</c:if>>成信宏提供</option>
								</select>
								</td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">印章数量:</td>
								<td><input type="number" name="STAMP_COUNT" id="STAMP_COUNT" value="${pd.STAMP_COUNT}" maxlength="32" placeholder="这里输入印章数量" title="印章数量" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">开户银行:</td>
								<td><input type="text" name="INITIAL_BANK" id="INITIAL_BANK" value="${pd.INITIAL_BANK}" maxlength="255" placeholder="这里输入开户银行" title="开户银行" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">合同金额:</td>
								<td><input type="number" name="CONTRACT_MONEY" id="CONTRACT_MONEY" value="${pd.CONTRACT_MONEY}" maxlength="32" placeholder="这里输入合同金额" title="合同金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">预收款:</td>
								<td><input type="number" name="RESERVE_MONEY" id="RESERVE_MONEY" value="${pd.RESERVE_MONEY}" maxlength="32" placeholder="这里输入预收款" title="预收款" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">尾款:</td>
								<td><input type="number" name="TAIL_MONEY" id="TAIL_MONEY" value="${pd.TAIL_MONEY}" maxlength="32" placeholder="这里输入尾款" title="尾款" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">开始日期:</td>
								<td><input class="span10 date-picker" name="BEGIN_DATE" id="BEGIN_DATE" value="${pd.BEGIN_DATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开始日期" title="开始日期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">承诺完成日期:</td>
								<td><input class="span10 date-picker" name="DEADLINE" id="DEADLINE" value="${pd.DEADLINE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="承诺完成日期" title="承诺完成日期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
		
			if($("#SALER").val()==""){
				$("#juese").tips({
					side:3,
		            msg:'请输入签单人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SALER").focus();
			return false;
			}
			if($("#IS_CHECK_MONEY").val()==""){
				$("#IS_CHECK_MONEY").tips({
					side:3,
		            msg:'请输入是否验资',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#IS_CHECK_MONEY").focus();
			return false;
			}
			if($("#CUSTOMER").val()==""){
				$("#CUSTOMER").tips({
					side:3,
		            msg:'请输入客户（委托人）姓名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CUSTOMER").focus();
			return false;
			}
			if($("#CUSTOMER_TEL").val()==""){
				$("#CUSTOMER_TEL").tips({
					side:3,
		            msg:'请输入委托人联系方式',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CUSTOMER_TEL").focus();
			return false;
			}
			if($("#EMERGENCY_CONTACT").val()==""){
				$("#EMERGENCY_CONTACT").tips({
					side:3,
		            msg:'请输入紧急联系人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EMERGENCY_CONTACT").focus();
			return false;
			}
			if($("#EMERGENCY_TEL").val()==""){
				$("#EMERGENCY_TEL").tips({
					side:3,
		            msg:'请输入紧急联系人联系方式',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EMERGENCY_TEL").focus();
			return false;
			}
			if($("#REGISTER_AREA").val()==""){
				$("#REGISTER_AREA").tips({
					side:3,
		            msg:'请输入注册区域',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REGISTER_AREA").focus();
			return false;
			}
			if($("#REGISTER_ADDRESS").val()==""){
				$("#REGISTER_ADDRESS").tips({
					side:3,
		            msg:'请输入注册地址',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REGISTER_ADDRESS").focus();
			return false;
			}
			if($("#STAMP_COUNT").val()==""){
				$("#STAMP_COUNT").tips({
					side:3,
		            msg:'请输入印章数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STAMP_COUNT").focus();
			return false;
			}
			if($("#INITIAL_BANK").val()==""){
				$("#INITIAL_BANK").tips({
					side:3,
		            msg:'请输入开户银行',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INITIAL_BANK").focus();
			return false;
			}
			if($("#CONTRACT_MONEY").val()==""){
				$("#CONTRACT_MONEY").tips({
					side:3,
		            msg:'请输入合同金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTRACT_MONEY").focus();
			return false;
			}
			if($("#RESERVE_MONEY").val()==""){
				$("#RESERVE_MONEY").tips({
					side:3,
		            msg:'请输入预收款',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RESERVE_MONEY").focus();
			return false;
			}
			if($("#TAIL_MONEY").val()==""){
				$("#TAIL_MONEY").tips({
					side:3,
		            msg:'请输入尾款',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TAIL_MONEY").focus();
			return false;
			}
			if($("#BEGIN_DATE").val()==""){
				$("#BEGIN_DATE").tips({
					side:3,
		            msg:'请输入开始日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BEGIN_DATE").focus();
			return false;
			}
			if($("#DEADLINE").val()==""){
				$("#DEADLINE").tips({
					side:3,
		            msg:'请输入承诺完成日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DEADLINE").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			

		});
		</script>
</body>
</html>