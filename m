Return-Path: <dmaengine+bounces-2240-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53C18D7303
	for <lists+dmaengine@lfdr.de>; Sun,  2 Jun 2024 03:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77281C20CA3
	for <lists+dmaengine@lfdr.de>; Sun,  2 Jun 2024 01:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAFEA21;
	Sun,  2 Jun 2024 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GxF7UmHy"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980901C06;
	Sun,  2 Jun 2024 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717292030; cv=none; b=rDgeCNohARngVaYeZnV1Ed6BhadSjfsGXvj83zhwEl0TLzryr3TSgEA+YVccA/BMYJQfTHw+oX9G0mB1CJju5vGMpWWI9335Fq1HE9dZAFcS7K01XjAvB2ROMpiinAwI5XnHdewueSGE/ymA843kwW4E+FVLrLsHGLHt7+dq1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717292030; c=relaxed/simple;
	bh=XdxcvQrH7p0DQxEfPUL/IAa4KIlheTgoqVanz15UsX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kHfcIk0Vs8EFNgSxtEywfNbG6aWcVk+PEJdKOkyVT3qo6C6a9Zd9xIg5r3gcs/wQMIBAVCA+0rlNK8mgJB2u682foruTrXkLeIo3dNqz3RbQJ7K5TrusZRV1Qu5RrL1oHyj0IJFQQ1kZqBqHbU+GEB4h2aQvfsRowT/WW10qeCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GxF7UmHy; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4521XNXO114874;
	Sat, 1 Jun 2024 20:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717292003;
	bh=NxaxaTDvTYoiYmYWtCJv/7sGuhc5KKGpJm/etOuESak=;
	h=From:To:CC:Subject:Date;
	b=GxF7UmHy+kgERAmA2VCDcTeD1EDVsfvmqsIGkURjIzmfNZgit4DruF3nY/I653FCu
	 7LTEQnpdpTMPCktptcbG9sH4ZYo7AGky8zbkucOYc9Swma1ZAF0COuBklZYpCUAPrH
	 ggFpcNSEPZgnUfHzXUUhbfx1AuNJRQ2AYyC1DFdw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4521XNSE059863
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 1 Jun 2024 20:33:23 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Jun 2024 20:33:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Jun 2024 20:33:23 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4521XKQ0071063;
	Sat, 1 Jun 2024 20:33:20 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <Markus.Elfring@web.de>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2] dmaengine: ti: k3-udma-glue: Fix of_k3_udma_glue_parse_chn_by_id()
Date: Sun, 2 Jun 2024 07:03:19 +0530
Message-ID: <20240602013319.2975894-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The of_k3_udma_glue_parse_chn_by_id() helper function erroneously
invokes "of_node_put()" on the "udmax_np" device-node passed to it,
without having incremented its reference count at any point. Fix it.

Fixes: 81a1f90f20af ("dmaengine: ti: k3-udma-glue: Add function to parse channel by ID")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---

Hello,

This patch is based on commit
83814698cf48 Merge tag 'powerpc-6.10-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
of Mainline Linux.

v1 of this patch is at:
https://lore.kernel.org/r/20240518100556.2551788-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased patch on latest Mainline Linux.
- Collected "Acked-by" tag from Peter Ujfalusi <peter.ujfalusi@gmail.com>
  from:
  https://lore.kernel.org/r/8b2e4b7f-50ae-4017-adf2-2e990cd45a25@gmail.com/
- Updated commit message based on feedback from
  Markus Elfring <Markus.Elfring@web.de> at:
  https://lore.kernel.org/r/22a66571-0a0c-46dd-899a-d24079372880@web.de/
  with the change being:
  s/..incremented its reference at../..incremented its reference count at../

Regards,
Siddharth.

 drivers/dma/ti/k3-udma-glue.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index c9b93055dc9d..f0a399cf45b2 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -200,12 +200,9 @@ of_k3_udma_glue_parse_chn_by_id(struct device_node *udmax_np, struct k3_udma_glu
 
 	ret = of_k3_udma_glue_parse(udmax_np, common);
 	if (ret)
-		goto out_put_spec;
+		return ret;
 
 	ret = of_k3_udma_glue_parse_chn_common(common, thread_id, tx_chn);
-
-out_put_spec:
-	of_node_put(udmax_np);
 	return ret;
 }
 
-- 
2.40.1


