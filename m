Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395094D4753
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 13:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbiCJMxx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 07:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiCJMxw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 07:53:52 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0DD63530;
        Thu, 10 Mar 2022 04:52:48 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g17so9280433lfh.2;
        Thu, 10 Mar 2022 04:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KP//rluMIm5TxoP3CCPSu0RD6tHviTrcO3Lx2tvMiOo=;
        b=Zzbe3cMJjY77VY6GOtFbCvSAbzXNBdnaSgFR4bGlE7t0QSDoB/qWtCqG+6/LzCiPCV
         sABob9I6ZU3pN7EIIBfxEBBCu3sFx3wR/MZJ11moPV3nApDmB0VAT9QkVFNK2o7k88Y0
         n4WGLhKIi0c+Gxl5/MqKGx74dF1CyowbdnY2FBR4w7QIgLbq2+NjiF2bgemByVdotHMQ
         ITUAKETupq+XCt1vSwVeFrWMPoAmyitvDzFnDvfhFXpwv2IC57w6FhovIi2U9wqYnTWS
         EoWzDWw/oJQDk3LWafh2c3YeTTcukASWHfPdMGUpcN0N59jl9By1nOMImikgNDyzzCyv
         HaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KP//rluMIm5TxoP3CCPSu0RD6tHviTrcO3Lx2tvMiOo=;
        b=0v5Qcur4T5Pjbw6puzIc8IPt0LcYleeQN05oHhmmh9CPN3uNfM5QO6eMGrhFOUrFsQ
         rxPfWSHalWXK4eYyS616YHH9kMPXWhpnVNqLZo2GmLIe72hfvIH6QN7zme0C9OsNxc5C
         LbHa5Mg0Ha3/cpYsh8x94QqqQZa+QATDXA4/wj58Nd1+RYipXBPvwU6JxF4isN4qNVqz
         NOiNm/zOy600wVTIw3D+HlhoY0k7dIL9nkg6zXHw6nXbMSssBYLkFb0aMpGTOcfz+HxN
         BKMsqwIsx3eW83AtWkgAZqfkXobd1MJbg7K/d4iFBezzmlFVhzlyV9CncRDb0FY4yXol
         2s+g==
X-Gm-Message-State: AOAM533WflWQBrKLBGBtbPt40nA80C0dGUt910YOI5rQCbS57hvxxdIR
        A1Tb+QY2Cc07OIAyuFYTdN8=
X-Google-Smtp-Source: ABdhPJy/ENkEQOcYu5vhB1IyBE6vhf41nOil+A02sDEZlRVbHjHSUs6IKfr/4U6HzJiruPUxAwNCEw==
X-Received: by 2002:a05:6512:3890:b0:448:21bd:28d with SMTP id n16-20020a056512389000b0044821bd028dmr2876829lft.376.1646916766899;
        Thu, 10 Mar 2022 04:52:46 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id m25-20020a195219000000b0044846bbda49sm960971lfb.121.2022.03.10.04.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 04:52:46 -0800 (PST)
Date:   Thu, 10 Mar 2022 15:52:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v4 2/8] dmaengine: dw-edma: remove unused field irq in
 struct dw_edma_chip
Message-ID: <20220310125244.uakhndanc4gxdppn@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309211204.26050-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 09, 2022 at 03:11:58PM -0600, Frank Li wrote:

> irq of struct dw_edma_chip was never used.
> It can be removed safely.

The patch is incomplete. See drivers/dma/dw-edma/dw-edma-pcie.c:234.
The irq field is initialized there. But it's never used afterwards. So
you need to fix the dw-edma-pcie.c driver too by dropping the
corresponding initialization, otherwise the driver will fail to be
built.

-Sergey

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> new patch at v4
> 
>  include/linux/dma/edma.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index a9bee4aeb2eee..6fd374cc72c8e 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -37,7 +37,6 @@ enum dw_edma_map_format {
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
>   * @id:			 instance ID
> - * @irq:		 irq line
>   * @nr_irqs:		 total dma irq number
>   * @ops			 DMA channel to IRQ number mapping
>   * @wr_ch_cnt		 DMA write channel number
> @@ -51,7 +50,6 @@ enum dw_edma_map_format {
>  struct dw_edma_chip {
>  	struct device		*dev;
>  	int			id;
> -	int			irq;
>  	int			nr_irqs;
>  	const struct dw_edma_core_ops   *ops;
>  
> -- 
> 2.24.0.rc1
> 
