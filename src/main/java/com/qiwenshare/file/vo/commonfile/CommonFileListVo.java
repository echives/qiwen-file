package com.qiwenshare.file.vo.commonfile;

import lombok.Data;

@Data
public class CommonFileListVo {

    public Long commonFileId;

    private String fileName;

    private Long userFileId;

    private Long userId;


}
