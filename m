Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C0850064B
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 08:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiDNGpN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 02:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbiDNGpL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 02:45:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D5B4EA24;
        Wed, 13 Apr 2022 23:42:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2516B8285B;
        Thu, 14 Apr 2022 06:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B872C385A1;
        Thu, 14 Apr 2022 06:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649918565;
        bh=VpJImhcEYXAW31uW7ZX0+Pzc0Tu+aD5u1Obi0+xzHvw=;
        h=From:To:Cc:Subject:Date:From;
        b=NouI7JrN5qTC97ZV4jEAV3Xk9xnuapfy3yxRjUt44T/lh8lGBRw4vDWw3OLdjHF0f
         SkPoHxTTRPjvh8guGVxp8lsD9kW4rmwYDaK+a7uxA9U0GkDyhD1sogUBC9km6wDdK1
         9lS9dMQvs6HXsBwZwtJiWWpQj4jl7kQzt+4C3LHjLKCCJ6MtyyvVRlBtSAGTylzRrE
         wUzrChhsGp3revoLS2K+g9INN7py95bE5nLbHoDCxWAgVb6p6YHmWguqxGheopMAxc
         pU3JORmGzN/urhdHoGny6UmhLx36DzGSznW1EOCZ3TmrEt7uQAWv1Kth+SER6vYiAG
         aYjpLt+54rkEw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dmaengine: qcom: gpi: Add minItems for interrupts
Date:   Thu, 14 Apr 2022 12:12:35 +0530
Message-Id: <20220414064235.1182195-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the minItems for interrupts property as well. In the absence of
this, we get warning if interrupts are less than 13

arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb:
dma-controller@800000: interrupts: [[0, 588, 4], [0, 589, 4], [0, 590,
4], [0, 591, 4], [0, 592, 4], [0, 593, 4], [0, 594, 4], [0, 595, 4], [0,
  596, 4], [0, 597, 4]] is too short

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 8a790ffbdaac..7d2fc4eb5530 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -32,6 +32,7 @@ properties:
   interrupts:
     description:
       Interrupt lines for each GPI instance
+    minItems: 1
     maxItems: 13
 
   "#dma-cells":
-- 
2.34.1

