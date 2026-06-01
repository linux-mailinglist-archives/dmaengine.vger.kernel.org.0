Return-Path: <dmaengine+bounces-11106-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHs/NseiHWrmcgkAu9opvQ
	(envelope-from <dmaengine+bounces-11106-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 17:18:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D9B6217FB
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 17:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EAC83049703
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 15:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9935F3DA5B6;
	Mon,  1 Jun 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dm7JAemL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0273D9028;
	Mon,  1 Jun 2026 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326739; cv=none; b=GV2g6TqsoJ9KwSW8Oaf1NbbJYmVqesyG4v41Wtj364Pr5r7jCdU6nnwgG/B7f5wNNJ6YokpaBgTyfmmoAf1cIcRUyFnOb3Pi9gg0qKVi3YxpEjMw1lpUbihjZgWef+LW7sGy9KM41gNsQFq1l8Lu58wcBPg+f9lA1rni/P7tG7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326739; c=relaxed/simple;
	bh=2saUA1jn4UBCFlo11E7lmGLbC/fnZCl5La8sqtYuxaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MIMvvuoB7/uh3r0Vrp+E3ZIOLA6Vg7XxbfhyX4wBpjYkXc+N4kDviblfRB9Xx8G9mZlXSsrqSEEbgEf9RVuLRrG5fcZZzaNdcSBojhcuNhvSxOhpzvzZ3+aFJ0A41Aq+R+dizpzE1qKclxH1fAn2MkGoWJWsr0oFFKm7gvVZhjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dm7JAemL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780326734; x=1811862734;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2saUA1jn4UBCFlo11E7lmGLbC/fnZCl5La8sqtYuxaE=;
  b=Dm7JAemLztpBPySFuo5Fs3XLYkh/JDCOS1K6UvrS8mMwHCCWjI+av6ki
   rRsdhn2no4tNQY+WeGsyx1jcsL30iiJ1GN0+6fkSdF7vJBJQOSvH0hPFa
   u627SgCFimaq/C9iK2Cqof6vkNNyIXDYdPqyeNyHMbo5Hyr5hI6QdGNV8
   RchSgbvMhE7RhFvudmbNC6RuGsIpgMdYSjpt8V574ZaQgq8rkOaUiA4ef
   7TxB1fkBRKOJdfmX3qB4scIsSmbCOtCox5Z7urzDZSslbmPkOgoiUuhOw
   1Urgi7hMjxkZ1LRbhqebYPKSx7i789Nv6l05f8km74AtPJyzfSY43Qj5L
   g==;
X-CSE-ConnectionGUID: kZVG8tcaTdmM0SPvrawr4g==
X-CSE-MsgGUID: Ql+WUjBeR7SzURZa8p6k7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="68621200"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="68621200"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 08:12:13 -0700
X-CSE-ConnectionGUID: E4oYExVPQA6ZQMObcnhcOA==
X-CSE-MsgGUID: tU6dUduTQtOd135+CW50EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242549205"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.248]) ([10.125.111.248])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 08:12:12 -0700
Message-ID: <ab53cd17-894b-471c-959d-52cfdafb0d22@intel.com>
Date: Mon, 1 Jun 2026 08:12:11 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ioatdma: use !kstrtoint(), not sscanf()!=-1
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Ujjal Singh <ujjal.singh@intel.com>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM"
 <dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260526061321.6123-1-grandmaster@al2klimov.de>
 <20260526061321.6123-3-grandmaster@al2klimov.de>
 <9461e4b3-d42b-4550-a931-19532588bdbc@intel.com>
 <48fac400-4813-4b14-986d-8392c7faf936@al2klimov.de>
 <da523982-576f-4bf8-95b6-79cecf683f55@intel.com>
 <ef38b0e8-2b6f-4f65-bac5-177b981479ae@al2klimov.de>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ef38b0e8-2b6f-4f65-bac5-177b981479ae@al2klimov.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11106-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,al2klimov.de:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 87D9B6217FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/31/26 1:56 AM, Alexander A. Klimov wrote:
> 
> 
> On 5/28/26 22:06, Dave Jiang wrote:
>>
>>
>> On 5/26/26 11:06 AM, Alexander A. Klimov wrote:
>>>
>>>
>>> On 5/26/26 16:49, Dave Jiang wrote:
>>>>
>>>>
>>>> On 5/25/26 11:13 PM, Alexander A. Klimov wrote:
>>>>> Depending on the user input, sscanf() may return 0 for 0 success.
>>>>> But intr_coalesce_store() wants sscanf() to parse one number,
>>>>> so expect 1 from sscanf(), not any int except -1.
>>>>>
>>>>> While on it, fix typo in %du by using just %d,
>>>>> as this interface expects %d or %d\n.
>>>>> Latter made scripts/checkpatch.pl complain,
>>>>> so use kstrtoint() instead of sscanf().
>>>>>
>>>>> Fixes: 268e2519f5b7 ("dmaengine: ioatdma: Add intr_coalesce sysfs entry")
>>>>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>>>>> ---
>>>>>    drivers/dma/ioat/sysfs.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
>>>>> index e796ddb5383f..f59df569956a 100644
>>>>> --- a/drivers/dma/ioat/sysfs.c
>>>>> +++ b/drivers/dma/ioat/sysfs.c
>>>>> @@ -144,7 +144,7 @@ size_t count)
>>>>>        int intr_coalesce = 0;
>>>>>        struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
>>>>>    -    if (sscanf(page, "%du", &intr_coalesce) != -1) {
>>>>> +    if (!kstrtoint(page, 10, &intr_coalesce)) {
>>>>
>>>> looks good. We can probably use kstrtouint() since we are expecting a positive number always.
>>>
>>> This would break `return -EINVAL;` below
>>
>> Shouldn't we just drop the < 0 compare since it's no longer needed?
> 
> Wouldn't that change behavior shown to userspace from return -EINVAL
> on negative int input to return count?

No a negative value would trigger parsing error and return -EINVAL. Same behavior for user.


