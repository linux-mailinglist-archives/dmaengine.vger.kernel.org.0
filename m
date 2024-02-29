Return-Path: <dmaengine+bounces-1204-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 496A286D34B
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 20:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEDB0B21268
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 19:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CCF13C9CD;
	Thu, 29 Feb 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+S85SBu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E21E499;
	Thu, 29 Feb 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235428; cv=none; b=X8aW52C4cT/JB60J2/BJWExVMNcSkfWLgtAlsXzrkXnDNvZtbjbmHBdETz5lekIAjZ0jPqXA/c8NWF+A9JgdwfCe5ryadXbmdSz58tR4ojZmrUuyp73KCtpcY0SQ+Vp8mFteLnxk5QYtIt5+BR7tuoTD4zy4mYMvKflxGcKJy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235428; c=relaxed/simple;
	bh=HxFiMEFSmzCFY+WY5P1+X68vvWW5G5DzknMWKq1jjbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNVu6xBYlVv9ZSElvwGVX/eRVaoZhpy3zjIa4YGSp5ueZujzHoWNimYi8DpO541AOdEoDNnwRWmnBHr9ub0MBWY508K6l1Xs0pnYTGpMuEdyNKbogWq11O0vRtxE7lh2JnCJowyndI5ECSZZFo/th+lFQihSxT4v2jLwnZbFCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+S85SBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEB1C433C7;
	Thu, 29 Feb 2024 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709235428;
	bh=HxFiMEFSmzCFY+WY5P1+X68vvWW5G5DzknMWKq1jjbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m+S85SBuV9SIHhfC9dMLCdurLg+KbyJOT0ZuQcfRPg6/ekbFXqmOI8lKWeVI4g2nw
	 97JdaKY11cvCmY2VP/uzaRPkip8FiGVFuNfb2B7WSaGBbFwGqTbIHqmJKP0b21mGZN
	 4rxBo1r7Ey34dexq9zLREL2HMcHe4Y9LQxt2DJ2U3/ZssUisaZIQxCcmngap2fFfQj
	 mdcqq9sN4FjNmHPcmD7BccNs/STrWR/FblQgrW1OklBOKeUZHLOz8/Tvp1JhHgQzKW
	 P86eMmDf0P+7+ExJ6cgkscA1xFkJWipaT9lXxCYew7am+U7hL2APqC9jwgXrIdAAgp
	 TQLDWOn4o/u5A==
Date: Thu, 29 Feb 2024 11:37:06 -0800
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
Message-ID: <20240229113706.42c877a1@kernel.org>
In-Reply-To: <202402291059.491B5E03@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
	<20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
	<202402281341.AC67EB6E35@keescook>
	<20240228144148.5c227487@kernel.org>
	<202402281554.C1CEEF744@keescook>
	<20240228165609.06f5254a@kernel.org>
	<202402291059.491B5E03@keescook>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 11:08:58 -0800 Kees Cook wrote:
> > And some seem to be cargo-culted from out-of-tree code and are unused :S  
> 
> Ah, which can I remove?

The one in igc.h does not seem to be referenced by anything in the igc
directory. Pretty sure it's unused.

> As a further aside, this code:
> 
>         struct net_device *dev;
> 	...
>         struct net_device *p;
> 	...
>         /* ensure 32-byte alignment of whole construct */
>         alloc_size += NETDEV_ALIGN - 1;
>         p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
> 	...
>         dev = PTR_ALIGN(p, NETDEV_ALIGN);
> 
> Really screams for a dynamic-sized (bucketed) kmem_cache_alloc
> API. Alignment constraints can be described in a regular kmem_cache
> allocator (rather than this open-coded version). I've been intending to
> build that for struct msg_msg for a while now, and here's another user. :)

TBH I'm not sure why we align it :S
NETDEV_ALIGN is 32B so maybe some old cache aligning thing?

