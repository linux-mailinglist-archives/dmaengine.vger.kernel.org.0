Return-Path: <dmaengine+bounces-2394-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6290E90B6B0
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 18:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C961F24451
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB0E1E529;
	Mon, 17 Jun 2024 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuyLilHj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42E1D9515
	for <dmaengine@vger.kernel.org>; Mon, 17 Jun 2024 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642443; cv=none; b=j2Wjy4/IVZXQve50BRkHwfvRQEqcHEMVf23cwmV8u3p7ouqfBRAZeItlNtRjiHIhJ+Azxi9plM8/clijc9msAyLXVDu900eCLGT/DK+wwrdIXCXgo9QJKe7QwZbsMwrQqE6FW62CFnaqRL4naWzkuSdlTeZ3p1OeLPrSFxcjbeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642443; c=relaxed/simple;
	bh=XKtWqI4bwRnnHfgF9xVHN2zZDlTendZ45NwaTmQG1Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WTWWwdH8W1BaoHFkwVg/SnDRmhY3bLvkgN2IN+TfsUUJP0bMGTi/CWrXOPRt8QEPnrbEl4HiUDeAZwfJGdRln6A4T417eOMz1KxYFsZMDAojCPu2RNy7TcZH2qLmW7hTaqsKYxzyDFK0iV00k7xqIBoMrBJefIjZOcQFk7Pw6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuyLilHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35157C2BD10;
	Mon, 17 Jun 2024 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718642443;
	bh=XKtWqI4bwRnnHfgF9xVHN2zZDlTendZ45NwaTmQG1Yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fuyLilHjStanrQGHdcbeS5ZnTk5z4G4En6wQ7JhLMumY5iWPdmkhX2o2gKf5vxJCC
	 aHoT0pAmOnB2JbycLY1iOE1xUL2k6HbYTEqxcHccJP/MtHOoAtz9RIf/eD+gKid/eC
	 voq9KSvKuTn7xReHWX00Pkk3UQvYjQKFKprJCx57ydTEuqVh/cEvbPI18xJwdxUCxi
	 SBUe+Hl3mu2nZnkYLfYDGFkMmYw9nxhkgbwmjFj1xX9JVEWIIvwQJcB2wEJf3EQkhX
	 GfoQuhL5f6nmxr88wNMYUY4ro8TyRDa71x9sZEr1bmReuVyBDlE4OKDHjcrGYbLZpB
	 bONW8bdtOPz9g==
Date: Mon, 17 Jun 2024 11:40:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Raju.Rangoju@amd.com,
	Frank.li@nxp.com
Subject: Re: [PATCH v2 2/7] dmaengine: ae4dma: Add AMD ae4dma controller
 driver
Message-ID: <20240617164041.GA1217135@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617100359.2550541-3-Basavaraj.Natikar@amd.com>

On Mon, Jun 17, 2024 at 03:33:54PM +0530, Basavaraj Natikar wrote:
> Add support for AMD AE4DMA controller. It performs high-bandwidth
> memory to memory and IO copy operation. Device commands are managed
> via a circular queue of 'descriptors', each of which specifies source
> and destination addresses for copying a single buffer of data.

> +++ b/drivers/dma/amd/ae4dma/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config AMD_AE4DMA
> +	tristate  "AMD AE4DMA Engine"
> +	depends on X86_64 && PCI

Possible "(X86_64 || COMPILE_TEST)"?

> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c

> +static int ae4_get_irqs(struct ae4_device *ae4)
> +{
> +	struct pt_device *pt = &ae4->pt;
> +	struct device *dev = pt->dev;
> +	int ret;
> +
> +	ret = ae4_get_msix_irqs(ae4);
> +	if (!ret)
> +		return 0;
> +
> +	/* Couldn't get MSI-X vectors, try MSI */
> +	dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
> +	ret = ae4_get_msi_irq(ae4);
> +	if (!ret)
> +		return 0;

Consider pci_alloc_irq_vectors() and pci_free_irq_vectors() here.

> +	/* Couldn't get MSI interrupt */
> +	dev_err(dev, "could not enable MSI (%d)\n", ret);
> +
> +	return ret;
> +}

