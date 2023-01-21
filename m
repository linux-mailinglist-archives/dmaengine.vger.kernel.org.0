Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F21676968
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jan 2023 21:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjAUUh7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 Jan 2023 15:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjAUUhJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 Jan 2023 15:37:09 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0295829169;
        Sat, 21 Jan 2023 12:37:08 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id y19so9214257ljq.7;
        Sat, 21 Jan 2023 12:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihJfB+Lf1iGGfjeNkVhjPxgKB7bbF/bseUfIXl+wRaE=;
        b=Kk1JkvpQyNnJS9bZf7wSi1XxHXKMQ3JvdclliEDrqHDYlLUSfY5Dmnja26zDyVYkih
         jyqrlxPXjymT6I1a789KvMJ7RUWEmIG6+21Lc0soodE7TgfsATlOW2ZxLpoJa+MuR1NM
         khvez59Ooz44gBQ/JQoox1k03h/+wvFR+iA5aSGAl/EQ6hTtmzyurZbWwWl+71OzhQM9
         aVEnrwtbCf1AD/Igqs1/Ik7CZ0Me5aMxhBsO1G/6zhwtXTQtIEseIW9uy2UXSzInkwQv
         81NLmMk+PvyNJRKcOElfPVRj3FhXiaxqTJtrzuU6mmhkWYM5O9N6QWRQFlQ2XmVym8Dr
         LLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihJfB+Lf1iGGfjeNkVhjPxgKB7bbF/bseUfIXl+wRaE=;
        b=Vb1L2IbU5xY5TeT2AkqNV/r/0SMu3RPNy5LMpVITL1DEHBD7djPo3BbEoP+6dTWfl2
         wiU5WyDOVgDK2m4HiDnuYD2JMcqx3xEIFzf+WAqywH4GHAzo17QnXloRupTsYnWwQLuR
         wngvm2961VCUMS8OtWMY8/f8X/1xRixkFgWhcH1FPpiky5pUMD2ADGAWBDhLiIi7d4GZ
         VWWIIMzDi1BJrEcI832H/Kjfsb6c2eqnwbgg0tVxj8O0/3EMx2rOkslJ/j1J/YUWvIXo
         ZPdYMOKLzKbALY3n4LHnoS1mPIaXgI+AtAfcv/p+zWWCLzCDIt715sfWbBj7LFcLB3Bc
         vT6A==
X-Gm-Message-State: AFqh2kr5GbCjgC3phWL6c+YWotrK7nIN8rb7AfX8vmG7OXmpYstPLDL3
        hY2UMIWAErdFxapswUd7QxY=
X-Google-Smtp-Source: AMrXdXvYtwyWQvF7hiBYUmHLUkZauE9mP5agHJ35VPA0BvuutM+GCxV1mMCCec2qVDfKpo+MJLv0hQ==
X-Received: by 2002:a2e:6a02:0:b0:285:f6b9:f16c with SMTP id f2-20020a2e6a02000000b00285f6b9f16cmr4699729ljc.2.1674333426168;
        Sat, 21 Jan 2023 12:37:06 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id bd2-20020a05651c168200b0028b796bb9basm2244920ljb.93.2023.01.21.12.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:37:05 -0800 (PST)
Date:   Sat, 21 Jan 2023 23:37:02 +0300
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
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 08/27] dmaengine: dw-edma: Add PCIe bus address getter
 to the remote EP glue-driver
Message-ID: <20230121203702.kgo7rdeiu7pvwh2b@mobilestation>
References: <20230113171409.30470-9-Sergey.Semin@baikalelectronics.ru>
 <20230120232920.GA681120@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120232920.GA681120@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 20, 2023 at 05:29:20PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 13, 2023 at 08:13:50PM +0300, Serge Semin wrote:
> > In general the Synopsys PCIe EndPoint IP prototype kit can be attached to
> > a PCIe bus with any PCIe Host controller including to the one with
> > distinctive from CPU address space. Due to that we need to make sure that
> > the source and destination addresses of the DMA-slave devices are properly
> > converted to the PCIe bus address space, otherwise the DMA transaction
> > will not only work as expected, but may cause the memory corruption with
> > subsequent system crash. Let's do that by introducing a new
> > dw_edma_pcie_address() method defined in the dw-edma-pcie.c, which will
> > perform the denoted translation by using the pcibios_resource_to_bus()
> > method.
> > 
> > Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> > 
> > ---
> > 
> > Note this patch depends on the patch "dmaengine: dw-edma: Add CPU to PCIe
> > bus address translation" from this series.
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 04c95cba1244..f530bacfd716 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -95,8 +95,23 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
> >  	return pci_irq_vector(to_pci_dev(dev), nr);
> >  }
> >  
> > +static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct pci_bus_region region;
> > +	struct resource res = {
> > +		.flags = IORESOURCE_MEM,
> > +		.start = cpu_addr,
> > +		.end = cpu_addr,
> > +	};
> > +
> > +	pcibios_resource_to_bus(pdev->bus, &region, &res);
> > +	return region.start;
> > +}
> 

> This doesn't look DW-specific.  Do you expect other implementations
> that are specific, or could this be a generic function that shares
> some implementation with pci_bus_address()?

I have doubts any other implementation would need such method of the
address translation. It's specific to the remote DW eDMA setup (DW
eDMA embedded into a PCIe end-point and accessed from a PCIe
host-side), which support is implemented in the
drivers/dma/dw-edma/dw-edma-pcie.c driver and it doesn't seem to be a
widespread type of devices anyway. The only known case is the Synopsys
PCIe EndPoint IP prototype kit mentioned in the initial DW eDMA driver
commit.

In case of the local DW eDMA setup (DW eDMA embedded into the DW PCIe
Root Port/Complex/End-point controllers and accessible via the
CPU-side of the controllers) the CPU->PCIe address translation is
performed by the outbound iATU engine if the DMA_BYPASS flag is
cleared in the outbound iATU windows control register. The
__dw_pcie_prog_outbound_atu() function (see pcie-designware.c) doesn't
set that flag. That's why we can freely omit the
dw_edma_core_ops.pci_address callback.

On the other hand the DW PCIe controller can have a customized ATU
(see dw_pcie_rp.bridge->child_ops can be pre-initialized by the DW
PCIe low-level drivers). In that case I can't predict of how the eDMA
engine would work. It can be as much similar to the iATU
DMA_BYPASS-flag-less case or work on the vendor-specific basis. It's
up to LLDD to implement the proper dw_edma_core_ops.pci_address
callback then.

-Serge(y)

> 
> >  static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
> >  	.irq_vector = dw_edma_pcie_irq_vector,
> > +	.pci_address = dw_edma_pcie_address,
> >  };
> >  
> >  static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > -- 
> > 2.39.0
> > 
> > 
