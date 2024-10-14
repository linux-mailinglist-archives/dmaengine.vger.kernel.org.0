Return-Path: <dmaengine+bounces-3338-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A85099C473
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 10:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007D91F21505
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 08:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD531553A3;
	Mon, 14 Oct 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkQUS2ip"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE412CD96;
	Mon, 14 Oct 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896303; cv=none; b=i69yEs+6LWQ6o+Hz90grXQfxNPO999MjmDVyoagNExVzox4Rbq4/BnSxZKaP/5TBpV4yJSreMN9Xf2XkWYIxjZvLKZkid+KGzWVJZdav4oEMrDHM2tydj97jI3THSWVz6vhWHciuerV4G24uIqkJ5AIvGJWO9jXvaDfp4e1NVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896303; c=relaxed/simple;
	bh=en97uQq/wU58/ojsiceIgcHAfChEIeCSY/86B7fnMGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqdhF5TzN2epjByRevzWHvrJO8ztUeVOb8ix6b2fYx0w5KIta8k30O3dmhcjGfQhPJPz4end6lYOQ3VLZV18IbpBSaKn+oj2Voh49GStfPMYvURFsNjAQ9FfI+Tsv7DGhIT1Xwr1+HbMDrQLOfeQ1/iXp8RlAjsbc6M2e5euHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkQUS2ip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E721AC4CEC3;
	Mon, 14 Oct 2024 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728896303;
	bh=en97uQq/wU58/ojsiceIgcHAfChEIeCSY/86B7fnMGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkQUS2ipFVJvOJKlvZg2MsrjC5WG9NPlHUJGO2PM04x3y0W1uMDO0eyA4r4QIB1mh
	 R3gABoYQbJ59vdDERfO6qTkdYGKD2aBJRkyk3I/G4ZmA1ciQuCT/gTgI9qxPp1cba6
	 W6YlwNHRgPmXPsjOo3WbvPKCc5N5Ca65WAtUOLXjGOMA68sRYsYB+av/E54Pm1e4P5
	 KRN5ZMHXY8gp9uTPixE1WTe7upozapRI6c+FG+oaDeL/Fxij40NSBaRu4giU/LZxni
	 1+YOMvqsYuEgMZA5SxnbQczrQo+cE+X0BcdkVVZfacpx/TC9vnj0MVf3QuSxFaQubt
	 JfSWx+qVgy7qQ==
Date: Mon, 14 Oct 2024 09:58:19 +0100
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.12-rc3
Message-ID: <20241014085819.GO77519@kernel.org>
References: <CAHk-=wg061j_0+a0wen8E-wxSzKx_TGCkKw-r1tvsp5fLeT0pA@mail.gmail.com>
 <20241014072731.3807160-1-geert@linux-m68k.org>
 <711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org>

On Mon, Oct 14, 2024 at 10:38:20AM +0200, Geert Uytterhoeven wrote:
> On Mon, 14 Oct 2024, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.12-rc3[1] to v6.12-rc2[3], the summaries are:
> >  - build errors: +3/-1
> 
>   + /kisskb/src/crypto/async_tx/async_tx.c: error: no previous prototype for '__async_tx_find_channel' [-Werror=missing-prototypes]:  => 43:1
> 
> powerpc-gcc{5,13}/ppc44x_allmodconfig
> 
>   + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]:  => 126:37
>   + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]:  => 126:46

Hi Geert, all,

I wonder what the correct string format is in these cases?
I didn't have a good idea the last time I looked.

> 
> powerpc-gcc{5,13}/ppc85xx_allmodconfig
> 
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8e929cb546ee42c9a61d24fae60605e9e3192354/ (all 194 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b/ (131 out of 194 configs)

...

