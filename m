Return-Path: <dmaengine+bounces-2718-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F73E933D56
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 15:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322101F24438
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 13:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE141802A7;
	Wed, 17 Jul 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drlWOQU7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3B1CAB1;
	Wed, 17 Jul 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221578; cv=none; b=gYWZ6LRUd3kEypinai83J9u+vVC5gHdS0hoouPyoG6jcxeZ+5NipCcyUv6T/L6oyhRBw+lv+7Ho+AxuFZk4GsdM3UprZdElkcyqI8UoBHqnk+asS16h2p6eSolfnIjsQZSHa8pSs4GLCQ3LhhA2g2uX2AUUo8baa8B0k2dHbhQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221578; c=relaxed/simple;
	bh=yaL/3Sz8R2RqdFViPmeUSo/QB36Eh0Myf1lxuq046Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ds/Hg3M97zvsHaseH0KwNu79UoGQQVcC8c1j1DOV9cosrwmRfhFi49ghmGMdzdL+v9vzg/9ERQKVR+1MRNTIV8P5TSazeYkUbWRGBzDHdzYtV+pdOrfOfXm1fh7SSXdqTjS+Hw/Gf9AIpGlUd1JIEodTsUxmtfV8yOH/7kPEeaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drlWOQU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB2AC4AF0B;
	Wed, 17 Jul 2024 13:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721221578;
	bh=yaL/3Sz8R2RqdFViPmeUSo/QB36Eh0Myf1lxuq046Qs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=drlWOQU7L7ulGxUltBkVqx/Ye7eETBt6AAe1zFBZWY6+HzSolFhroVjxAFyDaLZ16
	 u7rTU6mv//guR4CmLIgOMY+OTmOTiwj6Joiyi2g69eE66sdRMv4k7kQO8H89jiYcUF
	 5Aw87SBysEh6SRIK3chn4FsbDfOAMAw1AVpE5ofPEisgyQn0Vx7WB7SHD8H0CpRxyz
	 9Ck1rnpC0nIRSa0e+R0jzsfPGWYrkPZBLDvWe2HC9As4bb5vYZOVrueFSTAyyw/GJO
	 k1F4FZBO47V1jMyGWxSKpT0PK1K/OmgEUH2yL6LiotI+dDpFSfcaRU50aEzjBGhGz2
	 iuqEtOD0ZnYYQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso8662279a12.2;
        Wed, 17 Jul 2024 06:06:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUk5JucedIjz0v1z97ANM+WC/lXZ924tWwLLsJGtKnVhRxDtSBO2vhCg6oxkixZJeExPTxOKH3GK5CuziZQEx9gJAElCOjz/tTEe71UOKQlBYJEOy0fh7+8chnPxwQy9iT52L6el/Evultz9LUTsJL5qgtQxXIZsG2/kPWdpiBj1NLOUOk73ai4lhmF0z1jI2BNAATD3sHqPsrVS81Mgms=
X-Gm-Message-State: AOJu0Yy36zDcHEBmknVsfiCQsKjnWca8Px3dU8HEP72VNZURNmC8P1E9
	5TcfnsLoznYR9xYr9/34blZf2eK5bYQ3YdWxoN3MZwPstaEydNiCqgoynLL/rZWuhN/ea4rXyrf
	k4N4fCcIVzwpJibwePQsHLHpksYg=
X-Google-Smtp-Source: AGHT+IESGwbAAUP5HG4e9xd3SsFRcHutRN1oZNbgQxILGR6GNamb8tduRv5yh4quBfU4f4WHX5wmcoRfafsx5t+5lnI=
X-Received: by 2002:a05:6402:190b:b0:58c:34cb:16ca with SMTP id
 4fb4d7f45d1cf-5a05d0efb27mr1394536a12.28.1721221576678; Wed, 17 Jul 2024
 06:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com>
 <CAAhV-H5OOXguNTvywykyJk3_ydyDiSnpc-kvERRiYggBt441tw@mail.gmail.com>
 <CAJhJPsXC-z+TS=qrXUT=iF_6-b5x-cr9EvcJNrmSL--RV6xVsQ@mail.gmail.com>
 <CAAhV-H5Um5HhbmcB1Se=Qeh2OOAeP34BAx+sNtLKge_pePiuiQ@mail.gmail.com>
 <b1a53515-068a-4f70-87a9-44b77d02d1d5@app.fastmail.com> <CAAhV-H5cDiwAWBgXx8fBohZMocfup3rbe-XjDjEzsLAUB+1BUQ@mail.gmail.com>
 <54d9edd5-377e-4d9a-956f-8f2ba49d4295@app.fastmail.com>
In-Reply-To: <54d9edd5-377e-4d9a-956f-8f2ba49d4295@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 17 Jul 2024 21:06:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6aaAu=0eyEp8am8A+SSj53+CGp7DrCYCxkNZScBd74BQ@mail.gmail.com>
Message-ID: <CAAhV-H6aaAu=0eyEp8am8A+SSj53+CGp7DrCYCxkNZScBd74BQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 0/2] Add support for Loongson1 APB DMA
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Kelvin Cheung <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 9:12=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B47=E6=9C=8816=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=
=E5=8D=885:40=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> > On Mon, Jul 15, 2024 at 3:00=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoa=
t.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A82024=E5=B9=B47=E6=9C=8815=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=
=8B=E5=8D=882:39=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> >> [...]
> >> >
> >> >> You said that you've accepted my suggestion, which means you recogn=
ize
> >> >> 'loongson' as the better name for the drivers.
> >> > No, I don't think so, this is just a compromise to keep consistency.
> >>
> >> Folks, can we settle on this topic?
> >>
> >> Is this naming really important? As long as people can read actual chi=
p name from
> >> kernel code & documents, I think both are acceptable.
> >>
> >> I suggest let this patch go as is. And if anyone want to unify the nam=
ing, they can
> >> propose a treewide patch.
> > Renaming still breaks config files.
>
> This is trival with treewide sed :-)
Please read the commit message of b8d3349803ba34afda429e87a837fd95a careful=
ly.

Huacai

>
> Thanks
> - Jiaxun
>
> --
> - Jiaxun

