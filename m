Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90C53F75F8
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 15:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbhHYNhh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 09:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239882AbhHYNhh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Aug 2021 09:37:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C27C061757
        for <dmaengine@vger.kernel.org>; Wed, 25 Aug 2021 06:36:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w6so14341990plg.9
        for <dmaengine@vger.kernel.org>; Wed, 25 Aug 2021 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4SdTXxMtheluPjQhGvMvJBbVQA0TYZMs4/uw4SZTmjg=;
        b=0CxtFE44MiZj8tcVCWC3qROBJxfZePYcNBnUA+7o1n6XP9s8JJLFgcAQTThtp6GX1H
         SS52VT9Um9TicjijQ1js21fmCvDTdClmlWPfuPR6/zQt9lmYodmBnZKhCvBR7N6X1RfR
         bJZIB5Ni9dIPQKySE74owf4TCZ51h0RyMbynLCU8gzjgFu7sKgSbinIArcD+8UQ16GuE
         RTjPZRjXl7f0ChEsjEP/TqRRl5ggSxjUrMCWNReGWcT+vcS/uZ8yagspglAFgJEDxv8U
         symKu7uuUWt4OwdvRcejYOAJ+uISd5w4142gQwNT75p27qp2q67NFRVGnoReoGw9k7mK
         5CQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4SdTXxMtheluPjQhGvMvJBbVQA0TYZMs4/uw4SZTmjg=;
        b=m5rah2moFhbRin2AMiYjsZWQZkBXBgZ8qyviJgC9biUWSIgM06af4xUj0R0UfzEDq+
         mdiidaXytK+lDGZe2M3ZArEJjtWeCDfDLliD1NnpNaoxfhMrkmQaEhzrUeE8T6IupNk5
         U0C03RFexPowNVpppiYR4kJ4sw6SZpps4MOgIjLEhEjvVQQS1nZRuG6XnlC8F5RhzufY
         Na17Yz7zwgqMAjAUzbKxghRHfMFiYtaeglhkuaK7aLQtAl+Xkrf2T46R8SshLeOShlTi
         c7zea4GJjudqffSOXsiAUo1TJCb+eW5FP1pmNQulGlslBiFP0VKexNf2ylo5DD3dvgej
         61JA==
X-Gm-Message-State: AOAM530G/s8Zn00n7NODfu/ayqMDSLvqA4rF3/nLoZStFUpACaB6AEn+
        AgyxRQeQ4L2wUT8Qcnb9d4AGeEVAxuyCCHNLS+kIgA==
X-Google-Smtp-Source: ABdhPJw0pYhktGJfj2iaRrLtx5uD/ZGaezhzH+B7i6bfEKTjbxEBACle6us2w3ohJXB7tt5tThk9rBzjQIz8Yp25Sx0=
X-Received: by 2002:a17:90a:1991:: with SMTP id 17mr2192218pji.149.1629898611001;
 Wed, 25 Aug 2021 06:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
 <CAPcyv4i0p-DaPA7YTid4XsUJUpq+L-c1kDNArb=0XXnFkXz-iw@mail.gmail.com>
 <0ef27e7c8df520ca48900140b3930af279cd2466.camel@sipsolutions.net>
 <CAPcyv4jYy+O9NcTr93PK_rq2xYnhx3GHyS1=k+jbvO4t7U1iiw@mail.gmail.com> <4dc26051a8b03c1bc7fbac9212e71703d57457c0.camel@sipsolutions.net>
In-Reply-To: <4dc26051a8b03c1bc7fbac9212e71703d57457c0.camel@sipsolutions.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 25 Aug 2021 06:36:40 -0700
Message-ID: <CAPcyv4j545=-9igjXjMWU_6-1COkOOejZz9ULgOmVvK1Y+8eiQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ioat: depends on !UML
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 25, 2021 at 6:34 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2021-08-25 at 06:31 -0700, Dan Williams wrote:
> > On Mon, Aug 9, 2021 at 10:27 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> > >
> > > On Mon, 2021-08-09 at 10:24 -0700, Dan Williams wrote:
> > > > On Mon, Aug 9, 2021 at 2:25 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> > > > >
> > > > > From: Johannes Berg <johannes.berg@intel.com>
> > > > >
> > > > > Now that UML has PCI support, this driver must depend also on
> > > > > !UML since it pokes at X86_64 architecture internals that don't
> > > > > exist on ARCH=um.
> > > > >
> > > >
> > > > Do you really need to disable compilation of the whole driver just
> > > > because an arch level helper does not exist on UML builds? Isn't there
> > > > already a check for enqcmds on x86_64 to make sure the CPU is
> > > > sufficiently feature enabled?
> > >
> > > Hmm?
> > >
> > > The problem here is that cpuid_eax() and cpuid_ebx() don't even exist on
> > > UML, and that's not really surprising - ARCH=um is after all compiled to
> > > run as a userspace process, not to run on bare metal. I guess
> > > technically we could provide (fake or even sort of real) implementations
> > > of these, but there's very little point?
> > >
> > > I don't see why you would ever possibly want to have this driver
> > > compiled on ARCH=um, even if it's compiled for x86-64 "subarch", since
> > > there will be no such device to run against?
> >
> > See CONFIG_COMPILE_TEST, i.e. even the "depends on X86_64" should be
> > reconsidered if you ask me.
> >
> But CONFIG_COMPILE_TEST is for stuff that can *compile*, just not *work*
> independent of the platform - e.g. if I have a driver that compiles
> fine, but I know there's never going to be such a PCI device on non-
> Intel platforms (happens a lot, after all)
>
> But here it's the other way around - this cannot *compile* even anywhere
> other than "X86_64 && !UML", let alone *work*.

It can't compile because the arch dependencies are not stubbed out
like other arch specific helpers. I think this is something to revisit
if / when concepts similar to the "enqcmd" instruction appear on other
archs.
