Return-Path: <dmaengine+bounces-8228-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106ED158D4
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 23:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A63D30274C8
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 22:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD8F284B37;
	Mon, 12 Jan 2026 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbhfRBA8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812628488D
	for <dmaengine@vger.kernel.org>; Mon, 12 Jan 2026 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768256463; cv=none; b=Y96/BjKit2r3387bALS6XwHTsPsYA2VgbdvFgiaoeJdsPO0W/5SW2Uky7MkyX4Uu5930RTdktnvfMn6IHlucpN9MdZ0WVWFhV6bL29mKi2yx/Wld3wuCok2VLHbLZl3Zl5dUuUs6I0bViJcuUbCrySPyg/x19ekLUC2DB0vGd90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768256463; c=relaxed/simple;
	bh=4SPFLrU7wrxVmSv7v+NsnMnYgOOi7bckFa4Tw9bRyYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHo/NeWnsafiPEYJ3a7uWEFIU0u1LYuf6dYj0YLobw24Xo0EVQK6xs6zx+sxxGGHIm+vreT/YTbefdw7M205hXb3vzyAkprtu10ruu23Kc+LyNgGQnXoVvHgGkFn1TTI4aMNu/qbOLuGhI0qqmhuACo/eBd4NMSQZNpn/Vrx28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbhfRBA8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c24f4dfb7so3696247a91.0
        for <dmaengine@vger.kernel.org>; Mon, 12 Jan 2026 14:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768256461; x=1768861261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uoiv8fedPQnlXrFULgDUJIq2gVaU1GhpnBWRrOvatjM=;
        b=GbhfRBA8R4AJbAzeRbjl3LO6sBoC0WvNDgwrshG3LHiemMqySaEv2Sf4NHb9dIrT71
         7gYopR67xkbzzAnzBRKyzGzQ1qXZotXnuFpKNhvhe8t90Ds27KXQ+LrxaLvnUYjl4Wca
         BZSpq6sMlR2o6WdvRPoM2yavIVt8rJcDLYQKtdlgT22T2EI+W4j8Ym9q2PmDnm1Fou2d
         ZD5jKDZNOv4fieIVVrCB+lLLFQZIeXu9UsppCedPGUh2CnjDrh3jMnvTu3YqcNd7+kQ4
         O7pAynp9I+C8o9sVbohrBcuJXm3lDqMtersmq8Alc+lOnR8Am78cF4zcolXMnsithgwL
         VVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768256461; x=1768861261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uoiv8fedPQnlXrFULgDUJIq2gVaU1GhpnBWRrOvatjM=;
        b=wtvKVIdECY9evZt3eyzeXbaQ79P1hMSJfcXPr3nNM0NwvnX+PuVEPzlfmVsKfrNuF1
         8dv/aatLB3dU0yUHtI1xnMgJGyLlGCZwIXhQCp0M1mtfJOAugWd78/plTdf+bOOt4aLO
         cf5J7pd94XIf6yofPSyufhxy/1Ro3MkAhY/goKUa+JPmuzffugQL2ti61ng2SOI5de5z
         ITZ3nXYtKkFvFF6kBD3gv5Un2bb5o2p8W9OsrXW62l8LTprEfY/otlHjdg0G0+W36MCH
         yz8nSUSb1WANEiN+jD98CCEnWqcXeAz8mvWSQRXbjvT0kirkq2Bfls0UcAl5aBMdAK5e
         W9eg==
X-Forwarded-Encrypted: i=1; AJvYcCVzAiGWy9jHTo3vL8du8hniVT/Th4FtFVgnIeEaKtuN/ykAEeR/WcLHwmpGgRhCkamn52bXozrZzsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0VjtXBtaOct0Rm5Qj+pTYLwQEkGzOM97tA1342Wk2wzsZPIf
	o2bH9NmjboWib5ZjIT1aT2gacnzjnqGmPcA6PsWGqZaLmCgqFhmcLgW1rMPjOsbDDzclBX/tl+Q
	yVHcijG48y/9appsirI6ovsbPXdZXwRM=
X-Gm-Gg: AY/fxX6at4+DoFP1ODwU1fgIuKCjO0nYlfMfldCKy8H2Vnb1E3W4SGMFHpX3Udck21E
	2W/qzN9vMjRZQ2i2lKbv8JNnViMMcsUCuJZHbzLmrpxtBChunLGD4TLGEEh1h8JtzQ7oGEb0Mte
	Co+xzyI3XIRuUBIhudpyVmfPd6Bsf5tp3IDvzngKqZJhHEyQ6zw08p2yoV1oZ193UVxyj3oJZwe
	Dw6pzjbcXSfcincTqES4h6qrWhUy2PMvkrSZyCntRAnF0rzHoViI/jCrnIf8RgzmYjPQDSgB5ON
	WerplHeXO7tsBfnOWAUXTyIEizOwWC6x6tshpw==
X-Google-Smtp-Source: AGHT+IE7ljtkZSrtzV+qfvV9wG3ZGInUhW/Yj2eTx8GRIuJg6yQ0KjOrmu0plhXgonSN2mFEMGybAsbjpLwGvuJspYM=
X-Received: by 2002:a17:90b:57e4:b0:340:25f0:a9b with SMTP id
 98e67ed59e1d1-34f68cefbf9mr17291828a91.33.1768256461059; Mon, 12 Jan 2026
 14:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108080332.2341725-1-allen.lkml@gmail.com>
 <20260108080332.2341725-2-allen.lkml@gmail.com> <6342bd3d-6023-4780-b3b9-96af7d2a4814@app.fastmail.com>
 <CAOMdWSLX07i_-NjUB6TTXbWVmeFLSNoaTBhvOs0WX6Ad=A6PDA@mail.gmail.com> <7a557097-5dca-4c44-a48f-21dfa2659abc@app.fastmail.com>
In-Reply-To: <7a557097-5dca-4c44-a48f-21dfa2659abc@app.fastmail.com>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 12 Jan 2026 14:20:47 -0800
X-Gm-Features: AZwV_QgfJKT1tiAhM67WF5J1qtR-_Y3PpGHx5sNB2w4LUPkDOZEkrIN5-b_KnvU
Message-ID: <CAOMdWSJ7ut3n-nryTYSyPD37YwN7UqyZ1VcgZ9nmBcRF_jxH=w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] dmaengine: introduce dmaengine_bh_wq and bh helpers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vkoul@kernel.org>, Kees Cook <kees@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >    Thanks for the feedback. My intent with WQ_BH was to keep callbacks =
in
> >   softirq/BH context, but I agree the scheduling overhead and existing =
tasklet
> >   assumptions are valid concerns.
>
> Hi Allen,
>
> Sorry about missing the bit about WQ_BH, I forgot about the details
> of or previous discussion and this is pretty much what I had
> suggested last time,
>
Hi Arnd,

  Sorry I missed the WQ_BH point in my reply, I=E2=80=99d forgotten the det=
ails of our
  earlier discussion, and I should have followed up on this sooner.

> >   I can re-spin the RFC to drop the workqueue entirely and keep
> > tasklet semantics,
> >   while still abstracting tasklet handling into dmaengine helpers so dr=
ivers no
> >   longer directly manipulate tasklets. That keeps
> > dmaengine_desc_callback_invoke()
> >   in tasklet context and avoids breaking DMA users that rely on that be=
havior.
>
> It's probably fine to do both, but a series of two patches (first introdu=
ce
> the per-channel API, then move it over to WQ_BH) may be slightly
> clearer here.
>
> I'm not sure why the dmaengine_*_bh_wq() functions are exported
> interfaces, as far as I can tell, you use them only internally
> in the dma_chan_*_bh() functions, so making them static would
> let the compiler inline them where possible.
>
> There are of course dmaengine drivers that use tasklets for other
> purposes than the channel callback. Was your idea here to use
> the same workqueue for these? I would perhaps hold off on that for
> the moment and see if there is a better alternative for those,
> possibly hardirq context, threaded irq or a regular workqueue
> depending on the driver.
>
> >   A hardirq callback path feels like a larger API change, so I=E2=80=99=
d
> > prefer to handle that as a separate follow=E2=80=91up (e.g. explicit ha=
rdirq
> >  callback/flag + user migration where safe). Thoughts?
>
> Yes, definitely keep that separate. I still think that this is
> what we want eventually for a bigger improvement, but your
> patch seems valuable on its own as well.
>

Thanks for the detailed feedback. I=E2=80=99ll respin along these lines:

  - Split the series into two patches: (1) introduce the per=E2=80=91channe=
l BH API,
    (2) switch the vchan implementation over to the WQ_BH backend if we dec=
ide
    to keep that step. This should make the progression clearer.

  - The dmaengine_*_bh_wq() helpers will be made static; only dma_chan_*_bh=
()
    stays exported.

  - I won=E2=80=99t try to move the other per=E2=80=91driver tasklets onto =
the shared queue in
    this series. That feels like a separate discussion, and the right conte=
xt
    (hardirq/threaded/workqueue) may vary by driver.

  - I=E2=80=99ll keep the hardirq callback path separate. For that follow=
=E2=80=91up, I can plan
    to add an explicit =E2=80=9Chardirq safe=E2=80=9D request bit (e.g. a n=
ew dma_ctrl_flags)
    and update vchan_cookie_complete() to invoke the callback directly when
    requested; otherwise it stays on the tasklet path.

  If you=E2=80=99d prefer I drop the WQ_BH conversion entirely for now and =
keep only the
  tasklet=E2=80=91based per=E2=80=91channel API, I can do that too.

Thanks,
Allen


> Some more thoughts on where that later change could take us:
>
> >    /*
> >   - * This tasklet handles the completion of a DMA descriptor by
> >   - * calling its callback and freeing it.
> >   + * This bottom-half handler completes a DMA descriptor by invoking i=
ts
> >   + * callback and freeing it.
> >     */
> >   -static void vchan_complete(struct tasklet_struct *t)
> >   +static void vchan_complete(struct dma_chan *chan)
> >    {
> >   -    struct virt_dma_chan *vc =3D from_tasklet(vc, t, task);
> >   +    struct virt_dma_chan *vc =3D to_virt_chan(chan);
> >        struct virt_dma_desc *vd, *_vd;
> >        struct dmaengine_desc_callback cb;
> >        LIST_HEAD(head);
> >   @@ -131,7 +131,7 @@ void vchan_init(struct virt_dma_chan *vc, struct
> > dma_device *dmadev)
> >        INIT_LIST_HEAD(&vc->desc_completed);
> >        INIT_LIST_HEAD(&vc->desc_terminated);
> >
> >   -    tasklet_setup(&vc->task, vchan_complete);
> >   +    dma_chan_init_bh(&vc->chan, vchan_complete);
>
> This is where I think it makes sense to start, again for
> the vchan imlmenentation. What the dmaengine drivers have
> is a per-driver tasklet (or WQ_BH) with a single complete()
> function that directly calls into the client drivers for
> each completion that has happened.
>
> Since the context we want depends on the type of client
> driver, I think a good approach would be to start
> by modifying vchan_cookie_complete() to allow it to
> call the callback function directly from hardirq context
> when the client asks for that, and avoid the round trip
> through the tasklet where possible.
>
> A new bit in the dma_ctrl_flags word could be used
> to ask for hardirq vs softirq context, and the existing
> drivers just fall back to using a tasklet for softirq
> context.
>
>       Arnd



--=20
       - Allen

