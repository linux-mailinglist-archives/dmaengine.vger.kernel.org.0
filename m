Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2205F1FC4
	for <lists+dmaengine@lfdr.de>; Sat,  1 Oct 2022 23:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJAVTv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Oct 2022 17:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJAVTt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Oct 2022 17:19:49 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2EA18E12;
        Sat,  1 Oct 2022 14:19:48 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p202so5733587iod.6;
        Sat, 01 Oct 2022 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ncWXTlDofAnH4a6zbZXsucgF01Ea2LS/bTNTYDPAZe8=;
        b=IP3Az7IU4h2FlVb8Izvh64cUIFCzb0bDD3o9TuJUjJxU7R5qOb9hrFgRfwghvNNMaM
         UXdEYY+9op2uW3vLidX4+Ilwh53PzbY/s0UaBENC5RDKktC8fjQMcC3o8EzMLAeutw46
         OCTag8HHRff5GYYhn7WI0ZD0RafcsPJV8oCHKEm9V8gxjhnmPfiAaWELtMl+AA8GemMd
         shtUFH4K5SXmcHKGuG7o4WLL7O7u80UOgh1DedZqvO1TIZRRAMeFYlXz/yRlOyxXwkq7
         fO+cHWwMLPgsisn3TZLXrXKQof1zYuxpnOCAtioGkZAv45qy86X3JRtQ2ol6J1wc5CYk
         SpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ncWXTlDofAnH4a6zbZXsucgF01Ea2LS/bTNTYDPAZe8=;
        b=XHPG63uqnM9/7rtJ56/5QiWpV1ji+QZv+O0wHX8JNCDEY2h1I+i/wp6G2YBeTXagit
         pgJnSKfLBiiu/9K/2Wm4jMMmkNAGQEJJIJp5r2eXwGxpdE+0Ul+VsaCFH5UDWQF57LYd
         EGMHGuvM/GGrFPvbh/1BZxkaz1PEIAo9P7Y+2ZJovYxvZOlTIvL8SO8b/Oy7xZQtJbjP
         /yTkvsc3476etAEAvjFx7iwWBHdyD3nIa5SWbcWNseg0DBXZUz9JRY59jJxScDoXOOQW
         +ta11fzhz0DmelTLDAJdijUTgkUuwGCBu9/vpBaKcnR706ejT2qcTFAxMSk5UuiqS4pj
         Zj8Q==
X-Gm-Message-State: ACrzQf2Oa3iRIPSmu886bYe6amVBKo55MgX4PsJI2yCaf4fazF2Ta6XJ
        UvlX9XV5ldbaVpX31lULuZ4lgjG5qR9ttA==
X-Google-Smtp-Source: AMsMyM69qdc7SEZY+JRhEYOQKmIp6dl21M+u+kB9e9kTiLfjsSFUMbBWugKcjeSi/D3zbQJeqqtayA==
X-Received: by 2002:a05:6638:1a1b:b0:35a:ce31:2e2b with SMTP id cd27-20020a0566381a1b00b0035ace312e2bmr7498793jab.289.1664659186536;
        Sat, 01 Oct 2022 14:19:46 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id l28-20020a02665c000000b00356744215f6sm2393731jaf.47.2022.10.01.14.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 14:19:46 -0700 (PDT)
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
Subject: [PATCH v4 4/4] dmaengine: qcom: deprecate redundant of_device_id entries
Date:   Sat,  1 Oct 2022 17:19:34 -0400
Message-Id: <20221001211934.62511-5-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001211934.62511-1-mailingradian@gmail.com>
References: <20221001211934.62511-1-mailingradian@gmail.com>
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
2.37.3

