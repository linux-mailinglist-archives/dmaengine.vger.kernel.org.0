Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45BA6BAA53
	for <lists+dmaengine@lfdr.de>; Wed, 15 Mar 2023 09:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjCOIB7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Mar 2023 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCOIBx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Mar 2023 04:01:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703007203C
        for <dmaengine@vger.kernel.org>; Wed, 15 Mar 2023 01:01:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o7so7064265wrg.5
        for <dmaengine@vger.kernel.org>; Wed, 15 Mar 2023 01:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678867303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5wswi1DyAuYzJFWHWsqSArP17cSfb+M+N1FHnH+AfhA=;
        b=bXvkz/yX64lIDsHFesL+52hM15LEw2hh1hd9XLiSKXK5vxE8pVYfQHdqOkZ0FMGcXc
         F4R5ESNK1Tk/rqBaN0eR6oFsui0szxNHXCWqekofsh7DM5r+IptlZ9qE6WEFyLlaf6Hl
         KyYDpbpee/rxB5EBAcwllKXsRlAQjufynXVfD1GFQI7wSV+pAvgHZ/75PWUPIUueSqqe
         X8oXiF17AMiftJmvXhVXWltm3IFGEYPlkPuMRzwSea4ejcU7QjVql4IPqo5vAqru7CPX
         VBlxrDOKNoKvMyfxoC+fMZHuoZV9ch6sgrWqlaARYDZJfBWMuQOEw47ZkZv/mCkjtBDH
         sFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678867303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wswi1DyAuYzJFWHWsqSArP17cSfb+M+N1FHnH+AfhA=;
        b=J0KLdkmYan+WMMOONk92EsE4zJ0uCJKM5VMq6laDFjQIur36l5RzH1lp4FZnaEp/0+
         yBQ1q2hW4e22Q3FwnnU/3ynf1gg6dP0605U4vw1ZbRZoxSR9r3sBJNiD1PmQBuysbsJJ
         fkdEkPqENY9h9RFebCX31DUaLYrnEejdZ0IOfNxTLwV6hG4xSititC6VTxuejzvW0Bht
         hz19jZrKB9w71XMRnWeBiuEqXuTLxQ953qaQE4NlflBTGGeTt4RUvH48Go5s0XnWp0kP
         oWaMX9bvU7j9bOocTlOmAeSRCaj+xbEQk5TzUWi4fM4cl/fjNMsoZa0yj452cZyEj7iJ
         0J6A==
X-Gm-Message-State: AO0yUKXq/J3LbAd/eBPDlHknfBzWvdR7G2uxDQMn7K2pKRg7ltHqv3x2
        ur7zp14jYevN4LBWB7xwcfjq//wYma9eqXDC+h9Oug==
X-Google-Smtp-Source: AK7set/zDwpw5tmgpQkQE93auoU6m0X9eMFuTR84C2UImSDMGqPTyR5wis50nno6pRellvCAciITc3dcaQs8FlsxmTE=
X-Received: by 2002:a5d:65cc:0:b0:2ce:a3a6:79f6 with SMTP id
 e12-20020a5d65cc000000b002cea3a679f6mr365503wrw.4.1678867300640; Wed, 15 Mar
 2023 01:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 15 Mar 2023 13:31:29 +0530
Message-ID: <CAH=2NtxHrk4XnFAzUD82ngqihsEPHKztz_7OJJ36U4X=DA9wGQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] QCM2290 compatibles
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 14 Mar 2023 at 18:23, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Document a couple of compatibles for IPs found on the QCM2290 that don't
> require any specific driver changes
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (6):
>       dt-bindings: watchdog: qcom-wdt: add QCM2290
>       dt-bindings: dmaengine: qcom: gpi: Add QCM2290 GPI DMA
>       dt-bindings: nvmem: Add compatible for QCM2290
>       dt-bindings: mmc: sdhci-msm: Document QCM2290 SDHCI
>       dt-bindings: usb: dwc3: Add QCM2290 compatible
>       dt-bindings: thermal: tsens: Add QCM2290
>
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml       | 1 +
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml      | 1 +
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml  | 1 +
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml      | 2 ++
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml  | 1 +
>  6 files changed, 7 insertions(+)
> ---
> base-commit: ec0fa9a0a6fac454745c930bdb8619d0a354bac9
> change-id: 20230314-topic-2290_compats-5bec96afeeb0
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>

Thanks for posting this, for the series (with the assumption that the
board dts will follow soon):

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
