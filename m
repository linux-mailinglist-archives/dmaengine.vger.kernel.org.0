Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E67511597
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 13:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiD0K71 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 06:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiD0K7T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 06:59:19 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFDB3DB5E3;
        Wed, 27 Apr 2022 03:36:50 -0700 (PDT)
Received: from relay12.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::232])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 99CE4CC45C;
        Wed, 27 Apr 2022 09:57:43 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E15DF200004;
        Wed, 27 Apr 2022 09:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651053423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/2uPiY2TYWmapERUhN8j/bje3sF8nIU5bDWIigV/vE=;
        b=h/+yRqP+cB0wVBo6tNkOtNpvK0tItmZbtR4YS1YMYs9+tv8BG5yvBRyhF6ohc/nknjfIqQ
        LMm7CTnRFhgw203UKlvWvO0KaXvq53wineGmDqbJ/wR+WbZMSQCyvAYRx7TWH2z6TyYy8G
        tst0qXNWpMK6mle3k4SicjgAgBi0H1bI+yC3ULK1im3LSd8mROX/1Lo7d6Vwqg13xNDup5
        8a84nb5B+82Heov5lnKOjsy/CnZPyjgXr92DY1iG7dZK3k3iU4uPYTXE9LopXwXCjRwO97
        fXh/aMxuekCWCggbRvFIqr4K4ntGccijT7MaABUI/gy4mOExG8HxE21nHH4DDw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v12 3/9] dt-bindings: dmaengine: Introduce RZN1 DMA compatible
Date:   Wed, 27 Apr 2022 11:56:47 +0200
Message-Id: <20220427095653.91804-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220427095653.91804-1-miquel.raynal@bootlin.com>
References: <20220427095653.91804-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Just like for the NAND controller that is also on this SoC, let's
provide a SoC generic and a more specific couple of compatibles for the
DMA controller.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/dma/snps,dma-spear1340.yaml       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
index 6b35089ac017..c13649bf7f19 100644
--- a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
@@ -15,7 +15,13 @@ allOf:
 
 properties:
   compatible:
-    const: snps,dma-spear1340
+    oneOf:
+      - const: snps,dma-spear1340
+      - items:
+          - enum:
+              - renesas,r9a06g032-dma
+          - const: renesas,rzn1-dma
+
 
   "#dma-cells":
     minimum: 3
-- 
2.27.0

