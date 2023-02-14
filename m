Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FEA6955B3
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 02:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBNBDx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Feb 2023 20:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBNBDw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Feb 2023 20:03:52 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878531630D;
        Mon, 13 Feb 2023 17:03:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VbdJ5kt_1676336625;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VbdJ5kt_1676336625)
          by smtp.aliyun-inc.com;
          Tue, 14 Feb 2023 09:03:46 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     vkoul@kernel.org
Cc:     michal.simek@xilinx.com, lizhi.hou@amd.com, brian.xu@amd.com,
        raj.kumar.rampelli@amd.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] dmaengine: xilinx: xdma: Fix some kernel-doc comments
Date:   Tue, 14 Feb 2023 09:03:44 +0800
Message-Id: <20230214010344.5354-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Make the description of @xdma_chan to @xchan to silence the warnings:

drivers/dma/xilinx/xdma.c:283: warning: Function parameter or member 'xchan' not described in 'xdma_xfer_start'
drivers/dma/xilinx/xdma.c:283: warning: Excess function parameter 'xdma_chan' description in 'xdma_xfer_start'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4051
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/dma/xilinx/xdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 462109c61653..93ee298d52b8 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -277,7 +277,7 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num)
 
 /**
  * xdma_xfer_start - Start DMA transfer
- * @xdma_chan: DMA channel pointer
+ * @xchan: DMA channel pointer
  */
 static int xdma_xfer_start(struct xdma_chan *xchan)
 {
-- 
2.20.1.7.g153144c

