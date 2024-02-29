Return-Path: <dmaengine+bounces-1179-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2481D86BE24
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 02:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98741F2BD22
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 01:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32CC2CCA0;
	Thu, 29 Feb 2024 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2Xeh2Ru"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E122612;
	Thu, 29 Feb 2024 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709169311; cv=none; b=NyEr9AqRXn/URPQHCHc+ZG2V5BMYyGbn73VdRPL10DpkN70hJRKTskxUgmNf5GGXrzazAuOEBKqQUo6s8Ym9ypgRR2hcc0xFiv+J19GFIRbNsS/LhuQSs+i/bt4DE+UVN+ST0Bbu6c5jxgLrR131r18nzBNGSumhUSxCkhZWgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709169311; c=relaxed/simple;
	bh=z7f+Dbb4dDt0wPU1cnaBodq/Wil5VeJE1ycdq0aUaq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDkiRWivDVTSmDqoXvZxLqJQwLO77dMlNE2pGqA5fEpSzz4Efh54+SXM4U+79e4kmDFBAirwdN/urZLMuJ7qdJesczDLVVzXqRz4Rr2jiSo0K1xfjovhjhXrBVTwb62Bjiki9/gNugFZjt7bKmUBm/GLK87BEHJ4pNkJK+EiWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2Xeh2Ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55633C433F1;
	Thu, 29 Feb 2024 01:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709169311;
	bh=z7f+Dbb4dDt0wPU1cnaBodq/Wil5VeJE1ycdq0aUaq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F2Xeh2RubzK3AW7IcsJ8JguT0FCtBPq8dwfnSFWlufbMmVlY2g3+MfMfEM01Bh2MK
	 z5ccVI4tykZjoiO95oQ0dYg7GIlCTWyTi1Up81i0EuRKMYHvTR5n3W7fN8QXupphte
	 kmZSklRhuYvDXiSRo1BgmiYdzVRKbBrx4t+PIIvHBN+xtBaQAxt7uzmGk7tFXnlgbQ
	 052q7dyS0vKRTmZlh2lrVMMEfladfdH9F25NkO8VShL0ha5ZC7/vJ16RoBIsVmThjH
	 YyDT8eVuI7JTTNXRsjZH4swfQGnpZIb+u7GFjMp/lsSh4GmDwDnJwY36VOmwmY+KzH
	 ictO3oxeNV89g==
Date: Wed, 28 Feb 2024 17:15:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-spi@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Message-ID: <20240228171509.4eeb5519@kernel.org>
In-Reply-To: <49f55b02-ce21-40ac-a4cc-02894cd5eb8f@embeddedor.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
	<20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
	<202402281341.AC67EB6E35@keescook>
	<20240228144148.5c227487@kernel.org>
	<202402281554.C1CEEF744@keescook>
	<653bbfe8-1b35-4f5e-b89d-9e374c64e46b@embeddedor.com>
	<20240228165730.3171d76c@kernel.org>
	<49f55b02-ce21-40ac-a4cc-02894cd5eb8f@embeddedor.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 19:03:12 -0600 Gustavo A. R. Silva wrote:
> On 2/28/24 18:57, Jakub Kicinski wrote:
> > On Wed, 28 Feb 2024 18:49:25 -0600 Gustavo A. R. Silva wrote:  
> >> struct net_device {
> >> 	struct_group_tagged(net_device_hdr, hdr,
> >> 		...
> >> 		u32			priv_size;
> >> 	);
> >> 	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
> >> }  
> > 
> > No, no, that's not happening.  
> 
> Thanks, one less flex-struct to change. :)

I like the flex struct.
I don't like struct group around a 360LoC declaration just to avoid
having to fix up a handful of users.

