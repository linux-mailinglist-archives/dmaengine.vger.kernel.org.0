Return-Path: <dmaengine+bounces-9818-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NcOJnzHzWkLhQYAu9opvQ
	(envelope-from <dmaengine+bounces-9818-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 03:33:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7DA38247B
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 03:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 963F53037D73
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 01:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B9E1E32D6;
	Thu,  2 Apr 2026 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zar8Yl8g"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72AF1E885A;
	Thu,  2 Apr 2026 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093533; cv=none; b=KqmPs3ycSieCYje2PhBZWkcs7ZGbZckf/GvQW4ithqU3xaximvSu0kryl4pthsmwW7QTCvAfjM6u7uYJpBNq5cH5n+zSKZ0mWWXNlQCGeFhAxswsaYNfVIXNidCMISNcHeYBFVetbfX/ovc67hK3YLmRmOxczSolgaBtAfMAfJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093533; c=relaxed/simple;
	bh=q31r6y+c2kh5xyneHd/KgA8RaCHvnZvFHfQdBURLmvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oe7cegA1acN23nNJzHMPR1Oe9syw3tW0K2duz5QSrQWdwLx9wH3BDbC6wY/dlCjSVnMXeVCWF5QbXUo0qc0qF/Mc8+8KEc7WyNYcnYBhT/N4Pp6h/8c9B90go/AIi7ztiFLYFv2K6JSBUf6nJsjGRlfO995WAz6PPopdkCFteqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zar8Yl8g; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775093524; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=68sUhpCzBeo8yOYWdJvOus9Env4cx8x9VdhpXC2y68c=;
	b=Zar8Yl8g9uKo2blrqEYhvXn08M4MwWtR7wJ+y2Zd4++omkDBkdzy0VTxnL2eG0vOGo8cGfweBB1UgrmHLNS8jv9kGmL31M2VacH14O5GjCYI7yDVSOy1Am375wgaXvNlztyr/vAiUiULakCzwJRbrmDksIAhwZIkw7SmWysRIwA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X0FQ2fv_1775093522;
Received: from 30.246.177.235(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X0FQ2fv_1775093522 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Apr 2026 09:32:03 +0800
Message-ID: <b4b29433-f5fc-42a2-85ed-c25c1268c68c@linux.alibaba.com>
Date: Thu, 2 Apr 2026 09:32:14 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: fix double free in idxd_setup_groups()
 error path
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260401033622.1446904-1-lgs201920130244@gmail.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260401033622.1446904-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9818-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,kernel.org,nvidia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xueshuai@linux.alibaba.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB7DA38247B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/26 11:36 AM, Guangshuo Li wrote:
> When an error happens after device_initialize(), idxd_setup_groups()
> calls put_device(conf_dev).
> 
> The device release callback idxd_conf_group_release() frees group, but
> the current error paths then call kfree(group) again, causing a double
> free.
> 
> Keep the cleanup in idxd_conf_group_release() after put_device() and
> avoid freeing group again in idxd_setup_groups().

Yes, I think it is a double free.
Sorry, I missed the idxd_conf_group_release path.

> 
> Fixes: aa6f4f945b10 ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_groups")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/dma/idxd/init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index b782eb3c191d..d9a9d56dd277 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -374,7 +374,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>   		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
>   		if (rc < 0) {
>   			put_device(conf_dev);
> -			kfree(group);
> +
>   			goto err;
>   		}
>   
> @@ -399,7 +399,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>   	while (--i >= 0) {
>   		group = idxd->groups[i];
>   		put_device(group_confdev(group));
> -		kfree(group);
> +

Nit: please remove the blank lines left behind by both deletions.

With those addressed:

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai



