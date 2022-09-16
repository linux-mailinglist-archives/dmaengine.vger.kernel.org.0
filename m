Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46D5BB102
	for <lists+dmaengine@lfdr.de>; Fri, 16 Sep 2022 18:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIPQRS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Sep 2022 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiIPQRP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Sep 2022 12:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F19B602D
        for <dmaengine@vger.kernel.org>; Fri, 16 Sep 2022 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663345033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N2Tln14Ocv6kONUatrxC5kt37vjmPJnPDfeEkInI1oc=;
        b=C+hFCJjau6OptkSxbakZ6zwhF4KOEfzdn1UadnShg72cfVTqYFaUcbbJEtK3XX5qb6nGMM
        w+sGYlPD4uJuER8mW7pXrAD2l/IVBjmsljLfmK5jtEwb8KH4kTo1KuP0/7arOA2Kht98gZ
        uFZ3AGyGIny3wNNzndihvDrprLmFtR4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-151-Tv0WgTzyOzGPxLTiRTyWug-1; Fri, 16 Sep 2022 12:17:11 -0400
X-MC-Unique: Tv0WgTzyOzGPxLTiRTyWug-1
Received: by mail-pj1-f71.google.com with SMTP id 2-20020a17090a0b8200b001fdb8fd5f29so11020205pjr.8
        for <dmaengine@vger.kernel.org>; Fri, 16 Sep 2022 09:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=N2Tln14Ocv6kONUatrxC5kt37vjmPJnPDfeEkInI1oc=;
        b=K7Unhragy/wu8MkY7CETA4kIXsTTgaxyvzYwx6UPHBaVB4dO0qGV7DpctjgFUEG27o
         XPLMa1bw7czLAv55SYb/aoEjZGl12+3jgCEoNfpQuoRBkyOHP9ozYWQpskFdrar3tMkH
         zs+1HVZbI++E+XEsAhAbbkLKSDPyWjprxlWqMiX+QoXL7sk1l2fiFH2NFtEY8TcKlKVh
         nuaSV+NvnodMhgbE3ETHviMVNjPKSguRxj0ZUNLxIgOchtwHNB3zP2Pr5UKrk/mAT1fg
         uLCfqYvKpYCRGFmS4AhsnyCaPtO1KJncPlAilugAQUbP9pthFcbkZmUrHaE4+pgxAt7W
         lSTQ==
X-Gm-Message-State: ACrzQf2R+jXu735o/DPSzO8Y0qeQaXnBTj0iPC6HXSIUaYwK04nx/VAY
        L7s2bNuscUiPLTDDFLG8cpz5SOROHfQwKwDyT/1+CZP7qeG3YUl4Xv9a253xj5MAr3Lg9E6eKE4
        OxUQaQbZvvwBJ6za1Uz2b
X-Received: by 2002:a17:902:7281:b0:178:388d:6f50 with SMTP id d1-20020a170902728100b00178388d6f50mr573445pll.127.1663345030623;
        Fri, 16 Sep 2022 09:17:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6X3Z9Gc3KaRdSev7M6ptsUUTZgZuBwPComTkQd67+aT/x+WuOixIxbO2qzm9/ewt/KUM4jKg==
X-Received: by 2002:a17:902:7281:b0:178:388d:6f50 with SMTP id d1-20020a170902728100b00178388d6f50mr573424pll.127.1663345030380;
        Fri, 16 Sep 2022 09:17:10 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902dc8100b0017508d2665dsm15100299pld.34.2022.09.16.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 09:17:10 -0700 (PDT)
Date:   Fri, 16 Sep 2022 09:17:09 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix memory leak in idxd_alloc()
Message-ID: <20220916161709.p6srrszdp2qz2nmp@cantor>
References: <20220914230815.700702-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914230815.700702-1-rafaelmendsr@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Sep 14, 2022 at 08:08:14PM -0300, Rafael Mendonca wrote:
> If the IDA id allocation fails, then the allocated memory for the
> idxd_device struct doesn't get freed before returning NULL, which leads to
> a memleak.
> 
> Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/dma/idxd/init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index aa3478257ddb..fdc97519b8fb 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -445,8 +445,10 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>  	idxd->data = data;
>  	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
>  	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
> -	if (idxd->id < 0)
> +	if (idxd->id < 0) {
> +		kfree(idxd);
>  		return NULL;
> +	}
>  
>  	device_initialize(conf_dev);
>  	conf_dev->parent = dev;
> -- 
> 2.34.1
> 

