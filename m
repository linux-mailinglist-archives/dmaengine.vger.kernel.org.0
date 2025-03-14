Return-Path: <dmaengine+bounces-4752-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DC2A61E3F
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 22:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE23884E4E
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 21:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65F1193073;
	Fri, 14 Mar 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sRc2F3H9"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E901DFED;
	Fri, 14 Mar 2025 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988160; cv=fail; b=jLZByYeXgeg0m0ft1gbDuV6AUkgwTcfZAQhvObrnOwrh/jme6afHlKCQarR+jYh6tqUpEeRSrLJOIYecpszq01YfJKPdGY2FMvHtiE52nrrHITEr7S8hpjdlnhYRZfKrOdZU7Nmam7zthxcb9gE/cuS/c6lKoAEJjaYp8DD9Iiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988160; c=relaxed/simple;
	bh=2xNjQANdJfzd73ql8UTX2r5+Up+brfHhgZ6JXHCgy6k=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gSW6dMrClAF+ssvvVi/mkeBSFT8NyRCgiTYefh3xmIpVi7oakvBZ0Q2eFb82D2o6uF3dUbIOmB3pfE6dze9I0sqJWyUPvT9Rr2QglVNROXR/4SXpBZP1JjIUDc6I+vNuqoMBApvO+Yn4TTwImNnYGihlAjkvhQWjK+9p9Uw1Ukc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sRc2F3H9; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiL7DuwPfyUvoQ/lIh3MaJpOIqo1KouPuVaoBckTgV4UWNsmfsBHpyywa7DXXFKyhfqTOxB7uPBRE6wa8Id/2/3UlgvYg8KGmDsShkvWOcury3DQeR3V2zdyBpxAQl5O/tofqJq7S2/WWjeQQySU/cR/p51HyLAFYLUaBhXO6Vz+kIZocn6Gq30DWTipGiUn8yQwW7k23Zpv6QUawEMa2CxH8F56+pqP+ofgWVJLyQSnlBDAk3nD9w4VzZUu2VJlSq1cwc8N7RflQOVRnYF+rNeXldxQChm90R9ylplCc59/m2rPF4skMinLcLOyuOVDKnod6Wsry0jVYvR3rwNclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xNjQANdJfzd73ql8UTX2r5+Up+brfHhgZ6JXHCgy6k=;
 b=WvxzjW/sZ0EJuFbbs0PSrC5CqCifRNU8Me2A5cj3mUy/XZSq1qygDNeW09cA3YD5mb+sryXfEppcf/I+I0SBZ8Zh+7A5zJWCtuAktdH6stlY3abUDEnNwaDap2lxwHc1piuD4Wy6EfZvw+YiTq9Wb83pth+G0GZ6yfqUpCt3qWxMR907TybPpbGd+yhTyK7cUa1ZDX+4Olt68M9EgrQZi5YRXtaJKmdznLQESicTfw2w4A1n9LkPrXU3JoXMOyn0JQUDqiYSFQonJq4KaWZEdb+vMTxjNv2x63yBwAQ8lX4QB98qrhZsVcsI4yvetPuW2YqsVv8RlRDeMf8Pk2EqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xNjQANdJfzd73ql8UTX2r5+Up+brfHhgZ6JXHCgy6k=;
 b=sRc2F3H9nKyouf8q/QDZImHDqkEQ0BXY6Fv+dRqCpTG+cyLPSSj2z4zzwz9TzMxXSY6oPhOG0laW6RDlYM297iMzcsPFKCwpACp9/S7X0uASKB3fc9QuogfxcmEb1MA8W4cUZIXTsMjoHkq9aYMmie+ndcLw/DeG1D92ja1BuB8=
Received: from PH7P221CA0031.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::26)
 by DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 21:35:54 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::c0) by PH7P221CA0031.outlook.office365.com
 (2603:10b6:510:33c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Fri,
 14 Mar 2025 21:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 21:35:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 16:35:53 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vinod Koul
	<vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave.jiang@intel.com>, <kristen.c.accardi@intel.com>, kernel test robot
	<oliver.sang@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
In-Reply-To: <87r030ldbw.fsf@intel.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
 <878qpa13fe.fsf@AUSNATLYNCH.amd.com> <87senhoq1k.fsf@intel.com>
 <874izx10nx.fsf@AUSNATLYNCH.amd.com> <87wmcslwg4.fsf@intel.com>
 <871pv01vaz.fsf@AUSNATLYNCH.amd.com> <87r030ldbw.fsf@intel.com>
Date: Fri, 14 Mar 2025 16:35:46 -0500
Message-ID: <87y0x7z45p.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DS0PR12MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb55193-bc1a-4e17-ded7-08dd634032ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7+fk6vaNvxlAgx+2ytEli+VfDKA7y+UrHcDvAx3EzCoEONfgGpG8SI4vzCf7?=
 =?us-ascii?Q?IUg8SBPOoy0ktOxXw8h/oqkesR0CGweUenEBFXlQc/pf9Krwtb59H6G5MTzX?=
 =?us-ascii?Q?/gcQlRye9JW5uUOv0bkKqJpWpJCqAwW5xmanlOW50PiDaU6jyUBOmdmXBnDn?=
 =?us-ascii?Q?URDobJzwo02KZTNHs/AGzB6FeSugN0vZo6zRwisGz1K3Uphf1ufxI4BROWaU?=
 =?us-ascii?Q?q0MB0nJmS+DQpTCgMgmWfoGq4SSa47jWPG19oQ1vkA8wk8yWSRRpn70DEydP?=
 =?us-ascii?Q?IcW3LVVvzpmy/m2pmZtd46AJmI9qWnxjl57PrQkl/p1k6NVYEwMrSkTCNYeh?=
 =?us-ascii?Q?KdgnDe+uKbjZZ1cGd+jqmCYabBpASWlP8pnYSYij0x4l4jBADuzqfXEDZFmZ?=
 =?us-ascii?Q?48Cae46ppCzPGorh/cvoUqx2ZKrW92W5pCdBKS+7Aiy7voQuU70MV9yhsANC?=
 =?us-ascii?Q?vfF5tQSbFbPd09hPgA8+oSR+OfuNwv6gckvvcTP9Dp6x5pmyNPopyxglDjnJ?=
 =?us-ascii?Q?8j88aa0MfYw/zX/xFSzVAHi+6PVamBZ9V/bgevjM1/NkXwzPvmBbMy30Q+1K?=
 =?us-ascii?Q?4jdjTAs1HQatfqEwM/GFxeoDZbuh9KGIfQ1ClvAlz3Vt8TI5NEFvPoLiCeSG?=
 =?us-ascii?Q?0V/8fZzYlbrD5ipXEsLHsJdfOCeiX1fq9j/tThva8cdRnehsj2dM4qXuE22+?=
 =?us-ascii?Q?1iCHUi4lWRKAk0cSAbTBBRdTRF2/BPAUvVgZEePfbzW7kn6XEGkbgzbBHxkN?=
 =?us-ascii?Q?Yut1gDYJY1JzOdPx/8R6Kxs+ABqZyx3ly/GKT9uk/bzd+ACh9BkRsteiIIsc?=
 =?us-ascii?Q?9TqHYSzVjBFTKftUlJBOPXGGcVk2HuhaouE6X2H7ZapPwxlJIDfqWIqyPeSy?=
 =?us-ascii?Q?WbKzhWDn7pC/0+nOQLkwCgsyk4wVLCfJQuaBW5+bLjS+ta8p1bYSJApOPLv4?=
 =?us-ascii?Q?kBCrI3yY8nYxFtXMr9hOhKR6Nvy5otlDzERI8vkdRcew+236qZC/uKJAa6fd?=
 =?us-ascii?Q?43IOngVsPpHa3UJSnkXWjfStbiAk48/Axtwek735Y5wLTpLMvRXnKiaTuuWv?=
 =?us-ascii?Q?egNNqVqVg7dCi3n74WQmX05rjQ0vIHwTTpx63Zq1olzHgiAzLaw7oaZ01KwC?=
 =?us-ascii?Q?iVG+5NA4F+nSako3PsuNI3PrumkFkcjYoE2UyU+OTjvEce/jgvM1yy8AKaVA?=
 =?us-ascii?Q?4qWDiqiY/p1rxukqFZsEcp5WKPugcdQ6VDpVHqI67aKGMUvLfGshANYAG50U?=
 =?us-ascii?Q?fnboQsHBL0O5kSwDf79pf6tMstf/mjYDWfFEb8njh5nLkEiFC9OtgjMdm25V?=
 =?us-ascii?Q?tTcudMaCxSKIXLmep6nUh6jBJFGIo2Lh41ph1pxWI7AB/OgLyD5neX6+S6Uj?=
 =?us-ascii?Q?2pfpQ7HgSz6zhdSg6RK1v48Pa7ZIqPonaogfizVM7g5ZA6labbT00oxw+mKi?=
 =?us-ascii?Q?AUin1Sl84lTt0swq1hSgb7yYAw0L7BEMGv0LQEBFtAEjfc4dzkyiZbTtkvfa?=
 =?us-ascii?Q?X3W2PnmMq7j6hI4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 21:35:53.8422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb55193-bc1a-4e17-ded7-08dd634032ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
> Nathan Lynch <nathan.lynch@amd.com> writes:
>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>>> My understanding (and testing) is that wait_event_timeout() will block
>>> for the duration even in the face of interrupts, 'freezable' will not.
>>
>> They have different behaviors with respect to *signals* and the
>> wake_up() variant used, but not device interrupts.
>>
>
> Ah! That's something that I wasn't considering. That it could be
> something other than interrupts that were unblocking wait_event_*().

Well, I doubt it would be a signal in this case. Maybe you've
experienced timeouts?

>> dmatest_callback() employs wake_up_all(), which means this change
>> introduces no beneficial difference in the wakeup behavior. The dmatest
>> thread gets woken on receipt of the completion interrupt either way.
>>
>> And to reiterate, the change regresses the combination of dmatest and
>> the task freezer, which is a use case people have cared about,
>> apparently.
>>
>
> If this change in behavior causes a regression for others, glad to send
> a revert and find another solution.

Thanks - yes it should be reverted or dropped IMO.

