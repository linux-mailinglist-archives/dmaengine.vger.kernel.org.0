Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579C05FF630
	for <lists+dmaengine@lfdr.de>; Sat, 15 Oct 2022 00:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJNWNB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Oct 2022 18:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiJNWMg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Oct 2022 18:12:36 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78B11CC779;
        Fri, 14 Oct 2022 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665785531; x=1697321531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DI7qluMmvdU6Xy+i5dPa+KBhMy+MAaoUFY3q3I6UluU=;
  b=E38Qccl/nl9ypIHVIEoCZX4sW3wXBaAM2qSy3v0ey9rqtq5EZPJbdHDJ
   FTzH7r0wKQtX9jvBFflxHt9/DVUoaIXt33Jo8T3IlO5X08XaIE/3GmcMJ
   mXjN9w/annu63IiK9/qmJ87cf5YRaPkDuzjcidUnTWrwU41gTJokmTaHA
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Oct 2022 15:11:52 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 15:11:52 -0700
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 14 Oct 2022 15:11:20 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v2 0/2] Add dma gpi support for QDU1000/QRU1000 SoCs
Date:   Fri, 14 Oct 2022 15:11:00 -0700
Message-ID: <20221014221102.7445-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series adds the dt bindings and driver support for dma gpi driver
on the QDU1000 and QRU1000 SoCs.

This patchset is based off of patches found at [1].

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

[1] https://lore.kernel.org/all/20220927014846.32892-1-mailingradian@gmail.com/

Melody Olvera (2):
  dt-bindings: dmaengine: qcom: gpi: Add compatible for QDU1000 and
    QRU1000
  dmaengine: qcom: gpi: Add compatible for QDU1000 and QRU1000

 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 ++
 drivers/dma/qcom/gpi.c                              | 2 ++
 2 files changed, 4 insertions(+)


base-commit: dca0a0385a4963145593ba417e1417af88a7c18d
prerequisite-patch-id: 3fbdc40584bde724063f88038e6e5178413fa9ce
prerequisite-patch-id: 7df51dc9dfa16d11f910c5142513ca7e43e5c4d4
prerequisite-patch-id: cb57181838cf718e80f2e07b290ffaf67b5acbc9
prerequisite-patch-id: efc95efd7a81f8bc65dc188f5d7c75769340dbe7
-- 
2.38.0

