Return-Path: <dmaengine+bounces-4132-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E7DA13E1C
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 16:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6413AEC04
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B4E22CBCF;
	Thu, 16 Jan 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="flfnRN9f"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11E22CA11;
	Thu, 16 Jan 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042313; cv=fail; b=Bq05jzYFKFS2W0TWL/wzUXqGwux7VaDqf5gXgfs0jW8nGw4fBOJs/GBzdxMcvxwOfmcCszrZeCudT1zMpNDjBHt/KBB/nUR1p/PFihFw1EwzTWfn2z88ibyXFzMrHXSuClkMGbEs4ZkvRr48JTGYP+Kty9LDSgI7/QEsYPtyRgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042313; c=relaxed/simple;
	bh=P6e9KK+ZsQ7J0t6LnRG+4VSYJUODw/m+aWsSDuSP8aQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iET5yhQ8cGUbKb5Ui1J2Amh/RdrJM+/sJ9u473TNevf2n7t0jHm6AxMvPbntaNZiqTZGiFIMq+xiLIUGJORtsVwjEbZCKbO3siROC+5zsltoCQEUdc+bdPdih/UUV7bvg7Wh33vr5s0wQvWlwz3wrkNwbWcdxwRlo48TK6thlUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=flfnRN9f; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6uphqT8dgu9nUxlY3ejtLpEMlfISUe0MVoX1Uta0pOtvTyAHmiiEHQn/82HCZa9UUq4uRJ7Y2vMeFjPt5XPbmlXA+PAz0F42SrA6hAlLSllaDGTER+viK2Mvw4aPMtekTHOO/9WH4mDEYtG6QOEfIgMlI3U9STeBNhTMwouPei1JOEVI3+5kSZgZP2FEUOoN5weQfzuGB5oWLMI63Qko5PMUyAJ6tG/nOGqw7ANIJItx7omKn7w274iIh1dlx1jBLaU4LfHsrNkgrMri7N9zNJ/10zi1OYB+hayLWrNfwtV/4/yHtgGr1gEzAwXh1p1TE/y0HSBUjc9DHO7JJFBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC+Sn0GnGUg2BzNNzQNKhWV7l3mz5HP7mDl/DEBsfjQ=;
 b=M2qCptqgZtA5Q+KX7BEwErfqC5WxMcaLScIkifg7J5fvzjpqahRPKLfVpCNxgKJ37UeUkugPFrMOTTu/UgU7vkqIAjpjl1Qk1zMlcV9LhgtmRn31hpZV04WtgYoHNw9OEHjCVjTT3QAUjY/P/NNmJjKEus/X7p/+Kz800GUsvessKsnM3umw1/f5C9x3lskNP8+kv1HfQ8SgQGhqf8/fhRRst+LV/2aPgnfOcrldF39JDTo7A7nFTe+oW+0x/BTW2dpT2JysIpo0d3/lXjSeTNOAIOGZmdQkRLjiOaaRC+z55scV1rNJtFIihTzTiA6/4zqE/SbZToXdj4peblOJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC+Sn0GnGUg2BzNNzQNKhWV7l3mz5HP7mDl/DEBsfjQ=;
 b=flfnRN9f7foH+qFuy99sDjnmF2SCoBiYrqYpDBN9ALV6bg9XHzMt4oYE30zNNu5elaiMFU789eCiRMvdRJxnFXsNFJ5raHyozVRc1wAr7PuuwQnbr35rOZASt0ZlgnA888MvQTGto1eQ1deJ9dlzvI1veh49/AZxmpc+cz1PZDn4V6FRXKg+rqUrAoczrdX2rHtXqseztslckG0BwwFlav0BFNSeUtg1EOf4TmF7c/bToc402YUIFmXysKFiCDb+TP9VLEdyMjOO8+z0FqeiEulw5dMC2O51daSqlguWpmBQgS42BpAyXeNayR05XIVxIhCdSJMPSp1tDx6TJ2TT6A==
Received: from BLAPR05CA0048.namprd05.prod.outlook.com (2603:10b6:208:335::29)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 15:45:05 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::29) by BLAPR05CA0048.outlook.office365.com
 (2603:10b6:208:335::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.6 via Frontend Transport; Thu,
 16 Jan 2025 15:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 15:45:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 07:44:54 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 16 Jan 2025 07:44:54 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 07:44:52 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>
Subject: [PATCH 0/2] Tegra ADMA fixes
Date: Thu, 16 Jan 2025 21:14:37 +0530
Message-ID: <20250116154439.3889536-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: b3aa63c9-34f0-4bc2-4fbe-08dd3644bf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?01htBDJPB4zHzSecAVvIZ1DiX4swxXoRHJ2A/HOePCQwyBlRh+cRQcnkHV9c?=
 =?us-ascii?Q?8yBVoPzgZidBLh9Efsr8gnjd17uQBop7r9mtoJZ00MzaXCHHWXkGc+5iJYja?=
 =?us-ascii?Q?yglqPDKinG5Rz2qCvGEij94FWlPaUVyMbSJ0ghJTscSRyVX3Pp++eN2ekDLX?=
 =?us-ascii?Q?22Mz/tRk5wzrcw9JQ6RkCi5EVwKLcSEwn5pFc5DtyH7uVbo6XAcPu4/0nUbs?=
 =?us-ascii?Q?sOHFse1HveMqpK2oQc2W5LIK+vMg89dzfEa70LuGMB2ugNZxBmGUgafK3k59?=
 =?us-ascii?Q?La5Sd1oR6zd8Fqb5HYUCuXhan2foq7aryrUmDWOPmHMv4qHto1H14OisH29Y?=
 =?us-ascii?Q?9xvaWxqVcJw6mmPWHt1CDw0ul9fGIVK575v++GAQcISqdgf3ggfwJN+1lpwS?=
 =?us-ascii?Q?wayBASvmDGHwo12qozGe+VC/FXcF18T7HtwvTeR8eRnH+kt0Lf1TbAFDN7YW?=
 =?us-ascii?Q?CE+/edinNWVzaRWYRr5/kkfw76wnp9s5NyxTKVstf580udHHsrfa4poH0e1A?=
 =?us-ascii?Q?ctYf6jQrlqpXegke9w9OWITWkB8nWQYR+4Dct7fSR9jCOWev6eCPlWzIwuTe?=
 =?us-ascii?Q?hjQuWg6CDZ5gmym0pCak6lgbWu4g6LxC41COy9+qoMTrRzsd/34oolHXBF/J?=
 =?us-ascii?Q?kvtiT/N5q5UaLB4316kmCdcb7sQfae5yj9D4ujhA07Euqa0EAh+WfVoyWs04?=
 =?us-ascii?Q?fn8jvGpUbAXBLSyP44yC/dCZ7WWJeNvWPprvDIJ+B3ES1YBEg0hRpooMF1W5?=
 =?us-ascii?Q?4S+j4c54eXK6/0RgvVI/0oS0KRYfGtQT7iRZkVxhn+H3qSQUHrq3azocmkbp?=
 =?us-ascii?Q?gLCKHu/BTMXGQbiqk0cYUlo3c6+k/3sK0IS8c9hS0BaE4YfhJ+18NL0eYpMQ?=
 =?us-ascii?Q?igEKLmzRjQd4+ctYu+JvfKRspG5+j/dlXmQEwzMIfX4ayOBa4PZTxApU2m0L?=
 =?us-ascii?Q?1GU4vyw+0NF+gmkmXoyWCBZqhAyVB9sLrFATs4o3v2knFxD/ZJ6G9dTn4SFE?=
 =?us-ascii?Q?Qb1J1wQ4pIP8ENZ8vXUXcE+Cy7xS+3ffoCKTw25/R75/VwntUNJ/P9j+my03?=
 =?us-ascii?Q?EXzF7cctYOYxn2cjecet8N2upcFY9X2i5921I/mA9fW23cdvyQmSKQyf1IyG?=
 =?us-ascii?Q?zNjt4mnRM0rVEujcotRdz2oCPJuWihd6pMFVvkwJ4D70SeN5jdAv0k7GoNWl?=
 =?us-ascii?Q?ToUof8GQZDBSgiumnDH7jWtLwvbNSL1BbvAapZsdTVDwbYQ31mpCa3Pl+AK9?=
 =?us-ascii?Q?x1C0gPoGnltn7HX72kdprzB+o4RY548P6H3hMSjChzuG08FJrDH78ZlzcODK?=
 =?us-ascii?Q?25OORv5Ih6+8UfKapQNfFl6rg37C8kTQvWgDgWCoI6uPwaRsi0XbkgKp/Z3f?=
 =?us-ascii?Q?qXb1Rq9+VEEN4J32jvxtSwd9q7TJl2x3Mlsgt4WxZP6gFYB4fIrXIKhKVe3C?=
 =?us-ascii?Q?ToiHFd2goSg6nYjGU+JVbrRaIS/tHg6/g50gDT8VYwIa4FJoHKexkEMtI8z1?=
 =?us-ascii?Q?35Houl8TmWGwlAA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:45:04.7893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3aa63c9-34f0-4bc2-4fbe-08dd3644bf30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322

- Fix build error due to 64-by-32 division
- Additional check for adma max page

Mohan Kumar D (2):
  dmaengine: tegra210-adma: Fix build error due to 64-by-32 division
  dmaengine: tegra210-adma: check for adma max page

 drivers/dma/tegra210-adma.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
2.25.1


