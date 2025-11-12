package com.match.file.event;


import lombok.Data;

import java.io.Serializable;

/*
多文件上传完成监听事件
 */
@Data
public class MultiFileUploadEvent implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long ossId;
}
