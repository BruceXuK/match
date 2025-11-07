package com.match.email.controller;

import com.match.common.core.text.Convert;
import com.match.common.core.utils.poi.ExcelUtil;
import com.match.common.core.web.controller.BaseController;
import com.match.common.core.web.domain.AjaxResult;
import com.match.common.core.web.page.TableDataInfo;
import com.match.common.log.annotation.Log;
import com.match.common.log.enums.BusinessType;
import com.match.email.domain.EmailRecord;
import com.match.email.service.IEmailRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 邮件记录Controller
 *
 * @author bruceXuu
 * @date 2022-07-11
 */
@RestController
@RequestMapping("/email/record")
public class EmailRecordController extends BaseController
{
    @Autowired
    private IEmailRecordService emailRecordService;

    /**
     * 查询邮件记录列表
     */
    @PreAuthorize("@ss.hasPermi('email:record:list')")
    @GetMapping("/list")
    public TableDataInfo list(EmailRecord emailRecord)
    {
        startPage();
        List<EmailRecord> list = emailRecordService.selectEmailRecordList(emailRecord);
        return getDataTable(list);
    }

    /**
     * 导出邮件记录列表
     */
    @PreAuthorize("@ss.hasPermi('email:record:export')")
    @Log(title = "邮件记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EmailRecord emailRecord)
    {
        List<EmailRecord> list = emailRecordService.selectEmailRecordList(emailRecord);
        ExcelUtil<EmailRecord> util = new ExcelUtil<EmailRecord>(EmailRecord.class);
        util.exportExcel(response, list, "邮件记录数据");
    }

    /**
     * 获取邮件记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('email:record:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(emailRecordService.selectEmailRecordById(id));
    }

    /**
     * 新增邮件记录
     */
    @PreAuthorize("@ss.hasPermi('email:record:add')")
    @Log(title = "邮件记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EmailRecord emailRecord)
    {
        return toAjax(emailRecordService.insertEmailRecord(emailRecord));
    }

    /**
     * 修改邮件记录
     */
    @PreAuthorize("@ss.hasPermi('email:record:edit')")
    @Log(title = "邮件记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EmailRecord emailRecord)
    {
        return toAjax(emailRecordService.updateEmailRecord(emailRecord));
    }

    /**
     * 删除邮件记录
     */
    @PreAuthorize("@ss.hasPermi('email:record:remove')")
    @Log(title = "邮件记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(emailRecordService.deleteEmailRecordByIds(ids));
    }
}
