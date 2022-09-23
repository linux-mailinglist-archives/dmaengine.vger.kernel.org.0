Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FABF5E84A0
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 23:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiIWVJu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 17:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiIWVJt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 17:09:49 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF11AF20;
        Fri, 23 Sep 2022 14:09:47 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d8so895530iof.11;
        Fri, 23 Sep 2022 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=C2BdUYf5Q3qgdeRFaSwEnqK2NV19YSZcp++8KlXdTLs=;
        b=DqBa6r1gzi3C1npKx+Hz6wMVKZ9k/2ZnOi9/UxTObwUXIKXdEGdZ2RCDtjvKariJKT
         0ctisO8Rou1ZNGxr0n1bDtlHFMee+o15Pm0mD+iHE1b4WbC8YwJrpEWU4BnO/5Ehg/o2
         L+wS3RpN/6ffKDNWLQRbswBsSSiMSRNqSYUe31xcADgO29s15+Prz9W4EMXZOTxIHAne
         yiaps8lft8Iufn/vnM18XCjKw/vfh2MeEsdn13BOhk242UwFAZhOste0h8DxPUwJG7cJ
         GL4a94dYv9eKHLxOK6r6y7VYz1j+uJt/HApGZrIHInmZv/f0zv7fi9j8FiU+BMhiHfjs
         Hmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=C2BdUYf5Q3qgdeRFaSwEnqK2NV19YSZcp++8KlXdTLs=;
        b=JrL7HsYw8RdkO0Si3LTQdycOH8j5yIqSZwK57gzevUt27Bx6eXkRzw85dIJfVGzzKs
         c0aSrwAzhCPN6pt4y50NYTT/T2Nxi4j3JW6woZaF1fu575VpuMSDbHlfiiKrOAtLEMao
         5EuphwFWPQPX2B1bofccHVYjfyQa/cdYUylcwPmU+wa/IdBLNRX4S8R5zh2qbfBFyqtf
         rnB+9+YJa5F4PdZQHQ3DdcXhNyCIhnDOTVbcWbt8HE2K3R7TjUdpb68AEmNo+pDc6MCS
         eI7qRMv6LcVhChMXcpw8QFQMwGMIbHOyrVk681S0O2McDKFxJisJdm+kemOPLYqHNMmI
         d22w==
X-Gm-Message-State: ACrzQf2AdD3Iq0wNc3HlRykhiaSzMW8eKvGENbzMjTcGV/tq7TQAUm3R
        jssfx5siWP+scB8JRZmDXyacNDd3puQ=
X-Google-Smtp-Source: AMsMyM5rEPDMrc91frTACfQZwsBWytq9ZOTLBWS5E4n1LFGskjKBR9Z0ZmBuqnlihZqhJOGtML6cmA==
X-Received: by 2002:a05:6602:26d5:b0:68a:db5d:2923 with SMTP id g21-20020a05660226d500b0068adb5d2923mr4821277ioo.175.1663967387035;
        Fri, 23 Sep 2022 14:09:47 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id k20-20020a023354000000b0034c12270863sm3810114jak.80.2022.09.23.14.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 14:09:46 -0700 (PDT)
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
Subject: [PATCH v2 4/4] dmaengine: qcom: gpi: drop redundant of_device_id entries
Date:   Fri, 23 Sep 2022 17:09:34 -0400
Message-Id: <20220923210934.280034-5-mailingradian@gmail.com>
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

The drivers are transitioning from matching against lists of specific
compatible strings to matching against smaller lists of more generic
compatible strings. Continue the transition in the GPI DMA driver.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/dma/qcom/gpi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 89839864b4ec..f38c3d6ef11e 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2286,11 +2286,9 @@ static int gpi_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id gpi_of_match[] = {
+	{ .compatible = "qcom,gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
-	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
-	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
-	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sm8450-gpi-dma", .data = (void *)0x10000 },
 	{ },
-- 
2.37.3

