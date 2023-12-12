Return-Path: <dmaengine+bounces-485-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F3380E9F1
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 12:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A34E281E27
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 11:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CF15CD1B;
	Tue, 12 Dec 2023 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S96wkB+G"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A0210C7;
	Tue, 12 Dec 2023 03:11:10 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCBAEbn031704;
	Tue, 12 Dec 2023 05:10:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702379414;
	bh=c3xZPTrlmq5zKDBwFw/CwKWYbPbI3+6H+5cNtLUVu3k=;
	h=From:To:CC:Subject:Date;
	b=S96wkB+GbpaD8/Yimg5ACTTq+GTJ2I8Hto4UZ/eixVQINahk/Cwl6I1WabbxwmJRo
	 /iIEude9hKWy0+w5+KRCknl5LHIXEp1DwuRezAtRBHkWhQEYKH0lOadvXdxwsyt7f3
	 y2e16x9sz6S0tndLstOkyHs35aoHusQMGeDvNl8o=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCBAEXJ014613
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Dec 2023 05:10:14 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 05:10:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 05:10:14 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCBAB9v088764;
	Tue, 12 Dec 2023 05:10:12 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/4] Add APIs to request TX/RX DMA channels by ID
Date: Tue, 12 Dec 2023 16:40:07 +0530
Message-ID: <20231212111011.1401641-1-s-vadapalli@ti.com>
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
as being informed by Firmware on a remote core via RPMsg regarding the
allocated TX/RX DMA channel IDs. In such cases, the driver can be probed
by non device-tree methods such as RPMsg-bus, due to which it is not
necessary that the device using the DMA has a device-tree node
corresponding to it. Thus, add APIs to enable the driver to make use of
the existing DMA APIs even when there's no device-tree node.

Additionally, since the name of the device for the remote RX channel is
being set purely on the basis of the RX channel ID itself, it can result
in duplicate names when multiple flows are used on the same channel.
Avoid name duplication by including the flow in the name.

Series is based on linux-next tagged next-20231212.

v1:
https://lore.kernel.org/r/20231114083906.3143548-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased series on linux-next tagged next-20231212.
- Updated commit messages with details regarding the use-case for which
  the newly added APIs will be required.
- Removed unnecessary return value check within
  "of_k3_udma_glue_parse_chn()" function in patch 1, since it will fall
  through to "out_put_spec" anyway.
- Removed unnecessary return value check within
  "of_k3_udma_glue_parse_chn_by_id()" function in patch 1, since it will
  fall through to "out_put_spec" anyway.
- Moved patch 4 of v1 series to patch 2 of current series.

RFC Series:
https://lore.kernel.org/r/20231111121555.2656760-1-s-vadapalli@ti.com/
Changes since RFC Series:
- Rebased patches 1, 2 and 3 on linux-next tagged next-20231114.
- Added patch 4 to the series.

Siddharth Vadapalli (4):
  dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
  dmaengine: ti: k3-udma-glue: Update name for remote RX channel device
  dmaengine: ti: k3-udma-glue: Add function to request TX channel by ID
  dmaengine: ti: k3-udma-glue: Add function to request RX channel by ID

 drivers/dma/ti/k3-udma-glue.c    | 304 ++++++++++++++++++++++---------
 include/linux/dma/k3-udma-glue.h |   8 +
 2 files changed, 225 insertions(+), 87 deletions(-)

-- 
2.34.1


