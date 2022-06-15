Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6517D54D589
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 01:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349472AbiFOXyH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 19:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348951AbiFOXyG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 19:54:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CF13DDE1;
        Wed, 15 Jun 2022 16:54:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s1so17283474wra.9;
        Wed, 15 Jun 2022 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IMHxQtKFSGIpi4Dt5QYvqjxFJ6KAEK/ElIU+ikKEqhE=;
        b=L5nBjPJp8jqFfZbco081UO/HoB5IGYIHUvQAwTP6PKLl5vmXE95g9QuVSyuzDK5pxM
         dkJv+PtS2lN2fsn8PrRmUWnnj9uB96Pb+oII2EE88skQvY2zTA4DRp1U6S/pkfEUqz+b
         3YcXZ/91Q81pw1xunyLFid+dlYNW240z3EevxA742sejKy9XflO80V6iGVfc6arOhM1P
         al6aWL7W6/XgL/NnhSw4bUND8UubdJsy0bfitbKwuXFQay66RAZ7dfMShi0elJA5+oDI
         iMx6/qGc2gisUKc8cPMjPtD0Mae52ZCvNvG1rZJwj6etQau3e4gKCnbU2FDWUvNEg4EL
         zwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IMHxQtKFSGIpi4Dt5QYvqjxFJ6KAEK/ElIU+ikKEqhE=;
        b=lJVQdQjfbko4IIIR51nQBG396Q0wOhqBkLmbm5VT/5/5bu5bIDuCez69p3BQpK+Djw
         74nMdmtWJn1tltiA7JFQzvUTkHvlJw9LjauNUYBDDGJtxT8bTqePpVpjyKhzKlXDKWcZ
         hG0NPsjTzBePc2XYgt/e5qwizGaP6z4gdMCFHLG6J+v+bA+EN5tipnT8u/F57Eogdw97
         aKrp/A0enBnaUip+1aAptXcH8SgROhYFZfHLVR6dpisqLk+CZNwwoxqjTw/OeCyAWy9h
         LTEzyyCZm/rBbNl6Rqn9omh3Ac9PcU147c5KN+eEVUdNuqnLaMl14oNS/Iev7rumZVca
         6EHQ==
X-Gm-Message-State: AJIora86mLUzney/evOFRkqLo5sm9RgvBmMuZnLNNzf/tfAZ8jT6vEBL
        C085oc72c5rq5tQlOw5mbUs=
X-Google-Smtp-Source: AGRyM1u+muYBxk6COENUiNTsry2J4I3tggp+r+ALtyQl220gcSGcga8Z9a71T7GCGQMPWBCC9Hy9gg==
X-Received: by 2002:adf:ed92:0:b0:217:2e17:9219 with SMTP id c18-20020adfed92000000b002172e179219mr1960086wro.195.1655337243508;
        Wed, 15 Jun 2022 16:54:03 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id x1-20020adff0c1000000b002103cfd2fbasm268116wro.65.2022.06.15.16.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:54:03 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: dma: add additional pbus reset to qcom,adm
Date:   Thu, 16 Jun 2022 01:54:04 +0200
Message-Id: <20220615235404.3457-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615235404.3457-1-ansuelsmth@gmail.com>
References: <20220615235404.3457-1-ansuelsmth@gmail.com>
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
2.36.1

