Return-Path: <dmaengine+bounces-4903-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4278CA90713
	for <lists+dmaengine@lfdr.de>; Wed, 16 Apr 2025 16:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C512179E50
	for <lists+dmaengine@lfdr.de>; Wed, 16 Apr 2025 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEA91F463D;
	Wed, 16 Apr 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HqWfQe1t"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21761F585C;
	Wed, 16 Apr 2025 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815404; cv=fail; b=QI71hTiun18JPMC9H+f6vxFCMWoUf7UVFy8fvgpote2r7iMkOjuZuGaBdLCXrdaKe5ejlXsgpIP6GbwmVamZoSfTkYYzwSRVYGJFZeNQTJeiArn+aAFfa2Cafc66ybS9UDY5m8mTNPzGsJA8Ryb2TzfyFYMifbO3LiMN2Jzf98k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815404; c=relaxed/simple;
	bh=obDSsgYT5uh4TEO5NBPgZmrDpflocPRfQjIX/C/oBpM=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aYx5kzSMoz1K+ghyERwmbBDi0EaVH+Y5BWPnlq/Z6bKO7olTbG9gWDlojBr3Cx7HFn5vPPVNWzpKewgC5WX0xEa4r39uXhqDbaevv8Ixvw8SRF05upCozKKOGsTYr4dYnmUFkvM2EQgPU8pExLfpx2rygJSkhKeWqC56S8RDPT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HqWfQe1t; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKQs07im3Nhdahvi/MMYLaKsh+TbnhZW/l7+SQr7H7Q6jqK9eDoh1VyO9rKBWC3x7jBH0N8pb4x46MO/xaoQDkc1b0Aqwr1D31BpweORvSFY7BQMmyS8nu72EO5W39XCNLZMaDPl542+S6YppsV32YIgHv/FNwjVEU1c+sIcOyWY3pY/vPMGgq9rJrlzFSfnwaVvhKf/ma4Vl36Nn0HZk5kWPZRY9gjw+E6emcfmHmnuJmONGG9+wiz0Sl8wceFoMKNwHwVkTGY3bwOgYgOiopsjOVnYKqXswuVZINocR8tmV4UTwYr5I81CAPeglN+Ag61ccDhqPV6rBsDeILDYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IDNOgr1zhitGbiRglkabN//NqJEs8sIKg1z3NCv48w=;
 b=NtVsCCXbplAYwfdlvCUZ8gtzl00gB9F8BK/B16vWYB8hWavK1wvcP+4t8Nf6xamLO9wqpeZIdGW3ss63MPdWonuVo/hi3xE+eVnpPt/oGf05QoqJawUZrh80HssONvajU1Gm5XuyRzDCMfF5UzBcGAs3/bQsI+xReK9M62hPsWtbJ5u7egOBHcLWngZBOw3hQfNf191aSW6NwbdImMPJoLeSYGWc6kOZ5prXc9WBT2gAo7x/6ycK4PeeQ0ODLMBM8V50XJjVM4lM3uKxBYIb8vwmvdmmCSI6gux7UQ9n7Bzyg9jPb4qNbmNFnnb+lxaFSqbTgTDH66DVFkUtYBpthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IDNOgr1zhitGbiRglkabN//NqJEs8sIKg1z3NCv48w=;
 b=HqWfQe1tgEQNK4kPK32clZEkW8aibntX6L0vuCT7m68EJ/05ytMKAct0hg6NosP2Rtg6IP9FUNTclDeHSEGuAder4tqICT+2gStOBSBSyTjzJxjSqVfz6/6XX7lE2uuVi1MI5Os3gPsmDiiMUyRke7wVzgC2Sytkqzphn1llAgA=
Received: from CH5P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::17)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 14:56:38 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::8b) by CH5P223CA0005.outlook.office365.com
 (2603:10b6:610:1f3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Wed,
 16 Apr 2025 14:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 14:56:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 09:56:37 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Eder Zulian <ezulian@redhat.com>, <Basavaraj.Natikar@amd.com>,
	<vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Eder Zulian <ezulian@redhat.com>
Subject: Re: [PATCH v2] dmaengine: ptdma: Remove unused pointer dma_cmd_cache
In-Reply-To: <20250415121312.870124-1-ezulian@redhat.com>
References: <20250415121312.870124-1-ezulian@redhat.com>
Date: Wed, 16 Apr 2025 09:56:36 -0500
Message-ID: <87plhckvdn.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b3cc75-5d38-475e-adb2-08dd7cf6e3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MkDnhu/RFC0+FyuM8UfY72Wo32taDYhx3M45gjFU/UxpCtZGd6GrD2Ah6dED?=
 =?us-ascii?Q?/4ek+3bIRTXFjYnR+qKxrQ6T3Wze35dNeje6yUvuyCtFBGIWh1vmcIpV8K5W?=
 =?us-ascii?Q?3Xvng1/OzFir+cULIGpbZaAN0SBMLQWjt4dMEaNb8JaFS5NtGaTLFQxNgy+9?=
 =?us-ascii?Q?Dz7hSKLkGUP+HEx3EUF+Uh1aPaTdWrUaWZUYEUG2FVDA/Vd1NACkoE76XI5q?=
 =?us-ascii?Q?yGRTu9ivYFCIQg+PnPybDfPM5s6r2SH9nYCOqVeapq0WvYJEUvNchfhMM40B?=
 =?us-ascii?Q?0VZivyvd5Y/aPgqaRAF1+p1xhCxpQ7+zWMseO85tOlarM46DOrHwQblZWqMb?=
 =?us-ascii?Q?vRtgvacgaVKYUaZ9di+CXKkHVljrwq9WyAdPcn9WjzXMullhExy7+oTKlUVR?=
 =?us-ascii?Q?pKrWTMMHMcfbbH131EAeWCy/yWvJ09ojtKa+RQvmLRAKMCZ559yNor85s8AW?=
 =?us-ascii?Q?6NX0h/zbnXdg/8EIj+t2ppsf4Fj6qTtXmT522cA6UsdVDaGBzGr6NrK6TmAL?=
 =?us-ascii?Q?7hlEa5Jfj5IOEKgXzBB8ToLMpROGP0eeOv7x/4qnpz+iBydsBE7M/uU5xvAh?=
 =?us-ascii?Q?27+Kf//yn+e9OKr9ypPnzwf7Ni3C0XSXWYAGdAVB2oCIFcuRnYswqncf9IcB?=
 =?us-ascii?Q?VsAambg7PBprxiFlfBRf9vYCgDvYUncn7THPPiahmZDUPQBH/hF5RnI4pv8q?=
 =?us-ascii?Q?MuDtW4/XP4cMHQc02M1qiAMpEU0pG3NYFdpRyjCppwQPZr9XDRtFvxr91nMM?=
 =?us-ascii?Q?+CMpNo1bXza3DSt36h/BXPTUeR6IvW0Lzxw8nlRauIkYnyG0m/i9PWmH1aug?=
 =?us-ascii?Q?AUbqHCSl6PMOndRbyng5ENqBkvXtiZtR7yzDxhmMRSPJ/XahQWv6XPTmoiv4?=
 =?us-ascii?Q?jcwLV36cypT1j3m/2UlGniz0YbINSKWNDEyCMt+tJ3NsGUfKrxmRz5TiTRZ7?=
 =?us-ascii?Q?hO8DxsKKpZtF9hzvk3qIRRKpGBwUJlp2CQOXVpsdRREN1uco5HzhoHPASIAe?=
 =?us-ascii?Q?D/OcDFyHcX7Ig465AGu7mGK/iuI5wfj9drPIPMvER0h1HuArwr6frlpWH3BJ?=
 =?us-ascii?Q?KO2dDroRqSMJxpL8+MTFBpuMTxDUZIWzf0xo1AfDh0jNVF2NOZaDXFHVmkpj?=
 =?us-ascii?Q?tj8aOk1kJR6jTUHGc9FHPxrV8FyjqCLpSDWGSw6Ps9dJAuu5GcaoyN58cMCC?=
 =?us-ascii?Q?ZI0m745mc+HlH7CCyw7VgSATmguHpLjOgMGFmMnmo4+9JkbZCmDhQQiGmU/l?=
 =?us-ascii?Q?IOas7zhxNq9K9h4DJSFojfOCYcWWF2JjHjAiPrSu4W2Lg3coCqHW/iQCJBlA?=
 =?us-ascii?Q?/FdSNrUpgZrGBy+SsDnE2MKvjDBKG3MXagIWEAszVZKjXY360GrXk9sGgEQo?=
 =?us-ascii?Q?wm+5uvYi4RSBDMTXTQexGbJ2+TE42ZT/BIZUEbtG2DP0iVUtjdD4lGvP7wpa?=
 =?us-ascii?Q?z1Sj9ayqWxbv+gV9XJa7spI1EbgLQPUJOGuKoizRYcMH8LaDNITC+g3d9b1v?=
 =?us-ascii?Q?SFzL1yPnKSZlXfRpeJU39/6NBnDH9hrtN5K8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 14:56:38.1035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b3cc75-5d38-475e-adb2-08dd7cf6e3c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682

Eder Zulian <ezulian@redhat.com> writes:
> The pointer 'struct kmem_cache *dma_cmd_cache' was introduced in commit
> 'b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA
> resource")' but it was never used.
>
> Changes since v1:
> - Remove the 'err_cache' label and return -ENOMEM directly instead of
>   assigning -ENOMEM to 'ret' and jumping to the label, since there
>   are no unmanaged allocations to unwind. Based on suggestion from
>   Nathan Lynch.
> - Fix checkpatch.pl error: ERROR: Please use git commit description style
>   'commit <12+ chars of sha1> ("<title line>")'
>
> Signed-off-by: Eder Zulian <ezulian@redhat.com>

Reviewed-by: Nathan Lynch <nathan.lynch@amd.com>


