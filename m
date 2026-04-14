Return-Path: <dmaengine+bounces-10014-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNrtHNOn3mlTHAAAu9opvQ
	(envelope-from <dmaengine+bounces-10014-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Apr 2026 22:47:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C753FE72E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Apr 2026 22:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28404300F12D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Apr 2026 20:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1F1351C29;
	Tue, 14 Apr 2026 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/uXR2x8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125C371D1F
	for <dmaengine@vger.kernel.org>; Tue, 14 Apr 2026 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199631; cv=pass; b=H5yvMserXZQ7EMfAu3wp9OR5lkFwdvcA+CUzlP5HzBUuc0y+tvBCv8aEVEesG6tGhEUACUYKvHJMJac286EPLWOJYTtFqlfYdF08oZGmAgA/uRgzMzFY/ndM/ePJmK1zK89clyyjDcc1XGM5MmEYB3MRFY96uDt4ChzeO9v6m1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199631; c=relaxed/simple;
	bh=w74mUAf5VahjnEJnuSGpY2y5M9gKcwnQOiPx4hHYhvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKYDfQ2c6Zikqwtdg7KWvxGbpPLbrp+MrbmaXu8XQya4O/LdpB+beF0qOgwX97i6bK5SqYSM5huVS40BKr7+S7dWd+IPGwLKpwObgy9tEOU860c4p78Ts22ku37SF23Hesi/DeP7qEx7i3LKMdAMiZj0LCNJl8MnO3Ujuw8Tty8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/uXR2x8; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-671ae79e617so2935509a12.3
        for <dmaengine@vger.kernel.org>; Tue, 14 Apr 2026 13:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776199629; cv=none;
        d=google.com; s=arc-20240605;
        b=GGyv6t4RmJTQh/lHYix0pYqrepneTo4f3YXSt5dYqu7znjsWlBII4BEE23k8y1MNTK
         GeUVXZ//HAq05ZkYpk99tTRLQBp8VmZO0UuO/2Qu0z21ohyM6Myk3cIXTGgYyXi5pPxS
         SNoTBsc8aAW11L0LbHGjmJVgF1aiY5neQhG+JMCEHdChOZh+H4zwOJCyZUJvhJC58mAJ
         1qYgJ+zjOleeVD7ecRCMHEexnQ6tP1A0w2o5XdvfX9sjpS+xn59bgt/6bb9TI3oxgD7w
         RA+ZROF2G1RmE7YjCb79UAMPeRO/EM8s2f1xdx3bYmEY0HxSeORaiDNEhFFaBURs0GH5
         uXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ULQscP/jHQhzC6bIBAm/mnPePwL8/2Be+C8MegQPnW0=;
        fh=x+FQWSdGliD2GXZCRWAICkTVTX6I+XolA51YjeCbxcY=;
        b=KtwPBg5gNZQ4BdQ0q+A4keV1+1o5cSAndN5OsE3GpkODak+O7iNLo4Tm4m6QEaB0PT
         YF9c1mzQdWjPXmk+7zo4FDWKN8vWcRH0CUEJxrIsGNDNAxmPdwLDkX9brIQzcxwfpd1t
         udIuVU6i0DaJaqq9yILRd0U5wKd6TWYGggMVDBvLjp+PYCZG8Di1Q8cWnaeNiBVbzqBg
         deBaTA9gy4Ykscbk1fVNbPCM8ySavVxysnI5b5snideawk/GT0DlvUwOs+lgJrF1YHFw
         5fakE3Ngn+GyxZU0ToiDUkXoqYHQ6IbHcLNVhy6lJn6qpF4wy0NH9FZI0NIqdrvGJ7ti
         rUcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776199629; x=1776804429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULQscP/jHQhzC6bIBAm/mnPePwL8/2Be+C8MegQPnW0=;
        b=T/uXR2x8sOCQj5JnasSVimdT6XFAD2+dgKJXcruygbd3Wg94RRCAbg2ga4qLnsB6yu
         lqI3cB0t0TmY9180yQ5ibTlO/l0Wg/XCkbMzWiblqfRwcSm9x8RXUArCBhqijGNCysa0
         ajulAScKpCiGw+rw+3oNHzWXjuDnDyynYymeec0GZjP953MiDfZ1TCvuHU27azqAVdbZ
         Xw7p5IN08uO32maJke1OORpyPJeM/e55zARQW9/omz/AWJVRcKYlYaksGNTt8lYLhfMz
         SmQvrS9bns8CjreKiok+ZKe4K4Hz/eMdUvB2drayDR24909WAAeWzg58Q1yApBcu9VvO
         4G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776199629; x=1776804429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ULQscP/jHQhzC6bIBAm/mnPePwL8/2Be+C8MegQPnW0=;
        b=EqbD5GWZjEULfRy41W1Epgi5vYyeaPiUSYrgiRj59dFj97tdotx3sTzZbql4cmTIiK
         /MHKk2gonN2/pqEqrX5b79xSyJSBDkyLauC9wWhfYsPjrMxd4GRBclB41FObkpxCLSLo
         851VJ+Nz5w8Z3n6UX1sl1pHAkpIz4dyetb/PUBMt6+GUE0tmr9ZexInBmSsQ5h2C7Ohu
         Yccuy5TWRtgp4fjMwFtLCRmdM7gJHvAYBGunsK8Ogok3++u4WCM08osl+taJm9n9uWle
         5juA+Cp6QY6qCnk9rFXH9OcnKO9Go2Kle3h92EpF+iXfy2H5N46SWs21aDnlaO5gjfAP
         I5Iw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ofn+0mOarMryjH3cWtv9bjcmuNBg+MW21PIBlrxl8z5cnJZ1eIAPW3jOZi2EOo6IDocfqkLpzZX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59Wi6JNiicCUS/IoJFnl1sAAS6vGFrY0GvtiZIygC/eSYf6Fd
	vtNnB1MPC6EV/8SO/XUPkL4aonTQRjEeYlMxG5c5NZy94Ex4xWTj9NIYxTqMKpEHaJSI9F7E2jf
	6xglDc2nozPXpcoIe5WeUP377U5bHSZY=
X-Gm-Gg: AeBDieu9xDms0nePksZccO8k9GItG68je4tOhDY5uzhi5n4Larpuf9wFvgUbFtOVGDh
	dydCN8bIWbySzUAwq+ry1F7IJLRk0j29ZWsSsOyV2nqkVymkydyHYeD6H462m0p3Nq5fbKMRt32
	wQx+dtYoC6s8j+34bbxn4cBjtJSzhVZC4pH1qZ7HQeWxfEf1pbmJTvooJM8aLjQagf1JGKkHyxu
	xrbsDv9YgesRQPDBFvx5EdEzxh8P69rz+pFI41/ldJSgT3ExUIhW3E3QaTKAO4/PYcP3sx4RruQ
	Ap2pK/gM+4XzV0UovJwRB6XGkruWno10Hf1b9n9ja8wr1itf30FtCX/Ry/m9nXcZqcGuuJjrkWz
	gl36cqV9JCMGNRvrd
X-Received: by 2002:a17:906:fd84:b0:b9e:3bd:6ed3 with SMTP id
 a640c23a62f3a-b9e03bd788amr413611066b.47.1776199628403; Tue, 14 Apr 2026
 13:47:08 -0700 (PDT)
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
 <CAHp75Vf_Q4OqYgEOBhoFxpKpAkw5_+GJxQCTbA6LnbR0xhOnMA@mail.gmail.com> <ad415SF1zIrCof8W@ashevche-desk.local>
In-Reply-To: <ad415SF1zIrCof8W@ashevche-desk.local>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 14 Apr 2026 13:46:57 -0700
X-Gm-Features: AQROBzCICMG8Zo6fYMVai50qbGVhi3q2wK0diZ3X13vuWCIcE4K4JnPpYpjQdUM
Message-ID: <CAKxU2N-xb8CKuwxAXMhix9BH31UBSBLwAkxXiewyUQ=t0BsOTQ@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, dmaengine@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10014-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid,gnu.org:url]
X-Rspamd-Queue-Id: 14C753FE72E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 5:41=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 01, 2026 at 04:32:13PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 1, 2026 at 12:31=E2=80=AFAM Rosen Penev <rosenp@gmail.com> =
wrote:
> > > On Mon, Mar 30, 2026 at 9:29=E2=80=AFPM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Mon, Mar 30, 2026 at 11:41=E2=80=AFPM Rosen Penev <rosenp@gmail.=
com> wrote:
> > > > > On Mon, Mar 30, 2026 at 1:46=E2=80=AFAM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@gma=
il.com> wrote:
>
> ...
>
> > > > > > > -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KER=
NEL);
> > > > > > > +       /* Calculate nr_channels from the IO space length */
> > > > > > > +       nr_channels =3D (chip->length - chip->offset) / HSU_D=
MA_CHAN_LENGTH;
> > > > > > > +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, chan=
, nr_channels), GFP_KERNEL);
> > > > > > >         if (!hsu)
> > > > > > >                 return -ENOMEM;
> > > > > > >
> > > > > > > -       chip->hsu =3D hsu;
> > > > > > > -
> > > > > > > -       /* Calculate nr_channels from the IO space length */
> > > > > > > -       hsu->nr_channels =3D (chip->length - chip->offset) / =
HSU_DMA_CHAN_LENGTH;
> > > > > > > +       hsu->nr_channels =3D nr_channels;
> > > > > > >
> > > > > > > -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_channel=
s,
> > > > > > > -                                sizeof(*hsu->chan), GFP_KERN=
EL);
> > > > > > > -       if (!hsu->chan)
> > > > > > > -               return -ENOMEM;
> > > > > > > +       chip->hsu =3D hsu;
> > > > > >
> > > > > > Don't know these _flex() APIs enough, but can we leave the chip=
->hsu =3D
> > > > > > hsu; in the same place as it's now?
> > > > > __counted_by requires the first assignment after allocation to be=
 the
> > > > > counting variable. The _flex macros do this automatically for GCC=
15
> > > > > and above.
> > > >
> > > > Why? The hsu member has nothing to do with VLA, where is this
> > > > requirement coming from? My understanding is that the check should
> > > > imply the minimum sizeof of the data structure and the compiler sho=
uld
> > > > know that way before doing any allocations.
> > > Not sure I follow. This patch changes hsu's chan member to a FAM.
> > > Where is VLA coming from?
> >
> > VLA: variable-length array
> > FAM: flexible array member
> > The second one is VLA member + size member.
> >
> > What your patch is doing is changing a pointer to VLA member.
> >
> > > The current code is devm_kzalloc(x, struct_size()). When it gets
> > > introduced, I'm sure there will be a treewide conversion to
> > > devm_kzalloc_flex, which would automatically set the counting variabl=
e
> > > for >=3DGCC15.
> > >
> > > It's best practice to assign right after since kzalloc_flex does it a=
nyways.
> >
> > Still, I'm not convinced we should blindly follow this rule. The
> > length needs to be known before accessing the VLA, but it's okay to
> > access other members. Leaving hsu member assignment where it's now is
> > fine, no need to move it around.
> >
> > > > My understanding seems in align with what Gustavo blogged:
> > > > https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-=
attribute-in-c-and-linux
> > > >
> > > > The same is written in the GCC patch description
> > > > https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html
>
> If you agree with my reasoning, please send a v4, I will give you a tag.
>
> Otherwise I really would like to understand the justification why the
> assignment going first is the best practice and how it may help the devel=
oper.
Merge window is closed right now AFAIK.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

