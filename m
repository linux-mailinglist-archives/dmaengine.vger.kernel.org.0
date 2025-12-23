Return-Path: <dmaengine+bounces-7890-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E6DCD9799
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56650301EDCD
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E827C2248AE;
	Tue, 23 Dec 2025 13:45:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6015ECCC
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497536; cv=none; b=D5vClHruCxDj1YAp9ieGnH6LkL8kQxq1yq9rEY5rjyBekl1anrGdcRKEjh/h76lVtNJzAdUdzpM/Qaog5Vq2x/s7GH6unr5rzFrJX/6umBGPpUsmOCXdYlawU3ozuvZWTWZQwVBe1W33J4qzwwc268UfuiMFmGUpd+rzy9u1MOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497536; c=relaxed/simple;
	bh=+vgDq4lQzhcJ/PmjToagAIXB+7UjAyqauVh2qc4S2YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV2bOIFi25dcZf3PEW8w/fArXXzSoQLFe3Gv2plO59xok10XGxeRccdMMJ61UTukBgURGyaLB/CpVymw0P+Y565f9Rfc2omILeSrj/dBku3MaAjc5jl2WbR7sLKEhDIFJqyjJfc68CLuBLPmpoyJ0Va2mJMBlR6gNcnPDcBDhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso6365129a12.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497534; x=1767102334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U258/dz1ml2wi6XM7goSRHkqu3ww0wtWLKndOq5PViQ=;
        b=kVjcIUL/wGKCgy9NASPbjXtoMFUCJrIw/jWK2pX8oXEaMBBhTWtfdGJRANK32MfXHJ
         b03qlO4U2zYQmT0WZKZ3Szh2X82QqqmAJt4GYyI2EIqRE3teiDtl08pxlgd5RoSlUyNR
         SAqTMkMGGaPHNRafI3GJanGIOpJatg2WwJeCAgx5pPWgI9XRhl6OnyNPvMQ0W9Qcvv46
         obg1YfGfRmUePXVaHhdukfnW8phR8QoZIMm+f+kbCpEMGZv8hTUTxefeAXbmUgcDEYRG
         GQ2Dj/TnZy/dTmYlI+XvdWCAg08KFFf/CYxM4/EzgBjxZXut4h/fGgIkDLumNA+upJEv
         6buw==
X-Forwarded-Encrypted: i=1; AJvYcCVtg/SvZqh8A6iY5OvPRIV2qMLu6BK76upxBMwjbn8UG6jkeb1qs/EZwHElgxDXKJn3rFUqAdDSr+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9u8qCMN1ZF4xUVRdZFYqF7lE6WdBdTa3Ows5a972nMLFPT8Gf
	xnr7j/gb/rVt8/IYLUu4fkPBneOvrv0Q44Ymc9GnPVColuQS0mkZjqypMd+ZLQfzJfk=
X-Gm-Gg: AY/fxX7aZ+gNqjKOIWqGjQ40tt7U45KAu/sw37dQdXco6bfDb5v6Otncxa8x7Twsskj
	p5K0eJRfDla0JhvuQpYz+/9T71j4SWP+etlzjTiFs00rif7xkm3+9FwObzmAAgdQ5fLNhrMgZ0H
	O8Og0ZhcnDphKFjP5YfnPlN6VmnmgfG8Kwf3SINL50surdCk8610vYj3qqlvxIxov/B30vm/SaF
	ZW6ef53KbK+ZOzs/ZAza3uUbTnZV1h+PzB7ANfbpCcyT0pPNlZKglDcdfnibfcDm8fOiiJd5e2P
	MASfpLabHHBtmUBNyqi/H6YVhLMO1Szv3ACD+oFiJYXZQTq813+ogFsFkEGkdaHpO4cpniANvVX
	IDjF7vpxjDaFcGqpn3WbKvdpVi+IZ5MCO9yAcuQ8lWR4u3nyCADXnVFgOtxia2GypDlz1A1brUe
	9zjRw32E00HNiXF7vt3jneddOqBVjjLvWSwlAhwwZv/nOrbU87
X-Google-Smtp-Source: AGHT+IExT5Jwm9tOlAKUq9k5nsIxnYZwI2gikpeW7mRnAghkiq5usBAAew4KuI+tsaxBOVAU/OTb/g==
X-Received: by 2002:a17:907:9717:b0:b72:8e31:4354 with SMTP id a640c23a62f3a-b8036f947c5mr1526327866b.25.1766497533339;
        Tue, 23 Dec 2025 05:45:33 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f09149sm1396418166b.47.2025.12.23.05.45.28
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 05:45:28 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b61f82b5fso6546675a12.0
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:45:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCrEz89tV2/T1bKSU3Yf9P8aBHzgBhU0b2Zx8sNmCdKT8AMJzuhOHRrgxOPiYUKgT5+9dGrivcs74=@vger.kernel.org
X-Received: by 2002:a05:6402:1e90:b0:64d:4894:776b with SMTP id
 4fb4d7f45d1cf-64d48947948mr7064838a12.27.1766497528286; Tue, 23 Dec 2025
 05:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251201124911.572395-3-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251201124911.572395-3-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 14:45:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV=EW4YbEBiXH2p0SeC5Kw-YmYWuQwsudpGgM63pgqcfw@mail.gmail.com>
X-Gm-Features: AQt7F2oX7CMa_8FU9LCOCZqrziankMeMXgDYxBV-ZhAtoMZJ9gqMth9qd4a31zo
Message-ID: <CAMuHMdV=EW4YbEBiXH2p0SeC5Kw-YmYWuQwsudpGgM63pgqcfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dmaengine: sh: rz_dmac: make register_dma_req() chip-specific
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Johan Hovold <johan@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Mon, 1 Dec 2025 at 13:52, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs use a
> completely different ICU unit compared to RZ/V2H, which requires a
> separate implementation.
>
> To prepare for adding support for these SoCs, add a chip-specific
> structure and put a pointer to the rzv2h_icu_register_dma_req() function
> in the .register_dma_req field of the chip-specific structure to allow
> for other implementations. Do the same for the default request value,
> RZV2H_ICU_DMAC_REQ_NO_DEFAULT.
>
> While at it, factor out the logic that calls .register_dma_req() or
> rz_dmac_set_dmars_register() into a separate function to remove some
> code duplication. Since the default values are different between the
> two, use -1 for designating that the default value should be used.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

You can find a few non-functional nits below...

> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -95,9 +95,16 @@ struct rz_dmac_icu {
>         u8 dmac_index;
>  };
>
> +struct rz_dmac_info {
> +       void (*register_dma_req)(struct platform_device *icu_dev, u8 dmac_index,
> +                                u8 dmac_channel, u16 req_no);

icu_register_dma_req, to make clear this is ICU-specific?

> +       u16 dma_req_no_default;

default_dma_req_no, to avoid confusion between literal "no" and an
abbreviation of "number"?

> +};
> +

> @@ -1067,9 +1068,18 @@ static void rz_dmac_remove(struct platform_device *pdev)
>         pm_runtime_disable(&pdev->dev);
>  }
>
> +static const struct rz_dmac_info rz_dmac_v2h_info = {
> +       .register_dma_req = rzv2h_icu_register_dma_req,
> +       .dma_req_no_default = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,

Since this is the only remaining user of RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
and this structure does specify hardware, perhaps just hardcode 0x3ff?

> +};
> +
> +static const struct rz_dmac_info rz_dmac_common_info = {

rz_dmac_classic_info, as this is not really common to all variants?
I am open for a different name ;-)

> +       .dma_req_no_default = 0,
> +};
> +
>  static const struct of_device_id of_rz_dmac_match[] = {
> -       { .compatible = "renesas,r9a09g057-dmac", },
> -       { .compatible = "renesas,rz-dmac", },
> +       { .compatible = "renesas,r9a09g057-dmac", .data = &rz_dmac_v2h_info },
> +       { .compatible = "renesas,rz-dmac", .data = &rz_dmac_common_info },
>         { /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, of_rz_dmac_match);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

