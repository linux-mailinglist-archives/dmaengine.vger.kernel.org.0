Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 524ACAD327
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2019 08:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfIIGfi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Sep 2019 02:35:38 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:12578 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729455AbfIIGfi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Sep 2019 02:35:38 -0400
X-IronPort-AV: E=Sophos;i="5.64,483,1559487600"; 
   d="scan'208";a="26091407"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Sep 2019 15:35:35 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 99B8041A59F7;
        Mon,  9 Sep 2019 15:35:35 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vinod.koul@intel.com
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 1/4] dmaengine: rcar-dmac: Fix DMACHCLR handling if iommu is mapped
Date:   Mon,  9 Sep 2019 15:34:49 +0900
Message-Id: <1568010892-17606-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568010892-17606-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1568010892-17606-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The commit 20c169aceb45 ("dmaengine: rcar-dmac: clear pertinence
number of channels") forgets to clear the last channel by
DMACHCLR in rcar_dmac_init() (and doesn't need to clear the first
channel) if iommu is mapped to the device. So, this patch fixes it
by using "channels_mask" bitfield.

Note that the hardware and driver don't support more than 32 bits
in DMACHCLR register anyway, so this patch should reject more than
32 channels in rcar_dmac_parse_of().

Fixes: 20c169aceb459575 ("dmaengine: rcar-dmac: clear pertinence number of channels")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/1567424643-26629-1-git-send-email-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
(cherry picked from commit cf24aac38698bfa1d021afd3883df3c4c65143a4)
[just cherry-picked it for slave-dma/next]
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index eb6f231..3993ab6 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -192,6 +192,7 @@ struct rcar_dmac_chan {
  * @iomem: remapped I/O memory base
  * @n_channels: number of available channels
  * @channels: array of DMAC channels
+ * @channels_mask: bitfield of which DMA channels are managed by this driver
  * @modules: bitmask of client modules in use
  */
 struct rcar_dmac {
@@ -202,6 +203,7 @@ struct rcar_dmac {
 
 	unsigned int n_channels;
 	struct rcar_dmac_chan *channels;
+	unsigned int channels_mask;
 
 	DECLARE_BITMAP(modules, 256);
 };
@@ -438,7 +440,7 @@ static int rcar_dmac_init(struct rcar_dmac *dmac)
 	u16 dmaor;
 
 	/* Clear all channels and enable the DMAC globally. */
-	rcar_dmac_write(dmac, RCAR_DMACHCLR, GENMASK(dmac->n_channels - 1, 0));
+	rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
 	rcar_dmac_write(dmac, RCAR_DMAOR,
 			RCAR_DMAOR_PRI_FIXED | RCAR_DMAOR_DME);
 
@@ -814,6 +816,9 @@ static void rcar_dmac_stop_all_chan(struct rcar_dmac *dmac)
 	for (i = 0; i < dmac->n_channels; ++i) {
 		struct rcar_dmac_chan *chan = &dmac->channels[i];
 
+		if (!(dmac->channels_mask & BIT(i)))
+			continue;
+
 		/* Stop and reinitialize the channel. */
 		spin_lock_irq(&chan->lock);
 		rcar_dmac_chan_halt(chan);
@@ -1774,6 +1779,8 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 	return 0;
 }
 
+#define RCAR_DMAC_MAX_CHANNELS	32
+
 static int rcar_dmac_parse_of(struct device *dev, struct rcar_dmac *dmac)
 {
 	struct device_node *np = dev->of_node;
@@ -1785,12 +1792,16 @@ static int rcar_dmac_parse_of(struct device *dev, struct rcar_dmac *dmac)
 		return ret;
 	}
 
-	if (dmac->n_channels <= 0 || dmac->n_channels >= 100) {
+	/* The hardware and driver don't support more than 32 bits in CHCLR */
+	if (dmac->n_channels <= 0 ||
+	    dmac->n_channels >= RCAR_DMAC_MAX_CHANNELS) {
 		dev_err(dev, "invalid number of channels %u\n",
 			dmac->n_channels);
 		return -EINVAL;
 	}
 
+	dmac->channels_mask = GENMASK(dmac->n_channels - 1, 0);
+
 	return 0;
 }
 
@@ -1800,7 +1811,6 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 		DMA_SLAVE_BUSWIDTH_2_BYTES | DMA_SLAVE_BUSWIDTH_4_BYTES |
 		DMA_SLAVE_BUSWIDTH_8_BYTES | DMA_SLAVE_BUSWIDTH_16_BYTES |
 		DMA_SLAVE_BUSWIDTH_32_BYTES | DMA_SLAVE_BUSWIDTH_64_BYTES;
-	unsigned int channels_offset = 0;
 	struct dma_device *engine;
 	struct rcar_dmac *dmac;
 	struct resource *mem;
@@ -1829,10 +1839,8 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	 * level we can't disable it selectively, so ignore channel 0 for now if
 	 * the device is part of an IOMMU group.
 	 */
-	if (device_iommu_mapped(&pdev->dev)) {
-		dmac->n_channels--;
-		channels_offset = 1;
-	}
+	if (device_iommu_mapped(&pdev->dev))
+		dmac->channels_mask &= ~BIT(0);
 
 	dmac->channels = devm_kcalloc(&pdev->dev, dmac->n_channels,
 				      sizeof(*dmac->channels), GFP_KERNEL);
@@ -1890,8 +1898,10 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&engine->channels);
 
 	for (i = 0; i < dmac->n_channels; ++i) {
-		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i],
-					   i + channels_offset);
+		if (!(dmac->channels_mask & BIT(i)))
+			continue;
+
+		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i], i);
 		if (ret < 0)
 			goto error;
 	}
-- 
2.7.4

