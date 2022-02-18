Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE454BBF1A
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 19:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbiBRSMv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 13:12:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiBRSMv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 13:12:51 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FCF36149;
        Fri, 18 Feb 2022 10:12:33 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9AA482000A;
        Fri, 18 Feb 2022 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645207952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDtK9hjDeoaFWuwGcjB8l+ZpHGIK6PdXu+t6v6YSX+I=;
        b=nI4sDrdfSrUYVO5GV1lR8ZVV13TVVsWsKvQ2I+3QOsyx6bJ2gj0UxsVEOIdX3ksAwe4fVo
        VSQ3XJ84IY7Xgsf2Vz14iezvw3Gx2ehxDCovGMXgCwnc2ixVOhd98HDkaXE/Ci1c9QGoc4
        Oqoc+hvG5is/jhSn3+I1/rOE+mF3T7biqb9xtku+0I9jYrrDTDsU+4Xspqf9md5ouzvaeg
        XNELQnv2PanFFbkZBSpqs/fZ+kr2EW9mR+eSWFI+0j3Lg5rdaMkRhZa06ay06e7FzLqQKk
        rFUIhjjTT7vZ5OBEP/N3Zhm8MZ54wpyZXHXPsEmpTiDNzcKjzxuZSYqnI0QmuA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/8] dt-bindings: dma: Introduce RZN1 DMA compatible
Date:   Fri, 18 Feb 2022 19:12:20 +0100
Message-Id: <20220218181226.431098-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220218181226.431098-1-miquel.raynal@bootlin.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
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

Just like for the NAND controller that is also on this SoC, let's
provide a SoC generic and a more specific couple of compatibles.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/dma/snps,dma-spear1340.yaml       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
index 6b35089ac017..c2e2dc637e0a 100644
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
+              - renesas,r9a06g032-nandc
+          - const: renesas,rzn1-nandc
+
 
   "#dma-cells":
     minimum: 3
-- 
2.27.0

