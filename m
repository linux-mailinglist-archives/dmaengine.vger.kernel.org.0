Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BECC121F85
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfLQAUE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:20:04 -0500
Received: from muru.com ([72.249.23.125]:48774 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfLQAUE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:20:04 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 0C1DB8126;
        Tue, 17 Dec 2019 00:20:41 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 11/14] dmaengine: ti: omap-dma: Allocate channels directly
Date:   Mon, 16 Dec 2019 16:19:22 -0800
Message-Id: <20191217001925.44558-12-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With the legacy IRQ handling gone, we can now start allocating channels
directly in the dmaengine driver for device tree based SoCs.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/dma/ti/omap-dma.c | 62 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -28,6 +28,7 @@ struct omap_dma_config {
 	int lch_end;
 	unsigned int rw_priority:1;
 	unsigned int may_lose_context:1;
+	unsigned int needs_lch_clear:1;
 };
 
 struct omap_dma_context {
@@ -47,6 +48,8 @@ struct omap_dmadev {
 	struct notifier_block nb;
 	struct omap_dma_context context;
 	int lch_count;
+	DECLARE_BITMAP(lch_bitmap, OMAP_SDMA_CHANNELS);
+	struct mutex lch_lock;		/* for assigning logical channels */
 	bool legacy;
 	bool ll123_supported;
 	struct dma_pool *desc_pool;
@@ -664,6 +667,37 @@ static irqreturn_t omap_dma_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+static int omap_dma_get_lch(struct omap_dmadev *od, int *lch)
+{
+	int channel;
+
+	mutex_lock(&od->lch_lock);
+	channel = find_first_zero_bit(od->lch_bitmap, od->lch_count);
+	if (channel >= od->lch_count)
+		goto out_busy;
+	set_bit(channel, od->lch_bitmap);
+	mutex_unlock(&od->lch_lock);
+
+	omap_dma_clear_lch(od, channel);
+	*lch = channel;
+
+	return 0;
+
+out_busy:
+	mutex_unlock(&od->lch_lock);
+	*lch = -EINVAL;
+
+	return -EBUSY;
+}
+
+static void omap_dma_put_lch(struct omap_dmadev *od, int lch)
+{
+	omap_dma_clear_lch(od, lch);
+	mutex_lock(&od->lch_lock);
+	clear_bit(lch, od->lch_bitmap);
+	mutex_unlock(&od->lch_lock);
+}
+
 static int omap_dma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct omap_dmadev *od = to_omap_dma_dev(chan->device);
@@ -675,15 +709,13 @@ static int omap_dma_alloc_chan_resources(struct dma_chan *chan)
 		ret = omap_request_dma(c->dma_sig, "DMA engine",
 				       omap_dma_callback, c, &c->dma_ch);
 	} else {
-		ret = omap_request_dma(c->dma_sig, "DMA engine", NULL, NULL,
-				       &c->dma_ch);
+		ret = omap_dma_get_lch(od, &c->dma_ch);
 	}
 
 	dev_dbg(dev, "allocating channel %u for %u\n", c->dma_ch, c->dma_sig);
 
 	if (ret >= 0) {
 		omap_dma_assign(od, c, c->dma_ch);
-		pr_info("XXX %s: assigned lch: %i\n", __func__, c->dma_ch);
 
 		if (!od->legacy) {
 			unsigned val;
@@ -734,7 +766,11 @@ static void omap_dma_free_chan_resources(struct dma_chan *chan)
 	c->channel_base = NULL;
 	od->lch_map[c->dma_ch] = NULL;
 	vchan_free_chan_resources(&c->vc);
-	omap_free_dma(c->dma_ch);
+
+	if (od->legacy)
+		omap_free_dma(c->dma_ch);
+	else
+		omap_dma_put_lch(od, c->dma_ch);
 
 	dev_dbg(od->ddev.dev, "freeing channel %u used for %u\n", c->dma_ch,
 		c->dma_sig);
@@ -1574,6 +1610,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 	struct omap_dmadev *od;
 	struct resource *res;
 	int rc, i, irq;
+	u32 val;
 
 	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
 	if (!od)
@@ -1628,6 +1665,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 	od->ddev.max_burst = SZ_16M - 1; /* CCEN: 24bit unsigned */
 	od->ddev.dev = &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
+	mutex_init(&od->lch_lock);
 	spin_lock_init(&od->lock);
 	spin_lock_init(&od->irq_lock);
 
@@ -1654,6 +1692,17 @@ static int omap_dma_probe(struct platform_device *pdev)
 		od->lch_count = OMAP_SDMA_CHANNELS;
 	}
 
+	/* Mask of allowed logical channels */
+	if (pdev->dev.of_node && !of_property_read_u32(pdev->dev.of_node,
+						       "dma-channel-mask",
+						       &val)) {
+		/* Tag channels not in mask as reserved */
+		val = ~val;
+		bitmap_from_arr32(od->lch_bitmap, &val, od->lch_count);
+	}
+	if (od->plat->dma_attr->dev_caps & HS_CHANNELS_RESERVED)
+		bitmap_set(od->lch_bitmap, 0, 2);
+
 	od->lch_map = devm_kcalloc(&pdev->dev, od->lch_count,
 				   sizeof(*od->lch_map),
 				   GFP_KERNEL);
@@ -1772,28 +1821,33 @@ static int omap_dma_remove(struct platform_device *pdev)
 static const struct omap_dma_config omap2420_data = {
 	.lch_end = CCFN,
 	.rw_priority = true,
+	.needs_lch_clear = true,
 };
 
 static const struct omap_dma_config omap2430_data = {
 	.lch_end = CCFN,
 	.rw_priority = true,
+	.needs_lch_clear = true,
 };
 
 static const struct omap_dma_config omap3430_data = {
 	.lch_end = CCFN,
 	.rw_priority = true,
+	.needs_lch_clear = true,
 	.may_lose_context = true,
 };
 
 static const struct omap_dma_config omap3630_data = {
 	.lch_end = CCDN,
 	.rw_priority = true,
+	.needs_lch_clear = true,
 	.may_lose_context = true,
 };
 
 static const struct omap_dma_config omap4_data = {
 	.lch_end = CCDN,
 	.rw_priority = true,
+	.needs_lch_clear = true,
 };
 
 static const struct of_device_id omap_dma_match[] = {
-- 
2.24.1
