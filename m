Return-Path: <dmaengine+bounces-1176-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DDC86BDA2
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 02:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B9B1F24C45
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 01:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D6B2D79D;
	Thu, 29 Feb 2024 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dtr4muXV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1213D2E8;
	Thu, 29 Feb 2024 00:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168172; cv=none; b=MM3q5JCcg1HxwnRY4Sz9sNO7kzsiamEePIThx+lJKLZODAynIsKUkH/dscStXh3nwEuXa83Qsy+cZOzRyZ/AVsM9k4gzE0mJO+0M42VMGeNxmPOSnwkosDnuyFWQINj+XzFW64WXXldkeXmkOueFWYPcRuWskQGNKzEYYOEobeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168172; c=relaxed/simple;
	bh=8INiMNb8bGe9aH8MD1xrZEujm+XkODnaql/+pLNknt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6OqHIbueUtxk1Dr1eMs5BZH6HxoOYl+qaU+HH5xBE/IXaktzYRTtBF6aIZiS83DaUREBNcVwQHPsy73zprL4c36VI5DhlEMbUYWSEmfh7j3G+wejsg9Y46wl2oIP2WQ4tYIt4JPu3K5uviv2Yrv+uAjTLGPbqnJ8oorA1VmZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dtr4muXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6112C433C7;
	Thu, 29 Feb 2024 00:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168171;
	bh=8INiMNb8bGe9aH8MD1xrZEujm+XkODnaql/+pLNknt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dtr4muXV2rTHbzpPr88K48luIP2g5EU4EX+96sQpgs2qtpPNDRTn8rPggkUSD2ZfG
	 48BtLthfzFgdoGiQGSW+PLQjm11pds7mKoPGIR3Rw/7bEKrfufh4/jMX4q/Z8g5tAl
	 oZTnu3DWuw1pvw9su+znP5UltSVjQB+QRC7dqkr1zFT8CYpE3nijeKnOMri4ozteck
	 awembGWUfpqTpg/GNSa7/gHIq14jzb43s58g+58dZoM6Os779mvmpqmvCu1B9BC7Ms
	 TKaGc1dS8DssrFm+AArg8gWcpHiw6UtNWSLatVqVUQ4JwwprQnoAH1ePVxfwbp3zaf
	 XsNBq1wjQWgtQ==
Date: Wed, 28 Feb 2024 16:56:09 -0800
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
Message-ID: <20240228165609.06f5254a@kernel.org>
In-Reply-To: <202402281554.C1CEEF744@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
	<20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
	<202402281341.AC67EB6E35@keescook>
	<20240228144148.5c227487@kernel.org>
	<202402281554.C1CEEF744@keescook>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 16:01:49 -0800 Kees Cook wrote:
> So, I found several cases where struct net_device is included in the
> middle of another structure, which makes my proposal more awkward. But I
> also don't understand why it's in the _middle_. Shouldn't it always be
> at the beginning (with priv stuff following it?)
> Quick search and examined manually: git grep 'struct net_device [a-z0-9_]*;'
> 
> struct rtw89_dev
> struct ath10k
> etc.

Ugh, yes, the (ab)use of NAPI.

> Some even have two included (?)

And some seem to be cargo-culted from out-of-tree code and are unused :S

> But I still like the idea -- Gustavo has been solving these cases with
> having two structs, e.g.:
> 
> struct net_device {
> 	...unchanged...
> };
> 
> struct net_device_alloc {
> 	struct net_device	dev;
> 	u32			priv_size;
> 	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
> };
> 
> And internals can use struct net_device_alloc...

That's... less pretty. I'd rather push the ugly into the questionable
users. Make them either allocate the netdev dynamically and store 
a pointer, or move the netdev to the end of the struct.

But yeah, that's a bit of a cleanup :(

