Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE06E30E9
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjDOKtL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjDOKs1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192E89EE5;
        Sat, 15 Apr 2023 03:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60E6861579;
        Sat, 15 Apr 2023 10:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD443C4339C;
        Sat, 15 Apr 2023 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681555620;
        bh=/WoZ1V3BfTduJ79xfQ4OOwggeNMcUtHeDcPNMKwKbuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WP8CTQVnMcRN7Gd9IuLqyX+rnXcuhpFrbyhjqGPPcCx3cq8kAFDEVn3ClbJWCE89W
         0VO8wRRGES8um3pGV3K2Jr4IWaIV6SKrNRUgTAs/5J0XRTXqThjua/0t/tgr6D7QZh
         JlCBWUIvKstKElPZnSc7EyDpkDXCzK2q4EOw2gWEGTA+cNeQgjNYh/z0nMr2LmCQdL
         dxAAmPf3+a8Q2TBzioejCjNCFBCEy5DgEL3ggzHdz6jlBQBSYShMpOyDCPgG4VYnph
         nRPfLq9P29AmTZb6Z+urSCPamJ1idiwMaxK/uylnRfCaBGX+xMZCDWWoX3z0V5SnJq
         QsLvv909eF1Cw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] dmaengine: dw-axi-dmac: remove unnecessary axi_dma_enable() calling
Date:   Sat, 15 Apr 2023 18:35:53 +0800
Message-Id: <20230415103601.2979-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415103601.2979-1-jszhang@kernel.org>
References: <20230415103601.2979-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dma is enabled, I.E runtime resumed during chan allocation, and
is disable, I.E runtime suspended during chan free. So when starting
xfer, we are sure the dma is enabled.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 56f12dfa410d..891776528619 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -382,8 +382,6 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 		return;
 	}
 
-	axi_dma_enable(chan->chip);
-
 	config.dst_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.src_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.tt_fc = DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC;
-- 
2.39.2

