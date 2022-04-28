Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB394513AA5
	for <lists+dmaengine@lfdr.de>; Thu, 28 Apr 2022 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiD1RMx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Apr 2022 13:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiD1RMw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Apr 2022 13:12:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FDCB82CA
        for <dmaengine@vger.kernel.org>; Thu, 28 Apr 2022 10:09:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x12so4487988pgj.7
        for <dmaengine@vger.kernel.org>; Thu, 28 Apr 2022 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fBDyiC8ejx38/XGCdInTXi7p0RF0GjbjfMkRMdvSGv0=;
        b=PkwH6hgXz4MEQ6AJYKtgR6JdFn8khlfOomPptOtAb4gKvnZVbyITWFLj18HBDE/jVq
         V52Y2WTHH+Mlon2KaabpIWE26PVgruOF7iMHzxKPxm04JREeCkFaFvsLGw8n02fmKDjZ
         jBD/fLoL1Haf8fcxb2iA+AcqU3ztg6rPCAFvccJkcIfUESAAgOglJ8SSPGiyM9GwYclN
         MVuJ9xQujbAgag0ghXdfMxWFU3vpQ5qXhSaQIz6A34VxadwhAlLt0ey9YQrTOyvsDkqT
         e5ovy538EjH3oNSYBO35UeP82w4JaRIv/rUgEPPUkNpfXcOqGo4e8PbEFsMyVxtWrrOn
         KPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fBDyiC8ejx38/XGCdInTXi7p0RF0GjbjfMkRMdvSGv0=;
        b=F9rc8/DRKg7AgcTsFzhbqB5qDWrhgU3U/fqHAv6FW986b69AfTPz+jopz/AMrYKA6F
         7oiaR/ikz921dN0oseKHU+HHq8ZvjIvUryGGsUxSTOIwWxEIJKN3KmPm9P41UFkspExC
         yBXtxcR4IsVm/HJJeGvzCCJkMrll/rveLrpMljr5TYPNQ8DQN3/UH68wDQCL4sQI3ycl
         gJ4A8UbUwL4Gjo+gmyRScphHtENHipev84DAoWz6yh9FdZVq+MuJATb7Os00w73OGOfK
         Xo22WHbiu1RHw5A8x6nVtrIyadEl41XqQdr2a8bfeGHKwkhn/icv61diyt19IukoMqvn
         Y9+Q==
X-Gm-Message-State: AOAM5327N1zdmRzhF2TrJhysaWWRgbXA9O//p0WXg0VLuHQXucF/oXr8
        3z5rkmgx/oR6+LByUAo3I8yX
X-Google-Smtp-Source: ABdhPJxJ1Bxs03N1VpCNGCBPDVOJJta4JTsZ6CuaLJFmn8qQJEEPihJ4pXGGAzycImcb+yUjHIiQZw==
X-Received: by 2002:aa7:9085:0:b0:50d:35ae:271 with SMTP id i5-20020aa79085000000b0050d35ae0271mr24736247pfa.42.1651165775932;
        Thu, 28 Apr 2022 10:09:35 -0700 (PDT)
Received: from thinkpad ([220.158.158.235])
        by smtp.gmail.com with ESMTPSA id b22-20020a63cf56000000b003c1a1f44736sm320918pgj.90.2022.04.28.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 10:09:35 -0700 (PDT)
Date:   Thu, 28 Apr 2022 22:39:29 +0530
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
Message-ID: <20220428170929.GC81644@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-26-Sergey.Semin@baikalelectronics.ru>
 <20220328141521.GA17663@thinkpad>
 <20220419205403.hdtp67mwoyrl6b6q@mobilestation>
 <20220423144055.GR374560@thinkpad>
 <20220428140501.6geybgwvkevqaz7e@mobilestation.baikal.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428140501.6geybgwvkevqaz7e@mobilestation.baikal.int>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 28, 2022 at 05:05:23PM +0300, Serge Semin wrote:

[...]

> > If iATU has unroll enabled then I think we can assume that edma will also be
> > the same. So I was wondering if we could just depend on iatu_unroll_enabled
> > here.
> 
> I thought about that, but then I decided it was easier to just define
> a new flag. Anyway according to the hw manuals indeed the unroll
> mapping is enabled either for both iATU and eDMA modules or for none
> of them just because they are mapped over a single space. It's
> determined by the internal VHL parameter CC_UNROLL_ENABLE.
> On the second thought I agree with you then. I'll convert the
> iatu_unroll_enabled flag into a more generic 'reg_unroll' and make
> sure it's used for both modules.
> 

Sounds good!

> > 
> > > > 
> > > > > +	if (pci->edma_unroll_enabled && pci->iatu_unroll_enabled) {
> > > > > +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > > > > +		if (pci->atu_base != pci->dbi_base + DEFAULT_DBI_ATU_OFFSET)
> > > > > +			pci->edma.reg_base = pci->atu_base + PCIE_DMA_UNROLL_BASE;
> > > > > +		else
> > > > > +			pci->edma.reg_base = pci->dbi_base + DEFAULT_DBI_DMA_OFFSET;
> > > > 
> > > 
> > > > This assumption won't work on all platforms. Atleast on our platform, the
> > > > offsets vary. So I'd suggest to try getting the reg_base from DT first and use
> > > > these offsets as a fallback as we do for iATU.
> > > 
> > > I don't know how the eDMA offset can vary at least concerning the
> > > normal DW PCIe setup. In any case the DW eDMA controller CSRs are
> > > mapped in the same way as the iATU space: CS2=1 CDM=1. They are either
> > > created as an unrolled region mapped into the particular MMIO space
> > > (as a separate MMIO space or as a part of the DBI space), or
> > > accessible over the PL viewports (as a part of the Port Logic CSRs).
> > > Nothing else is described in the hardware manuals. Based on that I
> > > don't see a reason to add one more reg space binding.
> > > 
> > 
> 
> > This is not true. Vendors can customize the iATU location inside DBI region
> > for unroll too. That's one of the reason why dw_pcie_iatu_detect() works on
> > qcom platforms as it tries to get iatu address from DT first and then falls
> > back to the default offset if not found.
> > 
> > So please define an additional DT region for edma.
> 
> It's obvious that iATU location can vary. I never said it didn't. We
> are talking about eDMA here. In accordance with what the DW PCIe hw
> manuals say eDMA always resides the same space as the iATU. The space
> is enabled by setting the CS2=1 and CDM=1 wires in case of the Native
> Controller DBI access. In this case eDMA is defined with the 0x80000
> offset over the iATU base address while the iATU base can be placed at
> whatever region platform engineer needs.
> 
> Alternatively the AXI Bridge-based DBI access can be enabled thus
> having the DBI+iATU+eDMA mapped over the same MMIO space with
> respective offsets 0x0;0x300000;0x380000. This case is handled in the
> branch of the conditional statement above if it's found that iATU base
> is having the default offset with respect to the DBI base address
> (pci->atu_base == pci->dbi_base + DEFAULT_DBI_ATU_OFFSET).
> 
> To sum up seeing I couldn't find the eDMA region defined in the qcom
> bindings and judging by what you say doesn't really contradict to what
> is done in my code, I guess there must be some misunderstanding either in
> what you see in the code above or what I understand from what you say.
> So please be more specific what offsets and whether they are really
> different from what I use in the code above.
> 

You won't see any edma register offset because no one bothered to define it
since it was not used until now. But the memory region should've been
documented...

Anyway, here is the offset for the Qcom SoC I'm currently working on:

DBI  - 0x0
iATU - 0x1000
eDMA - 0x2000

As you can see, these offsets doesn't really fit in both the cases you shared
above.

I don't have the knowledge about the internal representation of the IP or what
customization Qcom did apart from some high level information.

Hope this clarifies!

Thanks,
Mani
