Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3682F665C18
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jan 2023 14:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjAKNFN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Jan 2023 08:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjAKNFB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Jan 2023 08:05:01 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9609E0BF;
        Wed, 11 Jan 2023 05:04:59 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m6so23387511lfj.11;
        Wed, 11 Jan 2023 05:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wnJbYGoqAVjr8cFTcnARD5WZ3YOrip7EeeMWU73j5I=;
        b=fm8i7M7uvSN5s8fxj/6VURlNR03iFXw8QomM4Tuq7QQD2RCy8cUVQBF2Vh/0Ecs4/8
         u8EXU3vTKiOH4Csweq90FtX+RFgqYyfVHCJm+9bpoQhkJ1cF4vNW/DB+XtenGR5C4Zie
         BpWPv3d2x40AbshJZkQEKMjcGFjfAgHMcQ3arL+AXCY1xVZInucA3ML3csWz/2scGFY5
         2tLT4luLo7UU41313fQpEQK840hcy7Z6GtWIWHAoSppIHKFOyzoLHF5TBU7Syu+1BKwS
         uIcH6ehm46CCeWtjpkAwNQ9g11fWa7k0UrYuDzlEOnK4CgO4x03w480SPptycaLIn7o+
         BXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wnJbYGoqAVjr8cFTcnARD5WZ3YOrip7EeeMWU73j5I=;
        b=r6bzsDTh6kCMsgr+B6Qoxm1ZbDpPSAsn09fObbsoUSpyidGyKAJG2lKGFxov2ux1UZ
         +KwvHpWTRG6q60ej6ZfSyTemPH6lD5EKnfWvVoulq6cc48x8xvcgIpJOURQEh6r4AFiD
         Fux9+l9yl4aLg711q9ifajPtdPjDPLJkVghhtMTOTrjPzI7gFob17HBDxAu2op6OVV8p
         3ua7KTQ2/B+nLEE6IGBY6b6m1lpBzuU851zoe1W3A6meQi789lb5+u0xN2u73L4asEQ0
         kmWfYNFQirbkN5c2cYA7Myrx79v07Ez7a5yo+w3mabRG0jTmddxi5q4rNeq0Yogm18iR
         F9MQ==
X-Gm-Message-State: AFqh2koVmMgAH6T5R6dqqkYy6z0eq4cHRZp5PHTfKFV4LqsZuRZd7BWm
        uIc+MgT986MdAunYT1Bd6wA=
X-Google-Smtp-Source: AMrXdXvTMIAjCuI9wIGpnqJBRgu0IfWZWFjEjPng+TqzMu0FF+vZUDWztorchhNinNBMj1izs0hf2w==
X-Received: by 2002:ac2:4ec6:0:b0:4b6:eb36:e73e with SMTP id p6-20020ac24ec6000000b004b6eb36e73emr18180243lfr.17.1673442298197;
        Wed, 11 Jan 2023 05:04:58 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id g7-20020a056512118700b004cc885ea933sm1071694lfr.192.2023.01.11.05.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 05:04:57 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:04:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: remove redundant config PCI
 dependency for some Synopsys DesignWare eDMA driver configs
Message-ID: <20230111130455.lvdjkpo3l62fhh3a@mobilestation>
References: <20230111121637.24708-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111121637.24708-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 11, 2023 at 01:16:37PM +0100, Lukas Bulwahn wrote:
> While reviewing dependencies in some Kconfig files, I noticed the redundant
> dependency "depends on PCI && PCI_MSI". The config PCI_MSI has always,
> since its introduction, been dependent on the config PCI. So, it is
> sufficient to just depend on PCI_MSI, and know that the dependency on PCI
> is implicitly implied.
> 
> Reduce the dependencies of configs DW_EDMA and DW_EDMA_PCIE.
> No functional change and effective change of Kconfig dependendencies.

Indeed. Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/dma/dw-edma/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
> index 7ff17b2db6a1..0408e515b2f3 100644
> --- a/drivers/dma/dw-edma/Kconfig
> +++ b/drivers/dma/dw-edma/Kconfig
> @@ -2,7 +2,7 @@
>  
>  config DW_EDMA
>  	tristate "Synopsys DesignWare eDMA controller driver"
> -	depends on PCI && PCI_MSI
> +	depends on PCI_MSI
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help
> @@ -11,7 +11,7 @@ config DW_EDMA
>  
>  config DW_EDMA_PCIE
>  	tristate "Synopsys DesignWare eDMA PCIe driver"
> -	depends on PCI && PCI_MSI
> +	depends on PCI_MSI
>  	select DW_EDMA
>  	help
>  	  Provides a glue-logic between the Synopsys DesignWare
> -- 
> 2.17.1
> 
