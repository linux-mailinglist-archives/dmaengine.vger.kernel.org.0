Return-Path: <dmaengine+bounces-5032-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63A7A9F41A
	for <lists+dmaengine@lfdr.de>; Mon, 28 Apr 2025 17:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C943B7F95
	for <lists+dmaengine@lfdr.de>; Mon, 28 Apr 2025 15:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8895D26FA53;
	Mon, 28 Apr 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0XefnwXu"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C7326B2D6;
	Mon, 28 Apr 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852992; cv=fail; b=MElZGvielPJjD8IPFGptE2SBN7NTA7I0V3sN/SHu7ZQfP9gmHGPzlg6RPEKADn8LtF5ZwuCMKk6yrWueAKPtDiLZKFDwh4eVc+atRYWP9AakGi/dZ9UoX7m1Yu7c+ZfkC1I3hk1FJRejh85eMBMmTsz3kYWcsDvP+yNZFhBCvRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852992; c=relaxed/simple;
	bh=pFX7y3lQgaeOl4lkJeeyMNIhgzDvAz9bnYMEnX5IAD4=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dl1XyOjxu69ZzhXQ9JW6YU8TMp2gGu98ZkG4ZMIdS+2jbIBHX2K+c19MXu2SCBnhPyUk1+boYqUvLnWsXp16TUyumxTxMUxeCgzdZCtvdwEHxPwO7Q824reK8iKsjP24RxSw0eB4pdHpJl1aHnXL0Tz/Mb1115HQ63YxPmU3hNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0XefnwXu; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwHYlL4uO/UP1cowzOIm7ECpXXPbZPsHuCa09iC4bJGu2odykVktYbNxCMR7AKHw7w5WnE4DPFEyziLWFs8hyAd4YawPcfF9051lAqRy7eF8xw4u4uM5AFb28hZ2rcYcp3TMTw3lkYInxMxEVgf3XEiRfseMVUI7ZfRdFk0LF5VfjzrkmTYrw2YOjCmSEGJbOIzyfLbYHCDwfs/Tk/lT+Z7+6BDbDqkFQ1h71A9DmnzohQEDzhiKW3iDyzSdIRO5MKW2dz8LGR+qrC9dGSvwqA4is+kKtq+Nwp3xVZ+M2VDkJE0sRO8j8p3cCzHgtZ+MwBOhAY5aqpXf+pGeOGEyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abtB1EmnHZjJOISz2BRMgKsXGuuOAWj3tbJSdAwhj/8=;
 b=gZNTItUcN7Df5WQuh/A86fdM0QDOdvPE3S3Fh2p1x7+vWnCe8+18S4XIRwfV/77oZhcd3sUEnsxxVSrF12EPnjfJerGyWzqzUPPVc2dnWpEtzJjawb4yHSJI0rWQtfWu7Xq+LOxI1Y+ADYGDr2AUjN471nrBiGupZiuyq6RcwgQXmO2Z9TepiulhbWG0L/Edf7FvlMyXPBzWwG/4uARm6F7qC5lX+6eG3pRTBXtruLYfQM+xw8IdWplirHmskVg9io+xCDrso+Vv9ba1LOlrbM8ZicNan897dVx1pJtJnPoDNhL7coktFMRKl+YmK0eUMHRQYyn1KNoOzxYCBlrjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abtB1EmnHZjJOISz2BRMgKsXGuuOAWj3tbJSdAwhj/8=;
 b=0XefnwXuq3v3gVsdRBU39qc36ehUGaDuF6WzgxyhqxN6LEsArx0IiGzcvhmf9KMvn+OSUxACXigS4kEy9V6NJszHTmV2WWqaxDxdK79rzubz647wjjYGgjrmKJTmEKk64MnExhRJwk7X7owSIZIu6BiRoaUNKoGIZAOdN5DLkuM=
Received: from CH5P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::28)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 15:09:47 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::17) by CH5P221CA0010.outlook.office365.com
 (2603:10b6:610:1f2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 15:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 15:09:46 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 10:09:45 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Vinod Koul <vkoul@kernel.org>
CC: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Dave Jiang
	<dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <wei.huang2@amd.com>
Subject: Re: [PATCH] dmaengine: dmatest: Don't forcibly terminate channel in
 polled mode
In-Reply-To: <20250408-dmaengine-dmatest-poll-mode-fix-v1-1-754a446a5363@amd.com>
References: <20250408-dmaengine-dmatest-poll-mode-fix-v1-1-754a446a5363@amd.com>
Date: Mon, 28 Apr 2025 10:09:35 -0500
Message-ID: <871ptcmifk.fsf@AUSNATLYNCH.amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dea5fc7-bb70-45fa-4ec5-08dd8666b697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TTGGNNsq1vqWiwNEf1ErNpeeFezC66dIXI93a7KCHPI4hkLYYMNkAphalmt5?=
 =?us-ascii?Q?qXw7schU7XLkSCC6gkXyDiyt0fiXnDakm3xWTDoSX4Gu3IjbbBMUV6wHh1TY?=
 =?us-ascii?Q?bDJdJ0HK9SC+n7miQlXdWb4maixR08yWoUBgf26nADU3Hie8Cs8mcT0dcEtA?=
 =?us-ascii?Q?N74yCGcGKif7ht7sJ1T3Ford8fFtLkE3ZmhW2qsxiVg1VZV8zGGra66zzjIm?=
 =?us-ascii?Q?Z83Im+VnVZ/uCbEs+Yewvj8fuoLkqGUnfoTqxuNu6wEmG3o6hNIHosaZEMvn?=
 =?us-ascii?Q?PVp2zkJ0HAab8hX1APu6IvO1A3N5Jzj20yZMFLmmx/UHq4QmN2ZzBgRkYV7e?=
 =?us-ascii?Q?MtkFovd3YPQRBCP1LjX04D8Io3swXFPdERRTMmBTcK+U/W5WSWh3Th4ZQc/F?=
 =?us-ascii?Q?kCRxyw47OB+OGPxI79dJb93tZGO2PvtVj8htLlU00F3F2P1oPn/3yFfFknUA?=
 =?us-ascii?Q?Zly3K0m3fn1KE5tgbI3mHXyflcKFSsrgFN3lraLPaUb1IDqWYS+itmFj3jg5?=
 =?us-ascii?Q?QEgFKxiaOJXCaKlnC9uTRPobi9kD9i5MiepQggRsQlyS0T2m5ghGWMtZIaAp?=
 =?us-ascii?Q?4CraxtTqWgit3xJBPGr5/NbjfGcikZ5aHVUFPOygJ1zAi6QdIVs2IJcS71UV?=
 =?us-ascii?Q?PBGRvXupAnFHS1QA1KP7e1vNzbynzb9vS+3yMdjMwi14ou+OGGijXje5hwsS?=
 =?us-ascii?Q?hiiYDSJ+p1rRSGmuJgHKdhZyKsp5Koq4UoCHzzIYcLjcJ+M2NPDrG5Q4obHD?=
 =?us-ascii?Q?mdllRqk6ZD+K72J4CkBbNUhRCY1qgVLEOXIIFUkDdZXZKNxSxSr+zK1wL4EN?=
 =?us-ascii?Q?lpFtoB50ayyX5lx48cy4zI2b5BPFKWhjsJhhshSozYsO75bvjtpf/sJj3vDC?=
 =?us-ascii?Q?OTDQX/p3VHeRuephmwSrgo+UaKraTO6CEAck0riP9ofNRFtDsJCaiLTI1g37?=
 =?us-ascii?Q?mIATNsxr/9VlViN3PBMtd9oaX4W9d3XSnY+S8hEyN1KFaXN/bcTNg8S9BeNw?=
 =?us-ascii?Q?LYZbVXL/agQWt6Ydjb5EoZzSA6jUfvRgioDJlvh/nZKzdLTrP4aCmfpx0hD3?=
 =?us-ascii?Q?DzkOFMz20DO7UMdFdWzKG+NKSFP/z9mtwhdaaIxf7Ahqu6DnaV+QfazIDtKO?=
 =?us-ascii?Q?MRsRVka/J2QKaOyfa2D0n3siKKUjVjAhynV1pFD7XpNNzPsqYGzLAr7LMskQ?=
 =?us-ascii?Q?eEMm058+TxULi8gZelbyFDRfG87bWx37PDCpdW4j/JD7T9eIac+qti34CAE4?=
 =?us-ascii?Q?Sz9UcSL6DdwwCUEq6uNYwoSwvpUj+eV75FYEd8MWn6oq6l8NjxEkAqLUEc7N?=
 =?us-ascii?Q?nWhezYXyYxN21hfnYdkKJ04FsM7P08oohBpnuhzkQ6RTa9nkv9qvonJavvAp?=
 =?us-ascii?Q?xSc8r2nn7dXGH5OPaPtW9vZVVdSv4BHFWXwwsPFIp+FCQFo94fwRwMfs+iOI?=
 =?us-ascii?Q?tpwZ8i3aRBe5To3kGI0+cFPQpl6rdexuzK65P3wWbKa3NQ9k5e64eWX9cQfM?=
 =?us-ascii?Q?15GZfsUsWTZjzYsmvlzYSUj+x45lAgygGYkR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:09:46.3789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dea5fc7-bb70-45fa-4ec5-08dd8666b697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

> From: Nathan Lynch <nathan.lynch@amd.com>
>
> Invoking dmaengine_terminate_sync() against the channel after each
> submitted descriptor is strange. It's benign when the test is
> single-threaded, but disruptive when multiple threads are submitting
> descriptors to the channel concurrently:
>
>   # cd /sys/module/dmatest/parameters/
>   # echo 1 > polled
>   # echo 2 > threads_per_chan
>   # echo dma0chan0 > channel
>   # echo 1 > run
> ...
>   dmatest: Added 2 threads using dma0chan0
>   dmatest: Started 2 threads using dma0chan0
>   xilinx-zynqmp-dma ffa80000.dma: dma_sync_wait: timeout!
>   xilinx-zynqmp-dma ffa80000.dma: dma_sync_wait: timeout!
>   dmatest: dma0chan0-copy0: result #3: 'test timed out' with
>     src_off=0x487 dst_off=0xf8 len=0x171b (0)
>   dmatest: dma0chan0-copy1: result #6: 'test timed out' with
>     src_off=0x227d dst_off=0xf99 len=0xf7a (0)
>
> Remove the call to dmaengine_terminate_sync() from the main thread
> loop.
>
> Fixes: fb9816f9d05f ("dmaengine: dmatest: Add support for completion polling")
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Any feedback on this change? If this is a case of user error or
misunderstanding the code, just let me know.


> ---
>  drivers/dma/dmatest.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index d891dfca358e209c9a5c2d8b49e3e539130e53e8..4e109c45fe0c5a7e8f337efe6e00e0616977f770 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -835,7 +835,6 @@ static int dmatest_func(void *data)
>  
>  		if (params->polled) {
>  			status = dma_sync_wait(chan, cookie);
> -			dmaengine_terminate_sync(chan);
>  			if (status == DMA_COMPLETE)
>  				done->done = true;
>  		} else {
>
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250403-dmaengine-dmatest-poll-mode-fix-671b02dc9084
>
> Best regards,
> -- 
> Nathan Lynch <nathan.lynch@amd.com>

