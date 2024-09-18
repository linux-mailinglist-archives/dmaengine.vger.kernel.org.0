Return-Path: <dmaengine+bounces-3185-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFC297BFC4
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 19:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23581C211CE
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426231C9861;
	Wed, 18 Sep 2024 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gVSJXc0J"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D81ACE0F;
	Wed, 18 Sep 2024 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726681030; cv=fail; b=i41Eonke28I8AYR9AYocNnmhvLRn/5rmZeHNoRxM11dea/4liLljtVbSnvku70/mvgXB8tH6oPsjcQSyTdONiE06n+Xt284biF0w64/VMwU+dJEjk8oeFBp10RvPJLeyfzFftpIL5krkxhRWxFM4ODt3ZHCcViIdTPfwluU6fcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726681030; c=relaxed/simple;
	bh=KEYG/bLykfkabG2xZSpEp99C9V0DdV3akR5cWfQEfj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O7i5I5en1Rci7bqb8pOm8d5JnG9JaaFGPmOdJZY3A5aUjQqv5y+pak/2aEz7nkPl8FN4NGOQz/NABybvC8Kh4vZAsn3d3tnE5y+TIeqzToq6UGhrA0+5TW9Hovn5R9Ks7tLXtiQ0PFVAoZyzecyNoEY4s6rPK7sLoJNHVpJFMTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gVSJXc0J; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpE39/xyDsTUpXWQQI8JQUaYj/sL+h5NcXyn3BBvmOHSeU7u1ke4pXgccm3X9CtDUACDj0/T5eMgvkkFtPxBjqBn8GWaP2IOyYTTi7tWaTUfYTklqe/RIOFyqA5F3Mu6G2Fr59i0k5IzEPA6tXyc+/gbvRhE45r+EZd9SVBs7WyST3TrFCe5xbrE10lP/q6a43edrWFiBMEyk5ida0Pz8OwuHgg9vRxKSoIuwkPUYV3BVm0miSwAty1Phzy4hNfDflq/OaiOkgElex1zZdzQ8PlUy6q3Kg7AbOhJMY82zuzwdqwkP7U/phjXOahKw9q1XTlYVPvc8mM5pJYpmA1DUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEYG/bLykfkabG2xZSpEp99C9V0DdV3akR5cWfQEfj0=;
 b=supUdsBpdF6IC/VeuNY9Y/ZgiS+qzXP6Z8KhZ3kodGL2um68+YWi0urLAf+bszr/+18vppRJiO9ltQ7tNEDKdfiQOTg5JtL82B32OKN66zWrLuqhuVncqfv7IFXNQGH2/CQzlV0DCQoRWoN6FN3YmRK3dQizEct/9LM+1TwwSoxbOChbkn36TfqqkpUG7DGFKalnFRLwuIIWRIO6gEf1KB12POT/S/UC0wcm6LkvVQ4UWF20UpURVNhYDadd5yBJoErHLscOjV/pzxz2R0+zxWnsUMuf3y09Ru0QP8k69PVQEAF/9807ZbbhRZHswbOmG7aKMCEi/XbQ88AKCJkqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lst.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEYG/bLykfkabG2xZSpEp99C9V0DdV3akR5cWfQEfj0=;
 b=gVSJXc0JVF6Y4ftNztWW3T20DT+ix8gmjihJgNGsioCv2mo+pKVf/ZUyaRMukVEksKCrrdJmndR3oM8TnXaV1K/VgEO5cZNOSfyjwImo4m8a8qE2CZtDEIc17Cw1scNvm2WJ15e8OU8+8WwPh7XtJ16awye3kXt1ZTpiQqg2MPA=
Received: from CH2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:52::34)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.16; Wed, 18 Sep 2024 17:37:04 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::89) by CH2PR04CA0024.outlook.office365.com
 (2603:10b6:610:52::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 17:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 17:37:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 12:37:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 12:37:01 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Sep 2024 12:37:01 -0500
Message-ID: <c35e1e99-ea3b-4625-eef3-cb0a415d1c18@amd.com>
Date: Wed, 18 Sep 2024 10:37:01 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] dmaengine: amd: qdma: Remove using the private get
 and set dma_ops APIs
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: <vkol@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nishads@amd.com>
References: <20240917161740.2111871-1-lizhi.hou@amd.com>
 <20240918121302.GB21062@lst.de>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20240918121302.GB21062@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c1eafc-b62b-48ec-29c9-08dcd8088216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVU3VVFpYXovUUoxU3gxWDg5MUROYzN3bHhNZ0hxR0dzaGNqVVMvZDlaTy9C?=
 =?utf-8?B?VkEra3I2Y2l6dkw5bDJsbTY4Rk5wenlaYVdHVS9Udlg1ZWllTXk1MVNxL1do?=
 =?utf-8?B?aFF5d1ZNbm8zZEIrWFpmS3BvZXArbEUwWjFGbkZZa2wvM1JzaFNvVmN6M21a?=
 =?utf-8?B?MTdZQ1lHWk1KcWVrR1pjdjNuMHlKNmNkRFN2dzdYNjRRV2MxczRDWUxMZEZn?=
 =?utf-8?B?TEZQd05qZnRvcEVoK3JnMVJuRmxTWXdsSXFkam51bHBkMmFNeVFNdTRJQ2s2?=
 =?utf-8?B?bldpTXdUaGVWL3RSNzRiMVhybXNBbDBVQWlITFlGRm56Z2s1NjV0bUlFOGhy?=
 =?utf-8?B?UjJCZW1PZTdxSkoxYjJHaGNvU0h3OTE1Zk1JWjFhZE1rR1VFSXEyWnRBajBo?=
 =?utf-8?B?SFlaODVldC9iL3VHcGtidzFwcXBRRWVaUUNGKytKM00vWitWTklaT09pUXhZ?=
 =?utf-8?B?YW5KQUE5dmFWSzVMMUlxSU95Y2cycTYzejV6QVlPRW4zblFqOHRRVlpPN3pM?=
 =?utf-8?B?dVR5QUxNSDYxVjJzMDFSYU5xYWxwVFRCSDU2dnN4RGdRMGgxYjBmZExDcVA1?=
 =?utf-8?B?Zk9PajBVUGNSTEtPa1FReHlpK0tvemJYMDNrdGc1ZUtsa1NkTllHdWlLS3pa?=
 =?utf-8?B?bkd3ZmoyQjB6eE0rWkpEYUZGcHlvd3c2c202a2l5b0RQV1BnaVA2RDZKNTBC?=
 =?utf-8?B?VmxMR3B4UDgvQXQvWFU3d0M4dnY5VlF1REEwRTVhaTlnR0RrNEZvTWtKNHVC?=
 =?utf-8?B?U09BKy9KbzhheFFjZVd6SVFNMUpZWW5nUUZFeFlOV1JkV1ZWYVA5TlMvVVFr?=
 =?utf-8?B?dGhJVjdCVnZneXVsQlRvWDJHekh1bStuTE1icUlaenJQNVpQTEFwTUNncFdm?=
 =?utf-8?B?dHNKZHl3R3Qwb0FIeU9YSmZsclNrMEQ4d1V3T1Y3VTJPNXhhaTkxbjNlc2RE?=
 =?utf-8?B?UFZLUldKa3R2NlNIaUNUbVJHUk4vdmRITlVKMWY2cStHZTJERlMyRXZvNXgy?=
 =?utf-8?B?ODBmSE1CRHVFVGYrd1RoRzNOU3k0RzQzQVh3d3lqNk9kbjZlSzVhTUlVcjFY?=
 =?utf-8?B?VU1HZWFQRCtHSmdXRXhVRWw3bjYvVDk5Z0xzTjZYaHY4MkN3ZzFNcXc4SWp2?=
 =?utf-8?B?K1N1a3ZJeTVxdDFVYXdUcWlQTTUyYUxYcFloOTFqZjNucit3WE9iQ2xLbkg5?=
 =?utf-8?B?aTRydTROclBJanBsOTBpRVljdVprb09EL1FJNGV3ckI5TE0xTEZoa3phaWhT?=
 =?utf-8?B?M1NhNTJoNFgwSlVBK2VPRzY0eG1rbG8rd09wKzhCVGdFOEE3M05jbEZ1UUtO?=
 =?utf-8?B?eVdkOW9UcGhzVW1YWDVnTnd2UDViT0VSbVhFTWdyNjFwMFQ1cmpxM0NBOE9L?=
 =?utf-8?B?Zzl5SjdlSU11SURHZHpGbG85bGVUQUtiSERVSytrRlBhV3kxMiswcDVUWDBC?=
 =?utf-8?B?bytERHlGVS9aSDdTMUNNQVQxajNnUFYxdWRMTjY3S0NOQ3c0OEJxTGVaV0xP?=
 =?utf-8?B?NytaZ0Fhc3hYd2R6UUNHVjRXWG1wTXpDMXNOUGZwZHQ5NDlaamJzaGFZWE5u?=
 =?utf-8?B?VWJpNGp5MjErSWd5T2F1RWJaZVRqcTROTyt2cGM2elQ2VExySzNrY3FPT1Jh?=
 =?utf-8?B?eHN1YkFKcEtaajkxZU1GMERZb1I0L0ZiejRnTG9JZ2NSRElxUU1FMzJ0aitF?=
 =?utf-8?B?eTFUNjlXbWhJdzR4bzhrcURrTjdEd0xCZW81L1dUcFlzVVpRemZjNG5ESlVv?=
 =?utf-8?B?QlcyYVdDdHpYdURqT2ZJVy9OM0lDcmJuRkozcmxqZFZDdmRGdk9OUjUzRWo5?=
 =?utf-8?Q?x+DfKJUmLePoCX/64Z6FtLgA2xMk/WLCmGYc8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 17:37:03.2658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c1eafc-b62b-48ec-29c9-08dcd8088216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592


On 9/18/24 05:13, Christoph Hellwig wrote:
> On Tue, Sep 17, 2024 at 09:17:40AM -0700, Lizhi Hou wrote:
>> The get_dma_ops and set_dma_ops APIs were never for driver to use. Remove
>> these calls from QDMA driver. Instead, pass the DMA device pointer from the
>> qdma_platdata structure.
> Btw, this file should also drop the include of <linux/dma-map-ops.h>,
> which is clearly marked as not for driver use.
>
>
Thanks. I will remove this header and re-spin a new patch.

