Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C463B5C8C
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jun 2021 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhF1Kkl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Jun 2021 06:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhF1Kkk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Jun 2021 06:40:40 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5214BC061574;
        Mon, 28 Jun 2021 03:38:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t17so31806857lfq.0;
        Mon, 28 Jun 2021 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/I7dcKCKPigz1sUat62lgmckX5MS1JXYmlBQYUMPTmg=;
        b=UDf51rVZxQcOLan9bcV0kkGZoYwNHrRQPKdC2tR3m4cvWOqLo0ClHjB7tVsIAiA9TN
         yQ/ab5XyBFUoySdi6Ymo4mKcxwrKwanh6z19XiMMXZaJwm9gJVVnAdZocvw23VdSTI2C
         Aq8vh7xfPXbPd/vba3gv9Qk3haCrey6yHMkK7tBOS3dnKxB9rvk/TWHLrquaMxiQXeyQ
         V7l+9WlGZwzzA/5R0yutHpAzEG2FqLXljmO6ypfARAbkv0zyecGzkUAawYCggPE8D/+r
         VqN7+bjE7aTywekeuI6rhVhk/jNCtd5RPOAkJ6cF2Z4gf4nCzQ3zyU49kl4dU4hwumJA
         oADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/I7dcKCKPigz1sUat62lgmckX5MS1JXYmlBQYUMPTmg=;
        b=C3h+Lg2Rs/Z9gce+s6ZTyqxEzbJsKWpK+IxyGxiQiNpPXSyO+1+1LSAQm1zKxNZKP2
         RQlc3dwSYDKfHN5rKbuWuv2jeZjXnNR3UNnEN65MHxKj3TWTkaD6Gdj2HEY1NKHbKRi4
         4tRpvM3IX9PIv39t25bvpf/Pc2jDHAjqWvQSIkvU+VU/lpbdu2gpHWxtpYrcBXGTaExw
         UMRkc+hmdtkboyJFqcKh9t/BYp5Ev/5iVXiQ/D9dR/oiMPlP80sZUp2Ab74+/vmrNL29
         1ZqLjOZjb7EA0E1Tp9itSnSxkzRLjzSyfk0DK53McnRIMJ5TtjpHf03xNohoe7DG+pd1
         oPRw==
X-Gm-Message-State: AOAM532k5nnS3yJNOh0x0CYmxbb3sKCkA/a5+FzNXeIGB+zvJPJewBcV
        p2HE0X0dmev+kPKmiBtgJvKpvARKeNs=
X-Google-Smtp-Source: ABdhPJzEqdSrhyJT1TFKvr8Uqot44JVj1GPidYVe6MSWHCPeKEuXDeysBss6RpR8Wpqq+o+FcvjeNQ==
X-Received: by 2002:a05:6512:3322:: with SMTP id l2mr18375800lfe.460.1624876693163;
        Mon, 28 Jun 2021 03:38:13 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id p17sm1281168lfo.118.2021.06.28.03.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 03:38:12 -0700 (PDT)
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210624182449.31164-1-p.yadav@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v3] dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
Message-ID: <6b8662e2-2dd5-b1c4-6bc1-24a69776ffac@gmail.com>
Date:   Mon, 28 Jun 2021 13:38:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624182449.31164-1-p.yadav@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 24/06/2021 21:24, Pratyush Yadav wrote:
> The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory.

If we want to be correct:
The CSI2RX subsystem in j721e is serviced by UDMA via PSI-L to transfer
frames to memory.

If you update the commit message you can also add my:

Acked-by: Peter Ujfalusi <peter.ujflausi@gmail.com>

> It can
> have up to 32 threads per instance. J721E has two instances of the
> subsystem, so there are 64 threads total. Add them to the endpoint map.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> This patch has been split off from [0] to facilitate easier merging. I
> have still kept it as v3 to maintain continuity with the previous patches.
> 
> [0] https://patchwork.linuxtv.org/project/linux-media/list/?series=5526&state=%2A&archive=both
> 
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
