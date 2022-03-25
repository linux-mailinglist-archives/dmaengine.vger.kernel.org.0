Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E311C4E7B6D
	for <lists+dmaengine@lfdr.de>; Sat, 26 Mar 2022 01:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiCYTka (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Mar 2022 15:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiCYTjv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Mar 2022 15:39:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E6E1AD3B3
        for <dmaengine@vger.kernel.org>; Fri, 25 Mar 2022 12:12:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p8so7178191pfh.8
        for <dmaengine@vger.kernel.org>; Fri, 25 Mar 2022 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kZES9xIl6k9PvYS5MDCMcxY5BJubJIUmZOtDfDfAejs=;
        b=G+VoHJsNN0ri/JzciH09IIMeE8UG5JI8cQ0Bi+n1qzT1U7e2FvdiZW70FLIX5LIbWI
         svKvAmULBod057SqPwM+zCt9dYAp0E7Nh0JdjhTVG9zloKwBg15BPF4N174Yjl2eHqiU
         Eja1GhgO6IYA3dYuZDm+hULboBb7ImzDwWP6ibLR81BotK0HFhHcQr7eqjGNAn/6QD8N
         cf3yzF+3aj0A8W19SK7cffVZxlCEmuIOwoRdtYQx1DJA7VekL91I6RjMb0Ay0tlkCc4q
         TOsdigNz7PpG5hQeE8+H3j5DcskDvPL6O6GKWgx8Ks4UFW60VUyt5A1nr+QDjQ5DAiRd
         1Ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kZES9xIl6k9PvYS5MDCMcxY5BJubJIUmZOtDfDfAejs=;
        b=ygFG2cxDxH8C8udVTUP/XDeBJbRdJVFMEqGoJU395x7C1JBbwqq0KbhtLg2Y7alLWw
         r1qFXTu2WYrEdyxBQK11wbnOPOvhezRWXyO/ltg9yyTzSeeA1PKhChTZEsp1dUMDdH6L
         RI1VTwFXznewxF/oy651TiSPT4yHa7d0mD9dAVO2crBHXB+Dy16o55S/df722NdHitNj
         vhpwV5x51lluEaYyaOQ3gya8yRj2KL42Glio0iq/OCtPsTPcdrSYAOEWUSBqRqfvQy69
         GkLmUZOyHlnuOv7X+qlaWI7BHmkF0iQbK8jnZncN9czxHcBldZWpS9NBqkLZAhjf7koG
         GRMw==
X-Gm-Message-State: AOAM532OMbKjQ5J/Tez3AdHJqK35P1IZepWz3G/QgeR1Ts7qbW97XPmG
        pDEDlFkZpR+AzOJbHknQwp7lRglx5BMI
X-Google-Smtp-Source: ABdhPJxHEq9AiqyZOMWbqRFWmAZeorLFYNmf9U/rZ0ZkWmXSwUxDnbhzMAiXTxAo6JhPvOvZ4DYL7w==
X-Received: by 2002:a63:77ca:0:b0:386:25a5:5ed with SMTP id s193-20020a6377ca000000b0038625a505edmr649866pgc.30.1648231848826;
        Fri, 25 Mar 2022 11:10:48 -0700 (PDT)
Received: from thinkpad ([117.193.209.11])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a000cd000b004fadb6f0290sm7420435pfv.11.2022.03.25.11.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:10:48 -0700 (PDT)
Date:   Fri, 25 Mar 2022 23:40:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/25] dmaengine: dw-edma: Bypass dma-ranges mapping for
 the local setup
Message-ID: <20220325181042.GA12218@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-24-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-24-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:34AM +0300, Serge Semin wrote:
> DW eDMA doesn't perform any translation of the traffic generated on the
> CPU/Application side. It just generates read/write AXI-bus requests with
> the specified addresses. But in case if the dma-ranges DT-property is
> specified for a platform device node, Linux will use it to map the CPU
> memory regions into the DMAable bus ranges. This isn't what we want for
> the eDMA embedded into the locally accessed DW PCIe Root Port and
> End-point. In order to work that around let's set the chan_dma_dev flag
> for each DW eDMA channel thus forcing the client drivers to getting a
> custom dma-ranges-less parental device for the mappings.
> 
> Note it will only work for the client drivers using the
> dmaengine_get_dma_device() method to get the parental DMA device.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 72a51970bfba..ca5cd7c99571 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -716,6 +716,21 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>  	if (chan->status != EDMA_ST_IDLE)
>  		return -EBUSY;
>  
> +	/* Bypass the dma-ranges based memory regions mapping since the
> +	 * inbound iATU only affects the traffic incoming from the
> +	 * PCIe bus.
> +	 */

Bypass the dma-ranges based memory regions mapping since eDMA doesn't do any
address translation for the CPU address?

Other than this,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> +		dchan->dev->chan_dma_dev = true;
> +
> +		dchan->dev->device.dma_coherent = chan->dw->chip->dev->dma_coherent;
> +		dma_coerce_mask_and_coherent(&dchan->dev->device,
> +					     dma_get_mask(chan->dw->chip->dev));
> +		dchan->dev->device.dma_parms = chan->dw->chip->dev->dma_parms;
> +	} else {
> +		dchan->dev->chan_dma_dev = false;
> +	}
> +
>  	pm_runtime_get(chan->dw->chip->dev);
>  
>  	return 0;
> -- 
> 2.35.1
> 
