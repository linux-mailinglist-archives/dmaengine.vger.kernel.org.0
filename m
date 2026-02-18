Return-Path: <dmaengine+bounces-8955-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGUgLliMlWlhSQIAu9opvQ
	(envelope-from <dmaengine+bounces-8955-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:54:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ABD154F29
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89B9B300D752
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2418833E344;
	Wed, 18 Feb 2026 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dQHZcPUR"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D50E33DEE6;
	Wed, 18 Feb 2026 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408464; cv=fail; b=DBW/hTF+IMdVchLWuWqp52gdyli9im+9p4MALA4nuIC0obw4P+rv2XIsCo9engFPDceGzOI+Ywchx4UInn0gB867zNW0vEnL+fsjlnEGLcalxh6pMjU8FvlVslWPeKz78jZ9ZdPfCn1Z1mTwivJIXYAtaJ84Yn9EU8v8e9YtVZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408464; c=relaxed/simple;
	bh=U7d0hOvla9aPPOuYoTfPl5jrFJd9ENZ5wy9l0Rc5JOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMH/mMrrJDIS5sdlw4BFWpa70/wlttIjW1XnZC6VX1tHwi4t4h4GBYCfSfKl/+pKgHWIfZsUuUGtgagLu5WfVUxZWmJ+c/+sQiBLt2RcbV7iBPEi5pxx3Wv4C+AbbO77MXNlDaxHDgHxEL0duIMzvImb2QwzdyY720+rHO9Ns54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dQHZcPUR; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gH9oDp5avv8H2jgt0kdpY8nZ+e6jqlJaqgplSzfEXcy9on1eiRuUXnl8r92dts4kndIpcDL++Y2XKmQTziWCt7704zhgUegSwCQnXpCbzdbwJqWBFaWLPkYU5UJMMjsgYJw+10qtoUMwKIKrg7T+R6fV7UBVqzelp3ih5XxigcwaKlPS/UPcKAAkKbQuRzfZVHpUxGiCEjzMYNyVJPlzdzPaOO/uDS+GBEQVTxnf8rBbynCgqvvOItaBB/Z1BoQNSTuLmN+Tw75DtFYbwGIPs5/noFYcLwmH+fKxzjl3QnPI07b8yu6vNC1XIDw8oWNlD5xugGc4rPSBwZVkrNxuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up8uiAuYuoNA78nEIe93uxcJ/zm/FECWWclibKKJ8H8=;
 b=cHcctGKUgJRFCOTDsv+77g1hEFkfV5sYobN3BQIm8EevhN5zEo+h3qDiTZY1Uum2s9Z/qZvVmS9DLAG0+n14JCMT5ZrEsPOvNEtaPkK923br69JfA5nP6J1ikFP6bVhAcyC0A8wd2+2p3twzzhAu/2WsILzCBQL+z+nqAFp+qTNdNr5kVAb94AYOUVyuYf8SKj98hfEDKM2pdW25YMPsFBx8xZyKBRnuTRSNGjE3S/khwlovnYmXxK3xYAAC5ACu+xP7bp/1gcU2B78jkalLltO4JRdS2fuOhNI9+eo2JT63exSGIhobnDiMKmtPwcn4XmUudh04+XRNjImd3kMHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up8uiAuYuoNA78nEIe93uxcJ/zm/FECWWclibKKJ8H8=;
 b=dQHZcPURdtLUPRxrg9Nm/wbCJJgH+i+drtjW01a5MXycEN2gzS1mUYRdF3oUrdsOb7YAFlv4DmhM3/m7LJNwrFoHgaUk5RbLxuspt8k3ci7Y4oxoyx/r9t4HtYMv52zgSWudSHF7rJX+gWDrl1CqRCXbNNgwCsD63oNM5+Ae7vg=
Received: from DS7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::12) by
 SJ0PR10MB5565.namprd10.prod.outlook.com (2603:10b6:a03:3d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 09:54:20 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::c3) by DS7P220CA0024.outlook.office365.com
 (2603:10b6:8:223::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 09:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 09:54:18 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:54:18 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:54:17 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:54:17 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpIO200561;
	Wed, 18 Feb 2026 03:54:13 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 17/18] dmaengine: ti: k3-udma-v2: Update glue layer to support PKTDMA V2
Date: Wed, 18 Feb 2026 15:22:42 +0530
Message-ID: <20260218095243.2832115-18-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|SJ0PR10MB5565:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c782803-7b0b-46f6-fc6c-08de6ed3aef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iB6+uzcNecriEsdUW6BZ0SfGGmwEnD6TEFv3d9ePrBnA0zTr7hE3JHVDoM52?=
 =?us-ascii?Q?tYB/bFf2ah23n6Up7VJOWHBrDGwIB/KTy/BdaqmK1ry3NN9/5xPt/8WWdzam?=
 =?us-ascii?Q?5MuBW/RIzN1jzlPMbV15Q5qYR8rq8qg5j2b8U5mYlniqml8qCqa86Up/MUsT?=
 =?us-ascii?Q?O6h44BjYmbkjzxAEQ6CZm/WglD1l9PLZ+anewGngSmQEGi4DpxW/CURLxQ2O?=
 =?us-ascii?Q?47Jmp1ihSHety1JXFq+qTFc48o0LpyfiJljp3VI7OM0QfN1y6WBt1YhX2HhP?=
 =?us-ascii?Q?A4tucyEKZeGEtjCn28kjH1/A9IiRnV+JCMhL3L7TlrebpR1J8LzCFHpujeqY?=
 =?us-ascii?Q?TGrdWeRDWakRSRMQG5SIG7kefNopnqFtPOmRr4Hp6F6p1AG4BD98F/DRJPWk?=
 =?us-ascii?Q?h2oVHq99JRCb14ZkRCDLbN12YiYgeMeEC3CAf1teDy29wcJFi2BJTdJGToaF?=
 =?us-ascii?Q?cbunMHRPX2kXwSYLTPazHDtnvSdGxF3+7uKZZfYnE1byTnydwGqdXwxwLQ0M?=
 =?us-ascii?Q?6TOwk0D7N7rMT75Lway1ywpywRbnL1UlIY8J0KEklhQlRb8GPIKOgG4j/WYP?=
 =?us-ascii?Q?zc9KgV4aLtlQ3fG5FT2QWIcDNORZfNQUtEVeUtlbetHfGoHT9j5DkKe7Lhj0?=
 =?us-ascii?Q?O1yzRUHLlyHiY4jZZ+QiI8bbTSPgfTOO2znuuQmozDuPdkZpB7OyuoOwcldH?=
 =?us-ascii?Q?Pz8jJWurH0Kd+TLGRdTNhTi2YgcWs/Z4LIRjsUVSPfytWKlJWZH47b/qt3Y4?=
 =?us-ascii?Q?n6v30+yYrJ4NK+H9Lw2QzEf4kpXWz1pcfEbLoYoRKlOIsvs3TVS4ZE9sqbKw?=
 =?us-ascii?Q?1Xy2gUnmWZ1jNqbv186EiyT3zjHM6a4/swzzroaub6gVdbTZWukNodZjjplO?=
 =?us-ascii?Q?jbGmVbIazZWxt63lFCnahF5iFpFGW1Obu9OAO8nyP7xqpRZ6GbBYwBhSARN6?=
 =?us-ascii?Q?Uo+iMzhqA0AyLhMJPqdcE6YCiGcoZEsWqnMa5Zu/38/EHj2VUJWkJUX5TrHX?=
 =?us-ascii?Q?I34uvX86DcPshsgRGefgMrlersTpM2mNMvHV2maxIUNT7KZuqJYvgToB9ZSR?=
 =?us-ascii?Q?NFEuhwCvxVIU+qmoEgH3R91kmWVMz4Yu6i/x2DmrAuoZF9mj1Rz//CnfrZWT?=
 =?us-ascii?Q?UQ/sv8iNOnYu+PnAgcqL/dRQ9d3Hg6aH4oafJyyQ4wa6Ic2fOdsI9Wj5ZPer?=
 =?us-ascii?Q?bGrPm3h48fmijSEO0bzIpHYL6VBYUKyxS1od4p4iVC8n4yHL4ghUJ7ERjoRX?=
 =?us-ascii?Q?H0GtW0cI+s5X8hnxcWxhbXVZS3V1xsTvWaJa3Cpo+GyxzUDjeLRzjVixhNBm?=
 =?us-ascii?Q?t7HjCUZGNImGr1fh04xG7nvQ4EicLU+wYX3a2yBqcmMQvtwO5NUxKA8YFPGC?=
 =?us-ascii?Q?KCRPq0gnqEbG0MNNNjq0If6BOhtArUlBx9WepVbZc1KttDugz7a7s/locFqS?=
 =?us-ascii?Q?bgNgKYudAw7Wpx73MLLFgopd2S4PUbVyskWULfgn6PPcogQrLQCzVNb9UrG8?=
 =?us-ascii?Q?/9Vby+dNijDEpmnWnVf+aqW4IBP6KztaX+scHMGJ96Q4bryAD+K6ftex5o4C?=
 =?us-ascii?Q?fLIL+5LVr8Kh4KqSLA0siO1ZiBJGkVjaLEavM/8Vs8uvUm2tQKrESb1xb/Jp?=
 =?us-ascii?Q?5GSaLJMJOxo9zWZjtIL7ooE=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4uzgDLVfM64wht12RQRqYjGOtxoGGK93uwfIi0KXsWTAAEYAcAIda8CfIRt2b3+gkESoFZynqDlbY0s2HUmAD8Vm9sCthyRuNE9AhqS9RmtU5XUBG78eOeEOJYE/MHn2AfRYg90WlvjH9KRkhR7IpDrj8RkMiiS/KSQnnk0X+52pCh76RFy5a+eZJONdfTuMYdLKdx3HXHU2+X7P2nxuIh7adnVXewiW85Eh3I0OqlxXNFINac/CdRw+3KlP56KABCeu9ZESUWCw+K26+TZcojBFedi1C4RfEPSXFEA7cjGZb7S4EwX9hO3hV6dA1BU8O7OSVJdylq4CUOMi9Dxv2rg5OAYW1x9Y7WPhtjLqMMtLKxNWX+H+PjiYZVnyZ/ujZ37OlR2dvKYeEELnEbQUxHfy8dI6u8iS61A1/AGgpZ26F4lslIClDCn6YI+W0NjZ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:54:18.4875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c782803-7b0b-46f6-fc6c-08de6ed3aef7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5565
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8955-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:url,ti.com:email,out_irq.np:url];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 59ABD154F29
X-Rspamd-Action: no action

Update glue layer to support PKTDMA V2 for non DMAengine users.

The updates include
- Handling absence of TISCI
- Direct IRQs
- Autopair: Lack of PSIL pair.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/Kconfig           |  2 +-
 drivers/dma/ti/k3-udma-glue.c    | 91 ++++++++++++++++++++++----------
 drivers/dma/ti/k3-udma-private.c | 35 ++++++++++++
 drivers/dma/ti/k3-udma.h         |  2 +
 4 files changed, 101 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index 40713bd1e8e9b..ada2ea8aca4b0 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -68,7 +68,7 @@ config TI_K3_UDMA_COMMON
 config TI_K3_UDMA_GLUE_LAYER
 	tristate "Texas Instruments UDMA Glue layer for non DMAengine users"
 	depends on ARCH_K3 || COMPILE_TEST
-	depends on TI_K3_UDMA
+	depends on TI_K3_UDMA || TI_K3_UDMA_V2
 	help
 	  Say y here to support the K3 NAVSS DMA glue interface
 	  If unsure, say N.
diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index f87d244cc2d67..c6b012c698071 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -244,6 +244,9 @@ static int k3_udma_glue_cfg_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 	const struct udma_tisci_rm *tisci_rm = tx_chn->common.tisci_rm;
 	struct ti_sci_msg_rm_udmap_tx_ch_cfg req;
 
+	if (!tisci_rm->tisci)
+		return 0;
+
 	memset(&req, 0, sizeof(req));
 
 	req.valid_params = TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
@@ -502,21 +505,26 @@ int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 {
 	int ret;
 
-	ret = xudma_navss_psil_pair(tx_chn->common.udmax,
-				    tx_chn->common.src_thread,
-				    tx_chn->common.dst_thread);
-	if (ret) {
-		dev_err(tx_chn->common.dev, "PSI-L request err %d\n", ret);
-		return ret;
-	}
+	if (tx_chn->common.udmax->match_data->version == K3_UDMA_V2) {
+		xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
+				    UDMA_CHAN_RT_CTL_AUTOPAIR | UDMA_CHAN_RT_CTL_EN);
+	} else {
+		ret = xudma_navss_psil_pair(tx_chn->common.udmax,
+					    tx_chn->common.src_thread,
+					    tx_chn->common.dst_thread);
+		if (ret) {
+			dev_err(tx_chn->common.dev, "PSI-L request err %d\n", ret);
+			return ret;
+		}
 
-	tx_chn->psil_paired = true;
+		tx_chn->psil_paired = true;
 
-	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
-			    UDMA_PEER_RT_EN_ENABLE);
+		xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
+				    UDMA_PEER_RT_EN_ENABLE);
 
-	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
-			    UDMA_CHAN_RT_CTL_EN);
+		xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
+				    UDMA_CHAN_RT_CTL_EN);
+	}
 
 	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn en");
 	return 0;
@@ -682,7 +690,6 @@ static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
 			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID;
 
-	req.nav_id = tisci_rm->tisci_dev_id;
 	req.index = rx_chn->udma_rchan_id;
 	req.rx_fetch_size = rx_chn->common.hdesc_size >> 2;
 	/*
@@ -702,11 +709,18 @@ static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 	req.rx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
 	req.rx_atype = rx_chn->common.atype_asel;
 
+	if (!tisci_rm->tisci) {
+		// TODO: look at the chan settings
+		xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CFG_REG,
+				    UDMA_CHAN_RT_CTL_TDOWN | UDMA_CHAN_RT_CTL_PAUSE);
+		return 0;
+	}
+
+	req.nav_id = tisci_rm->tisci_dev_id;
 	ret = tisci_rm->tisci_udmap_ops->rx_ch_cfg(tisci_rm->tisci, &req);
 	if (ret)
 		dev_err(rx_chn->common.dev, "rchan%d cfg failed %d\n",
-			rx_chn->udma_rchan_id, ret);
-
+				rx_chn->udma_rchan_id, ret);
 	return ret;
 }
 
@@ -755,8 +769,11 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 	}
 
 	if (xudma_is_pktdma(rx_chn->common.udmax)) {
-		rx_ringfdq_id = flow->udma_rflow_id +
+		if (tisci_rm->tisci)
+			rx_ringfdq_id = flow->udma_rflow_id +
 				xudma_get_rflow_ring_offset(rx_chn->common.udmax);
+		else
+			rx_ringfdq_id = flow->udma_rflow_id;
 		rx_ring_id = 0;
 	} else {
 		rx_ring_id = flow_cfg->ring_rxq_id;
@@ -803,6 +820,13 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 		rx_ringfdq_id = k3_ringacc_get_ring_id(flow->ringrxfdq);
 	}
 
+	if (!tisci_rm->tisci) {
+		xudma_rflowrt_write(flow->udma_rflow, UDMA_RX_FLOWRT_RFA,
+				    UDMA_CHAN_RT_CTL_TDOWN | UDMA_CHAN_RT_CTL_PAUSE);
+		rx_chn->flows_ready++;
+		return 0;
+	}
+
 	memset(&req, 0, sizeof(req));
 
 	req.valid_params =
@@ -1307,6 +1331,9 @@ int k3_udma_glue_rx_flow_enable(struct k3_udma_glue_rx_channel *rx_chn,
 	if (!rx_chn->remote)
 		return -EINVAL;
 
+	if (!tisci_rm->tisci)
+		return 0;
+
 	rx_ring_id = k3_ringacc_get_ring_id(flow->ringrx);
 	rx_ringfdq_id = k3_ringacc_get_ring_id(flow->ringrxfdq);
 
@@ -1348,6 +1375,9 @@ int k3_udma_glue_rx_flow_disable(struct k3_udma_glue_rx_channel *rx_chn,
 	if (!rx_chn->remote)
 		return -EINVAL;
 
+	if (!tisci_rm->tisci)
+		return 0;
+
 	memset(&req, 0, sizeof(req));
 	req.valid_params =
 			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_QNUM_VALID |
@@ -1383,21 +1413,26 @@ int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 	if (rx_chn->flows_ready < rx_chn->flow_num)
 		return -EINVAL;
 
-	ret = xudma_navss_psil_pair(rx_chn->common.udmax,
-				    rx_chn->common.src_thread,
-				    rx_chn->common.dst_thread);
-	if (ret) {
-		dev_err(rx_chn->common.dev, "PSI-L request err %d\n", ret);
-		return ret;
-	}
+	if (rx_chn->common.udmax->match_data->version == K3_UDMA_V2) {
+		xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
+				    UDMA_CHAN_RT_CTL_AUTOPAIR |  UDMA_CHAN_RT_CTL_EN);
+	} else {
+		ret = xudma_navss_psil_pair(rx_chn->common.udmax,
+					    rx_chn->common.src_thread,
+					    rx_chn->common.dst_thread);
+		if (ret) {
+			dev_err(rx_chn->common.dev, "PSI-L request err %d\n", ret);
+			return ret;
+		}
 
-	rx_chn->psil_paired = true;
+		rx_chn->psil_paired = true;
 
-	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
-			    UDMA_CHAN_RT_CTL_EN);
+		xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
+				    UDMA_CHAN_RT_CTL_EN);
 
-	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
-			    UDMA_PEER_RT_EN_ENABLE);
+		xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
+				    UDMA_PEER_RT_EN_ENABLE);
+	}
 
 	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt en");
 	return 0;
diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index 44c097fff5ee6..45a71f87c54ff 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -3,6 +3,10 @@
  *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
@@ -165,6 +169,7 @@ void xudma_##res##rt_write(struct udma_##res *p, int reg, u32 val)	\
 EXPORT_SYMBOL(xudma_##res##rt_write)
 XUDMA_RT_IO_FUNCTIONS(tchan);
 XUDMA_RT_IO_FUNCTIONS(rchan);
+XUDMA_RT_IO_FUNCTIONS(rflow);
 
 int xudma_is_pktdma(struct udma_dev *ud)
 {
@@ -174,6 +179,21 @@ EXPORT_SYMBOL(xudma_is_pktdma);
 
 int xudma_pktdma_tflow_get_irq(struct udma_dev *ud, int udma_tflow_id)
 {
+	if (ud->match_data->version == K3_UDMA_V2) {
+		__be32 addr[2] = {0, 0};
+		struct of_phandle_args out_irq;
+		int ret;
+
+		out_irq.np = dev_of_node(ud->dev);
+		out_irq.args_count = 1;
+		out_irq.args[0] = udma_tflow_id;
+		ret = of_irq_parse_raw(addr, &out_irq);
+		if (ret)
+			return ret;
+
+		return irq_create_of_mapping(&out_irq);
+	}
+
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 
 	return msi_get_virq(ud->dev, udma_tflow_id + oes->pktdma_tchan_flow);
@@ -182,6 +202,21 @@ EXPORT_SYMBOL(xudma_pktdma_tflow_get_irq);
 
 int xudma_pktdma_rflow_get_irq(struct udma_dev *ud, int udma_rflow_id)
 {
+	if (ud->match_data->version == K3_UDMA_V2) {
+		__be32 addr[2] = {0, 0};
+		struct of_phandle_args out_irq;
+		int ret;
+
+		out_irq.np = dev_of_node(ud->dev);
+		out_irq.args_count = 1;
+		out_irq.args[0] = udma_rflow_id;
+		ret = of_irq_parse_raw(addr, &out_irq);
+		if (ret)
+			return ret;
+
+		return irq_create_of_mapping(&out_irq);
+	}
+
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 
 	return msi_get_virq(ud->dev, udma_rflow_id + oes->pktdma_rchan_flow);
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 642d8fc8f3175..8afcd69bc0d76 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -743,6 +743,8 @@ u32 xudma_rchanrt_read(struct udma_rchan *rchan, int reg);
 void xudma_rchanrt_write(struct udma_rchan *rchan, int reg, u32 val);
 bool xudma_rflow_is_gp(struct udma_dev *ud, int id);
 int xudma_get_rflow_ring_offset(struct udma_dev *ud);
+u32 xudma_rflowrt_read(struct udma_rflow *rflow, int reg);
+void xudma_rflowrt_write(struct udma_rflow *rflow, int reg, u32 val);
 
 int xudma_is_pktdma(struct udma_dev *ud);
 
-- 
2.34.1


