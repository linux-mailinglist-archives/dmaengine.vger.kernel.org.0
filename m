Return-Path: <dmaengine+bounces-4734-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC04EA5F751
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 15:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A00819C09B5
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A623926773D;
	Thu, 13 Mar 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uDHtueXP"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7230267B81;
	Thu, 13 Mar 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875052; cv=fail; b=oBGCWUULlGsx0JiD9JDAYpP+nASmoanijMjZiG4PBZs4SRNzNEF8hBNYYXIBoSletZtj+YRUmKFzW8ReGaDnxbx7+DQCLEWopGmXwVJh+z90ndpBr7srvX9ghAUn9PMVq+/HNSR/pVpVXscEN/L7+TJLXyuHGAG//6//3LLXp1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875052; c=relaxed/simple;
	bh=xDzn0upzTDBigjBCxRftJWKoVKOtF94TMsJ5lu6RFu0=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sVVQqlYbfCBnJshJcTYgbEqtf+zEoBQBGhEt/f1A0VVg3yuLmAMewmYGHQMmQYLTsVfVw5NYYFWjh5FIuYy9yT2AbpWJX1oZWuyTnH9rhT0HSskq+wf2iZkWkLxH7nvzWcF4CJeB1G+skVxp8RpX6MY9BvEx5X+hEWZjoBteRIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uDHtueXP; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9Xxc1jvxfwxARhJvAlLZiiSt8NWqHEHT8usVZ8fJEUPYaUU9s6bSZLvwsCNmkS7uTSDo0EOkLf/NEpl4OskSq3NMKJY6BXrHhFvAAlG+biPRkj6BdD4yZHa7RWlwhnM6c3favu5vZc7lNYW4jp97rielbnBu6gOv/E/BZoqiYOwTRslMvAqNNbG32Yw/82Ef+wAMB8SdA3xZG9pUqUS7m++YMhfNTyuEGI/IZ3qyNC8LKji1NgwGWsU/eRLOFCOncSNlrW86PY5iHH5hS5HVR6+uaBeG5kHrgAXKYywTdDBR8DSEnhMRcoIDSC7I43+uKvWpS5a+TSrSkHkBEyRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDzn0upzTDBigjBCxRftJWKoVKOtF94TMsJ5lu6RFu0=;
 b=q4N3k02kPVDMigRmlfCmImG1ztWRc8SRo2bsFbt4NyY3e09U/Gr6L+D0qqtFN2l3blSUYHQjH2FMDlFm70/A7OtaCw3Auy7gAPb2X325zoEEiGmBDXenX162RgAO64MSRarNrGq79k41tZGaROa6yOhJ/eKEv3hKko92BvsXPgQwSvQCHk19v2tmbYMl5VdrPHoo5Njz9gJiinkR1jx89X19awwxyXBjiLr8PdnahmUuMv2LdyQNS+bE4SrM3nAkbFvRP8DgBMHESMfC91SQ9m67Y8hxbelyy57HvNUE+V1+Iv9bG+aJDxRF9+1JavfZINsSPOXbPkLCd16J+u2M8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDzn0upzTDBigjBCxRftJWKoVKOtF94TMsJ5lu6RFu0=;
 b=uDHtueXPmvKlZuhB5j5MjpTFM1IFx5fIvjNQ9QH7nopKdmOiicu+i6UpdawdXdolk9BUW8a66bdTSPhQxWHrqdj+LHQMrG76inZVyqBjAOzXbXu6lCtaa3BXOHgBzDQDPfoO8sGXfYW/aVmiCBmtmfsnbaC7rmRqb+zYPBAS4Zk=
Received: from MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::13)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 14:10:46 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:531:cafe::ea) by MN0P222CA0003.outlook.office365.com
 (2603:10b6:208:531::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Thu,
 13 Mar 2025 14:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 14:10:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 09:10:44 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vinod Koul
	<vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave.jiang@intel.com>, <kristen.c.accardi@intel.com>, kernel test robot
	<oliver.sang@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
In-Reply-To: <87senhoq1k.fsf@intel.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
 <878qpa13fe.fsf@AUSNATLYNCH.amd.com> <87senhoq1k.fsf@intel.com>
Date: Thu, 13 Mar 2025 09:10:42 -0500
Message-ID: <874izx10nx.fsf@AUSNATLYNCH.amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c4289c-aeff-4aec-2672-08dd6238d8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gh+tYNrP1QdNWEiCR/oPZA0lNdJ4mcshFxLiHngFHcRF6XSeVyENuli0qdIZ?=
 =?us-ascii?Q?mhVfMQvlxg3ePXFLjqMBqtVNdIdWZHD6mXQC9B45zYsMK8w48Y25IVsSHnGj?=
 =?us-ascii?Q?TRhkuyjqRg0CBo/F6zhLf/sR3jxUJgFXX/FbW6gXcHbWxu58Fm2PscVzDgsP?=
 =?us-ascii?Q?s7x3g+89VO0zCM51A7HH6EsyJH7VOxkdhcf3OEGhR5Mt+60hiWlFFQq97fiA?=
 =?us-ascii?Q?a2n1rYKl2MxBGOKbFXrxC9kHT8Q3fH9TtCCRWpR9D8tzbFX/9tFZA7Ao0LKD?=
 =?us-ascii?Q?z7ZvooplaJEeJvwgERKPyznxLZctbDZmb7d8HGI8xvLEOA86w7cy877JR8MJ?=
 =?us-ascii?Q?gs9kO/L2TRxxiAIaCdVen4qFB/h5kSWMfT9f6K34NVfAZTRXKaAo7vlNJUlQ?=
 =?us-ascii?Q?nKLnpSSm2RcjuYY0NYQesIeUkA1sDpBBez4Ujh5s7vSLIHoAEkEstjFx0pLq?=
 =?us-ascii?Q?Pylf/rH38Khj5XfsmZ8EaJlXySQLu7MpzoY2kgeTAiJE49vClVRLjzz57Kvj?=
 =?us-ascii?Q?JUn1fPOanHLjQ05/I6tbKwAm60RQrNiL3yoXWW1dpf+iaE4JEZKZIQVfw/qC?=
 =?us-ascii?Q?h4I0kBlcAnfEc9J4zEZecDNV45H+lDzrc7Z1lH8nyjgr/wt0VbLVCsj0AuJW?=
 =?us-ascii?Q?ETrJJDWAZ+m4dIxfH3ByJR4irc/Twf/T+FflfX9QZBL3wvjOLLyoldjScMM8?=
 =?us-ascii?Q?kyvAvc786NySqg5YQskDg4Wl0XZpMQo/Eq1zMTr6PM4LZUm9UDNd//qx9ShL?=
 =?us-ascii?Q?pkBjwWEmkbvrsVP3eCLoQEW4Rso8VLNgyrqqCI5DCe/25jDJ2i0ubGwvsiMo?=
 =?us-ascii?Q?mogDXsA1Ihxyp32RZi0ONTXZ2hWoX9p2fkzXkH9jbJacZCgXkrP18u6fKL0c?=
 =?us-ascii?Q?P5UOSO+nB/+oHHeTNjvgMtD92qfeTnEd1c1yW+a+Y/Jfb1I200d6Ebft7FyY?=
 =?us-ascii?Q?/J2GlOt71ILrF/yI7fNE/d99+HBc/McSonxzzwAKFVwbxorRXXESSEWRTXRQ?=
 =?us-ascii?Q?vY+DYFupTDJxD6L3ZFvWchj5VmHzwSZEtRujOtOFeSt/QAxH/nxpjsom07QQ?=
 =?us-ascii?Q?ir6N7uF4DFv/4+glmau0HWcO8xq/h+Fe/A7WPsJXblGyTOStGF/IKsM1aFAl?=
 =?us-ascii?Q?2u03UM+2uGhXMUbCNFu5BDFs2jUAeLpl3RgLiponS62R3gLMzF7T+TcU7D0d?=
 =?us-ascii?Q?hL5EwBQgDXYOlbE7zm3GTwFmIFfzyavMnq3HATD7GGTVvp3jQqzSFqFrP/2t?=
 =?us-ascii?Q?N7CNqMmy+Bea6QyiGpNZBUOl0rkS0n//rU22vNaEeEFie3h7MyMHUdWqMDr1?=
 =?us-ascii?Q?6M9hJC1nc05MG/UKH1LNtmOlHMOPhUbQjcaP4kFmEZNPowOtrezP3N1QeNW4?=
 =?us-ascii?Q?QfRGUoaX6gLqBzTC5Q9aTEc5PxI78uyJ9o9c61k80NKihT8pY6JHAz847Poo?=
 =?us-ascii?Q?P96rlMwQJIoubM9zZLH2Be0jVgjnxD7xpMlRHQxE3Cim+SknUYiOlDe5f4JD?=
 =?us-ascii?Q?IPHPaIxbMmSR0/w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:10:45.0786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c4289c-aeff-4aec-2672-08dd6238d8c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944

Hi Vinicius,

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
> Nathan Lynch <nathan.lynch@amd.com> writes:
>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>>> Change the "wait for operation finish" logic to take interrupts into
>>> account.
>>>
>>> When using dmatest with idxd DMA engine, it's possible that during
>>> longer tests, the interrupt notifying the finish of an operation
>>> happens during wait_event_freezable_timeout(), which causes dmatest to
>>> cleanup all the resources, some of which might still be in use.
>>>
>>> This fix ensures that the wait logic correctly handles interrupts,
>>> preventing premature cleanup of resources.
>>>
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>> Closes: https://lore.kernel.org/oe-lkp/202502171134.8c403348-lkp@intel.com
>>
>> Given the report at the URL above I'm struggling to follow the rationale
>> for this change. It looks like a use-after-free in idxd while
>> resetting/unbinding the device, and I can't see how changing whether
>> dmatest threads perform freezeable waits would change this.
>>
>
> I think that the short version is that the reproducition script triggers
> different problems on different platforms/configurations.
>
> The solution I proposed fixes a problem I was seeing on a SPR system, on
> a GNR system (that I was only able to get later) I see something more similar
> to this particular splat (currently working on the fix).
>
> Seeing this question, I realize that I should have added a note to the
> commit detailing this.
>
> So I am planning on proposing two (this and another) fixes for the same
> report, hoping that it's not that confusing/unusual.

I'm still confused... why is wait_event_freezable_timeout() the wrong
API for dmatest to use, and how could changing it to
wait_event_timeout() cause it to "take interrupts into account" that it
didn't before?

AFAIK the only change made here is that dmatest threads effectively
become unfreezeable, which is contrary to prior authors' intentions:

commit 981ed70d8e4f ("dmatest: make dmatest threads freezable")
commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")


