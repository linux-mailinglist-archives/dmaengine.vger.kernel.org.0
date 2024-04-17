Return-Path: <dmaengine+bounces-1870-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E92C8A8A15
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 19:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBB4283B48
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 17:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C58171674;
	Wed, 17 Apr 2024 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUQhmaPy"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC916FF50;
	Wed, 17 Apr 2024 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374320; cv=none; b=PB67u6eokkQpk8apBaV5P+r9zKu01AWsTepl/KsPnfvrSBwDk7TN0t+5/5EYuq13Sc9KSKs/YGRwz6LeiU/8JQVxW3LN1WYHtYB2d9qOdfEvIp0bSd4TpjSvmYVPPBfUEYoqqF6adGKq9WYVA1fLxtajb49riGAQ5UmjShWsu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374320; c=relaxed/simple;
	bh=AVVC8QRcGY3UAjfNDcXN2mMvIcrHBnBOEBSfekr3s1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvQT8KbvZ9iKfPJXNMBp85Nhp3WlgH7F66bki6P5r+3PXMmrPnLc4DCzFI9sEphYmYKdtzMBdchxbb80pauR3NOFD+FQeIGQMmlEmPt/v3OVa33MeSCRvrn3qsAX95spKYKsR7QhJUw1hs3ly/KA0//r2CxgsDIQJSH1Z98T/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUQhmaPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B66C072AA;
	Wed, 17 Apr 2024 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713374320;
	bh=AVVC8QRcGY3UAjfNDcXN2mMvIcrHBnBOEBSfekr3s1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUQhmaPyJruOFGHbt5IlTLaWzjdXdb0nNly6FTzlwTSyimUJgvsNa6OWxJ5QfVpJg
	 j1cI3pk/fNrWN4AtPrqKNtkbIlYbfCPQapEEn6Wml0s10IRVQ1JurRC00/M/1CbvQX
	 NS+pYHEtYzcGwC67krDzlvav422BPoUTq8MCQg0bihViI8wJolSa5qonsOWhkrZ1gb
	 xpYEhgnlXjNwis/L3MBpm0HZ6gkl/2HBFUHZ+rVbygg0SOu0kdJRPjMe0BTpeJnSI7
	 1WQfcoMLJejVy7P4JnWVRYlyUcRpdRT6Qp+F0I0MxTi/wVm7g98FHu+t0ipEK2FwE+
	 hlW7DLj/jpjjw==
Date: Wed, 17 Apr 2024 22:48:36 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jie Hai <haijie1@huawei.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dmatest: fix timeout caused by kthread_stop
Message-ID: <ZiAEbOMxy9pBcOX5@matsya>
References: <20230720114102.51053-1-haijie1@huawei.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720114102.51053-1-haijie1@huawei.com>

On 20-07-23, 19:41, Jie Hai wrote:
> The change introduced by commit a7c01fa93aeb ("signal: break
> out of wait loops on kthread_stop()") causes dmatest aborts
> any ongoing tests and possible failure on the tests. This patch

Have you see this failure? Any log of that..

> use wait_event_timeout instead of wait_event_freezable_timeout
> to avoid interrupting ongoing tests by signal brought by
> kthread_stop().
> 
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>  drivers/dma/dmatest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index ffe621695e47..c06b8b16645a 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -827,7 +827,7 @@ static int dmatest_func(void *data)
>  		} else {
>  			dma_async_issue_pending(chan);
>  
> -			wait_event_freezable_timeout(thread->done_wait,
> +			ret = wait_event_timeout(thread->done_wait,
>  					done->done,
>  					msecs_to_jiffies(params->timeout));
>  
> -- 
> 2.33.0

-- 
~Vinod

