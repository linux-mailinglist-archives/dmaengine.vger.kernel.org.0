Return-Path: <dmaengine+bounces-9025-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEcxI4FLnWmhOQQAu9opvQ
	(envelope-from <dmaengine+bounces-9025-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 07:56:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B2018299D
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 07:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AA0A301FA6A
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 06:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F583093C6;
	Tue, 24 Feb 2026 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BZIrf1IR"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010033.outbound.protection.outlook.com [40.93.198.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBEB2F12AF;
	Tue, 24 Feb 2026 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916149; cv=fail; b=JjNzFGBBwkubDoS7Fc3eS1o4VEoVLtjLuR8p2t9OOwdCHHqo5D1b3WSfNtg2fpzU0uS0TuKKyNaeeFIQwvnKUtxSZCusYVRghNUTNkpkfwzBeyPN1M6XJtoFG54IaGsf1tiO3qo0MHbWfYE1iPBHb8QN5qCSBnaFJGABBkl9JGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916149; c=relaxed/simple;
	bh=00Ang+tG9TrqarR+2xhno44pMRj6YRR8f+RWaHhP4Ps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiTq5xoIiCDErTb4aP3kBCb7eoqQsipdZiO2F6YLPn2BPo0trpHdhA6Swi6G5a9DRlAMaY/2i3TXfiJKDZ8SXN3HYs3ibYcjhm1e+oxPWiKdaN27OcY0njPct2pCreFYly+UeFvHkRy3ewISGAZEpdm9SAZAMQgWt5hc7fqZj5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BZIrf1IR; arc=fail smtp.client-ip=40.93.198.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flG1b15GFZ0xKyxvLozDyi3dI2zBIdyMB0KcszeNhysNgv1JTP8xiblg3IIsUW6ag9/hGsNuzxRxPGIxJ/HT+xKBSXmk/9A/QZjNToLHEPkUQio3s//nRLyIqSdOGoFfEkR1UfFNzMTs324IkhrWAXgQdI4NQuyfG4Yy3Vom7FkF+DhboRgg5X3t1cqKjxXoAde/ebxm4uKY9N+gxF0gl0eBrrA+9R6w+PZshjKT6BRn5BhnXXEd16JCzLqyclcenkzGukrsofbM/amwfNNWQcJQZI7T2zZmNTcD1WiBR2fBltdtusmW7N4TbnSdC/fBHEboXKGufZIRB3UypabK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JezxlFNWqUfr7SH15x4qjsVsS7CUL0KO6krAY18VID4=;
 b=M6oGTfrbX6u7rCVPY6W0kkwXkdmtQ7CHIxdr9mfpZyBdkLcK+ofqEmmVvZimBV5tADjzaI9Irhh8E1Vg/9RM1BarYkVyhCFKaSlbkyFUDfXMj3GhIZoD7qTKTf5Iq5ip4peu+M7Tt7Fx6rpJZbLAf0XWqz8du702JPj0kBwg9X7MmJ3ZF3Z9fklv2Ki+v87s8mbE2wJndUN16kcg3Chc0lFZUP8LLQJ4A1L+8q59WUoKK1xRq8wh8t+p2SJNV4PbCLp6fyHJsnp09HJjWAlA/JHz2VkesBrdxaDRH7oTVXRVhsBi4kpeJwIdHcXIw54LyoaLBXABVwj9pt1vL4xE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JezxlFNWqUfr7SH15x4qjsVsS7CUL0KO6krAY18VID4=;
 b=BZIrf1IRwl4mqbtIeCMbTLuLDu+F8ivxOpXkrxegLUCAs9sj6RekQrl5gE4oHRRCADT3hWCaezPNSZoVzIjDCpw05a4FXbzGgq/6X03TwkwNqSWMTju6Ys8QKGd1lPa07yUOzPoJ4wQDnIBDxMhCwC8Ih1TlvwvZIgVbuCMFL2E7iZ5fnyR0iyzoOpZ7OxrCAgkuoURehl5n0Uz/R1vrrJkQsrMqXJUpzjt8MWSRo9vOGadwkms/mGaR3/f5XE5ZbSsQpwcAJmvCxkOre8rjvXISwl9/g1g58lDiIc9HsdUewK0+jwL8gYCmsiYlFMsei2FuEJ85zVUfxPMA/9hbjA==
Received: from DM6PR17CA0014.namprd17.prod.outlook.com (2603:10b6:5:1b3::27)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 06:55:45 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::35) by DM6PR17CA0014.outlook.office365.com
 (2603:10b6:5:1b3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 06:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 06:55:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 22:55:35 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 22:55:35 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 22:55:31 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <frank.li@nxp.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<jonathanh@nvidia.com>, <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>, <robh@kernel.org>,
	<thierry.reding@gmail.com>, <vkoul@kernel.org>
Subject: Re: [PATCH 8/8] arm64: tegra: Add iommu-map and enable GPCDMA in Tegra264
Date: Tue, 24 Feb 2026 12:25:30 +0530
Message-ID: <20260224065530.50701-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aZStTjL8EoZC4TtE@lizhi-Precision-Tower-5810>
References: <aZStTjL8EoZC4TtE@lizhi-Precision-Tower-5810>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2ec5dc-6ae7-4049-e4a6-08de7371bbb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KYjhWdx314vRD0SxubXWGz3fXfE3FTTZzYhrbjosIdWHPiQWtOCJP8LQ2vFO?=
 =?us-ascii?Q?HTdLfpGgmsYXLbSuBn53vVhyVgcoVvYaqpMqXcuHgz/73d/RYzS78iszm/ye?=
 =?us-ascii?Q?Bb6hlSzpAp9PfVzUBQeUngtXRYFjayJDzPYBWc2ZyzbAI+wbogigyFzrBJmh?=
 =?us-ascii?Q?jQFXWAf6UhbJDekOhK0dFIWLFQLrJI6LQpRCLiDsnQbxpXpnI2x4BvPzPTrn?=
 =?us-ascii?Q?C5b6KnjfPVseitsnYXgZRhwpmTdWB8nubCHLL5xF/3gw66pS1kJg6OpmrtrD?=
 =?us-ascii?Q?Bgj3Ch01L2PiIxtGUhNzRwFEd8Ivgwe4Ql7Q78tDH93DpruBCNUXeUhkTovs?=
 =?us-ascii?Q?Lyw+IaTOXvyq16WKjnoYMXyZG71utlZQNHe+3NNLQiJ8zCEitwBL9Ljj/Cgs?=
 =?us-ascii?Q?DPrQpo1gk7tbufXBQfAwZYwJ+uxaTCr0XLv9YltMDQL93bd9Xqim9MwL8ZO+?=
 =?us-ascii?Q?YqKZz3JhetvWqZGxq8bQ9Cb4L+OyEj7TnXB9Uvh+gpJDDZjvmYv4p06INO5x?=
 =?us-ascii?Q?6qHKKDGn4k5GJk4Oyjae7sF5uagPJMvFDMlGClNQvjZshMPmH93WT5c1aRtl?=
 =?us-ascii?Q?Q+O1GFgzuGrCXgv6132r+o9HkZw9b/0JCpbwCoxYd4MuZA3aNHLXMeyIE3bk?=
 =?us-ascii?Q?Znr0jqrckkb3wrh/CQZ8JWFSbJG8j689QRvyFlIUDJGUTzxkSu6F49FX1H4b?=
 =?us-ascii?Q?sGb8kggJ4yMkgJKQNalLRGgqcIcK0Bgyn35AHFnyImGRKWUo5g/RmADlnLK8?=
 =?us-ascii?Q?RhDEuC7G8IT4epC7TMTZRB5xOqh0FKuRUVAz3iqJZcpie7pzhl00rwqPrviX?=
 =?us-ascii?Q?GCeuPhaedjKYZH6DpISr6qfihlf0LiJMn76q5k7wvA46T5lqIR+YgZPLLb2/?=
 =?us-ascii?Q?eb74LxCn+tQWZb7lG6P4/4lfK4fsR9RtGJ6S1ON/YhXUV8qkFG9IFhPAVf8S?=
 =?us-ascii?Q?Jc5LJV9whFSt1PPKWtOHzX4YQA93N3EVJzs02+Ot3orofqL+X8P6nljc4QXb?=
 =?us-ascii?Q?RW/15XB1/I39eXLQTvq99CrKTizKP+cAnGtiEKaHSxevwAu4eM87jJRycxwO?=
 =?us-ascii?Q?lspOcO8MBvOwUw5RFA0HQ1mL7MzTRUMd2IlAksg7NIZ+5ETl+URPZyezjweA?=
 =?us-ascii?Q?5n/S0xUQ166l8NRGsgLeVPA7jOEEENaJ/FFWs5qOoa9yPxIaEzmZ7TKravNO?=
 =?us-ascii?Q?mh56ra/UvSM0G+RWgOcuhtC3NVpuE9DWTZned1SAusD9srq0H+yCOvGSGBLe?=
 =?us-ascii?Q?HX0FnTi8y0LqOUVjF+OcGqnG97CIod+rEri90YpBqMeE/gL4+yiwbf69p6cx?=
 =?us-ascii?Q?lTHYr/1pRe/+70OAhYpP6fWyY+TeuWooFXVDiA040ZIFFAuc3VR3NnwXpw47?=
 =?us-ascii?Q?2KheY9FdmfABp0obNrVeMN61DTj6uftIe11H9tk85+4Q7NY6ZGZ5zSSv8CRQ?=
 =?us-ascii?Q?/0LcLBiu6YqV/H7YjJr+mBnVBgG43ziZeK4/LLMV3hE4RVfPfdzRNNsMpcpO?=
 =?us-ascii?Q?mojaNpIHiVPyVeYkXTIdKfuLxlqjRYMmk5dW4+q5HJJx38GAcCMMlFrgdu7T?=
 =?us-ascii?Q?ykw3PMtwGHgfPKt1bvibLdc3AWj0UqwnbyiWXbJKtjkl4HIBl8JwUcAOjeNv?=
 =?us-ascii?Q?mlj1PYG3LYjPMr9wGt9GFxoon4W1cgoZ5/O7IG6V40/NtsTtUKlD0htM6aU2?=
 =?us-ascii?Q?47mAVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+Lqpbm79DUSkmDwquW/lQVaSSndXwb0YTzCUiOGYX6gbe/ApaGPY/mEfy1CEpzpaJrtEfx7RCX41UUTHC6+4Q7ahJQdCbrMCxMiViWmu8Hh9AXbGhFn5A12Z49k2IGmgsnchNonxPaL0jQdE/Jh1pR0IXEgIwo/EAhvl5wkcwYZT9eL+m2W0kgl4O64yXs+1PYh3OG+4FUjw7b8TeB68LgRMZAXCT+WqY2gVualPb28NnTpCQBN8kf74qoVQDgoBSZERfFoNB78pJOIRgHcVWDcCd8PJsIZ8DJFDp3PVDnHPIlW74k8xjETVJL7kBkZ2fhxID+DmDimmtpXaGAqDLvdUjM6W55Ude9kmYK+DGAyTQcfgEXBfITG38bbT6HKZSE8TAoVFxzJUamQqFaiv0z4QuJ4QteFkaj3tZc5NK7yXUeN///nzdixFYFxKhsdM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 06:55:44.9277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2ec5dc-6ae7-4049-e4a6-08de7371bbb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,pengutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9025-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c5a0000:email,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	DBL_PROHIBIT(0.00)[226.204.49.0:email,0.128.44.128:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 33B2018299D
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 13:02:54 -0500, Frank Li wrote:
> On Tue, Feb 17, 2026 at 11:04:57PM +0530, Akhil R wrote:
>> Add iommu-map and remove iommus in the GPCDMA controller node so
>> that each channel uses separate stream ID and gets its own IOMMU
>> domain for memory. Also enable GPCDMA for Tegra264.
>>
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> ---
>>  .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  4 +++
>>  arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 33 ++++++++++++++++++-
>>  2 files changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>> index 7e2c3e66c2ab..c8beb616964a 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>> @@ -16,6 +16,10 @@ serial@c4e0000 {
>>  		serial@c5a0000 {
>>  			status = "okay";
>>  		};
>> +
>> +		dma-controller@8400000 {
>> +			status = "okay";
>> +		};
>>  	};
>>
>>  	bus@8100000000 {
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
>> index 7644a41d5f72..0317418c95d3 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
>> @@ -3243,7 +3243,38 @@ gpcdma: dma-controller@8400000 {
>> 				     <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>,
>> 				     <GIC_SPI 615 IRQ_TYPE_LEVEL_HIGH>;
>> 			#dma-cells = <1>;
>> -			iommus = <&smmu1 0x00000800>;
>> +			iommu-map =
>> +				<1  &smmu1 0x801 1>,
>> +				<2  &smmu1 0x802 1>,
>> +				<3  &smmu1 0x803 1>,
>> +				<4  &smmu1 0x804 1>,
>> +				<5  &smmu1 0x805 1>,
>> +				<6  &smmu1 0x806 1>,
>> +				<7  &smmu1 0x807 1>,
>> +				<8  &smmu1 0x808 1>,
>> +				<9  &smmu1 0x809 1>,
>> +				<10 &smmu1 0x80a 1>,
>> +				<11 &smmu1 0x80b 1>,
>> +				<12 &smmu1 0x80c 1>,
>> +				<13 &smmu1 0x80d 1>,
>> +				<14 &smmu1 0x80e 1>,
>> +				<15 &smmu1 0x80f 1>,
>> +				<16 &smmu1 0x810 1>,
>> +				<17 &smmu1 0x811 1>,
>> +				<18 &smmu1 0x812 1>,
>> +				<19 &smmu1 0x813 1>,
>> +				<20 &smmu1 0x814 1>,
>> +				<21 &smmu1 0x815 1>,
>> +				<22 &smmu1 0x816 1>,
>> +				<23 &smmu1 0x817 1>,
>> +				<24 &smmu1 0x818 1>,
>> +				<25 &smmu1 0x819 1>,
>> +				<26 &smmu1 0x81a 1>,
>> +				<27 &smmu1 0x81b 1>,
>> +				<28 &smmu1 0x81c 1>,
>> +				<29 &smmu1 0x81d 1>,
>> +				<30 &smmu1 0x81e 1>,
>> +				<31 &smmu1 0x81f 1>;
> 
> It is linear increase
> <1 &smmu1 0x801 31>;

Ack. I will update.

> 
> Frank
> 
>>  			dma-coherent;
>>  			dma-channel-mask = <0xfffffffe>;
>>  			status = "disabled";
>> --

Regards,
Akhil

