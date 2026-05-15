Return-Path: <dmaengine+bounces-10487-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGwND7hFB2qgvwIAu9opvQ
	(envelope-from <dmaengine+bounces-10487-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 18:11:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC7552CD6
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 18:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9224C3036AFE
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 15:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9823FF1D5;
	Fri, 15 May 2026 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLxbvCYf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CCA3FF1DA;
	Fri, 15 May 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860396; cv=none; b=c1FDr9SOcIUTMXT9aXfz02A1j7QBMFbpWpD5DnwmViWPPp16oAFabJBc/nGVFcpIx1eDIL0uU23/87G/rBogJS/onlrJ68ckUiIdc1OrCZeIUlhhHS8vAt4jwhfIQgIN8nqGnUHCVovMqnGzteo2sknSZLoGz7yquS0XMzexQN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860396; c=relaxed/simple;
	bh=M4gY2h6P2P8MDlTavWbOY/URprPBD6HWXCETyDVT91c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=og0Sy3OVT8SQzeiBeUegT3diIyYJkuQrBBZdzCUoMJrfPAyHBsotZMRjbWgRSoqeLSLaVgKln2QfiT0VY1rPx6ouL4RIq2N1NLbWe/PgTDMbfeTRZGvBziNDG8+9Pfe2rpB8OcwAgwRWhTd/s/LpHWp0QofsqrZcFTqjDCtwOd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLxbvCYf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778860395; x=1810396395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M4gY2h6P2P8MDlTavWbOY/URprPBD6HWXCETyDVT91c=;
  b=CLxbvCYfGjCfjqo4fnlVLgUprWIRpLda6hWjHtEpuMRZQJWvRp5EW3WA
   ILiV1zk5Tfl5qEJgI4gl05KvlrN2Nvj251oPEazLEV0zzQjHpWKmOjhfh
   sCqWbMGUuVGUkBNaMXPSaN1mPxlAyZrwwNnMPQmc0EndyNcbDLAE+9jDD
   EHADzPzQRiEI3gdfsLTIazR3AnCZ4kNgvsZC1N0wIHq5tD1vFopUV6Mbf
   s0oRxINasKanMenyNwnT0KcZtMOaXwgCQyJoi/M97Bz1QgbHqB/5g5E0z
   yiJYqSVpIa3MKhDDR0lTXZ5SPR1p4AkP9TYuVpjMUWuTbbi87UgfTvTwh
   g==;
X-CSE-ConnectionGUID: O9Ypt7MKQZS/6j2oMWlV4w==
X-CSE-MsgGUID: gTOBIY4sTk2BpfH5TLlHbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="90920790"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="90920790"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 08:53:15 -0700
X-CSE-ConnectionGUID: gwa4ZgF6QNSr4ohM0MSLbw==
X-CSE-MsgGUID: EUx1GBEsQ/u/H98HBRl7MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262244745"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 08:53:13 -0700
Message-ID: <8407feed-0619-4b94-95c7-0d2f27c643c3@intel.com>
Date: Fri, 15 May 2026 08:53:12 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: idxd: fix deadlock and double free in
 idxd_cdev_open()
To: Yuho Choi <dbgh9129@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260515142623.793549-1-dbgh9129@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260515142623.793549-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 44CC7552CD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10487-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action



On 5/15/26 7:26 AM, Yuho Choi wrote:
> The failed_dev_add and failed_dev_name error paths in idxd_cdev_open()
> drop the file-device reference while still holding wq->wq_lock. If this
> is the last reference, put_device(fdev) runs idxd_file_dev_release(),
> which takes wq->wq_lock again and deadlocks.
> 
> Those error paths also fall through into the later ctx cleanup labels
> after idxd_file_dev_release() has already freed ctx. This can make
> idxd_xa_pasid_remove(ctx) operate on freed memory and can later free ctx
> again at the failed label.
> 
> Use scoped put_device() cleanup for fdev and return from the fdev setup
> failure path after unlocking wq->wq_lock. Take the WQ reference before
> fdev can be released so idxd_file_dev_release() always balances a
> matching idxd_wq_get().
> 
> Fixes: e6fd6d7e5f0fe ("dmaengine: idxd: add a device to represent the file opened")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
> Changes in v2:
> - Use __free(put_device) for the file-device reference.
> - Take the WQ reference before fdev can be released so the release
>   callback's idxd_wq_put() has a matching idxd_wq_get().
> 
>  drivers/dma/idxd/cdev.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 0366c7cf3502..18ff29118d12 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -216,7 +216,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>  	struct idxd_user_context *ctx;
>  	struct idxd_device *idxd;
>  	struct idxd_wq *wq;
> -	struct device *dev, *fdev;
> +	struct device *dev, *fdev __free(put_device) = NULL;

It's probably not a good idea to mix scope based cleanups with gotos. Use one or the other and not both. Otherwise the whole thing become a mess to read and maintain. In this function it looks to be pretty difficult to completely convert to scope based cleanups so I suggest avoiding it.

DJ

>  	int rc = 0;
>  	struct iommu_sva *sva = NULL;
>  	unsigned int pasid;
> @@ -289,6 +289,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>  	fdev->bus = &dsa_bus_type;
>  	fdev->type = &idxd_cdev_file_type;
>  
> +	idxd_wq_get(wq);
>  	rc = dev_set_name(fdev, "file%d", ctx->id);
>  	if (rc < 0) {
>  		dev_warn(dev, "set name failure\n");
> @@ -301,13 +302,14 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>  		goto failed_dev_add;
>  	}
>  
> -	idxd_wq_get(wq);
> +	fdev = NULL;
>  	mutex_unlock(&wq->wq_lock);
>  	return 0;
>  
>  failed_dev_add:
>  failed_dev_name:
> -	put_device(fdev);
> +	mutex_unlock(&wq->wq_lock);
> +	return rc;
>  failed_ida:
>  failed_set_pasid:
>  	if (device_user_pasid_enabled(idxd))


