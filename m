Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED25B680E86
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jan 2023 14:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbjA3NIw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Jan 2023 08:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbjA3NIq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Jan 2023 08:08:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D327360B3;
        Mon, 30 Jan 2023 05:08:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 265A1B810B2;
        Mon, 30 Jan 2023 13:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE29C4339B;
        Mon, 30 Jan 2023 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675084109;
        bh=h51fw2q7nVcSq+z7R5MTF0ybkYUQSW5xbCVY+5yyiYE=;
        h=From:To:Cc:Subject:Date:From;
        b=XsSoin7jduGK6g60Ugb2ioUf4CLCE6Boh6CSTHonx0N8EBV3Rw/xd4HScm32tTpNM
         ecdwLuUdGrQfiIaHMKtU/802xf350L0K3R0/AOdtBtp4NtBPnZ1ERuAFDWj6xN2aH8
         uCv5/Mxcekl09GwEdlsCNd3KJh1Y0/MQ8Yw1pcJWjYj+J4amlypkV5QG5WG7ihKhx+
         EZ9oZIpUP3LfwI0NKL/VusU64tFKdGLR5NxN0sFjhTStUjkEnkaOBR0GVhZW29mkGN
         /IHREe+TTPylV2ju+y2qmmX9uvzfL8EjclfDoy3Fbo7lbKGGYACReoXzAq5Zf8Odc8
         ckVhPmbixiAtg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: dw-edma: reduce stack usage after debugfs rework
Date:   Mon, 30 Jan 2023 14:08:10 +0100
Message-Id: <20230130130826.596171-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

After the dw_edma_debugfs_entry arrays are no longer compile-time
constant, they take up space on the stack, which exceeds the
warning limit after inlining:

drivers/dma/dw-edma/dw-edma-v0-debugfs.c:280:6: error: stack frame size (1784) exceeds limit (1400) in 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than]
void dw_edma_v0_debugfs_on(struct dw_edma *dw)

Work around this by marking the functions with the largest arrays
as 'noinline_for_stack' to make them not use up space on the same
stack together.

Fixes: 5c0373eafd83 ("dmaengine: dw-edma: Move eDMA data pointer to debugfs node descriptor")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 7be23c26ac88..9dfcbbdfb27b 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -116,7 +116,8 @@ static void dw_edma_debugfs_create_x32(struct dw_edma *dw,
 	}
 }
 
-static void dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
+static noinline_for_stack void
+dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
 				    u16 ch, struct dentry *dent)
 {
 	struct dw_edma_debugfs_entry debugfs_regs[] = {
@@ -136,9 +137,10 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
 	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, dent);
 }
 
-static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
+static noinline_for_stack void
+dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
 {
-	static const struct dw_edma_debugfs_entry debugfs_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
 		WR_REGISTER(dw, engine_en),
 		WR_REGISTER(dw, doorbell),
@@ -159,7 +161,7 @@ static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
 		WR_REGISTER(dw, ch67_imwr_data),
 		WR_REGISTER(dw, linked_list_err_en),
 	};
-	static const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
 		/* eDMA channel context grouping */
 		WR_REGISTER_UNROLL(dw, engine_chgroup),
 		WR_REGISTER_UNROLL(dw, engine_hshake_cnt.lsb),
@@ -197,7 +199,8 @@ static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
 	}
 }
 
-static void dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
+static noinline void
+dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
 {
 	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
-- 
2.39.0

