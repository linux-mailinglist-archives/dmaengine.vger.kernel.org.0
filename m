Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407734F5D6F
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 14:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiDFMEC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 08:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiDFMCm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 08:02:42 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3836A3024C6;
        Wed,  6 Apr 2022 01:04:25 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,239,1643641200"; 
   d="scan'208";a="115882199"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Apr 2022 17:04:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D90C941E7F1A;
        Wed,  6 Apr 2022 17:04:22 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dmaengine: sh: Kconfig: Make RZ_DMAC depend on ARCH_RZG2L
Date:   Wed,  6 Apr 2022 09:04:17 +0100
Message-Id: <20220406080417.14593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMAC block is identical on Renesas RZ/G2L, RZ/G2UL and RZ/V2L SoC's, so
instead of adding dependency for each SoC's add dependency on ARCH_RZG2L.
The ARCH_RZG2L config option is already selected by ARCH_R9A07G043,
ARCH_R9A07G044 and ARCH_R9A07G054.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index b35d705f79e7..c0b2997ab7fd 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -50,7 +50,7 @@ config RENESAS_USB_DMAC
 
 config RZ_DMAC
 	tristate "Renesas RZ/{G2L,V2L} DMA Controller"
-	depends on ARCH_R9A07G044 || ARCH_R9A07G054 || COMPILE_TEST
+	depends on ARCH_RZG2L || COMPILE_TEST
 	select RENESAS_DMA
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.17.1

