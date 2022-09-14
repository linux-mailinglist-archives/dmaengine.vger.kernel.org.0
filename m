Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE97A5B89DE
	for <lists+dmaengine@lfdr.de>; Wed, 14 Sep 2022 16:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiINOGW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Sep 2022 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiINOGB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Sep 2022 10:06:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C40286C5;
        Wed, 14 Sep 2022 07:04:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bj12so34892370ejb.13;
        Wed, 14 Sep 2022 07:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=02TavS8mINTMVN78q0QlG4Xhc4w7Y+6RhEJOvF39px4=;
        b=MCF9LBW0gHOs74aOZASWgcLENiamte2K9CdwIM0whMEYmFNVjEjzhwh4Ws0XwmhL4y
         HbutLuCf1DaD6NEOdjI37XqfcpxyS0Ll6PXEBql0Z9TBh8AmeYLD7aE8VYrgLhw69a24
         ihh/U99uWU/a6DuPWR7HyYtsCZy2LRtvGQBK3yXcTbQMBZPzgiyWUFoe+Ctr2F+jfMbV
         ApiV5U4qwArHq056TxlH64tRFE6i7eAI1/py8S5Yvzf83o48bgNbEROjB2CoPG7DQ6Aq
         BpFpG0fSqTOjEI3J1R+RbNjxjndkvC+bBqm9ofo9mBq8tgbv4u02mEdHh7ikzqaLcPBg
         pJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=02TavS8mINTMVN78q0QlG4Xhc4w7Y+6RhEJOvF39px4=;
        b=1gj/FmxPy9GLv0E6Bw23s1doXQEKJrSqi3O2UYOdjD6eJuCU02rT8vuQaw7ecBpUCB
         I1l9Wjo9SeGax2jIiRydAO0Cw2pQV1FpjAU6Bp90jMeDahMBTvgE4E5heHz9QB6N/xxK
         zajWfdVJWeuN/1ElgR/u3kV6AQl1LqXvbHdOm0gQ89SgcQYNEr8NgcxPWz0qnYQ4QpGl
         B0RKu7FA9mTIieNrLZLzSDNQ2dr/wWwW56lrfGSmCPEamhr5Hscb9kpWyvwkaNug0joF
         zK9JSKqOTD+/Y8ExPKECcA2IcYrh+W5W8+PxSpcSGSGk5DmNSRrVzWs/LDgG9uSdAPzw
         2BDw==
X-Gm-Message-State: ACgBeo2vKSet+TrP7bmUSDmPEEujEo0jxb3RcUT7j2JysT+xSKUJnMw6
        YTwuILVudfqza2VUeuLahuo=
X-Google-Smtp-Source: AA6agR4C5L8yKcAo75mmo5Zjm3a2SRTK4yfQ8bdXQQNDHTGg2bOsDK1XwnhbxBV/Og7ERmBFGhApNQ==
X-Received: by 2002:a17:906:fd85:b0:77b:b538:6472 with SMTP id xa5-20020a170906fd8500b0077bb5386472mr13649003ejb.48.1663164279850;
        Wed, 14 Sep 2022 07:04:39 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id i10-20020a1709061e4a00b0073dba2d9f99sm7560296ejj.128.2022.09.14.07.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:04:39 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: dma: add additional pbus reset to qcom,adm
Date:   Wed, 14 Sep 2022 16:04:26 +0200
Message-Id: <20220914140426.7609-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914140426.7609-1-ansuelsmth@gmail.com>
References: <20220914140426.7609-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

qcom,adm require an additional reset for the pbus line. Add this missing
reset to match the current implementation on ipq806x.dtsi.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/dma/qcom,adm.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,adm.yaml b/Documentation/devicetree/bindings/dma/qcom,adm.yaml
index 6c08245bf5d5..6a9d7bc74aff 100644
--- a/Documentation/devicetree/bindings/dma/qcom,adm.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,adm.yaml
@@ -40,6 +40,7 @@ properties:
   resets:
     items:
       - description: phandle to the clk reset
+      - description: phandle to the pbus reset
       - description: phandle to the c0 reset
       - description: phandle to the c1 reset
       - description: phandle to the c2 reset
@@ -47,6 +48,7 @@ properties:
   reset-names:
     items:
       - const: clk
+      - const: pbus
       - const: c0
       - const: c1
       - const: c2
@@ -86,10 +88,11 @@ examples:
         clock-names = "core", "iface";
 
         resets = <&gcc ADM0_RESET>,
+                  <&gcc ADM0_PBUS_RESET>,
                   <&gcc ADM0_C0_RESET>,
                   <&gcc ADM0_C1_RESET>,
                   <&gcc ADM0_C2_RESET>;
-        reset-names = "clk", "c0", "c1", "c2";
+        reset-names = "clk", "pbus", "c0", "c1", "c2";
         qcom,ee = <0>;
     };
 
-- 
2.37.2

