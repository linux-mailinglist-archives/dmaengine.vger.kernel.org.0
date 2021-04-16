Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA53620F7
	for <lists+dmaengine@lfdr.de>; Fri, 16 Apr 2021 15:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbhDPNcI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Apr 2021 09:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243944AbhDPNcG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 16 Apr 2021 09:32:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 137FE61073;
        Fri, 16 Apr 2021 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618579901;
        bh=pAFpgWg6GPX+HhwpwQwrdVpYDakGXHbOvQZ8j+Yr9rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBYbkd9nvymoIf4n3FejMQykdvgbImc6bqmUzpqwcDIxTuWq9tKWhdhwIOTYmnQ0x
         ApFSfaaLf30TmJEjc+gNjGgU+Dgf1qsQzBi5Ag2SQg0eNzRkzaqbM1uU/crYKLcrrX
         FkplHJE0XC9FH4wieV84SaY0YAUZrUDPUC2zlQNF+JNBYGyVNs3VJf05Vg4znKFfip
         t3Dqxq1O6EPXRlxYVnx9+gdwAgGF2xCNeIC7bMhkzXMdKkpzWXlKmgWyaqF+g7wjvP
         I5DinzkC7tO+YOnnUU9/gPGRi0SV+AeV/yC44DgCAi49I4yCLQc5nxFSFZZu+3grOH
         XhxJKlz270wDg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: [PATCH 1/2] DMA: qcom: gpi: add compatible for sm8150
Date:   Fri, 16 Apr 2021 16:31:32 +0300
Message-Id: <20210416133133.2067467-2-balbi@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416133133.2067467-1-balbi@kernel.org>
References: <20210416133133.2067467-1-balbi@kernel.org>
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

