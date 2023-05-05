Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1B66F7EFF
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 10:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjEEI2q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 May 2023 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjEEI2T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 May 2023 04:28:19 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4632419D49;
        Fri,  5 May 2023 01:27:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3458Q4Pe003850;
        Fri, 5 May 2023 03:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683275164;
        bh=eu/74Sw0rtrmZ5O0JjpRT++g3ExmODuSvlKPnoGzrTM=;
        h=From:To:CC:Subject:Date;
        b=WpipYlk1/x/MPbJv5TBj/EVIc1oo5N2r7zs9B7eGGSGDJgzzfGjzFvVXl5xhnRQwQ
         JmJM/61f2q/4b2n1oCdElIyrCX8vjW56RpBsoWkhwETj0TGjfjMc6mHEIjA8GPfmNl
         zFPHwCy+BVomoArz0g563CQx7v4zkVOCADA5gCMQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3458Q4EN129030
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 03:26:04 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 03:26:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 03:26:04 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3458Q39M120461;
        Fri, 5 May 2023 03:26:03 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <peter.ujfalusi@gmail.com>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>
CC:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <j-choudhary@ti.com>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <vigneshr@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH v2 0/2] Add support for J721S2 CSI BCDMA
Date:   Fri, 5 May 2023 13:56:00 +0530
Message-ID: <20230505082602.31783-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series adds support for J721S2 BCDMA instance for Camera Serial
Interface (CSI). 

V1 : https://lore.kernel.org/all/20230503065303.16674-1-vaishnav.a@ti.com/

V1->V2:
  Address Krzysztof's feedback:
     * Move J721S2 BCDMA entry to else condition to avoid failure
     with AM62A BCDMA in binding.
     dtbs_check :
  https://gist.github.com/vaishnavachath/221155d02575e0c5803a62f2ee22e70e

Vaishnav Achath (2):
  dt-bindings: dma: ti: Add J721S2 BCDMA
  dmaengine: ti: k3-udma: Add support for J721S2 CSI BCDMA instance

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 54 +++++++++++++------
 drivers/dma/ti/k3-udma.c                      | 25 +++++++++
 2 files changed, 64 insertions(+), 15 deletions(-)

-- 
2.17.1

