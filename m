Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE05977BAD4
	for <lists+dmaengine@lfdr.de>; Mon, 14 Aug 2023 16:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjHNOAc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Aug 2023 10:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjHNOAS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Aug 2023 10:00:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B30110FA;
        Mon, 14 Aug 2023 07:00:05 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPbbN5ZSgzrSKX;
        Mon, 14 Aug 2023 21:58:40 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 21:59:59 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <fenghua.yu@intel.com>, <dave.jiang@intel.com>, <vkoul@kernel.org>,
        <yuehaibing@huawei.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] dmaengine: idxd: Remove unused declarations
Date:   Mon, 14 Aug 2023 21:59:52 +0800
Message-ID: <20230814135952.12892-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit c05257b5600b ("dmanegine: idxd: open code the dsa_drv registration")
removed idxd_{un}register_driver() but not the declarations.
Commit 034b3290ba25 ("dmaengine: idxd: create idxd_device sub-driver")
declared idxd_{un}register_idxd_drv() but never implemented.
Commit 8f47d1a5e545 ("dmaengine: idxd: connect idxd to dmaengine subsystem")
declared idxd_parse_completion_status() but never implemented.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/dma/idxd/idxd.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 5428a2e1b1ec..05a83359def9 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -651,8 +651,6 @@ int idxd_register_bus_type(void);
 void idxd_unregister_bus_type(void);
 int idxd_register_devices(struct idxd_device *idxd);
 void idxd_unregister_devices(struct idxd_device *idxd);
-int idxd_register_driver(void);
-void idxd_unregister_driver(void);
 void idxd_wqs_quiesce(struct idxd_device *idxd);
 bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
 void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
@@ -664,8 +662,6 @@ void idxd_mask_error_interrupts(struct idxd_device *idxd);
 void idxd_unmask_error_interrupts(struct idxd_device *idxd);
 
 /* device control */
-int idxd_register_idxd_drv(void);
-void idxd_unregister_idxd_drv(void);
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
 void idxd_device_drv_remove(struct idxd_dev *idxd_dev);
 int drv_enable_wq(struct idxd_wq *wq);
@@ -710,7 +706,6 @@ int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc);
 /* dmaengine */
 int idxd_register_dma_device(struct idxd_device *idxd);
 void idxd_unregister_dma_device(struct idxd_device *idxd);
-void idxd_parse_completion_status(u8 status, enum dmaengine_tx_result *res);
 void idxd_dma_complete_txd(struct idxd_desc *desc,
 			   enum idxd_complete_type comp_type, bool free_desc);
 
-- 
2.34.1

