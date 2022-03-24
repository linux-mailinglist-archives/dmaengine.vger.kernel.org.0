Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805974E9C9F
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243450AbiC1QqX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbiC1QqC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:46:02 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 584F321E1F;
        Mon, 28 Mar 2022 09:44:16 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 29F111E494E;
        Thu, 24 Mar 2022 04:48:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 29F111E494E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086528;
        bh=yRKAu/9goZY2CuhAhPZ9QnZ4PkDsLD/RYGgM0Q+DtC8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=OvWOsR1RUWgtRc8GB5l1e+0O5kf1YTiVi1ymudckOkbaXZecCtUTJ3fsm2PXMcAge
         MwagEtmmLp96mECBvdSOviNSTGOnGu6PQv/G60JSqJdsDlXtQ/weYTOM5pWlC8T3ni
         McTGo6DAMKkz3xu2YCvTxPPJOLo6ixI9pV+tFdP0=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:47 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 14/25] dmaengine: dw-edma: Add dw_edma prefix to the DebugFS nodes descriptor
Date:   Thu, 24 Mar 2022 04:48:25 +0300
Message-ID: <20220324014836.19149-15-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The rest of the locally defined and used methods and structures have
dw_edma prefix in their names. It's right in accordance with the kernel
coding style to follow the locally defined rule of naming. Let's add that
prefix to the debugfs_entries structure too especially seeing it's name
may be confusing as if that structure belongs to the global DebugFS space.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 808eed212be8..afd519d9568b 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -46,7 +46,7 @@ static struct {
 	void					__iomem *end;
 } lim[2][EDMA_V0_MAX_NR_CH];
 
-struct debugfs_entries {
+struct dw_edma_debugfs_entry {
 	const char				*name;
 	void __iomem				*reg;
 };
@@ -94,7 +94,7 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
 
-static void dw_edma_debugfs_create_x32(const struct debugfs_entries entries[],
+static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry entries[],
 				       int nr_entries, struct dentry *dir)
 {
 	int i;
@@ -108,8 +108,7 @@ static void dw_edma_debugfs_create_x32(const struct debugfs_entries entries[],
 static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
 				    struct dentry *dir)
 {
-	int nr_entries;
-	const struct debugfs_entries debugfs_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		REGISTER(ch_control1),
 		REGISTER(ch_control2),
 		REGISTER(transfer_size),
@@ -120,6 +119,7 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
 		REGISTER(llp.lsb),
 		REGISTER(llp.msb),
 	};
+	int nr_entries;
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, dir);
@@ -127,7 +127,7 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
 
 static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 {
-	const struct debugfs_entries debugfs_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
 		WR_REGISTER(engine_en),
 		WR_REGISTER(doorbell),
@@ -148,7 +148,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 		WR_REGISTER(ch67_imwr_data),
 		WR_REGISTER(linked_list_err_en),
 	};
-	const struct debugfs_entries debugfs_unroll_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
 		/* eDMA channel context grouping */
 		WR_REGISTER_UNROLL(engine_chgroup),
 		WR_REGISTER_UNROLL(engine_hshake_cnt.lsb),
@@ -191,7 +191,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 
 static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 {
-	const struct debugfs_entries debugfs_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
 		RD_REGISTER(engine_en),
 		RD_REGISTER(doorbell),
@@ -213,7 +213,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 		RD_REGISTER(ch45_imwr_data),
 		RD_REGISTER(ch67_imwr_data),
 	};
-	const struct debugfs_entries debugfs_unroll_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
 		/* eDMA channel context grouping */
 		RD_REGISTER_UNROLL(engine_chgroup),
 		RD_REGISTER_UNROLL(engine_hshake_cnt.lsb),
@@ -256,7 +256,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 
 static void dw_edma_debugfs_regs(void)
 {
-	const struct debugfs_entries debugfs_regs[] = {
+	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		REGISTER(ctrl_data_arb_prior),
 		REGISTER(ctrl),
 	};
-- 
2.35.1

