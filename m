Return-Path: <dmaengine+bounces-4559-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1BFA40172
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 21:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF29417E050
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 20:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BA1253B47;
	Fri, 21 Feb 2025 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmJaPxB+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299E81EE028;
	Fri, 21 Feb 2025 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171381; cv=none; b=OyipwjW1bKvl5Nszg4MbRcI2QDbmDUkQXRyIsxNTm1kD2aB31Injbb3aDR+EVdZestQBopGnigvFGlX4jfilRkyUXqUojOlRExa2OIsG1t0mroSZ+kpROnb+Ow8UXIOPiMsnPMbVtncKoHVcOdzs/tWT476TZC1W5OD5/VR6uBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171381; c=relaxed/simple;
	bh=UL1z5TnqKig+hBxBnqDx45IBPuEIlWEWCSeD0gsgzn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYy6MWOgsOmaDyECRs4XhpUsQbVxtn3dEizidpBL1O12UiQh0/zlfasIr+rcQcERoSlBJMGahGRIdQJKyBbNJbmvX/EQ7qel4U+0EiNXb6+GPMBuFuS87cMRG7LoYQ+/BaBZp9xLmgP681rQITepWz0VUFQB1UqpTl8ZWvk6akM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmJaPxB+; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-521b1b8cdb6so772284e0c.2;
        Fri, 21 Feb 2025 12:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740171378; x=1740776178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lx4mqqy75rNSrTRSbcy4HlReGbdqE3Sp6PMY5cYoGE=;
        b=AmJaPxB+vRCi0PuKB5jXoCql0rFATMnljFomckv5gABSAKAgz5exZTqPot7Zntaeex
         8hz0myeLIXSTBbfg5KP0K4yVIKOyVgBceBcwkcZC92yCBMfBL/4H6lZbz3Za7cKC3oZu
         KYuAUlRWau2l3cggIJPh4TD/Pwvpop7q/aSrBdiDSsWn9JMJiby4OKo1B3y9DCZRdtfH
         Q8bhd6cWKMcuKt3ItyjL7LBQP0qdcE42aaPrMO9GtitSnvGH9z3A23MKTukJ85GEo230
         vIq0HjyZeWuTkJg+8V9oZwPCvpOjLGmJaDqQwljufdnZgiyFuMkOe/VfrPmtaNImum59
         NkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740171378; x=1740776178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lx4mqqy75rNSrTRSbcy4HlReGbdqE3Sp6PMY5cYoGE=;
        b=ai6pAQZSJZGgN0O0H+xhuDDLOLKLG8ZQ+DxWhM7ge11abbzNCAIBvNMvUa3YIqHE82
         6G8B7t7CRz8EjLvggn2n8DG0rKxmbEtEkHt8rYOOM70oZjAH7IWUCiaPAWh2YDBBnj6M
         WXjGLMQPKgWQzG14yt0DAV9MBUwEp1LwN4g4W2GqE4/mVxeHDW8v8w5Rl0PWjHPdHDoz
         io0g2U3c0Ct+wlHAf4hroFTqEfGcUlrGrhY2ahUj8SJKqh3Wvtm4DtS5ZwPFwoNRVbGS
         wdDuAJ527NI1XcV11AciYddCsRKMmzZOCCxo51kSRMzOplvHMl+Nr3FJHA8BNyRGZ8nU
         094g==
X-Forwarded-Encrypted: i=1; AJvYcCV1Kqxm4NkZhEmCGLc67/bZoNyXycukm9krmDXnNYOCHXjMqDGWOR34EemCkZZ/ICDXuK8AYQ/P2Qs+@vger.kernel.org, AJvYcCW7iGAO0lEkO3kl0yijRbGJSigVfU0ooDt8GLlOUds0P9mooeeGo1vfAtgHA1WU+E51eZ3a4EpWwVve@vger.kernel.org, AJvYcCWBddCN582a0SHXAPXCWx6zpCq0K7Hn4uqZux6zBNYREnsYi7dNNDZU2y+jWQk4HMnW1V3qlLZXg/CmoU2J@vger.kernel.org, AJvYcCXEy6wa2FqCU1ZrxzgT5K74CNAtTy4vpJDiMsERoIFDVUBrVuJtttj+H8symdzGAz+dfDGNnuzSWqo8mA1DqWmPvnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbS4yoxdT2gspC5jh+spJ2YONTOcqs2Ay2bGmqP454ToPqoeu4
	ol5CxwXNBN9tEmBgZ629ncCo5ourrJmepkMPJFf0HiI6bKgQ5s+QiyJEHPxlrv7j/T7JOHBCB4/
	4o+Zvh5nEiKyQW24rFRHHEL9jy6Abzq9CMr+F/A==
X-Gm-Gg: ASbGncu4gmrde2qGGu1vUtp7zNxt6MpJKDZPWNkLzDTn0Jo0sS+FMjMC+KQDIPKHq6h
	kIdSDpOK8cShrvL5qMdCTTB9GaZS4HOZicQQnYtTSvPvkaI0z7QC5tYMlHYUIO7mMMMqWwwCwah
	p4wbirwXSHb3chzbotkBKIe6Ht7lZiRyiLeRi+Anbk
X-Google-Smtp-Source: AGHT+IERGozJb/6nPHDwHNQA1dFetp7MiXp9WxbHkmklEamD2M9EYzc6xT1kmbt7+dthkN1C24Jb7NsMhzk+3jsYPVM=
X-Received: by 2002:a05:6122:659d:b0:51f:3eee:89f4 with SMTP id
 71dfb90a1353d-521ee468b8fmr2614676e0c.9.1740171377817; Fri, 21 Feb 2025
 12:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com> <20250220150110.738619-4-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250220150110.738619-4-fabrizio.castro.jz@renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Feb 2025 20:55:50 +0000
X-Gm-Features: AWEUYZkma8d8M8WhbDx0OPdVZzz-yZU3qhLlR7mNrh-EV9K2DltzETgWbcNteys
Message-ID: <CA+V-a8t2FQajtsxzDc+HoJmVWzMFegkYirAgF+Q_a9rjeHowPw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:15=E2=80=AFPM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
> The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
> Renesas RZ/G2L family of SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ NO/ACK NO
> * It is connected to the Interrupt Control Unit (ICU)
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v3->v4:
> * No change.
> v2->v3:
> * No change.
> v1->v2:
> * Removed RZ/V2H DMAC example.
> * Improved the readability of the `if` statement.
> ---
>  .../bindings/dma/renesas,rz-dmac.yaml         | 107 +++++++++++++++---
>  1 file changed, 89 insertions(+), 18 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b=
/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> index 82de3b927479..4b89d199c022 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -11,19 +11,23 @@ maintainers:
>
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - renesas,r7s72100-dmac # RZ/A1H
> -          - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five
> -          - renesas,r9a07g044-dmac # RZ/G2{L,LC}
> -          - renesas,r9a07g054-dmac # RZ/V2L
> -          - renesas,r9a08g045-dmac # RZ/G3S
> -      - const: renesas,rz-dmac
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,r7s72100-dmac # RZ/A1H
> +              - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five
> +              - renesas,r9a07g044-dmac # RZ/G2{L,LC}
> +              - renesas,r9a07g054-dmac # RZ/V2L
> +              - renesas,r9a08g045-dmac # RZ/G3S
> +          - const: renesas,rz-dmac
> +
> +      - const: renesas,r9a09g057-dmac # RZ/V2H(P)
>
>    reg:
>      items:
>        - description: Control and channel register block
>        - description: DMA extended resource selector block
> +    minItems: 1
>
>    interrupts:
>      maxItems: 17
> @@ -52,6 +56,7 @@ properties:
>      items:
>        - description: DMA main clock
>        - description: DMA register access clock
> +    minItems: 1
>
>    clock-names:
>      items:
> @@ -61,14 +66,22 @@ properties:
>    '#dma-cells':
>      const: 1
>      description:
> -      The cell specifies the encoded MID/RID values of the DMAC port
> -      connected to the DMA client and the slave channel configuration
> -      parameters.
> +      For the RZ/A1H, RZ/Five, RZ/G2{L,LC,UL}, RZ/V2L, and RZ/G3S SoCs, =
the cell
> +      specifies the encoded MID/RID values of the DMAC port connected to=
 the
> +      DMA client and the slave channel configuration parameters.
>        bits[0:9] - Specifies MID/RID value
>        bit[10] - Specifies DMA request high enable (HIEN)
>        bit[11] - Specifies DMA request detection type (LVL)
>        bits[12:14] - Specifies DMAACK output mode (AM)
>        bit[15] - Specifies Transfer Mode (TM)
> +      For the RZ/V2H(P) SoC the cell specifies the REQ NO, the ACK NO, a=
nd the
> +      slave channel configuration parameters.
> +      bits[0:9] - Specifies the REQ NO
> +      bits[10:16] - Specifies the ACK NO
> +      bit[17] - Specifies DMA request high enable (HIEN)
> +      bit[18] - Specifies DMA request detection type (LVL)
> +      bits[19:21] - Specifies DMAACK output mode (AM)
> +      bit[22] - Specifies Transfer Mode (TM)
>
>    dma-channels:
>      const: 16
> @@ -80,12 +93,29 @@ properties:
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
> +      On the RZ/V2H(P) SoC configures the ICU to which the DMAC is conne=
cted to.
> +      It must contain the phandle to the ICU, and the index of the DMAC =
as seen
> +      from the ICU (e.g. parameter k from register ICU_DMkSELy).
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
> +
>  required:
>    - compatible
>    - reg
> @@ -98,13 +128,25 @@ allOf:
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
> @@ -112,13 +154,42 @@ allOf:
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
>
> --
> 2.34.1
>
>

