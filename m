Return-Path: <dmaengine+bounces-646-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2DD81D05F
	for <lists+dmaengine@lfdr.de>; Sat, 23 Dec 2023 00:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D2E1F21281
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 23:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4970033CE8;
	Fri, 22 Dec 2023 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="YD2U7Fjc"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830733CDA;
	Fri, 22 Dec 2023 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 754EB2D2069A;
	Sat, 23 Dec 2023 00:17:39 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id UQjBv7TfVS_c; Sat, 23 Dec 2023 00:17:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id F04BC2D20699;
	Sat, 23 Dec 2023 00:17:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl F04BC2D20699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1703287055;
	bh=dKwuJE/p8RRTNPJmOWDd2RM8yZsZtfB+uaBsiCI6SDY=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=YD2U7Fjc8wqNsYnZ4NjXrRJWtf8dNNvKp9nd7OW8jIZm+YwNLcoIy9aSc55BhVQQl
	 xxAV+XXOhN4tErC2HOMWw8M2gROfgILKTYtrNxoxQWT5evjL3mjpiuDJmGZijo8fha
	 PQZrIdR/HUe6H0G8E7oKKgDxOgWQdriazcAma3JGs56OJ7yXwAZlsBGWaoX2owzDlk
	 lG2RI3PYrrh2i7DuT6s/EAIOoIYO/R1Kt2mvByKJosxRkwNj3hCgOtJaoEnuDEN9Ud
	 mPrra2vO1ugam8aR4sUmseU/+zC14Q9tNSBy+bMj3Xo+PQfUG03kPAp+jWw46XhFFG
	 JecDVXsIbgV1g==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id tkTwjA1T9G-8; Sat, 23 Dec 2023 00:17:34 +0100 (CET)
Received: from localhost.localdomain (unknown [10.125.125.1])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 68A792D20696;
	Sat, 23 Dec 2023 00:17:34 +0100 (CET)
From: Jan Kuliga <jankul@alatek.krakow.pl>
To: lizhi.hou@amd.com,
	brian.xu@amd.com,
	raj.kumar.rampelli@amd.com,
	vkoul@kernel.org,
	michal.simek@amd.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jankul@alatek.krakow.pl,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] dmaengine: xilinx: xdma: Fix kernel-doc warnings
Date: Sat, 23 Dec 2023 00:17:28 +0100
Message-Id: <20231222231728.7156-1-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace hyphens with colons where necessary.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312230634.3AIMQ3OP-lkp@i=
ntel.com/
Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 4ebc90b41bdb..927c68ed6bbc 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -548,11 +548,11 @@ static void xdma_synchronize(struct dma_chan *chan)
=20
 /**
  * xdma_fill_descs - Fill hardware descriptors with contiguous memory bl=
ock addresses
- * @sw_desc - tx descriptor state container
- * @src_addr - Value for a ->src_addr field of a first descriptor
- * @dst_addr - Value for a ->dst_addr field of a first descriptor
- * @size - Total size of a contiguous memory block
- * @filled_descs_num - Number of filled hardware descriptors for corresp=
onding sw_desc
+ * @sw_desc: tx descriptor state container
+ * @src_addr: Value for a ->src_addr field of a first descriptor
+ * @dst_addr: Value for a ->dst_addr field of a first descriptor
+ * @size: Total size of a contiguous memory block
+ * @filled_descs_num: Number of filled hardware descriptors for correspo=
nding sw_desc
  */
 static inline u32 xdma_fill_descs(struct xdma_desc *sw_desc, u64 src_add=
r,
 				  u64 dst_addr, u32 size, u32 filled_descs_num)
--=20
2.34.1


