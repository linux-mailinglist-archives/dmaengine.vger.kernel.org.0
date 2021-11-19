Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D944569BD
	for <lists+dmaengine@lfdr.de>; Fri, 19 Nov 2021 06:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhKSFaQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Nov 2021 00:30:16 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:41517 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232445AbhKSFaP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 Nov 2021 00:30:15 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0752B3201C2F;
        Fri, 19 Nov 2021 00:27:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 19 Nov 2021 00:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=+xYtIdU+vy/w4
        wAaJntDKQbRHQnV1NUkDSd39ihXndk=; b=G/LKt7w71/vqGhEITYI+sJF4UOnPH
        4t+HJ/6tuUSMAGB3+Yx0X9aZ58MwIiLvll30eMWGWrhYFcwpUUPZCzt12gkJ1Tye
        /dH0LprxtmqKwpl5bxmLxpNXyrC78Ncz7Km/sZJezRY1uTC9pWXfbDBrfOA9W3m7
        KAm4veohEzlsQFwph6dZQUFxZ2C8tjUMeESxgLsoiSxyDOjb9htXgB2UdnBsGSdo
        z9y1XqUD2hlyAmK+30+27xAopfSJc2c8CyR8m0rCOlFZLBruUyY1fJX3hK50bkfs
        OFf1a4gErf73kI58FWYi5+gO2NIdRRSdwmLyXm5/pYmnMBueI7xF9r6Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=+xYtIdU+vy/w4wAaJntDKQbRHQnV1NUkDSd39ihXndk=; b=av0f56yW
        2ymTz2VX+l1oV5FBu4lfAAJPr05zR84DdL7OfYwBMUOSezhw2Sd05L5gdNUDnZq6
        5q0oBbWx3kHyOdwUrbjTqiHfgzOOeoWN3IS1aLYzQWYR/SWgIkNLT0mz6vDgHz0W
        q9R+s8UxbFQzdnj4YE+F/rCVpZQweR5RazlKO1MGY725boEiZNAMo0s8oB716/+f
        3CKtBP1MFRl8XdvtzY3BTBmFIcNitsNIgVQWn3hYXNBgDsRPzRdxwELqOYDjbAMY
        X5xrtg1lDUl6QhHA7EiWP8xSzK6wVhMRVaHKWdt3L3GFvdE4pxIbAF34qFA6AgGi
        PTj7fFkYIFChmQ==
X-ME-Sender: <xms:sTWXYbLa7ae8G4fj4Stzk10YT-Hk3I3HvO6VIbMJ7V8YV_oNQOp6Dw>
    <xme:sTWXYfIl0HIeD8fpDEm9e1LMSkvx9uJfvRmRvKRqRZrGlbYJfFzcXlgx-jZ9jHsCg
    q8720MmM7paM87QCg>
X-ME-Received: <xmr:sTWXYTvsL7P8MlR4KYh_rf73f_OL5CwBk2OVDuWYwuszse0rhe8dEoJxr3-ys4Fd9SwynARkuTZbK0l85uvJ61fEtWr09ZcCqVfrghTd5VRGN63YnGqqVoEDzW6plljhreoekw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:sTWXYUYD7I6xONRNo4lsu9LbUDHnz2obklWm9VS2S0Rcd14ZwT8OkQ>
    <xmx:sTWXYSYNOtorjRH4L7dd3565WB5LizZ-3KsqBw0pVGRAZldypZgp6g>
    <xmx:sTWXYYBZdqZkHT5R9X-PIIqL_ENs6SRKM51zNUXTE95oD4nLeN0c0Q>
    <xmx:sTWXYa4QN6sGgVMd66xynbLVm19Ytk2Ud0Od6CjXHlgkBJ_QNuEQFA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Nov 2021 00:27:12 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 4/4] dmaengine: sun6i: Add support for the D1 variant
Date:   Thu, 18 Nov 2021 23:27:01 -0600
Message-Id: <20211119052702.14392-5-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119052702.14392-1-samuel@sholland.org>
References: <20211119052702.14392-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

So far it appears to match the configuration of the A100 variant.

Since D1 is a RISC-V chip, it does not meet any of the existing
dependencies for this driver, so relax the dependency somewhat.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/dma/Kconfig     | 2 +-
 drivers/dma/sun6i-dma.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6bcdb4e6a0d1..1ab216054694 100644
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
index 8c7cce643cdc..795cce445532 100644
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
2.32.0

