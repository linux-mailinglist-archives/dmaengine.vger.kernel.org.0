Return-Path: <dmaengine+bounces-2739-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D88C93CE1C
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2024 08:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45011C2140B
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2024 06:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA81174EC0;
	Fri, 26 Jul 2024 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zifa0Ldd"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5DB2B9C4;
	Fri, 26 Jul 2024 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975215; cv=fail; b=IFEKO4+K7jc+b+er3ppxkWwe6DAON+fi9GrUd+vF3uZAtWwOa5n4Ks3ttiPVFMbV32ecvH9ZLAmw3q75P8JThBt3xELB2eH+LsGDfi4EdWKtCsVHNqTS+4Yxnpy6ci2NII7qwYu5Xah8ETi+GQ8FH3evO9PrCIF8i8JfMfonSfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975215; c=relaxed/simple;
	bh=f2ZfzM8COCo/swM4JdteHFAvOUI2rsA2rDMAxWZ4SuA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PUKyxrEVdQX2WUhImF6QBvQStOwmRNA8S8Z7kBrGYc5qYR0x0IEmJRJI07Rnx6/DEYT6WDzlqLvHwk+r8fW79zG2OaKLdZrG0RCYR2pSVFNDKi3uJe64VxGXKQP4EvrWkc/aXxhnbzzMWGDD1ku1NBg6LWTUA7oJgzCN9xutj2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zifa0Ldd; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmzM15PkKoBGjBEcV2FqFRJPSl4YfvqdG9dooxWqdlzNUfebQAj22Bn1RmUWZ5T2klVMFjPvo1xDpoGIcP/HNewIrcfTAazElE7eP0WkLZjNyh9p96VOD/jo3tt4dUcZngvmS0wYQeI+4/T0ISCbxUu7nHz/eInlnawD+4W54lDxwMvmYopNm75kiPV+dgqTaxb2b85a/l6LgFwII+1jPIqmdtsJxpz1IYubyreqiIs9K1RkCPF4D0q0bxCD8N2kZNwxweBFBTsRVtULmeqywkTG0eYKnxhnWPVvbND94SR6jeHVoA3QksyUIW4h0wWTEEFHhEQA3tb557O/gww/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ5yq1moStC1wyD/W+/VYgBbdLK9RTQN1hv0P6AcMSA=;
 b=bKU3wo4C6sr4j7nYPIzH1uZUq3uIuRGDI8M/ic3pMSClJuqdcKsioUFnOa2ovyu52/9iTYHZoi0GsDl9HIj0Ui/qPMwgL8AN3INdrHbGjEMB8I10vgh4SXkpztTPMvCAVVMdUWN5ORX78mca5MW0/v+DhF4MT+nriFS2uTpx8Hhw7kM6PvqG2uwNaS8HC4ho0FTCeE9dwPDqR6OFcrgZQmOLg7BVYZQI6+2AH1NA5/d1d/gfkFk4sH840os8AJ1M4KeL4icJwd5dvqlNRysVRWtKODzEq4TBTTu2EbNGyTkETOxz2F0EKljbKMv2ht1hDhXneceJTi9XZIjZ089a2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ5yq1moStC1wyD/W+/VYgBbdLK9RTQN1hv0P6AcMSA=;
 b=zifa0LddEaj9rvYTP6SfI/SVNispY/UMM/EP0u954HAqcbN+EKbtzvIlcOXCZkjuGHCDBhSQOkyZ+GG97su1TrXbBF48L5Tx/r1xinuHc3QdzJk7zARfTvFP/3yssNArPXx4sGuWCHNfVHiooZrTIEjgIK8tJbLOfv8dgkPvU2c=
Received: from BN9PR03CA0675.namprd03.prod.outlook.com (2603:10b6:408:10e::20)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 06:26:47 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::57) by BN9PR03CA0675.outlook.office365.com
 (2603:10b6:408:10e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 26 Jul 2024 06:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 06:26:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 01:26:45 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 26 Jul 2024 01:26:42 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <vkoul@kernel.org>, <michal.simek@amd.com>, <robh@kernel.org>,
	<u.kleine-koenig@pengutronix.de>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <radhey.shyam.pandey@amd.com>,
	<harini.katakam@amd.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add support for ADMA
Date: Fri, 26 Jul 2024 11:56:37 +0530
Message-ID: <20240726062639.2609974-1-abin.joseph@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: abin.joseph@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: d96c898c-371d-483b-745e-08dcad3bed4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ovpZNx/zliIltPYkzGWtJLySRiIMo0Tt/Vo7iBFZIb0numYEE9bUsIzucRij?=
 =?us-ascii?Q?YeGSUKrTjN6KOSSA38RoGNfQgCzM8wMHH6uQu90427LbMJrzXOit+Hf0NEBO?=
 =?us-ascii?Q?RTPe9JmrFsYMt6Zq5gkWKItFH/2ps4tOO/2EsoIjQZRkOS1TRI5PQSvEsNqP?=
 =?us-ascii?Q?dtRObD3vI6GKoRIhcNijdJUl9NX2tyV9fHWhQeaGEppWDR0wK2TZmn3HQt1u?=
 =?us-ascii?Q?FBTwdIPOjiYlRCihFACZQROMDX/lLUSJveZb7CIbX5Eq1b3XIA/LWuJFkugs?=
 =?us-ascii?Q?hxvU7qnlvbBpeVxIQoU0YMot/R+hn0IqpsiFJrfv6tBg7UHy06BWBSLdRPf/?=
 =?us-ascii?Q?g1SxSpOp74KqZGYzT39luyDsZvhHIJpg+cszOssPL361mt35aBJfGsUGmOdn?=
 =?us-ascii?Q?2o2vSvOpoJ7yN5xgf9YytgyaMvpnZNbk7HJ9UVOFy8MDmC51MPK8oCWJQ6Ha?=
 =?us-ascii?Q?ah/s5c8ehCcF5IPyhrdFf37D+mybwlVdRJA2g2dqe/WPx0nrC4C7V5cFvjE6?=
 =?us-ascii?Q?TUWfW0o7Z3piHryz/Zg95E24ZiWSZtqpDWYIYeJH5TWAJpocDwfqW6IfKpmW?=
 =?us-ascii?Q?wUFSZqogvKOu9qckXNR5bM3/8EVyFKOARx2JdOTY4vI46SLc+tPXWuARdzlU?=
 =?us-ascii?Q?0zYKf5i6UATsnF//IP0Ivz+HgKI8irg07GENZbxBunbcuMMlnvsvR8dD/FGY?=
 =?us-ascii?Q?pXYnfkK43diCU8hsxzeaoGNmWOlX/YKLzVDJbXuU0ERnExraOCy55GTU7Qzy?=
 =?us-ascii?Q?+TCpzRuZnbMKPVraecpI1SbcPOnuKpj3UDifW9NN2wPRp1bM1evgER31BOjQ?=
 =?us-ascii?Q?PvPrDKES3rebL522FkOQ/CKPSQztE392/57H4/OFFHM+hh5o6OSUsZiQU8yJ?=
 =?us-ascii?Q?hUCX9YlrF9YtyYdgnsvquLGbSs8FJ/LALz0hpDmFpUF69GfRNNYAu0MRlQJh?=
 =?us-ascii?Q?b5v2+s+ZWAIKrQxLSIc5ImrEWQ8fiY6wmQiSzZb3pfQQb8LRubDwFSNyVY9G?=
 =?us-ascii?Q?taAlgqUR41TZq584UcgnumFMCyIogV8qCO6Jcf+Mqp+1mSsFNGD2Kf7Gfab2?=
 =?us-ascii?Q?hAXxsNLt50nR8zHoD3hg1qgOEMbIzbCyjnIYc9YM4796KyfJIv1RG82zkIzo?=
 =?us-ascii?Q?+vqKdepdtHIJwpZTvrNbHlmqra4lXg+2yQMGLq/1LWf8Yr70aXECLodB9COa?=
 =?us-ascii?Q?aIvSwEoKW3ZG4kFcdnwpvtOEGPrZFXU0UTRbBE/JF9fRlPN1F14V+F1oZTOS?=
 =?us-ascii?Q?Hp4w5Z3PhvVgx+3tQxQN9ZfQ5gbxcEwTJTGSsU1vYqGC6FsksHArjGHSc17U?=
 =?us-ascii?Q?0EbfOa1BR815zgdDZCBCSqNV3+dKH7PJVQP3aFvkkV+hvQeagxO1YnWXI+dU?=
 =?us-ascii?Q?1khEDzUyl0oMmrXRx3+Iojw29bp1MAp/HfBaQMSe9BqQEZfN3iOze3n/ygIF?=
 =?us-ascii?Q?M3wXAIezHx1919ufQOJRhYQud8mY5S/5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 06:26:47.3244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96c898c-371d-483b-745e-08dcad3bed4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

Add support for Versal Gen 2 DMA IP by adding a compatible string and
separate Versal Gen 2 DMA IP register offset.

Abin Joseph (2):
  dt-bindings: dmaengine: zynqmp_dma: Add a new compatible string
  dmaengine: zynqmp_dma: Add support for AMD Versal Gen 2 DMA IP

 .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml         | 17 ++++++++++++++++-
 drivers/dma/xilinx/zynqmp_dma.c                 | 17 +++++++++++++----
 2 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.25.1


