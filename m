Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330F05F801F
	for <lists+dmaengine@lfdr.de>; Fri,  7 Oct 2022 23:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJGVgy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Oct 2022 17:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJGVgw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Oct 2022 17:36:52 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1F310325D;
        Fri,  7 Oct 2022 14:36:52 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h74so668279iof.0;
        Fri, 07 Oct 2022 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXa0o6AJijj8nZh92TnYExxwyBjBOTqBx3x8YowQqdc=;
        b=ea4IhKNWGm6cnuAUG5tIY3qjDwSZ2lm8gHCkZ60vR7UTmBD8UNci4ZgfwP8r0TiEPh
         AdWjw3KNDQ197dflei/W2m0E9DG7mpVtONT9NKVq0GJvJBWsUuObneqySMBKFwBZq/cJ
         0U5pUmSdavO4fslNI0MNHUKSjxPd7TpDOp5KvSfiG9o3dAC1vbyD2BYyJ8tnfAeGrI6V
         oEukdu0NG6FcbWXPv2B2vE4VssgBUTowtmY1JW38/KYdxoHqh1ASwc4UCtwEZG2YDCww
         jhMRaAYI47t3yjivaiNJa7rMvL82QE4x2e69+Axs7XzN7UGdvmbuX3un7OHe/LjpZUgM
         i87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXa0o6AJijj8nZh92TnYExxwyBjBOTqBx3x8YowQqdc=;
        b=N282GrhEsZ88//FYoQhUeSvR7qkIWgV2FSXTETKRNerNw5IPLh6FL/6BWv8fEaOlhi
         XJRy6znS9CPdHWBII+HzgDBIP05STHj3RxH6sXs3Rs/YTwWjxj9V8oXzDGyBvw4b235t
         Y+iHTui8B3/A6bxChiUmdO2C0zs8S8OKr+4CHD8Hw7C91e4dVlogU4hZHqmc96MzEePG
         yTumPqktS7UmbrMAanYT78L3qZxgmaxNkkEu07vFhrm8wL59l75akAz7pcFZz2RIxea/
         PmU1lB9bESI/Y+j4WNZc0ET/ELVx/cH4L531/LgH9qHNCCs7qGKU7aZnRi9e7MvAII+u
         dQTg==
X-Gm-Message-State: ACrzQf0lefD9fWC6mgDvPRKsOxzki337ahUv5MekymldAAs6T98HnM2k
        h1oBBHFnoOXcy+jK/eaWK4wfIfD5MSALig==
X-Google-Smtp-Source: AMsMyM7gLUUuKzzn2ZHTqwpvq5obp2MUcZfUKJ2G2oHtqIjJTOq89eQVFSc3ULp+OeU9fyuv4aHL5A==
X-Received: by 2002:a05:6638:3452:b0:363:69f8:549f with SMTP id q18-20020a056638345200b0036369f8549fmr3777255jav.190.1665178611692;
        Fri, 07 Oct 2022 14:36:51 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::b714])
        by smtp.gmail.com with UTF8SMTPSA id r11-20020a92d44b000000b002f6028e31cesm1276491ilm.61.2022.10.07.14.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 14:36:51 -0700 (PDT)
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
Subject: [PATCH v5 3/3] dmaengine: qcom: deprecate redundant of_device_id entries
Date:   Fri,  7 Oct 2022 17:36:40 -0400
Message-Id: <20221007213640.85469-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007213640.85469-1-mailingradian@gmail.com>
References: <20221007213640.85469-1-mailingradian@gmail.com>
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

The drivers are transitioning from matching against lists of specific
compatible strings to matching against smaller lists of more generic
compatible strings. Add a message that the compatible strings with an
ee_offset of 0 are deprecated except for the SDM845 compatible string.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/qcom/gpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 89839864b4ec..ff22f5725ded 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2289,6 +2289,10 @@ static const struct of_device_id gpi_of_match[] = {
 	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
+	/*
+	 * Deprecated, devices with ee_offset = 0 should use sdm845-gpi-dma as
+	 * fallback and not need their own entries here.
+	 */
 	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
-- 
2.38.0

