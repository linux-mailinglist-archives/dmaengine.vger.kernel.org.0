Return-Path: <dmaengine+bounces-10226-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIGvOLW5+mnASAMAu9opvQ
	(envelope-from <dmaengine+bounces-10226-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 05:47:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D4F4D5FD8
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 05:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3D4930208BA
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 03:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BED2D46B3;
	Wed,  6 May 2026 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dT6Y2NoE"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFA21391;
	Wed,  6 May 2026 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039218; cv=fail; b=OLqlK646WEL7LP3RVHhCT17dVzlvxLDEloz/YQfL8jcMg5Pf06pys8snUrkCBCcEm3TRQogElABAbU+70DnorifjAjrc04FHgxjlsXY4nsdkZQnBvOWKJ+8cx1iiy+Kb32ihRY0FN4hU/DRtQAE0nThaFScuabe/wGhhFGO7hS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039218; c=relaxed/simple;
	bh=czmPJHQIwu5wJG2gjyrNsLw7GPC2PRBkWOb5K0AAvRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4yOi+cwMYQ0jEPL2WaOWS3iw/0Fu9DFhMH/1vCbI+t9E0tI/InjVf7u5bkZcz9RWP4UVHbRBVlUtpaq/qx5P/4u3dWZlxNldctxfWIrphNsUTa903SWS8f7zT8IcVpWdvKfVdwaR37TVKO6ciKJcCM7FkEETzjoKF4Xom4GXLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dT6Y2NoE; arc=fail smtp.client-ip=52.101.56.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEc1xexwvHbbHbxCVZfucrias/AW6SVgaGka95EOAhacrfnW88FSeawEo/IIpiD7yDJuLCIHmhCtpD9p0shddYngXJZQk5Ctj7r1KG4OPAi8mnfT+16fspGYaEWtXLhGR9jHXV8B9Firgh6qnwmHwvCwUu0hVUo/Kobwl5xufJ05NTSaA5+qV/HFxXci7h8qpq9liXyB4ppYgTVMZ/11TIlCp7TviCFjkE/gLriuMjfryvRNQNii777CgPyRf51RvbCOBZsAImiqYoenWyxUHrWi+94bJyRgpOe2EfRgC6MJfD3oHhUPARqB3+cgDHIsb4uBI+8X6VLy07L1KNPrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLIzaWQ1X3z6llgUT4MTENe/R39UqKgDW3//75/BEmE=;
 b=rQcrnTdH9f41NeiQN3Kb0L5JsLwLXKSMv8qpuVKlT+189yMjUVkSh6Snvcf9DFHGdf44swnWwoDkUKLi7Lf4rFvjMZCZIVcrxsB1eDy1/QdUL/7mFHCWyEN9doD0XgV7EyavJjn5HarvpkcejiHs7gyuppqGV9E1j7MYov1meVzWfXeLb5LpAasMDhSteTK5X0ATEGT8d8GCEyA7IMCEU5pSp8x4+KuJ2emuubJnM/b/GndVN6y0lO6VVsnoR7GAT15mNmBRQoCTNHCJ07TvP47wIr3YMIKuTAOjwVHnVWtd4RPjF0aZr+HFwBlwPJKEnYkbg4BFQqSdNEVNFWF1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLIzaWQ1X3z6llgUT4MTENe/R39UqKgDW3//75/BEmE=;
 b=dT6Y2NoE60v4ccAO+XfXfljIEp56CMSoGo3lXlL8nhbDxpYwO1shrFfkvdwEGKxnmFzQfQgr0qQc4XP3ehYBZXFxqb/EmLTsH/oRw7o/OiNLsKjGjQOuUuuV8isMV9D2I7v4iZUWhdmdIqNILSCjqKV7UV4fkNqidNBIrd93w+uKA1zRhDNjan3PDFGOx1FGb5l4nuNt18MIjgMl1SXQuTqTXrUqGz5ahUDOXCkMTbYQT0Pir1NGR896wlejKktbtH3BDY8I2WiXQZ7oUkE3PxhBSYAOEUW0yVvFwcd+mzouC/E6Qyw3YC0pbYvWmXDvZpj+WGqneIUzXnrz8io3dA==
Received: from SJ0PR13CA0065.namprd13.prod.outlook.com (2603:10b6:a03:2c4::10)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 03:46:48 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d9) by SJ0PR13CA0065.outlook.office365.com
 (2603:10b6:a03:2c4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 03:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 03:46:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 20:46:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 20:46:28 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 20:46:25 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: <vkoul@kernel.org>
CC: <jonathanh@nvidia.com>, <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<dmaengine@vger.kernel.org>, <krzk+dt@kernel.org>, <ldewangan@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<p.zabel@pengutronix.de>, <robh@kernel.org>, <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 00/10] Add GPCDMA support in Tegra264
Date: Wed, 6 May 2026 09:16:24 +0530
Message-ID: <20260506034624.18782-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <d548278c-8bbd-4871-8fb6-e22db1688546@nvidia.com>
References: <d548278c-8bbd-4871-8fb6-e22db1688546@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: ae932bae-02d0-4e18-e0bd-08deab2219bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	43bogO3sCKgtTi1MQVuNKSRgA6zlN7vdq/s08EzCARcqL0fclYv79MyubLY8T9bNziGQFkVC1m6Hxa6iektZo+sBJguubtFzqFwdiaPhOvPoCcTm3ycAFeHvbCPygtwq2naOAP+QEfSS3NcKyEz1VFg7M6y/5rGxut3aFXb+q2pphOWPmhNtFRb9THUUjs4PbeZ7sIE4TETD6BtsN/IhgL2LIFEPj+CCfake3VHy6MMFdXNGhy44s9nn+OG1/XiN7nQFaeeFkil1Oz1z8TJJW4pOdVaxxXsytZN1+0w2DBSZnSLAB8NACA3I8V0c8KFGltRCfM4MqpT3L0mfZYsExUaiArx/G+VXofk3K7zm55LYaIW/frUn6l9y2XmxiAhbsHiqqSM0cEXjauXoRnQ+PrTutO/VGcpir10eqkQXFOM9q1WERd/qBiP0lujFNPeLnnff0Pl/GhHIflZ9lGp306Lu7Nkfc3upFcc7MlGzdByhPBzOf1AefgbXAQQN3cJ2L1mUG+L8MgT81DaPwEkVq5ASlgp4IHJxrIB0MSBYmsaIWSxLr9fkt6/hjww8lLwUbXjrsjupLCeznw9XXMyJXPFR5KVc4gab+diXe4/HpHJ21eWnEKYwjCZdi7Q4O12dT3O/KWxPXSlT6Y5XzEbnLkW1GcP4W3hQEaGIMta/80fx1umagHqGK4KL6dUmB2RSXNHfGw5H6fV+8ama4eAF18o+XmJKCWY6YnVbkzUg+s8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YgoDTsc5FjZWhz/LyyrPzVVmgY2ZGO6cNTHr5eyqbswyZ7E6dhxNVqQPupRFS7H1pUUFupeQNIQb55cocSNYJfCeL7ZAiltvhBdDlN7rsxAIzwzZwt0TbOLrkLoNUUmrVdxcBnqGuG6mfQie1MG9o3NID3vNGrffiWGjJ4OWSaWQGQoDUVuAUonBECD4E2g3ZaZEtL6ZsxWN7dHwlusWqH+VfckMumnPO0+a6aaQbtfYgLNmMRBFFowdaq0RBQS1lBwJ/Kp5J2IEduBN1jfjDeK7zAGCiq/jhVMzMWu/00Bp2KbxTbWNXNYmDKnP6UFenH2YEbjpGIZ8VkOuD4zqcXuceKYGkNi1F1kWUUFKZcg8JXXwwxuBQWSyra7Ap/kohYyc9sSPaITKzL0ipm0f6PybZG9ByzgHwiCF+NhugWFH2AkZsl5el7Cex+BvycQU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:46:48.0814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae932bae-02d0-4e18-e0bd-08deab2219bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
X-Rspamd-Queue-Id: 88D4F4D5FD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
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
	TAGGED_FROM(0.00)[bounces-10226-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,pengutronix.de,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]

On Fri, 10 Apr 2026 09:09:38 +0100, Jon Hunter wrote:
> On 31/03/2026 19:06, Jon Hunter wrote:
>> 
>> On 31/03/2026 11:22, Akhil R wrote:
>>> This series adds support for GPCDMA in Tegra264 with additional
>>> support for separate stream ID for each channel. Tegra264 GPCDMA
>>> controller has changes in the register offsets and uses 41-bit
>>> addressing for memory. Add changes in the tegra186-gpc-dma driver
>>> to support these.
>>>
>>> v5->v6:
>>> - Replace dev_err() with dev_err_probe() in the probe function for fixed
>>>    return values also.
>>> v4->v5:
>>> - Use dev_err_probe() when returning error from the probe function.
>>> - Remove tegra194 and tegra234 compatible from the reset 'if' condition
>>>    in the bindings as suggested in v2 (which I missed).
>>> v3->v4:
>>> - Split device tree changes to two patches.
>>> - Reordered patches to have fixes first.
>>> - Added fixes tag to dt-bindings and device tree changes.
>>> v2->v3:
>>> - Add description for iommu-map property and update commit descriptions.
>>> - Use enum for compatible string instead of const.
>>> - Remove unused registers from struct tegra_dma_channel_regs.
>>> - Use devm_of_dma_controller_register() to register the DMA controller.
>>> - Remove return value check for mask setting in the driver as the bitmask
>>>    value is always greater than 32.
>>> v1->v2:
>>> - Fix dt_bindings_check warnings
>>> - Drop fallback compatible "nvidia,tegra186-gpcdma" from Tegra264 DT
>>> - Use dma_addr_t for sg_req src/dst fields and drop separate high_add
>>>    variable and check for the addr_bits only when programming the
>>>    registers.
>>> - Update address width to 39 bits for Tegra234 and before since the SMMU
>>>    supports only up to 39 bits till Tegra234.
>>> - Add a patch to do managed DMA controller registration.
>>> - Describe the second iteration in the probe.
>>> - Update commit descriptions.
>>>
>>> Akhil R (10):
>>>    dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
>>>    arm64: tegra: Remove fallback compatible for GPCDMA
>>>    dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
>>>    dmaengine: tegra: Make reset control optional
>>>    dmaengine: tegra: Use struct for register offsets
>>>    dmaengine: tegra: Support address width > 39 bits
>>>    dmaengine: tegra: Use managed DMA controller registration
>>>    dmaengine: tegra: Use iommu-map for stream ID
>>>    dmaengine: tegra: Add Tegra264 support
>>>    arm64: tegra: Enable GPCDMA in Tegra264 and add iommu-map
>>>
>>>   .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  32 +-
>>>   .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |   4 +
>>>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      |   3 +-
>>>   drivers/dma/tegra186-gpc-dma.c                | 429 +++++++++++-------
>>>   4 files changed, 284 insertions(+), 184 deletions(-)
>>>
>> 
>> For the series ...
>> 
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> 
> I am not sure if it is too late to pick this up for v7.1, but we would 
> like to get this into -next if you are happy with it.

Hi Vinod,

Just a gentle reminder on this series. Could you please take a look?
Please let me know if you see any concerns.

Best Regards,
Akhil

