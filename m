Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D68A362DF9
	for <lists+dmaengine@lfdr.de>; Sat, 17 Apr 2021 08:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhDQGUZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Apr 2021 02:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhDQGUZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 17 Apr 2021 02:20:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B24AF611C2;
        Sat, 17 Apr 2021 06:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618640399;
        bh=O46rq0MKoZq2cyMcLqVrMxRGChVeYKuAf8wLUhTZnpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBNcOylW0jFFmHRAnbgW5Mr8ZVaDxi4yZYO/0vIZLMgQ9M/RrKk3al6M2JLQRtxZD
         j4vPblXNt/KVfgct0JvBFxKoIm6OKzZgs/WGdeZZ1ycoDwgE6Bn3K/XNWPwE6kooBt
         w+vq3krPw25Oq7FZ1/53nipBcMnaX5R2Dcq0vIVPD/F0bwNeFmBsVqoKR2xoCxFq7o
         RhY5X37p2DQkg67a4TAVtwK9M88iLt1TNSedyC+SzwxIYJxYJ73v2HesuvoUVSV9n7
         XhXdptmdemOjSTpHvIvw3xd67n2MIgkbwB6MS1DiZP0DkcbGZr0l2EbnAjaQEH1Ce0
         hZ3RKbhyu2uEg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: [PATCH v2 1/2] DMA: qcom: gpi: add compatible for sm8150
Date:   Sat, 17 Apr 2021 09:19:50 +0300
Message-Id: <20210417061951.2105530-2-balbi@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210417061951.2105530-1-balbi@kernel.org>
References: <20210417061951.2105530-1-balbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Felipe Balbi <felipe.balbi@microsoft.com>

No functional changes, just adding a new compatible for a diferent
SoC.

Signed-off-by: Felipe Balbi <felipe.balbi@microsoft.com>
---

Changes since v1:
	- No changes

 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 drivers/dma/qcom/gpi.c                              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index f8142adf9aea..902e2e523386 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - qcom,sdm845-gpi-dma
+      - qcom,sm8150-gpi-dma
 
   reg:
     maxItems: 1
diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 57f5ee4235c7..43ac3ab23d4c 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2281,6 +2281,7 @@ static int gpi_probe(struct platform_device *pdev)
 
 static const struct of_device_id gpi_of_match[] = {
 	{ .compatible = "qcom,sdm845-gpi-dma" },
+	{ .compatible = "qcom,sm8150-gpi-dma" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, gpi_of_match);
-- 
2.31.1

