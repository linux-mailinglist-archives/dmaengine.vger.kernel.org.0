Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707D16967DC
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 16:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjBNPUx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 10:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjBNPUu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 10:20:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558272A98D;
        Tue, 14 Feb 2023 07:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676388049; x=1707924049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nsRF0f491KkD61nUvqBLtSWknSxgHLhsAPajWl3pVNw=;
  b=YHMmbI3AotDjGYgnCTRllu5pH09SuQJdcVVSWgBp5sZEJwu8I+oVqbY0
   BvWuieMu7wwpPIEqVQKJqj3jm6Hmg3isYCcV+43iy7OqRI5gzB4tjmDap
   R0ZDgmOGJ5tvq8sDJYs7tgTy0g07R6BNdqrGalrxSGfBXh9/dMlzaKRJO
   s2fYW7097oGu4LrCJgDjXbKK5BV3BSGTkcjvRqlNo7nkb3mO4CTeGmdF2
   gr8B6udWUUFsP/2suc0d7sxzzeX2rbL6f3OGMvMr3ahVz2teKB+xlEXpZ
   nsJpG+0BBJaxTDhl006+HOyaLypCjj/K21SUMURtUeoiY9GnZWfY4gurG
   w==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669100400"; 
   d="scan'208";a="196877729"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 08:20:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:20:44 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 08:20:40 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@linaro.org>,
        <vkoul@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/7] dmaengine: at_xdmac: fix imbalanced runtime PM reference counter
Date:   Tue, 14 Feb 2023 17:18:22 +0200
Message-ID: <20230214151827.1050280-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214151827.1050280-1-claudiu.beznea@microchip.com>
References: <20230214151827.1050280-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In case there are channels not paused during suspend (which on AT91 case
is valid for serial driver when no_console_suspend boot argument is used)
the at_xdmac_runtime_suspend_descriptors() was called more than
one time due to at_xdmac_off(). To fix this add a new argument to
at_xdmac_off() to specify if runtime PM reference counter needs to be
decremented for queued active descriptors. Along with it moved the
at_xdmac_runtime_suspend_descriptors() call under at_xdmac_chan_is_paused()
check on suspend path as for the rest of channels the suspend is delayed
by atmel_xdmac_prepare() in case channel is enabled. Same approach has
been applied on resume path.

Fixes: 650b0e990cbd ("dmaengine: at_xdmac: add runtime pm support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index f654ecaafb90..af3b494f9ba9 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -412,7 +412,7 @@ static bool at_xdmac_chan_is_enabled(struct at_xdmac_chan *atchan)
 	return ret;
 }
 
-static void at_xdmac_off(struct at_xdmac *atxdmac)
+static void at_xdmac_off(struct at_xdmac *atxdmac, bool suspend_descriptors)
 {
 	struct dma_chan		*chan, *_chan;
 	struct at_xdmac_chan	*atchan;
@@ -431,7 +431,7 @@ static void at_xdmac_off(struct at_xdmac *atxdmac)
 	at_xdmac_write(atxdmac, AT_XDMAC_GID, -1L);
 
 	/* Decrement runtime PM ref counter for each active descriptor. */
-	if (!list_empty(&atxdmac->dma.channels)) {
+	if (!list_empty(&atxdmac->dma.channels) && suspend_descriptors) {
 		list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels,
 					 device_node) {
 			atchan = to_at_xdmac_chan(chan);
@@ -2118,18 +2118,18 @@ static int __maybe_unused atmel_xdmac_suspend(struct device *dev)
 
 		atchan->save_cc = at_xdmac_chan_read(atchan, AT_XDMAC_CC);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
-			if (!at_xdmac_chan_is_paused(atchan))
+			if (!at_xdmac_chan_is_paused(atchan)) {
 				at_xdmac_device_pause(chan);
+				at_xdmac_runtime_suspend_descriptors(atchan);
+			}
 			atchan->save_cim = at_xdmac_chan_read(atchan, AT_XDMAC_CIM);
 			atchan->save_cnda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA);
 			atchan->save_cndc = at_xdmac_chan_read(atchan, AT_XDMAC_CNDC);
 		}
-
-		at_xdmac_runtime_suspend_descriptors(atchan);
 	}
 	atxdmac->save_gim = at_xdmac_read(atxdmac, AT_XDMAC_GIM);
 
-	at_xdmac_off(atxdmac);
+	at_xdmac_off(atxdmac, false);
 	pm_runtime_mark_last_busy(atxdmac->dev);
 	pm_runtime_put_noidle(atxdmac->dev);
 	clk_disable_unprepare(atxdmac->clk);
@@ -2165,14 +2165,14 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
 		atchan = to_at_xdmac_chan(chan);
 
-		ret = at_xdmac_runtime_resume_descriptors(atchan);
-		if (ret < 0)
-			return ret;
-
 		at_xdmac_chan_write(atchan, AT_XDMAC_CC, atchan->save_cc);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
-			if (at_xdmac_chan_is_paused(atchan))
+			if (at_xdmac_chan_is_paused(atchan)) {
+				ret = at_xdmac_runtime_resume_descriptors(atchan);
+				if (ret < 0)
+					return ret;
 				at_xdmac_device_resume(chan);
+			}
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, atchan->save_cnda);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
@@ -2318,7 +2318,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&atxdmac->dma.channels);
 
 	/* Disable all chans and interrupts. */
-	at_xdmac_off(atxdmac);
+	at_xdmac_off(atxdmac, true);
 
 	for (i = 0; i < nr_channels; i++) {
 		struct at_xdmac_chan *atchan = &atxdmac->chan[i];
@@ -2382,7 +2382,7 @@ static int at_xdmac_remove(struct platform_device *pdev)
 	struct at_xdmac	*atxdmac = (struct at_xdmac *)platform_get_drvdata(pdev);
 	int		i;
 
-	at_xdmac_off(atxdmac);
+	at_xdmac_off(atxdmac, true);
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&atxdmac->dma);
 	pm_runtime_disable(atxdmac->dev);
-- 
2.34.1

