Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8EF234BF2
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jul 2020 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGaUIo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jul 2020 16:08:44 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:33454 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgGaUIn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jul 2020 16:08:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B12D08040A69;
        Fri, 31 Jul 2020 20:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GKT3SX5obPrY; Fri, 31 Jul 2020 23:08:41 +0300 (MSK)
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
Subject: [PATCH v2 3/5] dmaengine: dw: Discard dlen from the dev-to-mem xfer width calculation
Date:   Fri, 31 Jul 2020 23:08:24 +0300
Message-ID: <20200731200826.9292-4-Sergey.Semin@baikalelectronics.ru>
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

Indeed in case of the DMA_DEV_TO_MEM DMA transfers it's enough to take the
destination memory address and the destination master data width into
account to calculate the CTLx.DST_TR_WIDTH setting of the memory
peripheral. According to the DW DMAC IP-core Databook 2.18b (page 66,
Example 5) at the and of a DMA transfer when the DMA-channel internal FIFO
is left with data less than for a single destination burst transaction,
the destination peripheral will enter the Single Transaction Region where
the DW DMA controller can complete a block transfer to the destination
using single transactions (non-burst transaction of CTLx.DST_TR_WIDTH
bytes). If there is no enough data in the DMA-channel internal FIFO for
even a single non-burst transaction of CTLx.DST_TR_WIDTH bytes, then the
channel enters "FIFO flush mode". That mode is activated to empty the FIFO
and flush the leftovers out to the memory peripheral. The flushing
procedure is simple.  The data is sent to the memory by means of a set of
single transaction of CTLx.SRC_TR_WIDTH bytes. To sum up it's redundant to
use the LLPs length to find out the CTLx.DST_TR_WIDTH parameter value,
since each DMA transfer will be completed with the CTLx.SRC_TR_WIDTH bytes
transaction if it is required.

We suggest to remove the LLP entry length from the statement which
calculates the memory peripheral DMA transaction width since it's
redundant due to the feature described above. By doing so we'll improve
the memory bus utilization and speed up the DMA-channel performance for
DMA_DEV_TO_MEM DMA-transfers.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---

Changelog v2:
- Add Databook version to the commit log.
---
 drivers/dma/dw/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 4700f2e87a62..3da0aea9fe25 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -723,7 +723,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			lli_write(desc, sar, reg);
 			lli_write(desc, dar, mem);
 			lli_write(desc, ctlhi, ctlhi);
-			mem_width = __ffs(data_width | mem | dlen);
+			mem_width = __ffs(data_width | mem);
 			lli_write(desc, ctllo, ctllo | DWC_CTLL_DST_WIDTH(mem_width));
 			desc->len = dlen;
 
-- 
2.27.0

