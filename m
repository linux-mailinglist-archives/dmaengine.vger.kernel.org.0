Return-Path: <dmaengine+bounces-8502-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHDjB2ZYd2lneQEAu9opvQ
	(envelope-from <dmaengine+bounces-8502-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 13:04:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7095387FA8
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 13:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CC68300F9EE
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A073346AD;
	Mon, 26 Jan 2026 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="meJPz8jE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202C334C1D
	for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429091; cv=none; b=HFDQHr1WhtL5MW6nUp7ak6dV6tBMMI9GUtcITZmICY1apiFvaV8sb7ZTzHmFFrAu/4mo7Now07cfb9kyndf/Ve7eZ4cU89G9eI+E44X2YHrofAUhRqFhZ0wSNLRJd6nvxCPz8YkJZOIBJzLyZqddRD4JTQLyK6xP+C+FvbabsqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429091; c=relaxed/simple;
	bh=02flGXJqK2mqeZ2EJtosEcym4C5fBaxvNzGfcMhAzTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUGYCSvZHRcaS6sm55k0/RF5G1BVZjNvwsy4J/4KCBOXTRpcPwbDUUanW6xgK2XtNsYj6PaPSx8YZWvfUL5HS2HW9CMcE4zL3pK6zG30K6OCb+qI3kg0cnKVxxMmaVXmRuLnjsf8mylXew9tLiN3j0qG4mzSwgcCRzVf3aiQm2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=meJPz8jE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47f3b7ef761so31617725e9.0
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 04:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769429085; x=1770033885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+i4rhKXwALaAWmX3Kdv+voAHyfvVqUS2Gq3G94PEDQ=;
        b=meJPz8jE+J7h6KsK+6+mahxnGJMfx2ea65qnMoS0PEXh0NVr8M+xNl/vY6StYjNNx5
         YKsa3m6LUBDfH6lYhk8/4NRiKUnms0+sa9LNUvcBq81z2YeKMnuCIa5obBVUkKz3XH8G
         cgkmf7TRcrowsICHj7+7wSU8bQTWRXL6uCfWVDIAgDAy9ZTkLtvegQavzY1XK9Av9ymj
         JqWdXeVUJuduIMM4/Exjo7EEd3Byk3iQ/kph7CBHbNNXm78CsypC0DKpIW8xVk5HIUGi
         qe8INJzMRGXoRcGk7SxO6DyL2/Ef8VEHSUm49aK9NnYHax3aheQ2T1UcsV2FVUzL3/pw
         NRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769429085; x=1770033885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+i4rhKXwALaAWmX3Kdv+voAHyfvVqUS2Gq3G94PEDQ=;
        b=WWvuisCWrva8216wsSD2LxQGC+2IGiQp+2iIJLRWwIBWsEc0TcnAOmu823I/pTvBj2
         v6gd9eXHQkqAbkz2MJwDRoILo/g0hqp8rT/a6qSjv2Woi+INngRSXPTi4RFOURLZOO3T
         OFBAqa72JrnArA1LUdrXt222oJhBV5r9oalAm+GhRj1JIXylXvQ5T3v7dmTxrQc6m7u4
         /ahi8KbmjwlQHFpAaBBRw0nJpuZ68iklAcFGEmqAjtW+7veBBOIp9F5PMekWKq1LX+aO
         88gEN3H/rmKVZu+5wrffWmtEWN94oSTix4sOvU1/dV99KTmSH6Ku8N5LkGk5NQRf3TIh
         usKw==
X-Gm-Message-State: AOJu0YzNtKuxg2E8BnQ/UE4JAOhkxboFJgYUnydkpyLuBw26/uWoYFBZ
	tByS6+daqAMDB+Z74Ur6dm/047qoAQcUAkYoXxzq6KBnFY6T1KLLNVX/BWlaQFD6Q5M=
X-Gm-Gg: AZuq6aIEkS4tpWxpJf6HfbI7+YtvfSQW1TBN79RNVyz22jvHCMDmqw+Oc0PRobI1Tg9
	OJOO846gf2C3+tiX3teqntqPJe4ZwjmsTgdITe7FutaSvqX3BBTgHO7ZB4NhpvpZHnNWoqJytHC
	Fr00CqBLxIP2xw3npsXby/rwNv+OJPHmxNgQdxpo5tY/qDwU5BUQbKv7wJtHLtPGcVP6WzMT47C
	g9QBnyliyRiOuNfbSXlSFNshHxDhgwMi4FkQZuAf2IW3SDnh0pBNBc6oUSRKb+ZuBpZn98PzIR3
	wyPQVBRQCwl2t9w5EaHebLCcVp/rsLBuHjg48x5g88wvmlkO+/pl3kANWAhiVmtR5h/CmYfk5UX
	BcspmG/PzNKWezS4scfJsV9M4RTDVrH7gjXMcWCQICkJob2a6vNVe9XeanUa+OKgO4DBH5w7WWo
	VQiljNJAG5mw2dtoyO2A==
X-Received: by 2002:a05:600c:1c13:b0:480:1a22:fce8 with SMTP id 5b1f17b1804b1-4805d0645cemr67629735e9.26.1769429085019;
        Mon, 26 Jan 2026 04:04:45 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85206fsm272641375e9.6.2026.01.26.04.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 04:04:44 -0800 (PST)
Message-ID: <16a6f14a-93e6-472c-8718-d46972f0ac5e@tuxon.dev>
Date: Mon, 26 Jan 2026 14:04:42 +0200
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
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113461F734BA087B60605C6FC8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
	TAGGED_FROM(0.00)[bounces-8502-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxon.dev:email,tuxon.dev:dkim,tuxon.dev:mid,bootlin.com:url,renesas.com:email]
X-Rspamd-Queue-Id: 7095387FA8
X-Rspamd-Action: no action

Hi,

On 1/26/26 13:03, Biju Das wrote:
> Hi Claudiu,
> 
> Thanks for the patch.
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: 26 January 2026 10:32
>> Subject: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S SoC supports a power saving mode in which power to most SoC components is turned
>> off, including the DMA IP. Add suspend to RAM support to save and restore the DMA IP registers.
>>
>> Cyclic DMA channels require special handling. Since they can be paused and resumed during system
>> suspend and resume, the driver restores additional registers for these channels during the resume
>> phase. If a channel was not explicitly paused during suspend, the driver ensures that it is paused and
>> resumed as part of the system suspend/resume flow. This might be the case of a serial device being
>> used with no_console_suspend.
>>
>> For non-cyclic channels, the dev_pm_ops::prepare callback waits for all ongoing transfers to complete
>> before allowing suspend-to-RAM to proceed.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>   drivers/dma/sh/rz-dmac.c | 183 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 175 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index ab5f49a0b9f2..8f3e2719e639
>> 100644
>> --- a/drivers/dma/sh/rz-dmac.c
>> +++ b/drivers/dma/sh/rz-dmac.c
>> @@ -69,11 +69,15 @@ struct rz_dmac_desc {
>>    * enum rz_dmac_chan_status: RZ DMAC channel status
>>    * @RZ_DMAC_CHAN_STATUS_ENABLED: Channel is enabled
>>    * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
>> + * @RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL: Channel is paused through
>> + driver internal logic
>> + * @RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED: Channel was prepared for system
>> + suspend
>>    * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
>>    */
>>   enum rz_dmac_chan_status {
>>   	RZ_DMAC_CHAN_STATUS_ENABLED,
>>   	RZ_DMAC_CHAN_STATUS_PAUSED,
>> +	RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL,
>> +	RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED,
>>   	RZ_DMAC_CHAN_STATUS_CYCLIC,
>>   };
>>
>> @@ -94,6 +98,10 @@ struct rz_dmac_chan {
>>   	u32 chctrl;
>>   	int mid_rid;
>>
>> +	struct {
>> +		u32 nxla;
>> +	} pm_state;
>> +
>>   	struct list_head ld_free;
>>   	struct list_head ld_queue;
>>   	struct list_head ld_active;
>> @@ -1002,10 +1010,17 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
>>   	return rz_dmac_device_pause_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);  }
>>
>> +static int rz_dmac_device_pause_internal(struct rz_dmac_chan *channel)
>> +{
>> +	lockdep_assert_held(&channel->vc.lock);
>> +
>> +	return rz_dmac_device_pause_set(channel,
>> +RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL);
>> +}
>> +
>>   static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
>>   				     enum rz_dmac_chan_status status)  {
>> -	u32 val;
>> +	u32 val, chctrl;
>>   	int ret;
>>
>>   	lockdep_assert_held(&channel->vc.lock);
>> @@ -1013,14 +1028,33 @@ static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
>>   	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)))
>>   		return 0;
>>
>> -	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
>> -	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
>> -				       !(val & CHSTAT_SUS), 1, 1024, false,
>> -				       channel, CHSTAT, 1);
>> -	if (ret)
>> -		return ret;
>> +	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED)) {
>> +		/*
>> +		 * We can be after a sleep state with power loss. If power was
>> +		 * lost, the CHSTAT_SUS bit is zero. In this case, we need to
>> +		 * enable the channel directly. Otherwise, just set the CLRSUS
>> +		 * bit.
>> +		 */
>> +		val = rz_dmac_ch_readl(channel, CHSTAT, 1);
>> +		if (val & CHSTAT_SUS)
>> +			chctrl = CHCTRL_CLRSUS;
>> +		else
>> +			chctrl = CHCTRL_SETEN;
>> +	} else {
>> +		chctrl = CHCTRL_CLRSUS;
>> +	}
>> +
>> +	rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
>>
>> -	channel->status &= ~BIT(status);
>> +	if (chctrl & CHCTRL_CLRSUS) {
>> +		ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
>> +					       !(val & CHSTAT_SUS), 1, 1024, false,
>> +					       channel, CHSTAT, 1);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	channel->status &= ~(BIT(status) |
>> +BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED));
>>
>>   	return 0;
>>   }
>> @@ -1034,6 +1068,13 @@ static int rz_dmac_device_resume(struct dma_chan *chan)
>>   	return rz_dmac_device_resume_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);  }
>>
>> +static int rz_dmac_device_resume_internal(struct rz_dmac_chan *channel)
>> +{
>> +	lockdep_assert_held(&channel->vc.lock);
>> +
>> +	return rz_dmac_device_resume_set(channel,
>> +RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL);
>> +}
>> +
>>   /*
>>    * -----------------------------------------------------------------------------
>>    * IRQ handling
>> @@ -1438,6 +1479,131 @@ static void rz_dmac_remove(struct platform_device *pdev)
>>   	pm_runtime_disable(&pdev->dev);
>>   }
>>
>> +static int rz_dmac_suspend_prepare(struct device *dev) {
>> +	struct rz_dmac *dmac = dev_get_drvdata(dev);
>> +
>> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
>> +		struct rz_dmac_chan *channel = &dmac->channels[i];
>> +
>> +		guard(spinlock_irqsave)(&channel->vc.lock);
>> +
>> +		/* Wait for transfer completion, except in cyclic case. */
>> +		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_ENABLED) &&
>> +		    !(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
>> +			return -EAGAIN;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void rz_dmac_suspend_recover(struct rz_dmac *dmac) {
>> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
>> +		struct rz_dmac_chan *channel = &dmac->channels[i];
>> +
>> +		guard(spinlock_irqsave)(&channel->vc.lock);
>> +
>> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
>> +			continue;
>> +
>> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL)))
>> +			continue;
>> +
>> +		rz_dmac_device_resume_internal(channel);
>> +	}
>> +}
>> +
>> +static int rz_dmac_suspend(struct device *dev) {
>> +	struct rz_dmac *dmac = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	for (unsigned int i = 0; i < dmac->n_channels; i++) {
>> +		struct rz_dmac_chan *channel = &dmac->channels[i];
>> +
>> +		guard(spinlock_irqsave)(&channel->vc.lock);
>> +
>> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
>> +			continue;
>> +
>> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED))) {
>> +			ret = rz_dmac_device_pause_internal(channel);
>> +			if (ret) {
>> +				dev_err(dev, "Failed to suspend channel %s\n",
>> +					dma_chan_name(&channel->vc.chan));
>> +				continue;
>> +			}
>> +		}
>> +
>> +		channel->pm_state.nxla = rz_dmac_ch_readl(channel, NXLA, 1);
>> +		channel->status |= BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED);
>> +	}
>> +
>> +	pm_runtime_put_sync(dmac->dev);
>> +
>> +	ret = reset_control_assert(dmac->rstc);
>> +	if (ret) {
>> +		pm_runtime_resume_and_get(dmac->dev);
>> +		rz_dmac_suspend_recover(dmac);
>> +	}
>> +
> 
> 
> This patch breaks, s2idle in RZ/G3L as it turns off DMA ACLK and IRQ's
> are not routed to CPU for wakeup.

Is this particular patch the one that explicitly breaks it? Is there any 
mainline PM support available for RZ/G3L? Can it be fixed along with the RZ/G3L 
support, if any, as I don't have the board to test it?

Currently, this has been tested with RZ/G2L (no suspend to RAM support) and
RZ/G3S (that has suspend to RAM support).

> 
> DMA ACLK is required for routing IRQ to CPU, without this CPU won't get any interrupts.
> 
> If we make this CLK as critical clock, s2idle fails, as the DMA ALCK turned off during suspend
> and there is no IRQ to wake up the system.

How a critical clock is turned off durring suspend? Check clk core APIs to 
disable clocks:

https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/clk/clk.c#L1051
https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/clk/clk.c#L1191

Can you please check the clocks HW bits on suspend/resume? I have prepared a 
patch for you to check this:

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index c0584bab58a3..6da4a31ddb67 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1603,6 +1603,14 @@ static void rzg2l_mod_clock_init_mstop(struct 
rzg2l_cpg_priv *priv)
                 scoped_guard(spinlock_irqsave, &priv->rmw_lock) {
                         if (!rzg2l_mod_clock_is_enabled(&clk->hw))
                                 rzg2l_mod_clock_module_set_state(clk, true);
+                       else {
+
+                               struct mod_clock *clock = to_mod_clock(hw);
+                               struct rzg2l_cpg_priv *priv = clock->priv;
+                               unsigned int reg = clock->off;
+
+                               pr_err("%s(): CLK_ON 0x%x/%pC %x\n", __func__, 
CLK_ON_R(reg), hw->clk, readl(priv->base + CLK_MON_R(reg)));
+                       }
                 }
         }
  }
@@ -2055,6 +2063,27 @@ static int __init rzg2l_cpg_probe(struct platform_device 
*pdev)
         return 0;
  }

+static int rzg2l_cpg_suspend(struct device *dev)
+{
+       struct rzg2l_cpg_priv *priv = dev_get_drvdata(dev);
+       struct mod_clock *clk;
+       struct clk_hw *hw;
+
+       for_each_mod_clock(clk, hw, priv) {
+               scoped_guard(spinlock_irqsave, &priv->rmw_lock) {
+                       if (rzg2l_mod_clock_is_enabled(&clk->hw)) {
+                               struct mod_clock *clock = to_mod_clock(hw);
+                               struct rzg2l_cpg_priv *priv = clock->priv;
+                               unsigned int reg = clock->off;
+
+                               pr_err("%s(): CLK_ON 0x%x/%pC %x\n", __func__, 
CLK_ON_R(reg), hw->clk, readl(priv->base + CLK_MON_R(reg)));
+                       }
+               }
+       }
+
+       return 0;
+}
+
  static int rzg2l_cpg_resume(struct device *dev)
  {
         struct rzg2l_cpg_priv *priv = dev_get_drvdata(dev);
@@ -2065,7 +2094,7 @@ static int rzg2l_cpg_resume(struct device *dev)
  }

  static const struct dev_pm_ops rzg2l_cpg_pm_ops = {
-       NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, rzg2l_cpg_resume)
+       NOIRQ_SYSTEM_SLEEP_PM_OPS(rzg2l_cpg_suspend, rzg2l_cpg_resume)
  };

  static const struct of_device_id rzg2l_cpg_match[] = {


And this is what I'm getting when executing on my side:



root@smarc-rzg3s:~# echo enabled > /sys/class/tty/ttySC3/power/wakeup
root@smarc-rzg3s:~# echo N > /sys/module/printk/parameters/console_suspend
root@smarc-rzg3s:~# echo 7 > /proc/sys/kernel/printk
root@smarc-rzg3s:~# echo freeze > /sys/power/state
[   80.019374] PM: suspend entry (s2idle)
[   80.024173] Filesystems sync: 0.000 seconds
[   80.040934] Freezing user space processes
[   80.048238] Freezing user space processes completed (elapsed 0.007 seconds)
[   80.055260] OOM killer disabled.
[   80.058476] Freezing remaining freezable tasks
[   80.064400] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   80.137919] ravb 11c30000.ethernet end0: Link is Down
[   80.170875] rzg2l_cpg_suspend(): CLK_ON 0x514/gic_gicclk 1
[   80.176435] rzg2l_cpg_suspend(): CLK_ON 0x518/ia55_clk 3
[   80.181744] rzg2l_cpg_suspend(): CLK_ON 0x518/ia55_pclk 3
[   80.187137] rzg2l_cpg_suspend(): CLK_ON 0x52c/dmac_aclk 3
[   80.192528] rzg2l_cpg_suspend(): CLK_ON 0x52c/dmac_pclk 3
[   80.197971] rzg2l_cpg_suspend(): CLK_ON 0x584/scif0_clk_pck 1
[   80.203728] rzg2l_cpg_suspend(): CLK_ON 0x598/gpio_hclk 1
[   80.209136] rzg2l_cpg_suspend(): CLK_ON 0x614/vbat_bclk 1
[   83.307594] rzg2l_mod_clock_init_mstop(): CLK_ON 0x514/gic_gicclk 1
[   83.313889] rzg2l_mod_clock_init_mstop(): CLK_ON 0x518/ia55_clk 3
[   83.319975] rzg2l_mod_clock_init_mstop(): CLK_ON 0x518/ia55_pclk 3
[   83.326146] rzg2l_mod_clock_init_mstop(): CLK_ON 0x52c/dmac_aclk 3
[   83.332315] rzg2l_mod_clock_init_mstop(): CLK_ON 0x52c/dmac_pclk 3
[   83.338572] rzg2l_mod_clock_init_mstop(): CLK_ON 0x584/scif0_clk_pck 1
[   83.345102] rzg2l_mod_clock_init_mstop(): CLK_ON 0x598/gpio_hclk 1
[   83.351291] rzg2l_mod_clock_init_mstop(): CLK_ON 0x614/vbat_bclk 1
[   83.455408] rzg3s-pcie-host 11e40000.pcie: PCIe link status [0x100014e]
[   83.667239] nvme nvme0: 1/0/0 default/read/poll queues
[   83.730087] Microchip KSZ9131 Gigabit PHY 11c30000.ethernet-ffffffff:07: 
attached PHY driver (mii_bus:phy_addr=11c30000.ethernet-ffffffff:07, irq=59)
[   83.814109] Microchip KSZ9131 Gigabit PHY 11c40000.ethernet-ffffffff:07: 
attached PHY driver (mii_bus:phy_addr=11c40000.ethernet-ffffffff:07, irq=61)
[   83.917155] usb usb2: root hub lost power or was reset
[   83.922361] usb usb1: root hub lost power or was reset
[   84.013163] usb usb4: root hub lost power or was reset
[   84.018358] usb usb3: root hub lost power or was reset
[   84.199309] usb 1-1: reset high-speed USB device number 2 using ehci-platform
[   84.457446] OOM killer enabled.
[   84.460679] Restarting tasks: Starting
[   84.477407] Restarting tasks: Done
[   84.487390] random: crng reseeded on system resumption
[   84.499640] PM: suspend exit
[   86.609639] ravb 11c30000.ethernet end0: Link is Up - 1Gbps/Full - flow 
control off
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# uname -r
6.19.0-rc6-next-20260123-00021-g1e76e85a016d-dirty
root@smarc-rzg3s:~#

Note that I'm waking up from an wakeup button.

If you are trying to resume from serial wake interrupts, have you checked the 
serial driver is prepard to handle this? Please check this driver on how the 
resume is handled for wakup from serial device: 
https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/tty/serial/atmel_serial.c#L1414

> 
> LOGS:
> root@smarc-rzg3l:~# echo enabled > /sys/class/tty/ttySC3/power/wakeup
> echo N > /sys/module/printk/parameters/console_suspend
> root@smarc-rzg3l:~# echo N > /sys/module/printk/parameters/console_suspend
> root@smarc-rzg3l:~# echo 7 > /proc/sys/kernel/printk
> root@smarc-rzg3l:~# echo freeze > /sys/power/state
> [   41.601992] PM: suspend entry (s2idle)
> [   41.605979] Filesystems sync: 0.000 seconds
> [   41.611261] Freezing user space processes
> [   41.614848] Freezing user space processes completed (elapsed 0.003 seconds)
> [   41.622676] OOM killer disabled.
> [   41.625908] Freezing remaining freezable tasks
> [   41.631642] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [   41.640137] renesas-gbeth 11c30000.ethernet end0: Link is Down
> 
> 
> On my testing shows on RZ/G3L, we need to make DMA ACLK as non-PM clk for
> Making both s2idle and str to work on RZ/G3L.

Is there any RZ/G3L suspend to RAM support available on upstream kernel? On my 
side, I'm doing the same set of steps on RZ/G3S. This is the output:

root@smarc-rzg3s:~# echo freeze > /sys/power/state
[  299.431018] PM: suspend entry (s2idle)
[  299.436111] Filesystems sync: 0.000 seconds
[  299.452540] Freezing user space processes
[  299.459432] Freezing user space processes completed (elapsed 0.006 seconds)
[  299.466422] OOM killer disabled.
[  299.469656] Freezing remaining freezable tasks
[  299.475469] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  299.550263] ravb 11c30000.ethernet end0: Link is Down
[  302.112742] rzg3s-pcie-host 11e40000.pcie: PCIe link status [0x100014e]
[  302.323225] nvme nvme0: 1/0/0 default/read/poll queues
[  302.386270] Microchip KSZ9131 Gigabit PHY 11c30000.ethernet-ffffffff:07: 
attached PHY driver (mii_bus:phy_addr=11c30000.ethernet-ffffffff:07, irq=59)
[  302.470286] Microchip KSZ9131 Gigabit PHY 11c40000.ethernet-ffffffff:07: 
attached PHY driver (mii_bus:phy_addr=11c40000.ethernet-ffffffff:07, irq=61)
[  302.573319] usb usb2: root hub lost power or was reset
[  302.578520] usb usb3: root hub lost power or was reset
[  302.669350] usb usb4: root hub lost power or was reset
[  302.674583] usb usb1: root hub lost power or was reset
[  302.951468] usb 1-1: reset high-speed USB device number 2 using ehci-platform
[  303.206055] OOM killer enabled.
[  303.209315] Restarting tasks: Starting
[  303.228380] Restarting tasks: Done
[  303.236159] random: crng reseeded on system resumption
[  303.247796] PM: suspend exit
[  305.205604] ravb 11c30000.ethernet end0: Link is Up - 1Gbps/Full - flow 
control off
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# uname -r
6.19.0-rc6-next-20260123-00021-g1e76e85a016d
root@smarc-rzg3s:~#

And the patches I have on my tree:

1e76e85a016d (HEAD -> 
claudiu/SSGRLPCSRC-1478/linux-next/dma-cyclic+ssi-using-it-prepare-for-upstream-v1) 
arm64: dts: renesas: r9a07g044: Add dma properties for serial nodes
1a70b2015703 spi flash
d09caee93d5a dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last 
descriptor
65073447cc2b ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
8a3e41ac5a15 dmaengine: sh: rz-dmac: Add suspend to RAM support
63d57ebe24c9 dmaengine: sh: rz-dmac: Add cyclic DMA support
fc77f2366208 dmaengine: sh: rz-dmac: Drop the update of CHCTRL_SETEN in 
channel->chctrl APIs




> 
> if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
> you need this check in suspend/resume not to turn off DMAACLK during s2idle.

Again, how is this turned off on suspend/resume if it's critical?

> 
> Also, the callback has to be in non_irq phase so that CPU start getting IRQ's
> During sleep phase.

That could be moved there, if there are users of it.

Thank you,
Claudiu

