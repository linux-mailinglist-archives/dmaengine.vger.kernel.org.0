Return-Path: <dmaengine+bounces-8926-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SORyEOanlGkRGQIAu9opvQ
	(envelope-from <dmaengine+bounces-8926-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:39:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2E414EB12
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F86306B09E
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1144336F436;
	Tue, 17 Feb 2026 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UJrRZ9Zc"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A58371060;
	Tue, 17 Feb 2026 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349830; cv=fail; b=Ls0sMdfJB4YUSROYR68LTdWO9PmLvfiEZQWmzMIt2CvTqCbJNOFZl2HXX2LNEfx+79riLRa+zdFljGwLlLKL8ExOZX7Xs+E2bjXnNAOJotwXLIV3KlHSQsigpSJmABt8VweRJynx9Nkpm/ypstOKJSUDlooPG/L5cqM3ScddRKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349830; c=relaxed/simple;
	bh=rizEGsCZe/iZu9Vfgqsqplo+sD3lf4kZ9FovUxZ704o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ys6+B3pVythBMw/P9XJPkziysbUB58cXhXLDa2GDNbTwW6c6IAoCwWsLB45fjAdexGptddo1g5KaG9cqd6r+FCHuxJk325wiAZGBEzjsA7Wd8K7vmAz5vjQ0W59lUn1Bgv9UJ0kiX13kxZ/NCCDiQw+wOrNCdWRANxwu9gHkjhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UJrRZ9Zc; arc=fail smtp.client-ip=52.101.62.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caSl7/EzefD89g/uzDcG7E0KuDSHN9+EJxSyrri9t4DoUjGKLYDMw9L73LU/zYHCF+ZaNchcDZLL8Zv1EplQwcvUzp71tZK9heiRzz2M8XNvuNuwp+cINyuOjzwV4ICxgIP+BjlsTbieuRYt8ag0vQ+OKxcEMPEFyCZWK1jEJTDX9NRu0s5XEEPe2tT2vwdRy6vsc5oX7duznAsZiNvNIPwsj6p7eak8YsddNbDyRNitIqwfHPs6XKjrT77nXiK/calQKWbtzieY2YKlrh+9fFXa2YYDozUXKFDmBskqU+yfSpzXn/M8C2O5Rh/YFpsIH22/ScOsDXyhQ5ajG/PVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TK9Nhi9Axiveh8iWO51kbJf96NBrHukqrxnF0wO15E=;
 b=bpvY9JLjF4/1Uxgo6kb27tHY94LOR5Mzo9BT/ObYp4R4ks6KSlQrPSo+lCUJYnErn6ektWQuY684W7Okx/GbGv2/CCgMyrI0AxDJoCs0DyCE9BizSuuptHhXfmoZSMv7YXCZWMOtK5aArO816bWnkDOtNQwxe7HvF95AgdzJa1FEOtULpj7MP69hTuy8tik89av3Xk2mMpzutgazrrjS89lg6i3lzxpFnMbt7VdqAr3BDSY5JoBTYKJ5/r4kw0vwkWxwFHlbHPf0Y6jpmAzTMF/v4WucqNpQR2MiYVoLf+0mXiTb1gLJnimrnxuEwA2vVMsnSoOB+G4LugolHVoGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TK9Nhi9Axiveh8iWO51kbJf96NBrHukqrxnF0wO15E=;
 b=UJrRZ9ZciXBYGQCWm0uEUtq8SQ1EO01wL4z8GHTS1WUEVwoi1Ft+029bBEFlw7ej8TQoBCQ+ihwz3uoEv3XWNz1xYhMPyj2HnsugObHAyFyMiFu6W7GgbwqbrRt/XekUCziUhNqGA9aYzjOOwjTpzqehBH5VvCssestvJCdWT/st6LTeZP1qB14HGfcsp8O87/q4hrLh63vT0bXvvS4tW8We8fSTNLC8IEsyPjZ77gNI8RN5CymHPHSZNH9zVNo6neFCah9RHRq804vc4Xig8rkiUuDq/8V/6kiOSVmWIj+lBunAlcxl4eUzZQKenuFRHLJ/GjAFZRzh7cMi5KFhMg==
Received: from MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::13)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 17 Feb
 2026 17:37:04 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:531:cafe::a8) by MN0P222CA0003.outlook.office365.com
 (2603:10b6:208:531::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 17:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 17:37:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 09:36:46 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Feb 2026 09:36:46 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 09:36:42 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <p.zabel@pengutronix.de>, Akhil R
	<akhilrajeev@nvidia.com>
Subject: [PATCH 7/8] dmaengine: tegra: Add Tegra264 support
Date: Tue, 17 Feb 2026 23:04:56 +0530
Message-ID: <20260217173457.18628-8-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260217173457.18628-1-akhilrajeev@nvidia.com>
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: d830830a-6aa7-4276-e130-08de6e4b2a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U46j1Gk0AIWUl7DHFx6Rq9ExADOeMgb5/SenzlBob7k5t6o3Vq0hMHzguTLr?=
 =?us-ascii?Q?LIGGWh8OI1+uk/RwtRY7TZmIl3uoGvnQsLYIRSqAScAwDT4M8ChobH2/P+EQ?=
 =?us-ascii?Q?vc83zRnL7KhPE5KJdoQXUsrR05XOAJCyrANQK8QsimMJdUKHU9iZ2eFZLUmo?=
 =?us-ascii?Q?oRtQ8IwqdP8ru6UuOPlzDrjJo4b4IZyTB+Aj5xA7GtylI2NNnb+Cv9P0vo2l?=
 =?us-ascii?Q?TFMB9u7IvPP1doQhEVaw3A0ztfdnh5MIORdv33sTy6rfXgpo6WvtlWNfB1FL?=
 =?us-ascii?Q?7a4UT2d2n1k+qP0LFN8x3Zo4W/kmOq9IigpQ8HOJVCmEThgIggFGTS5Ku8Ma?=
 =?us-ascii?Q?Pa/Ts+yitQOx29N7gkL7RaJZubeqO0mOElIppSvOY6fAfUIo3AKFCTCyFz1N?=
 =?us-ascii?Q?GsMHg8XqwK70jlvuxL6GRaZAl2aSVMm6/X9+cadSs5ncJ9xBrnlYrwKxDV4T?=
 =?us-ascii?Q?diXG+S0uuTo6N9uUeX1Pikjj8dtBvMdy5fZq1iHGZF6etihHLw1NEsF/IFXr?=
 =?us-ascii?Q?q5cjCUO8mx9+RvPDvGyeAChBejAS+L0bTdfBnhRkHfw7jbfsj7abo6/XrXd4?=
 =?us-ascii?Q?dV78c0GNNPdxFy6/BBjiW2yuznq0g/OFGpB5+YAj7qIWoGcKExL+IJIgMswQ?=
 =?us-ascii?Q?mRTOJcOhMDZogQLTXgRBnD9wjkzVsSp7uI3ZVzxNhy6WuEl2/BZ7wJmZKtrz?=
 =?us-ascii?Q?Lf+i+I3pWSSCHn/nE+Xfq1Ga9rMDdcFSvLBzx/iYXfhxGeRV86t83xI1VBDb?=
 =?us-ascii?Q?vo7is2SaDKMZFLWB8U9vgZrLmuMzkol4/NBAn5wdNB2Yhu3HsmfX4WuHBLLW?=
 =?us-ascii?Q?VJxZ/1AnNeB/RJTdekvb/tAvcry6ZoC1D5AJDU8YhrntE5kgF3PFFqGnSipB?=
 =?us-ascii?Q?K4fktBgvBL22UxpWo/2GjOPWSzuSx9fe8Msu6yGtokSad7rKhuGdT1ZVq2Us?=
 =?us-ascii?Q?ZRl4snJMHOzVIZAQZIidIE5fa7OBcC8pNFnu3h4EXMF21nO6QRuHxWZk46jB?=
 =?us-ascii?Q?RvHaOT3U+bB2n6ecqVGwNlIUMvH6uWUeOqjZUVPJyt4B0WgKFYrj+xYkN5n6?=
 =?us-ascii?Q?5HGl9v/vI4/C8UhC33a8a/gjym4Po2wJJaqXTRe3CLKixv1edI7lA3dq4A6L?=
 =?us-ascii?Q?aCSjs64cPEqSMnwaC0XqTQTQciFICprabCJzyfezlXYLHMAw1F1dwV3mZGfn?=
 =?us-ascii?Q?kWcxNhcJS2j4mWKrPG9yd9342rzxXRTXm5cp4WV3YWgEOLz8kKJ7wAA+XarZ?=
 =?us-ascii?Q?nhFxXEwHMGOLugpHGBoCWnKZlpU3VYwJvFNqVsaXQMAJtNIY+63wWSLhPhSX?=
 =?us-ascii?Q?F0OVRpFvaJPS5O/d5Qnnip/FmlmYd7hOKGENaAZsr9Q0fU7GtUr0AQbE0j1G?=
 =?us-ascii?Q?g0MISt34VIUE3pYU76RRd0RzeEbDKZMyvtjKYCg6pk2jGiBiT+QYmKccE28h?=
 =?us-ascii?Q?sHoYjFJpNx0tCYVOhG3WV0++mV09HFVXX3Rin28JE/THnOdvNA5Lqk8/7GS7?=
 =?us-ascii?Q?R/aByL2dVpSa1qjiSvAdqdFGXkCf/W66oLlWRAIQh0m1I72AuQURoXNvIYQ+?=
 =?us-ascii?Q?ByEhlgXW2IwHMLMQYZ0IGBXI7jsZyVlHC5kmLfTESCHRxHc7HbOxuPLtC69y?=
 =?us-ascii?Q?SQAhDa2ms1spLx/cPU+8qusP78EKmtoN4PuCUS4MdrvtB120jU55rH+H9XuM?=
 =?us-ascii?Q?ZsbdUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nNJ/evB34Ben+GqicXozK4gBpPsb2rMEIcevMmj4v8me/chF4HDJ/wf8VydSp23sYtHETnxeEZ/OqDJWIqGbsuVCspMNKmxoyRsvc+FKXljRZgRTOqKhMuczCSLjhaWPAA9PA0FvuZmeRsx7Xqqu6NsxE7uZ0vTQSbcljvaVCqzk3HrN7ehllOEUg89Tvz59YuEgz7ce6Pz1t5jg5b3ijrlzfexVVrb0w3wHxMo5CE9iT+mp6+h/SgeKgtUJYXOyjkUfH5nQHnCfHFTA6hf2nfofuwZjDyN0mhl82Sq9Jw+gXqVovdynQOD1gnobSfZoC14prPDHVZhCDOBerr2FwoNHlT9co5vcpS4EvLUurbGRaNPa3b5x+Xjg6jTOuJ4QqpOungfx+4A6HTBDcf2xMjxrpMz3Pmt3nhOMmZDFJJsPC7mtJNX2rKmBIiNk/Wlc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:37:04.6286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d830830a-6aa7-4276-e130-08de6e4b2a83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8926-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DE2E414EB12
X-Rspamd-Action: no action

Update compatible and chip data to support GPCDMA in Tegra264.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index b8ca269fa3ba..11347c9f3215 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1342,6 +1342,25 @@ static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
 	.spare = 0x40,
 };
 
+static const struct tegra_dma_channel_regs tegra264_reg_offsets = {
+	.csr = 0x0,
+	.status = 0x4,
+	.csre = 0x8,
+	.src = 0xc,
+	.dst = 0x10,
+	.src_high = 0x14,
+	.dst_high = 0x18,
+	.mc_seq = 0x1c,
+	.mmio_seq = 0x20,
+	.wcount = 0x24,
+	.wxfer = 0x28,
+	.wstatus = 0x2c,
+	.err_status = 0x34,
+	.fixed_pattern = 0x38,
+	.tz = 0x3c,
+	.spare = 0x44,
+};
+
 static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 	.nr_channels = 32,
 	.addr_bits = 40,
@@ -1372,6 +1391,16 @@ static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
 	.terminate = tegra_dma_pause_noerr,
 };
 
+static const struct tegra_dma_chip_data tegra264_dma_chip_data = {
+	.nr_channels = 32,
+	.addr_bits = 48,
+	.channel_reg_size = SZ_64K,
+	.max_dma_count = SZ_1G,
+	.hw_support_pause = true,
+	.channel_regs = &tegra264_reg_offsets,
+	.terminate = tegra_dma_pause_noerr,
+};
+
 static const struct of_device_id tegra_dma_of_match[] = {
 	{
 		.compatible = "nvidia,tegra186-gpcdma",
@@ -1382,6 +1411,9 @@ static const struct of_device_id tegra_dma_of_match[] = {
 	}, {
 		.compatible = "nvidia,tegra234-gpcdma",
 		.data = &tegra234_dma_chip_data,
+	}, {
+		.compatible = "nvidia,tegra264-gpcdma",
+		.data = &tegra264_dma_chip_data,
 	}, {
 	},
 };
-- 
2.50.1


