package com.qiwenshare.file.api;

import com.baomidou.mybatisplus.extension.service.IService;
import com.qiwenshare.file.domain.FileBean;

public interface IFileService  extends IService<FileBean> {

    Long getFilePointCount(String fileId);
    void unzipFile(String userFileId, int unzipMode, String filePath);

    public void updateFileDetail(String userFileId, String identifier, long fileSize, long modifyUserId);



}
