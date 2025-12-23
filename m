Return-Path: <dmaengine+bounces-7901-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABE5CD9847
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88DE4304ED8D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647C52BE7BB;
	Tue, 23 Dec 2025 13:52:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF662BCF43
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497957; cv=none; b=ZkEzhGCLs2a2UXDMggEF6QzMiCeszrBMyhOLEWmf4yOnjZESeRvSekcBv7e/o1lJ4lGecyEnKGNGOQO3oiYUoWUOb5pT80I1HjrNgycJUPNcFUk0POQ0KuGehSk9ds7jxULTt1RjQxKZ88Z/DOwAvOGhTJSKBXtYMa2kpp5Dvfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497957; c=relaxed/simple;
	bh=HEgGdhmdotY8pA3QPNPd/lQh91weDglMrwRgI5eq5nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1OJ/P/CwJ0XAokPIkjhMFOj3dRAD7BxjU/wJZmWpkdhponSnsEtiMMwD+ORhBKQFHl1reDjj+oW/byvyhFRcr2l4mK5FYudLHZERhMT+q9hziDn7NhEJRVQu/1wQi1yGngQ4zFwrB2hUz2gD7eydpNKtHvoURoVKh29n81lnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b76b5afdf04so733478766b.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497953; x=1767102753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qC2xhS+OSrcNsNoLm9/J2+cVx6ikhb0ktmaIYIIBhdU=;
        b=ZXbGSP2LjAtE//Qbc6vfQ/c9mqgngydNJxIOTcAO4lX20oxk566JvFKmM+7FShLBSt
         LRwr88xspjCDFCukHKsz8zQYdn8MHkga/MvWlrTTj48k0pEMPgFlACX9uyXhZJchz7Me
         z/AH7JaTid9NPXqvm466TfxcpDxPUfijNdnZDDDYcOcPnol1FQm07+c5HNF0O+xF2sw3
         13cvkxB/w1+G8u+BzyDFg+L1PAn2wt5+gtfgJNTWKuuDoE6sDWGNNXsMU+WoDGbS4AWn
         k+qznzjnD1Bo4vzLCKm5fr7VySNspGBRHhguTTaoZZ85sJDDNoUOKysPsu22r2nJX4an
         s4lA==
X-Forwarded-Encrypted: i=1; AJvYcCXbLrvBqCZbSqIe3erOj/IZHz6zP2K8tjrDL6KbnMFiAbEmC5jrNygkujcwo++QiqbJ7SMGt7Mf6/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQPxsus3/IBDPMvQrdTwrWOpNaJQ+Wjr6f8wc4cjyqVqQM6wQE
	zhyC+u2k0gvkV0BMyYkxQo55YBDKM4bwrXtP1WI/fT9qAz7zgwy7olLNNCfs9xoueC8=
X-Gm-Gg: AY/fxX4w66sY/W+EK35AE1WURPzlq70Mqv5MP1bEGaKKU+s4JrKx8v/uOast1FKSzyP
	rDhJHyQsiNLngfMr8pUicpAKvav+//EAyS+NAoJb9yl8lSxSopnMcrJp/R2joxdO0+hMLLYj9+7
	Fc5DcjESKpy6ND8/NYC3JwbzM3wekrXMSwhfrQeuipYYMfgBSQFdTT7cxTaC18PhqwK3J5EAcY5
	VeEbQmkTm2UM/x14suvAgrn9vnxkNp8PJZGSL8RZaU+wy15AhsTd+8U5QVc629mSfvXHtyhCTae
	eYOQ5tMgy4k3zRduwZTMdTBZfVYd4GgrhqxgHqPGegcMiOMnVnqYGtHp1az0WXi/PRrpt/mGToB
	+3vcD3yAPZV1jymtcmVbY7kcp6L3hDWMeV1XDlWH8/IoTQ/mlIAwC+tpO6aMJ1X+Xr67p+dC4pb
	vDrP2pr+YqnUiN+MWCmqTNnxdupJYIfiPNBFJhYKlRTQFDnMT+
X-Google-Smtp-Source: AGHT+IF8i0i+a30tPlfijYAyN314/Tt7mB7/XLMD7w2plErj+aaYRv7Yi5Y5y05Tx/WLKQAjSQskqA==
X-Received: by 2002:a17:907:1c01:b0:b7d:22b1:2145 with SMTP id a640c23a62f3a-b8036f2a9f9mr1430381966b.23.1766497953383;
        Tue, 23 Dec 2025 05:52:33 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53c70sm13786490a12.6.2025.12.23.05.52.29
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 05:52:29 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so6100340a12.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:52:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlKgNjdSz00bXrf5ez+TWKnS6uiUBxn1XzS0kYVvg76uY06xpH9KN/fTXN8iZIrPX3/hvFggcBaZI=@vger.kernel.org
X-Received: by 2002:a05:6402:1474:b0:64b:588b:4375 with SMTP id
 4fb4d7f45d1cf-64b8eb62574mr14209973a12.2.1766497949108; Tue, 23 Dec 2025
 05:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251201124911.572395-6-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251201124911.572395-6-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 14:52:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWOC1Zzvd_sbSfBVUMTVwA9NWy3-4ziP=ePxppsbMwRZQ@mail.gmail.com>
X-Gm-Features: AQt7F2qacHBfJ6E_bDNJY66lCMzd1HRJB8iFpiFIGp6HnGDNM9Z8L7u2p_OLyUI
Message-ID: <CAMuHMdWOC1Zzvd_sbSfBVUMTVwA9NWy3-4ziP=ePxppsbMwRZQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] arm64: dts: renesas: r9a09g077: add DMAC support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Johan Hovold <johan@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Dec 2025 at 13:53, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) SoC has three instances of the DMAC IP.
>
> Add support for them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.20.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

