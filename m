Return-Path: <dmaengine+bounces-7889-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF095CD9784
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9ECD2300BFDA
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05963314B4;
	Tue, 23 Dec 2025 13:41:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B311531C8
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497301; cv=none; b=n1ubCDRqO/n7/g68/+9jDKwoW0Cg0496QVG5FU0nVquI4G5EbW0K/UyWbWTtJQjYwOu5K+p1drwWVPoVLcDehhuTjq2TkgyNohkZKXFyjnynHUixn07nWVnqaOjwkqLq28CfNrq7gBzTwx6oj06rsmDzYM7IP9l3r+vYJVWpago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497301; c=relaxed/simple;
	bh=d+EZghonelPXBgUA78BQ/tWJ6ckYSNKpR9OnMalTYvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEi3sPAu2SpMo26ir5xjRYggwqLc10wRxLPOyObAem8M8aFSl7cxkhnxXipJFMpAZNxZFaQR2ghxrp1YWzjvatihBHaNBzmA/Kw0uUUmSlHJ7buTmpfxrdOQE/zL4ot1qsf0nW59RuRCTWCxuyr3rjCIJTasKAiWbg66eR0+R0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-455af5758fdso3361191b6e.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497299; x=1767102099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2q1TCGysZZkk+GHmS8vt4l47rdLT3znEaGV/tAdcUUc=;
        b=ECV/7HvTJhX+6GoT4WC8qVextR+pO3wJfjkqayEUb9r4P0oWAq31b1kG+udbe+TMzn
         58BoFnQvdCQRkLej4K0ukBc8aMoOu1YIRcy8FG6glQ88IgBORmsXdYykH1wJWU5qPLra
         nwgWCoef4UI1IxkELly0x59rSdUNpcItuk70AubAsNNEbkxTuavcRdGW98txIdg8IFUN
         yN5/48sV1H7veH4Km2qThxceN28FpiisREcYGrElkHHEXcmHW4XnydfqWtGtl2Vo1T5T
         Vmde82zkqRsRMhywCLnCm1c4Nzny4HhaFejHmP/r8ZxFY9QLlxeaRh/TOKRcNHD2+AI2
         LLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+j1GKvvt+AZRmXAmSfEkHcHdZPQ8HGdesSZo75q4rbrY7dlJxquWglPFA1BUn8Zbbe6YJkdSg5Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQRHj8ro4b2Eeb3cztOOaXEZw6mt870pPjBP37NfIM1yFC+Nm
	1F89cC/OxTW/c7nSSH280KjYHplECHs4Ym7vgWhIrlYG2Kz1OGdBHosgZ34vqlBH
X-Gm-Gg: AY/fxX6gdiuW3R6ycZe//V7hHBQnps1Uhz9szQTSrkfgSMcx8JeO9KKPJv7voaqJmZH
	3p3gCk1UANVLEgwzuWIIstFvWx66lPheIZ3I4ixtr/hAWxlYEEy5yzCphmq7f4kJNcPWQuNkhsd
	EtobsyaTvts1z9ETai1fo343LvUQmuQHH1vXqJp6X3bt0mzXpS4SrIjHah+B7RMK+VtrM98msC9
	yWLnimAPxp6XA77xjNskMuzf/PP1c7g6A1Vj9m3SgHDvE9quvlYmvRr5q/PJEJdy/QVA3f3zG9c
	9Rzf2W7KfJrMijFoDcVHOh4iyqarYDWkwhNg3EhaB0t4kjOvGkTSM60LsYogybWY1TiE4x3qjUN
	xorWON7Om06gYVSfH9ueVB/yIQaF+8E0Cx5OVHphdOJDs3GOEI33vRAksRqjLyXVj5kCs6bpErH
	4+P4dHHJhw0YDlrE8CrAmHqQ32f+IhlCpGRYjdbKfjTQYbsMzKQCxX
X-Google-Smtp-Source: AGHT+IFvrSAyWXHFvACgHngBszMALO/J3y3kBT8RXZI4yJi6Hm2c8o2NTjk1TwWGYcyPT0BB1iEBQQ==
X-Received: by 2002:a05:6808:c1b2:b0:43c:afd4:646d with SMTP id 5614622812f47-457b20eb656mr6552307b6e.14.1766497299046;
        Tue, 23 Dec 2025 05:41:39 -0800 (PST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667ebea3sm9370337a34.22.2025.12.23.05.41.38
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 05:41:38 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-450823a7776so3149878b6e.2
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:41:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHU4QPSXpzBUv9JZsJSd03hbB0VXab1Ib8t8GdmdPDF74JlPTuUgzaQiSDomiCbdCupRKbhmmKhvk=@vger.kernel.org
X-Received: by 2002:a05:6102:c07:b0:5db:f573:a2c with SMTP id
 ada2fe7eead31-5eb1a67d804mr4132076137.13.1766496825417; Tue, 23 Dec 2025
 05:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251201124911.572395-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251201124911.572395-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 14:33:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW8WK9EXjJ8bkUV_f3OgG2wv+QWgPQi-rPLFh7qcxjptw@mail.gmail.com>
X-Gm-Features: AQt7F2oA8sVMWIIIOjyLh788W_awCND3GcqvNsIMfjLaN-ARF4rTf9K4TdiA6zg
Message-ID: <CAMuHMdW8WK9EXjJ8bkUV_f3OgG2wv+QWgPQi-rPLFh7qcxjptw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dmaengine: sh: rz_dmac: make error interrupt optional
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Johan Hovold <johan@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Dec 2025 at 13:50, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs do not have
> an error interrupt for the DMACs, and the current driver implementation
> does not make much use of it.
>
> To prepare for adding support for these SoCs, do not error out if the
> error interrupt is missing.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

