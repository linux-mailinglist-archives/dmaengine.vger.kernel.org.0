Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF222A410
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jul 2020 03:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbgGWA7M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 20:59:12 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60988 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387483AbgGWA67 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jul 2020 20:58:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A06DD8040A69;
        Thu, 23 Jul 2020 00:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VCm0CRaRAYri; Thu, 23 Jul 2020 03:58:56 +0300 (MSK)
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
Subject: [PATCH v8 08/10] dmaengine: dw: Initialize min and max burst DMA device capability
Date:   Thu, 23 Jul 2020 03:58:46 +0300
Message-ID: <20200723005848.31907-9-Sergey.Semin@baikalelectronics.ru>
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

According to the DW APB DMAC data book the minimum burst transaction
length is 1 and it's true for any version of the controller since
isn't parametrised in the coreAssembler so can't be changed at the
IP-core synthesis stage. The maximum burst transaction can vary from
channel to channel and from controller to controller depending on a
IP-core parameter the system engineer activated during the IP-core
synthesis. Let's initialise both min_burst and max_burst members of the
DMA controller descriptor with extreme values so the DMA clients could
use them to properly optimize the DMA requests. The channels and
controller-specific max_burst length initialization will be introduced
by the follow-up patches.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---

Changelog v4:
- This is a new patch suggested by Andy.

Changelog v5:
- Introduce macro with extreme min and max burst length supported by the
  DW DMA controller.
- Initialize max_burst length capability with extreme burst length supported
  by the DW DMAC IP-core.
---
 drivers/dma/dw/core.c                | 2 ++
 include/linux/platform_data/dma-dw.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index fb95920c429e..afe5a2e465af 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1223,6 +1223,8 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_issue_pending = dwc_issue_pending;
 
 	/* DMA capabilities */
+	dw->dma.min_burst = DW_DMA_MIN_BURST;
+	dw->dma.max_burst = DW_DMA_MAX_BURST;
 	dw->dma.src_addr_widths = DW_DMA_BUSWIDTHS;
 	dw->dma.dst_addr_widths = DW_DMA_BUSWIDTHS;
 	dw->dma.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
index f3eaf9ec00a1..369e41e9dcc9 100644
--- a/include/linux/platform_data/dma-dw.h
+++ b/include/linux/platform_data/dma-dw.h
@@ -12,6 +12,8 @@
 
 #define DW_DMA_MAX_NR_MASTERS	4
 #define DW_DMA_MAX_NR_CHANNELS	8
+#define DW_DMA_MIN_BURST	1
+#define DW_DMA_MAX_BURST	256
 
 /**
  * struct dw_dma_slave - Controller-specific information about a slave
-- 
2.26.2

