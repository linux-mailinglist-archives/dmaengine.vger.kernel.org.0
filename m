Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A27C1E8089
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 16:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgE2OlM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 10:41:12 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:48958 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgE2OlL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 May 2020 10:41:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1A7A98029EA3;
        Fri, 29 May 2020 14:41:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VioAOvQ-z7cs; Fri, 29 May 2020 17:41:05 +0300 (MSK)
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
Subject: [PATCH v5 10/11] dmaengine: dw: Introduce max burst length hw config
Date:   Fri, 29 May 2020 17:40:53 +0300
Message-ID: <20200529144054.4251-11-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200529144054.4251-1-Sergey.Semin@baikalelectronics.ru>
References: <20200529144054.4251-1-Sergey.Semin@baikalelectronics.ru>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Changelog v5:
- Clamp the dst and src burst lengths in the generic dwc_config() method
  instead of doing that in the encode_maxburst() callback.
- Define max_burst with u32 type in struct dw_dma_platform_data.
- Perform of_property_read_u32_array() directly into the platform data
  max_burst member.

Changelog v6:
- Move DW_DMA_MAX_BURST macro definition to the previous patch.
---
 drivers/dma/dw/core.c                | 10 ++++++++++
 drivers/dma/dw/of.c                  |  5 +++++
 drivers/dma/dw/regs.h                |  2 ++
 include/linux/platform_data/dma-dw.h |  3 +++
 4 files changed, 20 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 4887aa2fc73c..588b9bae827c 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -791,6 +791,11 @@ static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 
 	memcpy(&dwc->dma_sconfig, sconfig, sizeof(*sconfig));
 
+	dwc->dma_sconfig.src_maxburst =
+		clamp(dwc->dma_sconfig.src_maxburst, 0U, dwc->max_burst);
+	dwc->dma_sconfig.dst_maxburst =
+		clamp(dwc->dma_sconfig.dst_maxburst, 0U, dwc->max_burst);
+
 	dw->encode_maxburst(dwc, &dwc->dma_sconfig.src_maxburst);
 	dw->encode_maxburst(dwc, &dwc->dma_sconfig.dst_maxburst);
 
@@ -1051,7 +1056,9 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 
 static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 {
+	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
 
+	caps->max_burst = dwc->max_burst;
 }
 
 int do_dma_probe(struct dw_dma_chip *chip)
@@ -1194,9 +1201,12 @@ int do_dma_probe(struct dw_dma_chip *chip)
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
 
diff --git a/drivers/dma/dw/of.c b/drivers/dma/dw/of.c
index 9e27831dee32..1474b3817ef4 100644
--- a/drivers/dma/dw/of.c
+++ b/drivers/dma/dw/of.c
@@ -98,6 +98,11 @@ struct dw_dma_platform_data *dw_dma_parse_dt(struct platform_device *pdev)
 			pdata->multi_block[tmp] = 1;
 	}
 
+	if (of_property_read_u32_array(np, "snps,max-burst-len", pdata->max_burst,
+				       nr_channels)) {
+		memset32(pdata->max_burst, DW_DMA_MAX_BURST, nr_channels);
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
index 369e41e9dcc9..4f681df85c27 100644
--- a/include/linux/platform_data/dma-dw.h
+++ b/include/linux/platform_data/dma-dw.h
@@ -44,6 +44,8 @@ struct dw_dma_slave {
  * @data_width: Maximum data width supported by hardware per AHB master
  *		(in bytes, power of 2)
  * @multi_block: Multi block transfers supported by hardware per channel.
+ * @max_burst: Maximum value of burst transaction size supported by hardware
+ *	       per channel (in units of CTL.SRC_TR_WIDTH/CTL.DST_TR_WIDTH).
  * @protctl: Protection control signals setting per channel.
  */
 struct dw_dma_platform_data {
@@ -58,6 +60,7 @@ struct dw_dma_platform_data {
 	unsigned char	nr_masters;
 	unsigned char	data_width[DW_DMA_MAX_NR_MASTERS];
 	unsigned char	multi_block[DW_DMA_MAX_NR_CHANNELS];
+	u32		max_burst[DW_DMA_MAX_NR_CHANNELS];
 #define CHAN_PROTCTL_PRIVILEGED		BIT(0)
 #define CHAN_PROTCTL_BUFFERABLE		BIT(1)
 #define CHAN_PROTCTL_CACHEABLE		BIT(2)
-- 
2.26.2

