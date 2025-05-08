Return-Path: <dmaengine+bounces-5110-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B1FAAF85C
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 12:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AF57B2388
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 10:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6A020B813;
	Thu,  8 May 2025 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="USFsIrzD"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471004B1E78;
	Thu,  8 May 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746701460; cv=fail; b=ttK2GpbwuJT8RDmNyNP56nwVLakgDVMU636bM9FXr6TPW0A81YPr93rD+n2I3VdgZKmnEUa9sKcu6VJOxgHBHfnjqSE8+dsb5Rb+OAQBdRaU2JPZc0z1YjCXNPo0zEeve0L1kJvcQkZctYqZVs1cvMib5oMP8vS7kW7qHQIMM0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746701460; c=relaxed/simple;
	bh=3bPCQKo+BJtU4ZRs5wDAkkJ09xktGJ+xsQbC3QdT71w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PvIb9qDiqDf6W/nble6LB96827TBGHcKas3zsryF8gwkxfRE8wi1SgkNsHgJDc453VYQOzXGOEdqePddKUdZycXO+hx0Zla3SH6vo3YJV0GewtDU9hCz18WgypAGxsvIDWVMsYBBUePwEEkO0AU7KP6hGGjw+xiRM0D0ob34OCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=USFsIrzD; arc=fail smtp.client-ip=40.107.101.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLUDhCy119pyC7aHqecqvJu1vonl67EYGQ1aHpY4ssw8EI3LMhaGUzntc2mMZ4ytTDddajuyuagazMx100p5qlPZoMpqhEIde+4Gg0ytPMxGP/pnZKv5fwzaQwMZLUnrwCjxyGxmgtbVfKltjhdAWLQPWPpyVg+Rzyt7Cvk3jWQwgnR5mxFr1JRE7e2cSrKppKpsCpivxesMBh9GZ+2VJ5TAI11Sc+SsBSMM/NgiXKwhDCoS4KT780uoIsdsszDxqPJTbPuonT625lfW9/bO5oIv+Mb2EKcOJ0OHjTb4eDmaDKEK799b+HIuTQdfj4zV4/tdKQ6HMm3EsIBSezBJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foIPHErUSzFYGPToOGUIbqFLMSMhlY8Pv5h0FBxObW4=;
 b=T1vtnptgoXF5kQ9/Y4wWvJB9yabh6hEhlTZVy+C/58P5LCexfzI1q9JjYwUNDcMcvAsQWzDbcvxqA1g9pLcnDQrVCl/Fyn9K2+wXIsPlHKmUWRfgRRyskilYmU7FKYhZLqvgm1MprY9ok9NR/rOh4nP8a0wwy1ya/Mp6xjPrzQ1agHoCo29CVhsEQuw/dtHQZ3rIFEt8NNOMQuz1GG3JLZr8l2jwxCYbtreawiJB8vzjnESC7Pmw2F0Q1FA+BxiJ9vvc2nbesxeVZmQ72gq6oYzmoAubB+6wtvQlbPbrUHEiXNbXxUmsd7AM4VfZKMzRna1eKO+j/dcths7naB6PGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foIPHErUSzFYGPToOGUIbqFLMSMhlY8Pv5h0FBxObW4=;
 b=USFsIrzDuvMeszluodxY8MOZm6GCHBrf01bWVhYlO0mAKmqLvymSoWhZACT0aksLVOR79vaAoQ4Dxp8X1GvV0GT7DtTFEIob+IZaLS6qhNZDgNVkjMBPlxtllP6LNsRdgHsBAYLdzT6XXBFqLr+0TAPhf2EiH8M0JDL6HNWk81SZXLheg4uHYmc80Xj3ws5YgQwHLcbzMHunNRscWc3fISXrTwQQr2m9l2VR08JKowURjUTTwSkjJiwxKhTgLf/j1VHI+PhtGgIFa4DmFFjRMBal5JOrW284EnAVie+ocaggmvhOIGVw0MZLzMHlvYgfPUKOut3wBnjq8r37mMqSCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Thu, 8 May
 2025 10:50:52 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 10:50:52 +0000
Message-ID: <9bf40c88-7b4d-45ba-946d-19e328be76c2@nvidia.com>
Date: Thu, 8 May 2025 11:50:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dt-bindings: dma: nvidia,tegra20-apbdma: convert
 text based binding to json schema
To: Charan Pedumuru <charan.pedumuru@gmail.com>, Vinod Koul
 <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250507-nvidea-dma-v4-0-6161a8de376f@gmail.com>
 <20250507-nvidea-dma-v4-2-6161a8de376f@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250507-nvidea-dma-v4-2-6161a8de376f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0242.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::16) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 83959c3c-d6bd-4e02-b33e-08dd8e1e3399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTl6eXRxUkZ4Qk5xaUVVNWRDS2FnaUs0TENMc1paMVdwMkxXTVFJZ3ZJSWRT?=
 =?utf-8?B?Rk5vM0Z3cGVzUkxZN2EzZkNyQldZOXhDSkNDUUFDT1QxVXlkbVlNM1U3cUdM?=
 =?utf-8?B?cDNuUWV4N1p5SVZRc25Eam9Td3dZY0s4RkFHRU9qdGZxaEpmSXIrYUQ2eVFX?=
 =?utf-8?B?OVkwZGZ5Tjk4VmVTWEVrU09HcXZKaTc0WTBJTlNYMFBpRVB2d3ZUVmFWVFpP?=
 =?utf-8?B?N0NJMjhubWxiSURsUFdqNC9la1BRallZL0ROcmJzdjVHTUlRUjFWb0FkazNB?=
 =?utf-8?B?Mm5xOVcwdVJMSHBUR1FsTE40ZnJEblhDYlNoNzd6M0tYbkVZOU5aZ25pR1JS?=
 =?utf-8?B?TjN3VnV2RjhCUXdNRWczaUJ4Tm9FU1ZuOTR2WjJTaFpIZ2J0dVZsbklEdEd0?=
 =?utf-8?B?NHFvb0h3UjROTUkyemhqaHFWemhnYWhOUDhpV1lBU3I3OTUrVGROeGV3Lzdl?=
 =?utf-8?B?U3N5ZjRlRjA3Tk5SVTZ4SUVIOGhHMlVJem5IK0ZEbkdmN3FaNzZ1Ui9Qb2lT?=
 =?utf-8?B?RVdXVjZ4SHg5dTIvMjNENmpBYUtncXVYSGptbXh5VmVYNzhRT3R0eHZadzRD?=
 =?utf-8?B?Nk1CZ1owZ2FSd3pLQWQvM01US2RhVjMxTzJOQ3Y5SDF4WE5BVFBMdVZPM3Vp?=
 =?utf-8?B?ZGU2TjBIOHpmTlJTb3dvbGlWdjhPWWQrMG4zS2kveXVyODB6YTMvVDhQb0Z0?=
 =?utf-8?B?UUNwZVZ1MkN2SW84UjZuNTMzOGxRc0J1OXh1V3p2azlGMU5rVnFRVXpKYlRn?=
 =?utf-8?B?ZkE4THhSSjZtN0pSbzhoaHZ4UlFRRWJ1Rjl1enhOSFJsOTNWdFhzTCtUNFFU?=
 =?utf-8?B?YW9iRG83b1NzSmxxdDB0d05kM1p6VUJlNEZYUkwwSHVNaEtXYUEvSGFPWnNN?=
 =?utf-8?B?bkVpWVRXR3BUVWVLZk1xeERMeFdYR3k5d1ZGNXNxci8xcDlvWCsrdE4xUVYr?=
 =?utf-8?B?dS9iZ002RU9TVUt2N2ZuZm1pQ2F2MjBFNTNEVTh2cXM5N3QvRCtwTVJaR0NU?=
 =?utf-8?B?Vk1Ia2pKbUdtTVNmSHhLT3phclFVdVlvbHpiVlloZmVlVmJzam5TRmhiR24x?=
 =?utf-8?B?dFdpUmNuTWZjU2JYQ3RuVFc2ZzhFNVF2UjJWRDU5NVU2OEtCWUVDZGprWWY0?=
 =?utf-8?B?SFBpcGNkNCtPdWNaclcvS0N5RzROSjBEQlRZSFBVUmxMT2JJaEYvWmdMWjA5?=
 =?utf-8?B?MXI0cDAvWFhBblU5NW82OUVtdkZaZ1hTWHpKU3c5V2VCNHA4NThoOGgzWHR3?=
 =?utf-8?B?STRPT1JRNnBVaHNCa3lYVThMaTMvT1haNS9wYUs1OUVmamU2cTk5YmVTZEEr?=
 =?utf-8?B?TCswM2Yrem8zdWVFdlJyYTVwUGZnSVNaVkxuVHJ6NEVCc0gycjhTMXVwVVlt?=
 =?utf-8?B?a1FkQzlvZWRwYXI2Z0xtQU1Jb2kvZmR0SDl2eUJxUXBnZUNUNnd1UFZHdlVh?=
 =?utf-8?B?U3RqT0g2UE5KcmF6ZVc5UkZWb2ZhaVRYZFBwSEJqcC9XS2dhSi9VcFd3ODFm?=
 =?utf-8?B?MEUwSDk5Y3NtL1I4WFEwWVN0QTNJWkp4OGZXTFdNV21ZRnRmcHYxRkl1ZU80?=
 =?utf-8?B?WjNCekV6MGRTd1RUZ1F2cHZSVXI3Rit3R2UxWGcwcjhkZ3hhV3BYNXNwbUNi?=
 =?utf-8?B?eGZWVlgwSTFrMlpncENQQlVhS2prSXhWdTdnSmRrQ3NCRCtuQStrMTAxYkND?=
 =?utf-8?B?SW5LV2NJWnc3djhpWHFWZFhxYllSV1JWeEtNR05oNjBwZUsvRDBXdnZaMnpJ?=
 =?utf-8?B?dktYNC9YUDdoMUJYV1Yzd1NoZmFyKzk3c1RIU2VBbkh3TkpsdjVjMEw0NXNZ?=
 =?utf-8?B?ZnRtbmk4ZXYvbTdDUk9PNEpCMmJtNW0vMFJ2SlVnWG1LdkcxV3gycEdTREVT?=
 =?utf-8?B?c3ErOExjVFVvNHUxN2VldVltRTRmaFVTdmIxdm5SeDdNVzZpZjc3QmtWNlB1?=
 =?utf-8?Q?y9tQS+MHlxw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXpKYzB6ZW9xdW5OdHR0K1c3eVYwZXdqNWQ0dXR5YjdXNWZjV2xZS2tSOVNw?=
 =?utf-8?B?Ny9KWU1QYWVnTFBZZVV4RkJhOGRIL0xya2p1bTgyd3NldXJVTitKRjgvNW1q?=
 =?utf-8?B?eFpqOEZKNzRBdnlHdmpDbGVjQVRQK1drOTQ0ckVXYlh0K2ZIemJjdWplQm1l?=
 =?utf-8?B?MW1DS2hhclY0VGFjVjcwZFByUHZkZHFMOUsxcUNCalJ1d01KUmlka3B0Mmdm?=
 =?utf-8?B?Q1lvc3EweHU4L3dxRWpldGZRUjRZNU56Q0lITmxkMXNXdytlaUVVVDRpZExO?=
 =?utf-8?B?Y2hKRzB6cWsvMlBFVTN1b3h5eDkzZHA5Q2gyNHVjK2UyT2N5L0g3Y3h2Q3k5?=
 =?utf-8?B?MkFvNG9udE8vY2RxekxpWVhMSkN0ZEplQWhLQ2tsckdOUnhWRVpNZWxnMXZI?=
 =?utf-8?B?TktWYm43NHg3aFBUdTA1bHQwM253MGhMaUx6MlVmQ3RBY3lhUkpsMThuS1lr?=
 =?utf-8?B?RVpJclJNS2hnVVZOWVNXeS95c2xCRDF3Qzg3VUxLL2ZlUmNQcFlEUnc4UjZC?=
 =?utf-8?B?Nnk3MGlTdGVlbnlxeVhBQ2tRTVVsaHF6QUpNcWhZUkgxS0Y2L1hOUE5LNTdV?=
 =?utf-8?B?N1pMcVh3OW1nVnFiYTNwVklPcWVpN2hmVzBhL2F3SXRaWDEwYXVleHZsTTdR?=
 =?utf-8?B?d09OazZHKzNRcHNXQ3FKazBaaG9md3lJUGZoZW5UajUyZXEzcFdQajBVOWhB?=
 =?utf-8?B?OU4wVkwxS2thYnNBY1RvRHZmNGNPVHRvdFV0WlFDVUhvRitBbEVOSUo0SWE3?=
 =?utf-8?B?bkdZVnMvOXZFdzFWMm8rTnFJa0lJWHBZN29xTmRQdE1oVmJ0dGdOeXJyR2pQ?=
 =?utf-8?B?ajg2eFM0WGY0UTZXMlZlVzZhdTB4Yk11R3ExM0NJdXh4M0FWb09SelN6R0Nn?=
 =?utf-8?B?VlZxSlZucS9JSHRnMmwwMk15UzZ4YnJGNldIQXJzVVF0VnRrQmlEQUd6dnJj?=
 =?utf-8?B?N2FvU0FPaDNoMDgyVlJXMXZuRlJZdlFML0VTc3NSMDVsUDEzRkRKV2lva3Fl?=
 =?utf-8?B?Q25aM0cxQjBIYkJQME5NeXVjcW5iZEdLZHRUeUIrKzBBUjRGRDlnWG8vb3ZR?=
 =?utf-8?B?NzhWYi9ZOG94aEtLVE9iMVBXczVjZlE2aEtIQTJrOVFVZmdFenRVWmQ0MkRw?=
 =?utf-8?B?QU96ZFpwK3JzbkkrWFFtYnlRaWpjVUJBc2NtTVVvWjl3WkZDU2hrWTRRR2Y3?=
 =?utf-8?B?S0g1Z3lJOVN6Tjc4Z2RwTHBQbTJvUVZHSi82MTBtaDlPd0dNQjNxbGg5cURI?=
 =?utf-8?B?MWo4Y2VqVjAwU2xqb2RCaHpxREROSlFwTTZ6UlZEOVk4NmN5cHA5SDkwcTBH?=
 =?utf-8?B?NXcrNE9xZmxWQmhERW1xSGg4dm5OM2taTm4wQnNJekFLNFJyMnJEbG1zQ08x?=
 =?utf-8?B?bWhjSndlL3dsNDVQd0wrU0FEdFZERS9ZaGsvSkJJYm9NNmt6WXhvZGlXeFZ4?=
 =?utf-8?B?dFNxYjByLzZENHhXdXRRekhYbFQvb0d6Nk4xZG9vNUkvR0FhS1NlTmRBYjRQ?=
 =?utf-8?B?eDBzTGMvRzMxdzZWMllzeU5wU3c2UDJ5Q3hsK3g3MkJXRktNTFp4aHFPR3pi?=
 =?utf-8?B?YVJHdDJVN0VnelVkWEZxaVVJWFdjaUdMQ2V1ZDkvR3greHd0WnhiMHdsWlNE?=
 =?utf-8?B?emdMQVFLNHd0K0NNR0VoQWVmSHNQNzBOclpTVjVVYkNWREtDL3hocEJLck0v?=
 =?utf-8?B?STg0TUNIakh5RElsdUFZMXErbnIwNUdHemd5dU5PQ2VsUlNYTzJVRDJ1WlBW?=
 =?utf-8?B?MkRBazNOZlZtbzV6eHBtT09NN1N5UHdjRVlDKy96ZHp1bHdHcUVqMUxxQnhZ?=
 =?utf-8?B?dTY4Wjdzd1RDUy9VNFdrOFBQVVBjbERqWVNQMDQ3UmNxeHR3akZxSGhjVEFx?=
 =?utf-8?B?OUpHSFBRVXdzanJqcUdCZzFmUGlHL2wwY1V0QnIzcnRzSWpab3pNZktwN2VC?=
 =?utf-8?B?SEMzdTc5MWN3eVA4VnJzK1pOT3Y2ZEh3dmtGamNhUFhMQy93TFc5a0NuRzRi?=
 =?utf-8?B?UW9qT3V5UHFNYmVab2c5ZHdrYWpBSHZ1YjhVYUNhSmZMYUZEL1NpeldjYU1j?=
 =?utf-8?B?Q2tVckt5UVZjYURVRm9zYWt2RGdDTDZLTkV5NlY4dzRUNmdaZmNlMGI0V1hw?=
 =?utf-8?B?Smw1Q0lKcW1pckUvTVlrbWJMMTJNckdLZkNvcDR6MkRlbTVBSEpZK0w3ME5U?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83959c3c-d6bd-4e02-b33e-08dd8e1e3399
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:50:52.5005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkvV2fLreHCoT/QbsuiJghgxgW36StmEEzH/+O2LQC5t1sZ7xtFMKOrs+kkuzQhzevQxBh8OLg4LovutHcP0sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966



On 07/05/2025 05:57, Charan Pedumuru wrote:
> Update text binding to YAML.
> Changes during conversion:
> - Add a fallback for "nvidia,tegra30-apbdma" as it is
>    compatible with the IP core on "nvidia,tegra20-apbdma".
> - Update examples and include appropriate file directives to resolve
>    errors identified by `dt_binding_check` and `dtbs_check`.
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
>   .../bindings/dma/nvidia,tegra20-apbdma.txt         | 44 -----------
>   .../bindings/dma/nvidia,tegra20-apbdma.yaml        | 90 ++++++++++++++++++++++
>   2 files changed, 90 insertions(+), 44 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.txt b/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.txt
> deleted file mode 100644
> index 447fb44e7abeaa7ca3010b9518533e786cce56a8..0000000000000000000000000000000000000000
> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -* NVIDIA Tegra APB DMA controller
> -
> -Required properties:
> -- compatible: Should be "nvidia,<chip>-apbdma"
> -- reg: Should contain DMA registers location and length. This should include
> -  all of the per-channel registers.
> -- interrupts: Should contain all of the per-channel DMA interrupts.
> -- clocks: Must contain one entry, for the module clock.
> -  See ../clocks/clock-bindings.txt for details.
> -- resets : Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names : Must include the following entries:
> -  - dma
> -- #dma-cells : Must be <1>. This dictates the length of DMA specifiers in
> -  client nodes' dmas properties. The specifier represents the DMA request
> -  select value for the peripheral. For more details, consult the Tegra TRM's
> -  documentation of the APB DMA channel control register REQ_SEL field.
> -
> -Examples:
> -
> -apbdma: dma@6000a000 {
> -	compatible = "nvidia,tegra20-apbdma";
> -	reg = <0x6000a000 0x1200>;
> -	interrupts = < 0 136 0x04
> -		       0 137 0x04
> -		       0 138 0x04
> -		       0 139 0x04
> -		       0 140 0x04
> -		       0 141 0x04
> -		       0 142 0x04
> -		       0 143 0x04
> -		       0 144 0x04
> -		       0 145 0x04
> -		       0 146 0x04
> -		       0 147 0x04
> -		       0 148 0x04
> -		       0 149 0x04
> -		       0 150 0x04
> -		       0 151 0x04 >;
> -	clocks = <&tegra_car 34>;
> -	resets = <&tegra_car 34>;
> -	reset-names = "dma";
> -	#dma-cells = <1>;
> -};
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..a2ffd5209b3bf3f2171b55351a557a6e2085987d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra20-apbdma.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/nvidia,tegra20-apbdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra APB DMA Controller
> +
> +description:
> +  The NVIDIA Tegra APB DMA controller is a hardware component that
> +  enables direct memory access (DMA) on Tegra systems. It facilitates
> +  data transfer between I/O devices and main memory without constant
> +  CPU intervention.
> +
> +maintainers:
> +  - Jonathan Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nvidia,tegra20-apbdma
> +      - items:
> +          - const: nvidia,tegra30-apbdma
> +          - const: nvidia,tegra20-apbdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Should contain all of the per-channel DMA interrupts in
> +      ascending order with respect to the DMA channel index.
> +    minItems: 1
> +    maxItems: 32
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: dma


Krzysztof, given that there is only 1, isn't the preference to remove 
this? I understand that this requires a driver change, but it should not 
break compatibility.

Jon

-- 
nvpublic


