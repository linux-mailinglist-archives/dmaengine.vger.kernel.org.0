Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2726696C3
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jan 2023 13:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241244AbjAMMTE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Jan 2023 07:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241473AbjAMMSe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Jan 2023 07:18:34 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB02019C12;
        Fri, 13 Jan 2023 04:12:06 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bf43so32859441lfb.6;
        Fri, 13 Jan 2023 04:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/GmW1bTcV/m+/egJkIJpEJ7OChAfuXCohbhC9vybKk=;
        b=QifauPrEutC56cnlw8laAvu09B3Aie8gUyBzFVXad+szi+P7n9IT1T8TT2XwmRbzIO
         3E/GRrsDGOoeyKArj8jc1v/wKZLZ94EKOTEoy3yBV3a1zZ4uBkeoqXxKx2KkNY7JJz4i
         7BXmZ+dcvZRvG6eIM7Rp1qInwXBakk4Py5QX/RgnmS4nj8G3QQJcTDWSMXLZR4QfDLJn
         iaRACZLqAjDp2LDQAxKoxBrla/UshjCEoKUR1soqvdZzgVsTxgeV3S4TDSEbpj7Ydzr7
         pg3RKdzBbzpcv4ZpKHXKjMbAG0fU6H3pBdFVLXgCJjytUti5uxwiWtWtCiEpO6lC0ytQ
         NBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/GmW1bTcV/m+/egJkIJpEJ7OChAfuXCohbhC9vybKk=;
        b=R2O/UiQoszfvqUEQ4Xhnf4Vs1USKMB7159RB9lR3tgDUKVQCWSGPRyoiSxtTl5wZq3
         +WldwMTp3OaVJFTCz7/1mg50tiEDQYVY+cwvfvnaKG6Ml1n5zNRYMygHLvi3JahyIQc+
         YIK2reT9LYHoqRH8TWr1pvttrpezLPYyy/fm+ihTIxb8uAitX6CnwKzzge1emViDbyJy
         9E1xnOzJzfnwVo/55/KtxatbgVfNKbCieoQrx23PmqPbOjv98+mgA/brUMzOexjN132v
         MEjOFoU2r7U++ien0p0+RoWi0tr7U9820VhkdkDlj3IG9ypwSHskj/J54b2B6psI3DMX
         imDg==
X-Gm-Message-State: AFqh2kpzX39KZuV6+KB7JCS40rF0mN7Ffn7dpDHzVBnSULCgSVcg7F9T
        XzyUFHhHKqMxLHFVsFIZGzM=
X-Google-Smtp-Source: AMrXdXuAhI89SDhPscAzsvqkCnyW+qvBg0/meGoBY/lkodXMfeMnYm4FKj6Zv9y3JwlQ1SHRERNxAQ==
X-Received: by 2002:a05:6512:2216:b0:4d1:3f9:d0b1 with SMTP id h22-20020a056512221600b004d103f9d0b1mr634792lfu.26.1673611924997;
        Fri, 13 Jan 2023 04:12:04 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id s9-20020ac24649000000b004a47e7b91c4sm3787887lfo.195.2023.01.13.04.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:12:04 -0800 (PST)
Date:   Fri, 13 Jan 2023 15:12:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20230113121202.2oa2eaijg6jlqdjo@mobilestation>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-25-Sergey.Semin@baikalelectronics.ru>
 <Y8FI3m0Yare5gCeM@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8FI3m0Yare5gCeM@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lorenzo

On Fri, Jan 13, 2023 at 01:04:46PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Dec 15, 2022 at 02:53:04AM +0300, Serge Semin wrote:
> > The DW PCIe RC IP-core is synthesized with the 64-bits AXI address bus.
> > Since the device is also equipped with the eDMA engine we need to
> > explicitly set the device DMA-mask so the DMA-engine clients would be able
> > to allocate the data buffers from the DMA-able memory space.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v7:
> > - This is a new patch added on v7 stage of the series. (@Robin)
> > ---
> >  drivers/pci/controller/dwc/pcie-bt1.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Hi Robin,
> 
> are you OK with this change ? I think that's the last (PCI) bit we
> need to take the series.

There is a sparse warning raised by the last patch in this series:
> drivers/pci/controller/dwc/pcie-designware.c:917:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *vaddr @@     got void * @@
   drivers/pci/controller/dwc/pcie-designware.c:917:27: sparse:     expected void [noderef] __iomem *vaddr
   drivers/pci/controller/dwc/pcie-designware.c:917:27: sparse:     got void *
   drivers/pci/controller/dwc/pcie-designware.c:928:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *vaddr @@     got void * @@
   drivers/pci/controller/dwc/pcie-designware.c:928:27: sparse:     expected void [noderef] __iomem *vaddr
   drivers/pci/controller/dwc/pcie-designware.c:928:27: sparse:     got void *

See it full text in the oe-kbuild-all list:
https://lore.kernel.org/oe-kbuild-all/202212201019.zbdcz1of-lkp@intel.com/

I'll resubmit the patchset v9 today with that warning fixed. So please
hold on with merging the series in.

-Serge(y)

> 
> Thanks,
> Lorenzo
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
> > index 8b6c7d544d9a..04aa58348aa5 100644
> > --- a/drivers/pci/controller/dwc/pcie-bt1.c
> > +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> > @@ -583,6 +583,10 @@ static int bt1_pcie_add_port(struct bt1_pcie *btpci)
> >  	struct device *dev = &btpci->pdev->dev;
> >  	int ret;
> >  
> > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +	if (ret)
> > +		return ret;
> > +
> >  	btpci->dw.version = DW_PCIE_VER_460A;
> >  	btpci->dw.dev = dev;
> >  	btpci->dw.ops = &bt1_pcie_ops;
> > -- 
> > 2.38.1
> > 
> > 
