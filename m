Return-Path: <dmaengine+bounces-5181-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218F5AB8443
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 12:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8014A06DD
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 10:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC02529825C;
	Thu, 15 May 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfTLTM9L"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86A298255;
	Thu, 15 May 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306102; cv=none; b=BpYN3HhRfCGoQVRJhCNYEsAqzvgsyVyQVxXtg7LSUHmqCBq2GjIkh8qjU4Xc4s61RSJ3oiNWUhIRR3Ae1V2pjN9xBnY4myzuQ/2ke8WlwjfMCg0KfgcBZM4F0KKu4NkgNhsvEe2s87glgY7Z063hpXZZdJpa4Mv1bb9ucD3063o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306102; c=relaxed/simple;
	bh=eBPgvvsvHseuwOOxm/fxnYlTjdO4X6W/Sa724t+OOxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLhYvcvlyyN/7B/6SPtjChDJ9o+6EGT8Z8Qa2r9z0N/jbk+wvIqFGWq9aRjcOtbBdW7dO/r87aXR48K2BV1AwoOzOYQMMTdP9xf4m81Hdp/Nb4nJheneWh12SIjW1jI6T1gmVPDrMNInF5DjV/Yo4ubaq49QzF+V6FftzGJ8LKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfTLTM9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D8BC4AF09;
	Thu, 15 May 2025 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747306102;
	bh=eBPgvvsvHseuwOOxm/fxnYlTjdO4X6W/Sa724t+OOxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfTLTM9LTMC6SzJrgtYs00OrUofyFCHezGXXKViJVYeakcCCqqgEHbDdKFA4YWZ5/
	 D4e8z6eujMyUzh9UDkfyRG6xci9BE2e5NELK0o2qkHEqyRgF4guWxYrDgMQ7mp6Jax
	 dX9Al8qFAmCCDRt/IFsVADWDEmsPo47xycvazkQtEIHxKjD5uMkki8opEHo7rFtfeE
	 tayB9CBSMBI+GXA/6/Uw9IYGDAFWUnxU5Q6Anl3Ol9yiWQuUWMR7pz/Mh9BUUFaghI
	 /g6gdCG4HBB7chLiUq58JT+ctMJmwkR22aDRIqoZxUFbOev/PIQv54P1LibHnaVC4m
	 LnaGTHKPOScFA==
Date: Thu, 15 May 2025 11:48:19 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	dma <dmaengine@vger.kernel.org>
Cc: Qiu-ji Chen <chenqiuji666@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the dmaengine-fixes tree
Message-ID: <aCXGc21rVab7ZuDG@vaman>
References: <20250515093325.4e29e8a6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515093325.4e29e8a6@canb.auug.org.au>

On 15-05-25, 09:33, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the dmaengine-fixes tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/dma/mediatek/mtk-cqdma.c: In function 'mtk_cqdma_find_active_desc':
> drivers/dma/mediatek/mtk-cqdma.c:423:23: error: unused variable 'flags' [-Werror=unused-variable]
>   423 |         unsigned long flags;
>       |                       ^~~~~
> 
> Caused by commit
> 
>   157ae5ffd76a ("dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()")
> 
> I have used the dmaengine-fixes tree from next-20250514 for today.

Thanks, I have fixed it up and applied below:

-- >8 --


From 811d6a923b40fc130f91abf49151f57cf9ac2a6f Mon Sep 17 00:00:00 2001
From: Vinod Koul <vkoul@kernel.org>
Date: Thu, 15 May 2025 11:42:13 +0100
Subject: [PATCH] dmaengine: mediatek: drop unused variable

Commit 157ae5ffd76a dmaengine: mediatek: Fix a possible deadlock error
in mtk_cqdma_tx_status() fixed locks but kept unused varibale leading to
warning and build failure (due to warning treated as errors)

drivers/dma/mediatek/mtk-cqdma.c: In function 'mtk_cqdma_find_active_desc':
drivers/dma/mediatek/mtk-cqdma.c:423:23: error: unused variable 'flags' [-Werror=unused-variable]
  423 |         unsigned long flags;
      |                       ^~~~~

Fix by dropping this unused flag

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 157ae5ffd76a ("dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/mediatek/mtk-cqdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index e35271ac1eed..47c8adfdc155 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -420,7 +420,6 @@ static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
 {
 	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
 	struct virt_dma_desc *vd;
-	unsigned long flags;
 
 	list_for_each_entry(vd, &cvc->pc->queue, node)
 		if (vd->tx.cookie == cookie) {
-- 
2.34.1


-- 
~Vinod

