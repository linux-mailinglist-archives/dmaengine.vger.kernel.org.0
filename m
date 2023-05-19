Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5597095A2
	for <lists+dmaengine@lfdr.de>; Fri, 19 May 2023 13:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjESLB2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 May 2023 07:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjESLB0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 May 2023 07:01:26 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383841BC1;
        Fri, 19 May 2023 04:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684494032; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=P7f4Q9hQu7cnvWu1lAf8NZUpIXs9TYXjTG4aZDpiIQK7Eq2A5o4Qe8OiAjiab8pFeD
    4R4GgT0mYWNQEocFqKeO35HYdbAG8VWaeC4e4PleHTeKO1yzGwpROuCHNjNrSlVLFhJI
    w4zr6Q9h9Y/vQCg8VtrpzqYyBRnInSBUaRRmcWaLGCHC8mlzmdQjA80QSDZUle/cgQ1m
    iw6eo5b3EEKxXTGeRMZTJo3ms/Mgqxz/AqJGAlndVg6t++YYbRkhnMeG9jRq+vxKQzcm
    RCYavuR/arfCmK9FdEhrZnC5uFSWoP0iCEArZGk9O9A3pHRBEtqbSElByjZCTvMtpvgY
    /svQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684494032;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=yQb8geel8/PmlIERmu/C0g7x/X4cNdXUDvdM8Uvw/9U=;
    b=WzM3laCuIUGw2ijYcg0X2MH5hIAfjIuke8yso8SLc9mXgslLyIZgZFweu5UcSorLag
    S+eahYtVQQot9DbmRW2QBRLF+gMEQDF1C3+7ayl97kheXC2o5VCJqvwpMWdo8OshYUyN
    WY1g1zSP203XuOv3r07gTpcfum93c8qe5jRMk1EmQgZ9Aisp2+RsyNeQM8RM+X3mNrLz
    tKqyQ719l9l65ah085x84+PNikqF+K4OaJU7s8ncA2by3AQdE8GfRaiQ+El2AG9AuzDl
    icYpD+LKltNC1jS0e/uGHLdD1ThA3HlbylEWEw8qJQVvG+aSrLXfn2S8iKwPHtkDKomQ
    +/jg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684494032;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=yQb8geel8/PmlIERmu/C0g7x/X4cNdXUDvdM8Uvw/9U=;
    b=nwH1W17jDTYw2bFCTJjtYH+bUYL0T/gy8+YqriQXvTzWjjm7vCqQm2c1ZS3j+0+aUE
    U5bs7wpK3X1wJeDPUthpjly2Hpg8cpjFzMMTHOFnijG9TS0dMZIfkH1qz3PWpjFYRFp4
    z4iA0Lb5tcTVmHneYG38tLkA+SUMfSGN9RETlrOkZ29yjlr80UKpXYq9U5oeBoMargew
    wxI66xTjvUvTZ9FG+e3NwyZ/5JHErivfUrBk6kXhRo39zt4uZJ0ugIP8QT4rR7XNR1U0
    WuMjRCu/mZBWdYWsxdkNJRnN+LMdRDm21wEp0dSe9oKJp8ELccIZZFAuayrj2qxiCRxL
    q9gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684494032;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=yQb8geel8/PmlIERmu/C0g7x/X4cNdXUDvdM8Uvw/9U=;
    b=r+2dnb6GwAVOFrnmIwUyHxClper+2dBKBOwjX4uZ4b3CBZ8FOs0WyozLf7lBHU2Wca
    atRpLj02n/PYq0iSY8AQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOT/9w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4JB0WEZZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 19 May 2023 13:00:32 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Fri, 19 May 2023 13:00:13 +0200
Subject: [PATCH v2] dmaengine: qcom: bam_dma: allow omitting
 num-{channels,ees}
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230518-bamclk-dt-v2-1-a1a857b966ca@gerhold.net>
X-B4-Tracking: v=1; b=H4sIALxWZ2QC/22Nyw7CIBBFf8XM2jEFaqCu/A/TBY9pISI1UBtN0
 38Xu3Z5Tu5jhUI5UIHLYYVMSyhhShX48QDW6zQSBlcZeMNFc2YKjX7YeEc3o2tbo6mVRggJNW9
 0ITRZJ+trI71irPKZaQjv/eDWV/ahzFP+7H8L+9l/0wtDhooPUiirOum660jZT9GdEs3Qb9v2B
 dpnIge5AAAA
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The bam_dma driver needs to know the number of channels and execution
environments (EEs) at probe time. If we are in full control of the BAM
controller this information can be obtained from the BAM identification
registers (BAM_REVISION/BAM_NUM_PIPES).

When the BAM is "controlled remotely" it is more complicated. The BAM
might not be on at probe time, so reading the registers could fail.
This is why the information must be added to the device tree in this
case, using "num-channels" and "qcom,num-ees".

However, there are also some BAM instances that are initialized by
something else but we still have a clock that allows to turn it on when
needed. This can be set up in the DT with "qcom,controlled-remotely"
and "clocks" and is already supported by the bam_dma driver. Examples
for this are the typical BLSP BAM instances on older SoCs, QPIC BAM
(for NAND) and the crypto BAM on some SoCs.

In this case, there is no need to read "num-channels" and
"qcom,num-ees" from the DT. The BAN can be turned on using the clock
so we can just read it from the BAM registers like in the normal case.

Check for the BAM clock earlier and skip reading "num-channels" and
"qcom,num-ees" if it is present to allow simplifying the DT description
a bit.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
- Rewrite commit message for more clarity (discussion with Bhupesh)
- Link to v1: https://lore.kernel.org/r/20230518-bamclk-dt-v1-1-82f738c897d9@gerhold.net
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
base-commit: 2437d5ea2191f3059246a1a7ac6fc4c8cc004dec
change-id: 20230518-bamclk-dt-d44bae47b337

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

