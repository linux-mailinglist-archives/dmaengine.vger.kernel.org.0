Return-Path: <dmaengine+bounces-7710-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6053CC4A1F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F9D305D99D
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B37430F538;
	Tue, 16 Dec 2025 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9Z0adoY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165113A1E8E;
	Tue, 16 Dec 2025 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905482; cv=none; b=dRqxTIfM7sVVPn1N4zJFpXmeZbvLzYeI2KxRqe6UyPOd9cNb+tQ+KXAJx1rpw06hxRpTZUiv0kOdxX6zkm6RC223hb/VxE1ML59bqrrO28UAH/nLyjlMsjWP0E+SP3RV+CAL3g+tx2JpU1aQGvKLr/Zp1dzkjLnQ5CpwYIkbLkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905482; c=relaxed/simple;
	bh=cppGG9PT+JpiVSfKeuzy9K48JaGezXDa3T4Yw7/QjLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUwLg5Woq+qGxztFBNIJR0pYysNiCVthb1oGSGlT2gaG8qooQgm5WEF0SkDn5ovnph7DCjvZjAAmyzU9xQ2JPyosYRGhameol7v1YcKBx4gYw/MvLPgnOvfiOw50J66hNtGBUKs56F0MbnRfHjGfD6tvAxzHZ1wkcLi+YJayw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9Z0adoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3909C113D0;
	Tue, 16 Dec 2025 17:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765905481;
	bh=cppGG9PT+JpiVSfKeuzy9K48JaGezXDa3T4Yw7/QjLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9Z0adoYBmlbmaIqmD79zYatnS+Nt9uvNPpMDj8zX/H9mOuYbV48DmY7Rh8YVw9qd
	 kPaz6lUutNxyvoq7ZvVMPOvsgYTAzuBlktLuvQ5j5I6V5g7piqDfxgXGt8ewBWaV99
	 KVhZfzc6hJz1AFyIDWQlGEPMQlWZ23GklILkeYlwlpyezVASDJn8Y3tC+h9+7ViXMV
	 F6TWaAZvDP6hyZlZdErrsnkbI/f8almng8GM1fBYyZOmchVnX0pKgBMiqUi4HiCeSf
	 uiFFuy6zg2Y5TNiUPlnOgcsviidlVs2UFXR0qo2C805X9YA13sjqyc7PDY5fLzXDrQ
	 dyBmhKeBtDjFQ==
Date: Tue, 16 Dec 2025 22:47:57 +0530
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
Message-ID: <aUGURVuW33WSTuyI@vaman>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <aUFUX0e_h7RGAecz@vaman>
 <aUF2SX/6bV2lHtF0@lizhi-Precision-Tower-5810>
 <aUF-C8iUCs-dYXGm@vaman>
 <aUGA7tmDYm1MhRXn@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUGA7tmDYm1MhRXn@lizhi-Precision-Tower-5810>

On 16-12-25, 10:55, Frank Li wrote:
> On Tue, Dec 16, 2025 at 09:13:07PM +0530, Vinod Koul wrote:
> > On 16-12-25, 10:10, Frank Li wrote:
> > > On Tue, Dec 16, 2025 at 06:15:19PM +0530, Vinod Koul wrote:
> > > > On 08-12-25, 12:09, Frank Li wrote:
> > > >
> > > > Spell check on subject please :-)
> > > >
> > > > > Previously, configuration and preparation required two separate calls. This
> > > > > works well when configuration is done only once during initialization.
> > > > >
> > > > > However, in cases where the burst length or source/destination address must
> > > > > be adjusted for each transfer, calling two functions is verbose.
> > > > >
> > > > > 	if (dmaengine_slave_config(chan, &sconf)) {
> > > > > 		dev_err(dev, "DMA slave config fail\n");
> > > > > 		return -EIO;
> > > > > 	}
> > > > >
> > > > > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> > > > >
> > > > > After new API added
> > > > >
> > > > > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags, &sconf);
> > > >
> > > > Nak, we cant change the API like this.
> > >
> > > Sorry, it is typo here. in patch
> > > 	dmaengine_prep_slave_single_config(chan, dma_local, len, dir, flags, &sconf);
> > >
> > > > I agree that you can add a new way to call dmaengine_slave_config() and
> > > > dmaengine_prep_slave_single() together.
> > > > maybe dmaengine_prep_config_perip_single() (yes we can go away with slave, but
> > > > cant drop it, as absence means something else entire).
> > >
> > > how about dmaengine_prep_peripheral_single() and dmaengine_prep_peripheral_sg()
> > > to align recent added "dmaengine_prep_peripheral_dma_vec()"
> >
> > It doesnt imply config has been done, how does it differ from usual
> > prep_ calls. I see confusions can be caused!
> 
> dmaengine_prep_peripheral_single(.., &sconf) and
> dmaengine_prep_peripheral_sg(..., &sconf).
> 
> The above two funcitions have pass down &sconf.
> 
> The usual prep_ call have not sconf argument, which need depend on previous
> config.
> 
> further, If passdown NULL for config, it means use previuos config.

I know it is bit longer but somehow I would feel better for the API to
imply config as well please

> 
> >
> > > I think "peripheral" also is reduntant. dmaengine_prep_single() and
> > > dmaengine_prep_sg() should be enough because
> >
> > Then you are missing the basic premises of dmaengine that we have memcpy
> > ops and peripheral dma ops (aka slave) Absence of peripheral always
> > implies that it is memcpy
> 
> Okay, it is not big deal. is dmaengine_prep_dma_cyclic() exception? which
> have not "peripheral" or "slave", but it is not for memcpy.

Cyclic by definition implies a cyclic dma over a peripheral

-- 
~Vinod

