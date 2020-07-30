Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F822335E7
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jul 2020 17:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgG3PqB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jul 2020 11:46:01 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57422 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbgG3PqA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jul 2020 11:46:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 314A480045E5;
        Thu, 30 Jul 2020 15:45:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aBeM2cVMX9sW; Thu, 30 Jul 2020 18:45:55 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] dmaengine: dw: Add DMA-channels mask cell support
Date:   Thu, 30 Jul 2020 18:45:45 +0300
Message-ID: <20200730154545.3965-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
References: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DW DMA IP-core provides a way to synthesize the DMA controller with
channels having different parameters like maximum burst-length,
multi-block support, maximum data width, etc. Those parameters both
explicitly and implicitly affect the channels performance. Since DMA slave
devices might be very demanding to the DMA performance, let's provide a
functionality for the slaves to be assigned with DW DMA channels, which
performance according to the platform engineer fulfill their requirements.
After this patch is applied it can be done by passing the mask of suitable
DMA-channels either directly in the dw_dma_slave structure instance or as
a fifth cell of the DMA DT-property. If mask is zero or not provided, then
there is no limitation on the channels allocation.

For instance Baikal-T1 SoC is equipped with a DW DMAC engine, which first
two channels are synthesized with max burst length of 16, while the rest
of the channels have been created with max-burst-len=4. It would seem that
the first two channels must be faster than the others and should be more
preferable for the time-critical DMA slave devices. In practice it turned
out that the situation is quite the opposite. The channels with
max-burst-len=4 demonstrated a better performance than the channels with
max-burst-len=16 even when they both had been initialized with the same
settings. The performance drop of the first two DMA-channels made them
unsuitable for the DW APB SSI slave device. No matter what settings they
are configured with, full-duplex SPI transfers occasionally experience the
Rx FIFO overflow. It means that the DMA-engine doesn't keep up with
incoming data pace even though the SPI-bus is enabled with speed of 25MHz
while the DW DMA controller is clocked with 50MHz signal. There is no such
problem has been noticed for the channels synthesized with
max-burst-len=4.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/dma/dw/core.c                | 4 ++++
 drivers/dma/dw/of.c                  | 7 +++++--
 include/linux/platform_data/dma-dw.h | 3 +++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 3da0aea9fe25..5f7b9badb965 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -772,6 +772,10 @@ bool dw_dma_filter(struct dma_chan *chan, void *param)
 	if (dws->dma_dev != chan->device->dev)
 		return false;
 
+	/* permit channels in accordance with the channels mask */
+	if (dws->channels && !(dws->channels & dwc->mask))
+		return false;
+
 	/* We have to copy data since dws can be temporary storage */
 	memcpy(&dwc->dws, dws, sizeof(struct dw_dma_slave));
 
diff --git a/drivers/dma/dw/of.c b/drivers/dma/dw/of.c
index 1474b3817ef4..abdf22b269b5 100644
--- a/drivers/dma/dw/of.c
+++ b/drivers/dma/dw/of.c
@@ -22,18 +22,21 @@ static struct dma_chan *dw_dma_of_xlate(struct of_phandle_args *dma_spec,
 	};
 	dma_cap_mask_t cap;
 
-	if (dma_spec->args_count != 3)
+	if (dma_spec->args_count < 3 || dma_spec->args_count > 4)
 		return NULL;
 
 	slave.src_id = dma_spec->args[0];
 	slave.dst_id = dma_spec->args[0];
 	slave.m_master = dma_spec->args[1];
 	slave.p_master = dma_spec->args[2];
+	if (dma_spec->args_count >= 4)
+		slave.channels = dma_spec->args[3];
 
 	if (WARN_ON(slave.src_id >= DW_DMA_MAX_NR_REQUESTS ||
 		    slave.dst_id >= DW_DMA_MAX_NR_REQUESTS ||
 		    slave.m_master >= dw->pdata->nr_masters ||
-		    slave.p_master >= dw->pdata->nr_masters))
+		    slave.p_master >= dw->pdata->nr_masters ||
+		    fls(slave.channels) > dw->pdata->nr_channels))
 		return NULL;
 
 	dma_cap_zero(cap);
diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
index 4f681df85c27..3bc48451a70c 100644
--- a/include/linux/platform_data/dma-dw.h
+++ b/include/linux/platform_data/dma-dw.h
@@ -23,6 +23,8 @@
  * @dst_id:	dst request line
  * @m_master:	memory master for transfers on allocated channel
  * @p_master:	peripheral master for transfers on allocated channel
+ * @channels:	mask of the channels permitted for allocation (zero
+ *		value means any)
  * @hs_polarity:set active low polarity of handshake interface
  */
 struct dw_dma_slave {
@@ -31,6 +33,7 @@ struct dw_dma_slave {
 	u8			dst_id;
 	u8			m_master;
 	u8			p_master;
+	u8			channels;
 	bool			hs_polarity;
 };
 
-- 
2.27.0

