Return-Path: <dmaengine+bounces-8321-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B743D38E3E
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 12:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B80C43009D65
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 11:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215C3054EE;
	Sat, 17 Jan 2026 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgL1Brga"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F035C2580E1;
	Sat, 17 Jan 2026 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768649651; cv=none; b=rhoMd4EJF+8XNmROxuuw/CR1bwCT0Z/36I323o8KAERg63KzJKTXIJ9fjdYS2hcD/fWmbpxbOzVjUNVzzkeWFWNd4NWBO5f8pHeOGhMi9eW0ZDwl38a/bQl4uDx7YOHzNd7slivVtMzxyAtGK9R6q8pZEsAxBEp4+N3oghWwY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768649651; c=relaxed/simple;
	bh=fv7CZKE3aaSA68XB9hs5SRb1yJ22PTBB5qdBpAufLtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3y55zDem3q2/TsdSJF11/TSRbc1LeoWM0p5gCCp/C2z78zZr9jisTPzQgMfCUNh25Rf0R/J0Qd5ZnxkXq/IWB3SkCDdFr61JuFqEwiJc96m4FAhxakKQNXL6avTjvK3Wji6E32hPqDhJ+3bdzmZYqZZUY3z7pDqdFbcrrMLAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgL1Brga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28765C4CEF7;
	Sat, 17 Jan 2026 11:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768649650;
	bh=fv7CZKE3aaSA68XB9hs5SRb1yJ22PTBB5qdBpAufLtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgL1BrgaT52iSum4tdHARsgvsLwD7xKFLvJG31MzNCvKC7ueYCW/5nHSK6dJ3u+QQ
	 o+yw64hK19tYtRwAIbTlrm9pB44tz2S1lCIgzvFb72fQKGydZYBwtggW428jL4u3sn
	 icci5MmA7ytNwQ6XoNAbfAQ2rSzhy71hQdvHuUk3ZWjJfLEy8DIiEycKWzIIfDBS4S
	 6UWaHkbDzoBflMWYP35UuBFFvw1tVCYZ1lMYt0O/ZCQGx6qiYOIykInc5Ju3w1o//w
	 jf9nvSwFKeZOxdZLguezq2PA3bcWlGqKkCe7TpjK+Un+Rk/aHIba+axo+cWkQ+SSEP
	 qaDQ6vyg69k7g==
Date: Sat, 17 Jan 2026 12:34:00 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Keith Busch <kbusch@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	imx@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/9] dmaengine: Add new API to combine configuration
 and descriptor preparation
Message-ID: <aWtzqJKsCHPJqDDH@ryzen>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <aWTwrOOXX3AR8Ght@ryzen>
 <6f4elcu5iql65jeqfeqhmllquv253xh4gb37ivef2kyvsj5lps@w35ciehuwxym>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4elcu5iql65jeqfeqhmllquv253xh4gb37ivef2kyvsj5lps@w35ciehuwxym>

On Sat, Jan 17, 2026 at 04:35:40PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 12, 2026 at 02:01:32PM +0100, Niklas Cassel wrote:
> > Frank,
> > 
> > Thanks a lot for your work on this series!
> > 
> > On Mon, Jan 05, 2026 at 05:46:50PM -0500, Frank Li wrote:
> > >  Documentation/driver-api/dmaengine/client.rst |   9 ++
> > >  drivers/crypto/atmel-aes.c                    |  10 +--
> > >  drivers/dma/dmaengine.c                       |   3 +
> > >  drivers/dma/dw-edma/dw-edma-core.c            |  41 ++++++---
> > >  drivers/nvme/target/pci-epf.c                 |  21 ++---
> > >  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 ++++--------
> > >  drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
> > >  include/linux/dmaengine.h                     | 117 ++++++++++++++++++++++++--
> > >  8 files changed, 177 insertions(+), 84 deletions(-)
> > 
> > Is the plan to merge this series via the dmaengine tree?
> > 
> 
> It makes sense to take it through dmaengine tree given that the changes in PCI
> and other drivers are straightforward.
> 
> > If so, we might need an Ack from Mani on the pci-epf-mhi.c and
> > pci-epf-test.c patch.
> > 
> 
> Just did.

Great!

Keith, Christoph, any chance to get an ack on the NVMe patches?


Herbert Xu, David Miller (crypto API maintainers),
any chance to get an ack on the crypto driver ?
There does not seem to be an explicit entry in MAINTAINERS for the atmel
crypto driver, and another atmel crypto driver is marked as orphan.


Kind regards,
Niklas

