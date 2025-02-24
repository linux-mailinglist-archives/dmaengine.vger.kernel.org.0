Return-Path: <dmaengine+bounces-4570-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA3A41FCC
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 14:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D93189766F
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75888233736;
	Mon, 24 Feb 2025 13:01:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871023BD1F;
	Mon, 24 Feb 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402071; cv=none; b=d/B/sCtgQga+Gy2KCusPPfyg8SI5Rw/uWwKvbBAET9gu3vmZojl2+f9qvRCGUu4ZMXJ6zQGVBV1ZPNGu22csGSlBrMHKejhQNfEQ2qmg6nvnoDj2xNl00/GKlky3/D4Zx+J/RuSB5aChUOxiLHtFN8lcUZWBfnDKkt4MHBtVbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402071; c=relaxed/simple;
	bh=NOAJsfh5icgwgKXiJMVgBnNtMztUxOn5pcYE/dwnIEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q82pLNW9zcPVcn4V5psfLdgQCN+2JlFyWSx24qYjccEciiQcEcnHcDkS331saY3uiEEBm+8ODnYRP36CCLGNlXu0H2ySJom7trPsw5LyUxEvBm/irZMjJUu3l/se4hAm3GYKx0sHlNXLD70cxBPi3RUFjDdLCj4xdPe+NeKshzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-520b9dc56afso981347e0c.1;
        Mon, 24 Feb 2025 05:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402067; x=1741006867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4rZJEuJFkjBnapPharVO2d6QdwuKllTCeKoTcUZ8vk=;
        b=U1xc+BY9w79mgQl5e894oiu+CN2UnZX2WIGID4oo4mfZiIpItN9LiZhxdnIQ5AY/h8
         Za6rQ/ye3R3jzsvJYgLxa2T6RI7SBZe7I+2OxpjJXXLiReHn1Aswp4Wp7uMfqWOiE+pq
         BM52Rr9sIqAGDZIJFaU+LGGoE8bxMQnX0VFHtCaIKtoJ1jkHk2wZDU+ObgUWqMAqVOIx
         D9s0CjXQ1N3xNA7Ysxc9/opr4VZkBzY6LwYTegDe3dhymhiL3wtXzJ1OHKbY9KHXRInj
         cI8QuT5tmKH55PuWvvnjwj5whgC1FuedDjioNcHrOG4NflA90GBmjPNzz1WNsg0KQhGP
         E5tA==
X-Forwarded-Encrypted: i=1; AJvYcCVLs0HV1YNmyaQwWMYGP/lURJkGfb28ssmC2VyC9L/RjLJjlnjI8SzSv09sIwTOWtZizEsJX/9xoBE=@vger.kernel.org, AJvYcCVMK3hnxxHt75K+gxyzTueN3fKRT7N8o87uq5YQPGbGJcjQthhlgBd63toV4cfwZhM7Sq8PmAXrHVXFqbP6iFlHWvY=@vger.kernel.org, AJvYcCVfFOkd2ueZwaRAoKy6sQqBREi3KgOIsE+EVNrXYkGOf6xgaLBDtJbk+e8xx5IsY/YWwdq2q/wrYBpEvP/7@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvfXE7FIZxDuGU3JC0rEMAGJcDArBhmUxsm4tarWBPF3aD9WN
	tUNurcs0pWfHRLRfoRBSJ2sN96nkQa9PK70luqhDVDkrhGGPkmEVt7P44IJc5Mw=
X-Gm-Gg: ASbGnctDYySdKDYde15Nsh9if8kQ8mDoIcXatFa48dK2aPLCB+V/0v40epcXtPL1A1Z
	6zcOlUQj1orcDktvRYlfxViEKGLiM8x2q90fAglQwutXtc5/3DsSgmPcgnlio1GuvXq5phpG059
	NkcFJwAhvntIlzea2rjjQ9aRRfqbIGKerCHnwBERqQj1Ldpn4AL8C9xXTY+B8Mh5VvzYQTfY0+C
	DgqsYMYec/NME7+9/dD+IPpCMGi3TP53D/MZgjLKdX+k8TLc63LPTYswNT/x3ksLSIr8k7eRA5f
	7eimGlUknu+8J/NXjxd9DewZShLSrxCO/xjhkwvXiDRlGBEx4biVCAvzoNBTYE1pBGnB
X-Google-Smtp-Source: AGHT+IFOiN+GJppSZE/vlUsd+jrI1fqRUidNxgYYFWB+GG+98Rzs92lJcPAk6j0RhZF1vY09aOvdTg==
X-Received: by 2002:a05:6122:2a15:b0:520:42d3:91d2 with SMTP id 71dfb90a1353d-521ee1d78f9mr4467671e0c.1.1740402067323;
        Mon, 24 Feb 2025 05:01:07 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e858066csm4527916241.9.2025.02.24.05.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 05:01:07 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-520b9dc56afso981330e0c.1;
        Mon, 24 Feb 2025 05:01:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnzpgsEDYRzuKztaxIUJA5Dtfq0n3Ozn0s12JhYukOAmQUd2NqlxfYOmHfYbZiljs4QPPUjmr4erc=@vger.kernel.org, AJvYcCVOgyQuP0s64kCiovZG9f8F4TSx5Pf5eRu61eStGzzjQKK1ASPYZ1B2ABZva5k4u+e35o9+kbsDdwTMIioQ@vger.kernel.org, AJvYcCW4TVq69DMpn11CUwpDa+GMyEWHl4wz20XrSs2eO6jg4A0FGXeAVM+flii+e0ew96H+4d9bUCBTmPMYR4sMW8gJxMg=@vger.kernel.org
X-Received: by 2002:a05:6122:488d:b0:520:60c2:408 with SMTP id
 71dfb90a1353d-521edfa7d21mr5631428e0c.0.1740402066850; Mon, 24 Feb 2025
 05:01:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com> <20250220150110.738619-6-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250220150110.738619-6-fabrizio.castro.jz@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Feb 2025 14:00:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVmR60=jUZvzNuAe66KGYS+1iqO-kG9hgPHQ_RXh+YPQg@mail.gmail.com>
X-Gm-Features: AWEUYZm7vP0zaB2nnHZciI3f1st_GeQzRBlEe7EbHxPRSzu4KkkQhDNFRH7HpP0
Message-ID: <CAMuHMdVmR60=jUZvzNuAe66KGYS+1iqO-kG9hgPHQ_RXh+YPQg@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] dmaengine: sh: rz-dmac: Allow for multiple DMACs
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 16:01, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> dma_request_channel() calls into __dma_request_channel() with
> NULL as value for np, which won't allow for the selection of the
> correct DMAC when multiple DMACs are available.
>
> Switch to using __dma_request_channel() directly so that we can
> choose the desired DMA for the channel. This is in preparation
> of adding DMAC support for the Renesas RZ/V2H(P) and similar SoCs.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

