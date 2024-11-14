Return-Path: <dmaengine+bounces-3734-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3EF9C814F
	for <lists+dmaengine@lfdr.de>; Thu, 14 Nov 2024 04:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35879283B82
	for <lists+dmaengine@lfdr.de>; Thu, 14 Nov 2024 03:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B8E1E9078;
	Thu, 14 Nov 2024 03:05:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DF21E4110
	for <dmaengine@vger.kernel.org>; Thu, 14 Nov 2024 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553511; cv=none; b=FdjeBHYK5H1Mgza/lqyYhmlUUX4/J9IqAfNcV10P/QaNpPnB9kRdPZGbazbOg0WNI130vIixNB9ZIvEVOHuHohAkDCQzKEUveiyhAoSozH/6e9h+t0bmULDbuuEeo2kHsDhUwHZtOo06OVxy0PTKK2lbGbyDVPgRkTzg4W1H3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553511; c=relaxed/simple;
	bh=MpoqoRkZO1RL5VTicjx6layCqhOB/WfHgPzE52fUzx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOLgsVp7hZ0Brbs9ecg3OgeTHWrkkjlWX5P1luJN6cVCs0zTAbJX0DmtdIenEEPJ02/kjT24dJ0U4iisYQbEVCJyAo2kXlrTirUvjaneRFcGnvXl3xqbcJAq6prWc+/v9b9p2Ga1xe6mFhzkq3gVFnsO67cIMH6AtwbwQABUm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XplPc380kz4f3jkY
	for <dmaengine@vger.kernel.org>; Thu, 14 Nov 2024 11:04:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 95EC81A0197
	for <dmaengine@vger.kernel.org>; Thu, 14 Nov 2024 11:05:05 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgDHoYXhaDVnQrnoBg--.58951S2;
	Thu, 14 Nov 2024 11:05:05 +0800 (CST)
Message-ID: <a761125d-42cf-46d6-bc38-0422bcc6b890@huaweicloud.com>
Date: Thu, 14 Nov 2024 11:05:04 +0800
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
X-CM-TRANSID:gCh0CgDHoYXhaDVnQrnoBg--.58951S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1rtF1fZFyfAFWrJFW5ZFb_yoWDuwb_Ga
	4xur1xZr1DGF17Can2krn5ZrWakFy7Xr1S9w1vq34fCFZ8ZF95Zr4xtr95G345u3yxGFW5
	Cr9YvFZ5Wr1UZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUG0PhUUUUU=
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


