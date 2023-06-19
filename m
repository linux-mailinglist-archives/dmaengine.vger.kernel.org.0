Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F8D735CDA
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jun 2023 19:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjFSRP6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jun 2023 13:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjFSRP4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jun 2023 13:15:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D521E133;
        Mon, 19 Jun 2023 10:15:54 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso1753825e87.2;
        Mon, 19 Jun 2023 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687194953; x=1689786953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5aYWsp6KbNeg2MOX/P43UYoIALiLHt3j0iMIOhhdmlE=;
        b=BmN9Mk80Pk9Ym6baqM3DnlOYhyiaMso3ZigbZSz1mhHjaDrRhEqfFDBmQrB5VR6nuX
         SewCKBFFMvL424WvDFbQqgc82TWDotFwPdS3VhLDiQFIOfCVQvaNElZgsDs9lUuhzDAH
         5k2mrcZKGNpJBmdGCTpuMlDPPaWiMTIXm5gM4yrGq5tJFNLDVwgrklQgd02BLTZwfP7a
         mkmcWZZdTj/cNE0Bf0iZ9MBtYhRpcK+ZaU72yQ9B8PknwKiDGFbon6V6O7Q5Lopw8C91
         6CipsTcX64gI7txbbTk7iGyUyVVWIFhOErvJs0qoycF6mczWlM2egbZ0ZLTfS1BiQ7eh
         Czlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194953; x=1689786953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aYWsp6KbNeg2MOX/P43UYoIALiLHt3j0iMIOhhdmlE=;
        b=DprPfPax4mLDDiwLwgnph1yFnfGb4mb+xmrMTR8Dj/uzSxKSLmVEzV0EOO2X0JPpnQ
         sGoycRhmM0lBhNtgammLCoPdqY1NmqLh58MsERMrdX+xwO1DoyY3NYv8QoX5VN95hZJQ
         1HBb+X5CVZdBfhYqqo0ari9aafyhPXlvsXIZWHa2kFPw1fJ+mZa8FhgJf5KIqiAzVGYD
         RUXXO5G1g6ReT55BL+JMeXN7pMeMTmiIOSs5E9TlZTL4Jn2QT8nFR+xFxMfDySGFXD/K
         Zh1sK0HuksZVq6pAQeRd/nqoFmQZ3g4tmjfDMEqkYRkT484v3SaOU+KqPUFl93VNnp0C
         E5Lg==
X-Gm-Message-State: AC+VfDyn3ghz8tUXKCBgDoVImlSanj+h/Yr9sZ9bW6cj45Ta7q089j2x
        4hr0A2Hg12am2WE1UiewQkR6xBRPRbw=
X-Google-Smtp-Source: ACHHUZ76hDLrxNh0ERjPVOjRpi6DyVvvGML4dNgAzJWTdUN8AWWoMYe5VOExYEEiSfW1Laso5AogZA==
X-Received: by 2002:ac2:5f9b:0:b0:4f3:78c2:2a6d with SMTP id r27-20020ac25f9b000000b004f378c22a6dmr5405123lfe.3.1687194952750;
        Mon, 19 Jun 2023 10:15:52 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id a9-20020a19f809000000b004f3a71a9e72sm12875lff.102.2023.06.19.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 10:15:52 -0700 (PDT)
Date:   Mon, 19 Jun 2023 20:15:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 5/9] dmaengine: dw-edma: HDMA: Fix possible race
 condition in remote setup
Message-ID: <20230619171550.3iyujmbre3dpe5oq@mobilestation.baikal.int>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230609081654.330857-6-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609081654.330857-6-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 09, 2023 at 10:16:50AM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> When writing the linked list elements and pointer the control need to be
> written at the end. If the control is written and the SAR and DAR not
> stored we could face a race condition.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Once again. Is this a hypothetical bug or have you actually
experienced the denoted problem? If you do please describe the
circumstances, give more details. Otherwise it sounds weird. Here is
why.

DW eDMA HW manual states that the control LL DWORD is indeed supposed
to be written after the rest of the descriptor DWORDs are written. But
AFAICS it's only relevant for the LL tree entries recycling. Current
DW eDMA driver design doesn't truly implement that pattern. Instead
the DMA transfer is halted at the end of the chunk. Then the engine is
recharged with the next chunk and execution is started over. So the
runtime recycling isn't implemented (alas) for which the CB flag of
the control DWORD needs to be updated only after the rest of the LLI
fields.

If you described a hypothetical problem then it would be ok to accept
the change for the sake of consistency but I would have dropped the
Fixes tag and updated the patch description with more details of the
race condition you are talking about.

-Serge(y)

> ---
> 
> This patch is fixing a commit which is only in dmaengine tree and not
> merged mainline.
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 0b77ddbe91b5..f28e1671a753 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -162,10 +162,10 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
>  	} else {
>  		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
>  
> -		writel(control, &lli->control);
>  		writel(size, &lli->transfer_size);
>  		writeq(sar, &lli->sar.reg);
>  		writeq(dar, &lli->dar.reg);
> +		writel(control, &lli->control);
>  	}
>  }
>  
> @@ -182,8 +182,8 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
>  	} else {
>  		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
>  
> -		writel(control, &llp->control);
>  		writeq(pointer, &llp->llp.reg);
> +		writel(control, &llp->control);
>  	}
>  }
>  
> -- 
> 2.25.1
> 
