Return-Path: <dmaengine+bounces-11018-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBqrKMSHGGpnkwgAu9opvQ
	(envelope-from <dmaengine+bounces-11018-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 20:21:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2AF5F6363
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 20:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1717331BE590
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 18:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78185407CE1;
	Thu, 28 May 2026 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b="pP8278WC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C072BE7A7;
	Thu, 28 May 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992223; cv=none; b=mWX1Ihkm+lDYKS/87Hu+Wm8p5Do+gdUYAIKO/8wn58t86p594CyNHJ0nlvC621FmmAbIoEDlk9p93XMy1YifyHcwl+539xf+0oJytUyKB3Ap25e49wukD55ikF68eMjapV6xCpS629QUIkOVOp8CkMh5Srt/ug+YtU/tt3JT1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992223; c=relaxed/simple;
	bh=E2SWLaDBDzUSYehig9RlRQS9xP0OdvgcK/4Mf/TbqAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bZbRrMO105o3vPdtso0+U9QJzkTc5QM7lojstAJskDIzqoysMZzhIvY48VA2E8HmIyB0Ptxr02PxiOMtjxN5fsHsZaEnz70GTJvF0PtYgybjSz0eHG72QCx1ftY3KDSzgNtfRa4Q7Ei4rjSV7VNHLC5ZjnfoFJDttuHk8/P0hic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; spf=pass smtp.mailfrom=al2klimov.de; dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b=pP8278WC; arc=none smtp.client-ip=162.55.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=al2klimov.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=E2SWLaDBDzUS
	Yehig9RlRQS9xP0OdvgcK/4Mf/TbqAQ=; h=in-reply-to:from:references:to:
	subject:date; d=al2klimov.de; b=pP8278WChKl8f/zXlUQJNOB0CrS9WF8WsmgPOr
	0D7ScxK0SNdPxPpXiFXJ/DVxHunashUKeDnynIm0ec25GxZi1PBM2nYgirrsUu0jd2jzAQ
	/z+z9F25saPKVzldvXMu9HK8k1er3vxhB3CPssQwMacjT1fzmPr7N8Ba6muVkzSV3K01w/
	9mNag0R3Wvxi5Nv2scEvjkyKu0dgCsvKXS+iWye1anJnsNBclQTh9SMxOMf1kq0hWhzXrW
	UKgd3jgnB0jzn7Lh2EhibRUGLeZ0xIOzy9mjJOR298FUfs14UwRqK3wKJ1VWuUg1UyLZUk
	wcs10zAF/GKN2eMWMLeUbdAg==
Received: from [192.168.0.101] (88.215.123.80.dyn.pyur.net [88.215.123.80])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id 799bb7fc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 28 May 2026 18:16:53 +0000 (UTC)
Message-ID: <48fac400-4813-4b14-986d-8392c7faf936@al2klimov.de>
Date: Tue, 26 May 2026 20:06:33 +0200
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
Content-Language: en-US
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
In-Reply-To: <9461e4b3-d42b-4550-a931-19532588bdbc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[48];
	DMARC_POLICY_ALLOW(-0.50)[al2klimov.de,quarantine];
	R_DKIM_ALLOW(-0.20)[al2klimov.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11018-lists,dmaengine=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_TRACE(0.00)[al2klimov.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grandmaster@al2klimov.de,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[al2klimov.de:email,al2klimov.de:mid,al2klimov.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EE2AF5F6363
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/26 16:49, Dave Jiang wrote:
> 
> 
> On 5/25/26 11:13 PM, Alexander A. Klimov wrote:
>> Depending on the user input, sscanf() may return 0 for 0 success.
>> But intr_coalesce_store() wants sscanf() to parse one number,
>> so expect 1 from sscanf(), not any int except -1.
>>
>> While on it, fix typo in %du by using just %d,
>> as this interface expects %d or %d\n.
>> Latter made scripts/checkpatch.pl complain,
>> so use kstrtoint() instead of sscanf().
>>
>> Fixes: 268e2519f5b7 ("dmaengine: ioatdma: Add intr_coalesce sysfs entry")
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>> ---
>>   drivers/dma/ioat/sysfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
>> index e796ddb5383f..f59df569956a 100644
>> --- a/drivers/dma/ioat/sysfs.c
>> +++ b/drivers/dma/ioat/sysfs.c
>> @@ -144,7 +144,7 @@ size_t count)
>>   	int intr_coalesce = 0;
>>   	struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
>>   
>> -	if (sscanf(page, "%du", &intr_coalesce) != -1) {
>> +	if (!kstrtoint(page, 10, &intr_coalesce)) {
> 
> looks good. We can probably use kstrtouint() since we are expecting a positive number always.

This would break `return -EINVAL;` below

> 
> DJ
> 
>>   		if ((intr_coalesce < 0) ||
>>   		    (intr_coalesce > IOAT_INTRDELAY_MASK))
>>   			return -EINVAL;
> 


