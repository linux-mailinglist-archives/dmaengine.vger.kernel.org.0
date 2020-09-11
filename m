Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C68265D18
	for <lists+dmaengine@lfdr.de>; Fri, 11 Sep 2020 11:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgIKJ54 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Sep 2020 05:57:56 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:60624 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbgIKJ54 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Sep 2020 05:57:56 -0400
X-IronPort-AV: E=Sophos;i="5.76,414,1592838000"; 
   d="scan'208";a="57029955"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Sep 2020 18:57:54 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4D4FB423A659;
        Fri, 11 Sep 2020 18:57:52 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH v2] dmaengine: Kconfig: Update description for RCAR_DMAC config
Date:   Fri, 11 Sep 2020 10:57:34 +0100
Message-Id: <20200911095734.19348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

rcar-dmac driver is used on Renesas R-Car Gen{2,3} and Renesas
RZ/G{1,2} SoC's, update the same to reflect the description
for RCAR_DMAC config.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
v1->v2
* Included RZ/Gx
* Restored RB tag from Geert

v1 - https://patchwork.kernel.org/patch/11763239/
---
 drivers/dma/sh/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 54d5d0369d3c..13437323a85b 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -32,12 +32,12 @@ config SH_DMAE
 	  Enable support for the Renesas SuperH DMA controllers.
 
 config RCAR_DMAC
-	tristate "Renesas R-Car Gen2 DMA Controller"
+	tristate "Renesas R-Car Gen{2,3} and RZ/G{1,2} DMA Controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select RENESAS_DMA
 	help
 	  This driver supports the general purpose DMA controller found in the
-	  Renesas R-Car second generation SoCs.
+	  Renesas R-Car Gen{2,3} and RZ/G{1,2} SoCs.
 
 config RENESAS_USB_DMAC
 	tristate "Renesas USB-DMA Controller"
-- 
2.17.1

