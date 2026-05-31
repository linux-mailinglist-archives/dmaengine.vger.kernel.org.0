Return-Path: <dmaengine+bounces-11072-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CImkM8f/G2o3IQkAu9opvQ
	(envelope-from <dmaengine+bounces-11072-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 11:30:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27661562F
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 11:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B905C3014641
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEBD33F5BE;
	Sun, 31 May 2026 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b="EtjMW2t1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AE033FE15;
	Sun, 31 May 2026 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780219799; cv=none; b=TxU592xIwPcWpiY3BbXjxcMa6ManPXUO9RQ7A4F3Mst8Kfyudkx/lq9HSms/2KspCmtcL6Rel+PeOqbBlq8tsIEVm7pvzwb3pdNV7TKwu650JAg/H7EP4XSl6hQmO6Z2/VKeWiUotIlgdFCoN+FLRbHHof/t5o7aKb51sPx9Uqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780219799; c=relaxed/simple;
	bh=nOGLe9zt9RLyrCg+dZcKXfPKxklIDT+1SJcbhu4vyRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HxLcVEcCrENJrsaE3rzcqBtfPR4ZjUMOBC6LHUDvkjmiGtAsBoIG5mqfBIjH5BfsIqyT0+BOh6A0+/Ex28Aym3IfOh4ok1waenKwIC6UPJIJeI5JEWIyb5Db4r0Pm6rU8zwbrV4xBoTJXDSO/MIRiXeF+1+Kh2aFXz1rn98W4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; spf=pass smtp.mailfrom=al2klimov.de; dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b=EtjMW2t1; arc=none smtp.client-ip=162.55.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=al2klimov.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=nOGLe9zt9RLy
	rCg+dZcKXfPKxklIDT+1SJcbhu4vyRs=; h=in-reply-to:from:references:to:
	subject:date; d=al2klimov.de; b=EtjMW2t1Jq61ywXlVajR6lSXhf1vkwed6QEPL7
	yF2DpKDz5/gNteZqTDx2+3SsVh9MhzxTMWjxBznuRxrUY256bOcfoNcc2UsxNniNpVMHHt
	oJv8qcPe8HkCk/xfKVHyz50hY8uvEA7Ri0o7bbrLuDi0+jJN5/GiPEz/GzKqaAvZVHEUUo
	gajuOdkItuh4Kd3nvbE+3blpL1L2I9fXeVmjLVTSh6fp8/ZX1zl4Bav/Dj1ic6+iceJWHu
	kr9DcES+wlG7acpfdbpplx08qP6vtifR7waXohmLVF/HMaU3gEqQWCyHY1rIhagOOcA7sf
	GD8mP0JjLQnYX8m30JdwZJMA==
Received: from [192.168.0.101] (88.215.123.80.dyn.pyur.net [88.215.123.80])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id 98504ab4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 31 May 2026 09:29:48 +0000 (UTC)
Message-ID: <ef38b0e8-2b6f-4f65-bac5-177b981479ae@al2klimov.de>
Date: Sun, 31 May 2026 10:56:08 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ioatdma: use !kstrtoint(), not sscanf()!=-1
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Ujjal Singh <ujjal.singh@intel.com>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM"
 <dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260526061321.6123-1-grandmaster@al2klimov.de>
 <20260526061321.6123-3-grandmaster@al2klimov.de>
 <9461e4b3-d42b-4550-a931-19532588bdbc@intel.com>
 <48fac400-4813-4b14-986d-8392c7faf936@al2klimov.de>
 <da523982-576f-4bf8-95b6-79cecf683f55@intel.com>
Content-Language: en-US
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
In-Reply-To: <da523982-576f-4bf8-95b6-79cecf683f55@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[al2klimov.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[al2klimov.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11072-lists,dmaengine=lfdr.de];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[al2klimov.de:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grandmaster@al2klimov.de,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4C27661562F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/28/26 22:06, Dave Jiang wrote:
> 
> 
> On 5/26/26 11:06 AM, Alexander A. Klimov wrote:
>>
>>
>> On 5/26/26 16:49, Dave Jiang wrote:
>>>
>>>
>>> On 5/25/26 11:13 PM, Alexander A. Klimov wrote:
>>>> Depending on the user input, sscanf() may return 0 for 0 success.
>>>> But intr_coalesce_store() wants sscanf() to parse one number,
>>>> so expect 1 from sscanf(), not any int except -1.
>>>>
>>>> While on it, fix typo in %du by using just %d,
>>>> as this interface expects %d or %d\n.
>>>> Latter made scripts/checkpatch.pl complain,
>>>> so use kstrtoint() instead of sscanf().
>>>>
>>>> Fixes: 268e2519f5b7 ("dmaengine: ioatdma: Add intr_coalesce sysfs entry")
>>>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>>>> ---
>>>>    drivers/dma/ioat/sysfs.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
>>>> index e796ddb5383f..f59df569956a 100644
>>>> --- a/drivers/dma/ioat/sysfs.c
>>>> +++ b/drivers/dma/ioat/sysfs.c
>>>> @@ -144,7 +144,7 @@ size_t count)
>>>>        int intr_coalesce = 0;
>>>>        struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
>>>>    -    if (sscanf(page, "%du", &intr_coalesce) != -1) {
>>>> +    if (!kstrtoint(page, 10, &intr_coalesce)) {
>>>
>>> looks good. We can probably use kstrtouint() since we are expecting a positive number always.
>>
>> This would break `return -EINVAL;` below
> 
> Shouldn't we just drop the < 0 compare since it's no longer needed?

Wouldn't that change behavior shown to userspace from return -EINVAL
on negative int input to return count?

