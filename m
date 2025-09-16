Return-Path: <dmaengine+bounces-6546-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA2DB5A0F2
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 21:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A155164E13
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E9F2D7398;
	Tue, 16 Sep 2025 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nhgwj2Ww"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D5632D5D4;
	Tue, 16 Sep 2025 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049656; cv=fail; b=Eb6JHmz6dizmsFA623CoYXtNW9akAIl+62XUs2jpHDcJ4h5rp8w0bwWqstCsi7XBHlNy1XYiwYYZAXVAdpv9KBQXEgw9cVGeKOOnOPm+jMseI5LmIDykKQpRVeQtBEgrFKot5fv7x4YIlcPhI7Ek/hdaSs2XJklUrzpssiQ93i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049656; c=relaxed/simple;
	bh=v4BJucQxp+lHLinVP4jLuuPWvLnLdcLHwLX1Xzv5lJk=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GkhfcHcS2RzEIno29D01q+7NG8uI7+ClhYwoosfzNzL4rZFNaPD9n8VPCj+2cIAjKVJLxBz6UjBAe9a70ErWIqoiHDeT3q2QfzsOffZvst5JztwBRK+7jFNhuzlQD3m4XXz1kIjQzO0nUOlI0Ju9gQ980FO3YMLu4o1Qagul5s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nhgwj2Ww; arc=fail smtp.client-ip=40.107.200.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqDNVPGyf14pn6FdG48zbmBbYh1RpgIyiBwccY3+pTz1+GC9lIIyvL3IVhC6MxFT3NlkiZnt8zoXilmrGl+cx2hY+DtMoJ27KofqIuIjdjjPi3wcND9Bpa25g30zdr6nytCNPb+1xo5if5+XQOj/kBrkStpNB3ZdFu7y6VNYTxDpDs6699oi3Q+HgtZkdYXl+jTBW4N+WwF8ocqbIVhRe+BFQdyMYxi7NTButL3qu0luCL/lGFzWt3z1jxjaOn/87gBZvmNBdMGSEr71Xo1QXdpJAtpw9roCl8ebcK7H3e1E4Dql1g7oAHk5YYrHjPvsltweHG3WGN92MMemtJQ9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3HAOR41UdkqhaTXrQuSIltx58M9zx0NRGc0jI+Pvo0=;
 b=Av0X/QsUd90ZedRH0c+f5oKXCSKO3+aCGzpINxnV66asSAfVVFUlpjh+V0bF4iAEmQaZ31XAP7EnWjUzPD5kEvbGryMGamulCSvrBe0I6j3/97/hDgBZBLP55QR747R8flW66g79cTNH3JYd/A/Dkl3+++7yXBfT5Zzf7hg/IMrLmF4HH6ZBvcwE5B2ajhADkXJVlx94OjuPrN9rbHOb8/utdlAQOrDvuaRhqhqtbAC1D0wvFntQOuscKaa0PGz5rfMHQfCpf5y0eYSYWlEUhtd2APw4dOKXW0i8ckmgiOxofpOXSN7NZm4sImeOrlqLmtJzfAH9gDBZtbKp3iOJng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3HAOR41UdkqhaTXrQuSIltx58M9zx0NRGc0jI+Pvo0=;
 b=Nhgwj2WwdmsxZlvyO2FLH+u8MaYEL7XY7mhgflKqDdvBDhVVQrML2/pwwSpahyAJIKe8N5oMwIBGHh/9ZaFAybtLI2hKESIZsdkCLuiVN1mTFeuxlrssQFgp5i0yvRjia0di7IfWqE5KIRc85Y6EvFpTsXBtb8qjhGosE7gFcuQ=
Received: from CH0PR04CA0094.namprd04.prod.outlook.com (2603:10b6:610:75::9)
 by CH1PR12MB9671.namprd12.prod.outlook.com (2603:10b6:610:2b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:07:31 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::b4) by CH0PR04CA0094.outlook.office365.com
 (2603:10b6:610:75::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 19:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:07:30 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:07:30 -0700
From: Nathan Lynch <nathan.lynch@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, "Nathan Lynch via B4
 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 05/13] dmaengine: sdxi: Add software data structures
In-Reply-To: <20250915125937.000072ab@huawei.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
 <20250905-sdxi-base-v1-5-d0341a1292ba@amd.com>
 <20250915125937.000072ab@huawei.com>
Date: Tue, 16 Sep 2025 14:07:24 -0500
Message-ID: <87cy7qxllf.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|CH1PR12MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c85530-a9ec-4069-39e2-08ddf5544921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vtcN07ms4GGDtb3n8OvIUkPdsBsffWU94gjhzvDrDHqqF0xeT6a7cCAqd0O0?=
 =?us-ascii?Q?k9oYe9/oNHi0qkgIJxr3WHvR/lj6iaS4fFHoq1NboGAqIz3byTS+g1quVyAW?=
 =?us-ascii?Q?QB9OZWZ9O0MwbPYBw/NYOGDf/TLqq2QRaMaVxOBOXxpiVc1Py5FT/eAzV/VA?=
 =?us-ascii?Q?NWg4SrvlMF8QXbk4ENelqcPEdkKsFEacd2AW0SID3281wkDkJV2tmluNT/Vw?=
 =?us-ascii?Q?VeB6wRFUvhfZf2/kuC7JYbUQCa7hlnWlNEq03UGuUfraIekvRSIvje5Z4kst?=
 =?us-ascii?Q?X+060sCrhcEtdx9Ptt+Hpz47pl87FY+fj2TRg/u1TutPUoUdhenXVo/FG1Vh?=
 =?us-ascii?Q?s9NAcGGkVUhx0XOTyFyyb927WVaIHqMN70Bd79dqYviG02o0jnIzkrhvwkxw?=
 =?us-ascii?Q?/lCkQiejeI7slUmeu1YdkD4breCEX4y9j0zeJgUJO9X7289GfGajxW4vDN2S?=
 =?us-ascii?Q?fdl26ETWBe0G0V4zVV1a5bls8mz29+Q2iJ0oZgWEjXGQcygheU+bFwG4ZKZE?=
 =?us-ascii?Q?MG7cauhH927vWVXQxXM0xWgsHQ+v2lzJXoNP7UZK7U2y6kV8+Mz0XGQ+aeDU?=
 =?us-ascii?Q?BPXvGkBPRQjNQlkE8ZsYKMLsIOkvpyKY/MEuxg4qvxf9SJBoa11Aw6nqvUDY?=
 =?us-ascii?Q?DJbrsZfZxWZYdkNb6DdAjWZH1k6RHchrTBBZqgA7UqwNGqfh+TdOVtvbrYGc?=
 =?us-ascii?Q?zKi9EO68ziM+MwJPufJyu3xpDdJTD05E8eyzdyVoWq1ExR3FQhQZQ22J6xjI?=
 =?us-ascii?Q?KYaM6eR+bLK5ziUwCdquAKbuVUjrEOnw2gjniyVHDKd2Uyh8bsOFTqZKvu+3?=
 =?us-ascii?Q?8b+JqDGiTAKdRfljYrTNo477RUPaaXA9EcVY+rtc+lBrECC8lwilo4VKianr?=
 =?us-ascii?Q?OpOrIsFnblVLVG5boi8SVmRXjVifuj1n8ItCvzR+FvA7VkT2v1xufns8eYLq?=
 =?us-ascii?Q?tngBiXAvyk8ySiwTtHY1E7RVFUFBdrVCDWGVeP5KG4krdT+uPgFzPyZivO3h?=
 =?us-ascii?Q?6vxpD08S+cV8YIkUVwY0u5QZYWhO5bbQQawsmheQ30XNaJzXloSEIZeYKNPk?=
 =?us-ascii?Q?/LTqhaEjdqRGt+BDEnn/HkFimyxeg0hERzKTqMSIC2UvurWhwtZtrNKXcUKN?=
 =?us-ascii?Q?1jJQGibeH9XADfMvmI49WnMFVIekQnmzNgIqCrapyVYotIgJMzZrfcCX8H7c?=
 =?us-ascii?Q?Wfiz3w5NCn8YtfLv6nbKN0svxbqAxgJcKE13JktNdHj4WRklnN8B8HlWJM03?=
 =?us-ascii?Q?Y4AvPtw/cBPlbNReFHkTXR56SZZqgn3Ihq94NaQzIRLAnL7LMtsQ/lqDW9Sr?=
 =?us-ascii?Q?O8JBoK5Y5web2A3wnOK7YGKG8pDSu0cJxXhnlhg8UvAUTcV2Et9FaUTDmUFZ?=
 =?us-ascii?Q?VQM7YeLcZXyBa9NX9gNgFO0654g5Km6rXeiSxyv3UMrLRXUS+g2OMX1ihQeK?=
 =?us-ascii?Q?vD41hQCmlA7SJiSULwS1/NtFZeMfCDmXYzup65e4UROEUItUSU8yMcezV047?=
 =?us-ascii?Q?f1Y/SEM7oSCsSr1a4lnWYDjYxyojPN4ctS7k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:07:30.8910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c85530-a9ec-4069-39e2-08ddf5544921
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9671

Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> On Fri, 05 Sep 2025 13:48:28 -0500
> Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:
>
>> From: Nathan Lynch <nathan.lynch@amd.com>
>> 
>> Add the driver's central header sdxi.h, which brings in the major
>> software abstractions used throughout the driver -- mainly the SDXI
>> device or function (sdxi_dev) and context (sdxi_cxt).
>> 
>> Co-developed-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
>
> I'm not personally a fan of 'header' patches.  It's find of reasonable if it's
> just stuff of the datasheet, but once we get function definitions, we should
> have the function implementations in the same patch.
>
>> ---
>>  drivers/dma/sdxi/sdxi.h | 206 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 206 insertions(+)
>> 
>> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..13e02f0541e0d60412c99b0b75bd37155a531e1d
>> --- /dev/null
>> +++ b/drivers/dma/sdxi/sdxi.h
>> @@ -0,0 +1,206 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * SDXI device driver header
>> + *
>> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#ifndef __SDXI_H
>> +#define __SDXI_H
>> +
>> +#include <linux/dev_printk.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/dmapool.h>
>
> Some of these could I think be removed in favor of one or two forwards
> definitions.  In general good to keep to minimal includes following principles of
> include what you use din each file.
>
>> +#include <linux/dmaengine.h>
>> +#include <linux/io-64-nonatomic-lo-hi.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/types.h>
>
>
>
>> +/* Device Control */
>
> Superficially these don't seem have anything to do with controlling
> the device. So this comment is confusing to me rather than helpful.
>
>> +int sdxi_device_init(struct sdxi_dev *sdxi, const struct sdxi_dev_ops *ops);
>> +void sdxi_device_exit(struct sdxi_dev *sdxi);
>
> Bring these in with the code, not in an earlier patch.
> Ideally set things up so the code is build able after each patch.

Agreed on all points here and I'll modify the series accordingly,
thanks.

