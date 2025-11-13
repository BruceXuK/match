package com.match.file.controller;

import com.match.common.core.domain.R;
import com.match.common.core.web.controller.BaseController;
import com.match.common.core.web.domain.AjaxResult;
import com.match.common.core.web.page.TableDataInfo;
import com.match.common.log.annotation.Log;
import com.match.common.log.enums.BusinessType;
import com.match.common.security.annotation.RequiresPermissions;
import com.match.file.domain.SysOssConfig;
import com.match.file.service.ISysOssConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Arrays;
import java.util.List;

/**
 * 对象存储配置
 *
 * @author Lion Li
 * @author 孤舟烟雨
 * @date 2021-08-13
 */
@RestController
@RequestMapping("/file/oss/config")
public class SysOssConfigController extends BaseController {

    @Autowired
    private ISysOssConfigService iSysOssConfigService;

    /**
     * 查询对象存储配置列表
     */
    @RequiresPermissions("system:oss:list")
    @GetMapping("/list")
    public TableDataInfo list(SysOssConfig bo) {
        startPage();
        List<SysOssConfig> list = iSysOssConfigService.queryPageList(bo);
        return getDataTable(list);
    }

    /**
     * 获取对象存储配置详细信息
     *
     * @param ossConfigId OSS配置ID
     */
    @RequiresPermissions("system:oss:query")
    @GetMapping("/{ossConfigId}")
    public R<SysOssConfig> getInfo(@NotNull(message = "主键不能为空")
                                     @PathVariable Long ossConfigId) {
        return R.ok(iSysOssConfigService.queryById(ossConfigId));
    }

    /**
     * 新增对象存储配置
     */
    @RequiresPermissions("system:oss:add")
    @Log(title = "对象存储配置", businessType = BusinessType.INSERT)
    @PostMapping()
    public AjaxResult add(@RequestBody SysOssConfig bo) {
        return toAjax(iSysOssConfigService.insertByBo(bo));
    }

    /**
     * 修改对象存储配置
     */
    @RequiresPermissions("system:oss:edit")
    @Log(title = "对象存储配置", businessType = BusinessType.UPDATE)
    @PutMapping()
    public AjaxResult edit(@RequestBody SysOssConfig bo) {
        return toAjax(iSysOssConfigService.updateByBo(bo));
    }

    /**
     * 删除对象存储配置
     *
     * @param ossConfigIds OSS配置ID串
     */
    @RequiresPermissions("system:oss:remove")
    @Log(title = "对象存储配置", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ossConfigIds}")
    public AjaxResult remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ossConfigIds) {
        return toAjax(iSysOssConfigService.deleteWithValidByIds(Arrays.asList(ossConfigIds), true));
    }

    /**
     * 状态修改
     */
    @RequiresPermissions("system:oss:edit")
    @Log(title = "对象存储状态修改", businessType = BusinessType.UPDATE)
    @PutMapping("/changeStatus")
    public AjaxResult changeStatus(@RequestBody SysOssConfig bo) {
        return toAjax(iSysOssConfigService.updateOssConfigStatus(bo));
    }
}
