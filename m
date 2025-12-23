Return-Path: <dmaengine+bounces-7900-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2B5CD9835
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABF22302C8C0
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A032BE7BB;
	Tue, 23 Dec 2025 13:51:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED52D7393
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497859; cv=none; b=ebKB7CehlceyoIbKQ03y+w9zwhaONUs/Z2eg7tDyuNlAZfkFfFzRUgRgIrnbk6B9ztLhkJOhPdZhyijkZOn5JYEetTPPAmCm+b8+cJxj4FLF4buHGV143WEalzUI9JVVjP8J6sstfyfrnLNj9lvb22E0G1KEBC6KhXCiE+DvN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497859; c=relaxed/simple;
	bh=5muInitChGsMSj6kPp99AfFHw72VmyRJFeeekTtjmcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPg+J3fkv4FCNrseJR17L5gIXjahygkSgyhCsl5zhII3Y1e52ngBC+BBsCzdnQ0uYtsURAXjVbDXXBo66Ch0/qj22ZAkWFp1dbSo1wZUsPHlJ2l9TlIR4Z8LYHLazC+qXbGEhWlkNgfgMGddZJssTSWysmiYyfTZ6sOQogS2oT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b79af62d36bso878693866b.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497856; x=1767102656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxgwuYv1GqkX/JgxOxMK1IynEvwBQ0HN2CK1BOB0UKY=;
        b=HJ5KrMB+vlGiICy+pAA3KSNsAZkS28gOEjqFfixCAhafLVH+0Tp7+Fyp8JdsZ1fWsf
         lAJgJwZ5hfMO86BY/ECA005TJTbOo+Q0kgKrROfKFI70E88BWJ/wsJyGKxyyfxkucnj7
         oNOj4S7mTS54Y9NikrIg5GkQilEvcOoeGkbpI4K+tdwQuLqVnYRwKFPDFy/PjwddW4HF
         QtFV/8KQ97ezDDJA8j9MYNdIFREvHRvGeZMj5XsMSutnZPbkYEtE04sZCVcbPk2+EbR/
         LqsFybkPue5ELxUT+Fci837/mH2RvqNQFe68nwjhij90SjNpCmWtNF6V5mHU3V9pdq9m
         PBkw==
X-Forwarded-Encrypted: i=1; AJvYcCXjKna/sPIiM91pH47Pz9jxZU0XOfK7D1epcnwKtiQxMzFCvgn743TLo2dDl5/4Z1WqJ5hNMtsv31g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4oC05ta/y4rYNdE6tcjsSW4goA7/PfdXjjppIHKClVP4UGtM6
	YJZXFTAJusxiInmt0x5oyXN7G4ts1el8HtYXKHTgOQ4/02v4K4E7IzdwP+FGSvGPeso=
X-Gm-Gg: AY/fxX6aa0KpowCU7BcmR+9reotmLa4kiu4EjoE/WLEM9ywk7dmQSHeaQmTcptNL+jf
	gStoViVaAojNb0V+5GRyg9UP8ebLoS6l+sc3uh1ifOgN09qUjaujjmwFXC4ir0kDT024ICzugJI
	lupuOpS212lushRZuBkVMzPJsplIGmrJUfYIloOKP6UEzlbEUeTxX9KS2Kqb33Y/OoAtN8KX6BQ
	SNwIiGO45ePMyGuIzJho79pRBL9+PBfEelaUibY3jkMmO6XkqNhVWigZpLMeZbObin82gvQS1VV
	kyby9c93A8P49PhRnbGkDy5SRHlxfE3p3yUYP0G7QtIlAZYX8KKSoj5EIVt2xwjl3c4U5fLvs57
	WdJfmNdmk6c3GSTYa05CbnShMFtVnNcHiQJVCnAPHH3f1ndgbLBY2wcEzVA7LadpGOB45rtEa9I
	k3VyMQxPEz0MhaN/vBbvV89Ds9OBRaiBpjReACwNhv21NkOS3C
X-Google-Smtp-Source: AGHT+IGuM7uD7guTIlwkYJ/ojd5506m6ETu+qfH4G474kSCJbKOkHkpSA++P+Xa6JKYwvFV0VPzeRw==
X-Received: by 2002:a17:907:3f23:b0:b74:9862:3e36 with SMTP id a640c23a62f3a-b8037198d15mr1624167866b.51.1766497855807;
        Tue, 23 Dec 2025 05:50:55 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad8577sm1409543466b.24.2025.12.23.05.50.51
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 05:50:52 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b83949fdaso5987212a12.2
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:50:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdV+Mm4C+w2R5GgmOTjfud5Ze3kpilRqY8XPTGZuc2shirbi269j+VgVaVoWm/qbCgVe9/sf80FKM=@vger.kernel.org
X-Received: by 2002:a05:6402:13ca:b0:64d:e1c:4c0a with SMTP id
 4fb4d7f45d1cf-64d0e1c4d98mr11290130a12.0.1766497850916; Tue, 23 Dec 2025
 05:50:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251201124911.572395-5-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251201124911.572395-5-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 14:50:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDhi9KqE5hS=z_UqWQ8Hzhy82NaqBMOm7c2q15=M=SBA@mail.gmail.com>
X-Gm-Features: AQt7F2pBYW6Az37iaIR_8IHqN4poQvGi9qJio54afeSNgWx41VFy7kVT0EKlhFU
Message-ID: <CAMuHMdXDhi9KqE5hS=z_UqWQ8Hzhy82NaqBMOm7c2q15=M=SBA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dmaengine: sh: rz_dmac: add RZ/{T2H,N2H} support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Johan Hovold <johan@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

CC tglx

On Mon, 1 Dec 2025 at 13:50, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs use a
> completely different ICU unit compared to RZ/V2H, which requires a
> separate implementation.
>
> Add support for them.
>
> RZ/N2H will use RZ/T2H as a fallback.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch!

> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -15,6 +15,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/irqchip/irq-renesas-rzv2h.h>
> +#include <linux/irqchip/irq-renesas-rzt2h.h>

As this has a hard dependency on commit 13e7b3305b647cf5 ("irqchip: Add
RZ/{T2H,N2H} Interrupt Controller (ICU) driver") in irqchip/irq/drivers
(next-20251217 and later), Vinod cannot apply this patch without
merging that dependency first.

>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -1073,12 +1074,18 @@ static const struct rz_dmac_info rz_dmac_v2h_info = {
>         .dma_req_no_default = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
>  };
>
> +static const struct rz_dmac_info rz_dmac_t2h_info = {
> +       .register_dma_req = rzt2h_icu_register_dma_req,
> +       .dma_req_no_default = RZT2H_ICU_DMAC_REQ_NO_DEFAULT,
> +};
> +
>  static const struct rz_dmac_info rz_dmac_common_info = {
>         .dma_req_no_default = 0,
>  };
>
>  static const struct of_device_id of_rz_dmac_match[] = {
>         { .compatible = "renesas,r9a09g057-dmac", .data = &rz_dmac_v2h_info },
> +       { .compatible = "renesas,r9a09g077-dmac", .data = &rz_dmac_t2h_info },
>         { .compatible = "renesas,rz-dmac", .data = &rz_dmac_common_info },
>         { /* Sentinel */ }
>  };

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

