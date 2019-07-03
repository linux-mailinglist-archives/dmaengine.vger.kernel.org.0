Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CA25DADB
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jul 2019 03:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfGCBaq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 21:30:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33012 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfGCBaq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Jul 2019 21:30:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so576985ljg.0;
        Tue, 02 Jul 2019 18:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R2h8QxAUqfOZDJkqxT/yDkxaNzMuXvVHpnof0zAlkMg=;
        b=HFbjDS/MeWwTyTs+m+PA4dij9GbLCpeEkloAaseEOjOR7oGWev2VonuJhUxxq5CAtO
         EEolZnUteftJf04GZGqDCZeCyAc4B9O5eGMiVDUkleY2uNYDula+PZ0/dDcZvg/flN0I
         XjUmpBuxU+0tR9Hey87OcFgOO5kLVs60PO1IVVw+j6jbkxZ0akTV9/KRznw7KaNOB9NQ
         Z7wF9w/h/L+T3vhRujC2eSqW/d1S+lLfCxGZUW3xloGn1iIoJLAt2tDbAt8piEXZgh2i
         416U3DNWWQDiutTlS4oXL6P/j5+sfVDLdh9WiMCHReHSAi7mkRsKODyBp0zO5uTCgibp
         B6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R2h8QxAUqfOZDJkqxT/yDkxaNzMuXvVHpnof0zAlkMg=;
        b=YUn0tmruO1UOJ1fLg4aANpCnI2pKwP5Ac0aFdrylZBYDkjAJwEfTWyaCxOr5Y9Vec4
         IxLQwok0dPnt3SdWNCHkUTNhIE6WAN0bGakVFWMUshs4K6n2fZA98/7pINFIyBJ6dSg2
         gjw2LlzAkLZPtRDHxKwSgJgTAbDDxKQ+9Z5LHMNPJcTggBbIOQ914Jb0XC11bvbvWunO
         uy527YwvA09Md4oIcBr41p5jtcVQwraz4S7KzvKRKZvv2Jpwly0dWE8s5SLjw+T5f4ZP
         VN2geeVx+B6KCPk9kIs6jnD1XQEwfVVDGrO+05rkJogxfPHKb++bzVxU6s0+Z6RIyV03
         ZcWA==
X-Gm-Message-State: APjAAAWr7I50cEz6cFxfpLibh/74/HDo/8hPbsvcMQwHSPUKGKO6BBFp
        nHK1EjTiapobNdpE/9Ubo0Q=
X-Google-Smtp-Source: APXvYqwLPp+mnA8st/z58bgGf4ESYKnh0JcUGhR4phDEFuGgVxIjyHnDETX8YhmEzT5PrJa6Sp6gCA==
X-Received: by 2002:a2e:2d12:: with SMTP id t18mr7228516ljt.175.1562117443881;
        Tue, 02 Jul 2019 18:30:43 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id 25sm145206ljv.40.2019.07.02.18.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 18:30:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] dmaengine: tegra-apb: Support per-burst residue granularity
Date:   Wed,  3 Jul 2019 04:28:36 +0300
Message-Id: <20190703012836.16568-1-digetx@gmail.com>
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

 drivers/dma/tegra20-apb-dma.c | 72 +++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 79e9593815f1..148d136191d7 100644
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
@@ -797,6 +802,62 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
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
+		 * This case shall not ever happen because EOC bit
+		 * must be set once next cyclic transfer is started.
+		 * Assume that hardware is malfunctioning or there is
+		 * a software bug.
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
@@ -806,6 +867,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	enum dma_status ret;
 	unsigned long flags;
 	unsigned int residual;
+	unsigned int bytes = 0;
 
 	ret = dma_cookie_status(dc, cookie, txstate);
 	if (ret == DMA_COMPLETE)
@@ -825,6 +887,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	list_for_each_entry(sg_req, &tdc->pending_sg_req, node) {
 		dma_desc = sg_req->dma_desc;
 		if (dma_desc->txd.cookie == cookie) {
+			bytes = tegra_dma_sg_bytes_xferred(tdc, sg_req);
 			ret = dma_desc->dma_status;
 			goto found;
 		}
@@ -836,7 +899,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 found:
 	if (dma_desc && txstate) {
 		residual = dma_desc->bytes_requested -
-			   (dma_desc->bytes_transferred %
+			   ((dma_desc->bytes_transferred + bytes) %
 			    dma_desc->bytes_requested);
 		dma_set_residue(txstate, residual);
 	}
@@ -1441,12 +1504,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
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

