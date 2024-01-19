Return-Path: <dmaengine+bounces-753-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5A78329B0
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89091C21812
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2293A4EB5B;
	Fri, 19 Jan 2024 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkCv3BtD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC94C3D2
	for <dmaengine@vger.kernel.org>; Fri, 19 Jan 2024 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668596; cv=none; b=TrQ+tY0uIHSafekNRtNaxoxH64cGLB5mFD1SusUX4snMwkGK3VETHA5o9iXyWsgLjA9GLlv5VwjKLfH4kP7nDKo0okU2twYgzV+cfd58r5uiuDcAlnOdZ0n1OvDWlCwY3ei6Hs78znSWUrtU19sPGj97HJSQh7YUu7oM6dlRpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668596; c=relaxed/simple;
	bh=t3zAQPK9B6UGRZLtH4SKvNCUMjE3y+M+uR5nAJgXi6U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUdjEQooGRw+wJ+fej/POGOy7aHi6M2kji9NE9/8DxMHu9EUeCojkI5bOmggxUtXj7hT4qNzwgU8Amf4CQWrG1L3qflrwd62DpkJa4ud13St4n7WND23mpokxH4/lMKdkKNRkGVPdF7eYZvn4vUI7BWq0tFz7Pfq0ki86l0u3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkCv3BtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45759C433F1;
	Fri, 19 Jan 2024 12:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705668595;
	bh=t3zAQPK9B6UGRZLtH4SKvNCUMjE3y+M+uR5nAJgXi6U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AkCv3BtDsina4KoC486OYCzywFnQkgILWw1PUTMi4utJcxuaMMNI9Pz6w79OVhmbR
	 1wzh3ntnq715p1kfcvyz/TJAg7NVGfVBtzLxw80tZon15fwAm8YjMEVcc24h+OOiPt
	 u/h0aVmJH5eZfq9LBRdzohDgkab/Vcrh9DbpG+GdavMleFq/nuu40149MfX2gugFvI
	 NbojsmiHeI0UGekd/65me5rVL6cjZeMgXlM4sCUOsQ2eMdajUkBSGt6mvgO8ScDODr
	 xpTuFGaKBUcsp41EdhOgMFHbnHxjWckj/sp8xTPCwS+70OODKjNJOa/ugVeNx4F1lB
	 nYETpaU24CnSA==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 3/3] dmaengine: dw-edma: increase size of 'name' in debugfs code
Date: Fri, 19 Jan 2024 18:19:44 +0530
Message-ID: <20240119124944.152562-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119124944.152562-1-vkoul@kernel.org>
References: <20240119124944.152562-1-vkoul@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We seem to have hit warnings of 'output may be truncated' which is fixed
by increasing the size of 'name'

drivers/dma/dw-edma/dw-hdma-v0-debugfs.c: In function ‘dw_hdma_v0_debugfs_on’:
drivers/dma/dw-edma/dw-hdma-v0-debugfs.c:125:50: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
  125 |                 snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
      |                                                  ^~

drivers/dma/dw-edma/dw-hdma-v0-debugfs.c: In function ‘dw_hdma_v0_debugfs_on’:
drivers/dma/dw-edma/dw-hdma-v0-debugfs.c:142:50: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
  142 |                 snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
      |                                                  ^~
drivers/dma/dw-edma/dw-edma-v0-debugfs.c: In function ‘dw_edma_debugfs_regs_wr’:
drivers/dma/dw-edma/dw-edma-v0-debugfs.c:193:50: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
  193 |                 snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
      |                                                  ^~

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 4 ++--
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 0745d9e7d259..406f169b09a7 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -176,7 +176,7 @@ dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
 	};
 	struct dentry *regs_dent, *ch_dent;
 	int nr_entries, i;
-	char name[16];
+	char name[32];
 
 	regs_dent = debugfs_create_dir(WRITE_STR, dent);
 
@@ -239,7 +239,7 @@ static noinline_for_stack void dw_edma_debugfs_regs_rd(struct dw_edma *dw,
 	};
 	struct dentry *regs_dent, *ch_dent;
 	int nr_entries, i;
-	char name[16];
+	char name[32];
 
 	regs_dent = debugfs_create_dir(READ_STR, dent);
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
index 520c81978b08..dcdc57fe976c 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
@@ -116,7 +116,7 @@ static void dw_hdma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
 static void dw_hdma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
 {
 	struct dentry *regs_dent, *ch_dent;
-	char name[16];
+	char name[32];
 	int i;
 
 	regs_dent = debugfs_create_dir(WRITE_STR, dent);
@@ -133,7 +133,7 @@ static void dw_hdma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
 static void dw_hdma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
 {
 	struct dentry *regs_dent, *ch_dent;
-	char name[16];
+	char name[32];
 	int i;
 
 	regs_dent = debugfs_create_dir(READ_STR, dent);
-- 
2.43.0


