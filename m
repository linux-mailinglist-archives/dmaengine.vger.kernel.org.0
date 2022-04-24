Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5187E50D3FB
	for <lists+dmaengine@lfdr.de>; Sun, 24 Apr 2022 19:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiDXRbG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Apr 2022 13:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiDXRbF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 Apr 2022 13:31:05 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F6D14AADC;
        Sun, 24 Apr 2022 10:28:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0EBBC5C00FD;
        Sun, 24 Apr 2022 13:28:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 24 Apr 2022 13:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1650821281; x=1650907681; bh=tYQpR+3L6sMfcoMlRTkL4+IjF
        VYToJqJPQNAaXV+C1Q=; b=brfaepI2esfiUJBHZKFwDTUodFSi+zRQjh1QVJCLU
        ZPRodzqrEHqqemZbwc9zuUV95g6bZbiB3lm0pTMtmaap8wOoxbDCreYSd0pLwEqI
        yzvOGlF4VbtnNCpHLD7w2ewMdjxyng5798TWml5KFk7Dk5KdW82o98jRDieTzLXJ
        xDVdJOwuQlDbnuLPnGPS/Os4xce/gIlXWzg4u0xszhjaUe9qnPH0CZp7/532RTRR
        Yes+f/8yCdu97dx2LaQxawHVs0EnnAy6yopTRD/TEuMp6No5AuL3ZmKQeCzFpPSk
        uO0kqP3h9f/L5qxgBu4A2+KGP86LV90rTARM8LeltdEEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650821281; x=1650907681; bh=t
        YQpR+3L6sMfcoMlRTkL4+IjFVYToJqJPQNAaXV+C1Q=; b=vf/kQnjIeQuKHIr92
        2oNqCWJ9ADX0mzA2m9c02JHismymbPlsJY7/PwKtGAm4Lmzhea7iFVhWT+SaS4rO
        0g/kTR/7NykwQxM1YYHtkst/MeQWItLZWPFvBBdqVce6U8qx/vy0td0x/XUyJCq0
        y7m+PU+gQn+6dCgFine9DbtccvDpM0mjriWznr55tAAx+lnXY2UOL4nQKAKfTssp
        OerJaYs7uCrDyEX/7XcMMtWetguCATeepAI2TSjVIru1qcVdUmhmnpiwKC5lGYNo
        Uc6FYWexXnYmw4s110kRS7nGXpLbxtkWkU7abwF51JVlTIeXGRMeyg1wMuJedhNW
        TrGsg==
X-ME-Sender: <xms:oIhlYvvUYPI4nvl2pjZNU1JBbnzOfk-sgRFNX3uAf5JaLGfaLpk32g>
    <xme:oIhlYgdN7nuF1HXZrcu9MM4MH0KT_AnaNMvHA_fyHXm5M2MSk08Kn63cKob2HQSe8
    Pd3wezjRS4szrZ3Nw>
X-ME-Received: <xmr:oIhlYixuf-kBWft_wqNTcUZAWAq6AuYF890lGce8cb31NhnizOC7OM0vRGOA05Y1-N0ZDSc3zgUiUgqcqBJU6xZx7-lECXEW-s7u6WKkRCrmcGMNv6o9pbXzyqJVtVIVG6DHtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:oIhlYuPcsOVxaCGxAw9RoTq5KtRSLLt9R8JTtx87m21Ftoe8kq6guQ>
    <xmx:oIhlYv_CSWpzXKU4WGGILxrl2jGVbzd9de4dSHpjIOhc-K5pKf1SUw>
    <xmx:oIhlYuW8k-zgRBWcmKqSOl3L2ePZnjjjcyhmTRs99T0BBe7piPMaAQ>
    <xmx:oYhlYg0TMxyhBWvUjjmu-k_fm60qolVIg4vCl4mhbqIRMIu34KU1cg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 13:28:00 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v3 0/4] dmaengine: sun6i: Allwinner D1 support
Date:   Sun, 24 Apr 2022 12:27:54 -0500
Message-Id: <20220424172759.33383-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

D1 is a new RISC-V SoC that uses mostly the same peripherals as
existing ARM-based sunxi SoCs. This series adds dmaengine support for
D1, after fixing an issue where the driver depended on architecture-
specific behavior (patch 2) and resolving a TODO item (patch 3).

Changes in v3:
 - Fix format warnings
 - Fix shift warnings for 32-bit dma_addr_t and 32-bit phys_addr_t
 - Make explicit that v_lli->src/dst only hold the low 32 bits

Changes in v2:
 - Fix `checkpatch.pl --strict` style issues (missing spaces)

Samuel Holland (4):
  dt-bindings: dma: sun50i-a64: Add compatible for D1
  dmaengine: sun6i: Do not use virt_to_phys
  dmaengine: sun6i: Add support for 34-bit physical addresses
  dmaengine: sun6i: Add support for the D1 variant

 .../dma/allwinner,sun50i-a64-dma.yaml         |  9 +-
 drivers/dma/Kconfig                           |  2 +-
 drivers/dma/sun6i-dma.c                       | 92 ++++++++++++-------
 3 files changed, 65 insertions(+), 38 deletions(-)

-- 
2.35.1

