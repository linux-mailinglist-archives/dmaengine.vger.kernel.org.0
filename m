Return-Path: <dmaengine+bounces-8239-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C480FD1B5D1
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 22:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 478473015145
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 21:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB19E31A7FB;
	Tue, 13 Jan 2026 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="WOMBSAvi"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748512EDD45
	for <dmaengine@vger.kernel.org>; Tue, 13 Jan 2026 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338677; cv=none; b=V7VClCSf287Xb+Qba+H4Y4DRtsf7w22wTDjit596awZsL0xNDxRpxZ5dndPefIe8tJGsjNDchbG0+lyYspWCAcJxu65mc2FtNssPqwXu84qvxPTSTdlun90dobg3mZyitSPmHPrGookFjkXaAPZEMIvMq7BDD+PrpMvYBwc9ESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338677; c=relaxed/simple;
	bh=ssiXJ/3nLCBanlaa1K6bMObnAkXNzpLL2Zz9UcFayjA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=uPYfley8fuIR7IDxVvUNnj7GqjUX4NL4Fqp3TVC9c5Ch6Vujndj69K3o7ks+Zj37KqJ4WAdfre0kub4GUHW5TkL1gzHlEkbEeAJUM4xdzvbcuhGwAGnrdJQE3WdSSv+RoerEihh7LtNPefEaC4psV5o88NUU52T2zdwDlucxc0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=WOMBSAvi; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=lr6PBPqtBoI8DVSBTiIttC7HnrurE8FeoYjcc0qUiaI=; b=WOMBSAviZ9QRRM45aKNo72IF3k
	OO+QPz2YLgHuNIe68zBkTRxpw2Y0Ck7QnlTqkAh0N4EFs6nZBWVqhrkJhtoA/NN0lAHOQyL7aSQI/
	SLv3soHaXsoHbfprfhpfO3arC2zzdPqNKqVP1d36cuM8iUbNPtJgVVPNFDwusMM/nB/IwBerIoNeh
	p4ZAqn+kehcHb9Ph2DDhakYvuoxYBVXLdQpmzVzlTyREeXeODmItJiTgwKjafiRKu7gztNdIecoKl
	kXSjw/XDWsqL3tiIzaUSp1OcwgaREJ/EKDGyhLGB89mLue/5wLFt+6b0FX+6YpqUVJ0gP6I4p5Ze0
	I1WELiGQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vflfP-00000000kpJ-2Qio;
	Tue, 13 Jan 2026 14:11:08 -0700
Message-ID: <ee0d730c-f487-4888-8bcb-deac72f4006f@deltatee.com>
Date: Tue, 13 Jan 2026 14:10:42 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Frank Li <Frank.li@nxp.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Kelvin Cao <kelvin.cao@microchip.com>, George Ge <George.Ge@microchip.com>,
 Christoph Hellwig <hch@infradead.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Christoph Hellwig <hch@lst.de>
References: <20260112184017.2601-1-logang@deltatee.com>
 <20260112184017.2601-2-logang@deltatee.com>
 <aWVXURk95OuKHbEb@lizhi-Precision-Tower-5810>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aWVXURk95OuKHbEb@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: Frank.li@nxp.com, dmaengine@vger.kernel.org, vkoul@kernel.org, kelvin.cao@microchip.com, George.Ge@microchip.com, hch@infradead.org, christophe.jaillet@wanadoo.fr, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v12 1/3] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine skeleton
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi Frank,

Thanks for the review!

On 2026-01-12 13:19, Frank Li wrote:
>> +	swdma_dev = kzalloc(sizeof(*swdma_dev), GFP_KERNEL);
>> +	if (!swdma_dev)
>> +		return -ENOMEM;
>
> why not use devm_kzalloc() and devm_ioremap() to avoid below goto?

For the kzalloc() call that wouldn't be correct:

swdma_dev is a reference counted structure and needs to be freed when
the last reference to the dma device is dropped, not when the PCI device
is unbound. devm_kzalloc() would free the structure immediately after
dma_async_device_unregister() is called, but that function only drops a
reference and if there is another reference to the dma_device, then
there will be a use after free bug.

Note how dma_async_device_unregister() calls a kref_put() which only
calls dma_device_release() if the reference count is zero.

For the ioremap() call:

This patch series originally used pcim_iomap_table() but it was switched
to using ioremap() in v3 as suggested by Christoph Hellwig[1]. Given
that the pcim version does not provide a huge cleanup in this case, I'm
inclined to leave it the way it currently is.

>> +	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>> +	if (rc)
>> +		goto err_disable;
> 
> dma_set_mask_and_coherent() never return failure when MASK >= 32.
> 
> See: Documentation/core-api/dma-api-howto.rst
Good tip! I've queued up the change for v13.

Logan

[1] https://lore.kernel.org/all/ZDQ8geSEauTsd2ME@infradead.org/

