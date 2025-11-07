package com.match.event.controller;

import com.match.common.core.utils.poi.ExcelUtil;
import com.match.common.core.web.controller.BaseController;
import com.match.common.core.web.domain.AjaxResult;
import com.match.common.core.web.page.TableDataInfo;
import com.match.common.log.annotation.Log;
import com.match.common.log.enums.BusinessType;
import com.match.event.domain.MarathonEvent;
import com.match.event.domain.Registration;
import com.match.event.service.IEventService;
import com.match.event.service.IRegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 赛事Controller
 *
 * @author bruceXuu
 */
@RestController
@RequestMapping("/event")
public class EventController extends BaseController {
    @Autowired
    private IEventService eventService;
    
    @Autowired
    private IRegistrationService registrationService;

    /**
     * 查询可报名赛事列表 - 面向普通用户
     */
    @GetMapping("/available")
    public TableDataInfo availableEvents() {
        MarathonEvent event = new MarathonEvent();
        event.setStatus("0"); // 只查询状态为"正常"的赛事
        List<MarathonEvent> list = eventService.selectEventList(event);
        return getDataTable(list);
    }
    
    /**
     * 检查用户是否已报名某个赛事
     */
    @GetMapping("/isRegistered")
    public AjaxResult isRegistered(@RequestParam Long userId, @RequestParam Long eventId) {
        Registration registration = registrationService.selectRegistrationByUserIdAndEventId(userId, eventId);
        return AjaxResult.success(registration != null);
    }

    /**
     * 查询赛事列表
     */
    @PreAuthorize("@ss.hasPermi('event:event:list')")
    @GetMapping("/list")
    public TableDataInfo list(MarathonEvent event) {
        startPage();
        List<MarathonEvent> list = eventService.selectEventList(event);
        return getDataTable(list);
    }

    /**
     * 导出赛事列表
     */
    @PreAuthorize("@ss.hasPermi('event:event:export')")
    @Log(title = "赛事", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MarathonEvent event) {
        List<MarathonEvent> list = eventService.selectEventList(event);
        ExcelUtil<MarathonEvent> util = new ExcelUtil<MarathonEvent>(MarathonEvent.class);
        util.exportExcel(response, list, "赛事数据");
    }

    /**
     * 获取赛事详细信息
     */
    @PreAuthorize("@ss.hasPermi('event:event:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(eventService.selectEventById(id));
    }

    /**
     * 新增赛事
     */
    @PreAuthorize("@ss.hasPermi('event:event:add')")
    @Log(title = "赛事", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MarathonEvent event) {
        return toAjax(eventService.insertEvent(event));
    }

    /**
     * 修改赛事
     */
    @PreAuthorize("@ss.hasPermi('event:event:edit')")
    @Log(title = "赛事", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MarathonEvent event) {
        return toAjax(eventService.updateEvent(event));
    }

    /**
     * 删除赛事
     */
    @PreAuthorize("@ss.hasPermi('event:event:remove')")
    @Log(title = "赛事", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(eventService.deleteEventByIds(ids));
    }
}