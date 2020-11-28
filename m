Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84EE2C70F6
	for <lists+dmaengine@lfdr.de>; Sat, 28 Nov 2020 22:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgK1Vul (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 28 Nov 2020 16:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbgK1Sw7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 28 Nov 2020 13:52:59 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879A8C09426B
        for <dmaengine@vger.kernel.org>; Fri, 27 Nov 2020 23:30:55 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w4so6019298pgg.13
        for <dmaengine@vger.kernel.org>; Fri, 27 Nov 2020 23:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9nnMCs5Hcj1B0InGqYhQt07I+A6doiLbezoJJTJwXWA=;
        b=wbFKyNzbY8f16WAqEtJ8FqnOuGFZqcWK/U19UhOH6E1P34pLSr2kN7MWgVcacV2Oro
         kgzm1Tn0Z2rzuKqPp02VRDIGs8Z4B81BKzy+MRz0X2ezjcgiim5IpzAl5ATqees6BR8f
         bJe+JF/sDekd77+g56HVAg8zwyRU/qqcHd67JVh4V7AIjTJDpJzt5rleBKJIe0ULbd7g
         EwRYMbi+B30d/97+a/uKP26Ym6wiRHlOQdi9zZIoG0uJJ8LsTbaoormtEUl7Ol/SUcOz
         voZE2QeLcEiTVzxoAJ/X9EFn6jXkdoDcR3ejbXstMv9tixmF4VaeUNOt3fCBDtQfthm0
         SaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9nnMCs5Hcj1B0InGqYhQt07I+A6doiLbezoJJTJwXWA=;
        b=KIXdsELtRY9cU6PRpZetg4wLPmm1wl+JRH4ierSkv6/zAYc7u635AsUvWUDDAWGVKD
         Y8KVQZneE8CARtTw1xtt7nCPEy9EV8Sp8dMyCjD2fNSQGrStMRH75B3Skok5jN00wb9A
         ei8oGtPxjqCn96YdcE/XSafAoxNg2Yc4q7PCIbpb7tHuZfRr/U3/CyxBuGeeL8MKK5PY
         OHB5tk9OngC0nD3H+zRZX3b6MtBqKnmJ/knG4sHtQIFxxvePBWzdXVfbBzQxMtpsb9ru
         hTeTyptJIx0CLdNS9EKwRdyqDMb8MtzjxOegz+HTP1r7wGX2JVikmxyXHAeV3WbQugVT
         jLkw==
X-Gm-Message-State: AOAM532Lb5QmV4veqD03j0usTgLUaL4HZju7skBl35zB+n5okZDck023
        uGOj5dnsUMTIz+Ys1svoOY7j
X-Google-Smtp-Source: ABdhPJwmAMGZ4p72YcZ59D9AL7LLjeO5FavXou0oGW2AwUi5z7FMu7aGHjEQSaGzVVeF1lmf3uyHsQ==
X-Received: by 2002:a63:da14:: with SMTP id c20mr9984661pgh.447.1606548655093;
        Fri, 27 Nov 2020 23:30:55 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id e22sm9676435pfi.83.2020.11.27.23.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:30:54 -0800 (PST)
Date:   Sat, 28 Nov 2020 13:00:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/18] dmaengine: owl: Add compatible for the Actions
 Semi S500 DMA controller
Message-ID: <20201128073045.GU3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <f2e9f718eb8c7279127086795a4ef5047fc186d5.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e9f718eb8c7279127086795a4ef5047fc186d5.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Nov 20, 2020 at 01:55:59AM +0200, Cristian Ciocaltea wrote:
> The DMA controller present on the Actions Semi S500 SoC is compatible
> with the S900 variant, so add it to the list of devices supported by
> the Actions Semi Owl DMA driver.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

I hope that you have verified both Memcpy and Slave transfers...

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/owl-dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index 9fede32641e9..54e509de66e2 100644
> --- a/drivers/dma/owl-dma.c
> +++ b/drivers/dma/owl-dma.c
> @@ -1082,6 +1082,7 @@ static struct dma_chan *owl_dma_of_xlate(struct of_phandle_args *dma_spec,
>  static const struct of_device_id owl_dma_match[] = {
>  	{ .compatible = "actions,s900-dma", .data = (void *)S900_DMA,},
>  	{ .compatible = "actions,s700-dma", .data = (void *)S700_DMA,},
> +	{ .compatible = "actions,s500-dma", .data = (void *)S900_DMA,},
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, owl_dma_match);
> -- 
> 2.29.2
> 
