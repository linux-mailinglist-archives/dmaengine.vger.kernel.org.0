Return-Path: <dmaengine+bounces-2075-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C92B38C904F
	for <lists+dmaengine@lfdr.de>; Sat, 18 May 2024 12:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858CB1C20DBF
	for <lists+dmaengine@lfdr.de>; Sat, 18 May 2024 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C21426C;
	Sat, 18 May 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NPGyrMmV"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55D8BE2;
	Sat, 18 May 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716026771; cv=none; b=aDlJKikCxBwYcAUs15Qh3ogWhGU0dhMpmt6DTn9Dovpb3rLXbgGFqnRuK3cuZGKVbFdDN8mFaH7ZaFaa94aPYIB5eXJTYsAR3IC6lGCJQnmszgmBGPxC1SQo0VY+mToohv45XR+Alh8XsZ1mwiY0TYcAtfakUHyUV9/lOP+vBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716026771; c=relaxed/simple;
	bh=2KLYzi0Quxs3zJMUGfVzy9lVcJJAzfPspjlA12X1dQg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZuI00ScjrT4zvmiFQffHYRExJ5gNurk4qB8VFJTfP0hsYMmXizehStS59tr8MJOrqByVRl6400V/mJJIxwpsqPAT7+GzJRXWZKRtNDaTT/KyF7UauXbqOR6qI5KjkCIIh+Idb5o4r0QaYvJfQSWttcgPGXmE8bjDDyU82OqBEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NPGyrMmV; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44IA60pD122481;
	Sat, 18 May 2024 05:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716026760;
	bh=+s027MF9CiDove3Goyu/bsXNM0Zc7/KqIS+GLcrruic=;
	h=From:To:CC:Subject:Date;
	b=NPGyrMmVRTfRneZGxYSUvAwP3q1RkrrCFo4YyhOCKt9S8GK+YXpXP5nmXNKCIv4YP
	 2RSysowDgaOXtLR3YGLw9dnGtu+kH+272OsWvVbBtSQPEsyZZwwqqQZeUNQOP5cf2m
	 nLXio2o9VEmzrQ7G/w/3moibFOvF2JOfgcvaeeyY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44IA60FK007642
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 05:06:00 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 05:05:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 05:05:59 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44IA5vR8100665;
	Sat, 18 May 2024 05:05:57 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma-glue: Fix of_k3_udma_glue_parse_chn_by_id()
Date: Sat, 18 May 2024 15:35:56 +0530
Message-ID: <20240518100556.2551788-1-s-vadapalli@ti.com>
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
without having incremented its reference at any point. Fix it.

Fixes: 81a1f90f20af ("dmaengine: ti: k3-udma-glue: Add function to parse channel by ID")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
4b377b4868ef kprobe/ftrace: fix build error due to bad function definition
of Mainline Linux.

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


