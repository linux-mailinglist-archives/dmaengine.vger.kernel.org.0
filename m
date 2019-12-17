Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3166D121F77
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfLQATy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:19:54 -0500
Received: from muru.com ([72.249.23.125]:48698 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfLQATy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:19:54 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 23DE982AA;
        Tue, 17 Dec 2019 00:20:33 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 06/14] ARM: OMAP2+: Configure sdma capabilities directly
Date:   Mon, 16 Dec 2019 16:19:17 -0800
Message-Id: <20191217001925.44558-7-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Only earlier SoCs need to be checked for this, all SoCs starting with
omap3630 have CCDN register. This way we get closer to removing the need
to ioremap sdma registers in the platform code.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -273,10 +273,10 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 		d->dev_caps |= HS_CHANNELS_RESERVED;
 
 	/* Check the capabilities register for descriptor loading feature */
-	if (dma_read(CAPS_0, 0) & DMA_HAS_DESCRIPTOR_CAPS)
-		dma_common_ch_end = CCDN;
-	else
+	if (soc_is_omap24xx() || soc_is_omap34xx() || soc_is_am35xx())
 		dma_common_ch_end = CCFN;
+	else
+		dma_common_ch_end = CCDN;
 
 	return 0;
 }
-- 
2.24.1
