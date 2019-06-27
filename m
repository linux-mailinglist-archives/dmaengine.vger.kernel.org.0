Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5083658B19
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2019 21:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfF0Tto (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Jun 2019 15:49:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37777 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfF0Ttn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Jun 2019 15:49:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id y57so3832161qtk.4;
        Thu, 27 Jun 2019 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MenPiCw1B2pHCHuETRVoHlHg8uoJRec68bX3QIhKK+0=;
        b=b2tZYxcOSVDOSlx9s9Y0fD5ZZq5G7Sx+TNB/9r7SSwO0TQ0t/E7iQjuw3D8GIbciOx
         Phckim+CZ+rZUEZj7olsxP6BHD1NMuLhLdfVjq/a8fWVQhVu2tyNN7QAKYy1pvLrDhLp
         F8Dr8cD8CQvU5UqHz1WStBvvx4pPwPWiO7+LlNnrkFMl/4VSw17mvIoqdwUoNMk5xOJU
         RQAc500HLM9D6jpX2EsiGV/iEOnyAaUw4S8WvlhHD73f0ivCFmjin2D3u72fKozikZbV
         PHVnzAGoSoPIO31CQBLkhgYqIBUz/LGznxdHhpsplrnVjqE+4uaVfwRR3Wd6Ux4AqF2S
         FzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MenPiCw1B2pHCHuETRVoHlHg8uoJRec68bX3QIhKK+0=;
        b=cEpDlpIuFtLAxTBANpyEjjL/h+atVhiUAaxzgpqL1JfZzmSaahCcdsIoKKV685FMgK
         riESmPw2szPpT1nuJSNWMFUeqlh+uK6MOBp9Mq6tCxHrTzEgG51H8Rs26AZZzObR3vXA
         WrNaRwrz9xrQiapt7pRSgSK9k5u2YOtId3vAOIPVDr6txU6E13O3IeU+4xKKP9cWQGBw
         3luoVZAqa5b2fHNwr/RW5T67eNrKiHyysvLHPe72c2TfGCTlunZHiJToYV5nSJkyejF2
         vCI74xkn2GarH1z5AK1w2PdmKXORSeM3uo2DlnSEN3FFukKcXsBP8BktRn4As3DpP04g
         R1PQ==
X-Gm-Message-State: APjAAAVZ+7Svaq4quzcojP6pguv0Va9TGoVbTJTnqlpEwYgCcm0Lj1CZ
        hac+a/kqufDtq6E/xoaIRsM=
X-Google-Smtp-Source: APXvYqzoaYDifvYkRLn3drVCGVXffLrEFo0MNdR3u9o8JcopLUZzCYdZSGJ3h+zSAqEg7E9jfkOKwg==
X-Received: by 2002:a0c:b998:: with SMTP id v24mr4881682qvf.132.1561664982305;
        Thu, 27 Jun 2019 12:49:42 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id k55sm37681qtf.68.2019.06.27.12.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 12:49:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dmaengine: tegra-apb: Support per-burst residue granularity
Date:   Thu, 27 Jun 2019 22:47:28 +0300
Message-Id: <20190627194728.8948-1-digetx@gmail.com>
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
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v3:  Added workaround for a hardware design shortcoming that results
     in a words counter wraparound before end-of-transfer bit is set
     in a cyclic mode.

v2:  Addressed review comments made by Jon Hunter to v1. We won't try
     to get words count if dma_desc is on free list as it will result
     in a NULL dereference because this case wasn't handled properly.

     The residual value is now updated properly, avoiding potential
     integer overflow by adding the "bytes" to the "bytes_transferred"
     instead of the subtraction.

 drivers/dma/tegra20-apb-dma.c | 69 +++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 79e9593815f1..71473eda28ee 100644
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
 
@@ -797,6 +800,61 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
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
+		wcount = sg_req->req_len - 4;
+		WARN_ON_ONCE(1);
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
@@ -806,6 +864,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	enum dma_status ret;
 	unsigned long flags;
 	unsigned int residual;
+	unsigned int bytes = 0;
 
 	ret = dma_cookie_status(dc, cookie, txstate);
 	if (ret == DMA_COMPLETE)
@@ -825,6 +884,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	list_for_each_entry(sg_req, &tdc->pending_sg_req, node) {
 		dma_desc = sg_req->dma_desc;
 		if (dma_desc->txd.cookie == cookie) {
+			bytes = tegra_dma_sg_bytes_xferred(tdc, sg_req);
 			ret = dma_desc->dma_status;
 			goto found;
 		}
@@ -836,7 +896,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 found:
 	if (dma_desc && txstate) {
 		residual = dma_desc->bytes_requested -
-			   (dma_desc->bytes_transferred %
+			   ((dma_desc->bytes_transferred + bytes) %
 			    dma_desc->bytes_requested);
 		dma_set_residue(txstate, residual);
 	}
@@ -1441,12 +1501,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
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

