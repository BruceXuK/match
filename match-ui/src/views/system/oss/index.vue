<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="文件名" prop="fileName">
        <el-input
          v-model="queryParams.fileName"
          placeholder="请输入文件名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="原名" prop="originalName">
        <el-input
          v-model="queryParams.originalName"
          placeholder="请输入原名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="文件后缀" prop="fileSuffix">
        <el-input
          v-model="queryParams.fileSuffix"
          placeholder="请输入文件后缀"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="创建时间">
        <el-date-picker
          v-model="dateRange"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
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
          icon="el-icon-upload"
          size="mini"
          @click="handleUpload"
          v-hasPermi="['system:oss:upload']"
        >上传文件</el-button>
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

    <el-table v-loading="loading" :data="ossList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="对象存储主键" align="center" prop="ossId" />
      <el-table-column label="文件名" align="center" prop="fileName" />
      <el-table-column label="原名" align="center" prop="originalName" />
      <el-table-column label="文件后缀" align="center" prop="fileSuffix" />
      <el-table-column label="URL地址" align="center" prop="url" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="上传人" align="center" prop="createBy" />
      <el-table-column label="服务商" align="center" prop="service" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handlePreview(scope.row)"
            v-hasPermi="['system:oss:list']"
          >预览</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-download"
            @click="handleDownload(scope.row)"
            v-hasPermi="['system:oss:download']"
          >下载</el-button>
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

    <!-- 添加或修改OSS对象存储对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="文件名" prop="fileName">
          <el-input v-model="form.fileName" placeholder="请输入文件名" />
        </el-form-item>
        <el-form-item label="原名" prop="originalName">
          <el-input v-model="form.originalName" placeholder="请输入原名" />
        </el-form-item>
        <el-form-item label="文件后缀" prop="fileSuffix">
          <el-input v-model="form.fileSuffix" placeholder="请输入文件后缀" />
        </el-form-item>
        <el-form-item label="URL地址" prop="url">
          <el-input v-model="form.url" placeholder="请输入URL地址" />
        </el-form-item>
        <el-form-item label="服务商" prop="service">
          <el-input v-model="form.service" placeholder="请输入服务商" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 文件上传对话框 -->
    <el-dialog :title="upload.title" :visible.sync="upload.open" width="500px" append-to-body @close="handleCloseUpload">
      <file-upload
        ref="fileUpload"
        :file-type="['doc', 'docx', 'xls', 'xlsx', 'pdf', 'jpg', 'jpeg', 'png', 'gif', 'tiff', 'xml', 'html', 'jar']"
        @uploadSuccess="handleUploadSuccess"
        @uploadFinish="handleUploadComplete"
        @fileExists="handleFileExists"
      />
      <div slot="footer" class="dialog-footer">
        <el-button @click="handleCloseUpload">取 消</el-button>
        <el-button type="primary" @click="submitUpload">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listOss, delOss, updateOss } from "@/api/system/oss";
import FileUpload from "@/components/DataCollectionFile/fileUpload.vue";

export default {
  name: "Oss",
  components: {
    FileUpload
  },
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
      // OSS对象存储表格数据
      ossList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 日期范围
      dateRange: [],
      // 默认排序
      defaultSort: {prop: 'createTime', order: 'descending'},
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        fileName: undefined,
        originalName: undefined,
        fileSuffix: undefined
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        fileName: [
          { required: true, message: "文件名不能为空", trigger: "blur" }
        ],
        originalName: [
          { required: true, message: "原名不能为空", trigger: "blur" }
        ],
        fileSuffix: [
          { required: true, message: "文件后缀不能为空", trigger: "blur" }
        ],
        url: [
          { required: true, message: "URL地址不能为空", trigger: "blur" }
        ],
        service: [
          { required: true, message: "服务商不能为空", trigger: "blur" }
        ]
      },
      // 上传参数
      upload: {
        // 是否显示弹出层
        open: false,
        // 弹出层标题
        title: "上传文件",
        // 上传的文件ID
        ossId: undefined
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询OSS对象存储列表 */
    getList() {
      this.loading = true;
      listOss(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.ossList = response.rows;
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
      this.dateRange = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    /** 选择条数  */
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.ossId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 关闭上传对话框
    handleCloseUpload() {
      this.upload.open = false;
      // 重置文件上传组件
      if (this.$refs.fileUpload) {
        this.$refs.fileUpload.reset();
      }
    },
    // 表单重置
    reset() {
      this.form = {
        ossId: undefined,
        fileName: undefined,
        originalName: undefined,
        fileSuffix: undefined,
        url: undefined,
        service: undefined
      };
      this.resetForm("form");
    },
    /** 新增按钮操作 */
    handleUpload() {
      this.upload.open = true;
      this.upload.title = "上传文件";
    },
    /** 下载按钮操作 */
    handleDownload(row) {
      window.open(row.url, "_blank");
    },
    /** 预览按钮操作 */
    handlePreview(row) {
      window.open(row.url, "_blank");
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ossIds = row.ossId || this.ids;
      this.$modal.confirm('是否确认删除OSS对象存储编号为"' + ossIds + '"的数据项？').then(function() {
        return delOss(ossIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const ossId = row.ossId || this.ids[0];
      // 获取详细信息进行编辑
      listOssByIds(ossId).then(response => {
        this.form = response.data[0];
        this.open = true;
        this.title = "修改OSS对象存储";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          updateOss(this.form).then(response => {
            this.$modal.msgSuccess("修改成功");
            this.open = false;
            this.getList();
          });
        }
      });
    },
    // 文件上传成功回调
    handleUploadSuccess(data) {
      console.log("文件上传成功:", data);
      this.upload.ossId = data.ossId;
    },
    // 文件上传完成回调
    handleUploadComplete() {
      // 延迟关闭对话框，确保提示信息有足够时间显示
      setTimeout(() => {
        this.upload.open = false;
        this.getList();
        // 重置文件上传组件
        if (this.$refs.fileUpload) {
          this.$refs.fileUpload.reset();
        }
      }, 1500);
    },
    // 文件已存在回调
    handleFileExists() {
      this.$modal.msgWarning("文件已经上传过了");
    },
    // 提交上传
    submitUpload() {
      if (this.$refs.fileUpload) {
        this.$refs.fileUpload.uploadFile();
      }
    }
  }
};
</script>