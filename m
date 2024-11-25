Return-Path: <dmaengine+bounces-3788-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030B39D7E78
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 09:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72267B24B2A
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D102418E05F;
	Mon, 25 Nov 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H0CA8TRf"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20457082C;
	Mon, 25 Nov 2024 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525025; cv=none; b=fI8RKj9UoVta28ZvVV8s8C3jDhDDvIzJBl5XFJ7SxkIyKm+cvzVEzOkK92XcvNUAYMQKezW9nwCLqbFuVra93YXSYl34VPRC7x+kFaG1u/0/nmhv8IIpV6xRwB8RJ9aDjLpcqSuw4rDE9fTIVtCONh3/fEEUUwdep4/bHVK1Ebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525025; c=relaxed/simple;
	bh=+HHx1UwdTOZXvLeFxjB05giJcfy6ekNZV+yWUQe+dww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjbvJ08Iqvcq0QBD7UZ867J5sth+zVj86elhnXFBbZq6puqJ/C+klrlKzK1B0mHTmBt8EXoYvfdxQP/iFnHQ2GUvnRdXVwh3qHOCcXhzl2gowMyZ2xmLlKc/2z9pCrQt783veqlACzFBVzUBxfcYPt+F02UZdyBBfm2kNGF2u+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H0CA8TRf; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AP8dMvY640456
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 02:39:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732523962;
	bh=Po8mjmkN+7GJHfNw49gxB2Jy2zXvZ8kxkXerGYlrYM0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=H0CA8TRfI/Rz/gQAE+Qj30LTiPBJzHQ0DkKVom+HCbq1HJj7YoltVkA9o75yPacpu
	 WedWMmvyt3uoU1TwqN+81oYy06hYFalL2qWSAz/bqS7XtStfYaWjUv6rRz9Ye6A7vB
	 J9jQ4TsFP7uY3frMrFyc6dIg83oFfucQaPNk8eSQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AP8dMlZ008987
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Nov 2024 02:39:22 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Nov 2024 02:39:22 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Nov 2024 02:39:22 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AP8dEio127929;
	Mon, 25 Nov 2024 02:39:19 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <vigneshr@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 2/2] dmaengine: ti: k3-udma: Add TX channel data in AM62A CSIRX DMSS
Date: Mon, 25 Nov 2024 14:09:14 +0530
Message-ID: <20241125083914.2934815-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125083914.2934815-1-vaishnav.a@ti.com>
References: <20241125083914.2934815-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

J722S/AM67 uses the same BCDMA CSIRX IP as AM62A, but it supports
TX channels as well in addition to RX. Add the BCDMA TCHAN information
in the am62a_dmss_csi_soc_data so as to support all the platforms in the
family with same compatible. UDMA_CAP2_TCHAN_CNT indicates the presence
of TX channels and it will be 0 for platforms without TX support.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

CSI2RX capture test results on J722S EVM with IMX219:
https://gist.github.com/vaishnavachath/e2eaed62ee8f53428ee9b830aaa02cc3

 drivers/dma/ti/k3-udma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index b3f27b3f9209..4130f50979d4 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4340,6 +4340,8 @@ static struct udma_match_data j721e_mcu_data = {
 
 static struct udma_soc_data am62a_dmss_csi_soc_data = {
 	.oes = {
+		.bcdma_tchan_data = 0x800,
+		.bcdma_tchan_ring = 0xa00,
 		.bcdma_rchan_data = 0xe00,
 		.bcdma_rchan_ring = 0x1000,
 	},
-- 
2.34.1


