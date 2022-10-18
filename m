Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9ED602002
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 02:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiJRA56 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 20:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRA5y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 20:57:54 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1331D0C2;
        Mon, 17 Oct 2022 17:57:53 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id r20so6728822ilt.11;
        Mon, 17 Oct 2022 17:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGOddrq1TbXskC3V91ACaoVHHWqz1fTHGtmIS0OMGxo=;
        b=CLGCojXqZmCoaPCSXvRCY7RIPqH3jEUujb9XKOjjOgVR1DW19cWsgoYOM51sO5v837
         qqHQ/0+k9EIVC7l7GgSH/ys3aUfbc2LgWjlEXMGw/ZnpiYzzT+mkfNLnC6XJg+Wj5glW
         qKKBicP9trPJSrwCxOe0kpniIZ5aHM3layg42Ybt9t4QvjNp9uCrQk3s4VIlh5GYt+WF
         cWYW1iOyO5S7ACBhgKDXgX/jwSDmhtG0NVx8IgyULjqFLRkOvd2wOq+qV+tZWzp0BCtv
         J9fluRkbBGAlYbEcM14XcbBvsUBchMaFqcQJMGDNO+SvUUJrnu+KTmSIiA2O/VvowgEM
         yF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGOddrq1TbXskC3V91ACaoVHHWqz1fTHGtmIS0OMGxo=;
        b=KaTLQztEcR0892yfytjMS2tUWlpIButC9lm65tDHrmV8BtVOpKWgDWstT1yZNnKDF6
         3IO/4BegjF2w8KI8iKz+RgmLfuvluvrZUL4jbGh3x3g4Fip/dx27ZIDCtX/aQOwGhJti
         jguGJnEcCyQ8IyyKqaYRle3QFBgJ02qKRz3P/gxeYzd9L2sdQsyxK/t4eg2eLfm4PzqY
         PoFVU9Bv6AvYaZLUa+I4UFRp7owPTv64aXhFMp+J7h1NyZDUBSTvikkS1TA27gZRfMCt
         Gq7XoXdCNLXGIFYKo+8O3an31dgKO9NJk5Y9Nb0Ugdt711GvkABIHXnm3AF+Z1MZCznS
         SQ2g==
X-Gm-Message-State: ACrzQf2kkpD2wC0YpVrJbl3PLLKNN2/PWejDn6WYHTn57jt8eR9U08sT
        PkI2P7aRSbw9rBR0CL6Sp4fUDm/wJTZG8A==
X-Google-Smtp-Source: AMsMyM6AuqTWbaNOyfzzdk772AjJbIyEd/v0DjfF6ulv6ryWvMpNIJN081MC38nHI8CrobyKHs76EA==
X-Received: by 2002:a92:ab01:0:b0:2fc:405a:d055 with SMTP id v1-20020a92ab01000000b002fc405ad055mr563624ilh.94.1666054672575;
        Mon, 17 Oct 2022 17:57:52 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id a20-20020a921a14000000b002f139ba4135sm439828ila.86.2022.10.17.17.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 17:57:52 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 2/4] dt-bindings: dma: qcom: gpi: add compatible for sdm670
Date:   Mon, 17 Oct 2022 20:57:38 -0400
Message-Id: <20221018005740.23952-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018005740.23952-1-mailingradian@gmail.com>
References: <20221018005740.23952-1-mailingradian@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 182b8573230d..6f7dcae944e4 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,sm8450-gpi-dma
       - items:
           - enum:
+              - qcom,sdm670-gpi-dma
               - qcom,sm8150-gpi-dma
               - qcom,sm8250-gpi-dma
           - const: qcom,sdm845-gpi-dma
-- 
2.38.0

