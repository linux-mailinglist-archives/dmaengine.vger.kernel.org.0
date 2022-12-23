Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B81E654F44
	for <lists+dmaengine@lfdr.de>; Fri, 23 Dec 2022 11:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiLWKnQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Dec 2022 05:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiLWKnP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Dec 2022 05:43:15 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1AE13D4E;
        Fri, 23 Dec 2022 02:43:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso5105382wmb.1;
        Fri, 23 Dec 2022 02:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3sTp5JTfMAw1HdBsJay3H4/W2Fv/qdhk10DrSJkAUZE=;
        b=hvKBUAwrpUR51eiIcGjo6+MuoEOKYm5MljK1+R4gQH5DjjBk80ZzBkZhJGD4MJZY/A
         AoVqxhVv+AKlOZJm/ym2X44XSh3tRtR9HCBZcpasCl8RKyBqq6OvCePoG3KUSbIFpRq+
         yfVmrS06hior2EH4ivaK23FF4f5dKzp9juPXOWQO/gw1N7/JEd0nLhTr2kuwYGxq9iad
         clRao/Gj19w4+J3JDI49I27mE8VCV2A66EwZzuAz9+b1DzcVAqLO7SX3JhoBAkxTmsgV
         RTZfQHMh0+PwcveRwf6oVgWDtGkiSzK/o1VR66Ym4yWWEymB7Np5Egzoc1MbUxXF9O44
         B9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sTp5JTfMAw1HdBsJay3H4/W2Fv/qdhk10DrSJkAUZE=;
        b=PJtCrLYUnZVtZCB5ZEAoESEruZMBIJHg6LyMnoNPwt0SvBBkRtasHr8jx9E4wcO3r8
         E0ZKA0nnIr1ZCysQGUUCSA050nukzaHmY6VOpIHP9tSt+1A0ygmDmaKOpXbXt3t7DOsi
         J8rmvpRxHQSG49g9zdN0Fd6o2/MQB7jZyIJQs0FdUNCyi06OCyr5WR78L0oimKZoXWOg
         DfpH40C+uuO5ZsAhjlHI3t04f3rLsVELpntDVWKHUPNDqFCF2hKxJAj+0RblUX0+lUCu
         GJxtZEsy312ikku1QseHTKXXxnNqH4zsAv1qOkJpbIa4rvbDM5V7836ShxH1+nbMteHM
         uuIA==
X-Gm-Message-State: AFqh2kqjyibbobN4POKvteHjNwPR2U0h+BQ2mXlfAzv9g1CN3ml2717A
        sBf0RLwjw4Kkp4s71vTT+M4=
X-Google-Smtp-Source: AMrXdXuYojS3X51R0vF48LFu4TiFFMV/bLzPF78c4nTAwY3uXcAQwL+x8hCq72GF/yGAyjseUw9w4g==
X-Received: by 2002:a05:600c:1d98:b0:3d3:3d51:7d4b with SMTP id p24-20020a05600c1d9800b003d33d517d4bmr6605907wms.29.1671792192199;
        Fri, 23 Dec 2022 02:43:12 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c4f0700b003d96c811d6dsm2259091wmq.30.2022.12.23.02.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 02:43:11 -0800 (PST)
Date:   Fri, 23 Dec 2022 13:42:57 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: plx_dma: Fix potential double free in
 plx_dma_create
Message-ID: <Y6WGMd5hb2LoDyNL@kadam>
References: <20221220061752.1120381-1-linmq006@gmail.com>
 <31659f35-453e-2a5a-2f93-e35ef1395ad7@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31659f35-453e-2a5a-2f93-e35ef1395ad7@deltatee.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Dec 20, 2022 at 09:35:38AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2022-12-19 23:17, Miaoqian Lin wrote:
> > When all references are dropped, callback function plx_dma_release()
> > for put_device() will call kfree(plxdev) to release memory.
> > Fix the error path to fix the possible double free.
> >
> > Fixes: 07503e6aefe4 ("dmaengine: plx_dma: add a missing put_device() on error path")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> > Please correct me if I make mistakes, thanks for your review.
> > ---
> >  drivers/dma/plx_dma.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> > index 12725fa1655f..bce724ff4e16 100644
> > --- a/drivers/dma/plx_dma.c
> > +++ b/drivers/dma/plx_dma.c
> > @@ -546,8 +546,9 @@ static int plx_dma_create(struct pci_dev *pdev)
> >  	return 0;
> >  
> >  put_device:
> > -	put_device(&pdev->dev);
> >  	free_irq(pci_irq_vector(pdev, 0),  plxdev);
> > +	put_device(&pdev->dev);
> > +	return rc;
> >  free_plx:
> >  	kfree(plxdev);
> >  
> 
> 
> Sorry, after reviewing, I don't think this patch is correct.
> 
> plx_dma_release() is called from dma_async_device_unregister() which
> won't be called if dma_async_device_register() fails. It does not get
> freed when the pci device is put. So I don't think this is a possible
> double free.

I think instead of "double free" it Miaoqian meant "use after free".  It
does look like a use after free to me.  Certainly there is no harm from
applying the patch and it makes the code more obviously correct.

regards,
dan carpenter

