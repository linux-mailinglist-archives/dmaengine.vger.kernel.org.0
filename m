Return-Path: <dmaengine+bounces-9235-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I2GBI4LqGn2nQAAu9opvQ
	(envelope-from <dmaengine+bounces-9235-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 11:38:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF771FE764
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 11:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E50FB303461A
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 10:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACA93A4531;
	Wed,  4 Mar 2026 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q77tDMyd"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B239FCD8;
	Wed,  4 Mar 2026 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620682; cv=fail; b=Cu7Gnpc3yhzWKwkp9dPRhJ/7nSgi1Q18cRINVdu2TfNyaTuoreLyVHm12/pmBUDjWZ2zfo69b95143BSi1onJfUVF4NEGYgpRCPpuZ88yM9b+xelZGfzW+IXF3WM/HidpNWiIL0A3L48vOSL8zOxgBA9NjFG7NWI5FIUZg4XEB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620682; c=relaxed/simple;
	bh=C/BLrmVea6XS6Hx3g/eG349HLRNrwVGTSx2kIIL+b+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXI4mvDLtEH/L/JvEerejwvG/MRS0jBBQjwaYKDpEDH2iswTplo9759fbGZb0WwiW/+4SoqmdB3NbRj70g3rKnT6XpO2ZD1rV4QJoxohbsZM6sCNUeMzrSgkoIlLHx38vMcJchR2+TktlTHfnZ83MH6EbvAVNH7VJXMGfFmyWGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q77tDMyd; arc=fail smtp.client-ip=52.101.57.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVh0NjIVaqMQ0VuFIjKtQ7feCX+IRgcWgehuyvN8XhBL6m/TqEqXoqCnk5QiM+kmwY5kZKYIy/Zu9jaghmSnR2AyQiYDRWUgpTM/fGpa1S4Ihr8224URdrxnz0OG7F1xvTc3bUEPANXU57XTrjkQxBvvjln4sBP0g82noR1rJWsYsDp17lQ1XpNQZ4bgLbrlfHYW4rbWhRfZP/Jp1Qdz5k9eZQSc/Nf+Ce/okBGmuPrPenbd6OB6PXJja6B2WBZanh26Jx4goHwb/Ah6TOFahn+umJ7HN62vXsihqZMPOwWNMvpJRhZQ8R/5UTtwwMO76ZqNzoB29x0r/M5X0b/XFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nyIfHurOoeAxDCIORF+sBteAqgNMhO2d27pH0SJ1dw=;
 b=eHN6O1BmZw2jvvQic4lLhl70SEpkksI/eTF2LjIbWvJE3SReUDysVEujYXoLRIycvZxAOoNHJiny17F8bi/w5ddjb+1/zoHtJYFA5OPnucDE6t/TR+FSUXDneQKbW5rETC/zUNGjCYNJoxShDOUdCjRLz3gll0thhhEZo64tvoNcT3GAyDoQJLdV/PaNO/LjkiWrifApBLVuRzXH4rI/6cgtYDAINpf9Lbz67Vvq+gVUd2o4q5jj7jGvbEZ/97ftecSnFM6BQM7uzvZt2E4yRRtnnbE13E9a2i3e4RBnDgghjuADFBPnm6085r0rsdq4gu7kFGfZ2sQdNQNy0770zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nyIfHurOoeAxDCIORF+sBteAqgNMhO2d27pH0SJ1dw=;
 b=q77tDMydUqAEz70w1EzPHLmibqYY1TYaFCnAHnvkeIC9S5SQMuyhGSimABklfs9MVJxPUzBRUYa302LZ+AvswpJ2HbYpxB0pVTsxB8mjvsIxYsM//59H0pkdu8gyP3Bv3mJqpEI7AIM0/2d59qgyJjZiCUykoYzZeaoAT/HHIn3nW8+2xbQXiOBOCB6yrmPuVbEvojAt3KJoMd7p5VwfJoNcWMV1TdjFC1mooQ3AEN63aAmmERadBsmDGhG14ilY5wM6KwiWl/wdFdn7Ed62pNV8cJLWw/GRAwTl95v9o1UQr11BV+HsNy+XXUDBVRtpYlCB2Zsv6Ynq4b8OOe7ewA==
Received: from DS7PR03CA0056.namprd03.prod.outlook.com (2603:10b6:5:3b5::31)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 10:37:49 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:5:3b5:cafe::21) by DS7PR03CA0056.outlook.office365.com
 (2603:10b6:5:3b5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Wed,
 4 Mar 2026 10:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.0 via Frontend Transport; Wed, 4 Mar 2026 10:37:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 02:37:31 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 02:37:30 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Mar 2026 02:37:26 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <jonathanh@nvidia.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<krzk+dt@kernel.org>, <krzk@kernel.org>, <ldewangan@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<p.zabel@pengutronix.de>, <robh@kernel.org>, <thierry.reding@kernel.org>,
	<vkoul@kernel.org>
Subject: Re: [PATCH v2 1/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
Date: Wed, 4 Mar 2026 16:07:25 +0530
Message-ID: <20260304103725.64228-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <361e0146-c5af-4f16-a946-14d1df85f99b@nvidia.com>
References: <361e0146-c5af-4f16-a946-14d1df85f99b@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: f461025a-e65c-4cdc-bcc9-08de79da14ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	1nGy67L4i/3m8bf/qVTPfzHtGwi9tN4abKAJk40k6xkvDaKpYlP5ty4GG/9fRky3rfnqyZ+9OgzQJitHdnA2SrBiDMr3n8aqEfSbl+Xt5MV+8xnZyawZTyu5HnzBSa4HEfWV5tKl6BPs3ACQAUkUgVEB+wVUQhT1N8l7ZXgSKKFqb6E9v2uRlrjxtl5nfVpzQ/EhZMT83vTBXoKpTwbXzUeqCfjJbjwHnBD754C+457mnEFR6p9iFKLFueKdTw2BFXQhMit2r12/eOxw/lUq0FodkdmIRPBVIMlSY1StttxUwoMYnD1zFmMoDpCpKIjJDshrc8O50v9bGtb2DE0kJ2fByJUWIfwkcyYL3uMprO2T9W/eWSKFxctNzbQ8Pd8MlRtcp19zJeyTnbS6GF07ZJtz5eUXjQak92Q9I9mv9Y5Y1YihyHbgd2Z8eMG0ERV6Yq+7QZT1H03CITwxcF2DyCaHj2cop80uCTfG2XPPvzkx2mnuoBXimI9krCtaAu/0lztLx1Wmt4jc0/Rsuz9f9psxGpRRpB50GcA2jSfBJgm3VjpdDdsB0HEBOqs4QzcgBvvTLeYL5/6TDUKaGDsd1WqmgYFEAqvBmB8zgvIINDtszsCzFZEOVQBa1rXaUoRSwOQSioHV5CATzH+aC9Ouq6goqud3f4o0ab0lJiSa7/Ro/aGQO/OoY9df/GjxCMpz7SHfUiAZqdjb0uEjfZiZuFfHZiQz2NqHZuUm9anJk5Gma1lzHN1F9SkJn8WzkYKADBM90DggZm2DyAM6LXFyug==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yx8CbQbzddXlgirXIr48l4GOz/wNtvY812Wlb5r+IXZ8BvXWZ6cC+SDgCt+onmmN6JooyDmnx3Gh9wWsOtpvv5OHpglxoLitPHJNhfNvQFX4P384nQXLOuqOpoLTcp5ZMVOAY1XGOn5rhS3YDW6VzjqdVjhyQrnndmt9Pe1SYc1bkY8GWg3mfy6szqG3hTjqUjVnWHFkKn5iz0VfEDfhFwMKncJo/Nh+2ogMRcPG6GHrCofk7JvJqG7o990PlzERfgsw5jXTPUKaT9BkCG8KITicEFB4ULMI4zPnpscJzhAaRG2lpZNBnmqQPI27vxnGZYYj/gMbHVhT+r5ZwUVEbtzMnfmsIpxqQRSycOiaAmeYZ7VdxlZHM4mD62CKfdNyqsBmGdsb72cq5mzVxpyMxE+OUiPsoYGsoYVoAB8mXG5Qp29zGAXyEilmftYk6v8k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 10:37:49.0136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f461025a-e65c-4cdc-bcc9-08de79da14ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
X-Rspamd-Queue-Id: BEF771FE764
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9235-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Tue, 3 Mar 2026 17:34:00 +0000, Jon Hunter wrote:
> On 03/03/2026 17:14, Akhil R wrote:
>> On Tue, 3 Mar 2026 13:09:00 +0000, Jon Hunter wrote:
>>> On 03/03/2026 08:40, Akhil R wrote:
>>>
>>> ...
>>>
>>>>> Why is this flexible? If it is, means usually items are distinctive, so
>>>>> I would expect defining/listing them. If they are not distinctive,
>>>>> commit msg is incorrect. If the list is as simple as 1-to-1 channel
>>>>> mapping, just add it in the description how they are ordered.
>>>>
>>>> Yes, it is a 1-to-1 channel mapping to an IOMMU ID. The intent of making
>>>> it flexible is to allow non-consecutive IOMMU ID assignments as well.
>>>> This is particularly needed in virtualised environments where the
>>>> hypervisor may reserve certain stream IDs, and the guest VM can map only
>>>> the permitted ones. Shall I add a description here mentioning this
>>>> use-case?
>>>
>>> Isn't this already handled by the 'dma-channel-mask' property? The
>>> driver will skip over any channels that are not in specified by the mask.
>> 
>> dma-channel-mask would not help if a channel is exposed, and the
>> corresponding IOMMU ID is not exposed. For instance say channel 15 is
> available for a VM, but not the stream ID 0x80f.
>
> Is that a valid configuration? Above we said it is a 1-to-1 mapping 
> which would imply the mapping is always constant. Ie. same channels maps 
> to name SID. Is that not the case?

I think the hypervisor configuration can determinte which stream IDs
are assigned to each VM, so the mapping can vary across platforms.
By 1-to-1, I meant that each channel maps to one IOMMU ID, but the
specific IDs themselves may not be fixed. If we prefer a constant
mapping instead, we could document that only IDs in the range 0x801 to
0x81f should be allocated to a Linux VM. Happy to go either way. Let me
know your thoughts.

Regards,
Akhil

