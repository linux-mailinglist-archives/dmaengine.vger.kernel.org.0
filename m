Return-Path: <dmaengine+bounces-839-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFEC83F3F0
	for <lists+dmaengine@lfdr.de>; Sun, 28 Jan 2024 06:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833F41C21A0D
	for <lists+dmaengine@lfdr.de>; Sun, 28 Jan 2024 05:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8863D9;
	Sun, 28 Jan 2024 05:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qaEkJ80M"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16186116;
	Sun, 28 Jan 2024 05:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706418043; cv=none; b=CcaSYzQDndwja6fUS+SE/MDBl3BvAOO6O01qDrSMnbZ7us+JfX7t345qQCaS/X8zmUUaOUwlXsQEdj4LtfjXjWRKjlH5wVUg3kwrXsbHb1gPOANouF1yn6Z9AdpIfSxnd1zFCFCtVmoDNd+AgZ6BwLUzSlRXp56Qh+9HxzO7o7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706418043; c=relaxed/simple;
	bh=ogcAvDrUKdfvDm23jvMymVOtUfnEhfEGQUl/5hs1Ywk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NJWoj6Wf/mfP412cBwei3EKo/kYWjdRnmfZzbHNg3EvAW6gspNaD5wbOWkE4q9laj4qPTjylNRL3zIvQqTsATrKPEZsq8fXClWbqa8p7sduLa5t0tX/kxJXwhjN1avLlCCf+ZQ5wEhpcAhXvBhHXzeCFkpUfQftVOgc417n0NBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qaEkJ80M; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40S50VR9000624;
	Sat, 27 Jan 2024 23:00:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706418031;
	bh=731f90R3A/dRcqxYvM7aL6//fI0w+YT6eNiSJ79wbIc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qaEkJ80M34VyUHFGQuU0YJvfohF+SHUdMpEQrFutBby43nSw1wb0I9Lbcd39p8sbK
	 PFbURZW3954GCI62jSdWPpxETnUMnY28leA9vDO/Dmxsj87KU/b1IToTB7ezraWduO
	 4G3LG1eF2sxECr7PR/kwP/Q65wFeGVwl5RCLUbfU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40S50VOl019212
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 27 Jan 2024 23:00:31 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 27
 Jan 2024 23:00:30 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 27 Jan 2024 23:00:30 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40S50R8U107717;
	Sat, 27 Jan 2024 23:00:28 -0600
Message-ID: <2286ff68-ae30-47d4-9362-16bc780bfe03@ti.com>
Date: Sun, 28 Jan 2024 10:30:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-psil-j721s2: Add entry for CSI2RX
Content-Language: en-US
To: Vaishnav Achath <vaishnav.a@ti.com>, <vkoul@kernel.org>,
        <peter.ujfalusi@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
References: <20240125111449.855876-1-vaishnav.a@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240125111449.855876-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Thanks Vaishnav

On 1/25/2024 4:44 PM, Vaishnav Achath wrote:
> The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory. It can
> have up to 32 threads per instance. J721S2 has two instances of the
> subsystem, so there are 64 threads total, Add them to the endpoint map.
>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> Tested on J721S2 EVM on 6.8.0-rc1-next-20240124 for CSI2RX capture with
> OV5640: https://gist.github.com/vaishnavachath/e6918ae4dadeb34c4cbad515bffcc558
>
>   drivers/dma/ti/k3-psil-j721s2.c | 73 +++++++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
>
> diff --git a/drivers/dma/ti/k3-psil-j721s2.c b/drivers/dma/ti/k3-psil-j721s2.c
> index 1d5430fc5724..ba08bdcdcd2b 100644
> --- a/drivers/dma/ti/k3-psil-j721s2.c
> +++ b/drivers/dma/ti/k3-psil-j721s2.c
> @@ -57,6 +57,14 @@
>   		},					\
>   	}
>   
> +#define PSIL_CSI2RX(x)					\
> +	{						\
> +		.thread_id = x,				\
> +		.ep_config = {				\
> +			.ep_type = PSIL_EP_NATIVE,	\
> +		},					\
> +	}
> +
>   /* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
>   static struct psil_ep j721s2_src_ep_map[] = {
>   	/* PDMA_MCASP - McASP0-4 */
> @@ -114,6 +122,71 @@ static struct psil_ep j721s2_src_ep_map[] = {
>   	PSIL_PDMA_XY_PKT(0x4707),
>   	PSIL_PDMA_XY_PKT(0x4708),
>   	PSIL_PDMA_XY_PKT(0x4709),
> +	/* CSI2RX */
> +	PSIL_CSI2RX(0x4940),
> +	PSIL_CSI2RX(0x4941),
> +	PSIL_CSI2RX(0x4942),
> +	PSIL_CSI2RX(0x4943),
> +	PSIL_CSI2RX(0x4944),
> +	PSIL_CSI2RX(0x4945),
> +	PSIL_CSI2RX(0x4946),
> +	PSIL_CSI2RX(0x4947),
> +	PSIL_CSI2RX(0x4948),
> +	PSIL_CSI2RX(0x4949),

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> +	PSIL_CSI2RX(0x494a),
> +	PSIL_CSI2RX(0x494b),
> [..]

