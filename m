Return-Path: <dmaengine+bounces-5237-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0373ABFBFE
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B8E3B67A8
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E2B25F780;
	Wed, 21 May 2025 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsTOiqKV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55281A8403;
	Wed, 21 May 2025 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847241; cv=none; b=gbD/0lSuWqqZN4XgNCgw4qDdOlAh8rmVGXtl2xSXqtiGq4T2sYYYFKXvcMlsO9+z4FHtLIr+VnJGWYyn9FoWdVtmILI11s7/jWbbiahyYkNgKAAF7OA+naqNAYlZ3HNAg2pZQTuSWY1F9X3szppMJfew5NHFwx/PVgah5MYdVwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847241; c=relaxed/simple;
	bh=juanpoGDP5se9DUa3Psp9B0EREdhjhS051NWJ+q3n9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpdZlkJydyQ4xjzyhFFA/NQOyOhwJ1UXT/pc5WXqOGZnUBYT3cBhqFTRCHrmFuf7ZBngJwIW3FQ1EGmgqXHb0DpjBgwW5D4G10fa1OSO0SS/EJwIFdMi+L+ACO47hfXDhrjGvolY94Eb06jrM4SZtXcE1r9vlooU2cf7f0xd+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsTOiqKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEBCC4CEE4;
	Wed, 21 May 2025 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747847239;
	bh=juanpoGDP5se9DUa3Psp9B0EREdhjhS051NWJ+q3n9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rsTOiqKVY4DrJpGQyGZLSCkFaXIef/RUnhlkx6H7kZjgGhPYTjadeF+cKFPxoIwqP
	 z8+hgmrhwwtc4R9F6R8hnyWovsSxWKTRt6xkQU5FLJ4/p017yK1ov1Aqxm6LjOraTz
	 HOR0zENg4y/oGKwdrAwlmCZWKxIVXqMaImrOvs2BVBAPidZAtGcc1A6b8Y/ApjaS7o
	 EXU0vhq0XdjRR3nhbkdT9hIoqIrubKe9zKkwvSKRrLqLnS7mQYscMw4ecLoyfRIXHz
	 eRFyDJXbV0VYRzXThnFlEtfDPVFsF75sXD0CQXYRW+lZe3nwxZiHc3X5Uo5DixgC1c
	 eWqMvjntaSRjA==
Date: Wed, 21 May 2025 10:07:17 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: vkoul@kernel.org, chenxiang66@hisilicon.com, m.szyprowski@samsung.com,
	leon@kernel.org, jgg@nvidia.com, alex.williamson@redhat.com,
	joel.granados@kernel.org, iommu@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH 1/6] fake-dma: add fake dma engine driver
Message-ID: <aC4IRTo_HBxv9dVN@bombadil.infradead.org>
References: <20250520223913.3407136-1-mcgrof@kernel.org>
 <20250520223913.3407136-2-mcgrof@kernel.org>
 <e3b98f16-2b9f-4cc1-8a54-29c6dfee918f@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b98f16-2b9f-4cc1-8a54-29c6dfee918f@arm.com>

On Wed, May 21, 2025 at 03:20:11PM +0100, Robin Murphy wrote:
> On 2025-05-20 11:39 pm, Luis Chamberlain wrote:
> > Today on x86_64 q35 guests we can't easily test some of the DMA API
> > with the dmatest out of the box because we lack a DMA engine as the
> > current qemu intel IOT patches are out of tree. This implements a basic
> > dma engine to let us use the dmatest API to expand on it and leverage
> > it on q35 guests.
> 
> What does doing so ultimately achieve though?

What do you do to test for regressions automatically today for the DMA API?

This patch series didn't just add a fake-dma engine though but let's
first address that as its what you raised a question for:

Although I didn't add them, with this we can easily enable kernel
selftests to now allow any q35 guest to easily run basic API tests for the
DMA API. It's actually how I found the dma benchmark code, as its the only
selftest we have for DMA. However that benchmark test is not easy to
configure or enable. With kernel selftests you can test for things
outside of the scope of performance.  You can test for expected
correctness of the APIs and to ensure no regressions exist with extected
behavior, otherwise you learn about possible regressions reactively. We
have many selftests that do just that without a focus on performance for
many things, xarray, maple tree, sysctl, firmware loader, module
loading, etc. And yes, they find bugs proactively.

With this then, we should be able to easily add a CI to run these tests
based on linux-next or linus' tags, even if its virtual. Who would run
these? We can get this going daily on kdevops easily, if we want them, we
already have a series of tests automated for different subsystems.

Benchmarking can be done separatley with real hardware -- agreed.
But it does not negate the need for simple virtual kernel selftests.

  Luis

