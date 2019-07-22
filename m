Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228D970299
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 16:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfGVOpP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 10:45:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46598 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfGVOpP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jul 2019 10:45:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id r4so28716749qkm.13;
        Mon, 22 Jul 2019 07:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCrmMyeXJU21mgGD66S4pq7iGkwMcbrBGw6giWUHZKo=;
        b=FWVchHl3rpGEDHADnRva21ws9Ctqxx1nV/HRVRWHFg/+xAmL7DN0S0mymxh+IASPwu
         DY1ZxJ6/6vc7xfvfnWzNnrTpfoEa3VgyHK/L6W9LAMJK+IZVm4TGbp+TwlwrWvBiasuw
         WjQoN3tSM8DmWD8BNOgZZpoZmCAOCoOaYRjwJ2Plc0xDl18VMkYKtfY+7BTxT5ZWhuZs
         8c0fo0eTvxA+w4gU0nl8toYloj001j5+EuZ25t0d6wkeQUBu68Jav/T8CRvz+tXBEewP
         dOmC64lPVR5mpVh2cr1vRqfKfYwGQrbpQFkSaVyxJ6Kn+oQuRdw+fSs2dJkqiRk8ZWTC
         9wjw==
X-Gm-Message-State: APjAAAVuz8MdTcVXsI1GmDtZZCNrhmvU4XmLXUcDAs3pRGuLnExLQ5Bk
        kq2EIpYQ0MFE3OMBWU/3hRZgPQwj7Mb4bHTSOSklhAKu
X-Google-Smtp-Source: APXvYqyvYkb8bN20vVgnX8YnSjGe5uWLc0/7bvik5gkkNAUrKOPFNcnuJIu/5etHrPwOznqM3f5bzyWis9rruWHC7uM=
X-Received: by 2002:a37:5f45:: with SMTP id t66mr47571591qkb.286.1563806714188;
 Mon, 22 Jul 2019 07:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190722081705.2084961-1-arnd@arndb.de> <20190722141240.GT12733@vkoul-mobl.Dlink>
 <CAK8P3a0tHRyjwwHk3tGFA=3dByH4g7R4FobrGC874bW5DJCnNw@mail.gmail.com> <20190722143533.GX12733@vkoul-mobl.Dlink>
In-Reply-To: <20190722143533.GX12733@vkoul-mobl.Dlink>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jul 2019 16:44:58 +0200
Message-ID: <CAK8P3a1P4LyOieH1ii0vn_5rdj-NC4ft6JKCKs6YX88Qdk5SSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] [RESEND] dmaengine: omap-dma: make omap_dma_filter_fn private
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jul 22, 2019 at 4:36 PM Vinod Koul <vkoul@kernel.org> wrote:
> On 22-07-19, 16:22, Arnd Bergmann wrote:
> > On Mon, Jul 22, 2019 at 4:13 PM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 22-07-19, 10:16, Arnd Bergmann wrote:
> > > > With the audio driver no longer referring to this function, it
> > > > can be made private to the dmaengine driver itself, and the
> > > > header file removed.
> > > >
> > > > Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > > Link: https://lore.kernel.org/lkml/20190307151646.1016966-1-arnd@arndb.de/
> > >
> > > This seems to point to older rev, my script updated it to latest one.
> >
> > That was intentional, to see the replies to the last time it got
> > posted. I'm not sure if that's the best way to do it, would you
> > rather not have that included?
>
> That's a valid point, but should we add both the links or just relevant
> one, common sense says former, scripting tends to add so keep both...?
>
> I am thinking of not changing the one submitted and let my
> script append. Is that fine?

I think adding both is best then.

       Arnd
