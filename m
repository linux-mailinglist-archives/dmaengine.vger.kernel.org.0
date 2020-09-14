Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865B6268CFF
	for <lists+dmaengine@lfdr.de>; Mon, 14 Sep 2020 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgINOL0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Sep 2020 10:11:26 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6850 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgINOKS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Sep 2020 10:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600092618; x=1631628618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qoBNbkKAab5vCz1WzJd2Q0kui0rzQACYA42GOpjUIoU=;
  b=sqFtk4vZ1mR9Zup6N6O2zXLo4NazmweOXkXU6W+bxcIURXY4GEb0Tfuz
   dWAnBCg8pinUooFZthNnWFV4pd/b7FK4PB8uVvdxzeNrmK2KywSQbtI95
   YFvZJRcdEtLid8CO3UlYEN8aveMjmpDpahAPbFlH/6QfIOjRB1Yu/KMMD
   lZfGOmyA4GbdCN1ib8WcWD03h1JqTMn6zdaL/7E478iBqluoMOaZIYoBm
   CtGD1nMxFtcUPzmBi0+m8rW+0a2yz+alFT5HxBUPRpIa24i5ovB9911XC
   RCfPzfO0tc9uR6HNVJHC8x2H0TG7yUw18HyewDcWFS6VDBtoRJMTf/cqI
   g==;
IronPort-SDR: 7oIQZaexsHimlVNbzcxjtkuhCzaBKIp8DHYo+1Cl4koOINEVVpTpio8OvfzfbuYE06Knkw9LIU
 8rJ9ewawn/oSznX4Zn2ihrZyikJDyBrLOVLe4wDhibgPv4zV6N+tb5KCGUuPGGkjaubiQurP+S
 74Vmo9VgswC+2n80uOLfftzu7RdnfXj0RssSmfAEzwEkBd4aNUNS+zovXQGBjV4Vl97o3GshDc
 zSy31tM4fXiDv5pMY4c0jgdzDIcRgKgLEz2je4riqroz9ZDPFau4Gq/V+R/xOAoRJsRoFgSohf
 jhw=
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="88993937"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 07:10:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 07:10:14 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 14 Sep 2020 07:10:11 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <tudor.ambarus@microchip.com>, <ludovic.desroches@microchip.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 3/7] dt-bindings: dmaengine: at_xdmac: add compatible with microchip,sama7g5
Date:   Mon, 14 Sep 2020 17:09:52 +0300
Message-ID: <20200914140956.221432-4-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914140956.221432-1-eugen.hristev@microchip.com>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add compatible to sama7g5 SoC.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/dma/atmel-xdma.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/atmel-xdma.txt b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
index 4dc398e1a371..510b7f25ba24 100644
--- a/Documentation/devicetree/bindings/dma/atmel-xdma.txt
+++ b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
@@ -2,7 +2,8 @@
 
 * XDMA Controller
 Required properties:
-- compatible: Should be "atmel,sama5d4-dma" or "microchip,sam9x60-dma".
+- compatible: Should be "atmel,sama5d4-dma", "microchip,sam9x60-dma" or
+  "microchip,sama7g5-dma".
 - reg: Should contain DMA registers location and length.
 - interrupts: Should contain DMA interrupt.
 - #dma-cells: Must be <1>, used to represent the number of integer cells in
-- 
2.25.1

