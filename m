Return-Path: <dmaengine+bounces-4392-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF36A2EFB6
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C061888C89
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB552528F6;
	Mon, 10 Feb 2025 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FSSEhqv0"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93092528E4
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197606; cv=fail; b=c0ym7/qGVNdzN3ndoztg2LNhc7A7EBNLE3onvvDV4VvRhiXzX18mmPXPKA52OxXFfM9ciKQi06QPqaCc8An9AeJho9N38RbrBHPrYOmrIr6l83Ed0jLQWmWDHI9XamZU4uK5oY62jJoJuDhq7tiIIYH6CTzRDq8QfYhglmLnpVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197606; c=relaxed/simple;
	bh=CLKlfVmgwdYv4smLoAY1EzJ5OyOHwJyvbHHUcp6Xol0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e1Jijy0lsE+a96PCbCm60/uoEyFcvctK124rWFgQcV5bNdut7ldR2SvoIJxzLKnAFTQFNt5uQuGv5lwkoZp86T8NVdvyjgyslJSE6c5+sCg434ma0JnjUImM5hma+FlBl6w8wJJtMfZmNfURQwCrFSNGvBRoWPmCkbi1Ylt5PJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FSSEhqv0; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTx1da1DtYBuWkQRZxRBVVb59YD+1Vo5rjjTx37bvLb+PtGPCzZ0bsOcBY0PJz5zVeDLEeJrmXqezbtoAqHMDhcGGSuOBSTj9lus0l29lp4nFTaBdBkLHgnqguLNb/rSVMt2VY0D8mk+vn8i3sbwKcU2NE774r6kWB9d7o7GISOU9mcLVLWAgWYT4FJmddCwcgQzaAuQBOoXa9tZz7sQmELMWA1KSxWWiXHXlgNmERhFv3uQxB2t1xjKcwkkyArUqTLW/qUchV+pYM2vJN4K+sxlBkWK9xgO8zWgbCIMBZKL8U8TPMByuO7KHwGnt7rV6LoCki31b2jPvujQ+HoZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adXPLlGKXuZWPGK+C1c5i9NeXkVeDVnuhF2gPxZMxGw=;
 b=igCQQLE0XETcsrNtBtxXsiaCJHcgnRcVeudaBlJBjCa+MRfXDw9Do7LXK0REet2m5lWgsKF61A3eQNSU2rz1cTVcW7MRfFmNZTRPhbVUTRAy5cy7s16vOg6MXCdv01l8DWicXFwzxnYyAqVXc/CoMw/MpYxN9nPtaQh1VVv3nHyg5v/lpBf1l1alVamrVM9v+paNNoqAhIm4EgR2AFooisHf4aI5iE8wbkZ/Wosc8nq9CfTlvXC5cXbm1x0pkCK0W1kvpu51i/J4i3TQiCRAopQEKu4aqGJxySvRQpSrS/xwsF1W0T0GpuEenbL5lgYaQVU1i7ZfkyAUXqG8OSBXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adXPLlGKXuZWPGK+C1c5i9NeXkVeDVnuhF2gPxZMxGw=;
 b=FSSEhqv0kU1ICm1icfCs98st2Qh/fJdZTwVfnQC7JLk9bW5jIUH5/jbJRoCRB1MTSpk75z+GoSjwKP/r1r1yT0up54m0nwodg3Uf3h6IDh5m8xa6PXNXQdtyNtWVbFoBG7CW/IVXB51EtJx7PtwsO/4kJsNQVut/6Qz//l1EtQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 14:26:38 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:26:38 +0000
Message-ID: <c568caf4-c69c-4e41-a794-4756ca8fbd93@amd.com>
Date: Mon, 10 Feb 2025 19:56:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dmaengine: ptdma: Utilize the AE4DMA engine's
 multi-queue functionality
To: Vinod Koul <vkoul@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org
References: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
 <20250203162511.911946-4-Basavaraj.Natikar@amd.com> <Z6oKqKncVc9AL2Tb@vaman>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <Z6oKqKncVc9AL2Tb@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: afe9b3c6-59c5-422f-8fef-08dd49dee244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjV3dm81bmJnUzVvdUw5SWxaMGRsUVh3TEpWUDRyNkxsMHJBSXlsbXJpbW0w?=
 =?utf-8?B?c1hza0FYTVJqbGJJaFowN3Fpd095T3AyOEZrbFNTSnZMaHVHTExqUWZtT3Nx?=
 =?utf-8?B?RE5pRnFFMXcxKzBzbGZ6ZW1COUUrNjR5eVc2aFdDdVZCWDNwQlROdm5WRkZy?=
 =?utf-8?B?MGpvYjhRbCtFTXJ0cmV3Y2NIWm5EdTZtSmJ0TmhKT0x0U1dESjBDNEFLQzBW?=
 =?utf-8?B?eHJFWE9oNG90YjFrWmRSYTRxclAwT08xQkhsdHdFT0pwb3VtSWFiSGJpeHNC?=
 =?utf-8?B?WW43MmJnUzMvNndBVGw2N0c4Vm9EVXIvZUxua1VOb3lOczE5NTdXSk5lNE10?=
 =?utf-8?B?UVlyS2tWNm45Mm9sVVAwNjFqdGQxNjVGR3hiQzBMS1pYZU1DRThUSFNEZnNh?=
 =?utf-8?B?Q2hqUlhlV2cwRUtsWUFJQkJoTC9kdlVlRUZUZnE3WkZCRnoyTllQdGwwVCtN?=
 =?utf-8?B?QmJmVUpwRWdyRkozeXFPeTJuVUlwNjl2V3NHNkhFMTJubnRaNG9zOFhVNDgr?=
 =?utf-8?B?WUs5VndJOFQ0RHkwZGhnQzFzb3lzOU9tZE54aVhUL05WMk82MGduMHVHMEpa?=
 =?utf-8?B?MXVXSy9rMFg3WnVVQWpVVDd0WjZuRmVTb3pJVXlVU0hEYmQ4bjNPajZFbW03?=
 =?utf-8?B?U05SWEJScDMraEsxNk1NR28xbjB6VHV6UkVIU0dTQnBHZm5yYWErR2lSQkFX?=
 =?utf-8?B?Wmh3TjVLTDVKZUlUS3hzc1dkNHNyTXZNSFRrY25UaHNueTh6R2Y3NDMrMlVr?=
 =?utf-8?B?MFBnQm1GNzFuZVJiakZlcUpkZitIczJKK3YyVlNQUTUxSHR5RGswZUNQam5T?=
 =?utf-8?B?dUloNURsOEVqVDJmL0pDL08wSHBqZnVSOVBPb2hMcTZEU1crdCt2MTZscVIz?=
 =?utf-8?B?ejJuY0JDbWlkaUZ6bDFPYkk1OUdoM1RMR2Q5YUtGbDU1aW9CZ0krV0E0MTh1?=
 =?utf-8?B?eWNyRzJXaXc3eXQ3VkxhY2k2Slo3MzlMcXdFSTM2ZTU2bXBUb2R1WlAzaFpn?=
 =?utf-8?B?TVR4RmQ0RzRJeWwzaG1WMzVXTmtTdUUxQnRMa2MxTEREUkVtM1pONGhXUnVh?=
 =?utf-8?B?RGQzVjNpS2JHbDVOYnVCeGl4eG1uNDhjRWlPUGhRV2pHWWRFZTZ3bVJKemNl?=
 =?utf-8?B?K1JOODk3Ynp4VkVVWVpzUG1aQzB3dmIyRnR0VjVjSHB6MUJ1aGEvajh3TVQz?=
 =?utf-8?B?bnZTSTZabkM1Ry92aUZMM0QzWi9QQnpBd1c2OXV1MWJaM2Z6dWZBL21ZZXNE?=
 =?utf-8?B?NGdCbHlpYzJvc2I3SVFqZTlDYkxWUTRUUHlSZEN6L2F2MjIwRVpVUWp6cTJi?=
 =?utf-8?B?VzQ0SGx1Wjl0NG8xZkJQNWNrMzlkNStYbUhDVnlVL3RnUmdnUGU4NkFCWTEx?=
 =?utf-8?B?T3l4c1RnR1gvWDlQSkFiMUNOTGpRQ2JDR2VCTURib0k0aHg1TFRKdElIQ3lB?=
 =?utf-8?B?Tk0waUJRdHRqanVaOHI2S01DZVcyR3hjTzNNaWIvM0hmTURGVk51d2ZTWUZn?=
 =?utf-8?B?WWlzNWFKTFRLSHV3YmlEcXpoRG9VditDWnlXb2Y3NklCdGo1eWZKTEN0Z2Vk?=
 =?utf-8?B?OWJyRWo0d0FWWjNNWmU4aEY4dGtZK1RhcmdrL3pySFJDbTNuZ3hSYWU1ODd0?=
 =?utf-8?B?WUY4TEl3RktOemRGU1g4NGhXbjlCM3VCV29DbExnZEs5Z1dGRWFpZW5aZVdE?=
 =?utf-8?B?YzdBL0pnZUthYW9oSkRqM2pKL2RzREt5aW9ML0VCNXJxMk5NMTQ4cUZyanB6?=
 =?utf-8?B?dm9SRkFudWNsa2lhZ0RpajBkMWtDZVhtREFreGJocitORDJxZURZaWljN3lF?=
 =?utf-8?B?ZitUUUMvL2x0RU1HSVZsUHBRVis2MExhczdrT05YSWZpZmhaL1RRMG1oM2Vz?=
 =?utf-8?Q?BRyfMzqOHkNUr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTBUUjNpdGVRN01kSG9SZ2VtOHVwRk9vV1Y4WEhtYVNCZEJjVmRhVkFySStm?=
 =?utf-8?B?eFRuRzNoMkIzM1M5Ull4Rzh0Zis0S1ZDN1hrcGZlWHBGM1hmUThNRmJ1aGFp?=
 =?utf-8?B?TVppQ044dVBqU3VCN3B1MmtlTTJ6OENHUmM1ZmI5cTNXRDhYanNyU2hrcUxn?=
 =?utf-8?B?bUZ4UWpuSm9MRVB4RnFWSDNiZzRBUWZZbXVKZ0E3cW1jZWhYb3hYSG0xc0NN?=
 =?utf-8?B?MHc5czUzQzVpVEpRMmpwUENtRFBEVjRSeFNxYUloSXExQkxPS3ZkaXpLMUtG?=
 =?utf-8?B?ajZPUmZUaW5pNm1reERGN2hGTnVKaFhjSzg5YllHQms4YXQxdzVuV0V5R1Az?=
 =?utf-8?B?OHg3T1kwb0JPQnhPVTZRWVQ2ZnBSWGRzLzFSa29iK09PQWZtaEdxd0MzYTE1?=
 =?utf-8?B?MGJ1SkpPQ2tsM1BrMCtYbjJsQ2hXSFFhakkvTUxtVHpUSHVKZkZET1EzVDFB?=
 =?utf-8?B?SEFPK0JRNCtxL3pRem5VWHZKQklkbTF0THcwOEl0ZlhpaDN0U0x2OHlBZ29E?=
 =?utf-8?B?VnZRWkRoUEVVRXl5SGJUZEhhTnR1c1lMNldmekRGbHZUWnB2RG1VU0J2MkRH?=
 =?utf-8?B?NFZHdEJyd2tVR0tsNjN2WVpBUFQ4d0t5VDZCSkVpV0svbkR2NXNNY2JkcVdR?=
 =?utf-8?B?NTY4TXhFM3V5aUlkemRmczVxcXkyNGNBcW9wSkwwVFdLNjQzMFpJTElMdFdn?=
 =?utf-8?B?blQwMjhrTC9FcnNsT0N1Y3NQMy83NHU4aE84RFdWbWNhNUNhKzRMdkt6NFJG?=
 =?utf-8?B?d1lKV1gyYmxKcnYvL2dZQ0ZIUmRLT0J6YzZtWnVUYXRRWmxiNjMwd0RQcVNp?=
 =?utf-8?B?a0ZVMzZGS3VkRFpuSGxXUjdESDJvSURMRWE4Tndtc3VSL3Z5akpvd1pld0kr?=
 =?utf-8?B?OU1xc25pMXBoN1p0azZ1KzI1V1MyOHZHaTZlamZOeE9QemJyMTFxck1qcGZw?=
 =?utf-8?B?MzE3elZvekZmMmtTVHQ2MU5rWWJPR3ZDWGtZSU5lZ01VUTRTdSs3Rm4yOE4r?=
 =?utf-8?B?cW9lcEgwSVQyZWEvbGorUU5KemRjbWRoaFZGbmxFTWFTRjRnWnZKN2Q0bHJH?=
 =?utf-8?B?OHJnZWxZMmh5ejdLb2FqSVlkYUpnNU9tZTJ0NjVCR3Z3V2VXSkVYdlpYb1ZZ?=
 =?utf-8?B?M3JaS05Id0JOVDdJRVhBSXNsRnRqSnByZ1AyVkNhSHN1d3hNZlZhMmNGekJR?=
 =?utf-8?B?OGxLeTlIc1FVRnVJMzdhN2UrQkV1RDNBRmpXSnJFcE9nV3VvY3RuQ090dGtu?=
 =?utf-8?B?UlQzRHZ6SFVGR0tsOG9Nb21TbzcrTG91ZEpJQm51TXdkTHdUU3hXc1BhaUdl?=
 =?utf-8?B?bHFieSt0NDViMGFpV1JkOHNsWk5GQTJxbFl2eDR1WHlIcHFqbm02VmhWYmJl?=
 =?utf-8?B?OWtQOHRzTlA0cnA3T2FaaVVwNDlsa0V3cVJ2ZXVtcDdzS1JadHFSUzh1Nyt0?=
 =?utf-8?B?OEVVWVF5dmpiKy96QTlxbjFKM2FDZWhzd2hyQTRyc2NXMkpRcDA4dURYMG1z?=
 =?utf-8?B?ZjNCS0hJaDFiZklFbEhBNUk0TUR5WStOUlZWSnNMZ3hEaFo0aHV2NnFmYldj?=
 =?utf-8?B?OUwvL2hiRGNmNW1vSVdvVitsQzVCeU9SNE8rekJ5dkI5Q1BJeXZOVGRleVVm?=
 =?utf-8?B?aVpFQlF0UXFNaUcvY2R1cDI5MG1lRjUvS01wUkdNbHFwOFU3RkcyMmkxNzRk?=
 =?utf-8?B?c3YvazNJeEd1U3FHVzVVVDhldGFEVG82aVFZMnNhbk4yeWpJVjVrWktRRGJu?=
 =?utf-8?B?b3FwenRPdThsd3A1aE4wZTd4Qk1ocWlEakVzRVZkRHByMnlVcG9nWC9ZNnJ2?=
 =?utf-8?B?Z3RYQ2d4SE1TUVAwRjJiL3gxWUZaazlKUzkvbnVQQ0k0SmhiM21mUVYyLzlz?=
 =?utf-8?B?OThPRU1wcGN0VzJ4VzdrUW9ya1VONVRCNzZRSlo3U05Dek9TY05yWktnRVl0?=
 =?utf-8?B?QlBTQzhiU1QzU3lXQkYxeTUrZ3lFV3BrL0IrVGF1c1pRZVVOTFl2WnFZQ28w?=
 =?utf-8?B?eXg2d21LTEs4U2NrcnZHbjIwU3VuOTkxSG9aQXJxOWFLaE9KdE1CbUU5WkVN?=
 =?utf-8?B?U2U5YVQ1dDkyMysxU20wWGd0L3lSOUx1azR0aUh1ampQRk5kRXpPdyswV0xz?=
 =?utf-8?Q?TTCih7RIJlqeSkHWDuiF0z4Tz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe9b3c6-59c5-422f-8fef-08dd49dee244
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:26:37.9393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UO/7JgZyINpUEKuEfA7wdLaA8mvZaZDR5mqwj8QvoOLa23vrfk2eBPNXo1ge1IEBE1QM+4JJAjcb/fod/o30A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740



On 2/10/2025 7:48 PM, Vinod Koul wrote:
> On 03-02-25, 21:55, Basavaraj Natikar wrote:
>> As AE4DMA offers multi-channel functionality compared to PTDMA’s single
>> queue, utilize multi-queue, which supports higher speeds than PTDMA, to
>> achieve higher performance using the AE4DMA workqueue based mechanism.
>>
>> Fixes: 69a47b16a51b ("dmaengine: ptdma: Extend ptdma to support multi-channel and version")
> Why is this a fix, again!

Yes, as AE4DMA is much faster with multi-queue. However, sometimes due to multi-queue
processing, it takes longer and introduces a timeout for the synchronization of
consumers and producers, which helps avoid long waits that could eventually cause a hang.

Thanks,
--
Basavaraj

>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>   drivers/dma/amd/ae4dma/ae4dma.h         |  2 +
>>   drivers/dma/amd/ptdma/ptdma-dmaengine.c | 90 ++++++++++++++++++++++++-
>>   2 files changed, 89 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
>> index 265c5d436008..57f6048726bb 100644
>> --- a/drivers/dma/amd/ae4dma/ae4dma.h
>> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
>> @@ -37,6 +37,8 @@
>>   #define AE4_DMA_VERSION			4
>>   #define CMD_AE4_DESC_DW0_VAL		2
>>   
>> +#define AE4_TIME_OUT			5000
>> +
>>   struct ae4_msix {
>>   	int msix_count;
>>   	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
>> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>> index 35c84ec9608b..715ac3ae067b 100644
>> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>> @@ -198,8 +198,10 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>>   {
>>   	struct dma_async_tx_descriptor *tx_desc;
>>   	struct virt_dma_desc *vd;
>> +	struct pt_device *pt;
>>   	unsigned long flags;
>>   
>> +	pt = chan->pt;
>>   	/* Loop over descriptors until one is found with commands */
>>   	do {
>>   		if (desc) {
>> @@ -217,7 +219,7 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>>   
>>   		spin_lock_irqsave(&chan->vc.lock, flags);
>>   
>> -		if (desc) {
>> +		if (pt->ver != AE4_DMA_VERSION && desc) {
>>   			if (desc->status != DMA_COMPLETE) {
>>   				if (desc->status != DMA_ERROR)
>>   					desc->status = DMA_COMPLETE;
>> @@ -235,7 +237,7 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>>   
>>   		spin_unlock_irqrestore(&chan->vc.lock, flags);
>>   
>> -		if (tx_desc) {
>> +		if (pt->ver != AE4_DMA_VERSION && tx_desc) {
> Why should this handling be different for DMA_VERSION?
>
>>   			dmaengine_desc_get_callback_invoke(tx_desc, NULL);
>>   			dma_run_dependencies(tx_desc);
>>   			vchan_vdesc_fini(vd);
>> @@ -245,11 +247,25 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>>   	return NULL;
>>   }
>>   
>> +static inline bool ae4_core_queue_full(struct pt_cmd_queue *cmd_q)
>> +{
>> +	u32 front_wi = readl(cmd_q->reg_control + AE4_WR_IDX_OFF);
>> +	u32 rear_ri = readl(cmd_q->reg_control + AE4_RD_IDX_OFF);
>> +
>> +	if (((MAX_CMD_QLEN + front_wi - rear_ri) % MAX_CMD_QLEN)  >= (MAX_CMD_QLEN - 1))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>   static void pt_cmd_callback(void *data, int err)
>>   {
>>   	struct pt_dma_desc *desc = data;
>> +	struct ae4_cmd_queue *ae4cmd_q;
>>   	struct dma_chan *dma_chan;
>>   	struct pt_dma_chan *chan;
>> +	struct ae4_device *ae4;
>> +	struct pt_device *pt;
>>   	int ret;
>>   
>>   	if (err == -EINPROGRESS)
>> @@ -257,11 +273,32 @@ static void pt_cmd_callback(void *data, int err)
>>   
>>   	dma_chan = desc->vd.tx.chan;
>>   	chan = to_pt_chan(dma_chan);
>> +	pt = chan->pt;
>>   
>>   	if (err)
>>   		desc->status = DMA_ERROR;
>>   
>>   	while (true) {
>> +		if (pt->ver == AE4_DMA_VERSION) {
>> +			ae4 = container_of(pt, struct ae4_device, pt);
>> +			ae4cmd_q = &ae4->ae4cmd_q[chan->id];
>> +
>> +			if (ae4cmd_q->q_cmd_count >= (CMD_Q_LEN - 1) ||
>> +			    ae4_core_queue_full(&ae4cmd_q->cmd_q)) {
>> +				wake_up(&ae4cmd_q->q_w);
>> +
>> +				if (wait_for_completion_timeout(&ae4cmd_q->cmp,
>> +								msecs_to_jiffies(AE4_TIME_OUT))
>> +								== 0) {
>> +					dev_err(pt->dev, "TIMEOUT %d:\n", ae4cmd_q->id);
>> +					break;
>> +				}
>> +
>> +				reinit_completion(&ae4cmd_q->cmp);
>> +				continue;
>> +			}
>> +		}
>> +
>>   		/* Check for DMA descriptor completion */
>>   		desc = pt_handle_active_desc(chan, desc);
>>   
>> @@ -296,6 +333,49 @@ static struct pt_dma_desc *pt_alloc_dma_desc(struct pt_dma_chan *chan,
>>   	return desc;
>>   }
>>   
>> +static void pt_cmd_callback_work(void *data, int err)
>> +{
>> +	struct dma_async_tx_descriptor *tx_desc;
>> +	struct pt_dma_desc *desc = data;
>> +	struct dma_chan *dma_chan;
>> +	struct virt_dma_desc *vd;
>> +	struct pt_dma_chan *chan;
>> +	unsigned long flags;
>> +
>> +	dma_chan = desc->vd.tx.chan;
>> +	chan = to_pt_chan(dma_chan);
>> +
>> +	if (err == -EINPROGRESS)
>> +		return;
>> +
>> +	tx_desc = &desc->vd.tx;
>> +	vd = &desc->vd;
>> +
>> +	if (err)
>> +		desc->status = DMA_ERROR;
>> +
>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>> +	if (desc) {
>> +		if (desc->status != DMA_COMPLETE) {
>> +			if (desc->status != DMA_ERROR)
>> +				desc->status = DMA_COMPLETE;
>> +
>> +			dma_cookie_complete(tx_desc);
>> +			dma_descriptor_unmap(tx_desc);
>> +		} else {
>> +			tx_desc = NULL;
>> +		}
>> +	}
>> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
>> +
>> +	if (tx_desc) {
>> +		dmaengine_desc_get_callback_invoke(tx_desc, NULL);
>> +		dma_run_dependencies(tx_desc);
>> +		list_del(&desc->vd.node);
>> +		vchan_vdesc_fini(vd);
>> +	}
>> +}
> Why do we have callback in driver...?
>
>> +
>>   static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
>>   					  dma_addr_t dst,
>>   					  dma_addr_t src,
>> @@ -327,6 +407,7 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
>>   	desc->len = len;
>>   
>>   	if (pt->ver == AE4_DMA_VERSION) {
>> +		pt_cmd->pt_cmd_callback = pt_cmd_callback_work;
>>   		ae4 = container_of(pt, struct ae4_device, pt);
>>   		ae4cmd_q = &ae4->ae4cmd_q[chan->id];
>>   		mutex_lock(&ae4cmd_q->cmd_lock);
>> @@ -367,13 +448,16 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
>>   {
>>   	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>>   	struct pt_dma_desc *desc;
>> +	struct pt_device *pt;
>>   	unsigned long flags;
>>   	bool engine_is_idle = true;
>>   
>> +	pt = chan->pt;
>> +
>>   	spin_lock_irqsave(&chan->vc.lock, flags);
>>   
>>   	desc = pt_next_dma_desc(chan);
>> -	if (desc)
>> +	if (desc && pt->ver != AE4_DMA_VERSION)
>>   		engine_is_idle = false;
>>   
>>   	vchan_issue_pending(&chan->vc);
>> -- 
>> 2.25.1


