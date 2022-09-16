Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065525BB046
	for <lists+dmaengine@lfdr.de>; Fri, 16 Sep 2022 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiIPPds (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Sep 2022 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiIPPdn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Sep 2022 11:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31407AE863
        for <dmaengine@vger.kernel.org>; Fri, 16 Sep 2022 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663342421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aiOGShZgtal0YCnERs7PQ39FdXhKpXc59WJYhtlfUyY=;
        b=F6U3Y+o3o1HbpsWBAN/yGLMf2Cwoxs3c9TMLr9dYy5WaLX8t4YOHQ+vh8CFJ8qjwAE+xa/
        ukjTL5ubXrkvzEccwIWH87yaFEckzlKkX581cjN+zWP8xvrNkO32T14lqYR/9PiNrgC9U3
        M3l8S7TxIWAgeJCWUHHICWPX9KgUm/Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-99-DvBfyFI2PkC-NSAEYjkZMw-1; Fri, 16 Sep 2022 11:33:40 -0400
X-MC-Unique: DvBfyFI2PkC-NSAEYjkZMw-1
Received: by mail-pj1-f71.google.com with SMTP id z8-20020a17090a014800b001fac4204c7eso6197pje.8
        for <dmaengine@vger.kernel.org>; Fri, 16 Sep 2022 08:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aiOGShZgtal0YCnERs7PQ39FdXhKpXc59WJYhtlfUyY=;
        b=qQsnlp1teIVOc7oSrMFE9jh/zBsiXDyEK1ZJNz8gxu0hkxNfDxpnFJXcgSBkQAUvvD
         9OCfGCbDn1YcxOZ1sfnixHq+EJ5YwgPt9QSD2OzqID0ZdSA8+FYb/uedSKURqm6OarCW
         8Ipn8iEi5fYgo7XLiX6alWzGa9WqNGc7YQqTvrlbALrFbB/jCpPChcVtNYs3PGVqwowC
         i4Wjv7ezmuks/DwVYyob3DodJixCXiHHoEyqCU4cEqBv54DFQuXUTXvXC78d5op/wwgj
         rhifb6BvAPPBk1HGNgmhaXWjVR6UjQsQcNRBEbgkdGfnLCwolQG3whpxf+jeHz0Ir1PY
         GleA==
X-Gm-Message-State: ACrzQf3NESaPgE+SrpilMZf1PJYVmef8HR0OSdYdcY3qXlhZbUOjfauY
        2T5aMubpFxfMUlckPXSCoDEkLGhGe1+vUZGnFtMUXGZF3J70DcRC0S3dSAyLir0njZpR9esf/uy
        BYyGe8gIGNmy4if5mspan
X-Received: by 2002:a63:e17:0:b0:42c:7046:3780 with SMTP id d23-20020a630e17000000b0042c70463780mr5170838pgl.352.1663342419062;
        Fri, 16 Sep 2022 08:33:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6gyY95wunf4Mx/KCccq/TtC0jyxgRo5edMj2YIdbSPRrLahzTfNsQBjp4u9IzHOOtsJ3iE2Q==
X-Received: by 2002:a63:e17:0:b0:42c:7046:3780 with SMTP id d23-20020a630e17000000b0042c70463780mr5170824pgl.352.1663342418758;
        Fri, 16 Sep 2022 08:33:38 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id y128-20020a623286000000b005360da6b26bsm14424109pfy.159.2022.09.16.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:33:38 -0700 (PDT)
Date:   Fri, 16 Sep 2022 08:33:37 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dmaengine: Fix client_count is countered one more
 incorrectly.
Message-ID: <20220916153337.5e65x5lwvzvz2cka@cantor>
References: <20220830093207.951704-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830093207.951704-1-koba.ko@canonical.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 30, 2022 at 05:32:07PM +0800, Koba Ko wrote:
> If the passed client_count is 0,
> it would be incremented by balance_ref_count first
> then increment one more.
> This would cause client_count to 2.
> 
> cat /sys/class/dma/dma0chan*/in_use
> 2
> 2
> 2
> 
> Fixes: d2f4f99db3e9 ("dmaengine: Rework dma_chan_get")
> Signed-off-by: Koba Ko <koba.ko@canonical.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/dma/dmaengine.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 2cfa8458b51be..78f8a9f3ad825 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -451,7 +451,8 @@ static int dma_chan_get(struct dma_chan *chan)
>  	/* The channel is already in use, update client count */
>  	if (chan->client_count) {
>  		__module_get(owner);
> -		goto out;
> +		chan->client_count++;
> +		return 0;
>  	}
>  
>  	if (!try_module_get(owner))
> @@ -470,11 +471,11 @@ static int dma_chan_get(struct dma_chan *chan)
>  			goto err_out;
>  	}
>  
> +	chan->client_count++;
> +
>  	if (!dma_has_cap(DMA_PRIVATE, chan->device->cap_mask))
>  		balance_ref_count(chan);
>  
> -out:
> -	chan->client_count++;
>  	return 0;
>  
>  err_out:
> -- 
> 2.25.1
> 

