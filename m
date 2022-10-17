Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18B3601AF4
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 23:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiJQVGv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 17:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiJQVGf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 17:06:35 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3737CE3A;
        Mon, 17 Oct 2022 14:06:28 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 187so10176603iov.10;
        Mon, 17 Oct 2022 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zb5dCJMmbifAmMeWE+WOg/Who9dgBV1R0nSBBi0FI+c=;
        b=c+2OFtZ4fUb5M/hJZPOc98r1Xc82kZF/wvHJTHld6CoxuR0Eq4B9k8R/pHbaRfpR/W
         ZOZg7f8LgoAsyGQM/Xv55u1uIzGIBcbDQ/uBSMAbNszEhKEwuJi7i+a973ezEQ8WLxrU
         CzYSpo3DH3NlrcsuKKUnKmfcxzxyouDru8RJ/ljmoWWKKdUPVT5yZl1xJr422hJ84LDH
         YrDtL1xCkwzc0L+d+ZisVz6y8eY/ojSiH4gEbt0ugUMRUuYZ85SyvD6OdUPcaXwMndmo
         wWS61ZlB3RVhqOb48X+VSzG8Nb3LhVrNbr4EZLTwepWBTrUL4kb8kEWb9VlNOC8kPTH7
         qreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zb5dCJMmbifAmMeWE+WOg/Who9dgBV1R0nSBBi0FI+c=;
        b=AFbIp3oR5OSKUfecN7DP81mvPXy/dvd4V9Uu9Hh+zctr59tPgWj2rYc2PyKRwy+iDO
         Bv1MVPGwT5bBwzoh3sqH+jV6u0L3UbQKYrqu/wpmvR8FmelRgjHXOLOBY8bhdbDaHgs0
         mZ/HP6ZaW7RJ5C556W55clErMk2iIQv/qUU3pRx3fPYhtLB/4XxGbRO4WTtQ96SagW13
         WG0fZazvKEBdA1wMBfwpM9bMa9cSUETNEYO7UMunZBsSKtcn0d+lcGWZx9N5OMG7eabx
         7I+QTwx2P9rdfsLIuNng03c8eyiYeqANITlc9X8KasKH4qgw2YyMm2uniEeTyHu6suE1
         +MjA==
X-Gm-Message-State: ACrzQf3MI55EKtzMtBbQT807AKfJOPCjNF9ySpHvGyxWbg+cFAjj9rBA
        Niqmgejj9Lvw+wHwQQeZcc48eJ4exeH/KA==
X-Google-Smtp-Source: AMsMyM6Y8BHaTxpKC3+y7aNMMafxwUeuPTV+1RsXNTbJ5WRdyKZ1SEUEI2x/iSmivD4aQQsPUabBFA==
X-Received: by 2002:a6b:5f16:0:b0:6bc:132:5b60 with SMTP id t22-20020a6b5f16000000b006bc01325b60mr5264501iob.65.1666040787338;
        Mon, 17 Oct 2022 14:06:27 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id t69-20020a025448000000b00363455b779csm314118jaa.159.2022.10.17.14.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:06:26 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH v5 0/3] SDM670 GPI DMA support
Date:   Mon, 17 Oct 2022 17:06:22 -0400
Message-Id: <20221017210622.3498-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007213640.85469-1-mailingradian@gmail.com>
References: 
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

> Changes since v4:
>  - drop dts patch (to be sent separately)

Hmm, [1] still includes it. Maybe it doesn't make sense to do this, and maybe
I should split the dts patch.

[1] https://lore.kernel.org/linux-arm-msm/20221015140447.55221-1-krzysztof.kozlowski@linaro.org/T/

>  - accumulate review tags
> 
> Changes since v3:
>  - keep other compatible strings in driver and add comment
>  - accumulate review tags
> 
> Changes since v2:
>  - change fallback to sdm845 compat string (and keep compat string in
>    driver)
>  - fallback now only affects two SoCs + SDM670
> 
> Changes since v1:
>  - add fallback compatible
> 
> This patch series adds the compatible string for GPI DMA, needed for the
> GENI interface, on Snapdragon 670.
> 
> Richard Acayan (3):
>   dt-bindings: dma: qcom: gpi: add fallback compatible
>   dt-bindings: dma: qcom: gpi: add compatible for sdm670
>   dmaengine: qcom: deprecate redundant of_device_id entries
> 
>  .../devicetree/bindings/dma/qcom,gpi.yaml     | 22 ++++++++++++-------
>  drivers/dma/qcom/gpi.c                        |  4 ++++
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> -- 
> 2.38.0
> 
