Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8FD47FC7A
	for <lists+dmaengine@lfdr.de>; Mon, 27 Dec 2021 13:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhL0MGf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Dec 2021 07:06:35 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:47399 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbhL0MGf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Dec 2021 07:06:35 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MryKr-1mgUEN17Ez-00nx3N; Mon, 27 Dec 2021 13:06:14 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 03/11] dmaengine: bcm2835: Support common dma-channel-mask
Date:   Mon, 27 Dec 2021 13:05:37 +0100
Message-Id: <1640606743-10993-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:pLYG2yJd/86QSRmuXUNXZ0jIhtsFv1rfHEN2cSa9TfrRHXAWO4l
 aNYr2qJeom3SA27zUgKi6qnIgcL0rjTmq/0FDmy2SMlwHx+4AP4XCT2c+qwQexjMvOGKiS1
 JTOEQAVEPBUUr7BwZuH4qT2h5SQSpVcrYOJGgtzQeMj6za1WG8IyO+YLj0eiNSrC6IMJn1p
 /9/wtHXceaKFfdeRcVerA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:J6uy7lC+pS8=:/R/8iW/sI1gAwBu30ljRSk
 jXqZfVAjxRgtDwM6cRkToPx1ynXW1wFJyh2Q8H6djqi5HwsK6+pWX7jNZxor3t/2fo9MCuUfM
 rdZB1ykQt+N0FEXMK3mdHYizMURtO+BSmLYspKcZ0vIpcFhvBMHX0ycUL26VeA7jkPiJFncic
 f+Ka9dvWLA0mVfXzCj9EZrxMFs+n3yv0uignNRzEaCGdELeYtl/YCc+KvkVhFw+/XiRyoUyQj
 Cd2uCaEfJwk1wQ5ZL65s3VkfiaqRHeDrp4Jv1ofgP6IgQkTikTcvgBTZ2GXWjx5zyOz0Ole3y
 y8sfH/vTdHcI7K4VmibkdOoZF+N3wDb7Gbb4Z7sRvahfDEWLgNYIg4ptytQ3ETlm2HoDiZvEE
 VAJ/4KDo5CGzT4syfC+Dap4JifeJyisc2+jKh7nQr4xgXRH43v0F7lWEo5mF2NWWejLa1WzcD
 Iynxj2lVGYcgIHrXdabARmmex3qUKUO8lLMMw0onmbYnZ0rBWgkKudnKHU/TERUf0hfHypZdm
 ThOjjCfvl+FzUGDahA5QUjFNZsVKhwC8/XFMoJkqX1txAaifmUyhXIBM6EsDzlQT2TkF14DvY
 gPl6ZGy55KN1sqQRjrsFFFcTxmwG/RkYtZtEvOT1xejCmgIVYKTLeGXot58eR+8jcAhHfJT+m
 0dEUMkp5yNzRpRCM7qpVRlb+RZ4gyovXbshezgG0SIQY4pJ/+pMTmN9hIy2J1kqsuQejM3JX8
 5l6ykr9GibWR8/6H
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Nowadays there is a generic property for dma-channel-mask in the DMA
controller binding. So prefer this one instead of the old vendor specific
one. Print a warning in case the old one is used. Btw use the result of
of_property_read_u32() as return code in error case.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/dma/bcm2835-dma.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 630dfbb..adfe6bc 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -943,12 +943,19 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	}
 
 	/* Request DMA channel mask from device tree */
-	if (of_property_read_u32(pdev->dev.of_node,
-			"brcm,dma-channel-mask",
-			&chans_available)) {
-		dev_err(&pdev->dev, "Failed to get channel mask\n");
-		rc = -EINVAL;
-		goto err_no_dma;
+	rc = of_property_read_u32(pdev->dev.of_node, "dma-channel-mask",
+				  &chans_available);
+
+	if (rc) {
+		/* Try deprecated property */
+		if (of_property_read_u32(pdev->dev.of_node,
+					 "brcm,dma-channel-mask",
+					 &chans_available)) {
+			dev_err(&pdev->dev, "Failed to get channel mask\n");
+			goto err_no_dma;
+		}
+
+		dev_warn(&pdev->dev, "Please update DT blob\n");
 	}
 
 	/* get irqs for each channel that we support */
-- 
2.7.4

