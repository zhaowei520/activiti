package com.fh.controller.process.commerce;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.activiti.AcStartController;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.Tools;
import com.fh.service.process.commerce.CommerceManager;
import com.fh.service.system.user.UserManager;

/** 
 * 说明：工商办理
 * 创建人：FH Q313596790
 * 创建时间：2018-06-06
 */
@Controller
@RequestMapping(value="/commerce")
public class CommerceController extends AcStartController {
	
	String menuUrl = "commerce/list.do"; //菜单地址(权限用)
	@Resource(name="commerceService")
	private CommerceManager commerceService;
	@Resource(name="userService")
	private UserManager userService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Commerce");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COMMERCE_ID", this.get32UUID());	//主键
		pd.put("C_DATE", Tools.date2Str(new Date()));	//创建日期
		pd.put("C_USER", Jurisdiction.getUsername());	//创建人
		pd.put("M_DATE", Tools.date2Str(new Date()));	//修改日期
		pd.put("M_USER", Jurisdiction.getUsername());	//修改人
//		commerceService.save(pd);
		
		try {
			/** 工作流的操作 **/
			Map<String,Object> map = new LinkedHashMap<String, Object>();

			map.put("签单人", pd.getString("SALER"));
			map.put("客户（委托人）姓名", pd.getString("CUSTOMER"));
			map.put("委托人联系方式", pd.getString("CUSTOMER_TEL"));
			map.put("紧急联系人", pd.getString("EMERGENCY_CONTACT"));
			map.put("紧急联系人联系方式", pd.getString("EMERGENCY_TEL"));
			map.put("注册区域", pd.getString("REGISTER_AREA"));
			map.put("注册地址", pd.getString("REGISTER_ADDRESS"));
			map.put("印章数量", pd.getString("STAMP_COUNT"));
			map.put("开户银行", pd.getString("INITIAL_BANK"));
			map.put("是否验资", pd.getString("IS_CHECK_MONEY"));
			map.put("合同金额", pd.getString("CONTRACT_MONEY"));
			map.put("预收款", pd.getString("RESERVE_MONEY"));
			map.put("尾款", pd.getString("TAIL_MONEY"));
			map.put("开始日期", pd.getString("BEGIN_DATE"));
			map.put("承诺完成日期", pd.getString("DEADLINE"));
			map.put("USERNAME", Jurisdiction.getUsername());		//指派代理人为当前用户
//			myleaveService.save(pd);
			commerceService.save(pd);//记录存入数据库
			startProcessInstanceByKeyHasVariables("KEY_bus",map);
			mv.addObject("ASSIGNEE_",Jurisdiction.getUsername());	//用于给待办人发送新任务消息
		} catch (Exception e) {
			mv.addObject("errer","errer");
			mv.addObject("msgContent","请联系管理员部署相应业务流程!");
		}
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Commerce");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		commerceService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Commerce");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		commerceService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Commerce");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = commerceService.list(page);	//列出Commerce列表
		mv.setViewName("process/commerce/commerce_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("process/commerce/commerce_edit");
		List<PageData>	userList = userService.listAllUser(pd);	//列出用户列表
		mv.addObject("userList", userList);
		mv.addObject("msg", "save");
		pd.put("SALER", Jurisdiction.getUsername());
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = commerceService.findById(pd);	//根据ID读取
		mv.setViewName("process/commerce/commerce_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Commerce");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			commerceService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Commerce到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("签单人");	//1
		titles.add("是否验资");	//2
		titles.add("创建日期");	//3
		titles.add("客户（委托人）姓名");	//4
		titles.add("委托人联系方式");	//5
		titles.add("紧急联系人");	//6
		titles.add("紧急联系人联系方式");	//7
		titles.add("注册区域");	//8
		titles.add("注册地址");	//9
		titles.add("印章数量");	//10
		titles.add("开户银行");	//11
		titles.add("合同金额");	//12
		titles.add("预收款");	//13
		titles.add("尾款");	//14
		titles.add("开始日期");	//15
		titles.add("承诺完成日期");	//16
		titles.add("创建人");	//17
		titles.add("修改日期");	//18
		titles.add("修改人");	//19
		dataMap.put("titles", titles);
		List<PageData> varOList = commerceService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("SALER"));	    //1
			vpd.put("var2", varOList.get(i).getString("IS_CHECK_MONEY"));	    //2
			vpd.put("var3", varOList.get(i).getString("C_DATE"));	    //3
			vpd.put("var4", varOList.get(i).getString("CUSTOMER"));	    //4
			vpd.put("var5", varOList.get(i).getString("CUSTOMER_TEL"));	    //5
			vpd.put("var6", varOList.get(i).getString("EMERGENCY_CONTACT"));	    //6
			vpd.put("var7", varOList.get(i).getString("EMERGENCY_TEL"));	    //7
			vpd.put("var8", varOList.get(i).getString("REGISTER_AREA"));	    //8
			vpd.put("var9", varOList.get(i).getString("REGISTER_ADDRESS"));	    //9
			vpd.put("var10", varOList.get(i).get("STAMP_COUNT").toString());	//10
			vpd.put("var11", varOList.get(i).getString("INITIAL_BANK"));	    //11
			vpd.put("var12", varOList.get(i).get("CONTRACT_MONEY").toString());	//12
			vpd.put("var13", varOList.get(i).get("RESERVE_MONEY").toString());	//13
			vpd.put("var14", varOList.get(i).get("TAIL_MONEY").toString());	//14
			vpd.put("var15", varOList.get(i).getString("BEGIN_DATE"));	    //15
			vpd.put("var16", varOList.get(i).getString("DEADLINE"));	    //16
			vpd.put("var17", varOList.get(i).getString("C_USER"));	    //17
			vpd.put("var18", varOList.get(i).getString("M_DATE"));	    //18
			vpd.put("var19", varOList.get(i).getString("M_USER"));	    //19
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
