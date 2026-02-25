Return-Path: <dmaengine+bounces-9056-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e1XwOJrInmmnXQQAu9opvQ
	(envelope-from <dmaengine+bounces-9056-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:02:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 694031956D1
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 485D13003BE2
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 10:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F211F33B96F;
	Wed, 25 Feb 2026 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EBlSKKCW"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010057.outbound.protection.outlook.com [52.101.193.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DDC3242D8;
	Wed, 25 Feb 2026 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013706; cv=fail; b=lJ55X8h0Xl8hkbyYzmVGdlNGSxcbkTVZwzJwtNKwQ47sP4vfO0aTdGCuJiXlW8cXHNayqkVtONW25NEiGPyvrlw3qx37g/+Tclr9O9RVffH9WdmmSD2yhf13Db6RVJGloerzk1lHii7h6Dt5l/ZS7/FbDA2FuB0Lltc+bJI+qcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013706; c=relaxed/simple;
	bh=4dTEJMpeqyCexGyMyW9Uj1M8i8nxQjZ+tx0sJYh7beA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iN4LK0agOaquZpkvt0jD6OXccVrqORw2PKZgsLP5LA7a4zVcSr1iZPzvTWTubMlBuoh7s4TOkwHsIfrKA0FhZqlmi71Skfd9j7mRmWjr8k0Anx/g7KzSioNPEAumlG1ViLNR3t2o0A3tWnbR9McLT76QqmgMRaJk8pSlym1Q6p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EBlSKKCW; arc=fail smtp.client-ip=52.101.193.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLQN/GFdPm8RXz99kqzUczYaInVIMDdKiL37M+ZKfxpJoxk49yLFY+n54aPpkzavlUHpRWnNeLyyfbHiHsBIT6gHO+erB03HEmw9Shxc+YqHcam2PnqOQ0rsLGLhuFDcdlLbAx7dcKZs/flLzLB55Qrxe5cEOanp4ght5hl7cXjXB8Z5Msc03doh+HImwTFZ3tqvA0HL8/NbAsXfTY3mSriW37mq6UsC1vYb9yM629HCY+QRyiW2qH6IYnjmNQH9YsKDxj0WD2v0WQrjLRlSzaNV8nAwVnjEmE+7z73vdbYkkVzk/IHzk8RBmRrYEgMkpMazs8vdjoo4SuGOfv/Xsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdjBAVUntiz82CIzcRTb7GjGMlUSXdNa9qlzI7lav3o=;
 b=tk2zGmBwMPlqZnl6Wo5XyoLRODAqohnGezqQWKpr5HY7bftlbbCl7C/lrtLGea+XXJhClR2P31qjoQnoYioPQWXGUP5qTH1A0fwXmvgY8mWg9/YtBsK0EuE5lvkaiqu0pebK2XOBzlNGnrYLfqtz2yGP7mMG5ZOUXJGxFRxc+UYrrI4aCcBnACagZUW/5xF4fqR8tu1svDp9jAjAPVaziQF/UUix6MyP/2NExsdHyeYr9HmIXeCu4UulrE4gZ9QQBBXr6RtzI/3InI9ggCjCxuHwQARVCMRSrrHUGDo3qyiE/f4zoxMQG9PYKF65BAPq6sCtbl03OoWhMQbBjy20AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdjBAVUntiz82CIzcRTb7GjGMlUSXdNa9qlzI7lav3o=;
 b=EBlSKKCWUfeFPtQdB4+Amv+cpCiQZBkwyOahEuDp97GXXi0csVP/Y3rIMONNVFq01eDJnbyTFZHa4g8x/qYRk2K5lt8z0GsyXOmT6PVHLLYBnyscBK4zwRYjUZTW82aBwmwLSKeABXjQMtEVSRSx0dzeQyqfp9ytZa4YWfyUOXWoLEjU67a50lfSpMEtpteKwiXO9IRP2EUkr2PC4Rn9kZ3AqhfTuZAW4xoVFFqXWUVU3sppqGtqM1CGbrxrI84OKRaZolhElsl3dYkgi4Qer0DruNKLg1mRD6KTfLpuHfuf6+aeWN/XdKt9T3MfH2fCKCuXDoScF8HutBm074PVUw==
Received: from SA9PR11CA0019.namprd11.prod.outlook.com (2603:10b6:806:6e::24)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 10:01:41 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::44) by SA9PR11CA0019.outlook.office365.com
 (2603:10b6:806:6e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Wed,
 25 Feb 2026 10:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 10:01:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 02:01:23 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 25 Feb 2026 02:01:23 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 02:01:19 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <jonathanh@nvidia.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<frank.li@nxp.com>, <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>, <robh@kernel.org>,
	<thierry.reding@gmail.com>, <vkoul@kernel.org>
Subject: Re: [PATCH 3/8] dmaengine: tegra: Make reset control optional
Date: Wed, 25 Feb 2026 15:31:18 +0530
Message-ID: <20260225100118.45523-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <e7944c01-5ede-445e-94df-ce1006414a0d@nvidia.com>
References: <e7944c01-5ede-445e-94df-ce1006414a0d@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b10928-a342-4e28-37ee-08de7454dfe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	woAyBjiu3E/9YOGZUZgpuQBb7ViSSf7LC2FpIk8aG0aH5XhcO6sl8f1BiycdZiTldvyDSYfb+uMBQIRI/5Fe5QFj9Fcj4DA8PU+52B1QrT32+AdexR508yhYqtKrxNI2zqDLbcEHNX5Fe2Pe7cVRN1kxoK7AWY4iFXza9FULr64JwhqW5KJIDXOhncNlnOhpvUHsrd+CvmkrCzQrY5XVQJVUrd/Xj1B7S5BDWEQQ+UYXds3dXcYXigbqe+jXWHY9XAnzxHsxz+GShtLR6VOKNR1ywjPGroPH0qJwbqgJuAwoIWNeh2+GKB9A8CwyDsGTeTK8OslpS9lHGmz3fVqGefSj87+f0EUQ7vgNZeSsnSciQuiOHAXYPo7McHqXxt+6DvT8uWgfZzqoCPQ4v355na2RK52ZnpDGHb7ncF0t79qdeSlTRTGQMnhcVeL1XH9SIcfQRj56TD0KeWCQ1cZ+dw1DvPFH7+Uo/pjp0IYlpbQZY+Z1vcH+oIuDv2e2eZ9E6wiF3WcuMkrHEefsXDblbOC+XJTvdM20dnmmLEswQtzHXiSGdKuAbrZtTpuWJGJl7+VJTuvgV1IAKPnYJCkPnUJntgE9EoG9sXLQGkSbb0XYecCxEXByaaqXvF9LFi0gsntUv3QQ5FIphVTMEnFPL96F+Hqwr/OHm6606SYw0iddnTFcSXaLcSlo/7olEBWlIF3czP6wpUWPa3yzLaSp2B9i3FkbUxEGKrXh5HFnxbyG5L+UnunxCo03xy8x2Wq+Vx52VDSgocI62hb5Nq47ix02bG39P8BCtFCxeQ7cnXtLDJL5KbbrWW+gxt46xO8+KlETt/Ja06U8x8ZquvS/BQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rbVigkUwzXt+B0piruR7F3Qetus0Ypb2iUqkz4uNn1ZBvifyAaj/BJVT7l2azJJ1qMup6SR13WEj/t36Y6kgkh3T6zCUBaVyNpu/V+msuR01a2hcoKRjNMPbANuMevc0mjKFfntHM7x6udUzLA788u5MGaqYoTlZCNZW0DarE3z+GFItYmLqrH36MYYWtjyiYKMzvicivhfTgAyjiNwqNp3lkm0LacomuoG0vW6roo1smpq1xHY4we//iomzudf8LnyDjmB797j7IarXIe+n8r6pge0mzhifzaQbbZyyLppjb1kLt0tVE969GUHvnJwjRZGn5EMZvuW/dXqk9Wd5DFatW2qm4QdFkWccyX5fLEvX7W+s5oz2QOco1cjGmogMfiJXtMb3686lED7lMPucQBFy6PDBT3B9649mXB6L7yboLBbNPyYSuQdqEKzwmgKV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:01:41.4260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b10928-a342-4e28-37ee-08de7454dfe1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,nxp.com,pengutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-9056-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 694031956D1
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 17:02:24 +0000 Jon Hunter wrote:
> On 24/02/2026 05:39, Akhil R wrote:
>> Hi Frank,
>> 
>> On Tue, 17 Feb 2026 13:04:57 -0500, Frank Li wrote:
>>> On Tue, Feb 17, 2026 at 11:04:52PM +0530, Akhil R wrote:
>>>> Tegra264 BPMP restricts access to GPCDMA reset control and the reset
>>>
>>> what's means of BPMP?
>> 
>> BPMP is Boot and Power Management Processor which is a co-processor
>> in Tegra and runs a dedicated firmware. It manages the boot, clock,
>> reset etc. I will put the expansion in the commit message in the next
>> version. Do you suggest adding more details?
> 
> Technically you don't even need to mention BPMP here if it confuses 
> matters. We can just say that for "Tegra264 there is no reset available 
> for the driver to control and this is handled by boot firmware".

Ack. I will update the commit message.

Regards,
Akhil

