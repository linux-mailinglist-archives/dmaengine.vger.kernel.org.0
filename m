Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA9693819
	for <lists+dmaengine@lfdr.de>; Sun, 12 Feb 2023 16:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBLPlu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Feb 2023 10:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjBLPln (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Feb 2023 10:41:43 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F712F09;
        Sun, 12 Feb 2023 07:41:37 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 85BE926F790;
        Sun, 12 Feb 2023 16:41:36 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?=A1er?= <povik+lin@cutebit.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH 15/17] dt-bindings: dma: apple,admac: Add t8112-admac compatible
Date:   Sun, 12 Feb 2023 16:41:25 +0100
Message-Id: <20230202-asahi-t8112-dt-v1-15-cb5442d1c229@jannau.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=j@jannau.net; h=from:subject:message-id; bh=S0Iix+sqEiNt1+LztfuVpGzFysCtRTtL+8qXnHKS/io=; b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuSX7Cctj8mFrO69buzrXLdi+51fD+8LhFq82vFXk/ls/ PQL8ilnOkpZGMQ4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExkjyPDP5ujN1JdMjc/XLE8 a+u13JyrecEeyw91tESm/Km5Pve3gh8jw4apSS2mV070POnZbih/9ZqwVb/OqtSSz+WtGktKn++ L5gcA
X-Developer-Key: i=j@jannau.net; a=openpgp; fpr=8B336A6BE4E5695E89B8532B81E806F586338419
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The block found on Apple's M2 SoC is compatible with the existing driver
so add its per-SoC compatible.

Signed-off-by: Janne Grunau <j@jannau.net>

---
This trivial dt-bindings update should be merged through the asahi-soc
tree to ensure validation of the Apple M2 (t8112) devicetrees in this
series.
---
 Documentation/devicetree/bindings/dma/apple,admac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml b/Documentation/devicetree/bindings/dma/apple,admac.yaml
index 97282469e4af..beb09f115f40 100644
--- a/Documentation/devicetree/bindings/dma/apple,admac.yaml
+++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
@@ -26,6 +26,7 @@ properties:
       - enum:
           - apple,t6000-admac
           - apple,t8103-admac
+          - apple,t8112-admac
       - const: apple,admac
 
   reg:

-- 
2.39.1

