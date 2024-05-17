Return-Path: <dmaengine+bounces-2056-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F338C8574
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 13:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93EB1C21864
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692533D0A3;
	Fri, 17 May 2024 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="HGCg061F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052733B78B;
	Fri, 17 May 2024 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944748; cv=none; b=RldVElgDMFhkilnLxr5nvR+4FFkUFTFyh9NoyYTHxSY1IMyXW2HdCPda7+CHC0GXgj5HVRUvKTIKZhYbbHmNpiPCrC1KLZefbHy7D2IrLTqj9jx8WLDG0hSTMRtnpmdkzQ93bu3ds3P7Oa4XfagEj4o6T0pcIsfS3Z+3dw0HoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944748; c=relaxed/simple;
	bh=cO2vSdqcGJpMPi+yEXm6Pdtgj69gONnYZVOEhF5dVBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI9oN2ZLc41Pdgl44YSjLy+HATt6FdpwGLHB2hKt8au3QervD1GARige6zgMt8Flc77a9W+SrIt87ZKrDmOqA35VOWOTOQmnGwdPua5jOYdZWw7r9eOPOcbVOe7ylVbHBcgcxS1bQzlRQx3IbXLxP95Yps+YfwxBenmO34TNf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=HGCg061F; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=8fWvTVdamGkUuRsdVgUf56VkvVX12PzmdijVreLfbOY=; b=HGCg061FjpQGYi68
	ux0lHPT0iTNJWGYwicTiV0q6ItNJDnmGwkf62XqhoIJqCOClIHhnhulIFQF6oQz+Z6G3pMJnihR/N
	BgTbwF2D1MWAxgv1XK1+u/wtiPpOp85cbrFbY9o8OU92rT8LdfjDO0ssXQE/frARhKUmfYtFw1jUj
	H9tmkfhigG6TR/1nPuS0r7glwYJOFGB52PLkzzXMbKOMjbRdmjQcPGfPHk9ZcHWf9i1+tItq21F/H
	WIzu1vbhtjIITEOJhaPd9wZDfDRQrMM3E7vQ9vOSqWk5q3SbVhYaCpbkmnSCR57Yczn+wuWtsSAZz
	WL9vglftOgTaHO98KQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s7vc7-001NSk-0s;
	Fri, 17 May 2024 11:19:03 +0000
Date: Fri, 17 May 2024 11:19:03 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Frank.li@nxp.com, vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: qcom: gpi: remove unused struct 'reg_info'
Message-ID: <Zkc9J4vbQdeCmTpO@gallifrey>
References: <20240516152537.262354-1-linux@treblig.org>
 <39b66355-f67e-49e9-a64b-fdd87340f787@linaro.org>
 <Zkc69sMlwawV8Z7l@gallifrey>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Zkc69sMlwawV8Z7l@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 11:18:40 up 8 days, 22:32,  1 user,  load average: 0.10, 0.05, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> * Bryan O'Donoghue (bryan.odonoghue@linaro.org) wrote:
> > On 16/05/2024 17:25, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > Remove unused struct 'reg_info'
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > ---
> > >   drivers/dma/qcom/gpi.c | 6 ------
> > >   1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> > > index 1c93864e0e4d..639ab304db9b 100644
> > > --- a/drivers/dma/qcom/gpi.c
> > > +++ b/drivers/dma/qcom/gpi.c
> > > @@ -476,12 +476,6 @@ struct gpi_dev {
> > >   	struct gpii *gpiis;
> > >   };
> > > -struct reg_info {
> > > -	char *name;
> > > -	u32 offset;
> > > -	u32 val;
> > > -};
> > > -
> > >   struct gchan {
> > >   	struct virt_dma_chan vc;
> > >   	u32 chid;
> 
> Hi Bryan,
> 
> > More detail in the commit log please - is the structure unused ? What is the
> > provenance of it being added and becoming dead code.
> > 
> > More detail required here.
> 
> If you look at the V1 I had
> ''gpi_desc' seems like it was never used.
> Remove it.'
> 
> but Frank suggested copying the subject line; so I'm not sure
> whether you want more or less!
> 
> I could change this to:
> 
> 'gpi_desc' was never used since it's initial
> commit 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")

Oops, of course I mean 'reg_info' which is what I fixed in v2.

> Would you be OK with that?

Dave

> Dave
> 
> 
> > 
> > ---
> > bod
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

