Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED5C23A287
	for <lists+dmaengine@lfdr.de>; Mon,  3 Aug 2020 12:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHCKKO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Aug 2020 06:10:14 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33628 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCKKO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Aug 2020 06:10:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 073AA8nG086234;
        Mon, 3 Aug 2020 05:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596449408;
        bh=f81INNybJwHaQhrKDUJ2Qj0demoIazMnorfGf8irLLg=;
        h=From:To:CC:Subject:Date;
        b=ik1BlGK3YHblUIAqPMb4w5eEaRS04WKAOg3OzWtaRai+nXn78l8mxcvimNrgNaAqH
         qln3sQ9pxXSc1NaugE4S4sgKB0qkYFtkuBKZeeWAYfFZmxi50ggjb+ZngtjEeptKEu
         r/MfVS0K/ztJVli47BJ8qauKlkj45Fxf7wcKLi6o=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 073AA8QK081826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Aug 2020 05:10:08 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 3 Aug
 2020 05:10:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 3 Aug 2020 05:10:08 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 073AA51F062951;
        Mon, 3 Aug 2020 05:10:06 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <nm@ti.com>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>, <nsekhar@ti.com>,
        <kishon@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] dmaengine: ti: k3-psil: Add support for j7200
Date:   Mon, 3 Aug 2020 13:11:26 +0300
Message-ID: <20200803101128.20885-1-peter.ujfalusi@ti.com>
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
 drivers/dma/ti/k3-psil.c       |  20 +++-
 4 files changed, 195 insertions(+), 6 deletions(-)
 create mode 100644 drivers/dma/ti/k3-psil-j7200.c

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

