Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D955BB04E
	for <lists+dmaengine@lfdr.de>; Fri, 16 Sep 2022 17:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiIPPgr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Sep 2022 11:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiIPPgq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Sep 2022 11:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C0FA0610
        for <dmaengine@vger.kernel.org>; Fri, 16 Sep 2022 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663342605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rcDieOXWzwDYad3Or3UKN2ift/v1pBenSYpheluB7r0=;
        b=EQTYNQ03vw8wS27zVMkxPWkupBDIzAi0sqw2Quj8rYhNTtKoqDaByNyCYHHaxYCFooUUN7
        eI7ySCC3wgwjgSmovXuueEFqqJMaYhK6Su71M4dkv0djgUvYnGMWOGizRZa1fa2TOiy8eE
        D8bXa9nYN+2UbZHHFYVAZnMZrzub0Ik=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-tM75hB4aPp2juRwRb8elSg-1; Fri, 16 Sep 2022 11:36:44 -0400
X-MC-Unique: tM75hB4aPp2juRwRb8elSg-1
Received: by mail-pl1-f198.google.com with SMTP id l2-20020a170902f68200b00177ee7e673eso14959296plg.2
        for <dmaengine@vger.kernel.org>; Fri, 16 Sep 2022 08:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rcDieOXWzwDYad3Or3UKN2ift/v1pBenSYpheluB7r0=;
        b=SvEVqcebB/2eTiW5/WV1MhPq1LiAiSEvyp1WrkMNkZIjaeFq8vz/O3UqFSBJlxdbqY
         D1aMFx8xssKBsh/56fjM2yRri556y1CuqzdqQxQUOTI3fEmxfHlDdUc1Y7zib2QuzW54
         KjfEul4Xbi1eClhXrdFeCc7NvqGMxdSdjfVSAL0e8kljXhud24f4Ibm7XKHh6QiyOVx+
         vhPKpEEC59pY73NCsEca+jUWeWC4CKgWh96bS/Sjj3VTmmuAKccqDl2T2wAApg5o4n7Z
         cFO70ISWEe6God1gjjm2z271VHfg4hrD4xp5UbJsqIMDC9uExURGzmFJ9RUDsUHT4ZJs
         qUsg==
X-Gm-Message-State: ACrzQf0ZBNSGbh+IwdWMh8nm1H63E++1YFU4qe6aOtYbYMpiaO1WrehY
        AwXfXQDUJFGNNEIiWqeH7z9pC4bkaJ9t6BLskMvPn+UdBrFdzc5jQUrOJRQCdxnp2Cku8j4iR5f
        /+q9eCnAbZVLJZWwqFz2t
X-Received: by 2002:a17:903:11c4:b0:178:634b:1485 with SMTP id q4-20020a17090311c400b00178634b1485mr416682plh.142.1663342602566;
        Fri, 16 Sep 2022 08:36:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5MxN5GDaKAW0gIQvMUlsiHS3eu5jYGdQYwFNbFfi1lYWJxmztLq24GWXq+Lik+GfMhgVaU3Q==
X-Received: by 2002:a17:903:11c4:b0:178:634b:1485 with SMTP id q4-20020a17090311c400b00178634b1485mr416662plh.142.1663342602257;
        Fri, 16 Sep 2022 08:36:42 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p20-20020a63e654000000b00434abd19eeasm13592258pgj.78.2022.09.16.08.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:36:41 -0700 (PDT)
Date:   Fri, 16 Sep 2022 08:36:40 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix memory leak in idxd_alloc()
Message-ID: <20220916153640.qtb74i63upcncpuw@cantor>
References: <20220914230815.700702-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914230815.700702-1-rafaelmendsr@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

I think there needs to be a kfree(idxd) where it checks rc < 0 after the call to dev_set_name() as well, yes?

Regards,
Jerry

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

