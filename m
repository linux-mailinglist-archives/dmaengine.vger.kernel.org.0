Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0CD43160E
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 12:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhJRK24 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 06:28:56 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:35071 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhJRK2y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Oct 2021 06:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1634552791;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=GCXJJtuqsiwVcUKc+rGZzetE5ZrPt4qXdCp4FafrMb8=;
    b=pjF1vO6iNrJsSrUOGwqEAoZs9cP++IZb9plaPgrP1wYFBPX3jzeSGevuzm93ieFrc4
    oBVhbJTkdHynegfyxwbhID2LRYRZda4+639G2q5ojXYEmKRcRzOBjQx7DFVcynAJtLsV
    fLkqCo5Xl7n/dPT7ZwLLQn96F5tgnt+1waynmIsw2qZzFSsBrA61//1NxcaT3C0Xa8KY
    BwM375Ndtz5le/aufKMjiWIhSoXKsndxU8KG+vL854opR7J65MSzJLvenjNLQpkYUgEx
    pVaM3MkDiam8zL1OfEZNppYKokXXlR8mon0NrPmpzm0Y1OOlaqKbScpsSti5fwe6bJYB
    /Yrw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7UOGqRde+a0fiL1OfxR"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.33.8 AUTH)
    with ESMTPSA id 301038x9IAQVVQ3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 18 Oct 2021 12:26:31 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 1/2] dt-bindings: dmaengine: bam_dma: Add "powered remotely" mode
Date:   Mon, 18 Oct 2021 12:24:20 +0200
Message-Id: <20211018102421.19848-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018102421.19848-1-stephan@gerhold.net>
References: <20211018102421.19848-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In some configurations, the BAM DMA controller is set up by a remote
processor and the local processor can simply start making use of it
without setting up the BAM. This is already supported using the
"qcom,controlled-remotely" property.

However, for some reason another possible configuration is that the
remote processor is responsible for powering up the BAM, but we are
still responsible for initializing it (e.g. resetting it etc). Add
a "qcom,powered-remotely" property to describe that configuration.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v3: None, split from BAM-DMUX patch set
Changes since RFC:
  - Rename qcom,remote-power-collapse -> qcom,powered-remotely
    for consistency with "qcom,controlled-remotely"

Also note that there is an ongoing effort to convert these bindings
to DT schema but sadly there were not any updates for a while. :/
https://lore.kernel.org/linux-arm-msm/20210519143700.27392-2-bhupesh.sharma@linaro.org/
---
 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
index cf5b9e44432c..6e9a5497b3f2 100644
--- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
@@ -15,6 +15,8 @@ Required properties:
   the secure world.
 - qcom,controlled-remotely : optional, indicates that the bam is controlled by
   remote proccessor i.e. execution environment.
+- qcom,powered-remotely : optional, indicates that the bam is powered up by
+  a remote processor but must be initialized by the local processor.
 - num-channels : optional, indicates supported number of DMA channels in a
   remotely controlled bam.
 - qcom,num-ees : optional, indicates supported number of Execution Environments
-- 
2.33.0

