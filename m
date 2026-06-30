Return-Path: <dmaengine+bounces-11894-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JOTHOTP2Q2q9mAoAu9opvQ
	(envelope-from <dmaengine+bounces-11894-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 19:00:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 214506E6B30
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 19:00:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Zt4oJqHX;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11894-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11894-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 066D0301F8DA
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A593D8116;
	Tue, 30 Jun 2026 17:00:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F23BCD04;
	Tue, 30 Jun 2026 17:00:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838822; cv=none; b=A8cB/utV1GOR8kY+1ahTC0dHuGscW2jes6aZcwaqM6Wo+uBnbz1J9P/f9CMZQakaP+NyL+1Rde9IMKmyvekKQgWrhjn4MVJh8dJ/txOIHj5VL9LTusUeLyUtvOB5R+aXox+FxgUgWkb8uEDik2lkNfS1tQSHG4LRxy9tu9nhmiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838822; c=relaxed/simple;
	bh=rQNL14oeQ/QRzd3KXDqIxnBmEO+YeYFuD4yEj/tMkFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZ82CASbbChtzr5X7sgOUPRxDUEnq1S5Xij0opkv02qigAGArn6ps3/36YWR7RmfT37GhrJLEQ1HyenznpU9IjeZK7cIUUZ/7Tq0aZyhkZnWSv7txX7wLBWfBXEZdFtoYkYhWkTQ6uBfJm9zXd/tYuy0NDzuYlqhY2rLc+L5obk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zt4oJqHX; arc=none smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782838821; x=1814374821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rQNL14oeQ/QRzd3KXDqIxnBmEO+YeYFuD4yEj/tMkFE=;
  b=Zt4oJqHX4Zfq6lSptYNBngLlb8qNfCbZUEPRIgG1vLVhKUauTOxBueEv
   796naLNuL6HJzsiyqFNDF8s++xwHYTZPG3JwMqGda1TGHqQOza412T4ll
   Oek5Tx1ztRN15tryCbV9mkAeEPo4UKo3R4kSF24Zq4gyCwZJDmTs2TQW0
   Anis+uawV1nFSk06+ZYs62RQd2H7jgv6IoHGgajMQkGx4ChA8rxhtTnbL
   mDVWS7OBPRvVkeRcoPCh/37Z500g7ptB/MxO0GekVw7mNaDbFwGqqjuxl
   Dr5vE9W4E1KReYpRBoyxlpTMxnrHCgu4VFydom44zIWPA6lUmbJCUPjUH
   Q==;
X-CSE-ConnectionGUID: KBNphKsoT2imFzNzasm8Pw==
X-CSE-MsgGUID: fuWZ2gHKQ4agUF3ZVWbcsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83589300"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83589300"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 10:00:20 -0700
X-CSE-ConnectionGUID: TjF50KayQ7KNCoLdVGv2tA==
X-CSE-MsgGUID: IdAB/a38SbaFVZVglUAiow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="252969732"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.254]) ([10.125.109.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 10:00:19 -0700
Message-ID: <33053773-aafb-483d-ab0d-957a9cd4074e@intel.com>
Date: Tue, 30 Jun 2026 09:59:58 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dmaengine: idxd: fix fdev setup failure cleanup in
 idxd_cdev_open()
To: Yuho Choi <dbgh9129@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260525141550.1385581-1-dbgh9129@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260525141550.1385581-1-dbgh9129@gmail.com>
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
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dbgh9129@gmail.com,m:vinicius.gomes@intel.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,kernel.org];
	FORGED_SENDER(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11894-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 214506E6B30



On 5/25/26 7:15 AM, Yuho Choi wrote:
> The failed_dev_add and failed_dev_name paths drop the file-device
> reference while wq->wq_lock is still held. If put_device(fdev) drops the
> last reference, idxd_file_dev_release() runs synchronously and tries to
> take wq->wq_lock again, deadlocking.
> 
> Those paths also fall through into the later ctx cleanup labels even
> though idxd_file_dev_release() owns that cleanup and frees ctx. This can
> make idxd_xa_pasid_remove(ctx) and kfree(ctx) operate on a freed context.
> 
> Move idxd_wq_get() before file-device setup can fail, since the release
> callback always calls idxd_wq_put(). Then unlock wq->wq_lock before
> put_device(fdev) and return directly from the file-device setup failure
> path, leaving ctx cleanup to the release callback.
> 
> Fixes: e6fd6d7e5f0fe ("dmaengine: idxd: add a device to represent the file opened")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> Changes in v3:
> - Drop scoped __free(put_device) cleanup and use explicit cleanup, as
>   suggested by Dave Jiang.
> - Keep idxd_wq_get() before file-device setup can fail so the release
>   callback always balances a matching WQ reference.
> Changes in v2:
> - Use __free(put_device) for the file-device reference.
> - Take the WQ reference before fdev can be released so the release
>   callback's idxd_wq_put() has a matching idxd_wq_get().
> 
>  drivers/dma/idxd/cdev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 0366c7cf3502..82b07cf942ef 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -288,6 +288,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>  	fdev->parent = cdev_dev(idxd_cdev);
>  	fdev->bus = &dsa_bus_type;
>  	fdev->type = &idxd_cdev_file_type;
> +	idxd_wq_get(wq);
>  
>  	rc = dev_set_name(fdev, "file%d", ctx->id);
>  	if (rc < 0) {
> @@ -301,13 +302,14 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>  		goto failed_dev_add;
>  	}
>  
> -	idxd_wq_get(wq);
>  	mutex_unlock(&wq->wq_lock);
>  	return 0;
>  
>  failed_dev_add:
>  failed_dev_name:
> +	mutex_unlock(&wq->wq_lock);
>  	put_device(fdev);
> +	return rc;
>  failed_ida:
>  failed_set_pasid:
>  	if (device_user_pasid_enabled(idxd))


