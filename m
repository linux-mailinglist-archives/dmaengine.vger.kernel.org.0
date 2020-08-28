Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C65255DCB
	for <lists+dmaengine@lfdr.de>; Fri, 28 Aug 2020 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgH1P0q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 11:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgH1P0p (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Aug 2020 11:26:45 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37345208C9;
        Fri, 28 Aug 2020 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598628404;
        bh=log7AWSuF7JDEl3CBLoeT1NR4965UMi8bHOOurlBFhI=;
        h=From:To:Cc:Subject:Date:From;
        b=dMDYP5r9cdaKFRyr7mNN7hs6VyR+O+iZydqxbOsqcYAf+bXjVXMRlFi0oE3FzTOD0
         h6ZmkSqU4+De+egmyCUSFm7VIGozhViBbWg4FS+574X/ck2R4m02Me/8fZ67Htfhui
         +AhhWO2mDGCKAxVHoMlu8NFh8/OZknduFMlFuSu8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Nicholas Graumann <nick.graumann@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] dmaengine: pl330: Simplify with dev_err_probe()
Date:   Fri, 28 Aug 2020 17:26:35 +0200
Message-Id: <20200828152637.16903-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/pl330.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 106f47298f9e..bb27338ec1ae 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -3034,9 +3034,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pl330->rstc = devm_reset_control_get_optional(&adev->dev, "dma");
 	if (IS_ERR(pl330->rstc)) {
-		if (PTR_ERR(pl330->rstc) != -EPROBE_DEFER)
-			dev_err(&adev->dev, "Failed to get reset!\n");
-		return PTR_ERR(pl330->rstc);
+		return dev_err_probe(&adev->dev, PTR_ERR(pl330->rstc), "Failed to get reset!\n");
 	} else {
 		ret = reset_control_deassert(pl330->rstc);
 		if (ret) {
@@ -3047,9 +3045,8 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pl330->rstc_ocp = devm_reset_control_get_optional(&adev->dev, "dma-ocp");
 	if (IS_ERR(pl330->rstc_ocp)) {
-		if (PTR_ERR(pl330->rstc_ocp) != -EPROBE_DEFER)
-			dev_err(&adev->dev, "Failed to get OCP reset!\n");
-		return PTR_ERR(pl330->rstc_ocp);
+		return dev_err_probe(&adev->dev, PTR_ERR(pl330->rstc_ocp),
+				     "Failed to get OCP reset!\n");
 	} else {
 		ret = reset_control_deassert(pl330->rstc_ocp);
 		if (ret) {
-- 
2.17.1

