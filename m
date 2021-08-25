Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354AE3F769E
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 15:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbhHYNy0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241553AbhHYNyZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Aug 2021 09:54:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF4EC0613CF
        for <dmaengine@vger.kernel.org>; Wed, 25 Aug 2021 06:53:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j187so21313499pfg.4
        for <dmaengine@vger.kernel.org>; Wed, 25 Aug 2021 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2X3QXQ6HqeJAEbBh8lnPTDjkH/I0HfMubxbidjbmIU=;
        b=qnzfB6+gYHv/yUQGj4df24/U3Vs5PdSN+m27S1c3J0ADGHNfJ2VVyfCVXgoFPX2eDx
         o8X5ONEi5Rxv1+83XafIbLzvZ0TrLU2caOO5U1yK6mrA5DMykfc/J76n4AhfUYQ1bCgk
         sWIWLjtcoB+FYiK1Vy9vFNpbCqYuOzJkZssl+ByGtejoodUyTZgRXTBOhsNUeb4BCQA/
         y8BQ2ppg+Z7sNoEEnIdWp9+yY2fS5kSUUWOU4oV5I2FhzEi1mluzepA3A5KtuUSziUdz
         mcpkNPj2dILPpTX5OZx62pT9UNWo3BAArebNLuE/45M4yB32R2TTXHziiAuoOME0dFdW
         bQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2X3QXQ6HqeJAEbBh8lnPTDjkH/I0HfMubxbidjbmIU=;
        b=bYt/fYbsdRNTHl41qPaJ+A5TtWTS+DWwInwodcHHldPJ3JBCJjULCk1H92MorgE18c
         ZOm2cO47hF0HaAN/0wljb2CJdJ/4nMJ2BfrwZra2xbrrm/jN7UopRILuTDL74SYqgI41
         fGT+kwei9/XmeCr8O7Kf7+KFHZQMFMgsQISXu/nI88BlfV/vvAkxILhCNYFkK7lvdXXo
         JGNvBGCmsj074Viaze/HZZhIla4mOOSNZkHW972I0FIw7KcVSyz+GQB9EWioE7Pbl82w
         fN0ZKOhwv1JBFcMKp+czCpx0+oj4BwiIlwfL/rouln8rrXWsHPAmu9i885x7FgkO+dZ1
         nsQA==
X-Gm-Message-State: AOAM532J6O6YfZP7kyWFbEv+AftgGPigWmaCSFpH8aRkoTgSajY5t1ym
        HkUJ7M+STmE0M3W0BIFC2YLjdPxZ3bFeU1Doi2CuaA==
X-Google-Smtp-Source: ABdhPJyGmJdg5GnvYql7SM3kw7i9GeURIeNCxbx95BjrItnGtXx01dSBL8XmLTitK0wTEERW6dNjpkX55zrH3OykZvU=
X-Received: by 2002:a05:6a00:9a4:b0:3e2:f6d0:c926 with SMTP id
 u36-20020a056a0009a400b003e2f6d0c926mr37755266pfg.31.1629899619735; Wed, 25
 Aug 2021 06:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
 <CAPcyv4i0p-DaPA7YTid4XsUJUpq+L-c1kDNArb=0XXnFkXz-iw@mail.gmail.com>
 <0ef27e7c8df520ca48900140b3930af279cd2466.camel@sipsolutions.net>
 <CAPcyv4jYy+O9NcTr93PK_rq2xYnhx3GHyS1=k+jbvO4t7U1iiw@mail.gmail.com>
 <4dc26051a8b03c1bc7fbac9212e71703d57457c0.camel@sipsolutions.net>
 <CAPcyv4j545=-9igjXjMWU_6-1COkOOejZz9ULgOmVvK1Y+8eiQ@mail.gmail.com> <b6fd5d53925712f9948a2ae3fa29cc4bc3b219fc.camel@sipsolutions.net>
In-Reply-To: <b6fd5d53925712f9948a2ae3fa29cc4bc3b219fc.camel@sipsolutions.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 25 Aug 2021 06:53:29 -0700
Message-ID: <CAPcyv4hqJwpe06iGXSj9bFH8B+Gb=aXDAQ7rE_t1WO-e8T2V5A@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ioat: depends on !UML
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 25, 2021 at 6:41 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2021-08-25 at 06:36 -0700, Dan Williams wrote:
> > > > >
> > > > > The problem here is that cpuid_eax() and cpuid_ebx() don't even exist on
> >
> [snip]
>
> > It can't compile because the arch dependencies are not stubbed out
> > like other arch specific helpers. I think this is something to revisit
> > if / when concepts similar to the "enqcmd" instruction appear on other
> > archs.
>
> I think you're confusing ioat and idxd? :)
>

Whoops, indeed I am, sorry for that noise.

> The ioat driver (which this patch is against) uses cpuid_eax() and
> cpuid_ebx() above, and really if a driver uses that then it can only
> possibly run on IA :)

True.

> I'm not sure it makes sense to abstract out things such as
> dca_enabled_in_bios() to a general architecture thing either?

Not general arch in this case, but a preference to keep x86'isms out
of drivers. That helper can move behind some local header ifdef'ery
and return false when needed. That said IOAT is mature, Vinod has
already taken this as is, and the commit that added it pre-dated
CONFIG_COMPILE_TEST by 6 years, so it can be forgiven.
