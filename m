Return-Path: <dmaengine+bounces-1173-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED0986BAD0
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 23:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10571C20CAF
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 22:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B8D7004E;
	Wed, 28 Feb 2024 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riY0y4Fx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90F2B9A7;
	Wed, 28 Feb 2024 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160110; cv=none; b=oMFSD1NVvqM3EgWERLc1UzZk4Xp6a/LCQSQwGHVFFb/rY05o3goYQZXYHugOFYKFs1RM4+ehZ5Neq6PwC9GzfvfxGnEVy+DqDWWmgwoQAmF3yxpEHs1U0tO53W/60mK39j+6GrUpNfXlTju1AjqzpN5W0V8EC+7zFs+hxjsVK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160110; c=relaxed/simple;
	bh=tjZVW+wfEpV5hm2GKoaS8QIBTAqnujkBvNvmFWcTTLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLCtoNmnyd0U9TG/tB7PNN0sW9JEMn7c5/JfaR1hnpxQ+lIE4V/i6M3KJr12Axa5l91haet2d2XYUjGQiQuo4adpiR53IE2pG0j9SrlJk/pJHdcKZND4SDOWRvWkn0D5asLsMYOCLwYY8zmg32b945j/iKa2A3dM3L+PLds669A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riY0y4Fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C851C433C7;
	Wed, 28 Feb 2024 22:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709160110;
	bh=tjZVW+wfEpV5hm2GKoaS8QIBTAqnujkBvNvmFWcTTLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=riY0y4Fx+9tYTZwqjeMsvr4+CHnvM+egJckNzF8PFaNWQ4EcaJYupvlD7D/scvNCv
	 OhTNiq2/vxp/DVYtwKstTH3GAs1WmKe8yIY1CUOu7+oAK4EjG6PWlW5nZZj/ylk/xd
	 9Osn0CC2JXqYGhqhpjD+IOdYMgVLSQLQIgWQ8GvziuaEoSKgQ5/+gk9d5rqnvYJyKh
	 WOn77ZDAlVWd8VC4fDQ6lEprgplYLB9xmm50yk2Fw7mM8ribnczNkB4HznWNedrKbx
	 0Zi5KnVyCs3gsId7Prbd3CVRBlNzEzTBkG0FuvZyKyNF8B/BkVTOKkG38ds7GZgeJM
	 RMKDJwj4vNoHg==
Date: Wed, 28 Feb 2024 14:41:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul
 <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-spi@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Message-ID: <20240228144148.5c227487@kernel.org>
In-Reply-To: <202402281341.AC67EB6E35@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
	<20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
	<202402281341.AC67EB6E35@keescook>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 13:46:10 -0800 Kees Cook wrote:
> I really don't like hiding these trailing allocations from the compiler.
> Why can't something like this be done (totally untested):
> 
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 118c40258d07..dae6df4fb177 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2475,6 +2475,8 @@ struct net_device {
>  	/** @page_pools: page pools created for this netdevice */
>  	struct hlist_head	page_pools;
>  #endif
> +	u32			priv_size;
> +	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);

I like, FWIW, please submit! :)

