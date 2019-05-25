Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D5B2A57C
	for <lists+dmaengine@lfdr.de>; Sat, 25 May 2019 18:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfEYQif (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 May 2019 12:38:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43912 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfEYQie (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 May 2019 12:38:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id l17so4424847wrm.10;
        Sat, 25 May 2019 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07+2U0H+IBjlhuGrjcqPkQ09B1GGgjfSq3SMD7jPmPk=;
        b=klPyfvEI/cinBZjUx/j9WztCqHYARfQARCJH1q6MDnkpugFwTZS3mXWJOPhY2kGm9X
         xvh8y4d29cRIP/haRLAjSm/wPDvhHSowZ9b+BTaxE25Wj94v3Hbhj8NY4kMrQgFFqArj
         Sdim6YOIeNCEs+B8n78T0DnM3lLO72mOaiTq79RuFx0s/A3FKGT0JMJkoUXlNDNHZkN6
         Cz2lzFORDCEjpKz2uQtW61g0f9z1ljIwrqsZZJGWZVQLIxTSlcUFdn3VmkCWavKq473z
         KIUSwRdjoE66O0i8n7CjJFSoIXC4TKqNnsPlYOj9J9errHJfOr344EHHAnZHXAF3vdEm
         k+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07+2U0H+IBjlhuGrjcqPkQ09B1GGgjfSq3SMD7jPmPk=;
        b=QzXbfqDaFTU/mtUIipL8eAiqrRBX3PrhgWIKILYtM6gf9bwKXAFFLlvOnqZe50lfRf
         BYmbRH9KiIbg8YtTjrie8JfwgJnHYRRvn/QVC8vM81c523GKOOIocu9Qx1DotjVYfVe+
         7EsQiMFeZz7MfoQYuNggj9R3JGD+vyDeAHTp9Yek0sEcfLzJUJgqJEZwlAhORq2lfzqx
         a+jnJvximtwut+3wlHDShiQm4XoR2duhR9ef5WN1hJlnb+js90I4/A0MWfhTM+ILpfy2
         9OeNauxnaIW957s5fgU8ChE6mAtfzXvy2nUVJY6MclufS6R/cYq5NxtFm4GrQLziYRi4
         1g9g==
X-Gm-Message-State: APjAAAUl7QAyT1YCoqeC9D+OL6PHXKDJiNKepvF+GlMh7L1e42C88V9t
        VTbVAyug9mIX33GZQF0W9Hk=
X-Google-Smtp-Source: APXvYqzm/wYeHMQ/bMWtYde+sUwDQUn/a6MwN3kmijYbXweILvEJLFoIryLiSzFlzR9HON9LpbyEqA==
X-Received: by 2002:adf:db89:: with SMTP id u9mr30158479wri.294.1558802311115;
        Sat, 25 May 2019 09:38:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id f65sm9306498wmg.45.2019.05.25.09.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 09:38:30 -0700 (PDT)
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
Subject: [PATCH v2 5/7] dmaengine: sun6i: Add support for H6 DMA
Date:   Sat, 25 May 2019 18:38:17 +0200
Message-Id: <20190525163819.21055-6-peron.clem@gmail.com>
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

H6 DMA has more than 32 supported DRQs, which means that configuration
register is slightly rearranged. It also needs additional clock to be
enabled.

Add support for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/dma/sun6i-dma.c | 44 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index f5cb5e89bf7b..8d44ddae926a 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -69,14 +69,19 @@
 
 #define DMA_CHAN_CUR_CFG	0x0c
 #define DMA_CHAN_MAX_DRQ_A31		0x1f
+#define DMA_CHAN_MAX_DRQ_H6		0x3f
 #define DMA_CHAN_CFG_SRC_DRQ_A31(x)	((x) & DMA_CHAN_MAX_DRQ_A31)
+#define DMA_CHAN_CFG_SRC_DRQ_H6(x)	((x) & DMA_CHAN_MAX_DRQ_H6)
 #define DMA_CHAN_CFG_SRC_MODE_A31(x)	(((x) & 0x1) << 5)
+#define DMA_CHAN_CFG_SRC_MODE_H6(x)	(((x) & 0x1) << 8)
 #define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
 #define DMA_CHAN_CFG_SRC_BURST_H3(x)	(((x) & 0x3) << 6)
 #define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
 
 #define DMA_CHAN_CFG_DST_DRQ_A31(x)	(DMA_CHAN_CFG_SRC_DRQ_A31(x) << 16)
+#define DMA_CHAN_CFG_DST_DRQ_H6(x)	(DMA_CHAN_CFG_SRC_DRQ_H6(x) << 16)
 #define DMA_CHAN_CFG_DST_MODE_A31(x)	(DMA_CHAN_CFG_SRC_MODE_A31(x) << 16)
+#define DMA_CHAN_CFG_DST_MODE_H6(x)	(DMA_CHAN_CFG_SRC_MODE_H6(x) << 16)
 #define DMA_CHAN_CFG_DST_BURST_A31(x)	(DMA_CHAN_CFG_SRC_BURST_A31(x) << 16)
 #define DMA_CHAN_CFG_DST_BURST_H3(x)	(DMA_CHAN_CFG_SRC_BURST_H3(x) << 16)
 #define DMA_CHAN_CFG_DST_WIDTH(x)	(DMA_CHAN_CFG_SRC_WIDTH(x) << 16)
@@ -319,12 +324,24 @@ static void sun6i_set_drq_a31(u32 *p_cfg, s8 src_drq, s8 dst_drq)
 		  DMA_CHAN_CFG_DST_DRQ_A31(dst_drq);
 }
 
+static void sun6i_set_drq_h6(u32 *p_cfg, s8 src_drq, s8 dst_drq)
+{
+	*p_cfg |= DMA_CHAN_CFG_SRC_DRQ_H6(src_drq) |
+		  DMA_CHAN_CFG_DST_DRQ_H6(dst_drq);
+}
+
 static void sun6i_set_mode_a31(u32 *p_cfg, s8 src_mode, s8 dst_mode)
 {
 	*p_cfg |= DMA_CHAN_CFG_SRC_MODE_A31(src_mode) |
 		  DMA_CHAN_CFG_DST_MODE_A31(dst_mode);
 }
 
+static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mode, s8 dst_mode)
+{
+	*p_cfg |= DMA_CHAN_CFG_SRC_MODE_H6(src_mode) |
+		  DMA_CHAN_CFG_DST_MODE_H6(dst_mode);
+}
+
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
 {
 	struct sun6i_desc *txd = pchan->desc;
@@ -1160,6 +1177,28 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
 };
 
+/*
+ * The H6 binding uses the number of dma channels from the
+ * device tree node.
+ */
+static struct sun6i_dma_config sun50i_h6_dma_cfg = {
+	.clock_autogate_enable = sun6i_enable_clock_autogate_h3,
+	.set_burst_length = sun6i_set_burst_length_h3,
+	.set_drq          = sun6i_set_drq_h6,
+	.set_mode         = sun6i_set_mode_h6,
+	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
+	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
+	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.has_mbus_clk = true,
+};
+
 /*
  * The V3s have only 8 physical channels, a maximum DRQ port id of 23,
  * and a total of 24 usable source and destination endpoints.
@@ -1190,6 +1229,7 @@ static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
 	{ .compatible = "allwinner,sun8i-v3s-dma", .data = &sun8i_v3s_dma_cfg },
 	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },
+	{ .compatible = "allwinner,sun50i-h6-dma", .data = &sun50i_h6_dma_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dma_match);
@@ -1288,8 +1328,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(np, "dma-requests", &sdc->max_request);
 	if (ret && !sdc->max_request) {
 		dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
-			 DMA_CHAN_MAX_DRQ_A31);
-		sdc->max_request = DMA_CHAN_MAX_DRQ_A31;
+			 DMA_CHAN_MAX_DRQ_H6);
+		sdc->max_request = DMA_CHAN_MAX_DRQ_H6;
 	}
 
 	/*
-- 
2.20.1

