Return-Path: <dmaengine+bounces-5922-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57181B17212
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 15:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B223545719
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFBF239E7A;
	Thu, 31 Jul 2025 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKv2Uv53"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4CD223719;
	Thu, 31 Jul 2025 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968705; cv=none; b=ntz+isfRcQcSLb3qEwdKMY3ClEqtXuV6XM4ehzaKPJovFMachD8YYpz32bZLr2+XdQVG7BwmddQsidZ87CNmFO8D0K0qOO1mO+wG/Pw2beMbslgAbnvhJelA5AWrNe2Qz7w3b3bzYESIbu7erMumExs+VaHB+9PgJwXHhP0/W/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968705; c=relaxed/simple;
	bh=yB/Zam9PU8Vpw3OSJp2b99yh8gus5SsqhuwtZijYvKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qv03uuA/CWQT8NZEFsub+yNz5RSrTR+L6SkseXaSab4UUqguhoKR7NOWTbPpPvKuwsGAsEnBtNDukC/imZO3CYVIE9v2KtP/4b4VWLabgFzjX8JDlzo2dBjSZmeekZuFIOUhI4QcadbIdNff7V32bhdWGsmt9z0T8NqAjm0nl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKv2Uv53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4084EC4CEEF;
	Thu, 31 Jul 2025 13:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753968705;
	bh=yB/Zam9PU8Vpw3OSJp2b99yh8gus5SsqhuwtZijYvKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKv2Uv53OCqReDBRvl/sVyIczEfl8N2nNRTXiyToyT4+p1u2IPtECBzt2eq9NdLs8
	 ok0ytREWhuKKrv7W7IQCEVgz7qCxPp7SGlcXS17NKVv5M+y24Aj4G8uAO5O63baISB
	 vhHr/a5Sr4vxlmS5mTzQyT1a9+M80dFxD2cLV127ijRXHcWHUFQcOCGX/HTb/S9K1v
	 RikPrXXIuU/vNswRlTJ+q+1y9pE3LPEBqVXHgqcmWFySZC71zliRlC/+oVytiEyaiW
	 Sfu6FCCvJ9MMYWjHl57gZN6tj0Trr8pj2RV2/Yw7F03OS8xlRZ+1SjLCQdHEIIEzlc
	 curP48FPn8WfQ==
Date: Thu, 31 Jul 2025 19:01:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>
Subject: Re: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
Message-ID: <2xlz5noopmv72h7yczpubmqrrbjwkn6wd6ehnu3rcqnpkuzw7s@i45jgrbuctpm>
References: <20250623061733.1864392-1-devverma@amd.com>
 <d6rtkyelnfhqya6txe7wr6rup7y6riifwzw6tbajopqa5wty6j@3o32khdidnas>
 <SA1PR12MB812030AE4BC9A4D211A4C7669527A@SA1PR12MB8120.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR12MB812030AE4BC9A4D211A4C7669527A@SA1PR12MB8120.namprd12.prod.outlook.com>

On Thu, Jul 31, 2025 at 09:32:12AM GMT, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Manivannan
> 
> Please check my response inline.
> 
> Regards,
> Devendra
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > Sent: Wednesday, July 23, 2025 19:26
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; vkoul@kernel.org
> > Subject: Re: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Mon, Jun 23, 2025 at 11:47:33AM GMT, Devendra K Verma wrote:
> > > The HDMA IP supports the simple mode (non-linked list).
> > > In this mode the channel registers are configured to initiate a single
> > > DMA data transfer. The channel can be configured in simple mode via
> > > peripheral param of dma_slave_config param.
> > >
> > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-core.c    | 10 +++++
> > >  drivers/dma/dw-edma/dw-edma-core.h    |  2 +
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 53
> > ++++++++++++++++++++++++++-
> > >  include/linux/dma/edma.h              |  8 ++++
> > >  4 files changed, 72 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > index c2b88cc99e5d..4dafd6554277 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -235,9 +235,19 @@ static int dw_edma_device_config(struct dma_chan
> > *dchan,
> > >                                struct dma_slave_config *config)  {
> > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > +     struct dw_edma_peripheral_config *pconfig = config->peripheral_config;
> > > +     unsigned long flags;
> > > +
> > > +     if (WARN_ON(config->peripheral_config &&
> > > +                 config->peripheral_size != sizeof(*pconfig)))
> > > +             return -EINVAL;
> > >
> > > +     spin_lock_irqsave(&chan->vc.lock, flags);
> > >       memcpy(&chan->config, config, sizeof(*config));
> > > +
> > > +     chan->non_ll_en = pconfig ? pconfig->non_ll_en : false;
> >
> > Who is allocating 'dw_edma_peripheral_config' and setting 'non_ll_en' flag? We
> > cannot introduce a flag without anyone using it in upstream.
> >
> > - Mani
> >
> 
> The caller of the DMA engine client APIs will be responsible for allocating
> and setting the non_ll_en flag. This flag helps in setting the channel in to
> non-Linked-List mode. This functionality is supported by the DMA controller.
> The peripheral_config is just configuring the peripheral (DMA) in to the modes
> it supports based on user discretion. As this functionality is used by the
> clients to differentiate between the modes supported by the controller it
> may not require the equivalent code in upstream.
> 

As I stated above, we *must not* have an unused interface in upstream drivers. I
understand that fact that your downstream driver is setting this flag and you
want to keep your driver downstream. But the flag would be unused in upstream
and that is not acceptable, sorry.

- Mani


-- 
மணிவண்ணன் சதாசிவம்

