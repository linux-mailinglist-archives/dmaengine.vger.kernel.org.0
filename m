Return-Path: <dmaengine+bounces-8577-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCsGCP8re2lRCAIAu9opvQ
	(envelope-from <dmaengine+bounces-8577-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 10:44:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5080AE39E
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 10:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361DD3011126
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DF537FF6A;
	Thu, 29 Jan 2026 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="clkwRcPs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA837F75A
	for <dmaengine@vger.kernel.org>; Thu, 29 Jan 2026 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769679864; cv=none; b=MUgNXvSh3emnOpVEEUASeL6DyL8dvM7WG/yMzddB8LgNBYB52G30TCI1vzyQiJVDZcZ+zK1paWcVeYvNZjTI1CDyzWdJS6DgA27CrmJup6pLDhxZWzYnpd7cacZlIzGciBKSaBmjmduB/Lx1Ip10579+DCAswlmuvMGh5cw4r98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769679864; c=relaxed/simple;
	bh=jz1wf1CGFtWLf7K+3SOlmDiEcPV2639Jsw2Fh/OUoD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzaIZ3jvnBmMEGlg8Z/gY+1Aw/3kSsB/ufgC+zCJcFoj8CsjoiqUOCqEjuatbtmz68Y1lCla24c7OWTa6A5QapDS0wMyrBPYjE6JxVQvQo+NRwtvHPjQd3Kgu5NgPKSulGkBYi7OXoZxg/1rz1i2AhJKtwVSBuAz9f8Or6qrpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=clkwRcPs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43591b55727so670834f8f.3
        for <dmaengine@vger.kernel.org>; Thu, 29 Jan 2026 01:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769679860; x=1770284660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEpThG9+iE7G3Sanm83zLJrxXKtHkn95S0c/KwHIJWM=;
        b=clkwRcPswfIQ6srAjMQRXe4Dqdmi2iuv4muUu46WQizHW+d6T417MAQvsc/vE0LiJq
         8RIvmTXJxyyMRyhUHb3iJbmPprpjY51W1QNWCb+0FBY7PTNs0C4iFYoUW2DCJZpPV29d
         dGD5CNj2hMivUZdGNE7RJhMEHr4Z87ErGH8mqG00jsS2DoOlcuTyWgy5EeSjKHVpHPVa
         tbvBMWwk/MM6Q/GJjJvy7GfzU5LaSoOrnxPfHluWkBSkzWbTlZc/1Az59nQ6rr0+XYmE
         blmUBbwdZ58nSBUIrhuBt0476x1uVjdl6sea/iKyS++9/6oL/y224V53GJLeJjlSrP9z
         OGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769679860; x=1770284660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEpThG9+iE7G3Sanm83zLJrxXKtHkn95S0c/KwHIJWM=;
        b=hK7zAclDAz7PZnop1uzcGvrvOXlZ2SmrKI+VLUzZGXg36juuv+bZEq5n24n1hBusA2
         BRB7rvRtuiqtGAPgRb7n9rCWjmelZe4aeNh1J2BeRoP44UATDz+UnpDg/NEjXIisQV2D
         tsPDQerwzOHWTr5kg8rikR1ZRzVQECjJmekFyTYqZwTHHMa4NUK9Bmr8JQDf+bDy0aF2
         n+zUemp97KupFSCjI2LthzUJxl/iZrqqVjSBaPcJeoliwl1QD5sHVqNeazIy3pUTd7on
         XWt8UVAvndA+RAJpgDXcJfZJjJpGovJq60c/7xVCIHYpe3oayS5k75QSZwsRErp5+xMc
         AiPA==
X-Gm-Message-State: AOJu0Yx0GPFvOcSZv0hLzdawNGUthZ99mGjGgVnj6QrEWaxgYkSA+w2g
	24APZzUY+WMYFqprDxxBLUZ0Zj8xxg4k4UJAe+W38Wbl7Ww1BP7sQvysbZ2LMVIxYsUgh1IxoSR
	FFHMP
X-Gm-Gg: AZuq6aLb4t7Me6u7C29oR539SfSyFQT5vCPsqdFnpqSqqK8X/9ifLHBar1jUkzR/djF
	Yo9u7k7p3qMAdXGCK/tBVDEf+arQkQ04wqQBjPGUWKkVDdlsnHDWaOexFlWOnODMJ8xS7SGJq3D
	FNtB3RZAQvd/tXHYUaJ+7p7tlmjDUByBCHQVnZ1yI+prS5fSH77wfasF+G0epErsmMNY5aJIfyL
	aQ6R2rjnDCyBhf5A9jxmOey5u7Gl5KlBuE34OYZEYAVz8s7HWsFGyWr2UHgI0zxTE+f7xsW0EhZ
	2C1mZAAZaByp3TIPme0k20tS4xnxIhqPnK8JPLLr4fHlZBZC8HybwH+23ZjAxqa7YccbhylnKEX
	408boO5/6kG6CSG98T7UaBlqiFXCKFgIeI2q2S2RFsnpqWdLVuePRM0Qxi/owjbI+nOoQzfj1mj
	ct7viHN+U0ogvSZgLc4Q==
X-Received: by 2002:a5d:5f82:0:b0:435:dba0:7c0b with SMTP id ffacd0b85a97d-435dd028404mr10337399f8f.3.1769679860314;
        Thu, 29 Jan 2026 01:44:20 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cefdsm13177500f8f.23.2026.01.29.01.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 01:44:19 -0800 (PST)
Message-ID: <721cc697-0091-4938-80e9-93005f38c98d@tuxon.dev>
Date: Thu, 29 Jan 2026 11:44:18 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] dmaengine: sh: rz-dmac: Add tx_status and
 pause/resume support
To: vkoul@kernel.org, geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
 fabrizio.castro.jz@renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	TAGGED_FROM(0.00)[bounces-8577-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxon.dev:mid,tuxon.dev:dkim]
X-Rspamd-Queue-Id: B5080AE39E
X-Rspamd-Action: no action

Hi,

Gentle ping on this series.

Thank you,
Claudiu

On 1/20/26 15:33, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds tx_status and pause/resume support for the rz-dmac driver.
> Along with it were added fixes and improvements identified while working
> on the above mentioned enhancements.
> 
> Previous versions were addressed by Biju. The previous versions were
> posted here:
> 
> v4: https://lore.kernel.org/all/20240628151728.84470-1-biju.das.jz@bp.renesas.com/
> v3: https://lore.kernel.org/all/20230412152445.117439-1-biju.das.jz@bp.renesas.com/
> v2: https://lore.kernel.org/all/20230405140842.201883-1-biju.das.jz@bp.renesas.com/
> v1: https://lore.kernel.org/all/20230324094957.115071-1-biju.das.jz@bp.renesas.com/
> 
> Changes in v8:
> - rebased on top of https://lore.kernel.org/all/20260105114445.878262-1-cosmin-gabriel.tanislav.xa@renesas.com/
> - populated engine->residue_granularity in patch 7/8
> - report proper residue in case the channel is paused in patch 8/8
> 
> Changes in v7:
> - adjusted the pause/resume support
> - collected tags
> 
> Changes in v6:
> - added patches:
> -- dmaengine: sh: rz-dmac: Drop read of CHCTRL register
> -- dmaengine: sh: rz-dmac: Drop goto instruction and label
> - use vc lock in IRQ handler only for the error path
> - fixed typos
> - adjusted patch
>    "dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks"
> 
> Changes in v5:
> - added patches
> -- dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
> -- dmaengine: sh: rz-dmac: Protect the driver specific lists
> -- dmaengine: sh: rz-dmac: Move all CHCTRL updates under spinlock
> -- dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
> -- dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
> -- dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
> - for pause/resume used the DMA controller support to pause/resume
>    transfers compared with previous versions
> - adjusted patches:
> -- dmaengine: sh: rz-dmac: Add device_tx_status() callback
> 
> Thank you,
> Claudiu
> 
> Biju Das (2):
>    dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
>    dmaengine: sh: rz-dmac: Add device_tx_status() callback
> 
> Claudiu Beznea (6):
>    dmaengine: sh: rz-dmac: Protect the driver specific lists
>    dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
>    dmaengine: sh: rz-dmac: Drop read of CHCTRL register
>    dmaengine: sh: rz-dmac: Drop goto instruction and label
>    dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
>    dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
> 
>   drivers/dma/sh/rz-dmac.c | 289 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 239 insertions(+), 50 deletions(-)
> 


