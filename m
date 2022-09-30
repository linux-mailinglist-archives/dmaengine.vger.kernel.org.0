Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14805F0458
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 07:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiI3F41 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Sep 2022 01:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiI3F40 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 01:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00A11DFC6
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 22:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664517384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7TrrdqQkn5Ywi1UInDIe/lWyDEGIFczuNi867ARG5mM=;
        b=Uadb3kIhEMue/AvpoA/ohR3CDRMENk6VpT5nLA3tU3S3Ten5lgeSk71DBsXHI5WwU2bdrj
        W6HrhN9xD8Gdfpu4TbW6AiLWyGjzkfmKGxYYdB/rm6km+DPQpJFtvOEno6rtW4MZeH9f4U
        06zkhYWIeKEIT3NSprNVKZv2A5at4jg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-FOJOGZaPP4yOAA4MlHbZ2g-1; Fri, 30 Sep 2022 01:56:21 -0400
X-MC-Unique: FOJOGZaPP4yOAA4MlHbZ2g-1
Received: by mail-qv1-f69.google.com with SMTP id mo5-20020a056214330500b004ad711537a6so2307290qvb.10
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 22:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7TrrdqQkn5Ywi1UInDIe/lWyDEGIFczuNi867ARG5mM=;
        b=aFTNxxfNXBdsR4pT9Y89HRH79a6f5X+LBQDZKt2UOhpk014rA24auK/l1wYB11cfsQ
         6aQewSYF7xv5sogPTc/wB6KxP4dLGyhYhPHMsSzAD8gwzvfbh5uYOkxJrUxx+9bM9TpY
         BjYzMf/ILC8repwqvnwFjuxevshM2a2p+H0Y2ZaV2WvzLa22Ugy8ODBNZBF3s3u6MUBH
         WA3ZcgdcZYRZrwcPmOxgwJnMDFO1tQETEDpqApQJUyPfhhRaWbogmkWdlFjBM8mrtsiu
         Dw66UTUOR32s5Kzpl//+YkXDaxrYql0yfuOhmAWJHeq8ANJMCO4qxS++2zzSBH6u95A8
         VeqQ==
X-Gm-Message-State: ACrzQf3KQ2s4IHqFWz7BZmd50yXQXDjFenF1grOolXyasE9BZW9RkDAX
        F9i0R1SQbM7kwEVTdIT7u6teb09p0pHI1oupbSaSZ/OtrsOetxjDKKUw2OOHQliL4I4xEiZavGW
        qrfPU2Ah5ErpowuRVS3J0
X-Received: by 2002:ac8:58cc:0:b0:35b:a5af:2a95 with SMTP id u12-20020ac858cc000000b0035ba5af2a95mr5504278qta.381.1664517381204;
        Thu, 29 Sep 2022 22:56:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5gLsmZfGcMB6zbDGMgSUdfdxpbYkYgIyqNgyV8AN/w99lgeycysmp/WbY0faMiX/nXpmSzIQ==
X-Received: by 2002:ac8:58cc:0:b0:35b:a5af:2a95 with SMTP id u12-20020ac858cc000000b0035ba5af2a95mr5504272qta.381.1664517381006;
        Thu, 29 Sep 2022 22:56:21 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a284c00b006cebda00630sm1320488qkp.60.2022.09.29.22.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 22:56:20 -0700 (PDT)
Date:   Thu, 29 Sep 2022 22:56:19 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dmaengine: Fix client_count is countered one more
 incorrectly.
Message-ID: <20220930055619.ntgr2yobc5euzz6y@cantor>
References: <20220830093207.951704-1-koba.ko@canonical.com>
 <20220929165710.biw4yry4xuxv7jbh@cantor>
 <YzXRbBvv+2MGE6Eq@matsya>
 <4394cae0b5830533ed5464817da2c52119e30cea.camel@redhat.com>
 <CAJB-X+XYq6JRewKkPu0OSnEhJAsW5qFcs2ym2c+wErxWgoXGDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJB-X+XYq6JRewKkPu0OSnEhJAsW5qFcs2ym2c+wErxWgoXGDA@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 30, 2022 at 12:44:22PM +0800, Koba Ko wrote:
> On Fri, Sep 30, 2022 at 1:26 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> >
> > On Thu, 2022-09-29 at 22:40 +0530, Vinod Koul wrote:
> > > On 29-09-22, 09:57, Jerry Snitselaar wrote:
> > > > On Tue, Aug 30, 2022 at 05:32:07PM +0800, Koba Ko wrote:
> > >
> > > >
> > > > Hi Vinod,
> > > >
> > > > Any thoughts on this patch? We recently came across this issue as
> > > > well.
> > >
> > > I have only patch 3, where is the rest of the series... ?
> > >
> >
> > I never found anything else when I looked at this earlier.
> > The one thing I can think of is perhaps Koba was seeing multiple
> > issues at time when he found this, like:
> >
> > https://lore.kernel.org/linux-crypto/20220901144712.1192698-1-koba.ko@canonical.com/
> >
> > That was also being seen by an engineer here that was looking
> > at client_count code.
> >
> > Koba, was this meant to be part of a series, or by itself?
> >
> 
> Jerry, you're right, it's a part of the series.

Hi Koba,

If it is meant to be part of a series, where are patches 1 and 2?
The ccp patch has already been applied by the crypto maintainers if that
was meant to be part of a series with this patch.

Regards,
Jerry

> 
> >
> > Regards,
> > Jerry
> >

