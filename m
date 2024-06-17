Return-Path: <dmaengine+bounces-2395-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A36590B706
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 18:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E213728109F
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A87D161904;
	Mon, 17 Jun 2024 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riPcL82k"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA21E15A493
	for <dmaengine@vger.kernel.org>; Mon, 17 Jun 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643051; cv=none; b=noOXEuAQJHse/L3XAHnXcH5GeHTYbegdiDIk9LlS6BHf08XziNfphUmmq7XVGifLnBFIFKVXloC9J9BGSlTnNC5t70q5UP23fQqxYlylKxK5wZ60YLZFI07LdQA6+xZskFsVZWxW5DBL8lIIdiICB44vo/mZ2GxXrd4YQ3BpwlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643051; c=relaxed/simple;
	bh=TzMgCEkJsMJ3JH8uOrFDuoQvKCSH4RS+sLXrgOinoEU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SkfEmMq60Ma2MuN7IGoUmOgLkliG7vMXohPjEDBNdc9iPd4Xg4x3ubXn/UP64O+GpLLxVk/Q1ut5sYXBIpGP0pSTQTNi2wWenGGzlIg85oyzKGT/NJWx0I34VwoZi90OdW2UVI0b08gljFS9T83Hb56iT5/8UGD/02XYGoeczgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riPcL82k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399DBC2BD10;
	Mon, 17 Jun 2024 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718643051;
	bh=TzMgCEkJsMJ3JH8uOrFDuoQvKCSH4RS+sLXrgOinoEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=riPcL82k39UyYnuNe7rmP93+u536OSV4KAqT3f9twAlgIReqt8ikx211M1dHmKv7F
	 Xyoff1H2oHD4zzuCAzTFyZ7pnhRnadvXAyDvK1t131plSy4hOuPQ8k8OQU5jzB6LmL
	 tqjwNcqzevEh3ZIxZUGdt/hz8/Juqrynal19VU/KgiBfc+rrZmf3oK/FCHVfJ7Iduc
	 +YhkuWMEc2yCkmaoy/HWrYhlW0wQsVebmLIVwFozC0j9XD1iXEwo2RCGhAS/mXJF7c
	 vLWo8gpuktngIZ4KQpev2x4xAoOxz1GZC5GA2NLpEitYLauKHEcD4EyMHkUDhXw0o3
	 WMNHzvMyeE6uA==
Date: Mon, 17 Jun 2024 11:50:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Raju.Rangoju@amd.com,
	Frank.li@nxp.com
Subject: Re: [PATCH v2 2/7] dmaengine: ae4dma: Add AMD ae4dma controller
 driver
Message-ID: <20240617165049.GA1217718@bhelgaas>
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

> +static void ae4_free_irqs(struct ae4_device *ae4)
> +{
> +	struct ae4_msix *ae4_msix;
> +	struct pci_dev *pdev;
> +	struct pt_device *pt;
> +	struct device *dev;
> +	int i;
> +
> +	if (ae4) {

I don't think this test is necessary.  I don't think it's possible to
get here with ae4==0.

> +		pt = &ae4->pt;
> +		dev = pt->dev;
> +		pdev = to_pci_dev(dev);
> +
> +		ae4_msix = ae4->ae4_msix;
> +		if (ae4_msix && ae4_msix->msix_count)
> +			pci_disable_msix(pdev);
> +		else if (pdev->irq)
> +			pci_disable_msi(pdev);
> +
> +		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
> +			ae4->ae4_irq[i] = 0;

Clearing ae4_irq[] also doesn't seem necessary, since this is only
used in .remove(), and ae4 should never be used again.  If this path
becomes used in some future path that depends on ae4_irq[] being
cleared, perhaps the clearing could be moved to that patch.

> +	}
> +}
> +
> +static void ae4_deinit(struct ae4_device *ae4)
> +{
> +	ae4_free_irqs(ae4);
> +}

> +static void ae4_pci_remove(struct pci_dev *pdev)
> +{
> +	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
> +
> +	ae4_destroy_work(ae4);
> +	ae4_deinit(ae4);
> +}

