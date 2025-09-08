Return-Path: <dmaengine+bounces-6428-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0A0B49B0C
	for <lists+dmaengine@lfdr.de>; Mon,  8 Sep 2025 22:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091051BC1002
	for <lists+dmaengine@lfdr.de>; Mon,  8 Sep 2025 20:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8212D9ECD;
	Mon,  8 Sep 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDD6UaPB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA545945;
	Mon,  8 Sep 2025 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363177; cv=none; b=EPMOGFFdE7+MlzRh50uNh5E06QtRTDdeVzAJqmmlPi96MRQlGSIJN/1YMbcmsmr8RDBYR7vFLOAFrGvM2QFeaipduUTDsNfvbAvoigu17D/BNS8mVg+Wcs3W0hgeZpeQPz2gtHxnLWRCwQ/6s91D2k8BLwQ1J+uRpN8yyI2Luao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363177; c=relaxed/simple;
	bh=RTlIU2xCbD8I8E2KxfqW+zB3CNk6WHDCJMHR2w9OKjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiWnKccVZD9GIKGp3bwyEQ8YppZBgiCo9VX1M7FR3npFM4EMiQWE9Q+Q5ZpmbTWfPas/oKBC9tRQFODskAAckQvXYajFvJlo2EpSicwWpiEpgKjAOPCPzmhBLcS3BYrT0GFG8kZFt4LyVjYx7NAYvJdj2xvhwrYiv3WaxKjGd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDD6UaPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572C8C4CEF1;
	Mon,  8 Sep 2025 20:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757363176;
	bh=RTlIU2xCbD8I8E2KxfqW+zB3CNk6WHDCJMHR2w9OKjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bDD6UaPBhu/yHDtS7NvKJP1T0QKq12q7id9L1S4qMpVSJHprzwNlVf/oTUBzLu7/e
	 Flvr++ri/ZYAjLZK5z8vLY7AvogDPLKjzvs3M80SATKNVPqe2nsQT4fwpE9ISaNNuK
	 /FTukwJhPohg/487WxAaEx4gfSZf5tRuIg63DAd3Y4GXT6XPgoUYlcXt10uvJZSDxA
	 gvReQha+MHSqAwNMpJUqiM+CZzS9nhuTGwZ7humIGzTiwQFyjfWvlkUVkcg3zP6cVw
	 PhAyfiJBasbe73fzHe2sLb8umBxs45I+crDlGO2wZPgBq20F43EeaA2HjNz2cDu7Tt
	 ma9f2vCzJ/uKg==
Date: Mon, 8 Sep 2025 13:26:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Conley Lee <conleylee@foxmail.com>, vkoul@kernel.org
Cc: davem@davemloft.net, wens@csie.org, mripard@kernel.org,
 netdev@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: sun4i-emac: free dma descriptor
Message-ID: <20250908132615.6a2507ed@kernel.org>
In-Reply-To: <tencent_D434891410B0717BB0BDCB1434969E6EB50A@qq.com>
References: <20250904072446.5563130d@kernel.org>
	<tencent_D434891410B0717BB0BDCB1434969E6EB50A@qq.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Sep 2025 19:29:30 +0800 Conley Lee wrote:
> In the current implementation of the sun4i-emac driver, when using DMA to
> receive data packets, the descriptor for the current DMA request is not
> released in the rx_done_callback.

I wish you elaborated more on the reuse flag not being set :\

> Fix this by properly releasing the descriptor.
> 
> Fixes: 47869e82c8b8 ("sun4i-emac.c: add dma support")
> Signed-off-by: Conley Lee <conleylee@foxmail.com>

Hi Vinod, could you TAL? Is this fix legit or there's something wrong
with how the DMA engine API is used on this platform?
https://lore.kernel.org/all/tencent_D434891410B0717BB0BDCB1434969E6EB50A@qq.com/

