Return-Path: <dmaengine+bounces-7958-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CE3CE6A3B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 13:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DD31300CBAB
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 12:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65CD30F81F;
	Mon, 29 Dec 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="iamT1tTG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695072D640D
	for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767010048; cv=none; b=llVWvHo6/lZIJav1G8fqJxTmgI+Q1L9MzR0XR7x/mBFItkWQyanIAIttz/GLdAmMweWt5IIOU47V6njlUVUfY2kizIppFQKOyjIZou8mxwuTMrUft49CGyg3SccOabAGDOnQ7D1JaSrekPV+OUh5IkUf1VvMGCsDqe23JIUupTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767010048; c=relaxed/simple;
	bh=M0RIAwtADvVOqaERuCW9IojIKIPb3AOQCX/h4YSSMVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ss9XBle6Jbl3DfX19QXuoodtZxi+cAtmL7xYKOLYVR4EhVBPJS/Qur3k0jB6mE4DVFmOsuoyau4I96FiYK/o96bCLJSO/cBV632s0qw8tSqLobqOxtNw66enn4zS5Zf6wNjog5BDMExrUXAlC11UvaIL4miyMSYd8apDZVHFu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=iamT1tTG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8010b8f078so1280616166b.0
        for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 04:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767010045; x=1767614845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0RIAwtADvVOqaERuCW9IojIKIPb3AOQCX/h4YSSMVA=;
        b=iamT1tTGYGQlzW0SD7Bc5Gh9ZF8yq3i589wLhXJrSD1Kp1ZG0ZaxE07zplkkGHJVEP
         gb0by9XjDcH0ilhHcxSpil+RiSM7Ic1A8SSNbg2dpEfXCZg6NkVkwkdjMMKKxH2KX1Gf
         pdYGVDhIhWLK9RFe3oxaeh42xev2B9E2QeiJUwmTrK4iiImu5MhqPNxGIoaKR9SmPIJk
         BWAa1Ab215SKOtSeT5lNMMdyImsouv4dTKP/3SsgFQhmmnNLv71u8lm9YmvDxnym0Tez
         P3Fx5ZSdHR5Mqj4oBpHnVUccNb6D0RfhAVP83lrcvz6sILAhn4GItv8EK4Uo/FOIg5GA
         UIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767010045; x=1767614845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0RIAwtADvVOqaERuCW9IojIKIPb3AOQCX/h4YSSMVA=;
        b=EOpI83CD3CsQ2/VEiRyyURM6eLMcHph0BZX4+ziq3l0QkF9N3Gh9QKieUgNJYsx+K5
         sDobF0Zrjl+gOh+nmxHePerlwazdSnnAZuDi0ykmKvNjZznpaEVrt8N581Xrq5oPDRQn
         W+rQfj+LzU+A3QFLJWHJbCSkO95o5uHGOZZdlefZ8SzWuf7wUQ9rqApBR7Ewdm++VZt9
         sbqnT+L9jxtcciGE+ZEpvHGvlzxNyv/um1tqoy9rdb95voM/Fp4bpie6rijQ8lyU3qaE
         JdXvVFB25xUz7hSzwBFM6+rDKNq74YD8s1wD1qpknmZoh2QLmtsVscJkSr7apQJBZsHv
         IUBg==
X-Forwarded-Encrypted: i=1; AJvYcCUfZk2Tngtg3KUl9pESMpWvw4LQ4f82XJAnptS/ReVcGuhFqEXxRDii/NodRb/VGZS7/62Q0UwM2Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDJXqmxWpQctqqGHcLXc5bC+rIEYFXp2zSXAmEjifh2zmqQ3BH
	RAhdgZ2LogiJG1jS5K7gJnVH7s/OPBCCUp6M3OZ0mBFYsglRasL+PQd5TCfE/mH3bVf3dW4egnh
	pMBRQ6Lzyye+4K2w+cNOEgHESCduGE1HfjDPR17dGIA==
X-Gm-Gg: AY/fxX7m0bowcBwTDvEIKqUhMEvL10nc8srGrXRga/tJ+7t5ZzIfdHJBE9a26x9oSgB
	8/u/vqESTyjqgALRnUcITMTYY+NW2DGMqDkzCK1ce+fok2ez7gCQ73yA/GAaqtGOFjSk0i7KDjI
	nlML/XWS9VV1r9k/SDPHwYHp9fIxyevcfqUp4njeJZgkh14SDKj8QFsMYj2BqCcxkp+lwK84NEH
	Tm3gan2vh6wu78/YcdQCIxpniaM6aXAkuIThp3oGVAcPgSm9grYhoz7kuWIwyCAGcCwUcfBsrEn
	CeyQCyA4VxbNlGVM9ntaeg/ldq0P1hwyid/HJZen/+yHq0n2Qtcu
X-Google-Smtp-Source: AGHT+IHwGBZ7fPOTgnv1RT35iaeFO7HZRzkOQtdPCeQFstms7NNREAW/jaHp2F7zdlu800ZsYVpbEuZjGBw4wnDce1o=
X-Received: by 2002:a17:906:2081:b0:b80:415e:5b2 with SMTP id
 a640c23a62f3a-b80415e05efmr2616951466b.4.1767010044222; Mon, 29 Dec 2025
 04:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
 <20251223201921.1332786-2-robert.marko@sartura.hr> <20251224-berserk-mackerel-of-snow-4cae54@quoll>
 <CA+HBbNGym6Q9b166n-P=h_JssOHm0yfyL73JZ+G9P81muK=g4A@mail.gmail.com>
 <78bf252c-fd5e-4a36-b1a3-ca8ed26fde7a@kernel.org> <CA+HBbNG+ZVD6grGDp32Ninx7H1AyEbGvP0nwc0zUv94tOV8hYg@mail.gmail.com>
 <d210552f-c8bf-4084-9317-b743075d9946@kernel.org> <2025122516245554f59e2e@mail.local>
 <20251227-splendid-striped-starfish-ece074@quoll>
In-Reply-To: <20251227-splendid-striped-starfish-ece074@quoll>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 29 Dec 2025 13:07:13 +0100
X-Gm-Features: AQt7F2pkPcBxmyeR-DPcdCGLawGZy7wfoKy0BfxlIeZ5QxnvZTUu33UqbaIu3eU
Message-ID: <CA+HBbNEqq9ZqBR88DFSSSrYw=LBzAreFC0kL88-HZCGAsOrqZw@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] include: dt-bindings: add LAN969x clock bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org, 
	andi.shyti@kernel.org, lee@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, linusw@kernel.org, 
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com, 
	UNGLinuxDriver@microchip.com, olivia@selenic.com, radu_nicolae.pirea@upb.ro, 
	richard.genoud@bootlin.com, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	lars.povlsen@microchip.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-clk@vger.kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 12:17=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Thu, Dec 25, 2025 at 05:24:55PM +0100, Alexandre Belloni wrote:
> > On 25/12/2025 09:47:34+0100, Krzysztof Kozlowski wrote:
> > > On 24/12/2025 15:01, Robert Marko wrote:
> > > > On Wed, Dec 24, 2025 at 2:05=E2=80=AFPM Krzysztof Kozlowski <krzk@k=
ernel.org> wrote:
> > > >>
> > > >> On 24/12/2025 11:30, Robert Marko wrote:
> > > >>> On Wed, Dec 24, 2025 at 11:21=E2=80=AFAM Krzysztof Kozlowski <krz=
k@kernel.org> wrote:
> > > >>>>
> > > >>>> On Tue, Dec 23, 2025 at 09:16:12PM +0100, Robert Marko wrote:
> > > >>>>> Add the required LAN969x clock bindings.
> > > >>>>
> > > >>>> I do not see clock bindings actually here. Where is the actual b=
inding?
> > > >>>> Commit msg does not help me at all to understand why you are doi=
ng this
> > > >>>> without actual required bindings.
> > > >>>
> > > >>> I guess it is a bit confusing, there is no schema here, these are=
 the
> > > >>> clock indexes that
> > > >>> reside in dt-bindings and are used by the SoC DTSI.
> > > >>
> > > >> I understand as not used by drivers? Then no ABI and there is no p=
oint
> > > >> in putting them into bindings.
> > > >
> > > > It is not included by the driver directly, but it requires these ex=
act
> > > > indexes to be passed
> > > > so its effectively ABI.
> > >
> > > How it requires the exact index? In what way? I do not see anything i=
n
> > > the gck driver using/relying on these values. Nothing. Please point m=
e
> > > to the line which directly uses these values.... or how many times I
> > > will need to write this is not ABI?
> > >
> >
> > The index here is the exact id that needs to be set in the PMC_PCR
> > register and so it is dictated by the hardware.
>
> So not a binding between Linux and DTS.
>

What would be your suggestion on moving forwarding regarding the clock
HW indexes?

LAN966x does the same with HW clock indexes in the dt-bindings includes.

Regards,
Robert

> Best regards,
> Krzysztof
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

