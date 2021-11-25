Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F68A45DE0F
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 16:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354280AbhKYPzk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 10:55:40 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41005 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241268AbhKYPxk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 10:53:40 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B90343201591;
        Thu, 25 Nov 2021 10:50:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 25 Nov 2021 10:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=psUq8cfL3Y18aL207fic5TExY6
        JYclYjaN+xqGP4j2Q=; b=C0aNshtIvBR4og8sVJcEcyA+Die5Lw6gZEKfHRDBek
        uGFSqZ9KNt6L3E7hyVQYMGOp5fR3FBkVfOiZ4dFmOI6X73Gy/KNyVvodpoM4Sjcu
        26ymfJLKJ0s33swzibYoG7/1PUnA6cmm0Ww3Rc3kthrHCj+evn54cJtj00kYsS84
        zxrfHA0ck68h2KEsiY7Ssb8CzbRcPEPWi8l/3akZohScLRRq+bUn30W7bGIQw1wX
        zS1PIe1xt5jMhyBU135g9YrmQDKTCH+Ddk0h2G8qQgdEmq/uyn0jGvx5zwwN4qd+
        C2ulaYW9xOtS6y4YR9DJcZGZsGr/OFSs/44rl0MXfsWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=psUq8cfL3Y18aL207
        fic5TExY6JYclYjaN+xqGP4j2Q=; b=RILYT49/GubGbyTEYR7Pjla1NLKEriggY
        i9m2T/L3iFJQXwqdqcEq9rsJJhRWnxLF0Tr19LieEbHxzZhaA4NqXJg9m7Fm7SW9
        NfpMZPGiswzD/H/EztKGt6RtNfmNXQk0jmDxWgm8it0uBQrJbebKWwS/jNxNAKTZ
        ATFj2xYfMgSxxza4qZU5IbU2TZLjsifU7eSA8lHegjEqJfGfSngXinbEWwGolIan
        J2HIUt2jXpLPbB/5vEydPa19fCrQLHxpgT9jjAPduyIPn11xngPP4XO89QtBX3T7
        eSpLdgGfinifqBWiqv9BjVLbP7GILW6gelAUeyni5BkHTlBKN6fMg==
X-ME-Sender: <xms:wrCfYUTMHgeWkhdhQ2Z93rkIHN8gEF8aezDJZWOiM7YwyItFWkEbaA>
    <xme:wrCfYRwtSEKRMxnOMXeKtiqO56QKU02EzgXjt9N5XUzfMCn8hQM-8WDlxmtSjOlmw
    hxXdGW-a6xx7QIdTw>
X-ME-Received: <xmr:wrCfYR21cubg5fXIt5qUOdjYs0sIbvxFl9l4JHN9EAvfly28fKxL7T3dYmhBOlxhxyWkHCosAd2Q1s3amNYuq216fvTAHjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrhedtgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptehlhihsshgrucft
    ohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhephedvfffghf
    etieejgfetfedtgffhvdehueehvdejudfggefgleejgfelfeevgfefnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqhihlhhishhsseigvddvtd
    drqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:wrCfYYCXLo-T0sdmR_F86AnXhdfQaiwvkuSyUUIqWtPnzTLb-e_aJw>
    <xmx:wrCfYdhFN7kbTwD6kiS6zmdltJ091WqpPVGMszR2OcpDB1rZ5_NIgA>
    <xmx:wrCfYUppT7mdg9N1vqbJDvu2GrZ9ZnLE0tccYB4bXus2Iz-fc5OODg>
    <xmx:w7CfYbZwmmBejz_UZz_lrDk0OBEiFY3_j_jYiVH6HxmMff2NOAn8gQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Nov 2021 10:50:26 -0500 (EST)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id E41761339; Thu, 25 Nov 2021 15:50:24 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Peter Griffin <peter.griffin@linaro.org>
Cc:     Alyssa Ross <hi@alyssa.is>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI
        ARCHITECTURE),
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: st_fdma: fix MODULE_ALIAS
Date:   Thu, 25 Nov 2021 15:44:38 +0000
Message-Id: <20211125154441.2626214-1-hi@alyssa.is>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

modprobe can't handle spaces in aliases.

Fixes: 6b4cd727eaf1 ("dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 drivers/dma/st_fdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index 962b6e05287b..d95c421877fb 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -874,4 +874,4 @@ MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("STMicroelectronics FDMA engine driver");
 MODULE_AUTHOR("Ludovic.barre <Ludovic.barre@st.com>");
 MODULE_AUTHOR("Peter Griffin <peter.griffin@linaro.org>");
-MODULE_ALIAS("platform: " DRIVER_NAME);
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.33.0

