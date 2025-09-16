Return-Path: <dmaengine+bounces-6532-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6EAB59590
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 13:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45034E1F03
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E562B2D73AD;
	Tue, 16 Sep 2025 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zBm6dYtV"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B713D638;
	Tue, 16 Sep 2025 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023664; cv=fail; b=pg+glg2EZXWZq0+DtSsBG4wnct8iuOduTcljrVYW/jPS4JGLq84qxlO296TI/BprZkn5whsOO/ZroZw+e4kUeomAc4NQvjZov8YrE2rUhTE1XdJH8y7/ZixZJ2XqCKgR270GY6jdKqC9BBhk6UFtbj/VPYipD1iH0ey4wfcOyk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023664; c=relaxed/simple;
	bh=33QvYkajPjxLy++iyhn+B/YR2ytxAKSQX3Ba+0QVdmU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NadSOcviwdRFSdsATvQbCzzoZKOo4UnV29ifEtZI5UMq5vWaVqDY+H6m3p/9PEyLKOcQKaxfiauajBXwjZPV4thH20LDIyxaNP1mO4jb/msbjjgbrCcvl0QQE3pcZtdu8hU+aIcvxmo7W36RNtBKNSssQGI76lTh8jDHmnTQwVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zBm6dYtV; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TU0FKyiwPplhUX86a6zjEjKq37F9KFO/0DP5Ujij6wx12CyjVcAsPl+4Xs+//VSZJQXbN6C7Aefb1uVX0IgEnRLkUPvlwqeqZ/WmmcDEd18Szkkcr6TIK0pXGW1Vho3r4ZF5OXnaVwuIrKG3BfKbo0lrVgKO5wNeNCRWRbP3LxHdrLf6ew5l6vTMwBtH4xeP1xrxfNgx6CwE25B15oUPeuO9aKv/ga8GLOxbpEdsVZ6iviOvFjmckWFPL7qTYVtnG59CKOlhMHQMNTYU4rfaEDlpGk5kMQpadaE0SoWgFTGT7PLlugdETGr6RkuJnw75fLdtz/c1CfT+XRJEU9mhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POOaGtDq3AApC5W3w3TfrdVWi+gV/uqhSG+xPfXv1W8=;
 b=pq0l79EVpv0T3ICKuv3MpeMjSxv0jXg1ZCUh01F5Y4UrC5RjJNPcLfSB8IzYIm/uEU9IXg99L2e15n9kFQT61VMuYIEG2kVe1joEpDpuWDFEbYYMiJbci3ZZn+a8mhzPFPZfj8qrjebKJx2ZBT4CsHxT+T958zelgsushvHc3qJQ53PCj6+JhkpV9NfHjrP7kf+h6J5Qi04ceYJacrveLazAwCYDfHdPZ1KnN/CbP3PfBljeS8Y8291hhnXmmojQR5a7rr9/kZRwRXj5HNzKzBmhc1z5lKQLz7WzovtQhmq4vY9CU5dubZurKcLLqOiaBm2uBZk5w7FDADUFZQBY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POOaGtDq3AApC5W3w3TfrdVWi+gV/uqhSG+xPfXv1W8=;
 b=zBm6dYtV3N+KxjUZbuaDUEa8ELXKLcv99eA3+iVLpnrobeeFTLPOzmxxrha/Sz5EVzrQRmRBzVFy5IgBo93hOLmSKHJEpIZEvuGebysDZF2DcFLXhKgEwG794EijqE00vwIljTo60bCLB9trSppZmzYJkbXCJRDwXpPu1ve/72Y=
Received: from BLAPR03CA0114.namprd03.prod.outlook.com (2603:10b6:208:32a::29)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 11:54:16 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::3d) by BLAPR03CA0114.outlook.office365.com
 (2603:10b6:208:32a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 11:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 11:54:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 04:54:15 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 06:54:15 -0500
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 04:54:12 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v3 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Tue, 16 Sep 2025 17:24:09 +0530
Message-ID: <20250916115411.23655-1-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: devendra.verma@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 74873d33-41c3-41aa-2a49-08ddf517c2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YbuUracHRFCoLI8xQqUkH0dL2PCWXAz7syNxK7OWM1hqAbHnln2Tm1NVvshm?=
 =?us-ascii?Q?8BPFwwJlo6UZn4OYN60j9FSICq3bf1fTJzrQ8X3WnipstBz0pwifYtmS6UJx?=
 =?us-ascii?Q?H+SlVUNspiyqgHDbNiRHOAXvON6KcQ4+9ijZydRlYaV5b64sCsQlvXWxdYl/?=
 =?us-ascii?Q?gFk8aP6KA0N69gfIxU8ovbZP6Oeo89h4Og8TWHcpnMUy+6A1PwP3ABso2Iky?=
 =?us-ascii?Q?rTQHYnViDKv7tLNhFGK+RakBi2SQ8EEdZQNeHXAQS4/TQUt2XbUGRKb4SqZQ?=
 =?us-ascii?Q?AZGwZ54vRe/jsw+5wG4cz3rjMCrEL2MZpobwL7kqkdcJw9mx3ML4AkrQVUrj?=
 =?us-ascii?Q?0q21Mk5t9FpjWI+SivzDiVyfr/2vfAGmYr+jYQigSu7l8Y0K9YZSPZ1hG1E8?=
 =?us-ascii?Q?PkElry+YeDI19qDQq3Vj66TbH+doknzK8Gm1XudBJ5hXe6OPanttKESo7RWi?=
 =?us-ascii?Q?Q9MD2miJ+VNbObQo7LcAud0Qp2BBmVoBcb4XD4DqOWLrjb/y5HHB1YmJzUsm?=
 =?us-ascii?Q?p1LuW7S3EpiLmjwrcssngAUONN8O6dNJOu+g20nqMGWtbQNbEq/MvCri+jVo?=
 =?us-ascii?Q?DYQzblfHkgPaUpeWf1nSk2/y9VBFSTzpEMYJqV9nEo2tzu7Mw2p+1lQY5wqL?=
 =?us-ascii?Q?R5JxGGBfflkMPeVXPMJtm76HCnAGeLaI1hOnkpr+UGb5bAuIUKFUjlpyyf6/?=
 =?us-ascii?Q?NYevZQAecYTjnpnViH81+7/JVcuMSczxRxLTwZuYUFN1KtO1QYvRkVBN3Qj1?=
 =?us-ascii?Q?iTga5HiRrUI45Cb5aE3N/IOK8AuxB3Jbfutj31wQ2FvJiaQbirVbnseM0Uuk?=
 =?us-ascii?Q?U5pTQkVl+3UHlhy4MdcRu60HtUeTHFT9L7A7XVcXgyV6KucpM2eqbZ8N+F47?=
 =?us-ascii?Q?6yTvOvGkC4P0f9uahzbIZ0e+QGH3foD2JidFHkDG1kCg7/CJ3A72dEgfIyR9?=
 =?us-ascii?Q?WTkyfsToti9FDwpRgwylUYAew8nLdGvcYbcLnGL1DHS9Q3/MNPIpYaojxcn0?=
 =?us-ascii?Q?Ini3nONGLgovnHLfzVckXHzgG42AKzPwubyzDQPBpqJ2wFnylmHHyLUg+ENn?=
 =?us-ascii?Q?4uxthUTH70JJLiGjZbkEoUk0Ucu5u/wtusVUKvEtc3QmTO2tfe8j4eGbG0Ke?=
 =?us-ascii?Q?U0WqdKj872jZfO+ai2u6uVigJxJLfkzbR4KRG+q+nfoZM/WFiMP0is/Xqj00?=
 =?us-ascii?Q?m8U0iCgxjLsBrPBmfJUy/p2YhE9KSiC0++vu3M06BFRq6F1eo3TZhtZ+1VT4?=
 =?us-ascii?Q?+k0gNLXQpUxLiI9GMQMKv6rNHph4SI4A6V202Bmy9krON3f/Y8c1FUk76kQs?=
 =?us-ascii?Q?K3ViABE+kckAv277XS81A5OPBHsL43DTPmN7ifDPyh/6ApBDvGprj3COtqq2?=
 =?us-ascii?Q?soZYFdb717wzVV2L9S7zluDheEs+IKbwpaMhh7x7uc3rqPhZQCstrGQGNOUP?=
 =?us-ascii?Q?d1TTTKZbIXNQMvyOJRakL8OFSJ1vHisiihFGAr73RAW5hKOBXz99rws2/eD4?=
 =?us-ascii?Q?35LG4iABGlQj7/S1PI0koTFySui87YGEcAzj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:54:15.8256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74873d33-41c3-41aa-2a49-08ddf517c2db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

This series of patch support the following:

 - AMD MDB Endpoint Support, as part of this patch following are
   added:
   o AMD supported device ID and vendor ID (Xilinx)
   o AMD MDB specific driver data
   o AMD specific VSEC capabilities to retrieve the base of
     phys address of MDB side DDR
   o Logic to assign the offsets to LL and data blocks if
     more number of channels are enabled than configured
     in the given pci_data struct.

 - Addition of non-LL mode
   o The IP supported non-LL mode functions
   o Flexibility to choose non-LL mode via dma_slave_config
     param peripheral_config, by the client
   o Allow IP utilization if LL mode is not available

Devendra K Verma (2):
  dmaengine: dw-edma: Add AMD MDB Endpoint Support
  dmaengine: dw-edma: Add non-LL mode

 drivers/dma/dw-edma/dw-edma-core.c    |  38 +++++++-
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 178 ++++++++++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  62 +++++++++++-
 include/linux/dma/edma.h              |   1 +
 5 files changed, 266 insertions(+), 14 deletions(-)

-- 
1.8.3.1


