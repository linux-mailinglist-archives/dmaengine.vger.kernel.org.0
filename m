Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408414BED62
	for <lists+dmaengine@lfdr.de>; Mon, 21 Feb 2022 23:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiBUWtG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 17:49:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiBUWtG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 17:49:06 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 14:48:40 PST
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 968FB22B32
        for <dmaengine@vger.kernel.org>; Mon, 21 Feb 2022 14:48:39 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,386,1635174000"; 
   d="scan'208";a="111175693"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Feb 2022 07:43:36 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7756041105B0;
        Tue, 22 Feb 2022 07:43:34 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH] dmaengine: sh: Kconfig: Add ARCH_R9A07G054 dependency for RZ_DMAC config option
Date:   Mon, 21 Feb 2022 22:43:21 +0000
Message-Id: <20220221224321.11939-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RZ/V2L DMA block is identical to one found on RZ/G2L SoC. This patch adds
ARCH_R9A07G054 dependency for RZ_DMAC config option so that the driver
can be enabled on RZ/V2L SoC. While at it, also update config help text.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note: DMA DT documentation and DTSI changes have already been queued up
for RZ/V2L SoC [0].
[0] https://lore.kernel.org/lkml/20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com/T/
---
 drivers/dma/sh/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index a46296285307..b35d705f79e7 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -49,10 +49,10 @@ config RENESAS_USB_DMAC
 	  SoCs.
 
 config RZ_DMAC
-	tristate "Renesas RZ/G2L DMA Controller"
-	depends on ARCH_R9A07G044 || COMPILE_TEST
+	tristate "Renesas RZ/{G2L,V2L} DMA Controller"
+	depends on ARCH_R9A07G044 || ARCH_R9A07G054 || COMPILE_TEST
 	select RENESAS_DMA
 	select DMA_VIRTUAL_CHANNELS
 	help
 	  This driver supports the general purpose DMA controller found in the
-	  Renesas RZ/G2L SoC variants.
+	  Renesas RZ/{G2L,V2L} SoC variants.
-- 
2.17.1

