Return-Path: <dmaengine+bounces-882-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06338841288
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 19:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C8F9B21587
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB482162741;
	Mon, 29 Jan 2024 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NF2zZZu6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6726F16274D;
	Mon, 29 Jan 2024 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553390; cv=none; b=K/vGopWtsZaRM+FqrLQaRLeVSKW1W12JYWYkB0cziOQfnz+P+UJ0rZoOszgzf+Kd85vzW2I90DEowErLvCSPrcKFYjl2u+nqOxh8ISk/y5vo1oy1+C658vV85sir9ttcbA25hH1rM1arqkcUGEkQyafxljh3vMw3VSRTAe5CYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553390; c=relaxed/simple;
	bh=+GFlLe3e6fcoGMOT9P0XBWSK5jdsfSKtzZRqyBumyzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kf9ff+xz2RKjDYNgPsYioAjT3gXsItcBjSc/ZdwSk9Q8K1AGcGd0zmtDi4iBe3MpVjtllzpeMLChywh1pRsksbA4gWEZ3jWT3onxccwWrSR/8dnKQBmSFEcE8CJm5PdEn8xZDqsL8ik441g29cunlasn/joxH8+U6NQBmUzM7zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NF2zZZu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D86C43390;
	Mon, 29 Jan 2024 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553390;
	bh=+GFlLe3e6fcoGMOT9P0XBWSK5jdsfSKtzZRqyBumyzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NF2zZZu65DQVdDMOR+eaT1Uv/rMTm2W6hkNN3ssAb8JuonLCb7ECu51z0l1xIhwZc
	 cObV1bor/Kfb3ebTQGbhwQ+mGhbr1duWhXgf12VmrFebbDbzfMe0bjFINGk21ngLx1
	 43/SxU/OjY62zrKK/Zu5ZxGMjbOjejxX4F05rlrXY+0/q2LcLjTx20M+kjbpzJPyrT
	 3R0Xvr+Z3XLI4d9ZpfiTCfZm5nN49WITEbBUXMLzvQ86MDFkb5PXzkTzeetE35k8Zf
	 zyHLAcHBOIiA25sBaylPpmQ13bYbHyydvyVYPOiE5ynBB9BmTYmxpBnDC4pLRm0N5Q
	 NZKMoKlCo49gA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/3] dmaengine: shdma: increase size of 'dev_id'
Date: Mon, 29 Jan 2024 13:36:22 -0500
Message-ID: <20240129183625.464771-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183625.464771-1-sashal@kernel.org>
References: <20240129183625.464771-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
Content-Transfer-Encoding: 8bit

From: Vinod Koul <vkoul@kernel.org>

[ Upstream commit 404290240827c3bb5c4e195174a8854eef2f89ac ]

We seem to have hit warnings of 'output may be truncated' which is fixed
by increasing the size of 'dev_id'

drivers/dma/sh/shdmac.c: In function ‘sh_dmae_probe’:
drivers/dma/sh/shdmac.c:541:34: error: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 9 [-Werror=format-truncation=]
  541 |                          "sh-dmae%d.%d", pdev->id, id);
      |                                  ^~
In function ‘sh_dmae_chan_probe’,
    inlined from ‘sh_dmae_probe’ at drivers/dma/sh/shdmac.c:845:9:
drivers/dma/sh/shdmac.c:541:26: note: directive argument in the range [0, 2147483647]
  541 |                          "sh-dmae%d.%d", pdev->id, id);
      |                          ^~~~~~~~~~~~~~
drivers/dma/sh/shdmac.c:541:26: note: directive argument in the range [0, 19]
drivers/dma/sh/shdmac.c:540:17: note: ‘snprintf’ output between 11 and 21 bytes into a destination of size 16
  540 |                 snprintf(sh_chan->dev_id, sizeof(sh_chan->dev_id),
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  541 |                          "sh-dmae%d.%d", pdev->id, id);
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/sh/shdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 9c121a4b33ad..f97d80343aea 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -25,7 +25,7 @@ struct sh_dmae_chan {
 	const struct sh_dmae_slave_config *config; /* Slave DMA configuration */
 	int xmit_shift;			/* log_2(bytes_per_xfer) */
 	void __iomem *base;
-	char dev_id[16];		/* unique name per DMAC of channel */
+	char dev_id[32];		/* unique name per DMAC of channel */
 	int pm_error;
 	dma_addr_t slave_addr;
 };
-- 
2.43.0


