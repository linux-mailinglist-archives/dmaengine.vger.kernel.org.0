Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589BD6F84EF
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 16:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjEEOji (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 May 2023 10:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjEEOjg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 May 2023 10:39:36 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED26A3C38;
        Fri,  5 May 2023 07:39:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 345EdVkT022661;
        Fri, 5 May 2023 09:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683297571;
        bh=rfJUw3XI/VFU3YFzozIXQ3tshpJNDHpd6wJ+L1yxuW8=;
        h=From:To:CC:Subject:Date;
        b=QRGE3OTaI5Laxlrf0EbTDBKpwbxDzmbm/uocx3OO/eGTz6Dvos4PsNcFYO6KUEyzY
         tP/WqnHXyK4ebdM/p9FIJdRpS2a1umoi/H7Yo6oKHzh6RsqI01XwR1dBCbN7eXIfUL
         Hwe6+rAGRMA91kgCD9SuWTJZdqWxk/skKe0lessM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 345EdVR8123261
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 09:39:31 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 09:39:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 09:39:30 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 345EdTTj019546;
        Fri, 5 May 2023 09:39:30 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vigneshr@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <j-choudhary@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH v3 0/2] Add support for J721S2 CSI BCDMA
Date:   Fri, 5 May 2023 20:09:27 +0530
Message-ID: <20230505143929.28131-1-vaishnav.a@ti.com>
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
V2 : https://lore.kernel.org/all/20230505082602.31783-1-vaishnav.a@ti.com/

V2->V3:
  * Avoid using if:else:if, instead move ti,am64-dmss-bcdma
  to new if:, also keep entries in alphabetical order.

V1->V2:
  Address Krzysztof's feedback:
     * Move J721S2 BCDMA entry to else condition to avoid failure
     with AM62A BCDMA in binding.
     dtbs_check :
  https://gist.github.com/vaishnavachath/221155d02575e0c5803a62f2ee22e70e

Vaishnav Achath (2):
  dt-bindings: dma: ti: Add J721S2 BCDMA
  dmaengine: ti: k3-udma: Add support for J721S2 CSI BCDMA instance

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 30 ++++++++++++++++++-
 drivers/dma/ti/k3-udma.c                      | 25 ++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

-- 
2.17.1

