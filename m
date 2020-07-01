Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E364C210946
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgGAKas (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 06:30:48 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37104 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbgGAKas (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 06:30:48 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061AUidM089307;
        Wed, 1 Jul 2020 05:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593599444;
        bh=NP0JdMLh+U0vhC5zO7pOJizvlOHIeJNO1xQ5Cl4Bwr0=;
        h=From:To:CC:Subject:Date;
        b=oXpShRAxFqaCNVB/c7L3+0JwhpPIzkbFTYQPUNyDqqVeLegEwsTFNYZEiY31npCLr
         s9DLS63f5Xtut3LyQxEhchDWoiJOcw5uXuqYrEBwc3wle8KmFolFOP9UkHXO7kXmaz
         nwkvP75jp6rHaKw0GEWGaEskc9IPIXHOFLK+Sk0w=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061AUiID055689;
        Wed, 1 Jul 2020 05:30:44 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 05:30:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 05:30:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061AUgWi081763;
        Wed, 1 Jul 2020 05:30:43 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next 0/6] soc: ti: k3-ringacc: updates
Date:   Wed, 1 Jul 2020 13:30:24 +0300
Message-ID: <20200701103030.29684-1-grygorii.strashko@ti.com>
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
 drivers/dma/ti/k3-udma-glue.c                 |  40 ++--
 drivers/dma/ti/k3-udma.c                      |  34 +--
 drivers/soc/ti/k3-ringacc.c                   | 194 ++++++++++++------
 include/linux/soc/ti/k3-ringacc.h             |   4 +
 6 files changed, 261 insertions(+), 172 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml

-- 
2.17.1

