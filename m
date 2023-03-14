Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE9F6B9563
	for <lists+dmaengine@lfdr.de>; Tue, 14 Mar 2023 14:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjCNNFk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Mar 2023 09:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjCNNFT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Mar 2023 09:05:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BCEA72BA
        for <dmaengine@vger.kernel.org>; Tue, 14 Mar 2023 06:01:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p16so10236045wmq.5
        for <dmaengine@vger.kernel.org>; Tue, 14 Mar 2023 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678798879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H57htoQkTUg+UFTR1sq6q65W74NoULtO9Zp7Ye5hgiA=;
        b=nIt5lEa22Qb3b/ZAOTsiUpaVZd2t7zIXM4DJqkLZ/6EdL1aQcKDbEqlGvUrbfsYrfm
         ipctzCvWw+MUZXoH3l3ko6SRMFu4mqQSqmSikeBkYCcBOWYWQQUpzhfys1i9Sls7zFbV
         pRVQta1gWbzOCJi0MdP1V4UjPbtyMq4Adfga5wKnIcJQUVO9V/zjfcx5ZskdfOzyX58g
         jZuukc0azuCdRzMJAtAzVkLbcAKL+3pbZ5/80UXYBkcekYBRFhFMiwNsWl/udclDhk6y
         eL/SVJz1b36N4LS9deuFAIAek6RY1Ub1xUMSl9A9iisM4yF7cBRQrJHaqLmeN12fJMYP
         U4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678798879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H57htoQkTUg+UFTR1sq6q65W74NoULtO9Zp7Ye5hgiA=;
        b=oXmRzDQzKGuq7M72PLQMktKjuExMdPdgvcDO0sMbHPOnY8OT9RoRecmpdzzchiXtPP
         6dhiszypulAN6Doh/xXw0qt/QSbIFjlKgKdHDp6BvRIulVdXfa0Ue8EKhP0uXypvB8jq
         J7xsTeaJRU6s/7UAXcMNiP/TC/HITu2vROAOyJuoifPlAAaRglnforZEhd49OFW4avxC
         6pWySLd6ctDvoYg+ZbjD9eB+M4CstOspaX6twiB2x3l8uE0vzCU8Sja55zFOrQ1+FoMN
         NPIgZeamPKgYMg+Wn/tv+vNQ2SHhKDgUUgooh0N6UkNhQQrY6rrBhHaGb4XYzCPiSvRz
         8jjA==
X-Gm-Message-State: AO0yUKWZhjy/kPOjeF7eebiJaKGxd4lvSy0MlWhph7mgOjN4/Htp2OGW
        wt7FJAnPJ/3IXCqGeOOSESYoscITrlca5xwra5I=
X-Google-Smtp-Source: AK7set+LGzXnfPO9yxrQ7i+5lJWHJr8ilHoSFFsG62K03rnONrPIjtofPyo8KNV4If/IrFwW1hAinw==
X-Received: by 2002:ac2:53a6:0:b0:4dd:749b:2d5e with SMTP id j6-20020ac253a6000000b004dd749b2d5emr658238lfh.13.1678798389023;
        Tue, 14 Mar 2023 05:53:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm395374lfd.68.2023.03.14.05.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:53:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 13:52:56 +0100
Subject: [PATCH 1/6] dt-bindings: watchdog: qcom-wdt: add QCM2290
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-2290_compats-v1-1-47e26c3c0365@linaro.org>
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678798384; l=804;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5U3ca5wHa6L9Uqd71BtW3lQI84JxQ8icLuw8PMs5taA=;
 b=NtWhoOCxoiWQoOdiz2KumOaoFLzyepdvtefGrM6rQG0T+1vcJphHx4O58b5FRFhG29N0R0ZWIcA/
 csWPf2qLAUZbDFmWgOGLjLq3J5a5lAJMwSgks6lRLLJeqrPATjUS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document the QCM2290 KPSS watchdog.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 6448b633c970..db3e260fb2ef 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -19,6 +19,7 @@ properties:
           - enum:
               - qcom,kpss-wdt-ipq4019
               - qcom,apss-wdt-msm8994
+              - qcom,apss-wdt-qcm2290
               - qcom,apss-wdt-qcs404
               - qcom,apss-wdt-sa8775p
               - qcom,apss-wdt-sc7180

-- 
2.39.2

