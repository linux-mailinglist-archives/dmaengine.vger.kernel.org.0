Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D522DA0092
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2019 13:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfH1LPk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Aug 2019 07:15:40 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:38347 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725991AbfH1LPj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Aug 2019 07:15:39 -0400
X-IronPort-AV: E=Sophos;i="5.64,440,1559487600"; 
   d="scan'208";a="24930198"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Aug 2019 20:15:37 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 82F3342296E1;
        Wed, 28 Aug 2019 20:15:37 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/2] dmaengine: rcar-dmac: Don't set DMACHCLR bit 0 to 1 if iommu is mapped
Date:   Wed, 28 Aug 2019 20:13:54 +0900
Message-Id: <1566990835-27028-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566990835-27028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1566990835-27028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The commit 20c169aceb45 ("dmaengine: rcar-dmac: clear pertinence
number of channels") always set the DMACHCLR bit 0 to 1, but if
iommu is mapped to the device, this driver doesn't need to clear it.
So, this patch takes care of it by using "channels_mask" bitfield.

Note that, this patch doesn't have a "Fixes:" tag because the driver
doesn't manage the channel 0 anyway so that the behavior of
the channel is not changed.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 779b715..204160e 100644
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
@@ -446,7 +448,7 @@ static int rcar_dmac_init(struct rcar_dmac *dmac)
 	u16 dmaor;
 
 	/* Clear all channels and enable the DMAC globally. */
-	rcar_dmac_write(dmac, RCAR_DMACHCLR, GENMASK(dmac->n_channels - 1, 0));
+	rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
 	rcar_dmac_write(dmac, RCAR_DMAOR,
 			RCAR_DMAOR_PRI_FIXED | RCAR_DMAOR_DME);
 
@@ -822,6 +824,9 @@ static void rcar_dmac_stop_all_chan(struct rcar_dmac *dmac)
 	for (i = 0; i < dmac->n_channels; ++i) {
 		struct rcar_dmac_chan *chan = &dmac->channels[i];
 
+		if (!(dmac->channels_mask & BIT(i)))
+			continue;
+
 		/* Stop and reinitialize the channel. */
 		spin_lock_irq(&chan->lock);
 		rcar_dmac_chan_halt(chan);
@@ -1801,6 +1806,8 @@ static int rcar_dmac_parse_of(struct device *dev, struct rcar_dmac *dmac)
 		return -EINVAL;
 	}
 
+	dmac->channels_mask = GENMASK(dmac->n_channels - 1, 0);
+
 	return 0;
 }
 
@@ -1810,7 +1817,6 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 		DMA_SLAVE_BUSWIDTH_2_BYTES | DMA_SLAVE_BUSWIDTH_4_BYTES |
 		DMA_SLAVE_BUSWIDTH_8_BYTES | DMA_SLAVE_BUSWIDTH_16_BYTES |
 		DMA_SLAVE_BUSWIDTH_32_BYTES | DMA_SLAVE_BUSWIDTH_64_BYTES;
-	unsigned int channels_offset = 0;
 	struct dma_device *engine;
 	struct rcar_dmac *dmac;
 	const struct rcar_dmac_of_data *data;
@@ -1843,10 +1849,8 @@ static int rcar_dmac_probe(struct platform_device *pdev)
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
@@ -1903,8 +1907,10 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&engine->channels);
 
 	for (i = 0; i < dmac->n_channels; ++i) {
-		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i], data,
-					   i + channels_offset);
+		if (!(dmac->channels_mask & BIT(i)))
+			continue;
+
+		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i], data, i);
 		if (ret < 0)
 			goto error;
 	}
-- 
2.7.4

