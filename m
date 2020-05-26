Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B321E3312
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2020 00:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404649AbgEZWvx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 May 2020 18:51:53 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60354 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404604AbgEZWvx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 May 2020 18:51:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 536928030878;
        Tue, 26 May 2020 22:51:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 20x-cQrO6NKb; Wed, 27 May 2020 01:51:44 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 09/10] dmaengine: dw: Introduce max burst length hw config
Date:   Wed, 27 May 2020 01:50:20 +0300
Message-ID: <20200526225022.20405-10-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

IP core of the DW DMA controller may be synthesized with different
max burst length of the transfers per each channel. According to Synopsis
having the fixed maximum burst transactions length may provide some
performance gain. At the same time setting up the source and destination
multi size exceeding the max burst length limitation may cause a serious
problems. In our case the DMA transaction just hangs up. In order to fix
this lets introduce the max burst length platform config of the DW DMA
controller device and don't let the DMA channels configuration code
exceed the burst length hardware limitation.

Note the maximum burst length parameter can be detected either in runtime
from the DWC parameter registers or from the dedicated DT property.
Depending on the IP core configuration the maximum value can vary from
channel to channel so by overriding the channel slave max_burst capability
we make sure a DMA consumer will get the channel-specific max burst
length.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v2:
- Rearrange SoBs.
- Discard dwc_get_maxburst() accessor. It's enough to have a clamping
  guard against exceeding the hardware max burst limitation.

Changelog v3:
- Override the slave channel max_burst capability instead of calculating
  the minimum value of max burst lengths and setting the DMA-device
  generic capability.
---
 drivers/dma/dw/core.c                | 5 +++++
 drivers/dma/dw/dw.c                  | 1 +
 drivers/dma/dw/of.c                  | 9 +++++++++
 drivers/dma/dw/regs.h                | 2 ++
 include/linux/platform_data/dma-dw.h | 4 ++++
 5 files changed, 21 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index ceded21537e2..29c4ef08311d 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1051,7 +1051,9 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 
 static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 {
+	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
 
+	caps->max_burst = dwc->max_burst;
 }
 
 int do_dma_probe(struct dw_dma_chip *chip)
@@ -1194,9 +1196,12 @@ int do_dma_probe(struct dw_dma_chip *chip)
 			dwc->nollp =
 				(dwc_params >> DWC_PARAMS_MBLK_EN & 0x1) == 0 ||
 				(dwc_params >> DWC_PARAMS_HC_LLP & 0x1) == 1;
+			dwc->max_burst =
+				(0x4 << (dwc_params >> DWC_PARAMS_MSIZE & 0x7));
 		} else {
 			dwc->block_size = pdata->block_size;
 			dwc->nollp = !pdata->multi_block[i];
+			dwc->max_burst = pdata->max_burst[i] ?: DW_DMA_MAX_BURST;
 		}
 	}
 
diff --git a/drivers/dma/dw/dw.c b/drivers/dma/dw/dw.c
index 7a085b3c1854..4d6b1ecabda4 100644
--- a/drivers/dma/dw/dw.c
+++ b/drivers/dma/dw/dw.c
@@ -86,6 +86,7 @@ static void dw_dma_encode_maxburst(struct dw_dma_chan *dwc, u32 *maxburst)
 	 * Fix burst size according to dw_dmac. We need to convert them as:
 	 * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
 	 */
+	*maxburst = clamp(*maxburst, 0U, dwc->max_burst);
 	*maxburst = *maxburst > 1 ? fls(*maxburst) - 2 : 0;
 }
 
diff --git a/drivers/dma/dw/of.c b/drivers/dma/dw/of.c
index 9e27831dee32..d7323aad7cb5 100644
--- a/drivers/dma/dw/of.c
+++ b/drivers/dma/dw/of.c
@@ -98,6 +98,15 @@ struct dw_dma_platform_data *dw_dma_parse_dt(struct platform_device *pdev)
 			pdata->multi_block[tmp] = 1;
 	}
 
+	if (!of_property_read_u32_array(np, "snps,max-burst-len", mb,
+					nr_channels)) {
+		for (tmp = 0; tmp < nr_channels; tmp++)
+			pdata->max_burst[tmp] = mb[tmp];
+	} else {
+		for (tmp = 0; tmp < nr_channels; tmp++)
+			pdata->max_burst[tmp] = DW_DMA_MAX_BURST;
+	}
+
 	if (!of_property_read_u32(np, "snps,dma-protection-control", &tmp)) {
 		if (tmp > CHAN_PROTCTL_MASK)
 			return NULL;
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index 1ab840b06e79..76654bd13c1a 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -126,6 +126,7 @@ struct dw_dma_regs {
 /* Bitfields in DWC_PARAMS */
 #define DWC_PARAMS_MBLK_EN	11		/* multi block transfer */
 #define DWC_PARAMS_HC_LLP	13		/* set LLP register to zero */
+#define DWC_PARAMS_MSIZE	16		/* max group transaction size */
 
 /* bursts size */
 enum dw_dma_msize {
@@ -284,6 +285,7 @@ struct dw_dma_chan {
 	/* hardware configuration */
 	unsigned int		block_size;
 	bool			nollp;
+	u32			max_burst;
 
 	/* custom slave configuration */
 	struct dw_dma_slave	dws;
diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
index f3eaf9ec00a1..13e679afc0e0 100644
--- a/include/linux/platform_data/dma-dw.h
+++ b/include/linux/platform_data/dma-dw.h
@@ -12,6 +12,7 @@
 
 #define DW_DMA_MAX_NR_MASTERS	4
 #define DW_DMA_MAX_NR_CHANNELS	8
+#define DW_DMA_MAX_BURST	256
 
 /**
  * struct dw_dma_slave - Controller-specific information about a slave
@@ -42,6 +43,8 @@ struct dw_dma_slave {
  * @data_width: Maximum data width supported by hardware per AHB master
  *		(in bytes, power of 2)
  * @multi_block: Multi block transfers supported by hardware per channel.
+ * @max_burst: Maximum value of burst transaction size supported by hardware
+ *	       per channel (in units of CTL.SRC_TR_WIDTH/CTL.DST_TR_WIDTH).
  * @protctl: Protection control signals setting per channel.
  */
 struct dw_dma_platform_data {
@@ -56,6 +59,7 @@ struct dw_dma_platform_data {
 	unsigned char	nr_masters;
 	unsigned char	data_width[DW_DMA_MAX_NR_MASTERS];
 	unsigned char	multi_block[DW_DMA_MAX_NR_CHANNELS];
+	unsigned int	max_burst[DW_DMA_MAX_NR_CHANNELS];
 #define CHAN_PROTCTL_PRIVILEGED		BIT(0)
 #define CHAN_PROTCTL_BUFFERABLE		BIT(1)
 #define CHAN_PROTCTL_CACHEABLE		BIT(2)
-- 
2.26.2

