Return-Path: <dmaengine+bounces-4988-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7B9A988AF
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 13:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B599A17633A
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 11:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D08270576;
	Wed, 23 Apr 2025 11:37:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A5FC08;
	Wed, 23 Apr 2025 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408254; cv=none; b=FHVbqB7I2gdss7OGJeceCZc0XaC37/tabiuNvZ1OsjJyPgEQwkCKrxfc305OUbJkSSNNqHOchyxPWYM+NPzzIUFyK6ahn1ZO2eIahHYninJ/tAQQjEP8vOZsz76xlj23qIj6eAXSP68omWWtmNZDZ0naHQ2kWiUOVHl7JF2XvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408254; c=relaxed/simple;
	bh=6OQ2IkiNk4wkMhSgShhUXpqGsET/HqmzKTydByHvaQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxzMOnvjG4o0C+Wt+8gx+R6TXNEslMnBzyruBKwb8Mw0qCCYaK+F7+UA9YLlxZ0X9hO9DzgAimSZ+Aply4CYuxlgHIFsGROLa9KA4CqyA+rnAtH/IvB/Iv4HwL/5wpP4/mgYPzI1OdRsbw81dIFXXy2Up7Zy+hYzWlcecupJAYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d3805a551so2659217241.3;
        Wed, 23 Apr 2025 04:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745408249; x=1746013049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDuaTM9ibNIGOgABq8eZY4S2tIlVdKvchipAQzhVOaM=;
        b=le6f/7Df904/SroYxS3IuE4ZGyVBwgdaJKT+WVpcUORwNV/ky8WVh8hryHLElAOt27
         tRpWZPd7+W/W3mjHAKec/CTTkFvmRtXMiIS6M5XFUBicbWamP5baUiSiBXNaVVReoXM7
         EqKWZ3JaA0ZVMg4ORoUirhSAT1LsZUJo0T2PQZHdYeVTnb/fkauKWp47mOBXBjib12na
         o7aQo5oKx/o86gRwDTzIImmsGsHa35cjNxGfC50LWUsvG43ve32GiqdqqVAHJTES04l9
         TcQqFPE6It351oWPWNACC83nxJKc/UXbXkqAabOuNB3/dXQKHsuws/lF/KT2HTszdtl3
         7n4w==
X-Forwarded-Encrypted: i=1; AJvYcCUDl27DJcHKDrJFbbtjrk2eI6egDJpj9QZLBf50rufUeWO4AhXgdxzN4GxNziEzQm9eFtm5nHHLNkAP6WqaHwjPZ5o=@vger.kernel.org, AJvYcCV8i+S5XPoOG9TWqFAm+RPZpLmobbdnqWv+aj6maBeh3Yf6mt6IIVZYH3YnlqvYqf3TJfvke/X2G4d6MLQk@vger.kernel.org, AJvYcCVfOAOK6JQzHfxB/nxuYypoTKLPhDaj4CV1gbDAH2LFYvn5UOuIs5EvkiheAXewBhELUCf8SMq7zggW@vger.kernel.org, AJvYcCX1KDFh5AV0QfEEVouUAHioCm43t0dIBJRX6fUbE31YwaP2kj6otPavWLI5U524dDgzFp3DPspLg/KN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjr9woYuq/mXKa4a5n9Uzlth9cihmNpCZcqQaxuI8abts2EBI0
	jZtUKnhTg663+y0mZrPFufTwCvrqcE7UTFaV+cnmk6vQcpI+c0GSNidEUaUKkfE=
X-Gm-Gg: ASbGncuHjZI1pBpM9x/URackJBoz8CFbzUvHU5LRLFy+1DE8ZBhtVGSdFPfvVSgZlDE
	8Z9E8chYMIoEmBjVZSYJBur9H6z2IK7y5ePYfaly39hBR7Jixph4e5pUxyT4sEFj0vB3X4LDOUp
	L1UTU3hD2/DDyyI61k/RNqLg99ImKYWTxZEHuFBLsWYCqSR52/9szLWCeX7MB7SsbD3hrDaLQdM
	zdoZY0yqFivzM7fRCpoFSMabbyJVSpKMKiJDEMzXbWNZpA6mSmPcfbgMhmUTSgqSTI6i2VTJP4b
	QlUbAswuqFyAIi1KUTg3qoqDg69P9EoW5ZTkndoORy8974A+zD/zMs0Kse3ZB1S6QjWvKKoppg7
	latI=
X-Google-Smtp-Source: AGHT+IHhfmifE9P37+rg1v5BsnaKS0MXrAvHKGQ27idYcFRc26FFY+/pKYWYsIFHaI1HBYucH6GDpA==
X-Received: by 2002:a05:6102:2259:b0:4c3:64be:5983 with SMTP id ada2fe7eead31-4cb8023ef61mr12389892137.25.1745408249183;
        Wed, 23 Apr 2025 04:37:29 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-877647776b6sm2718858241.26.2025.04.23.04.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 04:37:28 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86fbc8717fcso2382967241.2;
        Wed, 23 Apr 2025 04:37:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHT+BqWU0un8QmQ1x2ICMyoJKW5dWOU6sMy6StSHicNZPd67wb4F2z1otCnS437N561BahYrmEphrP@vger.kernel.org, AJvYcCUf5/e45t9sRUROWltZ48q5pMbiXPxvzUsXC6TGJsdaJ19dqpjzToCe77/6YXK2mMTmlJAVO/jVe3J+@vger.kernel.org, AJvYcCWPM+N3qe7G169BwBzsixI3+L4e0q5DKpXjtAZc1aawsfpSgQiRTDYkCKsuQn0ex+jhDnZRpYq4q/sIyXb6@vger.kernel.org, AJvYcCX0nzmgX8h//ahmFfx1RJURlVzU2VSAJS6RUnSLq0KivDnrgJyltuW36dW0qyPqlnKpYtoFM2uS1+PB3DDyelznBpU=@vger.kernel.org
X-Received: by 2002:a05:6102:27ca:b0:4bb:9b46:3f8a with SMTP id
 ada2fe7eead31-4cb800c1a61mr11696598137.2.1745408248312; Wed, 23 Apr 2025
 04:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422173937.3722875-1-fabrizio.castro.jz@renesas.com> <20250422173937.3722875-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250422173937.3722875-3-fabrizio.castro.jz@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2025 13:37:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUKVDzLUfcr_0R_VQ0TzBtPWGVbwfX_pKbwOjzuaBLcEw@mail.gmail.com>
X-Gm-Features: ATxdqUH9su4W4mn8i54UlLb_HgPMtRPSv1JRSwXDunzWGUFbnDSkwnpEps3CkW0
Message-ID: <CAMuHMdUKVDzLUfcr_0R_VQ0TzBtPWGVbwfX_pKbwOjzuaBLcEw@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Hi Fabrizio,

On Tue, 22 Apr 2025 at 19:40, Fabrizio Castro
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
> v5->v6:
> * Reworked the description of `#dma-cells`.
> * Reworked `renesas,icu` related descriptions.
> * Added `reg:`->`minItems: 2` for `renesas,r7s72100-dmac`.
> * Since the structure of the document remains the same, I have kept
>   the tags I have received. Please let me know if that's not okay.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -80,12 +85,26 @@ properties:
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
> +      It must contain the phandle to the ICU, and the index of the DMAC as seen
> +      from the ICU (e.g. parameter k from register ICU_DMkSELy).

Doesn't really hurt, but this description is identical to the formal
description of the items below.

> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the ICU node.

Phandle

> +          - description:
> +              The number of the DMAC as seen from the ICU, i.e. parameter k from
> +              register ICU_DMkSELy. This may differ from the actual DMAC instance
> +              number.
> +
>  required:
>    - compatible
>    - reg

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

