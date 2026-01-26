Return-Path: <dmaengine+bounces-8511-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFJfCWV/d2m9hgEAu9opvQ
	(envelope-from <dmaengine+bounces-8511-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 15:51:17 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14B889BD4
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 15:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8910230038CD
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50681242D6A;
	Mon, 26 Jan 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TDASyS/7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECC72550D4
	for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438784; cv=none; b=na2qqNUHT3J9ltOCOzf5465IrOH3oLKcIbqCK/8jP798jdrB8JlGFFi0nE888pGluiFcy6EzAhT3EeKPaFSVT7+tPs7wgMPj1IwJ+P9sZ0/dlKgi4RL4ErQI9DLRESZW3Mh5g8Uj02wMP0TOVcB0Q3YtkvDHJjPTXvjbdXMxu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438784; c=relaxed/simple;
	bh=2IbRV9YOig8uEtdAcRc53kp6dqCuCW21kS1SlTHoqkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8LjXICqeB9plTKNwF7CRA7xPtShzEk7Ew2JSdSBGwtR4P7nMwn1Qiz4EtsCQZqpz+AreMk8KAPBKh1Eoa9p1vBCtx3KD+Fs0+oNrooRu07bey7qQDd4SJFAN9MAWspyp5kTD3/BKx9gApDZ/tSehyZRPhU0aQG5as+R2Z7b3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TDASyS/7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso36408515e9.1
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 06:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769438780; x=1770043580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pm0AyqOIj5dF9Te7g3FRe5p926c2ixXy2A4BKSh5SP8=;
        b=TDASyS/7sKqz1cSLh29SqZ8cACfCu8S4ziTR8DArMLfvIVesEYns/z+FaNQ7GqmP88
         1y2JUK/8VZz0AvJ1XTREdw99JpKm41AFHJB2Lr8mG1V3TJWACUJSPKxUY9Vr48eRtk3b
         CHrM+fVzjZdhhQgwrNqBqPl6TVbWmtEpG7JqsCKQeLWxhSDkDC0fqu3VLWoT/blb/iL+
         Ery4zo1UK2j3SSbCdkn3hTuuwFkUn2i6IlCWgsyKz/m9vkJ4o9HMGDLcDDcy0wjyJSku
         hSsHzMtPNtwza0RM2IiIOZMOvwAQG/1Aqvx9GBGT6p4Fu+1Tb6tRreswnXNQjV+Q/ZtN
         TSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769438780; x=1770043580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pm0AyqOIj5dF9Te7g3FRe5p926c2ixXy2A4BKSh5SP8=;
        b=g9XAJ6slHbPDlYmV9/VtPM7n8hbo7re162eJUPReMe9Kp5Dai8KTg3dGhmFpBwzkqO
         M2d0MXAWY/pU16oBt9/ejuGvR6NMXUFjbq+Io9y8gxyJ3ujDIQdAyghx4bnNhowsGTJk
         EkF5YTjXkL3JTzoJpx1LRhd3JirwSljb8o454Q/z7ZDGRzaRQaq3Vjca4mEu338hKY5O
         UMoJvQ3i3Gb1SHXHlo3Dcpw50HeYMa0G1qAdXISsRLd4/P9wQKKtd2bwqSfJKd+jbo8i
         TfEv+k1RVnz86CKHIVC8ddKHu3GIEKMK8hNRj7U+KFtcjVsSg0TmkO4JI7kW+W2OXV1j
         +2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVcVRqCTmdnOaULiHEHlxhcXs9zt7t8zoGszgCoMQ93yogm4BXF2h3Jrnl0u0+aUjD+avkeIRbrqBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOz/qXx/QQdrypPU79QdmnVaFXwh2poJnH7NYXBY/Wh2uUdNor
	qmTZTNU3yC17Q+VoaZGUaegIGuzD4rfusi8d7ctxKqZDmlmn/WMRqvKMNW02IlP7L3k=
X-Gm-Gg: AZuq6aLO3NRNQiBEdFdS+Bv8PgkbRQGFzcVKp+bU4cW1amslyoHSa4a0mdmCv7tvIYQ
	u+3G6FBxbL4H1Kluvn/Mb17yqH8jC45jqzetuG9C3llRr99/CMsj4VBuZAAhiyz1KJzsI1I1/kN
	P+g8O1gtk8R9ygydBZ/AyV5Kpgm5GksC+Qx1LJiNlPPgZZUOANtXAcCTSl88yFBvo6PRWWad4aj
	juLSmOUMvj9Lz6FG1tnY6gxLpNaoTHEfNcyS5Qx6BcnetoAADv2zhYVe1HFVJ0hFPNlIZ8BDSFQ
	O7qct0MSsmKK0eDsO0BZDYDdu/atWkGPMcs7e9IXb82iM3cqHxFY+muak/w/2lNvvpt+yS0FAFE
	rao9lQcxyNBBGrgGWEXN5Y/qmSw+vFVJx3hWlJwDz1Qb03JxhKz+W/NLZfH1u2Rf9ganTqA94tA
	Yb1TVJLjygtVy8grpyLA==
X-Received: by 2002:a05:600c:4fc6:b0:47e:e72b:1fce with SMTP id 5b1f17b1804b1-4805d06a5edmr62679165e9.37.1769438779698;
        Mon, 26 Jan 2026 06:46:19 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85206fsm283271695e9.6.2026.01.26.06.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 06:46:19 -0800 (PST)
Message-ID: <74692e8a-220f-4248-9481-81bb331597f1@tuxon.dev>
Date: Mon, 26 Jan 2026 16:46:16 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: vkoul@kernel.org, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, p.zabel@pengutronix.de,
 fabrizio.castro.jz@renesas.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
 <20260126103155.2644586-7-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWhY7nNanQ=h8HGrWyDfpCSL33QFJorhLCgnKASbmHiYw@mail.gmail.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdWhY7nNanQ=h8HGrWyDfpCSL33QFJorhLCgnKASbmHiYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8511-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,renesas.com,vger.kernel.org];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tuxon.dev:email,tuxon.dev:dkim,tuxon.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C14B889BD4
X-Rspamd-Action: no action

Hi, Geert,

On 1/26/26 16:26, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Mon, 26 Jan 2026 at 11:32, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> On Renesas RZ/G2L and RZ/G3S SoCs (where this was tested), captured audio
>> files occasionally contained random spikes when viewed with a profiling
>> tool such as Audacity. These spikes were also audible as popping noises.
>>
>> Using cyclic DMA resolves this issue. The driver was reworked to use the
>> existing support provided by the generic PCM dmaengine APIs. In addition
>> to eliminating the random spikes, the following issues were addressed:
>> - blank periods at the beginning of recorded files, which occurred
>>    intermittently, are no longer present
>> - no overruns or underruns were observed when continuously recording
>>    short audio files (e.g. 5 seconds) in a loop
>> - concurrency issues in the SSI driver when enqueuing DMA requests were
>>    eliminated; previously, DMA requests could be prepared and submitted
>>    both from the DMA completion callback and the interrupt handler, which
>>    led to crashes after several hours of testing
>> - the SSI driver logic is simplified
>> - the number of generated interrupts is reduced by approximately 250%
>>
>> In the SSI platform driver probe function, the following changes were
>> made:
>> - the driver-specific DMA configuration was removed in favor of the
>>    generic PCM dmaengine APIs. As a result, explicit cleanup goto labels
>>    are no longer required and the driver remove callback was dropped,
>>    since resource management is now handled via devres helpers
>> - special handling was added for IP variants operating in half-duplex
>>    mode, where the DMA channel name in the device tree is "rt"; this DMA
>>    channel name is taken into account and passed to the generic PCM
>>    dmaengine configuration data
>>
>> All code previously responsible for preparing and completing DMA
>> transfers was removed, as this functionality is now handled entirely by
>> the generic PCM dmaengine APIs.
>>
>> Since DMA channels must be paused and resumed during recovery paths
>> (overruns and underruns), the DMA channel references are stored in
>> rz_ssi_hw_params().
>>
>> The logic in rz_ssi_is_dma_enabled() was updated to reflect that the
>> driver no longer manages DMA transfers directly.
>>
>> Finally, rz_ssi_stream_is_play() was removed, as it had only a single
>> remaining user after this rework, and its logic was inlined at the call
>> site.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/sound/soc/renesas/rz-ssi.c
>> +++ b/sound/soc/renesas/rz-ssi.c
> 
>> @@ -1116,15 +936,19 @@ static struct snd_soc_dai_driver rz_ssi_soc_dai[] = {
>>   static const struct snd_soc_component_driver rz_ssi_soc_component = {
>>          .name                   = "rz-ssi",
>>          .open                   = rz_ssi_pcm_open,
>> -       .pointer                = rz_ssi_pcm_pointer,
>> -       .pcm_construct          = rz_ssi_pcm_new,
>>          .legacy_dai_naming      = 1,
>>   };
>>
>> +static struct snd_dmaengine_pcm_config rz_ssi_dmaegine_pcm_conf = {
>> +       .prepare_slave_config   = snd_dmaengine_pcm_prepare_slave_config,
> 
> This fails to link if CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM is not
> enabled (e.g. renesas_defconfig):
> 
>      aarch64-linux-gnu-ld: sound/soc/renesas/rz-ssi.o: in function
> `rz_ssi_probe':
>      rz-ssi.c:(.text+0x538): undefined reference to
> `devm_snd_dmaengine_pcm_register'
>      aarch64-linux-gnu-ld: sound/soc/renesas/rz-ssi.o:(.data+0xc8):
> undefined reference to `snd_dmaengine_pcm_prepare_slave_config'
> 
> Adding a select like this white-space damaged snippet:
> 
>      --- a/sound/soc/renesas/Kconfig
>      +++ b/sound/soc/renesas/Kconfig
>      @@ -56,6 +56,7 @@ config SND_SOC_MSIOF
>       config SND_SOC_RZ
>              tristate "RZ/G2L series SSIF-2 support"
>              depends on ARCH_RZG2L || COMPILE_TEST
>      +       select SND_SOC_GENERIC_DMAENGINE_PCM
>              help
>                This option enables RZ/G2L SSIF-2 sound support.
> 
> would fix the build.

Thank you for reporting and proposing a fix. I'll take care of it in v2.

Claudiu

