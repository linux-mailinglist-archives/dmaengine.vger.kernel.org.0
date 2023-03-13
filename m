Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB5F6B7F33
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCMRRi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCMRR3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:17:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3544377CBA;
        Mon, 13 Mar 2023 10:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A21BB6144A;
        Mon, 13 Mar 2023 17:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF0DC4339C;
        Mon, 13 Mar 2023 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727746;
        bh=eA2ZxLGWNR6IdxbFmS127kxHvHFaTkPGETvRqPfSGHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rz+HewYQDWhKf2yVjWlD3Ax9+Bei/7TPg13o2xwZJMK5x/cP9LYG78LNGMJ0j8/Od
         kKprT9xj8VyFk0GbUfCKCeXjqQnkpBzsAVxHRea9/0NxyNiez5/4/VWE0VYmijkZf+
         Rs2jKa7+8pzb3SEeKfl4lzZ0lwJfab0c5PDZE8ZEvLAVn5D17sZm+z0D3s70ggk9BJ
         yUvMLmRQ1DmmAqJxmtDMjRKeJCjICW8tGdLwOChm+OsExmxIDJnRArIDxbHQF4D0E8
         +uPUVPcchyBMj06+r2ukJZLkK7l5fFEGcapnljsHzX9WVOciblQefC38gn/zeNtUgC
         MGPe94fPoWuXg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] dmaengine: dw-axi-dmac: try best to get residue when tx is running
Date:   Tue, 14 Mar 2023 01:04:48 +0800
Message-Id: <20230313170450.897-10-jszhang@kernel.org>
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

