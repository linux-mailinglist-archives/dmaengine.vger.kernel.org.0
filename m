Return-Path: <dmaengine+bounces-2048-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D624A8C797F
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 17:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9231A28B358
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462C914D45E;
	Thu, 16 May 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Z5hPHuuD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9918D14D45B;
	Thu, 16 May 2024 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873325; cv=none; b=rkV/flk+gPvhOsq/BdkYz2wTdt5Yg3qCfU5S2LyRYYfbi07+w0ppXxEwn6K0tqu0EMBGua2yNgQfNhD6wgBw1cWvHRXBm88hy9J0sUFv3IHPEI65B9/Jn8FNtyM+D+iIWA9hmFO4wem00AhY63MQgsVXS1ZjMpmEn9jSxvbzlaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873325; c=relaxed/simple;
	bh=xCuk8ZzFJym6L8TZxuo7kEre6sk+X7WHmfdRRx/azAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S38y3EOlgd6cdLlEVNUmnrLhEx7BuJbr51x8JyKI4yRekVij+26wMCJssCBacxMSK2DpalwG7bfBx1Vug8Xbd7dV2o1uiSJZXdmsJAsTVm7XEI5F3QeVn7epxjJaGqKCoAWqgJmmN/Y4M0hiKYxZaekzQc/CW64jnkgM3D7hILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Z5hPHuuD; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=2VWTf8Mt+BUEGSmfkFPAKH4Wh10gssG2SiLRzDX3BqM=; b=Z5hPHuuDMUSHauH1
	c7l6j74fDGVAqL+LNQr3kauUbKmGz5NujWBujw0WMr3ZxgAxIlk1UigGnXUIxxpSx8UqPTdXHkGE0
	UZqyRFPsHuH+20BC3w6u0Brvd0vv5n1+ZEXUtK3OAJ0CPIvTuu2/EeXA01XAfBFezK7rzSpj0pVbb
	PJHr06u/lmF6IuQB/sddRADaUw4hGZboAR1jCuyMUgoDB2eZgp1/6WRIne01WdbAGK5iMOJizPpSV
	6MVkzb84TsJr6rEPiTAYxx+VJoukVnTcJgrGOkKLRsQ5zJ4grMZu+rtRfkIlPReAiv5cULylRKJ+d
	TkNVyScMk6YX+zZenA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s7d29-001FyV-1B;
	Thu, 16 May 2024 15:28:41 +0000
Date: Thu, 16 May 2024 15:28:41 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: moxart-dma: remove unused struct
 'moxart_filter_data'
Message-ID: <ZkYmKVQ5NRwgSA53@gallifrey>
References: <20240516133250.251252-1-linux@treblig.org>
 <ZkYeE2SgzCFDqKs2@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZkYeE2SgzCFDqKs2@lizhi-Precision-Tower-5810>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:28:29 up 8 days,  2:42,  2 users,  load average: 0.05, 0.04, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Frank Li (Frank.li@nxp.com) wrote:
> On Thu, May 16, 2024 at 02:32:50PM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'moxart_filter_data' never appears to have been used.
> > Remove it.
> 
> You can duplicate subject.
> 
> Remove unused struct moxart_filter_data.

V2 sent.

Dave

> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  drivers/dma/moxart-dma.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
> > index c48d68cbff92..66dc6d31b603 100644
> > --- a/drivers/dma/moxart-dma.c
> > +++ b/drivers/dma/moxart-dma.c
> > @@ -148,11 +148,6 @@ struct moxart_dmadev {
> >  	unsigned int			irq;
> >  };
> >  
> > -struct moxart_filter_data {
> > -	struct moxart_dmadev		*mdc;
> > -	struct of_phandle_args		*dma_spec;
> > -};
> > -
> >  static const unsigned int es_bytes[] = {
> >  	[MOXART_DMA_DATA_TYPE_S8] = 1,
> >  	[MOXART_DMA_DATA_TYPE_S16] = 2,
> > -- 
> > 2.45.0
> > 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

