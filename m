Return-Path: <dmaengine+bounces-8088-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCAFCFDE1F
	for <lists+dmaengine@lfdr.de>; Wed, 07 Jan 2026 14:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D4AD3002D32
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jan 2026 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D3C325483;
	Wed,  7 Jan 2026 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="d1UgUm2O"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D260316917
	for <dmaengine@vger.kernel.org>; Wed,  7 Jan 2026 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791863; cv=none; b=Sg7OjZdJVEternudGZjAyE/8wgBHbajI3tyGlyxE9OaB7dHIjxqXE1tKwUWPG/Xg3rbycgsBWc86uy7mUgrS28w0m6Weoz2Yi/4d4CX0g8RNwoUyBRkIpI0OXJszgIMeTFbTtlNhHeASebzLRlXxr3Y7WJOJ2OM23rempYd8idk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791863; c=relaxed/simple;
	bh=Ta1CNBpjyIuGYVDlwbXNMXWi/ajyIZa+LtJ//9NdvFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPKzPxLxEcM2yvXz29d43J3fgqgUAnq2dDXxo9lmiC3sZk8tmLwtwkfAwROoT7aZ6sKxOexpbmCaY3oV3qGbOiD2fEJ9Xv9v6VtH+iKsXjHlVWYpbRb4NtoTwxEIzCyCqmETcqUQ60RZnC8LSk/wtv9NKut3Nco0inTkhZ4iWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=d1UgUm2O; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso3037672a12.0
        for <dmaengine@vger.kernel.org>; Wed, 07 Jan 2026 05:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767791859; x=1768396659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kNVJPPyAEUALyNo8R8XvphVqSv0SiAbJB+jwRcXaR20=;
        b=d1UgUm2OY9CNfiI+ELiGEj3VPqt11qDsGO1Q8Q5g9eZL7RQl3A5bnB1O//P5o2tzqa
         +FD8s+NGq1Ikj/60DZhioeg+N8eLxL8jVXMc9GxrOGucE2P3/hQ0lWjOa5o2HmgZPB4N
         UgicxZAvrhD9dPguo2N1ccnvyEzUhbncH8kQcD4qcbJxelhTk2ojHS7RwHiVyzbtpX45
         63LQcSL9l83aPnS628rL2g1dKV/pSqvNNtJyi43h4Bgx/QvFVAMTT7XiB7Bp5pJ33fyp
         gNYK7NQxvL2Mm6MIXc2vhNXReBroZVeXNcPcJnmBIMLcAxUb3Xb1TzYXmh+0zv624EIA
         5zOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767791859; x=1768396659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNVJPPyAEUALyNo8R8XvphVqSv0SiAbJB+jwRcXaR20=;
        b=Rfa5yhYJMeCVSsIotayWPAnf2WgRDV/pIaHloH+RaFIXJSiVRh16g41SgYWDPnr7pM
         /lCcC2be8VDK7sBSnvpAnZYmUSuICq4NxSzZWgfCEYgxk4qxB4Z4TP2FDmpxVeD1Pnu/
         WeZU0DCepmRzwvwS1YE5uf0O8y3NS/UaP8VTJhpGyKEIy2bRHogZyduiC99VvwTnvI2X
         W7yJ40mXIZx3rVa+dmUaTgPXFONOOaZtMtg6SLpvivWczwdHBSMw18lZNolCureJesQD
         2FzW2WfVe2kf9513LI12WpHeqbt+vUsgl5GG3D/+Sz+yxe7acdYq2oVvx5R3Q+uMN1D0
         hgLw==
X-Gm-Message-State: AOJu0YzMXONI7p5aj1uxJrU4yPuZ/ckJNZiApN0OY6KB/C31fW2Ks7G7
	CNJmxGo/5/sjjZgW4ZufzYqV6WFsxJbkzeCrg+ckQrI+ess+FJHmFzuP/GSi3RqB/ag=
X-Gm-Gg: AY/fxX5lZEmDVlwQD4OocDyOSo1Xe9FT0xxbxNO/+H4XMgUYsz6Qit9gdJQCIMCCNij
	OaWveuEUx0zo+oWkswc85vMGlhPmLiPHpPTCSy/Td+cQdA1gddWrMYBt5xkBIejfvbvcZOxmbnp
	+/zen0u4GWtVfjGOQes6TlS05ioI6O5LLGgYatw61CScektwpxJGDMgOW5eTZH7WUetl9nHgyCe
	l8MEIsfSir+ng2pPiNMt9cIZxaQSD7rw0QHRbPZQx0n/5UQ2aSjfnDoJXZqUfnXN3+148cuP0jS
	G5M8sSfVSS2/iwomsDAobLXKBPrCmodwGsCPngzL6Q2FRCo0v2GE372N/i5/u+RhNN1uaSaE961
	duHMlPjQMF+XVlY5YKkxn+U8wzMAsB//ONDsRuCsSDVOco4hyMeYt1fxF5piGLy4v6QjoNYHsTa
	e7n0OEB8ievKMkPSyL5BWQmo5l8G9r
X-Google-Smtp-Source: AGHT+IFsuLM4Za/2J/KXS68VnXcnS5fndDPv1yTRssofUsxeHt6pKUZ/ipEHoD1ZKXNFAxrfAzq3TQ==
X-Received: by 2002:a17:907:7254:b0:b84:408d:b7f4 with SMTP id a640c23a62f3a-b8444fd36c9mr220892766b.50.1767791858563;
        Wed, 07 Jan 2026 05:17:38 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56db16sm505237666b.70.2026.01.07.05.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 05:17:38 -0800 (PST)
Message-ID: <c0a76fcf-8dca-4268-9d07-b5bae8c26c46@tuxon.dev>
Date: Wed, 7 Jan 2026 15:17:37 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] dmaengine: sh: rz-dmac: Add
 device_{pause,resume}() callbacks
To: Biju Das <biju.das.jz@bp.renesas.com>, "vkoul@kernel.org"
 <vkoul@kernel.org>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
 <20251223134952.460284-9-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113466CA0EB792BF134502A7986B5A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113466CA0EB792BF134502A7986B5A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 12/23/25 16:43, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: 23 December 2025 13:50
>> Subject: [PATCH v6 8/8] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add support for device_{pause, resume}() callbacks. These are required by the RZ/G2L SCIFA driver.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v6:
>> - set CHCTRL_SETSUS for pause and CHCTRL_CLRSUS for resume
>> - dropped read-modify-update approach for CHCTRL updates as the
>>    HW returns zero when reading CHCTRL
>> - moved the read_poll_timeout_atomic() under spin lock to
>>    ensure avoid any races b/w pause and resume functionalities
>>
>> Changes in v5:
>> - used suspend capability of the controller to pause/resume
>>    the transfers
>>
>>   drivers/dma/sh/rz-dmac.c | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 44f0f72cbcf1..377bdd5c9425
>> 100644
>> --- a/drivers/dma/sh/rz-dmac.c
>> +++ b/drivers/dma/sh/rz-dmac.c
>> @@ -135,10 +135,12 @@ struct rz_dmac {
>>   #define CHANNEL_8_15_COMMON_BASE	0x0700
>>
>>   #define CHSTAT_ER			BIT(4)
>> +#define CHSTAT_SUS			BIT(3)
>>   #define CHSTAT_EN			BIT(0)
>>
>>   #define CHCTRL_CLRINTMSK		BIT(17)
>>   #define CHCTRL_CLRSUS			BIT(9)
>> +#define CHCTRL_SETSUS			BIT(8)
>>   #define CHCTRL_CLRTC			BIT(6)
>>   #define CHCTRL_CLREND			BIT(5)
>>   #define CHCTRL_CLRRQ			BIT(4)
>> @@ -827,6 +829,38 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
>>   	return status;
>>   }
>>
>> +static int rz_dmac_device_pause(struct dma_chan *chan) {
>> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
>> +	u32 val;
>> +	int ret;
>> +
>> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> 
>> +		rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
> 
> 
> Probably first you need to check CHSTAT_EN first before setting CHCTRL_SETSUS??
> 
> As per the hardware manual
> 
> "
> Suspends the current DMA transfer. Setting this bit to 1 when 1 is set in EN of the
> CHSTAT_n/nS register can suspend the current DMA transfer."

OK, I'll update it as follows:

static int rz_dmac_device_pause(struct dma_chan *chan)
{
	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
	u32 val;

	guard(spinlock_irqsave)(&channel->vc.lock);

	val = rz_dmac_ch_readl(channel, CHSTAT, 1);
	if (!(val & CHSTAT_EN))
		return 0;

	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
					(val & CHSTAT_SUS), 1, 1024,
					false, channel, CHSTAT, 1);
}

This avoids timeouts reported by read_poll_timeout_atomic() when pause 
is set for a disabled channel.

> 
> 
>> +		ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
>> +					       (val & CHSTAT_SUS), 1, 1024,
>> +					       false, channel, CHSTAT, 1);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int rz_dmac_device_resume(struct dma_chan *chan) {
>> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
>> +	u32 val;
>> +	int ret;
>> +
>> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> 
> 
>> +		rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
> 
> 
> Similarly, first you need to check  CHSTAT_SUS bit first and then clear suspend state.
> 
> 
> Clears the suspend status. Setting this bit to 1 when 1 is set in SUS of the
> CHSTAT_n/nS register can clear the suspend status.

I'll update this one as follows, to keep the code simple:

static int rz_dmac_device_resume(struct dma_chan *chan)
{
	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
	u32 val;

	guard(spinlock_irqsave)(&channel->vc.lock);

         /* Do not check CHSTAT_SUS but rely on HW capabilities. */
	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
					!(val & CHSTAT_SUS), 1, 1024,
					false, channel, CHSTAT, 1);
}

With this:

1/ in case the channel is not suspended and the CHCTRL_CLRSUS is set, 
the read_poll_timeout_atomic() will not timeout, as the default value of 
the CHSTAT_SUS is zero.

2/ in case the channel is suspended and the CLRSUS is set, it is 
behaving as expected but without an extra check of the CHSTAT_SUS bit 
before setting CHCTRL_CLRSUS.

Thank you,
Claudiu

