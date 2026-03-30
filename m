Return-Path: <dmaengine+bounces-9719-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFWOE7GOymn09gUAu9opvQ
	(envelope-from <dmaengine+bounces-9719-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 16:54:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B5535D393
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 16:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 943E3311A860
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6291323416;
	Mon, 30 Mar 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cZ1ub7zY"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F94320A34;
	Mon, 30 Mar 2026 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881985; cv=fail; b=dAyr6QHr64PC25o6WkUo+Gt4s2fuN06q+1tQJf04ZQ8BWgS/bgG9YvIyW64PDkJ6JtL2y2vVcMK5dq7NjZtngpqZgVmuiSU9SrRYtZ8PJgCx2/cmD8++luRn/hmzO+0M+Unmd0ycLdtL7+KtoMPtWAMgB9L8EtpXNTXRtlFZvA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881985; c=relaxed/simple;
	bh=DQkNHhFDyC19k9csVDwhNnWWmByd32w8BQDSDsEd71E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZGcAPwzch0mBHHep5Aq+vngmxUQYTBo1Eo86x7e6XhdWte/AqoyexNZWzZ1e5VKonwNvpycvchVOKf19Q2VY7tLi6O/z9YVfGgGOEqGKxDvcovmE1pyNQXd4qPlBhX6xS9402mDQ7t2ETWfdTr+nwdagal+5C4i+2ZQ6zwZcWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cZ1ub7zY; arc=fail smtp.client-ip=52.101.57.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohVzIYW2YXy7zDFRCL7wt3UTHRBcJZe6p4wzeD/uWJc8a2VP/o15qPSKy5yQGgPML98O961mhzcfYYbod4k4jOAhmGfErtFquBH+2NqazNmELEw8+F9/lSqVGMTFOAKt6jB7sTnfdjv71W3dGxfOaYNWo9f98dzjOI98xccjo1oZ1I4xyoDb20Q/yIPUumAJJ4hBvh1tWfT+x2AvGQGeHIthqZHXs+ral9+jkl0O0xW7LK7dNsMswOzW1eW9xDagBVcdPZ+TUhqL0EohUHvW01On28iaSXDVNm3KvUKXzaVcCIlXKh/uinKgV4mBWsz9JvyjDfRDZGdQAWr6gtWhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E/TSJ4/CVWvqg/sIkoN1Bc+TDBYdsoBTkTcWD4FXls=;
 b=ObMcCgkCGt+njIHaeoRjoKWeBIjT11SyeDwyeaIp9M/xbKdNR6jb6LtM4VaO609wVObmJWV5leud24/du+nd0FA8T71xN3c/JNe/AYahz+DhRqWbGtQVHaTf9U42MXnTIcsqS+XYI+QWvAaFH++30nY2IzIgxLGVtVKjPtCMYB8bZ3DIRKb4nE/5cl6wZW/ojqr9M3y7EXCXi5XZmmhCfOJWrsBYIVNFsQpFhRteoZCRzy/7xZllGxVDysLrduoo/zK0kE5iBq3r4ERCDrVqAjm+6lOQ0j9iiPclRDl507WGBtz1ScNy2i2Bislo/IWTjy/iizWmXJQFq0i6KaLIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E/TSJ4/CVWvqg/sIkoN1Bc+TDBYdsoBTkTcWD4FXls=;
 b=cZ1ub7zYefxLdWjxGBnWRLAZnmIxi4Ft3mU+3mF7zS4za7fkV4k9jiaVogjXE45+yZuvOhImz+V4b+gWfTQsFoc8cq81D9YyITyh1S+8I6lTAZHE6IuSKLZEvO8sAAVbyvoVG3zR2G5Qd7D6r/NY5TGKPrgszUXc99jp4BHAxlv2KXWPHzSnpS0JbUjg9NT/6U2ktmFnC0cSEdsjR3xjDTKgdiuofzea1ALkf0KJtzzYXfMdz6MIU9yXWC6WmoNlij5wgEnWJCxBoIGhLRlX5vLjQ3rldKlYHXCKoaTOCDJ2dvVjtz5bMDchauotdPJDmEe5llZ8/RbnMwc1Hpd6XA==
Received: from SJ0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:a03:331::31)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:46:16 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::9f) by SJ0PR03CA0086.outlook.office365.com
 (2603:10b6:a03:331::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:46:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:45:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:45:50 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:45:46 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 04/10] dmaengine: tegra: Make reset control optional
Date: Mon, 30 Mar 2026 20:14:50 +0530
Message-ID: <20260330144456.13551-5-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260330144456.13551-1-akhilrajeev@nvidia.com>
References: <20260330144456.13551-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0aaaeb-9ff0-40f3-8b8f-08de8e6b18e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3IWb3hISuD/HpoYNPIFmU1AejdZFfQew4pGQoXY1wv5zCVGCW0D9opadE5nZ8p3N8LOnnXcHwTZGhkVOJgD3yXOhkAELwqKj+mBxWdZyfdqt/UFsz8rapk2abawvT656v937g9COQeRP/xai99CwyXSOOMIBaA4dkkfvBvoEU5vx/MR/9t06+fwV5LmN2wPWcpmjsmNkfmoV+Ga6YqW1J/igc0QrdoXPl+A3RNiwHVuHQQ1YtYfc6rj14ki/mTFhKt10eoheZlkx7CdTEeSsZwBhOG5soB0X6S3gpfaeSl/0Fh3HcbiHeexd134VpPolkaXGQ/qrnimdHfmjys/TA7swmJVVNvq0SPfjjND9NXYM/50uYpNJ748PUdV2w/zP1q6tiIc2wrATQTD8+ZqpBa4OKK7gCz2XtORae+0vIebFL5WpspEyxGAd98GtJOl/gNy5rOTDluMn4caAG0lixbcXYROcDf5xJoNzUMaalgqVJ4V/GbNdn03Agxls6HVGjKwZVljgyGh5AIbAGOLaZtE1YEhriZLwMq6ij5J95DYtX5PAvfgN1+hb/ZF+FPbRGlyv+//f8brRS0OD7oSa+nWsiDMI8ShHLHE9ocjdtllvjVp0VRHk8+w3myUSsw8UsbpHjgdOeO+I4IQOlPWchDRmX/hir+EbnWCapcKx7QdZ1Fup3n3nTps0w5DqFxPzdo/yFm5AZy4dd3BvHpiTdOMsjMqxWMK2TXYZTeK/9D5mddflK/CztK2uStcQ0gJAP7/Vgu19nBPc7WYsARHZAVmMIAVooFoBmqUpnMcEry7Qykvuip4iCYU1tuj68yBl
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l1leVh2GIca3J4WDJE0Jc7YU0ooBNeldfmIm5JygEjcdz0c1EuBTvT9WmtjMnph3NAo85h5HpMJ1ETyMNyAJj9GIz9IqrboJ0qEiyisFRIJcml29DfyGLwyhr5zmuCyGgkvfpPwxwM7JWVQLQKGWvtq0GCWfOvVltc7RghFifp0fTgJJd3pByoJe/y5H7PPwj3oj1zJj/EbaHMU3Hs1ayXnWhdK9kV5cqsVcMbqoIqtMNo8+iNjt54a3lmhyo7k907fcAYVrl3mL4IV6IzwCofLEbeGZYY36cnRZwTdlhT17MBVuDXwVHvUMNHxXJIWUmjfb079SFji9M5bRBvh9LRsxa4AV4ZC4DQEyrbmEGxdjCiBcOimWogVHttq/PyxCHdi5/9ypZN0mc3EffaKUvEazR5aLImIqCR5v3FjE51I+MCy2nq0mM4AVbljx73NO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:46:16.2049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0aaaeb-9ff0-40f3-8b8f-08de8e6b18e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9719-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,nxp.com:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A5B5535D393
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, reset is not available for the driver to control as
this is handled by the boot firmware. Hence make the reset control
optional and update the error message to reflect the correct error.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/tegra186-gpc-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 5948fbf32c21..a0522a992ebc 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1381,10 +1381,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (IS_ERR(tdma->base_addr))
 		return PTR_ERR(tdma->base_addr);
 
-	tdma->rst = devm_reset_control_get_exclusive(&pdev->dev, "gpcdma");
+	tdma->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, "gpcdma");
 	if (IS_ERR(tdma->rst)) {
 		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->rst),
-			      "Missing controller reset\n");
+			      "Failed to get controller reset\n");
 	}
 	reset_control_reset(tdma->rst);
 
-- 
2.50.1


