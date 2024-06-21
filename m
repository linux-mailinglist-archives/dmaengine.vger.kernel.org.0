Return-Path: <dmaengine+bounces-2491-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFC8911D20
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 09:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF4E1C2158E
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5397116C86A;
	Fri, 21 Jun 2024 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHcU5OcK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC327E58D;
	Fri, 21 Jun 2024 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955907; cv=none; b=V9XjUxSAUC75Uh326/Q3RBprCVX3rt3nc1njBXs9kNJM1kg/BhljPrWM3BqlrXSZ+Yj7dZO8RWHj4ff+JpK8rEQJ7anZ2HLtZgq6Cc8pA3uoEZ5XyAZFgVKtt7gwwpV2bkjHQQJKEMmrf+Uc5IXfxPXjxDfAJVM8qgZxc2rAZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955907; c=relaxed/simple;
	bh=kaVMXrwTmSC64V9oowdkW3LocVFxxI6q7Bieew/jhU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfPAbTdq4ajlY9DT79mibCbJiBdGrXgn33H6j3eYRRXm+6gABJ76T8ApKxWEGJIDiUPWb6rfjinEUw5PrU+NSvhmJaA6NvNF5mcMil1TJm3himiFWS5BXCegfbJVEWE/vGQ1Chk2CdC6Lf7x1ngbLD7UPeLBmLsRcj5d7nEGvKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHcU5OcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A549BC2BBFC;
	Fri, 21 Jun 2024 07:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718955906;
	bh=kaVMXrwTmSC64V9oowdkW3LocVFxxI6q7Bieew/jhU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHcU5OcKmyIuSvFX2uiCfjL+hqzmLLUuXSpxQkSHq290dmv2VLJhQ4Ta69W49r4Nk
	 uirkX9qtF2gwmdG1GscRoyErHl9DlfDUe44+Yh+AS6Z4lR/aZ3g4gKMawl1Xc6IgEn
	 oagGpD0YxZXKrpnOurjlzGmtWfOwmP4XgtUkg2Ac0ncef6ZnwCaHM92NX08d7xgJKr
	 a1uwzIT4X0/2Zk3peizz7HR8/P1MY7wMhCKjy08jJ9d0yxXEVHVULJ02ZVXc+HQelZ
	 w2FYmT3aSRxqx9efS351bY1cxqsRu9O443MHLLDnCqdeKFc4QmbjElYWuvO6qWmFig
	 7zxU5x/94AxYg==
Date: Fri, 21 Jun 2024 08:44:59 +0100
From: Lee Jones <lee@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Markus Elfring <Markus.Elfring@web.de>,
	lkp@intel.com, Paul Cercueil <paul@crapouillou.net>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Julia Lawall <julia.lawall@inria.fr>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [v11 3/7] iio: core: Add new DMABUF interface infrastructure
Message-ID: <20240621074459.GF1318296@google.com>
References: <202406191014.9JAzwRV6-lkp@intel.com>
 <c25aab0d-48f6-4754-b514-d6caf8d51fd1@web.de>
 <ZnRUSaHJhz7XLcKa@matsya>
 <20240620170522.GU3029315@google.com>
 <ZnUnFeum1Z2ahm9M@matsya>
 <b7283f9458047e63e7d8c8b80daf2bd6232403cb.camel@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7283f9458047e63e7d8c8b80daf2bd6232403cb.camel@gmail.com>

On Fri, 21 Jun 2024, Nuno Sá wrote:

> On Fri, 2024-06-21 at 12:39 +0530, Vinod Koul wrote:
> > On 20-06-24, 18:05, Lee Jones wrote:
> > > On Thu, 20 Jun 2024, Vinod Koul wrote:
> > > 
> > > > On 20-06-24, 12:45, Markus Elfring wrote:
> > > > > …
> > > > > > All errors (new ones prefixed by >>):
> > > > > > 
> > > > > > > > drivers/iio/industrialio-buffer.c:1715:3: error: cannot jump from
> > > > > > > > this goto statement to its label
> > > > > >     1715 |                 goto err_dmabuf_unmap_attachment;
> > > > > …
> > > > > 
> > > > > Which software design options would you like to try out next
> > > > > so that such a questionable compilation error message will be avoided
> > > > > finally?
> > > > 
> > > > The one where all emails from Markus go to dev/null
> > > 
> > > Play nice please.
> > 
> > Would love to... but Markus has been repeat offender
> > 
> > Sadly, I am yet to see a constructive approach or even better a helpful
> > patch which improve something, rather than vague suggestions on the list

Right, there are communication issues.

Doesn't mean we have to lower our own standards.

> Yeah, just look at how many automatic replies he get's from Greg pretty much
> saying to ignore his comments.

Yes, Greg is also grumpy about it, but at least he remains polite.

-- 
Lee Jones [李琼斯]

