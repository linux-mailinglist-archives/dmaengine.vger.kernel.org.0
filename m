Return-Path: <dmaengine+bounces-8952-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAArJEaNlWl7SQIAu9opvQ
	(envelope-from <dmaengine+bounces-8952-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:58:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D73155078
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0746430ADE1F
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC533DEE7;
	Wed, 18 Feb 2026 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TKCwZdQg"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140BC33DEE2;
	Wed, 18 Feb 2026 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408449; cv=fail; b=ryxgTiDMnmTNDfDsowfSOnbXPtcmfY4TROAuPbWVvvn5qSIfk5N9sqnvrR2m13xy77B8pc+MkUMlEVDIU9MONAcHSzIF7UB5f/spEtz2ws7r16BMUdZ33Wl6rBxvqdIWq8JfPDdGf4MU3TRvPDUBxQEYQGNupzi9c16q0awWUIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408449; c=relaxed/simple;
	bh=rmLaMOQgrBuoGCure95Sx4FQnosYhF4wpfH+AtB4/q0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxIqRL+IPghN2550Sn1CGVtxiqPe4m9DAPEiwcWVoEOz6QiU8NhxjmkNF0gJI2Ecx8Z7g+Gvi4xr+qH7UQM25lLTjUFFfPEdtVjeGGYN74OlotKXq+5R+qL9GVsWooJcWfz5CuMQc6DQXUeQ6ahaukiRvfnpzWwJgNKOqtxmHsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TKCwZdQg; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgrSU3whm6hyazYXwMw0eHt67goTHjSpEhImMlMb0AymkRxV+vNXHx3dp2Re17kFolHG+zd6Xg1RnfVbmczC5aeHyaFgHvvGPHHBuP5+kkc30jANh/99ZG7UHlgrnlsPyw+bBq9wBSBmDmwrKFk+swJF/7FTZa+WABp2+lNDAeSTmAlMXq6KCT0v+5hg4/XpybxbA55f09bIUZiAKuuCyU6JM8Idl36EMsDZbySoSyQ8E9q9AGm112O/yRVXET5tYpaEOuIiDGpzAb7LJemc0Voo9+M7x080Kr/JAVItcV39wDTGVX35s2XnyPF0fx/kXZETi9JU0JvSq6tgl6JTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJrAlx6lO+F7VT68NfA+jYVBa/9M218hBQEtuCnhwRs=;
 b=GbO5jnsiJn6flbvimCdPmdoRDoKmVbKqbY5Hi+Ma7hmhXVOey9Gzs8WjnwSI3ga1lwzec4TnyeqJZN7XGbNFyl6R4lJk+U25YetZqMQ/BZt/4yCFO9PhgA/a+vU4WLbKXygauwcxHbO37EfUtyk1j58tSts832Az710n+sXEvjEdgsDoCVp2kErHGt/DyKiiS2bwNW73Dx+rfM3d/yeWvFISyBOHWYhX2pMS+pOGzar4ucQVbihO04mT9lDokx5bLJD8L8Gfku8VMKHQNErTtUqbJSOU+dEwzEfghCFh7nYVQ2pGrJVNxu7hixdDOqrZLfnwLru3fnInpjsnL3o0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJrAlx6lO+F7VT68NfA+jYVBa/9M218hBQEtuCnhwRs=;
 b=TKCwZdQg0wEocnPNGQ685CkyLTNYiCkNYIHS3ovvxpkPkdW4XyZaM/4TjG25L9dS0Y1fjsXXn9BRugco1NjhLi3Br03D09IYbH+DHhBvd1r5YZ90+iQvPLnvE7yRHqDOjghzFsW8zPJCAc/dcQOGik2Hys9gGIi2mOb5CYaI+5E=
Received: from BN0PR04CA0208.namprd04.prod.outlook.com (2603:10b6:408:e9::33)
 by BN0PR10MB5174.namprd10.prod.outlook.com (2603:10b6:408:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 09:54:05 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::d2) by BN0PR04CA0208.outlook.office365.com
 (2603:10b6:408:e9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.15 via Frontend Transport; Wed,
 18 Feb 2026 09:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Wed, 18 Feb 2026 09:54:04 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:54:03 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:54:03 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:54:03 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpIL200561;
	Wed, 18 Feb 2026 03:53:59 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 14/18] dmaengine: ti: k3-psil-am62l: Add AM62Lx PSIL and PDMA data
Date: Wed, 18 Feb 2026 15:22:39 +0530
Message-ID: <20260218095243.2832115-15-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218095243.2832115-1-s-adivi@ti.com>
References: <20260218095243.2832115-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|BN0PR10MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5631ce-da0a-4a51-049e-08de6ed3a67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P9EbEdZzpvg6licXc8Tr4Sb+QbKwt/+M2CHYwUrliPbOUxDUAMKg3TGvKUOU?=
 =?us-ascii?Q?Abb6EXsAlRJNo8PIeRQQZto1lx/8DfRSDQZOVwt8IkfSLhaIG4Dj26OW5We3?=
 =?us-ascii?Q?SDjZxHnAKNpH3Umtp/EJN/5UN/VU9Df+uDCXquafeEGjTHt4luEvk6L3PwTu?=
 =?us-ascii?Q?WySeRpARjAjjewcdcnrlhhQUrhJ9cbPIiKGZi8PN54Y5BjPZJyKYYT+iwYwj?=
 =?us-ascii?Q?e/wy4Ra7fLaDP/V5/zQKr0ThclMulQsM4txQAebIxO2eoVspgJBe92wSsWna?=
 =?us-ascii?Q?kycFUOEVPpSt5AnTiHbgIsqn2mHBLfONmAYCOtIyf0121SIqF9cehzQdhOxV?=
 =?us-ascii?Q?hclX3ox9/KOP1eDHI67fVcx86+QvPC8dujKL9Ylo6BFYpu5kVB5yK/4v2kYC?=
 =?us-ascii?Q?czrlEO/o2MDPKOWpz7bCVAKXCFBy0LZ+nxOnv8beKyf2Gs10COkYwfdFubyS?=
 =?us-ascii?Q?W/cB7y4mnb01POtNrU/pN2j/lFoiRvC8LG0wMrU7vefg+/DukoVkjbB3GcSB?=
 =?us-ascii?Q?p4XqUf5lXxfW1QpE+I6O+FqYSm6QxTrwA6GaSh3tK5/bgjJCFVaWOhrPYyIa?=
 =?us-ascii?Q?ffJ2zi5QH30oJ9kvqRDy5jDT3IHjwciKuctsuM4lkqZo09/EgXXZuJwGIY9w?=
 =?us-ascii?Q?AUEwuTps3ESuPcsbsAlT71dT9do7BuRvgHna+AK65TaYIXN18KRP7nY+S2ZS?=
 =?us-ascii?Q?QIrp1vOCUYCG13WwkaVOfTHslNrx9sD8K5pADtCilGyCN0mC4xSXujpcHXry?=
 =?us-ascii?Q?wwjdklL5+PO++0eBP5c4BDZh47wgv8GA32PVmtz8+09hGGEKiEjwxazb7G42?=
 =?us-ascii?Q?g6FnWfTFBt6ftjPGVsn5WmNuZAZb8hkMaZmh8rBAMQlSa2/Yo4toT+rBlTRY?=
 =?us-ascii?Q?RMawJ3dCKAs5m2YD+QP+HvjCLgcH+C0i+/AyTW0qWOvVsNbRX53AoOHI1Ow+?=
 =?us-ascii?Q?x5iK91eX0drA7LxtngO9nsL+gqq5V8C5HvfwFepFf7b1ryW1JiIqDxNBI1Ns?=
 =?us-ascii?Q?ub1I3NgHdl5S6/vw0xbY95yTdG4tF78S2H+pRWXjv1/IIl/7aFwMpyebXGCb?=
 =?us-ascii?Q?ZLfyosuyHnpnyd+hV3Yr11b0XqeWOqm9lnl+10fnB1pJpxsU6d2/W+TxUQlK?=
 =?us-ascii?Q?prozJWftxNeepuNM0sdcGK7hFTc+JJF1aGO8jyq5jOd97lWk8Mwc+zzIuADR?=
 =?us-ascii?Q?TnV+xHEHPHbBEpipkMHCxX4AnEfuAJu1BsNudmSbTqCyVyc6jYH1s4YtsC3a?=
 =?us-ascii?Q?ODfrmVdtMPzOHROrTepag/A6ncUZiansMz0t2Io4+0BewR7ql8xyigETFW9e?=
 =?us-ascii?Q?DWH5+uI/nZRMm70NogPD/WaFO1HlpsPtBiPFkQvFMaZRoQmtE+Co2AX9exa+?=
 =?us-ascii?Q?T0wHZ6Ej9nvecMIUfx3T+3MUykfIe9QtgfY9EdjwpjRBP5DxTHKjICgRGYPu?=
 =?us-ascii?Q?UUQdgiN3nAsO6+Yxuf03/KtNCqX84Sp8qVtYotOYFOSdedGV5+12SXKUlVDL?=
 =?us-ascii?Q?izIELnQ1f42yvqk2ny3wvJwn7h2/0wiKY3uQusryaNJWfnUkh+7RZg6tX1xi?=
 =?us-ascii?Q?OZZ8uWLxWk7Sp6fb5aAhLxrODk3x4WGkVq2Ga+FDiYmJfiaFXsE07MDWSo+n?=
 =?us-ascii?Q?WnD2VyoW1uoMnOGWzuLLTTg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pXe1P0Smkc1+yw1QL5uUva46af92gxXYdKQZFYQXK/4Jv+QNivKQm4xEUk11US+iAEbQpCE/FnHu8pCHlWaaHWbuZM3ISOTH4ZfETsiGmDbJZMWcRkjJHrnzR+bEhqAdtangC6YM1TtsetwBnQuZkaEw1YGGe9SoMg88n0tS8kdDWxyhf12PNptfXdwieGL8UO5R/qb2A8VR1l50ZcS9cVaErRjTcxveochJxsL2yQEIerbbvT5jxnbVvw5KZcJKwVbCnO+TJ67t8XKy+YhoUVku/TeLjOnlitiCb7wmPXs1UQaJYrPljPdQEC2fHc8K9Tv6Ic4wohe+N+y5H/Uq3GPEK4A3nkp5VciawbyUnWUqjCmAn2VCk2gC39oOdtUzADF+u9uoy7tBUGWtOE5VjeSej9smgfVnOBaeAJIdn49Y04Tp/TjJAoC+8Ux4pnMm
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:54:04.2396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5631ce-da0a-4a51-049e-08de6ed3a67e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5174
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8952-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:url,ti.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E6D73155078
X-Rspamd-Action: no action

Add PSIL and PDMA data for AM62Lx SoC.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/Makefile        |   3 +-
 drivers/dma/ti/k3-psil-am62l.c | 132 +++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h  |   1 +
 drivers/dma/ti/k3-psil.c       |   1 +
 4 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ti/k3-psil-am62l.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index 3b91c02e55eaf..41bfba944dc6c 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -14,6 +14,7 @@ k3-psil-lib-objs := k3-psil.o \
 		    k3-psil-am62.o \
 		    k3-psil-am62a.o \
 		    k3-psil-j784s4.o \
-		    k3-psil-am62p.o
+		    k3-psil-am62p.o \
+		    k3-psil-am62l.o
 obj-$(CONFIG_TI_K3_PSIL) += k3-psil-lib.o
 obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
diff --git a/drivers/dma/ti/k3-psil-am62l.c b/drivers/dma/ti/k3-psil-am62l.c
new file mode 100644
index 0000000000000..45f5aac32f6a0
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-am62l.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2024-2025 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#include <linux/kernel.h>
+
+#include "k3-psil-priv.h"
+
+#define PSIL_PDMA_XY_TR(x, ch)					\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_PDMA_XY,		\
+			.mapped_channel_id = ch,		\
+			.default_flow_id = -1,			\
+		},						\
+	}
+
+#define PSIL_PDMA_XY_PKT(x, ch)					\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_PDMA_XY,		\
+			.mapped_channel_id = ch,		\
+			.pkt_mode = 1,				\
+			.default_flow_id = -1			\
+		},						\
+	}
+
+#define PSIL_ETHERNET(x, ch, flow_base, flow_cnt)		\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_NATIVE,		\
+			.pkt_mode = 1,				\
+			.needs_epib = 1,			\
+			.psd_size = 16,				\
+			.mapped_channel_id = ch,		\
+			.flow_start = flow_base,		\
+			.flow_num = flow_cnt,			\
+			.default_flow_id = flow_base,		\
+		},						\
+	}
+
+#define PSIL_PDMA_MCASP(x, ch)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_PDMA_XY,	\
+			.pdma_acc32 = 1,		\
+			.pdma_burst = 1,		\
+			.mapped_channel_id = ch,	\
+		},					\
+	}
+
+/* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
+static struct psil_ep am62l_src_ep_map[] = {
+	/* PDMA_MAIN1 - UART0-6 */
+	PSIL_PDMA_XY_PKT(0x4400, 0),
+	PSIL_PDMA_XY_PKT(0x4401, 2),
+	PSIL_PDMA_XY_PKT(0x4402, 4),
+	PSIL_PDMA_XY_PKT(0x4403, 6),
+	PSIL_PDMA_XY_PKT(0x4404, 8),
+	PSIL_PDMA_XY_PKT(0x4405, 10),
+	PSIL_PDMA_XY_PKT(0x4406, 12),
+	/* PDMA_MAIN0 - SPI0 - CH0-3 */
+	PSIL_PDMA_XY_TR(0x4300, 16),
+	/* PDMA_MAIN0 - SPI1 - CH0-3 */
+	PSIL_PDMA_XY_TR(0x4301, 24),
+	/* PDMA_MAIN0 - SPI2 - CH0-3 */
+	PSIL_PDMA_XY_TR(0x4302, 32),
+	/* PDMA_MAIN0 - SPI3 - CH0-3 */
+	PSIL_PDMA_XY_TR(0x4303, 40),
+	/* PDMA_MAIN2 - MCASP0-2 */
+	PSIL_PDMA_MCASP(0x4500, 48),
+	PSIL_PDMA_MCASP(0x4501, 50),
+	PSIL_PDMA_MCASP(0x4502, 52),
+	/* PDMA_MAIN0 - AES */
+	PSIL_PDMA_XY_TR(0x4700, 65),
+	/* PDMA_MAIN0 - ADC */
+	PSIL_PDMA_XY_TR(0x4503, 80),
+	PSIL_PDMA_XY_TR(0x4504, 81),
+	PSIL_ETHERNET(0x4600, 96, 96, 16),
+};
+
+/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
+static struct psil_ep am62l_dst_ep_map[] = {
+	/* PDMA_MAIN1 - UART0-6 */
+	PSIL_PDMA_XY_PKT(0xC400, 1),
+	PSIL_PDMA_XY_PKT(0xC401, 3),
+	PSIL_PDMA_XY_PKT(0xC402, 5),
+	PSIL_PDMA_XY_PKT(0xC403, 7),
+	PSIL_PDMA_XY_PKT(0xC404, 9),
+	PSIL_PDMA_XY_PKT(0xC405, 11),
+	PSIL_PDMA_XY_PKT(0xC406, 13),
+	/* PDMA_MAIN0 - SPI0 - CH0-3 */
+	PSIL_PDMA_XY_TR(0xC300, 17),
+	/* PDMA_MAIN0 - SPI1 - CH0-3 */
+	PSIL_PDMA_XY_TR(0xC301, 25),
+	/* PDMA_MAIN0 - SPI2 - CH0-3 */
+	PSIL_PDMA_XY_TR(0xC302, 33),
+	/* PDMA_MAIN0 - SPI3 - CH0-3 */
+	PSIL_PDMA_XY_TR(0xC303, 41),
+	/* PDMA_MAIN2 - MCASP0-2 */
+	PSIL_PDMA_MCASP(0xC500, 49),
+	PSIL_PDMA_MCASP(0xC501, 51),
+	PSIL_PDMA_MCASP(0xC502, 53),
+	/* PDMA_MAIN0 - SHA */
+	PSIL_PDMA_XY_TR(0xC700, 64),
+	/* PDMA_MAIN0 - AES */
+	PSIL_PDMA_XY_TR(0xC701, 66),
+	/* PDMA_MAIN0 - CRC32 - CH0-1 */
+	PSIL_PDMA_XY_TR(0xC702, 67),
+	/* CPSW3G */
+	PSIL_ETHERNET(0xc600, 64, 64, 2),
+	PSIL_ETHERNET(0xc601, 66, 66, 2),
+	PSIL_ETHERNET(0xc602, 68, 68, 2),
+	PSIL_ETHERNET(0xc603, 70, 70, 2),
+	PSIL_ETHERNET(0xc604, 72, 72, 2),
+	PSIL_ETHERNET(0xc605, 74, 74, 2),
+	PSIL_ETHERNET(0xc606, 76, 76, 2),
+	PSIL_ETHERNET(0xc607, 78, 78, 2),
+};
+
+struct psil_ep_map am62l_ep_map = {
+	.name = "am62l",
+	.src = am62l_src_ep_map,
+	.src_count = ARRAY_SIZE(am62l_src_ep_map),
+	.dst = am62l_dst_ep_map,
+	.dst_count = ARRAY_SIZE(am62l_dst_ep_map),
+};
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index a577be97e3447..961b73df7a6bb 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -46,5 +46,6 @@ extern struct psil_ep_map am62_ep_map;
 extern struct psil_ep_map am62a_ep_map;
 extern struct psil_ep_map j784s4_ep_map;
 extern struct psil_ep_map am62p_ep_map;
+extern struct psil_ep_map am62l_ep_map;
 
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index c4b6f0df46861..2a843f36261bc 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -28,6 +28,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "J784S4", .data = &j784s4_ep_map },
 	{ .family = "AM62PX", .data = &am62p_ep_map },
 	{ .family = "J722S", .data = &am62p_ep_map },
+	{ .family = "AM62LX", .data = &am62l_ep_map },
 	{ /* sentinel */ }
 };
 
-- 
2.34.1


