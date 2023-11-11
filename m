Return-Path: <dmaengine+bounces-76-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 039627E8ADA
	for <lists+dmaengine@lfdr.de>; Sat, 11 Nov 2023 13:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F33AB20B23
	for <lists+dmaengine@lfdr.de>; Sat, 11 Nov 2023 12:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3905514270;
	Sat, 11 Nov 2023 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ygle3yJd"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821B13FFA
	for <dmaengine@vger.kernel.org>; Sat, 11 Nov 2023 12:16:16 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3753A84;
	Sat, 11 Nov 2023 04:16:14 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ABCFwNs069236;
	Sat, 11 Nov 2023 06:15:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1699704958;
	bh=drIkQeDrQ69r/4uSlBuE4vgTDEqYk1UD99meQvJ9WS8=;
	h=From:To:CC:Subject:Date;
	b=ygle3yJdoEbmobrF7j+pP/ryTKl2M96kaeQ5xBsQe15O87lAQ/Z/J3ytoQurR1RJC
	 7NLbetd2dlJMANonpBgdwmcfiuNmPftCaikzmy1wLkyuDAEwD1ff+9fO63bsXQ2lfY
	 lH0ZW+UGhBTsTTjWWyxi1G6xtZCtkF+aPjMxbN2Y=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ABCFwVQ053543
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 11 Nov 2023 06:15:58 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 11
 Nov 2023 06:15:58 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 11 Nov 2023 06:15:58 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ABCFtVV100939;
	Sat, 11 Nov 2023 06:15:56 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 0/3] Add APIs to request TX/RX DMA channels by ID
Date: Sat, 11 Nov 2023 17:45:52 +0530
Message-ID: <20231111121555.2656760-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The existing APIs for requesting TX and RX DMA channels rely on parsing
a device-tree node to obtain the Channel/Thread IDs from their names.
However, it is possible to know the thread IDs by alternative means such
as being informed by Firmware on a remote core regarding the allocated
TX/RX DMA channel IDs. Thus, add APIs to support such use cases.

Series is based on linux-next tagged next-20231110.

Regards,
Siddharth.

Siddharth Vadapalli (3):
  dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
  dmaengine: ti: k3-udma-glue: Add function to request TX channel by ID
  dmaengine: ti: k3-udma-glue: Add function to request RX channel by ID

 drivers/dma/ti/k3-udma-glue.c    | 322 ++++++++++++++++++++++---------
 include/linux/dma/k3-udma-glue.h |   8 +
 2 files changed, 236 insertions(+), 94 deletions(-)

-- 
2.34.1


