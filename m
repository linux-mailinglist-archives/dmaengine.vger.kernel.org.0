Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0398150D3FA
	for <lists+dmaengine@lfdr.de>; Sun, 24 Apr 2022 19:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiDXRbO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Apr 2022 13:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbiDXRbK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 Apr 2022 13:31:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BEE14AAF3;
        Sun, 24 Apr 2022 10:28:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F01C5C017E;
        Sun, 24 Apr 2022 13:28:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 24 Apr 2022 13:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1650821289; x=1650907689; bh=HV
        olP6ZkMyb65XG1QvbeY08lLQkAYv1LBjKVDIgum5k=; b=YJ+7dCtdDGuT9u3w5g
        5qjQiu9grty/l+q8FCL3g/SAefYxN4xDgAOXAqfVG29eNasMrYScvpXlqtONbjpJ
        7Mhf7uBXBjYVViSrst0u15HsOhe7mloWQ8JFmfdKtaswVo7yh53NnjpzhHdDnZve
        fGjSqIY/lbMqIihq3sPS4RZAQTQEmZS3mP68H7YpW1bQmo7pHUdfBdWPOwHK0hr2
        Fdp6z5L14lpxyFs2qncBp1oYJwIULb8HAKTvRb0zuZUox8X+hrn4IRKqSBP2gi5L
        z7pV4OdAm7TZWfaQI5ILRNyAsVJicQNYbZmjuHGusIRWMr/+lBVpi4C7TgWreaBs
        VeHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650821289; x=1650907689; bh=HVolP6ZkMyb65XG1QvbeY08lLQkAYv1LBjK
        VDIgum5k=; b=sXHT+ylENl6l8k7rlDj9Ox832v31yLcMK4oGuAZ8+YYaCF6awLb
        eDgvCKo2M6Dvl1hpUGYIcOG0lA0pjZSRf44YLZFZ+th7FwK6y/S/3YlaqjjFmji9
        RDDiHSMJvCBnrz97iBn6UeoNXd+RfLezQx3lStqRUgrChPAGoRizgimejzEGYVaI
        KEg0fOW1sBk4lg2yaAJCyQoDHqquRVZgm1tU5gpOTLQPfsQsICgtBwvD1ZhFjMVy
        7qze4h3E2uboe2rmMNgbXCmdT9MjCSFZShxzjzXApyUVugCCMLs8wjOwrNaZsOtB
        w7f3g+NmiMxmqlXbaoCdDUYqaLNiC0gCS/A==
X-ME-Sender: <xms:qIhlYqTT_pnOx1pZOdd8vzq6WN6O_WWliGct4qlYJR6lWjlxOGjVZw>
    <xme:qIhlYvyQyx7vN6neWoYsx1DdWTCsGsAghVy56lHHanO_aqHUiMB11TwWTYGwZnuJb
    S4rnXP20yBgsSe8Yw>
X-ME-Received: <xmr:qIhlYn17nyjAz1YhGm7Q4HE06KbMb9YFYRt3EqXsfQFmWR1toGoxYTcwVxLpazHsF558wTNuIxvQkH2wnUOyukkbqSm2gvpZG4S9hthKegTeTWjRfUgigE40JCAPMPnrHWh6mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:qIhlYmBO-RauKQmJrmZ4qNbYsI7aQQeVAsyeksyHQBhpCKHdvVdh8g>
    <xmx:qIhlYjhjVIFOwKD_pVLNfRDKT6UlDhiNCxyBvgP0ytBLJ5UAsi70Tw>
    <xmx:qIhlYiormWo_jL8GRc7TgEu2tmr83XFPlMDBZqsLFgmAZmqKmi62gQ>
    <xmx:qYhlYmpc2NBBmQoWcyfmTFQX7pnke2p8D-RtudQmNaugTLeJ1_ZqVA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 13:28:08 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 4/4] dmaengine: sun6i: Add support for the D1 variant
Date:   Sun, 24 Apr 2022 12:27:58 -0500
Message-Id: <20220424172759.33383-5-samuel@sholland.org>
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
index 1eb3bafa7324..b7557f437936 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1271,6 +1271,7 @@ static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg },
 	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
 	{ .compatible = "allwinner,sun8i-v3s-dma", .data = &sun8i_v3s_dma_cfg },
+	{ .compatible = "allwinner,sun20i-d1-dma", .data = &sun50i_a100_dma_cfg },
 	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },
 	{ .compatible = "allwinner,sun50i-a100-dma", .data = &sun50i_a100_dma_cfg },
 	{ .compatible = "allwinner,sun50i-h6-dma", .data = &sun50i_h6_dma_cfg },
-- 
2.35.1

