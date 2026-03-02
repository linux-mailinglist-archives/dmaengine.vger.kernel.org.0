Return-Path: <dmaengine+bounces-9174-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGmVKn6WpWmPEQYAu9opvQ
	(envelope-from <dmaengine+bounces-9174-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 14:54:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDA91DA2DF
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 14:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BA4E3026166
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4854430BA2;
	Mon,  2 Mar 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Al3enh21"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7293F23D9
	for <dmaengine@vger.kernel.org>; Mon,  2 Mar 2026 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459444; cv=none; b=D3LliZEGZ5Vq7ZM7qbax/XDJpfCsqVwOGoN7GMI3FnRyeXt6Phd3V50oGI5b0hw/LY5FcuAEJqW5QnDgvV/t5vScfB4LnZrqimoSNk12yMPT5naxhXtLtJWaaOsrNeiAbGZCFvYC93XXgVjElDH43sXH6BTCxAXblYU13qrLIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459444; c=relaxed/simple;
	bh=znayURIc6UwMnzR4+zxKj1YujXCvZq0nZhvdTiYBMbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzsPOfzpYs+JHv3/clfCm7HZOBMg49o5J55Fsb+iuy5aNDqD66jlWRPHClOAN85j7vbpIZOxH9rgvc4CuZ0H7WDpnCrDyfNSs5bCz2tBMm4SIjbWESc/WQk6rfEuoxgO4qZR/XPaXOJgaGs0/O05VS9Rn2CLI7T8wwfg8ahZDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Al3enh21; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso38200845e9.3
        for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 05:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772459441; x=1773064241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQcasE3PVF0EyNWGb/SK4dKMSciKGR226g9dcmkAjbo=;
        b=Al3enh21oRQoKpaxnpPpvAUlI/RnZC3nsZ9n3M7qVdeYKljiPSbqHc//bZ1s2HBoRa
         TVl+8oQDzWgqMfcNKTLM5WZfoqsDtJvu+i8/xngW7q5O4HYNhAkJNidpRucKdhpXsajU
         n/C6KtMQbV4kxduvQ9lSi4HSRCuX/+EREV+SnzCwJM2Fvpz8o5FKNTCUdKNO2Q47SOdO
         vW4H2SqCqNPTVL91fCiquQUPyaPoxFS+LzdvSDC3r5y0PfTH4RsGa5oPE3NsjKltyQn6
         7EmFe6vE/O3ETUF1tSi1bmoyB+qni/Mz+c6ldUVpcTC1/n3mhn5GnN7+DpFIBYzaojp+
         SFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772459441; x=1773064241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQcasE3PVF0EyNWGb/SK4dKMSciKGR226g9dcmkAjbo=;
        b=pryT0cToywt2dSMLqJm3iShn3uFqLOUb2jeNyfootsb2dPZ9noy78nC2ZeGcM/21OS
         9CYqxcEBRp03mO0GLts9rqf6soDipMHWeNHIbYVpp1nIGirR1c/2rYtS3X0TTCkxphnm
         WKT4y7Ws2bM+Nlpb72GQzNLhJs42pJ8qDZoXjNYLPXkO5sK3268XQnKSsYdseYWYwSw/
         Glk5izJ124kY8oiDCDKlBBZvJHA+6I2igikyo65RRSfuh187jqpntjh5055uVm8mBEDr
         EcsCIHmEPvlxp3LKchqZfmdEOMpgqm6hWZUBTjPU83q7mHrM/6bjp7ieE93qLdngrbJN
         xgJg==
X-Forwarded-Encrypted: i=1; AJvYcCXMn9MXkUiV3UMLp8KClzNDTjCL3PIiC1s4ZvKbvRagfslFpe1lWk8UC1AxcwpJQTgZYAurQRf3UGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMaVi1FcnM1koKKKweykScU/9YsaixOd2ZgljE+m4c8m7kN9lO
	GQMylZvZUHpDGThL+AW+DvWNJLUOlCcwKVUpSxAEmyGm/y6WF/S/JFz2oBdWBI3AwK0=
X-Gm-Gg: ATEYQzwKlI5Gm9xg2Y0JOiKH5pMkaEL5EECPUTKuc1qQpIGpx5VHdRPF5BIKz6y+sNx
	B5lOmQS7Ox5NnKRfeu40Q/Crbg4/cITTkXSefQj/DeRkv/Tuk8XSmIuhotpXWh7Gh4fH8OxlfTR
	uEvVFkwXEmpyIqha1Mz1omY4K6xUhUPn/2TSJ5zf2zc+BXXdRnI+X7ACkvHIcletkfnYZ41uack
	aalFbNaNh4uchVwDEzX01gFGpvM6yEnypTS7BrJ7B5PuT7BVdC8CGwDkSQossmNdo870VLk+ltU
	0JXkQiFA/x5lHdUEq0O6897ToJeOClnbmDSVW8/f/hQO+vxWlI78qQGn2788giJUEp901wiSnGo
	RpSpgQi7aymCsE0ZY1VMzpsjgk2QUa3FYXuiR67Nv3daIhjGR+pONrCTfXjgp8XSnlRv41Gp18e
	V833fpJy7dzB+jQmxVZSkOttPKP3IKjC3OIIFm
X-Received: by 2002:a05:600c:699a:b0:471:700:f281 with SMTP id 5b1f17b1804b1-483c9bf44e8mr197437165e9.25.1772459441532;
        Mon, 02 Mar 2026 05:50:41 -0800 (PST)
Received: from [172.19.170.194] ([213.233.104.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd68826asm661190265e9.0.2026.03.02.05.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 05:50:41 -0800 (PST)
Message-ID: <2c90cc6b-906f-4251-9e72-4c70cfa648ae@tuxon.dev>
Date: Mon, 2 Mar 2026 15:50:39 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] dmaengine: sh: rz-dmac: Add
 device_{pause,resume}() callbacks
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
 fabrizio.castro.jz@renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
 <20260120133330.3738850-9-claudiu.beznea.uj@bp.renesas.com>
 <aZ8oD_kcEE6lrTDC@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <aZ8oD_kcEE6lrTDC@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	TAGGED_FROM(0.00)[bounces-9174-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxon.dev:mid,tuxon.dev:dkim,renesas.com:email]
X-Rspamd-Queue-Id: 0BDA91DA2DF
X-Rspamd-Action: no action

Hi, Frank,

On 2/25/26 18:49, Frank Li wrote:
> On Tue, Jan 20, 2026 at 03:33:30PM +0200, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add support for device_{pause, resume}() callbacks. These are required by
>> the RZ/G2L SCIFA driver.
> 
> "These are required by the RZ/G2L SCIFA driver", is not good enough. Can
> you descript why RZ/G2L SCIFA require it?

Sure, I'll update it.

Thank you,
Claudiu

