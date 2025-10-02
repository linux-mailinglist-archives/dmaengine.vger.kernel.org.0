Return-Path: <dmaengine+bounces-6743-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7188BB3F92
	for <lists+dmaengine@lfdr.de>; Thu, 02 Oct 2025 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DBC17F53E
	for <lists+dmaengine@lfdr.de>; Thu,  2 Oct 2025 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C863081B7;
	Thu,  2 Oct 2025 13:02:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5F283C93
	for <dmaengine@vger.kernel.org>; Thu,  2 Oct 2025 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410138; cv=none; b=KNFjZhtV+X367rKYP0zxx4le2IlRBLzZygL7qGbDgZSMddHr3Lzjqpr7iGkbJNzOsBClS4vPk74VgV/Sk/9wLIjONYx6wESOIrFMbWKpAIGVIKtEXj9PPaim1y/YG16Zmdi/VDZKDvmVg8JFU1XvaRVHJpbGS4Ac7P9xKSaaAvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410138; c=relaxed/simple;
	bh=UA6tTZXqaCOK2NigC5FAobaKNdJkRhWjZa2mAx2vxXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYfGGKebhHVfL+39Vjp7GdyHaW2sw0xGEOe50YzSiUZRS3h+LqiwODQ3UaBDmTpdIVaeDXR5Qy3NRMazMgPHd64svh1ohYM84/I2113PttDA+D4ZiGvGhje33m+tcXd3cSCVWpiH3khcwn1QbxJWVkd9EyZfb0NB09GmHuYwHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7a9a2b27c44so604588a34.0
        for <dmaengine@vger.kernel.org>; Thu, 02 Oct 2025 06:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759410133; x=1760014933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3dE+UYXSAYSMrP4rWfQs9LXTI5k4tbEHLzxqaY9yVY=;
        b=cXaJ1fEC968T59IOFVVXNS0XDmMiRuoUk6/jy3yU88/DQeo3qQNgwOTg8bA5yoxXnH
         QdTIGrJT9bOhhBbujmSDevDzccXFFdggvE8diV/E+s1ARixbMhypbM0QnMiLld3nIZQk
         /0mS6C1FPAvGw/4+Iveho0PCwxmH6hQlZK2BEddpRzsBTTJxaTjLGotAZQxeQxzSrPDV
         WHtGkeDlbQtj3tTKxE1sy48S4Zxo6bU/z5iCslLGIddPGO3GKbfb79gZaM+eHAZHkRUm
         snowvddFdURrPIv5XPg2vKfUdjPY2QxtifSsOACSIag3T6sY5ONMUKnBjNN6cnkK8ZpQ
         fSFA==
X-Forwarded-Encrypted: i=1; AJvYcCXqs7pNLon48efIhLywCrRlbukb5KeRMsX6xoz58kpyF2czFJEeso8oksYFhJPpB48rSha72Iw595o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1zb+Kl8Y+rzM/jAjvX2pZK2OV+2k146Lf3U1vLmpevzfoOGQ
	5lU5DmKE5uuBTXzHuKwfqCxwJ73BgHC7QZWPcyfOoAZwCT0JFMfkEgqkPohqmng5gR4=
X-Gm-Gg: ASbGncsjhXzClTOj2JKdKuiR2tetoAFesn2MPQVzbhm4KYMWOKbG/EG7KTEoL5189yQ
	4uQlp1tYgi3B9by2Wm57UQauac7akOd0/NHZ7iwIAgxWUXxMeJ8Y1jBF2+FzNCPELLGZLJM833W
	v+XmCPFfCrQ7UZNj1/gCuH+QrwVE8kbz+DP3nDOnzeWPCNcww2/jyQhX5jQ/eirw3Odw+kmY+Tj
	o8dixIx067NhXS5Vx4gtRs5oFohgrzwgeIZGeeZnJZUq9liv6/LFPYZChqDBwaClTUJNP+D9Hur
	34PGqufGKWF7gSuH8SboSYlIoRYMDVvSi2qoIrs3uDSdCXJV8G9oUGb9fAX2uYreiLW+ORrMNfX
	091An9grN3xnvzGrT6V4hpYE06zPipCIVAUqckIAf3syIaCzC6ZVb/yiJoIiEbY6MA9lr8buBmi
	8lDNsdSEPhDB61ml0iL973QFE=
X-Google-Smtp-Source: AGHT+IGNWuw4hq/ftA5a2GuIjAf5Ndq3Nmwgvoqk3rDvvTB7BbKi+ssiBKqg+/dWdAnSL1UfzhZaMg==
X-Received: by 2002:a05:6830:d0e:b0:756:f259:2d42 with SMTP id 46e09a7af769-7bf2c763319mr2377655a34.12.1759410133117;
        Thu, 02 Oct 2025 06:02:13 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf435eddc0sm617869a34.28.2025.10.02.06.02.12
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 06:02:12 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-43f9eb204baso1247980b6e.0
        for <dmaengine@vger.kernel.org>; Thu, 02 Oct 2025 06:02:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUN0ArGMTP7D8BpCIz6dJ1bv+O8Pr6JQjdjgEBTZvMYj2juJkpmrLbjH4GXnT2zKoKXRCtoxwINc+4=@vger.kernel.org
X-Received: by 2002:a05:6122:e017:10b0:54a:76f6:99e6 with SMTP id
 71dfb90a1353d-5523c01a219mr1048867e0c.2.1759409829773; Thu, 02 Oct 2025
 05:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002124735.149042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251002124735.149042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:56:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXA0fWwO_5bBud5FE-Kwp-7zU_rb9rVPcuZojaNJT=tkA@mail.gmail.com>
X-Gm-Features: AS18NWCCYsMv_0f38WPVlVfiPUyz1ABU_-4NHROasZoc_Eb-IAFzQ63J2o9bB7g
Message-ID: <CAMuHMdXA0fWwO_5bBud5FE-Kwp-7zU_rb9rVPcuZojaNJT=tkA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: Kconfig: Drop ARCH_R7S72100/ARCH_RZG2L dependency
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 14:47, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ DMA controller is used across multiple Renesas SoCs, not only
> RZ/A1 (R7S72100) and RZ/G2L. Limiting the build to these SoCs prevents
> enabling the driver on newer platforms such as RZ/V2H(P) and RZ/V2N.
>
> Replace the ARCH_R7S72100 || ARCH_RZG2L dependency with ARCH_RENESAS so
> the driver can be built for all Renesas SoCs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

