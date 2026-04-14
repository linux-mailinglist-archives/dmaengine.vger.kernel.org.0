Return-Path: <dmaengine+bounces-10015-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3tQCMxrU3mm0IwAAu9opvQ
	(envelope-from <dmaengine+bounces-10015-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 01:56:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B827D3FF288
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 01:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C30A301A096
	for <lists+dmaengine@lfdr.de>; Tue, 14 Apr 2026 23:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10FA3E7171;
	Tue, 14 Apr 2026 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/L6d41G"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA1938424D
	for <dmaengine@vger.kernel.org>; Tue, 14 Apr 2026 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776210964; cv=pass; b=TUfT4vLpMIwi110gKTZ1Wdu/inYBkGVUtCLlDjLLCQ8C+KIdTfOPdpzJKCgDV4okb2CkqYpv4mpk4HdDwrTqVhfsRJxM3PCCfM5DgCDbERyF2FWx+WArsPO3DFfW0iWwO2Bjyr7/GUITRZ/5OUYbIWWjCoDGixMc+EUtIT3HcKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776210964; c=relaxed/simple;
	bh=y7XgWgkBSM0u7n7VbhHpCkbU+WLbxF4zLee8oVSGQxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCRcjvQI4WbDpvjWY2BUjcEluXS8RhysCxRhhBdBeFuk3vgO7Lik6JoHvJTwfz2TmEGL0E6LewnlxPz9By5gUg38Jv/MDDEK/IQadSpNzeZepc3O2Z5CPd3vPpHd/MX6IFIuKeAGB7jmHtsh/FVGofF256y3jk36NXmGH54A6qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/L6d41G; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6720c7968e4so1814348a12.0
        for <dmaengine@vger.kernel.org>; Tue, 14 Apr 2026 16:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776210962; cv=none;
        d=google.com; s=arc-20240605;
        b=lto0TudDIT4rsdwFHWAsnOS8bwC3RBjHvfO7oS6ay01YX+/0gpdR8TTaFhnbei2bqg
         /fw7z6RuPe3o2JB3Bg49zJRJMoNw9PujbOoNy+3ezL2B4y1vBkBMMZhEp9Hl1viVR0N4
         L7JnJ3IbYM2lsRaOgq5FiSU90s1zM+gheYOO6Vet8Qjgp0tm2VUr0IX/UzG5SL8sNF+h
         Im213BtzZ1/FjcDLlhUSPTHQBzUwIdVri/HuwE7qiD7ZnWrd0RIMeSDliQF5qtiKZdyB
         HHntPlO33ZLGRIidAcaBNdLTYhBrkIZJWQsQu62D051nPQ1f1arh/QZwoelVPeApzjnS
         5/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c9NGwEvw3zvZJdwFjwrPp+/w3C9krMuTgJ+uxpVOpFI=;
        fh=EjV16566AQ1hZd4mtUIYoCSKCslkHawnudkpm2bNgoo=;
        b=BS+nF1gjjXI0BhvV4netkAbVQghGFwrW2A7MbfkuCMMif5fNzdIv5f5ZGU/pXQwcfq
         Oc3nq5N4R98FtA/mky/QEMk7TY81XkLzznn8t69bTFAEDXSVqPxDVT+KHfXGZ8fNVKAR
         8JOCLL8i7jbLPglhdJ6R9VfzxlDeogifh72aJF+G9H5jIqFUg2rTEmeRZBJJacDOLO4b
         pc0CYfZcMNSGon/VsCyR2OBCh9xponVkSUQ5Q1wHrHx+n+3n2PwVtpqgGXlC2d3/fdUU
         2mvJoGmxwbagOMnqJY4RxEPb0h3RQf7qBH3UGcODOLP1TJGsws8uCbaY2yN7Hc73pP1w
         Ww7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776210962; x=1776815762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9NGwEvw3zvZJdwFjwrPp+/w3C9krMuTgJ+uxpVOpFI=;
        b=A/L6d41G2LKEOOivBHfti1A+M8gzlFbguvvHMutWDUWzAo862hJJ55pp0aPeukEO5h
         yMQpRFgH2lwLyge/VOaHWAiA8csrKQe7N4+m3ktwQZkBsDEPCAmcdG5p3LV6wxOYJX+i
         tIk6okwVBs9O4EAHSux+4P0ym1fIO+9xtsIHjHvlwuYBwFb3sW0BauWTir966a03HWzW
         qlIo3laqd00MNjW6TI8gUrZyAUivSnq3jFIrDTitfzWCllaNKwGl9Ny3R7x+u23iMpqQ
         XLvmof+ie8Y8OiL2A0bCRBC9FnFyvreoRghIIucrGPYzwCksV28eNwkPlPF9pvEM/U1J
         cP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776210962; x=1776815762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c9NGwEvw3zvZJdwFjwrPp+/w3C9krMuTgJ+uxpVOpFI=;
        b=Q/4trOHryB9a0dTPgJl8QK5WbudOWm71KeRY8252zpJ1y+hmTEnFxbPsIsgWyiE6TZ
         ZhxjmB9y0rPILQuW7lH6I7CaiaQ6ZTmKboTJQckgsSlYtcmmE7KlBNJqPFI0G5qJOmNl
         tWY6by13tZjI3c8B9Nzz3Bv6aackQT+G5WtWEZtcDeQyFlCgSk1TK49HElVrZ8+5v4QG
         rmBwzsF0cGVWiDm7Z35Th4zyjsU2vSJUFxHoBc+l6cI771bqJhLfzeUhEjTAPzu5tjGE
         TE2sw8VztKKjDCAO9TP/cJwAAcPq5lY3yj/5v7JLsOGvKB0SVJGq9OlPQwrltR13DhHE
         UyvA==
X-Forwarded-Encrypted: i=1; AFNElJ8VOPeMqSNuIjWDWTA+kI8z0fzTlib0gUvx4bvJXb50m40vaA+Kl1+rowbw5+9AP95Zh3M+ciLiAew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/Xl5n+Sr9jkNeP/fqSCxK/YfZW94Kpu06/JlOdE5TakfWPJn
	3a4HuB8wtn807rxouC/G7B1+BeVP9Jcu16+4dy62nUoOfWx903b+zkkiir8lMgVcUqxfC1jS7+t
	mwcjX7xvpFPmzZULrG5HREnElv6JCyVk=
X-Gm-Gg: AeBDieswbaHvbCdB3pqU76J0BWINgZDvvOryMtt5U3yzEiU1Zq/TTaf/XjvfDtm7P2s
	7ngfUmk/JjBjk5nsO010s8jINXwjKqtAmu5ad9/i2ZAGZjYW3IFSAaUz2JyZ5kpsf9GrEfmrZST
	jxC/y9odiUJS3jkQAui6CKPNyLuStn9gs59Ch7x9P9r6oB+Y+oCDkg8NxWWbz+IC9ADWoTPmkr0
	bMz0xNCOxMa3MPyNWH3jahJELiPhLCOcbm3OCoTa1PgtP72TymIgYpFl14PExDAb22jc1Hw958U
	vPpDn9hXE7WskF32PhwyLOXx0leF8LpEdn19kLpv5l7CFZ1q+i6QHtrW8d3BIDNgMw/YfRMpPvq
	dADYwCgPWMqPfQn15kA==
X-Received: by 2002:a17:906:f59f:b0:b9d:dc1d:7660 with SMTP id
 a640c23a62f3a-b9ddc1d77a9mr602506366b.7.1776210961238; Tue, 14 Apr 2026
 16:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328191646.312298-1-rosenp@gmail.com> <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
 <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com>
 <CAHp75Vdvn9n_qgBsXTBw8mRxdJcrmCi01JfAGz7oTkKQ1uXBmw@mail.gmail.com>
 <CAKxU2N-QT6KAKzAYDUp_d9ug=1VxHMvegEQDbxS4GumH+8QBWg@mail.gmail.com>
 <CAHp75Vf_Q4OqYgEOBhoFxpKpAkw5_+GJxQCTbA6LnbR0xhOnMA@mail.gmail.com>
 <ad415SF1zIrCof8W@ashevche-desk.local> <CAKxU2N-xb8CKuwxAXMhix9BH31UBSBLwAkxXiewyUQ=t0BsOTQ@mail.gmail.com>
In-Reply-To: <CAKxU2N-xb8CKuwxAXMhix9BH31UBSBLwAkxXiewyUQ=t0BsOTQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 15 Apr 2026 02:55:24 +0300
X-Gm-Features: AQROBzAxO97PyxOP3pR4eo-Z0iwjdUGfYaxFOtjmUaYqYtfLqd53KTVAmq_Xl_Q
Message-ID: <CAHp75VcBTjnYRfOgdObhNwhyx1j224iRoDi46J5ULmPVrVB0Ww@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
To: Rosen Penev <rosenp@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dmaengine@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10015-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andyshevchenko@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,gnu.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B827D3FF288
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 11:47=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
> On Tue, Apr 14, 2026 at 5:41=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Apr 01, 2026 at 04:32:13PM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 1, 2026 at 12:31=E2=80=AFAM Rosen Penev <rosenp@gmail.com=
> wrote:
> > > > On Mon, Mar 30, 2026 at 9:29=E2=80=AFPM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Mon, Mar 30, 2026 at 11:41=E2=80=AFPM Rosen Penev <rosenp@gmai=
l.com> wrote:
> > > > > > On Mon, Mar 30, 2026 at 1:46=E2=80=AFAM Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > > On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@g=
mail.com> wrote:

...

> > > > > > > > -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_K=
ERNEL);
> > > > > > > > +       /* Calculate nr_channels from the IO space length *=
/
> > > > > > > > +       nr_channels =3D (chip->length - chip->offset) / HSU=
_DMA_CHAN_LENGTH;
> > > > > > > > +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, ch=
an, nr_channels), GFP_KERNEL);
> > > > > > > >         if (!hsu)
> > > > > > > >                 return -ENOMEM;
> > > > > > > >
> > > > > > > > -       chip->hsu =3D hsu;
> > > > > > > > -
> > > > > > > > -       /* Calculate nr_channels from the IO space length *=
/
> > > > > > > > -       hsu->nr_channels =3D (chip->length - chip->offset) =
/ HSU_DMA_CHAN_LENGTH;
> > > > > > > > +       hsu->nr_channels =3D nr_channels;
> > > > > > > >
> > > > > > > > -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_chann=
els,
> > > > > > > > -                                sizeof(*hsu->chan), GFP_KE=
RNEL);
> > > > > > > > -       if (!hsu->chan)
> > > > > > > > -               return -ENOMEM;
> > > > > > > > +       chip->hsu =3D hsu;
> > > > > > >
> > > > > > > Don't know these _flex() APIs enough, but can we leave the ch=
ip->hsu =3D
> > > > > > > hsu; in the same place as it's now?
> > > > > > __counted_by requires the first assignment after allocation to =
be the
> > > > > > counting variable. The _flex macros do this automatically for G=
CC15
> > > > > > and above.
> > > > >
> > > > > Why? The hsu member has nothing to do with VLA, where is this
> > > > > requirement coming from? My understanding is that the check shoul=
d
> > > > > imply the minimum sizeof of the data structure and the compiler s=
hould
> > > > > know that way before doing any allocations.
> > > > Not sure I follow. This patch changes hsu's chan member to a FAM.
> > > > Where is VLA coming from?
> > >
> > > VLA: variable-length array
> > > FAM: flexible array member
> > > The second one is VLA member + size member.
> > >
> > > What your patch is doing is changing a pointer to VLA member.
> > >
> > > > The current code is devm_kzalloc(x, struct_size()). When it gets
> > > > introduced, I'm sure there will be a treewide conversion to
> > > > devm_kzalloc_flex, which would automatically set the counting varia=
ble
> > > > for >=3DGCC15.
> > > >
> > > > It's best practice to assign right after since kzalloc_flex does it=
 anyways.
> > >
> > > Still, I'm not convinced we should blindly follow this rule. The
> > > length needs to be known before accessing the VLA, but it's okay to
> > > access other members. Leaving hsu member assignment where it's now is
> > > fine, no need to move it around.
> > >
> > > > > My understanding seems in align with what Gustavo blogged:
> > > > > https://people.kernel.org/gustavoars/how-to-use-the-new-counted_b=
y-attribute-in-c-and-linux
> > > > >
> > > > > The same is written in the GCC patch description
> > > > > https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html
> >
> > If you agree with my reasoning, please send a v4, I will give you a tag=
.
> >
> > Otherwise I really would like to understand the justification why the
> > assignment going first is the best practice and how it may help the dev=
eloper.
> Merge window is closed right now AFAIK.

You mean opened. In any case this kind of patch can still be sent,
it's just no time to review by the maintainers, but on the positive
side while they are busy with other stuff all kind of CIs, test bots,
AI reviews can be performed before the maintainer has a chance to look
at this. Which saves their time as well.


--=20
With Best Regards,
Andy Shevchenko

