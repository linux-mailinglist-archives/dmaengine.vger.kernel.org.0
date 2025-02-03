Return-Path: <dmaengine+bounces-4253-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D4A25AEC
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 14:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02894164E12
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A13205518;
	Mon,  3 Feb 2025 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PLWZBeo/"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5634720459A;
	Mon,  3 Feb 2025 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589553; cv=none; b=hC8VGVaBoJMpXLarT1jTArdPbSYiBCO3+Pa7e47K5jd+W/Qk0ZLnH3FPDZmm1RJ2wFd/ml2HwvLhVhraxPzVMD4/2hQDP6Z785wq4BT0FCZ527xyFFAQzTGHJguYFDQAu/O5NCS7q/cEdzoG9C7Fw6PbNEiOp+d4OHFX2pBq9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589553; c=relaxed/simple;
	bh=WioUpmeGt74M0RgAR1HiPjFTCZwnnxWzfiDRMoa/NcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PrWeMqRH8/4HHJ3RWLNset9M0vwCSDzGoB2yPyuUwMSKXRETUMWA7G677yF2ozIialyliPvZclwmpCH1J0GL1y8iRFR6bJkH6GU/Co8acspd4S1yZmv+98YLw4CQ1KaVKbvwJonzwYe5utgLqANUkZmJrPS3V4UgKbB/0khJb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PLWZBeo/; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 513DWRZe2199874
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 07:32:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738589547;
	bh=TgqyDV4/angzU7fIo2VicwI+66b6dtCuXvqEY6QThao=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PLWZBeo/8fRswfAexFDU5IDZu1mxfjzs92pZZhBvRI0hWhCSXup4jVWzDUha/+Riq
	 EcZJp7MZfPWgl+xsHR0sWFljcCq52Jw26T/CVmbVKS6+7cTDTGtXeU20UJV496w6aW
	 cg1O6G7g9x4KGs88+p1MpDpRRzM1d1MM3axvn3zw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 513DWRk3011584
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Feb 2025 07:32:27 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Feb 2025 07:32:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Feb 2025 07:32:26 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 513DWODT129645;
	Mon, 3 Feb 2025 07:32:24 -0600
Message-ID: <f9396cec-bc07-4304-a57c-76311d95f62c@ti.com>
Date: Mon, 3 Feb 2025 19:02:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Use cap_mask directly from
 dma_device structure instead of a local copy
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>,
        <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <vaishnav.a@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250203074915.3634508-1-y-abhilashchandra@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250203074915.3634508-1-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 2/3/2025 1:19 PM, Yemike Abhilash Chandra wrote:
> Currently, a local dma_cap_mask_t variable is used to store device
> cap_mask within udma_of_xlate(). However, the DMA_PRIVATE flag in
> the device cap_mask can get cleared when the last channel is released.
> This can happen right after storing the cap_mask locally in
> udma_of_xlate(), and subsequent dma_request_channel() can fail due to
> mismatch in the cap_mask. Fix this by removing the local dma_cap_mask_t
> variable and directly using the one from the dma_device structure.
>
> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
> Cc: stable@vger.kernel.org

I don't see  patch is sent to stable in cc , please check if you 
suppressed cc list.

For rest

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> ---
> RFC: https://lore.kernel.org/all/20250117121728.203452-1-y-abhilashchandra@ti.com/
>
>   drivers/dma/ti/k3-udma.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 7ed1956b4642..c775a2284e86 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4246,7 +4246,6 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
>   				      struct of_dma *ofdma)
>   {
>   	struct udma_dev *ud = ofdma->of_dma_data;
> -	dma_cap_mask_t mask = ud->ddev.cap_mask;
>   	struct udma_filter_param filter_param;
>   	struct dma_chan *chan;
>   
> @@ -4278,7 +4277,7 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
>   		}
>   	}
>   
> -	chan = __dma_request_channel(&mask, udma_dma_filter_fn, &filter_param,
> +	chan = __dma_request_channel(&ud->ddev.cap_mask, udma_dma_filter_fn, &filter_param,
>   				     ofdma->of_node);
>   	if (!chan) {
>   		dev_err(ud->dev, "get channel fail in %s.\n", __func__);

