Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24762515189
	for <lists+dmaengine@lfdr.de>; Fri, 29 Apr 2022 19:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379497AbiD2RXd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Apr 2022 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379494AbiD2RXc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Apr 2022 13:23:32 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99ED1B7B0
        for <dmaengine@vger.kernel.org>; Fri, 29 Apr 2022 10:20:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u9so7070720plf.6
        for <dmaengine@vger.kernel.org>; Fri, 29 Apr 2022 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a4Vg7xj5Oz0RqrtTAOpFC6SZhiV9hbA9Db0FqNGKSfo=;
        b=QmvdEjpZzZTCrJbvbO7i8sq/xCzMCL9QUUJqkc+omAQmFZG84ChfZ3Bk7gg/5STixL
         HDeG41+zs5VsWneYJYBGd1S91tGhNW0zpCYgrQ8rofqec67OiSzDLf/zVkzAZuDuzZGp
         RRbsQG6e07m9WqKyIsGgKMqJa95ZzVpTb58KWzCaeyZ9+JdQ7xWUpZiGhrhdIaf9QCmO
         Eb0beCY/wWk5pJxSh0bi5nZwM4ikJR4FGECjiJ46c538dvRSFdyjEjLHbiONRXMe6ZEc
         BZTDbDoVhLKix9b7MPIdB7Xusqy07FE2Qa9QhNGeNS2psqqC9yQuHuVDUcci1ldKNAb6
         FJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a4Vg7xj5Oz0RqrtTAOpFC6SZhiV9hbA9Db0FqNGKSfo=;
        b=bpw5ImwsndrckZJy/0E5rq7VU8R8zpR5eixGyrwoK4iC0gx/gJN17DH3lycgCEKLN4
         K/t2M5RTh1mQgP6abIlfz1yuIK5QnDFUNJxgrxUuUhFdTbAUyoJP+8O3QgOv2ncHuB0o
         IbRIsSC+Ka2aTeEaCXrq9u04YY1SagUUxcWnM/a2V2m2EP4XYDvkIfJpTZPUxxAY+J0L
         msayHKQOBn+od+lAIP9m9oxb6K0U2JOVI1bI9N3LenCG216JnJV/5Ak6mjtbP+hisZ4P
         lrwwZK5Fd/Gmf8ey7tM6BpzdddAMdKJJDyCjzYiShBJxAtEmwx4+NaewjCgGMxNFLJRM
         eStQ==
X-Gm-Message-State: AOAM532c3ebIWypl7wosGJ9gmAbhMpzXTkcJ9NeGk0aXRkI8rxCMi3An
        qVi5OY4J4ABtz/CYhMleOliq
X-Google-Smtp-Source: ABdhPJzedkPH2Wi/LHIEUZcCNdwZ3tG0YmgzAVROnWHQlXBE07AAFx5rSIvrUkOuZgEqpfq/+lMp8g==
X-Received: by 2002:a17:902:d484:b0:15e:7aa9:babc with SMTP id c4-20020a170902d48400b0015e7aa9babcmr458383plg.38.1651252812325;
        Fri, 29 Apr 2022 10:20:12 -0700 (PDT)
Received: from thinkpad ([59.92.96.47])
        by smtp.gmail.com with ESMTPSA id nm5-20020a17090b19c500b001cb978f906esm10849999pjb.0.2022.04.29.10.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 10:20:11 -0700 (PDT)
Date:   Fri, 29 Apr 2022 22:50:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
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
Message-ID: <20220429172004.GA12006@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-26-Sergey.Semin@baikalelectronics.ru>
 <20220328141521.GA17663@thinkpad>
 <20220419205403.hdtp67mwoyrl6b6q@mobilestation>
 <20220423144055.GR374560@thinkpad>
 <20220428140501.6geybgwvkevqaz7e@mobilestation.baikal.int>
 <20220428170929.GC81644@thinkpad>
 <20220429161348.zfjogvb3uxs3fxzp@mobilestation.baikal.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429161348.zfjogvb3uxs3fxzp@mobilestation.baikal.int>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 29, 2022 at 07:13:48PM +0300, Serge Semin wrote:
> On Thu, Apr 28, 2022 at 10:39:29PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Apr 28, 2022 at 05:05:23PM +0300, Serge Semin wrote:
> > 
> > [...]
> > 
> > > > If iATU has unroll enabled then I think we can assume that edma will also be
> > > > the same. So I was wondering if we could just depend on iatu_unroll_enabled
> > > > here.
> > > 
> > > I thought about that, but then I decided it was easier to just define
> > > a new flag. Anyway according to the hw manuals indeed the unroll
> > > mapping is enabled either for both iATU and eDMA modules or for none
> > > of them just because they are mapped over a single space. It's
> > > determined by the internal VHL parameter CC_UNROLL_ENABLE.
> > > On the second thought I agree with you then. I'll convert the
> > > iatu_unroll_enabled flag into a more generic 'reg_unroll' and make
> > > sure it's used for both modules.
> > > 
> > 
> > Sounds good!
> > 
> > > > 
> > > > > > 
> > > > > > > +	if (pci->edma_unroll_enabled && pci->iatu_unroll_enabled) {
> > > > > > > +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > > > > > > +		if (pci->atu_base != pci->dbi_base + DEFAULT_DBI_ATU_OFFSET)
> > > > > > > +			pci->edma.reg_base = pci->atu_base + PCIE_DMA_UNROLL_BASE;
> > > > > > > +		else
> > > > > > > +			pci->edma.reg_base = pci->dbi_base + DEFAULT_DBI_DMA_OFFSET;
> > > > > > 
> > > > > 
> > > > > > This assumption won't work on all platforms. Atleast on our platform, the
> > > > > > offsets vary. So I'd suggest to try getting the reg_base from DT first and use
> > > > > > these offsets as a fallback as we do for iATU.
> > > > > 
> > > > > I don't know how the eDMA offset can vary at least concerning the
> > > > > normal DW PCIe setup. In any case the DW eDMA controller CSRs are
> > > > > mapped in the same way as the iATU space: CS2=1 CDM=1. They are either
> > > > > created as an unrolled region mapped into the particular MMIO space
> > > > > (as a separate MMIO space or as a part of the DBI space), or
> > > > > accessible over the PL viewports (as a part of the Port Logic CSRs).
> > > > > Nothing else is described in the hardware manuals. Based on that I
> > > > > don't see a reason to add one more reg space binding.
> > > > > 
> > > > 
> > > 
> > > > This is not true. Vendors can customize the iATU location inside DBI region
> > > > for unroll too. That's one of the reason why dw_pcie_iatu_detect() works on
> > > > qcom platforms as it tries to get iatu address from DT first and then falls
> > > > back to the default offset if not found.
> > > > 
> > > > So please define an additional DT region for edma.
> > > 
> > > It's obvious that iATU location can vary. I never said it didn't. We
> > > are talking about eDMA here. In accordance with what the DW PCIe hw
> > > manuals say eDMA always resides the same space as the iATU. The space
> > > is enabled by setting the CS2=1 and CDM=1 wires in case of the Native
> > > Controller DBI access. In this case eDMA is defined with the 0x80000
> > > offset over the iATU base address while the iATU base can be placed at
> > > whatever region platform engineer needs.
> > > 
> > > Alternatively the AXI Bridge-based DBI access can be enabled thus
> > > having the DBI+iATU+eDMA mapped over the same MMIO space with
> > > respective offsets 0x0;0x300000;0x380000. This case is handled in the
> > > branch of the conditional statement above if it's found that iATU base
> > > is having the default offset with respect to the DBI base address
> > > (pci->atu_base == pci->dbi_base + DEFAULT_DBI_ATU_OFFSET).
> > > 
> > > To sum up seeing I couldn't find the eDMA region defined in the qcom
> > > bindings and judging by what you say doesn't really contradict to what
> > > is done in my code, I guess there must be some misunderstanding either in
> > > what you see in the code above or what I understand from what you say.
> > > So please be more specific what offsets and whether they are really
> > > different from what I use in the code above.
> > > 
> > 
> > You won't see any edma register offset because no one bothered to define it
> > since it was not used until now. But the memory region should've been
> > documented...
> > 
> 
> > Anyway, here is the offset for the Qcom SoC I'm currently working on:
> > 
> > DBI  - 0x0
> > iATU - 0x1000
> > eDMA - 0x2000
> 
> Finally we've got to something. Earlier you said:
> 
> > > > This is not true. Vendors can customize the iATU location inside DBI region
> > > > for unroll too.
> 
> Actually it is if we are talking about the standard Syopsys DW PCIe
> IP-CoreConsultant methods, which don't imply any eDMA base address
> customization parameter. Thus there must be some address translation
> performed at some layer before the address reaches the DW PCIe DBI
> interface. So it's platform-specific. That happens in your case too.
> 

Seems like it.

> > > > That's one of the reason why dw_pcie_iatu_detect() works on
> > > > qcom platforms as it tries to get iatu address from DT first and then falls
> > > > back to the default offset if not found.
> > 
> > As you can see, these offsets doesn't really fit in both the cases you shared
> > above.
> 
> Seeing the iATU address bits layout can be changed the next
> reg-space calculation code shall work for all the discussed cases:
> 
> if (!unroll) {
> 	pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> } else if (!pci->edma.reg_base) {
> 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
> 	if (res) {
> 		pci->edma.reg_base = devm_ioremap_resource(dev, res);
> 		if (IS_ERR(pci->edma.reg_base))
> 			return PTR_ERR(pci->edma.reg_base);

This should work for me. Thanks for the work!

Regards,
Mani

> 	} else (pci->atu_size >= 2 * 0x80000) {
> 		pci->edma.reg_base = pci->atu_base + 0x80000;
> 	} else {
> 		/* No standard eDMA CSRs mapping found. Just skip */
> 		return 0;
> 	}
> } else {
> 	/* pci->edma.reg_base can be specified by the platform code. This shall
> 	 * be useful for the tegra194 or intel gw SoCs. The former
> 	 * platform has the "atu_dma" resource declared which implies
> 	 * having the joint iATU+eDMA CSR space, while the later has
> 	 * specific iATU offset with respect to the DBI base address
> 	 * (address is two bits shorter).
> 	 */
> }
> 
> -Sergey
> 
> > 
> > I don't have the knowledge about the internal representation of the IP or what
> > customization Qcom did apart from some high level information.
> > 
> > Hope this clarifies!
> > 
> > Thanks,
> > Mani
