Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1D5606A22
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 23:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJTVVM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 17:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJTVVL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 17:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56AA186D64
        for <dmaengine@vger.kernel.org>; Thu, 20 Oct 2022 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666300869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AA2M5leJeq7b+d2td2zMq5XehgNBJAzySGkTKsCwEm8=;
        b=A7PaFbsZSJnDtJAIfD0E1cMShb9kObmy0AyrV4yj4pS7IjNKtTTxPPiuhkQRrN71uT/E6p
        pHuy0MkxC14xF1iCkjDVEkDHN4/ryQtSiw3tAGYYYIWYPUQCm7iiLDOJ7z+qX7tenTTZCe
        /zPud3iW/VKYZYWpx17qPaJxQiLzd5g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-LR2RPGN8O5eIIBJdralj8A-1; Thu, 20 Oct 2022 17:21:07 -0400
X-MC-Unique: LR2RPGN8O5eIIBJdralj8A-1
Received: by mail-qv1-f72.google.com with SMTP id np19-20020a056214371300b004b3b9ee8365so571560qvb.16
        for <dmaengine@vger.kernel.org>; Thu, 20 Oct 2022 14:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA2M5leJeq7b+d2td2zMq5XehgNBJAzySGkTKsCwEm8=;
        b=a0fcWSoKnnXH43luag+4PfUR+CAHHTE6dpmhXvoqk9aIO32VAd2VSU+lSaiUnq2iLg
         n7B3zbuBrRo7tv4G5QoqcW8oAf4vRYbykPvv0cy1Dx3vt8QGGCB1y2fWEMtgDRnY40n3
         QZiTMlFNQ0W4d9VrX01CEuHUgGFrSYvMkx5rnD+wHrKI5lANrTxFJdfA9rdLg1vNNiWN
         0ZZA94Yckh3wo8XWi4CI2rlpcHXLg+MHq4DJNdAiIbTBSrF9dRQ8FLTwJPy7DMvapt/T
         ACxTNwAAT3s7tGaRbfhumVOllOf6P7fe5oKXaZuLmchAht4yUM2H2unz2lMLvze8xWj9
         D0uw==
X-Gm-Message-State: ACrzQf11ytgYt1aaCpCbTGd/gpC1CfYDRtrAMA3ykliWrNaAVd90Ers7
        ++Sf4d34CCZhrPaRyzzFCIkTaR40J9fnpoR7obVnewnZs6LNq6qFDZGxr6PKihEBdbhqhtDpiXv
        X1FwkqMOJ6dElLrBVuZPD
X-Received: by 2002:ad4:5be7:0:b0:4b3:fe6c:904b with SMTP id k7-20020ad45be7000000b004b3fe6c904bmr13708633qvc.42.1666300867014;
        Thu, 20 Oct 2022 14:21:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Hs5U6ncrVol+hsN5yZMEPMktQU/xAp7xartWm+0sbZ7nARBntvRczWGYfvUo9Z7IFCGsX9A==
X-Received: by 2002:ad4:5be7:0:b0:4b3:fe6c:904b with SMTP id k7-20020ad45be7000000b004b3fe6c904bmr13708621qvc.42.1666300866811;
        Thu, 20 Oct 2022 14:21:06 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006e16dcf99c8sm8261171qko.71.2022.10.20.14.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:21:06 -0700 (PDT)
Date:   Thu, 20 Oct 2022 14:21:04 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org
Subject: Re: [PATCH] dmaengine: fix possible memory leak in while registering
 device channel
Message-ID: <20221020212104.toaz5drpyf6jji3c@cantor>
References: <20221020063830.3013799-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020063830.3013799-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Oct 20, 2022 at 02:38:30PM +0800, Yang Yingliang wrote:
> Afer commit 1fa5ae857bb1 ("driver core: get rid of struct device's
> bus_id string array"), the name of device is allocated dynamically,
> if device_register() fails, it should call put_device() to give up
> reference, the name can be freed in callback function kobject_cleanup().
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/dma/dmaengine.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index c741b6431958..46adfec04f0c 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1068,8 +1068,11 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  	dev_set_name(&chan->dev->device, "dma%dchan%d",
>  		     device->dev_id, chan->chan_id);
>  	rc = device_register(&chan->dev->device);
> -	if (rc)
> +	if (rc) {
> +		put_device(&chan->dev->device);
> +		chan->dev = NULL;

Doesn't this leak the memory that was just grabbed with the kzalloc() call at
the beginning of __dma_async_device_channel_register() since now kfree() is
going to passed NULL?

Regards,
Jerry


>  		goto err_out_ida;
> +	}
>  	chan->client_count = 0;
>  	device->chancnt++;
>  
> -- 
> 2.25.1
> 

