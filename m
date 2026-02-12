Return-Path: <dmaengine+bounces-8893-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qItwAVvbjWlm8AAAu9opvQ
	(envelope-from <dmaengine+bounces-8893-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 14:53:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B50212DFDA
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 14:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF3373044379
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3FC35C1B7;
	Thu, 12 Feb 2026 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xtHIklir"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602AC35C1A2;
	Thu, 12 Feb 2026 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904337; cv=fail; b=or0+S19GX6QVwzUTIliGGq8VGufrIgWNkZxe1j9adxpWv7E5ze+ztF9IoM1VpbVPBqrVagf7A5yntU17F2sAKw/KogaSwbQyS8l5wVHseG1CuzD6Ug6NINrxApa4BN406FOH5cbQuX59m5h/ztTZr7wx0Mgm6ognuis3/KvdYa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904337; c=relaxed/simple;
	bh=u6tVDoOSHqFtt4mPte2R7VTjNNVHO2n8FX9EqljW8uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9yonwH3MeQ6vNhN2xeVWg9/83tvLe5MChrse/mk4bsJWKeoqYIusAhOfTvIa7WxrIhCDGC/2RnH1v2Ek1jbtw+CuakhlixVKiVEUC6Ddu0Tz9Ryz/zwv/nAUBRNNTBDc6IruRpeNc/Pw9qQJAwhe/7wG2UzAe4CUEV7kfF3ZJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xtHIklir; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8CKaHT51sB/oF0pbFtkQmt8xxjTQpmWisCp/6uCmHmdQdkdKQhktUXKdnIUkjl0HMbSflSXWWNbkTkgLcvTrLKJSqP2Xa9cv35ZRdwsHovvksEJZUtsqGG4iDJd6qFIRSjRofMtihe6XA1hd/h1H1j9zYRhv+jIdfhqbdX1GcwN3gnbx+N6yhnTZa4g7lgnbBtFhGFxk5oBYFcw/qYO/9U2IdYcsWBuvIy7ufoAOYKnmBQlLaks95evUuE0l/sZ+nxxJflfCFi8VEiXpI5No1cVdhiND9rl9cDTnNDHMjQZctEOKcpcHMDSV1yoxfzprYVS37F3RM+TmrcZvLaYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ox5iypVEuvCzxMhHxoD6pt8edsVORHlNCY7am/yYHd8=;
 b=ZpC6XAi6oGza6ewK0fYPz71pz8B0w/nuE9RGv95H3fzkDR7NldOOgWPYTFhRF8Uek8Jan2bwgRmAMcZZacXqmMIGZzX85dH4aupik1CvUKmJXj8hNpCCop1pUrrHK5ad5CmR6qvLNmsoxRzZkrnjopAso1sj4vaYRcTnUW5vcDt52NiLJhqO9zy7mhaR4ElPH3b8RHFgdPcXJ/zlx/kzb0xK6bJC4f9kULzZsAgGg3YuM/OV95EcUgpdfcGJETLeDwwqZOzHJwPHdgpCe0HFT4JuyfCevXsaAzYD5924EhMh671o7ZSgaEWJHLE/s9VFm70yCNcXSL1hb9NyYIBLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox5iypVEuvCzxMhHxoD6pt8edsVORHlNCY7am/yYHd8=;
 b=xtHIkliryJEoE0/VCndoKvyXsVwbqYIvEy438aRauPekll/oycWNilNRTXkQidpREkO/G/yASnezIsjQY5E25WgZFeRHZGLoiRoJdjHPE60hz+bu/zRIHeihZpYQ3zYfn1Q4Fi1/+/0RHigu0MZXYSh5V8bEHVzGU5p2JBcHCgk=
Received: from MN0P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::34)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 13:52:10 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::2b) by MN0P221CA0014.outlook.office365.com
 (2603:10b6:208:52a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 13:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 13:52:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Feb
 2026 07:52:09 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Feb
 2026 07:52:08 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Feb 2026 07:52:04 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <vkoul@kernel.org>
CC: <michal.simek@amd.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <suraj.gupta2@amd.com>, <abin.joseph@amd.com>,
	<radhey.shyam.pandey@amd.com>, <dev@folker-schwesinger.de>,
	<thomas.gessler@brueckmann-gmbh.de>, <tomi.valkeinen@ideasonboard.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [PATCH 4/7] dt-bindings: xilinx-dma: Extend 'xlnx,axistream-connected' property to MCDMA
Date: Thu, 12 Feb 2026 19:21:43 +0530
Message-ID: <20260212135146.1185416-5-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260212135146.1185416-1-srinivas.neeli@amd.com>
References: <20260212135146.1185416-1-srinivas.neeli@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: b7189feb-945c-46ac-8c4a-08de6a3deaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sIqJ/xeZTbODmVR0p/ubTahKTFJPn95uQiPW9mbFUCbGpeYjlGxtovzSSIEH?=
 =?us-ascii?Q?aGLqfZOb+AEJ+czp/G46Kh8AzLpeChFckXvKWzYOPDpVW/PdOud0Di3cQkRB?=
 =?us-ascii?Q?uZ3ptGEx4zgsAl/mvJskMiuz5EBo78RDFzjG+9BJeX7XGe8Njq11+G26BSVn?=
 =?us-ascii?Q?5FKxce+m6ohl8Xr8P8xU5tAh9SNbr1md3ATos8bNKJIhde1OvULAnMJmFLCa?=
 =?us-ascii?Q?AqGV3kkbrlsSdK+lUknKapadzvPviXn5DeDqJX7oyp5/SN114ryyI0YnoxxX?=
 =?us-ascii?Q?G0873jp0k19E3e7K1gY1RDJ0wDc+JRCc7y8NmCEy2CE5UYCDxf21+jjYMRse?=
 =?us-ascii?Q?lue7IetGR0IfwW5oliUJMgMIwXb+KhT/iOVNoZPqEtB8GvEWUoerTcRWyyVf?=
 =?us-ascii?Q?cGDqdpDreWS6KTpAhe7jSeZjYfKUu+ltsLHs3k6K2f7rScNZCioVsHNdpWGs?=
 =?us-ascii?Q?QiMihWE2MfC9SU8ZL1DPJXf8wkumUquL4uUyPq6e4iFb1Wc0lp56eg28Er9R?=
 =?us-ascii?Q?lORUqp1UjyEZZPjtzbTLrt+49RA3VWb/q+bfdblfko6XDrSB/hi5B+dFrJzN?=
 =?us-ascii?Q?vHq4d0gK0b96Xf/i0Xb8bzZsBN5Fr7W2quL7WJeV/HwodWTlBC97a6XTrLh9?=
 =?us-ascii?Q?Wfv11XZZ7N/CjX0ZbvAHQKUm2Isjx+gs4OgwFMzDla3gltF9GzpgWf4dwaf0?=
 =?us-ascii?Q?3ApH7lWsb5laxz0EUKCKE4KV0rAhGPG2FAOL8Qb+O3Bn8+OlKbnU11UnvB3g?=
 =?us-ascii?Q?+4DGKfeE9ejJQ/ikFRFuv55ELQ8n+4JTTVgf9mW5E8rfqZ/P60wcD02hTLZT?=
 =?us-ascii?Q?7DIQ66soStNfru0kKHii9/Y2xlUY6m7bB363FPGeJHhBemksQ4hwTvDHMuyG?=
 =?us-ascii?Q?ePba3TBZVA0I4xmq51VIlkcA62L+TT6CkQh+okKJOn3bgJu1uQlKHqSg2kOE?=
 =?us-ascii?Q?lPJPCEp7oszUdUmOcq+ShLYzpX/WOPogevZw70cfQXamdNygpn/4bVG14CK5?=
 =?us-ascii?Q?Toh5jfA9SIXG0Hu6q00F13vWs291fJPzby+oaamR2iTxvDCtVqEPOW39O2Tr?=
 =?us-ascii?Q?xZIpn/5LTmSVIwB4woqFEnjMAmzzK1Y2Z/+3TqrOrM90Yl9yxTemLGx1et1C?=
 =?us-ascii?Q?U4I3AXRzYb+WWoSiHx1bayCl43KtBT908BGV0tOMLDpccBYsvayL+y7pjmoK?=
 =?us-ascii?Q?RlSFr5xQE/HuMGDC3IL8aIylavj1/+cAE06Rn1JKyf6gYjVG57wmHmSHCi8b?=
 =?us-ascii?Q?Ivy74jlFEXCDzzU6m+KGA6s1awJO68ob6uvjUuFTySxSiXrkh7RxLBY6//21?=
 =?us-ascii?Q?K3/oDykjJxtdjvxYlJYS0KD4UYM5W1xbYOTpabK3A8bnHz5zjmnPbEQetGGn?=
 =?us-ascii?Q?eIn4zIFbwI0+9zZoNUbeNQWXliHfsHkn0cWnal8QRBHB38C+CtY39LHJwflW?=
 =?us-ascii?Q?72QjNui5DwVJJvAzSZ2V8Vq88Qh8pyFlI9w7etK3kIypkBdgb7tKCvwssl3v?=
 =?us-ascii?Q?GxwEXMXZaBMLN/b7opcH+ng8jqOAbCWU9yaPWp/pJLnJZLl07NjL9y1Niuyf?=
 =?us-ascii?Q?6znt2InFiIunCiArTgkLckBBzwByCfXc//vK6b6Ua7ewmnAxP68hq9jae1B2?=
 =?us-ascii?Q?a2Y/J6AEDRzUS2qEPilqmCpmHTKYT5gNmQS6D6dUf06SAVsQWSRLVoSEIaOR?=
 =?us-ascii?Q?w7RaWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6D8jtImuSezbb1iZfVKnIBUypt4ROr+PhV/y8xHdTlfysg0w7U7igeaueKHZl68/lH2qjIxNvp3t7B5XtOuf0mDK24znWRgHWWDbuPXOflUsjNaPBW8+SAWDbqYt8PH+b6XbE8fVqEKqEWRR4g7aFoPl3DB1tJc5CdH++tTy+22NZz+pSB42zZnNsJs1z30BrX5RY/Cq05ge2+Ij1h27LUiuXlbHSB9gYsIV11kSFmObVJLZvnhhdzP9lpxZ1h/2b48B/mqS/2UV4dnbZHyCHSwngQi8olHjugGiv1bajc0RQUhlhH2GdkX2Eyv8nOpXuZNNDilC65x2qnIoRh9eI6HeAt7MDL6B6O6o/2Juw6l9lrV1ymEUYd4XICRbk5grrYYMBc2jr4YU0HsqUpWvL2GUNwXZoshembfQVEc5ukrJRlNHtyVJ4iKkYjj9ipNc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:52:09.9747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7189feb-945c-46ac-8c4a-08de6a3deaec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8893-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1B50212DFDA
X-Rspamd-Action: no action

Extend the xlnx,axistream-connected property for MCDMA IP. MCDMA also
supports AXI-Stream based designs, so the same property can be used to
enable stream-specific behavior and metadata handling.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index c9e75ce23d55..cab66742e168 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -52,9 +52,10 @@ Optional properties for AXI DMA and MCDMA:
 - xlnx,irq-delay: Tells the interrupt delay timeout value. Valid range is from
 	0-255. Setting this value to zero disables the delay timer interrupt.
 	1 timeout interval = 125 * clock period of SG clock.
+- xlnx,axistream-connected: Tells whether DMA or MCDMA is connected to
+	AXI stream IP.
 
 Optional properties for AXI DMA:
-- xlnx,axistream-connected: Tells whether DMA is connected to AXI stream IP.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
-- 
2.25.1


