Return-Path: <dmaengine+bounces-6423-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE98CB46447
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 22:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D4CBA07E7
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6272427A114;
	Fri,  5 Sep 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0Ut9NXy"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A228488D;
	Fri,  5 Sep 2025 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102722; cv=none; b=dmUXTDhmr0+i6b+rEOzhtz5trjmNNVthpbhXPbGSoD+i1EFQQYIHEII5VfrHIREvydpIXHiH7FToZB8Jyzy1Vi79XWYm+iyWyykEkKWsg57syOb6us0Oni2K2vlgc0zlHHSZTXZlGZtPHcDtK5pM4jdtbGtlDnZqu0Hus8eQaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102722; c=relaxed/simple;
	bh=8b33qV1eNdKD7O/JzULQ/wyc/in7gemdLdE+YJLAvyI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cpqytBdNtRnK3fORA+OqxiA5QljNCjoXdiznRlMwD3O79Q5JmZd9kCvXJhAbJ7IZ2NF1jAskdue/8r3BPiP2dJMBGLrvJ4YVxzo428wUD93dv9tvLyoQIcSyWvm+y8iNgKGwV750WqKuypI+B+BV0EZegAKoA87xFoNIeCB/Z1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0Ut9NXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F44DC4CEF1;
	Fri,  5 Sep 2025 20:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757102721;
	bh=8b33qV1eNdKD7O/JzULQ/wyc/in7gemdLdE+YJLAvyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=K0Ut9NXyv7v+4eRiezlf7+xXg0N9sMejDmwC82pD/E+NqL2iFuO6nWPjUQtdXkwHG
	 Eew6o5p/IO3B7r1i4ngpfLfKYPZotK6xQGd8K//gjoUVujbp1n55tvqjl2L+j1t03p
	 P49VcOfNoPRbYqcSxIEUp2gkHaSGS68vdiD9hFGx6jtUjQ/pZAUqGOJyaHRpr2WtYY
	 3a1UnAFe09RHmkOJjqpjTj4ppf2gW7qq2QgOdu3SyiePFRr4sdHuahLt4dPQ637kpE
	 +PN9zi6/1t1B/kQA05HLRtp078XmumQqdHUd1lpB2ujDi8GnLDvSf6PSneVGpSeChD
	 mhOC3l07r9RxQ==
Date: Fri, 5 Sep 2025 15:05:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: nathan.lynch@amd.com
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH RFC 10/13] dmaengine: sdxi: Add PCI driver support
Message-ID: <20250905200520.GA1321712@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-sdxi-base-v1-10-d0341a1292ba@amd.com>

On Fri, Sep 05, 2025 at 01:48:33PM -0500, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> Add support for binding to PCIe-hosted SDXI devices. SDXI requires
> MSI(-X) for PCI implementations, so this code will be gated by
> CONFIG_PCI_MSI in the Makefile.

> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
> +{
> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
> +	struct device *dev = &pdev->dev;
> +	int dma_bits = 64;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		sdxi_err(sdxi, "pcim_enbale_device failed\n");

s/pcim_enbale_device/pcim_enable_device/

> +		return ret;
> +	}
> +
> +	pci_set_master(pdev);
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_bits));

I don't see the point of "dma_bits" over using 64 here.

> +	if (ret) {
> +		sdxi_err(sdxi, "failed to set DMA mask & coherent bits\n");
> +		return ret;
> +	}
> +
> +	ret = sdxi_pci_map(sdxi);
> +	if (ret) {
> +		sdxi_err(sdxi, "failed to map device IO resources\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}

