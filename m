Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A21608BD
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 17:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfGEPGW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jul 2019 11:06:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37253 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfGEPGW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 Jul 2019 11:06:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id c9so4791504lfh.4;
        Fri, 05 Jul 2019 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPAr3FWAxOgjhdwsloh7Nxk63Uxm7v4m+2+AK2OrpDk=;
        b=DyuRN6FbFSY/uhiZo9VYzCZoVMuRvjyRqbkt+laU5eu1EdtMmGi7N5Ua6fKF62Fgf1
         plNAxNAdKHzS5jaoWdGG/CrizUUuAqBXW4DDONI7cZMRPihGrqTxl4e4B25F5bwM+Tqo
         7tr/e5LiGwGe3rlNe5GU2tEnOfzJ6/7mYDj2QGNLOgGV6LqGmirfivcU4cNipGczyk51
         ckRWnuk2/r4szWUOwnWlsEym1HbeoNbvWj5AXMGT1w5VllB1m1LRul5orFMdP9CzqZwA
         ct0arRZsIZ8i4T8p8y0sgBOgwgudUGGaXE4bFXoJMJul7jYVaENGK/5nqF/HDu1WcbJ7
         MU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPAr3FWAxOgjhdwsloh7Nxk63Uxm7v4m+2+AK2OrpDk=;
        b=HpQ2yAYQiNEFUYAdzaeAc1TQGUCpG1LiCxHQw2tg42rT+u6yj6M1etAMJoiI3Bhmzq
         WXse5yLn/+MOEGHTpQ+I2Yd0rBM2v/ClZfAsmqpC9Issxu4ee0qUVfMtx6A1rhMGFZ/D
         RCtWlyBenz4LFJ2ZH+xgWzketDXcLsixo33wgS/CX+CSvP1a3HII6/JoSnPrW+O+la/g
         0V7q5/P25gYP8iVriftVOpvQPS8EufFUYspu2/rKsQsNNKGzDTmNDGn8tWKZujlJJEcs
         VEfi7oY0pqWamV81/8ikjlK0gw7KqxX6KnjCTx71zpPs8dndjmRUGP6xYB9qXbuC4r4x
         XGag==
X-Gm-Message-State: APjAAAWKBOK3Ww/u5GLtNiVjIwVtoaOYLI0FKQPWEUgUcFu4ydtbC/FT
        WioaW9ROsYlyOuYe2+0I1us=
X-Google-Smtp-Source: APXvYqzoMlYrAoFSbSNg7rkTklc7MU/Ohzd5k3ISxm71DP90uUoKq0WD5c1Icb5BZUvPMAjtHh4W3w==
X-Received: by 2002:ac2:5382:: with SMTP id g2mr2187082lfh.92.1562339178781;
        Fri, 05 Jul 2019 08:06:18 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id t21sm1405531lfd.85.2019.07.05.08.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 08:06:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] dmaengine: tegra-apb: Support per-burst residue granularity
Date:   Fri,  5 Jul 2019 18:05:19 +0300
Message-Id: <20190705150519.18171-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tegra's APB DMA engine updates words counter after each transferred burst
of data, hence it can report transfer's residual with more fidelity which
may be required in cases like audio playback. In particular this fixes
audio stuttering during playback in a chromium web browser. The patch is
based on the original work that was made by Ben Dooks and a patch from
downstream kernel. It was tested on Tegra20 and Tegra30 devices.

Link: https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
Link: https://nv-tegra.nvidia.com/gitweb/?p=linux-4.4.git;a=commit;h=c7bba40c6846fbf3eaad35c4472dcc7d8bbc02e5
Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v5: Adjusted the code's comment as was suggested by Jon Hunter in the
    review comment to v4.

v4: The words_xferred is now also reset on a new iteration of a cyclic
    transfer by ISR, so that dmaengine_tx_status() won't produce a
    misleading warning splat on TX status re-checking after a cycle
    completion when cyclic transfer consists of a single SG.

v3: Added workaround for a hardware design shortcoming that results
    in a words counter wraparound before end-of-transfer bit is set
    in a cyclic mode.

v2: Addressed review comments made by Jon Hunter to v1. We won't try
    to get words count if dma_desc is on free list as it will result
    in a NULL dereference because this case wasn't handled properly.

    The residual value is now updated properly, avoiding potential
    integer overflow by adding the "bytes" to the "bytes_transferred"
    instead of the subtraction.

 drivers/dma/tegra20-apb-dma.c | 75 +++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 79e9593815f1..3a45079d11ec 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -152,6 +152,7 @@ struct tegra_dma_sg_req {
 	bool				last_sg;
 	struct list_head		node;
 	struct tegra_dma_desc		*dma_desc;
+	unsigned int			words_xferred;
 };
 
 /*
@@ -496,6 +497,7 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,
 	tdc_write(tdc, TEGRA_APBDMA_CHAN_CSR,
 				nsg_req->ch_regs.csr | TEGRA_APBDMA_CSR_ENB);
 	nsg_req->configured = true;
+	nsg_req->words_xferred = 0;
 
 	tegra_dma_resume(tdc);
 }
@@ -511,6 +513,7 @@ static void tdc_start_head_req(struct tegra_dma_channel *tdc)
 					typeof(*sg_req), node);
 	tegra_dma_start(tdc, sg_req);
 	sg_req->configured = true;
+	sg_req->words_xferred = 0;
 	tdc->busy = true;
 }
 
@@ -638,6 +641,8 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
 		list_add_tail(&dma_desc->cb_node, &tdc->cb_desc);
 	dma_desc->cb_count++;
 
+	sgreq->words_xferred = 0;
+
 	/* If not last req then put at end of pending list */
 	if (!list_is_last(&sgreq->node, &tdc->pending_sg_req)) {
 		list_move_tail(&sgreq->node, &tdc->pending_sg_req);
@@ -797,6 +802,65 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 	return 0;
 }
 
+static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_channel *tdc,
+					       struct tegra_dma_sg_req *sg_req)
+{
+	unsigned long status, wcount = 0;
+
+	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
+		return 0;
+
+	if (tdc->tdma->chip_data->support_separate_wcount_reg)
+		wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
+
+	status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
+
+	if (!tdc->tdma->chip_data->support_separate_wcount_reg)
+		wcount = status;
+
+	if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
+		return sg_req->req_len;
+
+	wcount = get_current_xferred_count(tdc, sg_req, wcount);
+
+	if (!wcount) {
+		/*
+		 * If wcount wasn't ever polled for this SG before, then
+		 * simply assume that transfer hasn't started yet.
+		 *
+		 * Otherwise it's the end of the transfer.
+		 *
+		 * The alternative would be to poll the status register
+		 * until EOC bit is set or wcount goes UP. That's so
+		 * because EOC bit is getting set only after the last
+		 * burst's completion and counter is less than the actual
+		 * transfer size by 4 bytes. The counter value wraps around
+		 * in a cyclic mode before EOC is set(!), so we can't easily
+		 * distinguish start of transfer from its end.
+		 */
+		if (sg_req->words_xferred)
+			wcount = sg_req->req_len - 4;
+
+	} else if (wcount < sg_req->words_xferred) {
+		/*
+		 * This case will never happen for a non-cyclic transfer.
+		 *
+		 * For a cyclic transfer, although it is possible for the
+		 * next transfer to have already started (resetting the word
+		 * count), this case should still not happen because we should
+		 * have detected that the EOC bit is set and hence the transfer
+		 * was completed.
+		 */
+		WARN_ON_ONCE(1);
+
+		wcount = sg_req->req_len - 4;
+	} else {
+		sg_req->words_xferred = wcount;
+	}
+
+	return wcount;
+}
+
 static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
@@ -806,6 +870,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	enum dma_status ret;
 	unsigned long flags;
 	unsigned int residual;
+	unsigned int bytes = 0;
 
 	ret = dma_cookie_status(dc, cookie, txstate);
 	if (ret == DMA_COMPLETE)
@@ -825,6 +890,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	list_for_each_entry(sg_req, &tdc->pending_sg_req, node) {
 		dma_desc = sg_req->dma_desc;
 		if (dma_desc->txd.cookie == cookie) {
+			bytes = tegra_dma_sg_bytes_xferred(tdc, sg_req);
 			ret = dma_desc->dma_status;
 			goto found;
 		}
@@ -836,7 +902,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 found:
 	if (dma_desc && txstate) {
 		residual = dma_desc->bytes_requested -
-			   (dma_desc->bytes_transferred %
+			   ((dma_desc->bytes_transferred + bytes) %
 			    dma_desc->bytes_requested);
 		dma_set_residue(txstate, residual);
 	}
@@ -1441,12 +1507,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 		BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
 	tdma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	/*
-	 * XXX The hardware appears to support
-	 * DMA_RESIDUE_GRANULARITY_BURST-level reporting, but it's
-	 * only used by this driver during tegra_dma_terminate_all()
-	 */
-	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	tdma->dma_dev.device_config = tegra_dma_slave_config;
 	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
 	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
-- 
2.22.0

