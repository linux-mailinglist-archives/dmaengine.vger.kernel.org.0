Return-Path: <dmaengine+bounces-7741-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D9FCC6010
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 06:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C25A7302357A
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 05:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99D1224AED;
	Wed, 17 Dec 2025 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcJmWWfK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1D1BEF8A;
	Wed, 17 Dec 2025 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765948232; cv=none; b=iaKrufj689Jt3FdEUBGs/k0W8c7jPsnF5eVdJ0vgfePm4lZdP4kYopG/TdzD9pc5wDH46Uc8cUruWmprC5/k3a0I1Mlujkkr0HcMzHv6A1X0SRPpJJG663K0pg8KayYBhzf6sAB4hoobG5zthuP5KUCRHx0ZU07jyM7XesGASdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765948232; c=relaxed/simple;
	bh=bLaK2gFWACWyalrEyaiMmZm2YYU4Bq1urmASnlDm6Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMvYE7ZyFPFtIz+qYF9MKWRqBHxRIhj8qjKrs8kjCdxiiIH7lM865R8op07J1Q/lAFTdd8jIjrJfzkJZJfzPTHogaPY+qpNcp3W0ASKOYQRcChs4tUdf/3MeTAZ9T7xuyaSkcUSXIu4WK3Ntmj1bhSe99MVmY84HiH1c+Ujo/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcJmWWfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1DCC19421;
	Wed, 17 Dec 2025 05:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765948231;
	bh=bLaK2gFWACWyalrEyaiMmZm2YYU4Bq1urmASnlDm6Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcJmWWfK33MwnybWoQwekHilGr5zCy1560YIq82bx13SaA1+NQhhGq6QhzHPOtbEe
	 g76xucoHWrhcqeg8jb5VE05l6kNRJqy8dzrHM71a0cQhnkMbxx8WNSdtD/xq6p5DJh
	 bLHZ6CrHbnrrdiA/lniK+9rvYDMqboXAwilsS0aU54t6HtaaMkb9cupJ0QxHomVxV2
	 yEKUZaMdsykL/s2wdfPiua3AQCBlcTtdYyxETlm+DBvrPfzz8JejKbsd8W5e+SNrmX
	 GIQpG0as5/ipXXQUCNwIQXZKMAJ3whyWGdWsrBeHqTqlltwGj8NOqaddzfTt/pb5xg
	 F3WTKkjID57OQ==
Date: Wed, 17 Dec 2025 10:40:28 +0530
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
Message-ID: <aUI7RJvQUx3m2IRf@vaman>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <aUFUX0e_h7RGAecz@vaman>
 <aUF2SX/6bV2lHtF0@lizhi-Precision-Tower-5810>
 <aUF-C8iUCs-dYXGm@vaman>
 <aUGA7tmDYm1MhRXn@lizhi-Precision-Tower-5810>
 <aUGURVuW33WSTuyI@vaman>
 <aUGWtarjFNNy2KyZ@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUGWtarjFNNy2KyZ@lizhi-Precision-Tower-5810>

On 16-12-25, 12:28, Frank Li wrote:
> On Tue, Dec 16, 2025 at 10:47:57PM +0530, Vinod Koul wrote:
> > On 16-12-25, 10:55, Frank Li wrote:
> > > The usual prep_ call have not sconf argument, which need depend on previous
> > > config.
> > >
> > > further, If passdown NULL for config, it means use previuos config.
> >
> > I know it is bit longer but somehow I would feel better for the API to
> > imply config as well please
> 
> I can use you suggested dmaengine_prep_config_perip_single().
> 
> But how about use dmaengine_prep_config_single(), which little bit shorter
> and use "config" to imply it is for periperal? (similar to cyclic case?)

Yes that is a good idea. config does imply peripheral cases. Please make
sure API documentation marks that clearly

BR
-- 
~Vinod

