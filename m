Return-Path: <dmaengine+bounces-870-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2876384123A
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 19:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6F81C2369A
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E9B15B0F5;
	Mon, 29 Jan 2024 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrZhmIsx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426015B0EE;
	Mon, 29 Jan 2024 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553318; cv=none; b=keR0pt9FZekxKHvCp20aVFT4ZQ6QjCteAL47Vas4al1c3f3EjGwVffd9QxiOVABA81PIyHU/eMRSmG4NOqeu4iOE6Qugs6V55A+UNhCrfSNC3KKWswf/MXCr8PvHfre9JAHI9hYS462r/xXnnT0/QAL9SwVSSjex7DQxtVrrZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553318; c=relaxed/simple;
	bh=sHnTdcZPKggZ9cS+k/fUWyeM7AgLx2VIukC+7lqjp6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIw+v1MDRVJPyOezBbxEQ//QSyy0EEdEasViFdMBASrCMmlIqORGy90US+odkpeinLvFANCgzieNW+5cEKIYJhZgoMUh7FY+c2xpMUa4ZdsQW2URM/31kHEF//W/aL+zdlXQTrG3ijdUAVCk7qz8blo7eLIIQconjR+EaJ2mYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrZhmIsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9C1C433F1;
	Mon, 29 Jan 2024 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553318;
	bh=sHnTdcZPKggZ9cS+k/fUWyeM7AgLx2VIukC+7lqjp6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrZhmIsx5yYB/+zcRbxZuSnEtuMofLFeV1UWA8dvYW16FZucozAPvl/60hsSbQtwM
	 LJOCOFd0CbF+0y49h3AEgZtpU55DO23M6YMqD4zcWQwqDr3RWfbwEuexSmyehEAErg
	 xSSXCov0gZoQYPJ7HFlKUM0uMMKAEXUy93GpxMxUGeExv1gZsa5aplcdmHwinIwpgp
	 WKWUWiJQ5IIW9lRDtmEyaCL1kIRxsKf0QUtoOyJXd2fcMD/dlX3jCYwaILHX9C4fXK
	 secRGNc9b9IdIrBL3IwN0VZS61n//kOiil2hmb0J7OVt66mkmYM1Di2Uh6iCqTKVYs
	 Rpnq2B6mxn8zQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	manivannan.sadhasivam@linaro.org,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 12/12] dmaengine: dw-edma: increase size of 'name' in debugfs code
Date: Mon, 29 Jan 2024 13:34:21 -0500
Message-ID: <20240129183440.463998-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183440.463998-1-sashal@kernel.org>
References: <20240129183440.463998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Vinod Koul <vkoul@kernel.org>

[ Upstream commit cb95a4fa50bbc1262bfb7fea482388a50b12948f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


