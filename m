Return-Path: <dmaengine+bounces-12535-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yAAHG3vjVmrLCQEAu9opvQ
	(envelope-from <dmaengine+bounces-12535-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 03:33:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD56759E61
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 03:33:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HCjrT2Cd;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12535-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12535-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58746302802D
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E400570809;
	Wed, 15 Jul 2026 01:33:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585D42BC2D
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 01:33:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079224; cv=none; b=AIaG01prBVzlKc28pEQ/rxDKw89V7TnzDCt0eVIR62nMXl19s7buFLyCKAEWyHRd+s3a4AUk0JQB9Y74KULI5uRTN7xfE3S8B+a0ro+4TGaZ7qx6sfB69iKG9BngVgb0eAmVom6jCh85m37hJ7fS7X7ZP3ZRVL7E+0NwmEhPkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079224; c=relaxed/simple;
	bh=9ZtRQE2ENIyQxxN4TmqFgEBu/yhvmsXeCiObhpJg/is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hx52+8n+HrLFtQDKIvPazlt5SBTzbYwxxfhEOEt2WEUkMrNq0HpFuY2lO3kjfz0ONDn5D4xrUvNVBPvBnsMQJRRI4Qwh/5EYUx9WlZGx6RtCTkcZ8eiPy0k8R5Uo166O1vObQAqTvKAnoaq82Q/NBBTh2Epc191oAzEFeUpT/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCjrT2Cd; arc=none smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784079221; x=1815615221;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=9ZtRQE2ENIyQxxN4TmqFgEBu/yhvmsXeCiObhpJg/is=;
  b=HCjrT2Cd0DoEDcd8H/7efFiUWskzClN3tp2n14oHkp4HjWSDgYE2Su9D
   aV/s74aR/1KUqBFSGQHgmo68qRoFwVKDwdVMWXDTj2ATFHgwDMrRZq+ZG
   +Xtl3O0oFgVGBwWG6RoqakZgIgdnFZHi5o33wOhIlG2NM/rToTZdxIWlS
   h0FhLoQ9K2o8xDWuZpWLRuuwnJf0V9g8Ne0wSxh03uLfQ1jHOT10zxL/F
   9BorzeKT2qcezL7v60hegBp9A6cSiS8ilFz1kpPJ798zVOitt6DKexJ8e
   hzifgBP+9aWhmZ+LU34So9eSOiu/J25g69x83L6GEI88nt3UjpHwWbWWq
   A==;
X-CSE-ConnectionGUID: 3WGwychUQG20mtQwgVuWxQ==
X-CSE-MsgGUID: eyKu0CDbTc+cz8zP/mRDyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95063704"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95063704"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 18:33:34 -0700
X-CSE-ConnectionGUID: d3FOSo9RTLiO+HGkzZQNrg==
X-CSE-MsgGUID: STtRs6yAR1ibnokLhACUxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="249650629"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO vcostago-mobl3) ([10.125.108.174])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 18:33:27 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 3/4] crypto: iaa - avoid counting fallback decompression
 bytes
In-Reply-To: <20260714042149.5F3091F00A3A@smtp.kernel.org>
References: <20260713-iaa-crypto-fixes-zswap-v1-0-65cac23c684d@intel.com>
 <20260713-iaa-crypto-fixes-zswap-v1-3-65cac23c684d@intel.com>
 <20260714042149.5F3091F00A3A@smtp.kernel.org>
Date: Tue, 14 Jul 2026 18:33:26 -0700
Message-ID: <874ii1qbo9.fsf@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12535-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADD56759E61

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Pre-existing DMA API violation: software fallback
> (`deflate_generic_decompress`) writes to the destination scatterlist
> while it is still mapped for DMA (`DMA_FROM_DEVICE`), leading to
> silent data corruption when unmapped if SWIOTLB or confidential
> computing is active.

Even if this is pre-existing, will think a bit more about this one, and
see if I can fix this more or less easily.

> --
>
> --- Patch [3]: [PATCH 3/4] crypto: iaa - avoid counting fallback decompre=
ssion bytes ---
> commit 589e7e250edf8839b3b071db5475eb3581825d01
> Author: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
>
> crypto: iaa - avoid counting fallback decompression bytes
>
> When decompression falls back to deflate-generic after an analytics
> error, the request no longer completes through IAA. Move decompression
> byte accounting into the successful IAA completion path in both the
> synchronous and asynchronous flows so decomp_bytes only reflects bytes
> actually processed by IAA.
>
>> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto=
/intel/iaa/iaa_crypto_main.c
>> index fb154959c2aa8..8f68b1478476e 100644
>> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
>> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
>> @@ -1084,15 +1084,17 @@ static void iaa_desc_complete(struct idxd_desc *=
idxd_desc,
>>  		}
>>  	} else {
>
> [Severity: High]
> This is a pre-existing issue, but does calling deflate_generic_decompress=
()
> in the error path just above this block violate the DMA API?
>
> In iaa_desc_complete(), if check_completion() fails with IAA_ANALYTICS_ER=
ROR,
> the driver falls back to software decompression:
>
> drivers/crypto/intel/iaa/iaa_crypto_main.c:iaa_desc_complete() {
>     ...
>     ret =3D deflate_generic_decompress(ctx->req);
>     ...
> err:
>     dma_unmap_sg(dev, ctx->req->dst, sg_nents(ctx->req->dst), DMA_FROM_DE=
VICE);
>     ...
> }
>
> Because the scatterlist is still mapped for DMA, won't dma_unmap_sg()
> overwrite the CPU's decompression work with the bounce buffer contents
> if SWIOTLB or confidential computing is active?
>
>>  		ctx->req->dlen =3D idxd_desc->iax_completion->output_size;
>> +
>> +		if (!ctx->compress) {
>> +			update_total_decomp_bytes_in(ctx->req->slen);
>> +			update_wq_decomp_bytes(iaa_wq->wq, ctx->req->slen);
>> +		}
>>  	}
>
> [ ... ]
>
>> @@ -1475,16 +1477,16 @@ static int iaa_decompress(struct crypto_tfm *tfm=
, struct acomp_req *req,
>>  		}
>>  	} else {
>
> [Severity: High]
> This is a pre-existing issue, but is there a similar DMA API violation he=
re?
>
> In iaa_decompress(), the synchronous path executes the software fallback
> and returns to the caller:
>
> drivers/crypto/intel/iaa/iaa_crypto_main.c:iaa_decompress() {
>     ...
>     ret =3D deflate_generic_decompress(req);
>     ...
> out:
>     return ret;
> }
>
> Does this mean the caller will subsequently unmap the scatterlist and
> unknowingly overwrite the fallback's data when SWIOTLB is active?
>
>>  		req->dlen =3D idxd_desc->iax_completion->output_size;
>> +
>> +		/* Update stats */
>> +		update_total_decomp_bytes_in(slen);
>> +		update_wq_decomp_bytes(wq, slen);
>>  	}
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-iaa-cryp=
to-fixes-zswap-v1-0-65cac23c684d@intel.com?part=3D3

--=20
Vinicius

