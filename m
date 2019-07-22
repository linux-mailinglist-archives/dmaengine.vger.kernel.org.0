Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F247C7022E
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 16:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfGVOWZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 10:22:25 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36215 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbfGVOWZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jul 2019 10:22:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so28711308qkl.3;
        Mon, 22 Jul 2019 07:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTmepm+1wfFxfhcjqWinIonpHuVFe0DnWusOLHAhtlk=;
        b=O2P7n+PBhpJokVp9oQM6s23hqF4JXmFo3u8AHdqz9P8n+bgxM6BY4V49t5WLXT0/7v
         /lRizT9pXBmDtcPrf4YdCjyUtwNa4+YemX8UbpKVRpK0VnMLwfZLlIuf8r6Jkmeyb0il
         O6bYtWe7/w1uNqhx0Gaam2CnG+0fDQ8siSEYBXKXZukZTz5NF9E4gjz5mC1XUZDEyLtc
         V261YPJ3Iu0B5y/uRQGTzA8xK1Dz3ovRi7NPJsANjtU1OqEuS554RwnvCitUkhfhQaAW
         2Ekj0B7l9tCv/bba+QLRgxhqlm5g5HbcKH2AQMXem+tBezsekPc928D8qCkc1rBxJ7GE
         gRVg==
X-Gm-Message-State: APjAAAWUbpU5tuGlxXswNSyvAqYCV3a7WVMjD0vRjisHfKKgycqgqHTF
        +DJmRlbYoH+ESjnhFQoLuCZqzdaGLxgDdk1AWXM=
X-Google-Smtp-Source: APXvYqyRl/V5f/dWzvRYci6j6FaJpVCVBePMszoWUP6PKN73YEOIAlkXQ8DgddVWxMgoli8YQHbOJLf6Q2SbjJgx0cU=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr2798435qkm.3.1563805344006;
 Mon, 22 Jul 2019 07:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190722081705.2084961-1-arnd@arndb.de> <20190722141240.GT12733@vkoul-mobl.Dlink>
In-Reply-To: <20190722141240.GT12733@vkoul-mobl.Dlink>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jul 2019 16:22:08 +0200
Message-ID: <CAK8P3a0tHRyjwwHk3tGFA=3dByH4g7R4FobrGC874bW5DJCnNw@mail.gmail.com>
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

On Mon, Jul 22, 2019 at 4:13 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 22-07-19, 10:16, Arnd Bergmann wrote:
> > With the audio driver no longer referring to this function, it
> > can be made private to the dmaengine driver itself, and the
> > header file removed.
> >
> > Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Link: https://lore.kernel.org/lkml/20190307151646.1016966-1-arnd@arndb.de/
>
> This seems to point to older rev, my script updated it to latest one.

That was intentional, to see the replies to the last time it got
posted. I'm not sure if that's the best way to do it, would you
rather not have that included?

       Arnd
