Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5391D3F2BF5
	for <lists+dmaengine@lfdr.de>; Fri, 20 Aug 2021 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbhHTMXA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Aug 2021 08:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbhHTMW6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Aug 2021 08:22:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAB9C061575;
        Fri, 20 Aug 2021 05:22:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y6so17040925lje.2;
        Fri, 20 Aug 2021 05:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L1UVWaFQOUZDHm5at21ToeLBscrRk6wAog3AJNeFE1E=;
        b=EkXhnLTWLlB6XKwlspU1wedJ7d8RJ4tg/ut7z5etYmlrPQL2gyoN4sqKM2vhmQ9mNx
         C2jZxG8STNASmMWR1yRavWShl8mpdTapYIslgex4rckDTxdM8qSSALa4bLAOiR96kjDN
         WpfpoZ3COacbM94Y7fyzoxvBweMSmr8Qx4oBUrn0+fINIKVEEB1J6zV5hpk0ZP8wPWAO
         3V0vZCXdPiRdbhqVc8v9UGGMogGACQTmThoYzuRQobrhbwBtkeigTDQBMCxyac9xpCCP
         GkLnoHzASayjNoWaJCGczDiHJrcSdYDOpQQB8lhwXgvy4P+PBiYttbpDNrYLbvO/bM6J
         985A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L1UVWaFQOUZDHm5at21ToeLBscrRk6wAog3AJNeFE1E=;
        b=c67hHqeD5oYRrff7Y/F/q60DOmoADSeF6UvAfpbkDFtAx/ynDiLGAMB3mXcIdoNBFf
         ACHfy53QpbuGDYXkZXJxNsY8ulWYGURl0i6WyQo3xDGnpdRX/Z9OUflNE/0AnYaskLZV
         9TiVGc93EoPsFlDeuLakguP2WRmMAJr4YixD6c4oufiL8QEvUIv58ljozm9BcE0KxB9l
         Rr6WS246P/iaP67Sje/NqssCvktCU1077mqrjr3T24x4ykByoDWXbNVO8BZj/Z3efj1B
         ITG1B7+r05zgTeMzZ+vAqs7FyTre7dANSgCKzhOHfls/eCCKUIbNt3ro/d6+xSqtwLJQ
         ch5Q==
X-Gm-Message-State: AOAM532MqZoGJSBUn6swyRxs/q7veczJ1Y4MoycQjpgfXXLcQvfEhtya
        xP/OeJjri+42lvtETTUEp76H90Y7vGQ61A==
X-Google-Smtp-Source: ABdhPJx6Yy/uv6/JJRwCZUDYn/Wol3ZWjVSPbcTYNgVkLtaJ14kwAACNNvXJI7ay1SP7T+ZOo5IciQ==
X-Received: by 2002:a2e:9e05:: with SMTP id e5mr10488211ljk.166.1629462138388;
        Fri, 20 Aug 2021 05:22:18 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id z11sm618059lfb.52.2021.08.20.05.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:22:17 -0700 (PDT)
Subject: Re: [PATCH v4] dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
To:     Pratyush Yadav <p.yadav@ti.com>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210819110106.31409-1-p.yadav@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <55060c2e-ba6e-cb85-64f9-833789e2d5bd@gmail.com>
Date:   Fri, 20 Aug 2021 15:22:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819110106.31409-1-p.yadav@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pratyush,

On 19/08/2021 14:01, Pratyush Yadav wrote:
> The CSI2RX subsystem on J721E is serviced by UDMA via PSI-L to transfer
> frames to memory. It can have up to 32 threads per instance. J721E has
> two instances of the subsystem, so there are 64 threads total. Add them
> to the endpoint map.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Acked-by: Peter Ujfalusi <peter.ujflausi@gmail.com>
> 
> ---
> This patch has been split off from [0] to facilitate easier merging. I
> have still kept the version number to maintain continuity with the
> previous patches.
> 
> [0] https://patchwork.linuxtv.org/project/linux-media/list/?series=5526&state=%2A&archive=both
> 
> Changes in v4:
> - Update commit message with Peter's suggested changes.
> - Add Peter's Ack.

Looks good, thank you.

> Changes in v3:
> - Update commit message to mention that all 64 threads are being added.
> 
> Changes in v2:
> - Add all 64 threads, instead of having only the one thread being
>   currently used by the driver.
> 
>  drivers/dma/ti/k3-psil-j721e.c | 73 ++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
> index 7580870ed746..34e3fc565a37 100644
> --- a/drivers/dma/ti/k3-psil-j721e.c
> +++ b/drivers/dma/ti/k3-psil-j721e.c
> @@ -58,6 +58,14 @@
>  		},					\
>  	}
>  
> +#define PSIL_CSI2RX(x)					\
> +	{						\
> +		.thread_id = x,				\
> +		.ep_config = {				\
> +			.ep_type = PSIL_EP_NATIVE,	\
> +		},					\
> +	}
> +
>  /* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
>  static struct psil_ep j721e_src_ep_map[] = {
>  	/* SA2UL */
> @@ -138,6 +146,71 @@ static struct psil_ep j721e_src_ep_map[] = {
>  	PSIL_PDMA_XY_PKT(0x4707),
>  	PSIL_PDMA_XY_PKT(0x4708),
>  	PSIL_PDMA_XY_PKT(0x4709),
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
> +	PSIL_CSI2RX(0x494a),
> +	PSIL_CSI2RX(0x494b),
> +	PSIL_CSI2RX(0x494c),
> +	PSIL_CSI2RX(0x494d),
> +	PSIL_CSI2RX(0x494e),
> +	PSIL_CSI2RX(0x494f),
> +	PSIL_CSI2RX(0x4950),
> +	PSIL_CSI2RX(0x4951),
> +	PSIL_CSI2RX(0x4952),
> +	PSIL_CSI2RX(0x4953),
> +	PSIL_CSI2RX(0x4954),
> +	PSIL_CSI2RX(0x4955),
> +	PSIL_CSI2RX(0x4956),
> +	PSIL_CSI2RX(0x4957),
> +	PSIL_CSI2RX(0x4958),
> +	PSIL_CSI2RX(0x4959),
> +	PSIL_CSI2RX(0x495a),
> +	PSIL_CSI2RX(0x495b),
> +	PSIL_CSI2RX(0x495c),
> +	PSIL_CSI2RX(0x495d),
> +	PSIL_CSI2RX(0x495e),
> +	PSIL_CSI2RX(0x495f),
> +	PSIL_CSI2RX(0x4960),
> +	PSIL_CSI2RX(0x4961),
> +	PSIL_CSI2RX(0x4962),
> +	PSIL_CSI2RX(0x4963),
> +	PSIL_CSI2RX(0x4964),
> +	PSIL_CSI2RX(0x4965),
> +	PSIL_CSI2RX(0x4966),
> +	PSIL_CSI2RX(0x4967),
> +	PSIL_CSI2RX(0x4968),
> +	PSIL_CSI2RX(0x4969),
> +	PSIL_CSI2RX(0x496a),
> +	PSIL_CSI2RX(0x496b),
> +	PSIL_CSI2RX(0x496c),
> +	PSIL_CSI2RX(0x496d),
> +	PSIL_CSI2RX(0x496e),
> +	PSIL_CSI2RX(0x496f),
> +	PSIL_CSI2RX(0x4970),
> +	PSIL_CSI2RX(0x4971),
> +	PSIL_CSI2RX(0x4972),
> +	PSIL_CSI2RX(0x4973),
> +	PSIL_CSI2RX(0x4974),
> +	PSIL_CSI2RX(0x4975),
> +	PSIL_CSI2RX(0x4976),
> +	PSIL_CSI2RX(0x4977),
> +	PSIL_CSI2RX(0x4978),
> +	PSIL_CSI2RX(0x4979),
> +	PSIL_CSI2RX(0x497a),
> +	PSIL_CSI2RX(0x497b),
> +	PSIL_CSI2RX(0x497c),
> +	PSIL_CSI2RX(0x497d),
> +	PSIL_CSI2RX(0x497e),
> +	PSIL_CSI2RX(0x497f),
>  	/* CPSW9 */
>  	PSIL_ETHERNET(0x4a00),
>  	/* CPSW0 */
> 

-- 
Péter
