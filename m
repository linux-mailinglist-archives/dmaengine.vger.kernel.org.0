Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C211504FB
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 12:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgBCLQQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 06:16:16 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37066 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgBCLQQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 06:16:16 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so16278155ioc.4;
        Mon, 03 Feb 2020 03:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYqiXmTfz4p/Fs3Zy1wbhMwP1CrrSHcGsiJsl44DR7g=;
        b=VuQdn0TyeYmnIKiR5y/5GWsgEJrXVezZufG5wP0K7CTLBmv12Ah+rLlT45zwbRASAJ
         DQPfxc6grh7WLvhEmTz/BuPRB8VS/Z1PPrcpwFgrfH2Tr1HxlM7MPRtU6QWdqao/XPS3
         MzctK8KZb1M3Y6scA0oUTU90GxH2pNU8NcWV5Bi4cs4b3u28g52Jg30QWBdTTftwQr5y
         XXo2vws/2fWMT+XVNeeCpdQYM970bP+hzhCwZjbuuTY4bmqDB9w51ZcnpLK6QQqkQMSj
         j3sStIQwZoWYJGKXJ9+LbwzFom9gLkuzY8GWbZqoky++msnee6705Qmr0zAzhW2dOEeS
         EilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYqiXmTfz4p/Fs3Zy1wbhMwP1CrrSHcGsiJsl44DR7g=;
        b=finB0yOyDindS+jnDNB9YCBDTnwIbSSxRbfyOk584UxgFmw+xbG8Grlv0c8mx+HzVv
         4nldxpriXUwRVntjb4F78nhPPvHtEqlP5X1b7kZsnew/UyNwsaMWZStHEaWcOwAXbgG1
         1BUWYAlg/xOb7XA/GXGisNwRfUSNLOaUAxjtJ7jjh67l/KuM+ehbqxHfBbtDXTTZpZzk
         iJ4qV4eRI6yy+vPUaz7t6zEs5hX51APEMq6UHEQ1wHcDZm5/LdsfuOo8RbR+y7tPpuRt
         ATjMDnASd5qtOAPYh8uIhvxbQXzxtInGOfg1ZMzAs4NG6U4reHgV3nqsQOcgdMdrqR2V
         SRrA==
X-Gm-Message-State: APjAAAVkMYR+VdBtH0+E5IVeHrsLiYvoXuZpHK8TOEm2p8qQpQNxtrjk
        UIUdQjiBo8b8hBJQZ+s8/JFnlEg1JonFMhDUmoo=
X-Google-Smtp-Source: APXvYqyEL9EgSzC3GggnJ+z7Q0BmOx97lJFrkeGc2avpDN3tW2d5T6RBtxU1kfy45gz7ZkYN5liC3kXb/IOnwMArFOA=
X-Received: by 2002:a02:a48d:: with SMTP id d13mr18971384jam.141.1580728574204;
 Mon, 03 Feb 2020 03:16:14 -0800 (PST)
MIME-Version: 1.0
References: <20200203101806.2441-1-peter.ujfalusi@ti.com> <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com>
In-Reply-To: <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Feb 2020 13:16:05 +0200
Message-ID: <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 3, 2020 at 12:59 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 03/02/2020 12.37, Andy Shevchenko wrote:
> > On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> >> Advise users of dma_request_slave_channel() and
> >> dma_request_slave_channel_compat() to move to dma_request_slave_chan()
> >
> > How? There are legacy ARM boards you have to care / remove before.
> > DMAengine subsystem makes a p*s off decisions
>
> The dma_slave_map support is added few years back for the legacy ARM
> boards, because we do care.
> daVinci, OMAP1, pxa, s3cx4xx and even m68k/coldfire moved over.

Then why simple not to convert (start converting) those few drivers to
new API and simple remove the old one?

> Imho it is confusing to have 4+ APIs to do the same thing, but in a
> slightly different way.

It was always an excuse by authors "that too many drivers to convert..."

> > without taking care of
> > (I'm talking now about dma release callback, for example) end users.
>
> I have been converting users in the background, but the _compat() is a
> bit more problematic as I need to maintainers of those legacy platforms
> to craft the map. If they care.

Why not to remove them and don't punish users of new drivers / platforms?

> Obviously the APIs are not going to be removed if we have a single user
> and if there is clearly a need for something the _compat() was doing and
> it can not be done via the dma_slave_map, then rest assured there will
> be a clean API to achieve just that.
>
> > They will be scary for no reason.
>
> There is a reason: to clean up the API to make it non confusing for the
> users.

No, it's a reason when you first take care of existing users and
decide to obsolete an API followed by removal few releases later. But
I see no reason to keep such APIs at all, so, instead of this
*wonderful* messages perhaps somebody should do better work?

> New drivers should not use the old API i new code and developers tend to
> pick the API they use after a quick 'git grep dma_request_' and see what
> the majority is using.

Isn't it a point to do better review rather than scary end users?

-- 
With Best Regards,
Andy Shevchenko
