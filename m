Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B43A4D6831
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 18:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346804AbiCKR7q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 12:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344852AbiCKR7p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 12:59:45 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369E71D2B7B
        for <dmaengine@vger.kernel.org>; Fri, 11 Mar 2022 09:58:39 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id t14so8069763pgr.3
        for <dmaengine@vger.kernel.org>; Fri, 11 Mar 2022 09:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dm1vOpXvIp9l8e+VkjRPvyaqUaFEE0HBNnHCWOy95E8=;
        b=pSZA0K1AzBAfbo+/3joVYCkvXL11i7b8wOqI7fIv3y2s5l7cnC49HUacRa4MitX6Jq
         2EVFDYRKLYkIk8RVFSU+OT/VXpEYk7CsNwmbm0OqIbfbx9bfV5LrAHWKViNxNFvr2VZt
         JgdCvdTKhF6GiYDsBW4HnQy8ZyduZooYm5V4IJdvdTugTBhsPJVhaGvLobMBM3c8zvOH
         IcG9XzFAdrfAYnbb4NSw/gpqSmfF5+wd2GkatLcA6uxEzP7w/Ere4P/b0HG1BGp+VIa/
         VXwq9NWPVKMmAyKZPSvr9DCoBBFE/FcLftYr7+w8UXbUh/mefqomGMfAlfejTonGvK1N
         EheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dm1vOpXvIp9l8e+VkjRPvyaqUaFEE0HBNnHCWOy95E8=;
        b=g5ycBqUFZ8ZYIGlsTAIsRWa1gBKDIF3dl5S0hddZWFAZc6ua2wQ3aj48T3WqG4vxsC
         ZfDnx6/BIyoNadTujXPemhrtzWAeh9UmC9or+8Ro6jTMy2FgoHHIjc4eMeOqM4ocHgr9
         wxYktp+0aYCvwbqIm0XDdj/V+MWi5xJTGtWhk4NImishFxBgjfX4PP8y2qoFNzo71F91
         ShG2yJngDuRolL+UpqIpjLTgEDt1RJwDO8mshTEyaHtaW1xtbi/hs3et3N9dCrnKQsQY
         X1iS4amR6i/s27OzfKRgG2vn18FaZ6StaECrXPKr29PFz3GV59pA2sK1OmyUgqtuGahq
         /JVg==
X-Gm-Message-State: AOAM533SK3tMGmpJ0Us/jBK2LU+dQXby28Zm63by674OXJImhIxmTu1j
        ehCklLKMux2BOdVEjf8mDNWeFwelfdQM
X-Google-Smtp-Source: ABdhPJzK4djpG2HG2wyuzPHVx/oJ73jhDH9QkIC8r7cYdaraSIufmd+sWxI5qW+0cygCxGy2q9yLIQ==
X-Received: by 2002:a05:6a00:ccd:b0:4f6:f6fb:d2b with SMTP id b13-20020a056a000ccd00b004f6f6fb0d2bmr11372721pfv.59.1647021518627;
        Fri, 11 Mar 2022 09:58:38 -0800 (PST)
Received: from thinkpad ([117.202.191.144])
        by smtp.gmail.com with ESMTPSA id k20-20020a056a00135400b004ecc81067b8sm12212185pfu.144.2022.03.11.09.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:58:38 -0800 (PST)
Date:   Fri, 11 Mar 2022 23:28:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v4 6/8] dmaengine: dw-edma: Don't rely on the deprecated
 "direction" member
Message-ID: <20220311175831.GD3966@thinkpad>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-7-Frank.Li@nxp.com>
 <20220310172930.g7xq3txjkbwtdmbw@mobilestation>
 <20220310174159.GF4869@thinkpad>
 <20220310175225.66k6cor4afjlybew@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310175225.66k6cor4afjlybew@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 10, 2022 at 08:52:25PM +0300, Serge Semin wrote:
> On Thu, Mar 10, 2022 at 11:11:59PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Mar 10, 2022 at 08:29:30PM +0300, Serge Semin wrote:
> > > On Wed, Mar 09, 2022 at 03:12:02PM -0600, Frank Li wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > > The "direction" member of the "dma_slave_config" structure is deprecated.
> > > > The clients no longer use this field to specify the direction of the slave
> > > > channel. But in the eDMA core, this field is used to differentiate between the
> > > > Root complex (remote) and Endpoint (local) DMA accesses.
> > > > 
> > > > Nevertheless, we can't differentiate between local and remote accesses without
> > > > a dedicated flag. So let's get rid of the old check and add a new check for
> > > > verifying the DMA operation between local and remote memory instead.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > no chang between v1 to v4
> > > >  drivers/dma/dw-edma/dw-edma-core.c | 17 ++---------------
> > > >  1 file changed, 2 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > index 507f08db1aad3..47c6a52929fcd 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > @@ -341,22 +341,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > > >  	if (!chan->configured)
> > > >  		return NULL;
> > > >  
> > > > -	switch (chan->config.direction) {
> > > > -	case DMA_DEV_TO_MEM: /* local DMA */
> > > > -		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ)
> > > > -			break;
> > > > -		return NULL;
> > > > -	case DMA_MEM_TO_DEV: /* local DMA */
> > > > -		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE)
> > > > -			break;
> > > 
> > > > +	/* eDMA supports only read and write between local and remote memory */
> > > 
> > > The comment is a bit confusing because both cases are named as
> > > "memory" while the permitted directions contains DEV-part, which
> > > means "device". What I would suggest to write here is something like:
> > > "DW eDMA supports transferring data from/to the CPU/Application memory
> > > to/from the PCIe link partner device by injecting the PCIe MWr/MRd TLPs."
> > > 
> > 
> 
> > End of the day, you'd be transferring data between remote and local memory
> > only and the terms (local and remote) are also used in the databook. So I think
> > the comment is fine.
> 
> Yes, but the databook either adds a note regarding what memory it is
> or it can be inferred from the text context. So at least it would be
> appropriate to preserve the notes here two:
> "eDMA supports only read and write between local (CPU/application) and
> remote (PCIe/link partner) memory." Otherwise it's hard to understand
> what memory the comment states about.
> 

Okay, I'm fine with this.

"eDMA supports only read and write between local (CPU/application) and
remote (PCIe/link partner) memory."

Thanks,
Mani

> -Sergey
> 
> > 
> > Thanks,
> > Mani
> > 
> > > -Sergey
> > > 
> > > > +	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
> > > >  		return NULL;
> > > > -	default: /* remote DMA */
> > > > -		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
> > > > -			break;
> > > > -		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
> > > > -			break;
> > > > -		return NULL;
> > > > -	}
> > > >  
> > > >  	if (xfer->type == EDMA_XFER_CYCLIC) {
> > > >  		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
> > > > -- 
> > > > 2.24.0.rc1
> > > > 
