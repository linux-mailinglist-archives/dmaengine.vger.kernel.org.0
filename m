Return-Path: <dmaengine+bounces-7907-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AE8CD9B03
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 15:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 651FD300C0FB
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB71F1C28E;
	Tue, 23 Dec 2025 14:36:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7714201004
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500575; cv=none; b=BxMO6MS0nxuN5qBhRWAoRpyQ+sD+oUKPH8pE1xeKD/uwKbaTqIQ1+1oUJA0pLJs7V+/bJ9JoBoNzhyZLgN5THyCiUtVDjMiCXiELgwEAMmcF7E8scnHZnsfH9/F3SmrLlUpkeKl64eNryV9I7NDbumsLTaqsCZXsWzkG2J5CI/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500575; c=relaxed/simple;
	bh=xRHgi78/9TJa6RE/uf2fUH6wEG9F+YXSAx9KnXSZTx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTs1d2qUyKJh+NSNC+q4EwF6Vj3aCMc0NwCcN5HYEt7AbRvEJUQ1A1/vkrcZQ2I0NvvXcUsxgZhmF6A4Tzwt1oQcenA1jMAF8RAQKsiWjYum1StBAyRZOgrC4klw1eWTCxwQIYqZ69LQhWLysQ6EN1Qat+y8Y34dSdo1QS9wAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2627269d5so546365185a.2
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 06:36:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766500572; x=1767105372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9KRWI7ek4fDakJL55ErZIsshqTMY6fNujiPa5ZpWhI=;
        b=EsMclde/2Qo2lX+oCZU3u1N+UKAiSpSemysNojqc379J6BH0rdidqnhcdV6BR6XXnL
         G0DKxIZZX8D5eLYu6niZOfBfRPsQ9/yF1QLp+B6oHpXTlqRgRiFHNKC4nvqQUW4MX8ZI
         83RvTWdxz01v+Bsp6p4mBCT83WkpK1aD1SpVU4UpQeQ0PWWuLdGY/wdrLzMzPCwKAfLK
         ROQftY0s4/AADoeZeoYJ6Lj0zrB3ma20g7BuA5rmbTtMmjKJa9C+Tm8zRP5afP7EwfJH
         b4S1XjP5eTsq4wjy2C1Xniqrb3VptLhGgVT3PPoOvuKy5MHwAkY/2gi0nhs6KLaI0Osj
         LMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF7tPKladc5Unxm2OmSQGaiuU63SuRMeE4i+d/6RA4Vgg7A4U0Uz7j/Ium1pntiaeDdBMqiwlVw2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzepnF2FviUCkM27Alsd75xt8DlN1Q7jbeWFVh/Rs9d6orlbP+s
	6r4fVzcs5gla5jvhIwwvGjIn/C9pxeg/S9jpmKSKM/ujIaOa1hlJWDFlZZN+VYKSg7o=
X-Gm-Gg: AY/fxX52DSjyHIlYv9TbCOV2+Q6ApL5Si06YG6zXaX0IHeawlpKnVUbPy+S6nMdro7u
	3/yP69fPY9DhZLNyYNUxYweZyXKxP+zqTrutpDr9ITd8+K30Rx8za8JB3oAqR3iYOfO8XwN6EqY
	SFXQOZn/gujwXJhZRghcZW53ahurNlH348ip0md1VxQAStIsd+xlL67pK4T68y/21QIm5Itfv51
	gyrG8q+3pAuQ+BZwvSSNXe41iRggZzW/m72UxOLB2QxE6FP7wXU5MCKfIfR5718KfGf//TN8h43
	XkIEI+vyIr53EoVMVikK+MxofkTRRHoi5G7xBfIMq/GxnFKF2DhxChKEjjmUpEqExgdQrIxjLvb
	t9aP3J/sNRi+1yGIP7vZO/kQ7tozsaoI2aL7gzNaXGHu0FqOobllfHa+ftuJQx1cb9iNuF6mO1Y
	diIbOBlm8xZq6QmaPTT0SODtPxpd81EJz8NYtekKiCRnCqg/XVIoI/
X-Google-Smtp-Source: AGHT+IFOAKyk9VJRl7HTPv7epsCPz1lugFS4J/L+LzU9JnpALP487FkdSLl/mhXOZ3J6reGfUmkxeA==
X-Received: by 2002:a05:620a:1794:b0:892:9838:b16a with SMTP id af79cd13be357-8c08fabfeabmr2277929985a.59.1766500572350;
        Tue, 23 Dec 2025 06:36:12 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09678afa6sm1111184185a.2.2025.12.23.06.36.12
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 06:36:12 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2627269d5so546363485a.2
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 06:36:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4+CmhZFXP4rCIxd+H9xXcWaOMHYP200Z+jVfbqVC4MiIqnipVhrphvEkRJp5jda9d9grC2lySog0=@vger.kernel.org
X-Received: by 2002:a05:6122:4f97:b0:557:c697:a30c with SMTP id
 71dfb90a1353d-5615be24746mr4492855e0c.15.1766500234851; Tue, 23 Dec 2025
 06:30:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251201124911.572395-3-cosmin-gabriel.tanislav.xa@renesas.com>
 <CAMuHMdV=EW4YbEBiXH2p0SeC5Kw-YmYWuQwsudpGgM63pgqcfw@mail.gmail.com> <TYYPR01MB1395515AF65F8522AED6B591885B5A@TYYPR01MB13955.jpnprd01.prod.outlook.com>
In-Reply-To: <TYYPR01MB1395515AF65F8522AED6B591885B5A@TYYPR01MB13955.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 15:30:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU1+-o7AOjdJe7yCgU+4x3Kn6d8B5P-EWk6P5_qXsCOZg@mail.gmail.com>
X-Gm-Features: AQt7F2qE2AtxEG2BOxgdP_v34Yp6lChJ9ZLcTByA9b4yF0Q7ASGmqWvId4Nax_Q
Message-ID: <CAMuHMdU1+-o7AOjdJe7yCgU+4x3Kn6d8B5P-EWk6P5_qXsCOZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dmaengine: sh: rz_dmac: make register_dma_req() chip-specific
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"magnus.damm" <magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Johan Hovold <johan@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Tue, 23 Dec 2025 at 15:08, Cosmin-Gabriel Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Mon, 1 Dec 2025 at 13:52, Cosmin Tanislav
> > <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs use a
> > > completely different ICU unit compared to RZ/V2H, which requires a
> > > separate implementation.
> > >
> > > To prepare for adding support for these SoCs, add a chip-specific
> > > structure and put a pointer to the rzv2h_icu_register_dma_req() function
> > > in the .register_dma_req field of the chip-specific structure to allow
> > > for other implementations. Do the same for the default request value,
> > > RZV2H_ICU_DMAC_REQ_NO_DEFAULT.
> > >
> > > While at it, factor out the logic that calls .register_dma_req() or
> > > rz_dmac_set_dmars_register() into a separate function to remove some
> > > code duplication. Since the default values are different between the
> > > two, use -1 for designating that the default value should be used.
> > >
> > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

> > > @@ -1067,9 +1068,18 @@ static void rz_dmac_remove(struct platform_device *pdev)
> > >         pm_runtime_disable(&pdev->dev);
> > >  }
> > >
> > > +static const struct rz_dmac_info rz_dmac_v2h_info = {
> > > +       .register_dma_req = rzv2h_icu_register_dma_req,
> > > +       .dma_req_no_default = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
> >
> > Since this is the only remaining user of RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
> > and this structure does specify hardware, perhaps just hardcode 0x3ff?
>
> In my opinion we should let the macro live in the ICU header as the
> value is more tied to the ICU block than to the DMAC block, even if
> the DMAC driver is the only actual user. But if you think this is
> worth changing, I will change it.

I have no strong feelings about this.

If it is really more of an internal ICU thingy, an alternative would
be to remove all public *_ICU_DMAC_REQ_NO_DEFAULT definitions, and
just pass -1.  Then the ICU drivers become responsible for filling in
the appropriate default value.

> > > +};
> > > +
> > > +static const struct rz_dmac_info rz_dmac_common_info = {
> >
> > rz_dmac_classic_info, as this is not really common to all variants?
> > I am open for a different name ;-)
>
> rz_dmac_generic_info? I don't have a strong opinion, but I agree that
> common denotes that it would be shared across all variants, which is
> not the case.

Fine for me, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

