Return-Path: <dmaengine+bounces-10262-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPRbEeGI/GleRAAAu9opvQ
	(envelope-from <dmaengine+bounces-10262-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 14:43:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCBF4E857F
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 14:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DFBB300EC92
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 12:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683443EE1DC;
	Thu,  7 May 2026 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivYdaGlo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA33E9280;
	Thu,  7 May 2026 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157787; cv=none; b=WpR4bB7uvAoIOqA7YnmPK2xlh/VA7UywnQHNGkob4JyG3/Oc1RMMv38Twle5gM1U64FDCR+jr2SnBQ0i34cbt+D5DVtAjab8N1ww7haBKvdSeZnbtw6k8lIhtULUKINrfETpKdsIZ4Cdtq8hFJBptAfYrCiSIHvjtvquJG/28I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157787; c=relaxed/simple;
	bh=KcJZ2tQuXM3g8y12mvLrPHW/18cvpRwsmiGbk6LCNUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPAkgn822TlgaVoeVSJUj8PyOz6nrWjC6S2EXVaKnLoA7B4w+GN/xOk/1bJ7XbJ/1lMCMlPNTzc2hwtz2S5mEuPLBiUtSVZvMP3HaxTp69l6gbCtKiMydl8afScCpfUA0/J1wj9T5mXnmN4fQ6N2yMYBNyO9ECjgxcHpCX6YbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivYdaGlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C71C2BCB2;
	Thu,  7 May 2026 12:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778157786;
	bh=KcJZ2tQuXM3g8y12mvLrPHW/18cvpRwsmiGbk6LCNUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ivYdaGloqHxvmfWXSxe1ELUU+RwECDQ3Ot2aFXb4yrVAQge39ukfDNjlED2qvSaZs
	 oSt9fjlj41wvhoEbVNAed0bzuECz1Oa95CYmBbYRw0rA0lZ8l9e/vqg/NeLtwbC19N
	 3hYoFNUyTffpG57XqltsjWbSULV11ZgH5g7UwlzF1x7ugsFp30oZACYww61xrFhatG
	 KoRJQygv77yLSMgafEG2DAH28LcK6ci1wOLt30Yz6lU12saNClOW9EhizsmcbNgdgT
	 jT4aUZyOu/eFs9CUbXRH7QpgIJoU/ZtJIIgNJ7J0HyBjmQjfOVOs6ABn8AUS1lo8s4
	 e7SElQxE0X/ug==
Message-ID: <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
Date: Thu, 7 May 2026 22:43:01 +1000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
To: Arnd Bergmann <arnd@kernel.org>, linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-can@vger.kernel.org, linux-spi@vger.kernel.org,
 Vladimir Oltean <olteanv@gmail.com>,
 Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org>
 <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com>
Content-Language: en-US
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AFCBF4E857F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,baylibre.com];
	TAGGED_FROM(0.00)[bounces-10262-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerg@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Arnd,

On 7/5/26 05:12, Arnd Bergmann wrote:
> On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> 
>> drivers/dma/mcf-edma-main.c
>>    Supports big-endian access by setting the big-endian flag of
>>    the drivers struct fsl_edma_engine. But locally should be using
>>    ioread32be() and iowrite32be() instead of ioread32() and iowrite32().
> 
> I'm still a bit confused about how this works at the moment,
> since the drivers/dma/fsl-edma-common.h file already contains
> checks for the edma->big_endian flag, which is set in
> mcf_edma_probe(). The version after your patch makes sense
> to me, but it looks like the existing code cannot work.

Yes, it certainly doesn't look right to me either.

Angelo: you look to be the original author of this driver, can you shed any
light on its working status in mainline currently?


>> drivers/spi/spi-fsl-dspi.c
>>    Setting the regmap format_endian flags to use native endian will
>>    force driver to use appropriate big or little endian access on
>>    whatever platform it is built for.
>>
>> These drivers have only been compile tested.
> 
> I would suggest marking these as explicit BIG_ENDIAN rather than
> NATIVE_ENDIAN. The effect should be the same since coldfire CPUs
> cannot run little-endian code, but the way that hardware usually
> works is that the endianess is fixed at the bus level to one way
> or the other. NATIVE_ENDIAN to me implies that the registers
> have configurable endianess that is switched along with the CPU
> mode.

Ok, will change. I chose native endian in this case since the regmap config
entry used for the m5441x family is also used by the vf610 devce (which looks
to be an ARM imx SoC). So it will need a duplicate setup with those endian
flags set to BIG_ENDIAN. But that is no problem.

Thanks
Greg


