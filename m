Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116BE234BEF
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jul 2020 22:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGaUIx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jul 2020 16:08:53 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:33470 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgGaUIp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jul 2020 16:08:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6B1428040A6B;
        Fri, 31 Jul 2020 20:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F02ocnSSBzsJ; Fri, 31 Jul 2020 23:08:41 +0300 (MSK)
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
Subject: [PATCH v2 4/5] dmaengine: dw: Ignore burst setting for memory peripherals
Date:   Fri, 31 Jul 2020 23:08:25 +0300
Message-ID: <20200731200826.9292-5-Sergey.Semin@baikalelectronics.ru>
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

According to the DW DMA controller Databook 2.18b (page 40 "3.5 Memory
Peripherals") memory peripherals don't have handshaking interface
connected to the controller, therefore they can never be a flow
controller. Since the CTLx.SRC_MSIZE and CTLx.DEST_MSIZE are properties
valid only for peripherals with a handshaking interface, we can freely
zero these fields out if the memory peripheral is selected to be the
source or the destination of the DMA transfers.

Note according to the databook, length of burst transfers to memory is
always equal to the number of data items available in a channel FIFO or
data items required to complete the block transfer, whichever is smaller;
length of burst transfers from memory is always equal to the space
available in a channel FIFO or number of data items required to complete
the block transfer, whichever is smaller.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Add Databook version to the commit log.
---
 drivers/dma/dw/dw.c     | 5 ++---
 drivers/dma/dw/idma32.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw/dw.c b/drivers/dma/dw/dw.c
index d9810980920a..a4862263ff14 100644
--- a/drivers/dma/dw/dw.c
+++ b/drivers/dma/dw/dw.c
@@ -67,9 +67,8 @@ static size_t dw_dma_block2bytes(struct dw_dma_chan *dwc, u32 block, u32 width)
 static u32 dw_dma_prepare_ctllo(struct dw_dma_chan *dwc)
 {
 	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
-	bool is_slave = is_slave_direction(dwc->direction);
-	u8 smsize = is_slave ? sconfig->src_maxburst : DW_DMA_MSIZE_16;
-	u8 dmsize = is_slave ? sconfig->dst_maxburst : DW_DMA_MSIZE_16;
+	u8 smsize = (dwc->direction == DMA_DEV_TO_MEM) ? sconfig->src_maxburst : 0;
+	u8 dmsize = (dwc->direction == DMA_MEM_TO_DEV) ? sconfig->dst_maxburst : 0;
 	u8 p_master = dwc->dws.p_master;
 	u8 m_master = dwc->dws.m_master;
 	u8 dms = (dwc->direction == DMA_MEM_TO_DEV) ? p_master : m_master;
diff --git a/drivers/dma/dw/idma32.c b/drivers/dma/dw/idma32.c
index f00657308811..3ce44de25d33 100644
--- a/drivers/dma/dw/idma32.c
+++ b/drivers/dma/dw/idma32.c
@@ -73,9 +73,8 @@ static size_t idma32_block2bytes(struct dw_dma_chan *dwc, u32 block, u32 width)
 static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
 {
 	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
-	bool is_slave = is_slave_direction(dwc->direction);
-	u8 smsize = is_slave ? sconfig->src_maxburst : IDMA32_MSIZE_8;
-	u8 dmsize = is_slave ? sconfig->dst_maxburst : IDMA32_MSIZE_8;
+	u8 smsize = (dwc->direction == DMA_DEV_TO_MEM) ? sconfig->src_maxburst : 0;
+	u8 dmsize = (dwc->direction == DMA_MEM_TO_DEV) ? sconfig->dst_maxburst : 0;
 
 	return DWC_CTLL_LLP_D_EN | DWC_CTLL_LLP_S_EN |
 	       DWC_CTLL_DST_MSIZE(dmsize) | DWC_CTLL_SRC_MSIZE(smsize);
-- 
2.27.0

