Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198541ABE68
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 12:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505476AbgDPKsV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 06:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505236AbgDPKgX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Apr 2020 06:36:23 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0471FC025480
        for <dmaengine@vger.kernel.org>; Thu, 16 Apr 2020 03:36:14 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:fd83:81bb:c1d7:433d])
        by andre.telenet-ops.be with bizsmtp
        id TNWz2200X4dKHqf01NWzRY; Thu, 16 Apr 2020 12:31:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1nP-0001ck-MK; Thu, 16 Apr 2020 12:30:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1nP-0003zB-LC; Thu, 16 Apr 2020 12:30:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial 2/6] dma: Fix misspelling of "Analog Devices"
Date:   Thu, 16 Apr 2020 12:30:54 +0200
Message-Id: <20200416103058.15269-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416103058.15269-1-geert+renesas@glider.be>
References: <20200416103058.15269-1-geert+renesas@glider.be>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

According to https://www.analog.com/, the company name is spelled
"Analog Devices".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0924836443152fb5..c35c0e03b40f026b 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -106,7 +106,7 @@ config AXI_DMAC
 	select REGMAP_MMIO
 	help
 	  Enable support for the Analog Devices AXI-DMAC peripheral. This DMA
-	  controller is often used in Analog Device's reference designs for FPGA
+	  controller is often used in Analog Devices' reference designs for FPGA
 	  platforms.
 
 config BCM_SBA_RAID
-- 
2.17.1

