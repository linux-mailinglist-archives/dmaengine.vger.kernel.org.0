Return-Path: <dmaengine+bounces-7343-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41376C86CE4
	for <lists+dmaengine@lfdr.de>; Tue, 25 Nov 2025 20:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EA3B4EB9C2
	for <lists+dmaengine@lfdr.de>; Tue, 25 Nov 2025 19:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7C33507C;
	Tue, 25 Nov 2025 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="GUezjqQ+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0C333720;
	Tue, 25 Nov 2025 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098680; cv=none; b=LInj4Iz/TVzhllpu9UWOSkkGebBowv216tmQCAW0+D5bQYct6i1aMRDT6xuELxtqQ2dhwBW9oR8TaD4BGmOx4BNI+LtxA++Cd/WzKIQKCTa3dhlQ0xKRRUqmKPrdm26hZuG9Lo66k/nPlWJaFvd294sbG6B/ac9lYDH2JU0XjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098680; c=relaxed/simple;
	bh=skILgqLwPJIPZBjRnJ1qT8M+/RtwxZ0zzX+N5F2lnCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaAMdz5GGJbHfmwner31ToNCAYCi1dLzGdU1pcOKy0eDluZNE/HA5sVTGtQMLtdE+4RhOZkcBLEcvpedTKb+AZP956lntyQTzF30vrEo4FbykAuTdkTOC9UMrfVxVDR+wvmEqwGD0NykZriupvGmufjxe626x7GpVwnFcGqG6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=GUezjqQ+; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id C370B58AAB3;
	Tue, 25 Nov 2025 08:18:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E48144248;
	Tue, 25 Nov 2025 08:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1764058711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zw2+CWzU7xDkCoIMauSVlX0cXTI9az6uTp3PwEpASrw=;
	b=GUezjqQ+p1uaYDNCAsk3Yic3CVVyBEwC52um1V28a4MXMxwKJLQrUDiF2Y1TRXld31tbwW
	CEvt7x5GBhndIji+MKGjBAHppy3ynPJ3iCjrFZRINqoAssSMkRf1HwXn6j85fwKe42GoSU
	Y3lbyoiqIknZIThYYoCvK53k6RWKV6JcQbaWNok4M6myHYxSfrLKKt6rjsypWE9pqMxe7S
	j69l09Vh/jS3Evkj5kc+uAZNVfV4+z7mZf+bcw7byI5REFfk5QhhXyMEBtTW0X1mFm1tLQ
	KRc95fpd3aeJ96m5Zde6bvkkDZseW93imEfKUCfCGZyVrpZTbKot4N4WUL7t3g==
Date: Tue, 25 Nov 2025 09:18:30 +0100
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dma: fsl-edma: Add write barrier after TCD
 descriptor fill
Message-ID: <aSVmVqRDhp3TRhKz@yoseli-yocto.yoseli.org>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
 <20251124-dma-coldfire-v1-1-dc8f93185464@yoseli.org>
 <aSSAfW9xLTRN5Fwk@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSSAfW9xLTRN5Fwk@lizhi-Precision-Tower-5810>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflvggrnhdqofhitghhvghlucfjrghuthgsohhishcuoehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrgheqnecuggftrfgrthhtvghrnhephefggefgtdduheelkeeuleejjeeijeeihfetieevueeftdeigeeuueefudevjeefnecukfhppedvrgdtudemvgdtrgemudeileemjedugedtmeekvgdtugemkegrugdumegvvggvleemleehsgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudeileemjedugedtmeekvgdtugemkegrugdumegvvggvleemleehsgdphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhnsggprhgtphhtthhopeejpdhrtghpthhtohephfhrrghnkhdrlhhisehngihprdgtohhmpdhrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehimhigsehli
 hhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

On Mon, Nov 24, 2025 at 10:57:49AM -0500, Frank Li wrote:
> On Mon, Nov 24, 2025 at 01:50:22PM +0100, Jean-Michel Hautbois wrote:
> > Add dma_wmb() barrier after filling TCD descriptors to ensure all
> > descriptor writes are visible to the DMA engine before starting
> > transfers. This prevents potential race conditions where the DMA
> > hardware might read partially written descriptors.
> >
> > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> > ---
> >  drivers/dma/fsl-edma-common.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> > index 4976d7dde08090d16277af4b9f784b9745485320..db36a6aafc910364d75ce6c5d334fd19d2120b6b 100644
> > --- a/drivers/dma/fsl-edma-common.c
> > +++ b/drivers/dma/fsl-edma-common.c
> > @@ -553,6 +553,9 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
> >  	fsl_edma_set_tcd_to_le(fsl_chan, tcd, csr, csr);
> >
> >  	trace_edma_fill_tcd(fsl_chan, tcd);
> > +
> > +	/* Ensure descriptor writes are visible to DMA engine */
> > +	dma_wmb();
> 
> This is not necessary because there are writel() in
> fsl_edma_issue_pending(), which will do memory barrier in writel().
> 
> currently, edma use vchan, descriptior have not dymantically to appending
> to running queue. so writel() in fsl_edma_issue_pending() is enough.
> 
> Even though edma will support append to running queue in future, dma_wmd()
> should be just before update csr.
> 
>  	dma_wmb();  // just before indicate TCD is ready to use.
> 	fsl_edma_set_tcd_to_le(fsl_chan, tcd, csr, csr);
> 

Thanks for you detailed explanation, I will remove this commit from v2
:-).

JM
> Frank
> >  }
> >
> >  static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
> >
> > --
> > 2.39.5
> >

