Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB9602004
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 02:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJRA57 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 20:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiJRA54 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 20:57:56 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52294C69;
        Mon, 17 Oct 2022 17:57:55 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e15so10601089iof.2;
        Mon, 17 Oct 2022 17:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QBx5zTfd1/9FdJudjZY/fTZb6pFRjHo6c21xxNtQyQ=;
        b=pffSwFUMaosOp6G6zQxgMPiRHJ1wsElsURTaJKnlg15EnsBpjRYkKpsQpR3jBNHPr5
         n6vfTy9p6XydEfnrrMH7tWvIfu+Lod/s5JgWX/RU0brFLJ9p28KI2sKbmokM2kH+PXnJ
         ZUcikY4vuq6/VhLN0qzEcD0s3B64vW0DyfBa1e6gBbfOUXKHuSbskUlj0vHa1PxHatYu
         yed67lXonmBl2GvhIzOhnZTEfKzPH+chtPDlTCv0qcpgD48Bf4cHpNcK2imabxsljD64
         fqjww27PM9sPckTMIJ05r0UWqCuNPPufsdocRTk4OkK4oAvZfB28ZRIaM2I51VorGupD
         RsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QBx5zTfd1/9FdJudjZY/fTZb6pFRjHo6c21xxNtQyQ=;
        b=BAUgl9H4zbw1BZHU8ypIU4hT44U3XwRQbes8oZZ8KZijkFU/DIvoxnNDkPGEQJiIIs
         ApjztYwhCDAZplTvG0tTLeCH3LSyHw9KhVHlFswULhcF+Csx3WjsyD20UXBz9pZugYBg
         114B4/KI0kF69NNzA4y7FKeaSzXHx805iBwcQdSMYGjkPVST5RFbBvR3fs8niSZT+u24
         I0fQ8ftFxqufG8FEvmC9FkH7BBXyyOTMSBRfSE6H7lKbcqyDfhsmCw72+9tNf/T7DW0+
         LOYxUiujQCJ/og07F1MLhFFMeTALBLrqbHqlWsPirv/f+8Cn5Lh4yebifcVy13F0I0gl
         Oqjg==
X-Gm-Message-State: ACrzQf19NiKRL+Hs9DLQFYYX+VK/saWJVAqEwSvAKdljsj7vRrV5Y9MI
        Hqqk2yeqHOYegxxsvoAgzgz0BOkEmIxvpw==
X-Google-Smtp-Source: AMsMyM42Njvo/h/1AZoqpg6xbOb9y8DCZ6AYtZ2fapsxq8bcznRSsDsTSa2K5cSf//fn9xQ/4gadTQ==
X-Received: by 2002:a6b:6f02:0:b0:6bc:15d8:3446 with SMTP id k2-20020a6b6f02000000b006bc15d83446mr518872ioc.108.1666054674448;
        Mon, 17 Oct 2022 17:57:54 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id ay33-20020a5d9da1000000b0067ba7abc4cesm463099iob.50.2022.10.17.17.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 17:57:53 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 3/4] dmaengine: qcom: deprecate redundant of_device_id entries
Date:   Mon, 17 Oct 2022 20:57:39 -0400
Message-Id: <20221018005740.23952-4-mailingradian@gmail.com>
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
index 3f56514bbef8..f8e19e6e6117 100644
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

