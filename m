Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53665223C37
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgGQNUe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 09:20:34 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47268 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQNUd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 09:20:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKSCw109446;
        Fri, 17 Jul 2020 08:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594992028;
        bh=hu78MvlqgFo+bRF487/quvGBr1vKDjN4sd4lNbKqsa8=;
        h=From:To:CC:Subject:Date;
        b=PUuslpX2DGI7EIW6Wx9OzptdUp5DjQ2pOnJpMCd0PJLnbYAyLyc7zi4ibQkQ5dc8s
         W0SgWGZWW2YOnCyuWgueNjaZ4FjuxgdxJZMatcBZUxmn7sk5abKM8OygolOAPGhgUW
         3EzZlk75OfkR/zXsxfSFLu+hH3mEEQMhIUd6wozo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HDKSDU062955
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 08:20:28 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 08:20:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 08:20:28 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKQfd026747;
        Fri, 17 Jul 2020 08:20:26 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next v2 0/6] soc: ti: k3-ringacc: updates
Date:   Fri, 17 Jul 2020 16:20:13 +0300
Message-ID: <20200717132019.20427-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Santosh,

This series is a set of non critical  updates for The TI K3 AM654x/J721E
Ring Accelerator driver.

Patch 1 - convert bindings to json-schema
Patches 2,3,5 - code reworking
Patch 4 - adds new API to request pair of rings k3_ringacc_request_rings_pair()
Patch 6 - updates K3 UDMA to use new API

Changes in v2:
- fixed build warning with patch 6
- added "Reviewed-by:" and "Acked-by:" tags.

v1: https://lore.kernel.org/patchwork/cover/1266231/

Grygorii Strashko (4):
  dt-bindings: soc: ti: k3-ringacc: convert bindings to json-schema
  soc: ti: k3-ringacc: add ring's flags to dump
  soc: ti: k3-ringacc: add request pair of rings api.
  soc: ti: k3-ringacc: separate soc specific initialization

Peter Ujfalusi (2):
  soc: ti: k3-ringacc: Move state tracking variables under a struct
  dmaengine: ti: k3-udma: Switch to k3_ringacc_request_rings_pair

 .../devicetree/bindings/soc/ti/k3-ringacc.txt |  59 ------
 .../bindings/soc/ti/k3-ringacc.yaml           | 102 +++++++++
 drivers/dma/ti/k3-udma-glue.c                 |  42 ++--
 drivers/dma/ti/k3-udma.c                      |  34 +--
 drivers/soc/ti/k3-ringacc.c                   | 194 ++++++++++++------
 include/linux/soc/ti/k3-ringacc.h             |   4 +
 6 files changed, 261 insertions(+), 174 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml

-- 
2.17.1

