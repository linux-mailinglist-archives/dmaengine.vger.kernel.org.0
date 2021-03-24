Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E3D34826F
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 21:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbhCXUAc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 16:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbhCXUAR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Mar 2021 16:00:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08B3C061763
        for <dmaengine@vger.kernel.org>; Wed, 24 Mar 2021 13:00:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u9so34911837ejj.7
        for <dmaengine@vger.kernel.org>; Wed, 24 Mar 2021 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8dDBopLN4Ef5Zw/BF4Z0o6GzOFvAj2/UMYpjpOsXvCE=;
        b=Kr44bHDZfm9pJLDk1pagV9SkO7/iUBVR9ldIWAgOEkL8RVIo2L1JvbqPCYVsEbzmKv
         b++AqbuRrqXL4glGQimJn6LEGMFeQeUJp5zJw/kIrk+F9HEwmI+/mDDPuXi8kZCvUnKq
         qkwDgJ+2NAkCC/4L9tBxbrHEcYChFu0zkKBtzhefhrLqT9nxAsO5kwj7yeqBPJAsgAM3
         RRmTkxApZgq6sDRxaLoGAQhUivTQvUqAApyw5OSViW3rLuGlUMrpz9E1CTSAskeb3eQx
         5oGnyaCAc2mRCrGxRV2upHUuk9tH8qrniuoMcYl25KWJsFVWxO2IXymB8C42VGuSmtmX
         5mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dDBopLN4Ef5Zw/BF4Z0o6GzOFvAj2/UMYpjpOsXvCE=;
        b=m/0+73g3ObiUv3+e0qPzbhNBGo9GbM3P3vW2FTIlkqB+CUSkZz15XSyrBNS07TxPUx
         CQEnbk59Soj2Ps/7N/8nVvGRn7LZo1ccO2IhcqAsP0TlJd+vYCov2V1sbFwALM4b015S
         QtsqsakS/Wag1jtvH/p8dlAa3jB+LMmHxzjsrkSojesqK+q2K3vtaQ30NGV2cXjU9VlA
         9aALKnhi+MT0e8XMa+gXr3CuXBsuBZ8x4E5NtRdwmkypRXmjGxRLINP7t1RqWiABfc0R
         08K4m9AizUEzS6QzGfiHhdzbwv4jEz/GAmLTnROCKwuyuXmFQtzD/A5fpE5ksGdIn4fu
         BHpw==
X-Gm-Message-State: AOAM530Ax5jNtCWRggmhOCjWoFv72bkUF/rS+kAhZGqpshLpZyjWUxeu
        mha+4IpEDrKc5tnSR4I5qyEtb+HQddjtTJeMfpvMEg==
X-Google-Smtp-Source: ABdhPJwlnke9XlcPzdV+AO5Djvc0Bw3HvQVygpKY9Cl55UcOB2xGk0WZRw0wj8+pSI2EqFgQQeEkrY1Z5bdRxfyjiH4=
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr5708074eji.323.1616616015643;
 Wed, 24 Mar 2021 13:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com> <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com> <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
 <20210324165246.GK2356281@nvidia.com> <CAPcyv4g2Odzusx621vatPbA041NXMmc1JK_3oSNM-EOPwDaxqA@mail.gmail.com>
 <20210324195757.GR1667@kadam>
In-Reply-To: <20210324195757.GR1667@kadam>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Mar 2021 13:00:04 -0700
Message-ID: <CAPcyv4geTG8M2mxJNxN0wxZsQsLbN0U-mr1jjC=3sjyRWOuwmA@mail.gmail.com>
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 24, 2021 at 12:58 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Mar 24, 2021 at 10:01:42AM -0700, Dan Williams wrote:
> > On Wed, Mar 24, 2021 at 9:52 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Wed, Mar 24, 2021 at 09:13:35AM -0700, Dan Williams wrote:
> > >
> > > > Which is just:
> > > >
> > > > device_initialize()
> > > > dev_set_name()
> > > >
> > > > ...then the name is set as early as the device is ready to filled in
> > > > with other details. Just checking for dev_set_name() failures does not
> > > > move the api forward in my opinion.
> > >
> > > This doesn't work either as the release function must be set after
> > > initialize but before dev_set_name(), otherwise we both can't and must
> > > call put_device() after something like this fails.
> >
> > Ugh, true.
> >
> > >
> > > I can't see an option other than bite the bullet and fix things.
> > >
> > > A static tool to look for these special lifetime rules around the
> > > driver core would be nice.
> >
> > It would... it would also trip over the fact the core itself fails to
> > check for dev_set_name() failures and also relies on !dev_name() as a
>  check after-the-fact.
>
> Where can I find the !dev_name() check?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/core.c#n3153
