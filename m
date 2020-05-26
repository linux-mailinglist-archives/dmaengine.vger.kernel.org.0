Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C6E1E332F
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2020 00:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404572AbgEZWvn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 May 2020 18:51:43 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60238 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404568AbgEZWvn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 May 2020 18:51:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id AFCA58030875;
        Tue, 26 May 2020 22:51:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uU1xhBNbPSMa; Wed, 27 May 2020 01:51:39 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-mips@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 02/10] dt-bindings: dma: dw: Add max burst transaction length property
Date:   Wed, 27 May 2020 01:50:13 +0300
Message-ID: <20200526225022.20405-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This array property is used to indicate the maximum burst transaction
length supported by each DMA channel.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mips@vger.kernel.org

---

Changelog v2:
- Rearrange SoBs.
- Move $ref to the root level of the properties. So do with the
  constraints.
- Set default max-burst-len to 256 TR-WIDTH words.

Changelog v3:
- Add more details into the property description about what limitations
  snps,max-burst-len defines.
---
 .../bindings/dma/snps,dma-spear1340.yaml          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
index e7611840a7cf..20870f5c14dd 100644
--- a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
@@ -120,6 +120,21 @@ properties:
         enum: [0, 1]
         default: 1
 
+  snps,max-burst-len:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Maximum length of the burst transactions supported by the controller.
+      This property defines the upper limit of the run-time burst setting
+      (CTLx.SRC_MSIZE/CTLx.DST_MSIZE fields) so the allowed burst length
+      will be from 1 to max-burst-len words. It's an array property with one
+      cell per channel in the units determined by the value set in the
+      CTLx.SRC_TR_WIDTH/CTLx.DST_TR_WIDTH fields (data width).
+    items:
+      maxItems: 8
+      items:
+        enum: [4, 8, 16, 32, 64, 128, 256]
+        default: 256
+
   snps,dma-protection-control:
     $ref: /schemas/types.yaml#definitions/uint32
     description: |
-- 
2.26.2

