Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8EA66A060
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jan 2023 18:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjAMRYP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Jan 2023 12:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjAMRXA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Jan 2023 12:23:00 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A6E0A1837;
        Fri, 13 Jan 2023 09:14:26 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 47D0AE0F21;
        Fri, 13 Jan 2023 20:14:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=vJ6TTWhITpF7HSfUq8zQJlbPEsqjRI1vBa4i6SZVZFQ=; b=GMlqpHbtAA9b
        MpQC4x80zoJCW7gscNZIwioEnDaEx/Oms84C2Xr7gfocPFYU98mf53N2WL/Wm09E
        KKWvlQ6WFVzc6biTdO8wSangegmWUvqztBUysDJJ+lbiZBliL8LOm7537bfyCcIS
        EZh8XsCc1aZxKHxJZo2UWrghzNqhZyM=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 31774E0F13;
        Fri, 13 Jan 2023 20:14:23 +0300 (MSK)
Received: from localhost (10.8.30.26) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 13 Jan 2023 20:14:22 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v9 06/27] dmaengine: dw-edma: Fix invalid interleaved xfers semantics
Date:   Fri, 13 Jan 2023 20:13:48 +0300
Message-ID: <20230113171409.30470-7-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
References: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.26]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The interleaved DMA transfer support added in commit 85e7518f42c8
("dmaengine: dw-edma: Add device_prep_interleave_dma() support") seems
contradicting to what the DMA-engine defines. The next conditional
statements:
	if (!xfer->xfer.il->numf)
		return NULL;
	if (xfer->xfer.il->numf > 0 && xfer->xfer.il->frame_size > 0)
		return NULL;
basically mean that numf can't be zero and frame_size must always be zero,
otherwise the transfer won't be executed. But further the transfer
execution method takes the frames size from the
dma_interleaved_template.sgl[] array for each frame. That array in
accordance with [1] is supposed to be of
dma_interleaved_template.frame_size size, which as we discovered before
the code expects to be zero. So judging by the dw_edma_device_transfer()
implementation the method implies the dma_interleaved_template.sgl[] array
being of dma_interleaved_template.numf size, which is wrong. Since the
dw_edma_device_transfer() method doesn't permit
dma_interleaved_template.frame_size being non-zero then actual multi-chunk
interleaved transfer turns to be unsupported even though the code implies
having it supported.

Let's fix that by adding a fully functioning support of the interleaved
DMA transfers. First of all dma_interleaved_template.frame_size is
supposed to be greater or equal to one thus having at least simple linear
chunked frames. Secondly we can create a walk-through all over the chunks
and frames just by initializing the number of the eDMA burst transactios
as a multiple of dma_interleaved_template.numf and
dma_interleaved_template.frame_size and getting the frame_size-modulo of
the iteration step as an index of the dma_interleaved_template.sgl[]
array. The rest of the dw_edma_device_transfer() method code can be left
unchanged.

[1] include/linux/dmaengine.h: doc struct dma_interleaved_template

Fixes: 85e7518f42c8 ("dmaengine: dw-edma: Add device_prep_interleave_dma() support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 35588e14f79a..d5c4192141ef 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -332,6 +332,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	struct dw_edma_chunk *chunk;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
+	size_t fsz = 0;
 	u32 cnt = 0;
 	int i;
 
@@ -381,9 +382,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		if (xfer->xfer.sg.len < 1)
 			return NULL;
 	} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
-		if (!xfer->xfer.il->numf)
-			return NULL;
-		if (xfer->xfer.il->numf > 0 && xfer->xfer.il->frame_size > 0)
+		if (!xfer->xfer.il->numf || xfer->xfer.il->frame_size < 1)
 			return NULL;
 		if (!xfer->xfer.il->src_inc || !xfer->xfer.il->dst_inc)
 			return NULL;
@@ -413,10 +412,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		cnt = xfer->xfer.sg.len;
 		sg = xfer->xfer.sg.sgl;
 	} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
-		if (xfer->xfer.il->numf > 0)
-			cnt = xfer->xfer.il->numf;
-		else
-			cnt = xfer->xfer.il->frame_size;
+		cnt = xfer->xfer.il->numf * xfer->xfer.il->frame_size;
+		fsz = xfer->xfer.il->frame_size;
 	}
 
 	for (i = 0; i < cnt; i++) {
@@ -438,7 +435,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		else if (xfer->type == EDMA_XFER_SCATTER_GATHER)
 			burst->sz = sg_dma_len(sg);
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
-			burst->sz = xfer->xfer.il->sgl[i].size;
+			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
 		chunk->ll_region.sz += burst->sz;
 		desc->alloc_sz += burst->sz;
@@ -481,10 +478,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
 			sg = sg_next(sg);
-		} else if (xfer->type == EDMA_XFER_INTERLEAVED &&
-			   xfer->xfer.il->frame_size > 0) {
+		} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
 			struct dma_interleaved_template *il = xfer->xfer.il;
-			struct data_chunk *dc = &il->sgl[i];
+			struct data_chunk *dc = &il->sgl[i % fsz];
 
 			src_addr += burst->sz;
 			if (il->src_sgl)
-- 
2.39.0


