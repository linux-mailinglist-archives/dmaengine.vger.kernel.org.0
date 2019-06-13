Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B049C44E1D
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 23:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfFMVJK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 17:09:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39095 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMVJK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Jun 2019 17:09:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so154497ljh.6;
        Thu, 13 Jun 2019 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=895NWKCSLGYKt5EcTpBtHcyCk2/DIWTeD9tNxcMqErQ=;
        b=Ts2Hv+zWx1lzjV2v0HuuD/I1rcFhAxdY02pPJcE03dN1wznH+jzXHgQ76ZPc9/pGCR
         NpDRpdX5mhh/8xo3Ep8yo8jQUry91hAGNecvDdVsfbyOe4AXD8KPe/PsZkqb8s8VXjdU
         aGutHBYWiDYuP5+fRf+XHeg9hNf6oqHLlJe0u54VxnmkE2FEpZLDMUm7k+uWPB4LObkz
         4Knmv0JU7U9DFrCK63DGdyKSnj1h7hyEf/AOWLaW39LCN1UVQOpCpDoeh+C1oe4fOdm9
         52X8M8f/SastbOqtsyX9NIY3W7lzWqHorc6x8UN4MLCsB2Gf6mj/sZVALseXwrHyPy+8
         oEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=895NWKCSLGYKt5EcTpBtHcyCk2/DIWTeD9tNxcMqErQ=;
        b=ijFB0nLTy07DcT0Yx1ukK918pF6SisnWtcDxXfe1gpAiNGseiy6SiY6xjAKTG7qsP7
         NU1AwRQlx7an2Ay5Xcmi1F/3bKRa3essLPWnDiOhykQq1f8mQOKfay78cIJSsfrIzNuF
         UoFh3s+yCHkiSZYEvwLh3vqqczt19PFcgFRkpGCYwB2AIbDuyQ2graNERDYEBA6ZPeeA
         a+zrOBzNuyMsh/5dRUXIEJpv7FlXJWK6DrCa7biuZQypXOt7/xUWQZ1OpbWbPEwPcoKU
         wdFjCc0r2yjrIifAiD28Jos3oMwi7lib+yfFehymkCGV0Sk6592p5N3chSHiu5jxX2sX
         axFw==
X-Gm-Message-State: APjAAAVEjbjrOEQ8HUj6QJyMA2DsOQM61jEI1Z2z1kAppcrbwgfN8MT/
        b3QzUNVUpP5/zrXavZ+mYk6hiSAB
X-Google-Smtp-Source: APXvYqws74y2zldX/c06Uv3zaHV8CGb3sJfcWRFswCPHlwNa7pr4PRgYt/Ut1URmeD6eZJS/xmpJCw==
X-Received: by 2002:a2e:6545:: with SMTP id z66mr49450292ljb.146.1560460147587;
        Thu, 13 Jun 2019 14:09:07 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id k15sm183729lji.89.2019.06.13.14.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 14:09:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue granularity
Date:   Fri, 14 Jun 2019 00:08:49 +0300
Message-Id: <20190613210849.10382-1-digetx@gmail.com>
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
based on the original work that was made by Ben Dooks [1]. It was tested
on Tegra20 and Tegra30 devices.

[1] https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/

Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 79e9593815f1..c5af8f703548 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 	return 0;
 }
 
+static unsigned int tegra_dma_update_residual(struct tegra_dma_channel *tdc,
+					      struct tegra_dma_sg_req *sg_req,
+					      struct tegra_dma_desc *dma_desc,
+					      unsigned int residual)
+{
+	unsigned long status, wcount = 0;
+
+	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
+		return residual;
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
+		return residual - sg_req->req_len;
+
+	return residual - get_current_xferred_count(tdc, sg_req, wcount);
+}
+
 static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	struct tegra_dma_sg_req *sg_req = NULL;
 	struct tegra_dma_desc *dma_desc;
-	struct tegra_dma_sg_req *sg_req;
 	enum dma_status ret;
 	unsigned long flags;
 	unsigned int residual;
@@ -838,6 +862,8 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 		residual = dma_desc->bytes_requested -
 			   (dma_desc->bytes_transferred %
 			    dma_desc->bytes_requested);
+		residual = tegra_dma_update_residual(tdc, sg_req, dma_desc,
+						     residual);
 		dma_set_residue(txstate, residual);
 	}
 
@@ -1441,12 +1467,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
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

