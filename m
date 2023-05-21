Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8E70ADD8
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjEULsU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjEUK1S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFBB10E3;
        Sun, 21 May 2023 03:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F788611F6;
        Sun, 21 May 2023 10:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E49C4339B;
        Sun, 21 May 2023 10:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664609;
        bh=BLq9O0pAfUMUGI7sir1Wus9mHo0zlYVxEcjud2ZFuwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obhYptZiMtvVZVJlLF20TpBWHQwK+KLU/DD5Fd//1C8URO1K0xZnhXxazi/WNESxr
         XzO9yh2LPz2Cmnz+ywcbRJFpc5J3G4eeCCwTY8T7aIeEnN46DrcEKnuH88X70TGO2o
         hsBtcV8N2/hJNHagOsDdsDeW94yvF1CVcxthm4v2j0K7Pzb7CNP4ys1xWDLYgUOd4e
         2eJFczzUX7ZUo4TfdqtHisXtsM89mAc5tQQqkHSUsmw1yMiD8EmPS3PcnhjK0sLp9+
         V/zuL1oiw2RcYtIMKcaMFxUafhn8uI3iCk0XKP7CEjZQO65HxcCJAkU3N66gZDrt+5
         OS9wB7NqLQr5g==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/11] dmaengine: dw-axi-dmac: remove unnecessary axi_dma_enable() calling
Date:   Sun, 21 May 2023 18:12:08 +0800
Message-Id: <20230521101216.4084-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230521101216.4084-1-jszhang@kernel.org>
References: <20230521101216.4084-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index a19b651ddaad..4378134eea63 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -389,8 +389,6 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 		return;
 	}
 
-	axi_dma_enable(chan->chip);
-
 	config.dst_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.src_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.tt_fc = DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC;
-- 
2.40.0

