Return-Path: <dmaengine+bounces-878-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87553841272
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 19:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2691E1F2AB81
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA4715FB11;
	Mon, 29 Jan 2024 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rS3MlViE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A615FB0E;
	Mon, 29 Jan 2024 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553375; cv=none; b=oHOVgbZCOEzGMkQl54UUeT9VqInuqYAkWuq9e3vt+60OLarWTGXefLGb5bqpdLi1OqRxwlGsJcTaAD/2QtRiocCfspoqipkFeOZzHhjzNEi/hKcDguz858fApoQGcnOJ9yk2rYJwqSdDhcBUL7QvY0K0pYxlJIPQGxuBzoq3Cm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553375; c=relaxed/simple;
	bh=+GFlLe3e6fcoGMOT9P0XBWSK5jdsfSKtzZRqyBumyzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjdG8u2t0X5e5wnKTOpNN9Cf5CaPlm0k8yf+PExU1y/ZKgP/kIZwMVnS04H9qy+ZcYlv/r4SgRKvaWoyDolPZtQuj2Y87q+Xv4n8Q15XAVWbVdhXwtpxDpfcsxo6FBqelKg3RpwG+rKEDbrF9hneqTthzcl9FbCFOle/eIxCvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rS3MlViE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A02C433C7;
	Mon, 29 Jan 2024 18:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553374;
	bh=+GFlLe3e6fcoGMOT9P0XBWSK5jdsfSKtzZRqyBumyzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rS3MlViEepTgWIYiA9oQQ9ETHjEs/7CKiSGUCSF/s8J5yrKNob1muGDAU9BCls21C
	 BaRvLc8EDR3G8vp/4/Qn7mJA6h/n0M4A2kCA0rRKZTxHuh86bWSfNWEPUXwHPafumD
	 6DlVQowefrxlZnde3y5tkq4/lu1wFjWsrNvu2tk4kdW71UDgZMlfPe4svCmI0N0LFa
	 kX1PEpmIkd6F6QBCnSSynvvBYlUbs+qLb3N+Nb49btfZbZP0MiJ16OdhhEmzo2npVU
	 uEkwBBGlqSWNtxqwlmtgct2xBs75H7UKPhtjxW9g6JDmpC/Tjr+mvci/jmKQjTixPY
	 NXUzEh5jJDOKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/3] dmaengine: shdma: increase size of 'dev_id'
Date: Mon, 29 Jan 2024 13:36:07 -0500
Message-ID: <20240129183610.464618-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183610.464618-1-sashal@kernel.org>
References: <20240129183610.464618-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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


