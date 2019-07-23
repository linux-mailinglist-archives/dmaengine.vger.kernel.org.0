Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A397F70FFA
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2019 05:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfGWDRh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 23:17:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35201 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfGWDRh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jul 2019 23:17:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so39615478ljh.2;
        Mon, 22 Jul 2019 20:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cAkKhHB6EBChFmLksq6UEkXVUCBYSKkZlbesT/ME1I8=;
        b=b5msMR78OxyCa/3M7ZaXsCcYk5jcj/G7bpgK622q7NhnZXeKi5+ajSLKidg+3ZEA5Z
         /4SzlMIvk84kqVajL2v9571sMpcsJRGREDoNFyhEU+9xiPvJxk5pW5kj/dyfZh58S7lB
         WnHIhiZYMzSVdfvi40fuOR8ECnGBIt12R01kltcFjkNHiplLp0F6XsPk3dAQ5dzsDgXc
         EmNEA0cAUGblzK7hjZAVrdocHl8h18r5poTtXmFOaArRr3c0sntB8KPCyKu3R6c8+Nv4
         kv1d7gHuwh40OKpIfiTrhHiE6Lxxl65TDNkFOajw7x/gG0E2gp05XTzA2ncaKoNoPF4d
         XRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cAkKhHB6EBChFmLksq6UEkXVUCBYSKkZlbesT/ME1I8=;
        b=GWbOXCudjpAWXrAYDLzu8g3xxz/voc0HgZkL5McS9eNU8yPY2SMAlTgS9JBtfLkOV3
         PH7D65OhHI/IIlx3OvfrlPcTGJM7EdH/tfBtl7kO/cq0DZ/XdGWL4KtkYa3INZDBRFBs
         BrRCPkM05tPMKZQx9vI8UgxAiZ1S70lvHg9akpG0F2YNpHg+kog8G8XAMwGskraxCUB4
         Qm7BpJEuSRvikZQvW4oX0h5YDPd3xK8M9RqDZlrfPcWI1wMxGoKLxavm3A3I1mIvUiUO
         DQFYPv7xjolacTTOx+R86koRz6PMZW6JS0/SqPRootCElneb5pq4V/Dnp7IRZLYq60kl
         7ULA==
X-Gm-Message-State: APjAAAW0A67h/MeNvKxyer/znLH3wvhNHGMpKOzTYVlbzWhlMqFCQvxg
        7wqpnak5OALXVYb+BGEcSEI=
X-Google-Smtp-Source: APXvYqxjIjH9ikeMus7wio8OMDL7Z8nL/2yyaocDNjC7JlhcvdD6eLHo1WOei6ytPpAgp1fh5HTRjg==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr38374465lja.230.1563851854307;
        Mon, 22 Jul 2019 20:17:34 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id t23sm7750300ljd.98.2019.07.22.20.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:17:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v5] dmaengine: tegra-apb: Support per-burst residue granularity
Date:   Tue, 23 Jul 2019 06:17:08 +0300
Message-Id: <20190723031708.308-1-digetx@gmail.com>
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

