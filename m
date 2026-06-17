Return-Path: <dmaengine+bounces-11568-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9evwFa4GMmqEtwUAu9opvQ
	(envelope-from <dmaengine+bounces-11568-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 04:30:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AD1696227
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 04:30:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=126.com header.s=s110527 header.b=okul5jce;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11568-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11568-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=126.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73A9830A715E
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 02:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3FB3016E0;
	Wed, 17 Jun 2026 02:30:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B74285C91;
	Wed, 17 Jun 2026 02:29:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663403; cv=none; b=IDV/C/OV2zgPooHhaUhixHmB4oCdVOgX4qibbFny7tQyvWzspmfbndS7mjSRCWVfmmrzBuPzspL6sN5A0Ogy5EIrMEbLJzbXo6/ziVWMDWijFymH/3iaMS4gfW2NjDXoFbQ96dfqwZcjVG0Zx17/ri5BLEW3009mTnwH3bjpKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663403; c=relaxed/simple;
	bh=L0xgJ+rKai2YUY8+NiLjHYLjaNCjJuHB7FtFOxM5/R4=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=Z45mvrwZXWNzZeCSC872JuwHhwth4pPebMDPEIECKqHsyvnXVcIDWuEsI6xn7g3a7vlYJd+mXsnwUbMYMnHEqHasWjIIqG/8Z13eSgntq2P+I0ioRi2dB4+oZhz7HbyQXyjOjVjkCKnmmsmHyTPcKNw3SuSK+s39AzQOSi4A5Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=okul5jce; arc=none smtp.client-ip=220.197.31.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=T2eQr/t8U1wQpTsAv2oqP/O+K73c/8wMmiyGmptHgmo=;
	b=okul5jce2NFh3k5vp7WjDI0WDf67UyKt1/zDFBfi7heNVLjta++no3Fk8aRn0P
	ciVVscI7M0P+K5pPcxXkuITBoOh99FFUTrtATDtMx7usCts/BmfRXq33c1Xg2JtY
	qHQS/9IDoT0wwsBwuHjZzbFVEseW4Ei1UqHOLzqIft4tw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgCXL2ddBjJqASY2BQ--.52696S2;
	Wed, 17 Jun 2026 10:28:46 +0800 (CST)
Message-ID: <6A32065F.3030705@126.com>
Date: Wed, 17 Jun 2026 10:28:47 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Frank Li <Frank.li@oss.nxp.com>
CC: Hongling Zeng <zenghongling@kylinos.cn>, vkoul@kernel.org, 
 Frank.Li@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, 
 samuel@sholland.org, mripard@kernel.org, arnd@arndb.de, 
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: sun6i-dma: Fix memory leak in sun6i_dma_terminate_all
References: <20260616060449.42225-1-zenghongling@kylinos.cn> <ajG2aR70B4z6j1fd@SMW015318>
In-Reply-To: <ajG2aR70B4z6j1fd@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgCXL2ddBjJqASY2BQ--.52696S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxur15JF1UWFW3WrWDWryfJFb_yoW5XF13pr
	W5Ja13GFW5Jwsaga1ftw4FqF1Yqa13tF47u3y5Zw13Zr45trnFkF1xCw1F9F4DArn8Zrn0
	yFs8Z34xC3WUCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jstxhUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoR6-kGoyBl5mLQAA3b
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:zenghongling@kylinos.cn,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:mripard@kernel.org,m:arnd@arndb.de,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhongling0719@126.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[126.com];
	TAGGED_FROM(0.00)[bounces-11568-lists,dmaengine=lfdr.de];
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
	FREEMAIL_CC(0.00)[kylinos.cn,kernel.org,gmail.com,sholland.org,arndb.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3AD1696227

Hi Frank and Jernej Skrabec:

      Thanks for all the review!

   You're absolutely right.After checking virt-dma.h, I see that 
desc_terminated is the correct queue for actively terminated transfers. 
I'll update to use:

   - vchan_terminate_vdesc(vd);

   I'll send v3 ,Please help to review.

   Best regards,
   Hongling Zeng

在 2026年06月17日 04:47, Frank Li 写道:
> On Tue, Jun 16, 2026 at 02:04:49PM +0800, Hongling Zeng wrote:
>> When terminating a non-cyclic DMA transfer, the active descriptor
>> is not properly reclaimed. The descriptor is removed from the
>> desc_issued list in sun6i_dma_start_desc(), but in
>> sun6i_dma_terminate_all(), only cyclic transfer descriptors are
>> added to the desc_completed list before cleanup.
>>
>> For non-cyclic transfers, pchan->desc is set to NULL without first
>> adding the descriptor back to a list that vchan_get_all_descriptors()
>> can collect. This causes the descriptor and its associated LLI chain
>> to be permanently leaked.
>>
>> Fix by ensuring both cyclic and non-cyclic active descriptors are
>> added to the desc_completed list before setting pchan->desc to NULL.
>>
>> Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>>
>> ---
>>   Change in v2;
>>   -Add pchan->desc != pchan->done check to prevent race condition
>>    where completed descriptors could be double-added to desc_completed
>>    list, causing list corruption
>> ---
>>   drivers/dma/sun6i-dma.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
>> index 7a79f346250a..12d038ef5f2e 100644
>> --- a/drivers/dma/sun6i-dma.c
>> +++ b/drivers/dma/sun6i-dma.c
>> @@ -946,16 +946,14 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
>>
>>   	spin_lock_irqsave(&vchan->vc.lock, flags);
>>
>> -	if (vchan->cyclic) {
>> -		vchan->cyclic = false;
>> -		if (pchan && pchan->desc) {
>> -			struct virt_dma_desc *vd = &pchan->desc->vd;
>> -			struct virt_dma_chan *vc = &vchan->vc;
>> +	if (pchan && pchan->desc && pchan->desc != pchan->done) {
>> +		struct virt_dma_desc *vd = &pchan->desc->vd;
>> +		struct virt_dma_chan *vc = &vchan->vc;
>>
>> -			list_add_tail(&vd->node, &vc->desc_completed);
>> -		}
>> +		list_add_tail(&vd->node, &vc->desc_completed);
> should It be in desc_terminated queue?
>
> ref: https://lore.kernel.org/dmaengine/ajETw7uwVx_U9o5F@ryzen/T/#m541c24b45fb425c6a8a81d800db225b58411447e
>
> Frank
>>   	}
>>
>> +	vchan->cyclic = false;
>>   	vchan_get_all_descriptors(&vchan->vc, &head);
>>
>>   	if (pchan) {
>> --
>> 2.25.1
>>


