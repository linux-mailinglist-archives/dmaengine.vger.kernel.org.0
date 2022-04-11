Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3953E4FB306
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 06:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbiDKEsu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 00:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiDKEst (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 00:48:49 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE381FA55;
        Sun, 10 Apr 2022 21:46:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 29DA23200EAD;
        Mon, 11 Apr 2022 00:46:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Apr 2022 00:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1649652394; x=1649738794; bh=o8/btCfUanwlG9sLCfsKkCh5b
        CVDjWKu+ESIlPdD1uc=; b=G7T15Zi6Xi1QY1QvxNYjpWVTvbidno5Zcn9KpVI//
        AmbdxU7s5mYUkmsWpPODhsWeWBysKMOytuYeuqunG1KJD8OZN8ETu70mDdnR1+tQ
        /ZjIL+DUburiv50zkfLd9EJuB/aX02csaUCmMxVWntGwjuyhMuwxRHm94kQSmCtF
        zayxA9O9+EA2EFB1EH6i4x66p0uuWg7zRgAKxdQzlWAM2pJQX+D0jcWoxQGJxnG2
        AEFZ/ibA+cbom6PwDeWvLCo2YnOdA1GD+SJZkT+PaHJyoXpAT6gV+RWrwVFw7hTn
        kfbVwGLyb0l9akvV4jxcZsIL/U08YbPGcWKCsWfE7owbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1649652394; x=1649738794; bh=o
        8/btCfUanwlG9sLCfsKkCh5bCVDjWKu+ESIlPdD1uc=; b=QZqLp9+vqwsxvowaz
        PCNZbg44QJrUndDwvFy5/ftfGR4VOUSRuaoVI5/ihRwUfo4/boSGTVPKtOMJzdqA
        qTgbNvUWSp13daFPPYnR5A7g5+BysjI2Tes3ye3p8DBghJhPFSvRYrR/5olwGlGJ
        /oFakR4HDoyF5iyRn41xJLWkR95LxPvfEgtgZsx3ADNtt9wt914bjGxPnDzNl/d3
        NLIev7jdMnDX+AS11/Tw4zo0iMX9q2BTAeSvdoQ6owk5pkH0yvShjWT64aCZT8i7
        YHSuxBE+SdDEgR/kC7C/KpMmjMlOY/+Mb8uNKtogbH9dX25XYSk4+8/LPw7cd5UN
        W2ozA==
X-ME-Sender: <xms:qrJTYjZpms1DN9cNrigMEWgz1o3_sGnultGLJXfx3YVD2cfbg54BIA>
    <xme:qrJTYiZsA1_p09Ppj9WB9xqTE1b382jGQ4TelnTYQ38Bw8A-zwjqP3rxQ4JSpPZSf
    DeDk2yOzJJCo5m5-g>
X-ME-Received: <xmr:qrJTYl-IByY8hb5UtSSLhDDlPnm4duL_8k0oU1p-Tp4V6heL6lpaa3MD-jUhH65b5Y2tF4PkVAl89-pxw2BOAcZCWpGpUZKCk4iH7Usmvmn33m-tChrUuxSjoPbuGzbg6yYzsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:qrJTYprWMVS_ORTZn2Q2xzO3fuBqG-idvx1wINfCS7cw1YhtmG9hMw>
    <xmx:qrJTYup_Qj5YWt-XtL2zWdsJO5g9_97_Zc2D9uiJhAze5pcqN0SENA>
    <xmx:qrJTYvRO25l-VkwJXygBkbrpy7OqKWUNhZrCI4KupVjlQnXk6xYHtg>
    <xmx:qrJTYrjgUJrYwH0h2kRMkDQf3mN1wPR1AMbSW5MR06WqEbwYU8w5WA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 00:46:34 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/4] dmaengine: sun6i: Allwinner D1 support
Date:   Sun, 10 Apr 2022 23:46:28 -0500
Message-Id: <20220411044633.39014-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

D1 is a new RISC-V SoC that uses mostly the same peripherals as
existing ARM-based sunxi SoCs. This series adds dmaengine support for
D1, after fixing an issue where the driver depended on architecture-
specific behavior (patch 2) and resolving a TODO item (patch 3).

Changes in v2:
 - Fix `checkpatch.pl --strict` style issues (missing spaces)

Samuel Holland (4):
  dt-bindings: dma: sun50i-a64: Add compatible for D1
  dmaengine: sun6i: Do not use virt_to_phys
  dmaengine: sun6i: Add support for 34-bit physical addresses
  dmaengine: sun6i: Add support for the D1 variant

 .../dma/allwinner,sun50i-a64-dma.yaml         |  9 ++-
 drivers/dma/Kconfig                           |  2 +-
 drivers/dma/sun6i-dma.c                       | 78 +++++++++++++------
 3 files changed, 61 insertions(+), 28 deletions(-)

-- 
2.35.1

