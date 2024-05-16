Return-Path: <dmaengine+bounces-2044-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822468C794A
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 17:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217041F219A2
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 15:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540D414B97B;
	Thu, 16 May 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="NU2xaTu/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8751E491;
	Thu, 16 May 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873118; cv=none; b=pEuzf8x6pHZpH7Wa6ykcDpFQxsnmb6IJIHc33PZYMMIjHeZSrig8tDHciSVHfxv44JRPL0z/9RdjVCbD/vXSLE8jszmHgAGa3G7ODya8YXPBnfyKIj5z0cYWQRvk6jEylLGMj5qWsp0pwOw2FMSghSBWjnMDfVGJR4mHO7Rq5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873118; c=relaxed/simple;
	bh=YTfcN3ABeR8TgtyVD7RSJHOoZtLWmrSjRR3Vv5D/b6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/J6ArceosP0ui6juDHW642eSW8cPqnQQyeJEOnGP2pi1gxjNDz6To2lq5XGizR0u9UbAZ72pUenqvUDqPXQVhi7voG3je2lo4KFBlHLmPMtjSsBbJD7k8pBXv6/25Lo5epzPgCqdZnbyshllkSqLau6g2W+BhKtbvTVYi2tFhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=NU2xaTu/; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=ZhFvrP46M0abGKnWf7SV+eo4mI12fx7mDm5L6hnBtXA=; b=NU2xaTu/MB5fraFn
	tWRzPU7/oXq/XojRJgS/8tT+OrizrJBQOsBOoDUKqLA51M+jnKfht5LpV0TSmTlWwb4cZ3D4r9wzY
	sPv44QOg6m3TJcIcjt28/szsca5ky3Ox+ZdD1fo6snX5yX7HqaD9Q1GSeMf7g3jemgmRcCHc9Ynys
	msgXJmYa0mX20oyG8bGWxajwylJZTsl5qFZ1TtE0AebI1H9/U8QBw/IdNoS4pLdGn2Prnmn3L1Pmq
	/OGXOGEvnGeV0FQ1/VabsrH41YKcCNVoecDQHB7PQZGKDWGXNsKPLKpoopjlmi1D5c9MDXJcF5cRe
	a8Towg5rJiBB6YBYFw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s7cym-001Fs8-1V;
	Thu, 16 May 2024 15:25:12 +0000
Date: Thu, 16 May 2024 15:25:12 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: gpi: remove unused struct 'gpi_desc'
Message-ID: <ZkYlWIg74EqHUFAp@gallifrey>
References: <20240516133211.251205-1-linux@treblig.org>
 <ZkYdDtoPMnYlGT/6@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZkYdDtoPMnYlGT/6@lizhi-Precision-Tower-5810>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:24:29 up 8 days,  2:38,  2 users,  load average: 0.01, 0.04, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Frank Li (Frank.li@nxp.com) wrote:
> On Thu, May 16, 2024 at 02:32:11PM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'gpi_desc' seems like it was never used.
> > Remove it.
> 
> code change show 'reg_info', not 'gpi_desc'. You need make sure that it
> really is not used, not "seems like".

Oops that was a cut-and-paste when I did the commit on the name.

It was build tested.

V2 coming along now.

Dave

> 'struct reg_info' is never used, so remove it.
> 
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  drivers/dma/qcom/gpi.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> > index 1c93864e0e4d..639ab304db9b 100644
> > --- a/drivers/dma/qcom/gpi.c
> > +++ b/drivers/dma/qcom/gpi.c
> > @@ -476,12 +476,6 @@ struct gpi_dev {
> >  	struct gpii *gpiis;
> >  };
> >  
> > -struct reg_info {
> > -	char *name;
> > -	u32 offset;
> > -	u32 val;
> > -};
> > -
> >  struct gchan {
> >  	struct virt_dma_chan vc;
> >  	u32 chid;
> > -- 
> > 2.45.0
> > 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

