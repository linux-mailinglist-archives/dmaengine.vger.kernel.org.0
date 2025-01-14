Return-Path: <dmaengine+bounces-4110-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88291A104B7
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2025 11:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161EF7A2E9A
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2025 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1A229604;
	Tue, 14 Jan 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhqENi0M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8022DC25
	for <dmaengine@vger.kernel.org>; Tue, 14 Jan 2025 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852146; cv=none; b=KMuGyEJXDCzYbM5ZBluL2sFx3Pb3qu99qWbz58H850PtA44u2QiFlH0Zl2ZvxcpjzBQbSkM/4cYIsTi643mwhp0KglMBqqQ1UvB9Hqmm+Upq9xh5boF62NnHxkSYLkWSMU+/iiG3JDEX2Mf7As7ZhtXpkE6ALKP7XCKgn5nLojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852146; c=relaxed/simple;
	bh=PhAfGfQbBpz/wfvfFqXb65XCKmqiTpALKSOTqIQlbX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcZW7NIBbFBeTiJnLn+X+D+RlyN4fKlyLUdTFDb7b6+Ir1gLMAAfXa3kPMJ3Nja8yB/D3lJk1SnX+wMHtCK/2Rd6RlBFNl25lueOggK0sxL1tTldYuMNUVB4vN8h0R1qheufocLOsfM/o5/HfastF0CRQR2ne1rRM1Xmh39Us9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KhqENi0M; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa6647a7556so94758366b.2
        for <dmaengine@vger.kernel.org>; Tue, 14 Jan 2025 02:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736852143; x=1737456943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w20vK13nhMzbjHJZSCggje7+hpPlrM9z3S//rlxScS4=;
        b=KhqENi0M07jzlxaKX6hYH8f+CvIz/qdzJuZ1eCuhPtDvARlkH1TRZRqbVoXjAb8BDR
         o5/1nSE48wYpAYum4pWBcVakXPFd889kv258HcaUFBev7S2VHnV1lVRMbI3hHXW8dTiw
         NmlqeJXor0J8Y4nHr9nAeWpps5M5xNbjbl3uAU9RznfwbXP3QtRZMvVflGLU/3Jeg1KB
         Ou07OvB2bG28Gdz3XsJ3o6lrcE86eaCZoaxVl+jenA+cVLYaWL5gyd+nP2+bCs+4qFXR
         MacmuqZM1SU6YysfjmcDitOcJqC9/TOW3KgfZjdo9qgPBCJSvBLc+uHn0rrmlRc/2LkF
         xObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736852143; x=1737456943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w20vK13nhMzbjHJZSCggje7+hpPlrM9z3S//rlxScS4=;
        b=OICi00YPbGc5eKPL5IUDqc9Wg9R5gvfuZ9PCVG1pfzMMm4sDFcfvQVjb6Zl7uhSsRn
         T2OJRtN8AeWEe7thxLqTrgEgB5A8VvUsWDWEJekFIxE+F1J3SQ/NWHvySAIuK5zeazD5
         c5j+DhW0Z4ehSF7Q2BrQs+/bDBmTs0F7bInmqbRmWrWHcd37yiK6eij8NA29KqiknRiG
         2JGk/Hdoa1ZivxX2jahc07c2VOVqZnvgsOWkeYjQD+m81s43/g9l0nlegiJfsk42x+Z3
         0GmN2ctvWL4PmE4hnvWr4AQXdVJGhm+l+WwsXB02o4dcwHYON8+HDOJsiI5vdFPcS/7q
         aFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlGHOvIcvmGEZrIwGdE6KlfeWVtmULLsYTtma0X7cJU9nEk6kbVuVmS3b60lu4AnjWgxDIaMKZdqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjnouaVNpt4pEn1Rza3OQ/A4GyG8t9aKNDlaI3vV7Wfxza8lv
	kYG33OpIq0hioWbtDJqfdHEh8byzmtwsD/qLvnpFQM+G1VAATwHvzd5K64H8DeQ=
X-Gm-Gg: ASbGncsj78UfEoXKSx7jEmUC2gHJA8VlXEssYPemVsV1sxyzauf2X4bauML2G2jV6Fm
	4duqPv/jyo5TYmWvuPJiV4cw+Mtzz+Wf2/lIb0pfyjnNWZQQzNqxqm7FZyw22n2LIV645d3ebTd
	HcF0ZqCUZCmNUx8gxsYusLBUEbI91h2xl0VRQIcTw0kjlzb9HWcHnWfZgf2/IdVjqYAeaReSK8m
	BHejfaCzIJ7evydzY3yuvumxpOqsvH2XlgiJQ55sDSFmrcUgkYArU/3HPlHivRC5IfW6Z0=
X-Google-Smtp-Source: AGHT+IG+VYqAZEZjAkkDupQTvwlvu2SSq7a2Lp6yZVkX5waA19et6Qvi69lKI25WLQ+J8Hn9t77VNw==
X-Received: by 2002:a17:906:c14b:b0:aac:619:6411 with SMTP id a640c23a62f3a-ab2abc6fd33mr825598566b.11.1736852142566;
        Tue, 14 Jan 2025 02:55:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95624e8sm611169266b.127.2025.01.14.02.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:55:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dmaengine: Use str_enable_disable-like helpers
Date: Tue, 14 Jan 2025 11:55:37 +0100
Message-ID: <20250114105538.272963-1-krzysztof.kozlowski@linaro.org>
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
 drivers/dma/imx-dma.c           | 3 ++-
 drivers/dma/pxa_dma.c           | 4 ++--
 drivers/dma/ti/edma.c           | 3 ++-
 drivers/dma/xilinx/xilinx_dma.c | 3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)

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


