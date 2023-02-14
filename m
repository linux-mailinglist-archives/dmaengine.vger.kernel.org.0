Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6346967DE
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 16:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjBNPU5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 10:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjBNPUy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 10:20:54 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552E92B082;
        Tue, 14 Feb 2023 07:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676388050; x=1707924050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XpfnJ7/Q7H/agWUZc5vz3g6HcP5lClT0AAW8DNkz+QU=;
  b=M7PtSsrbiMUBnszIki7f1lglAw1d+EelHJD1HMF4sU2CGQzDlhlof6UT
   iO4INcjdSUf2TX7TUYD2rkb9+mkB7uVIDTfbnLFVVokpwToSNCchm8F4J
   WP+3KeHTU/fm9/3YH9/nBRlP4TvjPQqmnGLIfw4dCCcLdZd+bCyAVST+F
   Dq+Iwy0oasR8kv3csx0RVcOZPyTw/2Yt4Q8kWanrQ4OM7v2OP2hfogncG
   fEL9wqLCMJipPDut5ur58SBsO6DtJff6JJNJahlOofGmUlGqqorJGe1gy
   5LFgDK5EFnP03AT9Lh/3/1RQsYXTY/fOdEpjUkzmgne4XKeH8veA34q0A
   w==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669100400"; 
   d="scan'208";a="137131037"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 08:20:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:20:49 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 08:20:44 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@linaro.org>,
        <vkoul@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/7] dmaengine: at_xdmac: do not resume channels paused by consumers
Date:   Tue, 14 Feb 2023 17:18:23 +0200
Message-ID: <20230214151827.1050280-4-claudiu.beznea@microchip.com>
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

In case there are DMA channels not paused by consumers in suspend
process (valid on AT91 SoCs for serial driver when no_console_suspend) the
driver pauses them (using at_xdmac_device_pause() which is also the same
function called by dmaengine_pause()) and then in the resume process the
driver resumes them calling at_xdmac_device_resume() which is the same
function called by dmaengine_resume()). This is good for DMA channels
not paused by consumers but for drivers that calls
dmaengine_pause()/dmaegine_resume() on suspend/resume path this may lead to
DMA channel being enabled before the IP is enabled. For IPs that needs
strict ordering with regards to DMA channel enablement this will lead to
wrong behavior. To fix this add a new set of functions
at_xdmac_device_pause_internal()/at_xdmac_device_resume_internal() to be
called only on suspend/resume.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 52 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index af3b494f9ba9..fa1e2e0da02f 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -187,6 +187,7 @@
 enum atc_status {
 	AT_XDMAC_CHAN_IS_CYCLIC = 0,
 	AT_XDMAC_CHAN_IS_PAUSED,
+	AT_XDMAC_CHAN_IS_PAUSED_INTERNAL,
 };
 
 struct at_xdmac_layout {
@@ -347,6 +348,11 @@ static inline int at_xdmac_chan_is_paused(struct at_xdmac_chan *atchan)
 	return test_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
 }
 
+static inline int at_xdmac_chan_is_paused_internal(struct at_xdmac_chan *atchan)
+{
+	return test_bit(AT_XDMAC_CHAN_IS_PAUSED_INTERNAL, &atchan->status);
+}
+
 static inline bool at_xdmac_chan_is_peripheral_xfer(u32 cfg)
 {
 	return cfg & AT_XDMAC_CC_TYPE_PER_TRAN;
@@ -1898,6 +1904,26 @@ static int at_xdmac_device_config(struct dma_chan *chan,
 	return ret;
 }
 
+static void at_xdmac_device_pause_set(struct at_xdmac *atxdmac,
+				      struct at_xdmac_chan *atchan)
+{
+	at_xdmac_write(atxdmac, atxdmac->layout->grws, atchan->mask);
+	while (at_xdmac_chan_read(atchan, AT_XDMAC_CC) &
+	       (AT_XDMAC_CC_WRIP | AT_XDMAC_CC_RDIP))
+		cpu_relax();
+}
+
+static void at_xdmac_device_pause_internal(struct at_xdmac_chan *atchan)
+{
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&atchan->lock, flags);
+	set_bit(AT_XDMAC_CHAN_IS_PAUSED_INTERNAL, &atchan->status);
+	at_xdmac_device_pause_set(atxdmac, atchan);
+	spin_unlock_irqrestore(&atchan->lock, flags);
+}
+
 static int at_xdmac_device_pause(struct dma_chan *chan)
 {
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
@@ -1915,11 +1941,8 @@ static int at_xdmac_device_pause(struct dma_chan *chan)
 		return ret;
 
 	spin_lock_irqsave(&atchan->lock, flags);
-	at_xdmac_write(atxdmac, atxdmac->layout->grws, atchan->mask);
-	while (at_xdmac_chan_read(atchan, AT_XDMAC_CC)
-	       & (AT_XDMAC_CC_WRIP | AT_XDMAC_CC_RDIP))
-		cpu_relax();
 
+	at_xdmac_device_pause_set(atxdmac, atchan);
 	/* Decrement runtime PM ref counter for each active descriptor. */
 	at_xdmac_runtime_suspend_descriptors(atchan);
 
@@ -1931,6 +1954,17 @@ static int at_xdmac_device_pause(struct dma_chan *chan)
 	return 0;
 }
 
+static void at_xdmac_device_resume_internal(struct at_xdmac_chan *atchan)
+{
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&atchan->lock, flags);
+	at_xdmac_write(atxdmac, atxdmac->layout->grwr, atchan->mask);
+	clear_bit(AT_XDMAC_CHAN_IS_PAUSED_INTERNAL, &atchan->status);
+	spin_unlock_irqrestore(&atchan->lock, flags);
+}
+
 static int at_xdmac_device_resume(struct dma_chan *chan)
 {
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
@@ -2119,7 +2153,7 @@ static int __maybe_unused atmel_xdmac_suspend(struct device *dev)
 		atchan->save_cc = at_xdmac_chan_read(atchan, AT_XDMAC_CC);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
 			if (!at_xdmac_chan_is_paused(atchan)) {
-				at_xdmac_device_pause(chan);
+				at_xdmac_device_pause_internal(atchan);
 				at_xdmac_runtime_suspend_descriptors(atchan);
 			}
 			atchan->save_cim = at_xdmac_chan_read(atchan, AT_XDMAC_CIM);
@@ -2167,11 +2201,15 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 
 		at_xdmac_chan_write(atchan, AT_XDMAC_CC, atchan->save_cc);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
-			if (at_xdmac_chan_is_paused(atchan)) {
+			/*
+			 * Resume only channels not explicitly paused by
+			 * consumers.
+			 */
+			if (at_xdmac_chan_is_paused_internal(atchan)) {
 				ret = at_xdmac_runtime_resume_descriptors(atchan);
 				if (ret < 0)
 					return ret;
-				at_xdmac_device_resume(chan);
+				at_xdmac_device_resume_internal(atchan);
 			}
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, atchan->save_cnda);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
-- 
2.34.1

