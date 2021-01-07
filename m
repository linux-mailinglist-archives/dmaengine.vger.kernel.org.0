Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40B62ED692
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jan 2021 19:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbhAGSQt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jan 2021 13:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbhAGSQt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jan 2021 13:16:49 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE83C0612FF
        for <dmaengine@vger.kernel.org>; Thu,  7 Jan 2021 10:15:29 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id DuFT2400C4C55Sk01uFTJ2; Thu, 07 Jan 2021 19:15:27 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxZok-001v2q-Tu; Thu, 07 Jan 2021 19:15:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxZok-008AZ9-Fu; Thu, 07 Jan 2021 19:15:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] dmaengine: rcar-dmac: Add support for R-Car V3U
Date:   Thu,  7 Jan 2021 19:15:24 +0100
Message-Id: <20210107181524.1947173-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107181524.1947173-1-geert+renesas@glider.be>
References: <20210107181524.1947173-1-geert+renesas@glider.be>
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
---
 drivers/dma/sh/rcar-dmac.c | 68 +++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 990d78849a7de704..c11e6255eba1fc6b 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -189,7 +189,7 @@ struct rcar_dmac_chan {
  * struct rcar_dmac - R-Car Gen2 DMA Controller
  * @engine: base DMA engine object
  * @dev: the hardware device
- * @iomem: remapped I/O memory base
+ * @iomem: remapped I/O memory bases (second is optional)
  * @n_channels: number of available channels
  * @channels: array of DMAC channels
  * @channels_mask: bitfield of which DMA channels are managed by this driver
@@ -198,7 +198,7 @@ struct rcar_dmac_chan {
 struct rcar_dmac {
 	struct dma_device engine;
 	struct device *dev;
-	void __iomem *iomem;
+	void __iomem *iomem[2];
 
 	unsigned int n_channels;
 	struct rcar_dmac_chan *channels;
@@ -216,10 +216,12 @@ struct rcar_dmac {
 
 /*
  * struct rcar_dmac_of_data - This driver's OF data
+ * @chan_reg_block: Register block index for DMAC channels
  * @chan_offset_base: DMAC channels base offset
  * @chan_offset_stride: DMAC channels offset stride
  */
 struct rcar_dmac_of_data {
+	unsigned int chan_reg_block;
 	u32 chan_offset_base;
 	u32 chan_offset_stride;
 };
@@ -235,7 +237,7 @@ struct rcar_dmac_of_data {
 #define RCAR_DMAOR_PRI_ROUND_ROBIN	(3 << 8)
 #define RCAR_DMAOR_AE			(1 << 2)
 #define RCAR_DMAOR_DME			(1 << 0)
-#define RCAR_DMACHCLR			0x0080
+#define RCAR_DMACHCLR			0x0080	/* Not on R-Car V3U */
 #define RCAR_DMADPSEC			0x00a0
 
 #define RCAR_DMASAR			0x0000
@@ -298,6 +300,9 @@ struct rcar_dmac_of_data {
 #define RCAR_DMAFIXDAR			0x0014
 #define RCAR_DMAFIXDPBASE		0x0060
 
+/* For R-Car V3U */
+#define RCAR_V3U_DMACHCLR		0x0100
+
 /* Hardcode the MEMCPY transfer size to 4 bytes. */
 #define RCAR_DMAC_MEMCPY_XFER_SIZE	4
 
@@ -308,17 +313,17 @@ struct rcar_dmac_of_data {
 static void rcar_dmac_write(struct rcar_dmac *dmac, u32 reg, u32 data)
 {
 	if (reg == RCAR_DMAOR)
-		writew(data, dmac->iomem + reg);
+		writew(data, dmac->iomem[0] + reg);
 	else
-		writel(data, dmac->iomem + reg);
+		writel(data, dmac->iomem[0] + reg);
 }
 
 static u32 rcar_dmac_read(struct rcar_dmac *dmac, u32 reg)
 {
 	if (reg == RCAR_DMAOR)
-		return readw(dmac->iomem + reg);
+		return readw(dmac->iomem[0] + reg);
 	else
-		return readl(dmac->iomem + reg);
+		return readl(dmac->iomem[0] + reg);
 }
 
 static u32 rcar_dmac_chan_read(struct rcar_dmac_chan *chan, u32 reg)
@@ -340,12 +345,23 @@ static void rcar_dmac_chan_write(struct rcar_dmac_chan *chan, u32 reg, u32 data)
 static void rcar_dmac_chan_clear(struct rcar_dmac *dmac,
 				 struct rcar_dmac_chan *chan)
 {
-	rcar_dmac_write(dmac, RCAR_DMACHCLR, BIT(chan->index));
+	if (dmac->iomem[1])
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
+	if (dmac->iomem[1]) {
+		for_each_rcar_dmac_chan(i, chan, dmac)
+			rcar_dmac_chan_write(chan, RCAR_V3U_DMACHCLR, 1);
+	} else {
+		rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
+	}
 }
 
 /* -----------------------------------------------------------------------------
@@ -1745,7 +1761,6 @@ static const struct dev_pm_ops rcar_dmac_pm = {
 
 static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 				struct rcar_dmac_chan *rchan,
-				const struct rcar_dmac_of_data *data,
 				unsigned int index)
 {
 	struct platform_device *pdev = to_platform_device(dmac->dev);
@@ -1754,9 +1769,6 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 	char *irqname;
 	int ret;
 
-	rchan->index = index;
-	rchan->iomem = dmac->iomem + data->chan_offset_base +
-		       data->chan_offset_stride * index;
 	rchan->mid_rid = -EINVAL;
 
 	spin_lock_init(&rchan->lock);
@@ -1881,9 +1893,17 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Request resources. */
-	dmac->iomem = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(dmac->iomem))
-		return PTR_ERR(dmac->iomem);
+	for (i = 0; i <= data->chan_reg_block; i++) {
+		dmac->iomem[i] = devm_platform_ioremap_resource(pdev, i);
+		if (IS_ERR(dmac->iomem[i]))
+			return PTR_ERR(dmac->iomem[i]);
+	}
+
+	for_each_rcar_dmac_chan(i, chan, dmac) {
+		chan->index = i;
+		chan->iomem = dmac->iomem[data->chan_reg_block] +
+			data->chan_offset_base + i * data->chan_offset_stride;
+	}
 
 	/* Enable runtime PM and initialize the device. */
 	pm_runtime_enable(&pdev->dev);
@@ -1930,7 +1950,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&engine->channels);
 
 	for_each_rcar_dmac_chan(i, chan, dmac) {
-		ret = rcar_dmac_chan_probe(dmac, chan, data, i);
+		ret = rcar_dmac_chan_probe(dmac, chan, i);
 		if (ret < 0)
 			goto error;
 	}
@@ -1978,14 +1998,24 @@ static void rcar_dmac_shutdown(struct platform_device *pdev)
 }
 
 static const struct rcar_dmac_of_data rcar_dmac_data = {
-	.chan_offset_base = 0x8000,
-	.chan_offset_stride = 0x80,
+	.chan_reg_block		= 0,
+	.chan_offset_base	= 0x8000,
+	.chan_offset_stride	= 0x80,
+};
+
+static const struct rcar_dmac_of_data rcar_v3u_dmac_data = {
+	.chan_reg_block		= 1,
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

