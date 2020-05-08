Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED931CA8BF
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2020 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEHKxr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 May 2020 06:53:47 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41862 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgEHKxq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 May 2020 06:53:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C9DE98030779;
        Fri,  8 May 2020 10:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k_ka0vsYUEeH; Fri,  8 May 2020 13:53:37 +0300 (MSK)
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
Subject: [PATCH v2 6/6] dmaengine: dw: Take HC_LLP flag into account for noLLP auto-config
Date:   Fri, 8 May 2020 13:53:04 +0300
Message-ID: <20200508105304.14065-7-Sergey.Semin@baikalelectronics.ru>
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

Full multi-block transfers functionality is enabled in DW DMA
controller only if CHx_MULTI_BLK_EN is set. But LLP-based transfers
can be executed only if hardcode channel x LLP register feature isn't
enabled, which can be switched on at the IP core synthesis for
optimization. If it's enabled then the LLP register is hardcoded to
zero, so the blocks chaining based on the LLPs is unsupported.

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
- Rearrange SoBs.
- Add comment about why hardware accelerated LLP list support depends
  on both MBLK_EN and HC_LLP configs setting.
- Use explicit bits state comparison operator.
---
 drivers/dma/dw/core.c | 11 ++++++++++-
 drivers/dma/dw/regs.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 5b76ccc857fd..3179d45df662 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1180,8 +1180,17 @@ int do_dma_probe(struct dw_dma_chip *chip)
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
 			dwc->max_burst =
 				(0x4 << (dwc_params >> DWC_PARAMS_MSIZE & 0x7));
 		} else {
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index f581d4809b71..a8af19d0eabd 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -126,6 +126,7 @@ struct dw_dma_regs {
 
 /* Bitfields in DWC_PARAMS */
 #define DWC_PARAMS_MSIZE	16		/* max group transaction size */
+#define DWC_PARAMS_HC_LLP	13		/* set LLP register to zero */
 #define DWC_PARAMS_MBLK_EN	11		/* multi block transfer */
 
 /* bursts size */
-- 
2.25.1

