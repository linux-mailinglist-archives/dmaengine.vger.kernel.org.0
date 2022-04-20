Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8692C5081B3
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 09:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350824AbiDTHJm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 03:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiDTHJl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 03:09:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F744255A1;
        Wed, 20 Apr 2022 00:06:56 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y11so829932ljh.5;
        Wed, 20 Apr 2022 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ar/vwA/dEWYGJ1jgD7azDwPgLk9jXIiNho6IYMM8hYg=;
        b=KZO3F8en3qIYFlhOnI6phmv3kEb0CeLS0HlxrnY1pOVDlpwcQd/OLgpzwAsRHbvsQE
         69YRI5mL/z9cqiOZtTrKk/nrYTqHlFDwheS21FzsdF079YMsbJsty+fp7WuPb/fRdrWZ
         sY/ovZXgE7hPa4ZsNxGS1D1DrSS8+ays9rga83ckOuZjQ1wb4Zquvg1LzSsZj56WwI/A
         HCR68JJCkRQYRIDCP5+E87J91ipvahhkBF2z4T4om9XMxZLneUaJIMLRSPty0ZQu4dKj
         ZGv7w5HtZQTLMA8CBJu/1OmOZgEurSH7dFjYvS33yFXkl/Tnur8halCrAqnze5Y6zrwr
         Cdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ar/vwA/dEWYGJ1jgD7azDwPgLk9jXIiNho6IYMM8hYg=;
        b=t8Im2a2/mQabflUb7d9Zvzgb76aEe9llbw+MvpKttzZDGN+DpJQ51O7dXiddXUM+eD
         yyTq+dcajJuXedf+YsZZnXRrpt8YnXMdpGyP79qAN/LN3lT89LiZXIXwmL21OABrHJba
         vq4sx/39aiui/HxFCAH1ZcP2sShMUFSrIHhKXSefs2gDIgK1JAU6uHre+g6DZ3VB5som
         5eYR5vuDW9ZSu38zNVXvsZgXF3abeKiBjc6yHnFw9RHL9caSwCK6kCLHcl8YfFTfVh9j
         tO/7Rn67cXHfhrLmQWesjIdIxud6Ea0TrsqteZCKp8TxECwy/46TWYdfocjTp5NhXG51
         upQg==
X-Gm-Message-State: AOAM532OR9/2uQjUqq9U8CPoEU3v4dnNU4YepNkiyJsxVjjFGuMnZTRq
        v6O1i6VfZD0sBILwjceqeiM=
X-Google-Smtp-Source: ABdhPJwqanHVm6eb232iGGy/Q2e3ODbt6tNa6/TMijD/uFi/B7cm3B6NTWfSNIH5UbeBZ6bHGcwAgA==
X-Received: by 2002:a2e:a40b:0:b0:24d:c4d4:5796 with SMTP id p11-20020a2ea40b000000b0024dc4d45796mr5148756ljn.202.1650438414681;
        Wed, 20 Apr 2022 00:06:54 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id v2-20020a2e4802000000b0024dc2a58534sm596458lja.75.2022.04.20.00.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 00:06:54 -0700 (PDT)
Date:   Wed, 20 Apr 2022 10:06:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v7 1/9] dmaengine: dw-edma: Remove unused field irq in
 struct dw_edma_chip
Message-ID: <20220420070652.rdnzwom6stj7aor5@mobilestation>
References: <20220414233709.412275-1-Frank.Li@nxp.com>
 <20220414233709.412275-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414233709.412275-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 14, 2022 at 06:37:01PM -0500, Frank Li wrote:
> irq of struct dw_edma_chip was never used.
> It can be removed safely.

Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v6 to v7
>  - move to 1st patch
> Change from v5 to v6
>  - s/remove/Remove/ at subject
> Change from v4 to v5
>  - none
> new patch at v4
> 
>  drivers/dma/dw-edma/dw-edma-pcie.c | 1 -
>  include/linux/dma/edma.h           | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 44f6e09bdb531..b8f52ca10fa91 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -231,7 +231,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->dw = dw;
>  	chip->dev = dev;
>  	chip->id = pdev->devfn;
> -	chip->irq = pdev->irq;
>  
>  	dw->mf = vsec_data.mf;
>  	dw->nr_irqs = nr_irqs;
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index cab6e18773dad..d4333e721588d 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -18,13 +18,11 @@ struct dw_edma;
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
>   * @id:			 instance ID
> - * @irq:		 irq line
>   * @dw:			 struct dw_edma that is filed by dw_edma_probe()
>   */
>  struct dw_edma_chip {
>  	struct device		*dev;
>  	int			id;
> -	int			irq;
>  	struct dw_edma		*dw;
>  };
>  
> -- 
> 2.35.1
> 
