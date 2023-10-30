Return-Path: <dmaengine+bounces-15-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CD37DC117
	for <lists+dmaengine@lfdr.de>; Mon, 30 Oct 2023 21:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49901C20AAF
	for <lists+dmaengine@lfdr.de>; Mon, 30 Oct 2023 20:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0FD19451;
	Mon, 30 Oct 2023 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiCL4e4k"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2418E03
	for <dmaengine@vger.kernel.org>; Mon, 30 Oct 2023 20:22:02 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2F3DF;
	Mon, 30 Oct 2023 13:22:01 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c51388ccebso69035981fa.3;
        Mon, 30 Oct 2023 13:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698697319; x=1699302119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLj9UKvEV9DLwuiKuPqd8dcsKww5dDNGQTbjI4W/wOw=;
        b=NiCL4e4kstHBT/sWdXU5niisdrum8Q8vHHQEZb96rn8pSd7znHpwWJsIuZ77W2VueO
         UTrfFtVNPHd1hDlGs0frEYB/aHkDFjzJiJwV/myxwaop3uOs2O3KnK6e1sVIRz4z5iji
         AZDVRm5gDqD2u/J8VLqzPwhTL1joxIDrSiYaJWp7l8rOWVeKQokviWmxxi4SpXVddzV0
         8krv0y3DhYfvnGQYNR9Lzqu/bj5i2Em+p72XHAGbJk/Gd6fPoQOh8BoNsLfzDyxeeeHM
         COKmuybvJWeq86L9QtpMLpqzuTw+OLt9vHH06bYaKqh7ovBO9v7JXBre24LgHDdNqNaZ
         qLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698697319; x=1699302119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLj9UKvEV9DLwuiKuPqd8dcsKww5dDNGQTbjI4W/wOw=;
        b=pGylddlPTW4c89p59oiJhjMeb45M+A5tXkWk6kwi8Jllb53Q9LCRbSHihYcCzcC5r8
         6/lTsk3qCx+IyEf8lTSAczKxsSAzA73bUGkbDmsmcroP6YAGsHEyQFG1bp4tRsOQ/sGf
         vdhalbUHZw3+Bff9dkwh0gw2uoqJyBExtVvF08jOLULnmOogTyESdX8oXKMZd8o/E/2C
         Fg2Q536Lp9lpTYAe+dp1Ys3m3QcCwsnrKG1zCaqNv4tuktF+1TDCKceuAQAwOwDq32zb
         LOUs4XhWlnQP517wrNxMG3D+wsUuC9xhxDY64FYZA+sZuzeAMoS+qnKIXELyE5t4UGQb
         nr7Q==
X-Gm-Message-State: AOJu0Ywzf733stIQhD8pe2at47t5VM6gFQEo/iamf9P/51c/m4FQ8mj0
	hx/9vR81XMU9zgXUoa16pF8=
X-Google-Smtp-Source: AGHT+IH882khLcW6Fyj5NxmEvNE6YOe/wZGTRAvff+ov3Ye2qfvqXspg3KAUMxDnigCrUdm1T0Nvpw==
X-Received: by 2002:a2e:9f08:0:b0:2c5:2fcd:2598 with SMTP id u8-20020a2e9f08000000b002c52fcd2598mr8315054ljk.8.1698697319162;
        Mon, 30 Oct 2023 13:21:59 -0700 (PDT)
Received: from [10.0.0.42] (host-213-145-197-219.kaisa-laajakaista.fi. [213.145.197.219])
        by smtp.gmail.com with ESMTPSA id u7-20020a2e2e07000000b002b93d66b82asm1338236lju.112.2023.10.30.13.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 13:21:58 -0700 (PDT)
Message-ID: <be189852-1fda-4f03-9b49-0e747b720765@gmail.com>
Date: Mon, 30 Oct 2023 22:22:29 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-psil-am62: Fix SPI PDMA data
To: Ronald Wahl <rwahl@gmx.de>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Ronald Wahl <ronald.wahl@raritan.com>
References: <20231030190113.16782-1-rwahl@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20231030190113.16782-1-rwahl@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/30/23 21:01, Ronald Wahl wrote:
> AM62x has 3 SPI channels where each channel has 4 TX and 4 RX threads.
> This also fixes the thread numbers.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
>  drivers/dma/ti/k3-psil-am62.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-psil-am62.c b/drivers/dma/ti/k3-psil-am62.c
> index 2b6fd6e37c61..1272b1541f61 100644
> --- a/drivers/dma/ti/k3-psil-am62.c
> +++ b/drivers/dma/ti/k3-psil-am62.c
> @@ -74,7 +74,9 @@ static struct psil_ep am62_src_ep_map[] = {
>  	PSIL_SAUL(0x7505, 21, 35, 8, 36, 0),
>  	PSIL_SAUL(0x7506, 22, 43, 8, 43, 0),
>  	PSIL_SAUL(0x7507, 23, 43, 8, 44, 0),
> -	/* PDMA_MAIN0 - SPI0-3 */
> +	/* PDMA_MAIN0 - SPI0-2 */
> +	PSIL_PDMA_XY_PKT(0x4300),
> +	PSIL_PDMA_XY_PKT(0x4301),
>  	PSIL_PDMA_XY_PKT(0x4302),
>  	PSIL_PDMA_XY_PKT(0x4303),
>  	PSIL_PDMA_XY_PKT(0x4304),
> @@ -85,8 +87,6 @@ static struct psil_ep am62_src_ep_map[] = {
>  	PSIL_PDMA_XY_PKT(0x4309),
>  	PSIL_PDMA_XY_PKT(0x430a),
>  	PSIL_PDMA_XY_PKT(0x430b),
> -	PSIL_PDMA_XY_PKT(0x430c),
> -	PSIL_PDMA_XY_PKT(0x430d),
>  	/* PDMA_MAIN1 - UART0-6 */
>  	PSIL_PDMA_XY_PKT(0x4400),
>  	PSIL_PDMA_XY_PKT(0x4401),
> @@ -141,7 +141,9 @@ static struct psil_ep am62_dst_ep_map[] = {
>  	/* SAUL */
>  	PSIL_SAUL(0xf500, 27, 83, 8, 83, 1),
>  	PSIL_SAUL(0xf501, 28, 91, 8, 91, 1),
> -	/* PDMA_MAIN0 - SPI0-3 */
> +	/* PDMA_MAIN0 - SPI0-2 */
> +	PSIL_PDMA_XY_PKT(0xc300),
> +	PSIL_PDMA_XY_PKT(0xc301),
>  	PSIL_PDMA_XY_PKT(0xc302),
>  	PSIL_PDMA_XY_PKT(0xc303),
>  	PSIL_PDMA_XY_PKT(0xc304),
> @@ -152,8 +154,6 @@ static struct psil_ep am62_dst_ep_map[] = {
>  	PSIL_PDMA_XY_PKT(0xc309),
>  	PSIL_PDMA_XY_PKT(0xc30a),
>  	PSIL_PDMA_XY_PKT(0xc30b),
> -	PSIL_PDMA_XY_PKT(0xc30c),
> -	PSIL_PDMA_XY_PKT(0xc30d),
>  	/* PDMA_MAIN1 - UART0-6 */
>  	PSIL_PDMA_XY_PKT(0xc400),
>  	PSIL_PDMA_XY_PKT(0xc401),
> --
> 2.41.0
> 

-- 
Péter

