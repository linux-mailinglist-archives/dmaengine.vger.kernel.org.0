Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429D06F0C37
	for <lists+dmaengine@lfdr.de>; Thu, 27 Apr 2023 21:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbjD0TBW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Apr 2023 15:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244173AbjD0TBV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Apr 2023 15:01:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED40421B;
        Thu, 27 Apr 2023 12:01:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so6790787e87.2;
        Thu, 27 Apr 2023 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682622077; x=1685214077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xV2YAsXnqJOfUPWjxJCvcfAyBJMrkTcR9Pqblefq9RU=;
        b=I+sgCr7aA+Slw3AlYi53LO5wloydXK2ilcqCqUFdaqjO4CrNyj/OlHk06wDjJdvG5N
         VtsqTbOxUWMRA/J2bWkcxKhI/9OOquAHPwlEolR2ebBGNYR/Kw6bp8bk/5KvVQwS3Tnj
         nOqmvUBlTqkK3YOZSB5jMa0VEXYAnnO7/jsUiX6Chj6+9tD3zRJNLuQ4HWxB4Obi23Gc
         IV278ExMvFRuxqYDXBwBZktgExZTGvR3k9qMqEZnQbyUh3sYOCP0dyBnY9RK7IXGErK0
         5mgi9li7BwHpQbyu84p//KzO/M4CG0AFUsCEvi2lkYI2PKC0p+P+6YyfvJfR1i4oV1nT
         WZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682622077; x=1685214077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xV2YAsXnqJOfUPWjxJCvcfAyBJMrkTcR9Pqblefq9RU=;
        b=almSugRxazHD8UZzbxDBcRx+ippaWGuhVeB0HrkuSvgZtV9qXaSSIm2OSha2mT7zHP
         lNdgPXqWfYC9raOMtP9aowYkUElvja4H9Jrx0feH6qoq7j+doreSKSkbycPzdNpx1GzH
         LhEG4ZAA9ok3px7rdoRSVouAh9eXEMYTwG+XAmCFWFOo2TmmpvQisZCkHXgaiNtU+hB9
         Dy8gfycdFFm8Tfqe+f/xdf6udvCuSVrCBUhpDU0ghoU0zSG0xt27cMHKOyqN1dLEHPCr
         1E5CNjffuwja74q/+LMQtKUqAlKR0Glcfs+dr3IIghpKruLvDv7LbHkxiBnB0SC1TSf8
         jPtw==
X-Gm-Message-State: AC+VfDxFeCZSZdPmcFkRlxZRqrN+kRHJDDfvAyTV+NGm9eeYr8lcaItA
        U5APO2fdeIPIjYUox9GbPy+hqoQrYvDfmA==
X-Google-Smtp-Source: ACHHUZ7BHztPtrElhYsjUgAKeiaqIWyISizxgSVGLhH9jVMnO9Wtesf/mijV4OjteX/uwOafhm6AnQ==
X-Received: by 2002:a05:6512:14a:b0:4ea:fa87:7a8a with SMTP id m10-20020a056512014a00b004eafa877a8amr958745lfo.37.1682622076775;
        Thu, 27 Apr 2023 12:01:16 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id l7-20020ac24a87000000b004edb981dfe7sm3050914lfp.172.2023.04.27.12.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 12:01:16 -0700 (PDT)
Message-ID: <1deaf8c0-0be6-1afe-9a91-ae93ba8a21d9@gmail.com>
Date:   Thu, 27 Apr 2023 22:01:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] dmaengine: ti: k3-psil-j721s2: Add PSI-L thread map
 for main CPSW2G
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com
References: <20230426083900.102229-1-s-vadapalli@ti.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230426083900.102229-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 26/04/2023 11:39, Siddharth Vadapalli wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Add PSI-L thread map for main CPSW2G.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>   drivers/dma/ti/k3-psil-j721s2.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-psil-j721s2.c b/drivers/dma/ti/k3-psil-j721s2.c
> index a488c2250623..1d5430fc5724 100644
> --- a/drivers/dma/ti/k3-psil-j721s2.c
> +++ b/drivers/dma/ti/k3-psil-j721s2.c
> @@ -99,6 +99,8 @@ static struct psil_ep j721s2_src_ep_map[] = {
>   	PSIL_PDMA_XY_PKT(0x461d),
>   	PSIL_PDMA_XY_PKT(0x461e),
>   	PSIL_PDMA_XY_PKT(0x461f),
> +	/* MAIN_CPSW2G */
> +	PSIL_ETHERNET(0x4640),
>   	/* PDMA_USART_G0 - UART0-1 */
>   	PSIL_PDMA_XY_PKT(0x4700),
>   	PSIL_PDMA_XY_PKT(0x4701),
> @@ -161,6 +163,15 @@ static struct psil_ep j721s2_dst_ep_map[] = {
>   	PSIL_ETHERNET(0xf005),
>   	PSIL_ETHERNET(0xf006),
>   	PSIL_ETHERNET(0xf007),
> +	/* MAIN_CPSW2G */
> +	PSIL_ETHERNET(0xc640),
> +	PSIL_ETHERNET(0xc641),
> +	PSIL_ETHERNET(0xc642),
> +	PSIL_ETHERNET(0xc643),
> +	PSIL_ETHERNET(0xc644),
> +	PSIL_ETHERNET(0xc645),
> +	PSIL_ETHERNET(0xc646),
> +	PSIL_ETHERNET(0xc647),
>   	/* SA2UL */
>   	PSIL_SA2UL(0xf500, 1),
>   	PSIL_SA2UL(0xf501, 1),

-- 
Péter
