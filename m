Return-Path: <dmaengine+bounces-8091-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F2CFEF01
	for <lists+dmaengine@lfdr.de>; Wed, 07 Jan 2026 17:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53DD6304F885
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jan 2026 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF7E35BDC9;
	Wed,  7 Jan 2026 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pApNhZUa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938C35BDC0
	for <dmaengine@vger.kernel.org>; Wed,  7 Jan 2026 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797824; cv=none; b=cT0Tg+HXNrUWiFRTU1OKwLv5bg/BLIqggWC0WT7X8uAQwepuJzu3+059EL+yE343LjO+AdlYvB5KBp8JijoXzQeImIjL9X9EYHN0uOXxy35MX9R3tq/vGPADgaBlqfrxeTnUcGDkdDLdlW3eoD0r11TWyT86W/NWfTE/2b6IUqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797824; c=relaxed/simple;
	bh=7IAGNzmojj/ldT0gL+Iyhiz5npSgPT5B9tF6WGWNcCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4Yl9ugkiRmQ5y5682ggWEneQXnJdLW8glRFdAKLQVKtw03IW+mk7V5UK5/RGhJ4iAPAAKApBC/uOfpfDZwo6Cj2U8CyKl/xlKIrpDoZEszqWbTYlvh8Iytmr+xi9ctwritt1scr84DH2Yy09d9Ggg6LJqEyWiF8xxj90LgoxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pApNhZUa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so13283965e9.1
        for <dmaengine@vger.kernel.org>; Wed, 07 Jan 2026 06:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767797820; x=1768402620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6efv/1qd1CRxR+yi3OwM7hKn0xFs+yuxbSeUESwD84=;
        b=pApNhZUaGxMOC43SUiVGXC+E5Xt5IGdYU71eLHxpCZKXt4obkF6Ms1WnaikYdb3RUS
         o903Kzj51foUEF3sevW6Q7lLUDuSu2LIISGwahcyZBPG7alOpORC9TlTQlFIpuLkLgVV
         ICLL1VplXkf3aj6mvwtw1JavUjXQfvov7dX/pHfSG+dm1wmj/W+zOfXSSMOVCm1c0uLE
         lqbxWMULiWjeX0WJUSIJa38XTMIImP/ENsFBNpMWZLD5w50CxrDldSC0Uqzi7udvWJYB
         mgDz7ETbQH8punyMCVnTkcYvWbnR6sNVOG8AkeCWc+DsFJFb5ccX+SANTTxhateZ4hm7
         5jhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767797820; x=1768402620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6efv/1qd1CRxR+yi3OwM7hKn0xFs+yuxbSeUESwD84=;
        b=aWZvLTDhTU7hzWKqBQWe0NcKYXhBmL72mkiuf9GPzo3qtYgx/TrlScWeyL4RQ//cun
         zNsD2Za4o7YSqlI1AvN3qgHrDSJ0yHUxPudSg3aZbKBI+7kSoCMYsGMxtp6R+4pmDW07
         w3N8BPqngUzMUHBJCosnp3CpuQfMYKdWvQtQMbh6JRNzjMQTOnGuS9yzQLB//22asiY+
         FDOXHG3T9djxJaJgaqJl+Tmdk68f5UzLPjjWfM+rdWf+JsIyCl6l/m6bedTJ0cVFecVf
         CwB1Hw7ZbUDo5e1kaL1RJ2zJ6YfZ/a114cYSBYK7VLVKv4TTdUTdw2WWIAWPO9rgyaUs
         i8Zw==
X-Gm-Message-State: AOJu0Yxl3ZXvyldPkvin1913bRhq4qCQfdtjFiUd6pPGO/SoDNQ1g5Qh
	2yqJlwKpuMJYAAbJSHui0TSX9YlI9E4pHEoWuGLSLzyIXPmRUVexDB6nLN1fxW3nN0A=
X-Gm-Gg: AY/fxX4Ul/6PJO8c6INuLaRyo8zdFu29tTRBIEIe8nX1/ax/DfFDgYmwHhtVEp+Pu6Q
	eFhGHtSAHtExqxQz8/w6Son7XdoY6FNF+ChrUC5+/GV11y/LIwKDRZ9oO8L8Gd4gq1azSv5gJNy
	uyqOpAyR4aHRmjyVFP46o/eaew0ZC26vhrx3/5rPp/8GViuA9l89ngn6WnRH3h6zbarf2wR5EEi
	m6/FGGK8ashgiF55d6gvU4eEWhDGb4WzjpiNF52q1ugmtyph/NvHdDpOOrjRcH9lrZkUXnYsrgJ
	3rnwmf77/aG1zrPsDG0OJE5eQ2StA3WTc0Ky+Avit0UWjmh/GNwtcXekC/GWW8g494LGyPDUD3L
	XcT46j2QH7/TySKJTYtd8+zBUGetstYCrEUFH52DSd3qJl8o5rsAHxaYOl7Q8RF+zHwE1Trw2Ig
	40hY+Q/RGhGoG9xNq7cQ==
X-Google-Smtp-Source: AGHT+IHlhzaUHJwrgX+pVx0asfV/0BbCjA4g6558c2jsK5EycmJHmGAopODSZoJGvZ5Q5ao4wtxynQ==
X-Received: by 2002:a05:600c:4703:b0:475:e007:baf1 with SMTP id 5b1f17b1804b1-47d84b49e27mr32080025e9.34.1767797820337;
        Wed, 07 Jan 2026 06:57:00 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f7035f2sm97200125e9.12.2026.01.07.06.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 06:56:59 -0800 (PST)
Message-ID: <7161814f-5317-49f0-9240-c84d331737c4@tuxon.dev>
Date: Wed, 7 Jan 2026 16:56:58 +0200
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
 <c0a76fcf-8dca-4268-9d07-b5bae8c26c46@tuxon.dev>
 <TY3PR01MB11346E51F609DDEC61E13609B8684A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB11346E51F609DDEC61E13609B8684A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/7/26 15:48, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Sent: 07 January 2026 13:18
>> Subject: Re: [PATCH v6 8/8] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
>>
>> Hi, Biju,
>>
>> On 12/23/25 16:43, Biju Das wrote:
>>> Hi Claudiu,
>>>
>>>> -----Original Message-----
>>>> From: Claudiu <claudiu.beznea@tuxon.dev>
>>>> Sent: 23 December 2025 13:50
>>>> Subject: [PATCH v6 8/8] dmaengine: sh: rz-dmac: Add
>>>> device_{pause,resume}() callbacks
>>>>
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Add support for device_{pause, resume}() callbacks. These are required by the RZ/G2L SCIFA driver.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> ---
>>>>

[...]

>>>> +
>>>> +static int rz_dmac_device_resume(struct dma_chan *chan) {
>>>> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
>>>> +	u32 val;
>>>> +	int ret;
>>>> +
>>>> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
>>>
>>>
>>>> +		rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
>>>
>>>
>>> Similarly, first you need to check  CHSTAT_SUS bit first and then clear suspend state.
>>>
>>>
>>> Clears the suspend status. Setting this bit to 1 when 1 is set in SUS
>>> of the CHSTAT_n/nS register can clear the suspend status.
>>
>> I'll update this one as follows, to keep the code simple:
>>
>> static int rz_dmac_device_resume(struct dma_chan *chan) {
>> 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
>> 	u32 val;
>>
>> 	guard(spinlock_irqsave)(&channel->vc.lock);
>>
>>           /* Do not check CHSTAT_SUS but rely on HW capabilities. */
>> 	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
>> 	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
>> 					!(val & CHSTAT_SUS), 1, 1024,
>> 					false, channel, CHSTAT, 1);
>> }
>>
>> With this:
>>
>> 1/ in case the channel is not suspended and the CHCTRL_CLRSUS is set, the read_poll_timeout_atomic()
>> will not timeout, as the default value of the CHSTAT_SUS is zero.
> 
> Just a question as we are not following the hardware manual.
> 
> At hardware level does it have any implications?

The documentation of CHCTRL_CLRSUS states:

Setting this bit to 1 *when 1 is set in SUS of the CHSTAT_n/nS register* 
can clear the suspend status.

So, it takes effect only when CHSTAT.SUS=1

> 
> Eg: we set this write only register without the device being suspended
>      
> 
> The next suspend operation, immediately clears the suspend operation

The next suspend operation will switch the DMA channel to suspend if the 
channel is enabled. Nothing should take place if the device is not enabled.

>      
>      Or
> 
> does it work normally.

Yes, it works normally.

I set the CLRSUS bit in a loop for a DMA channel where the audio was 
playing, with the following command:

while :; do devmem2 0x118200a8 w 0x200 > /dev/null; done

There were no issues with the audio stream, as expected.

If I set the SETSUS bit for the same audio channel after the CLRSUS was 
set in a loop, the audio is stopped as expected.

Thank you,
Claudiu

