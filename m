Return-Path: <dmaengine+bounces-6374-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB577B4276D
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 18:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099B91BC3BEF
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 17:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87F5310783;
	Wed,  3 Sep 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du5TE5lY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8630ACEC;
	Wed,  3 Sep 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918776; cv=none; b=JfS3LqQVrDDHEKw7k1iA/7tmU7FWi5d7u0RkEq3tUdxXiyJPGaIEnxdMGvIwY3rsOIKpPZjt909m4BewJO2rvocDx/gLRE3cucxUHEJMGXVk2cw2f7qJ7oMUdtbYyExqd4dw4tNPqA8dyxL3uQNgAdbeZfW6sIkrRNSENiqne4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918776; c=relaxed/simple;
	bh=Bqf24ykq34pargsaFkq2Si91QolnsDSUcmZFVagHHxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPAUA5wnyXlfQeYnHtLYLpI34jMrKdQ1Qpb+XVty3OtAqWvBB5/fn3hf7qgln+6MWN/OihOnjYfYb1Uwsd69TCimYVMudT1BkgAeYn+qe4BH4pw0bZ8eZMfKBSmfMj9/a8VEe2pGmIjhRJJyBPAG73ekMJ1wtcjCLfAxJq1gd+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du5TE5lY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA1FC4CEE7;
	Wed,  3 Sep 2025 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756918776;
	bh=Bqf24ykq34pargsaFkq2Si91QolnsDSUcmZFVagHHxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Du5TE5lYoogdhCZUtO1tel1NWCb+x+qPCPq3AV01bnDFGXDJRT39do3O1tCPzV4rh
	 yS0i9EHdHo7tJ+8i/v93XBaqHQ5atOrYSve6VFvjL21XhFRWFqOJR86gnyEW4s2464
	 sKhw6iR1mdlWKulnBALC/mBZYBz02XHK0rCLL7eBcdMeboglcMnGj6uW6ulA9t4d/+
	 DNzP3DvqvpWSPMl/0+2yVxKLSnMBOG4XbQqsgMuxCrzV/wp/KdED0zTxhyojEwuA2O
	 IWnf0MUhCF1wzyx07TUlZNwhYU09CKPzn1Qs7E7SyJ0dbDSd9EcbjDAshkm9U18Kyk
	 /BFUncYou4Ecg==
Date: Wed, 3 Sep 2025 09:59:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Vinod Koul <vkoul@kernel.org>, Guodong Xu <guodong@riscstar.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Benjamin Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250903 x86_64 clang-20 allyesconfig mmp_pdma.c:1188:14:
 error: shift count >= width of type [-Werror,-Wshift-count-overflow]
Message-ID: <20250903165931.GA3288670@ax162>
References: <CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com>
 <a07b0ebf-25e7-48ba-a1da-2c04fc0e027f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07b0ebf-25e7-48ba-a1da-2c04fc0e027f@app.fastmail.com>

On Wed, Sep 03, 2025 at 02:04:10PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 3, 2025, at 12:08, Naresh Kamboju wrote:
> 
> > Build error:
> > drivers/dma/mmp_pdma.c:1188:14: error: shift count >= width of type
> > [-Werror,-Wshift-count-overflow]
> >  1188 |         .dma_mask = DMA_BIT_MASK(64),   /* force 64-bit DMA
> > addr capability */
> >       |                     ^~~~~~~~~~~~~~~~
> > include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
> >    73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> >       |                                                      ^ ~~~
> 
> I see two separate issues:
> 
> 1. The current DMA_BIT_MASK() definition seems unfortunate, as the
> '(n) == 64' check is meant to avoid this problem, but I think this
> only works inside of a function, not in a static structure definition.

Right, this is one of our longest outstanding issues :/

https://github.com/ClangBuiltLinux/linux/issues/92
https://github.com/llvm/llvm-project/issues/38137

This only happens at global scope.

> This could perhaps be avoided by replacing the ?: operator with
> __builtin_choose_expr(), but that likely causes other build failures.

Yeah, that makes the problem worse somehow even though GCC says the
non-taken option should not be evaluated...

  drivers/dma/mmp_pdma.c:1188:14: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
   1188 |         .dma_mask = DMA_BIT_MASK(64),   /* force 64-bit DMA addr capability */
        |                     ^~~~~~~~~~~~~~~~
  include/linux/dma-mapping.h:73:70: note: expanded from macro 'DMA_BIT_MASK'
     73 | #define DMA_BIT_MASK(n) __builtin_choose_expr((n) == 64, ~0ULL, (1ULL<<(n))-1)
        |                                                                      ^ ~~~
  drivers/dma/mmp_pdma.c:1323:27: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
   1323 |                 dma_set_mask(pdev->dev, DMA_BIT_MASK(64));
        |                                         ^~~~~~~~~~~~~~~~
  include/linux/dma-mapping.h:73:70: note: expanded from macro 'DMA_BIT_MASK'
     73 | #define DMA_BIT_MASK(n) __builtin_choose_expr((n) == 64, ~0ULL, (1ULL<<(n))-1)
        |                                                                      ^ ~~~

> Guodong, how about a patch to drop all the custom dma_mask handling
> and instead just use dma_set_mask_and_coherent(DMA_BIT_MASK(64))
> or dma_set_mask_and_coherent(DMA_BIT_MASK(32)) here? Instead of
> passing the mask in the mmp_pdma_ops, you can replace it e.g. with
> a 'bool addr64' flag, or an 'int dma_width' number that
> gets passed into the DMA_MASK_MASK().

If this works, I think it is worth pursuing to avoid this bogus
warning/error.

Cheers,
Nathan

