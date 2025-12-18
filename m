Return-Path: <dmaengine+bounces-7797-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A392DCCAB65
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 08:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30E1B3006A65
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 07:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA96298CC0;
	Thu, 18 Dec 2025 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eNJPKxaC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867913A1E6E
	for <dmaengine@vger.kernel.org>; Thu, 18 Dec 2025 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043840; cv=none; b=rGtN6cYAY52XHtd04cRz1F4dEHE5IWJPb22u83n91LRCPppa/RtA0RnTBJ2vJ+2RBZwWWaECiebKMm8KjKGev1urNvkb37mDnEFHLsNZ78N07hSsFpIOAlw9S2o3Nb3ICyRY+eOL9JzF5N4N7e5JtUCxYKnKiIG1wdWmkWcfHWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043840; c=relaxed/simple;
	bh=p8l5eezb1CTtwAcj3l2Y3ml2pDSEw3r3dkZMwboKCCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+6j8LMWfqTmiR4dEf1/b2mHBKa2OC6MpJdtwNoPoDEJhi3ukUYsxzG5VlzTAs0Gn1l9ZGDtKmBLlAtySItnkfy6M4RPDTCQNa9J225kxuWgFRsAlo3i0Qzt9inECxHO/JtaWveZRYqpL7060u2S70NY45Zv2rfJly40oi5v4EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=eNJPKxaC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775895d69cso1095815e9.0
        for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 23:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766043837; x=1766648637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9a6I9p8Qoy8PBC1R4N7ii/8mZi1V+XC1q27O7cdjZY=;
        b=eNJPKxaCftkX8kGoj2R19ypCreRa00PFBFqfiAQCpHwHlG8wnwlwnpLEMgofIH6Z0n
         ThM0YfpOAeAiE3jpIiYWpkS6b9UlAuNl0Gm0CJPTqvm5U8GqsaZzO/3UqsyAW8mCa7zJ
         qbAwcGVFHrb3gLqEWIzgwzZnfMyeNMP/Y1N5wueL8hUoUPogm9RftX8oP+xji+TyKU1a
         rtwQJv0in2fe27KXNXvhTm+zyd0gz96cmunnlizrICLWkxEhcwpTesBR31cd6xVr3Z4c
         VrbQtXxSPXpB1gwGvBMNGPQkazGNmF0AsU9QfRCJSqk3fuU3vhl5Cnxt14aONqOcw1zy
         sX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766043837; x=1766648637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9a6I9p8Qoy8PBC1R4N7ii/8mZi1V+XC1q27O7cdjZY=;
        b=bBXmnaOffdR4qHg5iPgiyxdwh8zY3lT/s/9GCrEIVP/wPphhPU/fL9gn1jheE4U8vD
         amkYwTaWoDCD8xQ9X/CB8omQL/NIwZLbP20CrldmPiCnPbCWZnJw7HHehDbdOCRyJYkq
         PQDYMZpzjf/N+8aMSh/mxl65udT8gtGWJkopy40Z/UlGpnagPRiZmydkRig0mjhKOMgl
         3zUNh1WXg8RWNqGvhO8raB0Nk8baIBZ7sHusl5XRqLkdWX43NROAxCUHyiOQfBW/ke8k
         NRF+X0WeV/AKPObJG23iA1HkjsKdZGCEfbV+5MijVlhmqW5bSjIQDlcKaAtlF+lRZ5p1
         Yfog==
X-Gm-Message-State: AOJu0YxaBycCM9IAJHp6H8e3Nv+wiNYUq8KGlxdeNAsHTntWBTjNmdvA
	1euxhl+w8PnS4JRTZ5dHEYLyRfCZcuIlgQ9hwLoBzEeuS/oaXxvPpa5jdD0r7J3T/pM=
X-Gm-Gg: AY/fxX7F2Fgfo5Q3oARIavTBx9SiPicIs9nxJzGpyiCnVqLNwunXrQsEhXFPaMLjvgq
	SMhkOwtxNJQADClSLtTChDs6o540qITI+OezH+DIZQQIvhtk/c+igeiXuFfSyG9jfaLsMDhRA6Q
	DEjfKnEcZx0LvHAUrwYlZoFRPC9FRQ0c/EtcyHvk9WrHaAUlKGZVBP0xBdwrMHwnUkP/g6bWBkN
	/JX6eHzh7dgVwc0hY7BpgjLvNinrEHG2tBUSN4WlGUZnikRVY2Uv5znGBwxPsXwOs42UOJV7zpa
	K/mE9TiIkg1b+6He/75G8sKBM/K7sIa/mi1pxQOS2Bc5tVSnbY0bWwrK9rNCMnFzGU4kC2ffG+M
	hmvMY2xvv7FA3GuroWv8sAOY3oqMRUK4Gm6YR9719varDkTNAu/UZsAOP4TBhpWtsrHuISp66Wl
	XiNMeVlI4u0mtMZS2oBQ==
X-Google-Smtp-Source: AGHT+IHTaj354v56JVpbEnzZd73D1HkWzh99zzHoJxmOUQpA5NAIjnss1tvSVtvdSXeo4VkzhrFlQQ==
X-Received: by 2002:a05:600c:3e10:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-47a8f8ab731mr210907645e9.5.1766043836794;
        Wed, 17 Dec 2025 23:43:56 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324498fbd2sm3531140f8f.27.2025.12.17.23.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 23:43:56 -0800 (PST)
Message-ID: <e2037b38-4c20-4f1e-b681-ae3def30823c@tuxon.dev>
Date: Thu, 18 Dec 2025 09:43:54 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] dmaengine: sh: rz-dmac: Move all CHCTRL updates
 under spinlock
To: Biju Das <biju.das.jz@bp.renesas.com>, "vkoul@kernel.org"
 <vkoul@kernel.org>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
 <20251217135213.400280-3-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113463722674503F2B15F944786ABA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113463722674503F2B15F944786ABA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 12/17/25 18:16, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: 17 December 2025 13:52
>> To: vkoul@kernel.org; Fabrizio Castro <fabrizio.castro.jz@renesas.com>; Biju Das
>> <biju.das.jz@bp.renesas.com>; geert+renesas@glider.be; Prabhakar Mahadev Lad <prabhakar.mahadev-
>> lad.rj@bp.renesas.com>
>> Cc: Claudiu.Beznea <claudiu.beznea@tuxon.dev>; dmaengine@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>; stable@vger.kernel.org
>> Subject: [PATCH v5 2/6] dmaengine: sh: rz-dmac: Move all CHCTRL updates under spinlock
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the CHCTRL registers. To avoid
>> concurrency issues when updating these registers, take the virtual channel lock. All other CHCTRL
>> updates were already protected by the same lock.
>>
>> Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, before accessing CHCTRL registers
>> but this does not ensure race-free access.
> 
> Maybe I am missing some thing here about race-access:
> 
> 	local_irq_save(flags);
>    	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> 
> After local_irq_save there won't be any IRQ. So how there
> can be a race in IRQ handler.

My point was to address races that may happen b/w different cores trying 
to set CHCTRL. E.g.:

core0: take the IRQ and set CHCTRL
core1: call rz_dmac_issue_pending() -> rz_dmac_xfer_desc() -> 
rz_dmac_enable_hw() -> set CHCTRL

However, looking again though the HW manual, the CHCTRL returns zero 
when it is read, for each individual bit. Thus, there is no need for any 
kind of locking around this register. Also, read-modify-write approach 
when updating settings though it is not needed.

I'll adjust it in the next version.

Thank you,
Claudiu

