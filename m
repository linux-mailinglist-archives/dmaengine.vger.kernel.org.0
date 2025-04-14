Return-Path: <dmaengine+bounces-4886-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC99A88FE0
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 00:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B7B16D8C3
	for <lists+dmaengine@lfdr.de>; Mon, 14 Apr 2025 22:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0637F1D5159;
	Mon, 14 Apr 2025 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lNPS0/K9"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F82C1B4227;
	Mon, 14 Apr 2025 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744671527; cv=fail; b=F5TtfgnBe9FsYkBg/Ttc7f034/rQdwYgsZxN9lt0z90gNBwrQa5Lh/oC378sTI7h6YXztfJ4xYrg2nKf2ZVaOP0WXm1ZPQF2YwycPgqlV8TzBLX9HcVK8keAvKVgULUe/rnSMMDrt5cNV6JNqOBlIRk8iyKkKJT62aNuc5yDq80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744671527; c=relaxed/simple;
	bh=ncQxlB6K75I5jDvPp1lBJlUYSyjTW9BBNVOpRmtvpCY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nNHv4LGvIgLSAO7V8fdADlXaTe+03xJg+IlTPIHOJHXIKH5+Z0yOKQhDaPHpLVAtkoVMjyzJJEcVxPiPZLeoPRjYYKF2ZyWI6i56wK9/IkldpU6p6SZz53IkgEK3kzwss6vcs5DmYyOYRt4ht/Zn+hclq0es9/gSfIULH9vlnKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lNPS0/K9; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPtuQuottU7moF4M4cpMigJuC6F1VdV1s6PeGpaGr3cbqo8gCWHu6bdVVW2cApQj0z+Y0dsZjqzis2hsuMIqBpLSFdHssNGWXYYEKhuPYc1n9kpZHkblaMzeKy6ODrpKHnz5tRlaed3lcuPKk2zFlz06Y+I2em7gqIcP0XihGPNiyDXO2CgpqX8Eps5Lczp6Jxo8hRzTt7L9CGMM0B4+juh2dZFRKgJZZTiSaWdDhBOWNImOABH48Fn0jQIyxpVMbJyDUOZdFRe5RhzDZmiCHWX8KP6vjHoaiRd/bzOPOrZmttB3uKudFY9JinLqr3e72sAvOCv64EDPXMZUXbN0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0zpViQJbosEWdlKA6j0xdDXMoFaGozkl8rUrw0UYkc=;
 b=r+jDHIc0wPX9jFdtU6edu9/8mUKPgvOw1NV35r91wb/3pM7HRaVs+0cHNw3nxAg8umOE8vY8IxQkzh9TNe1iIWyqnlHXJ95AljjvUgZuJwoNL1prje/oQKKqO9jCmtMFPRtINxLXdP+AOfnRdAS1DqYfx+5/Sbiq81Bpobs3IYpREswBttQHK6mQRZX6a/nv6y5a0ODsnAGdU/v/GfY2mKLkqezWiVy837ZZnbFWVZgURBKmomVh5ZncwIn1u3W/Rjm4Uin7eAcZLHa4P0olnMoG61uiWoa8KpKo073yGEasNNnqVU7lTUaskr2qS1zL65bh1+SsxBQ7L+1c6lAA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0zpViQJbosEWdlKA6j0xdDXMoFaGozkl8rUrw0UYkc=;
 b=lNPS0/K9T9oz3EhY6SQGWemHW9bVt9+WTYGj+2GOgP8Y7pWiwum1lKsdIEPmCgzZ8t9ZzZJzBumVKzT/6mewJ+5KTcCMPvG5bVKhpR/2UFt+YO7xN+yZqhtRqyP9+D/ReGG6nDPDvqWbhdcndC5dpGLHKpavn6kux8bFBgSEuX4=
Received: from CH2PR05CA0046.namprd05.prod.outlook.com (2603:10b6:610:38::23)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Mon, 14 Apr
 2025 22:58:42 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::38) by CH2PR05CA0046.outlook.office365.com
 (2603:10b6:610:38::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Mon,
 14 Apr 2025 22:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 22:58:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 17:58:41 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Eder Zulian <ezulian@redhat.com>
CC: <Basavaraj.Natikar@amd.com>, <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: ptdma: Remove unused pointer dma_cmd_cache
In-Reply-To: <20250409114019.42026-1-ezulian@redhat.com>
References: <20250409114019.42026-1-ezulian@redhat.com>
Date: Mon, 14 Apr 2025 17:58:40 -0500
Message-ID: <87v7r673kv.fsf@AUSNATLYNCH.amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5fb627-0250-4997-8ea9-08dd7ba7e715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MXoCzhE+R4ib4rqiBRGVv2n1FgxH1xId19o97++vEQyuw0bxt6B1vtjd/cwl?=
 =?us-ascii?Q?fVVV3pqw4XUV17IUj+jrfRGY33cknxm1dpjAEjdszPGvG6X1W9UDGIOi10I6?=
 =?us-ascii?Q?NrZ1+G1xRKiN0xj1kbOORXz4T03eB3rzhw0fZM6IFv+a2V3g9zKIAmvFK6aA?=
 =?us-ascii?Q?5zkOB5r25yOFkOn07yOaVP78HaN1s+iSHlJ/egQgC4wUQsVUAbTkK6c2Xacu?=
 =?us-ascii?Q?+ZfNHySGUjcBHG/fvbHjRVLDZyll/zJXuwR0fF5UXhMTWJzhxjlbtZucv85G?=
 =?us-ascii?Q?QPt0qwa5IxNMx+m2W8lX4e1SNgzJ9dxFkr3hUO1NsOkDg+c4p5dA7v0qj0zG?=
 =?us-ascii?Q?RH1Ari/A0EzP333ocHoZtKh3B25So8PMTNF1v1FcXYGyDZ2ghhhjGpOJuT7B?=
 =?us-ascii?Q?G0/KI3KeJGhg7j5FHMHimrbcLCnOThPdwrCsVwZPP3m3sGaUsfWn4ey+bCKs?=
 =?us-ascii?Q?bF5F8CqzCkvUo3iyzvy57qJk0j3CvpcMFrbXv3AAWB9yRZ3snn937lrYEniV?=
 =?us-ascii?Q?+FfX2DHvqnYhN4v5PtRFuD+18tqME/IrscUdAspMY2wbSuJxyqpyYgZ/vEE3?=
 =?us-ascii?Q?wrciHC/CBleqebcO/KShDqybX0it3F4E59XaoH42FilvJlHyvxesVZ6hcOND?=
 =?us-ascii?Q?Pz5GPLRTtDL+fKT7OQnpht+NaVX1uxcw+nIVaaZH5LLIjiuXwTVoaSJY8nez?=
 =?us-ascii?Q?b0k10BcyfnzQmYN/1lmgS74oIYZK8UBquFGhccZziEbBbPQVSQVep6L4MGiX?=
 =?us-ascii?Q?M5/eCjGRNGYwsRdmk+moGU8JIcqAqinN0exr5IYivW4vrgnMktZt4vKp3Du/?=
 =?us-ascii?Q?6BAPtho2FYakYQ1g3mPDJyZSAIMYFDK/z5emT6W0Rp23Nkkls9mzoCY+8xBY?=
 =?us-ascii?Q?sVV639D8pUnsXqDsHPOs0LNHPOFJZHGtskBeIYOBfsx9ndZzJRDBdGVEy4rX?=
 =?us-ascii?Q?0S+FCOBdiVoto6X4HOoNrT3M1jguHG7cqd6Qg6qeQ0QuWmCC2ajDyfLnbk+t?=
 =?us-ascii?Q?YWubvzos/WLYJA1dS0bvsVycAefgXySM8LRnjFpYTxjADX/H2bgBhNgXuNcE?=
 =?us-ascii?Q?KWOUHlkzR/PHeErYvphiuBJPXBzcoBxLj2Jwsj6JYVWo10V2DaErDDcWqmd3?=
 =?us-ascii?Q?+ihXyIGaaL+Ca14X6FEfiEYlZEaC/GRfg/XKHJDS6zs6LRR55+j/G/q7zUOg?=
 =?us-ascii?Q?z+RZgZ6BzOZaK2AAiEvLFzOCw8a7I7Ochd5eEUM2keaMn7NWt+UrPH2z+Nbe?=
 =?us-ascii?Q?gVY+wZSjOs2mlNC39bz5x2LlmdpV4GIGXmiqdXOHLeUeAM4jvm8J0tQg+WsS?=
 =?us-ascii?Q?rUUElw0qyfHr7fpTH/fxc5F8QfLuFx3ohxLfxjIJYr/sCfVNTV5/DaRb8GhX?=
 =?us-ascii?Q?lcD7Zg5DJbTVG3+44adF8+EuhAZAADQI0JaufPT245fzDJ6cqk8xHiXKD1rc?=
 =?us-ascii?Q?tV5fNoayU4Lf2GpqER6qy9FjNz4xW5rV2KyIVuZwrv7CD4FnMJ1DR7mtmw6L?=
 =?us-ascii?Q?jAwhWfnHGcJetvCM1batQFscvgj4PmlOaAT9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 22:58:42.2244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5fb627-0250-4997-8ea9-08dd7ba7e715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140

Eder Zulian <ezulian@redhat.com> writes:
> The pointer 'struct kmem_cache *dma_cmd_cache' was introduced in commit
> b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA
> resource") but it was never used.
>
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 3 ---
>  drivers/dma/amd/ptdma/ptdma.h           | 1 -
>  2 files changed, 4 deletions(-)
>
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 715ac3ae067b..3f7f6da05142 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -656,8 +656,6 @@ int pt_dmaengine_register(struct pt_device *pt)
>  	kmem_cache_destroy(pt->dma_desc_cache);
>  
>  err_cache:
> -	kmem_cache_destroy(pt->dma_cmd_cache);
> -

I think you could remove the 'err_cache' label and convert the users of it
to return -ENOMEM directly, since there aren't any unmanaged allocations
to unwind:

	desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
					 "%s-dmaengine-desc-cache",
					 dev_name(pt->dev));
	if (!desc_cache_name) {
		ret = -ENOMEM;
		goto err_cache;
	}

	pt->dma_desc_cache = kmem_cache_create(desc_cache_name,
					       sizeof(struct pt_dma_desc), 0,
					       SLAB_HWCACHE_ALIGN, NULL);
	if (!pt->dma_desc_cache) {
		ret = -ENOMEM;
		goto err_cache;
	}

Otherwise LGTM.

