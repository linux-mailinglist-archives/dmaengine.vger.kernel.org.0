Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB53A4010
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 12:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhFKKUt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 06:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhFKKUt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Jun 2021 06:20:49 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B71C061574
        for <dmaengine@vger.kernel.org>; Fri, 11 Jun 2021 03:18:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:2411:a261:8fe2:b47f])
        by andre.telenet-ops.be with bizsmtp
        id FmJm2500225eH3q01mJmNv; Fri, 11 Jun 2021 12:18:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lreFR-00Fd2A-Jn; Fri, 11 Jun 2021 12:18:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lreFQ-00CaZY-IG; Fri, 11 Jun 2021 12:18:44 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] dt-bindings: dmaengine: Remove SHDMA Device Tree bindings
Date:   Fri, 11 Jun 2021 12:18:39 +0200
Message-Id: <ba56b7199fcf3516f202389d2c8f836c9ec51e7a.1623406640.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623406640.git.geert+renesas@glider.be>
References: <cover.1623406640.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove the Renesas SHDMA Device Tree bindings, as they are unused.
The DMA multiplexer node and one DMA controller instance were added to
the R-Mobile APE6 .dtsi file, but DMA support was never fully enabled,
cfr. commit a19788612f51b787 ("dmaengine: sh: Remove R-Mobile APE6
support").

Note that the mux idea was dropped when implementing support for DMA on
R-Car Gen2, cfr. renesas,rcar-dmac.yaml.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/dma/renesas,shdma.txt | 84 -------------------
 1 file changed, 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/renesas,shdma.txt

diff --git a/Documentation/devicetree/bindings/dma/renesas,shdma.txt b/Documentation/devicetree/bindings/dma/renesas,shdma.txt
deleted file mode 100644
index a91920a49433c2b8..0000000000000000
--- a/Documentation/devicetree/bindings/dma/renesas,shdma.txt
+++ /dev/null
@@ -1,84 +0,0 @@
-* SHDMA Device Tree bindings
-
-Sh-/r-mobile and R-Car systems often have multiple identical DMA controller
-instances, capable of serving any of a common set of DMA slave devices, using
-the same configuration. To describe this topology we require all compatible
-SHDMA DT nodes to be placed under a DMA multiplexer node. All such compatible
-DMAC instances have the same number of channels and use the same DMA
-descriptors. Therefore respective DMA DT bindings can also all be placed in the
-multiplexer node. Even if there is only one such DMAC instance on a system, it
-still has to be placed under such a multiplexer node.
-
-* DMA multiplexer
-
-Required properties:
-- compatible:	should be "renesas,shdma-mux"
-- #dma-cells:	should be <1>, see "dmas" property below
-
-Optional properties (currently unused):
-- dma-channels:	number of DMA channels
-- dma-requests:	number of DMA request signals
-
-* DMA controller
-
-Required properties:
-- compatible:	should be of the form "renesas,shdma-<soc>", where <soc> should
-		be replaced with the desired SoC model, e.g.
-		"renesas,shdma-r8a73a4" for the system DMAC on r8a73a4 SoC
-
-Example:
-	dmac: dma-multiplexer@0 {
-		compatible = "renesas,shdma-mux";
-		#dma-cells = <1>;
-		dma-channels = <20>;
-		dma-requests = <256>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		dma0: dma-controller@e6700020 {
-			compatible = "renesas,shdma-r8a73a4";
-			reg = <0 0xe6700020 0 0x89e0>;
-			interrupt-parent = <&gic>;
-			interrupts = <0 220 4
-					0 200 4
-					0 201 4
-					0 202 4
-					0 203 4
-					0 204 4
-					0 205 4
-					0 206 4
-					0 207 4
-					0 208 4
-					0 209 4
-					0 210 4
-					0 211 4
-					0 212 4
-					0 213 4
-					0 214 4
-					0 215 4
-					0 216 4
-					0 217 4
-					0 218 4
-					0 219 4>;
-			interrupt-names = "error",
-					"ch0", "ch1", "ch2", "ch3",
-					"ch4", "ch5", "ch6", "ch7",
-					"ch8", "ch9", "ch10", "ch11",
-					"ch12", "ch13", "ch14", "ch15",
-					"ch16", "ch17", "ch18", "ch19";
-		};
-	};
-
-* DMA client
-
-Required properties:
-- dmas:		a list of <[DMA multiplexer phandle] [MID/RID value]> pairs,
-		where MID/RID values are fixed handles, specified in the SoC
-		manual
-- dma-names:	a list of DMA channel names, one per "dmas" entry
-
-Example:
-	dmas = <&dmac 0xd1
-		&dmac 0xd2>;
-	dma-names = "tx", "rx";
-- 
2.25.1

