Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3800431614
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 12:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhJRK25 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 06:28:57 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:33053 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhJRK2y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Oct 2021 06:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1634552792;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=8V4a+ka21XmCMEzZ0ZIxTL3Kv2HDuub/ttB0v+Rkm54=;
    b=nvjxqucsY4AW2hYOCLeREUviBwaLwtGqEo6ixZaxPOB1xfGzHab1kaAz92Glu7SYwv
    o2Cm1PCa5HbfNVSP8qJtV98W4eU4ztMGds01aSegelQ4TkMeoAhI+EyTWoR136S8+ODt
    sV7QGADxics9Z1f5tJLrwmaU2cTNea2iOtbrar9YFh7OSJWkktHeFV7D++SKLdv/b51N
    fiI+0RgNHmvIJ8d2t7Dcfee/x76hlr5L9sOBa2e7naHRRVdusN66D6Ip8vztvkxllb4Y
    PpcXNH3cl7YJIomlO9MnUsYe48/6H0cWKpCSn8Vng2das5e91La7E8TC/xaygqyURdro
    ooAQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7UOGqRde+a0fiL1OfxR"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.33.8 AUTH)
    with ESMTPSA id 301038x9IAQVVQ6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 18 Oct 2021 12:26:31 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 2/2] dmaengine: qcom: bam_dma: Add "powered remotely" mode
Date:   Mon, 18 Oct 2021 12:24:21 +0200
Message-Id: <20211018102421.19848-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018102421.19848-1-stephan@gerhold.net>
References: <20211018102421.19848-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In some configurations, the BAM DMA controller is set up by a remote
processor and the local processor can simply start making use of it
without setting up the BAM. This is already supported using the
"qcom,controlled-remotely" property.

However, for some reason another possible configuration is that the
remote processor is responsible for powering up the BAM, but we are
still responsible for initializing it (e.g. resetting it etc).

This configuration is quite challenging to handle properly because
the power control is handled through separate channels
(e.g. device-specific SMSM interrupts / smem-states). Great care
must be taken to ensure the BAM registers are not accessed while
the BAM is powered off since this results in a bus stall.

Attempt to support this configuration with minimal device-specific
code in the bam_dma driver by tracking the number of requested
channels. Consumers of DMA channels are responsible to only request
DMA channels when the BAM was powered on by the remote processor,
and to release them before the BAM is powered off.

When the first channel is requested the BAM is initialized (reset)
and it is also put into reset when the last channel was released.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v3: Address review comment from Bjorn
  - Add missing () in documentation comment
  - Flip if condition to clarify code a bit
Changes since RFC:
  - Drop qcom-specific terminology "power collapse", instead rename
    "qcom,remote-power-collapse" -> "qcom,powered-remotely"

See original RFC for a discussion of alternative approaches to handle
this configuration:
  https://lore.kernel.org/netdev/20210719145317.79692-3-stephan@gerhold.net/
---
 drivers/dma/qcom/bam_dma.c | 90 ++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index c8a77b428b52..87f6ca1541cf 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -388,6 +388,8 @@ struct bam_device {
 	/* execution environment ID, from DT */
 	u32 ee;
 	bool controlled_remotely;
+	bool powered_remotely;
+	u32 active_channels;
 
 	const struct reg_offset_data *layout;
 
@@ -415,6 +417,44 @@ static inline void __iomem *bam_addr(struct bam_device *bdev, u32 pipe,
 		r.ee_mult * bdev->ee;
 }
 
+/**
+ * bam_reset() - reset and initialize BAM registers
+ * @bdev: bam device
+ */
+static void bam_reset(struct bam_device *bdev)
+{
+	u32 val;
+
+	/* s/w reset bam */
+	/* after reset all pipes are disabled and idle */
+	val = readl_relaxed(bam_addr(bdev, 0, BAM_CTRL));
+	val |= BAM_SW_RST;
+	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
+	val &= ~BAM_SW_RST;
+	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
+
+	/* make sure previous stores are visible before enabling BAM */
+	wmb();
+
+	/* enable bam */
+	val |= BAM_EN;
+	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
+
+	/* set descriptor threshhold, start with 4 bytes */
+	writel_relaxed(DEFAULT_CNT_THRSHLD,
+			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
+
+	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
+	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
+
+	/* enable irqs for errors */
+	writel_relaxed(BAM_ERROR_EN | BAM_HRESP_ERR_EN,
+			bam_addr(bdev, 0, BAM_IRQ_EN));
+
+	/* unmask global bam interrupt */
+	writel_relaxed(BAM_IRQ_MSK, bam_addr(bdev, 0, BAM_IRQ_SRCS_MSK_EE));
+}
+
 /**
  * bam_reset_channel - Reset individual BAM DMA channel
  * @bchan: bam channel
@@ -512,6 +552,9 @@ static int bam_alloc_chan(struct dma_chan *chan)
 		return -ENOMEM;
 	}
 
+	if (bdev->active_channels++ == 0 && bdev->powered_remotely)
+		bam_reset(bdev);
+
 	return 0;
 }
 
@@ -565,6 +608,13 @@ static void bam_free_chan(struct dma_chan *chan)
 	/* disable irq */
 	writel_relaxed(0, bam_addr(bdev, bchan->id, BAM_P_IRQ_EN));
 
+	if (--bdev->active_channels == 0 && bdev->powered_remotely) {
+		/* s/w reset bam */
+		val = readl_relaxed(bam_addr(bdev, 0, BAM_CTRL));
+		val |= BAM_SW_RST;
+		writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
+	}
+
 err:
 	pm_runtime_mark_last_busy(bdev->dev);
 	pm_runtime_put_autosuspend(bdev->dev);
@@ -1164,37 +1214,9 @@ static int bam_init(struct bam_device *bdev)
 		bdev->num_channels = val & BAM_NUM_PIPES_MASK;
 	}
 
-	if (bdev->controlled_remotely)
-		return 0;
-
-	/* s/w reset bam */
-	/* after reset all pipes are disabled and idle */
-	val = readl_relaxed(bam_addr(bdev, 0, BAM_CTRL));
-	val |= BAM_SW_RST;
-	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
-	val &= ~BAM_SW_RST;
-	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
-
-	/* make sure previous stores are visible before enabling BAM */
-	wmb();
-
-	/* enable bam */
-	val |= BAM_EN;
-	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
-
-	/* set descriptor threshhold, start with 4 bytes */
-	writel_relaxed(DEFAULT_CNT_THRSHLD,
-			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
-
-	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
-	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
-
-	/* enable irqs for errors */
-	writel_relaxed(BAM_ERROR_EN | BAM_HRESP_ERR_EN,
-			bam_addr(bdev, 0, BAM_IRQ_EN));
-
-	/* unmask global bam interrupt */
-	writel_relaxed(BAM_IRQ_MSK, bam_addr(bdev, 0, BAM_IRQ_SRCS_MSK_EE));
+	/* Reset BAM now if fully controlled locally */
+	if (!bdev->controlled_remotely && !bdev->powered_remotely)
+		bam_reset(bdev);
 
 	return 0;
 }
@@ -1257,8 +1279,10 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 	bdev->controlled_remotely = of_property_read_bool(pdev->dev.of_node,
 						"qcom,controlled-remotely");
+	bdev->powered_remotely = of_property_read_bool(pdev->dev.of_node,
+						"qcom,powered-remotely");
 
-	if (bdev->controlled_remotely) {
+	if (bdev->controlled_remotely || bdev->powered_remotely) {
 		ret = of_property_read_u32(pdev->dev.of_node, "num-channels",
 					   &bdev->num_channels);
 		if (ret)
@@ -1270,7 +1294,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 			dev_err(bdev->dev, "num-ees unspecified in dt\n");
 	}
 
-	if (bdev->controlled_remotely)
+	if (bdev->controlled_remotely || bdev->powered_remotely)
 		bdev->bamclk = devm_clk_get_optional(bdev->dev, "bam_clk");
 	else
 		bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
-- 
2.33.0

