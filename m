Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8584A42920A
	for <lists+dmaengine@lfdr.de>; Mon, 11 Oct 2021 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbhJKOjQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Oct 2021 10:39:16 -0400
Received: from aposti.net ([89.234.176.197]:46602 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238954AbhJKOjO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Oct 2021 10:39:14 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/5] dt-bindings: dma: ingenic: Add compatible strings for MDMA and BDMA
Date:   Mon, 11 Oct 2021 16:36:48 +0200
Message-Id: <20211011143652.51976-2-paul@crapouillou.net>
In-Reply-To: <20211011143652.51976-1-paul@crapouillou.net>
References: <20211011143652.51976-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The JZ4760 and JZ4760B SoCs have two additional DMA controllers: the
MDMA, which only supports memcpy operations, and the BDMA which is
mostly used for transfer between memories and the BCH controller.
The JZ4770 also features the same BDMA as in the JZ4760B, but does not
seem to have a MDMA.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/dma/ingenic,dma.yaml  | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
index ac4d59494fc8..f45fd5235879 100644
--- a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
+++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
@@ -14,15 +14,23 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - ingenic,jz4740-dma
-      - ingenic,jz4725b-dma
-      - ingenic,jz4760-dma
-      - ingenic,jz4760b-dma
-      - ingenic,jz4770-dma
-      - ingenic,jz4780-dma
-      - ingenic,x1000-dma
-      - ingenic,x1830-dma
+    oneOf:
+      - enum:
+        - ingenic,jz4740-dma
+        - ingenic,jz4725b-dma
+        - ingenic,jz4760-dma
+        - ingenic,jz4760-bdma
+        - ingenic,jz4760-mdma
+        - ingenic,jz4760b-dma
+        - ingenic,jz4760b-bdma
+        - ingenic,jz4760b-mdma
+        - ingenic,jz4770-dma
+        - ingenic,jz4780-dma
+        - ingenic,x1000-dma
+        - ingenic,x1830-dma
+      - items:
+        - const: ingenic,jz4770-bdma
+        - const: ingenic,jz4760b-bdma
 
   reg:
     items:
-- 
2.33.0

