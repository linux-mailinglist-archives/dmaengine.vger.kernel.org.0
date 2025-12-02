Return-Path: <dmaengine+bounces-7465-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA8BC9B665
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 12:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1607534824C
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6CD3101B6;
	Tue,  2 Dec 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyhRRVP5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1923126C7
	for <dmaengine@vger.kernel.org>; Tue,  2 Dec 2025 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676499; cv=none; b=Bmfyl5mqacx66zyB1KP2E3/8plOAhDCLxmE3tfZvhh00gpjrJlVu4iH9LAGO8FEtfVycFXbbIP86MYxyy0gby9WzzwQODzOH+F/V/btfnCs7AA9URXAfxn/7Wg2baY7xMmdQVY/CqxYNTfQSVH2/JGvWtGgqSv2Q0L/DwNvfgXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676499; c=relaxed/simple;
	bh=9HVr0hFekV2djI9nfpXHCkF1jtQ3WlL7/NK4I26R7Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THefXmTxZ2PHF7z+SPbqa2bobkkQk6gZkMhzjFwhiVGUwIJIYDav5Z8z6hZx48sed8TdcNkYVw3IalGiSyuUxhBaJaihwa8xtBCv3iXSi8uvRREQtYgp5HjjxXSg/PHmBR9H+6/dxHSAc8GqiJyDm73n6Q4zwaJ2Bt5pXwLs0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyhRRVP5; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9374ecdccb4so2939304241.3
        for <dmaengine@vger.kernel.org>; Tue, 02 Dec 2025 03:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764676496; x=1765281296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/vwk9xBXn+awoRVfW2c6HNjaaTRhyQlJnsxm+lpDbE=;
        b=MyhRRVP5EbvSEn9aTtlNFq9lak/+tiPr344fosFq78jkglFqFcXdaG71H4N0vbDeIT
         mZKwDLvS0E4gEE9uqBZIyCxsAzDbYsT6OltsWYl8e+Bt9l1aqrNpekudbCarpXR1b6yO
         rAZppY5A+VFEL4LGSJpw7zp3/FKSItJM7+9AkhaWRQxW1cYneN4ujWxQD26JlefTDus1
         AB8mNgdIhcioGMSYz7bsNFkStog1aFbJ49GS+okbm9AuRNtgnzhD0189E3YOm/cmUP4T
         tEHUl/J3ErJDP8s7bwkAfCDYq/rAA16fKInj9gz3s7no+5/jUjb+C8zJDjADcjrlqS/w
         iKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676496; x=1765281296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/vwk9xBXn+awoRVfW2c6HNjaaTRhyQlJnsxm+lpDbE=;
        b=jLgXE9iM0iDAcTFJxreGOGYO3QDj9IDoPPWqqoDm7Vo/cWAYcgcuLXsTJJloZ9Fy1l
         J3Hjgc5z7fihXmiycgBdBVwHtMx9Ewz8XO033Ugqd06yONOv54rKEm5vU2WPWE99scXR
         s5S3bJdilwS16L3/NFQVRzQ8SWxKBjmC86lfvMDlIp1TjyV5q8VWbJGpySG4K3jbT03I
         AmcSOY8eMqjBW+ESOznMKR2qEzSgVeI7dJgHVMQ6IvHW8vaCsh5woc/hH2gRvkAp4FIX
         C2hbbBjG2CLwRXudpZE7fx6Gh1+G2kQbD6sq3QzB/bdZy7P+4QBQx8t2nzV9tMoXi/1U
         XZMA==
X-Forwarded-Encrypted: i=1; AJvYcCWjK9kQOyk6beFZLBhRGYXGhdDTaLdJqK5KB9hpOkrEih5OSR2TofrZf2aJLXPJGbqI3SWBwmBdmi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46TzLDE+KDd1lWV/rjNJuI/XEJHI9JqXaQTRbEVQ+fXSa3rVa
	GTP4MzXAopyAkQpweb9MZCDcH5yq0KV4DYk3Mnyj65L5AoDM15d//vbOgvx/Ws+so5ADQlEUcSd
	qRPLyhxELoFWeex2/L3M9zmy7u3et/Xg=
X-Gm-Gg: ASbGnctbpWan3MXKARLepNrwD9viL6yzyCU9JWi2oXwav+PJyF8DdMl99fWDEKuzcoM
	tXthyolszvxvmKjlS3WgbxFXi1l90GGT9QsUhw3wPzfODE8X9eKtZc9ILcSkroM2FoWbDNBWiMf
	ITbaXcRevSInnJ0xXtLbrl03/F4udmcwfvUKb8UqYNdMMhKPC8OM6oYw8r83G4AhGioCABOx54o
	VTP+rUIas0oGJv6e9ufR3268pYJtT/EGmdmC/KiJKbj4xNUSXOXJ+mmEU9ammEyU30q9XJ+3SI+
	SAtJxFqHsqb+4ZFmlAMsrLfT3eRf5g==
X-Google-Smtp-Source: AGHT+IHIk9mxQ/QaxNsvsDBFmYRmqH16cSeai1KSIej2f98gKwcQYYe0fkNHh4RP81Kt+t2BKwXyRJBcWhjCI+ySj8k=
X-Received: by 2002:a05:6102:1499:b0:5db:ca9e:b57c with SMTP id
 ada2fe7eead31-5e2243d5189mr13518051137.27.1764676496514; Tue, 02 Dec 2025
 03:54:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128152947.304976-2-amin.gattout@gmail.com> <c1983852-b6ae-484b-989b-56fe0d00a679@linaro.org>
In-Reply-To: <c1983852-b6ae-484b-989b-56fe0d00a679@linaro.org>
From: Amin <amin.gattout@gmail.com>
Date: Tue, 2 Dec 2025 12:54:44 +0100
X-Gm-Features: AWmQ_bno37Lb5lzocOf6efRpA9uiP9lQnjLdWtfVnZKy5ocQKS2wuslCWX5dcq4
Message-ID: <CAHfa7xVxG48_qBXE8JcSNJgO1SG=Ge9qAyaCk2WLTvrKoH3NbQ@mail.gmail.com>
Subject: Re: [PATCH] shdmac: Remove misleading TODO comment in dmae_set_chcr
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: vkoul@kernel.org, thomasandreatta2000@gmail.com, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Eugen,

I could not reproduce any concrete issue, and after re-reading the
flow I think your assessment is correct:
If the channel is busy, CHCR is indeed never written, so in that sense
the TODO comment was accurate.

Given this, removing the busy check seems more consistent than
removing the comment...
My patch was therefore not addressing the real problem, sorry for the noise=
.

If you agree, I can prepare a follow-up patch that removes
the`dmae_is_busy()` check, or leave things as they are if that is
preferred.

Amin


Le mar. 2 d=C3=A9c. 2025 =C3=A0 11:12, Eugen Hristev <eugen.hristev@linaro.=
org> a =C3=A9crit :
>
>
>
> On 11/28/25 17:29, Amin GATTOUT wrote:
> > The comment suggested that the dmae_is_busy() check in dmae_set_chcr()
> > is superfluous and could be removed. However, this check serves as an
> > important safety net to prevent configuration of a DMA channel while
>
> I find this a bit odd overall, because apparently nobody checks the
> result of dmae_set_chcr() .
> So if it is such an important safety check, why is the result never
> checked ?
> As it looks, the caller doesn't care and continue as usual. The
> difference would be that chcr is never actually written if the channel
> is busy. Which looks strange. And "unexpected hardware behavior in edge
> cases" is quite vague. Do you have a scenario when an issue would happen =
?
> dmae_set_chcr() gets called on resume() and setup_xfer(). Is it possible
> that in fact dmae_set_chcr() is not called correctly then ? Maybe this
> chcr should be written at a different time when we are sure the dma is
> not busy ?
> Or why is it even possible to have the dma busy when calling it ?
>
> Eugen
>
> > it is active. Keeping it helps ensure transfer integrity and avoids
> > unexpected hardware behavior in edge cases.
> >
> > Signed-off-by: Amin GATTOUT <amin.gattout@gmail.com>
> > ---
> >  drivers/dma/sh/shdmac.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
> > index 603e15102e45..d0e0437ad916 100644
> > --- a/drivers/dma/sh/shdmac.c
> > +++ b/drivers/dma/sh/shdmac.c
> > @@ -243,7 +243,6 @@ static void dmae_init(struct sh_dmae_chan *sh_chan)
> >
> >  static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
> >  {
> > -     /* If DMA is active, cannot set CHCR. TODO: remove this superfluo=
us check */
> >       if (dmae_is_busy(sh_chan))
> >               return -EBUSY;
> >
>

