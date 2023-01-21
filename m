Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795C5676985
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jan 2023 22:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjAUVK0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 Jan 2023 16:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjAUVKZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 Jan 2023 16:10:25 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E783D22028;
        Sat, 21 Jan 2023 13:10:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id br9so12867083lfb.4;
        Sat, 21 Jan 2023 13:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGyflcQqxHomC2pDK0ldQILNgIUhC4VODU07KwyIzHk=;
        b=V01JxkFYrjDtJe1ldE/9HF7v+C59zrdbaQmt0QImGE1Qfo5KACes3qFD0kKZ5+d7Qd
         XTNIgHB4LPnTzo1AyLy0y32V6ZJDT4MxWf6dfdTBmgAUrcCDrL334IDcPMgO26EC502D
         ML9HYvyxf0vO1hyxVa4zyzyj9f6vvhXWqFtHn7F4AbUpHqwKKePinEBuv3IuShq1JKN3
         3DdiAqwRTFBLVjQ+tVvqs60q2jvoMNf/09wWBLI5G8A1YK61GfFhByY2eioiCYckhH/G
         XQhov/E3YPLrw1M3VNN80ijLnT/HFJcDOGHx1UQ93uP+XpWOqwkm/HcBUAMzxhbz4es0
         GHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGyflcQqxHomC2pDK0ldQILNgIUhC4VODU07KwyIzHk=;
        b=xZ/NNcS2sXU7iFSejDVcQ6trSDzk8iIqesgXe1GUZgkWMsVHMgngP/wD9WEUab3llu
         xlqfLAcLh4XsX9KzK0iT1iS7qPkjn2AAvNBHDW/oid9QPGxhpEBL7+HUb3hXtpPrZuYz
         vVMBTAb1XZzcAhz2ucfyDkofE/lpuTVJZKPIJpWP5kFaFQOahSv5wmOAdgLNxn/grd5e
         Lw5PA2Jh6d3AMI5z6T//n6oTSTtUb/T71FhQPMh6e9AZJM+VeG0cMGaJd8C/Oqov3jW8
         o/HJh3rgFDHqRWc/Ixd9xj+NjGpnjwrmeC1ApZC+/NkBaFJtJitmHFOEBiIuawrwImSo
         /SPA==
X-Gm-Message-State: AFqh2koLExGJ2Sef+9nWqcILvgmQ8r81iezFGE/FJtZp2ZOPYembNyj0
        CP9dhhWSLwL120yuUsnz6c4=
X-Google-Smtp-Source: AMrXdXuiSn+SAXno5D08S1ZrDQedSoMU7hjZvA60gvHymiiAPl3ks0qgBrhiEf6jk/qyqpvPU34jUg==
X-Received: by 2002:a05:6512:3a82:b0:4b6:e493:b798 with SMTP id q2-20020a0565123a8200b004b6e493b798mr6386544lfu.68.1674335422034;
        Sat, 21 Jan 2023 13:10:22 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id cf37-20020a056512282500b004d254939bebsm2541840lfb.305.2023.01.21.13.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:10:21 -0800 (PST)
Date:   Sun, 22 Jan 2023 00:10:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v9 09/27] dmaengine: dw-edma: Drop chancnt initialization
Message-ID: <20230121211018.wn2zjxts7hzmetin@mobilestation>
References: <20230113171409.30470-10-Sergey.Semin@baikalelectronics.ru>
 <20230120235449.GA682361@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120235449.GA682361@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 20, 2023 at 05:54:49PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 13, 2023 at 08:13:51PM +0300, Serge Semin wrote:
> > DMA device drivers aren't supposed to initialize the dma_device.chancnt
> > field. It will be done by the DMA-engine core in accordance with number of
> > added virtual DMA-channels. Pre-initializing it with some value causes
> > having a wrong number of channels printed in the device summary.
> > 
> > Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 6c9f95a8e397..ecd3e8f7ac5d 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -817,7 +817,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
> >  	dma->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> >  	dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> >  	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > -	dma->chancnt = cnt;
> 

> Did you look for other instances of this bug?  There are several other
> places that *look* like they might have the same issue:
> 
>   axi_dmac_probe
>   dw_probe               (dw-axi-dmac-platform.c)
>   ioat_pci_probe
>   plx_dma_create
>   ...
> 
> I hate to fix just one if there are other similar issues.

Indeed. The same problem can be spotted in:
drivers/dma/dma-axi-dmac.c
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
drivers/dma/ioat/init.c
drivers/dma/plx_dma.c
drivers/dma/qcom/hidma.c
drivers/dma/sprd-dma.c
drivers/rapidio/devices/tsi721_dma.c

Moreover besides causing a wrong number of channels printed in the
device summary the problem may also lead to the dma_ida IDs leak. So
it's a bit more complex than I described in the patch log.

@Vinod you didn't say anything about that during the patch review. Do
you want me to provide a similar fix for the denoted drivers?

-Serge(y)

> 
> >  	/* Set DMA channel callbacks */
> >  	dma->dev = chip->dev;
> > -- 
> > 2.39.0
> > 
> > 
