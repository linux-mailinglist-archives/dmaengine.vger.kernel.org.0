Return-Path: <dmaengine+bounces-2526-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571499145E8
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 11:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C97C1F23A12
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 09:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22C412EBCC;
	Mon, 24 Jun 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bw8H2JBc"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B961FE1;
	Mon, 24 Jun 2024 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220265; cv=none; b=D44DWh7XLmPk2IX1b+6p0Xh4ceZTwqxDdRWQNd0YkcMsKlO9omdCiTNFed6wvtAXZo7n5qKd8WNWLgNvg1i3kJ2qxEvcHhJZAy/qkgJExGthZxdLgW0QONC8BxlT3wqGuqPaP0Pg5U71KaC/IkiLEuc0X6su8B5i+zWGVn/40dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220265; c=relaxed/simple;
	bh=Cex5CEgDQbprkB96/Yakkk017OteSt4gx78pmqiLt3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D9cXnMOo1JTlsMI2bsM4glN32oZ0cHsCbQVy87YlW8PdRSUdqrMohcFuyaPgcKyIkykidWOOGsEQadY0ub60qaLf9dO9UNZ/YF3nJJS0KiIqa/XTcJnjzS28qSJH59jilVwsRGsj1HY7V3xRzdIHkWrWCkX/583G8BZH4moadTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bw8H2JBc; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45O9AnG6116048;
	Mon, 24 Jun 2024 04:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719220249;
	bh=gla0+mevsPokW90SHbIMNnHiVEsZOCf+jqU1zlqco0k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bw8H2JBcc9Pi0mrzwb1ZxHYZNFWAL8V7zqawQG7fSyVqrpQKGfphGPdVRX4QWD6ED
	 Ymk6hhSXhEVmRx1IW4X2FTCZ3ZTJ2xL8ODh19TJ3F4fTGGgRl1iD0FWf7u3kxl9Cls
	 QOoIkDC06sA+27+Xyd5iCiNR02GG7ds7uU9MOD/8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45O9AnjM013971
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Jun 2024 04:10:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jun 2024 04:10:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jun 2024 04:10:49 -0500
Received: from [172.24.227.55] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45O9AkBD088264;
	Mon, 24 Jun 2024 04:10:47 -0500
Message-ID: <676c2f57-2ae7-46b6-96a4-f84f8a15d76b@ti.com>
Date: Mon, 24 Jun 2024 14:40:46 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma: Fix BCHAN count with UHC and
 HC channels
To: Jai Luthra <j-luthra@ti.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Devarsh Thakkar <devarsht@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20240607-bcdma_chan_cnt-v2-1-bf1a55529d91@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20240607-bcdma_chan_cnt-v2-1-bf1a55529d91@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Jai,

On 07/06/24 23:41, Jai Luthra wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Unlike other channel counts in CAPx registers, BCDMA BCHAN CNT doesn't
> include UHC and HC BC channels. So include them explicitly to arrive at
> total BC channel in the instance.
> 
> Fixes: 8844898028d4 ("dmaengine: ti: k3-udma: Add support for BCDMA channel TPL handling")
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>

Tested audio on J722S platform on top of this patch.
McASP in J722S-EVM uses BCDMA.

Tested-by: Jayesh Choudhary <j-choudhary@ti.com>

> ---
> Changes in v2:
> - Add all BCHANs in a single operation
> - Update the Fixes tag to the commit adding TPL support
> - Link to v1: https://lore.kernel.org/r/20240604-bcdma_chan_cnt-v1-1-1e8932f68dca@ti.com
> ---
>   drivers/dma/ti/k3-udma.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 6400d06588a2..df507d96660b 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4472,7 +4472,9 @@ static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
>   		ud->rchan_cnt = UDMA_CAP2_RCHAN_CNT(cap2);
>   		break;
>   	case DMA_TYPE_BCDMA:
> -		ud->bchan_cnt = BCDMA_CAP2_BCHAN_CNT(cap2);
> +		ud->bchan_cnt = BCDMA_CAP2_BCHAN_CNT(cap2) +
> +				BCDMA_CAP3_HBCHAN_CNT(cap3) +
> +				BCDMA_CAP3_UBCHAN_CNT(cap3);
>   		ud->tchan_cnt = BCDMA_CAP2_TCHAN_CNT(cap2);
>   		ud->rchan_cnt = BCDMA_CAP2_RCHAN_CNT(cap2);
>   		ud->rflow_cnt = ud->rchan_cnt;
> 
> ---
> base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
> change-id: 20240604-bcdma_chan_cnt-bbc6c0c95259
> 
> Best regards,

Thanks,
Jayesh

