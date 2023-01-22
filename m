Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15764676A67
	for <lists+dmaengine@lfdr.de>; Sun, 22 Jan 2023 01:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAVALX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 Jan 2023 19:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAVALX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 Jan 2023 19:11:23 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853C14E93;
        Sat, 21 Jan 2023 16:11:21 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so13209839lfv.2;
        Sat, 21 Jan 2023 16:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WRreyOWAmXkbLt9Hu6sMXlTjNEw0tKoxlYL8sH0JJNU=;
        b=CLxbsfeq3WRGjqjefSkV7c7S41zqi1c/P7hxaw59cBAtY0Y9WgKXGqVSqz+cLiJJmS
         JS7gNjPdut/pbn4Ut8dyeVABLHiKEjwoDrxixTgmCQJmoU6X6Pdi09m6yPq7Zfbcn/7v
         Fy04cevGkD2kT1dQ4Ug3McT7kXagx23tKTI1jI3nOhKasrByoT7FQ+N1DWSJKitHTkF4
         ux3Kp6rHXl5Rqo3Od1+gfsg/8qQlcEf/6kmNRD2p3RcltGinWQeVJviPWbHLHnhYC15r
         do617DiCxwJrZZBSPHmEDKDyDctUSczBEDTPIK+zU4gJ+0lKPQ0kEGVXUU+8zUVhuUvA
         Ndjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRreyOWAmXkbLt9Hu6sMXlTjNEw0tKoxlYL8sH0JJNU=;
        b=YlJIfpbamBpuumxD1L6tpelPAlDEw0nkdXPZdM1Aw2r3GqluS0ncn8FvrWKDUk7Kir
         e+SDPUb42us1pMql7wnM5rwJFh9RHXk+AgWp+7JJ7eQmaVGcAp1tW509y1fW2EZtz/gZ
         oEP/lzQaUTNL2dL8JBddQ5i+1nK+0tneCibmKXPr1pUTf1dUQq4976x4TEterV5csVtO
         chtJE0UJYjfgVhorAGXhIVdnqk56reZx76cdX3SjmmL6L3N+MooNCcA3JqniSuutYR2z
         Ly3ZOPjbt/xX2moJkeKYAZJzRKDw51PeNQYNh+GUwqWk7wrv3Tg7/BA51NBd/2xv0hg4
         AKOA==
X-Gm-Message-State: AFqh2kotr2tfknBJuVIzOn3ZgS1pIkCTLH9DqdIkRy3m8aO2SAS3Oh7d
        FfqdxvPdi/2hs6gPaA1VcQw=
X-Google-Smtp-Source: AMrXdXvqckpNMq4fP+z4FjLx0Oji38k08Incx5QFkX3t+pg0lzrDbq8sn0PF9LhfVF4kSCHdedTj2w==
X-Received: by 2002:a05:6512:3251:b0:4b5:6755:4226 with SMTP id c17-20020a056512325100b004b567554226mr4909329lfr.55.1674346279465;
        Sat, 21 Jan 2023 16:11:19 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id t14-20020a056512208e00b004cc94ce2cb4sm4223155lfr.233.2023.01.21.16.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 16:11:18 -0800 (PST)
Date:   Sun, 22 Jan 2023 03:11:16 +0300
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
Subject: Re: [PATCH v9 24/27] dmaengine: dw-edma: Relax driver config settings
Message-ID: <20230122001116.jbhttuaed7zuls26@mobilestation>
References: <20230113171409.30470-25-Sergey.Semin@baikalelectronics.ru>
 <20230120225036.GA675763@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120225036.GA675763@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 20, 2023 at 04:50:36PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 13, 2023 at 08:14:06PM +0300, Serge Semin wrote:
> > Since the DW PCIe RP/EP driver is about to be updated to register the DW
> > eDMA-based DMA-engine the drivers build modes must be synchronized.
> > Currently the DW PCIe RP/EP driver is always built as a builtin module.
> > Meanwhile the DW eDMA driver can be built as a loadable module. Thus in
> > the later case the kernel with DW PCIe controllers support will fail to be
> > linked due to lacking the DW eDMA probe/remove symbols. At the same time
> > forcibly selecting the DW eDMA driver from the DW PCIe RP/EP kconfig will
> > effectively eliminate the tristate type of the former driver fixing it to
> > just the builtin kernel module.
> > 
> > Seeing the DW eDMA engine isn't that often met built into the DW PCIe
> > Root-ports and End-points let's convert the DW eDMA driver config to being
> > more flexible instead of just forcibly selecting the DW eDMA kconfig. In
> > order to do that first the DW eDMA PCIe driver config should be converted
> > to being depended from the DW eDMA core config instead of selecting the
> > one. Second the DW eDMA probe and remove symbols should be referenced only
> > if they are reachable by the caller. Thus the user will be able to build
> > the DW eDMA core driver with any type, meanwhile the dependent code will
> > be either restricted to the same build type (e.g. DW eDMA PCIe driver if
> > DW eDMA driver is built as a loadable module) or just won't be able to use
> > the eDMA engine registration/de-registration functionality (e.g. DW PCIe
> > RP/EP driver if DW eDMA driver is built as a loadable module).
> 
> I'm trying to write the merge commit log, and I understand the linking
> issue, but I'm having a hard time figuring out what the user-visible
> scenarios are here.
> 

> I assume there's something that works when CONFIG_PCIE_DW=y and
> CONFIG_DW_EDMA_PCIE=y but does *not* work when CONFIG_PCIE_DW=y and
> CONFIG_DW_EDMA_PCIE=m?

No. The DW eDMA code availability (in other words the CONFIG_DW_EDMA
config value) determines whether the corresponding driver (DW PCIe
RP/EP or DW eDMA PCI) is capable to perform the eDMA engine probe
procedure. Additionally both drivers has the opposite dependency from
the DW eDMA code.
|                |     DW PCIe RP/EP    |     DW eDMA PCIe     |
| CONFIG_DW_EDMA +----------------------+----------------------+
|                | Probe eDMA | KConfig | Probe eDMA | Kconfig |
+----------------+------------+---------+------------+---------+
|        y       |     YES    |   y,n   |     YES    |  y,m,n  |
|        m       |     NO     |   y,n   |     YES    |    m,n  |
|        n       |     NO     |   y,n   |     NO     |      n  |
+--------------------------------------------------------------+

Basically it means the DW PCIe RP/EP driver will be able to probe the
DW eDMA engine only if the corresponding driver is built into the
kernel. At the same time the DW PCIe RP/EP driver doesn't depend on
the DW eDMA core module config state. The DW eDMA PCIe driver in
opposite depends on the DW eDMA code config state, but will always be
able to probe the DW eDMA engine as long as the corresponding code is
loaded as either a part of the kernel or as a loadable module.

> 
> If both scenarios worked the same, I would think the existing
> dw_edma_pcie_probe() would be enough, and you wouldn't need to call
> dw_pcie_edma_detect() from dw_pcie_host_init() and dw_pcie_ep_init().

No. These methods have been implemented for the absolutely different
drivers.
dw_edma_pcie_probe() is called for an end-point PCIe-device found on a
PCIe-bus.
dw_pcie_host_init()/dw_pcie_ep_init() and dw_pcie_edma_detect() are
called for a platform-device representing a DW PCIe RP/EP controller.
In other words dw_pcie_edma_detect() and dw_edma_pcie_probe() are in
no means interchangeable.

-Serge(y)

> 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v8:
> > - This is a new patch added on v8 stage of the series in order to fix
> >   the tbot-reported build issues. (@tbot)
> > ---
> >  drivers/dma/dw-edma/Kconfig | 5 ++++-
> >  include/linux/dma/edma.h    | 2 +-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
> > index 7ff17b2db6a1..2b6f2679508d 100644
> > --- a/drivers/dma/dw-edma/Kconfig
> > +++ b/drivers/dma/dw-edma/Kconfig
> > @@ -9,11 +9,14 @@ config DW_EDMA
> >  	  Support the Synopsys DesignWare eDMA controller, normally
> >  	  implemented on endpoints SoCs.
> >  
> > +if DW_EDMA
> > +
> >  config DW_EDMA_PCIE
> >  	tristate "Synopsys DesignWare eDMA PCIe driver"
> >  	depends on PCI && PCI_MSI
> > -	select DW_EDMA
> >  	help
> >  	  Provides a glue-logic between the Synopsys DesignWare
> >  	  eDMA controller and an endpoint PCIe device. This also serves
> >  	  as a reference design to whom desires to use this IP.
> > +
> > +endif # DW_EDMA
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 08833f12b386..c062c8db472c 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -101,7 +101,7 @@ struct dw_edma_chip {
> >  };
> >  
> >  /* Export to the platform drivers */
> > -#if IS_ENABLED(CONFIG_DW_EDMA)
> > +#if IS_REACHABLE(CONFIG_DW_EDMA)
> >  int dw_edma_probe(struct dw_edma_chip *chip);
> >  int dw_edma_remove(struct dw_edma_chip *chip);
> >  #else
> > -- 
> > 2.39.0
> > 
> > 
