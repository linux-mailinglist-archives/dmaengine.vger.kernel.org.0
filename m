Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF035BB100
	for <lists+dmaengine@lfdr.de>; Fri, 16 Sep 2022 18:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIPQRB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Sep 2022 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIPQRA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Sep 2022 12:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DBEA0621
        for <dmaengine@vger.kernel.org>; Fri, 16 Sep 2022 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663345018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KwEng9FucssnnIBeze7eqp75KeUHUpdUwRdb+ybCBgM=;
        b=eGZ7y1I6ZAvh6QPAhU9YOaRH9tgi/z/LdqPW/ooAdX4ErWWLtYXsUHu3t+UADNnBa/cOBk
        4ZhKbJg94DICnLjmEEjaT5hBkQj+wyL9qa8MK34zIvV891fikg42wM0EvW5C+dp9EbrwZr
        gRuf/qaleDD3skkzciD/LEyaerZRfqE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-250-5-fBWjxONoevNRVMifcyyQ-1; Fri, 16 Sep 2022 12:16:57 -0400
X-MC-Unique: 5-fBWjxONoevNRVMifcyyQ-1
Received: by mail-pj1-f72.google.com with SMTP id b10-20020a17090a12ca00b002034af352d0so75040pjg.3
        for <dmaengine@vger.kernel.org>; Fri, 16 Sep 2022 09:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KwEng9FucssnnIBeze7eqp75KeUHUpdUwRdb+ybCBgM=;
        b=iL3jSZl9XWXH5pHzFRE5Fz3VK87wD5e6jQyE3OCW/6lU699F3tHNcf9K96DNDKam6A
         u3ps2VG+Rw/Hvh/7ApN+Fbnf8/uGoCSNjiMZPZfO+1qP0sU47MV2d0TBVf/lf02ztIrj
         yXVrZjo+/eVVgEXIvKIERuiW2Bz5OJqviwEV2lX7x6eCte8MgH3/b57kGZpWCc9VYRph
         I3YjjEC0sENyVXuLO1xkSvnuPoPxRk47BNsqkIHx6lIWN3gwq0bd4rx7g8CCfSPh07SR
         L+rRC4OG1yLHisJEgN/o+Ept1zFAD8jJSolqtOCE3F3QfRG1l9BwvH5HOYhe1YLPvc63
         HIlw==
X-Gm-Message-State: ACrzQf2OQucSCjr80Hj7+7W7jfAtxiDjbfxpev7aHP3ZZK14l2zcx74D
        bfBLQItRMoSwUSsolaEC1XQP7d2riSdBmz8gWWISBfc46YpRPV6fNIK21SPhl7HfhtCjKIFfU4G
        /xp8N7yyi1qc1QUlcMnok
X-Received: by 2002:a17:902:f68d:b0:178:41dd:12ad with SMTP id l13-20020a170902f68d00b0017841dd12admr582462plg.25.1663345016308;
        Fri, 16 Sep 2022 09:16:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM77LEaMvjhloYYf+FRwLwX4XS5s5sSAr48vT0DTyFaYIAHO2hbQIIjTGSiWfwyCQoaR1CnaEw==
X-Received: by 2002:a17:902:f68d:b0:178:41dd:12ad with SMTP id l13-20020a170902f68d00b0017841dd12admr582438plg.25.1663345016002;
        Fri, 16 Sep 2022 09:16:56 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id mv12-20020a17090b198c00b002000dabc356sm1667532pjb.45.2022.09.16.09.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 09:16:55 -0700 (PDT)
Date:   Fri, 16 Sep 2022 09:16:54 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix memory leak in idxd_alloc()
Message-ID: <20220916161654.2hld2iog54yagmxe@cantor>
References: <20220914230815.700702-1-rafaelmendsr@gmail.com>
 <20220916153640.qtb74i63upcncpuw@cantor>
 <a486a70a-6238-567a-d6a2-32e1269711cd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a486a70a-6238-567a-d6a2-32e1269711cd@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 16, 2022 at 08:49:25AM -0700, Dave Jiang wrote:
> 
> On 9/16/2022 8:36 AM, Jerry Snitselaar wrote:
> > On Wed, Sep 14, 2022 at 08:08:14PM -0300, Rafael Mendonca wrote:
> > > If the IDA id allocation fails, then the allocated memory for the
> > > idxd_device struct doesn't get freed before returning NULL, which leads to
> > > a memleak.
> > > 
> > > Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
> > > Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> > I think there needs to be a kfree(idxd) where it checks rc < 0 after the call to dev_set_name() as well, yes?
> The idxd_conf_device_release() should take care of freeing idxd with the
> put_device(). So I think we are good here.

Ah, right. Thanks.

Jerry

> > 
> > Regards,
> > Jerry
> > 
> > > ---
> > >   drivers/dma/idxd/init.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > > index aa3478257ddb..fdc97519b8fb 100644
> > > --- a/drivers/dma/idxd/init.c
> > > +++ b/drivers/dma/idxd/init.c
> > > @@ -445,8 +445,10 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
> > >   	idxd->data = data;
> > >   	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
> > >   	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
> > > -	if (idxd->id < 0)
> > > +	if (idxd->id < 0) {
> > > +		kfree(idxd);
> > >   		return NULL;
> > > +	}
> > >   	device_initialize(conf_dev);
> > >   	conf_dev->parent = dev;
> > > -- 
> > > 2.34.1
> > > 

