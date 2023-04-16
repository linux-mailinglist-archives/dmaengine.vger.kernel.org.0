Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376996E39E3
	for <lists+dmaengine@lfdr.de>; Sun, 16 Apr 2023 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDPPo1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Apr 2023 11:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPPo0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Apr 2023 11:44:26 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD8626AE;
        Sun, 16 Apr 2023 08:44:24 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3296292e623so17780565ab.2;
        Sun, 16 Apr 2023 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681659864; x=1684251864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91aIoHmg4vcGf+5r6THoD0HOXyJDPiMRC/dJS4oa9A0=;
        b=QjjA1ou0UIKs7eIwaPtXNsdhENzOQ7z9q5XEsj9R+tCOdMoV6kWRfqrc4siHLSiUlF
         oHsj6KOXxmRi7FkaYo+QglmNEdsa0GREKIrPI8OkF5sixNFw0j+v6fHPJ/t3qywM8GXN
         cqV7SQSqxWOh8qchiSKHNpZR7QpUw8Qdw0TJHv75pox8a28s4qxpyUMaIDeSEBCLIGTz
         GvE2Hyeku/yDeQ/byx3cbJf02RQ2ljCgXL+IhXbPJB9zj4YsNjw9c3emCx/bmzkAEthZ
         UNlwc6369lz9QYiSlVFWe4AIqIZbh/5LmPsHQoNet/e2gmDnP3CwbOlAYanNGYJfkNi6
         2Wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681659864; x=1684251864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91aIoHmg4vcGf+5r6THoD0HOXyJDPiMRC/dJS4oa9A0=;
        b=eCI40tVIvHTXI+iYsncNJ1O8X2u95RMQJZRf3QSBhHvA14lRQdqh8ORrtn0r/aP2Xz
         P1lsdOGWy9U0dZfxyYWI1RxYZoUnAE2kj8DCpFBWe87GvXJtlKcG1RZ9sbmCpHnAFcMC
         x28QX+LTELMh/JVvtRDnOLY7iHcDoN9fy0Xzfagl3SgWU5ai0Rc8c+SzAOWoaajy0gDS
         3M5BQ5/Bh+TwnEx5FENU7AGNOfwrdFCryuS7hPPLfrJVpmMne0B2eXM8mWSuSH1nMNIq
         wWwoXRreFt1zN74lJVK4njG3drNUwHwEsCY6vzi5AQ2P7aylz3F2z/I3t4G0mtDb08UC
         W6KQ==
X-Gm-Message-State: AAQBX9fp+vVnv2sh0xTimxLWhezdkS5eu7q4p1Hsbv4gmEh7ups7aEqv
        36P76aVVc5udJ1GnQqO9hMs=
X-Google-Smtp-Source: AKy350ZMnoyAGUI9lxBZtHTCTx8O3E8c1qudJvjlsX6mWO72duO6ML9giJExJSnqIzKVJpb5SoZNsw==
X-Received: by 2002:a92:cf41:0:b0:329:3c3b:93f4 with SMTP id c1-20020a92cf41000000b003293c3b93f4mr9050633ilr.19.1681659864335;
        Sun, 16 Apr 2023 08:44:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q39-20020a056638346700b0040fa075e5e6sm524644jav.102.2023.04.16.08.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 08:44:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 08:44:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
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
Subject: Re: [PATCH 1/6] dt-bindings: watchdog: qcom-wdt: add QCM2290
Message-ID: <2a50421a-3e1c-48fe-8a91-8a242634f240@roeck-us.net>
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
 <20230314-topic-2290_compats-v1-1-47e26c3c0365@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314-topic-2290_compats-v1-1-47e26c3c0365@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 14, 2023 at 01:52:56PM +0100, Konrad Dybcio wrote:
> Document the QCM2290 KPSS watchdog.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 6448b633c970..db3e260fb2ef 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -19,6 +19,7 @@ properties:
>            - enum:
>                - qcom,kpss-wdt-ipq4019
>                - qcom,apss-wdt-msm8994
> +              - qcom,apss-wdt-qcm2290
>                - qcom,apss-wdt-qcs404
>                - qcom,apss-wdt-sa8775p
>                - qcom,apss-wdt-sc7180
