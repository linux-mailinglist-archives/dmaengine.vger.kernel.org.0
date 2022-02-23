Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DE54C1B16
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 19:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbiBWSoX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 13:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbiBWSoX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 13:44:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48064DF62;
        Wed, 23 Feb 2022 10:43:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 661B6615F8;
        Wed, 23 Feb 2022 18:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247C7C340E7;
        Wed, 23 Feb 2022 18:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645641833;
        bh=XfBLjj4j3UjNuCB/GziGUYF4ayFzbyJpJY2IrYM3XUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmrjmHtGi/1eLxifAooKa7LLAMo24uRQeYXZJ/mzAaxxaKc++A2OAi+Jp6i9WAGMi
         hJTYhkUFcvE2ciF4k0zmK8FEhlFUJu+4acynMdYvZ4Yr3yJR5tsUQZhJ+XxEFa6Z7W
         lwXyAGLc4AcMGc3J4bK9XLFsYn+5Jrsbe5B7B/lMG8lDV4vXn/lCrCGmOaDcm51tAx
         GPuaxtQZVOBqg9+m/zXUJ2Ab1/+ECWKrxHtWpUE2Pu1/xkVIaTrq4fdTx15RBqOXXb
         wE4dw+3JRK3HrsoG7T0mZdrPpildS7DbpeJvFrtEEx88gDSN2ue685s1+qA6gUmxbY
         y7lGzNN4ReiQg==
Date:   Wed, 23 Feb 2022 11:43:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: Re: [PATCH v20 2/2] dmaengine: tegra: Add tegra gpcdma driver
Message-ID: <YhaAZNaav720xXXx@dev-arch.archlinux-ax161>
References: <20220221153934.5226-1-akhilrajeev@nvidia.com>
 <20220221153934.5226-3-akhilrajeev@nvidia.com>
 <YhUBt20I471s9Bhv@dev-arch.archlinux-ax161>
 <DM5PR12MB1850EF14473F9F941FB12506C03C9@DM5PR12MB1850.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1850EF14473F9F941FB12506C03C9@DM5PR12MB1850.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 23, 2022 at 03:49:09AM +0000, Akhil R wrote:
> > Hi Akhil,
> > 
> > On Mon, Feb 21, 2022 at 09:09:34PM +0530, Akhil R wrote:
> > > Adding GPC DMA controller driver for Tegra. The driver supports dma
> > > transfers between memory to memory, IO peripheral to memory and memory
> > > to IO peripheral.
> > >
> > > Co-developed-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> > > Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> > > Co-developed-by: Rajesh Gumasta <rgumasta@nvidia.com>
> > > Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> > > Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> > > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> > > ---
> > >  drivers/dma/Kconfig            |   11 +
> > >  drivers/dma/Makefile           |    1 +
> > >  drivers/dma/tegra186-gpc-dma.c | 1507
> > > ++++++++++++++++++++++++++++++++
> > >  3 files changed, 1519 insertions(+)
> > >  create mode 100644 drivers/dma/tegra186-gpc-dma.c
> > 
> > <snip>
> > 
> > > +static const struct __maybe_unused dev_pm_ops tegra_dma_dev_pm_ops =
> > > +{
> > 
> > The __maybe_unused cannot split the type ("struct dev_pm_ops") otherwise it
> > causes a clang warning:
> > 
> > https://lore.kernel.org/r/202202221207.lQ53BwKp-lkp@intel.com/
> > 
> > static const struct dev_pm_ops tegra_dma_dev_pm_ops __maybe_unused = {
> > 
> > would look a litle better I think. However, is this attribute even needed? The
> > variable is unconditionally used below, so there should be no warning about it
> > being unused?
> > 
> > Cheers,
> > Nathan
> > 
> > > +     SET_SYSTEM_SLEEP_PM_OPS(tegra_dma_pm_suspend,
> > > +tegra_dma_pm_resume) };
> > > +
> > > +static struct platform_driver tegra_dma_driver = {
> > > +     .driver = {
> > > +             .name   = "tegra-gpcdma",
> > > +             .pm     = &tegra_dma_dev_pm_ops,
> > > +             .of_match_table = tegra_dma_of_match,
> > > +     },
> > > +     .probe          = tegra_dma_probe,
> > > +     .remove         = tegra_dma_remove,
> > > +};
> > > +
> > > +module_platform_driver(tegra_dma_driver);
> > > +
> > > +MODULE_DESCRIPTION("NVIDIA Tegra GPC DMA Controller driver");
> > > +MODULE_AUTHOR("Pavan Kunapuli <pkunapuli@nvidia.com>");
> > > +MODULE_AUTHOR("Rajesh Gumasta <rgumasta@nvidia.com>");
> > > +MODULE_LICENSE("GPL");
> > > --
> > > 2.17.1
> > >
> > >
> 
> Hi Nathan,
> 
> Thanks. Will update the same.
> 
> I am getting notification for the below warning also.
> 
> >> drivers/dma/tegra186-gpc-dma.c:898:53: warning: shift count >= width of type [-Wshift-count-overflow]
>                            FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
> https://lore.kernel.org/all/202202230559.bLOEMEUh-lkp@intel.com/
> 
> I suppose, this is because it is compiled against a different ARCH other than arm64.
> For arm64, the dma_addr_t is 64 bytes, and this warning does not occur.
> Could this be ignored for now? If not, could you suggest a fix, if possible?

I am not really familiar with the DMA API and dma_addr_t so I am not
sure about a proper fix.

You could cast dest to u64 to guarantee it is a type that can be shifted
by 32 but that might not be right for CONFIG_PHYS_ADDR_T_64BIT=n. If the
driver is not expected to run without CONFIG_PHYS_ADDR_T_64BIT, then
this is probably fine.

You could mark this driver 'depends on PHYS_ADDR_T_64BIT' if it cannot
run with CONFIG_ARCH_TEGRA=y + CONFIG_PHYS_ADDR_T_64BIT=n but I do not
see any other drivers that do that, which might mean that is not a
proper fix.

Please do not ignore the warning, as it will show up with ARCH=arm
allmodconfig, which has -Werror enabled.

Cheers,
Nathan
