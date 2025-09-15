Return-Path: <dmaengine+bounces-6524-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7273EB58620
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 22:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02F9189020D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 20:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8729D26E;
	Mon, 15 Sep 2025 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HTN22vo3"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E01DE4EF;
	Mon, 15 Sep 2025 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757968967; cv=fail; b=tbwO9KuBRSZVqRMLEvvY9vK6oPKKd2BBZg+Jddv4kO7ZCwhtEX/JIjhSJAC73VlcLSDOCQL8vgLqNq4wdPLKuOg4j4FWFAZa5eg99lcA7R54C++KUALHO6wn4gFRp3PNUBxva+E9Muo5XKxPJwRwMF06/RMmUeri0A6G/N7eeAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757968967; c=relaxed/simple;
	bh=dkqdG6fcNBf9P0v3HVoVk/9DECvMfXKjdEB/wbGQiVg=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BBG6oafAsM2IBAQswJXGEo5KaPO2S430Kh6OT6G1rquhTkaNMxlzjTNqmZxtWqm8YlOMiQOGGPLnUw8pvg4xAgfAY0SitHYnkT3sr6Xg28gvBtMBMKZOVsnoxJoCwaY4edCudZ6kw4G3qW8kA2aupRRzth5ASWWtTWGKOUuVyKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HTN22vo3; arc=fail smtp.client-ip=52.101.43.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPZA+pMEKjRapkBHsWunHnY6RkHzDTFTaqC4AL/gAyB7t9JbeDENOkmXTeVUd/sVENuOn5+7GOoHreXIZFHHZl8ZtFS3DiY10vbsKRHKggHXqLizunVGqLXxw6p3vRI0g+E+m2D2QSSah1O4QgdoRt5oxOjwYSHwzU+euJu/tUh8RzOR8XsoEQLnwQgzSeUkXRKetiABqClQISqogFROWJPewjrujdPGVWrXgWdPeWqyyYE/XJ+lkArrDFHkkYMAtNNWBkC8DKU1v5XPPaTS5Fd6Wm92/xbOUMJ+t+TFHE3yn6AxGkDvI3LSmZWIzEzxmTWLCg80IUrGeT1zdxHASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qXR0Pbpv0bsVlgsuZtuXJB3Trz858u7m+6lTFQ+hQg=;
 b=JC6WrGDNOq3Fl93gqpeNL3u/0/rCQ2gvhaV7j/iw0L9biiYqOCC6JrjZtSUjXkdETG/R8eadKX8sYGc65NgsEj5BmRdup3moEvoTeJSms817sSvrh5BvH8cEoPxDADQUaf9rUINwe2YhVSKoQ7BFACpEIzBXdbgAf24uyTEqyod8zaJfTj4lHX6hq85VmXDkVZgaqfeb6XJxprdsarQcbIGzHDpGY0S2fnBFU6OnoIhJglDzsm2lExOrmRWpWVpToOCWkdg2txKaTRveWuegEGs/hF+f5tj7OB2o92/4yhnfwakmZPf3qJbs4pmi8XCEmddLnSK7k5KV05SUtLwJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qXR0Pbpv0bsVlgsuZtuXJB3Trz858u7m+6lTFQ+hQg=;
 b=HTN22vo30lEOEJN3pq4nfeVXPaU+Im+3WaUifSwJcU+wV+CS3fwFuC+F8etUt48aRsgg6z821a+diekMRBdAj+Q5qPW7oDH872YMA3r9n6mLEjTDLt40pERTmJvkKamvSw6Yr29WkLOOFZKbVmfNzDe1BHY89jJla0keE31ocoY=
Received: from SA0PR13CA0021.namprd13.prod.outlook.com (2603:10b6:806:130::26)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 20:42:42 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::a7) by SA0PR13CA0021.outlook.office365.com
 (2603:10b6:806:130::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 20:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 20:42:39 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 13:42:38 -0700
From: Nathan Lynch <nathan.lynch@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, "Nathan Lynch via B4
 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 06/13] dmaengine: sdxi: Add error reporting support
In-Reply-To: <20250915131151.00005f26@huawei.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
 <20250905-sdxi-base-v1-6-d0341a1292ba@amd.com>
 <20250915131151.00005f26@huawei.com>
Date: Mon, 15 Sep 2025 15:42:37 -0500
Message-ID: <87frcna1mq.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: a11c6cf2-2ddb-4de9-0cdb-08ddf498695c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R6twgZip4kEt1Rf8OMh8STK/lUKLrk5qsjj/bR2oP4r+EgU/r08WhTHrbr2a?=
 =?us-ascii?Q?NcIFfdi1+Q7k2qQxcl35vddaKsqLax5EMMxpHxP1V3YvyAV8a4EZGzgBrCMl?=
 =?us-ascii?Q?8yPKwN+CW8ZraDCJ+OSoZm8xDzI6ExAalEBXCKYlSsZZ6X3bxItDRsQ0kz5J?=
 =?us-ascii?Q?XYaBShJEONAMX8zWzzGQS0scmRbctMZ1saS84Hhe8SWEfOmxgh9a7SvswPLb?=
 =?us-ascii?Q?2vi3cnrwHDudDbUwNBMsBgqcfuTjKJArdkUYvVLTPneNae1+aDD5+qUXWjb0?=
 =?us-ascii?Q?wZ38MX/fi5EQb0xcc24zAp9LIoEfyEhW5EhtUgRbBjVzimrcT8rfjR4pSo/q?=
 =?us-ascii?Q?iuvi0XV+rlWgoC1vSjM4G7AC8Ri3SMEMb52ZIYNtmwyif/Ca42LJYMLULbyK?=
 =?us-ascii?Q?0MY8QxQC4QtepXLKLb9IUqcpbsvkenWczG99g+aqAE42+7ul/261FChHp9gn?=
 =?us-ascii?Q?S5TU7SB9AZKu0DSKp1lq272qzXvN57tlDjbo5b2V5rNHlfh2rQZ7IAafcoPp?=
 =?us-ascii?Q?Klfea1YuMzGSGB8sr+THQJMRHyeIvaTT8Y+9ixD2jIEMVeWRE+BYsMRV0aNB?=
 =?us-ascii?Q?1tDxxBiw7JXojpRmV4mcibckZBvhmf59yh+feh7cZa/3V5SyjBitSqJrY3jF?=
 =?us-ascii?Q?FrlgwoKzQKCHIUnGfqUsIQl7+pho5jYODNq9fk0gjcQ/j+tiKJWax2DDzZu2?=
 =?us-ascii?Q?4ha3uhlZXDZ4EUHeX/ur7UqetdbcK1VKJc7JqA8oNlyGLvRNGyIGjUmL2J8N?=
 =?us-ascii?Q?7aPJoOmwWFg1MzkrhPdf4gQhT7xY+d/W4ZohpIPaJXn+/C9fX2sF2J6bNYqk?=
 =?us-ascii?Q?gVkYKQqq9P8zgcEfpOTDY1i/udC3Y3ROFeEYJqbMD3A3YCsencApemTCZmz/?=
 =?us-ascii?Q?60KYQ1xGBLN0HQA9i6VwJbsNgomxN73yZduO/n7Aqau7q82A5dfAs8FV5mAK?=
 =?us-ascii?Q?IGPYe7L2HRKTVBGp8OnszTzplHGSfHhrOvLbi56mh/b1RE1XeEu72cAHtikW?=
 =?us-ascii?Q?SQfV/OYuboBMiEo+qyYY1FYMHQA7jjVEf1EX6Z3iiGnY5lpw73hz4mJFBFb0?=
 =?us-ascii?Q?e3nyHb6su4eKeEIIVoIgyuLzcFVMbs11lcLAR17oRvGrtMhD9p8RXABGfs+1?=
 =?us-ascii?Q?N2WA0eLYZmUk6NlERF0wA+Wac7lcSOEp2xjyoO2ldcPzUXwkJi1+cez9aqfr?=
 =?us-ascii?Q?0N+vMMlMvmFE6pCpZ8M2Tmr4vYCefM5h83QzI/0hJmBzs0qjKHWkR+3htUvi?=
 =?us-ascii?Q?dQ+09ItwZMvxFVfB81P5POqs+t4MgG5tZ5t0NngA84s7NEVcUtY6+pWwDuQ+?=
 =?us-ascii?Q?5f2WB0SNYhqwknqShfnoJ4wZHR91Alcmdm96PhemP1sMLoY92T05mDRyj49K?=
 =?us-ascii?Q?jB33Qpm0ozTDbRzsG8yCsuDOrT77RGwvG2mJg+RuKAhM34OMDklt+agypple?=
 =?us-ascii?Q?BD6dWkM6EMh1pCyIqHKgwe7Vy5cYPb6r9v28slkkunLWj1DEDE0yERteV8TP?=
 =?us-ascii?Q?tLMKdbuezwS6r+LxRhP9EVlUsKZkigBjHEYz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 20:42:39.5616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a11c6cf2-2ddb-4de9-0cdb-08ddf498695c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Fri, 05 Sep 2025 13:48:29 -0500
> Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:
>
>> From: Nathan Lynch <nathan.lynch@amd.com>
>> 
>> SDXI implementations provide software with detailed information about
>> error conditions using a per-device ring buffer in system memory. When
>> an error condition is signaled via interrupt, the driver retrieves any
>> pending error log entries and reports them to the kernel log.
>> 
>> Co-developed-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> Hi,
> A few more comments inline. Kind of similar stuff around
> having both register definitions for unpacking and the structure
> definitions in patch 2.
>
> Thanks,
>
> Jonathan
>> ---
>>  drivers/dma/sdxi/error.c | 340 +++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/dma/sdxi/error.h |  16 +++
>>  2 files changed, 356 insertions(+)
>> 
>> diff --git a/drivers/dma/sdxi/error.c b/drivers/dma/sdxi/error.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..c5e33f5989250352f6b081a3049b3b1f972c85a6
>> --- /dev/null
>> +++ b/drivers/dma/sdxi/error.c
>
>> +/* The "unpacked" counterpart to ERRLOG_HD_ENT. */
>> +struct errlog_entry {
>> +	u64 dsc_index;
>> +	u16 cxt_num;
>> +	u16 err_class;
>> +	u16 type;
>> +	u8 step;
>> +	u8 buf;
>> +	u8 sub_step;
>> +	u8 re;
>> +	bool vl;
>> +	bool cv;
>> +	bool div;
>> +	bool bv;
>> +};
>> +
>> +#define ERRLOG_ENTRY_FIELD(hi_, lo_, name_)				\
>> +	PACKED_FIELD(hi_, lo_, struct errlog_entry, name_)
>> +#define ERRLOG_ENTRY_FLAG(nr_, name_) \
>> +	ERRLOG_ENTRY_FIELD(nr_, nr_, name_)
>> +
>> +/* Refer to "Error Log Header Entry (ERRLOG_HD_ENT)" */
>> +static const struct packed_field_u16 errlog_hd_ent_fields[] = {
>> +	ERRLOG_ENTRY_FLAG(0, vl),
>> +	ERRLOG_ENTRY_FIELD(13, 8, step),
>> +	ERRLOG_ENTRY_FIELD(26, 16, type),
>> +	ERRLOG_ENTRY_FLAG(32, cv),
>> +	ERRLOG_ENTRY_FLAG(33, div),
>> +	ERRLOG_ENTRY_FLAG(34, bv),
>> +	ERRLOG_ENTRY_FIELD(38, 36, buf),
>> +	ERRLOG_ENTRY_FIELD(43, 40, sub_step),
>> +	ERRLOG_ENTRY_FIELD(46, 44, re),
>> +	ERRLOG_ENTRY_FIELD(63, 48, cxt_num),
>> +	ERRLOG_ENTRY_FIELD(127, 64, dsc_index),
>> +	ERRLOG_ENTRY_FIELD(367, 352, err_class),
>
> The association between the fields here and struct sdxi_err_log_hd_ent
> to me should be via some defines in patch 2 for the various fields
> embedded in misc0 etc.
>
>> +};
>
>> +static void sdxi_print_err(struct sdxi_dev *sdxi, u64 err_rd)
>> +{
>> +	struct errlog_entry ent;
>> +	size_t index;
>> +
>> +	index = err_rd % ERROR_LOG_ENTRIES;
>> +
>> +	unpack_fields(&sdxi->err_log[index], sizeof(sdxi->err_log[0]),
>> +		      &ent, errlog_hd_ent_fields, SDXI_PACKING_QUIRKS);
>> +
>> +	if (!ent.vl) {
>> +		dev_err_ratelimited(sdxi_to_dev(sdxi),
>> +				    "Ignoring error log entry with vl=0\n");
>> +		return;
>> +	}
>> +
>> +	if (ent.type != OP_TYPE_ERRLOG) {
>> +		dev_err_ratelimited(sdxi_to_dev(sdxi),
>> +				    "Ignoring error log entry with type=%#x\n",
>> +				    ent.type);
>> +		return;
>> +	}
>> +
>> +	sdxi_err(sdxi, "error log entry[%zu], MMIO_ERR_RD=%#llx:\n",
>> +		 index, err_rd);
>> +	sdxi_err(sdxi, "  re: %#x (%s)\n", ent.re, reaction_str(ent.re));
>> +	sdxi_err(sdxi, "  step: %#x (%s)\n", ent.step, step_str(ent.step));
>> +	sdxi_err(sdxi, "  sub_step: %#x (%s)\n",
>> +		 ent.sub_step, sub_step_str(ent.sub_step));
>> +	sdxi_err(sdxi, "  cv: %u div: %u bv: %u\n", ent.cv, ent.div, ent.bv);
>> +	if (ent.bv)
>> +		sdxi_err(sdxi, "  buf: %u\n", ent.buf);
>> +	if (ent.cv)
>> +		sdxi_err(sdxi, "  cxt_num: %#x\n", ent.cxt_num);
>> +	if (ent.div)
>> +		sdxi_err(sdxi, "  dsc_index: %#llx\n", ent.dsc_index);
>> +	sdxi_err(sdxi, "  err_class: %#x\n", ent.err_class);
> Consider using tracepoints for error logging rather than large splats
> in the log.

Agreed, context-level errors (which will be user-triggerable once there
is an ABI exposed to user space) should not be dumped to the kernel log
by default.

Some function-level errors may be appropriate to print.

> I'd then just fill the tracepoint in directly rather than have an
> unpacking step.

Yes, I can do that.


>
>> +}
>
>> +/* Refer to "Error Log Initialization" */
>> +int sdxi_error_init(struct sdxi_dev *sdxi)
>> +{
>> +	u64 reg;
>> +	int err;
>> +
>> +	/* 1. Clear MMIO_ERR_CFG. Error interrupts are inhibited until step 6. */
>> +	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, 0);
>> +
>> +	/* 2. Clear MMIO_ERR_STS. The flags in this register are RW1C. */
>> +	reg = FIELD_PREP(SDXI_MMIO_ERR_STS_STS_BIT, 1) |
>> +	      FIELD_PREP(SDXI_MMIO_ERR_STS_OVF_BIT, 1) |
>> +	      FIELD_PREP(SDXI_MMIO_ERR_STS_ERR_BIT, 1);
>> +	sdxi_write64(sdxi, SDXI_MMIO_ERR_STS, reg);
>> +
>> +	/* 3. Allocate memory for the error log ring buffer, initialize to zero. */
>> +	sdxi->err_log = dma_alloc_coherent(sdxi_to_dev(sdxi), ERROR_LOG_SZ,
>> +					   &sdxi->err_log_dma, GFP_KERNEL);
>> +	if (!sdxi->err_log)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * 4. Set MMIO_ERR_CTL.intr_en to 1 if interrupts on
>> +	 * context-level errors are desired.
>> +	 */
>> +	reg = sdxi_read64(sdxi, SDXI_MMIO_ERR_CTL);
>> +	FIELD_MODIFY(SDXI_MMIO_ERR_CTL_EN, &reg, 1);
>> +	sdxi_write64(sdxi, SDXI_MMIO_ERR_CTL, reg);
>> +
>> +	/*
>> +	 * The spec is not explicit about when to do this, but this
>> +	 * seems like the right time: enable interrupt on
>> +	 * function-level transition to error state.
>> +	 */
>> +	reg = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
>> +	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_ERR_INTR_EN, &reg, 1);
>> +	sdxi_write64(sdxi, SDXI_MMIO_CTL0, reg);
>> +
>> +	/* 5. Clear MMIO_ERR_WRT and MMIO_ERR_RD. */
>> +	sdxi_write64(sdxi, SDXI_MMIO_ERR_WRT, 0);
>> +	sdxi_write64(sdxi, SDXI_MMIO_ERR_RD, 0);
>> +
>> +	/*
>> +	 * Error interrupts can be generated once MMIO_ERR_CFG.en is
>> +	 * set in step 6, so set up the handler now.
>> +	 */
>> +	err = request_threaded_irq(sdxi->error_irq, NULL, sdxi_irq_thread,
>> +				   IRQF_TRIGGER_NONE, "SDXI error", sdxi);
>> +	if (err)
>> +		goto free_errlog;
>> +
>> +	/* 6. Program MMIO_ERR_CFG. */
>
> I'm guessing these are numbers steps in some bit of the spec?
> If not some of these comments like this one provide no value.  We can
> see what is being written from the code!  Perhaps add a very specific
> spec reference if you want to show why the numbering is here.

Perhaps it's understated, but at the beginning of this function:

  /* Refer to "Error Log Initialization" */
  int sdxi_error_init(struct sdxi_dev *sdxi)

The numbered steps in the function correspond to the numbered steps in
that part of the spec.

I could make the comment something like:

/*
 * The numbered steps below correspond to the sequence outlined in 3.4.2
 * "Error Log Initialization".
 */

though I'm unsure how stable the section numbering in the SDXI spec will
be over time.

