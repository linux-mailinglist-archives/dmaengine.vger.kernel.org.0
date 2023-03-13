Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6D6B7F2C
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCMRRR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjCMRRJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:17:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAF88092F;
        Mon, 13 Mar 2023 10:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6EACB811AF;
        Mon, 13 Mar 2023 17:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81027C433EF;
        Mon, 13 Mar 2023 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727747;
        bh=iP3PWNMb+3tRizoMnR4yxUHqhZ9zp9+fFtQ/nNwpumk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6B1QTM2G4QG7c6I9hwylzYb/x7Ch6gfDExVqIDhHFj0NuC8gZN0M2zyvSymKgzgJ
         /CLWU5n8lN5UGw5EO2P2WLvbSU+zpSmRi+Tq6+o3JIc7L10oZEy8UdMpeJVMxoO9Eg
         YIm2uQR1zaAZOAacvX5cIC1Z6fZfbByoC4bgpRBZkIJc/U30MzQ89EsCQkDMStoLgo
         sPbIegUeD9CCsAyvqwQVYE7zDF2x0tktW2tb9m1WNMmTywTUvcNchn+fM5nKpms/Ie
         96KwQIjDECl+IW60bH8GQKSElYwSs77N09WjjKnZgfGeP6Z7osUFt8Z04WNt0zdS+c
         dgF+0478/dDuw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] dmaengine: dw-axi-dmac: move dma_chan_tx_status()
Date:   Tue, 14 Mar 2023 01:04:49 +0800
Message-Id: <20230313170450.897-11-jszhang@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313170450.897-1-jszhang@kernel.org>
References: <20230313170450.897-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We will add polled support soon, for which we need to call
dw_axi_dma_handle_ch() in dma_chan_tx_status(). Move the function
to avoid pre-declaration.

No functionality changes.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 84 +++++++++----------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 1c1b9574985a..1d00793a83bf 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -300,48 +300,6 @@ static void vchan_desc_put(struct virt_dma_desc *vdesc)
 	axi_desc_put(vd_to_axi_desc(vdesc));
 }
 
-static enum dma_status
-dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
-		  struct dma_tx_state *txstate)
-{
-	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
-	struct axi_dma_desc *desc = NULL;
-	struct virt_dma_desc *vdesc;
-	enum dma_status status;
-	u32 completed_length;
-	unsigned long flags;
-	u32 completed_blocks;
-	size_t bytes = 0;
-	u32 length;
-	u32 len;
-
-	status = dma_cookie_status(dchan, cookie, txstate);
-	if (status == DMA_COMPLETE || !txstate)
-		return status;
-
-	spin_lock_irqsave(&chan->vc.lock, flags);
-
-	vdesc = vchan_find_desc(&chan->vc, cookie);
-	if (vdesc) {
-		desc = vd_to_axi_desc(vdesc);
-	} else if (chan->desc && chan->desc->vd.tx.cookie == cookie) {
-		desc = chan->desc;
-	}
-
-	if (desc) {
-		length = desc->length;
-		completed_blocks = desc->completed_blocks;
-		len = desc->hw_desc[0].len;
-		completed_length = completed_blocks * len;
-		bytes = length - completed_length;
-	}
-
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
-	dma_set_residue(txstate, bytes);
-
-	return status;
-}
-
 static void write_desc_llp(struct axi_dma_hw_desc *desc, dma_addr_t adr)
 {
 	desc->lli->llp = cpu_to_le64(adr);
@@ -1166,6 +1124,48 @@ static irqreturn_t dw_axi_dma_ch_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static enum dma_status
+dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
+		  struct dma_tx_state *txstate)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	struct axi_dma_desc *desc = NULL;
+	struct virt_dma_desc *vdesc;
+	enum dma_status status;
+	u32 completed_length;
+	unsigned long flags;
+	u32 completed_blocks;
+	size_t bytes = 0;
+	u32 length;
+	u32 len;
+
+	status = dma_cookie_status(dchan, cookie, txstate);
+	if (status == DMA_COMPLETE || !txstate)
+		return status;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	vdesc = vchan_find_desc(&chan->vc, cookie);
+	if (vdesc) {
+		desc = vd_to_axi_desc(vdesc);
+	} else if (chan->desc && chan->desc->vd.tx.cookie == cookie) {
+		desc = chan->desc;
+	}
+
+	if (desc) {
+		length = desc->length;
+		completed_blocks = desc->completed_blocks;
+		len = desc->hw_desc[0].len;
+		completed_length = completed_blocks * len;
+		bytes = length - completed_length;
+	}
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	dma_set_residue(txstate, bytes);
+
+	return status;
+}
+
 static int dma_chan_terminate_all(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
-- 
2.39.2

