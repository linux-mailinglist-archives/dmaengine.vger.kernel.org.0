Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E2C4F6437
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbiDFP6d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbiDFP6O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 11:58:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE91B2E9115;
        Wed,  6 Apr 2022 06:25:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A7F860BBC;
        Wed,  6 Apr 2022 13:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663EAC385A8;
        Wed,  6 Apr 2022 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251526;
        bh=hTm2T0pdYDtFq2HDDGIY0S7joOuEyR0hSrSZNJKq0oI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REZhUJMpmud3BuPyrnUP3oExqT2dwMzk4Yubx1hbmiyipl28W+l/Z4CNtxC7nMw0G
         Nq3bAwTdrlclkNnFTmmNPcUcTwSDAIQ6Z5L9sZOGJNSPRup8mQc+sbnDs46aqscjo1
         SG74enTTeyBOHe/HyRST+bXXp2xg5Gd+5YPMjWtioIskeOjMOv5321Tk2a8qu7L+FC
         Rhgqk1iAyMY/IzzJbS7hM15FDQXJBoqJmADNURkO1jZGZgSgdHUGI/RxM2kR6/OuAw
         9IIbNnEF5bi2O+k57SUe9Joa4Cv2+EKj0nEt+6nbR39TOBtKrwTyGJT+SljhOZFzHP
         NOXIaRvv27Ekg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: dmaengine: qcom: gpi: add compatible for sm8350/sm8350
Date:   Wed,  6 Apr 2022 18:55:07 +0530
Message-Id: <20220406132508.1029348-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220406132508.1029348-1-vkoul@kernel.org>
References: <20220406132508.1029348-1-vkoul@kernel.org>
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

Add the compatible for newer qcom socs with gpi dma i.e qcom sm8350 and
sm8450.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index e614fe3187bb..67f046a4a442 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -22,6 +22,8 @@ properties:
       - qcom,sdm845-gpi-dma
       - qcom,sm8150-gpi-dma
       - qcom,sm8250-gpi-dma
+      - qcom,sm8350-gpi-dma
+      - qcom,sm8450-gpi-dma
 
   reg:
     maxItems: 1
-- 
2.34.1

