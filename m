Return-Path: <dmaengine+bounces-9750-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJQyJrFNy2krFwYAu9opvQ
	(envelope-from <dmaengine+bounces-9750-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 06:29:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC43363E04
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 06:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 281FB3033507
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 04:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672E82D060B;
	Tue, 31 Mar 2026 04:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmLxc+fO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED622285C9D
	for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774931363; cv=pass; b=jzl3vMWwKdrKBdihuvCEyk5wuZviIDc1Pj07w2oJ4pFJevW5NIqCI7WQ8JyR3z43UY43lJeXJ2h2oTVK1CrgQ35PdWdo9jTczrpHUWZMBKs8JcDXlG5tqoffIB2yphqis3s/osusYwbCaIiqidrQUkUEgz23wXHdzEu5t2mHxig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774931363; c=relaxed/simple;
	bh=p+FvHoQ67nUJi6HBun/oyfLfwLgSq5M7WuggYsg24To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFUtxHhLahH3tuIW5sd1sOTEKwLB7fcXviNscbPA6qD9nwi5OoQ9lk/iQ9bFciXQy3A0BW8QYvDk+O0sz8EYVc3n6QUgMj0wyJiSJhZtoV7lB03UTbo8uExdfpuHlKuPz4L2s3dyYAW450cjK7DgsgI2tiVXYvurMXu9xnoAFBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmLxc+fO; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9961e4f71bso779433066b.3
        for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 21:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774931360; cv=none;
        d=google.com; s=arc-20240605;
        b=WHZxQmr2V6+rg3UbL8y4KiE/zYq9W4I8omsjsrquUTzSadIC47iYnVTDtylKQqMMml
         vVJ6NxAMZvyfwdS3Fc9B+ZHVM0zAjbC+k/lrd3VzfIhrrd6G+ldBmQFlN8qlr2YO4c3p
         idYtMCEvr+QUjk7rIsGclo0j8FiYzDbNXbvW3gY65cVs6ElFzG++J5XmL78zdFpIYx2k
         PUUsW7IcVbng1fQiMofrHsBb1jjKLH7+hqR7i+4TtI7qqTdb5ELuH+wavzOHwEJ6A3cv
         UcUp4DMt1j+DGLrk4U8pAmgjnAukYaxGJY4a26ktt+O7oUYgrhR3P+l0zSiVrZTCie3v
         nveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PEot+szO3NPt9LVmYqaYJOsqYdkjQVsjRt7jnY+c8Xw=;
        fh=22r3XkhgFXYlo01h1jYb+ZSltnvR0YVp6gSI4ip4x/I=;
        b=iqsGMedfGfAoJ4NsaoSPs5wtMIVbcJAhvBPILnZNKd+7yPoMZ+57SVye+kNvR2Y0jC
         i9M2N+4T3bUSyKXs9Llc2lCnfDw3n4x48i8vjcZpXhjGYe8+T2tQJanA9iL7w2DMGTyH
         K9/yyhgCtcWEoTJoxJEoMbBoznSPmmrOBwUjLUMuO4Kx7lsrhkYQ9HxtdCFi1H8i7B2M
         9AIaENjv3Yh4L3DI2FmkHiwwGbsLNZDQrdI2Yx5xJ/jYmVRA3gdqFdTb9pRYDkLi+Pyh
         z/68OC8qUdA5Z2J+xMz4NO19kxR3KerRfudhP2vVI+4PyZ7Ow++FSuscGOmL9qB80bzb
         h+pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774931360; x=1775536160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEot+szO3NPt9LVmYqaYJOsqYdkjQVsjRt7jnY+c8Xw=;
        b=ZmLxc+fO3A1ceHISrj9eiLvJuKvrIASudXvlOoAMzy+z5nV3Rj0ZK793nKQFXYuqzZ
         RawRKgIpy/sCf1M4H80RRC8EK3qxpjDc72JmzTDiiLHEHz2tHx1hopWECTq+Rtf8Dfmk
         dUgAQK/Wqcyyh53OBcG01DwF0Dc7H+ofONyPbHAGyDcI2ifswmiGdb+HVSs6jsuyFiMt
         zv06RX9s53ZPse6LAUD2FD337pls4WhDWg5hnqaaXBadWw9NXzH3VU4t7meJrFB71otP
         QyUJNPSluOqKL19BdpP5wl4xk6PXzwwCaLzj/bYk1MynVcVV0VS293t9tTOf9OuNEoEV
         wtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774931360; x=1775536160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEot+szO3NPt9LVmYqaYJOsqYdkjQVsjRt7jnY+c8Xw=;
        b=FQrAuZdGA0T6imUuN0eb5gmGKuTpCWl5NPNxk1X4fI2t5WahE5q5DNHRzp+ej9aE8H
         qxcSj021/yWR4iJToebhtTn4JDXcaCnuUUUJTnVS7R2keYvc3Rxvun0OHwOGcFC6qi1L
         deFtXVv02X+ITecIwgwqosOxWpswnmY/vm2p8pZQ8Tj85FKp2LqdPVkv425gVM6B2y6u
         bpIAr4pU5T6JviduepPHAqfi1oIom6vIX3IO0oynTIBSn+mExnN8vK284En3uyXYElQ/
         itGQ+xfUMyOrmjqd9R1RqBPR8Sqx9P0ufKfXdLS+as19be1HDlPBO4r/XfhtLShS5T/A
         y9pA==
X-Gm-Message-State: AOJu0YxtKhHTG1QYKv1WGSxwn2wD/uZVaMQryp6A9x2cUKixll1hK3MP
	Xyzplh+z0DHD4Ye7+CRUOTf/DEOdVJLqVBp7RyGWSuS2PHtLNwZ8jSkqsOALvX13S59hvrxOqmh
	IAUmYI1I0WtMZphljFvaDAamBZCeZv6g=
X-Gm-Gg: ATEYQzwAhlqnujSOA2P3x5kpz5X9RXbrXHSa4/L+cPPDWaO0xYHHKoQxoEkcdm+IAqX
	jEdoJpbsfohmDRjbMZwR/PEs9Livm5Miid1y7mMiGTlGWlDA0nZ1MAEGqwrOznNMqh/mZIqFvEB
	5rSpt03bTTfuVvS0Xu1cKm7J+kewqP49oPR5cAo9immqrUKhI5U1WQ1vFoT+rDFqoLWl8cQNwrc
	SDbNOOdxKLi1xKoJgF7kUkdTWJjw+BYQRYsciGU4j3oECm+HIS+EOqa6AQGKEt8cbhICU3HZQDa
	TBNQjTwUjIiJGO3KSUKLhfQYz9z9ENgvKieRyn5HM7G0X5BbjaPYWRbDGI9n/NXow7NNzNEna38
	s77ElYBvBMV7IpoFIdQ==
X-Received: by 2002:a17:907:6e88:b0:b9b:5648:6e8f with SMTP id
 a640c23a62f3a-b9b5657b695mr925494766b.26.1774931360120; Mon, 30 Mar 2026
 21:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328191646.312298-1-rosenp@gmail.com> <CAHp75VfXO1acijFMySQTCtYEE9dRyUMk7xJ7ff7m0hgy42g7=A@mail.gmail.com>
 <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com>
In-Reply-To: <CAKxU2N_SXeEgwZ5e1eARpK5jAorx-ycnPdf=Ut2jUvSM2xYZFw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 31 Mar 2026 07:28:43 +0300
X-Gm-Features: AQROBzBpGIynmbsQ2-RVSGCdRUHGb83IEBz642GQmmfamTKmS8_ptyDz1LyuthA
Message-ID: <CAHp75Vdvn9n_qgBsXTBw8mRxdJcrmCi01JfAGz7oTkKQ1uXBmw@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9750-lists,dmaengine=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: ECC43363E04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:41=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
> On Mon, Mar 30, 2026 at 1:46=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Mar 28, 2026 at 9:17=E2=80=AFPM Rosen Penev <rosenp@gmail.com> =
wrote:

...

> > > -       hsu =3D devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
> > > +       /* Calculate nr_channels from the IO space length */
> > > +       nr_channels =3D (chip->length - chip->offset) / HSU_DMA_CHAN_=
LENGTH;
> > > +       hsu =3D devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_cha=
nnels), GFP_KERNEL);
> > >         if (!hsu)
> > >                 return -ENOMEM;
> > >
> > > -       chip->hsu =3D hsu;
> > > -
> > > -       /* Calculate nr_channels from the IO space length */
> > > -       hsu->nr_channels =3D (chip->length - chip->offset) / HSU_DMA_=
CHAN_LENGTH;
> > > +       hsu->nr_channels =3D nr_channels;
> > >
> > > -       hsu->chan =3D devm_kcalloc(chip->dev, hsu->nr_channels,
> > > -                                sizeof(*hsu->chan), GFP_KERNEL);
> > > -       if (!hsu->chan)
> > > -               return -ENOMEM;
> > > +       chip->hsu =3D hsu;
> >
> > Don't know these _flex() APIs enough, but can we leave the chip->hsu =
=3D
> > hsu; in the same place as it's now?
> __counted_by requires the first assignment after allocation to be the
> counting variable. The _flex macros do this automatically for GCC15
> and above.

Why? The hsu member has nothing to do with VLA, where is this
requirement coming from? My understanding is that the check should
imply the minimum sizeof of the data structure and the compiler should
know that way before doing any allocations.

My understanding seems in align with what Gustavo blogged:
https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-attribut=
e-in-c-and-linux

The same is written in the GCC patch description
https://gcc.gnu.org/pipermail/gcc-patches/2024-May/653123.html

--
With Best Regards,
Andy Shevchenko

