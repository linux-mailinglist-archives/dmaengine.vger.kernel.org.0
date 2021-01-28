Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32E9307220
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jan 2021 09:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhA1Iy7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jan 2021 03:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhA1Ip3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jan 2021 03:45:29 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF0C06178A
        for <dmaengine@vger.kernel.org>; Thu, 28 Jan 2021 00:45:01 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id N8kx2400a4C55Sk018kyDE; Thu, 28 Jan 2021 09:44:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l52vB-001JYS-F6; Thu, 28 Jan 2021 09:44:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l52vB-009O1v-1g; Thu, 28 Jan 2021 09:44:57 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 4/4] dmaengine: rcar-dmac: Add support for R-Car V3U
Date:   Thu, 28 Jan 2021 09:44:55 +0100
Message-Id: <20210128084455.2237256-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128084455.2237256-1-geert+renesas@glider.be>
References: <20210128084455.2237256-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMACs (both SYS-DMAC and RT-DMAC) on R-Car V3U differ slightly from
the DMACs on R-Car Gen2 and other R-Car Gen3 SoCs:
  1. The per-channel registers are located in a second register block.
     Add support for mapping the second block, using the appropriate
     offsets and stride.
  2. The common Channel Clear Register (DMACHCLR) was replaced by a
     per-channel register.
     Update rcar_dmac_chan_clear{,_all}() to handle this.
     As rcar_dmac_init() needs to clear the status before the individual
     channels are probed, channel index and base address initialization
     are moved forward.

Inspired by a patch in the BSP by Phong Hoang
<phong.hoang.wz@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v3:
  - Add Tested-by,
  - Update for for_each_rcar_dmac_chan() parameter order change,
  - Stop passing index to rcar_dmac_chan_probe(),

v2:
  - Use two separate named regions instead of array,
  - Drop rcar_dmac_of_data.chan_reg_block, check for
    !rcar_dmac_of_data.chan_offset_base instead,
  - Precalculate chan_base in rcar_dmac_probe().
---
 drivers/dma/sh/rcar-dmac.c | 81 +++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 37e3c6890f8670da..6ea3f1ebfda9f2a0 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -189,7 +189,8 @@ struct rcar_dmac_chan {
  * struct rcar_dmac - R-Car Gen2 DMA Controller
  * @engine: base DMA engine object
  * @dev: the hardware device
- * @iomem: remapped I/O memory base
+ * @dmac_base: remapped base register block
+ * @chan_base: remapped channel register block (optional)
  * @n_channels: number of available channels
  * @channels: array of DMAC channels
  * @channels_mask: bitfield of which DMA channels are managed by this driver
@@ -198,7 +199,8 @@ struct rcar_dmac_chan {
 struct rcar_dmac {
 	struct dma_device engine;
 	struct device *dev;
-	void __iomem *iomem;
+	void __iomem *dmac_base;
+	void __iomem *chan_base;
 
 	unsigned int n_channels;
 	struct rcar_dmac_chan *channels;
@@ -234,7 +236,7 @@ struct rcar_dmac_of_data {
 #define RCAR_DMAOR_PRI_ROUND_ROBIN	(3 << 8)
 #define RCAR_DMAOR_AE			(1 << 2)
 #define RCAR_DMAOR_DME			(1 << 0)
-#define RCAR_DMACHCLR			0x0080
+#define RCAR_DMACHCLR			0x0080	/* Not on R-Car V3U */
 #define RCAR_DMADPSEC			0x00a0
 
 #define RCAR_DMASAR			0x0000
@@ -297,6 +299,9 @@ struct rcar_dmac_of_data {
 #define RCAR_DMAFIXDAR			0x0014
 #define RCAR_DMAFIXDPBASE		0x0060
 
+/* For R-Car V3U */
+#define RCAR_V3U_DMACHCLR		0x0100
+
 /* Hardcode the MEMCPY transfer size to 4 bytes. */
 #define RCAR_DMAC_MEMCPY_XFER_SIZE	4
 
@@ -307,17 +312,17 @@ struct rcar_dmac_of_data {
 static void rcar_dmac_write(struct rcar_dmac *dmac, u32 reg, u32 data)
 {
 	if (reg == RCAR_DMAOR)
-		writew(data, dmac->iomem + reg);
+		writew(data, dmac->dmac_base + reg);
 	else
-		writel(data, dmac->iomem + reg);
+		writel(data, dmac->dmac_base + reg);
 }
 
 static u32 rcar_dmac_read(struct rcar_dmac *dmac, u32 reg)
 {
 	if (reg == RCAR_DMAOR)
-		return readw(dmac->iomem + reg);
+		return readw(dmac->dmac_base + reg);
 	else
-		return readl(dmac->iomem + reg);
+		return readl(dmac->dmac_base + reg);
 }
 
 static u32 rcar_dmac_chan_read(struct rcar_dmac_chan *chan, u32 reg)
@@ -339,12 +344,23 @@ static void rcar_dmac_chan_write(struct rcar_dmac_chan *chan, u32 reg, u32 data)
 static void rcar_dmac_chan_clear(struct rcar_dmac *dmac,
 				 struct rcar_dmac_chan *chan)
 {
-	rcar_dmac_write(dmac, RCAR_DMACHCLR, BIT(chan->index));
+	if (dmac->chan_base)
+		rcar_dmac_chan_write(chan, RCAR_V3U_DMACHCLR, 1);
+	else
+		rcar_dmac_write(dmac, RCAR_DMACHCLR, BIT(chan->index));
 }
 
 static void rcar_dmac_chan_clear_all(struct rcar_dmac *dmac)
 {
-	rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
+	struct rcar_dmac_chan *chan;
+	unsigned int i;
+
+	if (dmac->chan_base) {
+		for_each_rcar_dmac_chan(i, dmac, chan)
+			rcar_dmac_chan_write(chan, RCAR_V3U_DMACHCLR, 1);
+	} else {
+		rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
+	}
 }
 
 /* -----------------------------------------------------------------------------
@@ -1743,9 +1759,7 @@ static const struct dev_pm_ops rcar_dmac_pm = {
  */
 
 static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
-				struct rcar_dmac_chan *rchan,
-				const struct rcar_dmac_of_data *data,
-				unsigned int index)
+				struct rcar_dmac_chan *rchan)
 {
 	struct platform_device *pdev = to_platform_device(dmac->dev);
 	struct dma_chan *chan = &rchan->chan;
@@ -1753,9 +1767,6 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 	char *irqname;
 	int ret;
 
-	rchan->index = index;
-	rchan->iomem = dmac->iomem + data->chan_offset_base +
-		       data->chan_offset_stride * index;
 	rchan->mid_rid = -EINVAL;
 
 	spin_lock_init(&rchan->lock);
@@ -1767,13 +1778,13 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 	INIT_LIST_HEAD(&rchan->desc.wait);
 
 	/* Request the channel interrupt. */
-	sprintf(pdev_irqname, "ch%u", index);
+	sprintf(pdev_irqname, "ch%u", rchan->index);
 	rchan->irq = platform_get_irq_byname(pdev, pdev_irqname);
 	if (rchan->irq < 0)
 		return -ENODEV;
 
 	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
-				 dev_name(dmac->dev), index);
+				 dev_name(dmac->dev), rchan->index);
 	if (!irqname)
 		return -ENOMEM;
 
@@ -1842,6 +1853,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	const struct rcar_dmac_of_data *data;
 	struct rcar_dmac_chan *chan;
 	struct dma_device *engine;
+	void __iomem *chan_base;
 	struct rcar_dmac *dmac;
 	unsigned int i;
 	int ret;
@@ -1880,9 +1892,24 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Request resources. */
-	dmac->iomem = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(dmac->iomem))
-		return PTR_ERR(dmac->iomem);
+	dmac->dmac_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dmac->dmac_base))
+		return PTR_ERR(dmac->dmac_base);
+
+	if (!data->chan_offset_base) {
+		dmac->chan_base = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(dmac->chan_base))
+			return PTR_ERR(dmac->chan_base);
+
+		chan_base = dmac->chan_base;
+	} else {
+		chan_base = dmac->dmac_base + data->chan_offset_base;
+	}
+
+	for_each_rcar_dmac_chan(i, dmac, chan) {
+		chan->index = i;
+		chan->iomem = chan_base + i * data->chan_offset_stride;
+	}
 
 	/* Enable runtime PM and initialize the device. */
 	pm_runtime_enable(&pdev->dev);
@@ -1929,7 +1956,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&engine->channels);
 
 	for_each_rcar_dmac_chan(i, dmac, chan) {
-		ret = rcar_dmac_chan_probe(dmac, chan, data, i);
+		ret = rcar_dmac_chan_probe(dmac, chan);
 		if (ret < 0)
 			goto error;
 	}
@@ -1977,14 +2004,22 @@ static void rcar_dmac_shutdown(struct platform_device *pdev)
 }
 
 static const struct rcar_dmac_of_data rcar_dmac_data = {
-	.chan_offset_base = 0x8000,
-	.chan_offset_stride = 0x80,
+	.chan_offset_base	= 0x8000,
+	.chan_offset_stride	= 0x80,
+};
+
+static const struct rcar_dmac_of_data rcar_v3u_dmac_data = {
+	.chan_offset_base	= 0x0,
+	.chan_offset_stride	= 0x1000,
 };
 
 static const struct of_device_id rcar_dmac_of_ids[] = {
 	{
 		.compatible = "renesas,rcar-dmac",
 		.data = &rcar_dmac_data,
+	}, {
+		.compatible = "renesas,dmac-r8a779a0",
+		.data = &rcar_v3u_dmac_data,
 	},
 	{ /* Sentinel */ }
 };
-- 
2.25.1

