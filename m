Return-Path: <dmaengine+bounces-11019-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1CRALJKiGGrKlggAu9opvQ
	(envelope-from <dmaengine+bounces-11019-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 22:16:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8D25F8388
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 22:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD06531AC94E
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 20:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B3304BB3;
	Thu, 28 May 2026 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSYwJsRr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58351335566;
	Thu, 28 May 2026 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998789; cv=none; b=bOSvSbAYjNYujGEgv30RnKA9pgOjknOo1JxjNakwSMbddVwkku4DF9qLpwMCvAE5RPOVzZOQIN4hVRvcU4/Ctr31Kq3QR9ON8nFJQrIxpJjekAaRzgeT3XYFuDJOTo/+EhrgKi7KhSPlycO2fjOV+vt9bKnPw3VqEbxOd6/evXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998789; c=relaxed/simple;
	bh=OPwLlGa+LZEYicR+OR7g/UZyMEoDMmofYPdn5PM3XQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vD4kZS9e7gxFD6FOAHU895VuzVqxb3qtvZ4SN0VL5YidjXHwSjqlfHr71wFQbEaQF/dI+CBgNWenFw+EAlMGcDOre7g2bEiuiLU71MKjsvDUyUmtcmQFZThdU7iBAZDz2aXOaQjsVhdBxczBVilCzRHkhyg5mcSGOcsAFyFUnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSYwJsRr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779998787; x=1811534787;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=OPwLlGa+LZEYicR+OR7g/UZyMEoDMmofYPdn5PM3XQ4=;
  b=nSYwJsRru7hVn/NcL18+rcclmQ7D2m7sE+ABi3Z0h79UI9vLCQ9ewuPJ
   1iFcZiQRALLopq1UyuTX1bieWkbjPvRUKIDG1Azo8UQ14d5DrCK1W/7fB
   trY3k++D0Z5OkvLNb6gmAW+WRWiM+RzOeRWLqL2gXQJgrhL+BzH9bGEM0
   uHg44zXhsiBWIIsLsvMm524gz+Ta+vgxa2XgAIXp+xRNFV4ixWTUQeMF0
   NFeOpDdA32Do6Uhpeu2s57tdhO3GqOj5P+Zpx+V6qCFgZN1uBBdaltM9t
   YsrASrka1CzGubgOAknAqGV9qLbgDx7CQXTUzO2LId9v0rovG0oVZCsb3
   A==;
X-CSE-ConnectionGUID: BU1UihbpSoufdI7ZNNI20Q==
X-CSE-MsgGUID: u6C/rf7nTbWwCGa9wOlgNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="68387061"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="68387061"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 13:06:26 -0700
X-CSE-ConnectionGUID: 2EruNyLwRPK0egDF1IVcZQ==
X-CSE-MsgGUID: oHCFenBmSrSpczK2WLOSOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="244466256"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.111.91]) ([10.125.111.91])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 13:06:26 -0700
Message-ID: <da523982-576f-4bf8-95b6-79cecf683f55@intel.com>
Date: Thu, 28 May 2026 13:06:25 -0700
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <48fac400-4813-4b14-986d-8392c7faf936@al2klimov.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11019-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:mid,intel.com:dkim,al2klimov.de:email]
X-Rspamd-Queue-Id: EA8D25F8388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/26 11:06 AM, Alexander A. Klimov wrote:
> 
> 
> On 5/26/26 16:49, Dave Jiang wrote:
>>
>>
>> On 5/25/26 11:13 PM, Alexander A. Klimov wrote:
>>> Depending on the user input, sscanf() may return 0 for 0 success.
>>> But intr_coalesce_store() wants sscanf() to parse one number,
>>> so expect 1 from sscanf(), not any int except -1.
>>>
>>> While on it, fix typo in %du by using just %d,
>>> as this interface expects %d or %d\n.
>>> Latter made scripts/checkpatch.pl complain,
>>> so use kstrtoint() instead of sscanf().
>>>
>>> Fixes: 268e2519f5b7 ("dmaengine: ioatdma: Add intr_coalesce sysfs entry")
>>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>>> ---
>>>   drivers/dma/ioat/sysfs.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
>>> index e796ddb5383f..f59df569956a 100644
>>> --- a/drivers/dma/ioat/sysfs.c
>>> +++ b/drivers/dma/ioat/sysfs.c
>>> @@ -144,7 +144,7 @@ size_t count)
>>>       int intr_coalesce = 0;
>>>       struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
>>>   -    if (sscanf(page, "%du", &intr_coalesce) != -1) {
>>> +    if (!kstrtoint(page, 10, &intr_coalesce)) {
>>
>> looks good. We can probably use kstrtouint() since we are expecting a positive number always.
> 
> This would break `return -EINVAL;` below

Shouldn't we just drop the < 0 compare since it's no longer needed?

> 
>>
>> DJ
>>
>>>           if ((intr_coalesce < 0) ||
>>>               (intr_coalesce > IOAT_INTRDELAY_MASK))
>>>               return -EINVAL;
>>
> 


