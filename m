Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D586949FA9
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 13:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfFRLvh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 07:51:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39679 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfFRLvg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jun 2019 07:51:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id p24so9035936lfo.6;
        Tue, 18 Jun 2019 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zpZnTmiFobuKU/2JfAFEVs7n9lSj0UZdJLNtCpW3WX4=;
        b=XwQw3hOve6XBYc4/Iqrypk1r/tdsXiyIvS0Vwvelo++xpDTNelSdaurum8wqVwJ/Jm
         vDT5EvbeOB6aalveng+13exox31Le1W1LG7Dza9D02AcOv4l8WxAmoiKRCZxBBcMbGHd
         BrskdeRuDihLG7AhLcdgZ+lzTfoSAyZr8NlmOwJIpXzsr38nx8g3rBg0aFQbNoyXT6n1
         U3li8ehgmX03aGAWzMzzKhO966tbH5vU/fL4uMd8tjMlb84dmOq6FGDz4fc+IpTVwVz5
         Op4pn/I7TeOSyYYNFoX4LqnxrD61+0Cx2LkXmeU4PAsyH0VlP/gfhuSJjzxKrJRq/81T
         8W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zpZnTmiFobuKU/2JfAFEVs7n9lSj0UZdJLNtCpW3WX4=;
        b=pd7kYU9xIpHzyZPPUDUmz9Yjvp0ygqx5Embwt7v7g8ObqUsIsT6DCfwNsUQrDqprg5
         22hJIe7dvztyUzr4JbXJRohfzRzsAcyS5zT1nOs2mxzhv52TYCsUw/L2t5QnezxktAHu
         zKyL9dXhof/qUUztAHbdk2SIfLzVvDXHLFQl8PNWLHkzz2rYEVVvIykksW0xMifPTQ9i
         0rhGYt2h2GS3qy+CV/7ATI5oNrrmmlSeo6Y7h6ewyFxbjfT7yF9TPnAPZJvRe/DhCf05
         d4a5lzxCw2gKQuQru5jDRtptnbBgWoMS67tTLG6AsLLivywo4KUE+NPDpWAvtxUsJAWY
         ZAbg==
X-Gm-Message-State: APjAAAVr/2T9iLzkTawSwp2WYJpQJd+c/qlz/+rlz15d+XGQWaZ8Qv05
        Ee3Y6bva0FtonCmIrAQGqWvwjk5F
X-Google-Smtp-Source: APXvYqyeEFt5PkWYBttPbqQ2wNvXaY9LOk479JqdCP/UPYEcpOZ6l5XVTEiZN0kdbiOumjmz0kW0cw==
X-Received: by 2002:ac2:482d:: with SMTP id 13mr14528286lft.132.1560858694302;
        Tue, 18 Jun 2019 04:51:34 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id l1sm2172154lfe.60.2019.06.18.04.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 04:51:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dmaengine: tegra-apb: Support per-burst residue granularity
Date:   Tue, 18 Jun 2019 14:50:35 +0300
Message-Id: <20190618115035.29250-1-digetx@gmail.com>
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
audio stuttering during playback in a chromiuim web browser. The patch is
based on the original work that was made by Ben Dooks. It was tested on
Tegra20 and Tegra30 devices.

Link: https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2:  Addressed review comments made by Jon Hunter to v1. We won't try
     to get words count if dma_desc is on free list as it will result
     in a NULL dereference because this case wasn't handled properly.

     The residual value is now updated properly, avoiding potential
     integer overflow by adding the "bytes" to the "bytes_transferred"
     instead of the subtraction.

 drivers/dma/tegra20-apb-dma.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 79e9593815f1..fed18bc46479 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -797,6 +797,28 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
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
+	return get_current_xferred_count(tdc, sg_req, wcount);
+}
+
 static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
@@ -806,6 +828,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	enum dma_status ret;
 	unsigned long flags;
 	unsigned int residual;
+	unsigned int bytes = 0;
 
 	ret = dma_cookie_status(dc, cookie, txstate);
 	if (ret == DMA_COMPLETE)
@@ -825,6 +848,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	list_for_each_entry(sg_req, &tdc->pending_sg_req, node) {
 		dma_desc = sg_req->dma_desc;
 		if (dma_desc->txd.cookie == cookie) {
+			bytes = tegra_dma_sg_bytes_xferred(tdc, sg_req);
 			ret = dma_desc->dma_status;
 			goto found;
 		}
@@ -836,7 +860,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 found:
 	if (dma_desc && txstate) {
 		residual = dma_desc->bytes_requested -
-			   (dma_desc->bytes_transferred %
+			   ((dma_desc->bytes_transferred + bytes) %
 			    dma_desc->bytes_requested);
 		dma_set_residue(txstate, residual);
 	}
@@ -1441,12 +1465,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
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

