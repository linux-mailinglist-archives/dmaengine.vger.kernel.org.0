Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68457525133
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344388AbiELPYN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 11:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355596AbiELPYJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 11:24:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E4F20EE07
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 08:24:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so8120186pjb.5
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wZ9fK0uQcOXF6KZtm59SA3PoAaj1ZmZIPuDsmvsxhvg=;
        b=unjy7OVrAJK4B5ZZwpszk8c42gcbCTZgQFBDKY4t7RLDiFhFmikPpcG8zNSa1GwW5g
         ZIpWe81H65ezBUGZeF4/30DZO86VLz2XykWOM+X/ldd9HU4QnaJomJua37FhCYO9VkVb
         K2dR7J9Ic9/jUaeMUxfjf/CsLznV0kJ0iJ+oSGu5uatF4Gh6MHB3FL4A984AtktbgSgs
         xlfEnlC47yD3wREAXLPwjChwLzBsR6jb/Dp8Us6uLGcxxbJcFhw1xwf3TXlJoGystAvs
         XAAyxhOg51ZWFLF4XtjGcybqLLKU2X0gqARb1WRxDdi2yq9Sz5OCcnKTL5g3HRZISYu0
         imHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wZ9fK0uQcOXF6KZtm59SA3PoAaj1ZmZIPuDsmvsxhvg=;
        b=SPuYmP5QeNueOljmrzQPm/aUEfzzTJrGEflrie03lvUZuHXkRldo8FAo36YZRvEI49
         wWijIEzEdVbE26Jh6RyvQDLBRZUocGfjTfLCZdNGklGLnD8u2pFDN1EGpMPFDKS8fc2X
         jfdr2yo73blhnxf/xztv6GAO8yRFQf0CeHn3mtLpzeWNB3jqksXGAKn0kjEAA8KgU7gQ
         7JZF0pjMz80wAjaakQyZw/Bte9EXJgb5POM1hb1dSM7hwi5augDeKO1CvvYkB5N/35KB
         Z0MPUGt/5llEIIZEZ/dcnizYw5Lqcr79V+OqZQ9rBaakBUtlAdo06ML6OG7V6Z84pqwL
         wGRA==
X-Gm-Message-State: AOAM531lXDhwgliNwE1lu7M10tjNUI88g8RWNpBORNxoMndlL5S2QH0Y
        BVFPXDOVb2+3pXT76UGi6PVt
X-Google-Smtp-Source: ABdhPJx5cgDgJuvo7bgLaWkO/6wh4Oa6GVVr7CBUY0HZkyXteomni4vqivunBkH4hPeIlnCdePTC8A==
X-Received: by 2002:a17:902:7d86:b0:15e:b761:3ca6 with SMTP id a6-20020a1709027d8600b0015eb7613ca6mr128925plm.56.1652369046791;
        Thu, 12 May 2022 08:24:06 -0700 (PDT)
Received: from thinkpad ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902e74b00b0015e8d4eb1d8sm71070plf.34.2022.05.12.08.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:24:04 -0700 (PDT)
Date:   Thu, 12 May 2022 20:53:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 24/26] dmaengine: dw-edma: Skip cleanup procedure if
 no private data found
Message-ID: <20220512152354.GO35848@thinkpad>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-25-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503225104.12108-25-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 04, 2022 at 01:51:02AM +0300, Serge Semin wrote:
> DW eDMA driver private data is preserved in the passed DW eDMA chip info
> structure. If either probe procedure failed or for some reason the passed
> info object doesn't have private data pointer initialized we need to halt
> the DMA device cleanup procedure in order to prevent possible system
> crashes.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

As I said in the previous iteration, I'm not sure we will hit this issue.
But I don't object the patch. So,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 908607785401..561686b51915 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1035,6 +1035,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  	struct dw_edma *dw = chip->dw;
>  	int i;
>  
> +	/* Skip removal if no private data found */
> +	if (!dw)
> +		return -ENODEV;
> +
>  	/* Disable eDMA */
>  	dw_edma_v0_core_off(dw);
>  
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
