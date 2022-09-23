Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281ED5E849D
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 23:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiIWVJt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 17:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiIWVJq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 17:09:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80BBF590;
        Fri, 23 Sep 2022 14:09:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p202so916896iod.6;
        Fri, 23 Sep 2022 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FQuCkSBJtehCIFomFirxSqESVrtox6RTz8WxwEmFExk=;
        b=hkNxe4g1EMgbUALSZYuGcOq/No6cFk2sHZCCEFloIWiV8diS279DoPQzNcMi/yAP/h
         S+L8ugBcjExIb9FhyaVEpcAVGbo+55Ifkwm+1Art+mlPRFhUJ3reDWsEcBEshIzM8opp
         ibmAxsEi0P34i/l2rTUPcTksD/EOSumXqWOjDYk23CUWTMIxTsc+v9qa3xcofufLDewW
         R3VoKLnZLMS+EOioWCECg5vKQ8dW9TOxw2di2X4YK46s5WJojcaEl+gjzslEes/NTTYU
         nrqpgJYR7wBKj11/AbdgwPCMh58fI3B4NKzB98f5ZeBWDJr+QDZmGfcvgGdRQcwB29gm
         61Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FQuCkSBJtehCIFomFirxSqESVrtox6RTz8WxwEmFExk=;
        b=HgNUT86HcSspzHqNohxvtdXKQaVs+ZwdpkS3NqBOXYvLuaACf/PoMQPIi//+An1T3s
         JmhJgiQAEC7PW6afOlkAhkrQcjZkgl/fPmv0v7zjON56JnlI1TkAy5iglHxQYEM10ZNx
         xePFddXByutUlr3Hro8XDBTceasIU+NTsht5XbnvnEzmudrHm2wg76c1PnA1/3H9cHFZ
         l9Kf0fBJKvB9pxObD0ZVBeNxWuwp0/eJppTyfTsGGoRUjYMWVZIS97OG3Bk4xsxOXKJY
         R1wz/OBEROVX3Hn9vn5DkwyS3VABCU00XVQd+auP8B/M9bRQVU517LgnIf/dkvKrIQpZ
         n2xw==
X-Gm-Message-State: ACrzQf3Zn3qofc4Qvk/UNX/jPEYN78upHlyugs+omGqPUwf761dgnJ1L
        HNJOUB8AgqSkD+Frqt0w5LNkV92280s=
X-Google-Smtp-Source: AMsMyM59IG79O6PnrQ/pZpoqbNyRv4vDLjCRj8lS+xQvwR9hZVr7gKiKTKpZnDJtwH8ZD2AlMvNgfg==
X-Received: by 2002:a05:6638:248f:b0:358:4319:69e8 with SMTP id x15-20020a056638248f00b00358431969e8mr5703239jat.30.1663967382211;
        Fri, 23 Sep 2022 14:09:42 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id k13-20020a02cb4d000000b0035a578870a4sm3781543jap.129.2022.09.23.14.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 14:09:41 -0700 (PDT)
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
Subject: [PATCH v2 2/4] dt-bindings: dma: qcom: gpi: add compatible for sdm670
Date:   Fri, 23 Sep 2022 17:09:32 -0400
Message-Id: <20220923210934.280034-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220923210934.280034-1-mailingradian@gmail.com>
References: <20220923210934.280034-1-mailingradian@gmail.com>
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

The Snapdragon 670 uses GPI DMA for its GENI interface. Add a compatible
string for it in the documentation.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 25bc1a6de794..6be3c99a73ec 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     - enum:
         - qcom,sc7280-gpi-dma
+        - qcom,sdm670-gpi-dma
         - qcom,sdm845-gpi-dma
         - qcom,sm6350-gpi-dma
         - qcom,sm8150-gpi-dma
-- 
2.37.3

