Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19699234BE5
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jul 2020 22:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgGaUIm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jul 2020 16:08:42 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:33436 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgGaUIm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jul 2020 16:08:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 153928030808;
        Fri, 31 Jul 2020 20:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fMG0FJN5piFD; Fri, 31 Jul 2020 23:08:40 +0300 (MSK)
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
Subject: [PATCH v2 2/5] dmaengine: dw: Activate FIFO-mode for memory peripherals only
Date:   Fri, 31 Jul 2020 23:08:23 +0300
Message-ID: <20200731200826.9292-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200731200826.9292-1-Sergey.Semin@baikalelectronics.ru>
References: <20200731200826.9292-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

CFGx.FIFO_MODE field controls a DMA-controller "FIFO readiness" criterion.
In other words it determines when to start pushing data out of a DW
DMAC channel FIFO to a destination peripheral or from a source
peripheral to the DW DMAC channel FIFO. Currently FIFO-mode is set to one
for all DW DMAC channels. It means they are tuned to flush data out of
FIFO (to a memory peripheral or by accepting the burst transaction
requests) when FIFO is at least half-full (except at the end of the block
transfer, when FIFO-flush mode is activated) and are configured to get
data to the FIFO when it's at least half-empty.

Such configuration is a good choice when there is no slave device involved
in the DMA transfers. In that case the number of bursts per block is less
than when CFGx.FIFO_MODE = 0 and, hence, the bus utilization will improve.
But the latency of DMA transfers may increase when CFGx.FIFO_MODE = 1,
since DW DMAC will wait for the channel FIFO contents to be either
half-full or half-empty depending on having the destination or the source
transfers. Such latencies might be dangerous in case if the DMA transfers
are expected to be performed from/to a slave device. Since normally
peripheral devices keep data in internal FIFOs, any latency at some
critical moment may cause one being overflown and consequently losing
data. This especially concerns a case when either a peripheral device is
relatively fast or the DW DMAC engine is relatively slow with respect to
the incoming data pace.

In order to solve problems, which might be caused by the latencies
described above, let's enable the FIFO half-full/half-empty "FIFO
readiness" criterion only for DMA transfers with no slave device involved.
Thanks to the commit 99ba8b9b0d97 ("dmaengine: dw: Initialize channel
before each transfer") we can freely do that in the generic
dw_dma_initialize_chan() method.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw/dw.c b/drivers/dma/dw/dw.c
index 7a085b3c1854..d9810980920a 100644
--- a/drivers/dma/dw/dw.c
+++ b/drivers/dma/dw/dw.c
@@ -14,7 +14,7 @@
 static void dw_dma_initialize_chan(struct dw_dma_chan *dwc)
 {
 	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
-	u32 cfghi = DWC_CFGH_FIFO_MODE;
+	u32 cfghi = is_slave_direction(dwc->direction) ? 0 : DWC_CFGH_FIFO_MODE;
 	u32 cfglo = DWC_CFGL_CH_PRIOR(dwc->priority);
 	bool hs_polarity = dwc->dws.hs_polarity;
 
-- 
2.27.0

