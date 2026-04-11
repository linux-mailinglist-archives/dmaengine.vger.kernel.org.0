Return-Path: <dmaengine+bounces-10001-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKk1FBdB2mmFzQgAu9opvQ
	(envelope-from <dmaengine+bounces-10001-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 14:39:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FEA3DFF53
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 14:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDCCA302EE91
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F981A7264;
	Sat, 11 Apr 2026 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JXWXRQ9M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC088E573
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775911126; cv=none; b=f57LRpS3+d/8bs/iN2rr5SVK6B2UjE+TCd13jlJijhHsPTAB2UeFrdY5OqFMsrQWM+GFbcciHt9J78m+tdZ1Lpv5ZdmSQlm9Yb6d4ulfMJFTOHRdI5pHOSQKuRUw9GixN8SSnS4BZ6JbmuogqIN3/ES78F129ZzM6GJuBc85NAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775911126; c=relaxed/simple;
	bh=i+pQwJ5xqs5M5ypuPeuIDBf+kIH1BYcd/Hw6yFSK5Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lj4Df8HBTctfPvRUAqXPIFnf88hTccLmGqYML0nLBedhcIcIZ+7bkFchjYw92JGbl12vDbXK1CpL4Ge7W4k+RZdiqRQo5GfSPmXXsg1tPnMHH09l9d2pG6AlSkFqheTEUcIG3eFHMCwkbMOMOdhSupH7IN1jCcv0B/xomGDaJlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JXWXRQ9M; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so46114685e9.2
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775911123; x=1776515923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yE4wcQKN4kem8Y2lVQo69XargwGADU8xbkrwOp7CO4Q=;
        b=JXWXRQ9M2/axU6NnP+lUcv/slzgAO7h/a0tIXB7PJf/pF3gTjZbqsIIeBBs9jc0Ott
         c2HxSV4MK45SP6oCq+v02lafQqymg7FkwEonofQehsKvAtO+H6UAySuzVAr3yM93l2fd
         z/c9mRHU3w5SlqGElauFuaUoeU9IfNeUWphZ+eGbCt2cBQrPVWAMivYdN+70akthpAwt
         JolBcG/7cUnlOu8uP9UKQbiXYPX4Vgfikf862toV84F3PLotgL3KrAqr69STh8uTVDna
         rHrN0GYcYzgbOetFYTKVKY5G0ljgU2otfYZqF4wUmLhxHaSz0hZYDMsKDlcz8HZhfYbL
         7rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775911123; x=1776515923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yE4wcQKN4kem8Y2lVQo69XargwGADU8xbkrwOp7CO4Q=;
        b=X6RUIf48omkQheaWbfD7q/0f+PbVu+ytvDaSxWfI/N/rSHcJvTYVH/Bmk9kAnPtOam
         QqJM/oMliM9CmDG59G/KapNlYIjE0qX1HUTlIFd57enJfmZRe588fKFsameErjeO10I5
         0QpkUwgx4AhnTSdk1cyOl1Wl2H3DnL2Kqi1xsI6DR6erHjTqt8TZIqnthFbXC+RaxHOL
         G0B34Msm+QqcYmTogLZSFVUbvWPGR3HLa9pL8ichVl5FTN/u0TI3PJ+ft8pe9U8cDpVR
         JLIL9nFvpMEDllP1wdQ0jvSShRGhquzW+KYj2P60QfPUT+/3vbEdGwlZaB6enbUdlAP7
         ReQA==
X-Gm-Message-State: AOJu0Yyn8m1Zky0h5ErrK9hXzKPzfvpK0mFWDhhCBO6/ykIGXl/1VFH/
	3MvQMzcjh57qCmJmcVVpO+u6KGMVcgaIi5zK8RqBZ/lnqYHYxa00e7mEFIjtAOdArF8=
X-Gm-Gg: AeBDietYBpgooMUGA1kmV6NU1vDzUlsRjudQmEXU3cpbellV97p9usjsr/El86asxXk
	6ek8LVg6pCZ/r53rPwMK4BgAlpyOqllei/YSOBu5Jl0p2NoLegx/2Up8GcFbcA3vzxsbYLnu2De
	dZqJbohmuQiYgWmLOFUuE+IYBbhTtCQHMMhjRy5Db6SgAo34lUVmoUu107FSzWdPOWfNJbBQUJe
	g1qxokgq+4DFSkmFJXCKOh2DGwrn00OtK0kRnf8JNEibZAzqJYmV+mfZdiBcISZdxiiyJzkfqwm
	w6T2Gd1CR2yYHRtcxHR7aWh6fa+fT/ZW+BPp78wzK698VRiC0cqgFF5pSRUB9RvNIXKzo1DwkcO
	NizJx0qHempyvXcQ7D6K/HhJ/mtv0VdG3ml4AWfl1wL4idzkT8P4LASMFDwVCGJqx+zk/KksY/9
	ZB7uvvGwqMazUees+XONKE+TNlNSLEfVJclwXn7ah9Fw==
X-Received: by 2002:a05:600c:a109:b0:488:b187:3c with SMTP id 5b1f17b1804b1-488d68431ebmr66421005e9.14.1775911123257;
        Sat, 11 Apr 2026 05:38:43 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5df2062sm47369605e9.12.2026.04.11.05.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 05:38:42 -0700 (PDT)
Message-ID: <f3577fe6-efc6-4acf-956b-93be6d498238@tuxon.dev>
Date: Sat, 11 Apr 2026 15:38:41 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/17] dmaengine: sh: rz-dmac: Save the start LM
 descriptor
To: Biju Das <biju.das.jz@bp.renesas.com>, "vkoul@kernel.org"
 <vkoul@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz"
 <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Long Luu <long.luu.ur@renesas.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-8-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346602C7FD8ACAB74BB568486262@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB11346602C7FD8ACAB74BB568486262@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10001-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:dkim,tuxon.dev:email,tuxon.dev:mid,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9FEA3DFF53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/11/26 15:34, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: 11 April 2026 12:43
>> Subject: [PATCH v4 07/17] dmaengine: sh: rz-dmac: Save the start LM descriptor
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Save the start LM descriptor to avoid looping through the entire channel's LM descriptor list when
>> computing the residue. This avoids unnecessary iterations.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v4:
>> - none
>>
>> Changes in v3:
>> - none, this patch is new
>>
>>   drivers/dma/sh/rz-dmac.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 6bea7c8c7053..0f871c0a28bd
>> 100644
>> --- a/drivers/dma/sh/rz-dmac.c
>> +++ b/drivers/dma/sh/rz-dmac.c
>> @@ -58,6 +58,7 @@ struct rz_dmac_desc {
>>   	/* For slave sg */
>>   	struct scatterlist *sg;
>>   	unsigned int sgcount;
>> +	struct rz_lmdesc *start_lmdesc;
>>   };
>>
>>   #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
>> @@ -343,6 +344,8 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
>>   	struct rz_dmac_desc *d = channel->desc;
>>   	u32 chcfg = CHCFG_MEM_COPY;
>>
>> +	d->start_lmdesc = lmdesc;
>> +
>>   	/* prepare descriptor */
>>   	lmdesc->sa = d->src;
>>   	lmdesc->da = d->dest;
>> @@ -377,6 +380,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>>   	}
>>
>>   	lmdesc = channel->lmdesc.tail;
>> +	d->start_lmdesc = lmdesc;
>>
>>   	for (i = 0, sg = sgl; i < sg_len; i++, sg = sg_next(sg)) {
>>   		if (d->direction == DMA_DEV_TO_MEM) { @@ -693,9 +697,10 @@ rz_dmac_get_next_lmdesc(struct
>> rz_lmdesc *base, struct rz_lmdesc *lmdesc)
>>   	return next;
>>   }
>>
>> -static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel, u32 crla)
>> +static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
>> +						 struct rz_dmac_desc *desc, u32 crla)
> 
> U32 normally used with register read/writes hardware related.
> 
> Here it is just computation which returns number of bytes. Unsigned int will be
> appropriate instead of u32.

Please check the type of residue as defined by dma_set_residue().

Thank you,
Claudiu

