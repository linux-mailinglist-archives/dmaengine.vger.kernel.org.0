Return-Path: <dmaengine+bounces-9788-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI2JJ7c/zGm+RgYAu9opvQ
	(envelope-from <dmaengine+bounces-9788-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 23:42:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31637218D
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 23:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 856D230FEA5B
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 21:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC914657F4;
	Tue, 31 Mar 2026 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhlLMpCA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25534657F6
	for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992671; cv=pass; b=d4X0qnAqZWp/Yz59QAm7dGIzQl0+GDWkILNLdwvkRrD0ecbO/fRIga2g+axRrw+veD3XQe3C+BOWl+WDdPzsgLkAHdrEXNvnc+aJBDjtLb/5PDECiay8YntcDVeSznLrtQMKjwmAYpqAc4W9+XPUapzhIKeeffXyaUrtsXYfjo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992671; c=relaxed/simple;
	bh=2A2JmefpCGzhygpv75dI+lo6EAqlpCUDR/JlkgSbrRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gzf0/b1eEoP9MW7eCK3og8pbKp/i4ZefuGNH7UphpQFX5BTFSnmLq607IlmaQnkLqBaGtnN0IrXOFDKDW4/ztiZx0dVeYvqdr6RtQ2glDJjYR/XIy6s+9Fv8g9YHTJUwpS3akldOnaz/qcKfYKRSgZMi2AMzCmnrkdypcbhy0SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhlLMpCA; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66bf15430ecso4740606a12.3
        for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 14:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774992668; cv=none;
        d=google.com; s=arc-20240605;
        b=NW6qYWLpVSCvFanO2RvOFpx4Z2fKqE3lvhQSrhHaXz+MM5FscORiJ9hAEuOZddgC6d
         6YZXrGoQ/fam8hgfqvGiKDe9d/BqUySf0ybv8FqrZ7Ox7unIvZxe3RBiwb0w1rsuZVQo
         NOQXxOdITgxQZ6I4Q6ud7zhL+T7rbACDhUiwoUfS4Jk15zX+5OeCJoq3qV3ZOLJde9ar
         HljwDseWull0/cGa+M2P3MtVe9CC3OuFCBnilBeE1aacdBxRkrUyTonD//PmsYYSS0bu
         4X8Gium2tz3UuSQ5ZZYnmxwsQ8+DF7kx9DvomB8j6Z4GQ5ajgyK4GZ2kdiCBrcYE+UwY
         hO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0gAZxdKTrtG0UNe7fhqbtNVst5TpR+8MqiteFQr6YFg=;
        fh=5yCQyCFvCUNVjME2BCR/k+AtUoXmnI7wokdRO8ukVdE=;
        b=aNRoCNRlSpmLvemgvQZBpTunyshIB75k+25joBKuqpGadOyCs06EAzlTmljqufzGzZ
         ezzi8AVQses4PbR6wFwtHDx4uQhfRapCqw2aP2INxGbwOO4xTYGUffpw/xBTkjtyDpwq
         ncDi6W33L4Lh4maoWwVG5EpI2hiAMkTesU5nnOWeeo5NurUaeCW4Bu8kGd86ww5WbnTf
         9BPCCCja1RX/9JgMK9429HxmGNeKe92EIh8E25FNa+6lGiCzbKhgf48cYgvB/FGIg5r2
         wjv3kJz9brP3bE0uhfAy2LW2nwySXH/g/55syAuZscsyDBaYfK0HoyEVLcIOtGIsEe8Y
         kRmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774992668; x=1775597468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gAZxdKTrtG0UNe7fhqbtNVst5TpR+8MqiteFQr6YFg=;
        b=BhlLMpCAhFyvu5S5DhCtDeVfYc8uN/TrrB+L2WWjdry4LGFFuw5vPn4uJuVuFSpYEE
         C0Ulc8DVEGp29GpwarEof2pfnS6t7A0p0Vcz23IHyOb1snGU+Bbqn24gvhBiL9lUvEmc
         Ty+TSfhBMbWOQaCh22rQwhXRMAWllw5VIhFQCyLnJKMnYOv2dPrN9IvQeotReEc0MOt5
         jUiJTCxAuBeilSyELeJFL8lXD9NNNZ8YBdycFnNQEbf/iO92F+s2uqkgGC43uiJVOVoo
         KrMf51fVZHOl2iuza9z/bZOEJGz1jhHvhc6Dp0ltFQXLAnuVeVyVtVPeY/coO1uB8h2V
         TkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992668; x=1775597468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0gAZxdKTrtG0UNe7fhqbtNVst5TpR+8MqiteFQr6YFg=;
        b=IQ1HmWkcWQCziGHiqacNstQ2EqzCYdcPX1axEOp1HC0gZXA8T3T8tXBIBI6Ott3DB7
         i0pW2DhDlqAIgaSGgfBo0mtauVeGGAOZ6zRY9/yzW2GL/PuZCOqxMskZjIgiyI+9Q/VD
         mRr0Ilbt/tnveKkKjIaomFZt+uZes1LP2aJW+VFZ2vYE9gcGEmZPqPW2I48uChoyZ2jD
         VQ7xcHpgmHx9Ix4ByiDpx/FV/LH3RuwNXQWH7WgzRTsHb0lU6eMxsmMNBMmreJj135vv
         OKC8DwJoWLcEB0T5AQ4QvKoR7i4Mz8Hc7EbzUG5keG5n6VV7oEQvFYxMVXtx2JdNEMw/
         5Vwg==
X-Gm-Message-State: AOJu0YyjD6BdazH/KvJ6Arvxc/NYZ8BAWaNXO3iJY+80xVbKk0VjF5vs
	Ns1Nc3lptVOf35arZ8uImV0t/MWdU5YA18N4YDzu2qXTEZEIwhywXI/Qm8bqUgTp59TEtPyMxl2
	olYaSI3gReTBmkV9DFczElglEHbB4TOM=
X-Gm-Gg: ATEYQzy3woGePGLYLzUDIOaTBzcwADa6Dmb6eAif8SNyTCWPePqe6SKT/YYTEfRO5Xs
	mujdy3Mxyxkrve1DL5ih0Ev10tfnr9ITE118q5p/Ru/NtxUtnv2sc1zPuB2xETprN1zwgV6Gr0x
	oDKglibb35Ep59GxTCJQsbPcRm0hQO932KCAZkw3OQwrxAajc0YP5ZBS87P01Dc9NaUGIRhiG01
	Ep9vxezjq0afGO5lqTG/efvmBGvCWL7Z8xOapOX3xkjX3zwVVxNTKMehiY5emyw4s+k+oUirGmz
	Cq45/9i1svF/VacermG68uqJfVHrKl1mMI2l2DAB5wBQetbc55oiOgOisI8Qp+DDDu+N8ICfqo/
	c1XcRVw==
X-Received: by 2002:a05:6402:a0d5:b0:66b:aa56:ee5c with SMTP id
 4fb4d7f45d1cf-66db3f96414mr555333a12.28.1774992668047; Tue, 31 Mar 2026
 14:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328191646.312298-1-rosenp@gmail.com> <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
 <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com> <CAHp75Vdvn9n_qgBsXTBw8mRxdJcrmCi01JfAGz7oTkKQ1uXBmw@mail.gmail.com>
In-Reply-To: <CAHp75Vdvn9n_qgBsXTBw8mRxdJcrmCi01JfAGz7oTkKQ1uXBmw@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 31 Mar 2026 14:30:56 -0700
X-Gm-Features: AQROBzDOlWtP4rTa212l85ZHquL-AO6utx3CmRcZmj7oHcqq8AvGqVreKjXveeQ
Message-ID: <CAKxU2N-QT6KAKzAYDUp_d9ug=1VxHMvegEQDbxS4GumH+8QBWg@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9788-lists,dmaengine=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A31637218D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 9:29=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 30, 2026 at 11:41=E2=80=AFPM Rosen Penev <rosenp@gmail.com> w=
rote:
> > On Mon, Mar 30, 2026 at 1:46=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@gmail.com=
> wrote:
>
> ...
>
> > > > -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
> > > > +       /* Calculate nr_channels from the IO space length */
> > > > +       nr_channels =3D (chip->length - chip->offset) / HSU_DMA_CHA=
N_LENGTH;
> > > > +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_c=
hannels), GFP_KERNEL);
> > > >         if (!hsu)
> > > >                 return -ENOMEM;
> > > >
> > > > -       chip->hsu =3D hsu;
> > > > -
> > > > -       /* Calculate nr_channels from the IO space length */
> > > > -       hsu->nr_channels =3D (chip->length - chip->offset) / HSU_DM=
A_CHAN_LENGTH;
> > > > +       hsu->nr_channels =3D nr_channels;
> > > >
> > > > -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_channels,
> > > > -                                sizeof(*hsu->chan), GFP_KERNEL);
> > > > -       if (!hsu->chan)
> > > > -               return -ENOMEM;
> > > > +       chip->hsu =3D hsu;
> > >
> > > Don't know these _flex() APIs enough, but can we leave the chip->hsu =
=3D
> > > hsu; in the same place as it's now?
> > __counted_by requires the first assignment after allocation to be the
> > counting variable. The _flex macros do this automatically for GCC15
> > and above.
>
> Why? The hsu member has nothing to do with VLA, where is this
> requirement coming from? My understanding is that the check should
> imply the minimum sizeof of the data structure and the compiler should
> know that way before doing any allocations.
Not sure I follow. This patch changes hsu's chan member to a FAM.
Where is VLA coming from?

The current code is devm_kzalloc(x, struct_size()). When it gets
introduced, I'm sure there will be a treewide conversion to
devm_kzalloc_flex, which would automatically set the counting variable
for >=3DGCC15.

It's best practice to assign right after since kzalloc_flex does it anyways=
.
>
> My understanding seems in align with what Gustavo blogged:
> https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-attrib=
ute-in-c-and-linux
>
> The same is written in the GCC patch description
> https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html
>
> --
> With Best Regards,
> Andy Shevchenko

