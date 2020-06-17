Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD361FD9C4
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2020 01:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgFQXks (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jun 2020 19:40:48 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57882 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFQXkq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 Jun 2020 19:40:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9229880045E4;
        Wed, 17 Jun 2020 23:40:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uBmVmL088CaH; Thu, 18 Jun 2020 02:40:41 +0300 (MSK)
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
Subject: [PATCH v6 5/9] dmaengine: dw: Take HC_LLP flag into account for noLLP auto-config
Date:   Thu, 18 Jun 2020 02:40:24 +0300
Message-ID: <20200617234028.25808-6-Sergey.Semin@baikalelectronics.ru>
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

Full multi-block transfers functionality is enabled in DW DMA
controller only if CHx_MULTI_BLK_EN is set. But LLP-based transfers
can be executed only if hardcode channel x LLP register feature isn't
enabled, which can be switched on at the IP core synthesis for
optimization. If it's enabled then the LLP register is hardcoded to
zero, so the blocks chaining based on the LLPs is unsupported.

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
- Rearrange SoBs.
- Add comment about why hardware accelerated LLP list support depends
  on both MBLK_EN and HC_LLP configs setting.
- Use explicit bits state comparison operator.

Changelog v3:
- Move the patch to the head of the series.
---
 drivers/dma/dw/core.c | 11 ++++++++++-
 drivers/dma/dw/regs.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 21cb2a58dbd2..33e99d95b3d3 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1178,8 +1178,17 @@ int do_dma_probe(struct dw_dma_chip *chip)
 			 */
 			dwc->block_size =
 				(4 << ((pdata->block_size >> 4 * i) & 0xf)) - 1;
+
+			/*
+			 * According to the DW DMA databook the true scatter-
+			 * gether LLPs aren't available if either multi-block
+			 * config is disabled (CHx_MULTI_BLK_EN == 0) or the
+			 * LLP register is hard-coded to zeros
+			 * (CHx_HC_LLP == 1).
+			 */
 			dwc->nollp =
-				(dwc_params >> DWC_PARAMS_MBLK_EN & 0x1) == 0;
+				(dwc_params >> DWC_PARAMS_MBLK_EN & 0x1) == 0 ||
+				(dwc_params >> DWC_PARAMS_HC_LLP & 0x1) == 1;
 		} else {
 			dwc->block_size = pdata->block_size;
 			dwc->nollp = !pdata->multi_block[i];
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index 3fce66ecee7a..1ab840b06e79 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -125,6 +125,7 @@ struct dw_dma_regs {
 
 /* Bitfields in DWC_PARAMS */
 #define DWC_PARAMS_MBLK_EN	11		/* multi block transfer */
+#define DWC_PARAMS_HC_LLP	13		/* set LLP register to zero */
 
 /* bursts size */
 enum dw_dma_msize {
-- 
2.26.2

