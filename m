Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF08323A6E7
	for <lists+dmaengine@lfdr.de>; Mon,  3 Aug 2020 14:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgHCMz6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Aug 2020 08:55:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52426 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgHCMz6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Aug 2020 08:55:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 073Ctr0l110891;
        Mon, 3 Aug 2020 07:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596459353;
        bh=fRQ5Oug422gkDKBoZdG1fdwjPUbLJ7z81qqj2DnNtMM=;
        h=From:To:CC:Subject:Date;
        b=Lr93Vw0CrSDMcrf0gIRmnhMtbjxwHXyFXb8DFMNjHswTjG3JaRXpWbWYfdzrJrZNj
         pqZDSa1wVjRIrZU9msD079pE7LxLvKaMwMOwaK0n1y/4HBtkLhQqeKI1M7ppoA30+w
         22Sg2OdRKmFqQ5Hw5tB6zkMW7fTlk23ElXanVWDE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 073CtrTd066325
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Aug 2020 07:55:53 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 3 Aug
 2020 07:55:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 3 Aug 2020 07:55:53 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 073CtoMh090290;
        Mon, 3 Aug 2020 07:55:51 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <nm@ti.com>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>, <nsekhar@ti.com>,
        <kishon@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] dmaengine: ti: k3-psil: Add support for j7200
Date:   Mon, 3 Aug 2020 15:57:11 +0300
Message-ID: <20200803125713.17829-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Changes since v1:
- Drop unrelated empty line change in patch 1 (k3-psil.c)

j7200 uses the same DMA hardware but have different set of peripherals, needing
different PSI-L thread map compared to j721e.

To simplify the runtime PSI-L map selection we will switch to use
soc_device_match.

See J7200 Technical Reference Manual (SPRUIU1, June 2020)
for further details: https://www.ti.com/lit/pdf/spruiu1

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: ti: k3-psil: Use soc_device_match to get the psil map
  dmaengine: ti: k3-psil: add map for j7200

 drivers/dma/ti/Makefile        |   5 +-
 drivers/dma/ti/k3-psil-j7200.c | 175 +++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h  |   1 +
 drivers/dma/ti/k3-psil.c       |  19 +++-
 4 files changed, 194 insertions(+), 6 deletions(-)
 create mode 100644 drivers/dma/ti/k3-psil-j7200.c

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

