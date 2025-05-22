Return-Path: <dmaengine+bounces-5250-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E74AC11C5
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 19:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1EB87A3BAC
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6429AAFD;
	Thu, 22 May 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7Cgago1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4D029A9DE;
	Thu, 22 May 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933144; cv=none; b=dwMlNvIOF+3iEV4+TNI4JX/wmBn/TkmVj/H1Ihtls08TBaiJhLbhH6mU1x+9t1/RQCOZdQbJmjbm15XW58UOvs8tJHwURUIfUHbLpKqEqTV6BvIciw6GQIMjprzYhLKx9E1dD+ZGtr67Yma1UHyoT4D8GxNXz01tcBOYl6L5Rs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933144; c=relaxed/simple;
	bh=7iUCLpjO0G0zm2z7WiyRM1wJ4Bn0E0bw1Qm+rsSCJn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfQZHkEvYfy5aGrwGgfBUfOGOhTHJgwP57rfLVg09NDyvOQn3ZxfMrnGmSZNbdWS6QUwNx+c/M2WUxynSVlaDZkJORexs8J46vicLK8SFD/GO+q2IUOOlh1h/CPskh43yk249XW1i1RKFAfEjP8rfS2MhQMcQuPHKYdZlaiYcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7Cgago1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE92C4CEE4;
	Thu, 22 May 2025 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747933143;
	bh=7iUCLpjO0G0zm2z7WiyRM1wJ4Bn0E0bw1Qm+rsSCJn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7Cgago1q5PCxsQNxVwuQJuW8zkePLjv+iWIv0JD6I5t/6ql+rb4fFWG2L9hp9OYn
	 FJVJ55WUDdUHTdtn/RZucx2Q4HV+pUJylhXB0zQqshopiGw2Z+0PBZO6tvH+qpTNOM
	 YIyNF0LTtCC9cRn/2kBtm1P4atjVGak+IEgfFXkFDUiXGLfNCU2FSZzwc5I5GW5JkQ
	 l/jUHoBLnUfqgsN8KZhd9Bhffmel+KcGhZFAU7hcmO9eZS46RdeKlWeTOVrGdkR25w
	 Qov9/fTKvSYOJzzhE4ppa6tGE2JnaPviAVaRDOtAZSUBrgIwdFJJwP+pHpQezh6V4P
	 vP5OhDqjT3XUA==
Date: Thu, 22 May 2025 09:59:01 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, vkoul@kernel.org,
	chenxiang66@hisilicon.com, leon@kernel.org, jgg@nvidia.com,
	alex.williamson@redhat.com, joel.granados@kernel.org,
	iommu@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Haavard.Skinnemoen@google.com,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/6] fake-dma: add fake dma engine driver
Message-ID: <aC9X1VFrRJbH4bYm@bombadil.infradead.org>
References: <20250520223913.3407136-1-mcgrof@kernel.org>
 <20250520223913.3407136-2-mcgrof@kernel.org>
 <e3b98f16-2b9f-4cc1-8a54-29c6dfee918f@arm.com>
 <CGME20250521170724eucas1p28e65ef0ade407ce9e2cfe0b72da26d7a@eucas1p2.samsung.com>
 <aC4IRTo_HBxv9dVN@bombadil.infradead.org>
 <fe97e7ba-85d1-44c7-9de8-2082146f335d@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe97e7ba-85d1-44c7-9de8-2082146f335d@samsung.com>

On Thu, May 22, 2025 at 01:18:45PM +0200, Marek Szyprowski wrote:
> On 21.05.2025 19:07, Luis Chamberlain wrote:
> > On Wed, May 21, 2025 at 03:20:11PM +0100, Robin Murphy wrote:
> >> On 2025-05-20 11:39 pm, Luis Chamberlain wrote:
> >>> Today on x86_64 q35 guests we can't easily test some of the DMA API
> >>> with the dmatest out of the box because we lack a DMA engine as the
> >>> current qemu intel IOT patches are out of tree. This implements a basic
> >>> dma engine to let us use the dmatest API to expand on it and leverage
> >>> it on q35 guests.
> >> What does doing so ultimately achieve though?
> > What do you do to test for regressions automatically today for the DMA API?
> >
> > This patch series didn't just add a fake-dma engine though but let's
> > first address that as its what you raised a question for:
> >
> > Although I didn't add them, with this we can easily enable kernel
> > selftests to now allow any q35 guest to easily run basic API tests for the
> > DMA API. It's actually how I found the dma benchmark code, as its the only
> > selftest we have for DMA. However that benchmark test is not easy to
> > configure or enable. With kernel selftests you can test for things
> > outside of the scope of performance.
> 
> IMHO adding a fake driver just to use some of its side-effects that are 
> related with dma-mapping without the obvious information what would 
> actually be tested, is not the right approach. Maybe the dma benchmark 
> code can be extended with similar functionality as the selftests for 
> dma-engine, I didn't check yet.

I like the idea, however I will can save you time. The dmatest was
added with the requirement for a DMA controller exposing DMA channels
through the DMA engine. The dma benchmark does not, it test an existing device.

At a cursory glance, if we want to do something like this I think this
would be evaluating merging both. Merging both is possible if we're willing
to then make the DMA channel requests optional, as I don't think every
device which we'd bind to the DMA benchmark would / could use the DMA
channels.

The point to the fake-dma driver was to write a DMA controller which
simulates fake DMA channels and registers to the DMA engine, it exposes
these channels so we can leverage the dmatest. The DMA controller capabitilies
are a full feature set to ensure we can test all APIs used for them through
DMA channels. At first I was under the impression DMA controllers always
need to register DMA channels, however I'm now under the impression DMA
controllers don't need to expose DMA channels. Is that right?

If DMA channels are optional and a specialized feature only leveraged
by certain devices, then bundling this into dma-benchmark just
architecturally doesn't make sense.

> It would be better to have such  self-test in the proper layer.

Agreed. Perhaps the dmatest reflects the age of the evolution of the
DMA engine with some specialized DMA controllers with DMA channels,
either private or public for verfy specialized offload operations. And
that's optional?

Regardless, its a feature of the DMA engine, and if we want to keep
test coverage for it, my point that its not feasible today to test
dmatest on q35 guests stands, still validating the need for something
like the fake-dma driver.

Then we'd need stick with two selftests:

 - dmatest - perhaps should be renamed for the emphasis on channels
 - dma-benchmark - for regular DMA API

If this is correct, this patchset still seems to be going in the
right direction.

> If adding the needed functionality to dma 
> benchmark is not possible, then maybe create another self-test, which 
> will do similar calls to the dma-mapping api as those dma-engine 
> self-tests do, but without the whole dma-engine related part.

That's what this patchset does already. What I wish was easier was
to not have to *require* doing to unbind/bind of a real device. That
would allow us to also enable CI testing through virtualization. I'll
try the few knobs suggested by Leon to see if that enables it.

  Luis

