Return-Path: <dmaengine+bounces-3339-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB5699C56D
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 11:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159AF1F23E7F
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D815615D5DA;
	Mon, 14 Oct 2024 09:18:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C94166F16;
	Mon, 14 Oct 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897510; cv=none; b=JvTefZfmhrsZymibYYheF6/kQTpvWaz7ziZxab2IXRGEKsMRoHEq3ZO4G7rfJHEfhUAo6wHdjiws+a2JKZNM4jF0mNjnEU29AAfJOKwpstjlp54Q0ve1WQABwXI/LuRylO+tf68cB++IqumGhN1dim/IdLmkhCA1jvmUw4HlgbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897510; c=relaxed/simple;
	bh=EkLpX6UtaHBiuLA6UQQFw0leVksrHOsz288ZZo9ULRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqY19IxFaDuEm9k2HSZudKaiIewFEnGeV6qulU4on3dawYgDkVFMVDC1HttJkmrqMv7sLDsXNmK7HKo3qr6OXNg77uWms/OZ0gLoK1VBTtnkdOo+B9eW4NZDT7fTuXmrxtZJpsPGLxZb/WpKwKQZ8qe0zT5GOHHS4xkYhEPxqPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e2f4c1f79bso33620227b3.1;
        Mon, 14 Oct 2024 02:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728897507; x=1729502307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XM7Hx7BDiEIgSKXCd36v4PFuRuWUiWCSpOVzrnoLBC0=;
        b=m3c0MlGJ8hYGG1XqMNnM9huknk0Nbqptpwc5nZNNiVTSOZYTShOdxQPGx70idnWvJ6
         z2UqtB2uOMcY10nMCL4cA6ILGpbQpdIWrWIWK5JCxQjTCTfjatjKI1L93vwdW2O8wtvX
         tNYnYBi+lcGB7Dfhc6eFr9saPZzhByQchPfCilWZIx8C6f4YABQdLoLmou3IDeUVErC2
         4CBy+N9birdWQ766qFqajvOj2FxFlxUwCsny91DBIFnNsb0wW4Rmld1SXgXvJjnLM3eC
         0kxgF+EuTQjLAtIBjdnW60tr+rfvxHTw1X6/vsjAIJJK3gi0hM+se7IPdhLfqlGUfXmm
         Q5nw==
X-Forwarded-Encrypted: i=1; AJvYcCUVOqmI3/pv19bJbRjAiYR1r6AT1Gkt1TvhfJ3oY9a7hfM0YLrTgwYM+m6rrwuvgYxYPtPQzSpDnUM=@vger.kernel.org, AJvYcCVaaKdv4WRem2Q7MQGhg8waEMcWdmjwGq3q84oNLMI6RAIfNHOWYwYO+92dQ/wQO7tXhAJjZK4UvugRUqPQ@vger.kernel.org, AJvYcCXvoedd9edNPEJQyPNovWxR3ssP7tYqxLVRs1MpEHvsG63LqmNh44MEbBLaUBanwRYx33fa/2Qb@vger.kernel.org
X-Gm-Message-State: AOJu0YzH30vMRMC/pqURfwU2IwPuRC7aplr12XGpsJJG7BwdONgUmuPh
	phcVsvOAfMI+MRQ+dWq71wV6X3XgMW+ej/1hw47cVWtfPyxo36KU5q/QOeen
X-Google-Smtp-Source: AGHT+IEoez0LlbuacHkjyQSLu7nO/WJeMIrU9tb2YD68IT9xAIGfMIslwhqUlq2J+ZVODM4qk7XuRQ==
X-Received: by 2002:a05:690c:4487:b0:6dd:ba9b:2ca7 with SMTP id 00721157ae682-6e347c6e752mr50167907b3.46.1728897507500;
        Mon, 14 Oct 2024 02:18:27 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332c269e7sm14769057b3.76.2024.10.14.02.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 02:18:27 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6dbc9a60480so33108317b3.0;
        Mon, 14 Oct 2024 02:18:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3LG1M1hsnfz+D6fHjXxDX8lyji2TqftmR1Xe06inQ2TOuz8rfHfTXHwGQIMXMz1rcMRSNVYR6OVY=@vger.kernel.org, AJvYcCUD6/55XpL6qP2aN4Jm1YlbAi+AOnObDVLo+G89CQf4Uq2U/ttPt2ZndEKh2kalIvL2SIOhQCrm@vger.kernel.org, AJvYcCWMT3XbUuT68J2od8SuQ7/Pmpldda28HGjn8KOra8n5t5Vi7WXuaK9Qe/waxpyCiOew0n+EhRtpEH7czlQs@vger.kernel.org
X-Received: by 2002:a05:690c:38b:b0:6e2:b263:104a with SMTP id
 00721157ae682-6e3479ca932mr84287817b3.23.1728897507018; Mon, 14 Oct 2024
 02:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg061j_0+a0wen8E-wxSzKx_TGCkKw-r1tvsp5fLeT0pA@mail.gmail.com>
 <20241014072731.3807160-1-geert@linux-m68k.org> <711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org>
 <20241014085819.GO77519@kernel.org>
In-Reply-To: <20241014085819.GO77519@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Oct 2024 11:18:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWedOgc4S12FwQR8_80aqgRJ2pwrKWsNb5Svt6776ti3Q@mail.gmail.com>
Message-ID: <CAMuHMdWedOgc4S12FwQR8_80aqgRJ2pwrKWsNb5Svt6776ti3Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.12-rc3
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Mon, Oct 14, 2024 at 10:58=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
> On Mon, Oct 14, 2024 at 10:38:20AM +0200, Geert Uytterhoeven wrote:
> >   + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: e=
rror: format '%x' expects argument of type 'unsigned int', but argument 4 h=
as type 'resource_size_t {aka long long unsigned int}' [-Werror=3Dformat=3D=
]:  =3D> 126:37
> >   + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: e=
rror: format '%x' expects argument of type 'unsigned int', but argument 4 h=
as type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=3Dformat=
=3D]:  =3D> 126:46
>
> I wonder what the correct string format is in these cases?
> I didn't have a good idea the last time I looked.

"%pa" + taking the address of the resource_size_t object.

https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/core-api/prin=
tk-formats.rst#L229

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

