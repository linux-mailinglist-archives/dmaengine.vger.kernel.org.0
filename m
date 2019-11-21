Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C62D4104912
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2019 04:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKUDTO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 22:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKUDTM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:12 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 841ED20721;
        Thu, 21 Nov 2019 03:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306351;
        bh=fuKwYNhnEaHwePLWYy4xsWV102lg4SPtdbTJkGFerLo=;
        h=From:To:Cc:Subject:Date:From;
        b=AbXvEL/J6fGY4IwcGySN2QD28ASDu7NkI8j2eiVglwoIc1FqUKw+TlmZ4qMTyrVAk
         gaiuK4icHAprAXmuKmXG/+bvlL4jJ7C3/qsc0R+Qvo2r/kKsS/xmW2zi0GTmVbuYYG
         3ePikbhgmP1/cUDkqfB+cNKpE/ZcUo0wEn1y2OJI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH v2] dmaengine: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:08 +0100
Message-Id: <1574306348-29212-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/dma/Kconfig | 60 ++++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 03dfee5c66d9..6fa1eba9d477 100644
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
@@ -215,28 +215,28 @@ config FSL_EDMA
 	  This module can be found on Freescale Vybrid and LS-1 SoCs.
 
 config FSL_QDMA
-       tristate "NXP Layerscape qDMA engine support"
-       depends on ARM || ARM64
-       select DMA_ENGINE
-       select DMA_VIRTUAL_CHANNELS
-       select DMA_ENGINE_RAID
-       select ASYNC_TX_ENABLE_CHANNEL_SWITCH
-       help
-         Support the NXP Layerscape qDMA engine with command queue and legacy mode.
-         Channel virtualization is supported through enqueuing of DMA jobs to,
-         or dequeuing DMA jobs from, different work queues.
-         This module can be found on NXP Layerscape SoCs.
+	tristate "NXP Layerscape qDMA engine support"
+	depends on ARM || ARM64
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	select DMA_ENGINE_RAID
+	select ASYNC_TX_ENABLE_CHANNEL_SWITCH
+	help
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
2.7.4

