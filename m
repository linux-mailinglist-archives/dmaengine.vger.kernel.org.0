Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE86819AA
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jan 2023 19:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjA3SvM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Jan 2023 13:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbjA3SvK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Jan 2023 13:51:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E885C2C65B;
        Mon, 30 Jan 2023 10:51:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A74661216;
        Mon, 30 Jan 2023 18:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EE7C433EF;
        Mon, 30 Jan 2023 18:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675104665;
        bh=stmljKudyEFFluMAGIJvUJoacI+Yf44SQf2dOTbzvZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=ufCBQ9n2J9TX1VYyZ55mqURRQJ7lfY6bBvDnwfeM27kNWPGd8/7ndUTcDeB3koazM
         quW1HkujWecFZfJG7ZaiP3bqb8iFsLfgE3DDPf/VXJknp7CnIc1fsYnsE70CADAq8h
         Hh/dsyZlbkmTRfbNzCEOOTWiTL8xyxNQbC5LANQ7YC2ILmdIdj+YeNGD2eefUyPUHa
         K0dc/PnrqKEuA1OaA6Qfid+OV7CIZ4FgVZUksJjBIniz1bYFyKxwCS5kjhP0FXuKLW
         2x0s4/NzlfPwaRWl3vr3KdZiNGu7uwCm6Seiug+vbGWfN4i3Kdfp1CxHfLlst/Rszp
         ybi5bdIgb4ZAg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] dmaengine: dw-edma: reduce stack usage after debugfs rework
Date:   Mon, 30 Jan 2023 19:50:42 +0100
Message-Id: <20230130185101.2883245-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
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

From: Arnd Bergmann <arnd@arndb.de>

After the dw_edma_debugfs_entry arrays are no longer compile-time
constant, they take up space on the stack, which exceeds the warning
limit after inlining:

drivers/dma/dw-edma/dw-edma-v0-debugfs.c:280:6: error: stack frame size (1784) exceeds limit (1400) in 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than]
void dw_edma_v0_debugfs_on(struct dw_edma *dw)

Work around this by preventing dw_edma_debugfs_regs_{wr,rd} from both
being inlined together, which cuts the stack frame size in half and
makes it fit below the warning limit.

Fixes: 5c0373eafd83 ("dmaengine: dw-edma: Move eDMA data pointer to debugfs node descriptor")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rebase on top of dmaengine tree
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 42380bf64a70..6542060bd01a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -136,7 +136,8 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
 	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, dent);
 }
 
-static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
+static noinline_for_stack void
+dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
 {
 	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
@@ -197,7 +198,8 @@ static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
 	}
 }
 
-static void dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
+static noinline_for_stack void
+dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
 {
 	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
-- 
2.39.0

