Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9191CA8B2
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2020 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgEHKx3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 May 2020 06:53:29 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41774 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgEHKx2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 May 2020 06:53:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 0868080307C2;
        Fri,  8 May 2020 10:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2IanKEQvf44Q; Fri,  8 May 2020 13:53:21 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] dmaengine: dw: Set DMA device max segment size parameter
Date:   Fri, 8 May 2020 13:53:01 +0300
Message-ID: <20200508105304.14065-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Maximum block size DW DMAC configuration corresponds to the max segment
size DMA parameter in the DMA core subsystem notation. Lets set it with a
value specific to the probed DW DMA controller. It shall help the DMA
clients to create size-optimized SG-list items for the controller. This in
turn will cause less dw_desc allocations, less LLP reinitializations,
better DMA device performance.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v2:
- This is a new patch created in place of the dropped one:
  "dmaengine: dw: Add LLP and block size config accessors".
---
 drivers/dma/dw/core.c | 17 +++++++++++++++++
 drivers/dma/dw/regs.h | 18 ++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 21cb2a58dbd2..8bcd82c64478 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1054,6 +1054,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	struct dw_dma *dw = chip->dw;
 	struct dw_dma_platform_data *pdata;
 	bool			autocfg = false;
+	unsigned int		block_size = 0;
 	unsigned int		dw_params;
 	unsigned int		i;
 	int			err;
@@ -1184,6 +1185,18 @@ int do_dma_probe(struct dw_dma_chip *chip)
 			dwc->block_size = pdata->block_size;
 			dwc->nollp = !pdata->multi_block[i];
 		}
+
+		/*
+		 * Find maximum block size to be set as the DMA device maximum
+		 * segment size. By doing so we'll have size optimized SG-list
+		 * items for the channels with biggest block size. This won't
+		 * be a problem for the rest of the channels, since they will
+		 * still be able to split the requests up by allocating
+		 * multiple DW DMA LLP descriptors, which they would have done
+		 * anyway.
+		 */
+		if (dwc->block_size > block_size)
+			block_size = dwc->block_size;
 	}
 
 	/* Clear all interrupts on all channels. */
@@ -1220,6 +1233,10 @@ int do_dma_probe(struct dw_dma_chip *chip)
 			     BIT(DMA_MEM_TO_MEM);
 	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
+	/* Block size corresponds to the maximum sg size */
+	dw->dma.dev->dma_parms = &dw->dma_parms;
+	dma_set_max_seg_size(dw->dma.dev, block_size);
+
 	err = dma_async_device_register(&dw->dma);
 	if (err)
 		goto err_dma_register;
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index 3fce66ecee7a..20037d64f961 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/dmaengine.h>
 
@@ -308,16 +309,17 @@ static inline struct dw_dma_chan *to_dw_dma_chan(struct dma_chan *chan)
 }
 
 struct dw_dma {
-	struct dma_device	dma;
-	char			name[20];
-	void __iomem		*regs;
-	struct dma_pool		*desc_pool;
-	struct tasklet_struct	tasklet;
+	struct dma_device		dma;
+	struct device_dma_parameters	dma_parms;
+	char				name[20];
+	void __iomem			*regs;
+	struct dma_pool			*desc_pool;
+	struct tasklet_struct		tasklet;
 
 	/* channels */
-	struct dw_dma_chan	*chan;
-	u8			all_chan_mask;
-	u8			in_use;
+	struct dw_dma_chan		*chan;
+	u8				all_chan_mask;
+	u8				in_use;
 
 	/* Channel operations */
 	void	(*initialize_chan)(struct dw_dma_chan *dwc);
-- 
2.25.1

