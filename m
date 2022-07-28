Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7885841AF
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 16:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiG1OgP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 10:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiG1OfP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 10:35:15 -0400
Received: from mail.baikalelectronics.com (unknown [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3399148C89
        for <dmaengine@vger.kernel.org>; Thu, 28 Jul 2022 07:34:35 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 00EF016DD;
        Thu, 28 Jul 2022 17:31:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 00EF016DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1659018675;
        bh=17/2wYbrQgogQ/AnOlqJwuN0f3HJbuhq/LuIABB8iF0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=VsKu/S/qUkCE2R7a/4gvA2tGHNl4TrlIj4VyM/16rSqPT2BzWMQ+C0IIYlhhDl7QA
         JpfRH8D6kR36wQBZPa6KUU5qZ9UAsCZOOrzu2LBTYBgbw+akfEWMvSOubGjc5NHxhE
         o/uwP+In761ki1XZp+aPg/kmfjI/xa4wBIRsi4uI=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Jul 2022 17:28:49 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v4 06/24] dmaengine: dw-edma: Fix invalid interleaved xfers semantics
Date:   Thu, 28 Jul 2022 17:28:23 +0300
Message-ID: <20220728142841.12305-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
References: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Acked-By: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 225eab58acb7..ef49deb5a7f3 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -333,6 +333,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	struct dw_edma_chunk *chunk;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
+	size_t fsz = 0;
 	u32 cnt = 0;
 	int i;
 
@@ -382,9 +383,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
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
@@ -414,10 +413,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
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
@@ -439,7 +436,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		else if (xfer->type == EDMA_XFER_SCATTER_GATHER)
 			burst->sz = sg_dma_len(sg);
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
-			burst->sz = xfer->xfer.il->sgl[i].size;
+			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
 		chunk->ll_region.sz += burst->sz;
 		desc->alloc_sz += burst->sz;
@@ -482,10 +479,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 
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
2.35.1

