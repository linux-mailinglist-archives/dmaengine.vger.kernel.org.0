Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC2E2BB48
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 22:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfE0UPN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 16:15:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54117 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfE0UPM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 May 2019 16:15:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id d17so538594wmb.3;
        Mon, 27 May 2019 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BvgB0y69e26fHuK5bMjd373fveSMgBcyqBpevwu2Pk=;
        b=g7yV4C4nR6jQkrnEHUzuhHEu7MT37q6Xug90j9dqaWfqLU72K0V5akejaTtrohvODs
         i1YLTlXtl4ygVsJLKh0Z4AwH0bb6zHXLkizvPOJPKW8vQk/unhEnEAig6uYekUX0ReXd
         itzr1R5v8raKj+pq0kzpcGpLXXpXlhjdDEKi8JYBZyuVVElultbZv1MkMtt4rDqJSOvz
         iFeVHYiYDW+MWgxgBFbJozyT3tN9RRwnxxvdsYwxNhvFYIJOdn9Do9t6hxFD4mmq0k1Y
         QjPbTcPN1HxB3u4mEtdbnzL+lKLTxOWbQWAv5biCxQ1wOzU6k8KAadbfnx8sp9m2pUG8
         XZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BvgB0y69e26fHuK5bMjd373fveSMgBcyqBpevwu2Pk=;
        b=uTIJucwFPfP7kbgBw5wB4/33s60B0p1gPEXXmLsr+MJZIusyN6850VsiKsWYe7jniB
         hPq+WG9hpLU/pFeEm4xlTtvxxjTWx8TbX9KRCvl/4qfx2UjTcZQSlnGouYpEUeGGOowU
         cbuaJu2i8J62uoDMktZmJsKXBLQliV76FTsY42qjauPHg0gSfmgl+X7olLxiP7iaE3nU
         ylTq+ebZonmOLSjUmi3cH82RsOw3cN6teBKBsA+oEjST2p6pcGJULMD0pnpwn0jSV5Ds
         w4xbnp33IeLt2UH6VwVgMjVAQr5gPoD07J9zHnwY8x9tOBQbshmMx5pXFNtMd2QZyLvJ
         kHNg==
X-Gm-Message-State: APjAAAXy0/HWWVL0m/wbqxjp3F9+XWecYoOCih44uOterGRPUc/1UVHm
        3RRNd/z6YpErb+uTSmjNTSk=
X-Google-Smtp-Source: APXvYqwWj1Jne/AvrBhR+KYfQenhvePNq7fRvDkUq38f7DeaAfwNu0S0CcBVsfFDjhwyc8kzHN3/pw==
X-Received: by 2002:a1c:c5cf:: with SMTP id v198mr503790wmf.84.1558988109293;
        Mon, 27 May 2019 13:15:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id i27sm347146wmb.16.2019.05.27.13.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:15:08 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 3/7] dmaengine: sun6i: Add a quirk for setting DRQ fields
Date:   Mon, 27 May 2019 22:14:55 +0200
Message-Id: <20190527201459.20130-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527201459.20130-1-peron.clem@gmail.com>
References: <20190527201459.20130-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 DMA has more than 32 possible DRQs. That means that current maximum
of 31 DRQs is not enough anymore.

Add a quirk which will set source and destination DRQ number.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/dma/sun6i-dma.c | 48 ++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 7d9606997251..f725b93fd21a 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -68,15 +68,15 @@
 #define DMA_CHAN_LLI_ADDR	0x08
 
 #define DMA_CHAN_CUR_CFG	0x0c
-#define DMA_CHAN_MAX_DRQ		0x1f
-#define DMA_CHAN_CFG_SRC_DRQ(x)		((x) & DMA_CHAN_MAX_DRQ)
+#define DMA_CHAN_MAX_DRQ_A31		0x1f
+#define DMA_CHAN_CFG_SRC_DRQ_A31(x)	((x) & DMA_CHAN_MAX_DRQ_A31)
 #define DMA_CHAN_CFG_SRC_IO_MODE	BIT(5)
 #define DMA_CHAN_CFG_SRC_LINEAR_MODE	(0 << 5)
 #define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
 #define DMA_CHAN_CFG_SRC_BURST_H3(x)	(((x) & 0x3) << 6)
 #define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
 
-#define DMA_CHAN_CFG_DST_DRQ(x)		(DMA_CHAN_CFG_SRC_DRQ(x) << 16)
+#define DMA_CHAN_CFG_DST_DRQ_A31(x)	(DMA_CHAN_CFG_SRC_DRQ_A31(x) << 16)
 #define DMA_CHAN_CFG_DST_IO_MODE	(DMA_CHAN_CFG_SRC_IO_MODE << 16)
 #define DMA_CHAN_CFG_DST_LINEAR_MODE	(DMA_CHAN_CFG_SRC_LINEAR_MODE << 16)
 #define DMA_CHAN_CFG_DST_BURST_A31(x)	(DMA_CHAN_CFG_SRC_BURST_A31(x) << 16)
@@ -125,6 +125,7 @@ struct sun6i_dma_config {
 	 */
 	void (*clock_autogate_enable)(struct sun6i_dma_dev *);
 	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
+	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
 	u32 src_burst_lengths;
 	u32 dst_burst_lengths;
 	u32 src_addr_widths;
@@ -311,6 +312,12 @@ static void sun6i_set_burst_length_h3(u32 *p_cfg, s8 src_burst, s8 dst_burst)
 		  DMA_CHAN_CFG_DST_BURST_H3(dst_burst);
 }
 
+static void sun6i_set_drq_a31(u32 *p_cfg, s8 src_drq, s8 dst_drq)
+{
+	*p_cfg |= DMA_CHAN_CFG_SRC_DRQ_A31(src_drq) |
+		  DMA_CHAN_CFG_DST_DRQ_A31(dst_drq);
+}
+
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
 {
 	struct sun6i_desc *txd = pchan->desc;
@@ -634,14 +641,13 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 
 	burst = convert_burst(8);
 	width = convert_buswidth(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	v_lli->cfg = DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
-		DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
-		DMA_CHAN_CFG_DST_LINEAR_MODE |
+	v_lli->cfg = DMA_CHAN_CFG_DST_LINEAR_MODE |
 		DMA_CHAN_CFG_SRC_LINEAR_MODE |
 		DMA_CHAN_CFG_SRC_WIDTH(width) |
 		DMA_CHAN_CFG_DST_WIDTH(width);
 
 	sdev->cfg->set_burst_length(&v_lli->cfg, burst, burst);
+	sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, DRQ_SDRAM);
 
 	sun6i_dma_lli_add(NULL, v_lli, p_lli, txd);
 
@@ -695,9 +701,8 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 			v_lli->dst = sconfig->dst_addr;
 			v_lli->cfg = lli_cfg |
 				DMA_CHAN_CFG_DST_IO_MODE |
-				DMA_CHAN_CFG_SRC_LINEAR_MODE |
-				DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
-				DMA_CHAN_CFG_DST_DRQ(vchan->port);
+				DMA_CHAN_CFG_SRC_LINEAR_MODE;
+			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
 
 			dev_dbg(chan2dev(chan),
 				"%s; chan: %d, dest: %pad, src: %pad, len: %u. flags: 0x%08lx\n",
@@ -710,9 +715,8 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 			v_lli->dst = sg_dma_address(sg);
 			v_lli->cfg = lli_cfg |
 				DMA_CHAN_CFG_DST_LINEAR_MODE |
-				DMA_CHAN_CFG_SRC_IO_MODE |
-				DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
-				DMA_CHAN_CFG_SRC_DRQ(vchan->port);
+				DMA_CHAN_CFG_SRC_IO_MODE;
+			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
 
 			dev_dbg(chan2dev(chan),
 				"%s; chan: %d, dest: %pad, src: %pad, len: %u. flags: 0x%08lx\n",
@@ -780,17 +784,15 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 			v_lli->dst = sconfig->dst_addr;
 			v_lli->cfg = lli_cfg |
 				DMA_CHAN_CFG_DST_IO_MODE |
-				DMA_CHAN_CFG_SRC_LINEAR_MODE |
-				DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
-				DMA_CHAN_CFG_DST_DRQ(vchan->port);
+				DMA_CHAN_CFG_SRC_LINEAR_MODE;
+			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
 		} else {
 			v_lli->src = sconfig->src_addr;
 			v_lli->dst = buf_addr + period_len * i;
 			v_lli->cfg = lli_cfg |
 				DMA_CHAN_CFG_DST_LINEAR_MODE |
-				DMA_CHAN_CFG_SRC_IO_MODE |
-				DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
-				DMA_CHAN_CFG_SRC_DRQ(vchan->port);
+				DMA_CHAN_CFG_SRC_IO_MODE;
+			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
 		}
 
 		prev = sun6i_dma_lli_add(prev, v_lli, p_lli, txd);
@@ -1055,6 +1057,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.nr_max_requests = 30,
 	.nr_max_vchans   = 53,
 	.set_burst_length = sun6i_set_burst_length_a31,
+	.set_drq          = sun6i_set_drq_a31,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1076,6 +1079,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.nr_max_vchans   = 37,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_a23,
 	.set_burst_length = sun6i_set_burst_length_a31,
+	.set_drq          = sun6i_set_drq_a31,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1092,6 +1096,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.nr_max_vchans   = 39,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_a23,
 	.set_burst_length = sun6i_set_burst_length_a31,
+	.set_drq          = sun6i_set_drq_a31,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1115,6 +1120,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.nr_max_vchans   = 34,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_h3,
 	.set_burst_length = sun6i_set_burst_length_h3,
+	.set_drq          = sun6i_set_drq_a31,
 	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1134,6 +1140,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 static struct sun6i_dma_config sun50i_a64_dma_cfg = {
 	.clock_autogate_enable = sun6i_enable_clock_autogate_h3,
 	.set_burst_length = sun6i_set_burst_length_h3,
+	.set_drq          = sun6i_set_drq_a31,
 	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1157,6 +1164,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.nr_max_vchans   = 24,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_a23,
 	.set_burst_length = sun6i_set_burst_length_a31,
+	.set_drq          = sun6i_set_drq_a31,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1272,8 +1280,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(np, "dma-requests", &sdc->max_request);
 	if (ret && !sdc->max_request) {
 		dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
-			 DMA_CHAN_MAX_DRQ);
-		sdc->max_request = DMA_CHAN_MAX_DRQ;
+			 DMA_CHAN_MAX_DRQ_A31);
+		sdc->max_request = DMA_CHAN_MAX_DRQ_A31;
 	}
 
 	/*
-- 
2.20.1

