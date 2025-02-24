Return-Path: <dmaengine+bounces-4569-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE61A41F65
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 13:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CFE1890CBD
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5F5233724;
	Mon, 24 Feb 2025 12:44:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8F9158870;
	Mon, 24 Feb 2025 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401053; cv=none; b=uy3sd22X51VJjXOf3WzLoE0/FNePkOnomAPc9B6NZd07RPfoFcXpnVWZ532fOpAbaZAshxeUOR1djFqkqrN/CacHpw5zf90bh81PUkcqA5+MvuYL8sG21odJNDVzmgVuTX3ma55zx2OPAav4p0kV0Tq7t/FRUJO2fe3rm+wnGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401053; c=relaxed/simple;
	bh=zUibEaqNaWJkz1+FPEIsiT0fEvu7iy7yfzN7V0cnt4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yc/qLp3iVEd2TbpvKY1EQOcG5kAG4bVqoIz9LbLOr+MbJk9pq0IC75lSMqjTuKc7Aj2B6mqgpknDeMl16oBoIHtEXWGQgfJ9wk5IVt3Sr8pHo6PTk4mkPoXO3A3I9B5/l4y1x7h+utWqhWSSSo4wAyHPP/pMC+CnCJgHO2xD688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-520a473d2adso2795660e0c.2;
        Mon, 24 Feb 2025 04:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740401048; x=1741005848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfKRKIWXmuVsvt2Fp1PvbnywriA6811yvZ1y23PVTWo=;
        b=dLW5fYcFp33r5l4JEDUJJSw8lECEOO1k260gZ7fIkboP9TlodkcnBmKhqZVGlTiXaw
         kRr4TqpVxAazMRsXTUdh7CKSFL0SuJkivxv90Bm8UJnlJTAbAE7z57z9TjyBe4yw8xbv
         8hIacQB2rxwSCvukq2h0JkOoZzPPDEcnX5mo+sgXOJTzyJxCo8vaJ1xvsPwyjJb3Dwu7
         EjbVN/TijztLTQyVVXFuQhi262nKiHLnXSI6TXZqo9e8cI439xROleQscZO1Agarq587
         SNUHLMWPJed1olC2ClP3M1NnuDxz4W1NFxvFZsexbCk5WMT5AZGQJCXmi5v8cSLVnBhp
         w1aw==
X-Forwarded-Encrypted: i=1; AJvYcCVBbdT4+ExcnmiOQWrU/VBAtr68zVwPDRdWkyWEmrqdXIpfTzJYKcqTG6NWo8G55NqSKZfa5nQXzX+U@vger.kernel.org, AJvYcCWtXEH/HigNmcaTWOBGhkTiu7L/r7aW5VWbNO327QkzzTgEz/ZTvX2VShOCxYkKlW2qURkr7kJxEecK@vger.kernel.org, AJvYcCXdQV7sC7OVJb8UAzkBClStzsBEi+P5fy5e9ekh3bCp/nG088wglY2K2fr2KVjH/VnKApS7TnFtUkT442gL@vger.kernel.org, AJvYcCXnAP4nd6hf6Me6xrwL9XNPLYTzuUS9wHZD67wZ3htKRITcAaVNFaN6GfCAIYClqgyc45qvZXjySrPETcWPL/DI0P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE7c0GDZicQ3WQNrH1o7/QW7KhRYl2SJhn/otF8gGsv7fLClMs
	BNd6DFlL6lEQq+SmFSwbJXylLoYz7xt08V/inSp0xzTQcvcg5Ezb0M03FZW8n3c=
X-Gm-Gg: ASbGncv1zO4OJoo+ILZVKryVGjAC8CLCj2Xk++kE28j3LjSQ8GpmUuwIS1rKunP5jUF
	cp/Tp8mI+D5sxMuJCO+Sj/viz1tmkXRdnfxSY0dysPJThDg/a7ZFFU6smYy/8XFvQ0pLW1lttx0
	EnbXpyIpIzvPpVRrHFnQg/7gmToo9eiKEjK7Vp0XaEQ/ea34OQH+Mctk6hV9LxE1iqLBn9UmILF
	hQb9kF2zJIkmv6HXVKe1tCom2C2Zbs7Tc1Aqf2w5S8MAxW6FyISsnXRnFlxRgK2dPG5b4oXSzjS
	I80pe3OpWmOn0KuQqvevXrygOCcoXyJ5NQfX09aaXRoTfSxRoecBCDP1E8aUBo5z0h/g
X-Google-Smtp-Source: AGHT+IHwRZmST5ujNiPY8sVjbqeHwaB1rnCTQVyhwmacKrDPFsQvVs1vIx7vAe3rNbzfhYtKTeYFjQ==
X-Received: by 2002:a05:6122:1b84:b0:520:61ee:c821 with SMTP id 71dfb90a1353d-521ee241e4fmr6776100e0c.3.1740401048579;
        Mon, 24 Feb 2025 04:44:08 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52085b489bbsm4442325e0c.42.2025.02.24.04.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 04:44:08 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso3123333e0c.1;
        Mon, 24 Feb 2025 04:44:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQ49YXWw7HUY6ZvIZ8bF9PESfkwbVgN2hjlQd3kj7KxFdFpMfDx3hGaIcq6QfsG+l02hq6np5uOGZ+@vger.kernel.org, AJvYcCVSQRvRgXQYLt1gosD4RCo6d8HA+qTF1agDFq9KxHTkZbmQK2RJrPYta8cGlI9spgDZCg3i4IRrd6efzJP2IvN0OTc=@vger.kernel.org, AJvYcCVmZhgWDd2sZGUmW/fU6RNZ312qNFjE1FtpV7+69Ge+muf3vOHKOiDQdmhTGUf2ktkN34PXaXZ26Z9Y@vger.kernel.org, AJvYcCXciZhcCMwxnJkjTqcusYMH+1q7nGFvPSaqB3lmTvotlNnsF/V01izvD7bGLvcB6g0tp6BI7rPYVjMMIrop@vger.kernel.org
X-Received: by 2002:a05:6102:54a6:b0:4bb:e80b:4731 with SMTP id
 ada2fe7eead31-4bfc023cce0mr6203694137.16.1740401048043; Mon, 24 Feb 2025
 04:44:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com> <20250220150110.738619-4-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250220150110.738619-4-fabrizio.castro.jz@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Feb 2025 13:43:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUjDw923oStxqY+1myEePH9ApHnyd7sH=_4SSCnGMr=sw@mail.gmail.com>
X-Gm-Features: AWEUYZltwujls4aQb_CukANB_WNWYRKY2nodRlJJtmo77HvwChNCoZ7RyAdoUhE
Message-ID: <CAMuHMdUjDw923oStxqY+1myEePH9ApHnyd7sH=_4SSCnGMr=sw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Fabrizio,

On Thu, 20 Feb 2025 at 16:01, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
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

> v1->v2:
> * Removed RZ/V2H DMAC example.
> * Improved the readability of the `if` statement.

Thanks for the update!

> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -61,14 +66,22 @@ properties:
>    '#dma-cells':
>      const: 1
>      description:
> -      The cell specifies the encoded MID/RID values of the DMAC port
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
> +      For the RZ/V2H(P) SoC the cell specifies the REQ NO, the ACK NO, and the
> +      slave channel configuration parameters.
> +      bits[0:9] - Specifies the REQ NO

So REQ_NO is the new name for MID/RID.

> +      bits[10:16] - Specifies the ACK NO

This is a new field.
However, it is not clear to me which value to specify here, and if this
is a hardware property at all, and thus needs to be specified in DT?

> +      bit[17] - Specifies DMA request high enable (HIEN)
> +      bit[18] - Specifies DMA request detection type (LVL)
> +      bits[19:21] - Specifies DMAACK output mode (AM)
> +      bit[22] - Specifies Transfer Mode (TM)

These are the same as on other RZ SoCs.
So wouldn't it be simpler to move ACK NO to the end (iff you need it
in DT), so the rest of the layout stays the same as on other RZ SoCs?

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

