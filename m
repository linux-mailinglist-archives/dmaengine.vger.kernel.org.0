Return-Path: <dmaengine+bounces-7130-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6185C47F9B
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE54B4EF38B
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23234280035;
	Mon, 10 Nov 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHf0VWs4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8127FD56;
	Mon, 10 Nov 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792205; cv=none; b=ABJVLLe4fSAGvOEa559KVrI4W6BVMbjAEUFCvEntc6fusJAd4iRnjDq1aM16wNCMKvyOf4Ee/ujTzyfyr6zpFDQhsm/Hm+NkUvd20ImhZNlC2TynAYZFRO43iYXJjGMU8CkDEBxrcIEtVA4rzBLWEq3Hje/BUdiLPA95OlIUpwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792205; c=relaxed/simple;
	bh=BENcJUva/mHHQYIayp0HLjQkCuTaKmej8Tu1JFzK0Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEYEkhkfHfl06RIyEbe/eEOsL4Bop3+NeSHMiN+EBhQ0REs7RXQxgYG6CJS+ZRl6xEfpM5+3RCVvPBFQVciDksDyATDP29/Dzf+T1CorERnKeKpp9Mu/EkX6DLLEH165c1+UwEE3AqvWGhtGLue29tll2J+Qcr//C8QiJNTuqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHf0VWs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D62C116D0;
	Mon, 10 Nov 2025 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762792204;
	bh=BENcJUva/mHHQYIayp0HLjQkCuTaKmej8Tu1JFzK0Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHf0VWs4SipvI5N7AaQ6K/3tRxLQgCT0CnlyFItJoneQ+JNsfdVG0M6Yk/jBN08xo
	 AyIQ5tytEvx9KerdQJCFnfePes9C9oq8nuJsQJC7groB2UOAvBWt84OFutfFDbmwWv
	 s7EPisfszp3zTP9OGVVRxvA9gZmfqK4/JSwsYym1bV+MMBXGP0GtkolMIXIe7q6Tk0
	 OS///SXTGxp1jQSWLjdFbviBAGs2C9koNl9W72FNMm/KGamKe4mX6RyO4NpeJ7hNCd
	 1VDVMLnQg6FFWLwD2BGYTHT8rforlQ3ozWPBydIkRDCCd2xtHJLKchuIR25tmUkrE5
	 aESXY2FgTLRFw==
Date: Mon, 10 Nov 2025 10:34:10 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Vinod Koul <vkoul@kernel.org>, 
	Thomas Andreatta <thomasandreatta2000@gmail.com>, Caleb Sander Mateos <csander@purestorage.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Olivier Dautricourt <olivierdautricourt@gmail.com>, 
	Stefan Roese <sr@denx.de>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 01/13] scatterlist: introduce sg_nents_for_dma() helper
Message-ID: <bnkx654tvfekhgragyuwseg7sxcrgrnb4bvwe5bgxikaf7k2ew@kf7jb76zrf3r>
References: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
 <20251110103805.3562136-2-andriy.shevchenko@linux.intel.com>
 <waid6zxayuxacb6sntlxwgyjia3w25sfz2tzxxzb4tkqgmx63o@ndpztxeh6o32>
 <jea2owcqtjeomlbwkfopt3ujsnakn4p3xeyqhh7s4kowf7k7dr@deyg5pky5udo>
 <aRIFyR0maAfZF7MN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRIFyR0maAfZF7MN@smile.fi.intel.com>

On Mon, Nov 10, 2025 at 05:33:29PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 10, 2025 at 09:21:18AM -0600, Bjorn Andersson wrote:
> > On Mon, Nov 10, 2025 at 09:05:26AM -0600, Bjorn Andersson wrote:
> > > On Mon, Nov 10, 2025 at 11:23:28AM +0100, Andy Shevchenko wrote:
> 
> ...
> 
> > > >  int sg_nents(struct scatterlist *sg);
> > > >  int sg_nents_for_len(struct scatterlist *sg, u64 len);
> > > > +int sg_nents_for_dma(struct scatterlist *sgl, unsigned int sglen, size_t len);
> 
> 
> ^^^
> 
> > > > +int sg_nents_for_dma(struct scatterlist *sgl, unsigned int sglen, size_t len)
> > 
> > All but two clients store the value in an unsigned int. Changing the
> > return type to unsigned int also signals that the function is just
> > returning a count (no errors).
> 
> The type is chosen for the consistency with the existing APIs.
> So, I prefer consistency in this case, if we need to change type, we need to do
> that for all above APIs I believe. And this is out of the scope here.
> 

That makes sense, after a second look I agree with your decision.

Regards,
Bjorn

> Personally I was also puzzled of the choice as *nents members are all unsigned
> int in the scatterlist.h.
> 
> ...
> 
> > > We need an EXPORT_SYMBOL() here.
> 
> Good catch! I'll add it in next version.
> 
> > > With that, this looks good to me.
> > > 
> > > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> Thanks!
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

