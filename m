Return-Path: <dmaengine+bounces-8131-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1126D05D95
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 20:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B28A30119ED
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 19:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAC2327C08;
	Thu,  8 Jan 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNkRM1TN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19692F83AC
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767900165; cv=none; b=I4Z5SZPxq+O/B6rt4Zx+VvvrRYIYVtKZyNL8PxnCxKkfRUMbeC1lagNr9eggCWIqaV9FvU+K7aCItNDogzyqq1h9NOxUz0lRYD1mIEkvHFr1T4squgWVpsoXcVBqgrc3tlisu3nEel1khzJ/xJvPX4A0/b/8hql2rSI2eyBeyx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767900165; c=relaxed/simple;
	bh=t4Z3VD6728LhGLXdBEpKiVga1lROVfED1LwZWt2Jyg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jb6xOn7c6fDIVQRtwqVjIRCmY8A8jkpLOARm5XIKTEY8BIhfC6vd1BCdcJAyvJ+hbIRy7+JFOc+Qld/lgMKlfKXP6Lm7fwzHBRGgMZPecxLa9eQFGZAm/ss6EMjdniVR82VO2UQlhXCbePhxqXEfOva7yrUBRSOQRAURwTagXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNkRM1TN; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so1128203a91.1
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 11:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767900160; x=1768504960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewQDLj6PeOf0xkSdKM/nQd4LAw9twFc8iVg/UDCABew=;
        b=aNkRM1TNQlcXZ4dVqIMJq2O0Fj2tajxc7bCfWO5EqiUA3PDdBqNFoY5KULDP2QD9mT
         sHKg6gAofe0II+vw48E1GZbcmrzsRHoeFbExfHVEh3KzNmNKN39d7TSYuCDQjUTX06tw
         vcCBIRH9FM6+JF/8ZTAI7F3X+k55im3oCiG+9bwGFOrlGwM2GRLL/N+OA6pnlZMMJpVQ
         HOk/Jl5N8eWGfYPpDez8U2p+Ot4YPQBuB0gVjpdM7fQ/uA4w3i7StCi8IheakmARkX8E
         4raEZHPOcDzcbGXBhPFOuYkC4/+7IDjw2geF5HiVpgGS1i4VSMxtwaQMHCLtJFIkw92b
         d+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767900160; x=1768504960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ewQDLj6PeOf0xkSdKM/nQd4LAw9twFc8iVg/UDCABew=;
        b=l8VQPBwdrRPBeWxwBlj+9Yorx+5GtzRfLvSvc+tF1sj5zixvQAHEkpzgza0Yt2HE4S
         Mkj78X4B1LyH2K68lZ6jlGxvfBKvxu5BbkKf6y+uM5Zd7BEnA+x+40bfyvH2aKtiX2QH
         RIo6k16TWc671m8Bimvswjs+fc/b3aPuvF2N/DqjcgpsgiDY8B5Z+tTNl6EgST1i+Zs0
         LopGXLH6G2+N7RQ+/F/5OoftgGRZ0VHSq2NarTkk/zrdGpmpWB6r+GfrOT7MUhX3aldV
         6Ff/rTwX7iLUVQrhAMdy2c8NoqhLCResINcXb+qtb4MmJ7VBUqRPH8DUuY+MS+4AoJuE
         MNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Iyz52w1VBZeNqJ5fFrSh+qcoSYr3WVxW3zr1Vf4Gn2it+NjKzPd6QX9+xJKzTo8s0GrPhda1bqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0j2gdxaJjjTvsYR7DDc0oh1WPWH9eBwG/Ez1ytzvxZyDUOGmA
	5T9GXqtL8hcK9gZsQNas5D3KNOzE1A4wcMnod64tcGH4O1eLIACeSaTKx06wuwqjE+Sw6b/W9Ke
	iun7QBT+vgx2GReED3uAJqvbnnopX3AvInP26KFk=
X-Gm-Gg: AY/fxX7NgTZewRhgOxfBqpmOKMZ7gH1ItJOIW6rNXhRqYbcdlhqqPreRxt0oQPhknj+
	m21SCgKTbT8UYGQD0L86z4HbmQAqiBg20ovAJ5lNDT5OQhv5LPeSIl62yKDM5yoRwTwD0SHUE0o
	r0+fr8O2jIuX8hZ0DR33NUFVlNOOpjJUD2svrVuulSHm5iGt/wh1nUQ+TtpTw6onyJ1cM7WJivJ
	F+HlQuNxy6/L7z2EK/qWrsQbnWehBusLyWltB3DBxxB5PQ4d/Hgk52y1rlsXOJIt+72+6K7C05a
	a5Vv+QI42st1/lx7cZBGPZlrux4F3UUf2zNEdg==
X-Google-Smtp-Source: AGHT+IGOvqgtXzn9Sjr6lffvD827Ke3YkF9+HNBPSlPoAuFOQHGR3JQVKDvk8B6eLgsy9Q7tBOMBoejckjL5EirRluI=
X-Received: by 2002:a17:90b:6c7:b0:34e:6e7d:7e73 with SMTP id
 98e67ed59e1d1-34f5f8fe873mr9703169a91.11.1767900160337; Thu, 08 Jan 2026
 11:22:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108080332.2341725-1-allen.lkml@gmail.com>
 <20260108080332.2341725-2-allen.lkml@gmail.com> <6342bd3d-6023-4780-b3b9-96af7d2a4814@app.fastmail.com>
In-Reply-To: <6342bd3d-6023-4780-b3b9-96af7d2a4814@app.fastmail.com>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 8 Jan 2026 11:22:27 -0800
X-Gm-Features: AQt7F2rgyNyMlcR3vO0vedgCM82uH3YFB6L_NH3vamSMA57HmpIrSYJQmfBq0Gw
Message-ID: <CAOMdWSLX07i_-NjUB6TTXbWVmeFLSNoaTBhvOs0WX6Ad=A6PDA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] dmaengine: introduce dmaengine_bh_wq and bh helpers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vkoul@kernel.org>, Kees Cook <kees@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > Create a dedicated dmaengine bottom-half workqueue (WQ_BH | WQ_PERCPU)
> > and provide helper APIs for queue/flush/cancel of BH work items. Add
> > per-channel BH helpers in dma_chan so drivers can schedule a BH callbac=
k
> > without maintaining their own tasklets.
> >
> > Convert virt-dma to use the new per-channel BH helpers and remove the
> > per-channel tasklet. Update existing drivers that only need tasklet
> > teardown to use dma_chan_kill_bh().
> >
> > This provides a common BH execution path for dmaengine and establishes
> > the base for converting remaining DMA tasklets to workqueue-based BHs.
> >
> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
>
> Hi Allen,
>
> I agree that the dmaengine code should stop using tasklets here,
> but I think the last time we discussed this, we ended up not
> going with work queues as a replacement because of the inherent
> scheduling overhead.
>
> The use of this tasklet is to invoke the dmaengine_desc_callback(),
> which at the moment clearly expects to be called from tasklet
> context, but in most cases probably should just be called from
> hardirq context, e.g. when all it does is to call complete()
> or wake_up(). In particular, I assume this breaks any console
> driver that tries to use DMA to send output to a UART.
>
> It may make sense to take the portions of your patch that
> abstract the dmaengine drivers away from tasklet and have them
> interact with shared functions, but I don't think we should
> introduce a workqueue at all here, at least not until we
> have identified dmaengine users that want workqueue behavior.
>
> If your goal is to reduce the number of tasklet uses in the
> kernel, I would suggest taking this on at one level higher up
> the stack: assume that dma_async_tx_descriptor->callback()
> is always called at tasklet context, and introduce an
> alternative mechanism that is called from hardirq context,
> then change over each user of dma_async_tx_descriptor to
> use the hardirq method instead of the tasklet method, if
> at all possible.

Arnd,

   Thanks for the feedback. My intent with WQ_BH was to keep callbacks in
  softirq/BH context, but I agree the scheduling overhead and existing task=
let
  assumptions are valid concerns.

  I can re-spin the RFC to drop the workqueue entirely and keep
tasklet semantics,
  while still abstracting tasklet handling into dmaengine helpers so driver=
s no
  longer directly manipulate tasklets. That keeps
dmaengine_desc_callback_invoke()
  in tasklet context and avoids breaking DMA users that rely on that behavi=
or.

  A hardirq callback path feels like a larger API change, so I=E2=80=99d
prefer to handle
  that as a separate follow=E2=80=91up (e.g. explicit hardirq callback/flag=
 + user
  migration where safe). Thoughts?

  Here=E2=80=99s a diff on top of v6.19-rc4 that does exactly this.

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
  index ca13cd39330b..611047763b35 100644
  --- a/drivers/dma/dmaengine.c
  +++ b/drivers/dma/dmaengine.c
  @@ -1425,6 +1425,48 @@ static void dmaengine_destroy_unmap_pool(void)
       }
   }

  +static void dma_chan_bh_entry(struct tasklet_struct *t)
  +{
  +    struct dma_chan *chan =3D from_tasklet(chan, t, bh_tasklet);
  +    dma_chan_bh_work_fn fn =3D READ_ONCE(chan->bh_work_fn);
  +
  +    if (fn)
  +        fn(chan);
  +}
  +
  +void dma_chan_init_bh(struct dma_chan *chan, dma_chan_bh_work_fn fn)
  +{
  +    if (WARN_ON(!fn))
  +        return;
  +
  +    if (WARN_ON(chan->bh_work_initialized))
  +        return;
  +
  +    chan->bh_work_fn =3D fn;
  +    tasklet_setup(&chan->bh_tasklet, dma_chan_bh_entry);
  +    chan->bh_work_initialized =3D true;
  +}
  +EXPORT_SYMBOL_GPL(dma_chan_init_bh);
  +
  +bool dma_chan_schedule_bh(struct dma_chan *chan)
  +{
  +    if (WARN_ON(!chan->bh_work_initialized))
  +        return false;
  +
  +    tasklet_schedule(&chan->bh_tasklet);
  +    return true;
  +}
  +EXPORT_SYMBOL_GPL(dma_chan_schedule_bh);
  +
  +void dma_chan_kill_bh(struct dma_chan *chan)
  +{
  +    if (!chan->bh_work_initialized)
  +        return;
  +
  +    tasklet_kill(&chan->bh_tasklet);
  +}
  +EXPORT_SYMBOL_GPL(dma_chan_kill_bh);
  +
   static int __init dmaengine_init_unmap_pool(void)
   {
       int i;
  diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
  index 7961172a780d..3d3fadb81f8d 100644
  --- a/drivers/dma/virt-dma.c
  +++ b/drivers/dma/virt-dma.c
  @@ -77,12 +77,12 @@ struct virt_dma_desc *vchan_find_desc(struct
virt_dma_chan *vc,
   EXPORT_SYMBOL_GPL(vchan_find_desc);

   /*
  - * This tasklet handles the completion of a DMA descriptor by
  - * calling its callback and freeing it.
  + * This bottom-half handler completes a DMA descriptor by invoking its
  + * callback and freeing it.
    */
  -static void vchan_complete(struct tasklet_struct *t)
  +static void vchan_complete(struct dma_chan *chan)
   {
  -    struct virt_dma_chan *vc =3D from_tasklet(vc, t, task);
  +    struct virt_dma_chan *vc =3D to_virt_chan(chan);
       struct virt_dma_desc *vd, *_vd;
       struct dmaengine_desc_callback cb;
       LIST_HEAD(head);
  @@ -131,7 +131,7 @@ void vchan_init(struct virt_dma_chan *vc, struct
dma_device *dmadev)
       INIT_LIST_HEAD(&vc->desc_completed);
       INIT_LIST_HEAD(&vc->desc_terminated);

  -    tasklet_setup(&vc->task, vchan_complete);
  +    dma_chan_init_bh(&vc->chan, vchan_complete);

       vc->chan.device =3D dmadev;
       list_add_tail(&vc->chan.device_node, &dmadev->channels);
  diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
  index 59d9eabc8b67..75c6fee2f70e 100644
  --- a/drivers/dma/virt-dma.h
  +++ b/drivers/dma/virt-dma.h
  @@ -8,8 +8,6 @@
   #define VIRT_DMA_H

   #include <linux/dmaengine.h>
  -#include <linux/interrupt.h>
  -
   #include "dmaengine.h"

   struct virt_dma_desc {
  @@ -21,7 +19,6 @@ struct virt_dma_desc {

   struct virt_dma_chan {
       struct dma_chan    chan;
  -    struct tasklet_struct task;
       void (*desc_free)(struct virt_dma_desc *);

       spinlock_t lock;
  @@ -106,7 +103,7 @@ static inline void vchan_cookie_complete(struct
virt_dma_desc *vd)
            vd, cookie);
       list_add_tail(&vd->node, &vc->desc_completed);

  -    tasklet_schedule(&vc->task);
  +    dma_chan_schedule_bh(&vc->chan);
   }
  @@ -137,7 +134,7 @@ static inline void vchan_cyclic_callback(struct
virt_dma_desc *vd)
       struct virt_dma_chan *vc =3D to_virt_chan(vd->tx.chan);

       vc->cyclic =3D vd;
  -    tasklet_schedule(&vc->task);
  +    dma_chan_schedule_bh(&vc->chan);
   }
  @@ -223,7 +220,7 @@ static inline void vchan_synchronize(struct
virt_dma_chan *vc)
       LIST_HEAD(head);
       unsigned long flags;

  -    tasklet_kill(&vc->task);
  +    dma_chan_kill_bh(&vc->chan);

       spin_lock_irqsave(&vc->lock, flags);
  diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
  index 99efe2b9b4ea..2d2c8ab3764d 100644
  --- a/include/linux/dmaengine.h
  +++ b/include/linux/dmaengine.h
  @@ -12,6 +12,7 @@
   #include <linux/scatterlist.h>
   #include <linux/bitmap.h>
   #include <linux/types.h>
  +#include <linux/interrupt.h>
   #include <asm/page.h>
  @@ -295,6 +296,10 @@ enum dma_desc_metadata_mode {
       DESC_METADATA_ENGINE =3D BIT(1),
   };

  +struct dma_chan;
  +
  +typedef void (*dma_chan_bh_work_fn)(struct dma_chan *chan);
  +
  @@ -334,6 +339,9 @@ struct dma_router {
    * @router: pointer to the DMA router structure
    * @route_data: channel specific data for the router
    * @private: private data for certain client-channel associations
  + * @bh_tasklet: bottom-half tasklet stored per-channel
  + * @bh_work_fn: callback executed when @bh_tasklet runs
  + * @bh_work_initialized: indicates whether @bh_tasklet has been initiali=
zed
    */
   struct dma_chan {
  @@ -359,6 +367,9 @@ struct dma_chan {
       void *route_data;

       void *private;
  +    struct tasklet_struct bh_tasklet;
  +    dma_chan_bh_work_fn bh_work_fn;
  +    bool bh_work_initialized;
   };
  @@ -1528,6 +1539,9 @@ struct dma_chan *devm_dma_request_chan(struct
device *dev, const char *name);

   void dma_release_channel(struct dma_chan *chan);
   int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *cap=
s);
  +void dma_chan_init_bh(struct dma_chan *chan, dma_chan_bh_work_fn fn);
  +bool dma_chan_schedule_bh(struct dma_chan *chan);
  +void dma_chan_kill_bh(struct dma_chan *chan);
   #else
  @@ -1575,6 +1589,20 @@ static inline int dma_get_slave_caps(struct
dma_chan *chan,
   {
       return -ENXIO;
   }
  +
  +static inline void dma_chan_init_bh(struct dma_chan *chan,
  +                    dma_chan_bh_work_fn fn)
  +{
  +}
  +
  +static inline bool dma_chan_schedule_bh(struct dma_chan *chan)
  +{
  +    return false;
  +}
  +
  +static inline void dma_chan_kill_bh(struct dma_chan *chan)
  +{
  +}
   #endif


>
>       Arnd



--=20
       - Allen

