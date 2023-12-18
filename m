Return-Path: <dmaengine+bounces-551-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA93816671
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 07:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA961F21923
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92F16FA5;
	Mon, 18 Dec 2023 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XSubNcgw"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E446FA4;
	Mon, 18 Dec 2023 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BI6QiYa121862;
	Mon, 18 Dec 2023 00:26:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702880804;
	bh=YzYYCmLdsyz+XNn08+/64pVMRS3zHl5MoTp6BwswK6M=;
	h=From:To:CC:Subject:Date;
	b=XSubNcgw2Y4Usv30GLhelHKILRoi5bvP8hunqRUvF/CF3/1rWQnys14YZ97TKBuX9
	 gWvoqktbBWrTh9b3jmyFvoufWJcS62/O8vXHTSbqaFmRXjm0KkNQFLRlB8pGG5mLd7
	 vgSJ9PwTzkCVn0EuOCgXohUnZloeD1sZBfNETbZ0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BI6QieH066461
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Dec 2023 00:26:44 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Dec 2023 00:26:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Dec 2023 00:26:43 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BI6QebF063306;
	Mon, 18 Dec 2023 00:26:41 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 0/4] Add APIs to request TX/RX DMA channels for thread ID
Date: Mon, 18 Dec 2023 11:56:36 +0530
Message-ID: <20231218062640.2338453-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The existing APIs for requesting TX and RX DMA channels rely on parsing
a device-tree node to obtain the Channel/Thread IDs from their names.
However, it is possible to know the thread IDs by alternative means such
as being informed by Firmware on a remote core via RPMsg regarding the
allocated TX/RX DMA channel thread IDs. In such cases, the driver can be
probed by non device-tree methods such as RPMsg-bus, due to which it is not
necessary that the device using the DMA has a device-tree node
corresponding to it. Thus, add APIs to enable the driver to make use of
the existing DMA APIs even when there's no device-tree node.

Additionally, since the name of the device for the remote RX channel is
being set purely on the basis of the RX channel ID itself, it can result
in duplicate names when multiple flows are used on the same channel.
Avoid name duplication by including the flow in the name.

Series is based on linux-next tagged next-20231215.

v2:
https://lore.kernel.org/r/20231212111011.1401641-1-s-vadapalli@ti.com/
Changes since v2:
- Rebased series on linux-next tagged next-20231215.
- Renamed the function "k3_udma_glue_request_tx_chn_by_id()" to
  "k3_udma_glue_request_tx_chn_for_thread_id()" as suggested by:
  Péter Ujfalusi <peter.ujfalusi@gmail.com>
- Similar to the above change, I have also renamed the function
  "k3_udma_glue_request_remote_rx_chn_by_id()" to
  "k3_udma_glue_request_remote_rx_chn_for_thread_id()".
- Updated the function prototypes in include/linux/dma/k3-udma-glue.h
  accordingly.
- Updated the commit messages for patches 3/4 and 4/4 to match the
  changes made to the function names.

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

Regards,
Siddharth.

Siddharth Vadapalli (4):
  dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
  dmaengine: ti: k3-udma-glue: Update name for remote RX channel device
  dmaengine: ti: k3-udma-glue: Add function to request TX chan for
    thread ID
  dmaengine: ti: k3-udma-glue: Add function to request RX chan for
    thread ID

 drivers/dma/ti/k3-udma-glue.c    | 306 ++++++++++++++++++++++---------
 include/linux/dma/k3-udma-glue.h |  10 +
 2 files changed, 229 insertions(+), 87 deletions(-)

-- 
2.34.1


