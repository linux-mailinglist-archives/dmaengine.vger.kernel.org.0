Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBEB0103C44
	for <lists+dmaengine@lfdr.de>; Wed, 20 Nov 2019 14:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfKTNmS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 08:42:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbfKTNmQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:16 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2180224FA;
        Wed, 20 Nov 2019 13:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257335;
        bh=wYQ8OP8Cb3pyOLHz3cznHXYjmnobWPzjJL4GgNNfLR8=;
        h=From:To:Cc:Subject:Date:From;
        b=tt76WOQ4A2+a64bQSdG1FIFRonxHjKqi/flSNw+ek+tkgQfpz01PYKrIcqcamRoOg
         jL7afwgplAQiYwkp0+Wj2o0np87mOEl/15ZCb+YVUXRgxg7xspoaeRqgw+Pm2oXgWS
         Wi/SDlBGnLxkv9Siq4JdqKbO375AwoEAjK3ZAReo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: [PATCH] dma: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:11 +0800
Message-Id: <20191120134211.15644-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/Kconfig | 46 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 03dfee5c66d9..47d951df2805 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -15,19 +15,19 @@ menuconfig DMADEVICES
 	  be empty in some cases.
 
 config DMADEVICES_DEBUG
-        bool "DMA Engine debugging"
-        depends on DMADEVICES != n
-        help
-          This is an option for use by developers; most people should
-          say N here.  This enables DMA engine core and driver debugging.
+	bool "DMA Engine debugging"
+	depends on DMADEVICES != n
+	help
+	  This is an option for use by developers; most people should
+	  say N here.  This enables DMA engine core and driver debugging.
 
 config DMADEVICES_VDEBUG
-        bool "DMA Engine verbose debugging"
-        depends on DMADEVICES_DEBUG != n
-        help
-          This is an option for use by developers; most people should
-          say N here.  This enables deeper (more verbose) debugging of
-          the DMA engine core and drivers.
+	bool "DMA Engine verbose debugging"
+	depends on DMADEVICES_DEBUG != n
+	help
+	  This is an option for use by developers; most people should
+	  say N here.  This enables deeper (more verbose) debugging of
+	  the DMA engine core and drivers.
 
 
 if DMADEVICES
@@ -222,21 +222,21 @@ config FSL_QDMA
        select DMA_ENGINE_RAID
        select ASYNC_TX_ENABLE_CHANNEL_SWITCH
        help
-         Support the NXP Layerscape qDMA engine with command queue and legacy mode.
-         Channel virtualization is supported through enqueuing of DMA jobs to,
-         or dequeuing DMA jobs from, different work queues.
-         This module can be found on NXP Layerscape SoCs.
+	 Support the NXP Layerscape qDMA engine with command queue and legacy mode.
+	 Channel virtualization is supported through enqueuing of DMA jobs to,
+	 or dequeuing DMA jobs from, different work queues.
+	 This module can be found on NXP Layerscape SoCs.
 	  The qdma driver only work on  SoCs with a DPAA hardware block.
 
 config FSL_RAID
-        tristate "Freescale RAID engine Support"
-        depends on FSL_SOC && !ASYNC_TX_ENABLE_CHANNEL_SWITCH
-        select DMA_ENGINE
-        select DMA_ENGINE_RAID
-        ---help---
-          Enable support for Freescale RAID Engine. RAID Engine is
-          available on some QorIQ SoCs (like P5020/P5040). It has
-          the capability to offload memcpy, xor and pq computation
+	tristate "Freescale RAID engine Support"
+	depends on FSL_SOC && !ASYNC_TX_ENABLE_CHANNEL_SWITCH
+	select DMA_ENGINE
+	select DMA_ENGINE_RAID
+	---help---
+	  Enable support for Freescale RAID Engine. RAID Engine is
+	  available on some QorIQ SoCs (like P5020/P5040). It has
+	  the capability to offload memcpy, xor and pq computation
 	  for raid5/6.
 
 config IMG_MDC_DMA
-- 
2.17.1

