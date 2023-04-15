Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231896E30F2
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjDOKuG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjDOKtw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:49:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3894EF4;
        Sat, 15 Apr 2023 03:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABDE5617E4;
        Sat, 15 Apr 2023 10:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA17C433D2;
        Sat, 15 Apr 2023 10:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681555629;
        bh=eA2ZxLGWNR6IdxbFmS127kxHvHFaTkPGETvRqPfSGHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZm1bHl7XW9SxEIIxUAftIHPOTtnfokBHFkTXliyMMm0VDJq0rS4/lb9Rsl65rgQv
         w/kF0nIlnI2ayXKT6YTcwti6KXBoP6YpssS7xQXh4K4ezaQ9FWfRbeFqVRSVGFm1c2
         i7PCsG4PiOii528r5pJfKaPemJRou+sHlcWhstzi8FEcBJbpjflb5NHBEYTTSMKgTp
         fUqsA82F/Q1KGdXYQstbf0DUXyim6zw8KbETAK8p5QAl5WmqWFpB1NbjyWJ9w/oOHL
         IXCBMOzDrTx/XypzjjKxQ/2Uyb5tEZdow9cTx8cYeFA0kiX0CgCP8Z92G5ezcjC/LF
         RV8LGYwuN8n8Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] dmaengine: dw-axi-dmac: try best to get residue when tx is running
Date:   Sat, 15 Apr 2023 18:35:59 +0800
Message-Id: <20230415103601.2979-10-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415103601.2979-1-jszhang@kernel.org>
References: <20230415103601.2979-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When tx is running, vchan_find_desc() will return NULL, try our best
to get the residue in this case.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a6e46cb66000..1c1b9574985a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -305,6 +305,7 @@ dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 		  struct dma_tx_state *txstate)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	struct axi_dma_desc *desc = NULL;
 	struct virt_dma_desc *vdesc;
 	enum dma_status status;
 	u32 completed_length;
@@ -322,9 +323,15 @@ dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 
 	vdesc = vchan_find_desc(&chan->vc, cookie);
 	if (vdesc) {
-		length = vd_to_axi_desc(vdesc)->length;
-		completed_blocks = vd_to_axi_desc(vdesc)->completed_blocks;
-		len = vd_to_axi_desc(vdesc)->hw_desc[0].len;
+		desc = vd_to_axi_desc(vdesc);
+	} else if (chan->desc && chan->desc->vd.tx.cookie == cookie) {
+		desc = chan->desc;
+	}
+
+	if (desc) {
+		length = desc->length;
+		completed_blocks = desc->completed_blocks;
+		len = desc->hw_desc[0].len;
 		completed_length = completed_blocks * len;
 		bytes = length - completed_length;
 	}
@@ -425,6 +432,7 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 	axi_chan_irq_set(chan, irq_mask);
 
 	axi_chan_enable(chan);
+	chan->desc = first;
 }
 
 static void axi_chan_start_first_queued(struct axi_dma_chan *chan)
@@ -1188,6 +1196,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	vchan_dma_desc_free_list(&chan->vc, &head);
+	chan->desc = NULL;
 
 	dev_vdbg(dchan2dev(dchan), "terminated: %s\n", axi_chan_name(chan));
 
-- 
2.39.2

