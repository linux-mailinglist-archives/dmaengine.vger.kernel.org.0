Return-Path: <dmaengine+bounces-4814-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1403BA7A7E7
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 18:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED181892F1D
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E972512C5;
	Thu,  3 Apr 2025 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lPndo74b"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4164199FC9;
	Thu,  3 Apr 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697500; cv=fail; b=eUMMTHtNQmxcVIwsEebY2zf8ZW6nL7ESsrzdFfvwoNe16et+mifQq2Y6WSPkPOV+gDdUr6G+6iGoiz9BLSaIOunRVFLBTRzNweXAnrPho4N9ymhMdMG2rcdHuRd7/3cXsuV4m+cfFSNzAZyQHQvqIWdUFgxL8vSjhKErlRRQ+Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697500; c=relaxed/simple;
	bh=O20vy2oryTFdztnsCt/0oCRcwyz7aXFSPSqnG1+mcyQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ee4sxU3jGOhr1zBGMTq7Lztk2UmeJwhi0hXT/jn2uoOEd5DeiC7MYBnp+pUKqYXEsJdZRC2Qm8Vrje7iEgumiY7g1qq3ychnbCEHTQYcrQarGgFPbPGSVDUt7L/Ksf9bf4bYWaHgPUm9FVeuG9s5TOu9OmFOnXbcsSVuGBkIUjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lPndo74b; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6nPK0dal48oUxhOBgkKj+zRJLCixwUn/UZ3Uy+W7x12s0fWktmsIK+Gloihx70DbqHWF/iIdX/unnAK3oo8+M+TX2b35UA7Si7O1o4uLSVtd/yP3a28OEDaG81eDxGmSqb6m2D0E+JPw9vAVOi9jf1EnkDz49SrYLMxk0DNqPF4CKAPxyosEIhk3QOyRf0iYfAX/drfIsGYi7YExrWwGTCcRvgJXJLh9aexs1R2yyHaAlXAr/vH9Lg7yd+Y5vYw2PyJAmTgQXRsTAGIFiWJP5kYguP6hpGm6R9nX2g0KSfx2puG28z8htDkVhRUj2PQM1JgvBbnBGVPfo9JKADJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O20vy2oryTFdztnsCt/0oCRcwyz7aXFSPSqnG1+mcyQ=;
 b=pvEgtO2//+J2rRhIc06Fs9kGcQrN1peZqWZbH2Nybm7yQGTjQACBGLDMYDOVuQhH0+lZc5dLd+Evbn4E3AOSkDegIDdOHl2/yawHXIAQWfDVjvHt5hppORu9UXoZaGauRILVKPoIUBTLfEzoghx/lurxrEodORe/9i/jBAuWya4cUC6yHCjsixoNmxUJ/yniBdkTpajWEhPJjR3xcoLOPOajFe1eQMm+gGbxSweK3jjDXwGSqK35qs01fkt5gcLUcaVLTJMw6cwyN1W3eALSFvL9mz3fhzbx3/nVGeDza6HliLNisg66iMXBmd+kS7DChm1jA+IJJZksBrJ0MAqzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O20vy2oryTFdztnsCt/0oCRcwyz7aXFSPSqnG1+mcyQ=;
 b=lPndo74box3dx28JpOh6TNWqL13Yop9L4sWzQmWXhISYco2yol2/iUzXM10HdwIvXhK5MbxHk1/LvTv8d3y294wQfE77c12iTp6rK2YtRYZuJFgZ37A80mrnuL9TrFOpIiPhWqEGb7sZrtvXlFyv4Oj/mXqy1Q9d9IiqgevDNEA=
Received: from SJ0PR13CA0180.namprd13.prod.outlook.com (2603:10b6:a03:2c7::35)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 16:24:56 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::ac) by SJ0PR13CA0180.outlook.office365.com
 (2603:10b6:a03:2c7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.10 via Frontend Transport; Thu,
 3 Apr 2025 16:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 16:24:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 11:24:55 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vinod Koul
	<vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave.jiang@intel.com>, <kristen.c.accardi@intel.com>, kernel test robot
	<oliver.sang@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
In-Reply-To: <87o6xdzz5w.fsf@intel.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
 <878qpa13fe.fsf@AUSNATLYNCH.amd.com> <87senhoq1k.fsf@intel.com>
 <874izx10nx.fsf@AUSNATLYNCH.amd.com> <87wmcslwg4.fsf@intel.com>
 <871pv01vaz.fsf@AUSNATLYNCH.amd.com> <87r030ldbw.fsf@intel.com>
 <87y0x7z45p.fsf@AUSNATLYNCH.amd.com> <87ldt7l081.fsf@intel.com>
 <877c428yng.fsf@AUSNATLYNCH.amd.com> <87o6xdzz5w.fsf@intel.com>
Date: Thu, 3 Apr 2025 11:24:53 -0500
Message-ID: <874iz58b6y.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd03074-111f-4076-cc68-08dd72cc123c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3W4igBH3UhvpjaJrh3gm0OQOnCUevB+pwsbrxNLhReKjm/1Nn2+i690cFnji?=
 =?us-ascii?Q?iJd7GsWgg3qyEVW4ScDYGw9vomAIanxUdWblktGHY0IB2d3vzOVkzHmiyViR?=
 =?us-ascii?Q?TrVRWROVgsggMTt9rJ1CAyXxDeyDUYcYLl4wkgZzvGm0xuAJzqIUUgzTkobF?=
 =?us-ascii?Q?1MaTv/Lyxk71g80tYxLnFx14U/z9hb+HdSPS3yG6oWpEwui9GZrqYbbAwqo1?=
 =?us-ascii?Q?nmxXhX/F6V/xBbmL9e+2FlH3Ptf8JRxOUrnS3LRUK96fkKkT/d1TCTvNfmjU?=
 =?us-ascii?Q?65DUpq4XcmAA/44mYUSy0VVs5HEIH5j3x6MsQ4N3hCAlgPYlzk96Y8w/d17v?=
 =?us-ascii?Q?YGaWHqto4bgx56M+tX7Vo8K3NhVUKhAAJemqcerWw/79vl2LduZj2aE/ao9j?=
 =?us-ascii?Q?GzhATAIXasu0nyKAcQPkEfLsAloblILBpkLoPIkJMm6CV+9oSICeNuBK10/v?=
 =?us-ascii?Q?/dssbPse9Led8tTuKQFQBKvkdEnGP0MpNO6m0p+SlVWkIRSLckVGBeCAVK56?=
 =?us-ascii?Q?4BAcAZPYDQubQzAGeMxkfxxAXSp9M3/mM+8oDKIDvwnXZ3UzPVBF312zRgKt?=
 =?us-ascii?Q?9l3vLkUZRyaQGZCllL60NB0SBakkIRBkqu/SPOU+EQSW989sJtySnpQ/BZmk?=
 =?us-ascii?Q?KYxm8h8OUyS0XR6loSxHNpQC0Gr7H3o7Os9Jz2kNtrPu9his1E6/4wTyGsoC?=
 =?us-ascii?Q?TXsMa97t/FkxeJ/zeOZeAeYVJPh76rfd96fyxR+caz4MlYqsKJ7D17341dMf?=
 =?us-ascii?Q?5juMbYOwL90Y1hxGf4mfZOe2maQDcwHfW+nDKa3pFw/MBN+QDVV92bEszZlC?=
 =?us-ascii?Q?SGDXce1sk1fonQzIJMlrJSlHxtVVLk653bCYZ3Zp1CQJrEBD2g8tu150/2yv?=
 =?us-ascii?Q?8yHGlkfa4dlcXFBGO0Sj4Coo5TBfVsWm3O2WESSklFWVFbIv9VochRo6biqQ?=
 =?us-ascii?Q?XXlYUQ3t5ZY7GDkNXG8BbexUsHKt8r101yT0IiArzufL5yhJb3zQHssvo2v2?=
 =?us-ascii?Q?Mc7rl3MJzzn+3G4INlTCkvfVvDuSX6bkzfRHrVDIgUmCAuAw0hcYvz5/s8Fv?=
 =?us-ascii?Q?24lhiZsr8d+T5m094GM01q1rDayhTPjp7rPhsv5UzAw8/iA2rNLTwNT38wyH?=
 =?us-ascii?Q?hsaFS8REeOd6+8IWeilTrEzeConO4JXlJy7/Hqt2104HtR8b3OOuK6dqArLP?=
 =?us-ascii?Q?UXuwrFYa41MuEXOtQ01p3zYPR6UYi/z3G+ZcBtSILrdYmtLvi09XEu3WzWfb?=
 =?us-ascii?Q?pQVv7eQIc4cLtySWMX6tfhpaV3PLV8f9i4qb58BuZm4Zp5A5gbM0KgKG3vXi?=
 =?us-ascii?Q?BXzcKR1mzdoEEhMlGms3Eeo6AxSiVVPRI7D9D2a1PRfnBeukn4OUQ9IJ9GLv?=
 =?us-ascii?Q?i7CxgN3TiwNjcYQBPcvBxOKMAsT+XTxdnNf1r0Y1QwRrDlgeEN/2n7KfBvQX?=
 =?us-ascii?Q?A+OiQrvwPdUV68vaO74ki167TtU5HM+13lHsyd4egB4jF+TgFRWuBN0eGuIs?=
 =?us-ascii?Q?cJ3GuUwBIQc5MEM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 16:24:55.9941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd03074-111f-4076-cc68-08dd72cc123c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
> Nathan Lynch <nathan.lynch@amd.com> writes:
>
>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>>> Nathan Lynch <nathan.lynch@amd.com> writes:
>>>
>>>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>>>>> Nathan Lynch <nathan.lynch@amd.com> writes:
>>>>>> dmatest_callback() employs wake_up_all(), which means this change
>>>>>> introduces no beneficial difference in the wakeup behavior. The dmatest
>>>>>> thread gets woken on receipt of the completion interrupt either way.
>>>>>>
>>>>>> And to reiterate, the change regresses the combination of dmatest and
>>>>>> the task freezer, which is a use case people have cared about,
>>>>>> apparently.
>>>>>>
>>>>>
>>>>> If this change in behavior causes a regression for others, glad to send
>>>>> a revert and find another solution.
>>>>
>>>> Thanks - yes it should be reverted or dropped IMO.
>>>
>>> Here's what I am thinking, I'll work on this a few days and see if I can
>>> find an alternative solution and send the revert together with the fix.
>>> If I can't find another solution in a few days, I'll propose the revert
>>> anyway.
>>
>> Just checking on this - I see this regression is in Linus's master
>> branch now.
>
> I have a series with the revert, a (hopefully better) fix for this
> issue, and a couple of others that I found along the way, that I should
> be able to propose soon.

Respectfully, I don't think that's how this should be handled. The
revert should be standalone, not part of a larger series subject to its
own cycle of review and revision.

I've written it up and submitted it myself.

