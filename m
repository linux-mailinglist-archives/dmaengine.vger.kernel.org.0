Return-Path: <dmaengine+bounces-9207-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA31L4SepmlqRwAAu9opvQ
	(envelope-from <dmaengine+bounces-9207-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 09:40:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A451EAE43
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 09:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADDC83034B02
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BFE387570;
	Tue,  3 Mar 2026 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CML67w9c"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F237AA91;
	Tue,  3 Mar 2026 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527232; cv=fail; b=TauQKtOXUxEJwbOKLN62/Z0ZwvE2S3JR0d75UcZOCZETrWPdYoVKngHT3phjTuwAn/oT8zeZQyB7WU5naCV6F/iIpRk2+2i5qEt350CDaKMy8vzvflSnokzMPwGBruFnxw3Ig8opT5YxXCgZ6gvDslZ0zWBexjgEUi7OnXjpO0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527232; c=relaxed/simple;
	bh=ATKIgvpgFTRDSGD77SZ1RgeGghm/0EODKh9vre0Bhqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlQnBN2+Vaqe1LAEgrImy/yKNhQuQZKQHJTYA3HmSiWogF9h9pwqVIcNOFGhcWuFsjNRVysOo/Q71I1hZBpL4me/HFebeEhlUy4r0f32PvcMeGrTP3/5fwoDA8SLd1BygGGYy8In0jLu390QybI2eMkqbGg469L8+hAr8k5h650=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CML67w9c; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+H8wNS7rl9jr/RbH5RfaDmXFZpDTqb55cG695OWAPWDTMyfuVCPwJ+t2w4zPKjo8CEpoNMS5UNnRgMXHzgmqbPpCvcn0bertkJCP5P0v0zybVObyBmBnss9yczss6CcfEWnrLoqEQIGzvZBU03MNTax+BZCIY2BiI1oqv7ZREbcacrM7ZyKC9EaWTxvVRxRcxP4Sn/KLq/2P3f+Tr9OjmCdFmpYvXPuHjLipWrMlnuPHZB50mtbC4LGWcpWQUCHd/VBMCUM+sKr7U0UTCDhrAOan354mNjh6JlwJNEa/KphQvALwVqyHucFBG0+Vj3D1sflzZBLH67BbJovdJs0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DM81Fe7oRPzqU9tNgTRvyS/pUwkY08r6FGvFR0Pr7a8=;
 b=WVduP7h0cTdonR4JvSnVn0UfE26DbtyXrayfjOqvYPiJHeKZMQopXrdvb/lQdVmu2sXpMkq5NG0HO9qgvUXeIxEt4kb3ksHxU8Gykq3/l4Ec08YAgJlezUOpoLjDZ8nUacFFGLSD3Wa3hwUv+0ziAKd1ye+Z78PcBJCbBqcSMem6a2J8ao8AaXPrJInhro9APyAaem9Kmu36wFKxW9ww6hcTIQLPfqBr0nzsKqPXd0qE4bofu/1ijIm8GdiQI/g0+Rqyso9ToNqkzx+rJ80I8AUsj8jmYYiLr1fZctSaoPtUQjC4Qh/HIm47/+xDan90nAZybAu7EfXpyKiEF5+P9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM81Fe7oRPzqU9tNgTRvyS/pUwkY08r6FGvFR0Pr7a8=;
 b=CML67w9c2Chf2IAKoJu5Qgfq7IKsoGKCWrRtn/0Az6TdQxxAURtVxi9oYDplT8T8a879IpD9xeoVEQxg24lT3DSD69oSFxy/TBRufqyKVK1V7zHojQcCZs0GClyl2GJnvD5zUjl9k0ekzAQlEHnCntN5dmKvl08ipnmJsV0aMOf1OL2ID8JP9jv9ZnQq5yQGImqRkZmwAZsHK5S3Em4cTsOzj9M2z3mIVnzXbn473Y3Uo9L2nxol7/kphGbPhZAx4mM5beO8vUxqX5TSl7HQ6waKJxWennVEo8LRnGnkdOJcx3TW/+MpWklHLAMO59ziLCb/nrwadCRNuihEBNENbg==
Received: from CH5PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:1f4::27)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 08:40:26 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::77) by CH5PR04CA0011.outlook.office365.com
 (2603:10b6:610:1f4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 08:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 08:40:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 00:40:11 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Mar 2026 00:40:10 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Mar 2026 00:40:06 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <krzk@kernel.org>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<jonathanh@nvidia.com>, <krzk+dt@kernel.org>, <ldewangan@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<p.zabel@pengutronix.de>, <robh@kernel.org>, <thierry.reding@kernel.org>,
	<vkoul@kernel.org>
Subject: Re: [PATCH v2 1/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
Date: Tue, 3 Mar 2026 14:10:05 +0530
Message-ID: <20260303084005.57114-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303-famous-fearless-asp-1240cb@quoll>
References: <20260303-famous-fearless-asp-1240cb@quoll>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 3986aaa2-a2ae-4abb-6722-08de7900849b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	y2EwmDweduTCs4pwsP9q8NbZ/Iy2ER2h3llXEigQM4LdvzyDy0YuH07G5tISIvB7Vhbl27rj1rllDyDWKvUrs3Aq/txewgsacmFGZU1nklyxPDInfvt8+FgwH5asxy2eAQJqcENcoS6GyL7+ZFx2YHpl7cjuw4gO+zChnKv0dP2vEdcnaRKDfl6wLAsogjSgiQdjXwNYBm/utreRqVWJ5C4gLCp/9eLbEGx0gbFtCnQ2M25mmlZfoW7TInAGjUpf3Eol/iQQolVRoX3G67KEE/hfGI7gZhwidjAoU0Bk2XPjgOVItiXbDm16Wc9EEyeoqTVvpLaC+WmKxdRW5FDvtqsT4hwbQcKE7fHzxx3yWxN+iwgAoKp/pvGyCECL7JDTYL7hr1A4bAkv4colF2okjBmizNJAhfYfe4Q1d27JG5HPVoS882y+ZWpI48pUiyqStPH1THUwGqlBD8ePQ4/IRyF+N1xBs9G1abJR0du6ie/qy3bE05bQRPTtqB/9i/aLOEZn10Hlki57tODa3DT4vdE903QGO4fI1Fa9YDWHpf1sbBRQcmU2EYzVj16Oca0MpAeGmeJzPcVYRG126qizNC84FYH82DSfMD5a7z+16VGXnT1ppGrpb+hBUXg95PyiKfrGpmCsGVa0/5IqTkAUi8biHcKohkQULk9V9PGHd+TBTK/iglBQlQ6bw6LsssVzTsPpiSD51EXFH+5HbXPl/94rQDFl5vVpSZTVZjF/VkOjOnG4pjqrdCCgaItsUx3Ztjh2V8BZfgQ3BJJJVguHXuH9mZkXxo3jpYGc2WOvcld+eyW6/ZQvjXrWA0MtZAT6akSMjDdkN816MNRpQ1f0Rg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MsD+McB385vxu8tbIGwwTnuM7Fv4IFuqbHKmhnstUd+vTmrJBvicaJdFeCvOtAh1Lut0qPKjphEv/KzlEVGCdC/oA9VFIGf2wmoagQlvrjcVsHOJw5kxTmHSIkJugQYGCzp+aEgdd1U+3Bo4FM5HmmlpkNaExaqcgQtI5DFOYkaQIlRTiNgFkjSn5yPuuJuOqd2T5WQZy8uHwDNHDgFm7x2VDmvkeXM5dz0Wed7l3ixzrReIPYW9nmk9hiwwyfvdQDdJbCulYCX0WK16/a8tpz09NBv0tukLboGJwOU34I2M0pr/cl3zRuKN5FOKOiUeA0rPY52Su8x5736eU4IkVXRQPflHvUmDvCxrudrg4mGRNnPF/KxplWfQOiMl3ZZZYuQK+zcEqgTonZ7m1V507zps3ucaUIjaAJAnpy+pFO6Dtovmmjdotf3qLilR8djs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 08:40:26.3257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3986aaa2-a2ae-4abb-6722-08de7900849b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
X-Rspamd-Queue-Id: 62A451EAE43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9207-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Tue, 3 Mar 2026 07:39:58 +0100 Krzysztof Kozlowski wrote:
> On Mon, Mar 02, 2026 at 06:02:31PM +0530, Akhil R wrote:
>> Add iommu-map property to specify separate stream IDs for each DMA
>> channel. This enables each channel to be in its own IOMMU domain,
>> keeping memory isolated from other devices sharing the same DMA
>> controller.
>> 
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> ---
>>  .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml     | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>> index 0dabe9bbb219..1e7b5ddd4658 100644
>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>> @@ -14,6 +14,7 @@ description: |
>>  maintainers:
>>    - Jon Hunter <jonathanh@nvidia.com>
>>    - Rajesh Gumasta <rgumasta@nvidia.com>
>> +  - Akhil R <akhilrajeev@nvidia.com>
>>  
>>  allOf:
>>    - $ref: dma-controller.yaml#
>> @@ -51,6 +52,10 @@ properties:
>>    iommus:
>>      maxItems: 1
>>  
>> +  iommu-map:
>> +    minItems: 1
>> +    maxItems: 32
> 
> Why is this flexible? If it is, means usually items are distinctive, so
> I would expect defining/listing them. If they are not distinctive,
> commit msg is incorrect. If the list is as simple as 1-to-1 channel
> mapping, just add it in the description how they are ordered.

Yes, it is a 1-to-1 channel mapping to an IOMMU ID. The intent of making
it flexible is to allow non-consecutive IOMMU ID assignments as well.
This is particularly needed in virtualised environments where the
hypervisor may reserve certain stream IDs, and the guest VM can map only
the permitted ones. Shall I add a description here mentioning this
use-case?

> 
>> +
>>    dma-coherent: true
>>  
>>    dma-channel-mask:
>> -- 
>> 2.50.1
> 

