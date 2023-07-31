Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACD67692DA
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 12:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjGaKOy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 06:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGaKOx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 06:14:53 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6658E3
        for <dmaengine@vger.kernel.org>; Mon, 31 Jul 2023 03:14:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BC2A1BF20D;
        Mon, 31 Jul 2023 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690798490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIavbQJuk5XuT1JU98DnGK6D45Tl57BY5MxbsyHMO6Y=;
        b=kZfiT2+59PQezD7Br+7it6zEPSFx53fI8cBJwOJfUJgVdI85hKDCvNIIrFqjhW9ShvifWH
        oNpGz45DUgfE4NiI6m2t2cjaabdrK3NL0Ahu0aMa1xT06KIKihhT13sbkf+wJ2OZfrBSPA
        14+rqKcvhoT7UQY3NUNesq78XqbeEYRSO7kNpjiilRCLXxAJYMiyWvhX7xyxBCplwyg8F5
        c1Onh6AG7mbfVRl72Aug8LLQCO5lDaHsN3Tjx1/kJHo09YR2qXlr8eam2TWzXCXjskLf4b
        4qshnrzIw/3tKt8j3z/+Iwm6zbvBVIndomhXn/3BylyOZUaNZaudX2MLmHOsfQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Michal Simek <michal.simek@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 3/4] dmaengine: xilinx: xdma: Prepare the introduction of cyclic transfers
Date:   Mon, 31 Jul 2023 12:14:41 +0200
Message-Id: <20230731101442.792514-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731101442.792514-1-miquel.raynal@bootlin.com>
References: <20230731101442.792514-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In order to reduce and clarify the diff when introducing cyclic
transfers support, let's first prepare the driver a bit. There is no
functional change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/dma/xilinx/xdma.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 5cdb19bd80a7..40983d9355c4 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -137,10 +137,10 @@ static inline void *xdma_blk_last_desc(struct xdma_desc_block *block)
 }
 
 /**
- * xdma_link_desc_blocks - Link descriptor blocks for DMA transfer
+ * xdma_link_sg_desc_blocks - Link SG descriptor blocks for DMA transfer
  * @sw_desc: Tx descriptor pointer
  */
-static void xdma_link_desc_blocks(struct xdma_desc *sw_desc)
+static void xdma_link_sg_desc_blocks(struct xdma_desc *sw_desc)
 {
 	struct xdma_desc_block *block;
 	u32 last_blk_desc, desc_control;
@@ -239,6 +239,7 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num)
 	struct xdma_hw_desc *desc;
 	dma_addr_t dma_addr;
 	u32 dblk_num;
+	u32 control;
 	void *addr;
 	int i, j;
 
@@ -254,6 +255,8 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num)
 	if (!sw_desc->desc_blocks)
 		goto failed;
 
+	control = XDMA_DESC_CONTROL(1, 0);
+
 	sw_desc->dblk_num = dblk_num;
 	for (i = 0; i < sw_desc->dblk_num; i++) {
 		addr = dma_pool_alloc(chan->desc_pool, GFP_NOWAIT, &dma_addr);
@@ -263,10 +266,10 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num)
 		sw_desc->desc_blocks[i].virt_addr = addr;
 		sw_desc->desc_blocks[i].dma_addr = dma_addr;
 		for (j = 0, desc = addr; j < XDMA_DESC_ADJACENT; j++)
-			desc[j].control = cpu_to_le32(XDMA_DESC_CONTROL(1, 0));
+			desc[j].control = cpu_to_le32(control);
 	}
 
-	xdma_link_desc_blocks(sw_desc);
+	xdma_link_sg_desc_blocks(sw_desc);
 
 	return sw_desc;
 
@@ -577,6 +580,12 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
 	return 0;
 }
 
+static enum dma_status xdma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
+				      struct dma_tx_state *state)
+{
+	return dma_cookie_status(chan, cookie, state);
+}
+
 /**
  * xdma_channel_isr - XDMA channel interrupt handler
  * @irq: IRQ number
@@ -925,7 +934,7 @@ static int xdma_probe(struct platform_device *pdev)
 	xdev->dma_dev.dev = &pdev->dev;
 	xdev->dma_dev.device_free_chan_resources = xdma_free_chan_resources;
 	xdev->dma_dev.device_alloc_chan_resources = xdma_alloc_chan_resources;
-	xdev->dma_dev.device_tx_status = dma_cookie_status;
+	xdev->dma_dev.device_tx_status = xdma_tx_status;
 	xdev->dma_dev.device_prep_slave_sg = xdma_prep_device_sg;
 	xdev->dma_dev.device_config = xdma_device_config;
 	xdev->dma_dev.device_issue_pending = xdma_issue_pending;
-- 
2.34.1

