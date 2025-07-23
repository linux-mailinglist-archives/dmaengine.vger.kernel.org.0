Return-Path: <dmaengine+bounces-5849-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46227B0F1FA
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 14:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343991C27F2C
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F8D2E5B07;
	Wed, 23 Jul 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QttaBP7L"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B70C28EA5A;
	Wed, 23 Jul 2025 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272745; cv=none; b=DBYx/v3WaW/ru6LEYP3Z9wC96xjpqTkrFQXGXf8rGgzJe5+RdGK10KBWJ9BJ/P5/s+D3uTu+FIZIZnZfrzk0iqGaXf995RhuCbIa9Rt/wmrzyAoql9vVHQ0AXGVoh0trLBVfvEgytukb03fr1qhYgww1fVE6Asf6kDoO93o9Oe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272745; c=relaxed/simple;
	bh=DG1NBtHVraXrCvfT0GvO2Zt6YdgH46eGtjzUJCLccQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9lujsI1IrwPnhKn1mV+C0l3ZWCTVpeVQpeO93pHDyTCrMv9ex7JJe8InIk9wXWoBW0O25r02UN3H0hYSRIYwrBu8LcR19nCorTBXr9mCORvUgY4VtzW9GEvrMtkIZLTaVSRmA1yIfO9VUZgg7zJBvA45uU9aNKjiXb3wcEs8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QttaBP7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515B8C4CEE7;
	Wed, 23 Jul 2025 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753272744;
	bh=DG1NBtHVraXrCvfT0GvO2Zt6YdgH46eGtjzUJCLccQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QttaBP7LzXrtQDNljNclyA1B3pCA62XqtmZ8SrA93OSljgPa0SeW5Q6apYdrARtaK
	 PNFiaKVJth/Ha+kNN5lc12A6wf9OJ2qWGOBeaTAIarGFkt3BCYYa+pOYtaW8cZsbL0
	 jl4E4jydOe40YMT1m03bIiBB6+PBfatRZ1u+79GzVrOJphJXjI9B4T//ywuUFwPGT4
	 oqRBx2baV1phs1R2KNCUi7VhJ86ElNaW06rN7TRy92R5DHP1nuNTyLh7lXid4JUZSX
	 OIyIIMkUwQP+Grq3JOG/5uTuZmZYbCr6vjXKoxoG+nOLjRajBD0d1WW4lNh4CR8nQ0
	 /uHrEg186Vvow==
Date: Wed, 23 Jul 2025 17:42:21 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ste_dma40: simplify d40_handle_interrupt()
Message-ID: <aIDRpSN0z3Ri1Fkh@vaman>
References: <20250720022129.437094-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720022129.437094-1-yury.norov@gmail.com>

On 19-07-25, 22:21, Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

What is the meaning of NVIDIA in your name?

Pls add the subsystem name to the patch as well (this and others you
sent)


> 
> Use for_each_set_bit() iterator and drop housekeeping code.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  drivers/dma/ste_dma40.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index d52e1685aed5..6cc76f935c7c 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -1664,7 +1664,7 @@ static irqreturn_t d40_handle_interrupt(int irq, void *data)
>  	int i;
>  	u32 idx;
>  	u32 row;
> -	long chan = -1;
> +	long chan;
>  	struct d40_chan *d40c;
>  	struct d40_base *base = data;
>  	u32 *regs = base->regs_interrupt;
> @@ -1677,15 +1677,7 @@ static irqreturn_t d40_handle_interrupt(int irq, void *data)
>  	for (i = 0; i < il_size; i++)
>  		regs[i] = readl(base->virtbase + il[i].src);
>  
> -	for (;;) {
> -
> -		chan = find_next_bit((unsigned long *)regs,
> -				     BITS_PER_LONG * il_size, chan + 1);
> -
> -		/* No more set bits found? */
> -		if (chan == BITS_PER_LONG * il_size)
> -			break;
> -
> +	for_each_set_bit(chan, (unsigned long *)regs, BITS_PER_LONG * il_size) {
>  		row = chan / BITS_PER_LONG;
>  		idx = chan & (BITS_PER_LONG - 1);
>  
> -- 
> 2.43.0

-- 
~Vinod

