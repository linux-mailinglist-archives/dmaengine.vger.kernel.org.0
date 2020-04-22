Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ACD1B3EAD
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 12:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbgDVKa2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Apr 2020 06:30:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56194 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730705AbgDVK31 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Apr 2020 06:29:27 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MASQ2q005974;
        Wed, 22 Apr 2020 12:29:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=vQkeoE76rBPKloDNcJgTTXfaQgVxBlx3RLBb7ovXc8k=;
 b=Y8XWGA98J3xPyW/eIsQk9ygDZWdawKRSfYio+swui0AiC6SpFpp8cpPWZUnTBlBtnNZh
 6hKcjgxVlW5dHtgK/UB21EPoAwyxJT0cultqFUipXBYDQm3QTYgFdvpvwX1IA1M2h9q8
 hSycRVFBRw4vnqhXnrpe38Z1On8XSSBh184g5pW5lVkPVcq16o65XGYhNRiYVHuqw9fW
 3FwERQeJBvShyTWyUL8gcE57gPm4qGV1hQORtHTg3yrsn0bzl7sgc3AfbcXW5tEcHmj0
 p6THGMF+WbaCg/VgkEJghUHMXgZqGM915WED2aYHOWFVLPM2VOxdlovL+jWcu49AzR8R Fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fregnra1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 12:29:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E7A3710002A;
        Wed, 22 Apr 2020 12:29:12 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D2CB92A9560;
        Wed, 22 Apr 2020 12:29:12 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 22 Apr 2020 12:29:12
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
Subject: [PATCH 0/2] STM32 DMA Direct mode
Date:   Wed, 22 Apr 2020 12:29:02 +0200
Message-ID: <20200422102904.1448-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

By default, the driver compute if the FIFO must operate in direct mode or with
FIFO threshold. Direct mode is allowed only if computed source burst and
destination burst are disabled. But with memory source or destination, burst
is always > 0.
Direct mode is useful when the peripheral requires an immediate and single
transfer to or from the memory after each DMA request.
This patchset adds a way to force Direct mode through device tree.

Amelie Delaunay (2):
  dt-bindings: dma: add direct mode support through device tree in
    stm32-dma
  dmaengine: stm32-dma: direct mode support through device tree

 .../devicetree/bindings/dma/st,stm32-dma.yaml |  5 +++
 drivers/dma/stm32-dma.c                       | 41 ++++++++++++++-----
 2 files changed, 36 insertions(+), 10 deletions(-)

-- 
2.17.1

