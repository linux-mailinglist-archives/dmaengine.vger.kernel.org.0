Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CC550D3F9
	for <lists+dmaengine@lfdr.de>; Sun, 24 Apr 2022 19:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiDXRbG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Apr 2022 13:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiDXRbF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 Apr 2022 13:31:05 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0819A14AAEB;
        Sun, 24 Apr 2022 10:28:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 66C2F5C017D;
        Sun, 24 Apr 2022 13:28:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 24 Apr 2022 13:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1650821283; x=1650907683; bh=gL
        LJXvPow1EyaPPDjH9fdOoNOR+1/wWYRGyiSoUxs+o=; b=FBiV7wxx+kBiVJhw2U
        0nRo8+CDjUOHCyi5GqiRsWvwOig/uYHw1SlQBbZX/iXWCKJKPI2yRxePjoRjiFb8
        AuCykvcWThzH0gCEts2FzQj7rR9JFMmqSj7T/GEL2GVelwztcc/+q5Z1xCWVGLNo
        e0idrdtcZi11zWn++NIGIPPijXKKJDX55pcux2oLXK511IhlipsnDJjn8DZSqQLh
        mYdF8Y2ldSE6LYE1fnS2+XbUztwulNXvbH5mgMhuG6LfFoWcK/VuFbaCojfK8meD
        ckIFqiP9vntIpKcVvpoy6Ko+uKloWFyuJIVH9VXOskhi7pNvz+De+4fpdVmUHdw5
        6kYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650821283; x=1650907683; bh=gLLJXvPow1EyaPPDjH9fdOoNOR+1/wWYRGy
        iSoUxs+o=; b=pOuiUpJw2LCW2hxJZeEPCCiZskRIeJvHr8tHUqpFVMCXzoOPk+p
        qd7VA6xlZHvsI5ubofpt4YX/5MerC/hMV7J0tsw6Hf8UHHB+qd1hu1q4gqp6nUxv
        E9nQpN3nWntW9rsysxl5ale3AoBGmh7TZjLoixtubltRZ5C4KLK0ltOZQJFWmCFw
        BulYuOLhE5kuV8POEG9/obxDFHW1mYA66KsWOyTbEyeRLlMoHL53rH4Hu1Aiilib
        eeu1Kh6W/c8f4WHX5EiV9wyNg1DSEt+0tfsErjWqHEnVpXsb2H1ZlpB9dykPAKdJ
        BEGFDzX/vpptylkiq/i0za2IfYJsrUnGcgg==
X-ME-Sender: <xms:oohlYjm0MocGpVmkbYd06wxk9qVdm0thxZqjQ1tLJGxIzmkboUXbKQ>
    <xme:oohlYm0OBPlyamLWlxVS7OBqCPbl5YwDhARC5SsFZQpV8CIBPM0u5z72KtxxJ1vdf
    xk1UZutf8K3KolOIA>
X-ME-Received: <xmr:oohlYppqjHWut4gijbd6LZk6c1VfhC0dlv7pgE9r2Iu_MyNd15qH6-lQ471-nXUVvZwwSG46LrUtw9dSwmUUcJV9STBYcH78PMN7zFe8uq-zVYW-Uv0ZbpbcRCzLsb27ctFQXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:oohlYrkra0vBcOMaF4YDhnCoRkwCN-Dts-qaba8rtMNBUCr0cfmjog>
    <xmx:oohlYh2YuV533KevEednzvOOw-tZLuiB8gJ3tSBQPxC7mQzsjqxbfg>
    <xmx:oohlYqtuUvXZu5gTcMTDYnaYHoSa7oS4kNHWBn62Uyl4I0AKVgwuDg>
    <xmx:o4hlYvORsR1KXIgaT6IrxpfoUyVu4TDVq96ajbhreip-j1JH0op_Dw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 13:28:02 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Rob Herring <robh@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 1/4] dt-bindings: dma: sun50i-a64: Add compatible for D1
Date:   Sun, 24 Apr 2022 12:27:55 -0500
Message-Id: <20220424172759.33383-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424172759.33383-1-samuel@sholland.org>
References: <20220424172759.33383-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

D1 has a DMA controller similar to the one in other Allwinner SoCs.
Add its compatible, and include it in the list of variants with a
separate MBUS clock gate.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 .../bindings/dma/allwinner,sun50i-a64-dma.yaml           | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
index b6e1ebfaf366..ff0a5c58d78c 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
@@ -20,9 +20,11 @@ properties:
 
   compatible:
     oneOf:
-      - const: allwinner,sun50i-a64-dma
-      - const: allwinner,sun50i-a100-dma
-      - const: allwinner,sun50i-h6-dma
+      - enum:
+          - allwinner,sun20i-d1-dma
+          - allwinner,sun50i-a64-dma
+          - allwinner,sun50i-a100-dma
+          - allwinner,sun50i-h6-dma
       - items:
           - const: allwinner,sun8i-r40-dma
           - const: allwinner,sun50i-a64-dma
@@ -58,6 +60,7 @@ if:
   properties:
     compatible:
       enum:
+        - allwinner,sun20i-d1-dma
         - allwinner,sun50i-a100-dma
         - allwinner,sun50i-h6-dma
 
-- 
2.35.1

