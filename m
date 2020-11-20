Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AC52BABE9
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 15:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgKTOdo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Nov 2020 09:33:44 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51274 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbgKTOdn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Nov 2020 09:33:43 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AKEW42p018604;
        Fri, 20 Nov 2020 15:33:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=2CM4NCa/CuP7klYZNKzVeHsDDN4tvYCHKHpkT+tePN8=;
 b=HKy1giFa6V4VB353LW3+rD6EdT20SS3QdDPJeyB5Ur3qFqZtuspzMPzSni43wUu7Wy3z
 DVSnLKhmauuYb+25mXBug6kG2U/Ac1JmkCQNkXwFELbJeE56MEqLOdeEdcWOfNaXP2Am
 XE7KrnFIO3fod+aYY8ZaKpZJ8LUeYot1oL3pZQYEEnomfqm1jncLU90G0MWYFQwM2RHS
 3Xfo+zTO83v7jLLYRw77+xaTpr2HzA3hnU16KjWL9YaCmlYo3TJXCxVKahEqw1ZwqBQ4
 9mQ0x/bwkciixr22uMk8PYNRBhC/VhCv0AUHtvd+ta9eIzodugIDNNW6FISTul3Hjh/z fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t70h7n0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 15:33:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A38F010002A;
        Fri, 20 Nov 2020 15:33:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 970A92777DE;
        Fri, 20 Nov 2020 15:33:28 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Nov 2020 15:33:28
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH 2/4] dmaengine: stm32-dma: clean channel configuration when channel is freed
Date:   Fri, 20 Nov 2020 15:33:18 +0100
Message-ID: <20201120143320.30367-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120143320.30367-1-amelie.delaunay@st.com>
References: <20201120143320.30367-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_07:2020-11-20,2020-11-20 signatures=0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When dma_channel_release is called, it means that the channel won't be used
anymore with the configuration it had. To ensure a future client can safely
use the channel after it has been released, clean the configuration done
when channel was requested.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 55a6bd381219..62501e5d9e9d 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1220,6 +1220,8 @@ static void stm32_dma_free_chan_resources(struct dma_chan *c)
 	pm_runtime_put(dmadev->ddev.dev);
 
 	vchan_free_chan_resources(to_virt_chan(c));
+	stm32_dma_clear_reg(&chan->chan_reg);
+	chan->threshold = 0;
 }
 
 static void stm32_dma_desc_free(struct virt_dma_desc *vdesc)
-- 
2.17.1

