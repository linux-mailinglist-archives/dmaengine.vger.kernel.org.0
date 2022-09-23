Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F25E85C5
	for <lists+dmaengine@lfdr.de>; Sat, 24 Sep 2022 00:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiIWWUk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 18:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiIWWUe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 18:20:34 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730EB1166EA;
        Fri, 23 Sep 2022 15:20:31 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id m16so845937ili.9;
        Fri, 23 Sep 2022 15:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Wms+EsGAbtafKKLzhloMJhni7qXQ+aJ2BVMhYXfuWbo=;
        b=Lj74ttX5nlY/XZqeHBv7/0k0wSuDxkLi1EJ9MNtigWE3d/MQ9OqZnTTKoTivYLCHfP
         6cGnSNZ/t4WRTK5hjM6Skexbj5HHofFktJf5rtQc3L0XHPYMcZ4Af25IGzZXx0mwK2Pa
         V/Kr+ykk9hJ210mLty/R9boVKJNSFUwfAENQpvfrBmIIoT8Ok97tK1Y4kVcX6dLrbOZq
         UqG+zEV9xW4/55e6Fksx+IrdMGN39a56KGGXQLP3DFjMo6lhE6W2k8UCF36gxhknQtxA
         AMWbYYgrnRG3U4kN7SdyGxoP30Z/GLG60gKdhtkBwG15TPPkDfj0lcCCHenno2qjglvR
         LJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Wms+EsGAbtafKKLzhloMJhni7qXQ+aJ2BVMhYXfuWbo=;
        b=qQCIFlbyzMDtnR7+ZkVadUAeUleIvfEoQOsVCf3Pus8NzhdQ4h3DxDSUa+wa4YDtyj
         lydww8goARguMgUor3+iK2GqbU2w33WUzC/JpDQTelLa7HgGKBf0YzBmc7tYXlbBZtnV
         zSq54gnBJDZLSLk4yfU05sAIwr7Rx1NxaHTVj4sh7dcy95ikjSX7KpowPubKMCdNq/C1
         wxJ0471mdle4hcGZvakNKrtTJUqNZyHMu1aRDXGsq8Mj8rDioRab1me6FAs+AMB8Jkb8
         8odC0l4N2vk3Ce5G+sPBEX4TIZprCRpCKA4aO6DyjCh52epSrix6xoiJ19jp/OkD/a47
         bpAQ==
X-Gm-Message-State: ACrzQf3S3C9Mc0NWcTntQZSh7s1RNtYRaHdxknGQbtEjyjkJubbIU143
        mHgkel7IXCv6r9WnOp8GaBw=
X-Google-Smtp-Source: AMsMyM4LyL3Sbzc5S7bG6GhiHIbGtFgleVniGGloNtihwviXUHlm/OO5amsC1PzN0kxf7IYFYqwdcA==
X-Received: by 2002:a05:6e02:148b:b0:2f6:bb96:7a0e with SMTP id n11-20020a056e02148b00b002f6bb967a0emr3934871ilk.127.1663971631367;
        Fri, 23 Sep 2022 15:20:31 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id m26-20020a02a15a000000b0035b1b597290sm3182722jah.162.2022.09.23.15.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 15:20:30 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: dma: qcom: gpi: add fallback
Date:   Fri, 23 Sep 2022 18:20:28 -0400
Message-Id: <20220923222028.284561-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <7b066e11-6e5c-c6d9-c8ed-9feccaec4c0c@linaro.org>
References: <20220923210934.280034-1-mailingradian@gmail.com> <20220923210934.280034-2-mailingradian@gmail.com> <7b066e11-6e5c-c6d9-c8ed-9feccaec4c0c@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On 23/09/2022 23:09, Richard Acayan wrote:
> > The drivers are transitioning from matching against lists of specific
> > compatible strings to matching against smaller lists of more generic
> > compatible strings. Add a fallback compatible string in the schema to
> > support this change.
> 
> Thanks for the patch. I wished we discussed it a bit more. :)

Ah, sorry for not replying to your original suggestion. I didn't see the
opportunity for discussion as this new series wasn't that hard to come up
with.

> qcom,gpi-dma does not look like specific enough to be correct fallback,
> at least not for all of the devices. I propose either a IP block version
> (which is tricky without access to documentation) or just one of the SoC
> IP blocks.

Solution 1:

Yes, I could use something like qcom,sdm845-gpi-dma. It would be weird to
see the compatible strings for that, though:

    compatible = "qcom,sdm670-gpi-dma", "qcom,sdm845-gpi-dma";

    // This would need to be valid in dt schema, suggesting solution 2
    compatible = "qcom,sdm845-gpi-dma";
    // This just doesn't make sense
    compatible = "qcom,sdm845-gpi-dma", "qcom,sdm845-gpi-dma";

    compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";

    compatible = "qcom,sm8250-gpi-dma", "qcom,sdm845-gpi-dma";

Solution 2:

I could stray from the "soc-specific compat", "fallback compat" and just
have "qcom,sdm845-gpi-dma" for every SoC.

Solution 3:

I found the original mailing list archive for this driver:

https://lore.kernel.org/linux-arm-msm/20200824084712.2526079-1-vkoul@kernel.org/
https://lore.kernel.org/linux-arm-msm/20200918062955.2095156-1-vkoul@kernel.org/

It seems like the author originally handled the ee_offset as a dt property
and removed it. It was removed because it was a Qualcomm-specific property.
One option would be to bring this back against the author's wishes (or ask
the author about it, since they are a recipient).

Solution 4:

You mentioned there being an xPU3 block here:

https://lore.kernel.org/linux-arm-msm/e3bfa28a-ecbc-7a57-a996-042650043514@linaro.org/

Maybe it's fine to have qcom,gpi-dma-v3?
