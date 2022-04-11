Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ABC4FB30B
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 06:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244664AbiDKEtI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 00:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244624AbiDKEtC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 00:49:02 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386F835DD8;
        Sun, 10 Apr 2022 21:46:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D65D93200EE0;
        Mon, 11 Apr 2022 00:46:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Apr 2022 00:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649652407; x=1649738807; bh=ZP
        5rt6ptJXp+J3FSVn6SSTBlioBq49HeROquJ1oQ8ZE=; b=VVLaE0wwY3jVr6pHAn
        86xiTa+pLBsFpdprReDzrD0528rKtGwt40LTZyCo8+oQM12q2GMS/J4IrpiQZD3P
        qBaZnTC2eAzYewxlTMlQvEo+6lletQ/ZWymFrUi3gSf7UIA3AMDbO44MyfxMt2Kv
        D5c7etiujMEd5APGnpah+EcKp8y/vnN13JGKpoNJuniXmdA7oc+kvCXX/Hgol4RX
        kFD8AmXg5s9q262Cs3IafHInidFSlAfDNSUIRJpmYR2q4krxjyQmXEXrBUhjmhVX
        hDJeJhMZHBCpL1P80/m/myVVYlP5OCnGHHoqenaLeDboCswEmr2yNflkjEDfRK+b
        sdKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649652407; x=1649738807; bh=ZP5rt6ptJXp+J3FSVn6SSTBlioBq49HeROq
        uJ1oQ8ZE=; b=BkJyetYmAuD9u99LUzTowTwkBc6ZfabIBBcFxMDlGWfljctFEWR
        i/bbIH+RCXJTscvjvdyLfRwBB6wHlV7SNNzaDZdzL/bUnnd0LQGHPa9TwOqQtXww
        t/Z/jIG/Ja4/kUzxISGhUIb/HvpKWtiSG6KP3bRIPJ0D8kp38KwhzvnOU8sr6G/J
        n2CvUHQfz0u+7Z+thT2rbjrqDwti/wen4EcJ5O37IiJD8DPnx2RmPDVDvP9W6ab9
        qocNRt18CoLI1AzwN8GHFx6ShQHbm9nSrenrl4nz0RCWU+wrYXbiCnPIAkVp5Q0B
        1FZAHb0LpymIGjvXVIIG3SJ79rl0jdCLQgg==
X-ME-Sender: <xms:t7JTYhJEGiKL4d-gmY7AqoVflLGrxA6l88TNNJUfUKvoipWRQnSnAQ>
    <xme:t7JTYtJD5cL2g0jspK4cvf8sdL2tLMYsWDLp5UVJUNUXrHnNbsWLlG5ZzOZmeqnjH
    sy_TTi2EwD_L6LqfQ>
X-ME-Received: <xmr:t7JTYpvkhI8AAkMcXVjgnwQyCCuBhIyi4GaT6GTWFlsKwvvwJjHYTnDHV9OTeMpvGTusJCVmefsvjvQdXN21ulxlYazcH_0zHTx3CLwbfJxe8h1y49aB0nEGCEA7H4ZudV-NMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:t7JTYiYEwO6SEhHTtzD1DJuPxnHPGrzymmkANYjhMTtPNGGyb7vpyA>
    <xmx:t7JTYoasxy4LwrqRheXUDcjUtRHjwsjAci9W-Ky8rO7qs3d6BfHHsQ>
    <xmx:t7JTYmB1cxAr785eEedPbF_sWM1DbDskrfVMUmlHT1jjpj8Gg5UvoA>
    <xmx:t7JTYiCgUYJXSUpBKfTtugSS5pSp7VFpPb_f1qNftBf7Y74UOxWc2Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 00:46:46 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 4/4] dmaengine: sun6i: Add support for the D1 variant
Date:   Sun, 10 Apr 2022 23:46:32 -0500
Message-Id: <20220411044633.39014-5-samuel@sholland.org>
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

So far it appears to match the configuration of the A100 variant.

Since D1 is a RISC-V chip, it does not meet any of the existing
dependencies for this driver, so relax the dependency somewhat.

Acked-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/dma/Kconfig     | 2 +-
 drivers/dma/sun6i-dma.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d5de3f77d3aa..b6845303cf7e 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -163,7 +163,7 @@ config DMA_SUN4I
 
 config DMA_SUN6I
 	tristate "Allwinner A31 SoCs DMA support"
-	depends on MACH_SUN6I || MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+	depends on ARCH_SUNXI || COMPILE_TEST
 	depends on RESET_CONTROLLER
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index bd5958185ed1..1b95e93c14ee 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1277,6 +1277,7 @@ static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg },
 	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
 	{ .compatible = "allwinner,sun8i-v3s-dma", .data = &sun8i_v3s_dma_cfg },
+	{ .compatible = "allwinner,sun20i-d1-dma", .data = &sun50i_a100_dma_cfg },
 	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },
 	{ .compatible = "allwinner,sun50i-a100-dma", .data = &sun50i_a100_dma_cfg },
 	{ .compatible = "allwinner,sun50i-h6-dma", .data = &sun50i_h6_dma_cfg },
-- 
2.35.1

