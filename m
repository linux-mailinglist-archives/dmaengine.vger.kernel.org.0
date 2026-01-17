Return-Path: <dmaengine+bounces-8320-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A94D38DFE
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 12:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B186B301842C
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66405310784;
	Sat, 17 Jan 2026 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I86gXbHe"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D74302767;
	Sat, 17 Jan 2026 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768647958; cv=none; b=gO21LHlKjriFOyOYcG5fDv9gvUJpaFVnKthJP2Xm9FAmaR8x85hYqDRNvgYnO/JFPKuLgZS1ZWM4MX6env1rrlM6x3/QVCqDkoZv7m/iz3Y+03VFyggMCnGkZbpmA6bEc52aYDzMCJgd/fJbHBo6XmQDVN7y6JbpNGZh7LwVVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768647958; c=relaxed/simple;
	bh=6d45T7HhrZc5jUsPEswloktiujk+9zSyGqQrcH8upas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjOUu8BxjVbD7MwCrv74SxD+bM+V23uuNZHtNDcXw5on1R0urm2+lCLRMAc/p9xsmmBfNz10fgZR3MbHgLiO6Pp6VP7okkMTI6q7ALBWI9mYb+2/WemHvYyg4x5vMrMzLLrRKujtqRQMLtAXgq51IFex/RL1FcLnvgofb8JfoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I86gXbHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A15C4CEF7;
	Sat, 17 Jan 2026 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768647957;
	bh=6d45T7HhrZc5jUsPEswloktiujk+9zSyGqQrcH8upas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I86gXbHeAPG5z+dNCmXJ4LzPzpH1PCM9BMOypcZ2cxCY/yMSDbRsNkPlf5LbxMsxm
	 y7L2XvpK1gqFYoOXMQaqCWoEggzXM6r98tqKl/C9yGzOItSVhO80a/C01Pzec+8grg
	 L/sa/1/sozRCc7xvT0+dX12N0V1lojo7vJ4wp95WbsxJTIgmr/2IGQTFOBmTDxEsUA
	 dW+u/3Jga8l8y8JLdh41y+M+YNFkwtEo/qwxRPUcsDYo7U9l4H4IrDImfHPxpl04bC
	 /PpApDyKyiJI8iYLzTbgdwC037qC/cJNyNRl7j+4iocl7R2M3UNfcYYWFa9ciYQPGg
	 9D+mCvRF6/HUw==
Date: Sat, 17 Jan 2026 16:35:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Koichiro Den <den@valinux.co.jp>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, mhi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/9] dmaengine: Add new API to combine configuration
 and descriptor preparation
Message-ID: <6f4elcu5iql65jeqfeqhmllquv253xh4gb37ivef2kyvsj5lps@w35ciehuwxym>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <aWTwrOOXX3AR8Ght@ryzen>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWTwrOOXX3AR8Ght@ryzen>

On Mon, Jan 12, 2026 at 02:01:32PM +0100, Niklas Cassel wrote:
> Frank,
> 
> Thanks a lot for your work on this series!
> 
> On Mon, Jan 05, 2026 at 05:46:50PM -0500, Frank Li wrote:
> >  Documentation/driver-api/dmaengine/client.rst |   9 ++
> >  drivers/crypto/atmel-aes.c                    |  10 +--
> >  drivers/dma/dmaengine.c                       |   3 +
> >  drivers/dma/dw-edma/dw-edma-core.c            |  41 ++++++---
> >  drivers/nvme/target/pci-epf.c                 |  21 ++---
> >  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 ++++--------
> >  drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
> >  include/linux/dmaengine.h                     | 117 ++++++++++++++++++++++++--
> >  8 files changed, 177 insertions(+), 84 deletions(-)
> 
> Is the plan to merge this series via the dmaengine tree?
> 

It makes sense to take it through dmaengine tree given that the changes in PCI
and other drivers are straightforward.

> If so, we might need an Ack from Mani on the pci-epf-mhi.c and
> pci-epf-test.c patch.
> 

Just did.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

