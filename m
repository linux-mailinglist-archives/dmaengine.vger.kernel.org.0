Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E274E66FB
	for <lists+dmaengine@lfdr.de>; Thu, 24 Mar 2022 17:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351685AbiCXQ16 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Mar 2022 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351718AbiCXQ14 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Mar 2022 12:27:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FAA6FF68
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 09:26:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k6so5226741plg.12
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=THlTesE5pnJpMjgygbUl5LvnGMnA21m3pPkRkHRIyLs=;
        b=IB+BHZIabwf6cwu99RiBIESNeVrQdigxyZj7FnvzFEelnrKivuY1eQozI/teZjHXxk
         3gzsLmXLIJWkwY03X+CFKCSiu/xWTQ2ns7bZO0itYin1uBnKBCuF2G4MFYo8l8+G1L/e
         eGB8PIFaOuS46/fBGonjRor5Ecggcqp17Z2Bdb+rsbYsG+SJFu030EVYC3nUR6TkxlzL
         i73ou/EAldHzqgJ6i9zEP+Qc4aeWndHXF/zR5ojE2NS4iRLpCE88Jvsz9a0BAYDTRNwb
         7nR6KRy2iqwEYi9dajwepE6TqDtM8vdLexOzu5v2MK4FnqAbdWV5zLtbShIIJKUy1m/W
         cQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=THlTesE5pnJpMjgygbUl5LvnGMnA21m3pPkRkHRIyLs=;
        b=LH9dlja4pyDFUyQcRk6pybfp6x1nT18Av+pHazexxCo8g7t9sWtSZM2rnic54qLru8
         sArW0R/vemsTFeCPP4KazwfJGX06GPEAH9AWRcwzC9JYHfFcXamdCIH0Cihzlsufv8Un
         EvptYijtEbXsY4ICStCjVIH9geDujO6yts+AUiS95WVZkTKkEallo+Yah93IIaptz0Uu
         obU/+G8QmcvRmcciaew5U2yaIyVSoXfYsvu8oiARIFm3DgK+4INCBGe6XlUDbQD2jneR
         9jXP6c436FC3SoUy9UpFGN88gSLRglHj1z4IcoM4J2qsdajfoyPiwt+DGsT5/UYJc0Bz
         SGwA==
X-Gm-Message-State: AOAM532Q5Od7f7d2rX9TAyZy/dGv8qaGmlO4iXUnJSc+yf8esvL37P7R
        YHHTOno8LTBPxksDJKVYjqIHK3gJzsPH
X-Google-Smtp-Source: ABdhPJyMtDwnipX5epw4YkS4utzdjUYPA/D8b775r+Ka5whUHULFYlklYKHj6Vj7ltUs18/KLnuSsg==
X-Received: by 2002:a17:902:f643:b0:14d:7b8f:14b3 with SMTP id m3-20020a170902f64300b0014d7b8f14b3mr6815131plg.19.1648139183818;
        Thu, 24 Mar 2022 09:26:23 -0700 (PDT)
Received: from thinkpad ([27.111.75.5])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm3356986pjt.11.2022.03.24.09.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:26:23 -0700 (PDT)
Date:   Thu, 24 Mar 2022 21:56:18 +0530
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
Subject: Re: [PATCH 06/25] dmaengine: dw-edma: Fix missing src/dst address of
 the interleaved xfers
Message-ID: <20220324162618.GP2854@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-7-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:17AM +0300, Serge Semin wrote:
> The interleaved DMA transfers support was added in the commit 85e7518f42c8
> ("dmaengine: dw-edma: Add device_prep_interleave_dma() support"). It
> seems like the support was broken from the very beginning. Depending on
> the selected channel either source or destination address are left
> uninitialized which was obviously wrong. I don't really know how come the
> original modification was working for the commit author. Anyway let's fix
> it by initializing the destination address of the eDMA burst descriptors
> for the DEV_TO_MEM interleaved operations and by initializing the source
> address of the eDMA burst descriptors for the MEM_TO_DEV interleaved
> operations.
> 
> Fixes: 85e7518f42c8 ("dmaengine: dw-edma: Add device_prep_interleave_dma() support")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 519d4b3c9fa0..2010d7f8191f 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -456,6 +456,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  				 * and destination addresses are increased
>  				 * by the same portion (data length)
>  				 */
> +			} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
> +				burst->dar = dst_addr;
>  			}
>  		} else {
>  			burst->dar = dst_addr;
> @@ -471,6 +473,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  				 * and destination addresses are increased
>  				 * by the same portion (data length)
>  				 */
> +			}  else if (xfer->type == EDMA_XFER_INTERLEAVED) {
> +				burst->sar = src_addr;
>  			}
>  		}
>  
> -- 
> 2.35.1
> 
