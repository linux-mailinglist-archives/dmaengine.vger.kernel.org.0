Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FC335383D
	for <lists+dmaengine@lfdr.de>; Sun,  4 Apr 2021 15:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhDDNZC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Apr 2021 09:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhDDNX5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Apr 2021 09:23:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB548C061756;
        Sun,  4 Apr 2021 06:23:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w28so13862780lfn.2;
        Sun, 04 Apr 2021 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nzpd4Vuf3kote7U8VoWNZRV+1cO2k+CwPl3bjJUX7L4=;
        b=jTGiv/ltH6tXMRh1sa9l53S3rlQ36ZEyoAOJ0OFYDQD4lcg1DYLAt4HMH2OfaFb3Ks
         7WfrNF6HtYqm80fkl2TWUk8vMxTKf3Ar7OO2WTIkf6XTIX6NdezwR+8/Os8zSc1DN2EV
         bYcOlHYmIxM1LcR2Ea36+G8e4oscGJLSsCMsqrxki62wsaz2fGRAbdmtdeMjcn2TRzUQ
         4cnNPvo+xch76Yu/9jPc7rRBVEj8ZWJUUYnmEyvVPr1MPtuwSSIwpCodv2MSpoIM+ut0
         yoC5XaNHHYwZ2+W963Jq4TgMSvAyN3dEYO/S0jydgxJrGnMBw6fe28dpCLbnhPPkqE2o
         nZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nzpd4Vuf3kote7U8VoWNZRV+1cO2k+CwPl3bjJUX7L4=;
        b=SyuakGJZ1QkzekchGXIym+eNPaXgZaFy3ZkX9VdoI4X1AW6e1i3+FZPGoQWBTFQNes
         /W9Sbg9ckgp0R2/LA+n3vFnD1a5BxcONPdWtJmkDGGyrudFFTVFVCpnqyVUuUrFz1QTw
         vaBfPP2QtkHz2HrA0wIiCnbq4dpfuqp8p5TaDGFto0coVHE3XdKk1ZIyzMgDj1PXPwmA
         6iC9q6b/OvJsIekzi2C6b9AFmA9LUQHj4N6r37wGcqpRzrcWMf7e3ZknCl6YzL/tABY2
         C64KngVWqyaVvjMn2/iwarSan8XqHeXaoTN7zwHVLyTGTCD8ZdH47/h6J9jHLEIpBZW+
         ikyg==
X-Gm-Message-State: AOAM530JQXnVpW+NDj943iJyEfkKfI31ly0q52AHtUT258s1SSnvAiFE
        2Rf5sviHdTFi4ekLTqOvNzk=
X-Google-Smtp-Source: ABdhPJwHUBVB8eEUjrJWD4onehy9Mey9+WSE1xcAdji3JR12pymm1dFCr3aamwRwRGniVZLgXGLsOQ==
X-Received: by 2002:ac2:4471:: with SMTP id y17mr14574843lfl.307.1617542630157;
        Sun, 04 Apr 2021 06:23:50 -0700 (PDT)
Received: from [10.0.0.42] (91-157-86-200.elisa-laajakaista.fi. [91.157.86.200])
        by smtp.gmail.com with ESMTPSA id y22sm1441965lfg.133.2021.04.04.06.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 06:23:49 -0700 (PDT)
Subject: Re: [PATCH 11/16] dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
To:     Pratyush Yadav <p.yadav@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Helen Koike <helen.koike@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmaengine@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-12-p.yadav@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <78a5983c-04c8-4a4c-04fe-bb1f31e87375@gmail.com>
Date:   Sun, 4 Apr 2021 16:24:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330173348.30135-12-p.yadav@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pratyush,

On 3/30/21 8:33 PM, Pratyush Yadav wrote:
> The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory. It can
> have up to 32 threads but the current driver only supports using one. So
> add an entry for that one thread.

If you are absolutely sure that the other threads are not going to be
used, then:
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

but I would consider adding the other threads if there is a chance that
the cs2rx will need to support it in the future.

> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/dma/ti/k3-psil-j721e.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
> index 7580870ed746..19ffa31e6dc6 100644
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
> @@ -138,6 +146,8 @@ static struct psil_ep j721e_src_ep_map[] = {
>  	PSIL_PDMA_XY_PKT(0x4707),
>  	PSIL_PDMA_XY_PKT(0x4708),
>  	PSIL_PDMA_XY_PKT(0x4709),
> +	/* CSI2RX */
> +	PSIL_CSI2RX(0x4940),
>  	/* CPSW9 */
>  	PSIL_ETHERNET(0x4a00),
>  	/* CPSW0 */
> 

-- 
Péter
