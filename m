Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2DC251646
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 12:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgHYKJQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 06:09:16 -0400
Received: from mailoutvs18.siol.net ([185.57.226.209]:45118 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729205AbgHYKJP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 06:09:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 6D6B652324E;
        Tue, 25 Aug 2020 12:00:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yl6QLzCUCvHr; Tue, 25 Aug 2020 12:00:38 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 220A8522FC8;
        Tue, 25 Aug 2020 12:00:38 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id DCD6952300A;
        Tue, 25 Aug 2020 12:00:35 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 1/2] dt-bindings: dma: allwinner,sun50i-a64-dma: Add R40 compatible
Date:   Tue, 25 Aug 2020 12:00:29 +0200
Message-Id: <20200825100030.1145356-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825100030.1145356-1-jernej.skrabec@siol.net>
References: <20200825100030.1145356-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

R40 has DMA engine which is basically the same as that in A64, with only
known difference being number of request sources and number of channels.

Add compatible for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../bindings/dma/allwinner,sun50i-a64-dma.yaml           | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-d=
ma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.=
yaml
index 9e53472be194..372679dbd216 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
@@ -19,9 +19,12 @@ properties:
     description: The cell is the request line number.
=20
   compatible:
-    enum:
-      - allwinner,sun50i-a64-dma
-      - allwinner,sun50i-h6-dma
+    oneOf:
+      - const: allwinner,sun50i-a64-dma
+      - const: allwinner,sun50i-h6-dma
+      - items:
+          - const: allwinner,sun8i-r40-dma
+          - const: allwinner,sun50i-a64-dma
=20
   reg:
     maxItems: 1
--=20
2.28.0

