Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3292C1FD9DD
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2020 01:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgFQXle (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jun 2020 19:41:34 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57884 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFQXkr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 Jun 2020 19:40:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 065938040A6A;
        Wed, 17 Jun 2020 23:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xid-sN17JxPT; Thu, 18 Jun 2020 02:40:42 +0300 (MSK)
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
Subject: [PATCH v6 6/9] dmaengine: dw: Set DMA device max segment size parameter
Date:   Thu, 18 Jun 2020 02:40:25 +0300
Message-ID: <20200617234028.25808-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200617234028.25808-1-Sergey.Semin@baikalelectronics.ru>
References: <20200617234028.25808-1-Sergey.Semin@baikalelectronics.ru>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org

---

Changelog v2:
- This is a new patch created in place of the dropped one:
  "dmaengine: dw: Add LLP and block size config accessors".

Changelog v3:
- Use the block_size found for the very first channel instead of looking for
  the maximum of maximum block sizes.
- Don't define device-specific device_dma_parameters object, since it has
  already been defined by the platform device core.
---
 drivers/dma/dw/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 33e99d95b3d3..fb95920c429e 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1229,6 +1229,13 @@ int do_dma_probe(struct dw_dma_chip *chip)
 			     BIT(DMA_MEM_TO_MEM);
 	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
+	/*
+	 * For now there is no hardware with non uniform maximum block size
+	 * across all of the device channels, so we set the maximum segment
+	 * size as the block size found for the very first channel.
+	 */
+	dma_set_max_seg_size(dw->dma.dev, dw->chan[0].block_size);
+
 	err = dma_async_device_register(&dw->dma);
 	if (err)
 		goto err_dma_register;
-- 
2.26.2

