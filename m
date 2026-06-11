Return-Path: <dmaengine+bounces-11473-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9Eb2MdzoKmr1zAMAu9opvQ
	(envelope-from <dmaengine+bounces-11473-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 18:57:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0ED673C5A
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 18:57:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jUHSDOLJ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11473-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11473-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0E4532F08DC
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E96332913;
	Thu, 11 Jun 2026 16:37:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862972EEE76
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 16:37:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195830; cv=pass; b=rkeDutMrlVz+HhmFETbrIXJJo/tFxXDbCKNNW0KxiHUWy/idUmQp8SWtGpqjx8X1ZoXdWcg1Y+OKa8V59j5n2FsEwNXs60F6I7mcH5ORHIKB2z/PuyYTKAeTqXU6kNmV0xJrck/h8ltcrSsFipzxh1swJ8+25VF75O7+daJwHw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195830; c=relaxed/simple;
	bh=uHfnAHi9x6mf9wjFGtM7b/sY/5O2/QimffWK1gabFXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GV8/OFUvYj80l4KP65sWlbPSRlglcaBtZqjha6Ekmqz+8RH5QxuJRf9s9XJG1if8phe02FAsf9m0wK08s0YNKyYH5rVLQVNMhDtNIYWB5/7traSFU+ycVbOKECou6lO24S0Bv7ulTSDSbW29a5fQT8ftCCdTJWnhkUYzQpuFv/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUHSDOLJ; arc=pass smtp.client-ip=209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6919f40a0c8so104317a12.0
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 09:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781195828; cv=none;
        d=google.com; s=arc-20240605;
        b=bQ40saZVAnUFQZNEkojK+mKdsbQdwBEmOcB896bTVAa4XalekE3Oep/Fdk1oPHJp8E
         orT32EIgUiQApUXpGKRMtblhtnaER0qRGwcCR1cUllgaDC+duTcs0J7dxzRAFYFeH1hp
         lbGIa/A4J2z5OQScRFXO2hf2lTlU/ZdwGZHsBq/mAAWzZuetx5S/1fUbir9AV91fcJKu
         9JtEzOBiibFJKos8mkVuXoQ0S3VsbROp13PVAKZ92ghvYfOX72Iu+tnUQVrkJxfeu9Pq
         xEY4qdVu/Vpdp6Joy16lEl4i1XXJrov84D1tC1d+wFofmx9l3uiRkUa+H+ZLuC1L1+VI
         60CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4DStYhYQsSipTicO46WKSDE7hgZDuh6T94LBB/5C16M=;
        fh=l5LZZo9YWyjS1zxvGAPeYoaETgB2nj09bwSH/d4QCy4=;
        b=EF3l4xnosv5Oa6dwFi4s/MeGkVcy8XqPncskHz+bfAhmHf8wnMi2b0+ZG7mo5K2n1k
         f1BC0sTdljxhFAcFN0A9qa2fTjfr3MaowbneXRHbpN2n4oMy0SPLGMf7oLt5QaoQXPGX
         OullHFi+YYou4q0FRcArmfsmPtkvsurp0UvguWYJzql+1unyvccBZ7YDgFZfd3cHnz/t
         knJobCgSV9PNR7eyaNS6MmejBiXlWvVqniWg4v6h0Bn1rC2rqV79dHaoyzTt8zdEmfCw
         nHJsWkZ+1UAitIePDrDezoHrMzMaQEBlRH+jAy0UPWxrOXd4RnNEeR/IA3dGebMPtYnQ
         bkDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781195828; x=1781800628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DStYhYQsSipTicO46WKSDE7hgZDuh6T94LBB/5C16M=;
        b=jUHSDOLJZCVuZliLlOqwTHmiH/uhYqjH5YZCUFgmgp7gvw53KQkAHVsSvLN6Z+k63d
         4Kn4A/fo85haf0jYGvVlCGquYQH7+2mHj2izzrItOoO9D7ZqcG7Fi6Dj+p/TnvjjSp1Y
         e7LwytGkxFk5fA8q5/CJyFdReNGMJc8+/wHSyXSwinNJwQ7dpDhPdWWHs7r9woqDo+g5
         yv4soZtXznp6tTO0FzxBT66aQxIcptWXd/SfLtWPdiCAxw7EkDr8S3yk9ibCz4VZY+nZ
         UDuogTjyWsbWdllZTB1EcD1U/77owlR2hebQauI2XwwO7fC6vmaQ6peSKypGZpkXp2O3
         nXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195828; x=1781800628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4DStYhYQsSipTicO46WKSDE7hgZDuh6T94LBB/5C16M=;
        b=B5CS1GfQrfdhZO4bLvmH5dgvSe6dSL81E0HYajo21SZ0nahpa6vwXCqCLS9RLY/kiv
         RDHWCkfkT0aNw+cwuFfkcXFP5ID05R9tRc33Vv+PPeTE1xYNYTp32t9iGEmPMn5Ds7nk
         kVXVGg9EGPfVw01iXDkREijphoIMIKGiKFoqvEzmVjtb1K9Lp//fCOr4KwtsxDlBypHO
         3pmSMY+6a9HgFbQrV3yycCmnqlsWSLJGnXN6WmyBYHUC6PR6dVZz5xLrzSojY+/3T4xc
         bglu378ErEGuc/XOlz/yJiN+knlcho3NcZ4fM6LBoGVGFK10WcozuQ478IS7IVVUTRz+
         Qw3g==
X-Gm-Message-State: AOJu0Yyqs9TPiQyfrwmnkOfafIIZAHnBIEGZVqNjf9uaGOZE0IqyGfie
	TJHrvx2ER1N/v/NC8iz1rvcgrQ+JPGdMWwncubrLCiEqtdulymPsnZCkbF8VKAxJRDQjhWyRTbB
	EzlrSgcK6v1IdVJNYXcXbXPex7VX39qM=
X-Gm-Gg: Acq92OHqzMGZ/arbYBo2zxY+m6+5v987ch1C39RuPE4Gpj6oASHbzgZKrSBNsjIxOJH
	7ckWWN8SR16dcm0NGR1zvxLdWxesDAWeB8/vfP0Z8i4ExDDZFy6+DCCloAP3I9S5Rpx9tE9+w5H
	mbEh8YNryDafCZnzC052zj5QGrseLVAC+YxomLPozfO7CHnuFVibxRbsVNTm1VqQ02Q3OtylUIK
	rg7iyskYEU6rJVGddMm6AOpgl2AGWzkeYQA70F1jhSyqShqYr/U8mHLebg0fB2LXU4pkp71p+2A
	MriJVGpK1L1SOIyit7JIjALyc8qt2i63lKViDAa/DAjdDfaQsBf6866fVb3RBbDkeKXSf7ypyNi
	SpKvtEgRgE+NpZ9HmpZjo8sKOYYst7VMxkvZJoKPEp1s2cT022Ki9UtY8
X-Received: by 2002:a05:6402:358d:b0:687:1c98:a19a with SMTP id
 4fb4d7f45d1cf-6930e2b5e6fmr2054888a12.13.1781195827845; Thu, 11 Jun 2026
 09:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611035245.13439-1-rosenp@gmail.com> <20260611035245.13439-12-rosenp@gmail.com>
 <airV8Wm3yyY4hTQP@lizhi-Precision-Tower-5810> <CAKxU2N9QNMo9u0s_MfYG8qfiWsHqwuB9ax_qbf6gbxA0syOiaw@mail.gmail.com>
 <airjMsF-YPGSt3-S@lizhi-Precision-Tower-5810>
In-Reply-To: <airjMsF-YPGSt3-S@lizhi-Precision-Tower-5810>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 11 Jun 2026 09:36:56 -0700
X-Gm-Features: AVVi8CdY6DBOq_Kf9XCWgkvqCE4_jbHsMoVYEFsNT-EymPwcj5ekivftZTICTTw
Message-ID: <CAKxU2N9aaQhtmYjA+sQqSmgGDoeqEJc=8WFppWN=Q-i=0oPRMA@mail.gmail.com>
Subject: Re: [PATCHv4 11/15] dmaengine: fsldma: convert channel allocation to devm_kzalloc()
To: Frank Li <Frank.li@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Zhang Wei <zw@zh-kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11473-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zh-kernel.org,gmail.com,google.com,lists.ozlabs.org,lists.linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D0ED673C5A

On Thu, Jun 11, 2026 at 9:33=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> On Thu, Jun 11, 2026 at 09:08:32AM -0700, Rosen Penev wrote:
> > On Thu, Jun 11, 2026 at 8:36=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com>=
 wrote:
> > >
> > > On Wed, Jun 10, 2026 at 08:52:41PM -0700, Rosen Penev wrote:
> > > > Convert fsl_dma_chan_probe from kzalloc_obj() to devm_kzalloc(), ty=
ing
> > > > the channel lifetime to the parent DMA device. Remove kfree(chan) i=
n both
> > > > the probe error path and the remove function.
> > > >
> > > > Assisted-by: opencode:big-pickle
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > ---
> > >
> > > If use flexible array, needn't allocate channel
> > Not sure what you mean. A regular array avoids that as well.
>
> Yes, consider only max 8 channel. Now the common method is
>
> fsl
> {
>         ....
>         int chan_count;
>         fsl_chan chan[] __count_by can_count;
> }
>
> scan children node to get total number
right. allocation happens on two compatible strings currently. I guess
it's safe to assume one of each is present in each child.
>
> devm_kzalloc(..., struct_size(fsl, chan_count)) ...
>
> Frank
>
> > >
> > > Frank
> > >
> > > >  drivers/dma/fsldma.c | 12 +++---------
> > > >  1 file changed, 3 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> > > > index e4a3315a7d9d..0df09789187d 100644
> > > > --- a/drivers/dma/fsldma.c
> > > > +++ b/drivers/dma/fsldma.c
> > > > @@ -1114,11 +1114,9 @@ static int fsl_dma_chan_probe(struct fsldma_=
device *fdev,
> > > >       int err;
> > > >
> > > >       /* alloc channel */
> > > > -     chan =3D kzalloc_obj(*chan);
> > > > -     if (!chan) {
> > > > -             err =3D -ENOMEM;
> > > > -             goto out_return;
> > > > -     }
> > > > +     chan =3D devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
> > > > +     if (!chan)
> > > > +             return -ENOMEM;
> > > >
> > > >       /* ioremap registers for use */
> > > >       chan->regs =3D of_iomap(node, 0);
> > > > @@ -1200,9 +1198,6 @@ static int fsl_dma_chan_probe(struct fsldma_d=
evice *fdev,
> > > >
> > > >  out_iounmap_regs:
> > > >       iounmap(chan->regs);
> > > > -out_free_chan:
> > > > -     kfree(chan);
> > > > -out_return:
> > > >       return err;
> > > >  }
> > > >
> > > > @@ -1215,7 +1210,6 @@ static void fsl_dma_chan_remove(struct fsldma=
_chan *chan)
> > > >       tasklet_kill(&chan->tasklet);
> > > >       list_del(&chan->common.device_node);
> > > >       iounmap(chan->regs);
> > > > -     kfree(chan);
> > > >  }
> > > >
> > > >  static void fsldma_device_release(struct dma_device *dma_dev);
> > > > --
> > > > 2.54.0
> > > >

