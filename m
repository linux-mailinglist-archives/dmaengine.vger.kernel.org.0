Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF503F75E9
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhHYNcf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 09:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbhHYNce (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Aug 2021 09:32:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B8C061757
        for <dmaengine@vger.kernel.org>; Wed, 25 Aug 2021 06:31:49 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id n18so23112869pgm.12
        for <dmaengine@vger.kernel.org>; Wed, 25 Aug 2021 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AO0PWlra54Wtl4Rkns92XZUGKvWoY0HgcaQrY1Jrokc=;
        b=QU0DvtE48zc+f7kvumuxPw3sYohY/Zjnz87/bzDTYTkuoIg/8Jdjo2hhKHVu0M+Jtd
         UbiBE6KH6O22Di92u6bh8kHlec0rniljhiTF2j3031mqfldHcYk/6cY/zesjOK9o4dXO
         AVUpcKGWJXGuEajPo1hR+iSl2bzTQWSNwG0/PD9oUYge35i7O40LF9aeHW+9f9vOp4Gm
         BF7Yi4VlI42s5LwK0ON6mp2aphufzefzYg3RTKNh25nY/yv2mW/uVMQy4L7H25Shd+wZ
         iExBYWFTHPmy2O2xjAEG3Apvs5aYikX/Cse6zrYfuzPqkiJAL/h1mBdFE8ejQzE42OOP
         7QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AO0PWlra54Wtl4Rkns92XZUGKvWoY0HgcaQrY1Jrokc=;
        b=DjjEvBuCVSE/OdKfxeP8M5CNaXyrSfTk/EKuW8wKcD5S4ELfS+foITTgapXnnWMEyU
         Qn2wwYbs0wIDvwIgnY54K6yHcD+WwazyDATmjvxhLlgTZmtRirDJfnleTlfdGSUiK1dO
         //C32dXyS+Nv3lOGQ3oEsZN1VNBYG6SjxhptKrFKqBJReaXPoCiiN/0EBF1LSErVlZe8
         2c0c+1+Z+RiFXt+YNs473OeamzKHpuVUuZvnuBRz53bDfYXhaJuqTpaWF2nacm+KTjq1
         pVNY31I2VPIf7RFZSrEOgyXSSD5/4V5DGHzhVLVaxnJ7j4zMCj5TdQgt2g1KqIZX6vSN
         1/7Q==
X-Gm-Message-State: AOAM5314E7Y6o3V8MCJisDxP13Q99a8WlkIvUYhouML9Rg536Y4ib9wM
        rPDsHj9XY0T1U+L3HMnhUdZH5RvX2gzQ+WhmFhqoaw==
X-Google-Smtp-Source: ABdhPJzJVAul+GZ7ihTS4lxF0i5dyKRW2GFzX3Fx4Xk74EMMrjOkEFsDGs0DU4Do+lnbPc5A20tmMK5jsDP4EWzeM2I=
X-Received: by 2002:a65:47c6:: with SMTP id f6mr8172673pgs.450.1629898308480;
 Wed, 25 Aug 2021 06:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
 <CAPcyv4i0p-DaPA7YTid4XsUJUpq+L-c1kDNArb=0XXnFkXz-iw@mail.gmail.com> <0ef27e7c8df520ca48900140b3930af279cd2466.camel@sipsolutions.net>
In-Reply-To: <0ef27e7c8df520ca48900140b3930af279cd2466.camel@sipsolutions.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 25 Aug 2021 06:31:37 -0700
Message-ID: <CAPcyv4jYy+O9NcTr93PK_rq2xYnhx3GHyS1=k+jbvO4t7U1iiw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ioat: depends on !UML
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 9, 2021 at 10:27 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Mon, 2021-08-09 at 10:24 -0700, Dan Williams wrote:
> > On Mon, Aug 9, 2021 at 2:25 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> > >
> > > From: Johannes Berg <johannes.berg@intel.com>
> > >
> > > Now that UML has PCI support, this driver must depend also on
> > > !UML since it pokes at X86_64 architecture internals that don't
> > > exist on ARCH=um.
> > >
> >
> > Do you really need to disable compilation of the whole driver just
> > because an arch level helper does not exist on UML builds? Isn't there
> > already a check for enqcmds on x86_64 to make sure the CPU is
> > sufficiently feature enabled?
>
> Hmm?
>
> The problem here is that cpuid_eax() and cpuid_ebx() don't even exist on
> UML, and that's not really surprising - ARCH=um is after all compiled to
> run as a userspace process, not to run on bare metal. I guess
> technically we could provide (fake or even sort of real) implementations
> of these, but there's very little point?
>
> I don't see why you would ever possibly want to have this driver
> compiled on ARCH=um, even if it's compiled for x86-64 "subarch", since
> there will be no such device to run against?

See CONFIG_COMPILE_TEST, i.e. even the "depends on X86_64" should be
reconsidered if you ask me.
