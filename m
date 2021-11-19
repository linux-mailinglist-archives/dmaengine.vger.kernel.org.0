Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55C0456F81
	for <lists+dmaengine@lfdr.de>; Fri, 19 Nov 2021 14:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhKSN0Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Nov 2021 08:26:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41540 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhKSN0Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 Nov 2021 08:26:24 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AJDNLqC116338;
        Fri, 19 Nov 2021 07:23:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637328201;
        bh=+cYPq112zaLUFWeWrMVnWAkuSqlv9Z6H35GNFCrzKdo=;
        h=From:To:CC:Subject:Date;
        b=lJJS3XmA6iRF8n4SKQc6uVvay9MeuzoiW0THjNqmpKOu4GBo3nF6KYiPE6SjJQ9cc
         DFPa98K8xx2+E2/4NiwxhYIJnWLw3Q65dC9sy9xzms9eZ1GNurbpylkXOQ9fTNbgle
         qsSgFNW5VmX5f2efa0oNIh+EXCyg92RrkeMnk0u8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AJDNL9s075749
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Nov 2021 07:23:21 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 19
 Nov 2021 07:23:20 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 19 Nov 2021 07:23:20 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AJDNHbU098826;
        Fri, 19 Nov 2021 07:23:18 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 0/2] J721S2: Add initial support
Date:   Fri, 19 Nov 2021 18:53:12 +0530
Message-ID: <20211119132315.15901-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The following series of patches add support for J721S2 SoC.

Currently, the PSIL source and destination thread IDs for only a few of the
IPs have been added. The remaning ones will be added as and when they are
tested.

The following series of patches are dependent on,
- http://lists.infradead.org/pipermail/linux-arm-kernel/2021-November/697574.html

Aswath Govindraju (2):
  dmaengine: ti: k3-udma: Add SoC dependent data for J721S2 SoC
  drivers: dma: ti: k3-psil: Add support for J721S2

 drivers/dma/ti/Makefile         |   3 +-
 drivers/dma/ti/k3-psil-j721s2.c | 167 ++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h   |   1 +
 drivers/dma/ti/k3-psil.c        |   1 +
 drivers/dma/ti/k3-udma.c        |   1 +
 5 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ti/k3-psil-j721s2.c

-- 
2.17.1

