Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D0546A35E
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 18:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhLFRq7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 12:46:59 -0500
Received: from aposti.net ([89.234.176.197]:59656 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245375AbhLFRqx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Dec 2021 12:46:53 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/6] dt-bindings: dma: ingenic: Support #dma-cells = <3>
Date:   Mon,  6 Dec 2021 17:42:55 +0000
Message-Id: <20211206174259.68133-3-paul@crapouillou.net>
In-Reply-To: <20211206174259.68133-1-paul@crapouillou.net>
References: <20211206174259.68133-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Extend the binding to support specifying a different request type for
each direction.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Enhance documentation

 .../devicetree/bindings/dma/ingenic,dma.yaml     | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
index 2607b403277e..3b0b3b919af8 100644
--- a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
+++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
@@ -44,13 +44,19 @@ properties:
     maxItems: 1
 
   "#dma-cells":
-    const: 2
+    enum: [2, 3]
     description: >
       DMA clients must use the format described in dma.txt, giving a phandle
-      to the DMA controller plus the following 2 integer cells:
-
-      - Request type: The DMA request type for transfers to/from the
-        device on the allocated channel, as defined in the SoC documentation.
+      to the DMA controller plus the following integer cells:
+
+      - Request type: The DMA request type specifies the device endpoint that
+        will be the source or destination of the DMA transfer.
+        If "#dma-cells" is 2, the request type is a single cell, and the
+        direction will be unidirectional (either RX or TX but not both).
+        If "#dma-cells" is 3, the request type has two cells; the first
+        one corresponds to the host to device direction (TX), the second one
+        corresponds to the device to host direction (RX). The DMA channel is
+        then bidirectional.
 
       - Channel: If set to 0xffffffff, any available channel will be allocated
         for the client. Otherwise, the exact channel specified will be used.
-- 
2.33.0

