Return-Path: <dmaengine+bounces-9024-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF7pAFVInWk7OQQAu9opvQ
	(envelope-from <dmaengine+bounces-9024-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 07:42:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E31D1827E2
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 07:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD6003036EFB
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD3303A32;
	Tue, 24 Feb 2026 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C44bAXcg"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B69187346;
	Tue, 24 Feb 2026 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915336; cv=fail; b=IC0sYR1xo5y4tX4uf1dQIb8s2pi2N8xsdEeLt1Z49Mp87Nzaxv+PogqbKZPNLCbYE34mdI2l8QS6WZnHlYwiOSzv4k5b/MAAhlhIiHrmmddgZIeuQLMkmQt9TC8ndqYjP4l2Rzt/GZMfTqPgQp0OFcX6wc0l25GHJeKitqS1wDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915336; c=relaxed/simple;
	bh=+rrrzzX4c0d/zk19KsXYIYAobxcRzdUpl65uM4tOaoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKcttV2f/D6FFT16mLqKnyFvflO4aaiPIevGdTooGZR/FwiCYKj2omVv9daDTeBGpZMT49A2ps61Mvyz23NCgqS8uk9egHjvXIYv4OasgPNB1A9MaeP4odY+6vvBB4jTZVxTdlHLty9HlMZJDdNW31z0uY0ryVoeXEchf9diPUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C44bAXcg; arc=fail smtp.client-ip=52.101.52.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3rSUCP1lxpiLHBAlHRAePbvNMGVjh+Ns0AT/bLKKhUZsfvZnWK2sETL13e705LqyfkjNNlxTO/i7emMYFzl9MR35Dz5TKAxoPI8JoGgsCqqCn29xUpCg5122dP5AeqV3ni+VB5YQa8M38zFORGVLmcpVZvQ1pcgi9WBNfVmkeNN5V+MT8DbvuvLSzzAVp3312i6UZNphO2WmAt9ne7+M7klCoFUz9k3H/iWx741Gm5Jq6krKP9TYN0RvFGVtgBcZCtUAHZpSHSJCBVemqvoOZpqF3hSbbUHgsI3dP5vCSp9F1Q/7amxbJVDl3zS86IggYjNeAdTJRSa3nSoizVulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQlHcz/siJaNFhBODw/vzA2DRIQeZbbDlRyEV21LoWE=;
 b=N8Ug73kZ+Xb7SC/FcmWg3xcTmIrctNhjg+niKq5T7XzvzhKfdndMkVHurrdugxirvxaWtenyI2oEOa4ZYxuWcM4j7VuNCBLiURoBI0JTIFcZ2ieEbfkL90BjOVqzsuSgKe9Adj4mm+3o84pzwlveV9b8HnMAviY2AAdWXpPiPJeSIHl1ZCm+/YEJisjCttx+zEfE3B1u/v/74Qf9dPfetDZeGfqgI3Vf6x7iKv8Tv3YVaJy0lsrKyTj576uN9WRcH18eFHaDlrsUdDLN0R91Kf7bnZNssDWPxa3qtBm3HO139B4vhcWHlwcaGKoGCvH3b0yYQlgEwhlGCm6vA6HHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQlHcz/siJaNFhBODw/vzA2DRIQeZbbDlRyEV21LoWE=;
 b=C44bAXcgsNdLe7ncPmptlzCzeMkPO+CGYLkTXZIz2D/ZXIZePnserYiMJcKJpNNnFmxI9SzQB6b2KIsgFonOHxPDWd71DRsR86WCdT7Ys71wSrjaNdWxvTLv9BBEcsIz5Ns4KzHU+7lFkRozxF1AN1BTIffqj/IvmQeVlqvu3ptfp8t2Zz07exOFpabSOiFJZ4UAJENjHJMs94wTgQAFiTHlcvNqS5cKo2A6Z1aAt+fQK+RiJMwsgdeWb/QUG6+WgPVtAop9RDTSrRd72G97+MWX0btGDcuorpl68GKSMXJX/gCoJVJ3LoAt3RTQGI0GJIQ+xw3HKKdhuRR2+H7n1g==
Received: from DS7PR03CA0351.namprd03.prod.outlook.com (2603:10b6:8:55::16) by
 IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 06:42:10 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::f6) by DS7PR03CA0351.outlook.office365.com
 (2603:10b6:8:55::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 06:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 06:42:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 22:42:04 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 22:42:03 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 22:42:00 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <robh@kernel.org>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<jonathanh@nvidia.com>, <krzk+dt@kernel.org>, <krzk@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<p.zabel@pengutronix.de>, <thierry.reding@gmail.com>, <vkoul@kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
Date: Tue, 24 Feb 2026 12:11:59 +0530
Message-ID: <20260224064159.49442-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAL_JsqL6+U__jOGyoZCHA1KMopP+=QoKuLC0K90rb_XJfqq9xA@mail.gmail.com>
References: <CAL_JsqL6+U__jOGyoZCHA1KMopP+=QoKuLC0K90rb_XJfqq9xA@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: bf99c402-9fe5-454a-f7a0-08de736fd624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yaGhku4IXE3JlIaGlSJwUdf793UAqA0NVn6UuhT3W5LhSRK6+dy1MTDr3Til?=
 =?us-ascii?Q?LIJEhhXsVqMaW1mOwHmftcWIUayGxcrJI6cKxgVDLiDMBiBo99f3oGHtIkva?=
 =?us-ascii?Q?LBtmTId1ATHBX5yOmUd2Wg83wDE9hH9B4MljsLnLg+ubRvcbRKsYQuyxlywU?=
 =?us-ascii?Q?DaXvRb1lMfWPz/m5ICgKqSe3F8ZeG/qL3cT9rQssqk6L8WC81mrT4Pm00LHh?=
 =?us-ascii?Q?4YxMU9UF5AxYbS9M8/8lr5Y9cnRm16fTPjO6LST7lXyjZGEl0E+6BbAeI01g?=
 =?us-ascii?Q?ZnOzzsprE9gojHpsii2gmVToURP/wmjQIYMYuSXwxAtPrlJutAgtZWU5WpNr?=
 =?us-ascii?Q?yHCkHvp8umf4CdqWliz1jZsPCHdf0tJtRCVeFRdJBBetdx7x0nFakKiUjWlf?=
 =?us-ascii?Q?yRaz03/2gtvSURTMD2uqdbmXx+UK99lLWbYiWvZ2i/Ufkr4TOs1+fOMA2ieU?=
 =?us-ascii?Q?V/nXwJKw9fi7aXd/6aVo+jzbW4R3XFtRbbArHj+NtaXyeXoH9j2XNOHDZ4rS?=
 =?us-ascii?Q?7u6/+2hoEcH/LmXf/2Ul8T00Nbnx6GoBCSSOo/ttXK20kCNQtfbw7qKTMWhb?=
 =?us-ascii?Q?u5UVdARzfhqDVXTjvP8Zu4noxxr73QYpmS3pMZF6fUm2X0rvf1o2FwKPXNEi?=
 =?us-ascii?Q?jOIwe0PIegDDPG9yPcZk1eTzdPG9YWdogOgX/G/dV0WF1pYlTAtwoBmlp8LP?=
 =?us-ascii?Q?izLbffF1Z5DNV9JZDcGnywtZMO+kZ0d0PzG7QoWVGCzrulT6mG/TfxKAjopN?=
 =?us-ascii?Q?00iU6CgoVvVBOPVorN5K14z5QNBzH0yWEWlJt1tTOyNkzOky6I7lDA5uMGxQ?=
 =?us-ascii?Q?mbNGHl2qUISRaf1RElBmszpNFYtIS4RcZ/MzK9xNfbORrAZPZToyrOfD0vAk?=
 =?us-ascii?Q?m+BP6b9ge9R7wFAZ8grucv6WQ3eB7dlUg+9wpOcL/RNJKJied3OzXOqHdDLU?=
 =?us-ascii?Q?Gap/z2TaHjAHhLGOL33HPQbkL+m60Vv/NV1F2/zPY7AMiLSnAb7kRUX5XLzR?=
 =?us-ascii?Q?wNu4S305k1sflzuWihmCNHgJOoFLjDkZHFAkBZ0wIO/Hb9sT1Cd2IIsw0a+g?=
 =?us-ascii?Q?UAzFyhvCMpjLXkyAi+6fzMIgDPqKQdOMySjb4VT1oEXZlSqJoln1Xq/PbeQU?=
 =?us-ascii?Q?0IJLGFycw/2099v/s3GZKo6kLogW10JpEEIgyDZ8GhaJQYuUXpdqzRmMxJgl?=
 =?us-ascii?Q?llrKdeHA5Z8oIaRotedI8N4knkVb4n2QSZ1fgVBO9YOvKdCl8TLN5NzHrKf2?=
 =?us-ascii?Q?4ow+e1CuxkwIIfueudGnzsF6WitZcGfMui8nyqi+7zmGD6P6w3DiZ3HeF/Pr?=
 =?us-ascii?Q?PAQI0zTyFhZXALOLQzbdShABDOpUfeI1/GtG0pdJDS3WIRm81VysUu+DGGcP?=
 =?us-ascii?Q?J8HIWjf2tgQzh88c1viWfpNpzGez9HEX3h7K/ekxVLHjk0JhxccAUUBEpoZ6?=
 =?us-ascii?Q?w5m15eLIvaWedVTzx/zDl+ihzgZoVVJtYXFaAZXV5Ejcbhws1NcPBso6jH/+?=
 =?us-ascii?Q?aOTu/QqQLyiV++8eNTnjIQYHQ7MN7/44DVZG2EqNZuky+T8NSOUTVdwRKW7T?=
 =?us-ascii?Q?ENez/H33dtLpRFdbkkQNxIaShl1Xha5hqR48u/I5T6uXAJmePdrLbS7rBRu/?=
 =?us-ascii?Q?Ywz8wk+lGaygCZKAWTE6PtyUINhWDXoCDb1Sfwk+WkPXJhJo7rerau3ksSTI?=
 =?us-ascii?Q?j2a1YA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sMm4K3aLTHkG20nA1NDAylJFfuHSz657B9vK3RkGQsFHyAYEEZAnVubN/tQp0TRF0rICxsHlHiV4rz6ivlvUjUBvQosLgVJPkPmMt5lVOEz/ZlGDvwb9kzim80sGehGGGBvJdq/nuOD8seJRZQRuxcKQ6h3gme7maw/Nu9bNpBhM+a/EZj4WXRDK31K4uTI34ZZVGacEuDWEqHIo+VkHvo/7lJ8oDyfd9tPZDCrAfum6Rw1wpbKLTutqc3MNDJZC6mT7ZGEH6gETGhWR3ZEGp2w4ADxPi5NrDVa2lFM9VYOEcAV8SXOwcFYLMQlRk+WeWsGXLFGo1xgKBKUHb9j1fL4OWczrWPXPyvEE0N8LYTIDi2w8+uLBBpGOmmFlu0vCfjH33EXoynEp5Vgt/r2AYLzh/pE6VtspnfhhQmDKpCqKnE4a457QN1IzsToi/pKs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 06:42:10.3378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf99c402-9fe5-454a-f7a0-08de736fd624
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,pengutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-9024-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9E31D1827E2
X-Rspamd-Action: no action

On Wed, 18 Feb 2026 09:49:28 -0600, Rob Herring wrote:
> On Wed, Feb 18, 2026 at 3:59 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 17/02/2026 19:53, Krzysztof Kozlowski wrote:
>>> On 17/02/2026 18:34, Akhil R wrote:
>>>> Add iommu-map property which helps when each channel requires its own
>>>> stream ID for the transfer. Use iommu-map to specify separate stream
>>>> ID for each channel. This enables each channel to be in its own iommu
>>>> domain and keeps the memory isolated from other devices sharing the
>>>> same DMA controller.
>>>>
>>>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>>>> ---
>>>>   .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml  | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>>>> index 0dabe9bbb219..542e9cb9f641 100644
>>>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>>>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>>>> @@ -14,6 +14,7 @@ description: |
>>>>   maintainers:
>>>>     - Jon Hunter <jonathanh@nvidia.com>
>>>>     - Rajesh Gumasta <rgumasta@nvidia.com>
>>>> +  - Akhil R <akhilrajeev@nvidia.com>
>>>
>>> With 4.5 trillion USD capitalization of Nvidia one could assume they can
>>> spare few resources to test the patch before sending it... instead of
>>> relying on Rob's and my machines to do that for them.
>>>
>>> Expect grumpy review because you do not care about our time.
>>
>>
>> ACK! We need to do a better job here. I will work with Akhil to improve
>> this.
>
> Anyone that wants to run a gitlab-runner (and docker) on one of their
> machines to add to the test capacity would be more than welcomed. It's
> pretty trivial to set up. The only requirement is something faster
> than gitlab shared runners. My 2 machines are M1 and M3 MBPs.

I did not realise that the system I used had a very old version of dtschema
where these errors did not show up. I do see them now once I upgraded the
dtschema. Will fix these and test them in the next revision. 

Regards,
Akhil

