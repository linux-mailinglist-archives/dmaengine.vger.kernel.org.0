Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D888564D3DA
	for <lists+dmaengine@lfdr.de>; Thu, 15 Dec 2022 00:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLNXxj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Dec 2022 18:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLNXxR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Dec 2022 18:53:17 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AF6A4875F;
        Wed, 14 Dec 2022 15:53:16 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id A7766E0ED6;
        Thu, 15 Dec 2022 02:53:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=yD9PICPiUNexEf6oBToH8CPTy9Uy6i+HLi2LtrhOcs0=; b=dCcYC88fWgfT
        /x/DKGudP0hWLmOOekeSNIOR6BPpb0aPrZDH5RtcNvAN+KFOXDfoy/b5fvuWBsHZ
        sIMWaNQtJA+IxuHhlBa55HL/BEWvKws79t899zdGlJxWhX8LlVhTJ6cBoGd0Uq8G
        FanHELsqdKXYWGy9nT9gqibgXrgTkaI=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 9972BE0E6B;
        Thu, 15 Dec 2022 02:53:15 +0300 (MSK)
Received: from localhost (10.8.30.6) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Thu, 15 Dec 2022 02:53:15 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 11/25] dmaengine: dw-edma: Stop checking debugfs_create_*() return value
Date:   Thu, 15 Dec 2022 02:52:51 +0300
Message-ID: <20221214235305.31744-12-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.6]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

First of all they never return NULL. So checking their return value for
being not NULL just pointless. Secondly the DebugFS subsystem is designed
in a way to be used as simple as possible. So if one of the
debugfs_create_*() method in a hierarchy fails, the following methods will
just silently return the passed erroneous parental dentry. Finally the
code is supposed to be working no matter whether anything DebugFS-related
fails. So in order to make code simpler and DebugFS-independent let's drop
the debugfs_create_*() methods return value checking in the same way as
the most of the kernel drivers do.

Note in order to preserve some memory space we suggest to skip the DebugFS
nodes initialization if the file system in unavailable.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 8e61810dea4b..6e7f3ef60ca7 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -100,9 +100,8 @@ static void dw_edma_debugfs_create_x32(const struct debugfs_entries entries[],
 	int i;
 
 	for (i = 0; i < nr_entries; i++) {
-		if (!debugfs_create_file_unsafe(entries[i].name, 0444, dir,
-						entries[i].reg,	&fops_x32))
-			break;
+		debugfs_create_file_unsafe(entries[i].name, 0444, dir,
+					   entries[i].reg, &fops_x32);
 	}
 }
 
@@ -168,8 +167,6 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 	char name[16];
 
 	regs_dir = debugfs_create_dir(WRITE_STR, dir);
-	if (!regs_dir)
-		return;
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
@@ -184,8 +181,6 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
 
 		ch_dir = debugfs_create_dir(name, regs_dir);
-		if (!ch_dir)
-			return;
 
 		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].wr, ch_dir);
 
@@ -237,8 +232,6 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 	char name[16];
 
 	regs_dir = debugfs_create_dir(READ_STR, dir);
-	if (!regs_dir)
-		return;
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
@@ -253,8 +246,6 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
 
 		ch_dir = debugfs_create_dir(name, regs_dir);
-		if (!ch_dir)
-			return;
 
 		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].rd, ch_dir);
 
@@ -273,8 +264,6 @@ static void dw_edma_debugfs_regs(void)
 	int nr_entries;
 
 	regs_dir = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
-	if (!regs_dir)
-		return;
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
@@ -285,6 +274,9 @@ static void dw_edma_debugfs_regs(void)
 
 void dw_edma_v0_debugfs_on(struct dw_edma *_dw)
 {
+	if (!debugfs_initialized())
+		return;
+
 	dw = _dw;
 	if (!dw)
 		return;
@@ -294,8 +286,6 @@ void dw_edma_v0_debugfs_on(struct dw_edma *_dw)
 		return;
 
 	dw->debugfs = debugfs_create_dir(dw->name, NULL);
-	if (!dw->debugfs)
-		return;
 
 	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->chip->mf);
 	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
-- 
2.38.1


