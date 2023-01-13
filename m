Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD35A66A203
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jan 2023 19:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjAMS2C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Jan 2023 13:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjAMS1W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Jan 2023 13:27:22 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012B8164B3;
        Fri, 13 Jan 2023 10:23:24 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id y19so2005940ljq.7;
        Fri, 13 Jan 2023 10:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ms1s84zAFNtBgb8NGTnCe0dENA/JZE+nvA+p2rbZyps=;
        b=ZeW8ivH7MrEqmbMhE+lDqQKcFg1kQ6vtNjrMH20SYx2uJd5Nvkz5q7dfAxkkRl5Mhd
         52moVFDM5MhdLEOtTL8amWm3O2Aend5OuVqhnNOvornlTtyoXcR5EjLTmeHFCJ4Dq8a1
         zc/zADqOhEjEh0assvD2BgOpkh3hLSbI8/USYo/WuvxmqWdQM31gW9qkkebxg3sQpES8
         tlEeySfoLQBASqXQpAQ7QCvQLwzpLWD1GYvTelXHJ5p7k+E+Quib0e0ho94SGfPuWuc6
         fN2kVJFf/YmIK1Q8G/nLvgg3fYPbhM4Am1Jtk9BQ/fvLu0rUnomE/LU2wz5KErQL7fie
         2+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ms1s84zAFNtBgb8NGTnCe0dENA/JZE+nvA+p2rbZyps=;
        b=q7To/8BuvUTwCWzJiQgikRLn/TGDw8bWMUsxHN13xUtHw1M4AH8Ou1tpkzeSfb+kPI
         ijV5wrXSCKgYqmFF/v8W8svYB+sN7Dkd6MuAPovfXW0pEmfff7ISlE783cMU7RTeFfDm
         62qe5aiEScMNLZEe02ev4buIso8KfhHFIOlyyPBPIRiAmTWV3CX+Q3Y4wSvDq9hXo3aZ
         mrUQVMqnHZxxuVL2b/+3Sv9PyDe9EL15mtCTwz54WACn0S8pTCZNCvME4cqE1YG97aeh
         /XP3RDm4ndOx6CcoNNxWD1E3qluiTY+0oN8vAt3jY/MeE72ke/GjEvvdiWJrHgl7dv+p
         W3lw==
X-Gm-Message-State: AFqh2krUqHIbzBmFwOhs/SCpLft8722GRQCR50KvsIq0HaDcuz2Zifh0
        JGEg82BKEUDt7M5hl8X1nq8=
X-Google-Smtp-Source: AMrXdXvd+FWhpuaS24X24HslbV32vcvLVXMlBkUkS7M3pHe2XfhNK4EtjX2ERoUIdHTs6iCGP4vY6Q==
X-Received: by 2002:a05:651c:2399:b0:284:1bdc:4e96 with SMTP id bk25-20020a05651c239900b002841bdc4e96mr334852ljb.38.1673634203077;
        Fri, 13 Jan 2023 10:23:23 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id h3-20020a2ea483000000b0027ff22d93a1sm2662372lji.1.2023.01.13.10.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:23:22 -0800 (PST)
Date:   Fri, 13 Jan 2023 21:23:20 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 24/25] PCI: bt1: Set 64-bit DMA-mask
Message-ID: <20230113182320.fijxjjoobgnwdhjc@mobilestation>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-25-Sergey.Semin@baikalelectronics.ru>
 <Y8FI3m0Yare5gCeM@lpieralisi>
 <8984a6ee-9066-bd2e-761f-96a8dd7875b6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8984a6ee-9066-bd2e-761f-96a8dd7875b6@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 13, 2023 at 05:40:38PM +0000, Robin Murphy wrote:
> On 2023-01-13 12:04, Lorenzo Pieralisi wrote:
> > On Thu, Dec 15, 2022 at 02:53:04AM +0300, Serge Semin wrote:
> > > The DW PCIe RC IP-core is synthesized with the 64-bits AXI address bus.
> > > Since the device is also equipped with the eDMA engine we need to
> > > explicitly set the device DMA-mask so the DMA-engine clients would be able
> > > to allocate the data buffers from the DMA-able memory space.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > ---
> > > 
> > > Changelog v7:
> > > - This is a new patch added on v7 stage of the series. (@Robin)
> > > ---
> > >   drivers/pci/controller/dwc/pcie-bt1.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > 
> > Hi Robin,
> > 
> > are you OK with this change ? I think that's the last (PCI) bit we
> > need to take the series.
> 

> Yup, having gone and double-checked the context this seems fine too - I've
> slightly lost track of all the circles we've been round in by now, but it
> looks like the way things all end up after v8 (and now v9) should be
> uncontentious.

Yes, v9 has just been submitted with your Rb-tag preserved in the
coherent-DMA-mask modification patch (patch #25/27).
Please find the last version of the series here:
https://lore.kernel.org/linux-pci/20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru/

-Serge(y)

> 
> Thanks,
> Robin.
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
> > > index 8b6c7d544d9a..04aa58348aa5 100644
> > > --- a/drivers/pci/controller/dwc/pcie-bt1.c
> > > +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> > > @@ -583,6 +583,10 @@ static int bt1_pcie_add_port(struct bt1_pcie *btpci)
> > >   	struct device *dev = &btpci->pdev->dev;
> > >   	int ret;
> > > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >   	btpci->dw.version = DW_PCIE_VER_460A;
> > >   	btpci->dw.dev = dev;
> > >   	btpci->dw.ops = &bt1_pcie_ops;
> > > -- 
> > > 2.38.1
> > > 
> > > 
