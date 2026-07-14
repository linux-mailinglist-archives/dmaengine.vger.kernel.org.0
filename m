Return-Path: <dmaengine+bounces-12522-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gw18CJiwVmqiAAEAu9opvQ
	(envelope-from <dmaengine+bounces-12522-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:56:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B80C6759154
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:56:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=oEHcraLz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12522-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12522-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8A8F302FEA4
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB942BE95;
	Tue, 14 Jul 2026 21:56:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA0418A2C;
	Tue, 14 Jul 2026 21:56:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066186; cv=none; b=LqUYqoGe799brGGIxeufMhaLORWp9BXgCl4gk9BtBa0nBVe+HfFfIBUqB6YuMEAbDobVQJVRxCGBG8q+hGiCzPAFV81yVEFuCAzgvfuTzZBrMAyCEHRbke31znZEdksMohOC00p8V6dP9GRDBjvxycipSOSWnAel4tWxRb7IRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066186; c=relaxed/simple;
	bh=lRmb6HCU9B+bp6w1hqqymNpMjfL4vxsnsvabcJ0elbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWai/zgUUL7sEi5r65D/oipj8i1oiNNp8KqDR47fxjYbRvAZjxgUB9khAbmODInDJOpgacVKvCufiNxdBDCc8u8rIh120n+wrPOmeYBankYJ2o8YOxg/Tcqbl+BX2op+ATYpuvhK13DuXj0+jradSyaW/eYaIg4rF+6dYrs2yqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEHcraLz; arc=none smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784066185; x=1815602185;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lRmb6HCU9B+bp6w1hqqymNpMjfL4vxsnsvabcJ0elbk=;
  b=oEHcraLzR5WADudjhUiOdHdlc8/ntpPYhbaOiroLU+CrU978p2F5K62y
   jh/XYcGx2d6s6/xd6EGlmZHw+E8Wfh2vHLVZYCIu0Ui5A4MYjaDMu7gEK
   IKHM+9bv/KT+KORIPcowZygk+lXB6ktX/ZWThtiux4R3zEpcMkTBAjK8f
   Y/bd50d9HmIjqu3DME7IN8D7j9E1KQOfYf4pS+E//QWZT99cFXuHwlkjK
   b94LYkkj2NWJr5x/HXtYVs77wx5xt8uCoO6R+w7s/B8yhOH75KS+oayHv
   6aJLgyGCA/vP5Hp+vQIhrwa8lJ43z56hDZeKZRi7gGrRuVvYSXtYn31xC
   A==;
X-CSE-ConnectionGUID: cuwNwwDhQJKVPvOcQQUU2w==
X-CSE-MsgGUID: Gb9tqQgKQAm/E5KRZ9RXiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="72223479"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="72223479"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 14:56:25 -0700
X-CSE-ConnectionGUID: +wuyvbA9TQGVlkH5cElinA==
X-CSE-MsgGUID: 7zMPcqLoQKCUqrKmOkj3+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="251561223"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 14:56:23 -0700
Message-ID: <fa0a99aa-6bef-4ca2-93d8-f475b5f9ca1f@intel.com>
Date: Tue, 14 Jul 2026 14:56:22 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] crypto: iaa - avoid counting fallback decompression
 bytes
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
 <20260713-iaa-crypto-fixes-zswap-v1-3-65cac23c684d@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260713-iaa-crypto-fixes-zswap-v1-3-65cac23c684d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-12522-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:mid,intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B80C6759154



On 7/13/26 9:10 PM, Vinicius Costa Gomes wrote:
> From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> 
> When decompression falls back to deflate-generic after an analytics
> error, the request no longer completes through IAA.
> 
> Move decompression byte accounting into the successful IAA completion
> path in both the synchronous and asynchronous flows so decomp_bytes only
> reflects bytes actually processed by IAA.
> 
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Missing Vinicius sign-off.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/crypto/intel/iaa/iaa_crypto_main.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> index fb154959c2aa..8f68b1478476 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> @@ -1084,15 +1084,17 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
>  		}
>  	} else {
>  		ctx->req->dlen = idxd_desc->iax_completion->output_size;
> +
> +		if (!ctx->compress) {
> +			update_total_decomp_bytes_in(ctx->req->slen);
> +			update_wq_decomp_bytes(iaa_wq->wq, ctx->req->slen);
> +		}
>  	}
>  
>  	/* Update stats */
>  	if (ctx->compress) {
>  		update_total_comp_bytes_out(ctx->req->dlen);
>  		update_wq_comp_bytes(iaa_wq->wq, ctx->req->dlen);
> -	} else {
> -		update_total_decomp_bytes_in(ctx->req->slen);
> -		update_wq_decomp_bytes(iaa_wq->wq, ctx->req->slen);
>  	}
>  
>  	if (ctx->compress && compression_ctx->verify_compress) {
> @@ -1475,16 +1477,16 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
>  		}
>  	} else {
>  		req->dlen = idxd_desc->iax_completion->output_size;
> +
> +		/* Update stats */
> +		update_total_decomp_bytes_in(slen);
> +		update_wq_decomp_bytes(wq, slen);
>  	}
>  
>  	*dlen = req->dlen;
>  
>  	if (!ctx->async_mode)
>  		idxd_free_desc(wq, idxd_desc);
> -
> -	/* Update stats */
> -	update_total_decomp_bytes_in(slen);
> -	update_wq_decomp_bytes(wq, slen);
>  out:
>  	return ret;
>  err:
> 


