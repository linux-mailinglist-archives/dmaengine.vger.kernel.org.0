Return-Path: <dmaengine+bounces-6607-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0F3B81550
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 20:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925DE4A57A2
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 18:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC272FD1BF;
	Wed, 17 Sep 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siL+TZXh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA142F7AA7;
	Wed, 17 Sep 2025 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133518; cv=none; b=KJJi2ddyADmRlOjd/Efs0RmS/IZLJMiP+w+3l7HLQeVbCVldKe21oxvvkoiPobcOLyOWMiIimLI7MwY1h9uXw26XanXo3XGim298baWVfrnjaa32LPUfKN0S+6kII1MsRkzTip+kvhuKVrPfL0qXlBaRqOhjm3AD6J64e6/4G8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133518; c=relaxed/simple;
	bh=ol6jCR0N9MRDTPmJkwp6Mwk5BfnDhBqRmd9kJrfHils=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jvs3qcPZjSz1xxmocMkV5VxFhz/cENDeao3RZargMzrShb+pRvctBq1ZtAYtQv/m6PUyldP489UHCzfA0lq1mu5yjBoM2gk35cZ+HdzV07ph62PRPw9vIUIBfzgUEk4gwV4b+rVmXIYKJaRoTtnalFgPcU9rAR6Xh/TJPBGtd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siL+TZXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15724C4CEE7;
	Wed, 17 Sep 2025 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758133517;
	bh=ol6jCR0N9MRDTPmJkwp6Mwk5BfnDhBqRmd9kJrfHils=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=siL+TZXh5aIyUhYcmGbqGVIoC7PSYcFcThXMRrAt8VoWxV2RFQmaA/1D6+DhbxHS2
	 4S+iaSvqROJ0B078hZCGJfxGQrhM84bAPoYTgTODTxGflm2qyTw6nmMPu1YMiSjz4c
	 Z21RPIfi6x6XBHnZYyfWOewX+Zj9qLu5DWw2WiYlOTQC4WgjwW918dAvC3KlGklgVE
	 2dGkK4AIEoOewXUGmwqBTc7kZ7O9sh/bhM26NNOtewBLa74q+4CQEy126vu4D5g+HB
	 zY/ClVoO3HJiUHjKRa2piV8x6uRsoY45vaxD6z2FpsMOZFai0YxHxIyfjwDj+QRMjS
	 JasuvEFFP1D4Q==
Date: Wed, 17 Sep 2025 11:25:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Vinod Koul <vkoul@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Benjamin Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250903 x86_64 clang-20 allyesconfig mmp_pdma.c:1188:14:
 error: shift count >= width of type [-Werror,-Wshift-count-overflow]
Message-ID: <20250917182512.GA98086@ax162>
References: <CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com>
 <a07b0ebf-25e7-48ba-a1da-2c04fc0e027f@app.fastmail.com>
 <20250903165931.GA3288670@ax162>
 <CAH1PCMYWWkThMosDMW=wZZWZ8d_c4_zQWhJOJPKe354LPiV1bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH1PCMYWWkThMosDMW=wZZWZ8d_c4_zQWhJOJPKe354LPiV1bA@mail.gmail.com>

Hi Guodong,

On Thu, Sep 04, 2025 at 03:38:21PM +0800, Guodong Xu wrote:
> On Thu, Sep 4, 2025 at 12:59 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Wed, Sep 03, 2025 at 02:04:10PM +0200, Arnd Bergmann wrote:
> > > On Wed, Sep 3, 2025, at 12:08, Naresh Kamboju wrote:
> > >
> > > > Build error:
> > > > drivers/dma/mmp_pdma.c:1188:14: error: shift count >= width of type
> > > > [-Werror,-Wshift-count-overflow]
> > > >  1188 |         .dma_mask = DMA_BIT_MASK(64),   /* force 64-bit DMA
> > > > addr capability */
> > > >       |                     ^~~~~~~~~~~~~~~~
> > > > include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
> > > >    73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> > > >       |                                                      ^ ~~~
...
> Thanks, Arnd. I'll send a patch to clean up and simplify the logic.

This error continues to break our -next builds. Have you submitted this
patch yet? I searched lore.kernel.org and I did not find anything but I
wanted to make sure I had not missed anything.

Cheers,
Nathan

