Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99828261071
	for <lists+dmaengine@lfdr.de>; Tue,  8 Sep 2020 13:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgIHLGx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Sep 2020 07:06:53 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:38299 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729646AbgIHLGu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Sep 2020 07:06:50 -0400
X-IronPort-AV: E=Sophos;i="5.76,405,1592838000"; 
   d="scan'208";a="56675400"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 08 Sep 2020 20:06:48 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 74377423AE53;
        Tue,  8 Sep 2020 20:06:46 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] dmaengine: Kconfig: Update description for RCAR_DMAC config
Date:   Tue,  8 Sep 2020 12:06:40 +0100
Message-Id: <20200908110640.5003-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

rcar-dmac driver is used on Renesas R-Car Gen2 and Gen3 devices
update the same to reflect the description for RCAR_DMAC config.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 54d5d0369d3c..5e8a8e122996 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -32,12 +32,12 @@ config SH_DMAE
 	  Enable support for the Renesas SuperH DMA controllers.
 
 config RCAR_DMAC
-	tristate "Renesas R-Car Gen2 DMA Controller"
+	tristate "Renesas R-Car Gen2/Gen3 DMA Controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select RENESAS_DMA
 	help
 	  This driver supports the general purpose DMA controller found in the
-	  Renesas R-Car second generation SoCs.
+	  Renesas R-Car second and third generation SoCs.
 
 config RENESAS_USB_DMAC
 	tristate "Renesas USB-DMA Controller"
-- 
2.17.1

