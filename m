Return-Path: <dmaengine+bounces-4857-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F7CA7F908
	for <lists+dmaengine@lfdr.de>; Tue,  8 Apr 2025 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2443A5AE4
	for <lists+dmaengine@lfdr.de>; Tue,  8 Apr 2025 09:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6304263F29;
	Tue,  8 Apr 2025 09:07:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB192641CD;
	Tue,  8 Apr 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103271; cv=none; b=CcmwixYeNESk867S+L+IMrzGxZnLh29/OkrSsOXilIxF+z9xFr6VIzR+bUNJ71me57DI8u2kDwDt7eoomKagZZ5DP4UREQ9nYk1Wl3JPQdrvEEHq1d3jnOF+sUUgyAv8jnpYrrplezfKpQ+sTTcneQbFXWbbBDuWA8eP6RjH3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103271; c=relaxed/simple;
	bh=R8+Mm7ZAxpaNDX5Aj66qssLQdzZDzVFFrFSOf5kv1c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TMnMeOH7/nfiCpxKZ+wFGuyOQj46u6shZ5PHHCX5H1lUQFBCvOVPrxhWFQeVEvi0Cc+ed9/OLEPmakkt7AehgfmuJAX7AQi8xC0marSxlJaS6hlVaHqVQJUTdVINmuCX4KM6YliZQKQ1yHIjFBq2aZNrO3BRxS2ojXCa++eR1S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZX0Tj38Sjz1f1by;
	Tue,  8 Apr 2025 17:02:49 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id E39321A016C;
	Tue,  8 Apr 2025 17:07:45 +0800 (CST)
Received: from [10.67.121.115] (10.67.121.115) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 8 Apr 2025 17:07:45 +0800
Message-ID: <ff50caa3-c753-feb0-7518-9d0e8a79a8f6@hisilicon.com>
Date: Tue, 8 Apr 2025 17:07:14 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] MAINTAINERS: Maintainer change for hisi_dma
Content-Language: en-US
To: Jie Hai <haijie1@huawei.com>, <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
References: <20250402085423.347526-1-haijie1@huawei.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
In-Reply-To: <20250402085423.347526-1-haijie1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200012.china.huawei.com (7.221.188.145)

On 2025/4/2 16:54, Jie Hai wrote:
> I am moving on to other things and longfang is going to
> take over the role of hisi_dma maintainer. Update the
> MAINTAINERS accordingly.

Thanks Jie Hai for maintaining hisi_dma driver! Best wishes to you.
Welcome Longfang to maintain this driver together!

Acked-by: Zhou Wang <wangzhou1@hisilicon.com>

Thanks,
Zhou

> 
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0045ac4327b..a9866eefda15 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10651,7 +10651,7 @@ F:	net/dsa/tag_hellcreek.c
>  
>  HISILICON DMA DRIVER
>  M:	Zhou Wang <wangzhou1@hisilicon.com>
> -M:	Jie Hai <haijie1@huawei.com>
> +M:	Longfang Liu <liulongfang@huawei.com>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
>  F:	drivers/dma/hisi_dma.c

