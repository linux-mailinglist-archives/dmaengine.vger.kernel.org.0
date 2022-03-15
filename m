Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4204DA310
	for <lists+dmaengine@lfdr.de>; Tue, 15 Mar 2022 20:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349362AbiCOTO0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Mar 2022 15:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349901AbiCOTOY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Mar 2022 15:14:24 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA6BD95;
        Tue, 15 Mar 2022 12:13:07 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 723B6C000A;
        Tue, 15 Mar 2022 19:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647371586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=psSRZJhAOXsPUtZ0dZbzo0PztnR1Q8vauZShn+Y/BqQ=;
        b=AKAed1zNDyLX7GKjwwyoW2dBLUdTZ1OGu17HuLQ5K7JEdwRWZt1O9s+1skMyU4zOpchKYr
        EGte3b/BisMNsIefbtnl//P6WvLp123NJTQtj3LY/mkqRQCW+8kRFXXq35miKNzTcIqn6f
        eDxJdk6Fwx9GhzAlkJkeQ8uQWn/CndFA0aaFzZ40gRyINEm8jDuhvQtvccoBV6rTdTlCc1
        piipzy6Ahi9BItIUioS4mshSWMEVik2sr4UFo0wMWgL7xnXxu7ATlHmVoECa50bMpm09xf
        zkU7Oq/uMl587lZFZBlsy7zDyfft8UpKimsFd+dcncS27esXlOMdfME4b9PxVg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Cc:     Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 3/8] dt-bindings: dmaengine: Introduce RZN1 DMA compatible
Date:   Tue, 15 Mar 2022 20:12:50 +0100
Message-Id: <20220315191255.221473-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220315191255.221473-1-miquel.raynal@bootlin.com>
References: <20220315191255.221473-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

