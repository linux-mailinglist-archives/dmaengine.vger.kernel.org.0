Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4CE667EA5
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jan 2023 20:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjALTFw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Jan 2023 14:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjALTF3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Jan 2023 14:05:29 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7296A4BD62;
        Thu, 12 Jan 2023 10:47:04 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bf43so29748840lfb.6;
        Thu, 12 Jan 2023 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kig/qntpjsc04QbM+nU6iO8PSigAiw2nmoJspoY9yks=;
        b=qVNztKtzIo2KoHeeA5KdrK5Q2l3IQ7YuKOTtMgToTfxJnHREI+HZrriqLQTuVU6r6f
         9HUdT6qtxspn52mfXksOO+0O/GHZnpWDRkONzQ27QErgFVPks1NWjVLb9Qda5BsCvbKF
         8f28GKEaIuJ63FPoEfrS3H3NZQ+m/37hfbcZUDI0E00nkXqX1B/PqhtxOJ795Jfue33y
         y1LONderOSeSjTm17COkd8uNlqMd925xgfCxqrpss3DrbL1P2Oc+UXaYvzqxfRrxtV/L
         uMnDBs4c/gr1Mqq2jWrgZf/x+czm17MERmmIPkr5Zv1mi7s2rU+p4yX2fmYvDLzjkLca
         /7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kig/qntpjsc04QbM+nU6iO8PSigAiw2nmoJspoY9yks=;
        b=zUZgHWFh27eEdBk0jetUCAUsb4pjSJdbXXbpxmJTxnXiDOrmrjyuyaRN0nj2o/+V+Y
         ldrTo66Xx24Xam2vUszykGtPVU+uB18zMAya1rShBTccGGbi5UfKU5sPFmSgmUYCr8we
         dliGqFzv7sJIYXobxzjH4f0pbiS3NPbjH19MM5m0M7sVYmtDE2biU/oGNO9jj/xOSTh9
         0tAQpxwn+v5LeLspsR09XTKsJMpqKGC70nUlsTJNDgP5g6iWcOofXvfFBx/AtshdO62X
         M/lCl6uWBSrMud4bCKyZIz1COIDktq6S2DtxNb15AvUmasYizwMgsOUvr4Xd1O0YCWfk
         w4Bw==
X-Gm-Message-State: AFqh2kr7kUFMJ0MPtUvjR2C4ctxWRJdabKUbiOqpYu5fGLmWaVIRt/AU
        Bw77rhGHCxy4Wg58QDvKsgo=
X-Google-Smtp-Source: AMrXdXu77Zy4IzmXKRriue1nqoGYETQcr4kmo5YRLZDWblYE4UjU/nM0j1O2SNz4+LZQx08OSbJJHg==
X-Received: by 2002:ac2:414b:0:b0:4b5:3505:d7f9 with SMTP id c11-20020ac2414b000000b004b53505d7f9mr19346850lfi.35.1673549222742;
        Thu, 12 Jan 2023 10:47:02 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id 18-20020a2e0312000000b0027fbb5c0f86sm2251356ljd.57.2023.01.12.10.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 10:47:01 -0800 (PST)
Date:   Thu, 12 Jan 2023 21:46:59 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
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
Subject: Re: [PATCH v8 24/26] PCI: dwc: Set coherent DMA-mask on MSI-address
 allocation
Message-ID: <20230112184659.mwwjr4xg6ktskqhd@mobilestation>
References: <20221219144658.26620-1-Sergey.Semin@baikalelectronics.ru>
 <20221219144658.26620-25-Sergey.Semin@baikalelectronics.ru>
 <fa491b99-5e05-b436-9304-32baeb019750@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa491b99-5e05-b436-9304-32baeb019750@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 11, 2023 at 01:39:35PM +0000, Robin Murphy wrote:
> On 2022-12-19 14:46, Serge Semin wrote:
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
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Great! Thanks.

-Serge(y)

> 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v8:
> > - This is a new patch added on v8 stage of the series.
> >    (@Robin, @Christoph)
> > ---
> >   drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 3ab6ae3712c4..e10608af39b4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -366,7 +366,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >   						    dw_chained_msi_isr, pp);
> >   	}
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
> >   	if (ret)
> >   		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
