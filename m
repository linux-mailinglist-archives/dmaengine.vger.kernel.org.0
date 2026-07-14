Return-Path: <dmaengine+bounces-12521-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OrIUHGewVmqYAAEAu9opvQ
	(envelope-from <dmaengine+bounces-12521-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:55:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F75759136
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:55:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=cvNApS7d;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12521-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12521-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58EC93024A6B
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F068418A2C;
	Tue, 14 Jul 2026 21:55:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E72931D7;
	Tue, 14 Jul 2026 21:55:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066144; cv=none; b=mOx9c4JeqzFTpCcEu38m2MHLbStc/6FcH4sWIysZuXuw26TODaeB7KjeUmEQ5V10Y/63Qxd/d/sUK5HmqBaDHpWHTTmSza7NeDj3WIdpfzgok/af4cavrrVflkuWVWzU4hfbdDX+KZRW9rcjxq3quSpsTIIYjaHCsO2eY3jj2mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066144; c=relaxed/simple;
	bh=kJe5yEiPerRVzS/pD24EU1zICnUSnzVRnMRFg7e/KbM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jkNAuMRRMjUI/L+t4zJMfW7i7yPG2tverbwWoAIvehpTjBjxiLw86TfhPzxqGyJ+4vfn4k8MReNM8fZlVdoXyQ4T8mEdCq949kxr0uVB3lB1kwtKtXJLaAcelKKeFa7BdEA2l0zc/jA+IOSgk5sIxMgqP2OAPiGeizNpuTYWH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvNApS7d; arc=none smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784066143; x=1815602143;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=kJe5yEiPerRVzS/pD24EU1zICnUSnzVRnMRFg7e/KbM=;
  b=cvNApS7dZ8Q94pb4z3OzZP8WWYsLmMeqIa62q+fQ9HLWR4BdM0FgI8sU
   VhTCzfyzX4r7RIjfcAqdGOV9Js1gBLeJXZAcqNAjf8WHao5xzZUwiJqFh
   jHe9LudTAZowJ2CsB0+ONAj+jn1R7pi49zfMxRMHPYQrpHd5r3MEjTL6r
   o68NxcBBTg5wP4S/ii1QZcwUczbyMStwm49o6HvcVAaFsRP5BWI+aRt0g
   /K00fuP711S9wvBg/atW2Fn3VD2f9jIPgdQDnz2TYIj63OKsXPkfhEYma
   saTlJ8IKF9r6yJJK1FNPVKyOuQqrFCq2g1TxMa4TGuwgHhJGQkSL2idLx
   g==;
X-CSE-ConnectionGUID: DoP1sgyWQrCpmVsuFesemQ==
X-CSE-MsgGUID: 7L2sSOTgRFaThBU6oJ/Seg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95298116"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95298116"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 14:55:42 -0700
X-CSE-ConnectionGUID: svFQM7BwT6u1cpLwXyeOWA==
X-CSE-MsgGUID: C7hBFPSRQFWRiXH2g8udVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="252014410"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 14:55:40 -0700
Message-ID: <1caa4de2-0aff-4281-8e5a-402b3278cb20@intel.com>
Date: Tue, 14 Jul 2026 14:55:40 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dmaengine: idxd: assign all engines to group 0 in IAA
 defaults
From: Dave Jiang <dave.jiang@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Kristen Accardi <kristen.c.accardi@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, Giovanni Cabiddu <giovanni.cabiddu@intel.com>
References: <20260713-iaa-crypto-fixes-zswap-v1-0-65cac23c684d@intel.com>
 <20260713-iaa-crypto-fixes-zswap-v1-1-65cac23c684d@intel.com>
 <90c8d0e8-99fc-4fd8-bdfd-f3093ffac256@intel.com>
Content-Language: en-US
In-Reply-To: <90c8d0e8-99fc-4fd8-bdfd-f3093ffac256@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:vinicius.gomes@intel.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kristen.c.accardi@intel.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:akpm@linux-foundation.org,m:yosry@kernel.org,m:nphamcs@gmail.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:giovanni.cabiddu@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,kernel.org,gondor.apana.org.au,davemloft.net,linux-foundation.org,gmail.com];
	FORGED_SENDER(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12521-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0F75759136



On 7/14/26 2:53 PM, Dave Jiang wrote:
> 
> 
> On 7/13/26 9:10 PM, Vinicius Costa Gomes wrote:
>> From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
>>
>> The IAA device defaults only assigned engine 0 to group 0, leaving
>> engines 1 through max_engines-1 unassigned (group_id = -1). This means
>> that by default only a single engine processed descriptors, limiting
>> throughput to one engine's capacity.
>>
>> Assign all available engines to group 0 so that the full hardware
>> parallelism is used out of the box without requiring manual
>> accel-config setup.
>>
>> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> 

Just noticed it's missing Vinicius sign off. 

> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> 
>> ---
>>  drivers/dma/idxd/defaults.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/defaults.c b/drivers/dma/idxd/defaults.c
>> index 2bbbcd02a0da..26ebfa2ca144 100644
>> --- a/drivers/dma/idxd/defaults.c
>> +++ b/drivers/dma/idxd/defaults.c
>> @@ -8,6 +8,7 @@ int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
>>  	struct idxd_engine *engine;
>>  	struct idxd_group *group;
>>  	struct idxd_wq *wq;
>> +	int i;
>>  
>>  	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
>>  		return 0;
>> @@ -41,11 +42,12 @@ int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
>>  	/* set driver_name to "crypto" */
>>  	strscpy_pad(wq->driver_name, "crypto");
>>  
>> -	engine = idxd->engines[0];
>> -
>> -	/* set engine group to 0 */
>> -	engine->group = idxd->groups[0];
>> -	engine->group->num_engines++;
>> +	/* assign all engines to group 0 */
>> +	for (i = 0; i < idxd->max_engines; i++) {
>> +		engine = idxd->engines[i];
>> +		engine->group = group;
>> +		group->num_engines++;
>> +	}
>>  
>>  	return 0;
>>  }
>>
> 
> 


