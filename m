Return-Path: <dmaengine+bounces-872-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53667841254
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 19:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70591F2A09C
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3517615B992;
	Mon, 29 Jan 2024 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgX/KLLF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952915D5A4;
	Mon, 29 Jan 2024 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553355; cv=none; b=Ophj79LTnd6FrFvd1qm5pdCI9pZvD9HTidMFb0b8+31i7LaF5r7fCGcaWuZWFKLyk7onv2MZ3a/G/gUIx3mVu8yp4LNcBxiAXrTDxVNjez5xBdo3YU5ErnKsTfn5954IUU2S5QcAwrqbSOwUJbj7PMuz6S+ruUM792oTnKr0+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553355; c=relaxed/simple;
	bh=+GFlLe3e6fcoGMOT9P0XBWSK5jdsfSKtzZRqyBumyzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlsiyXAXs/uCDP8hD36a4WwEOjDabvWoWew/b3EYytiOoftub8cmZq1qGLuMeXchS2V+J3ywMcDGk8PVqTeDv2+mveQyqqUY2iHOys0CqjHGiXPJPLJCUYP4kREW1Ly7SPVk3LtgCHGzYzubHK/kM8GmmIM0ooRKZFBGkgp6oN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgX/KLLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2F5C433C7;
	Mon, 29 Jan 2024 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553354;
	bh=+GFlLe3e6fcoGMOT9P0XBWSK5jdsfSKtzZRqyBumyzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgX/KLLFAR2J6qT5DiX5oUYKTjlwbPC3Y+DQYiujYBtTyqkAJ+v8WK/TjcgmrTLuG
	 kzEjJKmJx+Dp64ZKkd+8+KbedRB5hyfxNqeIrSDLrGHykDtkwvNEbd1zEJIxY1X69v
	 9f7v3Pi65SCJwPMAack5FylO3u+SXmLz1cHO0neALgc0qWqXszY9+plw1gZamxfVEF
	 cyMlTByJDN4qp+Fz75GMh4JKFCliFFPs9CCGXI4OCSqHrbq1D1szIkDoXx8wLbgNI/
	 s8BlrNF8dsSkksdO48UW1PlbkcnVReyi3hd/k2X3GkNKGY8S7pHfwgvQazmNGqsKQn
	 uE2SIWbUPnytg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/10] dmaengine: shdma: increase size of 'dev_id'
Date: Mon, 29 Jan 2024 13:35:16 -0500
Message-ID: <20240129183530.464274-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183530.464274-1-sashal@kernel.org>
References: <20240129183530.464274-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
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


