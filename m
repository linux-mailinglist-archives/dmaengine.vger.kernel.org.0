Return-Path: <dmaengine+bounces-2055-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA46F8C854D
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 13:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94754281F89
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78263FB38;
	Fri, 17 May 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="PXQxEoqz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B543FB2F;
	Fri, 17 May 2024 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944194; cv=none; b=uHRTiHOD4vJUKnixXJ75pUeKpS3fU2M1XuaoMiSFdCulms1oYAZO2oZuLPre0ctQiG/0AsOvr7YF/4g0nGTEtI0JjKWi4t1kDLsCQJcuHXgZMKbP4QlFubYVd4uVvlhr6FPIVO0Lh+npOM8Y42MKtVo6JTtiFz4C+X/Fx5ibCsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944194; c=relaxed/simple;
	bh=RQTAK1sZRcW/HEeu/lsrirYTSvY+q0Dip8xhIGw8Z/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onADI1uugWOV3loW6yJuCLzM66B48Ezo/BHk+Ue0/U10cixkfBYHLjo/X5knCSpCgsLkSXsaKGcNdNC2wNw7IyAFB3oglrr9cNjlvOw0O3VaSbImlgt491XqbDQgPnuiNKU3SQdggCKLXZpwU+/dgCkwbivkLdwjqEEeTB5gbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=PXQxEoqz; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=+tq+++souCpFv9+PH5wxA0rTtq3HB5/z/9XdF0Yji7k=; b=PXQxEoqzA6ESGS5A
	RR9fwH5MqwROAAdk+Tm5KGQEui49DCReLnueWbvuhiljoFPwoQ9z4t/5qTjkPLCYwmtJDqn+j3Ahl
	Vg099N255BMVcPYySHq6XdjwT6advwGfUX1s5qZCQDkR9DF39voPmElvrCA2gYRTLMnKTOEJhTaT5
	G2wr1+xKyYaQpNkYOrldDqeTqIPJBFhCONyAJ/gl++VpXGPXx4fNlvaGPGjoTbrZEN1ojL/AAzdg5
	HcYxERi2gWxfydoq3LtjAtdgNhVpAFs4SR+OincCvtkAex4NgrxaeFiWuWVo3lNUyJawoXWRs3uwo
	6nkqTe1siPGDCn9YtA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s7vT4-001NKG-1q;
	Fri, 17 May 2024 11:09:42 +0000
Date: Fri, 17 May 2024 11:09:42 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Frank.li@nxp.com, vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: qcom: gpi: remove unused struct 'reg_info'
Message-ID: <Zkc69sMlwawV8Z7l@gallifrey>
References: <20240516152537.262354-1-linux@treblig.org>
 <39b66355-f67e-49e9-a64b-fdd87340f787@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <39b66355-f67e-49e9-a64b-fdd87340f787@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 11:05:21 up 8 days, 22:19,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Bryan O'Donoghue (bryan.odonoghue@linaro.org) wrote:
> On 16/05/2024 17:25, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > Remove unused struct 'reg_info'
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >   drivers/dma/qcom/gpi.c | 6 ------
> >   1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> > index 1c93864e0e4d..639ab304db9b 100644
> > --- a/drivers/dma/qcom/gpi.c
> > +++ b/drivers/dma/qcom/gpi.c
> > @@ -476,12 +476,6 @@ struct gpi_dev {
> >   	struct gpii *gpiis;
> >   };
> > -struct reg_info {
> > -	char *name;
> > -	u32 offset;
> > -	u32 val;
> > -};
> > -
> >   struct gchan {
> >   	struct virt_dma_chan vc;
> >   	u32 chid;

Hi Bryan,

> More detail in the commit log please - is the structure unused ? What is the
> provenance of it being added and becoming dead code.
> 
> More detail required here.

If you look at the V1 I had
''gpi_desc' seems like it was never used.
Remove it.'

but Frank suggested copying the subject line; so I'm not sure
whether you want more or less!

I could change this to:

'gpi_desc' was never used since it's initial
commit 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")

Would you be OK with that?

Dave


> 
> ---
> bod
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

