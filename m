Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE7B53544C
	for <lists+dmaengine@lfdr.de>; Thu, 26 May 2022 22:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbiEZUPZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 May 2022 16:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiEZUPZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 May 2022 16:15:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B52DC5DB9;
        Thu, 26 May 2022 13:15:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso3445873wmh.3;
        Thu, 26 May 2022 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vOOSDW3LWjs9OtqRa5AjHsFDFKnXrZ6n3su1CfR2K0U=;
        b=R9/CTyhc+jxrwO9ltIj70JhtW081O78V2963+iUCrLpAvG/aBztOJIhagPr7atkw/8
         sk13EoAbCyRutWQDS/lfCx5UrRrHfXu5cEy5H3cSvYcrnk9NqRl8H3WguUunhgwJBgC5
         4QBrJ9b/m74QGd7Pmsa+a2KrYOmuPf43nKCO0KwyUQsFKTtgI+awTbkghatMSva/mZvW
         6uxBHsjqaPjxUAPVwcVh74ynmXf5hb1jZnAWDfB2DCPKR5OMnNmeAxNht3OxuS9JdpsC
         +EJDnhyrUzQXOEHfB84AgREfivY2Adl+VVlTPwRdPcDD7FaKRBYBZewHvDVpzTMPHw6h
         Df3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vOOSDW3LWjs9OtqRa5AjHsFDFKnXrZ6n3su1CfR2K0U=;
        b=zYeTx6ysG16IAAnphwSwwoKdaXYKN7IS3uiy6EEWsyo8fbvAzR3afP8dQRuNedFyOY
         qGVe/uuZCmsPN3Xkq1/5hlfcPkYWLGayB1eA6uaQC3g7uNAHPMavHRbT1dSQc5PNMK/1
         FCgfb+pExuJA8dzwLn15ZwF5v8Fg5oJuN9PFbmvyLvJKwrYf53IsZtGxVRYp94xcl6LN
         5vv9TVKsucOiQXAWks10nxQfekqzgPCo/K4jjnB0yY1f5HcfH656YIrRi19U1EEhkDmw
         kkbvFJqvesrBNTHJ+NRRTs49pyK0UktWkdHPGCUFENmoKJ5t4nHzjZDGA0DmptssPZZt
         Q1BQ==
X-Gm-Message-State: AOAM533R0bvxtXUdUi66vvXLbnUfdDW4ulnXnAajJNwsYDoqMGqWcEI8
        2RIHlc9gCDvrjNd6D2UVH8Q=
X-Google-Smtp-Source: ABdhPJzYh/cJdGeA8u+SrsyNUMeyVhGcq1i2fuxjTUcc2CKlFascKZcvvsHhlPIBG3t6V6hcm60yOA==
X-Received: by 2002:a05:600c:3b05:b0:397:54ce:896 with SMTP id m5-20020a05600c3b0500b0039754ce0896mr3791047wms.3.1653596118826;
        Thu, 26 May 2022 13:15:18 -0700 (PDT)
Received: from olivier-3493erg ([2a01:e34:ec42:fd70:8e84:c3a8:e5ed:7183])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d588f000000b0020fe86d340fsm110962wrf.55.2022.05.26.13.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:15:18 -0700 (PDT)
Date:   Thu, 26 May 2022 22:15:16 +0200
From:   Olivier dautricourt <olivierdautricourt@gmail.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     sr@denx.de, vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] dmaengine: altera: Fix kernel-doc
Message-ID: <Yo/f1F5wf1Tpaqoi@olivier-3493erg>
References: <20220525093313.52749-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525093313.52749-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 25, 2022 at 05:33:13PM +0800, Jiapeng Chong wrote:
> Fix the following W=1 kernel warnings:
> 
> drivers/dma/altera-msgdma.c:927: warning: expecting prototype for
> msgdma_dma_remove(). Prototype was for msgdma_remove() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/dma/altera-msgdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 6f56dfd375e3..bdaac5d62a04 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -918,7 +918,7 @@ static int msgdma_probe(struct platform_device *pdev)
>  }
>  
>  /**
> - * msgdma_dma_remove - Driver remove function
> + * msgdma_remove() - Driver remove function
>   * @pdev: Pointer to the platform_device structure
>   *
>   * Return: Always '0'
> -- 
> 2.20.1.7.g153144c
> 

Hello, thanks for reporting.

I notice now that another doc entry is misnamed:

drivers/dma/altera-msgdma.c:758: warning: expecting prototype for
msgdma_chan_remove(). Prototype was for msgdma_dev_remove() instead

Is it possible for you to fix this aswell ?
I also suggest using the full name of the driver in the commit message:
dmaengine: altera-msgdma: ...


Kr,


Olivier

