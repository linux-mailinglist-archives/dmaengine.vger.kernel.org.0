Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6B63C517
	for <lists+dmaengine@lfdr.de>; Tue, 29 Nov 2022 17:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiK2Q0U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Nov 2022 11:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiK2Q0T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Nov 2022 11:26:19 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B422B19D;
        Tue, 29 Nov 2022 08:26:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp15so22786526lfb.13;
        Tue, 29 Nov 2022 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxf0kyi+s2Sutj6Iq3Va9K/X2sWiGBntVy1/4zVaeeo=;
        b=f53shSw7iwr3fTocRBL3RJqaS2TtbFH+jso75wE3Sj8/gb7E5JKDmyKql4Y1kvbAoh
         kRX1BboC3KBu7aEJcFYaFmWlHyRrOPC9u3m7PwaSbraRkbyAIS4WQD8DVzsY1sWUs1j0
         9KxUWZfNUSHBkFjC/4uHl7H02tzN0VboJ/RbYmlpXoxSCL4twMTN0DnkX+KPNd8Zdkwx
         Xs8zMrnUx5i4yr4s1/GQwZQNN/hbCh3GUKc3nkcaM902Bz46KqyfFGLkME08ZzQKReHp
         cD79oerHDP5FBKHenYco27LqTcak71AfK4sJHPaAcRvA2IvyvP2VlLgTgdxIvt5AUedP
         d2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxf0kyi+s2Sutj6Iq3Va9K/X2sWiGBntVy1/4zVaeeo=;
        b=0zPoeVweUXPyqOtnm/Dld6Y/sqxUBUKxeXYtPrXbjswFAnyiQ+SADT6wYFKqt537kq
         8tjHZ9Vxd5+z9Bw+6ssgfVDWog+ayIbYOSn6Zbzpta7MI8H7vpcoGF9idcRl2WZfDfdQ
         Fu0/k3Rs8MT8+Kg2YkWiYUL1iFLPyTY6gDvFUIrWTygw7GrXSnZQBmvsxSBafXA/h6Kd
         nGyqPeozoR87P0vEp+zPKRfOpC8EFcv6jksUV4GjBmRzJ28eIQhy7q4bNKJ+pL7IM0gx
         oPQ1tYMOYpUkoOUIyNhV1B/46BrquX8BEjSv5FCBQDcSo9/tvVCJsmkHu80FrLCkXA8Q
         Qn8w==
X-Gm-Message-State: ANoB5pk8oyqJPDmf2+Oz3M8HTAOb1zf931BrfVrcUyTdIlZqPL9bAnAb
        oLtVVYkIxnI1AI3ufDuE7lo=
X-Google-Smtp-Source: AA0mqf4/20Id36sAcbr1ok6LioIwk86ztFoCnJG/+naQ8a3UqglsWbuIoZDlozYoBZ7pTzE/h8+J2w==
X-Received: by 2002:a05:6512:2512:b0:4ac:9008:482 with SMTP id be18-20020a056512251200b004ac90080482mr18817538lfb.402.1669739176943;
        Tue, 29 Nov 2022 08:26:16 -0800 (PST)
Received: from ?IPV6:2001:999:230:8bc4:e9e4:a37:1c80:5708? ([2001:999:230:8bc4:e9e4:a37:1c80:5708])
        by smtp.gmail.com with ESMTPSA id v19-20020a056512349300b0049876c1bb24sm2246180lfr.225.2022.11.29.08.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:26:16 -0800 (PST)
Message-ID: <e032e055-9677-f332-b4a8-93acb25b78ec@gmail.com>
Date:   Tue, 29 Nov 2022 18:27:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Do conditional decrement of
 UDMA_CHAN_RT_PEER_BCNT_REG
To:     Jayesh Choudhary <j-choudhary@ti.com>, vkoul@kernel.org
Cc:     vaishnav.a@ti.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221128085005.489964-1-j-choudhary@ti.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20221128085005.489964-1-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 28/11/2022 10:50, Jayesh Choudhary wrote:
> PSIL_EP_NATIVE endpoints may not have PEER registers for BCNT and thus
> udma_decrement_byte_counters() should not try to decrement these counters.
> This fixes the issue of crypto IPERF testing where the client side (EVM)
> hangs without transfer of packets to the server side, seen since this
> function was added.

Right, the BCNT is available on PDMA_XY for sure, I don't know if it is 
on AASRC/MCAN type tho, but they are not used right now.

I might clarify and use ep_type == PSIL_EP_PDMA_XY to be sure that only 
the known variant is handled, but this is fine as well.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Fixes: 7c94dcfa8fcf ("dmaengine: ti: k3-udma: Reset UDMA_CHAN_RT byte counters to prevent overflow")
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   drivers/dma/ti/k3-udma.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index ce8b80bb34d7..4c62274e0b33 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -762,11 +762,12 @@ static void udma_decrement_byte_counters(struct udma_chan *uc, u32 val)
>   	if (uc->desc->dir == DMA_DEV_TO_MEM) {
>   		udma_rchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
>   		udma_rchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
> -		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
> +		if (uc->config.ep_type != PSIL_EP_NATIVE)
> +			udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
>   	} else {
>   		udma_tchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
>   		udma_tchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
> -		if (!uc->bchan)
> +		if (!uc->bchan && uc->config.ep_type != PSIL_EP_NATIVE)
>   			udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
>   	}
>   }

-- 
Péter
