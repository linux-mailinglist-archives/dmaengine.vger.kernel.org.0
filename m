Return-Path: <dmaengine+bounces-9819-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGDlNl3IzWlZhQYAu9opvQ
	(envelope-from <dmaengine+bounces-9819-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 03:37:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAA03824C1
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 03:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B20CB300E19D
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 01:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255E3264A86;
	Thu,  2 Apr 2026 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dwuTKaZe"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772619EED3;
	Thu,  2 Apr 2026 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093846; cv=none; b=FRDYvXDrnyUmr36u8hjbcs6Jq2UfgtGqYfZl9ZmyPV0NH4d0cGD9tFfe05XiKuDiQpl4LD9HEgAl2YXur+0RACSMRTtHch9vGXgCiQIqb3XbgEn73+SRMGXTyimM6GlNBLwi5RhuhzCnzQnRDcGFecO28lqHfokayxRSKUsV4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093846; c=relaxed/simple;
	bh=PlOkE3o5/qxUNZMl1qIkfynCj5bMQURnRhfUn4OKEMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSKYrmxI84zx3mcz9zeCHKFG1KD2g9teK3AnilGiIC3iiC9V+riWfAG6UB438S/Gxp4Gxg3SuDYlV+Wf1v+ygoxGhTk4sHh0UwPWZHN9eWCban4fuQuQM+BEbMvF+BSHyn01iR3cT9QFDrAt4jFqm3nXFCTL9fRqMT5fbbs6QYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dwuTKaZe; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775093840; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YS2sVCPtrKDNbFISvfJJiBkryUwNfuJSOehrNPOJ71s=;
	b=dwuTKaZe3xQ3U9e39juBUr6eVRL9goAPgAnbU3EpPoFBPaGbtkqMw21BAt04JerKNctvhZsv5aGAmLQQu/xGMlDooWgXU0Oilfa9kmS8uxVyn8lN4ZFLqmuZq/S8hcIBvpdkSJeFB6nTgyewhHtgNU8SyH947wos/YkOsPC5BNs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X0FIfyp_1775093839;
Received: from 30.246.177.235(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X0FIfyp_1775093839 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Apr 2026 09:37:20 +0800
Message-ID: <f9a8306d-cf81-4573-a57c-232344b0ea40@linux.alibaba.com>
Date: Thu, 2 Apr 2026 09:37:32 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: fix double free in idxd_setup_engines()
 error path
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260401034029.1457489-1-lgs201920130244@gmail.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260401034029.1457489-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9819-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,kernel.org,nvidia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xueshuai@linux.alibaba.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: CBAA03824C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/26 11:40 AM, Guangshuo Li wrote:
> When an error happens after device_initialize(), idxd_setup_engines()
> calls put_device(conf_dev).
> 
> The device release callback idxd_conf_engine_release() frees engine,
> but the current error paths then call kfree(engine) again, causing a
> double free.
> 
> Keep the cleanup in idxd_conf_engine_release() after put_device() and
> avoid freeing engine again in idxd_setup_engines().
> 
> Fixes: 817bced19d1d ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_engines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/dma/idxd/init.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index d9a9d56dd277..4eff74182225 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -310,7 +310,7 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>   		rc = dev_set_name(conf_dev, "engine%d.%d", idxd->id, engine->id);
>   		if (rc < 0) {
>   			put_device(conf_dev);
> -			kfree(engine);
> +
>   			goto err;
>   		}
>   
> @@ -324,7 +324,7 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>   		engine = idxd->engines[i];
>   		conf_dev = engine_confdev(engine);
>   		put_device(conf_dev);
> -		kfree(engine);
> +
>   	}
>   	kfree(idxd->engines);
>   
> @@ -374,7 +374,6 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>   		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
>   		if (rc < 0) {
>   			put_device(conf_dev);
> -
>   			goto err;
>   		}
>   
> @@ -399,7 +398,6 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>   	while (--i >= 0) {
>   		group = idxd->groups[i];
>   		put_device(group_confdev(group));
> -
>   	}
>   	kfree(idxd->groups);
>   


Nit: please remove the blank lines left behind by both deletions.

With those addressed:Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

