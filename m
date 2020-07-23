Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9A22A40D
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jul 2020 02:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbgGWA7M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 20:59:12 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60952 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387460AbgGWA67 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jul 2020 20:58:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A650F8040A6B;
        Thu, 23 Jul 2020 00:58:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q6Z3brlXoORE; Thu, 23 Jul 2020 03:58:53 +0300 (MSK)
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
Subject: [PATCH v8 04/10] dmaengine: Introduce max SG burst capability
Date:   Thu, 23 Jul 2020 03:58:42 +0300
Message-ID: <20200723005848.31907-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200723005848.31907-1-Sergey.Semin@baikalelectronics.ru>
References: <20200723005848.31907-1-Sergey.Semin@baikalelectronics.ru>
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
max_sg_burst capability. It is supposed to be initialized by the DMA engine
driver with 0 if there is no limitation of the number of SG entries
atomically executed and with non-zero value if there is such constraints,
so the upper limit is determined by the number set to the property.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---

Changelog v3:
- This is a new patch created as a result of the discussion with Vinud and
  Andy in the framework of DW DMA burst and LLP capabilities.

Changelog v4:
- Fix of->if typo. It should be definitely of.

Changelog v8:
- Replace max_sg_nents with max_sg_burst.
---
 drivers/dma/dmaengine.c   | 1 +
 include/linux/dmaengine.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2f1a7c0c5446..8177f78faeda 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -594,6 +594,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->directions = device->directions;
 	caps->min_burst = device->min_burst;
 	caps->max_burst = device->max_burst;
+	caps->max_sg_burst = device->max_sg_burst;
 	caps->residue_granularity = device->residue_granularity;
 	caps->descriptor_reuse = device->descriptor_reuse;
 	caps->cmd_pause = !!device->device_pause;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 669833c15dfc..c7e76e0ab7e1 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -467,6 +467,9 @@ enum dma_residue_granularity {
  *	should be checked by controller as well
  * @min_burst: min burst capability per-transfer
  * @max_burst: max burst capability per-transfer
+ * @max_sg_burst: max number of SG list entries executed in a single burst
+ *	DMA tansaction with no software intervention for reinitialization.
+ *	Zero value means unlimited number of entries.
  * @cmd_pause: true, if pause is supported (i.e. for reading residue or
  *	       for resume later)
  * @cmd_resume: true, if resume is supported
@@ -481,6 +484,7 @@ struct dma_slave_caps {
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;
+	u32 max_sg_burst;
 	bool cmd_pause;
 	bool cmd_resume;
 	bool cmd_terminate;
@@ -773,6 +777,9 @@ struct dma_filter {
  *	should be checked by controller as well
  * @min_burst: min burst capability per-transfer
  * @max_burst: max burst capability per-transfer
+ * @max_sg_burst: max number of SG list entries executed in a single burst
+ *	DMA tansaction with no software intervention for reinitialization.
+ *	Zero value means unlimited number of entries.
  * @residue_granularity: granularity of the transfer residue reported
  *	by tx_status
  * @device_alloc_chan_resources: allocate resources and return the
@@ -844,6 +851,7 @@ struct dma_device {
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;
+	u32 max_sg_burst;
 	bool descriptor_reuse;
 	enum dma_residue_granularity residue_granularity;
 
-- 
2.26.2

