Return-Path: <dmaengine+bounces-4900-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8716DA89E4E
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 14:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04691902204
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 12:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30A51FF1B0;
	Tue, 15 Apr 2025 12:39:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6022F01;
	Tue, 15 Apr 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720763; cv=none; b=JvB5aXFOke9m96+aKPJ+7PBdCm2qrYH5DVCN/JAQHFWv74O9ZFzlp7stTIi//gQQv1X4o2EPfB2flPAkQtpoEcNDnh4aZ4d3xEg2qKnORgUhoeElmBw8z2kABm8M4cWaazldkDv7e3pTFGk4QhXRg5XOFf2tcqDlGTNQOwDJnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720763; c=relaxed/simple;
	bh=yQ1UtJRnybgfKFu1lbiywS8+z9O8a+HPbwUWAZqD9Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEOgebOtZZ+dQ6qlEHbkkYEP4FueyhmtWzc8PGOIBEWxLMeYHlF0Afh0ZsmnVouBfCfmSxAqfhdNEU/a2M17hhpyfe9x4u87SldTJD2Rv1tvskvIKpMEZgT5gWK3LeVC2v5tSmjqDxSDT85LD4PdLr1JW1Wth2MoRS2hqNYNhAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4c32190386eso295535137.1;
        Tue, 15 Apr 2025 05:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744720759; x=1745325559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CljMwcmhWhPYHMXEqE3O9FpJH7LvXojW22x3A73BLzM=;
        b=uwYZTu1NGkBlFGJnWMZmvp6WlIUj95AKdM98qoULOAB2ctnJYmDpxBgvuQeZGND8L3
         1czL20F/USQYEhXLTF1tr0ZXqP249+e/P76Leap3u/e0I6MPw4R+JL19FVg7rZUDmdDr
         yt2eIetn6/mkOvNyC3v7M8hd9yGiz2T/7XyzO9ywDCNihC1A8Ebcp4CpKDavKJ1XEboW
         fXluPsDGROUoJUdgJwfJvRLfj8xi1gOa6m2KuaN5f9GlsgdZgQbVQr+kPehUOfW+pfxG
         pnpMgJeTJyNRSQDNrPCbrdTMGYO5OPOvy9hwgXEmLHfsZ7hiGX/1W+rCbyGYNiK7ts60
         OkbA==
X-Forwarded-Encrypted: i=1; AJvYcCVQBrlOIG356P9zknuMA1RiETmfll+1HZgeU/2O62eE+Cpi/mSagpZRv+34J5qgIuy2f5CD6Ojf/Oc=@vger.kernel.org, AJvYcCVf1vUTYGacDT2kFXUVom6C1yXw1c0kHIOnPgerglyUClHu0Js4tZFkIEz3MoBWPoxMAR20pGPNVvSd3jeW@vger.kernel.org, AJvYcCXuC/e4VYDhFevpMVDEgvoDjtraeJaDBxEzFi36OxmUFw+LYzCGnyoFJmzMnDMFKrIHNp1tP029R21/9rPqOihDn8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Gheyk+epJrmkfKPcLqBKl05yQEYbubu0QXGho6ulvbjV4dt/
	uIJpmAQh/Ckn44K1IkX9IRNwWLxOujuemhxJKTze4ZjJcwzxmoz4755YvrAk
X-Gm-Gg: ASbGncvwCkifJoUDHPzuC6q9SV5YQCLt2Mnnamuuj95TfxaNCMkEBfTY8sCUxH/+/vP
	4/NWBzpmvCUCgVVPCJNXOfoqMmMK2q0GcmvUHi9qH/elNJo1y0D58/D7CbIeQ85r7S46ZPpMns0
	bEWgBR8yypA+WHZkg8H4IjnkzvH43keUl+vFcJ4VPQhz+a0QSFBzDv2cwwgsQl9V7s5NMguhgen
	D/+MFnVg0JaKFaZrMCDWZjkiI3A25RUtsZUBiwCy14mqSqwY/uT98Hv6aGQ5BueensYYGA2poLN
	07tSoYVsDuT6trTgP5DSy2x4Y13M6CKodFQhPe+eHYqfLN2leg4m4RGns+0L20xD67jVI5gUsbB
	GrIk=
X-Google-Smtp-Source: AGHT+IG01/OJU8PvNtPf3a5+lWVVQjuSFrm8iJsWuZtp2z8/7LnZCQEd7041C1maQQX66N4RzueLmw==
X-Received: by 2002:a05:6102:5794:b0:4c2:ff6c:6043 with SMTP id ada2fe7eead31-4cb429eef20mr2163336137.0.1744720758938;
        Tue, 15 Apr 2025 05:39:18 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c9738083sm2624572137.4.2025.04.15.05.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 05:39:18 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so633363241.1;
        Tue, 15 Apr 2025 05:39:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcmP782F8WS0nc3oTR2tA52auvt1bw7hqe6R5/iaP0xVKOznfS/pFmk5ATBjiObilS9cQ/Ew3xE+c=@vger.kernel.org, AJvYcCXBinYofVDhCJ1w9BNRCmMV9rXJctDzJj7nfWgrtrEaB9OnrxR59ZLkvL6e8XgVmAhptokOYOjyYDfD4WBv@vger.kernel.org, AJvYcCXhWC4qpZLyfXsVHCm+WhutS0hokQrmCcvgg8jkxByXETvFU/B6k/ZzM7V3XsfE3UZTd75BnyG7jQ0MsSWhLD8OHls=@vger.kernel.org
X-Received: by 2002:a05:6102:8007:b0:4c2:fccb:a647 with SMTP id
 ada2fe7eead31-4cb42d4813cmr2476627137.5.1744720758022; Tue, 15 Apr 2025
 05:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com> <20250305002112.5289-6-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250305002112.5289-6-fabrizio.castro.jz@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Apr 2025 14:39:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXTnuMf-RryuKgLfSUPxrZ9uBzQE9R9hDzLaM473WQQyQ@mail.gmail.com>
X-Gm-Features: ATxdqUGBdUlLRT6Eh2ITmZMz_m8C31FbsLC4WyTipZXXWWUeaE5uxWGqxfq8dlw
Message-ID: <CAMuHMdXTnuMf-RryuKgLfSUPxrZ9uBzQE9R9hDzLaM473WQQyQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 01:21, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is
> similar to the version found on the Renesas RZ/G2L family of
> SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ No
> * It is connected to the Interrupt Control Unit (ICU)
> * On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5
>
> Add specific support for the Renesas RZ/V2H(P) family of SoC by
> tackling the aforementioned differences.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v4->v5:
> * Reused RZ/G2L cell specification (with REQ No in place of MID/RID).
> * Dropped ACK No.
> * Removed mid_rid/req_no/ack_no union and reused mid_rid for REQ No.
> * Other small improvements.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

