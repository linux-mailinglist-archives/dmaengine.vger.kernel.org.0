Return-Path: <dmaengine+bounces-11908-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ydgVE/+fRGp9yAoAu9opvQ
	(envelope-from <dmaengine+bounces-11908-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 07:05:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D85256E9C57
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 07:05:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=126.com header.s=s110527 header.b=knMDHtmM;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11908-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11908-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=126.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D5E53033200
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 05:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C081389104;
	Wed,  1 Jul 2026 05:04:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1302E9729;
	Wed,  1 Jul 2026 05:04:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782882292; cv=none; b=osfTMIjO7MgiOW7/bQOfSzWUO3Bo2FsID9IrW2pnLRx/DGGQYhgHAWthx6edhHdFwDuJ2M0suIXksoUHD5lokGHm/4X4sal304tkzrlMk+UYEHTvWaQ3lrhPM/EuzlGKNRjMcnlg5UBg+iBACe9RNBMEl4dxOAPim9vJ2w1bAVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782882292; c=relaxed/simple;
	bh=KjIbJHU90ib+jTpiDe5aw8cQYg6/8a5nemKTHlQn9EM=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=X2BAYaIO72YtQNEVdQXMqENn0/BKufc2FpzUOB5KRxexw3JzZxVKp6EJUQH+JVNDsw3dIJfqbbd8eBYnLYSb0i35eu+81g29jFgKpnCGzcsBXuZp1ZjiilYnaSZ1ftSjM4q+ZwTy2+O40Vze9kAtnAmOtrWrcZKbPiqKxhCD9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=knMDHtmM; arc=none smtp.client-ip=220.197.31.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=PMBPcXK7F9JzTFv1nefMDOq5iPo0GYCsozEaqsHN4vM=;
	b=knMDHtmMn1dz5JlbEGJC9cZBgLUltl5h/HWCv4SMolUIOxtpN5zgkldLYseu9H
	Yjpt1apTcRPZgjob4s39n9LAolVDucJknxM3AzmawDAwYzCxusncHqiwjc4sLlqF
	A1Z1t9LPyQkZe/qc0V6FOZQcXgVQ8nyE1v3aG5r7LoJhY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgB3H2chn0Rqwjx7CA--.7136S2;
	Wed, 01 Jul 2026 13:01:22 +0800 (CST)
Message-ID: <6A449F14.8030207@126.com>
Date: Wed, 01 Jul 2026 13:01:08 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Vinod Koul <vkoul@kernel.org>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: Frank.Li@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, 
 samuel@sholland.org, mripard@kernel.org, arnd@arndb.de, 
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.li@oss.nxp.com>
Subject: Re: [PATCH v4] dmaengine: sun6i-dma: Fix memory leak in sun6i_dma_terminate_all
References: <20260618020609.1155962-1-zenghongling@kylinos.cn> <akOptOSkd7o0Vivk@vaman>
In-Reply-To: <akOptOSkd7o0Vivk@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgB3H2chn0Rqwjx7CA--.7136S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW3Gr48urWxWrW3XFWrKrg_yoW5JFy5pr
	yUGw43CFWrJa9ag3Wftw4FqFn8Xa13tFW7CrWUXw15Zr4Ygr12kr1Ik34Fga1kAwn8uF4F
	ya1Yq347CF1UurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsEf5UUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrgKbbGpEnyJQWQAA3B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:zenghongling@kylinos.cn,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:mripard@kernel.org,m:arnd@arndb.de,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:Frank.li@oss.nxp.com,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhongling0719@126.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[126.com];
	TAGGED_FROM(0.00)[bounces-11908-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[126.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhongling0719@126.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,arndb.de,vger.kernel.org,lists.infradead.org,lists.linux.dev,oss.nxp.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D85256E9C57


在 2026年06月30日 19:34, Vinod Koul 写道:
> On 18-06-26, 10:06, Hongling Zeng wrote:
>> When terminating DMA transfers, active descriptors are not properly
>> reclaimed. Only cyclic descriptors were handled, leaving non-cyclic
>> descriptors and their LLI chains to be permanently leaked.
>>
>> Fix by using vchan_terminate_vdesc() which handles both cyclic and
>> non-cyclic descriptors by adding them to desc_terminated queue for
>> proper cleanup.
>>
>> Add pchan->desc != pchan->done check to prevent double-adding completed
>> descriptors, which would corrupt the list.
> Thanks for the patch. Please consider revising the subject which should
> describe the changes in the patch and not the fix/issue.
>
> A better one would be "fix reclaim descriptors while terminating"
   Thank you for the suggestion. I'll update the subject in v5 to describe
   the changes rather than the issue.

>> Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>> Suggested-by: Frank Li <Frank.li@oss.nxp.com>
>>
>> ---
>>   Change in v2;
>>   -Add pchan->desc != pchan->done check to prevent race condition
>>    where completed descriptors could be double-added to desc_completed
>>    list, causing list corruption
>> ---
>>   Change in v3:
>>   -Fix by using vchan_terminate_vdesc() as suggested by Frank Li
>> ---
>>   Change in v4:
>>   -Correct the commit message
>> ---
>>   drivers/dma/sun6i-dma.c | 13 +++++--------
>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
>> index 7a79f346250a..134ae840f176 100644
>> --- a/drivers/dma/sun6i-dma.c
>> +++ b/drivers/dma/sun6i-dma.c
>> @@ -946,16 +946,13 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
>>   
>>   	spin_lock_irqsave(&vchan->vc.lock, flags);
>>   
>> -	if (vchan->cyclic) {
>> -		vchan->cyclic = false;
>> -		if (pchan && pchan->desc) {
>> -			struct virt_dma_desc *vd = &pchan->desc->vd;
>> -			struct virt_dma_chan *vc = &vchan->vc;
>> -
>> -			list_add_tail(&vd->node, &vc->desc_completed);
>> -		}
>> +	if (pchan && pchan->desc && pchan->desc != pchan->done) {
>> +		struct virt_dma_desc *vd = &pchan->desc->vd;
>> +		
>> +		vchan_terminate_vdesc(vd);
>>   	}
>>   
>> +	vchan->cyclic = false;
>>   	vchan_get_all_descriptors(&vchan->vc, &head);
>>   
>>   	if (pchan) {
>> -- 
>> 2.25.1


