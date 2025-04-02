Return-Path: <dmaengine+bounces-4799-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86936A7902F
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 15:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A793A347A
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1590023A989;
	Wed,  2 Apr 2025 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2cuL5+Qp"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BEB237705;
	Wed,  2 Apr 2025 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601566; cv=fail; b=sZje12Z1cvTp3L8Ir9ghyWysG9xoJN03VsH7PudP3PQqHlfKvSUYfHOr0ZNLKweyl640LlmE9iwMayJwBwAoCaDQoTy8YljP+q0DvpRCJQnmgYiUs1Awwun3TqIB0We088X8eUsAbZCdDL4jfA/F5N1PJkZyU/H2ZJmMDtv78mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601566; c=relaxed/simple;
	bh=qIzoOuNbl/T59GFczQl1YtXLsQXswRrY0qBHECl/34k=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eAqKqSKwf/QaznlEOk+MgcMV4PnHSjRvf85f5Xbma4DVOtwB3zb/b2H7GIH5gnhD9ZNB9ialEjQcWoFeP6A+o+YhDma00pS1s4YxQJHA2iPWirWiEOh3I88Y9XMU2xK5L4GmXNiyBVX9qzyFy7lZ3a+BbQGdy27NoWsVm48T3io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2cuL5+Qp; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag2Bz55gh76nj4lwV/cw53JcglLrGYd2x0llv7FXTGH9Q2f54Qiuk02Kpqhj8VVcgKJsGNM1GhkhHzwYY5iqNOlYoYyDhDl2xmSumAxlYdL0DgRdOzf00GtS2SAK8RaRiBUz7L5BJd5/XHDUXMqYMudXBQWFLRELE5ORi6y1xH7YByXE9qfKXHl5Ba1djydetwBL5y5LbSfigPAK90FXdyHYazqu+nZOp9POaJz7pav/iC3gLYfO++nFD3Vm+X3x+xekO5lZJUvyBpS2kKGzz+dAJC5wmq7MexWVmwjusUBhj5I9iJeiZDWh5JT9WSnw1iDDojIziovgBHUcx0WDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIzoOuNbl/T59GFczQl1YtXLsQXswRrY0qBHECl/34k=;
 b=CKc6FO1cPCUOonttHwL4Kapb+umBG+1V9oOhwlQDSEYC0/yOhf8E9MgZsL2cNSqoujL4DqLPDgYtDCx3L6ijRvcdDTrVVszmCV8iMubh93LRqrcOoH1GDF0kIw12I1FCDzumh+cTElDQlNjjUsEgJbWkG6wxDcm6G12efargZSGZORWitGzDXF/AcuwytBbTtX5312rjeiQLwAPK0BfuGDx5wPQAaDgm6cF5dXJBAmVsjX6Tsl3VPCg6x+hfoTJ0eTAcZRxAJ2VTTkeAyEBOrJeGC+s0cCbeEPLVpwRq2uJvO3gwNHLiJnQaFMoO9ej1CXJYrLR/k8LjHEFpxHYttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIzoOuNbl/T59GFczQl1YtXLsQXswRrY0qBHECl/34k=;
 b=2cuL5+QpWEl8W3Qte57wfy6lag3HSIXvsbH9i3VmoIQRg1J2iWguCZlHOcrKozVWxqaAk71TPVIjE2rOqgkrSvOua6ZepFo7xFIyCeC8e7z+CSv9X72E4vUqJthFPhTZy1Nbgj9qogfHtHTxRd9Hw15zqcT2Fc2B1LZb4JQ4nds=
Received: from BL1PR13CA0108.namprd13.prod.outlook.com (2603:10b6:208:2b9::23)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Wed, 2 Apr
 2025 13:45:58 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::83) by BL1PR13CA0108.outlook.office365.com
 (2603:10b6:208:2b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 13:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 13:45:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 08:45:57 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vinod Koul
	<vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave.jiang@intel.com>, <kristen.c.accardi@intel.com>, kernel test robot
	<oliver.sang@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
In-Reply-To: <87ldt7l081.fsf@intel.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
 <878qpa13fe.fsf@AUSNATLYNCH.amd.com> <87senhoq1k.fsf@intel.com>
 <874izx10nx.fsf@AUSNATLYNCH.amd.com> <87wmcslwg4.fsf@intel.com>
 <871pv01vaz.fsf@AUSNATLYNCH.amd.com> <87r030ldbw.fsf@intel.com>
 <87y0x7z45p.fsf@AUSNATLYNCH.amd.com> <87ldt7l081.fsf@intel.com>
Date: Wed, 2 Apr 2025 08:45:55 -0500
Message-ID: <877c428yng.fsf@AUSNATLYNCH.amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: a8095628-d080-43c5-9c34-08dd71ecb286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rx7NKflYGxLkFv/BI16bN8skqw781eH3ZSBsFuzA/a6drstfqzajprhwX8TT?=
 =?us-ascii?Q?VYpyu2QkFoMiQG1mDmGuaBp9ppLGw8TW8aKkQ4AP+kqzWv7PRzH3WTtlCq5v?=
 =?us-ascii?Q?Cm+995EMVs3/upZAH2zpTvk9rjjzgf71Xty7wsK7CTrXyJ6vIelXxV3NtDoW?=
 =?us-ascii?Q?HyY6zz4/gE9pI43665b7LNYMWey1j0IAodjjibTxt4ABwXzV+IODxBQfEFi/?=
 =?us-ascii?Q?2++C0OAka+iQWJVjyTXUK6E1OnghGEQp4/IsdEReVTLpaGw159mmTbu0ZI69?=
 =?us-ascii?Q?lwO7VVO/73pCbNDY1+8/qyoJCHMdzDk+Klto7f5RvUQZ0ezBMyM473n94fph?=
 =?us-ascii?Q?1u7+Y/XBo9xvFSonHy0h7ueipvDjaF+y6P1gI6MkdBmHpUCav5Ub8cKQsO4W?=
 =?us-ascii?Q?5yLL9rzcA2wVwjmDyNYonlrjxvrPAg1WP+CfHvmh3D6pKB3dad6zWH75mZZN?=
 =?us-ascii?Q?Liyodsiiaa1yhZfwPQhuMR/EYQ4ZPl9oUHrDfmBMYgoktxtNRETI1MS10H9z?=
 =?us-ascii?Q?tB2R7MshS7PA6G6ccz4ZX0xSdSHvIfojkrCk/47s833UrvF4XgiUsbrAb/Rh?=
 =?us-ascii?Q?+8VmPPsRJvHHYAkpSIZNwTfUekB4+x/IQY+a87WdOzTvSZboGFTUzJBNpTu6?=
 =?us-ascii?Q?5VbTKyQuFnmpPMM6BRBvJWEOhTawzIk7t6nneGdpgwrPYvkltjLOz2aV5zFp?=
 =?us-ascii?Q?a1HZncSjGAoPjPr2aUQWIvdJd9NXyLocaEvmGU51ugP0smrNvTu+K9s8qZ59?=
 =?us-ascii?Q?jE8Yw32e/1nN9f8YoVnZW6H9QeT5CiaaQWXXIDhAOmEpGSyyLP61mk16S+8v?=
 =?us-ascii?Q?D//UrI3WSBnX2Ozv4uLlJyeLjyFJ5bsCHYawIq2QFUmW5jdWQTdlt4tkMbCn?=
 =?us-ascii?Q?QeLfP7oVYIt71Ac87roRRbzWZCY3hJjViEfTd4lqFDpnj35cBShK6xjrg3aU?=
 =?us-ascii?Q?Q0m1CBC0KIdMMQ5j0e/IdZJ3Xe7rQsx/XpQSXS2V4GctAhuz1E4X0dfdLEYH?=
 =?us-ascii?Q?EuY78ORR+CCcQ7W7G62Ni82C8xh7mwx32llaRkmcZgoAc9exgwFPovSMjMpq?=
 =?us-ascii?Q?pK17SZ3O2I4rz6ZUEwRotcO8BLLqZfZj5AfMAd+eamnbPUyzraesTCrdNY4g?=
 =?us-ascii?Q?v+D4d2CiuE6obZF8eotLMNzn4FcHJNn/C8Jyzyk88/d7VF+TQgJMWHI1dVEa?=
 =?us-ascii?Q?OrQIWWSXOklHlfxM8OC6hOT/eR6G2Cx09BKmUmgbspDfWXxJAqs6C/Iilo0i?=
 =?us-ascii?Q?2A1f6nsHcotDXrS1q2PFN6aj7wRYlwijRPJx8MgRC7uERBZ5sGr7bqtN73Ov?=
 =?us-ascii?Q?/jp/u+f9yOV+NUQ+mjn9ALHUPsQ09HZFO5NZetvT021a8Ytq+MvjrzyjvZUj?=
 =?us-ascii?Q?vFo9WWW7rmyt4zqXHsbHlBMlUzebA7CEoWFJRrVPkhRmcgw0E8N9wRDi1478?=
 =?us-ascii?Q?0qaA26j3yprZ0qzMkhAHbA/ffCtV6oXlr/X2wJkQakNhuq/1EEFGSrgd5jUS?=
 =?us-ascii?Q?BehKaY5O2VOL0UE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:45:57.7552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8095628-d080-43c5-9c34-08dd71ecb286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
> Nathan Lynch <nathan.lynch@amd.com> writes:
>
>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>>> Nathan Lynch <nathan.lynch@amd.com> writes:
>>>> dmatest_callback() employs wake_up_all(), which means this change
>>>> introduces no beneficial difference in the wakeup behavior. The dmatest
>>>> thread gets woken on receipt of the completion interrupt either way.
>>>>
>>>> And to reiterate, the change regresses the combination of dmatest and
>>>> the task freezer, which is a use case people have cared about,
>>>> apparently.
>>>>
>>>
>>> If this change in behavior causes a regression for others, glad to send
>>> a revert and find another solution.
>>
>> Thanks - yes it should be reverted or dropped IMO.
>
> Here's what I am thinking, I'll work on this a few days and see if I can
> find an alternative solution and send the revert together with the fix.
> If I can't find another solution in a few days, I'll propose the revert
> anyway.

Just checking on this - I see this regression is in Linus's master
branch now.

