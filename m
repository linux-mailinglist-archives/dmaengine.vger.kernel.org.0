Return-Path: <dmaengine+bounces-9454-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHqsLNKFuGltfAEAu9opvQ
	(envelope-from <dmaengine+bounces-9454-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 23:36:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 575BA2A1901
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 23:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58BAF301AE52
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 22:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F5D34A3A2;
	Mon, 16 Mar 2026 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="CnOC9H/D"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877C2364EA2;
	Mon, 16 Mar 2026 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700560; cv=none; b=qkQJKhBCiKcJ0Iyp5ZkBtvf5BqCHpYNyaH/kXr22Myl0+UousKs65UxZyVhq05TYhlRrEwXIu1hRGdk1kvqYkMaQXjvZLH9j0Z3Wj/03JizsBnV2qbBWurwE8ztHmEYLvoUtVWoURAqIDWi2DMAcENAjWWxrj6Qu+S/xJ+3ndaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700560; c=relaxed/simple;
	bh=Er5Om6vKr167gVVLMLzHw+KqbxEKNp/GaP8cU44hpIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxraZ9DX9gKyP9FtCtCMa6yCDjzEN9KcMarFfA567AJv8t7ubJmGabCxfA496iTozVV3Yar+rEBhTcR6QPXNk+rZLlShaay3E4Uox66lYxtcbELKcUtXCazDNsdk6480O5xlM0zmW4GsdFczxuY9CHPib4/siySftt03PDle4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=CnOC9H/D; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D03C10D582;
	Mon, 16 Mar 2026 23:35:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773700556;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=PeuyGZnZVt73gNnb6AoPMEvixfb/019SA0OSx6BMStU=;
	b=CnOC9H/DgyUvFXJEapVB9R/QvwEVBkq/W8sLQXIQP3otoy4mSa7/WzwwG0MifVaSPO9J1M
	PHk5ImJ9lQee/1oQHe/pdT5+1YO1VNHdlsqNit6XwkRguPmQLcgsJyjAYD9uEokCOYB6sg
	hzfoMnWWV9ZF/mRSxWz/vgKLux82Bt5RD459LaAbRu55684nuH+LsJh/LKfXQdoltRPibp
	riAQB69fawd79RA8t6H31HJDf7oTivTTG6wtfbiCs86JkvCk1qDD55KdubYKhtMN0jqHjw
	ZW/8hOzCIwPTSWAvcu2g+gCS5bAZoFNJKYiio18gMOrsL/3VtgXl6KDxfjgZww==
Message-ID: <95f13b52-41a4-409c-91c4-20141e208596@nabladev.com>
Date: Mon, 16 Mar 2026 23:35:52 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction
 reporting via device_caps
To: Folker Schwesinger <dev@folker-schwesinger.de>,
 Rahul Navale <rahulnavale04@gmail.com>
Cc: Rahul Navale <rahul.navale@ifm.com>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com,
 suraj.gupta2@amd.com, thomas.gessler@brueckmann-gmbh.de,
 radhey.shyam.pandey@amd.com, tomi.valkeinen@ideasonboard.com, marex@denx.de
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
 <20260309072822.5016-1-rahulnavale04@gmail.com>
 <DH2D8WNRXPUD.1205964NAEFPF@folker-schwesinger.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <DH2D8WNRXPUD.1205964NAEFPF@folker-schwesinger.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[folker-schwesinger.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-9454-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: 575BA2A1901
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/14/26 9:35 AM, Folker Schwesinger wrote:
> On Mon Mar 9, 2026 at 8:28 AM CET, Rahul Navale wrote:
>> I have applied provided patch (with kept RFC patch and debug stuff) and with
>> 7e01511443c3 applied. logs:
>>
>> root@pdm3:~# dmesg | grep ptr_res
>> [  198.997591] ptr_res: ptr = 0x00000000
>> ...
>> [  199.242820] ptr_res: ptr = 0x00000000
>>
>> Also I have applied provided patch (with kept RFC patch and debug stuff) and with
>> 7e01511443c3 reverted. logs:
>>
>> root@pdm3:~# dmesg | grep ptr_res
>> [   60.480754] ptr_res_no: ptr = 0x00000000
>> ...
>> [   60.600877] ptr_res_no: ptr = 0x00001770
>> ...
>> [   60.725869] ptr_res_no: ptr = 0x00002ee0
>> ...
>> [   60.850877] ptr_res_no: ptr = 0x00000000
>> ...
>> [   60.975869] ptr_res_no: ptr = 0x00001770
>> ...
> 
> This confirms that the residue_granularity field in dma_slave_caps,
> which gets properly set since 7e01511443c3 affects progress tracking in
> the PCM DMAEngine layer. Since Xilinx DMA advertises residue reporting
> with segment granularity [1], PCM DMAEngine switches from software based
> [2][3] progress tracking to hardware based progress tracking [4].
>  From my understanding however, residue reporting of the Xilinx DMA is
> incompatible with what the PCM DMAEngine expects. So the progression
> pointer is stuck at 0.
> 
> As I'm neither an expert in the PCM subsystem nor very familiar with
> residue reporting of the AXIDMA (and its limitations), I can't propose a
> solution that fixes the issue for you. I did a quick check of the code to
> see, if there is any way to force the DMAEngine PCM layer into software
> tracking from your custom driver. But I think there's no API to
> force-set the SND_DMAENGINE_PCM_FLAG_NO_RESIDUE bit in
> dma_engine_pcm->flags from your custom driver.
> Maybe there's a way to establish compatibility between PCM and AIXDMA in
> this regard. But to figure that out, I think more eyes on the issue from
> the audio experts and Xilinx/AMD engineers familiar with AXIDMA residue
> reporting would be needed.
> 
> Just to double check, and to make sure the regression you're seeing is
> not a combination of any additional, yet unknown side-effects, could you
> perform one more test?
> In dmaengine_pcm_pointer() (the function we just patched), could you
> replace the call to snd_dmaengine_pcm_pointer() with
> snd_dmaengine_pcm_pointer_no_residue() while keeping 7e01511443c3 active
> and test if this fixes your issue or not?
> 
> [1]: https://elixir.bootlin.com/linux/v6.19.3/source/drivers/dma/xilinx/xilinx_dma.c#L3284
> [2]: https://elixir.bootlin.com/linux/v7.0-rc3/source/sound/core/pcm_dmaengine.c#L136
> [3]: https://elixir.bootlin.com/linux/v7.0-rc3/source/sound/core/pcm_dmaengine.c#L235
> [4]: https://elixir.bootlin.com/linux/v7.0-rc3/source/sound/core/pcm_dmaengine.c#L251

I came to the same conclusion, that the residue handling is broken in 
the Xilinx DMA driver for cyclic transfers, and the fix is below, with 
two extra fixes on top:

https://lore.kernel.org/dmaengine/20260316221943.160375-1-marex@nabladev.com/
https://lore.kernel.org/dmaengine/20260316221728.160139-1-marex@nabladev.com/
https://lore.kernel.org/dmaengine/20260316222530.163815-1-marex@nabladev.com/

