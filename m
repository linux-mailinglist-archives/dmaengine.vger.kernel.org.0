Return-Path: <dmaengine+bounces-8504-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAw3ArNhd2n8eQEAu9opvQ
	(envelope-from <dmaengine+bounces-8504-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 13:44:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C1C8869C
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 13:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 507D7301F31C
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228E13016FC;
	Mon, 26 Jan 2026 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qdP9RXdJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C82F5A09
	for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431150; cv=none; b=mwbBnQVDfscE31unUXu5UEt2dcnnOT7vpd0nJtyQlfnHrEz/dEZ3hZyO2v3tc7T6TYek2KjAUaDtXNFXHZxebMfwKVHOc0HuUuXsa7YeNMTbtBge+zgJMQoAXukAbuFZeAmn/f5XjL6OEM5BL5nEMAmeE+YugEEQ6b5QaaolUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431150; c=relaxed/simple;
	bh=cyOIiW4pRspU7Ky5fnCdxX16wwU+4Lx/7snzOfV0wDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uajh5jPaG64K/7BvGSAs4O2qEydY/SqDaYDlHX93XvnAgVuACpjQ7ZIooFp64uuesqDnEX9yBKXrLI3iSwMsLcQgoqAJB+ROJ/IThQfS+dX7Eytr+Dq3cUPOR6gFQr685StY3rkq8TPxcFYFnv5wq8LO11nbUoobvpmnY+5SSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qdP9RXdJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so36612645e9.3
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 04:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769431146; x=1770035946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9LPVZSPw9JF8KAbPLK9s3M1ut6MOkLUhCUq7qppfgc=;
        b=qdP9RXdJjCEm2AMH8YRaUTrD0PF+7Sx7JsYV8tPjWRD7tut1noRqfV/WzSbU7t85Sb
         TY0See//8mL7TJW+p69ixwPpPLBZ4ysHt+AY4xFyRgbvBoSFnMjEqxP3Bb0PYIOf7E+K
         BL4elODtMaM76JXafll7dlxDz/fyXFzrkFY+QylFw6eQyYFwRLMHay+82GvN7JA/eZMI
         gImrvZr/lwKqM2fKh/CyQOiN6p8+lP7vn2+Yw9HfODsevfEEUTMsH1ZnfdXhxaO6Aaph
         3dwHQD7fSc6UkSpeS1LP/ZdPrzHj/4emzXKPfIETSijGjkkv+m9HQ7NEWfLRRiVy83cj
         j0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769431146; x=1770035946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9LPVZSPw9JF8KAbPLK9s3M1ut6MOkLUhCUq7qppfgc=;
        b=He5cO+7qn/uZfo9yrQaOktohztKiELko88gwpRUo1fYU5OBev0hT8TG3WJqe9kgOLY
         BG3BFd4v3jdRBmeSWAT2UJIIvTYAegmYQ8tEa0jmwbZ3qDTJYc9hEZim+8BRVl6o2Hxi
         k6AtNg45calxQ6IkmaC+MQ+1enomJwEAawB7osdbyEl/TkdWkzDpLGZyv6dAECW/h/NJ
         SxvFa2Rgp3pH4xDRaVp/L5l+S73Ec0jE32uJiOuwImYpkFVbgCtzoby/FwEROB/Ub4gg
         iA2U3rOD8HQKV7iFdrGZPMUrPK73eRL6dW9eWyLMM3TiAwO9xP8WT5gUgf9nG2yXIaK8
         AdJw==
X-Gm-Message-State: AOJu0Ywf56s0dUjA31Im/76uLPMYYeyC821zcion/3DKtREE3/WtBjnk
	+WiuPJF0HrV0JLpxzprI5BDvlPvaHRfZSirVboEyha4vzZZSZJKzl+L+pYU3b4+TTQo=
X-Gm-Gg: AZuq6aIIlq/MpxLFhcVZbgnr3FLwD2HDDJ8Yr8fqMXFfgGkGo1uqDBBvPWIV/3Rp3A1
	RTU/Qssvx7G+9NSKowWeYV2fnMPTxD5fRxwn6HaDet877UL68Cq5dLr8u3JjsnnyKKAVPWbHCBk
	9qEZ3kJQn/FikWfKYXwLupFMpGDKo5T4UCmipr14iA2Jp2W6ezkYh/UIqmako7Wm7nOP1dM/nnE
	fhWfmdloOExTSPt95AaaSCcUD/ZyZMFusVb0FlnC+NkNCV5lK6KamOPZGZer3l00gaxk6Dmb27v
	Ky3fSzFWkS0u8uUm9AZjq47qRUozkjjNw+Y1SnvKc67A62QK/59F8Tw0tFAZQXa9Xz2kMspHI0E
	a+9oBk7USo5zLC4/IFPrVMNm2yx/8Cf0ZkP/G50tKBnBEeee7LI7U/gI26GKIPEEH1k5+4irRM5
	R1SV6ONY791Txn/DkYebe6a8mUySpY
X-Received: by 2002:a05:600c:3b8e:b0:47e:e807:a05a with SMTP id 5b1f17b1804b1-4805d064497mr79561075e9.33.1769431145878;
        Mon, 26 Jan 2026 04:39:05 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d627871sm102636035e9.6.2026.01.26.04.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 04:39:05 -0800 (PST)
Message-ID: <5438ccc8-ed5a-4dd6-8995-e8e9926883a5@tuxon.dev>
Date: Mon, 26 Jan 2026 14:39:03 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
To: Biju Das <biju.das.jz@bp.renesas.com>, "vkoul@kernel.org"
 <vkoul@kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz"
 <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
 <20260126103155.2644586-6-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113461F734BA087B60605C6FC8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <16a6f14a-93e6-472c-8718-d46972f0ac5e@tuxon.dev>
 <TY3PR01MB113463BE8A4B1A40DBB0860538693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113463BE8A4B1A40DBB0860538693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8504-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bp.renesas.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email,glider.be:email,perex.cz:email,tuxon.dev:email,tuxon.dev:dkim,tuxon.dev:mid]
X-Rspamd-Queue-Id: 26C1C8869C
X-Rspamd-Action: no action



On 1/26/26 14:10, Biju Das wrote:
> 
> 
>> -----Original Message-----
>> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Sent: 26 January 2026 12:05
>> To: Biju Das <biju.das.jz@bp.renesas.com>; vkoul@kernel.org; Prabhakar Mahadev Lad <prabhakar.mahadev-
>> lad.rj@bp.renesas.com>; lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz; tiwai@suse.com;
>> p.zabel@pengutronix.de; geert+renesas@glider.be; Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>> Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; linux-sound@vger.kernel.org; linux-
>> renesas-soc@vger.kernel.org; Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> Subject: Re: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
>>
>> Hi,
>>
>> On 1/26/26 13:03, Biju Das wrote:
>>> Hi Claudiu,
>>>
>>> Thanks for the patch.
>>>
>>>> -----Original Message-----
>>>> From: Claudiu <claudiu.beznea@tuxon.dev>
>>>> Sent: 26 January 2026 10:32
>>>> Subject: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM
>>>> support
>>>>
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> The Renesas RZ/G3S SoC supports a power saving mode in which power to
>>>> most SoC components is turned off, including the DMA IP. Add suspend to RAM support to save and
>> restore the DMA IP registers.
>>>>
>>>> Cyclic DMA channels require special handling. Since they can be
>>>> paused and resumed during system suspend and resume, the driver
>>>> restores additional registers for these channels during the resume
>>>> phase. If a channel was not explicitly paused during suspend, the
>>>> driver ensures that it is paused and resumed as part of the system suspend/resume flow. This might
>> be the case of a serial device being used with no_console_suspend.
>>>>
>>>> For non-cyclic channels, the dev_pm_ops::prepare callback waits for
>>>> all ongoing transfers to complete before allowing suspend-to-RAM to proceed.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> ---
>>>>    drivers/dma/sh/rz-dmac.c | 183 +++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 175 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
>>>> index ab5f49a0b9f2..8f3e2719e639
>>>> +
>>>> +	pm_runtime_put_sync(dmac->dev);
>>>> +
>>>> +	ret = reset_control_assert(dmac->rstc);
>>>> +	if (ret) {
>>>> +		pm_runtime_resume_and_get(dmac->dev);
>>>> +		rz_dmac_suspend_recover(dmac);
>>>> +	}
>>>> +
>>>
>>>
>>> This patch breaks, s2idle in RZ/G3L as it turns off DMA ACLK and IRQ's
>>> are not routed to CPU for wakeup.
>>
>> Is this particular patch the one that explicitly breaks it? Is there any mainline PM support available
>> for RZ/G3L? Can it be fixed along with the RZ/G3L support, if any, as I don't have the board to test
>> it?
> 
> Maybe your TF-A is enabling DMAACLK during resume. Can you check that mean time, I will check what you have mentioned
> Here?
> 

You used "freeze" in your example. Same did I to check your usecase. That 
suspend type don't involve TF-A (unless something changes and I'm not aware of).

Thank you,
Claudiu

