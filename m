Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2E25B3A35
	for <lists+dmaengine@lfdr.de>; Fri,  9 Sep 2022 16:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiIIN66 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Sep 2022 09:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiIIN6u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Sep 2022 09:58:50 -0400
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Sep 2022 06:58:38 PDT
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2491580C;
        Fri,  9 Sep 2022 06:58:38 -0700 (PDT)
Received: from robin.home.jannau.net (p54acc2ba.dip0.t-ipconnect.de [84.172.194.186])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 7EA8226EFEB;
        Fri,  9 Sep 2022 15:51:04 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        er <povik+lin@cutebit.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/10] dt-bindings: dma: apple,admac: Add iommus and power-domains properties
Date:   Fri,  9 Sep 2022 15:50:55 +0200
Message-Id: <20220909135103.98179-3-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909135103.98179-1-j@jannau.net>
References: <20220909135103.98179-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Apple's ADMAC is on all supported Apple silicon SoCs behind an IOMMU
and has its own power-domain.

Signed-off-by: Janne Grunau <j@jannau.net>
---

 Documentation/devicetree/bindings/dma/apple,admac.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml b/Documentation/devicetree/bindings/dma/apple,admac.yaml
index bdc8c129c4f5..3b1e667f7ea0 100644
--- a/Documentation/devicetree/bindings/dma/apple,admac.yaml
+++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
@@ -49,6 +49,13 @@ properties:
       in an interrupts-extended list the disconnected positions will contain
       an empty phandle reference <0>.
 
+  iommus:
+    minItems: 1
+    maxItems: 2
+
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.35.1

