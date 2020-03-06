Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB917BE16
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2020 14:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgCFNSD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Mar 2020 08:18:03 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36634 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFNSC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Mar 2020 08:18:02 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2020 08:18:01 EST
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 37EDD8030708;
        Fri,  6 Mar 2020 13:10:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PnQUZGPfEfnN; Fri,  6 Mar 2020 16:10:48 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] dt-bindings: dma: dw: Add max burst transaction length property bindings
Date:   Fri, 6 Mar 2020 16:10:31 +0300
In-Reply-To: <20200306131035.10937-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306131035.10937-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306131049.37EDD8030708@mail.baikalelectronics.ru>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

This array property is used to indicate the maximum burst transaction
length supported by each DMA channel.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 .../devicetree/bindings/dma/snps,dma-spear1340.yaml  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
index d7f9383ceb8f..308ec6482064 100644
--- a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
@@ -126,6 +126,18 @@ properties:
           enum: [0, 1]
           default: 0
 
+  snps,max-burst-len:
+    description: |
+      Maximum length of burst transactions supported by hardware.
+      It's an array property with one cell per channel in units of
+      CTLx register SRC_TR_WIDTH/DST_TR_WIDTH field.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - maxItems: 8
+        items:
+          enum: [4, 8, 16, 32, 64, 128, 256]
+          default: 0
+
   snps,dma-protection-control:
     description: |
       Bits one-to-one passed to the AHB HPROT[3:1] bus. Each bit setting
-- 
2.25.1

