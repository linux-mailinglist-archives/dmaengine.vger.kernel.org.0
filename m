Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56DD3955A0
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhEaGxE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 02:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhEaGxE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 May 2021 02:53:04 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8617AC061574;
        Sun, 30 May 2021 23:51:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v5so13622954ljg.12;
        Sun, 30 May 2021 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pGbvjsQ37+jhwoTwXSRVtiv0VjHlEBl/iAsUrS7UtXI=;
        b=hXg5TLxR35V+P8DOvRVcEG4fZVvvgkMDgSuSOBMcnTn80GvFnFcgszCDhOxSY77mw/
         LUSPlemcexvlbiNL1snPeDN9CvhQXvvrHzVgt79+eJNG8hgV8M8qETubw6zHUNny+pAu
         xFHMP0u5g6C6hsq77JSYrj+99H6ZLvxNrY41Kw5Ak3ooMouzL4KFS1wprWhfU9wZ2FE2
         2z+deGsQm+N65n1+0wqxNEmg8sCDq8Fzo8w8oHVUP7jDRPkPGUpgSqmeBd5Z6uZrfvzF
         GyxJPIuBIccSc0P1C6S1Z5Q3qAZAIvXdGSVXloijnHOGft7zD5mwe69o70ifUlIg1eQt
         yW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pGbvjsQ37+jhwoTwXSRVtiv0VjHlEBl/iAsUrS7UtXI=;
        b=rht8F4vdlEqimqwJJA8dNOrHrl29st6fkrYPy7WZX/64H5RwzjeA8FU7wPzwy6rQnC
         kmtmQLzwGYjY7s0jgSHbhJg+vI9fFkgcSQh0qrJYRAHLA3L9+m/l9G5C5Nq0Qb3CCLRs
         uOJm3HiV5JTJBJGSP8GD0xhkAD5AQyl5kAKFUZBQpDNXqmX4Mxy4nZR/p9h/euLblC+y
         31U5lBVjgjJh5jd4vIPLY6tLIVLHx4flhsvzQbrCIqHwDrwtyE3WzjD66Vq4FZuKKE7Y
         RXE3Zgcsbx3AEJqy87POC6NkZ1ZNSSqCSIBTMeDIFZnB4LBvNKNnlju0Pn/FD/06N69x
         l2SA==
X-Gm-Message-State: AOAM532165oNvz1WGLt+T2DVAkocl6kV2CUoGSLYxsKEW94cg2XIkOoL
        vwbMvpdm0DcD+3KhHw58X9I=
X-Google-Smtp-Source: ABdhPJxjBVD5611rqLkegv8AKexDzJznggK21Mrdxoh24WU8L/02VVAqivz6BhHz4YuOiypc0whS5A==
X-Received: by 2002:a2e:b0d6:: with SMTP id g22mr15634459ljl.349.1622443882778;
        Sun, 30 May 2021 23:51:22 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id 12sm1477053lju.41.2021.05.30.23.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 23:51:22 -0700 (PDT)
Subject: Re: [PATCH v2 11/18] dmaengine: ti: k3-psil-j721e: Add entry for
 CSI2RX
To:     Pratyush Yadav <p.yadav@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-12-p.yadav@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <916ef8c9-e444-afa4-d544-8fa672690fdb@gmail.com>
Date:   Mon, 31 May 2021 09:51:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210526152308.16525-12-p.yadav@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 26/05/2021 18:23, Pratyush Yadav wrote:
> The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory. It can
> have up to 32 threads but the current driver only supports using one. So
> add an entry for that one thread.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v2:
> - Add all 64 threads, instead of having only the one thread being
>   currently used by the driver.

How many threads CSI2RX have? 32 (as per commit message) or 64? If I
recall right, it is 32.

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
