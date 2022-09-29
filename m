Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A401E5EFB69
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiI2Q5R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiI2Q5Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 12:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFFD1BB209
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664470634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ls8n7hJsgg/XBEwdI7SfnN0PoDTYd4YkxLZXvfSpw6o=;
        b=iGegMLL3tjNZ1nUUf3TQHcGJYQZXVXSvdU7HGLbmv3j5FPtY45SL6h79nsH7hNJOmgJ8cW
        o28Ms1KDnZ/3vaONqM71LsNuzIujwmUSdlzxWHYI5JxIbsyWmGrcxIb440Vl1NtP9TQBo0
        1Talu0zdyStPdWAVrgM9kVCtrBU2zEA=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-3F4nl4JgPXeiYV99yCyT2g-1; Thu, 29 Sep 2022 12:57:13 -0400
X-MC-Unique: 3F4nl4JgPXeiYV99yCyT2g-1
Received: by mail-oi1-f197.google.com with SMTP id a26-20020aca1a1a000000b0034fdf34de68so832099oia.12
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 09:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ls8n7hJsgg/XBEwdI7SfnN0PoDTYd4YkxLZXvfSpw6o=;
        b=ZM1fyWtzdRCvkEuN6i/S3h2+SMoMRtjqAteldVb96fY36/pcErtCUVGBUJLqokVGmC
         jokuuhdJma8ota0hkFiSfEUTGxRh/OnHJqG5SK+an0/8IyRCmVNcslVTSgDF9oIAw8yV
         Nt6Qzq6qPU6bQoraiWQePsUbCCzloo4cCYuRPNh/iyRJWjsLROaJ2fAL24fInpwNbrLO
         OU3SnO1B6oEHJ1NufBj9Z6ZyKFGGVtaez8pvoTlvWIlTiPilwSQMzlYLDWHQTFwMMvas
         dCXh3ExdhheSILLmIZDdDgkHePUaKYNiK1yYRVWn3NFRwSqo7f2hnyJFOGa0/tvW16cS
         d1SQ==
X-Gm-Message-State: ACrzQf07/xcsHgwbRSuJlP33ClHJJ6TNU5rUkoMp7iM0dL31Y0VGFAU1
        RLQH5i4W32KjEqoXf4Cm3qmDYEiKkENpHh+1uHPuUjvA0q0R3bg9jHkLdgH1a3VOUQnMaaBen04
        X7xyYSuK4ef3XFijEOe0f
X-Received: by 2002:a05:6870:630b:b0:128:828:5ec0 with SMTP id s11-20020a056870630b00b0012808285ec0mr2317762oao.249.1664470632611;
        Thu, 29 Sep 2022 09:57:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4x3JwzAv6PQPpQPp1JZjAv+x3RvEW7j9oQVP9QC65qyJ+hDROU6NZC7rfkAVrZxmR+FSTEcQ==
X-Received: by 2002:a05:6870:630b:b0:128:828:5ec0 with SMTP id s11-20020a056870630b00b0012808285ec0mr2317753oao.249.1664470632377;
        Thu, 29 Sep 2022 09:57:12 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id a11-20020acab10b000000b003450abf4404sm2886036oif.21.2022.09.29.09.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:57:12 -0700 (PDT)
Date:   Thu, 29 Sep 2022 09:57:10 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Koba Ko <koba.ko@canonical.com>
Subject: Re: [PATCH 3/3] dmaengine: Fix client_count is countered one more
 incorrectly.
Message-ID: <20220929165710.biw4yry4xuxv7jbh@cantor>
References: <20220830093207.951704-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830093207.951704-1-koba.ko@canonical.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Hi Vinod,

Any thoughts on this patch? We recently came across this issue as well.

Thanks,
Jerry

