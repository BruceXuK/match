<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="赛事名称" prop="eventName">
        <el-input
          v-model="queryParams.eventName"
          placeholder="请输入赛事名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="赛事状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="赛事状态" clearable>
          <el-option
            v-for="dict in dict.type.event_status"
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
          v-hasPermi="['event:event:add']"
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
          v-hasPermi="['event:event:edit']"
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
          v-hasPermi="['event:event:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['event:event:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="eventList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="id" />
      <el-table-column label="赛事名称" align="center" prop="eventName" />
      <el-table-column label="赛事照片" align="center" prop="eventPhoto">
        <template slot-scope="scope">
          <el-image
            v-if="scope.row.eventPhoto"
            :src="getFullImageUrl(scope.row.eventPhoto)"
            :preview-src-list="[getFullImageUrl(scope.row.eventPhoto)]"
            fit="cover"
            style="width: 60px; height: 60px"
          ></el-image>
          <span v-else>暂无图片</span>
        </template>
      </el-table-column>
      <el-table-column label="赛事描述" align="center" prop="eventDescription" />
      <el-table-column label="赛事时间" align="center" prop="eventTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.eventTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="报名开始时间" align="center" prop="registrationStartTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.registrationStartTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="报名截止时间" align="center" prop="registrationEndTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.registrationEndTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="最大参赛人数" align="center" prop="maxParticipants" />
      <el-table-column label="当前参赛人数" align="center" prop="currentParticipants" />
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.event_status" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['event:event:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['event:event:remove']"
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

    <!-- 添加或修改赛事对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="780px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="赛事名称" prop="eventName">
              <el-input v-model="form.eventName" placeholder="请输入赛事名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="最大参赛人数" prop="maxParticipants">
              <el-input-number v-model="form.maxParticipants" controls-position="right" :min="0" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="赛事时间" prop="eventTime">
              <el-date-picker clearable
                v-model="form.eventTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择赛事时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="赛事状态" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio
                  v-for="dict in dict.type.event_status"
                  :key="dict.value"
                  :label="dict.value"
                >{{dict.label}}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="报名开始时间" prop="registrationStartTime">
              <el-date-picker clearable
                v-model="form.registrationStartTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择报名开始时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="报名截止时间" prop="registrationEndTime">
              <el-date-picker clearable
                v-model="form.registrationEndTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择报名截止时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="赛事照片" prop="eventPhoto">
              <image-upload v-model="form.eventPhoto" :limit="1" :fileSize="5" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="赛事描述" prop="eventDescription">
              <el-input v-model="form.eventDescription" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listEvent, getEvent, delEvent, addEvent, updateEvent, exportEvent } from "@/api/event";
import { parseTime } from "@/utils/ruoyi";
import { getToken } from "@/utils/auth";
import ImageUpload from "@/components/ImageUpload";

export default {
  name: "Event",
  dicts: ['event_status'],
  components: {
    ImageUpload
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
      // 赛事表格数据
      eventList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        eventName: null,
        status: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        eventName: [
          { required: true, message: "赛事名称不能为空", trigger: "blur" }
        ],
        eventTime: [
          { required: true, message: "赛事时间不能为空", trigger: "blur" }
        ],
        registrationStartTime: [
          { required: true, message: "报名开始时间不能为空", trigger: "blur" }
        ],
        registrationEndTime: [
          { required: true, message: "报名截止时间不能为空", trigger: "blur" }
        ],
        maxParticipants: [
          { required: true, message: "最大参赛人数不能为空", trigger: "blur" }
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
    /** 查询赛事列表 */
    getList() {
      this.loading = true;
      listEvent(this.queryParams).then(response => {
        this.eventList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 获取完整的图片URL
    getFullImageUrl(url) {
      if (!url) return '';
      // 如果已经是完整URL，直接返回
      if (url.startsWith('http')) {
        return url;
      }
      // 如果是相对路径，拼接完整URL
      const baseUrl = process.env.VUE_APP_BASE_API || '';
      if (url.startsWith('/')) {
        return baseUrl + url;
      } else {
        return baseUrl + '/' + url;
      }
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        eventName: null,
        eventDescription: null,
        eventTime: null,
        registrationStartTime: null,
        registrationEndTime: null,
        maxParticipants: null,
        currentParticipants: 0,
        status: "0",
        eventPhoto: null
      };
      this.resetForm("form");
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
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加赛事";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getEvent(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改赛事";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateEvent(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addEvent(this.form).then(response => {
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
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除赛事编号为"' + ids + '"的数据项？').then(function() {
        return delEvent(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('event/event/export', {
        ...this.queryParams
      }, `event_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>

<style scoped>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>