Return-Path: <dmaengine+bounces-3849-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA43E9E0BF2
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 20:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518AAB42652
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AC8188A15;
	Mon,  2 Dec 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbbY+fN9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5817DFE1;
	Mon,  2 Dec 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156513; cv=none; b=D0GjvxHzhGI6i1xoD1RvWhXhaVvlos+57/zZ//Yk7x3UoxmI4kuYc32h3u2UuDq4jC9XKOgK6SdLvgshRqDfjkDqmUEFsZNdyaOZh9Omhkcxik4rohkvmLmKeHx85Z3vi2k138pa2z0r2in/ldKtcvg+aJhTF6juQtZ0rG2EYG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156513; c=relaxed/simple;
	bh=M8G40HlAqKSLTPrhmiBGiAiaHsou848ROOonuY5/5nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRhnD2q3Oi2nhCDmLY32mjUdHxT12eEUDSIGCjBQkFKdzeVC0257obxAA2akaYp+qylUyKZQNgxN1GDjEMo+5gVzgepTreRMT4Hs6zFYx/7SSK/mKPR4cXYj5A+lVWF6AebYe0bs0fwq13jeq2xm8pNMwLN73qLU4R55S7sGhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbbY+fN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653EBC4CED2;
	Mon,  2 Dec 2024 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733156513;
	bh=M8G40HlAqKSLTPrhmiBGiAiaHsou848ROOonuY5/5nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbbY+fN9ZiJcMZQiFp71hUeY1hRNb1GaGHbKL3cQIQv0DQHsvaP05oB6ME1aUAQxc
	 66OqCG4Uc+204F0ecBk78hYkY4ho4pO0qH5pqLnWHqdQYJsREc4kPCnz2BvEDSpzC5
	 M8LRpBj6bbZwV+ZNZn+NOPeekUitp+jfcHt79/k3/extQmg1tlR0PRod1vM2d2EUnN
	 zKoE3/d5q8t5H+K0Uut/gTFjwSaKBctZukM/POAYtb9mc7h+xtGljfj2baAMfQthWf
	 YYe1vLveIWbFaVPj4sT3Fnl9F7ptEGWujI2ObxJ4p49tb4eTGgzYXdeTjYxjG2HYFO
	 chlJpSIVYvNEQ==
Date: Mon, 2 Dec 2024 21:51:48 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Paul Cercueil <paul@crapouillou.net>, Nuno Sa <nuno.sa@analog.com>,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH] linux/dmaengine.h: fix a few kernel-doc warnings
Message-ID: <Z03enImvI+c7cZYw@vaman>
References: <20241125061508.165099-1-rdunlap@infradead.org>
 <1dcee6d5-761b-4fa2-a336-c23d3aaadcb9@infradead.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dcee6d5-761b-4fa2-a336-c23d3aaadcb9@infradead.org>

On 24-11-24, 22:20, Randy Dunlap wrote:
> 
> 
> On 11/24/24 10:15 PM, Randy Dunlap wrote:
> > The comment block for "Interleaved Transfer Request" should not begin
> > with "/**" since it is not in kernel-doc format.
> > 
> > Fix doc name for enum sum_check_flags.
> > 
> > Fix all (4) missing struct member warnings.
> > 
> > Use "Warning:" for one "Note:" in enum dma_desc_metadata_mode since
> > scripts/kernel-doc does not allow more than one Note:
> > per function or identifier description.
> > 
> > This leaves around 49 kernel-doc warnings like:
> >   include/linux/dmaengine.h:43: warning: Enum value 'DMA_OUT_OF_ORDER' not described in enum 'dma_status'
> > 
> > and another scripts/kernel-doc problem with it not being able to parse
> > some typedefs.
> > 
> > Fixes: b14dab792dee ("DMAEngine: Define interleaved transfer request api"), Jassi Brar
> 
> Oops, I left a note in the line above. I'll fix it for v2 after comments.

lgt,, I guess we can do a v2 now

> 
> > Fixes: ad283ea4a3ce ("async_tx: add sum check flags")
> > Fixes: 272420214d26 ("dmaengine: Add DMA_CTRL_REUSE")
> > Fixes: f067025bc676 ("dmaengine: add support to provide error result from a DMA transation")
> > Fixes: d38a8c622a1b ("dmaengine: prepare for generic 'unmap' data")
> > Fixes: 5878853fc938 ("dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Jassi Brar <jaswinder.singh@linaro.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Paul Cercueil <paul@crapouillou.net>
> > Cc: Nuno Sa <nuno.sa@analog.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: dmaengine@vger.kernel.org
> > ---
> >  include/linux/dmaengine.h |   13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> 
> -- 
> ~Randy
> 

-- 
~Vinod

