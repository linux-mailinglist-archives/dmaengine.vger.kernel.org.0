Return-Path: <dmaengine+bounces-4260-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F489A25FD9
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 17:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31043A8AC1
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0486720A5ED;
	Mon,  3 Feb 2025 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3GjuujvB"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65420A5FA
	for <dmaengine@vger.kernel.org>; Mon,  3 Feb 2025 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599941; cv=fail; b=L72GVVS1Vo3Punxbv58nI5mLJPX1dYmMJelHFSaif1gDM1ql2Xe8JGuGSw4+cFTB4vpBUoLU+1aLVXlziTWQHn4q/bMxHPdPDZ92eRJtkcvfkoRkhL7Fij0QfAiNcvCA8gTdOvekirbivGwBmjxgYyCVO1GWWNY8+nnJhaK4sc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599941; c=relaxed/simple;
	bh=KCCJaKXdSfg913fhbG6yyIl47vzThl7DCoVLt2RIwkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u6DeDLuGTkDR16TrieJmjn8qCkTI0UajSJtfeGQQXwgTRFtYYOALqvlZbiN+yVhbaXgMv8PHpDwPu+kxgl8JVdRW7aMixvV4i6lcMLvzVmnonkF+YqfxrxqbflB+vXD2jqa2IVYVVozhX/gSwivWYKKuMfJblsMtejPC9uR7SkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3GjuujvB; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDZUMf+/zGdeQpKzIvem40MKJ44zj9awBxgl2phVOv/bkeKmD5AEiulg2qWAHrjMcqq2S4E0LiIEm5AZ2COm6GTRdBaSQ6HjeFcHIESTQbM9vBeNg9+qhyrbetbCnX6O7ACO/XaxVLb1BIsRBYV6bYQWu/+KmAD/MNIw7xMMBvFz212a3cCCNKdVqE5nIk0z51eI41E1ZdsaVpC45J6cV0AXeKkXxJXvWiNYoUVdzNRF0jqiXEPiw3mQR3gMj8N80cUw5LhpVpjMSQr+jKpTCXv7FlWo8A2zBViPtpwRQCvn8ep05SaIOzwhZkr0mKuQb8CtEUdPZpvRgaSPakzJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/J+FfRTEVLMCNVm8FaAkjOszjL9jqpXFRE4HItNRuY4=;
 b=zBsj/EhYuTKuBRzimqNzJGjHbJzxES5O+g05rlIzN8V0rYmlFL67Rh/38ZxDcpH1rKfAZRofKijn0Hq/dW6ew4mIpHyU/dNt/jtu4FuWIn9ad3KnW5mtQoVRshOtjrj9Ix+aHarKKfg7hPkmMKB4BzEtWn9rGixN58ZoPt7g9tdQ4cF0tYQng2pcqKTRBq9q0ix67DmpeK9ZH/8a8ZhJhJTM6ylIs9lHucg6NqpS11m5S7NaoHeG5+iLzNO0TBadleB35LAlYYIX4Uo3tOPv6vZNpGPLRRoKgJd+Ixozhd546bBIPUer5T6+fqGE4dedkRWTlzvB3e1TdUxX6whpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J+FfRTEVLMCNVm8FaAkjOszjL9jqpXFRE4HItNRuY4=;
 b=3GjuujvB+/GEqaC6lryZHVm68R86/vfdjFYA93ABIRMJB1sNCjRy/QBPR3LQdw6Udqe+RKiVy4jRmreqaDnqBCX70Cv1qX/caCWCGHguAk4FjT3C4XdLgzz7g2NAKzVA/iudyTrpnRu5C4SnbrNty8dfA9eNVoB45f/zal1H1XE=
Received: from BY3PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:39a::13)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 16:25:34 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::1c) by BY3PR03CA0008.outlook.office365.com
 (2603:10b6:a03:39a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 16:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 16:25:33 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 10:25:31 -0600
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 0/3] Fixes to the AE4DMA
Date: Mon, 3 Feb 2025 21:55:08 +0530
Message-ID: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: f7417392-fd25-48ae-1e54-08dd446f6266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFhjODZKYWtBc1dvaWRlQVJKNGtWVWlWbjBraThFSU1CdUFFMjFGTWtZbGdK?=
 =?utf-8?B?ZGJjbkdZRDllNFFCdmdhYS9McW04aEM1eFh1RGUxUmdLT2xRSE9iTXFOd3F1?=
 =?utf-8?B?R3dVc1d2S01idjdMOW83QjdMZjM4NUpIL0xnb01UZGh2amY4RkFHNUw3Qkw0?=
 =?utf-8?B?UDE2MTZLQWIvQXRrQlZ2Q2lmVHU2L2dVRGNVWW1qdU02enhHaWJPM3UyOUNX?=
 =?utf-8?B?ZldYdHVqeUZrb1UwdXYrL015MzE2cC82ZG9Gc28zSmU3bjdGS0JDc3pjMjZh?=
 =?utf-8?B?bTltdTFZTlNBcHRRS2wybkowZkNpdGJUSlhYQThkeGs1VHBHS0I1eGZTTTJY?=
 =?utf-8?B?aFQ4dlZoZHF4YXdWdmFLZGxDTEo1K1g3WlhmY1JWcWNZTUxhMUVvS003YTBL?=
 =?utf-8?B?ZDFMSnZRRkxhNmJRQ2ozUWc2cHlRRSs1Q01ZMTVFcXJQZ2JiUW15SWd3VzlK?=
 =?utf-8?B?M1lKUmpDcVdMTkpNU3RTQzJ0Y211eVpBVUFDK2Z3dWNLZXNWeHNyUVl4dEhF?=
 =?utf-8?B?R2Jlcjhqbk8xZm9VT0JuM1cwb2YxMkxFenFzTGxKbXcwSWQxUi9IY3J6akla?=
 =?utf-8?B?UG5lTnJkTjVNR2YrM0MyMkxpeEdJazVzMDNtbk84TDR1cnlyUU9IRzVVZ1Nh?=
 =?utf-8?B?aVptOEt5bEp4Z3UvNXhDaTY1c2ZFRDdYc2JNck56Z01jN0tuaTd1MnVZMDFL?=
 =?utf-8?B?cTR4eUd2dzg3TWlQSks0K2JxVmRBU0doQnloNGZUK1J1VHp0bFBoVlVOb2dE?=
 =?utf-8?B?d1B1ZE5oQ0RVYWpzbzQxY0NEbGlEYWE4Y09QTVJteEFrNHJlTHBMSDkzVDdY?=
 =?utf-8?B?NW1iclVPVFlRNm04S3NIUjhGbkNQblNrT3AwdjRtUWZ2NStGZ0lJdTZDQ0FB?=
 =?utf-8?B?VTFmbngyMmN0SFNJL0VIZTJJM2tiN2cxc0xCWVJ1cEF2QU1rajdwdGZYN0VG?=
 =?utf-8?B?c1VXZ3NpOEd5ZjlnOHJ6ekRFaURmd2ZHZ3cvUjViRkdMNFU2MUxzRjZDQ0xl?=
 =?utf-8?B?VktodTJHcDAvRmsxb2JXOEhCeWpLMyt3Y3Y4ZXU3SDVmNXlUTUg2S09MYmhV?=
 =?utf-8?B?Q2Z4Qk5VWSs2NTU5MDl1N2hvTEc3bWxNQ2UvTXFNdEpIV0xLcWJaQS9DVUxQ?=
 =?utf-8?B?SlR4a21pQlFCdkxoU1FzL0w1ZWQvZElqT3FveGtmVjJVRU9NU0wwTE5ON2dm?=
 =?utf-8?B?MzMxZ1ptUVBjdDI4aitzS3UrZ0V2b1FUZG83UWc0ZVZqUUR5dzRoZEQ0VGtO?=
 =?utf-8?B?QmY3dXExZloydnJDcUkzbG9wNVRzVm5INklwRDlsMzZRN1pzZkIxZ0ZiK2NM?=
 =?utf-8?B?QlBvZnVQbGwyZXBoTkpwZWVxU0JkR2hlT2g2K1BJcmxWZ1V1N2M2US9BSmFP?=
 =?utf-8?B?U2FwamtCT29GNlYxWmRZQUNtbndidElvN1FoYnd1UDl2V1JEdWxmeDZTdHhO?=
 =?utf-8?B?KzFGUTlVN3kxRXNFWmEraHpxVVdtaFZEb21MTHl4blY2VFRYUzIyT082OTht?=
 =?utf-8?B?S3gyTHRNdzA1VnFQTnU0NzJBZk0zNGVteHlxelZDZjJFTE45UkwrNEZFcWpV?=
 =?utf-8?B?VUNhRWUvR3lWSjJFc3I5T2JzTUVkenhZOVUzNGdSVFpuZGxuN3drc2J2Z1h0?=
 =?utf-8?B?UWtCK1RrNnNhL05FK05xWXg5U3pEcFg3QnZPbmZkcXU3dXUyRUxQOHFabzJU?=
 =?utf-8?B?ZytCWkFnOG1hV1ZReFJUcDFGWWlaTHYwK2FlcEFTVkdCWmxKL2RNNnd6MmRI?=
 =?utf-8?B?MEUrU2Y0SVhkR1RnV0h2ZTNEMmhzdzQycFdjKzU5YjhWMzkwSzk3dno0d2NW?=
 =?utf-8?B?QU1nNnpDN2FIUTFEOFI3bmpjZHVzRmZCbm5oRnZrSmROZkZDenpPU01ldzhW?=
 =?utf-8?B?SElrbDBacVVsRWZTaTk1VXFqbEJRYTc0QXhJOUNiY1hVS0FTVnZjYlF0N2pm?=
 =?utf-8?B?NWw1a3ljUjRSdDlJWnpTQXpEWk9xaFBVaGNITzk3Vm5mNndabU9acE1GdWJx?=
 =?utf-8?Q?x8uBSbB27V34wdEJFwUvuWVVpOHx1k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 16:25:33.7677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7417392-fd25-48ae-1e54-08dd446f6266
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063

This patch series include changes for:
- Removing unused PCI IDs.
- Use of proper MSI functions.
- Enhancing and fixing the AE4DMA engine's multi-queue functionality.


Basavaraj Natikar (3):
  dmaengine: ae4dma: Remove deprecated PCI IDs
  dmaengine: ae4dma: Use the MSI count and its corresponding IRQ number
  dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue
    functionality

 drivers/dma/amd/ae4dma/ae4dma-pci.c     |  6 +-
 drivers/dma/amd/ae4dma/ae4dma.h         |  2 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 90 ++++++++++++++++++++++++-
 3 files changed, 91 insertions(+), 7 deletions(-)

-- 
2.25.1


