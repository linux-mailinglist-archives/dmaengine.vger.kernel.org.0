Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CC61E6EC6
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 00:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437153AbgE1WYm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 18:24:42 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44694 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437117AbgE1WYS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 18:24:18 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 326178030839;
        Thu, 28 May 2020 22:24:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tZprco_SoX-N; Fri, 29 May 2020 01:24:15 +0300 (MSK)
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
Subject: [PATCH v4 11/11] dmaengine: dw: Initialize max_sg_nents capability
Date:   Fri, 29 May 2020 01:24:01 +0300
Message-ID: <20200528222401.26941-12-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
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
utilized to load and execute each LLP-block one by one. The soft-LLP mode
of the DMA transactions execution might not work well for some DMA
consumers like SPI due to its Tx and Rx buffers inter-dependency. Let's
initialize the max_sg_nents DMA channels capability based on the nollp
flag state. If it's true, no hardware accelerated LLP is available and
max_sg_nents should be set with 1, which means that the DMA engine
can handle only a single SG list entry at a time. If noLLP is set to
false, then hardware accelerated LLP is supported and the DMA engine
can handle infinite number of SG entries in a single DMA transaction.

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

Changelog v4:
- Use explicit if-else statement when assigning the max_sg_nents field.
---
 drivers/dma/dw/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 60ef779fc5e0..b76eee75fde8 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1059,6 +1059,18 @@ static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
 
 	caps->max_burst = dwc->max_burst;
+
+	/*
+	 * It might be crucial for some devices to have the hardware
+	 * accelerated multi-block transfers supported, aka LLPs in DW DMAC
+	 * notation. So if LLPs are supported then max_sg_nents is set to
+	 * zero which means unlimited number of SG entries can be handled in a
+	 * single DMA transaction, otherwise it's just one SG entry.
+	 */
+	if (dwc->nollp)
+		caps->max_sg_nents = 1;
+	else
+		caps->max_sg_nents = 0;
 }
 
 int do_dma_probe(struct dw_dma_chip *chip)
-- 
2.26.2

