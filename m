Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B366761C3
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jan 2023 00:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjATXyz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Jan 2023 18:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjATXyy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Jan 2023 18:54:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFD81449C;
        Fri, 20 Jan 2023 15:54:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58D33B82A89;
        Fri, 20 Jan 2023 23:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73C3C433EF;
        Fri, 20 Jan 2023 23:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674258890;
        bh=iqOP9lSV+EeLcJNsAsjglTNHC5XAcXVWOnjm6GTY4Ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fNx76M08EivqBfJbGMukrlvh4EqFOFpmEMiDwWF7NePATZGCS7s5C8yCLEzWNqZF+
         C1MwY2a9/xN+JejzMVY46RFd85ZmpwjZ5oj0QaqeWv/NB8IY+DjozSksPN3pFE/wPl
         KY5EcEZ9R5lhKB6uJJUyNZhEQfQytEprNdVxcMS6atz0iYzo2agwamjfHSmwv8nOn+
         86OYSkjsICiZ5RPD8KoSUHkhSZafUH/xI2LMT+d9IdfDafmn17LQadoU0Yqtm6odtu
         O1up+U2j8c2W/RdIwaESoTYVJzTVrviyr9NS2NJmG/S4jfmG8Mm0BehQz0Htx0iiu/
         y1zsgL7Xz4oLA==
Date:   Fri, 20 Jan 2023 17:54:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 09/27] dmaengine: dw-edma: Drop chancnt initialization
Message-ID: <20230120235449.GA682361@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113171409.30470-10-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 13, 2023 at 08:13:51PM +0300, Serge Semin wrote:
> DMA device drivers aren't supposed to initialize the dma_device.chancnt
> field. It will be done by the DMA-engine core in accordance with number of
> added virtual DMA-channels. Pre-initializing it with some value causes
> having a wrong number of channels printed in the device summary.
> 
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 6c9f95a8e397..ecd3e8f7ac5d 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -817,7 +817,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
>  	dma->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>  	dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>  	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> -	dma->chancnt = cnt;

Did you look for other instances of this bug?  There are several other
places that *look* like they might have the same issue:

  axi_dmac_probe
  dw_probe               (dw-axi-dmac-platform.c)
  ioat_pci_probe
  plx_dma_create
  ...

I hate to fix just one if there are other similar issues.

>  	/* Set DMA channel callbacks */
>  	dma->dev = chip->dev;
> -- 
> 2.39.0
> 
> 
