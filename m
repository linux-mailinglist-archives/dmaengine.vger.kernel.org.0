Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743724F161A
	for <lists+dmaengine@lfdr.de>; Mon,  4 Apr 2022 15:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355509AbiDDNlP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Apr 2022 09:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355344AbiDDNlN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Apr 2022 09:41:13 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F51D1CFC3;
        Mon,  4 Apr 2022 06:39:16 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 93B39E0011;
        Mon,  4 Apr 2022 13:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649079554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NUnsQ1oGbmfdJo7lE8MZSfdAsUjuXHnI++Iru8elyKw=;
        b=XBqQFdkycxqB1R2A0TBEg/GiT6A8WUe8Ogvo8rduhXMlqo4JCZTOJrZR+M5OJFl0mDcSog
        UWY9Az5I6kHffyY3Qc2OEFTApdWgPW3XnOQVyScfwRLds+MhHNww1zlYcQuhdRFIwEEQ71
        ZUTrRSLumgXu0DG5ASm/KrM3g3Wlkx+4E+Jq4qttqqN9bo7+cuyYD/JV00yXGLM8qPe5zm
        P2ZuGNU+rLXjorvO6YGwV/Goyz4UVTbUo74p97smbUK/+rAEsxUICf5lkpQR6Qj9bbOSeD
        hjiQwc5Wn/be+4OF+xxS8Xhq5U4F4+Ju1CRwslYqGpM1r5SzPpuRa5q333bAZA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Milan Stevanovic <milan.stevanovic@se.com>,
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/8] dt-bindings: clock: r9a06g032-sysctrl: Reference the DMAMUX subnode
Date:   Mon,  4 Apr 2022 15:38:58 +0200
Message-Id: <20220404133904.1296258-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220404133904.1296258-1-miquel.raynal@bootlin.com>
References: <20220404133904.1296258-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This system controller contains several registers that have nothing to
do with the clock handling, like the DMA mux register. Describe this
part of the system controller as a subnode.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/renesas,r9a06g032-sysctrl.yaml     | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
index 25dbb0fac065..95bf485c6cec 100644
--- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
@@ -39,6 +39,17 @@ properties:
   '#power-domain-cells':
     const: 0
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^dma-router@[a-f0-9]+$":
+    type: object
+    $ref: "../dma/renesas,rzn1-dmamux.yaml#"
+
 required:
   - compatible
   - reg
-- 
2.27.0

