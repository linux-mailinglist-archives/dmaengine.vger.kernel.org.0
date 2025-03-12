Return-Path: <dmaengine+bounces-4721-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265B1A5E403
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 19:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F383AE918
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DA02580ED;
	Wed, 12 Mar 2025 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZLmDwPMy"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE62417F2;
	Wed, 12 Mar 2025 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805936; cv=fail; b=Ft7PlWozvrzrpRGDApVoc+amy6nQfU5vZDVYmUDMjhJqO3XuSd2uDboPg4H+0RRfxl5KH5sAJ7DxaMkMNYiJo0AzZceLYuTmGlMbr2fZRptrdUfdqXzHhenThX0b0chmBeX1wtCQGqcELYbyS7YYpUe38sdwrO+MuXTCSMIHREI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805936; c=relaxed/simple;
	bh=+jkQzT0CHutegRfxTxMY01BUaWhuILyKDPf6FD/sXTM=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nI+2vWSOWAOv2123h5fm+jxc0M/qrUewaS9wzF3Z32v/yUaBlznSdRhLvz45SeqK9461OceLsHOmWYOKOXCsO2jcyVE06JpKF4lVmrBckuF8k3r+7eTr0bQAwBDhylPfdOqihWjGeMrFMJk4yu7CbqlDrdW2b1b4qnDvLQax8C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZLmDwPMy; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4kJyYPwPCN3D8xTHY0OIxaSN0F1J5EHPUL+kET9v+Oi/Nm/RTbltbrq6kDRO//gXHidTMXLJLb352ixXLYKfBf4CRUfdHIDgOtDCQ+04vn71xljKacagGuZN4muREXpMxhZQCLrFiJpSsuU3zOYhfIUE3o5R4N2RK5OUTlFZCLxsStCZlU7dq7UgV5+KNPjaOoMMn9tkOigGd1NLPi/nKdbpnnNTNMogj9+yFQfRyrdzOorFORZPL/ZOoIP7v0eXHUZIQKFXOyuHg6sU3iIbEUEDv42t5T2KiNZqk4KYI1Zq5T3PBhoQEeR0YySPiSR8s7DZ9uATRZ8zrXacJ3+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR4QQvp8ZCPsqYlGT6nmY4adtPO7H1RC1KQdoa0BUQM=;
 b=XaFDwxugX3tPAqUZsxkVGnScFveZpMRVj/UvLZmOJiHwE0m+u6wo8/a7jCBoofXXUXyflMB8axAjT+bGb176EZJk6ZsBBAXKqsQXQL0J+B4+okSXz5CIqhhU78uh+7xKu5Gpnj0chwwh0cyBul5j3PJ7gCqM8NZEDWk79pdmq+fHM2pIfBOYG6kbTzbLvh1jq8odTg/npBy2C0wKgvdT+3939rwxnHE3CEp4WP56CkStoIfJiSwF0k+nMzUTNMP1isW2ytgBRtEakLHgVk9v2445Yqca9gm/zgokmC9vDrIlAubIC0VEfInY5ruxBAfEI/19P3dT2Mguy3eRLCfgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR4QQvp8ZCPsqYlGT6nmY4adtPO7H1RC1KQdoa0BUQM=;
 b=ZLmDwPMy6Ziii0CBkTzGFqXjM9jTVP+kvPt+QydCnoOU/oKZm/NPkwaa30aYuw1qPD42F5PP7qvP2wJztQ4ozOgyV3UzUcKTxRaLITne4S3hsrjJThPJv7W2OTJyEUJ+TwpRRM15AvOcq1OL4j/ED6XooeDAGOIJSZkHnB8fRjY=
Received: from BL1P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::9)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 18:58:47 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::96) by BL1P221CA0003.outlook.office365.com
 (2603:10b6:208:2c5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Wed,
 12 Mar 2025 18:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 18:58:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:58:47 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vinod Koul
	<vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave.jiang@intel.com>, <kristen.c.accardi@intel.com>, Vinicius Costa
 Gomes <vinicius.gomes@intel.com>, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
In-Reply-To: <20250305230007.590178-1-vinicius.gomes@intel.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
Date: Wed, 12 Mar 2025 13:58:45 -0500
Message-ID: <878qpa13fe.fsf@AUSNATLYNCH.amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfacec3-0a68-4afb-cde2-08dd6197eb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1AjIkxg+c6MulIYkJUpm31DZSoJQBxlfga2g4ajkS306mGzTjHtbuIoOI5u/?=
 =?us-ascii?Q?BsSeruvTSVFm0FelJKDzBsb184pU7rG0xdLdf2nj7saq3ZCUt2fWPJtviRH3?=
 =?us-ascii?Q?GNCqL8Tjk9/WqsNhIFoqmpK87jtsqMEluFdLfQ3ebWBOKxct3/Zo5wou8D3h?=
 =?us-ascii?Q?EdpC6AVNK5qCG9pJmnRxWf0lt9grGzd1smu934qiJxNrKq4c4yW57nvnWQ4l?=
 =?us-ascii?Q?gZQLaSxb1CEI7V+djoycmhusyvi0gmrGNfz+kxL4yBaIh5JIg9ox/ha/wRSn?=
 =?us-ascii?Q?hMq/NYVSnk+URdG3wVCK6v6tOqBmhctVHmK8qo4hd5D6DojHUz+TuGPOqOyK?=
 =?us-ascii?Q?/KowE6XmYMcAP8LQQS6DVz2cBzh3yE2WxyeIiycEElB/j97QY++lQjrJiyRp?=
 =?us-ascii?Q?lyiFf2+NTupZC79hQHr3u832mQANtWZqwgqNdeSoFkmHN7GxOk85JsfOAL12?=
 =?us-ascii?Q?NRMFu0ylzdmrhPzjAflv4GSG9NTcJ6seOd9sPjxanIxchxm3PLBIvkARraHM?=
 =?us-ascii?Q?qbc0RUsVubMAtMbMu0qkSTcKjH2WC4uisvY/SwGuceWLuxZmZcHKqhl0MjIW?=
 =?us-ascii?Q?7n8cTRPFrSMkxWAasPE6ZVnTKp7iwPB/W/FsqMkv6Vbj2tMZBlSqt9k2qOTw?=
 =?us-ascii?Q?qCS/VoG/F52k93uSnAVRyvXB/B9mMgRdChZaS0FXPl/d0LwnptRdsmekmKjW?=
 =?us-ascii?Q?0u4gMNCxKPv7p86eg7IBSr92vgJHngFc5CV8unqhi6s0eYP6n/d8Yd0cWQDj?=
 =?us-ascii?Q?FOLET6XOrjlm0l2TgAuffVwnt1XwmA03TlRWZJ/dH9V59KZIS1Oiqwm0bOBq?=
 =?us-ascii?Q?wHTJE+vThResEg1lEwnr2uwWNj0CZwBMJ5e0rqWxTtGvsf2O+8xNTLHg7vG9?=
 =?us-ascii?Q?qeJEOJv/oBS4tEKtnqpA1dpkagBS3Qkwm53ZrjLL7wKe5ABdJPwQ+SspmlQC?=
 =?us-ascii?Q?sKlFyb79zoVL3hhrqeYor/zTF2emJsqXOkidIXFa0tUj3a6EUudzVVLpYDbQ?=
 =?us-ascii?Q?ReHCeOieRE+fAMbWN7zHr39cVKpeWQMpKziR3rU4YWWc2CbIVIz2FiDlRyQM?=
 =?us-ascii?Q?hgT9TfVSB2jK9PfYnMBvY77B3g0w5CuaKAw1eh/Hk53l31kjuWrAPzHF1Q6o?=
 =?us-ascii?Q?kRpf6MEYxE44txkAt2m/h03qL8gQ4KcRByuT8gk9GkUXFqEhRHXW2KHd2Di3?=
 =?us-ascii?Q?uG9g9N6yObPsVMhHUbxR8cVollQdt/QoaGzsA+9HGWSNXJNBccc0UBNPxQz4?=
 =?us-ascii?Q?QkfSWAolyPIm9cb+lyW0Uk3q2F4O+SP8Y2/prDaKdNqjcrXv9AQ/4SlfT6YY?=
 =?us-ascii?Q?svD6og/Uil6LIXZ2+HvoyNVxZUZhDdxgFOp1yqRG2JyJyizrJVyMYzIfJTSx?=
 =?us-ascii?Q?13kqIYTmBqx/iqI1qUz3Y5+/590fMs9QZXXIjhjGGywW4dza3X3zU0yH5UR1?=
 =?us-ascii?Q?hOrEwxNtBr8wfi1Urg/2m29U+8Ou5gub2nozx3O64g4mHulXTyaqiAq2X/sS?=
 =?us-ascii?Q?PzO2ud/CkIrmygg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:58:47.6192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfacec3-0a68-4afb-cde2-08dd6197eb8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364

Hi,

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
> Change the "wait for operation finish" logic to take interrupts into
> account.
>
> When using dmatest with idxd DMA engine, it's possible that during
> longer tests, the interrupt notifying the finish of an operation
> happens during wait_event_freezable_timeout(), which causes dmatest to
> cleanup all the resources, some of which might still be in use.
>
> This fix ensures that the wait logic correctly handles interrupts,
> preventing premature cleanup of resources.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202502171134.8c403348-lkp@intel.com

Given the report at the URL above I'm struggling to follow the rationale
for this change. It looks like a use-after-free in idxd while
resetting/unbinding the device, and I can't see how changing whether
dmatest threads perform freezeable waits would change this.

Note the idxd code emits a couple of warnings about inconsistent state
before the UAF:

[   81.023244][ T1644] idxd dsa0: Active wq 0 on disable wq0.0.
[   81.040447][ T1644] idxd 0000:6a:01.0: Clients has claim on wq 0: 1

Here is the bad access:

BUG: KASAN: slab-use-after-free in idxd_dma_complete_txd+0x418/0x510 [idxd]
Write of size 4 at addr ff11000134978114 by task kworker/118:1/1644
CPU: 118 UID: 0 PID: 1644 Comm: kworker/118:1 Tainted: G S                 6.13.0-rc1-00054-g98d187a98903 #1
Tainted: [S]=CPU_OUT_OF_SPEC
Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.8118.D04.2206151341 06/15/2022
Workqueue: 0000:6a:01.0 idxd_device_flr [idxd]
Call Trace:
 <TASK>
 dump_stack_lvl+0x4f/0x70
 print_address_description+0x2c/0x3a0
 print_report+0xb9/0x280
 kasan_report+0xaa/0xe0
 idxd_dma_complete_txd+0x418/0x510 [idxd]
 idxd_flush_pending_descs+0x4a8/0x7e0 [idxd]
 idxd_wq_free_irq+0xcd/0x330 [idxd]
 idxd_drv_disable_wq+0x125/0x2d0 [idxd]
 idxd_dmaengine_drv_remove+0x1fd/0x2f0 [idxd]
 device_release_driver_internal+0x36d/0x530
 idxd_device_drv_remove+0xa0/0x240 [idxd]
 device_release_driver_internal+0x36d/0x530
 idxd_reset_done+0x600/0x770 [idxd]
 pci_reset_function+0x1c9/0x230
 idxd_device_flr+0x34/0x90 [idxd]
 process_one_work+0x676/0x1000
 worker_thread+0x710/0xf40
 kthread+0x2d4/0x3c0
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Here is the allocation site:

Allocated by task 3664:
 kasan_save_stack+0x1c/0x40
 kasan_save_track+0x10/0x30
 __kasan_kmalloc+0x8b/0x90
 idxd_dmaengine_drv_probe+0x2eb/0x860 [idxd]
 really_probe+0x1e0/0x920
 __driver_probe_device+0x18c/0x3d0
 device_driver_attach+0xae/0x1b0
 bind_store+0xc9/0x140
 kernfs_fop_write_iter+0x2e6/0x4c0

And here is where the memory was released earlier:

Freed by task 1644:
 kasan_save_stack+0x1c/0x40
 kasan_save_track+0x10/0x30
 kasan_save_free_info+0x37/0x60
 __kasan_slab_free+0x33/0x40
 kfree+0xef/0x3e0
 idxd_dmaengine_drv_remove+0x1cb/0x2f0 [idxd]
 device_release_driver_internal+0x36d/0x530
 idxd_device_drv_remove+0xa0/0x240 [idxd]
 device_release_driver_internal+0x36d/0x530
 idxd_reset_done+0x600/0x770 [idxd]
 pci_reset_function+0x1c9/0x230
 idxd_device_flr+0x34/0x90 [idxd]
 process_one_work+0x676/0x1000
 worker_thread+0x710/0xf40
 kthread+0x2d4/0x3c0
 ret_from_fork+0x2d/0x70


> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/dma/dmatest.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 91b2fbc0b864..d891dfca358e 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -841,9 +841,9 @@ static int dmatest_func(void *data)
>  		} else {
>  			dma_async_issue_pending(chan);
>  
> -			wait_event_freezable_timeout(thread->done_wait,
> -					done->done,
> -					msecs_to_jiffies(params->timeout));
> +			wait_event_timeout(thread->done_wait,
> +					   done->done,
> +					   msecs_to_jiffies(params->timeout));
>  
>  			status = dma_async_is_tx_complete(chan, cookie, NULL,
>  							  NULL);
> -- 
> 2.48.1

