Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A587E54EFCA
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jun 2022 05:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiFQDmO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 23:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFQDmM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 23:42:12 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4BA64D13;
        Thu, 16 Jun 2022 20:42:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 56BD75C00CC;
        Thu, 16 Jun 2022 23:42:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 16 Jun 2022 23:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1655437331; x=1655523731; bh=t1gILM+a5sDOSWsDsWFr57f86
        QLkg7frBwJzEs01CII=; b=tCHDJakn7Bd+IibM5flhnH8eTvqERDp7Q0WHcwfaI
        Viz6NyrT1g/A/aS0nfAQEXZ90DpfzkW+yDxU5kxzLLlGR5+lozlNX0i5cv8NGOZ0
        HYH24QNKgkZQSeUNkFU88TXA6x4WVL0CaVkj3Bg0SolrAwF7BqTqJHGuRl/yNQz5
        PQkjNYrpFR8jgTRS5ecTCfkXC4Bn4UPy/CtbxRFHMqXnxujPonVkVLAu5Q1Qz+TI
        IkEHOhKkRyXZdJVNIC930L4b44zNluYHgahG8168X9O8ePrxK+QRiMlAvQ4e2eOM
        KSH7dr8zClp2pHO8iyHLSjD3rgMKV3kahRU6waCsqhS1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1655437331; x=1655523731; bh=t1gILM+a5sDOSWsDsWFr57f86QLkg7frBwJ
        zEs01CII=; b=N7rNsjHy0bTYY8ZUQZ4OvCpJ7GbNfju+daNgvWf+eFgHxINNjo/
        3WbyJXCOPDVys53CL7PXwfhm3n0USpkVtiUTmbfRMXXhZMs2eJUxIozu4HXwC8H9
        0c8GpP2guJ8A/ckqpaSzhHZflv7m2voYCf/MzlqfFJ11lMDISOUwqtKQHtYKG2K4
        mmoButoCsU/dFk4h7eGu4VJBvMa25YVYbmfjnuU9KGiNMPRICLukBnsnQgXEi1rc
        7+fPpH0l2UkqWFYBLejx6hdg1BfZtdVZOeuV+smum6ouYfvt70JAPgAeeXa+LXIN
        FvKHssRRYii0MtAHrwtqb9VYzo7Oc1oU9nQ==
X-ME-Sender: <xms:E_irYpP_RbQfwzdSeK_XKR3VPBfmRkQ9weKOxh4scTh3YVOT7vR4Ow>
    <xme:E_irYr__5QKofzrmFf0E28r5VjAvpUD8vWm8MJfvNpoihEjgaAPSLQRhiKCVsiQtb
    UG2yE7FOPYUF0PHkw>
X-ME-Received: <xmr:E_irYoTWJz1wSOh4p6l0zIeDdqm89WAGJKPLWxtoqakQYF_FWudcbU3Ih1AOpKNai2uo1NQPNILBxjJmIAJYhgH5aLq4RuiVGjQo7RsrhO9toyh4okHlx4oLiY4RBEsShT_fCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvgedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:E_irYltaRFM9IsopLzXPHjDMYoUEn21epauftX5KAZOjBFG_cOHX8A>
    <xmx:E_irYhf_b0-0nbzygD6sprHgPHZjnzophRwko1KOgYyBnrTjB_JlLg>
    <xmx:E_irYh3j-A07RogbevLC3qu2J8IMFV84hi8rhjWcWK9em_itv6W9uw>
    <xmx:E_irYpRvzuvalDXJN4xG0PM45InMrLj--f3fD60bTsmsPdBR4x8n0A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 23:42:10 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] dmaengine: sun6i: Set the maximum segment size
Date:   Thu, 16 Jun 2022 22:42:09 -0500
Message-Id: <20220617034209.57337-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The sun6i DMA engine supports segment sizes up to 2^25-1 bytes. This is
explicitly stated in newer SoC documentation (H6, D1), and it is implied
in older documentation by the 25-bit width of the "bytes left in the
current segment" register field.

Exposing the real segment size limit (instead of the 64k default)
reduces the number of SG list segments needed for a transaction.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
Tested on A64, verified that the maximum ALSA PCM period increased, and
that audio playback still worked.

 drivers/dma/sun6i-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index b7557f437936..1425f87d97b7 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
 #include <linux/interrupt.h>
@@ -1334,6 +1335,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&sdc->pending);
 	spin_lock_init(&sdc->lock);
 
+	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(25));
+
 	dma_cap_set(DMA_PRIVATE, sdc->slave.cap_mask);
 	dma_cap_set(DMA_MEMCPY, sdc->slave.cap_mask);
 	dma_cap_set(DMA_SLAVE, sdc->slave.cap_mask);
-- 
2.35.1

