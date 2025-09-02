Return-Path: <dmaengine+bounces-6334-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C62CBB40AEE
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 18:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4453A1B6006A
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F2831B102;
	Tue,  2 Sep 2025 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HdQ9pQOD"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F530E0F1;
	Tue,  2 Sep 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831598; cv=fail; b=D/E8M0Z9dFVozMsuK/UYmnIV5kcuo+zNv47Bmc6Tu/UNhDCohAzyzgUaQoO7jLkdLKU3eCwIW4KtAsSolTDrW2/wZKXwOKThfwmr5GUpzRUXeL23KpGp/O4dePB7bwG4hOpQ+M9DR0Ye7clOfeiYSv7JqbqOWV0IKf1cC69+5/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831598; c=relaxed/simple;
	bh=txOQQqLOyvmwJtHEgP5HAmSK2TuEg4Tw3QYpfC7ci8w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=iMs+5GooeO+eG16uoB56jM5cGeI9jGfVLUL1vvvGHv2GBXWbMsAsFESeVSDlPpCNEWpph9ilWA6bI7G5sobxSJMGWJT9XRnslmbIkY6dBOCq0McNZeEerDEXu/nZ/mHJkBKwnFd1R1cuJgNzGDBK5TL5ZGAGu3DAWANFvHnMKCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HdQ9pQOD; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs0QLGscikOAi8Zu4WUT45yKtB5Hgclg4zF0u+t9YkxDnnP6Ne/28hmwLXNJdomTUFMfFD4Q0g3KUdgW6W3+Kn/utzD8Y58Ix+RqduwHR4au4u/UOZj9M+bOSxG11/rG2oGuSTV8XQjmHGxRT/xmuyKrggEvuhSeSN7wDsTVraBN4OonnI41fd62woZyAyAvRAyxRo9fUBemn3WXEQNMHxMb9/5Sc05IpccDX0yNxM/c41rgczl4/918ZChZsEQ7h/Vf8ZZIGCEp68MuUznpELJ37sE4kNh4N2kjCjnWI2TXJqqyOlen4WXvqgf94MxrCb7qa5fu/B7O+X5caeQ3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8MTrRQ3wYOwYWqanX40mGoykrUG5ot4hkijNd6l1Fo=;
 b=Bpr9st44sSdz0hbmuuVagmpbcloZgzcT7IEx3AFK2ZeoSLVTctjuJ0vdAeCqhoc75imIYM+uc9SlEy0k2BjsWefOsg11rvsSEDOmKk8GrWgS8LQEZ+lsL8J2l1rDSVGo9tiJVteH7aUPT8evdgjQLRtFKaTyw/WTh6qzjrHCMyP05QGKhVyICCSOBnnyLSaigOEI3D86/8FWDYcEqvdPW+jmgv+EawCmdhwLHKhI2YtxDhmTDkcdNLwST3epN+5yOov4LcZk7oFPUBTTjiFaIgz56xVofPPn39/j7Wa17CK+L7E9wYBVELUBYC53ht5a1TOBMdhSetB1m2j6e2eeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8MTrRQ3wYOwYWqanX40mGoykrUG5ot4hkijNd6l1Fo=;
 b=HdQ9pQODRI94wQo8Yirmzv2TwGstzbyP6yOFEZd8PWesKnGf/ZazLcbYjfGlRh+FlFODemE7FUF3ts5/0msS4Iit++bN0hhLE80FdeDfteYyuHpRqp0xsn3TeGh7AS5eR/c/TadrkyBD+mFpOs2i0vfqiEL8vVK4aDlzG/oOQEQ=
Received: from MW4PR04CA0095.namprd04.prod.outlook.com (2603:10b6:303:83::10)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 16:46:31 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::d0) by MW4PR04CA0095.outlook.office365.com
 (2603:10b6:303:83::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 16:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 16:46:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 11:46:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 11:46:28 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 11:46:27 -0500
Message-ID: <318ba0b9-a730-15b1-7573-db23c2cd9e32@amd.com>
Date: Tue, 2 Sep 2025 09:46:22 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] dmaengine: xilinx: xdma: Fix regmap max_register
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: <anthony@amarulasolutions.com>, Brian Xu <brian.xu@amd.com>, "Raj Kumar
 Rampelli" <raj.kumar.rampelli@amd.com>, Vinod Koul <vkoul@kernel.org>, Michal
 Simek <michal.simek@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250901-xdma-max-reg-v2-1-fa3723a718cd@amarulasolutions.com>
 <423ef4b3-d92b-8833-e21e-88ac4153c87e@amd.com>
In-Reply-To: <423ef4b3-d92b-8833-e21e-88ac4153c87e@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dedb09f-bf51-4a0d-7d13-08ddea4044d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG1IMEVMbG0vbC83MHZYWDllTnRKSUE1SFl2akdncHdyK3hRY0wzT2FRc0Vk?=
 =?utf-8?B?eWdtRGxMUm84NnIzWFl2bzlSVHZLbTJ3ZWNNWXZndjc2ODBQbW9DM0pIUEp1?=
 =?utf-8?B?TXpLM2xnbDJqaDZONERVZWp6SFRIQTl4NmgrTThETi9ZNUM0ZndrYkRhOGJ5?=
 =?utf-8?B?eDBxR3dRRmRtSkZaOG83N2Y3RmxOYWVLcTZhald0WUxtSWx1SFRMZncrY2xk?=
 =?utf-8?B?aG1lK2xSc01XKzB2ZGJuN2pTalVLZTBrcCtVY2xuQnBZUEtkSnBtNlcyYU1D?=
 =?utf-8?B?WFphN3hoeHlwK1JRaStTN1A5QXlab3NRa2FvZGYrUklqcVZ2dFF6a2phamhs?=
 =?utf-8?B?U2tlWjZPS01odlpjODY5SnJvZkNoS1ppa1VFRitBZHBNanh3NXd0NjhMbEtN?=
 =?utf-8?B?ZVNGNFFPTWpWSnBHdkJ2d1EwRUFFQ2pCMVBycGs4dWRwME1HZUJJSVFNeGQv?=
 =?utf-8?B?bDQ2M1RBNjdibytzc29TaEl1ZFNaUWNtRmFEWUVuK1Y1WXN1SUdncGZPRnQ4?=
 =?utf-8?B?RXg4MGEwKyt1bXlmd2k3M05BUStyR2hyMXBSaE4rQnFtWktQQW1mb0ozRFNS?=
 =?utf-8?B?YnZHNDJIS0dXK3E2NTZsRk9ScFQvdmMyclNpdk16bDNtNGM1cm4rNmxwV3Fk?=
 =?utf-8?B?S2g2MWN3VzNGWCtDdSsrZUZjNG9wRTdDZkdBdFRCZXpkNGhBZk5WM3NWWk9w?=
 =?utf-8?B?UXNBL3ZrTTIyS3FnN2EzcnV4NmdXUVlFMmM2WXRyRWxkVHRIbDl3K1pDVERn?=
 =?utf-8?B?OE1hMW1hS2MxWFRQUUYvMWxkZGcydmtGZGdpOW9KMTVlZDc5VEt6RmVIRFcr?=
 =?utf-8?B?Y3FwWkdySTVYSnJBZytXbFBuUkh3RTluUDlzNHZwcDdoZXJvMTFpNmJybzU1?=
 =?utf-8?B?dnBkMzJxYllKcEVZMzcwZmpoa0o4dEtsT3lWUFZXeVBFZzhXbFlrdTQwcUpX?=
 =?utf-8?B?RmdQZGxXd0NxWmlzUDRxM3pBQW9BMHYrS0UrQ2FPSVpjemdmQkgvcVRWdklu?=
 =?utf-8?B?TStpamp5TGpUd3M4Qi9KR21OL0VVRmRla2VCK0h0RHhic1VoVXM5UVpZb1Qy?=
 =?utf-8?B?eXc2a3NIbzNnaityR2UzejdDSnIvdzROZTJHYVZjZmpiai9kOVptOXRwUURQ?=
 =?utf-8?B?MmFTQWt3cFlLc0lTc0VRajBhcFAyaUhMd2FzZTJuTFdoWlJYSnpDdkxPK2Ir?=
 =?utf-8?B?WjJmNVIva0NUeTNEVXhsOERTYTJwZWRlWVRqcmtITElUeG5ZdXVCeFo4bEhO?=
 =?utf-8?B?dDFvUnJFT2NNaEFmN1pVVTJrN0t1cUY3QnRDQVNva0wwUDRNSHdLRzZtTndS?=
 =?utf-8?B?RmZtVTFzOVlSRk5KWFBBbGg4bm5FcmxWZSthQ1IwNFNOZmpPeXVkcFdpYnRE?=
 =?utf-8?B?M2Q2RE5ObnBvdElsZGN5cU9XY1hYeTJMMjAwcDhJaHZCblJkcFI2Z2VKSkN6?=
 =?utf-8?B?NjN2YXpMdDBRNHF1TncrVzhlcUdPdUx4MGNiRUNCczNjWjcxa1RQZWpOSTBs?=
 =?utf-8?B?UDFnV2N4RnFIUGZlc0IvaHVTYXpIeExEL3NTaFVkSFNjM2R3ZnRKL3FjcGtO?=
 =?utf-8?B?ZGR1NFRZbTVyZWZDODBpdEVpQUZYa0lPOStHL0RzVzZ1TE5makZQdzZRSkIx?=
 =?utf-8?B?ZTFRbkQ0SmpnaXFJTnNod1ZXb25jMk0xM0M4aTd4U04xR1dxOTRqWkJzSE1r?=
 =?utf-8?B?NFVNTDlZeDM5M3lNd0RSWU5jVFhiRDBXY1dmNFZYTGZheklxOHRYdHpnQzcx?=
 =?utf-8?B?cytHNWw0ZlRRbXhpQll3KzliRWcxejJtRkEzdmFHZTVkS3N3QjdxN3oyTWc1?=
 =?utf-8?B?ZWRvZzNuSDZnNFRsa0JRWVFNQzNpR0lBc1lYK2twMG5hOUQxUUpxeTUvay9x?=
 =?utf-8?B?b3ZvVTNTSnVOZlFLaXJpaWZFcTFTb2FtWWZNS1JsQmU0c0thTXZDR1JyRGVG?=
 =?utf-8?B?TGRVVVZsNG9XWm5vTkNHL09oUWpiMWxHWTNRNmFwWFIycWZvamR4Y2h1Y2tM?=
 =?utf-8?B?QWRyd1ozOExRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 16:46:30.8457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dedb09f-bf51-4a0d-7d13-08ddea4044d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073

Forgot to mention that it needs a 'Fixes:' tag.

On 9/2/25 09:42, Lizhi Hou wrote:
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>
> On 9/1/25 14:30, Anthony Brandon via B4 Relay wrote:
>> From: Anthony Brandon <anthony@amarulasolutions.com>
>>
>> The max_register field is assigned the size of the register memory
>> region instead of the offset of the last register.
>> The result is that reading from the regmap via debugfs can cause
>> a segmentation fault:
>>
>> tail /sys/kernel/debug/regmap/xdma.1.auto/registers
>> Unable to handle kernel paging request at virtual address 
>> ffff800082f70000
>> Mem abort info:
>>    ESR = 0x0000000096000007
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x07: level 3 translation fault
>> [...]
>> Call trace:
>>   regmap_mmio_read32le+0x10/0x30
>>   _regmap_bus_reg_read+0x74/0xc0
>>   _regmap_read+0x68/0x198
>>   regmap_read+0x54/0x88
>>   regmap_read_debugfs+0x140/0x380
>>   regmap_map_read_file+0x30/0x48
>>   full_proxy_read+0x68/0xc8
>>   vfs_read+0xcc/0x310
>>   ksys_read+0x7c/0x120
>>   __arm64_sys_read+0x24/0x40
>>   invoke_syscall.constprop.0+0x64/0x108
>>   do_el0_svc+0xb0/0xd8
>>   el0_svc+0x38/0x130
>>   el0t_64_sync_handler+0x120/0x138
>>   el0t_64_sync+0x194/0x198
>> Code: aa1e03e9 d503201f f9400000 8b214000 (b9400000)
>> ---[ end trace 0000000000000000 ]---
>> note: tail[1217] exited with irqs disabled
>> note: tail[1217] exited with preempt_count 1
>> Segmentation fault
>>
>> Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>
>> ---
>> Changes in v2:
>> - Define new constant XDMA_MAX_REG_OFFSET and use that.
>> - Link to v1: 
>> https://lore.kernel.org/r/20250901-xdma-max-reg-v1-1-b6a04561edb1@amarulasolutions.com
>> ---
>>   drivers/dma/xilinx/xdma-regs.h | 1 +
>>   drivers/dma/xilinx/xdma.c      | 2 +-
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/xilinx/xdma-regs.h 
>> b/drivers/dma/xilinx/xdma-regs.h
>> index 
>> 6ad08878e93862b770febb71b8bc85e66813428e..70bca92621aa41b0367d1e236b3e276344a26320 
>> 100644
>> --- a/drivers/dma/xilinx/xdma-regs.h
>> +++ b/drivers/dma/xilinx/xdma-regs.h
>> @@ -9,6 +9,7 @@
>>     /* The length of register space exposed to host */
>>   #define XDMA_REG_SPACE_LEN    65536
>> +#define XDMA_MAX_REG_OFFSET    (XDMA_REG_SPACE_LEN - 4)
>>     /*
>>    * maximum number of DMA channels for each direction:
>> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
>> index 
>> 0d88b1a670e142dac90d09c515809faa2476a816..5ecf8223c112e468c79ce635398ba393a535b9e0 
>> 100644
>> --- a/drivers/dma/xilinx/xdma.c
>> +++ b/drivers/dma/xilinx/xdma.c
>> @@ -38,7 +38,7 @@ static const struct regmap_config 
>> xdma_regmap_config = {
>>       .reg_bits = 32,
>>       .val_bits = 32,
>>       .reg_stride = 4,
>> -    .max_register = XDMA_REG_SPACE_LEN,
>> +    .max_register = XDMA_MAX_REG_OFFSET,
>>   };
>>     /**
>>
>> ---
>> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
>> change-id: 20250901-xdma-max-reg-1649c6459358
>>
>> Best regards,

