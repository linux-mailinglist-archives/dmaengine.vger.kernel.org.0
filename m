Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9288F4D4DE4
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 16:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbiCJP7N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 10:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiCJP7L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 10:59:11 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5024AE0E;
        Thu, 10 Mar 2022 07:58:09 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8851A200010;
        Thu, 10 Mar 2022 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646927884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n/exwqVSBn9GMxyX4v9iy7CTZTwOTnkcN2SvYt0CMdI=;
        b=lCqbdEoOWMH/Icj7qhCIkRLWLWNNIiGNJ3vAz78xNiCFqlqMPkDsEMQ43CpD54wxIvjwDT
        dlHW1LCPiA1LF3g6DeDAi4/0KxLKidBiexZ9ZdsSP13eKRRjEg5aknnD3AgPRSAJ05o0vv
        6dX1csZ1U9hLxlxitTXUy9iFrw7f6a/E9VJY9NmJzNwiDu4pIP9RkUGeMe2oQ+XmYj2KW3
        Lq9YNPKYC7s98o36kO6NBOpHibCiMqlzrBE5umaJuTvt+SlQhjhRgwQyZiRV7BQD3JyKhJ
        f+QG7uvuTAz8nHy6Qqu8oj/RRu+6Z6XBN/tAKmrC5u3wmA3r2md98FhNdT4dOQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 2/9] dt-bindings: clock: r9a06g032-sysctrl: Reference the DMAMUX subnode
Date:   Thu, 10 Mar 2022 16:57:48 +0100
Message-Id: <20220310155755.287294-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220310155755.287294-1-miquel.raynal@bootlin.com>
References: <20220310155755.287294-1-miquel.raynal@bootlin.com>
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

This system controller contains several registers that have nothing to
do with the clock handling, like the DMA mux register. Describe this
part of the system controller as a subnode.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
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

