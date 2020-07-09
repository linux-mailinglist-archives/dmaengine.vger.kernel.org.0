Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07444219AE6
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2020 10:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgGIIdv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jul 2020 04:33:51 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:65107 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgGIIdu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jul 2020 04:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594283629; x=1625819629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CbBPOIMRecx0ROTOrYcQYkZUD/u2YF7IpvISEGrfPe4=;
  b=d3J0q0M0CXVXBNedI7728ndn/QuQXzcYg8TjQUiTSYUZw8RQSOossUSr
   sbG5++2l/wVy5Z8vfNuZjGJJJv+3Zwdyhjp5hqtk9K8gmJUXyNdV4PFSr
   0dumY1mEfV8fpvH86u2vsZwVQwtQY+SGXZD3rJ7g/s+cGcpLKYiwBTRsc
   NdeUvgAVLYAbfneDj4rBlGfdDWtlXfWSd31rUjyJ3+x/k3yHVzjQvzAwB
   caXGkyRX1uZvdAyODHh4z12s5p7ydcC9VbxKA89IZZOtVJpsPXH+w4e6n
   6Qin4Nv5rzqZrK1C1cQc+C1cAoyLSrDKUGqKHwfFUBRI3pEW4jVPxIpd5
   Q==;
IronPort-SDR: kE8/60WUxW999zbV90XYA/wNxoYiDPhjmgBS6pjrEDs0vMAdqrg9CB8gJ/lHFbths6CMwCPZYs
 T4mcL7gbKSB+vwlpYKuUuA2JaQmVdn1hcJZcOkm3y0aHJFA2q0u2Rg8/Rlbuh44mGaKjwZSfCD
 s+lusFnqN8oYHFTzm1I4E0RH2qxzI9X9JAMOs4CgL1rkMtYPtUjrek+rubK5uWCLLQff0kgKnh
 TYr9X8dBx9YvinMK3IY/MzJ3UOFO8czSWGnKWmxRpUD5xwofbnzNAe3h7hRYOTECeT6Lfc1uxV
 A+U=
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="83125573"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2020 01:33:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 9 Jul 2020 01:33:22 -0700
Received: from ibiza.mchp-main.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 9 Jul 2020 01:33:47 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <tudor.ambarus@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>
Subject: [PATCH] MAINTAINERS: dma: Microchip: add Tudor Ambarus as co-maintainer
Date:   Thu, 9 Jul 2020 10:24:10 +0200
Message-ID: <20200709082410.6880-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add Tudor Ambarus as co-maintainer for both Microchip DMA drivers and
take the opportunity to merge both entries.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 MAINTAINERS | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c87b94e6b2f6..b1382f73ec28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11259,14 +11259,16 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/atmel
 
-MICROCHIP DMA DRIVER
+MICROCHIP DMA DRIVERS
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/dma/atmel-dma.txt
 F:	drivers/dma/at_hdmac.c
 F:	drivers/dma/at_hdmac_regs.h
+F:	drivers/dma/at_xdmac.c
 F:	include/dt-bindings/dma/at91.h
 F:	include/linux/platform_data/dma-atmel.h
 
@@ -11406,13 +11408,6 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/microchip/wilc1000/
 
-MICROCHIP XDMA DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-L:	linux-arm-kernel@lists.infradead.org
-L:	dmaengine@vger.kernel.org
-S:	Supported
-F:	drivers/dma/at_xdmac.c
-
 MICROSEMI MIPS SOCS
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.24.0

