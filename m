Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5134E67F9
	for <lists+dmaengine@lfdr.de>; Thu, 24 Mar 2022 18:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352361AbiCXRnz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Mar 2022 13:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352357AbiCXRnz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Mar 2022 13:43:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F7BB244B
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 10:42:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b13so2653598pfv.0
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ix5HG5X7RmrL9dqKstRw1McRJWsiK0E5jqwyDOBzbuM=;
        b=xfj3Sf7SWDJmay18REWrHUEbMiiizgTKly7sMrGNxPPdCYvY9Ch3QjLZJI4gktckpC
         UDBq7zZ/egwEHGSl9U16/DCC6mSzPcTxLERGrPNReQcGP8KwbpwxkE9ctyL+6m7kCRUp
         ojEPFW+1z5qtCZ6SKfr1kkMYaMTb2VBGXEyUWXqCk0CzzkebLk351MDTAJIN6dE5p8NO
         NtWuj6Sx+VHZrNtuQo+AXq2ja/yKDt7sJAo5uVJupZmS/an+vjp7WpTgu6SlgMxt/qBm
         H8XOXfcY+dvnFgniIZPq+VYitCyD3WPgLzuKaGA5JyP8TFt+nrVfftGM57173hD94PMi
         Jt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ix5HG5X7RmrL9dqKstRw1McRJWsiK0E5jqwyDOBzbuM=;
        b=Uz5jdnq/7ixHTiUgxy3Hc90zJWyfjIOqHkec011kTBgX4hDVCEazLAAFwo4sahNkNR
         y9OT3Y8BGYjaZKAsrQE7MtuUK3yJrSKh9Qsqt1eLvWsS1XKoUlRBm03YJAunwbMZYkvx
         9fVohovGimlD4Ge6AyEmGmLhzXbHQeAe9thVJVkwawYX7lfXist6XHdWVQLzpZkjSB/9
         0Si92IbQCp4qCoJYTGXnMvQ3gaN6O0lVtDk/+TQ1QIklu7aRswuxOcxl9SMOYPNxdO6f
         0tN+hzBD/iGx6BgZ8/I6+3etQJqHTv+vq/k5YQyOTsTYt4ADwn2hBqnhXbTV99ksPfYK
         76/Q==
X-Gm-Message-State: AOAM530EA1/MbtA+3gGcs05aoaIH4EtYh/Ij+xv3Kw4Cv4TCA/sU8ww/
        wy5OVkAXD+3o85HQkAH66vlr
X-Google-Smtp-Source: ABdhPJxiQ+OgZfcH81lzbRsE3Ak3wQ3W1on0G5tEEVL+3WsF550yVWf0drsfblSExo8Ivg5S5Q8nfw==
X-Received: by 2002:a65:6a4a:0:b0:380:fd52:1677 with SMTP id o10-20020a656a4a000000b00380fd521677mr4731957pgu.597.1648143742395;
        Thu, 24 Mar 2022 10:42:22 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id u37-20020a056a0009a500b004f820de3dcdsm4353788pfg.9.2022.03.24.10.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:42:22 -0700 (PDT)
Date:   Thu, 24 Mar 2022 23:12:15 +0530
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
Subject: Re: [PATCH 11/25] dmaengine: dw-edma: Drop chancnt initialization
Message-ID: <20220324174215.GT2854@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-12-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-12-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:22AM +0300, Serge Semin wrote:
> DMA device drivers aren't supposed to initialize the dma_device.chancnt
> field. It will be done by the DMA-engine core in accordance with number of
> added virtual DMA-channels. Pre-initializing it with some value causes
> having a wrong number of channels printed in the device summary.
> 
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 418b201fef67..cefa73412bf7 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -823,7 +823,6 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
>  	dma->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>  	dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>  	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> -	dma->chancnt = cnt;
>  
>  	/* Set DMA channel callbacks */
>  	dma->dev = chip->dev;
> -- 
> 2.35.1
> 
