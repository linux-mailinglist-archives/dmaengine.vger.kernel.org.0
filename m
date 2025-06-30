Return-Path: <dmaengine+bounces-5681-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD50BAEDECF
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jun 2025 15:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9A7188CEF9
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jun 2025 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFAD28A73C;
	Mon, 30 Jun 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="pRx/iQt2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED8CA4E
	for <dmaengine@vger.kernel.org>; Mon, 30 Jun 2025 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289509; cv=none; b=uvK7OL+C92nIPo6tTSNdxw6KU+k+fylsvAejlNnB/stCQT8geeQMg0TFRNHm2xaeVugrROZMYnCguziBi72Nir7goqomLdGqn4LaCJdCgR1tZWoBkRXTpr1ewh2CBpzznhaydrAoAEcLT9odMrXL19l1yme92z0RnmswbzDcdsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289509; c=relaxed/simple;
	bh=lTodMpiU5uuVCAXQ/xJnIx+Vmi4vwQ6HLDXj4qTx9vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WU63ZbZ7Y/7+Sp6mhIMhHpAfGb+pVMyK6busC5+FP1l/dE88RTcrZZGbXK5pFdgAoE6ul20K4fYnLXh4MDDMQ72RgJxS8r08RUxO9ujMpZjh2FAq4FgLqPZMblh5vFhRZf4oNLh8X/aiZeboTBNKBmEvUpuCoyH38J9FbIGzCQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=pRx/iQt2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0c4945c76so303224066b.3
        for <dmaengine@vger.kernel.org>; Mon, 30 Jun 2025 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751289505; x=1751894305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9zeJ4WnqwFH5BMqvuX+OeeKVaWRigfICDw1jtDlC48=;
        b=pRx/iQt2r9Pvyaa2L1OuB1hChLu7PshuT+14UlIp68vk5Y49Ad/UPWyyphWic5nit5
         WLlnh9uTrgCLh6e3KLYHKpAvjIKzleg6DlI0nXbxCHiXjgbzs+8dDevv9wSnpfy+IwAA
         //FF7oQK4EH89QibGMWK/3onxFx9XswMdCSp2MBoG4Nou3HrBgqvtPw5ZPQMWyOSZjs2
         M4836LLojD8qCTqeEDXpPAD3gjgiNQqhbUkpxwWfBhlMS9idNOZOfdGlvJulxTdrOnE6
         alnsshOQzru5++3lEOPFYiNd9rYd+evD3jXbSls//rZn1WttZnBlEObW2KbWYFVFttfb
         rthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751289505; x=1751894305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9zeJ4WnqwFH5BMqvuX+OeeKVaWRigfICDw1jtDlC48=;
        b=r7RKIPqMHx6D2EjeXJqZ363MuchiW3NFbNYbN5fvtTqwuNmug1wrulSAfsjej5qsz1
         Q1spyYLY4SFVJ0Ag8WIR8zOsIdIO1ZacAYkcxmVw1W01m2Rvc+/91/0bmvPmih9FsG2k
         yqxvtrX/mCd/Zs9QM+jh31Eo336WpgomGEu9jgnkPLXehG61IYKucRohVcLxm8fnJEx9
         xWax7mqJCzI+eiObY9WneBfR5FmRu/y6H9+J0guaJKAI+5/tNXMEXKjXO8JWU76z7l+n
         X3a711pJ76EO0LWE3n0evQomSlMgV3JxRrfMhDuJdcmf+G7Wo1VOLv932MLobM/VWbKS
         pGQg==
X-Forwarded-Encrypted: i=1; AJvYcCU5L4bifzo/0fz0kOpGHOpn6nsw9pyKvQ7+C3iwNi1rHT4Ct0/P4Gi9n1JhTDjH9ygCrrY7sLvtTc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRwjQNDtCXpSLqltlUQPSV/9nG/Iq0Bc0oQK+xW91oAej8Semt
	Ms4JGmkH+BkOJgRQUHjSPxEDt9BCsK9kzPnR6CdJNUFkH6NlSx7NYKb6+Iz/VhogfMcmyJHWjcM
	0piBbTA0uL5HYhXrTgI5nkxLPNiCCuAFAQqNHOS0JQw==
X-Gm-Gg: ASbGncvCkSIG1fGDqSLFI7WZmF25PJ1YSTf6l79jFj+TSHCWqOSNJ+dgi+BDyMXQPyO
	IB+SZWcqSQ5O3nSwldIudoI7+ue42G7SPy0Gv3ub+RF+oECVPCAdXfmxd/fXZnjZSv8dz+1fGom
	F+fA12hUgTh9e4YYBmTTOx0WwUAPkS5mLp5z/RoNlW0A==
X-Google-Smtp-Source: AGHT+IEawzH6slgwqh8lMlGexpCFs5UFNCtQJR4Lc0uD06pbIw6jclmGMPNliNKtJ0yxh9f1sHZF7joTilZ8ACzkvCc=
X-Received: by 2002:a17:907:75c8:b0:ade:36e4:ceba with SMTP id
 a640c23a62f3a-ae35018e67cmr951593466b.52.1751289505046; Mon, 30 Jun 2025
 06:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613114148.1943267-1-robert.marko@sartura.hr>
 <20250613114148.1943267-2-robert.marko@sartura.hr> <20250616102103.faoc5tqp22we67zl@DEN-DL-M70577>
In-Reply-To: <20250616102103.faoc5tqp22we67zl@DEN-DL-M70577>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 30 Jun 2025 15:18:14 +0200
X-Gm-Features: Ac12FXweyWpZVaFd_k9KiyWdnFDxPWGB4lbqdU7LoxWxkr8ipI5ijfQoLUWnGLg
Message-ID: <CA+HBbNGWSA8QNzcN1HRosSd7qibM8G0u05cxiia6grGJJ0meoQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] arm64: lan969x: Add support for Microchip LAN969x SoC
To: Daniel Machon <daniel.machon@microchip.com>
Cc: catalin.marinas@arm.com, will@kernel.org, olivia@selenic.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org, 
	andi.shyti@kernel.org, broonie@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, kernel@pengutronix.de, 
	ore@pengutronix.de, luka.perkov@sartura.hr, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 12:21=E2=80=AFPM Daniel Machon
<daniel.machon@microchip.com> wrote:
>
> > This adds support for the Microchip LAN969x ARMv8-based SoC switch fami=
ly.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Acked-by: Daniel Machon <daniel.machon@microchip.com>
> > ---
> >  arch/arm64/Kconfig.platforms | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platform=
s
> > index a541bb029aa4..834910f11864 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -133,6 +133,20 @@ config ARCH_SPARX5
> >           security through TCAM-based frame processing using versatile
> >           content aware processor (VCAP).
> >
> > +config ARCH_LAN969X
> > +       bool "Microchip LAN969X SoC family"
> > +       select PINCTRL
> > +       select DW_APB_TIMER_OF
>
> The lan969x SoC uses the clk-lan966x driver. Would it not make sense to s=
elect
> it here?

HI Daniel,
To me it made more sense to select individual drivers directly in the
config, cause we need pinctrl
etc as well and I dont think it scales selecting it directly via ARCH.

Regards,
Robert
>
>   +       select COMMON_CLK_LAN966X
>
> > +       help
> > +         This enables support for the Microchip LAN969X ARMv8-based
> > +         SoC family of TSN-capable gigabit switches.
> > +
> > +         The LAN969X Ethernet switch family provides a rich set of
> > +         switching features such as advanced TCAM-based VLAN and QoS
> > +         processing enabling delivery of differentiated services, and
> > +         security through TCAM-based frame processing using versatile
> > +         content aware processor (VCAP).
> > +
> >  config ARCH_K3
> >         bool "Texas Instruments Inc. K3 multicore SoC architecture"
> >         select PM_GENERIC_DOMAINS if PM
> > --
> > 2.49.0
> >
>
> /Daniel



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

