Return-Path: <dmaengine+bounces-1177-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED186BDA7
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 02:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EE31C24277
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 01:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E734224DC;
	Thu, 29 Feb 2024 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMmm8JIO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D632DF84;
	Thu, 29 Feb 2024 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168252; cv=none; b=Do2/Rjd3QVPc5E/4Ute/+uEWgmil9SnOh/XpYAGfY5BotuFM3sRsOg3+t8qAs6h2tSXcr2nLWXkgDVeqrI/sTTr/bMLkn4Iz8/ncW3klyGOs0/FmkXdzqRvr0CndyYLO8u8ndGxP2i9s+KHzwR/pC2IftoM6nz6U9TsNnXZ28DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168252; c=relaxed/simple;
	bh=9KaT+6S7JZlcb2mqMqAoog9VXZWY4bx0fyUl0UJuoNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RK0u2bUcxip1VUCWNqd6xE8ZC4pkP0/UWGM5Y15gyEh5NA98dWiwPSkahq5Lj76bIVbkxd2cc8xNg9jd7TSIL6NqgwJ8H0RVsyyBL1RQ2DIXto7adaHtrPYo/gUToZhcx2IL6wQWky+rIFDU6eQDplzASMOyUvDEnWEfRap/fRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMmm8JIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B6EC433C7;
	Thu, 29 Feb 2024 00:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168251;
	bh=9KaT+6S7JZlcb2mqMqAoog9VXZWY4bx0fyUl0UJuoNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sMmm8JIOVjqOr3OrT942IjBG7UKaB6xofC8V7MI0361wtXr/2mSCLg/fKaHNzVMV0
	 27XOpP4pciTtBcLUuvOKPKbt4NCRCZW6SZ4En0fi0cqX1zt1Tf1JOC9s/S2YlCDB5H
	 Sb0+b8KxuZiErmAlyYOyOXgIESUQ4oJTQMD5U55ykiqhCUNAzn4RDGYgyZ+mePa58A
	 N9EaKF6VOJncq8I34SR+Bwj84PBaL3FqbmTqh+6WRpy3Gr3Z5kGXfshMFqVMchr++B
	 K685dDwfg4O7Qk+Si2ZCgMdMCRZNnN50dFN3ewjIbp0CjjHwfJx8idwMFqJBxnA1LN
	 nnlsJXladKNNg==
Date: Wed, 28 Feb 2024 16:57:30 -0800
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
Message-ID: <20240228165730.3171d76c@kernel.org>
In-Reply-To: <653bbfe8-1b35-4f5e-b89d-9e374c64e46b@embeddedor.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
	<20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
	<202402281341.AC67EB6E35@keescook>
	<20240228144148.5c227487@kernel.org>
	<202402281554.C1CEEF744@keescook>
	<653bbfe8-1b35-4f5e-b89d-9e374c64e46b@embeddedor.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 18:49:25 -0600 Gustavo A. R. Silva wrote:
> struct net_device {
> 	struct_group_tagged(net_device_hdr, hdr,
> 		...
> 		u32			priv_size;
> 	);
> 	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
> }

No, no, that's not happening.

