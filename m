Return-Path: <dmaengine+bounces-880-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F1C84127D
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 19:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2792E1F2AB7D
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1A116089B;
	Mon, 29 Jan 2024 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwjw2Rw7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567ED160893;
	Mon, 29 Jan 2024 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553382; cv=none; b=rte3ObPpV0grnE5nmvMvRXwu/BiiqVYzAOgY/bCzVKKbRyHl/SQ4vyCssRQlsvxP2VKDGwCpAZKIzdkCToFLh5IirVOMKktsctl1isjv8GkW+JCcesbFcFIoPuBc8pXKXYGSRXVY/9e8hue/CiAixKC4dcAK49lR8a+6BUpk/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553382; c=relaxed/simple;
	bh=+GFlLe3e6fcoGMOT9P0XBWSK5jdsfSKtzZRqyBumyzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8HpLf0AF//Bz9G59MfFc8WsSQ8ZdAmZMHWw9zCl1QqVQN+sUQUFTi8rACILIMARs6XvtbnDfpO5m7InnWD6N8nRSVKwIx6w7vEuJaCM+yDAABkcAQynXWX5qXcsVjNzvMvMljLgI8UdSYN8sc+1K1Ltr94vi9/FHUI/32D6FX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwjw2Rw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409ECC43390;
	Mon, 29 Jan 2024 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553381;
	bh=+GFlLe3e6fcoGMOT9P0XBWSK5jdsfSKtzZRqyBumyzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwjw2Rw7Z2JVBJvk5g5GifUT/qzM90ut5VRL3I6qGaceuUp2s6LhiJrLTtpCyTN65
	 u6nE6GwwpElbkKYsNeVOViBhuZADrPG3PJrvmM6Yj9paLVT7WkCMdsLg9IZunvLBG9
	 LM83JyM3NxhyhzIYBrGsGXGRN2mDMnGICs2mvecwQqKkm8/5aP1T2wgS+TxTTF/2Qi
	 DrwU+pvaxpP/xps+i2MwaIl2EzRvnhZn1ttPnPleH+7wERZSJFCPa1SN42UCmhmIap
	 NOHC6EJ0Si7tB0+t68w53dMJ9B0bgIFWVbDz0btq+obbRT8EGMpFcJf9W3eyta2d3k
	 8k/gGTJrxjfNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/3] dmaengine: shdma: increase size of 'dev_id'
Date: Mon, 29 Jan 2024 13:36:15 -0500
Message-ID: <20240129183617.464694-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183617.464694-1-sashal@kernel.org>
References: <20240129183617.464694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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


