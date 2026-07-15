Return-Path: <dmaengine+bounces-12534-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kj18MOviVmquCQEAu9opvQ
	(envelope-from <dmaengine+bounces-12534-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 03:31:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A10759E47
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 03:31:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gkCMbJoO;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12534-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12534-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C33530252AC
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092A870809;
	Wed, 15 Jul 2026 01:31:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3A42BC2D
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 01:31:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079080; cv=none; b=MncdVY+KAGyONIRaUIznberQn/JYrv8oY2Nnrgp1q0MlOkpqhbzTXghGMV3dEIPVyVJ2mm+Y84DO1sZ08/+Uxx9SZHtA90X+LG9o3tXChG/hhgkQPHN4/x0KCftb5hzRqM0FMlmGVY4TKbNxfjczg4yij/wT8D8VqXmOrv6ckYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079080; c=relaxed/simple;
	bh=gEZSpkDWmhVTu28ZP23SlosL6YgIl0g5v4JYYcUHyyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mbn1Gz+fUjzEU1rRR88Xl6ax2yvUoa3TsBpRw21OGZKgL8k9pFD8X1XtC+k8ElasfQoPFlzsYiNkr7R2SE72xtbqXPQARKouC9gvTFABCp1jpU4daMxcvKEdEHRPQiXZCTUaxRz5Rb6m6/k+mToGqLzrFo56b/WYPuha6AXsDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkCMbJoO; arc=none smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784079077; x=1815615077;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=gEZSpkDWmhVTu28ZP23SlosL6YgIl0g5v4JYYcUHyyU=;
  b=gkCMbJoOOVZ9Zim5hBeXvYrzIEGjTz4BFNOUEWh5aM2AL2uJpRnQ1IkY
   Y6vkxUNuJsfz4nUJzcWnn0bpIS8C5AqgPLVfp5dkN2tvH3uLeajwCm085
   nQJh7XAMI+tWcZOoRDIJxzVNF1Ay+4224qa5y7/+fL+LFn8hKzcrrJEwF
   zd1zaszrbdtf8JjMXxn8x+VZ1kyQqCwQCXYxdcqOgaADq3ETfQIUi8X8Z
   qjwej85RmO9RH+A9gT1tQsUv90+j8i2GmIcnW+9D3+sJwWWcldRU4Jxi+
   Pk8QTbWSlU970uEZC1VZ2AbL/5rlC/0mgkRwLXoZCxX/rtk6PE53jf7Lt
   g==;
X-CSE-ConnectionGUID: YV6V2cH+Q5e3sLv5NZBZjg==
X-CSE-MsgGUID: S98dWYhKQq2tHsu9DrOVkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="107504537"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="107504537"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 18:31:17 -0700
X-CSE-ConnectionGUID: t27DOH7CTACLuYt0UMLbVQ==
X-CSE-MsgGUID: GZhyI5tyRt6g9SV5pPzX1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="254281293"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO vcostago-mobl3) ([10.125.108.174])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 18:31:17 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
Subject: Re: [PATCH 2/4] crypto: iaa - fall back to software for multi-entry
 scatterlists
In-Reply-To: <20260714043606.BBD8B1F000E9@smtp.kernel.org>
References: <20260713-iaa-crypto-fixes-zswap-v1-0-65cac23c684d@intel.com>
 <20260713-iaa-crypto-fixes-zswap-v1-2-65cac23c684d@intel.com>
 <20260714043606.BBD8B1F000E9@smtp.kernel.org>
Date: Tue, 14 Jul 2026 18:31:16 -0700
Message-ID: <87a4rtqbrv.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12534-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,intel.com:from_mime,intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1A10759E47

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Hardcoding the `nents` parameter to 1 in `dma_map_sg` causes
> a kernel panic if `req->dst` is NULL.

Upper layers tries to not give us req->dst being NULL, but will be a bit
more defensive.

> - [Medium] The implementation tracks fallback calls rather than processed=
 bytes, contradicting the commit message.
>

Will fix the commit message.

> Pre-existing issues:
> - [High] Software fallback writes to CPU memory while DMA bounce buffers =
are mapped, risking data corruption during unmap.
> - [High] A timeout during hardware polling causes the CPU to free DMA str=
uctures while the hardware device may still be performing DMA, leading to U=
se-After-Free memory corruption.
> --
>
> --- Patch [2]: [PATCH 2/4] crypto: iaa - fall back to software for multi-=
entry scatterlists ---
> commit 6f1532575ac946d82236e0ac6dffd05320f89063
> Author: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Subject: crypto: iaa - fall back to software for multi-entry scatterlists
>
> This commit adds a software fallback for the IAA driver when dealing with
> scatterlists containing multiple entries, as the hardware cannot process
> them directly. It simplifies the DMA mapping path to expect a single entry
> and adds counters for the fallback path.
>
>>     Add counters to track the number of bytes processed by the software
>>     implementation on the compression direction.
>
> [Severity: Medium]
> The commit message states that counters are added to track the number of
> bytes processed. However, looking at the updates in iaa_crypto_stats.c:
>
> void update_total_sw_comp_calls(void)
> {
>         atomic64_inc(&total_sw_comp_calls);
> }
>
> Could it be that the implementation only tracks fallback calls rather than
> the processed bytes?
>
>> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto=
/intel/iaa/iaa_crypto_main.c
>> index f62b994e18e58..fb154959c2aa8 100644
>> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
>> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> [ ... ]
>> @@ -983,17 +984,43 @@ static inline int check_completion(struct device *=
dev,
>>  	return ret;
>>  }
>
> [Severity: High]
> This is a pre-existing issue, but how does the driver handle hardware
> DMA after a timeout?
>
> In check_completion(), if the polling loop exceeds IAA_COMPLETION_TIMEOUT,
> it returns -ETIMEDOUT:
>
> check_completion() {
>     while (!comp->status) {
>         if (status_checks++ >=3D IAA_COMPLETION_TIMEOUT) {
>             ret =3D -ETIMEDOUT;
>             goto out;
>         }
>         ...
>     }
> }
>
> When this timeout happens, the caller immediately frees the IDXD descript=
or
> and unmaps the DMA buffers. However, the hardware might still be actively
> processing the request. If the delayed hardware eventually performs a DMA
> write to the destination address after the CPU has reallocated that memory
> for something else, could this cause silent memory corruption?
>
>> -static int deflate_generic_decompress(struct acomp_req *req)
>> +static int deflate_fallback(struct acomp_req *req, bool compress)
> [ ... ]
>> +static int deflate_generic_decompress(struct acomp_req *req)
>> +{
>> +	int ret;
>> +
>> +	ret =3D deflate_fallback(req, false);
>> +	if (ret)
>> +		return ret;
>> +
>>  	update_total_sw_decomp_calls();
>>=20=20
>> -	return ret;
>> +	return 0;
>>  }
>
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential problem when
> deflate_generic_decompress() is called as a fallback from iaa_decompress(=
).
>
> If a hardware error like IAA_ANALYTICS_ERROR occurs in iaa_decompress(),
> the software fallback writes to the CPU virtual mapping of req->dst:
>
> iaa_decompress() {
>     ...
>     if (idxd_desc->iax_completion->status =3D=3D IAA_ANALYTICS_ERROR) {
>         ret =3D deflate_generic_decompress(req);
>         ...
>     }
> }
>
> Since req->dst is still mapped for DMA_FROM_DEVICE at this point,
> when dma_unmap_sg() is eventually called, might it synchronize memory
> from a bounce buffer over the original CPU buffer, overwriting the
> software fallback's output? Should the scatterlist be unmapped before
> invoking the software fallback?
>
> [ ... ]
>> @@ -1507,30 +1538,25 @@ static int iaa_comp_acompress(struct acomp_req *=
req)
> [ ... ]
>> -	nr_sgs =3D dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVI=
CE);
>> -	if (nr_sgs <=3D 0 || nr_sgs > 1) {
> [ ... ]
>> +	if (!dma_map_sg(dev, req->dst, 1, DMA_FROM_DEVICE)) {
>
> [Severity: High]
> If req->dst is NULL, sg_nents() will return 0, bypassing the fallback che=
ck
> earlier in this function. Calling dma_map_sg() unconditionally with nents=
=3D1
> will then attempt to dereference the NULL scatterlist pointer.
>
> Would it be safer to verify req->dst is not NULL before attempting to map
> it, preserving the old behavior where sg_nents(req->dst) returning 0 was
> handled safely?
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-iaa-cryp=
to-fixes-zswap-v1-0-65cac23c684d@intel.com?part=3D2

--=20
Vinicius

