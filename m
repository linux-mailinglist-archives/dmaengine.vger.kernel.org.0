Return-Path: <dmaengine+bounces-11214-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QTe7LnBLI2q6oAEAu9opvQ
	(envelope-from <dmaengine+bounces-11214-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:19:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 004DC64B9BB
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:19:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=QSV4P9sU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11214-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11214-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A29323018D59
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52F5384CF0;
	Fri,  5 Jun 2026 22:19:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC9233134;
	Fri,  5 Jun 2026 22:19:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780697965; cv=fail; b=Zh8/2i1RArkSi8YiHTwdSqr2t7nFK9+zNEFAAUVVZmJyEuFD3aa8vQP83r/1ni9lmRqAKJ24NfESGY+AgZw1MN4z//VyUUaZxkxr6/mGKUEBZpYGWPxYuUDb8Ssi0Vx2dFVsVqD0alIrinwSX6BSh6FuH98AXiKDAyBluz2HhpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780697965; c=relaxed/simple;
	bh=Beupt88INTsnrtgOfe2MPnznkNRE3tNDNAed7dxGkPs=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oKHvx+Fn1o7hY+HrD6i49QpDDv2A3ljTs5GIYIwK7jKRs0kQor5sjswVJjr24uxkTpI33EWL5QTdIDVy+4I5ttkKnSG6dewEzEY2SWM6+5yljM7Tx7EhvsAiA/EYpNB7UgmrxcWzdqUzXvDtAdZo/2waaLeW8m7kbNGqXuwv9ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QSV4P9sU; arc=fail smtp.client-ip=40.107.208.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT6WeHgOifB0HoX3E59IsNS1S7bVWTVemP1zgLK1IQDmc1VY5Hty2quFeLeBxZ6HP061xurQt7koR7UCKsgdAl5q0bN8XwXR+HbVpy4tkHF/Xsowhb3A3mLWgmrPc4o7Fy1OfszaXwx5uYLxixIklEAEEtiLbBeXCXSpMGfqq7uAx3x+IN9GzU2i7UqtcwKj/i26WI58iMMbvkchV+i2s7/kOXlXUEglExoGr0jHRUXBuv9CI3KzqeGnskC0bKlTCa79ckGNIy1/C9weELO5Q1VN8GkocE6hNT+v1D0s0zLq0MP4fZLQa+DAhArcFGP6DyAx89y9Tu1k2TqmME3ReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR7ENMnFMXVW6tQYaX9OKrKOr54AK1Uhbg1HLwf0a2g=;
 b=FjSqZG1tPhQSAMVoUYrWQNGCYupWylFMUfyrSR4wFW3M5iT8KZ3V2kUA/Hr9EBrBRhivwwJ3EhqNLybg8+58JjZcqelPVOxNAuNWyEsy4Ny/Y1WmPQ+/IFOXLzRl2D974u3Lu3Gg6TICPOId/yHbLYF7Z91pzz3DE+bCPXmH7XcyVl+ptwKIuBSDIJ/pp/gHF9LkwkiZEMBogV0V/W2tNAIv+TI0IP9vGq9Uqb6nPZhWrG0G6tGXF9TdyeXzUQzaA26a4daLmQay5EriefBzCh+kVxjb+l3jUwpMRc47U4ResJFQLI5VPenJLEqIi3O3SPWfl2XOc1fxuykWKXjHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR7ENMnFMXVW6tQYaX9OKrKOr54AK1Uhbg1HLwf0a2g=;
 b=QSV4P9sUPwkce4lTGMslZ3TLANg8Dfpp8C4WRqodxYzaxsoIGcWrCtsBxAiNGHOBgPPNeR5jbkB06TO90m42TSHquwph9n0L1Nx1Hk87b8XfzTL0RxnpPTXkDv9lUJh2Sz87qFqPQAA/tRMYvG9JTapcGepebW2DQKi04HYM+rM=
Received: from BLAPR05CA0047.namprd05.prod.outlook.com (2603:10b6:208:335::28)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 22:19:21 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::2) by BLAPR05CA0047.outlook.office365.com
 (2603:10b6:208:335::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Fri, 5
 Jun 2026 22:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 22:19:20 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 17:19:20 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <Frank.Li@kernel.org>
Subject: Re: [PATCH v2 05/23] dmaengine: sdxi: Configure context tables
In-Reply-To: <20260513011220.DFC94C2BCB0@smtp.kernel.org>
References: <20260511-sdxi-base-v2-5-889cfed17e3f@amd.com>
 <20260513011220.DFC94C2BCB0@smtp.kernel.org>
Date: Fri, 5 Jun 2026 17:19:19 -0500
Message-ID: <87se70d40o.fsf@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: d01eb7bb-f085-4c41-49c6-08dec3507db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qm4roQ/jXOHWDC+qBJo9GIOWMCU4FnByTjKKAXzuV0Gaju88A0NI4KlKF/tpi90rdj4QbfENClLfxJSvX5tvaKymbhNyfynqVwaQHqHxsZMpf+sl/4iDRiurnTEVRTAZqegi+d9+gZ8p9ymuBH7hHQDdrROgk54mwrq1WRC92mpNCYSJ85hXN/eSnpfEp9TyjEiJ799QMz2eOknEgNSt9DOjIAWpsaJd/qorkd3b+0ZGgTs4ZB3ZmkjwiPdekEqut2poYFPai+NPGNoYX+Gkj3exji6kda+Wp7YLs+CBlABp/ll6l7BAUYbaLHdFBXSyR4k8wOKgW8nD9RSNMD4ihKFZP8yt5xVcdjJE5q7JVbMPA/mzvA6z3PdoIXr98eGMwrJTrDeHv8sK5TXTszCAz6IC7u6vWLrnYdp88nrZJMzi1yjYNShgW8dMOgrDs3ZFplCtwZAwwTCU2YmZ28qGdl/DAJ8hXuTAGbSJ7rSrmEK6+bLsjLP0nSoUrOeh6lYf8CeUQtc/exAQLkcO+xJfkYDq4P2k4199usTZ0Qx5j1GMwgc9lU1Z0/XHWcTWcB3gQvFD96MxgJMMg5kqMhYHX9mq7R2OS3U6RcSpVU48Ttvl+hIHMXnwF002+4uGTsdS7DX2OUJQw+rqO14fVf91QTEIEcztbAnDnV+wAQhbfgAEPTiRWg1Vb3qAQrifky4YmtW/0ozuAb8XKkGx6hL+FAZdMLJf5vIcClACOC+W1Ak=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uoSyVwNx/i7HrMjcDrj4cthOV5YT8TczYYVuNKkhFlFKMXjpqkR7YgWuC8FXTsbHQfHKcIf9gmAAf879l8JIyDr21llg/qmqRt23Monx14PX5WgAsxGZO2WbomgZX7yGWyAYH4ffBnAZTCpdwBEoS6WM0Nu6Sdl/NC9yoOfm0IwDJsUgKMhlbyBSuPH88YwgGU6qSdcQ2fLTGFWXHwTkp+CMAYkcsIXXJiPg1ggpvn2Q9MUzZjntN9c217dSrQHeiaYS9TZSDh+RGnMD5+fp+4kJCoafMtXUkzie8Y0XNTVHuqs7NAqdhcHzOBstIxhlAIwJrPxOKAbmZcV7+ELiIQPXg6btK9mLVMm9Yj1Y4kyBsVrVwLguj95xd6GoMjpMS7hM6WwpNR4hag81igVESZAu2dtvV3zSntrSc44LSIP8iuzmuT4Qn/DsvWMNm8Jm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 22:19:20.6594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d01eb7bb-f085-4c41-49c6-08dec3507db5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11214-lists,dmaengine=lfdr.de];
	FORGED_SENDER(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 004DC64B9BB

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Premature programming of the L2 table base address in the hardware register, leading to a dangling DMA pointer on error paths.
> - [Medium] Unnecessary and potentially harmful `__packed` attribute on naturally aligned DMA structures.
> --
>
> commit 0a4d9e9c9ca24875b4f7b4512a3bf669c25c0595
> Author: Nathan Lynch <nathan.lynch@amd.com>
>
> dmaengine: sdxi: Configure context tables
>
> This commit allocates and configures the two-level context tracking tables (L1
> and L2) for the SDXI driver. It allocates enough space for context IDs 0-127
> and caps the maximum contexts accordingly, using devres-managed allocations to
> simplify cleanup.
>
>> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
>> --- a/drivers/dma/sdxi/device.c
>> +++ b/drivers/dma/sdxi/device.c
>
> [ ... ]
>
>> @@ -172,6 +182,32 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>>  			   FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1));
>>  	sdxi_write64(sdxi, SDXI_MMIO_CTL2, ctl2);
>>  
>> +	/* SDXI 1.0 4.1.8.2 Context Level 2 Table Setup */
>> +	sdxi->L2_table = dmam_alloc_coherent(sdxi->dev,
>> +					     sizeof(*sdxi->L2_table),
>> +					     &sdxi->L2_dma, GFP_KERNEL);
>> +	if (!sdxi->L2_table)
>> +		return -ENOMEM;
>> +
>> +	cxt_l2 = FIELD_PREP(SDXI_MMIO_CXT_L2_PTR, sdxi->L2_dma >> ilog2(SZ_4K));
>> +	sdxi_write64(sdxi, SDXI_MMIO_CXT_L2, cxt_l2);
>> +
>> +	/* SDXI 1.0 4.1.8.3 Context Level 1 Table Setup */
>> +	sdxi->L1_table = dmam_alloc_coherent(sdxi->dev,
>> +					     sizeof(*sdxi->L1_table),
>> +					     &sdxi->L1_dma, GFP_KERNEL);
>> +	if (!sdxi->L1_table)
>> +		return -ENOMEM;
>
> If dmam_alloc_coherent() fails for L1_table, we return -ENOMEM. The devres
> framework will then free L2_table, but does this leave a dangling physical
> pointer in the hardware SDXI_MMIO_CXT_L2 register?
>
> Could this lead to a DMA use-after-free regression if the hardware incorrectly
> resumes or is later manipulated? Should we defer writing to SDXI_MMIO_CXT_L2
> until both tables are fully allocated and linked?

Yes, the error path potentially leaves MMIO_CXT_L2 programmed, but the
device is not going to access the table address until it actually gets
driven to active state. Maybe I'm missing something but I don't see any
issue here.

