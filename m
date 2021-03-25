Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE83498DC
	for <lists+dmaengine@lfdr.de>; Thu, 25 Mar 2021 19:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCYSDW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Mar 2021 14:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhCYSC7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Mar 2021 14:02:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89770C06174A
        for <dmaengine@vger.kernel.org>; Thu, 25 Mar 2021 11:02:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so4361344ejo.13
        for <dmaengine@vger.kernel.org>; Thu, 25 Mar 2021 11:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tF75vK/7ZWAlxeTU0qxQhdmUdRoa4Ndayr3XVKdcSy4=;
        b=Dhdv8L3bFqpCe0k175BPgv/S7dfR4qTYVzj5kLLtDr06PBSV8t4J+1KKz217fsmOZG
         DyTGcSfXVuEtPpWQ9KB6s0Vat9AVQCLkZNMzoFLjfKMsEFS6+vrZeb2aylV8YWD8lbVf
         AkPDj9GiDKxgReDspVHrIHDpEZYv2/YqUVYlHLee/2ETy6IF5IzmkSRSb+gugRhvszde
         tMQsCpgn6PreB0mxZeHJ22a8i3BFxjlN6l/U6uX9l6X7Zk6b1zD7klzYWDfU1YzZD7kE
         LVhodNiX4ikXm8GcGoYkoffcStKDrCydrBOCHKtz0V210N8Il/9ESPPQO80qXn3Ziwt/
         ts9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tF75vK/7ZWAlxeTU0qxQhdmUdRoa4Ndayr3XVKdcSy4=;
        b=s64/e5PzbaH5LVPRs9cdH6JtMiyEXwObaw+OBOifGXdhUsuhyfc/Vr3evjtRP5BSgk
         XiqRS7ToKafDIXq2eyfvKp3ohu93ljjhEZtFl3YxTFRKwvXapQt9qO6jpJp6ZVqyZzPs
         b9EFkUzM+T3kg+T4yKOEh6ST88J55HnFulQrolEu+GNCY23ldfJYL7vITmxpF9WCZt+8
         yFzvEcr2rGLAnJH7/yrSzv7ClLHB994kXYixOnUTelkEyTfTi0OrgUileaqSv1wou9zS
         4D261eWwEox3PXMrXvVIUx3kR5hxXCehi1ucYyzjvpWfqthfG5annFGooijko+nVavl8
         VK+w==
X-Gm-Message-State: AOAM530I37ZEc66OyA1wr7RjoRAkHKLrh/4FL3OtcnlLdSu3LUjW195f
        LSzeNrdMk7EuyHJHKdzUVg4wzHCawl3esEGaB4UgHw==
X-Google-Smtp-Source: ABdhPJzap4k1lkMYlMzXUjzek2ByLTdCKqLkFZEU5/6ldEQq8smY7HX3w8xnGV1CidNKebxL0j74J5zf4w1rpOe7Ea8=
X-Received: by 2002:a17:906:2ac1:: with SMTP id m1mr10895127eje.472.1616695377274;
 Thu, 25 Mar 2021 11:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com> <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com> <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
 <20210324165246.GK2356281@nvidia.com> <CAPcyv4g2Odzusx621vatPbA041NXMmc1JK_3oSNM-EOPwDaxqA@mail.gmail.com>
 <20210324195757.GR1667@kadam> <CAPcyv4geTG8M2mxJNxN0wxZsQsLbN0U-mr1jjC=3sjyRWOuwmA@mail.gmail.com>
 <20210325164809.GB2356281@nvidia.com>
In-Reply-To: <20210325164809.GB2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 25 Mar 2021 11:02:46 -0700
Message-ID: <CAPcyv4gwqkzOHQ-xJ2At0Rc2k_S1X43XB607k8f-Djf7T-O3eQ@mail.gmail.com>
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 25, 2021 at 9:48 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Mar 24, 2021 at 01:00:04PM -0700, Dan Williams wrote:
> > On Wed, Mar 24, 2021 at 12:58 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Wed, Mar 24, 2021 at 10:01:42AM -0700, Dan Williams wrote:
> > > > On Wed, Mar 24, 2021 at 9:52 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > >
> > > > > On Wed, Mar 24, 2021 at 09:13:35AM -0700, Dan Williams wrote:
> > > > >
> > > > > > Which is just:
> > > > > >
> > > > > > device_initialize()
> > > > > > dev_set_name()
> > > > > >
> > > > > > ...then the name is set as early as the device is ready to filled in
> > > > > > with other details. Just checking for dev_set_name() failures does not
> > > > > > move the api forward in my opinion.
> > > > >
> > > > > This doesn't work either as the release function must be set after
> > > > > initialize but before dev_set_name(), otherwise we both can't and must
> > > > > call put_device() after something like this fails.
> > > >
> > > > Ugh, true.
> > > >
> > > > >
> > > > > I can't see an option other than bite the bullet and fix things.
> > > > >
> > > > > A static tool to look for these special lifetime rules around the
> > > > > driver core would be nice.
> > > >
> > > > It would... it would also trip over the fact the core itself fails to
> > > > check for dev_set_name() failures and also relies on !dev_name() as a
> > >  check after-the-fact.
> > >
> > > Where can I find the !dev_name() check?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/core.c#n3153
>
> I would just add error checking here, it seems baffling not to have it
>
> Why didn't we use this simple device enumeration stuff for aux bus?

Good question...

...but aux-bus may need to contend with namespace collisions across
users, so that's why the modname prefix is forced in device names.
Also how would aux-drivers differentiate what they attach to with a
single bus provided name?
