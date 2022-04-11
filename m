Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE594FB30A
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 06:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbiDKEsz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 00:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbiDKEsw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 00:48:52 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28AC1FA55;
        Sun, 10 Apr 2022 21:46:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 99FF13200EAD;
        Mon, 11 Apr 2022 00:46:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Apr 2022 00:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649652398; x=1649738798; bh=gL
        LJXvPow1EyaPPDjH9fdOoNOR+1/wWYRGyiSoUxs+o=; b=uWTJmjUG7vENZM/afU
        2cf4iOilAoGPRqbcBRu9ALpyB+eHsRT3ogDmEs8uFt7BDGU2xC47oUSztbuatPOD
        +3lP+SeSp/iJAiE3dHlBMRNuNdj3K3ZXRZ+D6ziSx4m0zqmjrCzzZYT1PG/ukEg4
        CxAIJSq8RqRih8ookNt1kSdZHZxzmWQi+nFKgDIIW3uMBhBHfTsvVXsaRpxLo/SZ
        MASlC3srIL7d7P0T/CxW6cfKJwJ6D1hR75FHx3K+TeKBlmhgsKXb1hDzh1eSTAaZ
        bK2JH6v0RUETxf3phCNA3D9JaJLPcFBy8TCvIh7fk+qooACm3UcqTCAoizfX+cNq
        G8iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649652398; x=1649738798; bh=gLLJXvPow1EyaPPDjH9fdOoNOR+1/wWYRGy
        iSoUxs+o=; b=TOgUOZFimHb6KQFyoo1Lux1Vg5FMdsusJtXa0PUvaUs2Zx5xwXx
        wme4enkIaFsIM2ytdb1D1SliqBw8yhx76ryP3rnSvY1VTwYi6hZsnAsR+iWrywQ4
        CBKP486DUZV9xE8P+wTF4DtAAXPmaTQ9q7VHltEczNQw5XMJqJlOgvqDyEqa2IIM
        Nfz0aoAbAOO0hCDx5WKQ2Vt+k4TyjXe+70mzEtovRHP18PThRO2XXjzq7Da85Te3
        prXbvlh/AaGmRU246Z9Ns3GgKE6twHKthNNRnHZgLFVuap281okkC/cU1E3fKde0
        XVbohtlgj1m3qjhK9rdurYHKejLtUNAUUUw==
X-ME-Sender: <xms:rbJTYuOVNngPOvLhQiy1VkyUKJfhfxDjU7d-aiThWWEB0IqxmLzWMg>
    <xme:rbJTYs_fIYmSFT1KzXiazmShjuNKdxhyvMpUm8Sc1O4Ef6AxrgKOT11IJ6GFhdMds
    I8EWmkpI-WyqW3BOg>
X-ME-Received: <xmr:rbJTYlSdtJ4Q4qN_FYdSykTLSNSfvm74gDE1RX2YCWKBvZv47VBee1KTuKCn712bVoDEF7k6oHSrJqInu-lqTRVoE_Ue-Pgu-_Y0UbcA5N5dwSUDoPfyWuQrMOmA4fU0pZTx2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:rbJTYuvgk_7Bw0ZotA3Q1lVJlihQklqz6CJa20u6kDryTqHZb_VUug>
    <xmx:rbJTYmeq8Z-aWtlRpLSwmj_LOuSl_49yNlzFRpxbhRPjb3phLFsf1A>
    <xmx:rbJTYi202CK-qAgG-9PyzNvdGH9WiHcxEILwQYVUzGJ-tZ-TCCb5VQ>
    <xmx:rrJTYs3AUTWwGY_4hxwbJD3OKRP5D-Yegd_b31NZuzJCU-WfxnmsEg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 00:46:37 -0400 (EDT)
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
Subject: [PATCH v2 1/4] dt-bindings: dma: sun50i-a64: Add compatible for D1
Date:   Sun, 10 Apr 2022 23:46:29 -0500
Message-Id: <20220411044633.39014-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411044633.39014-1-samuel@sholland.org>
References: <20220411044633.39014-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

