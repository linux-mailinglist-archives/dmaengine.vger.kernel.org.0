Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97396676A73
	for <lists+dmaengine@lfdr.de>; Sun, 22 Jan 2023 01:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjAVAfC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 Jan 2023 19:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAVAfB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 Jan 2023 19:35:01 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607411F486;
        Sat, 21 Jan 2023 16:35:00 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id g14so9532040ljh.10;
        Sat, 21 Jan 2023 16:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdrGZsJ+QDC0ry+jJcKChDlMQ9gtWypeGkHtFi0scYc=;
        b=CQZjiL+L3V6Gh5EvD7jQqZi//1HouVKj82uMkBzA7PfDut+xGKcQ0+3RAo5hitAcEZ
         aXx5OuO3ZFaWpBP7/Eb+nHZsiFiJUIdtVzvR7Geg9fSlMR9aakwWjQ4JYEFRiovEbJYM
         d+U5wENUVBzAVpfh46y8hoh/U7vfpGD3OeSgzPsSFFK/yrdsWy9oyWzztGHAlN/B7Lmo
         gZo/4lONauqZiI+fB0KqPE5XughTSJ1nVRAd4ylm0j6KJIMJ1DpM/WM7hPDd/93/QrhO
         BiY4MVnHc1TrRJ1MMcl0et3aJRzyIv2t9zejjPSEheZ6Z0T5PyVVZLvRdFlKyXqCTbOm
         /oSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdrGZsJ+QDC0ry+jJcKChDlMQ9gtWypeGkHtFi0scYc=;
        b=SEe0cVqoUNdLcfiz2ILLOYpFKE/Yk2fQsqXCXVRy/GaWRBN706UIj10oUVL6Wl/Lyi
         /vr4PYuIPGPxo7MQ5BjqADYwGAWWC1NyI+e1HeKtgcIbqPFg9r+ZVtCKuHVIpT2sKA7a
         BKMDZzBzc4ZG0GkyS42IMeOSzoT5GSg/h2zITEIIT/pZSpYPfHNd8QzaK8rEM/Z1fWYP
         fYwy6VtIouQHx7pL2ATtiiazjxhSf3ErZ9GWu/nmUhfIC6P37X35d8qt02jjwBt/digO
         gO4AmXy/4cdvbD4BGS4Aa3SIqZBH2BP4qS/5h/+L3VwbBnJ459uPT8TLdhh8TIIRRFy6
         +lzA==
X-Gm-Message-State: AFqh2kq1PtOLUBxAwmWRZ+GeUGO1j6GNrC2zUHujumpCOolWH/p8Np0t
        7CzIbrXurNhUs/S2PlMdgPs=
X-Google-Smtp-Source: AMrXdXty0R5D4eSYIJE+CK657Fg4n7cCqeRZAzmb77gZrk7tgljRcjEQzY1HaT7LJwmdTl1zvbELng==
X-Received: by 2002:a2e:b17c:0:b0:28b:79d7:58bc with SMTP id a28-20020a2eb17c000000b0028b79d758bcmr5059018ljm.45.1674347698720;
        Sat, 21 Jan 2023 16:34:58 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id f27-20020a2eb5bb000000b0027fd72dd6a1sm3071426ljn.70.2023.01.21.16.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 16:34:58 -0800 (PST)
Date:   Sun, 22 Jan 2023 03:34:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 25/27] PCI: dwc: Set coherent DMA-mask on MSI-address
 allocation
Message-ID: <20230122003455.mftnxdsjyemxz7bb@mobilestation>
References: <20230113171409.30470-26-Sergey.Semin@baikalelectronics.ru>
 <20230120215952.GA672871@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120215952.GA672871@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 20, 2023 at 03:59:52PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 13, 2023 at 08:14:07PM +0300, Serge Semin wrote:
> > The MSI target address requires to be reserved within the lowest 4GB
> > memory in order to support the PCIe peripherals with no 64-bit MSI TLPs
> > support. Since the allocation is done from the DMA-coherent memory let's
> > modify the allocation procedure to setting the coherent DMA-mask only and
> > avoiding the streaming DMA-mask modification. Thus at least the streaming
> > DMA operations would work with no artificial limitations. It will be
> > specifically useful for the eDMA-capable controllers so the corresponding
> > DMA-engine clients would map the DMA buffers with no need in the SWIOTLB
> > intervention for the buffers allocated above the 4GB memory region.
> > 
> > While at it let's add a brief comment about the reason of having the MSI
> > target address allocated from the DMA-coherent memory limited with the 4GB
> > upper bound.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > 
> > ---
> > 
> > Changelog v8:
> > - This is a new patch added on v8 stage of the series.
> >   (@Robin, @Christoph)
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 3ab6ae3712c4..e10608af39b4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -366,7 +366,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  						    dw_chained_msi_isr, pp);
> >  	}
> >  
> > -	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > +	/*
> > +	 * Even though the iMSI-RX Module supports 64-bit addresses some
> > +	 * peripheral PCIe devices may lack the 64-bit messages support. In
> > +	 * order not to miss MSI TLPs from those devices the MSI target address
> > +	 * has to be reserved within the lowest 4GB.
> > +	 * Note until there is a better alternative found the reservation is
> > +	 * done by allocating from the artificially limited DMA-coherent
> > +	 * memory.
> > +	 */
> > +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> 

> We used to restrict both streaming and coherent DMA masks to 32 bits.
> Now we will only restrict coherent DMA to 32 bits.
> 
> So in essence this change removes a restriction on the streaming DMA
> mask, right?

Right.

> 
> And I guess bt1 is the only driver where this will make a difference
> (after the next patch) because no other dwc drivers set their own DMA
> masks?

Right. But that's only because I am sure the Baikal-T1 PCIe eDMA
engine is able to reach memory above 4GB limits. If you know any other
DW PCIe RP/EP controller with eDMA-capability and which can work with
the memory space wider than 4GB then you can update it' streaming
DMA-mask too. Note lacking to do so doesn't mean the eDMA-engine
driver won't work for them. The eDMA-engine will be forced to work
with the lowest 4GB space to which the upper memory will be mapped via
SWIOTLB.

-Serge(y)

> 
> >  	if (ret)
> >  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> >  
> > -- 
> > 2.39.0
> > 
> > 
