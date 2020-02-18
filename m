Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02216282D
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2020 15:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBROb1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Feb 2020 09:31:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50142 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgBROb1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Feb 2020 09:31:27 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01IEVL7d078364;
        Tue, 18 Feb 2020 08:31:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582036281;
        bh=82b+GU41j6/ZUJlCKcQWhnK8ypPA4+6ZqSrNcaCLVjI=;
        h=From:To:CC:Subject:Date;
        b=b2pdloQ7Oy5dzKqhKxVB+Ai2KlO0KfgQ246uuv69Q5YSJlX9WnIzYZZAiH5xhuwij
         SQfNOWG1PR0DOYU6qh/V70wxru0id4y2KrtyJNDn48Kw78dpc86Spag7zxtSyMnGmK
         V18i8z3+4aVWoM6oK1L+PNsu/RREl9I4lSeJL36M=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01IEVK1R108705
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Feb 2020 08:31:21 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 18
 Feb 2020 08:31:20 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 18 Feb 2020 08:31:20 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01IEVHXJ098737;
        Tue, 18 Feb 2020 08:31:18 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/2] dmaengine: ti: k3-udma: Support for per channel atype
Date:   Tue, 18 Feb 2020 16:31:24 +0200
Message-ID: <20200218143126.11361-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

The series is on top of the 5.6 update patches:
https://lore.kernel.org/lkml/20200214091441.27535-1-peter.ujfalusi@ti.com/

UDMA channels have ATYPE property which tells UDMA on how to treat the pointers
within descriptors (and TRs).
The ATYPE defined for j721e are:
0: pointers are physical addresses (no translation)
1: pointers are intermediate addresses (PVU)
2: pointers are virtual addresses (SMMU)

When Linux is booting within a virtualized environment channels must have the
ATYPE configured correctly to be able to access memory (ATYPE == 0 is not
allowed).
The ATYPE can be different for channels and their ATYPE depends on which
endpoint they are servicing, but it is not hardwired.

In order to be able to tell the driver the ATYPE for the channel we need to
extend the dma-cells in case the device is going to be used in virtualized
setup.

Non virtualized setups can still use dma-cells == 1.

If dma-cells == 2, then the UDMA node must have ti,udma-atype property which
is used for non slave channels (where no DT binding is exist for a channel).

Regards,
Peter
---
Peter Ujfalusi (2):
  dt-bindings: dma: ti: k3-udma: Update for atype support
    (virtualization)
  dmaengine: ti: k3-udma: Implement support for atype (for
    virtualization)

 .../devicetree/bindings/dma/ti/k3-udma.yaml   | 19 ++++++-
 drivers/dma/ti/k3-udma-glue.c                 | 18 ++++++-
 drivers/dma/ti/k3-udma.c                      | 50 ++++++++++++++++---
 3 files changed, 76 insertions(+), 11 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

