Return-Path: <dmaengine+bounces-8915-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L6dAHUGlGnX+gEAu9opvQ
	(envelope-from <dmaengine+bounces-8915-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 07:11:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABAD148F3D
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 07:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 574A93001F88
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 06:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1888285071;
	Tue, 17 Feb 2026 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6WiyaIm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC627FB35
	for <dmaengine@vger.kernel.org>; Tue, 17 Feb 2026 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771308655; cv=none; b=sJ1vVzWvqDbm9aSOkLfMNWOMeGgF9EBETbYR3yrhOGQaSInRc9wTu7DXRMKcOpOasYRRxV7W4vO/RH0VKHXMtVX9outF1QC1YXHYWjr2iF8Vtq5mptKim7GlkvGB7XDYHP63VkUaQfzH9Y51FRcTP71qILPCWCfkIXkoE/Dydkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771308655; c=relaxed/simple;
	bh=RZNIWl6tGl3E2IWfidbVZrbrr100fglzO0Fmmh8y6+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0tcHZXJpHJmadwYnDQ0hX102+z/dRKTuEVzsECeZzBxCIq81oRw8Ja7fLmT3k00fnDCd9yq+5IbNGlEpnDWv0jVMg6vakTx3OS4xt2JdcGhIDNI6Qe/RdUqS9oYMSIX308gzUR8N9tg5iMUUDpmdSJ90pXfc9hzCvxDp3lGJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6WiyaIm; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dea72099eso4453263e87.0
        for <dmaengine@vger.kernel.org>; Mon, 16 Feb 2026 22:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771308653; x=1771913453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2EmaR+jdHZmVae9mRMz72mzoy+uR0gNkmyjhuxhcrE=;
        b=a6WiyaImZb0auFHUIOvyDTb3kTVIsBEezsCb/JIPcLMi1a/jnqkoWQot+djcnAUNLk
         0G5B4oUZjSJ2xvFEX0vgkqMyTsnCjLMhasKBmDwcEjVUdj4ag/XByZsDfonytXm35w6j
         bPW4TBxayDZLXvUajRbnXKKx6G/hjk1zDx/3ORDh/H25Wma5OC9dgM/pA+loAJEWt1td
         BMC1hnLJOFjk8mbrF46Nxd+tV9qpo/U78ABdQ2VawQDDoOWQZUQIxVa3fLdLpeskGwPP
         3kjwVHwCRUYUg/Bn2XR5GCWY68GvckJfLViGeCRyA+LhFDOMvHb579EUTkh8senxpg4D
         38Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771308653; x=1771913453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2EmaR+jdHZmVae9mRMz72mzoy+uR0gNkmyjhuxhcrE=;
        b=uMRO4vtQjTU5HPDeflSBjB38WbM1tnEPr2j9tlWSuEEHRZOyjysysbJYJwsGfIyMjY
         Kmbk9zpvqMpPVIZnwfw9deAEexo0gUEMfGLFjkF4mfc8QPlgxb3XDD8rHa5P+OyyMuE8
         8BPdLO5nLEPFptTrZRqdK2IldDCbKHopomzoR3LZpVwzgvx2Q87Y6qnP4D9bXQ9jzYmX
         lvuTsr0aeynNiudzAe12p+TyTwkeCAefA+xgspY7tmcBoqCINAhjogFsne7WWSrvtKZ5
         rt8q8ml2PjjSY1jN+KQkizEPZRpSa2hop6It197Q2sR/H6V4ndS9c2dx/Zfm38BvSoVL
         n7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjUyyyMKsXhxYxKeTIn+2v9JWY9PTFscm9L45f5hdl9Vz3QSd+md2NYY6sdg/bAQscOh1pDBUtPCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0oz75X5LCWrYNUa2jER1WxwmbIswT95prf0p+ZGgeeaUu9e6u
	x8io4CFQCzbNMIxUZfOTmjBZKiOSXLyO5nKIvgZioO+zrhB3Invkq7QN
X-Gm-Gg: AZuq6aL8u16gbvWW/ob3JFqh2loRko2rhl+Np/jwGhmi6ZjoCjbUbYhqDtqMhOI0Bvm
	pLTnNvnsWP+YUJJVRsO+TArSUix+VJvLjnR6zs3lGhQLSv1prb885QpsAJx4nA4zixkr0JLfcJr
	38USJD0hgjwfhbvFdcaMt9ujRj/x/aw9twEf2vVNzBpNliHFKj4ysmMz/L7xDSWcHe2HNlZidfl
	0tii780VRzCyHruscCCuLnewdDUfGKsEaaOQEk7iaLwvay0htBdod/cwCwDxfdTXa7WOsBrNJKf
	zCnnGMBl30wRGBJpXYuNqjJ1zcmnGCmFt3Q8FW8ZcajAxXrx1u8GbC8kJDKBh6sWqrVleY80hbE
	v/+meYUv9BezTL5kOv5Yhr5R9CgODqWdO/5fWjPZsGDAhOLgePlL5elwegaSIlLP2Iiapfodqr7
	q1sc9KPVgbbnDzFM7FzH4E/Rrqe9RXsbuHas7xhOxsvAsfMKGCNK0M2pgRqZZOUUkVxaJnhjI=
X-Received: by 2002:a05:6512:3ca1:b0:59e:1727:fcff with SMTP id 2adb3069b0e04-59f6d3879demr3028546e87.44.1771308652390;
        Mon, 16 Feb 2026 22:10:52 -0800 (PST)
Received: from [10.0.0.100] (host-185-69-74-59.kaisa-laajakaista.fi. [185.69.74.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f56867fsm3665403e87.24.2026.02.16.22.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 22:10:51 -0800 (PST)
Message-ID: <d1ba23bc-d8cc-4109-985f-76bb454c6d4a@gmail.com>
Date: Tue, 17 Feb 2026 08:12:18 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] omap2-mcspi: periodic zero TX in target mode - debugging
 help needed
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 linux-spi@vger.kernel.org
Cc: broonie@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org,
 vigneshr@ti.com
References: <941806a6-0deb-415d-8af3-e78d6104da1c@yoseli.org>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <941806a6-0deb-415d-8af3-e78d6104da1c@yoseli.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8915-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterujfalusi@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 0ABAD148F3D
X-Rspamd-Action: no action

Hi,

On 12/02/2026 17:53, Jean-Michel Hautbois wrote:
> Hi,
> 
> I'm seeing a puzzling issue with omap2-mcspi in target mode on AM64x
> and could use some help understanding what might be happening.
> 
> Here is my setup:
> - AM64x as SPI target, external controller at ~1 MHz, 1 Hz frame rate
> - Target mode, DMA enabled (k3-udma, not legacy EDMA)
> - Fixed 64-byte transfers (matches MCSPI FIFO depth)
> - Full-duplex, using spi_async() for continuous operation
> - Kernel 6.12.y (also tried mainline, same behaviour) + PREEMPT_RT
> 
> Periodically, MISO outputs all zeros instead of the prepared TX buffer.
> The pattern is surprisingly regular: every 42 or 43 transfers.
> If transfer #10 fails, then #52 or #53, #94 or #95, etc.
> 
> This number (~42) doesn't obviously match any power of 2 or buffer
> size I'm using, which makes it more puzzling.

Curiously matches with the answer to the ultimate question (THGG) ;)

> I have verified a few things:
> - TX buffer is correctly filled before spi_async() returns
> - Added debug check: buffer is NOT zeros at submit time when failure occurs
> - RX works fine (master data received correctly)
> - System is mostly idle (basic Yocto, systemd, no heavy load)
> - Logic analyser confirms: zeros on MISO, correct clock/CS from master
> - Forcing single CPU (maxcpus=1) does not change behaviour
> 
> This suggests the data is correctly prepared but doesn't make it to
> the FIFO in time. The issue seems to be in omap2-mcspi or k3-udma,
> not in my slave protocol driver.
> 
> DMA configuration:
> - Using k3-udma (AM64x UDMA subsystem)
> - Single DMA descriptor per transfer (not cyclic)
> - DMA-coherent buffers allocated with dma_alloc_coherent()
> 
> Questions:
> 1. Are there known timing constraints for target mode DMA that
>    could explain this periodic behaviour?
> 2. Could this be related to k3-udma descriptor recycling or
>    ring management around ~42 iterations?
> 3. Is there recommended tracing/debug I should enable to
>    investigate the DMA/FIFO timing?
> 4. Has anyone seen similar periodic failures in target mode?
> 
> I can provide more details, traces, or test patches if helpful.

I would enable all interrupts (channel 0 is the relevant for
non-provider mode) FULL/UNDERFLOW/EMPTY and see if McSPI itself reports
any starvation.

Iteration is number of one-shot transfers (of equal size or variable size?)

I cannot recall anything which would result such an issue, but the
consistency is more than interesting. Re-reading the TRM for SPI + PDMA
and BCDMA (or PKTDMA is servicing McSPI?) might give some clues.

> 
> Thanks for any pointers!
> Jean-Michel

-- 
Péter


