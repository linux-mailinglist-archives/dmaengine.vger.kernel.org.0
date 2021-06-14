Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDE33A72B1
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 01:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhFNX6m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Jun 2021 19:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhFNX6l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Jun 2021 19:58:41 -0400
X-Greylist: delayed 136 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Jun 2021 16:56:38 PDT
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B1EC061767
        for <dmaengine@vger.kernel.org>; Mon, 14 Jun 2021 16:56:37 -0700 (PDT)
Received: from localhost.localdomain (83.6.168.161.neoplus.adsl.tpnet.pl [83.6.168.161])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id A8BBB1F8DC;
        Tue, 15 Jun 2021 01:56:34 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: dmaengine: qcom: gpi: add compatible for sm8250
Date:   Tue, 15 Jun 2021 01:56:28 +0200
Message-Id: <20210614235630.445501-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No functional changes, just adding a new compatible for a different
SoC.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index e302147e53c6..e614fe3187bb 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -21,6 +21,7 @@ properties:
     enum:
       - qcom,sdm845-gpi-dma
       - qcom,sm8150-gpi-dma
+      - qcom,sm8250-gpi-dma
 
   reg:
     maxItems: 1
-- 
2.32.0

