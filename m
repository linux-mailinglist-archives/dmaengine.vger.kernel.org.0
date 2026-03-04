Return-Path: <dmaengine+bounces-9233-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB6XAQLsp2mWlwAAu9opvQ
	(envelope-from <dmaengine+bounces-9233-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 09:23:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499D1FC848
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 09:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4C103016ECF
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 08:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA93914EC;
	Wed,  4 Mar 2026 08:22:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89845390209
	for <dmaengine@vger.kernel.org>; Wed,  4 Mar 2026 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612535; cv=none; b=YzF8lSihvbFdaptnYVK/0jqyiP5fCzSZwZV6tdFHNQ1fCaPsvxIpjiOPN+cJmoK6VzkxpAYRcStdZ/EsxnySep3My9cBZ3SCxsRpKGZTg41ze7wdofGqAuyHES9hrlH6YvyL/Ga1+8tpyFrwV8p8i6X6kO996zsHAHQMqv9r8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612535; c=relaxed/simple;
	bh=7/wPTDCTtiPAqWfH8TyBseAYgEZt04T6e94ACGrqkKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJYn2TAvAUEN0nDoISyJTSOfSW0470iaH+UNs9DUIdRZmFSxm6CyfPmdkzItuQ4q+YvHF6A5nPcm4xuN3SbI37Rz7/SOnGj2FAUy0Y3t2zJgKd+WmOakYCFqaZ/+s2EhLujAQ1hj9iMzetzXr133T1QzN13ryxhl8NKc3bx2dMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5674cd243d9so5727110e0c.0
        for <dmaengine@vger.kernel.org>; Wed, 04 Mar 2026 00:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772612532; x=1773217332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glRfPg2dFgKoSAd8Np4FiflBn8BE4BQOn9BTgaT8ZrM=;
        b=DFLDWe98JsKyhQBn9iyxBSwOM6X0y2WqfT7fz3sm5oIfFbRwjPsJWtLQGYZPWYFizA
         EcQGB0bNF8eHpm9C6C+RZY6JptzfwGbcSrdhKijXipE1txl2mbqhVe02DFWVqFGzCCPu
         il6Fu3bePC9pX1STmsqj/ifhPfb/XD4rh1V8I/48rAcrCUKbx0ub4jowuHW0xY9+Mgo9
         04EE3ywXhHFcNlWUoTc/9vqH4p4fIJW/300RZLtqywaXSS6IJqpuFxSJjAkvdJ27eaS9
         QTozypNg8q03z9w4iUdpu7S0K6AM6MpykysBOWu6e41iIf4tWFXaafpyEu1WI2m3BDse
         ZdwA==
X-Forwarded-Encrypted: i=1; AJvYcCUoBVnv9A2i09svENK15d8p+Cg6Or7pzgc6Cmd2GYy81SRAT6iDcZ9m3lrpWaRJ19I3CVkh7btbF4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwiBmxdDYm90HuE7/9D1jyJ6HI/nR8Df1dBRTU4xBJgx4cZ2V9
	KxmrRmk9JxpsWDJHn2S3JDafHjCgI+54v0E3yJv9juX42cZLVL+LZI43qrwTy8aX
X-Gm-Gg: ATEYQzx2MnziQD7eqkj0jT4yFymTuD1bDhuxt/vHdv5n9q2wmJsF4deeFl3WMhgPXk5
	AHNxh08rGC/xsS/dXZj1JU7J8AtO3oug3LSss9ViuxjByuKCDHqwrpb3/dUd5oUtD7gVHYrxxn+
	hX2ZSNNLghVAjuGijuJMPvpProUs80bAoXg21TwKEHsRLfXoryDneqV8x9580lX8rH6jefjpSwK
	WMixLLlgEoiDdM5jHUMupx39JK+CiYpl93H4t164HN9g1kKgJCjuuWwWuUI2Aaz55WLaD/AWpIq
	/6BG/jh8+mOFibwYtErdufTQK4ajDxTUAB336XZV41pWkoi0rsLridPu0/HKrLiDhpo1PceoVoG
	oI7jRQZhCZWL5MSFjX0RHc9F/VWZgXzsLfDKubjSnFA1ffjlsrEIWr+rVISXGbbbvil9hK3TfP8
	I8PQyG+YIF6BEHVUazTMP/fkrOtnGcnAY0BFeXHIdFFmhpQvAaXri2WBYKdJ+Hb65DLwugt2QnK
	K4=
X-Received: by 2002:a05:6122:1799:b0:559:6788:7b55 with SMTP id 71dfb90a1353d-56ae7ed1657mr473813e0c.3.1772612532508;
        Wed, 04 Mar 2026 00:22:12 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56ae16a4e31sm2844883e0c.11.2026.03.04.00.22.11
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 00:22:11 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5674cd243d9so5727084e0c.0
        for <dmaengine@vger.kernel.org>; Wed, 04 Mar 2026 00:22:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3TfdUT8CZttwV+kMPEce1AXBAXVW9yyqz9RykR2aTteXrC423OlFH/VnmNBrV446jmWcCnKRBQlI=@vger.kernel.org
X-Received: by 2002:a05:6102:5110:b0:5ef:a1ea:bd33 with SMTP id
 ada2fe7eead31-5ff8f9ef7b0mr2443984137.9.1772612531530; Wed, 04 Mar 2026
 00:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203103031.247435-1-biju.das.jz@bp.renesas.com> <20260203103031.247435-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260203103031.247435-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Mar 2026 09:21:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDt=VZ9-tpHWqHdZq_Uv=67Try_Un+SRKotRkL9yN94Q@mail.gmail.com>
X-Gm-Features: AaiRm51pC7YVz2x2KDtt6tjYIN7TWmh14FLmPTSKWXMV-aPGDw8SpsP9in0fhkk
Message-ID: <CAMuHMdXDt=VZ9-tpHWqHdZq_Uv=67Try_Un+SRKotRkL9yN94Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: dma: rz-dmac: Document RZ/G3L SoC
To: Biju <biju.das.au@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9499D1FC848
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9233-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,bp.renesas.com,vger.kernel.org,renesas.com,microchip.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[linux-m68k.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.049];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,renesas.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Biju,

On Tue, 3 Feb 2026 at 11:30, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Document the Renesas RZ/G3L DMAC block. This is identical to the one found
> on the RZ/G3S SoC.
>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch, which is now commit e45cf0c7d9b960f1
("dt-bindings: dma: rz-dmac: Document RZ/G3L SoC") in dmaengine/next.

> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -19,6 +19,7 @@ properties:
>                - renesas,r9a07g044-dmac # RZ/G2{L,LC}
>                - renesas,r9a07g054-dmac # RZ/V2L
>                - renesas,r9a08g045-dmac # RZ/G3S
> +              - renesas,r9a08g046-dmac # RZ/G3L
>            - const: renesas,rz-dmac
>
>        - items:

This part is good, but you forgot to update the conditional section
below, restricting various property ranges.

                    - renesas,r9a07g044-dmac
                    - renesas,r9a07g054-dmac
                    - renesas,r9a08g045-dmac
    +               - renesas,r9a08g045-dmac
          then:
            properties:
              reg:

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

