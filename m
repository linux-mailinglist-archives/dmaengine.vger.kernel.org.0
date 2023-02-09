Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB8569147E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 00:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjBIXel (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Feb 2023 18:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjBIXeb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Feb 2023 18:34:31 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BD06D8D8;
        Thu,  9 Feb 2023 15:34:17 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hx15so11336447ejc.11;
        Thu, 09 Feb 2023 15:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1BgS9E3oRrAbPLSDERqxU+DcBINbB6yh3H/ZgX+n58=;
        b=m3NyWM8pPtreMVFV9CP8AZSYUYzNA3v6FLzaCHuM06I3pA8bJEsDWRd3taYiaNySrP
         rxTVI2wh9uo07mmMB/pUjqzcvXkwqXVU/03yGEHGn4dQHMnh39+PXocjx6sVZXh+cjRX
         EAxTemTi7/gZPxFJQv2Yw1t61htlfJ09P9ohq2VaNxBy8m1Zj1W7WVjppIXadYjTaAfS
         K02LQi643LxUojMKLE6sAKdt8mxANWU/dhOB+8tor3MuxLRowAgq/4dyHInJrAuh3VDE
         dBegvZ1sKNJb09b1Hqwak17MavjeHx0Lk1RLUScjRMSrFgEN6vD9FgOnIJoYm1hb0fuD
         W0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1BgS9E3oRrAbPLSDERqxU+DcBINbB6yh3H/ZgX+n58=;
        b=oblbPVKPWmTsk9REyzwy2P6Ayg9RtS91tH1s0SR6a8EtcJ70k0Ao3NQoK+7M6ClU8j
         E71rPwFxuoO0RHu5fB1xtnk02kjElQgwB1xDaTu97YVTrN/ASI18+3BmO4CfEA50brKj
         zrezJR5Pf0alXSvYgC0X+amqALsvDUVlNQfOMe5KCHL8Yd3PdCyNSNz/5ZXqCPafBBZX
         9XvXkzoYZ2rKi4CGUkt+NiBfSgONhz9YZbcqUz2cb/MHEVW+Up9VI9/IHsgG/HfIdeG0
         M/nNdEJLYYCX8i169xY/nKcUHPWR5XNaCisloxr1UzGa56vCPhPWQJiOMiqDW8UJE6RU
         1Zqw==
X-Gm-Message-State: AO0yUKV0Uwg2s/VCQBdN6cWBOqBUd7iP+Lo3FWonDpRO8G7y/s0+yrFZ
        FuMx/8QwhtYYtqH0MYCXnbQ=
X-Google-Smtp-Source: AK7set+QyHi4AnsDJ0J/4STY0SQz0VkFMPSZ7xnKVG80fqWGru2KZ+R0tB4iRGRg9M39pr9nweTDrQ==
X-Received: by 2002:a17:906:1b09:b0:864:223:40b with SMTP id o9-20020a1709061b0900b008640223040bmr15845537ejg.33.1675985655968;
        Thu, 09 Feb 2023 15:34:15 -0800 (PST)
Received: from mobilestation ([83.220.236.142])
        by smtp.gmail.com with ESMTPSA id x24-20020a170906135800b00872a726783dsm1482034ejb.217.2023.02.09.15.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 15:34:15 -0800 (PST)
Date:   Fri, 10 Feb 2023 02:34:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: dw-edma: Rename dw_edma_core_ops
 structure to dw_edma_plat_ops
Message-ID: <20230209233412.iadlwmm4nw4qtxt3@mobilestation>
References: <20220921064859.10328-1-cai.huoqing@linux.dev>
 <20220921064859.10328-2-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921064859.10328-2-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Sep 21, 2022 at 02:48:50PM +0800, Cai Huoqing wrote:
> From: caihuoqing <caihuoqing@baidu.com>
> 
> Rename dw_edma_core_ops structure to dw_edma_plat_ops,
> because the 'ops' is related to platform device

@Vinod is right. The commit log is misleading. Please elaborate.

> 
> Signed-off-by: caihuoqing <caihuoqing@baidu.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 4 ++--
>  include/linux/dma/edma.h           | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 3f9dadc73854..5604f3771866 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -109,7 +109,7 @@ static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>  	return region.start;
>  }
>  
> -static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
> +static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
>  	.irq_vector = dw_edma_pcie_irq_vector,
>  	.pci_address = dw_edma_pcie_address,
>  };
> @@ -225,7 +225,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  
>  	chip->mf = vsec_data.mf;
>  	chip->nr_irqs = nr_irqs;
> -	chip->ops = &dw_edma_pcie_core_ops;
> +	chip->ops = &dw_edma_pcie_plat_ops;
>  
>  	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
>  	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 9d44da4aa59d..642dd325259b 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -37,7 +37,7 @@ struct dw_edma_region {
>   *			iATU windows. That will be done by the controller
>   *			automatically.
>   */
> -struct dw_edma_core_ops {
> +struct dw_edma_plat_ops {
>  	int (*irq_vector)(struct device *dev, unsigned int nr);
>  	u64 (*pci_address)(struct device *dev, phys_addr_t cpu_addr);
>  };
> @@ -77,7 +77,7 @@ enum dw_edma_chip_flags {
>  struct dw_edma_chip {
>  	struct device		*dev;
>  	int			nr_irqs;
> -	const struct dw_edma_core_ops   *ops;
> +	const struct dw_edma_plat_ops   *ops;
>  	u32			flags;
>  
>  	void __iomem		*reg_base;

This patch should also update the structure name in the DW PCIe driver:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/controller/dwc/pcie-designware.c?h=pci/ctrl/dwc#n831

-Serge(y)

> -- 
> 2.25.1
> 
