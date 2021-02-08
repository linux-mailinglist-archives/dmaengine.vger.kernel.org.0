Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05703131DC
	for <lists+dmaengine@lfdr.de>; Mon,  8 Feb 2021 13:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBHMLi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Feb 2021 07:11:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232680AbhBHMJw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 8 Feb 2021 07:09:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F1A264E7C;
        Mon,  8 Feb 2021 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612786151;
        bh=zEXIGaz/Pnm+o6JEnUtqjW6qAoRGi0mtgVzkI/osh4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mztQi4NUjSvlv2F4FH9dxElLDeqxcdDwaYfpXeqySrBuge0YsdpFsehGLIkIz1e5L
         DEI8XesEnrbAJlnZEIh/OXd3leP38LqHGoycs5VpisZYHbM47axiuQurJRqiGHOfEZ
         PjcB+bgCLunb20La2vuSZxUts8o7per9ezMNYSZNmlvKWEq2AKq8b+2/oQgjIMIq8K
         w+QSs7mt3s/FafFTun6VqTLsZnxpY9i4fLDhwlRyB11TuLX7SQ012EFZcr0tWYMqzL
         iX5sbr9GA6utyfjP8oftsm5KV5JdFkfWTjrD9nL9V/kMCYtHpeqQCSd3nTGodkOLnn
         GSbMKPHBOT/qA==
Date:   Mon, 8 Feb 2021 17:39:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Sia, Jee Heng" <jee.heng.sia@intel.com>
Cc:     Colin King <colin.king@canonical.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] dmaengine: dw-axi-dmac: remove redundant null
 check on desc
Message-ID: <20210208120907.GD879029@vkoul-mobl.Dlink>
References: <20210203134652.22618-1-colin.king@canonical.com>
 <CO1PR11MB502607E4DB3DD971956D6CF2DAB39@CO1PR11MB5026.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB502607E4DB3DD971956D6CF2DAB39@CO1PR11MB5026.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-02-21, 00:18, Sia, Jee Heng wrote:
> The code looks good to me. I have also verified it on Intel KeemBay platform.
> 
> Reviewed-by: Sia Jee Heng <jee.heng.sia@intel.com>
> Tested-by: Sia Jee Heng <jee.heng.sia@intel.com>

Please *do not* top post!

> 
> Thanks
> Regards
> Jee Heng
> > -----Original Message-----
> > From: Colin King <colin.king@canonical.com>
> > Sent: 03 February 2021 9:47 PM
> > To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>; Vinod Koul
> > <vkoul@kernel.org>; Sia, Jee Heng <jee.heng.sia@intel.com>; Andy
> > Shevchenko <andriy.shevchenko@linux.intel.com>;
> > dmaengine@vger.kernel.org
> > Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH][next] dmaengine: dw-axi-dmac: remove redundant
> > null check on desc
> > 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The pointer desc is being null checked twice, the second null check is
> > redundant because desc has not been re-assigned between the checks.
> > Remove the redundant second null check on desc.
> > 
> > Addresses-Coverity: ("Logically dead code")
> > Fixes: ef6fb2d6f1ab ("dmaengine: dw-axi-dmac: simplify descriptor
> > management")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index ac3d81b72a15..d9e4ac3edb4e 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -919,10 +919,6 @@ dma_chan_prep_dma_memcpy(struct
> > dma_chan *dchan, dma_addr_t dst_adr,
> >  		num++;
> >  	}
> > 
> > -	/* Total len of src/dest sg == 0, so no descriptor were
> > allocated */
> > -	if (unlikely(!desc))
> > -		return NULL;
> > -
> >  	/* Set end-of-link to the last link descriptor of list */
> >  	set_desc_last(&desc->hw_desc[num - 1]);
> >  	/* Managed transfer list */
> > --
> > 2.29.2
> 

-- 
~Vinod
