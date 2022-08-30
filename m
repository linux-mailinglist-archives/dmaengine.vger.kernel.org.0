Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AD55A5EBC
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 10:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiH3I5a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Aug 2022 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH3I53 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Aug 2022 04:57:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2CF9DFB6
        for <dmaengine@vger.kernel.org>; Tue, 30 Aug 2022 01:57:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p5so11452534lfc.6
        for <dmaengine@vger.kernel.org>; Tue, 30 Aug 2022 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=GqxXJYLcgxzpP2ZXiJpKYao0UsYj8w9DXe+9ym7gme0=;
        b=ujObYb7BZjSY2DG1cWtiXE+XefTdW9gkANM8ivM/MyZaWp2WACtiRtjyn9khuMY6dL
         7xUWQE/PGwBxSRXLV9PYIOx6nGWmv+nQ3T1/vQnrHh8AwYM+oNFlit+m23uReoNY1LCQ
         bp41qS+zVwBwi7JDyvD29HsZ9GPn12z10Dm9eP49yjHEBVJWyO/XCpu9UMxdd5B2/Y4M
         28dCWyzz+s01uq9wDqUJGS58VnQRCtUsghnGTwjqaGFj9zUgkUfQQ92Zl3A9CUWGZW98
         4oOXfroo9QygAIsAaCszAk/SlpVh5P3h7kghynKiDVCGlt0b814ZRJrxokUIATYQXzak
         NbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GqxXJYLcgxzpP2ZXiJpKYao0UsYj8w9DXe+9ym7gme0=;
        b=VkYCeBSrZTr9dN2rBc3PyGCduhh7M7ILh/dw5l2X6dOcppY+xCphiTil9rdE0Jxlc9
         yIcocBC6D3rH1rywAAOkdRGIqlTU3ChD808d1n3USW4UgbL1JZ+jnuparwhrBldSlcK0
         zIDxFsCJFNBS20v6ZpZ4+RM7WaL3w3avKtKmItyHaaKa9st6q6OMk/t10i/XqYTJtKP4
         qpN2u6EynEOirRgVpULUqLOWLAi1TPJfmXQW53C9qJkzN091bbnT3ShVqOHFMBUdvwCU
         6p0MTnQQ+Eb/ElLQ/f1r9Grz+iE1UTCYPOrJdwWFP7Oaq5DFtU9YQERbVitzWJNESQh5
         KTag==
X-Gm-Message-State: ACgBeo2TvD2n0HW6EDicsDq+bDStw/mI7Fl/Z8A0BGbV4BSd1IEiRfEI
        KtUkssJon0VnoYKSou9BGNOC8A==
X-Google-Smtp-Source: AA6agR4EU+9shH21zvi7esssrpBh2nzV77A/AczGVMGQGOf/eJ1aqB+K9adBP6pNavBwjlUVXcwY3w==
X-Received: by 2002:a05:6512:108f:b0:494:7299:7152 with SMTP id j15-20020a056512108f00b0049472997152mr1954983lfg.514.1661849846799;
        Tue, 30 Aug 2022 01:57:26 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id c9-20020a2e9d89000000b002655fb689a6sm718889ljj.139.2022.08.30.01.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 01:57:26 -0700 (PDT)
Message-ID: <40577a34-6046-a10b-e444-4fb36d13e8e6@linaro.org>
Date:   Tue, 30 Aug 2022 11:57:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V3 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT
 schema
Content-Language: en-US
To:     Joy Zou <joy.zou@nxp.com>
Cc:     shengjiu.wang@nxp.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220830081839.1201720-1-joy.zou@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830081839.1201720-1-joy.zou@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30/08/2022 11:18, Joy Zou wrote:
> Convert the i.MX SDMA binding to DT schema format using
> json-schema. In addition, add new peripheral types HDMI
> Audio.
> 
> when run dtbs_check will occur nodename not match issue
> because the old dts nodename can't match new rule. I have
> modified thoes old dts, and will upstream in the near future.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes since (implicit) v2:
> modify the commit message in patch v3.
> modify the filename in patch v3.
> modify the maintainer in patch v3.
> delete the unnecessary comment in patch v3.
> modify the compatible and run dt_binding_check and
> dtbs_check in patch v3.
> add clocks and clock-names property in patch v3.
> delete the reg description and add maxItems in patch v3.
> delete the interrupts description and add maxItems in patch v3.
> add ref for gpr property.
> modify the fsl,sdma-event-remap ref type and add items
> in patch v3.
> delete consumer example in patch v3.

This is patch 1/2. Where is 2/2?

Best regards,
Krzysztof
