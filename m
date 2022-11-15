Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96940629D33
	for <lists+dmaengine@lfdr.de>; Tue, 15 Nov 2022 16:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiKOPTI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Nov 2022 10:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiKOPTF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Nov 2022 10:19:05 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B322982C
        for <dmaengine@vger.kernel.org>; Tue, 15 Nov 2022 07:19:02 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g7so24951559lfv.5
        for <dmaengine@vger.kernel.org>; Tue, 15 Nov 2022 07:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBTiHOlwLmRiAuaSvNZO8YXJt075Sx4T7PQqEUHFf2c=;
        b=d6u6VmjGdTBtmz5cEKvMM6xpVQ6BvhVhWJCSIuME0VV8b1aBkaLDsezcLTxZb2vrcG
         rR8uuNHtMCcSaHyQ7KSfMHTW4LPRHxL5qSeQEMf80/9jcWQ3sPfDL2zGhFlhe3f48aEV
         YVEX5hBoeB+y9lEtuLlCZDphF0T1D+u3GMWL6k4rZsFYojo4KNggT0ViLLlZtOAW8Nwp
         s3hiUF8yl+k9DRNNIkut80NAEaCzYZ2y5zeCHwBp53LHx+wKVqG341hSpxNqoZHXLk2g
         AQlsDnSjUW8m6H1RzZx/oMOMIhcn6JkXxS3noAHAE2rxgnScOAhVA/kN/8f68k6AGyVM
         FXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBTiHOlwLmRiAuaSvNZO8YXJt075Sx4T7PQqEUHFf2c=;
        b=6GBbOu5iTDx/9vNSihI6kqWidO8ATGIAye+xJdWsiHtEH4oI+LmMZ1hLh/r0s0fF8r
         o2Umsx+mjYJhbLjc6titpadIqWz97oCu2znrQuHlNP8UCgn7jKXfR+yr0HCjcdxSwX7o
         PA2idScuxfFbN7mqOForWJyk1vJ1f77RwHTmAg6Ff2V8/mnSA8DQJsGc/9QLv/oItD3e
         KUuxTh9NkBmUH7noK7sYzKxBE0MML5t00mRPRZu+ioNhvwI7V5ZqWmzGclEpuS7EYxQV
         uyGS1DxWyARUQ5PQmNyoRc0LZNAgGAcxPTK8HJiKm/wrn/Do1mql13PqPENny+KDejPn
         5THA==
X-Gm-Message-State: ANoB5plmDB6VECay4dNWZ0GsgjkBwWiJ/nAMhEmU3EfKtOxlrAC20qvv
        86MlHvO1iy7Ia26IU2m9zLETAA==
X-Google-Smtp-Source: AA0mqf4jb3EPPaIrHilGakTHY0Y9MJQ/s64A+PrmCjrCNClAt3BIroL+6i112TZF2XocXB6Cod5vEw==
X-Received: by 2002:ac2:5314:0:b0:4b1:8fbb:d3f4 with SMTP id c20-20020ac25314000000b004b18fbbd3f4mr6147602lfh.70.1668525540702;
        Tue, 15 Nov 2022 07:19:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bp8-20020a056512158800b00494a8fecacesm2241052lfb.192.2022.11.15.07.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 07:19:00 -0800 (PST)
Message-ID: <a7d1de8f-c1a6-890e-12ed-ebb75a96aa2c@linaro.org>
Date:   Tue, 15 Nov 2022 16:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT
 schema
Content-Language: en-US
To:     Joy Zou <joy.zou@nxp.com>, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221115093823.2879128-1-joy.zou@nxp.com>
 <20221115093823.2879128-2-joy.zou@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115093823.2879128-2-joy.zou@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15/11/2022 10:38, Joy Zou wrote:
> Convert the i.MX SDMA binding to DT schema format using json-schema.
> 
> The compatibles fsl,imx31-to1-sdma, fsl,imx31-to2-sdma, fsl,imx35-to1-sdma
> and fsl,imx35-to2-sdma are not used. So need to delete it. The compatibles
> fsl,imx50-sdma, fsl,imx6sll-sdma and fsl,imx6sl-sdma are added. The
> original binding don't list all compatible used.
> 
> In addition, add new peripheral types HDMI Audio.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

