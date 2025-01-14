Return-Path: <dmaengine+bounces-4113-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BF6A110DF
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2025 20:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938CF168DFE
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2025 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9A82045A5;
	Tue, 14 Jan 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkfZJI/H"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518341FC7DB
	for <dmaengine@vger.kernel.org>; Tue, 14 Jan 2025 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881841; cv=none; b=UFu0fphfss2JkdXPjzzLb0YiNh7bjIE7GCeZ4VOIgx2olqyFTUArEt0o5bOWYu7j7YJRTRPQfhlypgzoDCLFP/W/jWLoiGdGjVF54HRkhy5iGPZV6GQXrIb1wVoXHZxj+6HMUELCjni+j/CNZmynnVsbsQHNGkaTt85NhAv+hXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881841; c=relaxed/simple;
	bh=00zE05JwVw+zUZJIln5biscGtauqbH2vGDzl9MH+hxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jj/3gCTIgddP7OVePJFX8WvYdnaIuO4Fgy/rDqM/1m1Da+bY6EQiF7wM/acuDUKVng6ELExI78LcVpIxJ24pyLVELRZIM4UgS8PEam8cwmBIwIlLRW07WEUDkuE4iVZrVfvwDQEOOV7LLQ+tR8bdniWctKHA06TTb0k9X8NYB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HkfZJI/H; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385dc85496dso290248f8f.3
        for <dmaengine@vger.kernel.org>; Tue, 14 Jan 2025 11:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736881837; x=1737486637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Hq0kZV+DlzD8qoGvH66U3+jQ5umvo6DGWQDujH64ns=;
        b=HkfZJI/HhtwS2Snc4HtZFZ230iEi/I/s8xzNRqyyLWALZEUAdihmSFUYLI5dlorleD
         THW6IDJS5plrqlPAo8mtmQ2vHO62Uqw5d2Hc5F2hEQCyScaD84sj+5eUgsuDiU8QhDT4
         PMeGPeIO06J6nm2LX/kfxQpKak2CAs2zoR1C6zLP/Xyn+tb+23icTcEFRg2tAFQmRiOo
         WP6jut96fDhHqeEg4baescl5KfgDf31avSF08mjv+5TRp1XBLSXp+U50XfV42ivPdbaX
         I9dQYLHfykm+sAwzZ0C/KRIj+7A+zZil36BKHCKkL51lq8PZd8NXlJl45g8iXuadzsoG
         X00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736881837; x=1737486637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Hq0kZV+DlzD8qoGvH66U3+jQ5umvo6DGWQDujH64ns=;
        b=myUA+jSA6tIvhZizOgvwCUy0DCN6na/ooduTCTz1VMlRhIOcbnh6y2z8zDpPkCh6yn
         wnbn/HnNZQFxia4/DNeg9ub3lfLmOgn3YWzlCS+9roSMLue1lszns9UAnNb0BqrfZjBP
         WHXtDMbB4p5p/lOaRKMMQsxS4FW1K5wirRCPuuU/alc0hmq5HAE0c3Z9OiJXJMuB8zTg
         T+jV9gXmCSYKP6BMlQuT3zDTnG+0GFIzMHup2qqrWZtgXgzN0afHswTag5yC1ldkJG5b
         hDCxjs/aCKC/wD/lt7wIdH2skFuC3lpCb/brPZnLANqsuaXcGeLNPWorOCkIEKhQOyVe
         99jg==
X-Forwarded-Encrypted: i=1; AJvYcCVxIgEd36mYFeExqAQWHELsFXsexup5KUCSROg5BHXU1hyY3c+xmZ2GInci9a1kH9BdzjJepDpBbq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJM/VXAqgpWsPdo1alnKuoPjDWNYrR4czSBF/14eQm1EQYtD/f
	Fc30hIUt//tu6oZlOm1B/0gHsyEPRNeA/g4HUiEM12mJSIYACQY0CX0pG+FbrpU=
X-Gm-Gg: ASbGncu1igAG6F42nQvSCATu/zubVdiJWhse0mf+ejs478TS0ommZ8QltFjQmbYBBFo
	q/9EnwfgcI3lp06qcSQoAAdSyOjDT2VohBdc26r6YgISfTnPDkY8VIOIk0DkPC7rCzo3qW8NKyH
	2I/1AVA83FMjqxsbYTq37BVIlO09FjuusXBA3EDN4IMw7OQo72UTsQJybgRa87CGr3XSnhzpNQI
	gqbPbnNPmzyelzALGAsgBKAYkQlV6CF+Hyhi6r16YULmEUCVCOrHBGxYXeVju1xr9ePP2c=
X-Google-Smtp-Source: AGHT+IG2A8LJoFY7HSHluOf/VUgtUb7NwFTVX2MTXjdEOwZYpV2MYFuUV6Fofa8Ort5P+B1yzvLbnQ==
X-Received: by 2002:a05:6000:1ac5:b0:385:f3d8:66b9 with SMTP id ffacd0b85a97d-38a873122f8mr8267937f8f.11.1736881837369;
        Tue, 14 Jan 2025 11:10:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddcda3sm219721835e9.22.2025.01.14.11.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:10:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dmaengine: Use str_enable_disable-like helpers
Date: Tue, 14 Jan 2025 20:10:20 +0100
Message-ID: <20250114191021.854080-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ternary (condition ? "enable" : "disable") syntax with helpers
from string_choices.h because:
1. Simple function call with one argument is easier to read.  Ternary
   operator has three arguments and with wrapping might lead to quite
   long code.
2. Is slightly shorter thus also easier to read.
3. It brings uniformity in the text - same string.
4. Allows deduping by the linker, which results in a smaller binary
   file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Also drivers/dma/dw-edma/dw-edma-core.c and drivers/dma/sun6i-dma.c
---
 drivers/dma/dw-edma/dw-edma-core.c | 6 ++++--
 drivers/dma/imx-dma.c              | 3 ++-
 drivers/dma/pxa_dma.c              | 4 ++--
 drivers/dma/sun6i-dma.c            | 3 ++-
 drivers/dma/ti/edma.c              | 3 ++-
 drivers/dma/xilinx/xilinx_dma.c    | 3 ++-
 6 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 68236247059d..c2b88cc99e5d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -15,6 +15,7 @@
 #include <linux/irq.h>
 #include <linux/dma/edma.h>
 #include <linux/dma-mapping.h>
+#include <linux/string_choices.h>
 
 #include "dw-edma-core.h"
 #include "dw-edma-v0-core.h"
@@ -746,7 +747,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->ll_max -= 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
-			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
+			 str_write_read(chan->dir == EDMA_DIR_WRITE),
 			 chan->id, chan->ll_max);
 
 		if (dw->nr_irqs == 1)
@@ -767,7 +768,8 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
 
 		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
-			 chan->dir == EDMA_DIR_WRITE  ? "write" : "read", chan->id,
+			 str_write_read(chan->dir == EDMA_DIR_WRITE),
+			 chan->id,
 			 chan->msi.address_hi, chan->msi.address_lo,
 			 chan->msi.data);
 
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index a651e0995ce8..de8d7070904e 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
@@ -942,7 +943,7 @@ static struct dma_async_tx_descriptor *imxdma_prep_dma_interleaved(
 		"   src_sgl=%s dst_sgl=%s numf=%zu frame_size=%zu\n", __func__,
 		imxdmac->channel, (unsigned long long)xt->src_start,
 		(unsigned long long) xt->dst_start,
-		xt->src_sgl ? "true" : "false", xt->dst_sgl ? "true" : "false",
+		str_true_false(xt->src_sgl), str_true_false(xt->dst_sgl),
 		xt->numf, xt->frame_size);
 
 	if (list_empty(&imxdmac->ld_free) ||
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index e50cf3357e5e..249296389771 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -10,6 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/dmaengine.h>
 #include <linux/platform_device.h>
 #include <linux/device.h>
@@ -277,8 +278,7 @@ static int chan_state_show(struct seq_file *s, void *p)
 	seq_printf(s, "\tPriority : %s\n",
 			  str_prio[(phy->idx & 0xf) / 4]);
 	seq_printf(s, "\tUnaligned transfer bit: %s\n",
-			  _phy_readl_relaxed(phy, DALGN) & BIT(phy->idx) ?
-			  "yes" : "no");
+			  str_yes_no(_phy_readl_relaxed(phy, DALGN) & BIT(phy->idx)));
 	seq_printf(s, "\tDCSR  = %08x (%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s)\n",
 		   dcsr, PXA_DCSR_STR(RUN), PXA_DCSR_STR(NODESC),
 		   PXA_DCSR_STR(STOPIRQEN), PXA_DCSR_STR(EORIRQEN),
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 95ecb12caaa5..2215ff877bf7 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 
 #include "virt-dma.h"
@@ -553,7 +554,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 			continue;
 
 		dev_dbg(sdev->slave.dev, "DMA irq status %s: 0x%x\n",
-			i ? "high" : "low", status);
+			str_high_low(i), status);
 
 		writel(status, sdev->base + DMA_IRQ_STAT(i));
 
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 4ece125b2ae7..b1a54655e6ce 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
 #include <linux/of_irq.h>
@@ -2047,7 +2048,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	dev_dbg(dev, "num_qchannels: %u\n", ecc->num_qchannels);
 	dev_dbg(dev, "num_slots: %u\n", ecc->num_slots);
 	dev_dbg(dev, "num_tc: %u\n", ecc->num_tc);
-	dev_dbg(dev, "chmap_exist: %s\n", ecc->chmap_exist ? "yes" : "no");
+	dev_dbg(dev, "chmap_exist: %s\n", str_yes_no(ecc->chmap_exist));
 
 	/* Nothing need to be done if queue priority is provided */
 	if (pdata->queue_priority_mapping)
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 108a7287f4cd..3ad44afd0e74 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -46,6 +46,7 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/clk.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 
@@ -2940,7 +2941,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 			    XILINX_DMA_DMASR_SG_MASK)
 			chan->has_sg = true;
 		dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
-			chan->has_sg ? "enabled" : "disabled");
+			str_enabled_disabled(chan->has_sg));
 	}
 
 	/* Initialize the tasklet */
-- 
2.43.0


