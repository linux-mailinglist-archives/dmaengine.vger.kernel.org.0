Return-Path: <dmaengine+bounces-3065-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2013C96A4D8
	for <lists+dmaengine@lfdr.de>; Tue,  3 Sep 2024 18:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57FF0B226D2
	for <lists+dmaengine@lfdr.de>; Tue,  3 Sep 2024 16:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA518BB9F;
	Tue,  3 Sep 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lbxoMXnX"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425771E492;
	Tue,  3 Sep 2024 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382254; cv=fail; b=inst8xosDedUoatfAMzZD9Tsd+ZGvlZTuSFg02rnRtH/XU6AOglfiI/nNYp65pBQlVZ9SJRyrxEOqpMXAyTyMf0ZAmdFczK9TtetZkEhnWfxOhY1zmc8tDUIEM7Rmg55R/0sN7WuZpSzsOYzsB44Zx/X9MRw9upKjIISbBHatUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382254; c=relaxed/simple;
	bh=pyXaxYEnb6Mvtr/2Pewi7wRZdqT8XSnzTkOHAbjgAVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q/DTKeGuP75YYe9VZMGTywUod2qO+z79Ub7cao/8VeW/NX5GdAEB1UYHHo6mdXWwpWoQm1rtPoOeFbGMT/AwRjF+jl9f/Hcq6nXRRRwuvK3syfpd3QNi2+3DNBDiDsQSfFA+PGGaU3lA4eDCaBEeMa+czMUo1RCip0wZyzJ/do4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lbxoMXnX; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JomBznkzHhJzTpYSRA6+iMULFxri0b82al8bnNfc2LEzdYhRTT4DlH2kROI7Cki4OTak6Lr1/3T6YxfYQtqzfkLDLluziO+mD9mz12eKpHPBoAQe5hErHBb+LNo8Yj9A2F3nE6AmE/N/x3P+hT+fvL06IZ9ICfBvbQsoLD0kZx1tRt7qaR5e+FyvLL1ALcrqsWPBH7KD4JyKA7CVioxw+goQ3Ly8lSLpEesv24d24iadSQ4qn7zWjKLjitd3QZ5gI80NG7itQ2I3CSuS6Pu1vI8YXulOWNBdnM5c9Se41bcBEWiCQa+Qsy7A3qBeL8iOVuZ9f02Ylgkk4iVFNnBurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oCVWmlIfAFwM5jWPIUjnQgieYPHzW4oXwxuJ8UMlNo=;
 b=wJ6xhAdf4jRAuYROchpJSBF1UhGQPANBJmdMLVAOHUrUwAqhzE6sjVipUxl4sm9TO6c1WGvZwu6PoYzhFZSNMVHMsHDBdOG2vosOM55avNpbVoKxSAm8dg1PkWQi3K2mCgL7r3oRx+lmnfGfnvE6cnwfD9znuIF5q+JU/3yXU3A9m6kSgCJ74rnx/59/zvvSiO7OXbfMcONU9X0BwpsTlaxue64/GrHLCwoboZINcsNcOAt9WKbPmgAUo4VgDbySTMV+in67Ga8tWAqu18lfLXTVx0Y9kCc/0lBtTnFlHDwqajADa1uhyxsJWFwXDE7ftS0GV7poZlwv+Byh+AsY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oCVWmlIfAFwM5jWPIUjnQgieYPHzW4oXwxuJ8UMlNo=;
 b=lbxoMXnXny8+Ol6MFYlK3ARd3XRGbieYZVBpllI8DSXpDKOO/Oe9osB0h9gWZJEbZOVVMXtwvioAOG83V+gDnZ4GpfnwZD0KOnEnDrKVrNkMsEG6zidOWlMbSrDE+yx7wPdcmfLgJ7TG2ce8X7+10/v55WwcC8t4QInIVkEQXXA=
Received: from DS7PR03CA0221.namprd03.prod.outlook.com (2603:10b6:5:3ba::16)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 16:50:49 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::a5) by DS7PR03CA0221.outlook.office365.com
 (2603:10b6:5:3ba::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Tue, 3 Sep 2024 16:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 16:50:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 11:50:47 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 11:50:47 -0500
Message-ID: <e2a37bb6-3353-1c2f-3841-d63748756df1@amd.com>
Date: Tue, 3 Sep 2024 09:50:46 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V12 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>, <nishad.saraf@amd.com>
CC: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Nishad Saraf <nishads@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
References: <1713462643-11781-1-git-send-email-lizhi.hou@amd.com>
 <1713462643-11781-2-git-send-email-lizhi.hou@amd.com>
 <CAMuHMdXVoTx8K+Vppt07s06OE6R=4BxoBbgtp1WWkCi8DwqgSA@mail.gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAMuHMdXVoTx8K+Vppt07s06OE6R=4BxoBbgtp1WWkCi8DwqgSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1938fe-1b19-45d5-1069-08dccc38902c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFdBaXR2OTk0R2FXbUxIeXRDUlZ4RmZsUHZzVk9sQ0xHUGVYbmUvdHRXd1dx?=
 =?utf-8?B?T3dQalIxeDRpaXNiVS92TW5Jbnp6QnhCYlR3R3V0dEhEbG1VRnk5WEdMcDR6?=
 =?utf-8?B?ZXBidGgrVGJwOFNKNnVsaW9LVDQwZzFTMzNyYWlvcGhKTUc4UlpRQkRDdGF6?=
 =?utf-8?B?Mnp6YzRhZ1dXdnVJR1o2eTl0QXVTSnhjWlp3OXpuUFp5RkRsK2grcWNCYjZN?=
 =?utf-8?B?R1NQK3hpRFQ5V0o2WlZLendlKzFUN2srYXA2dndnTlBLdTl5Vm5PcmZNZWxN?=
 =?utf-8?B?NG5DUVY2T1V2VkRUTEx5Q2grY0o4THNHQUhYanUwbXBNRTZwMGhvb252NmQw?=
 =?utf-8?B?SFgxZllYOHRLVkpSN0QyTkNYUWNDcHRVSXU2bFNkdWdJdy83R2FKQ1o1aEhT?=
 =?utf-8?B?aml2ZmEzSm0xSFE2UyttUGFUU2JvVkJ0MHJ2bXNzM2dEQkU1ZWppNzhXVkJU?=
 =?utf-8?B?ZW4zMDM5TnZlbjF2Tlp2SE5pcWIzWmNwa05SWGFKRFRMaUdpdXVNcXU4S2Zh?=
 =?utf-8?B?dG5UQ2FRMlA1UTRIZU5mRmdLNFQ1QWlQc3U5RXl0NVFWVVJNdXNOazRSSFpw?=
 =?utf-8?B?dVFWdm10Q2g2RW1IWVkwOFhiQlVsQndjRGo5WU1VWCtoNURWRWZLckVFYWIr?=
 =?utf-8?B?b2MxRDlaUGNLRkt1dkVhM3plRWV1ODdDSWMxMmsvNG13RXA1YklzSmNnc2k2?=
 =?utf-8?B?dUVvclEraG5QbkVValFsSGFLb0U4bkhFRnRoNitVazl1UjdUeHptN3QwQm5a?=
 =?utf-8?B?WDlvYmo0bDNGMDI4d3V5djZ3N2hKbzlXazhWTTRKU2d0TFVLKy91SDVUME5V?=
 =?utf-8?B?SVBjNEFrSUVUS1FYbGxYK1pzSktyS3dxQ0QwUWUrVmd3V0lvTG91WXM3U3p1?=
 =?utf-8?B?ZVpKMzdqOUpJZnFsQmkyT1BURDkvQmdEMVB3WDM0azBjZEI1ZUJmVVdnaGFE?=
 =?utf-8?B?U0dkK1BTZEYvNzRHb2ZjbjMybjZabUdZK3pwRFY0L0s1UUdkM0dDcXhzYm9K?=
 =?utf-8?B?Z2h4OEtXdWRyUFU5MVFCVUliVTRQU2FyN1djQ2FQdks4ZWVjcVo4Q3NKYXk2?=
 =?utf-8?B?ZnEyR1FMdEVvNHROZUJkcDhQOHZrUW9GSkgvVHA3UjNjaUt0aURkb3ZCSUMv?=
 =?utf-8?B?VkRnYWFMdkxrL2ZuUGFJU1lGREJPbmtiREdFOUJCVDA0Vms5NGZPWGlsOGlr?=
 =?utf-8?B?WWZicVBoU0kxbWUvNGUveFVOeXpEVWdIYnY5SEU3ZStTZGR1MGNFUEhKZXho?=
 =?utf-8?B?NDdsUHlOS04vcmoyakZVTU54cHhOQk1ybEdzZldzWlp2dUVZd1hrM2EyTjV4?=
 =?utf-8?B?RlFwTVdwMFJGSUVuVnE4UW1VSlZ2UzNVZkNlZnZwZTN4UVhHQ2dhTEJPZm5M?=
 =?utf-8?B?WVBpM3lrSmVjY3p5QU9jRDJ6YmJmMm0rZjlkd1dJNERpTzRJNHNuVEQ5NEEz?=
 =?utf-8?B?TEZQclNoZkxJQjNoQWxpSUF3RnRCWkpQUDBWS3lxMmNkQmsrTFFsVXJaclM2?=
 =?utf-8?B?RW5nZHpSeTR4VnlVeTdsWmxjSkZick1WcFNEQXUramxSVE82cUlEYmxkU3Rk?=
 =?utf-8?B?MG9sYmJCbXFwQmxaRzk2V2FYZzhJemdSd0ZtTGZKMTQxRkxvVVVZODZ1YXFm?=
 =?utf-8?B?UUw3ZHo2RHBsV0xTU3E3RndqZnlWcUFjZW1BZTFoalJkNDJtK1FlTEtNaWhy?=
 =?utf-8?B?TEVBUncyVHpXOEFIc2RFdVNWKzdST200OGFCcTZaNmpBb1BYYUNKTk8rWVdQ?=
 =?utf-8?B?TkFoU1U0ZUtXbzdxRGN4a1dJYWk4emsrWmpmUnZXUlFIb014dyt4V0pCenNl?=
 =?utf-8?B?cXJPT1Fnc3RuUlIxd1gyUDNsdnNhbGRVSDNDM0hIc2IzTDF4OEYzU2NxZXBa?=
 =?utf-8?B?WU5MSnUyZ1dIK1NPdFk5NHNzL0wvbTNlWmo5ekJsUzdVMEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 16:50:48.7715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1938fe-1b19-45d5-1069-08dccc38902c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871


On 9/3/24 02:20, Geert Uytterhoeven wrote:
> Hi Lizhi, Nishad,
>
> On Thu, Apr 18, 2024 at 7:51 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>> From: Nishad Saraf <nishads@amd.com>
>>
>> Adds driver to enable PCIe board which uses AMD QDMA (the Queue-based
>> Direct Memory Access) subsystem. For example, Xilinx Alveo V70 AI
>> Accelerator devices.
>>      https://www.xilinx.com/applications/data-center/v70.html
>>
>> The QDMA subsystem is used in conjunction with the PCI Express IP block
>> to provide high performance data transfer between host memory and the
>> card's DMA subsystem.
>>
>>              +-------+       +-------+       +-----------+
>>     PCIe     |       |       |       |       |           |
>>     Tx/Rx    |       |       |       |  AXI  |           |
>>   <=======>  | PCIE  | <===> | QDMA  | <====>| User Logic|
>>              |       |       |       |       |           |
>>              +-------+       +-------+       +-----------+
>>
>> The primary mechanism to transfer data using the QDMA is for the QDMA
>> engine to operate on instructions (descriptors) provided by the host
>> operating system. Using the descriptors, the QDMA can move data in both
>> the Host to Card (H2C) direction, or the Card to Host (C2H) direction.
>> The QDMA provides a per-queue basis option whether DMA traffic goes
>> to an AXI4 memory map (MM) interface or to an AXI4-Stream interface.
>>
>> The hardware detail is provided by
>>      https://docs.xilinx.com/r/en-US/pg302-qdma
>>
>> Implements dmaengine APIs to support MM DMA transfers.
>> - probe the available DMA channels
>> - use dma_slave_map for channel lookup
>> - use virtual channel to manage dmaengine tx descriptors
>> - implement device_prep_slave_sg callback to handle host scatter gather
>>    list
>>
>> Signed-off-by: Nishad Saraf <nishads@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Thanks for your patch, which is now commit 73d5fc92a11cacb7
> ("dmaengine: amd: qdma: Add AMD QDMA driver") in dmaengine/next.
>
>> --- /dev/null
>> +++ b/drivers/dma/amd/Kconfig
>> @@ -0,0 +1,14 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config AMD_QDMA
>> +       tristate "AMD Queue-based DMA"
>> +       depends on HAS_IOMEM
> Any other subsystem or platform dependencies, to prevent asking the
> user about this driver when configuring a kernel for a system which
> cannot possibly have this hardware?
> E.g. depends on PCI, or can this be used with other transports than PCIe?

No, this driver does not have other dependencies. It can be used with 
other transports.

It is similar with dmaengine/xilinx/xdma


Thanks,

Lizhi

>
>> --- /dev/null
>> +++ b/drivers/dma/amd/qdma/qdma-comm-regs.c
>> +static struct platform_driver amd_qdma_driver = {
>> +       .driver         = {
>> +               .name = "amd-qdma",
> Which code is responsible for creating "amd-qdma" platform devices?
>
>> +       },
>> +       .probe          = amd_qdma_probe,
>> +       .remove_new     = amd_qdma_remove,
>> +};
>> +
>> +module_platform_driver(amd_qdma_driver);
> Gr{oetje,eeting}s,
>
>                          Geert
>

