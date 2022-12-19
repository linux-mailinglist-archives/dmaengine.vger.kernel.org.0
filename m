Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED30650A55
	for <lists+dmaengine@lfdr.de>; Mon, 19 Dec 2022 11:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiLSKry (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Dec 2022 05:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiLSKru (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Dec 2022 05:47:50 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DF8E0FC
        for <dmaengine@vger.kernel.org>; Mon, 19 Dec 2022 02:47:47 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b13so13059093lfo.3
        for <dmaengine@vger.kernel.org>; Mon, 19 Dec 2022 02:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2CoDDdJPV+F+RkeEfjAJH81FjwM8sOza7IocmxaprM=;
        b=qU5NWvCQQbrNIMqmikpeNTaJe6vN4Uzeg0CvVk4rpMqg3N5VE4C2Carv+JJSzJWHkn
         MoWfDR59bHEBtTWb55PeV7Q78eMn/xdOYEQfzP+JNVCVXYs7Hw8V67y9QJxfCd3nhvZy
         my1Np3IoxrnsOSXKdYsXa/u1a5MfTQDcvo7WQtOVMdmwA/TXhiibBlkzJzztBRjAeGc8
         wtMKhhLok3TF3VnR1TGhKeaSYfPhkVgEnWHuMqiKydlUJSMEoDe+NkdRS+4wP4Kcvu38
         gjcPBVdXumZsfQsYYEzxuU006uZtqJfK+uLTsa96ZkdqYVrHayFWnIl4Y4wNQpy8scXA
         UdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2CoDDdJPV+F+RkeEfjAJH81FjwM8sOza7IocmxaprM=;
        b=jntyh/XyD05v8QJmuINtbO06ktD9kzS/WOiARjyUjyJVDwdchBzommocedhUh3QiZ1
         2FS54K9Jik2vXH+QL4EWGDrmEctHE7Lgopp8tGG1ecD2RjwL2HXSsDFNqRq7RzvrTGeN
         rXsU/kHoPvlXe58U05WmyTYpfm3t335WQ+hjMInhG0Z8iXcn+YJen03SIpgADucmJsTm
         VDSAlFSJeL4mx49nF7QrNnYEOeQ8ZB3EmPkT0RZ9nskTkiYHmQFGo4BBz67rjaVjWImr
         WSh9UyI5AMn2lKxk1x4g6kZ0XhCjRz+MM5itSHaNHUFe7mYgJ7tuCPRImrhhNMWy+5if
         Jlhg==
X-Gm-Message-State: ANoB5pm6D0i0Mhca9ZG5Xxp4zR8w9VdvtQ1Ln59EvmpBbDFGDda9QbBL
        pzsdZtS1iXDWc9mgAnISRpWDUw==
X-Google-Smtp-Source: AA0mqf6zwvEdGK2fNK6Ur54nIDh33i8BjY3gi5/EVb4DLTo9bLZoblQkYCX85TGqVkpagvhxGVqyKA==
X-Received: by 2002:ac2:4e12:0:b0:4a4:68b8:f4f6 with SMTP id e18-20020ac24e12000000b004a468b8f4f6mr16010921lfr.60.1671446866158;
        Mon, 19 Dec 2022 02:47:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b6-20020a056512070600b004b51ab265f8sm1072924lfs.193.2022.12.19.02.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 02:47:45 -0800 (PST)
Message-ID: <6d2e2df1-0e22-a7dd-1b6e-c66f22597e4e@linaro.org>
Date:   Mon, 19 Dec 2022 11:47:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] dt-bindings: dma: fsl-mxs-dma: Convert MXS DMA to DT
 schema
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221219093713.328776-1-marex@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219093713.328776-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19/12/2022 10:37, Marek Vasut wrote:
> Convert the MXS DMA binding to DT schema format using json-schema.
> 
> Drop "interrupt-names" property, since it is broken. The drivers/dma/mxs-dma.c
> in Linux kernel does not use it, the property contains duplicate array entries
> in existing DTs, and even malformed entries (gmpi, should have been gpmi). Get
> rid of that optional property altogether.
> 
> Update example node names to be standard dma-controller@ ,
> add global interrupt-parent property into example.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

