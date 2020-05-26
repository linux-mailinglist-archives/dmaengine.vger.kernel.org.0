Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512AC1E332D
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2020 00:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392264AbgEZWw2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 May 2020 18:52:28 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60272 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404570AbgEZWvp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 May 2020 18:51:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 64E5C8030877;
        Tue, 26 May 2020 22:51:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g1jr_e4QOzSc; Wed, 27 May 2020 01:51:40 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 04/10] dmaengine: Introduce max SG list entries capability
Date:   Wed, 27 May 2020 01:50:15 +0300
Message-ID: <20200526225022.20405-5-Sergey.Semin@baikalelectronics.ru>
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

Some devices may lack the support of the hardware accelerated SG list
entries automatic walking through and execution. In this case a burden of
the SG list traversal and DMA engine re-initialization lies on the
DMA engine driver (normally implemented by using a DMA transfer completion
IRQ to recharge the DMA device with a next SG list entry). But such
solution may not be suitable for some DMA consumers. In particular SPI
devices need both Tx and Rx DMA channels work synchronously in order
to avoid the Rx FIFO overflow. In case if Rx DMA channel is paused for
some time while the Tx DMA channel works implicitly pulling data into the
Rx FIFO, the later will be eventually overflown, which will cause the data
loss. So if SG list entries aren't automatically fetched by the DMA
engine, but are one-by-one manually selected for execution in the
ISRs/deferred work/etc., such problem will eventually happen due to the
non-deterministic latencies of the service execution.

In order to let the DMA consumer know about the DMA device capabilities
regarding the hardware accelerated SG list traversal we introduce the
max_sg_list capability. It is supposed to be initialized by the DMA engine
driver with 0 if there is no limitation for the number of SG entries
atomically executed and with non-zero value if there is such constraints,
so the upper limit is determined by the number set to the property.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v3:
- This is a new patch created as a result of the discussion with Vinud and
  Andy in the framework of DW DMA burst and LLP capabilities.
---
 drivers/dma/dmaengine.c   | 1 +
 include/linux/dmaengine.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index b332ffe52780..ad56ad58932c 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -592,6 +592,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->directions = device->directions;
 	caps->min_burst = device->min_burst;
 	caps->max_burst = device->max_burst;
+	caps->max_sg_nents = device->max_sg_nents;
 	caps->residue_granularity = device->residue_granularity;
 	caps->descriptor_reuse = device->descriptor_reuse;
 	caps->cmd_pause = !!device->device_pause;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 0c7403b27133..6801200c76b6 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -467,6 +467,9 @@ enum dma_residue_granularity {
  *	should be checked by controller as well
  * @min_burst: min burst capability per-transfer
  * @max_burst: max burst capability per-transfer
+ * @max_sg_nents: max number of SG list entries executed in a single atomic
+ *	DMA tansaction with no intermediate IRQ for reinitialization. Zero
+ *	value means unlimited number if entries.
  * @cmd_pause: true, if pause is supported (i.e. for reading residue or
  *	       for resume later)
  * @cmd_resume: true, if resume is supported
@@ -481,6 +484,7 @@ struct dma_slave_caps {
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;
+	u32 max_sg_nents;
 	bool cmd_pause;
 	bool cmd_resume;
 	bool cmd_terminate;
@@ -773,6 +777,9 @@ struct dma_filter {
  *	should be checked by controller as well
  * @min_burst: min burst capability per-transfer
  * @max_burst: max burst capability per-transfer
+ * @max_sg_nents: max number of SG list entries executed in a single atomic
+ *	DMA tansaction with no intermediate IRQ for reinitialization. Zero
+ *	value means unlimited number if entries.
  * @residue_granularity: granularity of the transfer residue reported
  *	by tx_status
  * @device_alloc_chan_resources: allocate resources and return the
@@ -844,6 +851,7 @@ struct dma_device {
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;
+	u32 max_sg_nents;
 	bool descriptor_reuse;
 	enum dma_residue_granularity residue_granularity;
 
-- 
2.26.2

