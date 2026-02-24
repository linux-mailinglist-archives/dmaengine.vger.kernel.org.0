Return-Path: <dmaengine+bounces-9021-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tGgdG6A5nWmMNgQAu9opvQ
	(envelope-from <dmaengine+bounces-9021-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 06:39:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09673182219
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 06:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F362301FBAB
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 05:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BE729AB05;
	Tue, 24 Feb 2026 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qoNEMSIW"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43A296BDC;
	Tue, 24 Feb 2026 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911579; cv=fail; b=jq2l5yxbm4iBibwkRZugpUrX3/UxPtAlcTroVuHFdrB8BsW/wnphC+r29AxG3dPveiw/aTlZw/SeIFdWU8X6iGhXL/VwGgk6P1XBBfeGqucAMglOUe/+4N3y7anpQ2eawvo6IXZLijAgMEpNBpjDYyRPvmYR5EvZSzXY6ZYjmkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911579; c=relaxed/simple;
	bh=ZA84+gPXl/CoZ6yzgDgi/kN+n+ydeLTRXHSeRrvurbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJ0TGFUye718UGp1dSAmvWTuYpSRRpVN743/+pMfL3kY6ur6va7rRRr+TknoI+tJgnOiHFEhX5ir5n9ESaKvYOsrWk5Hvlrinkvdow6XJYR2eLphKB4YpaiNhVF69bztu1nleNYvzOfpgIErSF171BGPGUTmHT4WPtGaJZw1Btk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qoNEMSIW; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azccU0KL9m++SxoCuMhBlu5+76K3kXJ75FvQS89OwN/DY1gFiEx80z8LdtePPv/WELtsVZxCYyY7yVWiY6ASS8UldhpFzF+Capr622EU+hd/ROf4l3zs9Gz87FXAaLXwe/okqn0dQU+z5A/+lPrIdQI1zB2hTuENXysSzNhbFd1P37LWaOtRmw9+TXkPxbmiRaP2140ydnclqf5IiGF5R3W10qN7blafvnJR7AQF66ABXxwHKBuhn6VnSvJRLlHFBHzzrtTMR/T4Nr0zJ0wdgV1l0LRI3u2mc0MF3Bkjf65+UXiMtAmtwW3/ErX9l+fj9eU/0M2t/SfBoBoUWwQLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n5TUnAlk987ftT/ySfpyyuFEqCmJx66ACWIrspdAsg=;
 b=JkvxMb2klQvnaRWe4mPPDKkCH0bLwyq/RXWh1uNE32kNDcaBmraIJm0MXiLw7db7zqE6+oFg1hZJkdo5G8VS1yuQXai0C7Q9qoEuGJRPtBnbCtnOMaawlpns1tUiYBKPNYvfpFddfzmm9/JTAGdEVG/0Pe4tfoyUFhotbEN+GaZabd/MGtOIU8WU78SAXotLt/HSu5oMwexToucmJMm5EO6hQMgCyXYPYYIBlIOuCqKcrT/jMl3l64tN89PwOSogByfM7DNWOpeNgcDqUvkaMcLkT1nbe+L1vYh9QHGO0F+Apf7ce+b2BpWBu0+EjKi0NSzQW/amX9AeU/KSgQSaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n5TUnAlk987ftT/ySfpyyuFEqCmJx66ACWIrspdAsg=;
 b=qoNEMSIWLSQepKRn5MZxyOiMu6IE3p56MN3ZiaG0S4BnSKErg28GnWtP8GXJkxiiNO1GnQfh4dtd0NMvncwqd49A0hWMbHUgYUdEnhJB85DTbSdO7lMDU1wfMOywngwTbUp3Iqx4ZrSfO8E/ACahMCWH/OY5GBpULNjFTF6MybLPj7FmFlZbqDe/mqWroALZ1AWQHK9egTmj+YrR0YuS4Y8dMOkfIr/hwq81r5zB+1OFTJF20kofeIjrrwpy18TLdznPdSlLCugPUzsddKDSAAkZ1Zafu6SQRe8ECAwwASoUrECZmNUWABpS6xCICtqp5huOwPeCnUL0dlIoESEjww==
Received: from SA0PR11CA0083.namprd11.prod.outlook.com (2603:10b6:806:d2::28)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:39:33 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::2a) by SA0PR11CA0083.outlook.office365.com
 (2603:10b6:806:d2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 05:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 05:39:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 21:39:27 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 21:39:27 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 21:39:23 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <frank.li@nxp.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<jonathanh@nvidia.com>, <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>, <robh@kernel.org>,
	<thierry.reding@gmail.com>, <vkoul@kernel.org>
Subject: Re: [PATCH 3/8] dmaengine: tegra: Make reset control optional
Date: Tue, 24 Feb 2026 11:09:22 +0530
Message-ID: <20260224053922.43058-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aZStyRaoMYBlNOSY@lizhi-Precision-Tower-5810>
References: <aZStyRaoMYBlNOSY@lizhi-Precision-Tower-5810>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3d7853-ee0a-4ecb-4ea4-08de736716b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gJ85kFT2Kpnb+lxotX6CVsa0Reh6MbcyZ4s3hmkjBzBNAVqZtsNqT6kF7R+6?=
 =?us-ascii?Q?r3SQxOaTpynDASRcfZQN2/MQi3aadAtLaQ58u/i6ZE42tUXEGvMWNYHBzWDM?=
 =?us-ascii?Q?pmeL44MwSt0/pkSQu9teTUqBqULqKyzRnBTKgHq58MqaC3YtFjl9/o3Cslbm?=
 =?us-ascii?Q?cRPpA0U4usvpsiMdirYoXn/yH3biXT/1V9NCSSxtMbBroQFHcMvz33v5R/v6?=
 =?us-ascii?Q?82G/YWfp+L+m8czrVLtjY2sFuaBTDPBbG9oKxRIr6XoO/ukOEsMKpp/GOD0g?=
 =?us-ascii?Q?okB5slXSqBC1RRf4q7/VPfXeGtowaSiUH7bZZBQThiKT2FCHpYZglYZ2yuDT?=
 =?us-ascii?Q?161m8sXmCHz3GCrzea5DisYDQJ55g2VSg4d+zEbBXCF9W9rZpXDsdM9uKgyT?=
 =?us-ascii?Q?vK2jUAqRO8YmzBXhRxd18sbiRkyjc+yCZ5aaUDxGkfb8YoHkmRMTdw2/moqO?=
 =?us-ascii?Q?7UpG3TpDRsYmTlrV6XXOPvY7xtS2fFZmj+kRC20uE1VQD66zGoIYTBbpnu5e?=
 =?us-ascii?Q?mDJSEwfj+4frv1KvmtYNOMGe+EVXRG6ByoYbKhO27FoNAwrPoVXGwFPor0d6?=
 =?us-ascii?Q?WTsxMCx0SH3378xSeqTcaXI+rZU0XWYoG9yJL8sYxqUkkwFppAULEkXfXl7J?=
 =?us-ascii?Q?3kJ7j9D0+Ci9Dm1CLmFaed9Sd9dFCYd2mxS5RDSNKs80QUYW9TRLuoAYgPwJ?=
 =?us-ascii?Q?nS1fXJW5Ychokz3LXNmRWjH+dCnH28E0T+FJvzEOCGQgZHELYpyB48CKOvdB?=
 =?us-ascii?Q?qNYUXYldypnLqMvTVhzKQ7g+EU01T87U+MGtwOQrkBPCQvQX1Lh0o3BPw0B5?=
 =?us-ascii?Q?oUkFKrcGGI/TkA/hEKA4GM5GYTVJmgJy5GjPg9UlJwBjGVgtFtsCeCuthmqX?=
 =?us-ascii?Q?O9vkj2CNZekOYbexva6DV4BLnWmLrCYxKCZo5VgxXmI/XxwsiBqLMjo+PDN2?=
 =?us-ascii?Q?aVaCD/62iTPyra4hDZkc18YeJrJ7qzswRR8h3MbTqN5kMx59+TVGIkayvgTm?=
 =?us-ascii?Q?tElxkp6KEMDQBncan8kp2V4IrXPYe3MQCI2W/ybBR2fXEDLhaIQFFBt6kCjJ?=
 =?us-ascii?Q?hT5RbdsswR+hTszFDp2HsmHiD5zCtwx+KPkbmYj3Wm1FjkUzTJd8IrPndYlG?=
 =?us-ascii?Q?Ax6wNKN+XnZlPEshreBkZ5urIaUBYXkvfUOMR2GMvZO66DbX7LOzt/kYhUOY?=
 =?us-ascii?Q?gz/lYe9xf4/VDlOu93bpRvtFde8hbTEW3ounqu1ZkQHkHsCEjzb3tRz/1N8Q?=
 =?us-ascii?Q?T5OmWEz2tDjMxQGfIntRyQGGYdNUDPnMXsMbO35M+CgZMb7HIrfxjxyhm+bN?=
 =?us-ascii?Q?WwTPksA/aS/0GF0q6ppyM4RAoWgxtNESICNZEl96fjVTRKcty4Xv27FzK5bo?=
 =?us-ascii?Q?Y4j61fnxZ68Bwuhlr2UAkHtqNLuPTZ3B6ah/1mednyHC5oF0NPaSS6ukphRY?=
 =?us-ascii?Q?tby40UK4bk3KEZdxTGtSLaZI60nX2AX/tXKpPz5S8I1X8aS/y+Z4PuB9P0OM?=
 =?us-ascii?Q?A9ZS/jNY1CQf7oRcAIYxBFkpUVORvmIoEmmpXjFADpmFGTXryRkHsTl4cLd5?=
 =?us-ascii?Q?7RBm4EUwLEvyzEuzteF9d1/E2kTz5peBthhIz7s3EOGaFbgbytuD/FZ97QV2?=
 =?us-ascii?Q?YnU98lCviCPMAW+8gYyD4UAIu8soIj2p0LGb5txu0eLSAvAf8uJ5oNHGczK0?=
 =?us-ascii?Q?I6tdMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GjkxHqpKchcTzw/ujew3RrUmuwyl+bkbOCbPRyoNU5QvSHAhrKSl27FKu8lZ5jT2XY0ouk4Z1MQtEu0GIuGKVbfScJiC7Tfx+JE7LjxL+lDMIvSk+cldIuPCCqQwVXcWlLLoVKryr1gmrv/NlkJR3F7ThW1QgzX1kCwMs19lq0Nd7MylN0Ip08agD/XyZADty5nksDfmoUclLxQ3Sizlx49jyY8WFJ4HZkAHum1dEQZFKRl3NdzNS4LY7VBvYxut/2nRc9M2Of0iMq8+MINW3qYr7QMZ8cYYpH4nBDqicumEjofUtZkJ0KQ83d8UClEfPwaRG+s25GA6xmGWQfVdAMYarRSoiIjKRS5Q6C/sHLYldqP5uaI+AlpQ+eqSi59EyjMfEYPBd6SrCUQgAHr0Eg7paQjw/jd754WDyxwfK5M1axbNODaAJvp9GbM39KIM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 05:39:33.1836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3d7853-ee0a-4ecb-4ea4-08de736716b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,pengutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-9021-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 09673182219
X-Rspamd-Action: no action

Hi Frank,

On Tue, 17 Feb 2026 13:04:57 -0500, Frank Li wrote:
> On Tue, Feb 17, 2026 at 11:04:52PM +0530, Akhil R wrote:
>> Tegra264 BPMP restricts access to GPCDMA reset control and the reset
> 
> what's means of BPMP?

BPMP is Boot and Power Management Processor which is a co-processor
in Tegra and runs a dedicated firmware. It manages the boot, clock,
reset etc. I will put the expansion in the commit message in the next
version. Do you suggest adding more details?

There is a documentation for this in Linux -
https://www.kernel.org/doc/Documentation/devicetree/bindings/firmware/nvidia%2Ctegra186-bpmp.txt

> 
> Frank
>> is expected to be deasserted on boot by BPMP. Hence Make the reset
>> control optional in the driver.
>>
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> ---
>>  drivers/dma/tegra186-gpc-dma.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
>> index 4d6fe0efa76e..236a298c26a1 100644
>> --- a/drivers/dma/tegra186-gpc-dma.c
>> +++ b/drivers/dma/tegra186-gpc-dma.c
>> @@ -1382,7 +1382,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>  	if (IS_ERR(tdma->base_addr))
>>  		return PTR_ERR(tdma->base_addr);
>>
>> -	tdma->rst = devm_reset_control_get_exclusive(&pdev->dev, "gpcdma");
>> +	tdma->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, "gpcdma");
>>  	if (IS_ERR(tdma->rst)) {
>>  		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->rst),
>>  			      "Missing controller reset\n");

Thanks for the review.

Regards,
Akhil

