Return-Path: <dmaengine+bounces-12520-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QWz4CSCwVmqHAAEAu9opvQ
	(envelope-from <dmaengine+bounces-12520-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:54:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312E759118
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:54:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MGvIGLjn;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12520-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12520-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AE9D3021E7E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9E93F7A88;
	Tue, 14 Jul 2026 21:54:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE43F1AA8;
	Tue, 14 Jul 2026 21:54:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066073; cv=none; b=INPocUQD15og/bS3om9RPlur99ivMmbwlpfMgy2smIYeoQxhAMB2aO722SUKsyuPpMxXx3zuNH7oMdCQ8vIVKQYy1NzDBxkqwHUEFCPjvBxL9ZFGZOzPGMYkYoL28qrM3mc3303ZcuEF1pFYJ4q+m7Lh1fjkcGGI2HBPw2Ee5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066073; c=relaxed/simple;
	bh=p0KjtwMNVRVXVfUbidqsDMtQrUFw2JIo8yCDdBGsQ9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stDVMq24wPTjw9Jwm/K2v5cyJGnynccn6XWDwOVSDUKABXW4Lt9xQHGmCOLN3Yc2BX6e7uVFvLu+fgo5hQ+TysshJIh3CtGTAjfhBq2dd7leVdoU0hDujFizO3y/uAWUvz2+JCioWJCus8v/EKsuYyp47oh9uC1TqeLz3rQO+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGvIGLjn; arc=none smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784066070; x=1815602070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p0KjtwMNVRVXVfUbidqsDMtQrUFw2JIo8yCDdBGsQ9o=;
  b=MGvIGLjnetdsoS479h5jWs1zPW65YOQjb+eMiZnsF6/lxwYIekkXj5eW
   VJeNeEXD/eHSbd8LGmTpTJK1KANZwCF1ReqboFADXPwQKNdegIdYHaKfh
   a/YmqXOHSQpZEoEppxFF1Sn2rgBrJbDthL7V63TYQvuLNwt/f1iOFyjhe
   pPyZdTqBF3aAMG2TnvQKieKZVw13yw3LlQHjFzSFYnuItZmFe/YHdDUrg
   DPtoemwf9KBhdAgqJH6lQd/6io81qdeotRW8RZzaLCcBpvT34mWL+h4Yl
   28uke2NdI953NeI8XJyWfQK7gAt4PIgbbbFsXB/Qx6gP/oCArkBvhTVgb
   A==;
X-CSE-ConnectionGUID: Gadi45s5TBeKObJ89RtgkQ==
X-CSE-MsgGUID: vxFk4cUITnWXTSn02Z7jdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84579788"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84579788"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 14:54:30 -0700
X-CSE-ConnectionGUID: WLhbwy93Sw+AeXtC3p+l0g==
X-CSE-MsgGUID: OsXgIFuKRJuezsfWChhKcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="252595966"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 14:54:28 -0700
Message-ID: <d5417906-20d9-43a7-aa80-c130cbd05d53@intel.com>
Date: Tue, 14 Jul 2026 14:54:27 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] crypto: iaa - fall back to software for multi-entry
 scatterlists
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
 <20260713-iaa-crypto-fixes-zswap-v1-2-65cac23c684d@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260713-iaa-crypto-fixes-zswap-v1-2-65cac23c684d@intel.com>
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
	TAGGED_FROM(0.00)[bounces-12520-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 7312E759118



On 7/13/26 9:10 PM, Vinicius Costa Gomes wrote:
> From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> 
> IAA cannot process source or destination scatterlists with more than one
> entry directly. Instead of failing these requests, route them through a
> separate deflate acomp transform and keep the request alive in software.
> 
> Since commit e2c3b6b21c77 ("mm: zswap: use SG list decompression APIs
> from zsmalloc"), zswap passes the raw zsmalloc SG list directly to
> crypto drivers, so objects spanning multiple pages now reach IAA as
> multi-entry sources and would otherwise fail decompression.
> 
> Fallback to the generic DEFLATE implementation for scatterlists with
> more than one entry. After the multi-entry cases fall back early,
> simplify the DMA mapping path to a single scatterlist entry and fall
> back on mapping failure as well.
> 
> Add counters to track the number of bytes processed by the software
> implementation on the compression direction.
> 
> Fixes: e2c3b6b21c77 ("mm: zswap: use SG list decompression APIs from zsmalloc")
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Missing Vinicius sign off. 

DJ

> ---
>  drivers/crypto/intel/iaa/iaa_crypto_main.c  | 122 ++++++++++++++++------------
>  drivers/crypto/intel/iaa/iaa_crypto_stats.c |  11 ++-
>  drivers/crypto/intel/iaa/iaa_crypto_stats.h |   2 +
>  3 files changed, 84 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> index f62b994e18e5..fb154959c2aa 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
>  
>  #include <linux/init.h>
> +#include <linux/crypto.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -983,17 +984,43 @@ static inline int check_completion(struct device *dev,
>  	return ret;
>  }
>  
> -static int deflate_generic_decompress(struct acomp_req *req)
> +static int deflate_fallback(struct acomp_req *req, bool compress)
>  {
>  	ACOMP_FBREQ_ON_STACK(fbreq, req);
>  	int ret;
>  
> -	ret = crypto_acomp_decompress(fbreq);
> +	ret = compress ?
> +		crypto_acomp_compress(fbreq) :
> +		crypto_acomp_decompress(fbreq);
>  	req->dlen = fbreq->dlen;
>  
> +	return ret;
> +}
> +
> +static int deflate_generic_decompress(struct acomp_req *req)
> +{
> +	int ret;
> +
> +	ret = deflate_fallback(req, false);
> +	if (ret)
> +		return ret;
> +
>  	update_total_sw_decomp_calls();
>  
> -	return ret;
> +	return 0;
> +}
> +
> +static int deflate_generic_compress(struct acomp_req *req)
> +{
> +	int ret;
> +
> +	ret = deflate_fallback(req, true);
> +	if (ret)
> +		return ret;
> +
> +	update_total_sw_comp_calls();
> +
> +	return 0;
>  }
>  
>  static int iaa_remap_for_verify(struct device *dev, struct iaa_wq *iaa_wq,
> @@ -1472,7 +1499,7 @@ static int iaa_comp_acompress(struct acomp_req *req)
>  	struct iaa_compression_ctx *compression_ctx;
>  	struct crypto_tfm *tfm = req->base.tfm;
>  	dma_addr_t src_addr, dst_addr;
> -	int nr_sgs, cpu, ret = 0;
> +	int cpu, ret = 0;
>  	struct iaa_wq *iaa_wq;
>  	struct idxd_wq *wq;
>  	struct device *dev;
> @@ -1489,6 +1516,10 @@ static int iaa_comp_acompress(struct acomp_req *req)
>  		return -EINVAL;
>  	}
>  
> +	/* Fall back to software if src or dst has multiple sg entries */
> +	if (sg_nents(req->src) > 1 || sg_nents(req->dst) > 1)
> +		return deflate_generic_compress(req);
> +
>  	cpu = get_cpu();
>  	wq = wq_table_next_wq(cpu);
>  	put_cpu();
> @@ -1507,30 +1538,25 @@ static int iaa_comp_acompress(struct acomp_req *req)
>  
>  	dev = &wq->idxd->pdev->dev;
>  
> -	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
> -	if (nr_sgs <= 0 || nr_sgs > 1) {
> -		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
> -			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
> -			iaa_wq->wq->id, ret);
> -		ret = -EIO;
> -		goto out;
> +	if (!dma_map_sg(dev, req->src, 1, DMA_TO_DEVICE)) {
> +		dev_dbg(dev, "couldn't map src sg for iaa device %d, wq %d\n",
> +			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
> +		iaa_wq_put(wq);
> +		return deflate_generic_compress(req);
>  	}
>  	src_addr = sg_dma_address(req->src);
> -	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
> -		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
> +	dev_dbg(dev, "map src %llx req->src %p slen %d sg_len %d\n", src_addr,
>  		req->src, req->slen, sg_dma_len(req->src));
>  
> -	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
> -	if (nr_sgs <= 0 || nr_sgs > 1) {
> -		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
> -			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
> -			iaa_wq->wq->id, ret);
> -		ret = -EIO;
> -		goto err_map_dst;
> +	if (!dma_map_sg(dev, req->dst, 1, DMA_FROM_DEVICE)) {
> +		dev_dbg(dev, "couldn't map dst sg for iaa device %d, wq %d\n",
> +			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
> +		dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
> +		iaa_wq_put(wq);
> +		return deflate_generic_compress(req);
>  	}
>  	dst_addr = sg_dma_address(req->dst);
> -	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
> -		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
> +	dev_dbg(dev, "map dst %llx req->dst %p dlen %d sg_len %d\n", dst_addr,
>  		req->dst, req->dlen, sg_dma_len(req->dst));
>  
>  	ret = iaa_compress(tfm, req, wq, src_addr, req->slen, dst_addr,
> @@ -1550,8 +1576,8 @@ static int iaa_comp_acompress(struct acomp_req *req)
>  		if (ret)
>  			dev_dbg(dev, "asynchronous compress verification failed ret=%d\n", ret);
>  
> -		dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_TO_DEVICE);
> -		dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_FROM_DEVICE);
> +		dma_unmap_sg(dev, req->dst, 1, DMA_TO_DEVICE);
> +		dma_unmap_sg(dev, req->src, 1, DMA_FROM_DEVICE);
>  
>  		goto out;
>  	}
> @@ -1559,9 +1585,8 @@ static int iaa_comp_acompress(struct acomp_req *req)
>  	if (ret)
>  		dev_dbg(dev, "asynchronous compress failed ret=%d\n", ret);
>  
> -	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
> -err_map_dst:
> -	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
> +	dma_unmap_sg(dev, req->dst, 1, DMA_FROM_DEVICE);
> +	dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
>  out:
>  	iaa_wq_put(wq);
>  
> @@ -1572,7 +1597,7 @@ static int iaa_comp_adecompress(struct acomp_req *req)
>  {
>  	struct crypto_tfm *tfm = req->base.tfm;
>  	dma_addr_t src_addr, dst_addr;
> -	int nr_sgs, cpu, ret = 0;
> +	int cpu, ret = 0;
>  	struct iaa_wq *iaa_wq;
>  	struct device *dev;
>  	struct idxd_wq *wq;
> @@ -1587,6 +1612,10 @@ static int iaa_comp_adecompress(struct acomp_req *req)
>  		return -EINVAL;
>  	}
>  
> +	/* Fall back to software if src or dst has multiple sg entries */
> +	if (sg_nents(req->src) > 1 || sg_nents(req->dst) > 1)
> +		return deflate_generic_decompress(req);
> +
>  	cpu = get_cpu();
>  	wq = wq_table_next_wq(cpu);
>  	put_cpu();
> @@ -1605,30 +1634,25 @@ static int iaa_comp_adecompress(struct acomp_req *req)
>  
>  	dev = &wq->idxd->pdev->dev;
>  
> -	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
> -	if (nr_sgs <= 0 || nr_sgs > 1) {
> -		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
> -			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
> -			iaa_wq->wq->id, ret);
> -		ret = -EIO;
> -		goto out;
> +	if (!dma_map_sg(dev, req->src, 1, DMA_TO_DEVICE)) {
> +		dev_dbg(dev, "couldn't map src sg for iaa device %d, wq %d\n",
> +			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
> +		iaa_wq_put(wq);
> +		return deflate_generic_decompress(req);
>  	}
>  	src_addr = sg_dma_address(req->src);
> -	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
> -		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
> +	dev_dbg(dev, "map src %llx req->src %p slen %d sg_len %d\n", src_addr,
>  		req->src, req->slen, sg_dma_len(req->src));
>  
> -	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
> -	if (nr_sgs <= 0 || nr_sgs > 1) {
> -		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
> -			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
> -			iaa_wq->wq->id, ret);
> -		ret = -EIO;
> -		goto err_map_dst;
> +	if (!dma_map_sg(dev, req->dst, 1, DMA_FROM_DEVICE)) {
> +		dev_dbg(dev, "couldn't map dst sg for iaa device %d, wq %d\n",
> +			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
> +		dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
> +		iaa_wq_put(wq);
> +		return deflate_generic_decompress(req);
>  	}
>  	dst_addr = sg_dma_address(req->dst);
> -	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
> -		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
> +	dev_dbg(dev, "map dst %llx req->dst %p dlen %d sg_len %d\n", dst_addr,
>  		req->dst, req->dlen, sg_dma_len(req->dst));
>  
>  	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
> @@ -1639,10 +1663,8 @@ static int iaa_comp_adecompress(struct acomp_req *req)
>  	if (ret != 0)
>  		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
>  
> -	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
> -err_map_dst:
> -	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
> -out:
> +	dma_unmap_sg(dev, req->dst, 1, DMA_FROM_DEVICE);
> +	dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
>  	iaa_wq_put(wq);
>  
>  	return ret;
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
> index f5cc3d29ca19..55d0d9c6f61a 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
> @@ -19,6 +19,7 @@
>  
>  static atomic64_t total_comp_calls;
>  static atomic64_t total_decomp_calls;
> +static atomic64_t total_sw_comp_calls;
>  static atomic64_t total_sw_decomp_calls;
>  static atomic64_t total_comp_bytes_out;
>  static atomic64_t total_decomp_bytes_in;
> @@ -43,6 +44,11 @@ void update_total_decomp_calls(void)
>  	atomic64_inc(&total_decomp_calls);
>  }
>  
> +void update_total_sw_comp_calls(void)
> +{
> +	atomic64_inc(&total_sw_comp_calls);
> +}
> +
>  void update_total_sw_decomp_calls(void)
>  {
>  	atomic64_inc(&total_sw_decomp_calls);
> @@ -104,6 +110,7 @@ static void reset_iaa_crypto_stats(void)
>  {
>  	atomic64_set(&total_comp_calls, 0);
>  	atomic64_set(&total_decomp_calls, 0);
> +	atomic64_set(&total_sw_comp_calls, 0);
>  	atomic64_set(&total_sw_decomp_calls, 0);
>  	atomic64_set(&total_comp_bytes_out, 0);
>  	atomic64_set(&total_decomp_bytes_in, 0);
> @@ -174,6 +181,8 @@ static int global_stats_show(struct seq_file *m, void *v)
>  		   atomic64_read(&total_comp_calls));
>  	seq_printf(m, "  total_decomp_calls: %llu\n",
>  		   atomic64_read(&total_decomp_calls));
> +	seq_printf(m, "  total_sw_comp_calls: %llu\n",
> +		   atomic64_read(&total_sw_comp_calls));
>  	seq_printf(m, "  total_sw_decomp_calls: %llu\n",
>  		   atomic64_read(&total_sw_decomp_calls));
>  	seq_printf(m, "  total_comp_bytes_out: %llu\n",
> @@ -263,7 +272,7 @@ int __init iaa_crypto_debugfs_init(void)
>  	return 0;
>  }
>  
> -void __exit iaa_crypto_debugfs_cleanup(void)
> +void iaa_crypto_debugfs_cleanup(void)
>  {
>  	debugfs_remove_recursive(iaa_crypto_debugfs_root);
>  }
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.h b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
> index 3787a5f507eb..6e0c6f9939bf 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_stats.h
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
> @@ -11,6 +11,7 @@ void	iaa_crypto_debugfs_cleanup(void);
>  void	update_total_comp_calls(void);
>  void	update_total_comp_bytes_out(int n);
>  void	update_total_decomp_calls(void);
> +void	update_total_sw_comp_calls(void);
>  void	update_total_sw_decomp_calls(void);
>  void	update_total_decomp_bytes_in(int n);
>  void	update_completion_einval_errs(void);
> @@ -29,6 +30,7 @@ static inline void	iaa_crypto_debugfs_cleanup(void) {}
>  static inline void	update_total_comp_calls(void) {}
>  static inline void	update_total_comp_bytes_out(int n) {}
>  static inline void	update_total_decomp_calls(void) {}
> +static inline void	update_total_sw_comp_calls(void) {}
>  static inline void	update_total_sw_decomp_calls(void) {}
>  static inline void	update_total_decomp_bytes_in(int n) {}
>  static inline void	update_completion_einval_errs(void) {}
> 


