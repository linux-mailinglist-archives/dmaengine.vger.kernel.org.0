Return-Path: <dmaengine+bounces-8507-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOLnBrhnd2nCfQEAu9opvQ
	(envelope-from <dmaengine+bounces-8507-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 14:10:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDF7889F0
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 14:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 406D9300DE07
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43E63382D9;
	Mon, 26 Jan 2026 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KklkwW9P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADFA336EE9
	for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432847; cv=none; b=ZGx5yy3ZULaqtSZXYE0KOJjX49Sj4i1DFRXH0ZrVvW6fCOAqYAixPo+INuOlJWpamzOGcJk7pTvu8oZBZbxymBKgv4Z++DO8YiE2oik/Si5jsrREcwSMhrWJP3yM0kZob7kroOVbgzgTbwGAdgLUnuHsoBmjjHTR4HHqWBiiaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432847; c=relaxed/simple;
	bh=+TcBNzGPvxQkr2bX4m1zGQnp80VH4oJq7S7HlOWyt20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KswnhqwzBecRAAJ06EkNADO3FL4r7R/AAvYZMhTzxl7tt35g+5B/OA4U0BW2uz0kjS2R6+MrYc/Zj/QIWj+dmuvNUHg5HpWMfAtRDhIP6g0mK32tMMmQfXR+HYvleAtc8mZJr95WyBtV15tG2Ia1C40vN0qrq9HzU0jXLRWZLdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KklkwW9P; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fbc305914so3865146f8f.0
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 05:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769432844; x=1770037644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7OELa91kqMKF9jEL75+OFYlb2Frqr822HFr1aC++eI=;
        b=KklkwW9PAU+/Bo8fDtA2bXKIiNSk6yrq6vpeD3gaACAEwO9JMSKOXgBeSq6Z9Xih5Q
         G4FGegbXvktlNddIkFaJDbzghZzOrRFsVUnb5ZD9uuze3pJw+W8qrUWzzSc14CuLp9fG
         5gg97+RXk16hu1VDpuN2pL61+Y8jgYjwRle/ut9zQHFsIRk57MAmU6W5XnkH45BKByIM
         qPphqgtU2xe3KYTUVrkPA2YiZMsmDNb9536PnAB/Su62qEQzLGcPQRXBfX8pUQ1nZ3ux
         GcmUuNZkFRXgKoH2Tdu1e3gbvNiTrewYQAIPnp9zuKjjaGNjdu1STlnOZx/Kv+F0XDoG
         YXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769432844; x=1770037644;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7OELa91kqMKF9jEL75+OFYlb2Frqr822HFr1aC++eI=;
        b=lcZn1V1XJyEiVjuHCZpkFW/ItLPzvMG52nRyZDJUVJQxGhLMrgY5IkkPiZsvBUz3y8
         DzUKnZ1OkV8AVsPnFWAI72KTYvRvqf/itOI685gr2VPlhnyh5y+7EymFq5Bd2hXFNWQ+
         B2i2fCSLUSuRmt+Z3EppjoZgV5ORGz+aGgXNEBlbiEGK84n+Gjz7KWimHJo31xKapWxv
         ZEZ9vtTm7FU1YX5W3m6+aYiigIJSHiNbTdvV0Hw9jQDK5f+ecoLhPWN62HDqloRBdsSd
         ELgiMCNRBHKdTCzC6kwAYvsGJUWgYty7TjMIRXOH7lFzAFQls12wXk9pvJ2UIHF3udyh
         zS7w==
X-Gm-Message-State: AOJu0Yye0dwbp3p/ZbsuXUIIGlfEmN8XlfmkOft2LRbae6qptvzH3wK3
	FDHhK8CHfxvaBVCGd3GiUS768MSRQB4bCkP4xioiRKdn8NCm8xU6S+Cyf2CBaWxmrlg=
X-Gm-Gg: AZuq6aJBoFeqJhOeu8Q8nD5nIXAPX3RWKPIEOAkaGTI8XS08UUq/ybHPwAP4ir6ur+W
	3Y9DJ0fMW4bMjMY8iXxWO0i7t3GHR/Jt0uROyr0JTvICFX/mfCiYWT7HStuEwv0cMlpo9sZ/v0l
	L7nNxY/SEBEUG/H7Q1AIGcPLts7kOAZ00y+YR6YWH1qYOneQxI1M14DYkM8E89e+y6YqohI7p/w
	S6iLC6LwY+D465oU0U4dU/otIEYEq/0C7SSTVxgWUJ/gysyR6BFXjZ/OifEu7F+MeFLPXleBzjA
	q333ZDjP+O8MM71fEp6oNGJ5YWW6VPClZkOiYfAm2Y01ewhAe4gpvheGxqv6Bdl1Zt+C+cNeJR9
	CcSXDEJ3s4idDd7h5BqVQQmJG8PWajquocjA8HmNbzUmOl6acemxgZuaBTYeeQjz0fHULXVwUOv
	U8JWTfW5VVP4j+8cQaAjEtJgVWKokv
X-Received: by 2002:a05:6000:24c1:b0:435:bd00:cb4 with SMTP id ffacd0b85a97d-435ca1394b5mr7130948f8f.23.1769432843905;
        Mon, 26 Jan 2026 05:07:23 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c01783sm30842945f8f.3.2026.01.26.05.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 05:07:23 -0800 (PST)
Message-ID: <ad752abc-275b-43ca-aec3-188c1a69c50b@tuxon.dev>
Date: Mon, 26 Jan 2026 15:07:21 +0200
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
 <5438ccc8-ed5a-4dd6-8995-e8e9926883a5@tuxon.dev>
 <TY3PR01MB11346325F46C2BCA6B2B181D08693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <TY3PR01MB11346325F46C2BCA6B2B181D08693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8507-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,pengutronix.de:email,perex.cz:email,tuxon.dev:email,tuxon.dev:dkim,tuxon.dev:mid,smarc-rzg3l:email,suse.com:email,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FDF7889F0
X-Rspamd-Action: no action



On 1/26/26 14:51, Biju Das wrote:
> Hi Claudiu,
> 
> 
>> -----Original Message-----
>> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Sent: 26 January 2026 12:39
>> Subject: Re: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
>>
>>
>>
>> On 1/26/26 14:10, Biju Das wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>>> Sent: 26 January 2026 12:05
>>>> To: Biju Das <biju.das.jz@bp.renesas.com>; vkoul@kernel.org;
>>>> Prabhakar Mahadev Lad <prabhakar.mahadev- lad.rj@bp.renesas.com>;
>>>> lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz;
>>>> tiwai@suse.com; p.zabel@pengutronix.de; geert+renesas@glider.be;
>>>> Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>>>> Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> linux-sound@vger.kernel.org; linux- renesas-soc@vger.kernel.org;
>>>> Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> Subject: Re: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM
>>>> support
>>>>
>>>> Hi,
>>>>
>>>> On 1/26/26 13:03, Biju Das wrote:
>>>>> Hi Claudiu,
>>>>>
>>>>> Thanks for the patch.
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Claudiu <claudiu.beznea@tuxon.dev>
>>>>>> Sent: 26 January 2026 10:32
>>>>>> Subject: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM
>>>>>> support
>>>>>>
>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>
>>>>>> The Renesas RZ/G3S SoC supports a power saving mode in which power
>>>>>> to most SoC components is turned off, including the DMA IP. Add
>>>>>> suspend to RAM support to save and
>>>> restore the DMA IP registers.
>>>>>>
>>>>>> Cyclic DMA channels require special handling. Since they can be
>>>>>> paused and resumed during system suspend and resume, the driver
>>>>>> restores additional registers for these channels during the resume
>>>>>> phase. If a channel was not explicitly paused during suspend, the
>>>>>> driver ensures that it is paused and resumed as part of the system
>>>>>> suspend/resume flow. This might
>>>> be the case of a serial device being used with no_console_suspend.
>>>>>>
>>>>>> For non-cyclic channels, the dev_pm_ops::prepare callback waits for
>>>>>> all ongoing transfers to complete before allowing suspend-to-RAM to proceed.
>>>>>>
>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>> ---
>>>>>>    drivers/dma/sh/rz-dmac.c | 183 +++++++++++++++++++++++++++++++++++++--
>>>>>>    1 file changed, 175 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
>>>>>> index ab5f49a0b9f2..8f3e2719e639
>>>>>> +
>>>>>> +	pm_runtime_put_sync(dmac->dev);
>>>>>> +
>>>>>> +	ret = reset_control_assert(dmac->rstc);
>>>>>> +	if (ret) {
>>>>>> +		pm_runtime_resume_and_get(dmac->dev);
>>>>>> +		rz_dmac_suspend_recover(dmac);
>>>>>> +	}
>>>>>> +
>>>>>
>>>>>
>>>>> This patch breaks, s2idle in RZ/G3L as it turns off DMA ACLK and
>>>>> IRQ's are not routed to CPU for wakeup.
>>>>
>>>> Is this particular patch the one that explicitly breaks it? Is there
>>>> any mainline PM support available for RZ/G3L? Can it be fixed along
>>>> with the RZ/G3L support, if any, as I don't have the board to test it?
>>>
>>> Maybe your TF-A is enabling DMAACLK during resume. Can you check that
>>> mean time, I will check what you have mentioned Here?
>>>
>>
>> You used "freeze" in your example. Same did I to check your usecase. That suspend type don't involve
>> TF-A (unless something changes and I'm not aware of).
>>
> 
> Looks like reset assert in suspend() is the issue, not the clk.

How did you concluded this? Do we know if the wakeup interrupt is
configured properly? Could you point to the code configuring the wakeup
interrupt?

Also, could you please respond to the questions on the previous emails I
addressed? It helps understanding the problem.

> 
> echo N > /sys/module/printk/parameters/console_suspend
> root@smarc-rzg3l:~# echo 7 > /proc/sys/kernel/printk
> root@smarc-rzg3l:~#
> root@smarc-rzg3l:~#
> root@smarc-rzg3l:~# echo mem > /sys/power/state
> [   57.103165] PM: suspend entry (deep)
> [   57.106929] Filesystems sync: 0.000 seconds
> [   57.112372] Freezing user space processes
> [   57.114782] Freezing user space processes completed (elapsed 0.002 seconds)
> [   57.123730] OOM killer disabled.
> [   57.126964] Freezing remaining freezable tasks
> [   57.132691] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [   57.141140] renesas-gbeth 11c30000.ethernet end0: Link is Down
> [   57.148638] rzg2l_cpg_pm_suspend(): CLK_ON 0x514/gic_gicclk 1
> [   57.154428] rzg2l_cpg_pm_suspend(): CLK_ON 0x518/ia55_clk 2
> [   57.160032] rzg2l_cpg_pm_suspend(): CLK_ON 0x518/ia55_pclk 2
> [   57.165687] rzg2l_cpg_pm_suspend(): CLK_ON 0x52c/dmac_aclk 1
> [   57.171339] rzg2l_cpg_pm_suspend(): CLK_ON 0x52c/dmac_pclk 1
> [   57.177000] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_clk_axi 30c0
> [   57.183174] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_clk_chi 30c0
> [   57.189347] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_tx_i 30c0
> [   57.195258] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_rx_i 30c0
> [   57.201169] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_tx_180_i 30c0
> [   57.207426] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_rx_180_i 30c0
> [   57.213684] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_rmii_i 30c0
> [   57.219774] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_ptp_ref_i 30c0
> [   57.226120] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_clk_axi 30c0
> [   57.232290] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_clk_chi 30c0
> [   57.238459] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_tx_i 30c0
> [   57.244369] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_rx_i 30c0
> [   57.250279] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_tx_180_i 30c0
> [   57.256540] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_rx_180_i 30c0
> [   57.262798] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_rmii_i 30c0
> [   57.268884] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_ptp_ref_i 30c0
> [   57.275229] rzg2l_cpg_pm_suspend(): CLK_ON 0x584/scif0_clk_pck 1
> [   57.281228] rzg2l_cpg_pm_suspend(): CLK_ON 0x598/gpio_hclk 1
> [   57.286997] Disabling non-boot CPUs ...
> [   57.292890] psci: CPU3 killed (polled 0 ms)
> [   57.300567] psci: CPU2 killed (polled 0 ms)
> [   57.308116] psci: CPU1 killed (polled 0 ms)
> NOTICE:  BL2: v2.10.5(release):2.10.5/rzg3l_1.0.0
> NOTICE:  BL2: Built : 08:36:10, Jan 20 2026
> INFO:    BL2: Doing platform setup
> INFO:    Configuring TrustZone Controller
> INFO:    Total 3 regions set.
> INFO:    Configuring TrustZone Controller
> INFO:    Total 1 regions set.
> INFO:    Configuring TrustZone Controller
> INFO:    Total 1 regions set.
> INFO:    eMMC boot from partition 1
> INFO:    Loading image id=39 at address 0x44428
> INFO:    emmcdrv_block_len: len: 0x00001000
> INFO:    Load dst=0x44428 src=(p:1)0x260000(4864) len=0x1000(8)
> INFO:    Image id=39 loaded: 0x44428 - 0x45428
> INFO:    DDR: Retention Exit (Rev. 02.05)
> NOTICE:  BL2: SYS_LSI_MODE: 0x12051
> NOTICE:  BL2: SYS_LSI_DEVID: 0x87d9447
> INFO:    BL2: Skip loading image id 3
> INFO:    BL2: Skip loading image id 5
> NOTICE:  BL2: Booting BL31
> INFO:    Entry point address = 0x44000000
> INFO:    SPSR = 0x3cd
> INFO:    GICv3 without legacy support detected.
> INFO:    ARM GICv3 driver initialized in EL3
> [   57.313836] Enabling non-boot CPUs ...
> [   57.319883] Detected VIPT I-cache on CPU1
> [   57.319942] GICv3: CPU1: found redistributor 100 region 0:0x0000000012460000
> [   57.319992] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
> [   57.320755] CPU1 is up
> [   57.341066] Detected VIPT I-cache on CPU2
> [   57.341112] GICv3: CPU2: found redistributor 200 region 0:0x0000000012480000
> [   57.341151] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
> [   57.341886] CPU2 is up
> [   57.362133] Detected VIPT I-cache on CPU3
> [   57.362177] GICv3: CPU3: found redistributor 300 region 0:0x00000000124a0000
> [   57.362213] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
> [   57.362975] CPU3 is up
> [   57.383339] rzg2l_mod_clock_init_mstop(): CLK_ON 0x514/gic_gicclk 1
> [   57.389666] rzg2l_mod_clock_init_mstop(): CLK_ON 0x518/ia55_clk 3
> [   57.395803] rzg2l_mod_clock_init_mstop(): CLK_ON 0x518/ia55_pclk 3
> [   57.402038] rzg2l_mod_clock_init_mstop(): CLK_ON 0x57c/eth0_clk_axi 3fff
> [   57.408784] rzg2l_mod_clock_init_mstop(): CLK_ON 0x57c/eth0_clk_chi 3fff
> [   57.415544] rzg2l_mod_clock_init_mstop(): CLK_ON 0x57c/eth0_rmii_i 3fff
> [   57.422217] rzg2l_mod_clock_init_mstop(): CLK_ON 0x57c/eth0_ptp_ref_i 3fff
> [   57.429143] rzg2l_mod_clock_init_mstop(): CLK_ON 0x57c/eth1_clk_axi 3fff
> [   57.435895] rzg2l_mod_clock_init_mstop(): CLK_ON 0x57c/eth1_clk_chi 3fff
> [   57.442656] rzg2l_mod_clock_init_mstop(): CLK_ON 0x57c/eth1_rmii_i 3fff
> [   57.449314] rzg2l_mod_clock_init_mstop(): CLK_ON 0x57c/eth1_ptp_ref_i 3fff
> [   57.456240] rzg2l_mod_clock_init_mstop(): CLK_ON 0x584/scif0_clk_pck 1
> [   57.462818] rzg2l_mod_clock_init_mstop(): CLK_ON 0x598/gpio_hclk 1
> [   57.469039] ###########rzg2l_cpg_resume ########0/0
> [   57.474068] dwmac4: Master AXI performs fixed burst length
> [   57.484472] renesas-gbeth 11c30000.ethernet end0: No Safety Features support found
> [   57.492079] renesas-gbeth 11c30000.ethernet end0: IEEE 1588-2008 Advanced Timestamp supported
> [   57.500658] renesas-gbeth 11c30000.ethernet end0: configuring for phy/rgmii-id link mode
> [   57.525097] dwmac4: Master AXI performs fixed burst length
> [   57.530615] renesas-gbeth 11c40000.ethernet end1: No Safety Features support found
> [   57.538201] renesas-gbeth 11c40000.ethernet end1: IEEE 1588-2008 Advanced Timestamp supported
> [   57.546764] renesas-gbeth 11c40000.ethernet end1: configuring for phy/rgmii-id link mode
> [   57.557533] OOM killer enabled.
> [   57.560668] Restarting tasks: Starting
> [   57.565020] Restarting tasks: Done
> [   57.568586] random: crng reseeded on system resumption
> [   57.573929] PM: suspend exit
> root@smarc-rzg3l:~# [   60.574926] renesas-gbeth 11c30000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/tx
> 
> root@smarc-rzg3l:~#
> root@smarc-rzg3l:~# echo enabled > /sys/class/tty/ttySC3/power/wakeup
> root@smarc-rzg3l:~# echo freeze > /sys/power/state
> [   86.957826] PM: suspend entry (s2idle)
> [   86.961742] Filesystems sync: 0.000 seconds
> [   86.966381] Freezing user space processes
> [   86.972014] Freezing user space processes completed (elapsed 0.001 seconds)
> [   86.979011] OOM killer disabled.
> [   86.982248] Freezing remaining freezable tasks
> [   86.987966] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [   86.996469] renesas-gbeth 11c30000.ethernet end0: Link is Down
> [   87.004128] rzg2l_cpg_pm_suspend(): CLK_ON 0x514/gic_gicclk 1
> [   87.009913] rzg2l_cpg_pm_suspend(): CLK_ON 0x518/ia55_clk 3
> [   87.015484] rzg2l_cpg_pm_suspend(): CLK_ON 0x518/ia55_pclk 3
> [   87.021140] rzg2l_cpg_pm_suspend(): CLK_ON 0x52c/dmac_aclk 1
> [   87.026795] rzg2l_cpg_pm_suspend(): CLK_ON 0x52c/dmac_pclk 1
> [   87.032448] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_clk_axi 30c0
> [   87.038620] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_clk_chi 30c0
> [   87.044792] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_tx_i 30c0
> [   87.050704] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_rx_i 30c0
> [   87.056616] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_tx_180_i 30c0
> [   87.062873] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_rx_180_i 30c0
> [   87.069130] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_rmii_i 30c0
> [   87.075218] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth0_ptp_ref_i 30c0
> [   87.081562] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_clk_axi 30c0
> [   87.087733] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_clk_chi 30c0
> [   87.093917] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_tx_i 30c0
> [   87.099829] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_rx_i 30c0
> [   87.105741] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_tx_180_i 30c0
> [   87.111999] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_rx_180_i 30c0
> [   87.118258] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_rmii_i 30c0
> [   87.124342] rzg2l_cpg_pm_suspend(): CLK_ON 0x57c/eth1_ptp_ref_i 30c0
> [   87.130688] rzg2l_cpg_pm_suspend(): CLK_ON 0x584/scif0_clk_pck 1
> [   87.136687] rzg2l_cpg_pm_suspend(): CLK_ON 0x598/gpio_hclk 1
> 
> No IRQ's in s2idle.

You tested mem before freeze while previously you only pointed to the
freeze. Could you please follow the same configuration sequence to isolate
the problem?

Thank you,
Claudiu

