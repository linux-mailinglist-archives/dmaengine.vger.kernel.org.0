Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F781CA8B3
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2020 12:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgEHKx3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 May 2020 06:53:29 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41798 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgEHKx2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 May 2020 06:53:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D67D0803078F;
        Fri,  8 May 2020 10:53:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 43gaQWD2vqt6; Fri,  8 May 2020 13:53:23 +0300 (MSK)
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
Subject: [PATCH v2 4/6] dmaengine: dw: Print warning if multi-block is unsupported
Date:   Fri, 8 May 2020 13:53:02 +0300
Message-ID: <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
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

Multi-block support provides a way to map the kernel-specific SG-table so
the DW DMA device would handle it as a whole instead of handling the
SG-list items or so called LLP block items one by one. So if true LLP
list isn't supported by the DW DMA engine, then soft-LLP mode will be
utilized to load and execute each LLP-block one by one. A problem may
happen for multi-block DMA slave transfers, when the slave device buffers
(for example Tx and Rx FIFOs) depend on each other and have size smaller
than the block size. In this case writing data to the DMA slave Tx buffer
may cause the Rx buffer overflow if Rx DMA channel is paused to
reinitialize the DW DMA controller with a next Rx LLP item. In particular
We've discovered this problem in the framework of the DW APB SPI device
working in conjunction with DW DMA. Since there is no comprehensive way to
fix it right now lets at least print a warning for the first found
multi-blockless DW DMAC channel. This shall point a developer to the
possible cause of the problem if one would experience a sudden data loss.

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
- This is a new patch created instead of the dropped one:
  "dmaengine: dw: Add LLP and block size config accessors"
---
 drivers/dma/dw/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 8bcd82c64478..e4749c296fca 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1197,6 +1197,21 @@ int do_dma_probe(struct dw_dma_chip *chip)
 		 */
 		if (dwc->block_size > block_size)
 			block_size = dwc->block_size;
+
+		/*
+		 * It might crucial for some devices to have the hardware
+		 * accelerated multi-block transfers supported. Especially it
+		 * concerns if Tx and Rx DMA slave device buffers somehow
+		 * depend on each other. For instance an SPI controller may
+		 * experience Rx buffer overflow error if Tx DMA channel keeps
+		 * pushing data to the Tx FIFO, while Rx DMA channel is paused
+		 * to initialize the DW DMA controller with a next Rx LLP item.
+		 * Since there is no comprehensive way to fix it right now lets
+		 * at least print a warning that hardware LLPs reloading is
+		 * unsupported.
+		 */
+		if (dwc->nollp)
+			dev_warn_once(chip->dev, "No hardware LLP support\n");
 	}
 
 	/* Clear all interrupts on all channels. */
-- 
2.25.1

