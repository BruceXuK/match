<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="配置key" prop="configKey">
        <el-input
          v-model="queryParams.configKey"
          placeholder="请输入配置key"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="对象存储状态" clearable>
          <el-option
            v-for="dict in dict.type.sys_normal_disable"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:oss:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:oss:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:oss:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="ossConfigList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主建" align="center" prop="ossConfigId" />
      <el-table-column label="配置key" align="center" prop="configKey" />
      <el-table-column label="访问站点" align="center" prop="endpoint" />
      <el-table-column label="自定义域名" align="center" prop="domain" />
      <el-table-column label="accessKey" align="center" prop="accessKey" />
      <el-table-column label="secretKey" align="center" prop="secretKey" />
      <el-table-column label="bucketName" align="center" prop="bucketName" />
      <el-table-column label="是否HTTPS" align="center" prop="isHttps">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_yes_no" :value="scope.row.isHttps"/>
        </template>
      </el-table-column>
      <el-table-column label="域" align="center" prop="region" />
      <el-table-column label="桶权限类型" align="center" prop="accessPolicy" />
      <el-table-column label="是否默认" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:oss:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:oss:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改对象存储配置对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="配置key" prop="configKey">
          <el-input v-model="form.configKey" placeholder="请输入配置key" />
        </el-form-item>
        <el-form-item label="访问站点" prop="endpoint">
          <el-input v-model="form.endpoint" placeholder="请输入访问站点" />
        </el-form-item>
        <el-form-item label="自定义域名" prop="domain">
          <el-input v-model="form.domain" placeholder="请输入自定义域名" />
        </el-form-item>
        <el-form-item label="accessKey" prop="accessKey">
          <el-input v-model="form.accessKey" placeholder="请输入accessKey" />
        </el-form-item>
        <el-form-item label="secretKey" prop="secretKey">
          <el-input v-model="form.secretKey" placeholder="请输入secretKey" />
        </el-form-item>
        <el-form-item label="bucketName" prop="bucketName">
          <el-input v-model="form.bucketName" placeholder="请输入bucketName" />
        </el-form-item>
        <el-form-item label="是否HTTPS" prop="isHttps">
          <el-radio-group v-model="form.isHttps">
            <el-radio
              v-for="dict in dict.type.sys_yes_no"
              :key="dict.value"
              :label="dict.value"
            >{{dict.label}}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="域" prop="region">
          <el-input v-model="form.region" placeholder="请输入域" />
        </el-form-item>
        <el-form-item label="桶权限类型" prop="accessPolicy">
          <el-select v-model="form.accessPolicy" placeholder="请选择桶权限类型">
            <el-option label="private" value="private" />
            <el-option label="public" value="public" />
            <el-option label="custom" value="custom" />
          </el-select>
        </el-form-item>
        <el-form-item label="是否默认" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态">
            <el-option
              v-for="dict in dict.type.sys_normal_disable"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listOssConfig, getOssConfig, delOssConfig, addOssConfig, updateOssConfig, changeOssConfigStatus } from "@/api/system/oss";

export default {
  name: "OssConfig",
  dicts: ['sys_normal_disable', 'sys_yes_no'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 对象存储配置表格数据
      ossConfigList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        configKey: undefined,
        status: undefined
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        configKey: [
          { required: true, message: "配置key不能为空", trigger: "blur" }
        ],
        endpoint: [
          { required: true, message: "访问站点不能为空", trigger: "blur" }
        ],
        accessKey: [
          { required: true, message: "accessKey不能为空", trigger: "blur" }
        ],
        secretKey: [
          { required: true, message: "secretKey不能为空", trigger: "blur" }
        ],
        bucketName: [
          { required: true, message: "bucketName不能为空", trigger: "blur" }
        ],
        isHttps: [
          { required: true, message: "是否HTTPS不能为空", trigger: "blur" }
        ],
        accessPolicy: [
          { required: true, message: "桶权限类型不能为空", trigger: "blur" }
        ],
        status: [
          { required: true, message: "状态不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询对象存储配置列表 */
    getList() {
      this.loading = true;
      listOssConfig(this.queryParams).then(response => {
        this.ossConfigList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.ossConfigId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.open = true;
      this.title = "添加对象存储配置";
      this.form = {
        isHttps: "N",
        accessPolicy: "private",
        status: "1"
      };
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.open = true;
      this.title = "修改对象存储配置";
      const ossConfigId = row.ossConfigId || this.ids[0];
      getOssConfig(ossConfigId).then(response => {
        this.form = response.data;
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.ossConfigId != null) {
            updateOssConfig(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addOssConfig(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ossConfigIds = row.ossConfigId || this.ids;
      this.$modal.confirm('是否确认删除对象存储配置编号为"' + ossConfigIds + '"的数据项？').then(function() {
        return delOssConfig(ossConfigIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        ossConfigId: undefined,
        configKey: undefined,
        endpoint: undefined,
        domain: undefined,
        accessKey: undefined,
        secretKey: undefined,
        bucketName: undefined,
        isHttps: "N",
        region: undefined,
        accessPolicy: "private",
        status: "1",
        remark: undefined
      };
      this.resetForm("form");
    }
  }
};
</script>