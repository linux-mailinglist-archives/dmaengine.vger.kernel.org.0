Return-Path: <dmaengine+bounces-10421-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J3zIryFBGrVKwIAu9opvQ
	(envelope-from <dmaengine+bounces-10421-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:07:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E14534B4A
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 246E032213F1
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4702DF128;
	Wed, 13 May 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeDNzbJh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7E3F412F;
	Wed, 13 May 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679558; cv=none; b=ui9uS+/irVREydem8/TeZsLeiOCzD1lSD7TvOXjjBiGh+rd6a3kt1mHky9D1g8Y2fHBLACF8mVVF9J1yagJkjVukv7pPv2Z0oI+B82blIzrf9mJBN0M6fbAcjoE44ANpBGy/8Q7dMGqNDhwjeBl8q93MIKxUU75jeWrxPbiFPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679558; c=relaxed/simple;
	bh=0EnrsKnnBnq2JUQb5BCHeSYxrstFhOumbAU6gWoMGes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FD1962kns5/nwdop8PU2nxncDCbv3cxZn4zLTPFJV0G4k2xotB4R3rmDRv0+sGOqkbkITx2y4eIGxbHn5IiQJXjFhj60N4KJhWVcZC+hLLUIUY4B2J6uAR95e4sDImm5O36+1xQfTqP3XYmURdIuota91ngziz0TxUDZScmq22Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeDNzbJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9672C2BCB7;
	Wed, 13 May 2026 13:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778679558;
	bh=0EnrsKnnBnq2JUQb5BCHeSYxrstFhOumbAU6gWoMGes=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TeDNzbJhSZwc6hn1/z/C8WK8v1GICAYeKKZx+B1/Qqop4Ir4gfNwB5ySaX+YTG/x8
	 UgmhB7WjUBT1YH4pl9z1kgsD91FsVycCX9idmUAaDVWR3jQubG08zLTI2vL9wvDKW3
	 Y6zmAU5ufcupMhcB+kY3I9DfYIDwQclVMZdTvgI33IbzAkXMbmjnzvuPN6k3beQYq3
	 /9ZMoacZNIrp2QfVhTHpi73ngGuldlziInVhW+TjUY3BzUnPONhqbhXifR86W7CftB
	 0ybgAEXiGHNrg9bY+TLieAkhPDN/gUTgt9MLRTf2mRohHbdtZLOUUsf8El+6DqCDNv
	 NQR4+XeL69IeQ==
Message-ID: <94430a9b-b5ae-475d-b001-e1a4ff35db8c@kernel.org>
Date: Wed, 13 May 2026 16:39:12 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/17] dmaengine: sh: rz-dmac: Add runtime PM support
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
 <20260512121219.216159-14-claudiu.beznea.uj@bp.renesas.com>
 <agOjwF12NI_jkOzR@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <agOjwF12NI_jkOzR@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 04E14534B4A
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
	TAGGED_FROM(0.00)[bounces-10421-lists,dmaengine=lfdr.de];
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

On 5/13/26 01:03, Frank Li wrote:
> On Tue, May 12, 2026 at 03:12:14PM +0300, Claudiu Beznea wrote:
>> Protect the driver exposed APIs with runtime PM suspend/resume calls
>> before accessing HW registers. As the current driver leaves runtime PM
>> enabled in probe, the purpose of the changes in this patch is to avoid
>> accessing HW registers after a failed system suspend leaves the runtime
>> PM state of the device improperly reinitialized.
>>
>> In that case, the driver remains bound to the device, the APIs are still
>> exposed, and any access to HW registers without runtime resuming the
>> device may lead to synchronous aborts.
>>
>> This patch prepares the driver for suspend-to-RAM support.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v5:
>> - none, this patch is new
>>
>>   drivers/dma/sh/rz-dmac.c | 48 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
>> index d6ad070be705..df91657fd5e3 100644
>> --- a/drivers/dma/sh/rz-dmac.c
>> +++ b/drivers/dma/sh/rz-dmac.c
>> @@ -488,7 +488,15 @@ static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
>>
>>   static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
>>   {
>> +	struct dma_chan *ch = &chan->vc.chan;
>> +	struct rz_dmac *dmac = to_rz_dmac(ch->device);
>>   	struct virt_dma_desc *vd;
>> +	int ret;
>> +
>> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
>> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
>> +	if (ret)
>> +		return;
> 
> According vnod comment *_prep() call may be called in atomic context
> (complete callback). but runtime_pm may sleep.

That's why the pm_runtime_irq_safe() was called in probe, to allow it being 
called in atomic context.

The series was tested with CONFIG_LOCKDEP=y and CONFIG_DEBUG_ATOMIC_SLEEP=y no 
issue was identified.

-- 
Thank you,
Claudiu


