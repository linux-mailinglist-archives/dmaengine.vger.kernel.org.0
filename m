Return-Path: <dmaengine+bounces-8135-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4538FD06DF5
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 03:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8286830173A6
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 02:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E173168E5;
	Fri,  9 Jan 2026 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9GPn2/4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85E2BB13;
	Fri,  9 Jan 2026 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767926527; cv=none; b=oImU4TxldYkZqhFH2aJghsXlAVA525/0j203Q0GG1mUxfP+t0E5jwT5t3SG/NmtHN8/bbSQhl/+anjhPahBlLr6JY81LClsKa8UxhhsFZ9rf2itlKnjILI7P09aZ+GupvVi5vzfQ4AJ1CXmiJ2Hzt5RvgzkFgl/j4XwFVukEza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767926527; c=relaxed/simple;
	bh=g31+4Hf030M5UkrfcWRXSDe9kElttwljGric81+w9Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAKLU1fsXZLMocy17RvUJA6DkpFaMiVLnoBOStM7pYxHEoZFh3OkvD9011knMQahGV7LpcKPNfRfRSbIIJLzL+5w/RmMwVnUGgjxfAA5CtmgmkH7BBSaIpFCjCem260nwa64K1sd9iKXT7ZelBsJnCLY2QCOHTxGPEpxaaf+kPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9GPn2/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5507C116C6;
	Fri,  9 Jan 2026 02:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767926525;
	bh=g31+4Hf030M5UkrfcWRXSDe9kElttwljGric81+w9Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P9GPn2/4mrGiOQuMOVF3/qf3CWBbZDpu10LOxAYiSicJBhAgK05Wi1CMZmgZo3nrd
	 sjMWJiuK9iVJ4IE7WS0lSULEUoLljgnCt/jQwJpSkNnqH5QD8NS093J467RPre87fn
	 is3ckKb1kj6aSclP+7K6KJb5UlcwJhJgDPNkhUraCWQvaU/lA9NhUDBWIUWrU4shCb
	 BNuFPZmxKwaAVD4o1pKn8Ur9RK0cNz9ZYk2rat1kytYxRAvkRe/xQBC+DKbF9jZcK1
	 VOZpF+EXDBQHM2yX8F+PUMonMGhMQAAACCsK/HlCI11Gz33tKpuqqfNb2D592PCnUO
	 0btfwyrJmbGYQ==
Date: Fri, 9 Jan 2026 08:12:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, dmaengine@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [RESEND][PATCH v1] dmaengine: sh: Discard pm_runtime_put()
 return value
Message-ID: <aWBq-Rfu1yez6EjK@vaman>
References: <8633556.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8633556.T7Z3S40VBb@rafael.j.wysocki>

On 08-01-26, 16:28, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Clobbering an error value to be returned from shdma_tx_submit() with
> a pm_runtime_put() return value is not particularly useful, especially
> if the latter is 0, so stop doing that.
> 
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.

Hey Rafael,

This is commit b442377c0ea2044a8f50ffa3fe59448f9ed922c in my tree.

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is requisite for converting pm_runtime_put() into a void function.
> 
> If you decide to pick it up, please let me know.
> 
> Otherwise, an ACK or equivalent will be appreciated, but also the lack
> of specific criticism will be eventually regarded as consent.
> 
> Originally posted here:
> 
> https://lore.kernel.org/linux-pm/9626129.rMLUfLXkoz@rafael.j.wysocki/
> 
> ---
>  drivers/dma/sh/shdma-base.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/dma/sh/shdma-base.c
> +++ b/drivers/dma/sh/shdma-base.c
> @@ -143,7 +143,7 @@ static dma_cookie_t shdma_tx_submit(stru
>  				}
>  
>  				schan->pm_state = SHDMA_PM_ESTABLISHED;
> -				ret = pm_runtime_put(schan->dev);
> +				pm_runtime_put(schan->dev);
>  
>  				spin_unlock_irq(&schan->chan_lock);
>  				return ret;
> 
> 

-- 
~Vinod

