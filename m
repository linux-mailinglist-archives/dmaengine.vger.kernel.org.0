Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47CF3F15EE
	for <lists+dmaengine@lfdr.de>; Thu, 19 Aug 2021 11:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhHSJOJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Aug 2021 05:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbhHSJOJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Aug 2021 05:14:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EE5C0613CF
        for <dmaengine@vger.kernel.org>; Thu, 19 Aug 2021 02:13:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q6so7961425wrv.6
        for <dmaengine@vger.kernel.org>; Thu, 19 Aug 2021 02:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mu9b4mblc/ExPlSUnMroTgqBzEI9hLYiUrbLs2ZdCaU=;
        b=xeqOJFv4Yk292z5h/hTFjEN/0ui5PwnRO2mKenFqm6I4TTp1INPK3NKzStaZMpmI1J
         Ysa7qwchiDka9i8OTzaigrmYgdyztKhoA64bp532bl3zJzO+gPBRxYZBdbx+CEOpsWMd
         WKf4Q6BTwSCzp2Q0GhEBO3nka7Ov+fi0E/JVNMGls+iI2OzEOM0DtyKZDwPf2mn1NsEb
         pEQPsYSLyBstiPeq2gjWgjbYLRzwZfy2rhS8jH+OZ7NA1gL5zIVklP2lJ7CP5xb663sz
         c1dvWXtFlyQeSMXIE6IYtlL5Xfcp4eAW430w4l6VnPQrMlrla3cg81rGf43mAgdQuXdl
         06RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mu9b4mblc/ExPlSUnMroTgqBzEI9hLYiUrbLs2ZdCaU=;
        b=NfDoSvH/FubDEYFgF7apCpcPi6QDFD3t/NNkKHPIWOTxXOuwojSqOkWUv0/EJiL1eD
         IOKtpPBRNx/bfDCd3Pye/vglJXgodIFnJZHsRxqqhb6teocM4PNQwPWy8Qu3THghSvsV
         6BMw7AqdGaMrCxrzcNwtMFvybOJMLBCUY2WXuNa7okc7UF24d6+sqv77Cly9e71cltad
         yrjILRJHR4YbRnUe0Od8/4/uSn7VgkOWZg4ssL6Z7bQEwbs6FnDUJkvxmxKha1QbSZLh
         2xMfYzzeN7poc3IM568Fcz8t+Z/gjN2r4+m7oa9uL62wGLjJKV0ikVWlS24HCfMXtZjs
         9xww==
X-Gm-Message-State: AOAM531a1FoJN5gvVYox88z+DGLfiHS7O0fGQflCK75zqSNQclbRe5W7
        M2VocAFzXCRDvnHSIhJ7xY+wGw==
X-Google-Smtp-Source: ABdhPJwu8ApgZURG1smRQNq5OoDX0gahn5gKM2eQ/sizWhYa+rCQGx1dpSOz0CNUkakynGmxjbtGrw==
X-Received: by 2002:adf:ea09:: with SMTP id q9mr2498131wrm.64.1629364411576;
        Thu, 19 Aug 2021 02:13:31 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id s10sm2730312wrv.54.2021.08.19.02.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 02:13:30 -0700 (PDT)
Date:   Thu, 19 Aug 2021 10:13:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@linaro.org, Haavard Skinnemoen <hskinnemoen@atmel.com>,
        =?utf-8?Q?H=C3=A5vard?= Skinnemoen <hskinnemoen@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: dmaengine: Add a description of what
 dmatest does
Message-ID: <20210819091328.6up4oprx4j7u5bjl@maple.lan>
References: <20210818151315.9505-1-daniel.thompson@linaro.org>
 <20210818151315.9505-2-daniel.thompson@linaro.org>
 <CAHp75VdDZJ+aUtx-A3y62WQ5+OtrS47Ts6PDe1bGQ0OcRRV+7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdDZJ+aUtx-A3y62WQ5+OtrS47Ts6PDe1bGQ0OcRRV+7Q@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 18, 2021 at 06:27:52PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 18, 2021 at 6:15 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Currently it can difficult to determine what dmatest does without
> > reading the source code. Let's add a description.
> >
> > The description is taken mostly from the patch header of
> > commit 4a776f0aa922 ("dmatest: Simple DMA memcpy test client")
> > although it has been edited and updated slightly.
> 
> > Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> 
> Not sure if you can use it like this (I mean the above SoB)

I wondered about that.

In the end I concluded that if I had picked up code from an old patch
and edited to this degree then I would probably consider it a new
patch but be clear about credit and preserve the original SoB. I saw no
real reason to treat the contents of a patch header much different.

However, I'm very happy to make the credit more informal if needed.

> Otherwise it's a good idea, thanks!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!


Daniel.


> 
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  Documentation/driver-api/dmaengine/dmatest.rst | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/driver-api/dmaengine/dmatest.rst b/Documentation/driver-api/dmaengine/dmatest.rst
> > index ee268d445d38..529cc2cbbb1b 100644
> > --- a/Documentation/driver-api/dmaengine/dmatest.rst
> > +++ b/Documentation/driver-api/dmaengine/dmatest.rst
> > @@ -6,6 +6,16 @@ Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> >  This small document introduces how to test DMA drivers using dmatest module.
> >
> > +The dmatest module tests DMA memcpy, memset, XOR and RAID6 P+Q operations using
> > +various lengths and various offsets into the source and destination buffers. It
> > +will initialize both buffers with a repeatable pattern and verify that the DMA
> > +engine copies the requested region and nothing more. It will also verify that
> > +the bytes aren't swapped around, and that the source buffer isn't modified.
> > +
> > +The dmatest module can be configured to test a specific channel. It can also
> > +test multiple channels at the same time, and it can start multiple threads
> > +competing for the same channel.
> > +
> >  .. note::
> >    The test suite works only on the channels that have at least one
> >    capability of the following: DMA_MEMCPY (memory-to-memory), DMA_MEMSET
> > --
> > 2.30.2
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
