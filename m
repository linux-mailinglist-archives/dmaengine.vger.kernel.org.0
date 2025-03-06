Return-Path: <dmaengine+bounces-4654-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982E3A54C1F
	for <lists+dmaengine@lfdr.de>; Thu,  6 Mar 2025 14:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B827B16C1E6
	for <lists+dmaengine@lfdr.de>; Thu,  6 Mar 2025 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B72720E320;
	Thu,  6 Mar 2025 13:27:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5A20E310;
	Thu,  6 Mar 2025 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267642; cv=none; b=pOKC8rjMUbI36fQSNgTBH/Z40bXbhDav+HSovcsWXz6/8fHdB3Y2JQFFu94ImOb61OumFkjcquQVoIuzSeTdiGXJxenp8vRfu/gIjWF+108V6RFjQnnPBbRChyRxscIhjI6Oh8M8/pwiLuuv0sMN6cctR2t7r4PEFaLU3iDebbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267642; c=relaxed/simple;
	bh=XKcEeWbzH4fA5/cvRfTVPBDGny582CAz/diU/D9T8do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApGOFXxXY5xEoeIl/WBW66aQ7r/9ZlOn0m15WH05p+oNFV49qWgH7pOj3jTCkJsq2lhEupbkvm/KYx7bmxZOg/mZ9J6l0dste9tWfMf63AapHKw07fB7zRKg3qsdFgep6H7p202zdJ2TZwA8ws4AegxTmrPVBmHlKMQPevpS3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86b6be2c480so226858241.0;
        Thu, 06 Mar 2025 05:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741267638; x=1741872438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1V4GXjxaHQ1MX8XrAYuwsdCJjMPQ0MFEVUQeYP147s=;
        b=m3qxBlVPwOPZnKoVJLeJFLRQqSBq+WbqIqNIwbx7HmBOvt4sIcfh18c92G00LjtvQJ
         w5a1MYM25R8JWyumJSeue63VPLAoiV3v2DYww+CviSXxBbO7NaHM4ch5YsC0nl/vv7AU
         zYYO4DmPUx51yQwhH2ENUmJ6IcPM9B/IXAr327FjQhvy7pP7zHXIXcg4A9KvEdyUO6Kh
         5WRFEU1VkbzA5KfNSfhIYRnod8YeMNf0V4gh3NPoKXQGq19EgNnMSuzy9TKHsnUrg8Ug
         w++2t5Va1cAyEcT9yGddVj3YBTnVB5B43ScuixXLD3Gd6HNKtdECXK5hZiGZCJQ5CBqT
         d+zw==
X-Forwarded-Encrypted: i=1; AJvYcCU4gHPoXFd0H9ZuvkD/UCd9+3JKd5t/qtqsrI1wF7GF53Nj4fhH9+8lJcYns/dGMl9azQO5+94KVCPzduUB@vger.kernel.org, AJvYcCWYjG3/BuECLQptl9FrYWqlQLnlC/mUbTVyR9SsWpUq8gtOFZP7UtkZPdyUMsSNym+q/6lZCUNRg37e@vger.kernel.org, AJvYcCWcSesvGcWQFnXdAQ1fIEjV/mR5GqA8Q8lB9jKx0hS8mkRFhfHwtz2S51A3mI0lDOS0mdAuwTKGlB+M@vger.kernel.org, AJvYcCXhMWOUe76kpzRs5oFP4NOPSXI13pDo16svGp8GXkney8NdwodfFjEs1el9Gk/waZdpIr1kR+dBElbb8aBt5HzLy78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf2JQTgStjCK+DJH210+Y+KXxB5UgyoDdf1TTfcoCOcCQDzTfI
	G4Mmn0j6Dsx+0SpowfnCCFeNIUvQPZnBgP2PVb22q3IZP23s8/yV5tX6NPdn
X-Gm-Gg: ASbGncvRbFvGv+xl5+WXigAH2SMHGnWPGKgVo+l0ku4Bj4JdxBC6IQ/39cR59N5RbAs
	mMmhiqg3Wa97GR/BF0BlcNcPzbothJk7KZUcPbQp5Modp6IqLH5PkLdSPvWy2cKZ960vWBWOQeK
	6EoMZrOOE+FaI8znPMLPitcM8Q8cDBmRiSl0j6OAYRCSLIptVCu2PvDrXqbFywajUvX9jv+4ZMi
	tV068QMFYrbfVHL5qAXTz+q8smm9MYanAymKHjYs3X8xdbB7Eomw4GCGez9SS/frQ9QkjtUDJK2
	ZMBANtW6uwNEN1j5LEnRL2qYjSPpnAVG/eT9U+ha/TqA+i21UVZyHJiRASkU9WtedrYV/zRlYHD
	8vFkh6+Y=
X-Google-Smtp-Source: AGHT+IEy6Rv4wjm84q5K+TbBTG944eiJABN0mDsfYMGHJX/ZGbboYio9IbTuwHyaN29m5pVPVd1RoQ==
X-Received: by 2002:a05:6102:dce:b0:4bb:cf25:c5a7 with SMTP id ada2fe7eead31-4c2e27a6d7dmr4441933137.7.1741267638412;
        Thu, 06 Mar 2025 05:27:18 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33ca65a9sm219399241.27.2025.03.06.05.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 05:27:18 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86b6be2c480so226841241.0;
        Thu, 06 Mar 2025 05:27:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU92WFNfySAnYVgKlWOUXgBHaW565dGpVNMpOpzEHn+/1MNShzgqaaPC2QX98aP+ZbjeaCvoblDJgIp@vger.kernel.org, AJvYcCUWpNX27F7ebNDUkBz3h1pY1ByBTTFcKVPP8Bzsun8T9ESkqvxBWkODOxesfiX35Of8+T8lXl1Z7btGQrBj@vger.kernel.org, AJvYcCXiBXrAqOoa+R2A3TM8EqkQ9+zsy+ToCENjOlElsCuMYeKbpo7oGQp6UC9Z2RNaqqYIcWMjQa+crshHZWPb1waIh8A=@vger.kernel.org, AJvYcCXvpHYzGUcDC92TMRiTc5rrAPamygUFPdZ4RTwEWWiRfSwTwea2XMSJQzeiKi+z0WkLlr1lkvHWazDY@vger.kernel.org
X-Received: by 2002:a05:6102:e12:b0:4bd:3519:44be with SMTP id
 ada2fe7eead31-4c2e2804512mr4388822137.15.1741267637914; Thu, 06 Mar 2025
 05:27:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com> <20250305002112.5289-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250305002112.5289-3-fabrizio.castro.jz@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Mar 2025 14:27:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVeLiQKHm5BQXhqEjKTP4p7Y20b5ocsjvNCnicDQym19A@mail.gmail.com>
X-Gm-Features: AQ5f1JroeThd9ulD1ahlmdpsXT6NLFZFZZdIi3Hy9pIsRu-zZy6kxIxGiyfRxZQ
Message-ID: <CAMuHMdVeLiQKHm5BQXhqEjKTP4p7Y20b5ocsjvNCnicDQym19A@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Hi Fabrizio,

On Wed, 5 Mar 2025 at 01:21, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
> The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
> Renesas RZ/G2L family of SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ No
> * It is connected to the Interrupt Control Unit (ICU)
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v4->v5:
> * Removed ACK No from the specification of the dma cell.
> * I have kept the tags received as this is a minor change and the
>   structure remains the same as v4. Please let me know if this is
>   not okay.

Thanks for the update!

> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -61,14 +66,21 @@ properties:
>    '#dma-cells':
>      const: 1
>      description:
> -      The cell specifies the encoded MID/RID values of the DMAC port

Please just insert "or the REQ No" and be done with it?

> -      connected to the DMA client and the slave channel configuration
> -      parameters.
> +      For the RZ/A1H, RZ/Five, RZ/G2{L,LC,UL}, RZ/V2L, and RZ/G3S SoCs, the cell
> +      specifies the encoded MID/RID values of the DMAC port connected to the
> +      DMA client and the slave channel configuration parameters.
>        bits[0:9] - Specifies MID/RID value
>        bit[10] - Specifies DMA request high enable (HIEN)
>        bit[11] - Specifies DMA request detection type (LVL)
>        bits[12:14] - Specifies DMAACK output mode (AM)
>        bit[15] - Specifies Transfer Mode (TM)
> +      For the RZ/V2H(P) SoC the cell specifies the DMAC REQ No and the slave channel
> +      configuration parameters.
> +      bits[0:9] - Specifies the DMAC REQ No
> +      bit[10] - Specifies DMA request high enable (HIEN)
> +      bit[11] - Specifies DMA request detection type (LVL)
> +      bits[12:14] - Specifies DMAACK output mode (AM)
> +      bit[15] - Specifies Transfer Mode (TM)

... so the casual reader doesn't have to look for the (nonexisting)
differences in the other bits.

>
>    dma-channels:
>      const: 16
> @@ -80,12 +92,29 @@ properties:
>      items:
>        - description: Reset for DMA ARESETN reset terminal
>        - description: Reset for DMA RST_ASYNC reset terminal
> +    minItems: 1
>
>    reset-names:
>      items:
>        - const: arst
>        - const: rst_async
>
> +  renesas,icu:
> +    description:
> +      On the RZ/V2H(P) SoC configures the ICU to which the DMAC is connected to.

Are other SoCs with ICU planned?

> +      It must contain the phandle to the ICU, and the index of the DMAC as seen
> +      from the ICU (e.g. parameter k from register ICU_DMkSELy).

This is already described more formally below

> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the ICU node.
> +          - description: The DMAC index.
> +              4 for DMAC0
> +              0 for DMAC1
> +              1 for DMAC2
> +              2 for DMAC3
> +              3 for DMAC4

Other SoCs may have other mappings.
So perhaps leave out the translation table, but write:

    The number of the DMAC as seen from the ICU, i.e. parameter k from
register ICU_DMkSELy.
    This may differ from the actual DMAC instance number!

> +
>  required:
>    - compatible
>    - reg
> @@ -98,13 +127,25 @@ allOf:
>    - $ref: dma-controller.yaml#
>
>    - if:
> -      not:
> -        properties:
> -          compatible:
> -            contains:
> -              enum:
> -                - renesas,r7s72100-dmac
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a07g043-dmac
> +              - renesas,r9a07g044-dmac
> +              - renesas,r9a07g054-dmac
> +              - renesas,r9a08g045-dmac
>      then:
> +      properties:
> +        reg:
> +          minItems: 2
> +        clocks:
> +          minItems: 2
> +        resets:
> +          minItems: 2
> +
> +        renesas,icu: false
> +
>        required:
>          - clocks
>          - clock-names
> @@ -112,13 +153,42 @@ allOf:
>          - resets
>          - reset-names
>
> -    else:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r7s72100-dmac
> +    then:
>        properties:

    reg:
        minItems: 2

>          clocks: false
>          clock-names: false
>          power-domains: false
>          resets: false
>          reset-names: false
> +        renesas,icu: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g057-dmac
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +        clocks:
> +          maxItems: 1
> +        resets:
> +          maxItems: 1
> +
> +        clock-names: false
> +        reset-names: false
> +
> +      required:
> +        - clocks
> +        - power-domains
> +        - renesas,icu
> +        - resets
>
>  additionalProperties: false

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

