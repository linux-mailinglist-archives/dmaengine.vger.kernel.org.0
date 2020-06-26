Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EA620B272
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2020 15:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgFZNYc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Jun 2020 09:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgFZNYb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 26 Jun 2020 09:24:31 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DAD62075D;
        Fri, 26 Jun 2020 13:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593177871;
        bh=/EUxyCyPVfvVOBq8FVj7Lzb1Feg675LVd6REFNzxA2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUQdPr/BUuMqYXe8r9nhip2IX12AYbzTXzkUAxwJL5FE60nIhfMu2DKFa+LbyIYP7
         ZdsFqpQ8cHDvUJMUuhBPcG5PUTvVN99Zef36yIJqeMWGkiW5D6DCNvVlxhINT+3nsg
         HyJ3UXX2scv/Q608VIWJuTgZyM466GVNGOJXy6UE=
Date:   Fri, 26 Jun 2020 08:29:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: ti: k3-udma: Use struct_size() in
 kzalloc()
Message-ID: <20200626132944.GA26003@embeddedor>
References: <20200619224334.GA7857@embeddedor>
 <20200624055535.GX2324254@vkoul-mobl>
 <3a5514c9-d966-c332-84ba-f418c26fa74c@embeddedor.com>
 <98426221-8bff-25df-a062-9ec1ca4e8f26@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98426221-8bff-25df-a062-9ec1ca4e8f26@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

Please, see my comments below...

On Fri, Jun 26, 2020 at 10:30:37AM +0300, Peter Ujfalusi wrote:
> 
> 
> On 24/06/2020 20.12, Gustavo A. R. Silva wrote:
> > Hi Vinod,
> > 
> > On 6/24/20 00:55, Vinod Koul wrote:
> >> On 19-06-20, 17:43, Gustavo A. R. Silva wrote:
> >>> Make use of the struct_size() helper instead of an open-coded version
> >>> in order to avoid any potential type mistakes.
> >>>
> >>> This code was detected with the help of Coccinelle and, audited and
> >>> fixed manually.
> >>>
> >>> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> >>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >>> ---
> >>>  drivers/dma/ti/k3-udma.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> >>> index 0d5fb154b8e2..411c54b86ba8 100644
> >>> --- a/drivers/dma/ti/k3-udma.c
> >>> +++ b/drivers/dma/ti/k3-udma.c
> >>> @@ -2209,7 +2209,7 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
> >>>  	u32 ring_id;
> >>>  	unsigned int i;
> >>>  
> >>> -	d = kzalloc(sizeof(*d) + sglen * sizeof(d->hwdesc[0]), GFP_NOWAIT);
> >>> +	d = kzalloc(struct_size(d, hwdesc, sglen), GFP_NOWAIT);
> >>
> >> struct_size() is a * b + c but here we need, a + b * c.. the trailing
> >> struct is N times here..
> >>
> > 
> > struct_size() works exactly as expected in this case. :)
> > Please, see:
> > 
> > include/linux/overflow.h:314:
> > 314 #define struct_size(p, member, count)                                   \
> > 315         __ab_c_size(count,                                              \
> > 316                     sizeof(*(p)->member) + __must_be_array((p)->member),\
> > 317                     sizeof(*(p)))
> 
> True, struct_size is for this sort of things.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> While looking it up in include/linux/overflow.h I have noticed your
> commit in linux-next, which adds flex_array_size()
> 
> The example in the commit message contradicts with what the helper

There is no contradiction here.

> does imho. To be correct it should have been:
> 
> struct something {
> 	size_t count;
> 	struct foo items[];
> };
> 
> - struct something *instance;
> + struct something instance;
> 
> - instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
> + instance.items = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
> instance->count = count;
> memcpy(instance->items, src, flex_array_size(instance, items, instance->count));
> 

This is all wrong. Please, double check how struct_size() works.

Thanks
--
Gustavo

> >>>  	if (!d)
> >>>  		return NULL;
> >>>  
> >>> @@ -2525,7 +2525,7 @@ udma_prep_dma_cyclic_pkt(struct udma_chan *uc, dma_addr_t buf_addr,
> >>>  	if (period_len >= SZ_4M)
> >>>  		return NULL;
> >>>  
> >>> -	d = kzalloc(sizeof(*d) + periods * sizeof(d->hwdesc[0]), GFP_NOWAIT);
> >>> +	d = kzalloc(struct_size(d, hwdesc, periods), GFP_NOWAIT);
> >>>  	if (!d)
> >>>  		return NULL;
> >>>  
> >>> -- 
> >>> 2.27.0
> >>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
