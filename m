Return-Path: <dmaengine+bounces-3690-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB58D9BFF61
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2024 08:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD452834C7
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2024 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB774191F9C;
	Thu,  7 Nov 2024 07:50:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F47F9
	for <dmaengine@vger.kernel.org>; Thu,  7 Nov 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730965836; cv=none; b=QEI9tVEBffEa/tRtpRff6BnvHW9d8N/ERMvSqC//PomnYOWTMAN5RJctvC+sikN3Sdwjco1o2S5CX80pqx3az+A2C9k4crr5y4xSEhWvgUcU9VqXO7iEuVVx/b/8K8z31vB0YCtwXQybEyJhERtEcfUJCKFYoZRop6YSCBl90E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730965836; c=relaxed/simple;
	bh=MpoqoRkZO1RL5VTicjx6layCqhOB/WfHgPzE52fUzx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUTkQQYi8Ay19LEuI6z2cQDJzumutSTAXnXzXN8EnoC8eDleB6AOv2S4F4mPwYcBmshBse7OQYogPx0Rm8r0PX5EnkvxHcIix8ax1L/ObnR3UKh3cQPc6uIvawwp0YNnfcGZn22EnRg8EVXXd1IEsSJN8q9MQx41B7bxh3kdEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XkZ4340bCz4f3jXt
	for <dmaengine@vger.kernel.org>; Thu,  7 Nov 2024 15:50:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9124A1A08DC
	for <dmaengine@vger.kernel.org>; Thu,  7 Nov 2024 15:50:29 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgAX9sJEcSxnr0I7BA--.10235S2;
	Thu, 07 Nov 2024 15:50:29 +0800 (CST)
Message-ID: <9fec1ee8-7c6a-46f1-80cb-9b7cd1dd2d12@huaweicloud.com>
Date: Thu, 7 Nov 2024 15:50:27 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: at_xdmac: avoid null_prt_deref in
 at_xdmac_prep_dma_memset
To: Chen Ridong <chenridong@huaweicloud.com>,
 ludovic.desroches@microchip.com, vkoul@kernel.org, mripard@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 wangweiyang2@huawei.com
References: <20241029082845.1185380-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20241029082845.1185380-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAX9sJEcSxnr0I7BA--.10235S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1rtF1fZFyfAFWrJFW5ZFb_yoWDuwb_Ga
	4xur1xZr1DGF17Can2krn5ZrWakFy7Xr1S9w1vq34fCFZ8ZF95Zr4xtr95G345u3yxGFW5
	Cr9YvFZ5Wr1UZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1D
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/10/29 16:28, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The at_xdmac_memset_create_desc may return NULL, which will lead to a
> null pointer dereference. For example, the len input is error, or the
> atchan->free_descs_list is empty and memory is exhausted. Therefore, add
> check to avoid this.
> 
> Fixes: b206d9a23ac7 ("dmaengine: xdmac: Add memset support")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  drivers/dma/at_xdmac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 299396121e6d..e847ad66dc0b 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1363,6 +1363,8 @@ at_xdmac_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
>  		return NULL;
>  
>  	desc = at_xdmac_memset_create_desc(chan, atchan, dest, len, value);
> +	if (!desc)
> +		return NULL;
>  	list_add_tail(&desc->desc_node, &desc->descs_list);
>  
>  	desc->tx_dma_desc.cookie = -EBUSY;

Friendly ping.


