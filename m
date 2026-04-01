Return-Path: <dmaengine+bounces-9811-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ+vFF4gzWnOaAYAu9opvQ
	(envelope-from <dmaengine+bounces-9811-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 15:40:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B0537B618
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 15:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 338E9303430A
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B600A2C0296;
	Wed,  1 Apr 2026 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drl+lWPr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006C29D294
	for <dmaengine@vger.kernel.org>; Wed,  1 Apr 2026 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050374; cv=pass; b=V2xQqghNFcmIPfZnvp7CQuC7WASFML3DaYDsEncNFlP4W9GVxrbE9/+NJJJrqr43PzKHkq5Cbv8EfbbyR5Ey6XYjr2W+FRecaih45o/iUpYD2/VCWBLf7RKrjcXweM0gUQgRO7M72fNIANvI9JiPwj1Uk8Rrj9j9pSloJLeP1oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050374; c=relaxed/simple;
	bh=ykZlBQP3ui0pr+RmE/BDkLgSNESXpnvh5+IEQp6F9Qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4jGEeMf0864PMmDWp3nEiu0bZJXfuaDyCLunog6jqYF3DGy6JdlZjxSAL3IklUaXdL/wlONT+2kddHgIzU16oJEAHYuwVOwekadcHj14OwXjzsXt5GhyeBRck28pyMmHVFPdrKfn5rvnPixKQSiTp7EzcaCldAGJvtwab4jTco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drl+lWPr; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so121387266b.0
        for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 06:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775050372; cv=none;
        d=google.com; s=arc-20240605;
        b=UqkZUuw3lZ+sGD/5X2d9a+l1ihxnoIhSAVT4i6Uc9h9GdFnMkXW/Gd12u0UlRmZJF5
         19903H5wpr4dKzM5Wg/1rGH60sOTzUsqiCFGshcScbT3uuEeigYKt+skbQQkEvvSvFRt
         GtWE/1JMn1voFxjwadgfEdwCAs/Fd9BQGuBhtMcMyNp+0/AQt+1aqeV/Tn1CzX59Vfmc
         jY0pcaVWEhN4Bd0LnVgBIr/lsAdkCjIkOl+NxeLC6dWQmEeTYsu91hPVmJCbUgkKIJAU
         3iY69z++atnyxGG2yQCS8C8K6uxLcLKaTefoJfAYbKKGYSLvkCTHWi1+H1Jw5sfkcM04
         D02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XdQtbwlhskFWFC4jOk1CfaWVr+c6qUIfl9XMYThbgKA=;
        fh=22r3XkhgFXYlo01h1jYb+ZSltnvR0YVp6gSI4ip4x/I=;
        b=OWs2R12lgxQr4wY5czXOHchVgMYw/8HCVOUfXzluZLM8gqARk0DLV76kUppMW2LElL
         cqOAg82T1oRshkk+dGZSAhe3QZTmtUL7dJeRaoaMuox9YeSoldS8P26lDG2RR+Jqxy0t
         DHftYSEp7nAZT9flGcZ/Z+DpmnFOAqRe7OsPhUZTZicZxsF2VX3vUt1MF+Hbm8el1ZD7
         5SWM94ziJHWUMKWaauo+Prt4r2APEI1WGlZmEajsQSCr41m7Q5h4lK82+gHavbcKGmoH
         QWLMlmM1Pf19ZvUl43OJ59Frg3seqYvvnvISRIPEClfTQFAy0KSY/VzVjGr5fTuhbCfa
         qq0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775050372; x=1775655172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdQtbwlhskFWFC4jOk1CfaWVr+c6qUIfl9XMYThbgKA=;
        b=drl+lWPrtGiBxHOM5pgDFJD5CmHy4v+/dJJYWTH3SiBxikgnLRDfkCshRpArShhvih
         0hoNNwidgE8RbdojmOd3fvO3/gHoNCpX0ptr+DKqBEdJKb4qsvIpxb3sfNSQS9ez41y2
         QEwM7RjkQGHgqER68SGmVRFzlfdSBj3SwuyYGrROcTkUsiBqD8cBZUJfVjvSQL/LWjZd
         8V4D0GyYu+dpm8YUA4tJBu967oq0XHtkV2FIxxFPZ3zRaybk2OMr9nvl+Ud5y6KQ5Cr6
         7PNIgYhd27tK4o+zuqn3EWSwaB/RpbKraO5xiNtKg6K6+qRWTZu1DfX8GRIwnggCQrmY
         YHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775050372; x=1775655172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XdQtbwlhskFWFC4jOk1CfaWVr+c6qUIfl9XMYThbgKA=;
        b=FO9qxTVjufxetVS6HqjVDwQ5/0MlbDf1v4SdhTJSCiAvlYVmZ08cDvgK04+uNFC1IE
         jc+IMERf8SHrUBEWtU2gqr1UHCFys+tjECLuCPBJ/S0J9EczjYLMPh1QtIG04tB4YbiH
         OMJLeKmY3kn1G40qnzNovUTZdkfFABypFkwfq2w6RcBR8tDBYyq234LI/rE1vSV8I2Oy
         sGwOYF84LFVdD88RBH80+uZbvYyWXy2XisuFmMYuSNz0yVfvr1KTfljzLNxNo0IkxgK+
         zHfNsDwuChopOAVUh3uo5rmc3ljzqHAO2OlGUScQEvZJFezg/3phLC+hXUAxQvUlKC/b
         69xg==
X-Gm-Message-State: AOJu0YyEpt0HK9CsSQlDZRbaBzPHpgvMSDje+MGJ/WGRUGcLGOE+OLxh
	eUn4wcLh0wTHicibTKvj3UyPDhNNe7lGTn5nUL6QVR+TdtgEyrfFF98m/fdBHBLVqx9dOKyQkQU
	ZsZstEwHqPuCclvdR8BInBG+APk7VUaE=
X-Gm-Gg: ATEYQzxM8IhmiXCosZcvEEdw80koBj8IwSIwWj8soagspEiawZDhLzrQlbdTpvZKt2L
	VFOmmHnL3yx0AfUGgH8h6w+f7F4fPtpfd9N/G0qsk8c8jrC6loYaqwTD1Vj6GLbqtOoEE0yLAyr
	E1lQ6pzzl6zZZ/fCWJ+6QWJUuYSYbJbn44E5Rh7ztzxWj5Efx2OzSdWmRKUjSyw6hdZguHA8oEc
	1khfCY2SmuyWlUVoRx6BmLAJNKnAFzDoPfOXVnPHhPM7WRaUxZCF1T1Hb/LlKgW4pia443X7myL
	4cS9EkMwkjvTAoCe/Clq3pQB5cuaV9GpR3T3gqW9Oa4xN2fCbSUMVO4+i1gOwmo6xmoH2L4U/H9
	Xdj8fg+4=
X-Received: by 2002:a17:906:891:b0:b98:2c19:6c49 with SMTP id
 a640c23a62f3a-b9c139028e4mr197175066b.18.1775050371154; Wed, 01 Apr 2026
 06:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328191646.312298-1-rosenp@gmail.com> <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
 <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com>
 <CAHp75Vdvn9n_qgBsXTBw8mRxdJcrmCi01JfAGz7oTkKQ1uXBmw@mail.gmail.com> <CAKxU2N-QT6KAKzAYDUp_d9ug=1VxHMvegEQDbxS4GumH+8QBWg@mail.gmail.com>
In-Reply-To: <CAKxU2N-QT6KAKzAYDUp_d9ug=1VxHMvegEQDbxS4GumH+8QBWg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 1 Apr 2026 16:32:13 +0300
X-Gm-Features: AQROBzDcdLuWeJRe3D71X4YVGCYTKmrY5ZFcR0AhiBibbvw6usBcWjOKiaIKYno
Message-ID: <CAHp75Vf_Q4OqYgEOBhoFxpKpAkw5_+GJxQCTbA6LnbR0xhOnMA@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9811-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andyshevchenko@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: C0B0537B618
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 12:31=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
> On Mon, Mar 30, 2026 at 9:29=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 30, 2026 at 11:41=E2=80=AFPM Rosen Penev <rosenp@gmail.com>=
 wrote:
> > > On Mon, Mar 30, 2026 at 1:46=E2=80=AFAM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@gmail.c=
om> wrote:

...

> > > > > -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL)=
;
> > > > > +       /* Calculate nr_channels from the IO space length */
> > > > > +       nr_channels =3D (chip->length - chip->offset) / HSU_DMA_C=
HAN_LENGTH;
> > > > > +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, chan, nr=
_channels), GFP_KERNEL);
> > > > >         if (!hsu)
> > > > >                 return -ENOMEM;
> > > > >
> > > > > -       chip->hsu =3D hsu;
> > > > > -
> > > > > -       /* Calculate nr_channels from the IO space length */
> > > > > -       hsu->nr_channels =3D (chip->length - chip->offset) / HSU_=
DMA_CHAN_LENGTH;
> > > > > +       hsu->nr_channels =3D nr_channels;
> > > > >
> > > > > -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_channels,
> > > > > -                                sizeof(*hsu->chan), GFP_KERNEL);
> > > > > -       if (!hsu->chan)
> > > > > -               return -ENOMEM;
> > > > > +       chip->hsu =3D hsu;
> > > >
> > > > Don't know these _flex() APIs enough, but can we leave the chip->hs=
u =3D
> > > > hsu; in the same place as it's now?
> > > __counted_by requires the first assignment after allocation to be the
> > > counting variable. The _flex macros do this automatically for GCC15
> > > and above.
> >
> > Why? The hsu member has nothing to do with VLA, where is this
> > requirement coming from? My understanding is that the check should
> > imply the minimum sizeof of the data structure and the compiler should
> > know that way before doing any allocations.
> Not sure I follow. This patch changes hsu's chan member to a FAM.
> Where is VLA coming from?

VLA: variable-length array
FAM: flexible array member
The second one is VLA member + size member.

What your patch is doing is changing a pointer to VLA member.

> The current code is devm_kzalloc(x, struct_size()). When it gets
> introduced, I'm sure there will be a treewide conversion to
> devm_kzalloc_flex, which would automatically set the counting variable
> for >=3DGCC15.
>
> It's best practice to assign right after since kzalloc_flex does it anywa=
ys.

Still, I'm not convinced we should blindly follow this rule. The
length needs to be known before accessing the VLA, but it's okay to
access other members. Leaving hsu member assignment where it's now is
fine, no need to move it around.

> > My understanding seems in align with what Gustavo blogged:
> > https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-attr=
ibute-in-c-and-linux
> >
> > The same is written in the GCC patch description
> > https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html

--=20
With Best Regards,
Andy Shevchenko

