Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A7C52504B
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355439AbiELOjK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 10:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355435AbiELOjJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 10:39:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF42532CE
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 07:39:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j14so5069703plx.3
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RpvA14mopi2wM/0/4s7P6t9yjcv8sVd/ys9twTz6XHs=;
        b=IwjrKmELqe++qDbcjrB0VrUfg6crocNU1xe5lMxp6nWDAzOL5RWRRt8saVMkiGySTi
         oFhpr/l7d61NIYvJG9xPdiXKeej6OyIZFHq7456kaCwqyz0g5bKVMdETsAH1TBVFFayr
         rlNG/yc6J6myUNMWB6CFQ8qjTTUSzLwGSQTawUMIPH1LQ1wIQ39pAcWNRk4Wy4HpF9Q5
         1GqUU7aWjlfmKZtqOwn+axFPpEsVq+5jqEMW2ZvjYj4y421WNHqCgfnk7QPDI/12rh7C
         QNy2f3yAt3shWmOImGNjA8N37MhIMQs0iwYguP2rDjiZtaWS4/AE0VDsyJqe0dlJnArm
         Ptvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RpvA14mopi2wM/0/4s7P6t9yjcv8sVd/ys9twTz6XHs=;
        b=zi0wGxjty1HQ4SAc0ZkwW0TySlH9xSCI5LbDAjH2fPsQ9jvQGCdFhGkqlbyV7dd0UG
         7XoTboWAQRhXJfLkXqLlFhWaE2WDYMenNC65NOEb8HET9at6zBdYyCba66HXtaCPSlMK
         UGKTlRDSgvEWRzU/UEGe/lUNj05naNbov0OU8QgBg89Za7jazKj3lGPawTkHOn83xzJG
         dH8XjfGwx+EXP0+rLwePmubopYi/DgQ8KcUnqP4YcEJbuIBrC/25eyKyK02TcIAug+XN
         OaAZ9KfbX7TgdqTOiWBDpuZb0W/gvoIvkatIfNa8oV2qZbrZFNjFCJr3grDDsQeZmT39
         xG2Q==
X-Gm-Message-State: AOAM530sAjsDdhNr+malBkPeh35WqnBnn1YCqInsDjVO8/A3hkCVd217
        zbEjG8RaT2GjwUNBzkOuxiFJ
X-Google-Smtp-Source: ABdhPJzGX4QVR+Nu2JITJr/b8RNE+XCcktTJ7Bx+sADcWNFJ0GnMQN2f39XlXIhEaWDxYRZWAK1HHw==
X-Received: by 2002:a17:902:f710:b0:15f:165f:b50b with SMTP id h16-20020a170902f71000b0015f165fb50bmr276822plo.158.1652366348217;
        Thu, 12 May 2022 07:39:08 -0700 (PDT)
Received: from thinkpad ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id 72-20020a62154b000000b0050dc762816bsm3852511pfv.69.2022.05.12.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:39:07 -0700 (PDT)
Date:   Thu, 12 May 2022 20:09:00 +0530
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
Subject: Re: [PATCH v2 03/26] dmaengine: dw-edma: Release requested IRQs on
 failure
Message-ID: <20220512143900.GH35848@thinkpad>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503225104.12108-4-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 04, 2022 at 01:50:41AM +0300, Serge Semin wrote:
> From very beginning of the DW eDMA driver live in the kernel the method
> dw_edma_irq_request() hasn't been designed quite correct. In case if the
> request_irq() method fails to initialize the IRQ handler at some point the
> previously requested IRQs will be left initialized. It's prune to errors
> up to the system crash. Let's fix that by releasing the previously
> requested IRQs in the cleanup-on-error path of the dw_edma_irq_request()
> function.
> 
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> 
> ---
> 
> Changelog v2:
> - This is a new patch added in v2 iteration of the series.
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 07f756479663..04efcb16d13d 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -899,10 +899,8 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  						dw_edma_interrupt_read,
>  					  IRQF_SHARED, dw->name,
>  					  &dw->irq[i]);
> -			if (err) {
> -				dw->nr_irqs = i;
> -				return err;
> -			}
> +			if (err)
> +				goto err_irq_free;
>  
>  			if (irq_get_msi_desc(irq))
>  				get_cached_msi_msg(irq, &dw->irq[i].msi);
> @@ -911,6 +909,14 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  		dw->nr_irqs = i;
>  	}
>  
> +	return 0;
> +
> +err_irq_free:
> +	for  (i--; i >= 0; i--) {
> +		irq = chip->ops->irq_vector(dev, i);
> +		free_irq(irq, &dw->irq[i]);
> +	}
> +
>  	return err;
>  }
>  
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
