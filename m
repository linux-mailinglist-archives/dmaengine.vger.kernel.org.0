Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F352A581
	for <lists+dmaengine@lfdr.de>; Sat, 25 May 2019 18:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfEYQiv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 May 2019 12:38:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35040 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfEYQid (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 May 2019 12:38:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so12833869wrv.2;
        Sat, 25 May 2019 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H03wKTI6oMmWjRMAo+KT8s6YBguBSsFMM/5UIe8GNQk=;
        b=Iddrw4kWou21k/kiAmXABQ84cser+X5MUpZAa9hVL91V9F615spMPNd2RQsulxU9Lk
         aIsy7ssyPs2REq7+/lkqC5OWSzaAWgYGIRtWwnkEuueh6ugMCk9RjzluRZNYdp91qY5L
         lMmCbPCXooM2KGphQxGnbJros4Of31LdliwtPAGBuVK/yCpMEPjSQHqneHJa9qCkwyqT
         39IbYsx8C1/weS7Ge8gN1kxWPJyNyvkn5g+gDAtKZ6CsL6lEsDyrGCC6T11c7IKN1EHl
         qpZPmtFGcGbsPHDM1w1nVfDlXHT4rDNX/tCM4az/J0lYCSmRL4caqdhAMql5Jp6rGd+A
         OkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H03wKTI6oMmWjRMAo+KT8s6YBguBSsFMM/5UIe8GNQk=;
        b=qYIYmEDgPNjz0Uc97vPcdSBulRfuN/F832x9sfJhLHoEOrUTgbOguIIg0P9i7VHc1N
         wB3jrvNvdpUljG+V4UR7BggTwZrZMGBrplzJ2+6idFTa062yKc8ZUuVKO7YmRkqlpMRg
         2wnYbXKJMJ81o67Kfd/QKMgnqVqi4WUkg6vrtyWOOMbAa0J7xvJ715Zl9Y9tNZLNtnbk
         FiIEC0hSboo8hN+Ka90Tv0Eh14iROIlbAg341KsYNHCRn74YwF/v41sM6AEUoLoDFGDO
         1gM8DcuA9Obw33Gq5hkaUYn5nmOSRpLrC0b68aeu+17YgPiTFve1sSr+jbt11F3vLKkU
         GF+g==
X-Gm-Message-State: APjAAAVuIyg7W9I3bk3LfbrZE9445e9g8BqmxSJxbgSVoykCO+z48ZsO
        1IEIe09ige+J6R7hrA+8Jjs=
X-Google-Smtp-Source: APXvYqw5sFDjRtDp0iNaPs2KQNMhDcL2yGJeY6KQpk7jesSctB6oJfyHxfP2zRbHceh6y467XZDpRg==
X-Received: by 2002:adf:f6ce:: with SMTP id y14mr12786156wrp.113.1558802310197;
        Sat, 25 May 2019 09:38:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id f65sm9306498wmg.45.2019.05.25.09.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 09:38:29 -0700 (PDT)
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
Subject: [PATCH v2 4/7] dmaengine: sun6i: Add a quirk for setting mode fields
Date:   Sat, 25 May 2019 18:38:16 +0200
Message-Id: <20190525163819.21055-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525163819.21055-1-peron.clem@gmail.com>
References: <20190525163819.21055-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 DMA has mode fields in different position than any other currently
supported DMA controller.

Add a quirk for that.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/dma/sun6i-dma.c | 46 ++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index f725b93fd21a..f5cb5e89bf7b 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -70,15 +70,13 @@
 #define DMA_CHAN_CUR_CFG	0x0c
 #define DMA_CHAN_MAX_DRQ_A31		0x1f
 #define DMA_CHAN_CFG_SRC_DRQ_A31(x)	((x) & DMA_CHAN_MAX_DRQ_A31)
-#define DMA_CHAN_CFG_SRC_IO_MODE	BIT(5)
-#define DMA_CHAN_CFG_SRC_LINEAR_MODE	(0 << 5)
+#define DMA_CHAN_CFG_SRC_MODE_A31(x)	(((x) & 0x1) << 5)
 #define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
 #define DMA_CHAN_CFG_SRC_BURST_H3(x)	(((x) & 0x3) << 6)
 #define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
 
 #define DMA_CHAN_CFG_DST_DRQ_A31(x)	(DMA_CHAN_CFG_SRC_DRQ_A31(x) << 16)
-#define DMA_CHAN_CFG_DST_IO_MODE	(DMA_CHAN_CFG_SRC_IO_MODE << 16)
-#define DMA_CHAN_CFG_DST_LINEAR_MODE	(DMA_CHAN_CFG_SRC_LINEAR_MODE << 16)
+#define DMA_CHAN_CFG_DST_MODE_A31(x)	(DMA_CHAN_CFG_SRC_MODE_A31(x) << 16)
 #define DMA_CHAN_CFG_DST_BURST_A31(x)	(DMA_CHAN_CFG_SRC_BURST_A31(x) << 16)
 #define DMA_CHAN_CFG_DST_BURST_H3(x)	(DMA_CHAN_CFG_SRC_BURST_H3(x) << 16)
 #define DMA_CHAN_CFG_DST_WIDTH(x)	(DMA_CHAN_CFG_SRC_WIDTH(x) << 16)
@@ -98,6 +96,8 @@
 #define LLI_LAST_ITEM	0xfffff800
 #define NORMAL_WAIT	8
 #define DRQ_SDRAM	1
+#define LINEAR_MODE     0
+#define IO_MODE         1
 
 /* forward declaration */
 struct sun6i_dma_dev;
@@ -126,6 +126,7 @@ struct sun6i_dma_config {
 	void (*clock_autogate_enable)(struct sun6i_dma_dev *);
 	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
 	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
+	void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
 	u32 src_burst_lengths;
 	u32 dst_burst_lengths;
 	u32 src_addr_widths;
@@ -318,6 +319,12 @@ static void sun6i_set_drq_a31(u32 *p_cfg, s8 src_drq, s8 dst_drq)
 		  DMA_CHAN_CFG_DST_DRQ_A31(dst_drq);
 }
 
+static void sun6i_set_mode_a31(u32 *p_cfg, s8 src_mode, s8 dst_mode)
+{
+	*p_cfg |= DMA_CHAN_CFG_SRC_MODE_A31(src_mode) |
+		  DMA_CHAN_CFG_DST_MODE_A31(dst_mode);
+}
+
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
 {
 	struct sun6i_desc *txd = pchan->desc;
@@ -641,13 +648,12 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 
 	burst = convert_burst(8);
 	width = convert_buswidth(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	v_lli->cfg = DMA_CHAN_CFG_DST_LINEAR_MODE |
-		DMA_CHAN_CFG_SRC_LINEAR_MODE |
-		DMA_CHAN_CFG_SRC_WIDTH(width) |
+	v_lli->cfg = DMA_CHAN_CFG_SRC_WIDTH(width) |
 		DMA_CHAN_CFG_DST_WIDTH(width);
 
 	sdev->cfg->set_burst_length(&v_lli->cfg, burst, burst);
 	sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, DRQ_SDRAM);
+	sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, LINEAR_MODE);
 
 	sun6i_dma_lli_add(NULL, v_lli, p_lli, txd);
 
@@ -699,10 +705,9 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 		if (dir == DMA_MEM_TO_DEV) {
 			v_lli->src = sg_dma_address(sg);
 			v_lli->dst = sconfig->dst_addr;
-			v_lli->cfg = lli_cfg |
-				DMA_CHAN_CFG_DST_IO_MODE |
-				DMA_CHAN_CFG_SRC_LINEAR_MODE;
+			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
+			sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, IO_MODE);
 
 			dev_dbg(chan2dev(chan),
 				"%s; chan: %d, dest: %pad, src: %pad, len: %u. flags: 0x%08lx\n",
@@ -713,10 +718,9 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 		} else {
 			v_lli->src = sconfig->src_addr;
 			v_lli->dst = sg_dma_address(sg);
-			v_lli->cfg = lli_cfg |
-				DMA_CHAN_CFG_DST_LINEAR_MODE |
-				DMA_CHAN_CFG_SRC_IO_MODE;
+			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
+			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, LINEAR_MODE);
 
 			dev_dbg(chan2dev(chan),
 				"%s; chan: %d, dest: %pad, src: %pad, len: %u. flags: 0x%08lx\n",
@@ -782,17 +786,15 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 		if (dir == DMA_MEM_TO_DEV) {
 			v_lli->src = buf_addr + period_len * i;
 			v_lli->dst = sconfig->dst_addr;
-			v_lli->cfg = lli_cfg |
-				DMA_CHAN_CFG_DST_IO_MODE |
-				DMA_CHAN_CFG_SRC_LINEAR_MODE;
+			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
+			sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, IO_MODE);
 		} else {
 			v_lli->src = sconfig->src_addr;
 			v_lli->dst = buf_addr + period_len * i;
-			v_lli->cfg = lli_cfg |
-				DMA_CHAN_CFG_DST_LINEAR_MODE |
-				DMA_CHAN_CFG_SRC_IO_MODE;
+			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
+			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, LINEAR_MODE);
 		}
 
 		prev = sun6i_dma_lli_add(prev, v_lli, p_lli, txd);
@@ -1058,6 +1060,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.nr_max_vchans   = 53,
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
+	.set_mode         = sun6i_set_mode_a31,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1080,6 +1083,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.clock_autogate_enable = sun6i_enable_clock_autogate_a23,
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
+	.set_mode         = sun6i_set_mode_a31,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1097,6 +1101,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.clock_autogate_enable = sun6i_enable_clock_autogate_a23,
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
+	.set_mode         = sun6i_set_mode_a31,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1121,6 +1126,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.clock_autogate_enable = sun6i_enable_clock_autogate_h3,
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_a31,
+	.set_mode         = sun6i_set_mode_a31,
 	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1141,6 +1147,7 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
 	.clock_autogate_enable = sun6i_enable_clock_autogate_h3,
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_a31,
+	.set_mode         = sun6i_set_mode_a31,
 	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1165,6 +1172,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.clock_autogate_enable = sun6i_enable_clock_autogate_a23,
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
+	.set_mode         = sun6i_set_mode_a31,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-- 
2.20.1

