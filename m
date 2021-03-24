Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED3347E6F
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 18:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbhCXRCI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 13:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbhCXRBz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Mar 2021 13:01:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68733C061763
        for <dmaengine@vger.kernel.org>; Wed, 24 Mar 2021 10:01:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id j3so28423366edp.11
        for <dmaengine@vger.kernel.org>; Wed, 24 Mar 2021 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=teQkYQTEYprzBnytUo0/0s+FcUNCoeOyTlndkzE7Heo=;
        b=S2waayKt1nAN/gvRH3e+Cg98Yo9AkScBqUW1NOB/iUNBxQ+12pRGpX87ZNgnaQjc2L
         L00Koqra6c9D88R5QumDVWED37pATrIRimXhCTMHtuI4c4cJjAB37g0enFHV4sLj46+3
         KexjBzsbjL7z0HpS6GtqObNMXAUWelhrSLU2DrvF0PFEd9pPSdlH3GIJedPbpPahm6JJ
         YcgWScqXLlKHtXSgy9Y+KDLb0GvhPlxH4YVLC8QaaoPYj9URsIUMuaFaYUc2BmpuAJQ/
         1vAUk3KAyswE9SMdutxRa2n+U3dRnfxrwBcSbWSpzzig6cOi9lu6Y0M0Dq46L1lT6+iA
         Vopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teQkYQTEYprzBnytUo0/0s+FcUNCoeOyTlndkzE7Heo=;
        b=oJ2K0otNi5DUvD5gXFvGx3VBeKnJ38wgD4v3dJgN6q3491KUVIesIm/vDNeLQIZBp4
         5MxHyKOVReQVRmEaQDf6gBoRkfzeKwOo+GKSyok+6b0a6yicpOEB6XDPEQ5YWdwmDirM
         YNi/mwl4W2HPJXe33mWb9j/1K594G6PhhEVaMWDSbLUDrN9Nk6WIgk+6PE/ERMrY8kLz
         uH5babacqU7AGcNr4HjUfMmE3KizVrVXbWyVfXCKhhDwRWApZ43XUMiqgOjoc7P/GyC5
         t+gC3L23pKKB6MaE6bWDhL5Ozj/opX4Yd6CF16KuDwXTdoJRb6mZWZgafO6I0JlPvKiq
         whUg==
X-Gm-Message-State: AOAM533Ipmu0bEEZlkM/OvgjXBgOfIN+5t2KgH8CLdT7t4ZftET2NM/s
        y/RnSJZuhTro1CYV1T685MC6MCs3C5ZZ/EwWPRjtNQ==
X-Google-Smtp-Source: ABdhPJw/y5jHhpSIB3wk/Af1VQdBzGqHzC2sUJUjdIkXeN48qnE32ayf25bpSHZd9V+Bi8zpkBRJNrumy5jAU4o67cw=
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr4487630edw.348.1616605312764;
 Wed, 24 Mar 2021 10:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com> <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com> <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
 <20210324165246.GK2356281@nvidia.com>
In-Reply-To: <20210324165246.GK2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Mar 2021 10:01:42 -0700
Message-ID: <CAPcyv4g2Odzusx621vatPbA041NXMmc1JK_3oSNM-EOPwDaxqA@mail.gmail.com>
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 24, 2021 at 9:52 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Mar 24, 2021 at 09:13:35AM -0700, Dan Williams wrote:
>
> > Which is just:
> >
> > device_initialize()
> > dev_set_name()
> >
> > ...then the name is set as early as the device is ready to filled in
> > with other details. Just checking for dev_set_name() failures does not
> > move the api forward in my opinion.
>
> This doesn't work either as the release function must be set after
> initialize but before dev_set_name(), otherwise we both can't and must
> call put_device() after something like this fails.

Ugh, true.

>
> I can't see an option other than bite the bullet and fix things.
>
> A static tool to look for these special lifetime rules around the
> driver core would be nice.

It would... it would also trip over the fact the core itself fails to
check for dev_set_name() failures and also relies on !dev_name() as a
check after-the-fact.

That check is broken if the device was not zeroed on allocate.
