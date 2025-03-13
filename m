Return-Path: <dmaengine+bounces-4743-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A57FAA60356
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 22:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7954F7A15E6
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 21:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EE31F03E5;
	Thu, 13 Mar 2025 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jT4ptvZR"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD7747F;
	Thu, 13 Mar 2025 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900877; cv=fail; b=lIlfyfW8JzqIogjOTPtzKvDgu2n8EryCv/JTDlPSpOohTX1mk7/m7vQ10dHm69zHDE1eOiclRUP6xS8/IIucTIS6UoklYxM24Y3wtHd3NYqzn4zlJhrJSnGLKX6kuAQu/u+Oli1bDjGW5rRK/tF0ueQfEyjjZI7CMRdHmFVB9pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900877; c=relaxed/simple;
	bh=RffNUvxKJ/F6meGDBc1xxtqeBxsIqfuJRdqUbDj1fDc=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uea9tIMW60Kspw5nM0Mx+qvXdtobFDmPF2BCT4Weg8K9G5dZtLwwWx4JY+eF985MhpLr3/yOvWGzfbamHNJWYF777KyUmeeqoktCb1k7cSGE2DdiVUd5TwGcaXJnS350e563A5YD6MKvlDxZJROGtdYBoAZq6/IhSf9PZocd0rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jT4ptvZR; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ct6MtS0WX+VEMtej21DAHy1MzyS+qWefiulqgVBgpjIJG6HsEhtzb4SPD3NgyB+LewwdPzhp9Pcf3zKX+sZmydVJcUwuwUesZSqo1k2xRXq/Dq6Gs53LoL5b0Wd7UOw/jY0pFP1ciOpZhyRLR6lyVmrrzkbPk1lNqwiBOJytBJ8Hkv/BebF05LoA7FKlj3CmUuUVTK3KXNb+3ICcSyY5KY5R9J9p08TeAEXJ7fH6uy3QNLROXRr5etSPPbpJXg1hOX4eJq+bllceeYPYfCkRMIokTmBWDPeOrbkSh45Cw9B+26GVeu7v8CfHshd4nq+KhfcI62WVLakJY3cfc2ki+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RffNUvxKJ/F6meGDBc1xxtqeBxsIqfuJRdqUbDj1fDc=;
 b=or5p52FgG6pQ6c6uNrJuzyruWpw9biCCsabpd1AD4q+56MAb55X2zANImaE1sFKyzMhXOmmMKJ8PQHukQyX5CueTIfoeuq628smNsxDwKH5r/WatdLKYfAw1LtzQtSaz0fMrrjifm3iDFp2dz89pVt83KTwTQGWd0b7pGDoFHorzUqKBT/23zZFj/xJfCxOrJNPLxCHXPPwJloSfvajmXmsCG6oLdc0ZvhW64E7YBgDWDCrP/AP21Gt6mG6VPxSwzWRV+NqTmcsTZ0xXMmURA7RVIKpLgUffB6nbeJdv/nt9R+GI374eSRR5wZCKV9m8C7EZlFGHq4by48xTxiQFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RffNUvxKJ/F6meGDBc1xxtqeBxsIqfuJRdqUbDj1fDc=;
 b=jT4ptvZRRdfgxhY7Mmy9pH6USCrGuR9+MTyfbIzkLtiaABFnF93veaQY2q7Uu7Xn1ILFy1ztVmTuGAWORaZfNBHercIveoVIXUveI6ixQGTU2dj1yQr3Y/sa8cotthWdLFrge/FPCLtIMwyofdUznFhRus2JEpNOSyBerk4zta0=
Received: from BLAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:32b::8)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 21:21:10 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:32b:cafe::da) by BLAPR03CA0003.outlook.office365.com
 (2603:10b6:208:32b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 21:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 21:21:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 16:21:09 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vinod Koul
	<vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave.jiang@intel.com>, <kristen.c.accardi@intel.com>, kernel test robot
	<oliver.sang@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
In-Reply-To: <87wmcslwg4.fsf@intel.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
 <878qpa13fe.fsf@AUSNATLYNCH.amd.com> <87senhoq1k.fsf@intel.com>
 <874izx10nx.fsf@AUSNATLYNCH.amd.com> <87wmcslwg4.fsf@intel.com>
Date: Thu, 13 Mar 2025 16:21:08 -0500
Message-ID: <871pv01vaz.fsf@AUSNATLYNCH.amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6cd29d-74ee-424b-fcd6-08dd6274f9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BtLgBFjsIz2n2bheuCeRVebeyM5cTpbVavdfLHZeHVEtEwvH16nTucl5F8Qd?=
 =?us-ascii?Q?sPLgE+NJ7MecjSiQl158ses1PA9fae5hgf/eMQBYeE5Nfm3xkcq44SwXV5nb?=
 =?us-ascii?Q?KNZNHdlyt1UNjI3jHAmLwUNBI75P8rHDauDJXIMM4KEt8rzmxsPx5h8181ox?=
 =?us-ascii?Q?hnLNTId36bxi/qggVJYECBGLUkGlx/TIQdQ2Osgc9SfF3KFoInJLpY249iP8?=
 =?us-ascii?Q?AwVsNKLYfN6tbhKzly6xsbpt2IeKdgTmIESB6N2Gtc1Or0PzI7f1KzVghsBc?=
 =?us-ascii?Q?fIBJiylOm0GK8C3NrZrr9xJS3ao0W5Ih3ETw4sdSZBBNqmUW4oqhFrhutz4b?=
 =?us-ascii?Q?ryZ8DrqwhuMAVmcBn6GVUThTqgpDssXDbpWuRr47IOqHWlIU6M+YxpMOegS1?=
 =?us-ascii?Q?ecRimvwSx9yvPHKeLIzgJaBt9SIjC3FA5w8QBxVBjLrD4HcxzD6Wzgr4tmD1?=
 =?us-ascii?Q?XkWygXmYuX822VxgemlCc2hnHhKhRQhB08PxvP6MF26irnXH1RODhzU/T3Pu?=
 =?us-ascii?Q?qNQf3ILcNOlFkOYSb0GKLsJKNZhclNKsfUbEyVDEbS0F4KCYfq821D8zNONv?=
 =?us-ascii?Q?Uu6tdNIaPPRxb1so25ENCFnLknEN73JF96DiNv1jqTVmU2I/FCvcqj3X2K+R?=
 =?us-ascii?Q?SK1NEPoKStcYGCo6lK+fNOeuCk0Gh+Rx0Z5vKxhD4q8aOcqTqqKqGmZuSrny?=
 =?us-ascii?Q?o1aLWPrAVW3TEaihxYbCPITsB+ZCfCRsHkBqIbbmswfpnHxwwvDVy0hj4v+8?=
 =?us-ascii?Q?+pMtFW6NUzE9FVK0vL1FB7CL8DwFxMk9S4sJusgNgQdl5gBkoYGqtgPQPBJm?=
 =?us-ascii?Q?Lercx2G4BNQXjC0UwWaDWB87K5i8utShF/oY/rl3Cwo38EQ3gCz9Ktsm9oa5?=
 =?us-ascii?Q?1Bik3zACrk3AvV9GiHbRFr+sU4lEnt8D0ZtmEyTDz7knewZ3NBP/+ARYT3f8?=
 =?us-ascii?Q?lPrQIV055dvEQcn2gxJtAu1YGcIaoLs+uQTQAloPDi+cT62FDqFbb5QnJGsc?=
 =?us-ascii?Q?DgS6JrTqvc/FKGsh79olPUCOEcnRF1ZUzAaPDQYor+sKhxwNLwTgQAqw0vu2?=
 =?us-ascii?Q?rJYs5m/KmMBQ+TCBTMu0YF8vldel1mFSGkLqfUI52bKrhjtdf+rqrNNPl5gk?=
 =?us-ascii?Q?mxa8tz2QmpEXBKm9L5igV3HRioQ13IvS20OoW0CAxY57hOtvkyDAtcO9V187?=
 =?us-ascii?Q?JhCry5ycxU366UfuJ8nJn63gvdVJsd8JiRZGu0ZZdo/f+cetZhO7CVIxjJY0?=
 =?us-ascii?Q?Smtwvj7mdUEkGZobaa0TfhWo0YWhCZMM4Ct6+8U7P2m7mo89i2y0WclkvPq/?=
 =?us-ascii?Q?1BWJi2F3HAZRQSSoraWY2Ah6QcGsXyLUA8KLfrlEblnkPCWO2kxq9sKxVqWR?=
 =?us-ascii?Q?ojxwupYjaEN5MlsflnO/0bInuDDb+T0RTH5EP6I04vB8mYomICQl2Aclp2b7?=
 =?us-ascii?Q?GYIViH5yBpj9m+aZeNSGm0WVHKhrw2Ki6718xWbPwe47u+06HXFxrzKQcHfq?=
 =?us-ascii?Q?BG+XIUx2/oe1VTM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 21:21:10.0339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6cd29d-74ee-424b-fcd6-08dd6274f9a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
> Nathan Lynch <nathan.lynch@amd.com> writes:
>
>> Hi Vinicius,
>>
>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>>> Nathan Lynch <nathan.lynch@amd.com> writes:
>>>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>>>>> Change the "wait for operation finish" logic to take interrupts into
>>>>> account.
>>>>>
>>>>> When using dmatest with idxd DMA engine, it's possible that during
>>>>> longer tests, the interrupt notifying the finish of an operation
>>>>> happens during wait_event_freezable_timeout(), which causes dmatest to
>>>>> cleanup all the resources, some of which might still be in use.
>>>>>
>>>>> This fix ensures that the wait logic correctly handles interrupts,
>>>>> preventing premature cleanup of resources.
>>>>>
>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>> Closes: https://lore.kernel.org/oe-lkp/202502171134.8c403348-lkp@intel.com
>>>>
>>>> Given the report at the URL above I'm struggling to follow the rationale
>>>> for this change. It looks like a use-after-free in idxd while
>>>> resetting/unbinding the device, and I can't see how changing whether
>>>> dmatest threads perform freezeable waits would change this.
>>>>
>>>
>>> I think that the short version is that the reproducition script triggers
>>> different problems on different platforms/configurations.
>>>
>>> The solution I proposed fixes a problem I was seeing on a SPR system, on
>>> a GNR system (that I was only able to get later) I see something more similar
>>> to this particular splat (currently working on the fix).
>>>
>>> Seeing this question, I realize that I should have added a note to the
>>> commit detailing this.
>>>
>>> So I am planning on proposing two (this and another) fixes for the same
>>> report, hoping that it's not that confusing/unusual.
>>
>> I'm still confused... why is wait_event_freezable_timeout() the wrong
>> API for dmatest to use, and how could changing it to
>> wait_event_timeout() cause it to "take interrupts into account" that it
>> didn't before?
>>
>
> My understanding (and testing) is that wait_event_timeout() will block
> for the duration even in the face of interrupts, 'freezable' will not.

They have different behaviors with respect to *signals* and the
wake_up() variant used, but not device interrupts.

dmatest_callback() employs wake_up_all(), which means this change
introduces no beneficial difference in the wakeup behavior. The dmatest
thread gets woken on receipt of the completion interrupt either way.

And to reiterate, the change regresses the combination of dmatest and
the task freezer, which is a use case people have cared about,
apparently.

>> AFAIK the only change made here is that dmatest threads effectively
>> become unfreezeable, which is contrary to prior authors' intentions:
>>
>> commit 981ed70d8e4f ("dmatest: make dmatest threads freezable")
>> commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")

