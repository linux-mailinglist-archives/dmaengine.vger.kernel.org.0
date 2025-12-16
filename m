Return-Path: <dmaengine+bounces-7680-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B62CC4074
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0262130469BC
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9EF35C1B9;
	Tue, 16 Dec 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avTeetSC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF333A9C8;
	Tue, 16 Dec 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899791; cv=none; b=jFx16sM4G3oV8wRQZtDM28olO2KI6AK04bA9QEJKTURZfihoZdkrhTJNvR9tr0bw1x/ARTiqSwzJxvQRORn4QYoNQJcjRAkj7UX7YUh5DSU5iN4obR54eH0OwhGIXAO25O6v4DM3MWNdxYkzs4zW+SYOGRDChzq3+wmmKXheVUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899791; c=relaxed/simple;
	bh=ZJTJypfLe1H/1AUEwksCTkMoXxELG4u7pdR81YdX+EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2OAq1Q1Sik+S0NaYMQJROBwVSeIjutu+8mAB1ulQ6S7GW1EBGXwsGSVS7qvqs1Nqq7kl+LO3FixlFKAC481+yOLtKyHYbs07QbEem9K4GRpWBhSxee4SRtorDbg4ezYoYeDbOfNHoVvaIjsLjEaikkuE6eBJQt1q7/qj0K/aJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avTeetSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8A9C4CEF1;
	Tue, 16 Dec 2025 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765899791;
	bh=ZJTJypfLe1H/1AUEwksCTkMoXxELG4u7pdR81YdX+EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=avTeetSCg2f1iVCLtIL2eMD8lxo6IXEVPcYP29oezKOpSlnYbzQvySLzpryda+R1A
	 ew6Qmjryuhzff4o2BNqhJbYikZ/FxB9nsZ+SVx/fEVe4+Vk8KAAXNTxXKgB1dOxfC6
	 74+SKOUxUYH7bvsWWQn3Q5qwYcHK43xEPD2CbWjHDldkEanlq21fmXVgnU0XBWMqbv
	 BNwMTA5V4T1ZdwdXE45rLHOcG/cKJ0JLceGyQuUmh04zLBAqknv3qYM1zyCFIEZrg6
	 xNyoNgN2Bk8xHpe+jauDCs8GKdRJcRNBlYtSaJq0IBEmiVa1MMIQaZqoQDY1frH7eC
	 nyyoTKRn0yS8A==
Date: Tue, 16 Dec 2025 21:13:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 0/8] dmaengine: Add new API to combine onfiguration and
 descriptor preparation
Message-ID: <aUF-C8iUCs-dYXGm@vaman>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <aUFUX0e_h7RGAecz@vaman>
 <aUF2SX/6bV2lHtF0@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUF2SX/6bV2lHtF0@lizhi-Precision-Tower-5810>

On 16-12-25, 10:10, Frank Li wrote:
> On Tue, Dec 16, 2025 at 06:15:19PM +0530, Vinod Koul wrote:
> > On 08-12-25, 12:09, Frank Li wrote:
> >
> > Spell check on subject please :-)
> >
> > > Previously, configuration and preparation required two separate calls. This
> > > works well when configuration is done only once during initialization.
> > >
> > > However, in cases where the burst length or source/destination address must
> > > be adjusted for each transfer, calling two functions is verbose.
> > >
> > > 	if (dmaengine_slave_config(chan, &sconf)) {
> > > 		dev_err(dev, "DMA slave config fail\n");
> > > 		return -EIO;
> > > 	}
> > >
> > > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> > >
> > > After new API added
> > >
> > > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags, &sconf);
> >
> > Nak, we cant change the API like this.
> 
> Sorry, it is typo here. in patch
> 	dmaengine_prep_slave_single_config(chan, dma_local, len, dir, flags, &sconf);
> 
> > I agree that you can add a new way to call dmaengine_slave_config() and
> > dmaengine_prep_slave_single() together.
> > maybe dmaengine_prep_config_perip_single() (yes we can go away with slave, but
> > cant drop it, as absence means something else entire).
> 
> how about dmaengine_prep_peripheral_single() and dmaengine_prep_peripheral_sg()
> to align recent added "dmaengine_prep_peripheral_dma_vec()"

It doesnt imply config has been done, how does it differ from usual
prep_ calls. I see confusions can be caused!

> I think "peripheral" also is reduntant. dmaengine_prep_single() and
> dmaengine_prep_sg() should be enough because

Then you are missing the basic premises of dmaengine that we have memcpy
ops and peripheral dma ops (aka slave) Absence of peripheral always
implies that it is memcpy

> - dmaengine_prep_dma_cyclic() is actually work with prepiperial FIFO
> - some prepierial FIFO work like memory, by use shared memory method, like
> PCIe map windows.
> - argument: config and dir already passdown information to indicate if it
> is device preiperial. So needn't indicate at function name.
> - maybe later extend to support mem to mem by config becuase adjust burst
> size for difference alignment or difference bus fabric port to optimaze
> performance.
> 
> Frank
> 
> >
> > I would like to retain the dmaengine_prep_slave_single() as an API for
> > users to call and invoke. There are users who configure channel once as
> > well
> >
> > >
> > > Additional, prevous two calls requires additional locking to ensure both
> > > steps complete atomically.
> > >
> > >     mutex_lock()
> > >     dmaengine_slave_config()
> > >     dmaengine_prep_slave_single()
> > >     mutex_unlock()
> > >
> > > after new API added, mutex lock can be moved. See patch
> > >      nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Frank Li (8):
> > >       dmaengine: Add API to combine configuration and preparation (sg and single)
> > >       PCI: endpoint: pci-epf-test: use new DMA API to simple code
> > >       dmaengine: dw-edma: Use new .device_prep_slave_sg_config() callback
> > >       dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
> > >       nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
> > >       nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
> > >       PCI: epf-mhi:Using new API dmaengine_prep_slave_single_config() to simple code.
> > >       crypto: atmel: Use dmaengine_prep_slave_single_config() API
> > >
> > >  drivers/crypto/atmel-aes.c                    | 10 ++---
> > >  drivers/dma/dw-edma/dw-edma-core.c            | 38 +++++++++++-----
> > >  drivers/nvme/target/pci-epf.c                 | 21 +++------
> > >  drivers/pci/endpoint/functions/pci-epf-mhi.c  | 52 +++++++---------------
> > >  drivers/pci/endpoint/functions/pci-epf-test.c |  8 +---
> > >  include/linux/dmaengine.h                     | 64 ++++++++++++++++++++++++---
> > >  6 files changed, 111 insertions(+), 82 deletions(-)
> > > ---
> > > base-commit: bc04acf4aeca588496124a6cf54bfce3db327039
> > > change-id: 20251204-dma_prep_config-654170d245a2
> > >
> > > Best regards,
> > > --
> > > Frank Li <Frank.Li@nxp.com>
> >
> > --
> > ~Vinod

-- 
~Vinod

