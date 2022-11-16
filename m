Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ED062B800
	for <lists+dmaengine@lfdr.de>; Wed, 16 Nov 2022 11:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbiKPK0O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Nov 2022 05:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiKPKZp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Nov 2022 05:25:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EC7F28
        for <dmaengine@vger.kernel.org>; Wed, 16 Nov 2022 02:23:29 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d9so24413753wrm.13
        for <dmaengine@vger.kernel.org>; Wed, 16 Nov 2022 02:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvE5SovEDJCGF/rawmWEv+LBNoAcghIphpP6V/P6V0A=;
        b=fltpn0kAZk73fsa6sh+pSvQk1/yfT+g4cRlZgJncX7GlU7W1j178/oQzUHZjST8sC2
         YC3Bya1IBgqvQ7frC5sYX3gKFxyb291EssE6REMN9KGKaHsM0+rp8V1m3ndZS0+UVZ8a
         LJ5aDTtuBLJt8SNDCCbiNgpgAzP08yWrUL3Qtm7ecFyi/IP9cE+Ap2cnsEW/jL0eU0fw
         aZJhbZk2Fry6VpXaWCge6fS6J9TAGUR5mSbiGBcHiq8HPda76b/RRztBctyA/wFiTKWp
         NyQ7RxX9RiHMj6hDa8werbvZxNDBzZNKgnjUhfSSk7wF3bqbFCh2oKJ3AWMe/858m42b
         bYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvE5SovEDJCGF/rawmWEv+LBNoAcghIphpP6V/P6V0A=;
        b=V+0ZcLwMzAjMF3yq/puaaNH0rKrVdTfmXL3PxJU++Iiwgh2+WqFRlggpLZ91q9lWYf
         //OKmMTLDHQpCgnMLE145rK1mKP4qgi3CLqXB1Ab9f8DrZFNL/mqvW8ZPWm+8UBUfoBm
         5BUfDV21Khw8ghOKzXvlZvy4H48xszftbeVhwxhRgomnDwIN75HX52AlnbhovmHbRIxe
         0WWe3DbLAblzy3G6j52Mgj/POvE41trUATTA3FONR/OSEGbWjULRw9N6FvN9r9jsNUqU
         McSzx1vBPyjBHMbW9okYLVJ7C0QH73uO1NZwWOQV09ppj6yp3dDZNdnxeezbukZrZIKS
         1IQw==
X-Gm-Message-State: ANoB5pl4E0DtUltMEW3j3kS+GiuXY5j5OJzWD7ydxDwcFb6LB3YHoI/c
        g0rymAFTn9lk03TofjK//txmuA==
X-Google-Smtp-Source: AA0mqf5v4bQjBjkLpiFWrtD7U4f1kmffpiBLeWwKJC8c5qO7nx54jMdrGd+eCWZfA45L4eymlZiL0A==
X-Received: by 2002:a5d:514b:0:b0:236:7921:e10e with SMTP id u11-20020a5d514b000000b002367921e10emr13159994wrt.61.1668594190881;
        Wed, 16 Nov 2022 02:23:10 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id i9-20020adfefc9000000b00228dbf15072sm14927047wrp.62.2022.11.16.02.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:23:10 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:23:08 +0100
Subject: [PATCH 1/4] dt-bindings: dma: qcom,bam-dma: Add 'interconnects' and
 'interconnect-names'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-qce-v1-1-31b489d5690a@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-qce-v1-0-31b489d5690a@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-qce-v1-0-31b489d5690a@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

Add 'interconnects' and 'interconnect-names' as optional properties
to the device-tree binding documentation for BAM DMA IP.

These properties describe the interconnect path between BAM and main
memory and the interconnect type respectively.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 003098caf709..ce8bbb2de4c5 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -36,6 +36,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  interconnects:
+    maxItems: 1
+    description:
+      Interconnect path between bam and main memory.
+
+  interconnect-names:
+    const: memory
+
   iommus:
     minItems: 1
     maxItems: 4

-- 
b4 0.10.1
