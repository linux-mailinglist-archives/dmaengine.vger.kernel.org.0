Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A5C1E330F
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2020 00:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404585AbgEZWvw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 May 2020 18:51:52 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60366 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404608AbgEZWvt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 May 2020 18:51:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id CEECE8030879;
        Tue, 26 May 2020 22:51:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zWst2UV7r8ga; Wed, 27 May 2020 01:51:45 +0300 (MSK)
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
Subject: [PATCH v3 10/10] dmaengine: dw: Initialize max_sg_nents with nollp flag
Date:   Wed, 27 May 2020 01:50:21 +0300
Message-ID: <20200526225022.20405-11-Sergey.Semin@baikalelectronics.ru>
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

Multi-block support provides a way to map the kernel-specific SG-table so
the DW DMA device would handle it as a whole instead of handling the
SG-list items or so called LLP block items one by one. So if true LLP
list isn't supported by the DW DMA engine, then soft-LLP mode will be
utilized to load and execute each LLP-block one by one. The soft-LLP mode
of the DMA transactions execution might not work well for some DMA
consumers like SPI due to its Tx and Rx buffers inter-dependency. Let's
expose the nollp flag indicating the soft-LLP mode by means of the
max_sg_nents capability, so the DMA consumer would be ready to somehow
workaround errors caused by such mode being utilized.

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
 drivers/dma/dw/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 29c4ef08311d..b850eb7fd084 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1054,6 +1054,15 @@ static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
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
+	caps->max_sg_nents = dwc->nollp;
 }
 
 int do_dma_probe(struct dw_dma_chip *chip)
-- 
2.26.2

