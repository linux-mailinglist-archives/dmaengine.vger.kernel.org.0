Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79FD46A35B
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 18:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbhLFRqr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 12:46:47 -0500
Received: from aposti.net ([89.234.176.197]:59616 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243600AbhLFRqq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Dec 2021 12:46:46 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: dma: ingenic: Add compatible strings for MDMA and BDMA
Date:   Mon,  6 Dec 2021 17:42:54 +0000
Message-Id: <20211206174259.68133-2-paul@crapouillou.net>
In-Reply-To: <20211206174259.68133-1-paul@crapouillou.net>
References: <20211206174259.68133-1-paul@crapouillou.net>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v2: Fix indentation

 .../devicetree/bindings/dma/ingenic,dma.yaml  | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
index dc059d6fd037..2607b403277e 100644
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
+          - ingenic,jz4740-dma
+          - ingenic,jz4725b-dma
+          - ingenic,jz4760-dma
+          - ingenic,jz4760-bdma
+          - ingenic,jz4760-mdma
+          - ingenic,jz4760b-dma
+          - ingenic,jz4760b-bdma
+          - ingenic,jz4760b-mdma
+          - ingenic,jz4770-dma
+          - ingenic,jz4780-dma
+          - ingenic,x1000-dma
+          - ingenic,x1830-dma
+      - items:
+          - const: ingenic,jz4770-bdma
+          - const: ingenic,jz4760b-bdma
 
   reg:
     items:
-- 
2.33.0

