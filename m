Return-Path: <dmaengine+bounces-4861-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D677A81CF2
	for <lists+dmaengine@lfdr.de>; Wed,  9 Apr 2025 08:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6170188E643
	for <lists+dmaengine@lfdr.de>; Wed,  9 Apr 2025 06:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78221DC991;
	Wed,  9 Apr 2025 06:18:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9E15A85E;
	Wed,  9 Apr 2025 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179535; cv=none; b=bJ6yGJHZDBN9O04eJf4RuJ0YF3/qzUhqcz41C/m4lKxvRXolIz3OTwUKbJVN5BuLdfA3a2bCm0xeYB338Wn0nDjMi4Q0oR0haJP/or/SRIGjhiZb20wLVUGkysFhpfo1/FYDIKHPdfX01uBexDimB00kLYCNFtZDc+RZctnjpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179535; c=relaxed/simple;
	bh=G1LHBNBqeyiZOMPl2PflZcM6o/1KMAKeUJr20z5gmA4=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EA799e893SXeLZK6LaWsmo/WRIK8jaVWyBGzNO+5TBMMsXRQv4mVpAVxTxNbMtA0NS2jtDwmIb343S+gZDmZt1J9mmPpeONw2uZLK441yD2wqCxxRVH42YnLsu3OEKpB+4l1/I1U0VhVrImL5AKWOudiXiFkQ1xOQnEubgiyi6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZXXjj27pnz69Xk;
	Wed,  9 Apr 2025 14:15:05 +0800 (CST)
Received: from kwepemg500006.china.huawei.com (unknown [7.202.181.43])
	by mail.maildlp.com (Postfix) with ESMTPS id 5806E180467;
	Wed,  9 Apr 2025 14:18:50 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 kwepemg500006.china.huawei.com (7.202.181.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Apr 2025 14:18:49 +0800
Subject: Re: [PATCH] MAINTAINERS: Maintainer change for hisi_dma
To: Zhou Wang <wangzhou1@hisilicon.com>, Jie Hai <haijie1@huawei.com>,
	<vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250402085423.347526-1-haijie1@huawei.com>
 <ff50caa3-c753-feb0-7518-9d0e8a79a8f6@hisilicon.com>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <0ea7b0ba-8719-7bd1-c572-0c94d5614b83@huawei.com>
Date: Wed, 9 Apr 2025 14:18:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ff50caa3-c753-feb0-7518-9d0e8a79a8f6@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500006.china.huawei.com (7.202.181.43)

On 2025/4/8 17:07, Zhou Wang wrote:
> On 2025/4/2 16:54, Jie Hai wrote:
>> I am moving on to other things and longfang is going to
>> take over the role of hisi_dma maintainer. Update the
>> MAINTAINERS accordingly.
> 
> Thanks Jie Hai for maintaining hisi_dma driver! Best wishes to you.
> Welcome Longfang to maintain this driver together!
>

Thanks to Jie Hai for maintaining the hisi_dma driver,
and I will continue to maintain it going forward.

Thanks.
Longfang.

> Acked-by: Zhou Wang <wangzhou1@hisilicon.com>
> 
> Thanks,
> Zhou
> 
>>
>> Signed-off-by: Jie Hai <haijie1@huawei.com>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e0045ac4327b..a9866eefda15 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10651,7 +10651,7 @@ F:	net/dsa/tag_hellcreek.c
>>  
>>  HISILICON DMA DRIVER
>>  M:	Zhou Wang <wangzhou1@hisilicon.com>
>> -M:	Jie Hai <haijie1@huawei.com>
>> +M:	Longfang Liu <liulongfang@huawei.com>
>>  L:	dmaengine@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/dma/hisi_dma.c
> .
> 

