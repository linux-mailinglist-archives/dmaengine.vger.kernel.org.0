Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1536320E258
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 00:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388068AbgF2VEY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jun 2020 17:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731119AbgF2TMp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Jun 2020 15:12:45 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03DEC0149DD;
        Mon, 29 Jun 2020 01:19:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n2so3034499edr.5;
        Mon, 29 Jun 2020 01:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Di4X3kO1NLhqcaNYFfndVe6TZWk4Eo5zmSmqMBqgXsg=;
        b=ifgI6FKoFI1Vj1Y+nGO/as8ZauW+sydv5qFWLvnktrrd+l8EjoY0z7O5zApRcfIIhS
         RlFN/y8e0n51H6cEehMPylM946Wx/H+jVJ0pcLlzNtIjppj07NZgbpXUKfZwniLoheTJ
         +NqBBpp60z8OjGiY+u+rHkgHRpnakZLyZ4FcOtEW27C0twNv5XWpiq/hzTMfHlHG/sHA
         CDZxrFFX3QUyQWfR05S5EDvntl5pAG1dWlfA2WGfhx8moL20Cxsh6pF+G9SJqXzlCuFZ
         S1EHIkwV0NgK0NSIQv6MqeIR8kcmdm6hzDAasfCewAia06Ur4YxsWrj4MjjLwaCuC0DU
         Vj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Di4X3kO1NLhqcaNYFfndVe6TZWk4Eo5zmSmqMBqgXsg=;
        b=kXVGdwDXTTcFOO1mrtsXznf2AEZYjwXFk/CiYKOyRMMpJ2b3FtJGDVMUNIvqrpJGYP
         v2dSQU1ak1anx5pkkM80dhvmihpvwNCeG6vqILpDFaUGFi+r0Q51FVPvbeIaXnZdBmAj
         r4ts1BnKGkT754+b0Wlxaf8bIunD+kyq6VatxrMa0F6rPmmEkPRI1o36Nia7zR+2NNgY
         GX42SW9eF6GPXGYSWAbpxHWRqqKAcj6GNTduo82cYcT1GbPKZtsWXBweorH/4IrKV8A7
         GPE0oKJqGjCxs8arPWHBtKM/u+EYWtX70nHiRKzQ8L66Pix7IwSY9E9CqUYI3z2rosHX
         jWDQ==
X-Gm-Message-State: AOAM532PV9giwIHwEYpRJOGWdoeRo7od23UwYitwoOUOtnkiKC94UjGp
        ZjMRGXQckmynb7hnhG5aUpOirzJ9bJpBpLvRlSI=
X-Google-Smtp-Source: ABdhPJwfdt2m13rVluP61KSXjdS/shN0vv951DCdcYyHLuk5BLxsJ+nzlopMzbt3IgLYif0iqkr1O0q0o+EFuSIip/o=
X-Received: by 2002:a50:fe94:: with SMTP id d20mr15868605edt.254.1593418789481;
 Mon, 29 Jun 2020 01:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
 <1591697830-16311-3-git-send-email-amittomer25@gmail.com> <20200624061529.GF2324254@vkoul-mobl>
In-Reply-To: <20200624061529.GF2324254@vkoul-mobl>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Mon, 29 Jun 2020 13:49:13 +0530
Message-ID: <CABHD4K-Z7_MkG-j1uAt6XGnz4zWzNYeuEgq=BwE=NXPwY6gb6g@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] dmaengine: Actions: Add support for S700 DMA engine
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for having a look and providing the comments.

> Is the .compatible documented, Documentation patch should come before
> the driver use patch in a series

Yes, this new compatible string is documented in patch (05/10).
I would make it as a patch (1/10).

> >  static int owl_dma_probe(struct platform_device *pdev)
> >  {
> >       struct device_node *np = pdev->dev.of_node;
> >       struct owl_dma *od;
> >       int ret, i, nr_channels, nr_requests;
> > +     const struct of_device_id *of_id =
> > +                             of_match_device(owl_dma_match, &pdev->dev);
>
> You care about driver_data rather than of_id, so using
> of_device_get_match_data() would be better..

Okay. would take care of it in next version.

> >       od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
> >       if (!od)
> > @@ -1083,6 +1116,8 @@ static int owl_dma_probe(struct platform_device *pdev)
> >       dev_info(&pdev->dev, "dma-channels %d, dma-requests %d\n",
> >                nr_channels, nr_requests);
> >
> > +     od->devid = (enum owl_dma_id)(uintptr_t)of_id->data;
>
> Funny casts, I dont think you need uintptr_t!

But without this cast, clang compiler emits following warning:

warning: cast to smaller integer type 'enum owl_dma_id' from 'const void *'
          [-Wvoid-pointer-to-enum-cast]

Thanks
-Amit
