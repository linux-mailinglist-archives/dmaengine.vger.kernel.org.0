Return-Path: <dmaengine+bounces-5258-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24FEAC33C8
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 12:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DEF170D98
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 10:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52DF2B9BC;
	Sun, 25 May 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="te9hgUNQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A1BA42;
	Sun, 25 May 2025 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748168192; cv=fail; b=LlC7IIOrk/42mcP9sTWioLE17L6yF7RUPAN7Vd8iPzWQraaep5Nx1V8ymeXITZ33KtOcqVm1EaoHSeshayIedk2CUfdNfP7TLtp8/gsSisyFeG2fOHRfQ6u3HdgZKT8qtSgPLtcNnSpHvmpXMG1oN857SzL1MkSmbEjjTk/r2MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748168192; c=relaxed/simple;
	bh=7U0ZmQRJ3Bp56Wy1CxppyIT1b38JdIczkka7Pik9mFw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LeZ/Xp8O0k5TtaRpaVHQ0SFFD7DUH8s68fEqscbT5VtVAAWp6c68UFA2FeK1S4XW8M2VYHE37XfArwdd6o2wA7wTqhz+uZbRJtug4eTUl4N2wT/uwQfLfFqmcrM6eMgJOW69w46fWeYBMt5XYUt+jFwB/LyMCG67vgjmtRoNUFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=te9hgUNQ; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnMQCeFeyYP4qm6YmtqSGMvSeg2ACbBT2aPe9SmNKceHsiFwSxrDlXbZxgkY6kv41yiMS7Fc1R+6IjpHl3Uvth0ecU+UsLensAyToQHL2JZ/YBpDmxQeD3IMVcEosubF2Yr9VxUPs5x0tA0kc7InHI+S+3upQPmIYPtmDKIN9N9F6ra0JxXOl/Wkw7h/D1l2cgsJQ/7mNRF6NZPDgB2QIe9/yDiXKXzfvG1T2AV6E4Ml4nbhMDELOX+a6DxSPIMEHLpCIkI7AQThKB7j3EuNyTtlgcggmEDAguSQisyMdP0svvHymxqfS9D9j7szx3gUiyD/4ayvSq9sJZbkIIv4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRzuhiY1lSropOwTYSbUjCGNhw4wKd5tf8Yzlru3qDA=;
 b=ZuBcyyBswRGFUixiEXaROp2TGBu9l3kuNUcSf/ig6OFrQ0ae7pyMRXmNrnv8AhaCLz0xftVXKkHAMiMYEY15GXUXvPDJz2HyoWEtSnb4/7KDxhx3m1dAV2RN/ufBjaiuRG6EQmB6pfiIBYK2zixt9+lmZ/hOMxLyOEB/InpmEJyH2Wp2o6qIMtHESHjrzCRqRGt5FuFA5HijPDVeWamCy+TJ2p/kzmwct2UeGUOFA1f1Mb1bEs9aA7JWJqjgyH6KMoG+cO51PZiO9x4A/z5luwd5qGyySR+YiZXm2hyyo1JES2+ocafEHCMmTuH1C8aNyLy3eOIolFLsZsjGecL6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRzuhiY1lSropOwTYSbUjCGNhw4wKd5tf8Yzlru3qDA=;
 b=te9hgUNQmCkVwBJ3N5buphOomHBD8gtw8291Y0gxVIhc8bkcJ+sWszedh1OU5E4OrFgFTL+9N49MOx2J7kuLTrfDphQ6hEaHCKOCSEvaLUOA70CupCJYP9YXpyMSgd2pCzzNV9P5k8uguhEWFyX9lgnPaKwqquBUjlz9ZfkKYF8=
Received: from BY3PR10CA0006.namprd10.prod.outlook.com (2603:10b6:a03:255::11)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sun, 25 May
 2025 10:16:27 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::1a) by BY3PR10CA0006.outlook.office365.com
 (2603:10b6:a03:255::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Sun,
 25 May 2025 10:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 10:16:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 05:16:25 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 25 May 2025 05:16:22 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>,
	<thomas.gessler@brueckmann-gmbh.de>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH 0/2] Add support to configure irq coalescing count and delay for AXI DMA
Date: Sun, 25 May 2025 15:46:15 +0530
Message-ID: <20250525101617.1168991-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa1ad45-fc0c-4315-2ff1-08dd9b7535c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BhB05K5TGS3wxQqLBMeT2WecYsJyaiRFXnvlKrvVTANLuana0nLIiK92Y/QK?=
 =?us-ascii?Q?bRzyjGcME7qXkczD3fQ4ofqd3iUIkBOZ6cyg87tQ2jY/c3ZBfGtPeVVkK2ft?=
 =?us-ascii?Q?yvrLAHm0LhyFUBOF2lQAmT3Zd3evFfH9/B3Z5G8zjmCRF3V0LyaHowU045Cg?=
 =?us-ascii?Q?U23UpeSihpAP0eySVNAzdq6hrQAgWnp3xcuTHpMmQTi2THlIQh7UIaKn+Cej?=
 =?us-ascii?Q?V0tQwvlAgIJMKGzCVj/0b6xkCWVWJLcXG23o6p5OX/0LHpTBz80ElQUFVM+F?=
 =?us-ascii?Q?3qlzfRjISzGjPPOCNZH18vYV1a7lgkb4/FkIAO1m1m8l7aLUU8lI8BfTmHSI?=
 =?us-ascii?Q?wydWXeGkJLlNz2aU+f/ro15JBMwTo2X3i1MlpMkaQ0H15SlkJRpMNOdWKpfJ?=
 =?us-ascii?Q?jvTZ90vKUF9HGU4eDOW1dpmbKukpv9lGVFH47s4DAW6lV0706rnWEjj6CNRy?=
 =?us-ascii?Q?81IuRzFDOeeG6CweWInSAnWn5/ki0KJBKF8KfltPzJ22ayJVGvCcYf8UDgCf?=
 =?us-ascii?Q?Xu9aSvNQPBb0uUD1EqQT21gRWnsnVu8XWfqu6gS/SoS4m0FXIQOW/ZhoZ+cc?=
 =?us-ascii?Q?I5DrjgMFZj674cg3/PhMJA0Pbc34Xc3y49P4WNPlsXyuwBVbXt41ZwVB370W?=
 =?us-ascii?Q?SDP/0fseWZzDdsHGXyPLlTurPm+RYwtC3klsHC5e2Kq6/Ts4Xtr6JJ/nBCYb?=
 =?us-ascii?Q?SsXT7qssxueyCltSopVaLtjHbthD7eG0FLPjyzjLahTj1+b9GTuU0Q3Xz7HU?=
 =?us-ascii?Q?LpmPQpt1HMNBkecvM7E8cPZ7feEePhdViJRvknoNomgw5Nntb37fKABCWceL?=
 =?us-ascii?Q?HhR0HRSgwZEDFQYqwhpv7Q+8v+vLZJPY4hrtfPzy9irxZciewCp+mb8igKK5?=
 =?us-ascii?Q?KFuSGrD9eOEbX5gW6qN/Uwy90BQd7igVM0iN3OiAIQtWYanhCBP3Jg9lfi1U?=
 =?us-ascii?Q?tKgUAQY6MWIlmI2/R61RepbzZRESQtM0mvPFkEWe738mqUnKbCiSF0FzivyC?=
 =?us-ascii?Q?rEi1N2ehaJl+xdk5Qg36TPrG/h27xYLDsutfUPTC0LnmGme1ICD+z0EgCRQw?=
 =?us-ascii?Q?ur7VUClIlU4J0aWUx7yCn5V0gMSMJmRAUDgvMqIL4986+Ei6Mg2b4GIel4yS?=
 =?us-ascii?Q?pTVz70xPncGuN+9AP3YZcCUYqKhgaOgu1/9A6IHMJEM4we0tzgeQ+k/OQplo?=
 =?us-ascii?Q?rEaa9aEWJxUrzvM/Q+//7VlnaBOAKE6vavXj/howJYikvIENqtEVWa58GerA?=
 =?us-ascii?Q?+Pusur8wCLQSboPw8EJnb5nW3zcB2Ep8Jafz9Es5UZkQeUjFOvpkJrv+hZJj?=
 =?us-ascii?Q?/8RecOJVrq2Yiw+UcM2bkfzL+Z8gipAQxqBncTDdc066iv6z6q3fkiWpYT7Q?=
 =?us-ascii?Q?XbHSUYqr6JD4ziHjaennfTkqZlut1jdQ+HKfopidZ7jbAXTl1QLMkEr2lKNO?=
 =?us-ascii?Q?5VuE8VbwPRIjFgNSDBvNerdrylcPVCdWCMMiiqJ8GJYdG+IqN8CngnHm+AzU?=
 =?us-ascii?Q?/Zd2fCAPGMxagQmPSg6i/tHoGTrCq7DFPEU/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 10:16:27.0876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa1ad45-fc0c-4315-2ff1-08dd9b7535c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371

Allow AXI DMA client to configure / report coalesce parameters. Client can
fine-tune irq coalescing parameters based on the transfer load.

AXI ethernet driver uses AXI DMA dmaengine driver. Corresponding changes
for AXI ethernet driver to allow irq coalescing configuration / reporting
via ethtool will be sent to net-next with following subject:
"net: xilinx: axienet: Configure and report coalesce parameters in
DMAengine flow"

Suraj Gupta (2):
  dmaengine: Add support to configure and read IRQ coalescing parameters
  dmaengine: xilinx_dma: Add support to configure/report coalesce
    parameters from/to client using AXI DMA

 drivers/dma/xilinx/xilinx_dma.c | 62 ++++++++++++++++++++++++++++-----
 include/linux/dmaengine.h       | 10 ++++++
 2 files changed, 64 insertions(+), 8 deletions(-)

-- 
2.25.1


