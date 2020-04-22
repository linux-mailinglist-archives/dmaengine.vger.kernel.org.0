Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EE01B3EB6
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 12:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgDVKaz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Apr 2020 06:30:55 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17092 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730638AbgDVK32 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Apr 2020 06:29:28 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MAS5xx017009;
        Wed, 22 Apr 2020 12:29:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=hX7L0nE5JA6X8n9fkmiMK0qtz3ve5bvKWHb4t+EobHs=;
 b=tfjSZSJ7FzTF5KEHO10VpSEll5r4CcvTvj0b38S5QxaIBf44sEZeuPo1Lw+2U1rBw35a
 XyVf+7Jzee+hxoeiY539v+7hsGgFIFfBUhixA+/Ywhp/PxImjuQDnTU6vPK8NnHOJBIJ
 FiwivbGGjr0udu4gPv+RrqZWQHR6WvQvwMuRcv9CJb55Rux3xLXTRofhAd6oDUcZT+pd
 YJRy/KvmdTl23IP776OMBJersLGPuaFDVfWiTd1Llo0KUt5WbiFKSqAZvEwWmo+IbBg2
 Jl8bqg5B2xeFU/GXKj2spctbrOpv1a1X+dzE3+Ahl0tElqg9YIKaQl3JjfefU7oX4VsX Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fq11nt23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 12:29:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A30610002A;
        Wed, 22 Apr 2020 12:29:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 38BDD2A9560;
        Wed, 22 Apr 2020 12:29:14 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 22 Apr 2020 12:29:13
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Pierre-Yves Mordret <pierre-yves.mordret@st.com>
Subject: [PATCH 1/2] dt-bindings: dma: add direct mode support through device tree in stm32-dma
Date:   Wed, 22 Apr 2020 12:29:03 +0200
Message-ID: <20200422102904.1448-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422102904.1448-1-amelie.delaunay@st.com>
References: <20200422102904.1448-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Direct mode or FIFO mode is computed by stm32-dma driver. Add a way for the
user to force direct mode, by setting bit 2 in the bitfield value
specifying DMA features in the device tree.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/dma/st,stm32-dma.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml b/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
index 0c0ac11ad55f..71987878e4ae 100644
--- a/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
@@ -36,6 +36,11 @@ description: |
          0x1: 1/2 full FIFO
          0x2: 3/4 full FIFO
          0x3: full FIFO
+       -bit 2: DMA direct mode
+         0x0: FIFO mode with threshold selectable with bit 0-1
+         0x1: Direct mode: each DMA request immediately initiates a transfer
+              from/to the memory, FIFO is bypassed.
+
 
 maintainers:
   - Amelie Delaunay <amelie.delaunay@st.com>
-- 
2.17.1

