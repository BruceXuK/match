package com.match.event.controller;

import com.match.common.core.utils.poi.ExcelUtil;
import com.match.common.core.web.controller.BaseController;
import com.match.common.core.web.domain.AjaxResult;
import com.match.common.core.web.page.TableDataInfo;
import com.match.common.log.annotation.Log;
import com.match.common.log.enums.BusinessType;
import com.match.event.domain.Registration;
import com.match.event.service.IRegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 报名记录Controller
 *
 * @author bruceXuu
 */
@RestController
@RequestMapping("/event/registration")
public class RegistrationController extends BaseController {
    @Autowired
    private IRegistrationService registrationService;

    /**
     * 查询报名记录列表
     */
    @PreAuthorize("@ss.hasPermi('event:registration:list')")
    @GetMapping("/list")
    public TableDataInfo list(Registration registration) {
        startPage();
        List<Registration> list = registrationService.selectRegistrationList(registration);
        return getDataTable(list);
    }

    /**
     * 导出报名记录列表
     */
    @PreAuthorize("@ss.hasPermi('event:registration:export')")
    @Log(title = "报名记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Registration registration) {
        List<Registration> list = registrationService.selectRegistrationList(registration);
        ExcelUtil<Registration> util = new ExcelUtil<Registration>(Registration.class);
        util.exportExcel(response, list, "报名记录数据");
    }

    /**
     * 获取报名记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('event:registration:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(registrationService.selectRegistrationById(id));
    }

    /**
     * 新增报名记录
     */
    @PreAuthorize("@ss.hasPermi('event:registration:add')")
    @Log(title = "报名记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Registration registration) {
        return toAjax(registrationService.insertRegistration(registration));
    }

    /**
     * 修改报名记录
     */
    @PreAuthorize("@ss.hasPermi('event:registration:edit')")
    @Log(title = "报名记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Registration registration) {
        return toAjax(registrationService.updateRegistration(registration));
    }

    /**
     * 删除报名记录
     */
    @PreAuthorize("@ss.hasPermi('event:registration:remove')")
    @Log(title = "报名记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(registrationService.deleteRegistrationByIds(ids));
    }
}