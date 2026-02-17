Return-Path: <dmaengine+bounces-8922-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODUKM22nlGkRGQIAu9opvQ
	(envelope-from <dmaengine+bounces-8922-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:37:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 353CE14EA89
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906F6303DAD2
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CBA36F419;
	Tue, 17 Feb 2026 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T9ybQ/ll"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA2A36EA9C;
	Tue, 17 Feb 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349790; cv=fail; b=XuVFZzpTx8jWVDwR9CUqlDcMQiHYfO2TnJ3oYxnXAFc7TSwA41D2UqQTd3Zw/8CM2ioqgEbCC/onWHgMGRX7Ft3Hf+tFT+JaUcxfN4SLBLPR7X7O2+pAmphUdr1mqIrkNCSnN4gceueB8D5mbF19Mg/gXSQcfU8o5RXopBWWXQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349790; c=relaxed/simple;
	bh=ldY09j2zFLGOoodn7uEPUTsNcN2OjWXoyO3HzAt9dj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCikTuoKRc6Izj93Yktc2DvNA1QMJZCjEba0o1a4V5RkJeIkKP397m1ZKaopmenD2qxnJzjjIY1EchHw1bLl9b7DDxK19WjgvG4q0KqIfzdwOcUgjmQmi7Gx8Y7eg/4izKW0YivFbJZFgRZit56ebp7VDCZ0c4QcfqWxeEU0Q7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T9ybQ/ll; arc=fail smtp.client-ip=40.107.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNLhSPgh69wYH8HG+jkCK78rOCxR/PhIbwcb4FRx7wfw+dhhSz7zAVSqkkvDXlkjxKnM8dmb63Ctk7bLontUIF0mJO90tT72iHM4/Q9A+pg4AfWABtrPAbEguvthTje5YQOpQ6cT147rCDYuk/GmwdCL9yPClnFoZCK30vMpNzwyQCseLt+T43v5VaHzLxz3GjhLLSHkWeaD4NjMo6oquCujFi5NAGCANTgkxgCvJtgRHtOUjQG88mn+pWBqo9ch2cmnyh5iBXGghMj5RND91OZcpSMqB83QE7cTbzmvjvuZE2GjD/nhr2QZJaKcCWdxkgOisPPfsxfb8LD8osT4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7e1rT2M6hhIuB6/yyYw7kgvG1Vt7W13sExdMqjlXDT8=;
 b=WiN3g+CoR7apzr5WUP82AOrqQbbTcPbHMvv1iZ8ZI2NqK4M0L9NzZ+zeGhIwsH0X2hRiuIAXKwdM11Hb7Hqy52bxtqGvFpJIf4JMMV4h/PIoOZsUMWVTZNkwJCsIaQ422iOISEUddQB0C+eSYFe+g0vGopRJA2wfhvvloIxAKbpZ3YTX/Mp+peYIwPxYn1YJ8tusTZI9956Ltvejq5XyAA/JNFxkPPD+TEPQ5Q1AY46YX+HoSJtg5Dicik2itFrrmySFcqjNU2Ur1eUK2W/Ce3WWCjg4jnbRMt1bB5J0ddqz8typQPx6z43YX0hubpmM/yBfVyZrcIVpjT0mVBcqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e1rT2M6hhIuB6/yyYw7kgvG1Vt7W13sExdMqjlXDT8=;
 b=T9ybQ/llXMH+XT3A7szA809c9eayovwfLrVCZTY/to7O7c2eXt1bDzqFg48xP9YpbFAJdD7ILomczE0EB+2u/4Gv6KlIye8X1IiVRzFhni8hIniHvztSdEKZy6l6M8fqmGm8hw0QnYnninl+Eb/CU7Z6hoxJVWZYuuraRGSmfLG3ixQaD3nuQyS0DncQ58/cyCydJX8l5Nb/9CbMRHkbpIblGSLcI9roOO9qkbyddl1Uow0B8WMGpcqVH0B5Sh2CsnuvDmMh5eaOblbq9TEXYOfZDxpq+E02y63TiWnY3KxRWq0KcQHuORPfJaZIDgz89vWHQWio/3NCi59r9VlQLg==
Received: from MN2PR20CA0027.namprd20.prod.outlook.com (2603:10b6:208:e8::40)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.16; Tue, 17 Feb 2026 17:36:23 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:e8:cafe::7f) by MN2PR20CA0027.outlook.office365.com
 (2603:10b6:208:e8::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 17:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 17:36:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 09:36:05 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Feb 2026 09:36:05 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 09:36:01 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <p.zabel@pengutronix.de>, Akhil R
	<akhilrajeev@nvidia.com>
Subject: [PATCH 3/8] dmaengine: tegra: Make reset control optional
Date: Tue, 17 Feb 2026 23:04:52 +0530
Message-ID: <20260217173457.18628-4-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc19489-5299-4fb3-931c-08de6e4b11a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bfz+55SW2K0vKI1PaJdz8etfbb8+D41ej6A09g4GkOWrxwLDuehhiiSG7sJz?=
 =?us-ascii?Q?/vShc5TlauIAvJ5D/mO3dhcjqPIEQiSNh+sQ30vxRoYi8QoR9tKRkrEcd05y?=
 =?us-ascii?Q?c2eplTMkfRn68ey8ec8V9lYzVfIgbeWfU/WLPrSyaVVnphHMy1XvDPP6rYKW?=
 =?us-ascii?Q?9TV4hGEXUDtWJYRBY/BIuZgMr4wiD5lyu0vox0BS7qr5X4jlEFn6l+kLcLEo?=
 =?us-ascii?Q?G1HMV3NTP8LzUmRRBKiCCZ/JSxIqn4GAz57M2aTty69YK5hW9d988GOOoO08?=
 =?us-ascii?Q?I+xE9ioK0K74LCE0Jr6ICLetff0mTxdhgypiiWvUQBho0Vw/VofGmnvIF/eU?=
 =?us-ascii?Q?SsnLWNiq1U+dQ4pJFnGnI4a5hGm4mmBxZ+pF3hvHFA4Phz7r94znrlfgRriF?=
 =?us-ascii?Q?7KJMIBkkOrykdiWtjylp3A4eCZSp9jB+Gli1wkG8bA1NQxmLca89yRJBzCRF?=
 =?us-ascii?Q?pbmbghAI9JL4op82CpEfjrwDRxdL+8jRJbawUWn0vz79RE4SSsHMoOz/BR4G?=
 =?us-ascii?Q?TzfMhEq9QBIqjI17oLqJEtCCDenh2EkbUho19JOd2vdHe9PsDJjWN4bMjeRV?=
 =?us-ascii?Q?MPBaxy3HirnzhMML1YEdLcYIs1Xr9pRkBhWYoh8N4yk5c/w6rIRdDicmMftY?=
 =?us-ascii?Q?NL4uIMRXxzclL+tw2mNVW9ofsmSk/0+z2cVrFMhS69YuqKF2Xf0KpuO6+Ubn?=
 =?us-ascii?Q?I9b6FEkYqoaBa1hKbZGpNmoQomWcM091OvGpMkaQuEIV0BlmYvaApotSThlc?=
 =?us-ascii?Q?FNAvGoIrVuqDtF6hWc3V+KAj8EcNnuQ/eQrYtVcgRRb4DTBho90ahkjpev0U?=
 =?us-ascii?Q?eN6oH9P9WzV028SIllYbOwjrZi9DqMYn6nTg641N8Gagn9b8oKiRlDzyzheJ?=
 =?us-ascii?Q?jpmISWHjougk63Vex1IOlTV7vualY3VeVcee7Z5WJy1/IbWPwvuuWlESEgqK?=
 =?us-ascii?Q?e/6DglWg5GBbZrdrbTvgkgqEN7DoVIVMf/KL2sTx6npYH6zqNoEh/omXmH/X?=
 =?us-ascii?Q?iMd3tZ07jMfCAaN54W13GVYKPpsSUIVi8UyZZ+Rfj+wfB1VJBYJXpFaK53gQ?=
 =?us-ascii?Q?lk2m8g+jc1yfcRJc1ROnLmwJzGL6zjKrLtpNlPTogG+zlN5qdEIemFEI9H5U?=
 =?us-ascii?Q?BAC9Fbq9Bxmw1eAdDir+C7TH6Xvnhu3KkjeLHUmcGoSNdjVHm7n004In4NbO?=
 =?us-ascii?Q?nPJl29RYrR/zhxUqMaS8AbMVZBNrBYi2bda6qta2QilKBZKpTeZ1NKnhM7yf?=
 =?us-ascii?Q?lCymNaJvwskkxvwXdNlFLhjWK7V2FJQRidK7s1h0p2Cg00Off0EZOOY1yh5N?=
 =?us-ascii?Q?m2xFcrnBPfjb6umd5UwCMbxTs+JcC5oFDCDq1OQ3Col9gXkffWjnjFi1IBw5?=
 =?us-ascii?Q?yzgCfJQUr5EbdB1vN5C2GfffHCAYypGvtDmqn/un0sFxB6ZTMj+eESMi2fzx?=
 =?us-ascii?Q?3bPmhen6PP4M9R1zi7vSylIPqIUr5tWy+sKvo5PItecnhtkDls3FjkAIBYJU?=
 =?us-ascii?Q?MYxe6UhD8eSBINWWeVG3Z6ky1cpL/pr07ozw8hPTmTVBIirpkja4A6YyNQ+3?=
 =?us-ascii?Q?ly135wSAcmcqWqKp5rP+3Mx6Yby6Zw+LCsDIBNt/qQLkR2vT/TWFkdCUIlqq?=
 =?us-ascii?Q?THHOpCvAbckfO86cMGuJg8E3O3yCh0k2r/c4Jj9jQMx/0Z8nIg+a6h+FYrUl?=
 =?us-ascii?Q?7LmQqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nh1hua/cKsNY906Ko8WWn/Pkz2iEgaIYzRdNLloJ7YDJDbXNCr9uL4sCqqMlGJNKiwvKxku7+TxESmHrFbUorguJZgiEXPn3nYpS9FRR2cR8JNtcYqyj7by7sKBFOFszASgpchTjhz7QVB3LR6QUMl4F4XImaciq4x7gHieaIVL+s9IIDD5rlwTa0LesGZBGOucT+FwBRAMfVL5P+JIzZSkqHcjn2hy49GDiwXhjMNI7RE5BNHNGuMGBSLAf54EMbySfW9+jsxNlIOpEHCXzQ/PmBbMeMPPQOP2UeR4XM4EoMEUP7vq/agkDrtPmLjlhWk69qctQJU1t/4dbucGrViRFfxy2xnfnlu6MMqrtOgMI90dyI/vB5GM07gmzakaXAv06d0ddSpOx1ECP0dX4c7sYqk/AdpN4xm3wp9Aok87DWHk/5L3IrF+vPNkHQCwv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:36:22.8769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc19489-5299-4fb3-931c-08de6e4b11a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8922-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 353CE14EA89
X-Rspamd-Action: no action

Tegra264 BPMP restricts access to GPCDMA reset control and the reset
is expected to be deasserted on boot by BPMP. Hence Make the reset
control optional in the driver.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 4d6fe0efa76e..236a298c26a1 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1382,7 +1382,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (IS_ERR(tdma->base_addr))
 		return PTR_ERR(tdma->base_addr);
 
-	tdma->rst = devm_reset_control_get_exclusive(&pdev->dev, "gpcdma");
+	tdma->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, "gpcdma");
 	if (IS_ERR(tdma->rst)) {
 		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->rst),
 			      "Missing controller reset\n");
-- 
2.50.1


