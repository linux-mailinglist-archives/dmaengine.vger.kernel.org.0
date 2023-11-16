Return-Path: <dmaengine+bounces-117-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB907EE28B
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 15:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB8B209A4
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 14:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E20131A73;
	Thu, 16 Nov 2023 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1FED55;
	Thu, 16 Nov 2023 06:16:45 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a82f176860so9418057b3.1;
        Thu, 16 Nov 2023 06:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700144205; x=1700749005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibmdabV7l5XTVe2k8R3JzSdJeiOB1me2z9/gej+1Tto=;
        b=GJ4gMj/gchRjIry1gEBriVfGP/xzWg2Jcy8BXbe/sB17IApoxwJcu5VdDbZEJHK5Lx
         haSCsyWS69LukKGux0pVAfrOD6gH8oB+zSkRtHyP5VbB9RV/76/T6Zyi36/hdfIf9Xiv
         8kCXiMlk1cI97Ufm+2LrWQGtEzpZ84uRnrnS1XnHNZHjURDjE4JV2M/KKLo0GypwUk4i
         cfSSLQWSD8GwAqRUnAPLpmg13egVlo8IsfJcTDSxd95d9xIWfCeSFfRJofhJLKgLM7SP
         I8TvO2F3Iv1fD8z5Ql4Mf1xcg3qqZ2EAmlAIQYHz4/pW2oV5XUMkrkz+sr+gPzojdmpX
         byuA==
X-Gm-Message-State: AOJu0YxbXptc61/KiUuUT1SiCGtzWd1HRp3rW09s+m7lv3hZCqXzK3JL
	ZtB+YoWrWmYQjVcTJ9mpaPFLGfVyaOZnSQ==
X-Google-Smtp-Source: AGHT+IHbcX04PGYeaUhKqhleU5CNVn4S+x2ZzvU6qX6U22YHkpdciZkxtyf3/SpSCmh/NUkh0c0MYw==
X-Received: by 2002:a0d:e3c1:0:b0:5a8:60ad:39a4 with SMTP id m184-20020a0de3c1000000b005a860ad39a4mr17955067ywe.3.1700144204813;
        Thu, 16 Nov 2023 06:16:44 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id w190-20020a0dedc7000000b005a7d9fca87dsm999245ywe.107.2023.11.16.06.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:16:44 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5b31c5143a0so9283847b3.3;
        Thu, 16 Nov 2023 06:16:44 -0800 (PST)
X-Received: by 2002:a81:49d8:0:b0:5a8:5079:422 with SMTP id
 w207-20020a8149d8000000b005a850790422mr16462532ywa.26.1700144204289; Thu, 16
 Nov 2023 06:16:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Nov 2023 15:16:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVmoknQLnkMmi-pGVjz5osE8Vx_TQy3OXH3GUfYbtDwMw@mail.gmail.com>
Message-ID: <CAMuHMdVmoknQLnkMmi-pGVjz5osE8Vx_TQy3OXH3GUfYbtDwMw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/Five SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 9:39=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.co=
m> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The DMAC block on the RZ/Five SoC is identical to one found on the RZ/G2U=
L
> SoC. "renesas,r9a07g043-dmac" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
>
> No driver changes are required as generic compatible string
> "renesas,rz-dmac" will be used as a fallback on RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>


Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

