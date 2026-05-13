Return-Path: <dmaengine+bounces-10419-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGzTOHWFBGrVKwIAu9opvQ
	(envelope-from <dmaengine+bounces-10419-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:06:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E847534AE6
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4555B31C8540
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D073101C8;
	Wed, 13 May 2026 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcKqh1P3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF630CD92;
	Wed, 13 May 2026 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679352; cv=none; b=i3Mco9IKu2bFKpBC0xo5pRxzbJxSRiPQYir/F+J7TXTHQCgYiprPLr9AJX4MI8HVRRP2G9oXGYMELwIUUzgI6FAXZm3rslixsizjIB/Y7ZEN6aioYKjWt4Q/FOlC7LDQS0m01kkj5PqiLDRVBtr0edvw/VOtt6H7Edt5trAEJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679352; c=relaxed/simple;
	bh=gRzMQkyMkW76rEWqtz1pVibIlYxd9sVYad/ToeB8y7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjj4m45K+ScN+uJ6jKxyEqkZJZnLmROapeRbkCXge1SW7dWatrcNHCTF1OWdUNRwaJL3RgAX21jsxoKL4SM/f0jxalXhpvdVBcNMILdp92eJOpwZQHitB+GvzYk8MlVNfXltQVj+wWAHNVUFS7kW+I7BrGuYe94j2YMTZlcOMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcKqh1P3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F2DC2BCB7;
	Wed, 13 May 2026 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778679351;
	bh=gRzMQkyMkW76rEWqtz1pVibIlYxd9sVYad/ToeB8y7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IcKqh1P3558a+LdBfaXzEJExCO971yEZFsWXBGOZIyCPm3/0raLxrXvpmKp5ejhI2
	 a9RNw8L5E2iisdPyR41wdMha6zs152Cv8s2tiZxkaoLHme1VDbvf4bFukHQWEW1td8
	 5xPfqxi1/178pcRMYPslx4Gov05sv1lI5CY9dI4FHx7xQ9wmCLQbY+vwFq2lEl8Xrg
	 8LG1E1gYP3E8lPFpUE+ORQAhyEK/B1xd/P7eLctSfN8lYiApgT+WLKROGKx8eFEDIm
	 s1eSd3CtHgCLExJT4nKnj+hElLdipcXIuoBvhbIqjj0Ai+7PUj2pAYjcoTJ+ysPzGL
	 V077ZXRWOvZUA==
Message-ID: <b079eddc-7080-4d7f-bce3-64f0dfc430a3@kernel.org>
Date: Wed, 13 May 2026 16:35:45 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/17] dmaengine: sh: rz-dmac: Refactor pause/resume
 code
To: Frank Li <Frank.li@nxp.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 p.zabel@pengutronix.de, geert+renesas@glider.be,
 fabrizio.castro.jz@renesas.com, kuninori.morimoto.gx@renesas.com,
 long.luu.ur@renesas.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-11-claudiu.beznea.uj@bp.renesas.com>
 <agOe8ibuEjDPklKt@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <agOe8ibuEjDPklKt@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5E847534AE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10419-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Action: no action

Hi, Frank,

On 5/13/26 00:43, Frank Li wrote:
> On Tue, May 12, 2026 at 03:12:11PM +0300, Claudiu Beznea wrote:
>> Subsequent patches will add suspend/resume and cyclic DMA support to the
>> rz-dmac driver. This support needs to work on SoCs where power to most
>> components (including DMA) is turned off during system suspend. For this,
>> some channels (for example cyclic ones) may need to be paused and resumed
>> manually by the DMA driver during system suspend/resume.
>>
>> Refactor the pause/resume support so the same code can be reused in the
>> system suspend/resume path.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v5:
>> - none
>>
>> Changes in v4:
>> - reset channel->status in rz_dmac_free_chan_resources() and
>>    rz_dmac_terminate_all()
>>
>> Changes in v3:
>> - none, this patch new new
>>
>>   drivers/dma/sh/rz-dmac.c | 73 ++++++++++++++++++++++++++++++++++------
>>   1 file changed, 62 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
>> index 53ee9fe65261..2bf796dcc5f6 100644
>> --- a/drivers/dma/sh/rz-dmac.c
>> +++ b/drivers/dma/sh/rz-dmac.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/irqchip/irq-renesas-rzv2h.h>
>>   #include <linux/irqchip/irq-renesas-rzt2h.h>
>>   #include <linux/list.h>
>> +#include <linux/lockdep.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/of_dma.h>
>> @@ -63,6 +64,14 @@ struct rz_dmac_desc {
>>
>>   #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
>>
>> +/**
>> + * enum rz_dmac_chan_status: RZ DMAC channel status
>> + * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
>> + */
>> +enum rz_dmac_chan_status {
>> +	RZ_DMAC_CHAN_STATUS_PAUSED,
>> +};
>> +
> 
> Not sure why use BIT() for each status? suppose only one certain state

Later (in the next patches), a channel could be paused (or paused internally) 
and cyclic at the same time. This way we can keep a single member in struct 
rz_dmac_chan for all these and execute a single instruction when clearing the 
status bit (e.g. in rz_dmac_free_chan_resources(), rz_dmac_terminate_all()).

I consider this more compact than having individual state variables for all these.

-- 
Thank you,
Claudiu


