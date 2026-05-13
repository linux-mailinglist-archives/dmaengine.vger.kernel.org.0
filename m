Return-Path: <dmaengine+bounces-10418-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFl7GH2EBGrVKwIAu9opvQ
	(envelope-from <dmaengine+bounces-10418-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:02:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8BD5349B0
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3AD731898A5
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0E43F4127;
	Wed, 13 May 2026 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQyRCV17"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E893F4124;
	Wed, 13 May 2026 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679303; cv=none; b=MsGJT8G1jUJz/h7vZiOOgqXy3IntPv2jBoZPNk5xAO4bpYWk0BXc6FsCa9vN3qqWcrhlVIaMBIOC84jZ5EjlrjHEVbRRNNdDRf+vdxWchwRLzDYTuLHgUV0fBAUp09zMNnUuXN6QF/N+0ykYyr3BOidsUMLURRqnjoKXM+VqE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679303; c=relaxed/simple;
	bh=3VeMbMY1AOL2o82Oo+2ts6NUi06EqjZABaZifMYNeus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTayC5bPHpifwpNtLJ9odz3Y58SC+VzkZkjDfb3L+N1qYAvV7gy39B0YJriCXxJKJNOLqoJXMpGqUm25WzPSpwFd9pVaRml2mlTM3bmhsS6HTtGNFy0w9Qj5p++CsemC4olZMh3MyqlanYEU+SWjDFKTMvmfdfUl3EnSSuJVkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQyRCV17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6264C2BCB7;
	Wed, 13 May 2026 13:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778679303;
	bh=3VeMbMY1AOL2o82Oo+2ts6NUi06EqjZABaZifMYNeus=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TQyRCV17bWYM1kxOmLl0tJgguCbJyBIpzFU4ROVvnK00j1RMpOL7nn0hI6PRtSFBW
	 yGnCYlrEKjrjdYseV3H/TAYBrUIw9V8meu8noDxd+0/h1wBggD5maDTNy9bSuUpGVF
	 M9RS1v9AOrBhSdcVXdtui7RkShsQ41egS1wMZJVdnrWudMg3YL7CcjLf5+bwROfueL
	 n1DvBPym3qmmo1jiqV0gshxuEAjafEhTaeOxoy3hAnSMqcFpAC07oNqub6AcqIKt85
	 QAel9avNPuyGcxqDkjWSLUNJFGiYU3dr+9TdVVTg6nlFRgn7p1CZZApKCbeC3EOoZ9
	 0rPBUMGYwPMhg==
Message-ID: <f42c561d-8473-4d3b-a105-844de9cfeed1@kernel.org>
Date: Wed, 13 May 2026 16:34:57 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/17] dmaengine: sh: rz-dmac: Use virt-dma APIs for
 channel descriptor processing
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
 <20260512121219.216159-10-claudiu.beznea.uj@bp.renesas.com>
 <agOdyrPVur-NGfhq@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <agOdyrPVur-NGfhq@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3E8BD5349B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10418-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi, Frank,

On 5/13/26 00:38, Frank Li wrote:
> On Tue, May 12, 2026 at 03:12:10PM +0300, Claudiu Beznea wrote:
>> The driver used a mix of virt-dma APIs and driver specific logic to
>> process descriptors. It maintained three internal queues: ld_free,
>> ld_queue, and ld_active as follows:
>> - ld_free: stores the descriptors pre-allocated at probe time
>> - ld_queue: stores descriptors after they are taken from ld_free and
>>    prepared. At the same time, vchan_tx_prep() queues them to
>>    vc->desc_allocated. The vc->desc_allocated list is then checked in
>>    rz_dmac_issue_pending() and rz_dmac_irq_handler_thread() before
>>    starting a new transfer via rz_dmac_xfer_desc(). In turn,
>>    rz_dmac_xfer_desc() grabs the next descriptor from vc->desc_issued and
>>    submits it for transfer
>> - ld_active: stores the descriptors currently being transferred
>>
>> The interrupt handler moved a completed descriptor to ld_free before
>> invoking its completion callback. Once returned to ld_free, the
>> descriptor can be reused to prepare a new transfer. In theory, this
>> means the descriptor could be re-prepared before its completion
>> callback is called.
>>
>> Commit fully back the driver by the virt-dma APIs. With this, only ld_free
>> need to be kept to track how many free descriptors are available. This
>> is now done as follows:
>> - the prepare stage removes the first descriptor from the ld_free and
>>    prepares it
>> - the completion calls for it vc->desc_free() (rz_dmac_virt_desc_free())
>>    which re-adds the descriptor at the end of ld_free
>>
>> With this, the critical areas in prepare callbacks were minimized to only
>> getting the descriptor from the ld_free list.
> 
> Do you plan remove ld_free also?

I thought about it. But I prefer to keep it aside from this set as it is already 
big enough and I haven't notice any possible issue with it.

> 
>>
>> This change introduces struct rz_dmac_chan::desc to keep track of the
> 
> Remove "this change", just Introduce ...

OK

-- 
Thank you,
Claudiu


