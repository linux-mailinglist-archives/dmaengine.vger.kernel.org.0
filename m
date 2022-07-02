Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D9563DEB
	for <lists+dmaengine@lfdr.de>; Sat,  2 Jul 2022 05:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiGBDTL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 23:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBDTK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 23:19:10 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957DB31920;
        Fri,  1 Jul 2022 20:19:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 37CF65C0481;
        Fri,  1 Jul 2022 23:19:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 01 Jul 2022 23:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1656731947; x=1656818347; bh=tkkn7H5KuR11DtRO9e3GKNcav
        /pqu6bhTLvUj+dAf2Q=; b=d18xCvPJG2YTZLN+2pqHslXYMa/slrpgHGGKA5izv
        ROTpjaDIuk0AeQC3LtRluxniSIVtBlQEkTTYdG6oQBwSDQGVYZn61KiUozRz8y5B
        6h9Wj3ll5Sn5R6ABfv9GQHPJLIes64vQccpRG6mbZJIWI2YWcQh9Gr39AmIyw4jy
        FwIrzu8mRQpeVLWOpVSY1M6LQCE9OOChDRsANTa2Qk6fJhLaSePsdZJzWtgWeVny
        v0Is9RslW8yLctAYxEvsutARMr9hyuV5Uyow37rDw/SzynvM5mtXASEd0SW4W6PS
        dGpcBgIztfDFJCv6Qtdw3wX+b/swg7RX7HFlHhhi/am0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656731947; x=1656818347; bh=tkkn7H5KuR11DtRO9e3GKNcav/pqu6bhTLv
        Uj+dAf2Q=; b=n4IDn3TZZJi2SIgct/dfULfRQnbBWEnMFeyHfSCml7rd/QhVq2d
        COzs9XBC6jzC5iNy1c/GoCD4/rmyNMiLFE77g9wQfUXs5oE+kPtdXPkb3Nu1klrA
        T94xOwGe42NwQLCZAb0jQ3ChAY+C8RDc8iJXOw6lJI27PxQZ/foFNjkm7gUSMCUv
        ebo6ZGr6rrjjEBO9jCaU9otbAyuScsuCGD7cZzE37/0IXMHRSY2FCt7GGdiByX/H
        AxPeQTrSbvav5GFsQk9P9nbQ5qUX57VWNjFjdoMUtt4BMc5de/gw/2im+GxkFISr
        o7CMwgdAMmbnDJ+dooIzHc0wgWmhUV7gkXA==
X-ME-Sender: <xms:KLm_YuZOfEf1B4ct142S9uZXaY6Oq7iWNhIvbPcRD5JPULgyWqutnQ>
    <xme:KLm_YhZYzpZ4jtIBZPDMHlwMgfUoheD4UT6d9DMSe6eUaFDZYUQ8F0IC6bVivRANT
    q_Mbdndm-n2aOUqFA>
X-ME-Received: <xmr:KLm_Yo-dp9gvLdbPlyJHmOMftoG2WaX1FMtEK5VuYXkQa98bGVOGMTNkhfEuKDLH6iNJqC8lKVTWgltZbtpsPbj71tfVbdKV0qZcmZLZN07I0H9QkF93aOAdR3WD2ZwzBTGdfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:KLm_Ygr8o12zYFjbMgUhvr69ifbYaLN3lIbz5kaCv--GPYI46yY9FA>
    <xmx:KLm_YpoQv3SqvaqsvuitSSMK-gNdcPcJ7TWdhOFYjhS5dSDN9C7kaQ>
    <xmx:KLm_YuQJI7mUTT4XJv3zMfoi3zoLfWAjidtuFbEFOogf-amlf1cxQA>
    <xmx:K7m_Ymj90vjLauS9j6bXtP-xM_RtDybOdkTl3HlQZgFrBR0vC7TzOA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 23:19:04 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] dt-bindings: dma: allwinner,sun50i-a64-dma: Fix min/max typo
Date:   Fri,  1 Jul 2022 22:19:02 -0500
Message-Id: <20220702031903.21703-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The conditional block for variants with a second clock should have set
minItems, not maxItems, which was already 2. Since clock-names requires
two items, this typo should not have caused any problems.

Fixes: edd14218bd66 ("dt-bindings: dmaengine: Convert Allwinner A31 and A64 DMA to a schema")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
index ff0a5c58d78c..e712444abff1 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
@@ -67,7 +67,7 @@ if:
 then:
   properties:
     clocks:
-      maxItems: 2
+      minItems: 2
 
   required:
     - clock-names
-- 
2.35.1

