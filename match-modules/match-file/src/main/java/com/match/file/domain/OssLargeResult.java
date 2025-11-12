package com.match.file.domain;

import lombok.Builder;
import lombok.Data;

/**
 * @description: 大文件上传结果对象
 * @author: liuruchen
 * @date: 2024/9/30 15:04
 */
@Data
@Builder
public class OssLargeResult {

    private String uploadId;
    /**
     * 上传状态
     */
    private String uploadStatus;

    private Long ossId;

    private String fileSuffix;

    private Long fileSize;

}
