Return-Path: <dmaengine+bounces-7339-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4794AC83E1A
	for <lists+dmaengine@lfdr.de>; Tue, 25 Nov 2025 09:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C22A34D552
	for <lists+dmaengine@lfdr.de>; Tue, 25 Nov 2025 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB462D63F6;
	Tue, 25 Nov 2025 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="eF+x5kn4"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D092D6E5A;
	Tue, 25 Nov 2025 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057768; cv=none; b=P1QKWPkNBzl1n/DFA9dCFJDJ4nHcQtzqh3K8Z+PGU1tWJ3Jm1TedMQA6z8aimCfS9maRA92eARWHv9IyzE/A6lsPOzG50qeBzBJ/7xw1GEdUpB1crjjIdNnw19CVfxGrmBVDkmpUJO0klOrNILQjNDc8S8HbMY0Ftw5EssuXZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057768; c=relaxed/simple;
	bh=CD1JVdqtXIGAroJaFbdwj3Epr2vxLT0HRN8O1zlEfQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqN578EGUOQdXdUPETz8h9MDdvrcer5Mjzi3U0jzSG2HDeVWSwch0fybzEydsS5oMt7OOBQJYuBMr5o2wFJ9gLZLXHDboTsH92DnX/egP/zRtVhK0+x+YOeE/X1GiAdl/I237f4KuV4s4MRwZLYRb6NQ8lpDqfGypgXfGTKtv4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=eF+x5kn4; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30E664438A;
	Tue, 25 Nov 2025 08:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1764057758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MoWndkx7e+UmCx3Hyadc2ePIsV1F+2M/5sK889nnkUE=;
	b=eF+x5kn4Bz19wPZCq0SGBedVZbd9n4F4xU/K90iEC+buRU+T91zXQH+GAWq8hU5nAAELWj
	v6MZm0y1QxnUg4rXhaXly0jXTujkXkA/8kRoTZgPYnDDjNDFAP7D8gp1DJXWIyjO8PkFrz
	koT3FHLxjoVSTljKli5l9Y6mDPriL/zA2skOnFhxHwClCANUM885LMJaq9+38wkVv0fP68
	eN6aMgu0MLs8f0RdGt/SMY2EmDRXYqNOauGIh6a8Sq2x+z+SPD9mF4iKcrV+TOdPLJnnXm
	whE38bX14TIRPi8iH5m2pNJ1Cpl4JTNC6EQRdP1qiNgB+kO9QrWDlASfeheUEA==
Date: Tue, 25 Nov 2025 09:02:36 +0100
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dma: mcf-edma: Fix interrupt handler for 64 DMA
 channels
Message-ID: <aSVinMNSTEQLZxRi@yoseli-yocto.yoseli.org>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
 <20251124-dma-coldfire-v1-4-dc8f93185464@yoseli.org>
 <aSSDItseEjQ0VMh6@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSSDItseEjQ0VMh6@lizhi-Precision-Tower-5810>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeflvggrnhdqofhitghhvghlucfjrghuthgsohhishcuoehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrgheqnecuggftrfgrthhtvghrnhepffehhfdvieeuvdejteduhffgfefffeduveetgeekhfekledukeegjefhtdffgfffnecukfhppedvrgdtudemvgdtrgemudeileemjedugedtmeekvgdtugemkegrugdumegvvggvleemleehsgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudeileemjedugedtmeekvgdtugemkegrugdumegvvggvleemleehsgdphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhnsggprhgtphhtthhopeejpdhrtghpthhtohephfhrrghnkhdrlhhisehngihprdgtohhmpdhrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehimhigsehli
 hhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Frank,

On Mon, Nov 24, 2025 at 11:09:06AM -0500, Frank Li wrote:
> On Mon, Nov 24, 2025 at 01:50:25PM +0100, Jean-Michel Hautbois wrote:
> > Fix the DMA completion interrupt handler to properly handle all 64
> > channels on MCF54418 ColdFire processors.
> >
> > The previous code used BIT(ch) to test interrupt status bits, which
> > causes undefined behavior on 32-bit architectures when ch >= 32 because
> > unsigned long is 32 bits and the shift would exceed the type width.
> >
> > Replace with bitmap_from_u64() and for_each_set_bit() which correctly
> > handle 64-bit values on 32-bit systems by using a proper bitmap
> > representation.
> >
> > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> > ---
> >  drivers/dma/mcf-edma-main.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> > index 8a7c1787adb1f66f3b6729903635b072218afad1..dd64f50f2b0a70a4664b03c7d6a23e74c9bcd7ae 100644
> > --- a/drivers/dma/mcf-edma-main.c
> > +++ b/drivers/dma/mcf-edma-main.c
> > @@ -18,7 +18,8 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
> >  {
> >  	struct fsl_edma_engine *mcf_edma = dev_id;
> >  	struct edma_regs *regs = &mcf_edma->regs;
> > -	unsigned int ch;
> > +	unsigned long ch;
> 
> channel number max value is 63. unsigned int should be enough.

Yes, indeed, it is enough. I changed to unsigned long because
for_each_set_bit() calls find_next_bit which returns unsigned long. This
only avoiding an implicit conversion. But I can remove this change if it
does not make sense ?

Thanks,
JM

> 
> Frank
> > +	DECLARE_BITMAP(status_mask, 64);
> >  	u64 intmap;
> >
> >  	intmap = ioread32(regs->inth);
> > @@ -27,11 +28,11 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
> >  	if (!intmap)
> >  		return IRQ_NONE;
> >
> > -	for (ch = 0; ch < mcf_edma->n_chans; ch++) {
> > -		if (intmap & BIT(ch)) {
> > -			iowrite8(EDMA_MASK_CH(ch), regs->cint);
> > -			fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
> > -		}
> > +	bitmap_from_u64(status_mask, intmap);
> > +
> > +	for_each_set_bit(ch, status_mask, mcf_edma->n_chans) {
> > +		iowrite8(EDMA_MASK_CH(ch), regs->cint);
> > +		fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
> >  	}
> >
> >  	return IRQ_HANDLED;
> >
> > --
> > 2.39.5
> >

