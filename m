Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7D0707CED
	for <lists+dmaengine@lfdr.de>; Thu, 18 May 2023 11:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjERJca (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 May 2023 05:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjERJcY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 May 2023 05:32:24 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 May 2023 02:32:16 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE702269F
        for <dmaengine@vger.kernel.org>; Thu, 18 May 2023 02:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684401972; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Rl6R68C8H4FPS/jhpoG/Z31osMkn07jJyu2d79AfgLwKgfd294KNUbRsdLtXpyZGSw
    Ho2eSCCRy2J3Jk1LZMKL4KTAObInXkmhfg8cdx8VeHCwlStjIFHB9cmnUSqnaSEL6sb3
    +2QE70nh5o4Hrsik/XYYueDYQ0GvamH0C47s6BZttfSjZGqUFErNas6/MIeIjODSDGqC
    GGt6JUPfd9yXmYwnQjOvq0TZPz/jf5mdXno8z4a4PXa5EVkOtnGeo4B4xw8f6E/I/dQN
    mFP0oYDABlnUYxsZMWsFoaaF4KNIiUwYWv99JeFa1AmjrHzXg4iiqQpNPdwbvQTzYdC9
    C/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684401972;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=VQO5GZKsRP3ZSA1ItJkim0mWjRZa1duUQAzHk9XLuPY=;
    b=NIIo/VIFja0OfqtlM4e3RXLGSwMSF2BlN3ax5U95Y1Vq14CRZqicftsRm7MN5/MZjP
    lvgwQXc9Jo/PFn3fnfxzahTZY937ggcZbkJOGlAYbKd0YLWVECy5dWLtoQCCxTI7rXpE
    4oUEc7fuaYxoa8KYsAtaUxEPsWu69s7+kh1fcijKL8HVVnVzQvUxOYOvbW2VBKNtDUn8
    fBWx3BlgSKdm/bJ6ydFnBfs8svd1jHsS+JdjzQ45FKRkBVapSQG6psNWZUnvbZ3FX08s
    9hiGw6QnttU374FQRqkoU7t1JFoklMKKgT+sQnibgsQXtd9G6pcFRbm2x8SO7o947m/9
    WO3Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684401972;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=VQO5GZKsRP3ZSA1ItJkim0mWjRZa1duUQAzHk9XLuPY=;
    b=Aj4L2AS39FtstuOcjpg1P1jT1Bkvw0beudtYK6j9LzznPKPhXBLiCBuXG898o9Cw00
    4SjJBaCIUP40zcOUXy+SDa3OlO6BG9qa/B2G0hGSB9nidnpD8JHvHgV8UvcI5o7JtVRx
    Rw9aSMRITOuJOAGxtrOTW52DG9E+e7CXwznteFFpvxixtS+ilNu+E4oDQwVe0Edtw6Ih
    jVdvwOaNcnDgwNQYRFGosd+Ixcdy2GPxjW2DFTwTaiFO7724FgtHQEVdPU+O3ZXKZlY6
    WNvf97fwjKAiwY9LLaF4apHbdZCKPOUrub1y8ONZu/qqnwnGuPrkae+JLm5QcB/al4d9
    Kxtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684401972;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=VQO5GZKsRP3ZSA1ItJkim0mWjRZa1duUQAzHk9XLuPY=;
    b=lQcwfg74Koai6ozuU8fbsRd5/ddzfMLtsyABsfDZg/Wr8FRRCoDTcz2TIDv0jBb7JC
    wTwvBtwk0N7MEkjrhdCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p1/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4I9QBCGS
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 18 May 2023 11:26:11 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 18 May 2023 11:26:00 +0200
Subject: [PATCH] dmaengine: qcom: bam_dma: make channels/EEs optional in DT
 with clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230518-bamclk-dt-v1-1-82f738c897d9@gerhold.net>
X-B4-Tracking: v=1; b=H4sIACfvZWQC/x2N0QqDMAxFf0XyvIDaDmW/MvaQtNkMq91odQzEf
 zf4eC7ncjaoUlQq3JoNivy06icbdJcGwkT5JajRGPq2d+21G5FpDumNccHoPZP4gZ0bwHymKsi
 FcpjskdeUbPwWeer/DNwf+34A1/ZNkXAAAAA=
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If we have a BAM clock in the DT we are able to turn on the BAM
controller while probing, so there is no need to read "num-channels"
and "qcom,num-ees" from the DT. It can be read more accurately directly
from the identification registers of the BAM.

This simplifies setting up typical controlled-remotely BAM DMAs in the
DT that can be turned on via a clock (e.g. the BLSP DMA).

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/dma/qcom/bam_dma.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 1e47d27e1f81..4c3eb972039d 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1272,7 +1272,15 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->powered_remotely = of_property_read_bool(pdev->dev.of_node,
 						"qcom,powered-remotely");
 
-	if (bdev->controlled_remotely || bdev->powered_remotely) {
+	if (bdev->controlled_remotely || bdev->powered_remotely)
+		bdev->bamclk = devm_clk_get_optional(bdev->dev, "bam_clk");
+	else
+		bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
+
+	if (IS_ERR(bdev->bamclk))
+		return PTR_ERR(bdev->bamclk);
+
+	if (!bdev->bamclk) {
 		ret = of_property_read_u32(pdev->dev.of_node, "num-channels",
 					   &bdev->num_channels);
 		if (ret)
@@ -1284,14 +1292,6 @@ static int bam_dma_probe(struct platform_device *pdev)
 			dev_err(bdev->dev, "num-ees unspecified in dt\n");
 	}
 
-	if (bdev->controlled_remotely || bdev->powered_remotely)
-		bdev->bamclk = devm_clk_get_optional(bdev->dev, "bam_clk");
-	else
-		bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
-
-	if (IS_ERR(bdev->bamclk))
-		return PTR_ERR(bdev->bamclk);
-
 	ret = clk_prepare_enable(bdev->bamclk);
 	if (ret) {
 		dev_err(bdev->dev, "failed to prepare/enable clock\n");

---
base-commit: 1c677f238f92ba0a329b7c13220f38b396872806
change-id: 20230518-bamclk-dt-d44bae47b337

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

