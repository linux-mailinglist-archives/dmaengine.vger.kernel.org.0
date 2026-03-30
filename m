Return-Path: <dmaengine+bounces-9745-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFWwLfPhymnEAwYAu9opvQ
	(envelope-from <dmaengine+bounces-9745-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 22:49:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8CE36127B
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 22:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49AD63044BBA
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 20:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CA395257;
	Mon, 30 Mar 2026 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyMzFySJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72233393DF7
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903314; cv=pass; b=a9Iz6SU+1EDNimUYXzk+ZUn2xqabhSxdtjj08zR6mcWW9sdcEVAKZuqCRYqUpLvxSuGOdk38A+r8pzXjF3nrrf+PZHcJYfDN6hAXSgN7/tTBvuBQ+6MNAPrNmLAMSh0vyJ4OZB6qijN/5t+Itdv/KYmK9VoRf9XcWJStCeBsprA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903314; c=relaxed/simple;
	bh=DIK3V20QZOCwhmN6cwDKL9qfq86Sgll3B+nkwUxu4A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTu8mZHT4Vy00VVtXWIwUB7rRZwqlB1+6Zc9wJJBU4sg2ZGtpSFuFgH334ux4lCJQ4B38wPmyoawiy1xhp/iNMd0g8/p3aYjdRWNjoJn1SfRt+qRq1BvsCK4MThtvR3lpEcTV4KZGTsEXp2yZaZ1L8bDakLxs/tIZDKlxVBVdtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyMzFySJ; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso7253396a12.2
        for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 13:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774903312; cv=none;
        d=google.com; s=arc-20240605;
        b=aMw4nLUFK3RSNpEm05CtUME1M0tygaQtXQmDo10/EF24FhwfBCr03ZmK+a3Ez2Ij4X
         Sn1ktulNubXfdVU3tBlU5GlbZrXqHg1hQ/rJU6+DEV4WfpGFR/39TWEIlq9FfDG7f8+Z
         fJykUIDTE9zL3Q0YKoXU1W1GdfizrPlE4TBlT2h/nmAEI/d+iPotrqd5vxZnPQ9V8g5V
         9LhxGIO2hZ1DWs12kaSxxUWlV/5gL5b045QwdexItwrl/18LFW+Xn6d0BseAhP24Ea1A
         B4emNY8qNeAQdmlpMDshCPtvbMGERMQ/amcbM1i+l3HKKpCgEITD3lgNNDolJDGGXvjM
         tPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qQLQvYqOdJ6/QLS7K4HwUw3fLx5r205prr9boPIl5PA=;
        fh=5yCQyCFvCUNVjME2BCR/k+AtUoXmnI7wokdRO8ukVdE=;
        b=Vl8jieL2qsdnnuUS7Ab1tjbqm/Bc9W5UoKdmnKKgz/AoyGsYdJQR176c1SU/6rF+xB
         Yv891TQlIJCWPrD10YHUB3/3gI/ujYT0eZaCJfivecaVS5B72e+8qSifp+OCEAT+TeKX
         uw6KFm29Hq8Ga0caLb7cLPV5KxxN51jBwBybpjHBwU6Yd5jlaB5fCCPJ3OIehrjjlkYB
         fihSRVfBCKjn4sjuPEMkFbImFfuJupJsKtl25colAThsVFyrdx9hgzBibA/tb5Exui/V
         sD8l2lMKhcWxFPUJKOzz+UhTsdBcZsh2o40eTFKiYGU8HodtfO1OmK0GGw+q95kmrXVq
         U1Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774903312; x=1775508112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQLQvYqOdJ6/QLS7K4HwUw3fLx5r205prr9boPIl5PA=;
        b=WyMzFySJevzlKkLSoBfI5wLYZEvHyZ6dn1/fMBhf9MJMXOVi3ENJNJqG20SIEIqjFO
         x4z53JUdhr74o7YT9wjk5KxWjowywhESECRaYKuZfcwt8Ixz1Qv7bC9koKkhCN296vSD
         6Yu1Tkx9zMuCcDIV+42fDntGHM1TUEsnF+IUhBFOG6x1Bgf6dqssUyaCJXczTToZQL58
         ytmjYfZD92Eemc2k89Lubr2hV1vXrHZKCu8nBh6kBVDIJOswWXROeGvTa3zbgMO783Hs
         t1j+O8qBC9Bu0Fc8Yt3k0jNjiPkSRi+uW/LX8bWHZKyAhBSyLMHI8ppgIH48ravn9BFx
         WkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903312; x=1775508112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qQLQvYqOdJ6/QLS7K4HwUw3fLx5r205prr9boPIl5PA=;
        b=YPJP6NirzBDpp5K6SnE8CTqECs9yPB+kJc1lFrP56yNGM8R+84aFItL+y9n7nsg+Hl
         Z7M6yU68NEYTsQTAtZTh/JdnF023vnYzqavpKLagtrrbODNIoZ4sB6FPXkdCPNhuQAzI
         QGQ6tA9svhp7lchteKM2f4QOTawunVA0UxjOhEXJzZO1yTyiblOhJ4ixRF4Q/7jPiIxY
         GgEjuNWhOy9Z0J6CxZ1PWb53nrRMh1W8bjImxK3P+0vvAhbgkKGpc21mRDytSB2cfdXy
         ZbTRuNKn2uPXdlCNHc04wNGjBBoVwdWuGMM8zwJgOFyhQ6Mo/kQif7s1ambWkZdKxvME
         B72w==
X-Gm-Message-State: AOJu0YzMZvBZSwkOlnqWSAF0TyUjMyepmnn+wCwXYQ/kCdetIxFaGjqM
	W7OaizJrtgdHIiNq+IOR5mnmwpRONd72F8ve9sZKQl/NwhaLYua7qFAWfr5FHHSIpiFRgCpTiBT
	WJZ1N9f9sUfwFI9+rqmlVFMLpkZsr2HE=
X-Gm-Gg: ATEYQzzBOcmtsOEN91KEJj9z7DHqkxwsHoDI3rDgw3NkU7PZkcA0LqGUThy+6gUK72G
	7ioVQ8EOVG8pkfz48SwkdCJkcKs7HOZPNETYAHburGZ2TDi1gvD6T6CnkRpbKPkXGEqZZ2tXT5i
	1R2Q0WzqCjM9b+EfOmyni7KqHhZ+fOSglmxivhLC6Hg5bnucOe0Ct4tzRwgPBBAX42BR+P9dFMw
	35UDMdmGzpEvxex5bwYd4zB9D1tVTIKBLe0K/73ezafCpcAYqI9M3/3S+d27aGIIugCAn9ahH2T
	nQOK/Iwjmle6OXQc5Dw8KOTcP6wCeJcfqlr8DEJr39T4JeONeJQ3ZGxPEkIOOR4+KSq0IfN/oFR
	Ii01UPQ==
X-Received: by 2002:a05:6402:1469:b0:66c:36d2:6fae with SMTP id
 4fb4d7f45d1cf-66c36d270e1mr219646a12.11.1774903311681; Mon, 30 Mar 2026
 13:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328191646.312298-1-rosenp@gmail.com> <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
In-Reply-To: <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Mar 2026 13:41:40 -0700
X-Gm-Features: AQROBzDXfG62JkfLV_TELbkAYfelfc9Gc3QRSzDnyOpWEW5ceHPkCS80BBCOS2s
Message-ID: <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9745-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2F8CE36127B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 1:46=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > Simplifies allocations by using a flexible array member in this struct.
> >
> > Remove hsu_dma_alloc_desc(). It now offers no readability advantages in
> > this single usage.
> >
> > Add __counted_by to get extra runtime analysis.
>
> > Apply the exact same treatment to struct hsu_dma and devm_kzalloc.
>
> We refer to the functions as func(): devm_kzalloc().
>
> ...
>
> > -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
> > +       /* Calculate nr_channels from the IO space length */
> > +       nr_channels =3D (chip->length - chip->offset) / HSU_DMA_CHAN_LE=
NGTH;
> > +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_chann=
els), GFP_KERNEL);
> >         if (!hsu)
> >                 return -ENOMEM;
> >
> > -       chip->hsu =3D hsu;
> > -
> > -       /* Calculate nr_channels from the IO space length */
> > -       hsu->nr_channels =3D (chip->length - chip->offset) / HSU_DMA_CH=
AN_LENGTH;
> > +       hsu->nr_channels =3D nr_channels;
> >
> > -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_channels,
> > -                                sizeof(*hsu->chan), GFP_KERNEL);
> > -       if (!hsu->chan)
> > -               return -ENOMEM;
> > +       chip->hsu =3D hsu;
>
> Don't know these _flex() APIs enough, but can we leave the chip->hsu =3D
> hsu; in the same place as it's now?
__counted_by requires the first assignment after allocation to be the
counting variable. The _flex macros do this automatically for GCC15
and above.
>
> --
> With Best Regards,
> Andy Shevchenko

