Return-Path: <dmaengine+bounces-7360-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B320C89817
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 12:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26C6F342DF3
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B031ED81;
	Wed, 26 Nov 2025 11:26:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB32DE6FC
	for <dmaengine@vger.kernel.org>; Wed, 26 Nov 2025 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156402; cv=none; b=s7pUsAKTALEnp/MLazV1r8XB9oSgm1D+RHE2+kSH64m0BL6IWhhHSFKPC6NWiT6v6BwBnJQTZXD+tqBv+DtlEh6w3HvcachyeTtaiEIcmipyAwOREOli1RkmSO87/qrfRJz6wR8HdTBLSTAJgd6J02hjeuVZ392fzkcTGeesGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156402; c=relaxed/simple;
	bh=A/WTa594oqG70VFSxqpmEoPIo3eFhE3MtTwKAo9KLsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvbovH07xBJYAr2OytzaHUDq/C6zISoo073b27cnrZWE1jlyy/C9jQAP47KZ1XhNN8Yq/FIEu5xqjfvGmT9yuLbKC+9CvYIYUIdRF6S3HvNXB6diMYvMrtgmKQMByguVzpptqLPDkYn8FYGnpkZsJ2fv0FjkcXpqJAJNKpkcxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dd88eef2f3so2274012137.3
        for <dmaengine@vger.kernel.org>; Wed, 26 Nov 2025 03:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764156399; x=1764761199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtesYd0ebHqf3bGA+srPWLjam08hRq4/xzS8ygcZKPY=;
        b=fhLx4WFDVmETlzo+epyx7PCvjmWOY7TZN4O4DU2cq85yaMvR7x7/3MTAtJPBBfnD7O
         wa+TF0iBjlPzUoq1LADsrq89W5V4soqKT24T6jZqp0EmPTNIi6N5qIzVZMOviCuQZTcH
         gTow02Z544+0aNKfXAVWNjoZ3bT0bcTISra2t+ULHdOuQv6fXe1kkzCENa1EliDh10S6
         itZjFBzTcXVA1i1bRhV7eTdFMrN0OdoqUb67lkWut/yno/YASYTRRY9Npr551TcSKH5s
         gwcnL7vtZ+ZVWDcq5/qUBbBRxI6hfB996rC3Xdrm+zVbbQ0I4jEQCatOuWdDYskC4XDJ
         6Wyg==
X-Forwarded-Encrypted: i=1; AJvYcCUbPZ23SDPhQEEwr3spF0QLZE+teQ81fKKbNnDQ9MPHxY+4ZeLZ3IUG+JpCA/imADp6JTjt64JkdDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgL3E62dZuMFMLbXnVmYHgt1hSQt3P+iPCddkd3GqMhx3GFXXE
	wSyL6KaKd3YLfQt4m+p7jx0QlsI1R4BUCnECp652y8XeLaFovfv+sZ2Db4WHMm2w
X-Gm-Gg: ASbGncvzkGsB45zmNhmUXs+yurG0f7/ido7dKSHvU+HBOa44H6UhVQVVLet0UJxyvgu
	G4OFLnq3KV5Y+/rnjESE6kSiOdtsH3jm4UFfU+xPWrXa2j18zvmCqVJ0GSmAIijfvmF2ss4rNz1
	gtfittuUSWOwgaaxho25f/Y/6TXbynGJquHDWbIY83oPmu7VtnJU6yKXuDUXpSAitotXS21/QE7
	dNMJwcTj2MhV5+XuKkx6ddAKP3jeP+OcH71VZSqHNTGaz7ZhMj6zpKCHBuwJTF7A866n4cf0R+S
	30z+rcC5vM2DPE/+UTkdaR0D2GKLcIaSOM1m2rcXeNEiWzfSXC6S6tZRiVM+DxZc6I+Je0fHNqK
	OrvVRQQR9D/J9DW0eK3cQYyJtikMaByO3WqJ5Vt2d6psqJDYeRqVFyhc1WG1HRK5+i1R6reU6rM
	k0vFU21NF+459ZAKQTDuXY/LwjRgDF3nokjj6TGb9MtnozL5TxvqhQtUr1/oA=
X-Google-Smtp-Source: AGHT+IEDrIAxJQ1YpF+dIjUWKkHIDueS4nFInMxBagLsMEyXz7RTSQ8vQTEvmOzFyffuXwQJZrUeIg==
X-Received: by 2002:a05:6102:5984:b0:5db:e909:aa0d with SMTP id ada2fe7eead31-5e1de441af7mr6235116137.37.1764156399446;
        Wed, 26 Nov 2025 03:26:39 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c564c7dd3sm8021798241.9.2025.11.26.03.26.37
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 03:26:37 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9352980a4f2so1932098241.2
        for <dmaengine@vger.kernel.org>; Wed, 26 Nov 2025 03:26:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTY3jvUBkEmONUlNhI1JdNtftHXpjGxBIfVYY1dLDykChclCf4x5DE8FQt0RUJ1Sjz7fH41AFGMpw=@vger.kernel.org
X-Received: by 2002:a05:6102:5805:b0:5db:fb4c:3a89 with SMTP id
 ada2fe7eead31-5e1de25fdc1mr6714449137.19.1764156397436; Wed, 26 Nov 2025
 03:26:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125212621.267397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251125212621.267397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Nov 2025 12:26:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXEi+omKdRDx7qPCWmpssg09Yc_5MQjj+SDhhCcjL3Zew@mail.gmail.com>
X-Gm-Features: AWmQ_blz9vjpWn4fvUTyaqQkhCGAbdGKR4rE9qC99IBsh-eudnLwfjzrIWdxkZA
Message-ID: <CAMuHMdXEi+omKdRDx7qPCWmpssg09Yc_5MQjj+SDhhCcjL3Zew@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/V2N SoC support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 at 22:26, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document the DMA controller on the Renesas RZ/V2N SoC, which is
> architecturally identical to the DMAC found on the RZ/V2H(P) SoC.
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

