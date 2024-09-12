Return-Path: <dmaengine+bounces-3153-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D12269761CC
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2024 08:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E1FB20D8B
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2024 06:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4318A6BB;
	Thu, 12 Sep 2024 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="YCxhWq+I"
X-Original-To: dmaengine@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2407188929
	for <dmaengine@vger.kernel.org>; Thu, 12 Sep 2024 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123595; cv=none; b=oGxYBX6dTaoUkgPi0C+L5U35umCieMAzi8csUaS0ly4ZjhQuFWps0UCFAJHS69g4K8/FgbneDjvUVjlZDdmN6sIE1huwfMBoC0rn5e7pNrkQMSMIS2/BkBiqgau0/eO+7z3iDolURUhWxTWRptLD2buWx1z0o29cbx4NFaSY32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123595; c=relaxed/simple;
	bh=Z/m1fPRB4s0veA37AXYi/a1clTstrhIQGO/B9ZW/F28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7l9IFUr1Sq59XEnyS8Op6++WyhTY4R1iKDfSWVEFAFRrFNETK1jlLR+HcVBLSnXqRRVDDFdu0hFuWo7YUiHf8udr63JMFppzbd9E9t/r6oXAZLLQIUoIgO+8lfuDcoUCKMP0Mow1WEBO4fyQlGOBPUKVxkKwuml04CVJKbytBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=YCxhWq+I; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id oKADs6fP1umtXodb6sQP0M; Thu, 12 Sep 2024 06:46:32 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id odb5s6pVlAfxyodb5scaAu; Thu, 12 Sep 2024 06:46:31 +0000
X-Authority-Analysis: v=2.4 cv=fvfaZk4f c=1 sm=1 tr=0 ts=66e28e48
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=rpUMG24A1zG+UrzXDtAMsg==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=1TAzRpJlmNrmrX52BtgA:9 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SBZtRbN1+Ney3Bl9aK163TZL9TFwtrPsR0MLojQA1Lo=; b=YCxhWq+I/2zVyuD8LSI3U/xsXk
	D05AjbPXHUKeDug4iHa+jTa6Q+7d/jRFfeAIqGKUHCMhghbQdOZAY/8RHo7xN7Omp+v74z5YdUqLk
	jOSSpqmbkCre2kzf0dDZpEL+MOgX+ztZxi4ZSvJKX4LWoayPgxU/xs0PBYpiKcSE2zmYwRr7gdwQA
	W53GOuJaVEGWJ97Vuh7jgOdEY5w1ZW5eY1uFxl9pJA36HxAyQaLGE4OvZrsLX/qwcdpR66oeHPoo6
	Hpjw9NZxwW+f2/h8Sr/u6GMnx0MBv1lnA3NThxlDksK145at6luVOc9BjEdqZTasCrFimazeAV0kz
	v6pNQ2oA==;
Received: from [185.44.53.103] (port=42394 helo=[192.168.1.187])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sodb4-000W5K-17;
	Thu, 12 Sep 2024 01:46:31 -0500
Message-ID: <c9535f84-e354-4c93-ad6f-6ca15b3ea5b7@embeddedor.com>
Date: Thu, 12 Sep 2024 08:46:23 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix typo in drivers/dma/qcom/bam_dma.c
To: kendra.j.moore3443@gmail.com, gustavoars@kernel.org
Cc: dmaengine@vger.kernel.org
References: <20240911195618.94973-1-kendra.j.moore3443@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240911195618.94973-1-kendra.j.moore3443@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.44.53.103
X-Source-L: No
X-Exim-ID: 1sodb4-000W5K-17
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.187]) [185.44.53.103]:42394
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKz3uuq2MejFEpHLqnMmsvpxGJVKLaRi9s1BDRRaPZ+u6ZAJyVfP3FrjHp3I2OXYk+V8K1QMpgYHtcO2stSxComxjVR2//1jjWO+sz0XLwr/onZvrT63
 VV/sNT+wJAJ1/irheqbRi1Ey+m2O0Ikvmcc9aCcz/K0FWIQGIk0PSI4adaEM4H7UKE0rU2gny75KaVWg1m+rMcbuRAORa32inwA=



On 11/09/24 13:56, kendra.j.moore3443@gmail.com wrote:
> From: Kendra Moore <kendra.j.moore3443@gmail.com>
> 
> This patch corrects two spelling errors in this file.
> 
> Signed-off-by: Kendra Moore <kendra.j.moore3443@gmail.com>

Not sure why this was sent to me and not to the maintainers of this
code, but it looks correct, so here you go:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

To get the list of people and mailing lists your patches should be
sent to, run the following command on your patches:

scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback <path-to-your-patch>

In this case, I ran:

$ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback -f drivers/dma/qcom/bam_dma.c
Vinod Koul <vkoul@kernel.org> (maintainer:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM)
linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST)
dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

These are all the people and lists you have to send this changes to.

You can also create an alias to avoid typing the script name and
options every time.

I hope this helps.
--
Gustavo

> ---
>   drivers/dma/qcom/bam_dma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 5e7d332731e0..2d7550b8e03e 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -440,7 +440,7 @@ static void bam_reset(struct bam_device *bdev)
>   	val |= BAM_EN;
>   	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
>   
> -	/* set descriptor threshhold, start with 4 bytes */
> +	/* set descriptor threshold, start with 4 bytes */
>   	writel_relaxed(DEFAULT_CNT_THRSHLD,
>   			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
>   
> @@ -667,7 +667,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>   	for_each_sg(sgl, sg, sg_len, i)
>   		num_alloc += DIV_ROUND_UP(sg_dma_len(sg), BAM_FIFO_SIZE);
>   
> -	/* allocate enough room to accomodate the number of entries */
> +	/* allocate enough room to accommodate the number of entries */
>   	async_desc = kzalloc(struct_size(async_desc, desc, num_alloc),
>   			     GFP_NOWAIT);
>   

