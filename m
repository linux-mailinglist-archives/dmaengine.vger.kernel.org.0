Return-Path: <dmaengine+bounces-9356-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1kbTLcuhr2nvbAIAu9opvQ
	(envelope-from <dmaengine+bounces-9356-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 05:44:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5E12454A4
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 05:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D37FE30205C1
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 04:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4353F3859D5;
	Tue, 10 Mar 2026 04:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CAhk5MsV"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9862253B58;
	Tue, 10 Mar 2026 04:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773117896; cv=fail; b=aLHCctFqknhhP/CUgR3zYcizxmqzaWcG8Dg7gwq4Te9BkcQ7cp3XjOgxtIqQv1NmMtyAOoHCV5JetcDVXXR/JEEg+qIE/+5bFf5tc2xTiuCPL9AnO/9Z8tVwbFXG+0A7iA4FDG5nFj31xFGTThfx2rKoIc5ngh/ntfHFkNmbZwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773117896; c=relaxed/simple;
	bh=jWuYFs/WFc8+t0tgqPCztt4+RuF4Tv78venwRQhL3bg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFH6pejXnU+Q+nMS8IwaFULixx+rjFShDwXxxsVPdJv+iGwV5c9QZE44KAe7EliQ1u8KWpPFNvY/mn8e8WhpWKP27lq4rbh5zOraZPqcZiXZgkqZiwKca/2bOVaVQH8VkblI6Zlgp9fyy1cMcUO/xQNC4zRw9SMxZSOXofNiw/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CAhk5MsV; arc=fail smtp.client-ip=52.101.193.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uv9SlVpJeFn/b+BAThud9jU5NWnqBhzI5kOSw7//lbFEyCwF2RVFXi7tNMNIqrpIFgEYf3v+O/jbmJ0dZXGmcNVtu2oWuqhyghe9S01Lff1vIJiN0ssWdmQBJv1sTyAg2aOk62WoKEIWMQkMheYnjk5Mp3hKOz8rKTRYKsYojQ2zObF2idssZgioF+fL2gexZMH5q8Z3/pMxxj/7VJ5NIfKGIEFvs32v+xoZTaezpsTpmHtpIztGSUWyBkR8xt+hNZk+LPfXmp7609wnW3HAZg91btA+r2OaUJosRzvb+fvse9xL7+kHdH6MCBwPMTYo5zyWhpeYlKdjGfpw9hqLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9OOI1gDdOB/efrU9zvCIz664ZfqcUmGXjv9rZdbH3o=;
 b=tJZRri24zO7iOk6WdM4I0Dap6uBjgEqbCfcx+3CIYV9t5utK+oEchKuJeVrz3Nlg7sP0ruIgp7dDhMsABxpkucQBquzIbAL2soS5GKlivm3cP4XxDfrKVE/Vvg4vWxxgLjNqYa0Cf5BYQVLZqaw/xpLoyS3SKoCCrqFD+kYVbrdBkfs2dxDIgXVNLQqkwaLwZMf1Wz4OfuHLEKb8zB+drQwXJfcO3qlxsbgWAafavqachBmxBNQhrsjuGJq8IcqnOvqJneJIBpxfkKOU+OdEBuqnyVyYVb4KRgoD/I9Ix+nJbVejSPjeSz/mPp3LeyHwMz4hL8krWBpvhMDcu5BgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9OOI1gDdOB/efrU9zvCIz664ZfqcUmGXjv9rZdbH3o=;
 b=CAhk5MsVTDLxdGwWlBM59kf7wsUpbnalX3umV6qhTgJ0ZpBuSvkh6WdrmyqbgnT/iD+mtOAC0IDYHPEC/TuFK2avm2sVx2p9dAI42fCZ6XWXbNoVTRt0Vfyvc4wFB7abIty2xLO/30dhDGkHyYSlu5y/fDqh/C9EVkf1aWQRIGnzvRhfdnkhxAfJiGXHplQr1QsAzaBVfkvXxTADaUNMgpL/uwWesMGmav6RQo1fcPaqqFtktWU6ptFhZgA4rOwGHK26a2ChYrrmIkT5udu9RNjYNkdZR43Z7nsD748uBKw1e1tPEg+PBqpGmEmBDCOjt/vjic0LX3Qje2GzWlTQNg==
Received: from SA1PR02CA0018.namprd02.prod.outlook.com (2603:10b6:806:2cf::26)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 04:44:50 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::fe) by SA1PR02CA0018.outlook.office365.com
 (2603:10b6:806:2cf::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 04:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 04:44:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 21:44:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 21:44:30 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 21:44:26 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: <jonathanh@nvidia.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<krzk+dt@kernel.org>, <krzk@kernel.org>, <ldewangan@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<p.zabel@pengutronix.de>, <robh@kernel.org>, <thierry.reding@kernel.org>,
	<vkoul@kernel.org>
Subject: Re: [PATCH v2 1/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
Date: Tue, 10 Mar 2026 10:14:25 +0530
Message-ID: <20260310044426.53519-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <9740033b-0fa4-46c6-9628-f4c3ba1cceae@nvidia.com>
References: <9740033b-0fa4-46c6-9628-f4c3ba1cceae@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 584a18fc-cbb8-486c-45d5-08de7e5fc36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	AXHClB3DyJ301NJK0YU0Qdmmqes/i6Lgy9g7oJgTi8BHEaYg6mvlrE3BjOSmodLZnLi83Mkf2eW7LyQzQMvC/6nUsxDMjEqokfberX3RnzE7uwsLTqJl2jsBVsf1G67ySy3G7YTshhA8g6f6klMn68xRXqVfZHH3DODrDgB+PT9fp6Gp0ZN7lFnZCT6rCalWh/WEMmrns5qcZ1LfQdoq/FDlkqtCfSsXTdNGBEd+HgumyROMWkiPqgiiNWzqyHakAQ+9U5Ec6+H9a7HRWY8vRkJPN7XBfTPXyVe2AlBEkMb9V0s4d/7xTCfbl5DHrXfzlSl6HVCyGGWsHkSkl2b0XtLLEdTzBafGK37K+l801QV2W8J4y1OzqCjiN2gJa51d8/UNmAzO9+nDtb32zA0i7YRIqvsy9Zy9hfwERf/cIqfHjaNZzCRAnTq8IMjWEjCfWWyBQoBnjMQgr23h0U4F4CG45w4f7GgDjwQGFaxeXYZQndUb3euRcOPAfIYlm6pzZBaoEtre6WPXbr4Ijr9zLPAToZiE7Xf83WCiSG2sicsmCJAP4zrWYdeY27mf5tEvvmqf/st2Eyv8JjB0YoHNS21DbT3xFGFz7FuqTd9TMyWetC9PSixVdOwzIOw2HYF0Nxky9i6+7+U2Ra52keAEddOQRqAAyrdAcsbhaxxfseYI7dlSsJGEI4RZWgL0KZwkOGpJcNnxE2UlXyQS87k4Qoi7mD0If/En+9ZDVBchrtM0LsweaBBfrZl+2CAnGpKla759S4F3JD5svpwxI0MF2A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dz1EgFazfyMOIM1TahyIJXcwtfgGLaxJHTHkPE66sx8ACak/rnj9tJ2+nUQj7XS8qcCbkeC8vYE1C+EJ+TX3QjLFFyUlufwOHk3BxsFs+8mtw6Lhj+3oIXt1i2Va6FxbfVSibXERL7KrPaZgpzu554Yf1WnWqiU7VQmytS2KYqKiMxz6gXZOd2393IF0+w4Y2wj4tzx6NElsylPOL9BXWmb9rnpxbs61cVTPq2uP918a7QB9LgKN1zyFgwhiJzHFMdQyPGa/r3conHP9em7mYQybb6zw4VpmM0ltUo/GVYQeydQa8of/wd63kebfqmdLZIGtf2/xsFKp24DlSpWNnR7FxfCAZis34ipFY+uwFtb6zhjrrSmI64DtJ5IeN6fcINt5ABx0LtUUpYOp2PVLL8VO+Sp2c29u9tSkE2f4x8+TPc+T4eKskkcAJfVGN7Ad
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 04:44:49.7606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 584a18fc-cbb8-486c-45d5-08de7e5fc36b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
X-Rspamd-Queue-Id: 1E5E12454A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9356-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi Krzysztof and Jon,

On Wed, 4 Mar 2026 11:10:55 +0000, Jon Hunter wrote:
> On 04/03/2026 10:37, Akhil R wrote:
>> On Tue, 3 Mar 2026 17:34:00 +0000, Jon Hunter wrote:
>>> On 03/03/2026 17:14, Akhil R wrote:
>>>> On Tue, 3 Mar 2026 13:09:00 +0000, Jon Hunter wrote:
>>>>> On 03/03/2026 08:40, Akhil R wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>>> Why is this flexible? If it is, means usually items are distinctive, so
>>>>>>> I would expect defining/listing them. If they are not distinctive,
>>>>>>> commit msg is incorrect. If the list is as simple as 1-to-1 channel
>>>>>>> mapping, just add it in the description how they are ordered.
>>>>>>
>>>>>> Yes, it is a 1-to-1 channel mapping to an IOMMU ID. The intent of making
>>>>>> it flexible is to allow non-consecutive IOMMU ID assignments as well.
>>>>>> This is particularly needed in virtualised environments where the
>>>>>> hypervisor may reserve certain stream IDs, and the guest VM can map only
>>>>>> the permitted ones. Shall I add a description here mentioning this
>>>>>> use-case?
>>>>>
>>>>> Isn't this already handled by the 'dma-channel-mask' property? The
>>>>> driver will skip over any channels that are not in specified by the mask.
>>>>
>>>> dma-channel-mask would not help if a channel is exposed, and the
>>>> corresponding IOMMU ID is not exposed. For instance say channel 15 is
>>> available for a VM, but not the stream ID 0x80f.
>>>
>>> Is that a valid configuration? Above we said it is a 1-to-1 mapping
>>> which would imply the mapping is always constant. Ie. same channels maps
>>> to name SID. Is that not the case?
>> 
>> I think the hypervisor configuration can determinte which stream IDs
>> are assigned to each VM, so the mapping can vary across platforms.
>> By 1-to-1, I meant that each channel maps to one IOMMU ID, but the
>> specific IDs themselves may not be fixed. If we prefer a constant
>> mapping instead, we could document that only IDs in the range 0x801 to
>> 0x81f should be allocated to a Linux VM. Happy to go either way. Let me
>> know your thoughts.
> 
> I guess I don't know what flexibility we need here. But the more 
> flexible, the more complex the binding and so if we need that 
> flexibility then you will need to look at how Qualcomm solved this for 
> their 'iris video codec' as Krzysztof mentioned.

Looking at the qcom,sm8750-camss.yaml, each iommus entry is describing a
functionally distinct hardware block like IPE, JPEG, etc. Here for
GPCDMA the channels and the stream IDs are identical in hardware and there
is nothing functionally unique about any individual channel to describe.

If the channels and stream IDs are consecutive, as Frank mentioned in
the previous version, we would need only one iommu-map entry for all
the channels. In a virtualized system the hypervisor may assign
non-consecutive stream IDs, or a scattered channel mask. That would
require multiple entries.

I will document this in the description. Please let me know if it sounds
good or if you have any suggestions.

Regards,
Akhil

