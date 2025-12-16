Return-Path: <dmaengine+bounces-7691-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 742CACC4783
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F64E3008865
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC8271A6D;
	Tue, 16 Dec 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cakfrr4x"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418C21FF26;
	Tue, 16 Dec 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904181; cv=none; b=s758Flhk8RSi5z6N6XAzpB+3F5vYvO7e0cvHJV83ptzRzMWIybMh1PjRAk4Lu789L4W5ienFlCQ//btP9wvcumy+N6ivnvCIfHx1fv0LhTrbQwvX19v5vzns8yXh737+6rmnP1ljCPoqVnxCOcMM4acxO0L+RKfvIzJjcF6OlR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904181; c=relaxed/simple;
	bh=TARPN6Yt6Y6qE5PKNWdfNem27drZ6puaqfrsr4THSbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lU8LBscmWDksHGL8gnXlK9MW0er7AAsFK/MOGEyVL2E3HEAoPI/7d7QHUd8N1Xl6IvbMkVdo7Wx3s1Xv0Er/BBDMBSdLLQlfotLwizENmFo2PKpFF9x/CRnYbHgBqtZ/zfg0+hDpImLsJBfubOLJtXLSyqAubqulEXhok/q3AXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cakfrr4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3838FC4CEF1;
	Tue, 16 Dec 2025 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904181;
	bh=TARPN6Yt6Y6qE5PKNWdfNem27drZ6puaqfrsr4THSbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cakfrr4xAHefjOXOFgjDWOJ2gW6mWvs0tWBBtjws7vUlwI6o0YZ/zRv43tKtzXUnT
	 h/A3KBw+cNqzfIdGPcLsfTV7lkUUOkDDjrqlnd5DSpjsrXoDtxrInOKJDWsjp5sLcP
	 eCuOS3CC9/Ni37YLAGvZn+s0RJo+n0MeSdc7oxt0AwwcbNybTU588V9eKw11yvyqQ7
	 DGTon/wT3pLxeViHXQyT/A15u/p+RYDGtPUJZH6xRc+2DZDqn2Kn1MsVX5c6dlg7GS
	 52aaf9qUpt6sRZqYvIdW1km6GvFAahtriQK0J8sE10RnjNzpEQ7ZAIrukOQx1W6mt1
	 xyautJitcydMQ==
From: Vinod Koul <vkoul@kernel.org>
To: Yixun Lan <dlan@gentoo.org>, Guodong Xu <guodong@riscstar.com>
Cc: Alex Elder <elder@riscstar.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Juan Li <lijuan@linux.spacemit.com>
In-Reply-To: <20251216-mmp-pdma-race-v1-1-976a224bb622@riscstar.com>
References: <20251216-mmp-pdma-race-v1-1-976a224bb622@riscstar.com>
Subject: Re: [PATCH] dmaengine: mmp_pdma: Fix race condition in
 mmp_pdma_residue()
Message-Id: <176590417885.422798.17247803206459718657.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:26:18 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 16 Dec 2025 22:10:06 +0800, Guodong Xu wrote:
> Add proper locking in mmp_pdma_residue() to prevent use-after-free when
> accessing descriptor list and descriptor contents.
> 
> The race occurs when multiple threads call tx_status() while the tasklet
> on another CPU is freeing completed descriptors:
> 
> CPU 0                              CPU 1
> -----                              -----
> mmp_pdma_tx_status()
> mmp_pdma_residue()
>   -> NO LOCK held
>      list_for_each_entry(sw, ..)
>                                    DMA interrupt
>                                    dma_do_tasklet()
>                                      -> spin_lock(&desc_lock)
>                                         list_move(sw->node, ...)
>                                         spin_unlock(&desc_lock)
>   |                                     dma_pool_free(sw) <- FREED!
>   -> access sw->desc <- UAF!
> 
> [...]

Applied, thanks!

[1/1] dmaengine: mmp_pdma: Fix race condition in mmp_pdma_residue()
      commit: a143545855bc2c6e1330f6f57ae375ac44af00a7

Best regards,
-- 
~Vinod



