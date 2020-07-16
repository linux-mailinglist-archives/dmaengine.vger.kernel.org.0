Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03910221D59
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jul 2020 09:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgGPHZW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jul 2020 03:25:22 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:57031 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGPHZV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jul 2020 03:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594884321; x=1626420321;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rvp3qdfXI+0wIeF984KC4L+2tvzXTtg7kpB2Gfiux0I=;
  b=v1dSb2u2Be88pD0Y+TzQ9MEzFcKZbs9hwCW3Ffg+U/xfh+dmBoi9fi+v
   inUhZEyF9AwyN25M4iSCMKtG0RWr3YYAT3bdlm7IxovrosfC4J+YCOtXT
   /v0cJep66MXRfa7a+jtHS/L0qPmJb+jJVzg8o7IeS17VBLLRdz3I89Dih
   VXCqWuhF/yWDgJJ3lKulcNilC61rJSdJrdix38VDhqN/Evdd8+GwzpHFi
   0Jc0EndyJSxY2dlugDQGmx3vtsIkSIFY/cx9hDvnt6IT06pujOTE4GawI
   ZYlK3k13w3Z3npoh7qR35CMFm9wNM96WoybekkH1jvWoFBZZmCSITw3sd
   w==;
IronPort-SDR: zRqsZhW2OqPdcmzQi54wqgoI5fxKNnE+vagqY/aM0PmFGjoRKdrcd6Gp6K0o+8OaklKHi/uiXu
 3DdY1a4HdD26VPMH0mzBxpfiqV6n5GLa9umcJUwpu57MlNwr3XIECgQNsWhE8MtONjmyjYVexC
 oTV7C4fSGv0dteqq9JqIm6UUCixS5zyVowhKcwUeRTM3N0ibe7LOPpgZTqEm6aSIKvpQt2prsf
 iF6Xy1BydI1GhUR5tI5WjepHBHCtymKgQfqnveb48inXTKq2zofbwXN3Vt302kBzl8PFu+n2/o
 NB4=
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="84108511"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2020 00:25:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 16 Jul 2020 00:25:06 -0700
Received: from ibiza.mchp-main.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 16 Jul 2020 00:25:04 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <tudor.ambarus@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>
Subject: [PATCH v2] MAINTAINERS: dma: Microchip: add Tudor Ambarus as co-maintainer
Date:   Thu, 16 Jul 2020 09:15:24 +0200
Message-ID: <20200716071524.25642-1-ludovic.desroches@microchip.com>
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

v2:
 - Rename the entry to be more specific and to avoid collision with other
   Microchip's DMA drivers.

 MAINTAINERS | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea296f213e45..4a0a28c59bb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11240,6 +11240,19 @@ W:	http://www.monstr.eu/fdt/
 T:	git git://git.monstr.eu/linux-2.6-microblaze.git
 F:	arch/microblaze/
 
+MICROCHIP AT91 DMA DRIVERS
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	dmaengine@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/dma/atmel-dma.txt
+F:	drivers/dma/at_hdmac.c
+F:	drivers/dma/at_hdmac_regs.h
+F:	drivers/dma/at_xdmac.c
+F:	include/dt-bindings/dma/at91.h
+F:	include/linux/platform_data/dma-atmel.h
+
 MICROCHIP AT91 SERIAL DRIVER
 M:	Richard Genoud <richard.genoud@gmail.com>
 S:	Maintained
@@ -11268,17 +11281,6 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/atmel
 
-MICROCHIP DMA DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	dmaengine@vger.kernel.org
-S:	Supported
-F:	Documentation/devicetree/bindings/dma/atmel-dma.txt
-F:	drivers/dma/at_hdmac.c
-F:	drivers/dma/at_hdmac_regs.h
-F:	include/dt-bindings/dma/at91.h
-F:	include/linux/platform_data/dma-atmel.h
-
 MICROCHIP ECC DRIVER
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
 L:	linux-crypto@vger.kernel.org
@@ -11415,13 +11417,6 @@ L:	linux-wireless@vger.kernel.org
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

