Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA733206C1A
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 08:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbgFXGDx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 02:03:53 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:47660 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388164AbgFXGDx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Jun 2020 02:03:53 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jun 2020 02:03:53 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 6248B18009133
        for <dmaengine@vger.kernel.org>; Wed, 24 Jun 2020 05:56:36 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EF110837F24A;
        Wed, 24 Jun 2020 05:56:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2560:2563:2682:2685:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7904:9025:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:13069:13153:13228:13311:13357:13439:14181:14659:14721:21080:21451:21627:21990:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: cap36_5b0ffc026e41
X-Filterd-Recvd-Size: 2586
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Jun 2020 05:56:33 +0000 (UTC)
Message-ID: <fa304f0ef1dba4fcf5e495f3c2feb4d3816f20ac.camel@perches.com>
Subject: Re: [PATCH][next] dmaengine: ti: k3-udma: Use struct_size() in
 kzalloc()
From:   Joe Perches <joe@perches.com>
To:     Vinod Koul <vkoul@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Tue, 23 Jun 2020 22:56:32 -0700
In-Reply-To: <20200624055535.GX2324254@vkoul-mobl>
References: <20200619224334.GA7857@embeddedor>
         <20200624055535.GX2324254@vkoul-mobl>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 2020-06-24 at 11:25 +0530, Vinod Koul wrote:
> On 19-06-20, 17:43, Gustavo A. R. Silva wrote:
> > Make use of the struct_size() helper instead of an open-coded version
> > in order to avoid any potential type mistakes.
> > 
> > This code was detected with the help of Coccinelle and, audited and
> > fixed manually.
> > 
> > Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83

Is this odd tag really useful?

> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/dma/ti/k3-udma.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> > index 0d5fb154b8e2..411c54b86ba8 100644
> > --- a/drivers/dma/ti/k3-udma.c
> > +++ b/drivers/dma/ti/k3-udma.c
> > @@ -2209,7 +2209,7 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
> >  	u32 ring_id;
> >  	unsigned int i;
> >  
> > -	d = kzalloc(sizeof(*d) + sglen * sizeof(d->hwdesc[0]), GFP_NOWAIT);
> > +	d = kzalloc(struct_size(d, hwdesc, sglen), GFP_NOWAIT);
> 
> struct_size() is a * b + c but here we need, a + b * c.. the trailing
> struct is N times here..
> 
> 
> >  	if (!d)
> >  		return NULL;
> >  
> > @@ -2525,7 +2525,7 @@ udma_prep_dma_cyclic_pkt(struct udma_chan *uc, dma_addr_t buf_addr,
> >  	if (period_len >= SZ_4M)
> >  		return NULL;
> >  
> > -	d = kzalloc(sizeof(*d) + periods * sizeof(d->hwdesc[0]), GFP_NOWAIT);
> > +	d = kzalloc(struct_size(d, hwdesc, periods), GFP_NOWAIT);
> >  	if (!d)
> >  		return NULL;
> >  
> > -- 
> > 2.27.0

