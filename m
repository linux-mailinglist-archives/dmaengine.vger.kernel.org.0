Return-Path: <dmaengine+bounces-9022-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iISmOGA/nWlUNwQAu9opvQ
	(envelope-from <dmaengine+bounces-9022-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 07:04:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A02182471
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 07:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B105130363B2
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 06:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB22C234A;
	Tue, 24 Feb 2026 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hw+lQ0ai"
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59A275B05;
	Tue, 24 Feb 2026 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913052; cv=fail; b=GqBhu2cgEyUbP20GqFUJAXljyi7WzlZbXzki3dQtNAkXDgpLeTwGTQQOBHuEp8jNzvH/knsw+4RW7Gn3Hy/1sXGstbnElO4m/6CacZbR5IDJtLt8+EvilQqbt0s3V5P7xkpsEm12OPsckYtUxKbKS+kM85InV3CcPGsN3LLu68k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913052; c=relaxed/simple;
	bh=BHz8rdCvbwQbf1p0oDsPqYOuN5lvw/W3vpSoU09uLtY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cL5+G2JIaHLQCbTbT2LlcKt8B4tCh+NdzuxfnBsTp/Zkl05ybp4s6Mw+CPqFgaoLo8NjaqvKe2+8hfSOj5z9wO1E6TP1ysSHLJA0jjKH/zL7ArunGxqA0WQv9BjHe5YG+nhZt4MSBYQxj/riQEwCvBOk7FK3pNmqSauXy2uwl0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hw+lQ0ai; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rc5hXhBuX0dCM5koSzpjdt8kMaSerPPdJKhELk8+Ry4wfPXbbIsS0fXTeW/S3cx4zUKcSP0Qr9weUcqWQ8pyx5YO1XUZjV3Hh0CFhZeNb0g1F4D5tLdt4FQxkWdr+MrmvPSN6QFIAbMPdWAdgLLOAQOOnKaDZO5y4y6DqbaqRFSBbS9JEvpdyEzFZhjy4AHMl8y29u6J6HV8p7sy+aEh+9IFBcqnmDLmDq+8+PgT7ima6op3U4bif9IwvzZGrTn1FUXGney402VtHnyp/zPWWQDFjC4aSmkOCSoPnMvkHTwYygcKaa5O83T4+ZMQdKsjZVRj5ZMesBD0+/RBQ8Ncgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIjAg2eRlPPZtEDtYTP4CUeRXcZ1S3FeYNj77hT0KjY=;
 b=wsUzQMX9XsWSfimBCJz2IlwzpWl958WqL3W8f4dCqWqv5oKh4U5Xj4tz0v4EFdGZa8CnsnG156/IgI33KymSFggJxOijJ5GeZQqIrPZLJwH19maLONhMft6ZdWw24hgKBqlYlD7RYTkGKL7xkpnkhkAGtn609x/GL8TN3K4qE+Hr0NPlDNblUFPB2FKCa/ZMTe2yLi6GlwF+h1GjFKm6LiR5lbZ+G04NQpwBrtCs1vpMaMO7JjTVGXOzEPDTJYa7Q2X3yWDNnVcxk0UhHluJ7JcUuyeJTA+UkxGhaZNrMAiEdQ9VmAWk6Ot7UK1RdlNp4OiNAc6/+3AQWNsHwXrxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIjAg2eRlPPZtEDtYTP4CUeRXcZ1S3FeYNj77hT0KjY=;
 b=hw+lQ0aimUu7/ymCleRK0O+OZzrn9o4swScU4emduEVMJYgc2EjoELX826Wk9gbKv8MQEjJdgDP5H4DkjUpYrYX5dZ9pek+RNsGXiLxvgrzqSN1WcvMwejcnRvkMmm1Fg8voLXluyQcLcPiQdEaFDWuw45m5gZVQ2ejw37pb4fuMiL4/E6+VzK7dLC4pwzQUt8MfyoOJxnpIMCf0Y/4XzCfp7wk5L2PTInSDRKJ68tH7Y/Z9zfBP/TMu7FhSie3Gn5OivBRy0H2iAl6GOcJXnOVdUxWXttwBH4Cmw5zr+LPGDvnW05aWFCyIzHjULSItUYwlIS2ADK4DAlLkbLFK1Q==
Received: from MN2PR18CA0019.namprd18.prod.outlook.com (2603:10b6:208:23c::24)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:04:08 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::6e) by MN2PR18CA0019.outlook.office365.com
 (2603:10b6:208:23c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 06:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 06:04:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 22:03:53 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 22:03:52 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 22:03:48 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <frank.li@nxp.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<jonathanh@nvidia.com>, <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>, <robh@kernel.org>,
	<thierry.reding@gmail.com>, <vkoul@kernel.org>
Subject: Re: [PATCH 5/8] dmaengine: tegra: Support address width > 40 bits
Date: Tue, 24 Feb 2026 11:33:47 +0530
Message-ID: <20260224060347.45544-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aZTFHI8_iL4vCkMF@lizhi-Precision-Tower-5810>
References: <aZTFHI8_iL4vCkMF@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: daebbc03-2efa-4d3f-7d6a-08de736a85f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZSEVah6caOntnCkJww9F2P45m+Z1lEZMT5X7hK9LSYnt3dUfhClYwkx39rUn?=
 =?us-ascii?Q?6HsvuVD5o+ouqtLYUc06itHZKaV9NJvq29EgEqq6GWMWr48gxPyIgflfUh4M?=
 =?us-ascii?Q?LQ6YE26LxZ6DD8Ob7WjXn3M5GWsSfppIVWn1u09ZZ1qNqhm7M9DPtbZtQCBT?=
 =?us-ascii?Q?C1UUj9dKs4ruDdDCxGkMZpQaQZV+4OCYmQFd0SezayWpAH3fE66KHEYjvIXI?=
 =?us-ascii?Q?lILf2UbVI7n2Ap9isxwTIFRh9nGI4JXFM7qsS+qg8rThuKOb1lpYHznj8akp?=
 =?us-ascii?Q?3HcECFV48h0pVUrDWUeGfWLPCZ1xuTAnoAxpQMw63nA6JrKRQACBkKxqVfpX?=
 =?us-ascii?Q?xcntCb5KyymQKeE75RIhmJs05AoPw+1qEMIW87uO9WdQZNeXBdOafWLoVFyO?=
 =?us-ascii?Q?DzuPKPJ3gZqPXc6lf5v6HNb7JsGa2ewuxBA+6+m0W1jELgDKsM6Ga56uxEE+?=
 =?us-ascii?Q?RhIEVIKXKUo7nbCKUNfTxfqIwBl7AZY/B6d00qi112oLLMT2+jFl8JiP25Dr?=
 =?us-ascii?Q?OSh0nLPhPOUXFlJ0rRNcN+drRFXh828DHyGefvNipSF5H9gaYGSI8GSTd+xh?=
 =?us-ascii?Q?WSDLD79f2zq8zJ+kyDeH+3D+JOWfb+jLYKIGb6BVhye/2eT511tAzgo0dyA7?=
 =?us-ascii?Q?Cu1942bPNthpmB+XUsSKOknlW9EDcYsA99e8AnGXCUv4YLC/59AUGv+AVGHU?=
 =?us-ascii?Q?CEcsPbvNAJDLjgHITLfs/3v3JIbdMOr6dYWI+FnnVeWcCHyGdURDhk1V67+5?=
 =?us-ascii?Q?XvosDb5/qAYVxxqXGUaqXrB8rVX7Zf2nxH52EMok6OyfYr+0GlrTP4yabEk1?=
 =?us-ascii?Q?TiCjgXoUM0WVk5LTImib90BtNUKTUILyF8rmWwc2Gn3vihtLE79kqrzMFMkg?=
 =?us-ascii?Q?v26iDFjerwKevAO07SVnBuhTh7gzGemwrMI7RlVb9SraeTIOx7PLsTHP0M6H?=
 =?us-ascii?Q?2kErwObNHKMUTPHN7v4PYFw8Z17bjXImbGd4INgHWTAUjfKNbPkr5l2K9S0a?=
 =?us-ascii?Q?brTVOahe2wuIhYCZFrX0ONrR/hJ4nl5zjuZXEGP1/xAtlSFGjoPKjBnmB7Qz?=
 =?us-ascii?Q?9qIWFR3oYSybmpoavvC4vJ/2auEEMiwIWgrlcs26IuN+/stbTOBFbfV7eWeV?=
 =?us-ascii?Q?hV1JpaqKjBQM2RidCCwPNIo1GgVq7OCMPyW377E3GsPZb0lPbn3kGW4YgN1+?=
 =?us-ascii?Q?80fGTEs7fdY8v03W/PstBh39kKGZnBfcVZ1YH0/WgXycsVEfT3UOY+jKhMsX?=
 =?us-ascii?Q?ZVMYmZLBezqytotyu52zmWKE2sO7yOieoxoiVXRmoXpcJKSwJCvrQV+jIKqw?=
 =?us-ascii?Q?As6OilZ8JiI/wtrWUPmIMU4Z3TIEk4y2rgwIbU6rYyxMjfeLEVAI5NWOiRC5?=
 =?us-ascii?Q?YKAnrvnWSqX2Z0jVExh+EaftlB8BUys52aFGqYjuaFJAhdpeF66EKiq8yBpC?=
 =?us-ascii?Q?SAn25VeGaKE76he85k1xAoH8Oa5Cb7gCxVSOjmuR9m1FqB7dm9eEJKBMQfrM?=
 =?us-ascii?Q?mPXhPlqDFuzA8Igv0t59gG08Gyujw1q03Z81LgB3xDxnkGuq0dWcpP0pX3/6?=
 =?us-ascii?Q?8lRwVsYWFI2EhtyD/rVDf+R4VtMOYU2K6lvbDxKehzGfPU6n2iGSoSmvyOv2?=
 =?us-ascii?Q?S90HtuRVf1xYJqDszgtXzaM9cXVx0pvv68o9oUF6NPKsjqc7yYLitY2JIjIs?=
 =?us-ascii?Q?TUkusw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2V2I0TPufv0L5zoYgaVaqhdh8v1nA1HqBl3+eVK903BIFhV+ssbTB1Trcy5yF7R/+5RT8OLWq2uK/02U1uJa+RuqeYyNTXQEXaaPFG2yHqsxqr8PRPeGwNG88sZ5dwjonAxK1pV+hAFNs0S3NGq1x2Q742/iwBnWhEuR0fH4Ik+0zyOGxJB7cyk0cmRd1+tm0uMu86LyQUEgVm0qpMPzL9KmrZfe1ySNGnYh5ve2Xo68MYAqNH++qxd9kWrNF6jpaSUm28ijH2/Hq1dTD9GH7BKdtX0N9HExYyKvJyAXCuBSU6OsjRnhCxpEwdIYBRZjXmiI9xCPl8qZsz2k8KCS95KsjA+BfISdaQooTk9+TWHaLcluhJhFmyMyYKZMkdMnoW2AD5G12ar8v2UOzMHVbCTof4BeEaLu8RHrNnEA+0iXDWusXYickDhnBA38p3B9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 06:04:08.2380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daebbc03-2efa-4d3f-7d6a-08de736a85f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,pengutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-9022-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 46A02182471
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 14:44:28 -0500 Frank Li wrote:
> On Tue, Feb 17, 2026 at 11:04:54PM +0530, Akhil R wrote:
>> Tegra264 supports address width of 41 bits and has a separate register
>> to accommodate the high address. Add a device data property to specify
>> the number of address bits supported on a device and use that to
>> program the required registers.
>>
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> ---
>>  drivers/dma/tegra186-gpc-dma.c | 129 +++++++++++++++++++++------------
>>  1 file changed, 82 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
>> index 72701b543ceb..ce3b1dd52bb3 100644
>> --- a/drivers/dma/tegra186-gpc-dma.c
>> +++ b/drivers/dma/tegra186-gpc-dma.c
>> @@ -151,6 +151,7 @@ struct tegra_dma_channel;
>>   */
>>  struct tegra_dma_chip_data {
>>  	bool hw_support_pause;
>> +	unsigned int addr_bits;
>>  	unsigned int nr_channels;
>>  	unsigned int channel_reg_size;
>>  	unsigned int max_dma_count;
>> @@ -166,6 +167,8 @@ struct tegra_dma_channel_regs {
>>  	u32 src;
>>  	u32 dst;
>>  	u32 high_addr;
>> +	u32 src_high;
>> +	u32 dst_high;
>>  	u32 mc_seq;
>>  	u32 mmio_seq;
>>  	u32 wcount;
>> @@ -189,7 +192,8 @@ struct tegra_dma_sg_req {
>>  	u32 csr;
>>  	u32 src;
>>  	u32 dst;
>> -	u32 high_addr;
>> +	u32 src_high;
>> +	u32 dst_high;
>>  	u32 mc_seq;
>>  	u32 mmio_seq;
>>  	u32 wcount;
>> @@ -273,6 +277,41 @@ static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
>>  	return tdc->vc.chan.device->dev;
>>  }
>>
>> +static void tegra_dma_program_addr(struct tegra_dma_channel *tdc,
>> +				   struct tegra_dma_sg_req *sg_req)
>> +{
>> +	tdc_write(tdc, tdc->regs->src, sg_req->src);
>> +	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
>> +
>> +	if (tdc->tdma->chip_data->addr_bits > 40) {
>> +		tdc_write(tdc, tdc->regs->src_high,
>> +			  sg_req->src_high);
>> +		tdc_write(tdc, tdc->regs->dst_high,
>> +			  sg_req->dst_high);
>> +	} else {
>> +		tdc_write(tdc, tdc->regs->high_addr,
>> +			  sg_req->src_high | sg_req->dst_high);
>> +	}
>> +}
>> +
>> +static void tegra_dma_configure_addr(struct tegra_dma_channel *tdc,
>> +				     struct tegra_dma_sg_req *sg_req,
>> +				phys_addr_t src, phys_addr_t dst)
>> +{
>> +	sg_req->src = lower_32_bits(src);
>> +	sg_req->dst = lower_32_bits(dst);
> 
> I suggest save 64bit address to sq_req.  In tegra_dma_program_addr() to
> handle difference between 40bit and 41bit.
> 
> So only need handle difference at one place.

Ack. Will update. 

Regards,
Akhil

