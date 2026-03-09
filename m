Return-Path: <dmaengine+bounces-9341-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF83Ew6NrmnlFwIAu9opvQ
	(envelope-from <dmaengine+bounces-9341-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 10:04:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A684A235D8B
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 10:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83644301378C
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D2E37473B;
	Mon,  9 Mar 2026 09:03:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D60374190
	for <dmaengine@vger.kernel.org>; Mon,  9 Mar 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046982; cv=none; b=ULYFdLIDY96xRZov6fAW5MKEpMr0t5AH/zeBZI/Ao4x3YLSsa3QoXZEjHMYoxtVK3dPCn5CM7+lCv9WLpwOVfrALehWj6dzAAL2AkXqNfRoQ9S4JCMjqUlsfYDzWnmXILlCTjX2J5rehv8hP0WcVCtNSONbXAnyYdAGV6PWrhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046982; c=relaxed/simple;
	bh=+SvpTPCt3UmTajloqWXffF83Z0jPUDgrYCgmiUYedxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdFivxOu6KGOKb96NoLBYioycVgxFrEaJ5VKxLJpOGNZnU0GTcuTXF9HG4P37Lrk6kzr8pS7nVozw3puKh0N9Uy5u1Jf3r+Pqal8W3MkoenJiga7tCWvWLHa2AMxMGWhLHPTVqNTzVp0QGyor3MhOvaoJGoON0rTBFRSGzAOVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94dea0e029fso3303519241.2
        for <dmaengine@vger.kernel.org>; Mon, 09 Mar 2026 02:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773046980; x=1773651780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woFrl7jRlBwz5NvQNkYQJFvnP2BKvE4DuuKsF2voteU=;
        b=VqL+H5iZAd9cR6gjkAAbR/hhwd5Rf8UpBlAq68uwHm3uKgO2VxX/qsftgWtkRq5M0i
         Cav/qqqCMRmlTmEU9NF+Ro6llnp4WCS2U0OLU6weqAvqGqJi2lTPSH8i2pbfakMgTwZl
         Z4L67yQZmt6MpKaOPEjc1aIjn3NeFL+5/kx+fsJaDDJrWnCE8/jWZMQEroYvjQKtttRN
         /YBnmg5beF7W3Ypx1bpH7osGcEiWlUODrQT+HVDtAQzfgZitaLJTLKBydud4c4u+JhiF
         RFtu7w24UBNqepx2lM1mbwYFrxkisqedsaYfrgRPkVtL96jDcX3p4Nsqihy0xtLnkmVO
         rDUA==
X-Forwarded-Encrypted: i=1; AJvYcCVL7Q8JmHIVhVrfrb5BKKIhWW/ycmtTfopFv2juLUnc2E3V6ZbuPnBQvgr/jyK02goGyDzaT2lCr6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4rT2N0+f6HyaV9JmWviVEuVoK10SQahZU5cC2rkz9pnk9s/6D
	1DvjiZYIl9JEtlyM9qTFbeN6BjCbKTKy9d1cMwpxSWcrgpOBbqQNmyUIn7ys/CPD
X-Gm-Gg: ATEYQzzP1bC5SABVkovuGElAEyWAs3W4rPFIKMmrZokGFXXkHcoG7HxBxhioyx8thjb
	A58KY3SaQMszLBV752z2okdwTALji9uFy0NZniWuDZ41XoQMFthOjPxnxYhQTXjeU7UYbEYSZCo
	5/egSInCy1XUFtPJ4nOr6weS1IKS+8AluPRyF15y0BD8ci6NOeLSr7TTt3JurZ6RIKyCQyJKy94
	rcmyV8oZJJcay9T5pBIdOVl4csh+6esAuV2KuWT+a6fTUZB7W26FGSkNYFB8dxreVeF5tGS2MBc
	S/fMroM+yhiDBDEB6hAV1MjgSsqTvoqcXVHHyOI0wsxmmlLuT9TBnwnkNOQlEU49OLtZVqr1nwp
	qKyJD3t7fgtxbCSxk1AiHlb4Gj7k0Bx8URnnd3SvxuB+yzccURelgVOULc6NuY82aO6+fZZFLap
	NnnPXBASkKRAV61LN+jneSvJauEX6H4AZU3DtctPPnw3jruYmZWarUrA8h2IYH
X-Received: by 2002:a05:6102:3ecf:b0:5ff:c24c:5a09 with SMTP id ada2fe7eead31-5ffe614e740mr3172744137.25.1773046980176;
        Mon, 09 Mar 2026 02:03:00 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffe8922cdfsm8438291137.5.2026.03.09.02.02.58
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 02:02:58 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5ffd76e4c89so637340137.3
        for <dmaengine@vger.kernel.org>; Mon, 09 Mar 2026 02:02:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNUX0NaYVyNUffaJYy4LukdMgID6YtFaukRflLEQ+Owithedof2hCwB2b3N9cvcr10IaupeUlHZnI=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0b:b0:5f5:40ab:2d65 with SMTP id
 ada2fe7eead31-5ffe614cb63mr3587596137.22.1773046978396; Mon, 09 Mar 2026
 02:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306145819.897047-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260306145819.897047-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Mar 2026 10:02:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJuWVR_SvjTZXA0mtM==p_kcR3LWjuYf_c83U9Z35J-A@mail.gmail.com>
X-Gm-Features: AaiRm52y7ZyQNCmU3B4H1jId4AxkZXSLWMRot7Mw1tDnya6wSfnl74jLyKkpMyg
Message-ID: <CAMuHMdXJuWVR_SvjTZXA0mtM==p_kcR3LWjuYf_c83U9Z35J-A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Add conditional schema for RZ/G3L
To: Biju <biju.das.au@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Frank Li <Frank.Li@kernel.org>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A684A235D8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9341-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,bp.renesas.com,vger.kernel.org];
	DMARC_NA(0.00)[linux-m68k.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.158];
	TAGGED_RCPT(0.00)[dmaengine,dt,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,glider.be:email]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 at 15:58, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The RZ/G3L DMA controller is compatible with RZ/G2L, sharing the same
> IP. However, the conditional schema logic that enforces RZ/G2L-specific
> binding constraints was not extended to cover the RZ/G3L compatible
> string, leaving its bindings without proper validation.
>
> Add the RZ/G3L compatible string to the existing RZ/G2L conditional
> schema so that the same property constraints are applied to both SoCs.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Fixes: e45cf0c7d9b960f1 ("dt-bindings: dma: rz-dmac: Document RZ/G3L SoC")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

