Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E93F513641
	for <lists+dmaengine@lfdr.de>; Thu, 28 Apr 2022 16:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiD1OJJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Apr 2022 10:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348207AbiD1OIv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Apr 2022 10:08:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961AB714A;
        Thu, 28 Apr 2022 07:05:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id n14so8788579lfu.13;
        Thu, 28 Apr 2022 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/4p5s7yMwFYlej8gvLAFRA9Z7s2HhXHRztZsBkvwoQM=;
        b=DXGP+lp7TNUpqyBvBXz9szqWmhlk0jImYKSumhijwIdcS3/CUYuc+BSDy5JSYj6rV8
         rdeLS1RnFLNKJZF1Z7ui9FzsZmoQ2qEWwm0hWnnvWno0V38r7otsvhLFp1YCOSpTp3D9
         f8jniHe3XHKL0OjX5XkzuJZbyVXoT/IhvQ23nKj0cllFBFG6sr9OJw2VYZQgJVPrnvO5
         a/xzWzD1dumF6rQPkbi3ovWBUBHeDmnUUlgqy+XAvm5NGDoHVt5iEqZ0MvHSDmSaeiIQ
         wq0+KzSxcz+l2sTfAVd18BxKRhy99pV4J2yd8ZqHLZXRU/5VYOnQDAAPeenFoGqSxXAa
         HPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/4p5s7yMwFYlej8gvLAFRA9Z7s2HhXHRztZsBkvwoQM=;
        b=xj4GU9hWOCv+6h5sgPa97BbGvoAGyVmRm6XkgSo5V8eYN/HziNy7xX03qpFzmSQ/J/
         hmIQ4brjfPoAhoKe0VIJXuwLZR5ki12KxX2iLUl6dmzHUsBoTTM9T46aGivJWEH6Gmbk
         f7tuNCjJZfWZMCmS0p2r1iD0XYzd+QHDFkVn8txO9Sm7HzxlGRyCGgHuWDoxhKtGsdH6
         sGTwZVRRBnwUZzcTQJ/GMoywBd9tqyMYUTvQnA/w5oDKUSPwzRIQqw6NZ1WQREkrGyfs
         kp/wnxkrd9dCDJNJPBnV4fksFeWVBosaqjHlD0vo6xQW2RcGnn/6oR7NgItJXt37U9JY
         9r1g==
X-Gm-Message-State: AOAM530t7UTiKC/ND+NNFbfFwZfpSKzbZ4xnIn5vTkIlWdum3szkOv/n
        pqwMR4H0b8AWn0x9ZHYIJnk=
X-Google-Smtp-Source: ABdhPJzgU+R53k1UpBkNIUdemKmMYK7wT9/zI6XDHXlHWnVexZtln9F7c1NKCGGlAtFjwa8b5IXXSg==
X-Received: by 2002:a05:6512:3d06:b0:472:3a24:7e78 with SMTP id d6-20020a0565123d0600b004723a247e78mr2329890lfv.468.1651154726277;
        Thu, 28 Apr 2022 07:05:26 -0700 (PDT)
Received: from mobilestation.baikal.int (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id p12-20020a056512138c00b0044833f1cd85sm12706lfa.62.2022.04.28.07.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:05:25 -0700 (PDT)
Date:   Thu, 28 Apr 2022 17:05:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/25] PCI: dwc: Add DW eDMA engine support
Message-ID: <20220428140501.6geybgwvkevqaz7e@mobilestation.baikal.int>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-26-Sergey.Semin@baikalelectronics.ru>
 <20220328141521.GA17663@thinkpad>
 <20220419205403.hdtp67mwoyrl6b6q@mobilestation>
 <20220423144055.GR374560@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423144055.GR374560@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Apr 23, 2022 at 08:10:55PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 19, 2022 at 11:54:03PM +0300, Serge Semin wrote:
> > On Mon, Mar 28, 2022 at 07:45:21PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Mar 24, 2022 at 04:48:36AM +0300, Serge Semin wrote:
> > > > Since the DW eDMA driver now supports eDMA controllers embedded into the
> > > > locally accessible DW PCIe Root Ports and End-points, we can use the
> > > > updated interface to register DW eDMA as DMA engine device if it's
> > > > available. In order to successfully do that the DW PCIe core driver need
> > > > to perform some preparations first. First of all it needs to find out the
> > > > eDMA controller CSRs base address, whether they are accessible over the
> > > > Port Logic or iATU unrolled space. Afterwards it can try to auto-detect
> > > > the eDMA controller availability and number of it's read/write channels.
> > > > If none was found the procedure will just silently halt with no error
> > > > returned. Secondly the platform is supposed to provide either combined or
> > > > per-channel IRQ signals. If no valid IRQs set is found the procedure will
> > > > also halt with no error returned so to be backward compatible with
> > > > platforms where DW PCIe controllers have eDMA embedded but lack of the
> > > > IRQs defined for them. Finally before actually probing the eDMA device we
> > > > need to allocate LLP items buffers. After that the DW eDMA can be
> > > > registered. If registration is successful the info-message regarding the
> > > > number of detected Read/Write eDMA channels will be printed to the system
> > > > log in the same way as it's done for iATU settings.
> > > > 
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > ---
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   |   4 +
> > > >  .../pci/controller/dwc/pcie-designware-host.c |  13 +-
> > > >  drivers/pci/controller/dwc/pcie-designware.c  | 188 ++++++++++++++++++
> > > >  drivers/pci/controller/dwc/pcie-designware.h  |  23 ++-
> > > >  4 files changed, 225 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 23401f17e8f0..b2840d1a5b9a 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -712,6 +712,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  
> > > >  	dw_pcie_iatu_detect(pci);
> > > >  
> > > > +	ret = dw_pcie_edma_detect(pci);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> > > >  	if (!res)
> > > >  		return -EINVAL;
> > > 
> > 
> > > eDMA needs to be removed on error path
> > 
> > So does the EPC memory... The dw_pcie_ep_init() and the code using it
> > are broken in the cleanup part. Neither the platform drivers nor the
> > method itself de-allocate the epc memory on any further error. See,
> 
> Right.
> 
> > the dw_pcie_ep_exit() function isn't called by any glue driver, while
> > some of them do have the device remove method implemented. I
> > am not going to fix the platform drivers (though the devm_add_action()
> > method could be used for that in a least painful fix) due to lacking
> > of an EP device to test it out. But since you are asking to revert
> > the eDMA initialization in case of the EP init failure I'll add the
> > cleanup-on-error path to the dw_pcie_ep_init() method. But it will be
> > done in v2 of the "PCI: dwc: Various fixes and cleanups" series.
> > 
> 
> That's fine, thanks.
> 
> > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 715a13b90e43..048b452ee4f3 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -405,14 +405,18 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > > >  
> > > >  	dw_pcie_iatu_detect(pci);
> > > >  
> > > > -	ret = dw_pcie_setup_rc(pp);
> > > > +	ret = dw_pcie_edma_detect(pci);
> > > >  	if (ret)
> > > >  		goto err_free_msi;
> > > >  
> > > > +	ret = dw_pcie_setup_rc(pp);
> > > > +	if (ret)
> > > > +		goto err_edma_remove;
> > > > +
> > > >  	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
> > > >  		ret = pci->ops->start_link(pci);
> > > >  		if (ret)
> > > > -			goto err_free_msi;
> > > > +			goto err_edma_remove;
> > > >  	}
> > > >  
> > > >  	/* Ignore errors, the link may come up later */
> > > > @@ -430,6 +434,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > > >  	if (pci->ops && pci->ops->stop_link)
> > > >  		pci->ops->stop_link(pci);
> > > >  
> > > > +err_edma_remove:
> > > > +	dw_pcie_edma_remove(pci);
> > > > +
> > > >  err_free_msi:
> > > >  	if (pp->has_msi_ctrl)
> > > >  		dw_pcie_free_msi(pp);
> > > > @@ -452,6 +459,8 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
> > > >  	if (pci->ops && pci->ops->stop_link)
> > > >  		pci->ops->stop_link(pci);
> > > >  
> > > > +	dw_pcie_edma_remove(pci);
> > > > +
> > > >  	if (pp->has_msi_ctrl)
> > > >  		dw_pcie_free_msi(pp);
> > > >  
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 4a95a7b112e9..dbe39a7ecb71 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > 
> > > [...]
> > > 
> > > > +int dw_pcie_edma_detect(struct dw_pcie *pci)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	pci->edma.dev = pci->dev;
> > > > +	if (!pci->edma.ops)
> > > > +		pci->edma.ops = &dw_pcie_edma_ops;
> > > > +	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> > > > +
> > 
> > > > +	pci->edma_unroll_enabled = dw_pcie_edma_unroll_enabled(pci);
> > > 
> > > Is is possible to continue the unroll path for eDMA if iATU unroll is enabled?
> > 
> > Don't get it. Could you elaborate your question in more details?
> > Are you talking about using the same flag for both eDMA and iATU
> > unrolled space? If so then most likely yes. But in that case the
> > iatu_unroll_enabled flag name and semantics need to be changed.
> > 
> 

> If iATU has unroll enabled then I think we can assume that edma will also be
> the same. So I was wondering if we could just depend on iatu_unroll_enabled
> here.

I thought about that, but then I decided it was easier to just define
a new flag. Anyway according to the hw manuals indeed the unroll
mapping is enabled either for both iATU and eDMA modules or for none
of them just because they are mapped over a single space. It's
determined by the internal VHL parameter CC_UNROLL_ENABLE.
On the second thought I agree with you then. I'll convert the
iatu_unroll_enabled flag into a more generic 'reg_unroll' and make
sure it's used for both modules.

> 
> > > 
> > > > +	if (pci->edma_unroll_enabled && pci->iatu_unroll_enabled) {
> > > > +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > > > +		if (pci->atu_base != pci->dbi_base + DEFAULT_DBI_ATU_OFFSET)
> > > > +			pci->edma.reg_base = pci->atu_base + PCIE_DMA_UNROLL_BASE;
> > > > +		else
> > > > +			pci->edma.reg_base = pci->dbi_base + DEFAULT_DBI_DMA_OFFSET;
> > > 
> > 
> > > This assumption won't work on all platforms. Atleast on our platform, the
> > > offsets vary. So I'd suggest to try getting the reg_base from DT first and use
> > > these offsets as a fallback as we do for iATU.
> > 
> > I don't know how the eDMA offset can vary at least concerning the
> > normal DW PCIe setup. In any case the DW eDMA controller CSRs are
> > mapped in the same way as the iATU space: CS2=1 CDM=1. They are either
> > created as an unrolled region mapped into the particular MMIO space
> > (as a separate MMIO space or as a part of the DBI space), or
> > accessible over the PL viewports (as a part of the Port Logic CSRs).
> > Nothing else is described in the hardware manuals. Based on that I
> > don't see a reason to add one more reg space binding.
> > 
> 

> This is not true. Vendors can customize the iATU location inside DBI region
> for unroll too. That's one of the reason why dw_pcie_iatu_detect() works on
> qcom platforms as it tries to get iatu address from DT first and then falls
> back to the default offset if not found.
> 
> So please define an additional DT region for edma.

It's obvious that iATU location can vary. I never said it didn't. We
are talking about eDMA here. In accordance with what the DW PCIe hw
manuals say eDMA always resides the same space as the iATU. The space
is enabled by setting the CS2=1 and CDM=1 wires in case of the Native
Controller DBI access. In this case eDMA is defined with the 0x80000
offset over the iATU base address while the iATU base can be placed at
whatever region platform engineer needs.

Alternatively the AXI Bridge-based DBI access can be enabled thus
having the DBI+iATU+eDMA mapped over the same MMIO space with
respective offsets 0x0;0x300000;0x380000. This case is handled in the
branch of the conditional statement above if it's found that iATU base
is having the default offset with respect to the DBI base address
(pci->atu_base == pci->dbi_base + DEFAULT_DBI_ATU_OFFSET).

To sum up seeing I couldn't find the eDMA region defined in the qcom
bindings and judging by what you say doesn't really contradict to what
is done in my code, I guess there must be some misunderstanding either in
what you see in the code above or what I understand from what you say.
So please be more specific what offsets and whether they are really
different from what I use in the code above.

What I can suggest to modify in my solution is:
1) Make sure that the iATU/eDMA space fits the range
[atu_base; atu_base + atu_size]. If it doesn't just return an error.
2) Just realised that
DEFAULT_DBI_DMA_OFFSET = DEFAULT_DBI_ATU_OFFSET + PCIE_DMA_UNROLL_BASE,
so my conditional statement in the subject can be dropped thus
having the eDMA CSRs base address calculated as:
pci->edma.reg_base = pci->atu_base + PCIE_DMA_UNROLL_BASE;

-Sergey

> 
> > > 
> > > > +	} else {
> > > > +		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> > > > +		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> > > > +	}
> > > > +
> > > > +	ret = dw_pcie_edma_detect_channels(pci);
> > > > +	if (ret) {
> > > > +		dev_err(pci->dev, "Unexpected NoF eDMA channels found\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	/* Skip any further initialization if no eDMA found */
> > > 
> > 
> > > Should we introduce a new Kconfig option for enabling eDMA? My concern here is,
> > > if eDMA is really needed for an usecase and if the platform support is broken
> > > somehow (DT issues?), then we'll just simply go ahead without probe failure and
> > > it may break somewhere else.
> > > 
> > > And we are returning errors if something wrong happens during eDMA probe. This
> > > might annoy the existing users who don't care about eDMA but turning those
> > > errors to debug will affect the real users of eDMA.
> > > 
> > > For these reasons, I think it'd be better to probe eDMA only if the Kconfig
> > > option is enabled (which would be disabled by default). And properly return the
> > > failure.
> > 
> > I don't see a need in introducing of a new parametrization. Neither
> > there is a point in dropping the eDMA support on all the platforms for
> > the sake of some hypothetically malfunction hardware.
> 
> I'm not talking about "hypothetically malfunction hardware" but real customized
> ones like all Qcom platforms supporting PCIe. As I said in my previous comment,
> the default eDMA offset won't work on Qcom platforms. So if this driver tries
> to access the registers based on the default offset, it may result in SMMU
> errors. The edma region needs to be defined in DT for probing edma correctly.
> 
> But even if we add dt support for edma and probe edma unconditionally, we'd be
> breaking the dts compatibility with older ones that don't define it.
> 
> > Regarding the
> > config, the DW eDMA driver already has one. It's CONFIG_DW_EDMA which
> > can be used for what you say. Though I need to fix this patch a bit so
> > the -ENODEV errno returned from the dw_edma_probe() method would be
> > ignored in the dw_pcie_edma_detect() procedure to support the case of
> > the disabled DW eDMA driver.
> > 
> 
> Please do so.
> 
> Thanks,
> Mani
> 
> > -Sergey
> > 
> > > 
> > > Thanks,
> > > Mani
