Return-Path: <dmaengine+bounces-4888-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB29A892AB
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 05:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27714178A0E
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 03:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF131C700B;
	Tue, 15 Apr 2025 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vKU+zTJd"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7419B3EC
	for <dmaengine@vger.kernel.org>; Tue, 15 Apr 2025 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744689394; cv=fail; b=HE3EhhhQFE7Gn40L71idtqbjCe4Qfxg6DionBZVwr8tOe4u2Dd39F06KURdE67tGI35Z8WbetdD/fWbF0dfIpeF3yMdq5chZ6xT0rwTPxfxQWhv6qva7Cf+c+rYVI+N2jIRSPi6RQnNs+eQGyrkGuEN5+wu5EB07nA1tG2itXX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744689394; c=relaxed/simple;
	bh=LGwOqmHU08kUqMcHmIzTglENr3utePUBpONPli9QWpg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ye+8n+3/9hlrF1ea3Vvde5uYHdY6so0R4eGrwTB9p3M0FDlRWEl4/eedynZbd7l/AbRWSHQnbYHAQD/qsHRDMKAk29KWJvp7yAC0J+9g5pORJe0+K8KZBN2r4l6YiPxEHa7qNtQfCEfOi72HjRjb6LNl55BFZ1OU4f1hmdqV30o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vKU+zTJd; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUGpA8EldTczql+/r1AylE1cq5P6jJLXkFUA3iXJK6Wn9WhYs1buOQpLdGY9x54L356FvRIzxqzohiltZz6D7UeEvIew/WvhUHOCVTXwanhrU6S5IB0Zjpbhba8ZMldnp0s9NU4JiIGxlacZov4V3AuMjMsdvizStVw72Xwvl2Qmc08gVPgGSgG2bOgTvpxDo5k9RL73l1D7tvyvc6UgWeAoLu8Zc1/7eYw50U72VTogCLfaW1o28EaPuRAg7+ldOTEBa1FrKLdkyxlBIgSZ4fgmTyGf7IJNVDK8lUlJN49PS8S4UkmJiNMuxy8fuaAww7oCxeYPM82zoMCMiuCc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R561uTQBhZBSz8uAOZKo2bsmvp3OIVgL5zpxbFjQcY4=;
 b=ji36oNGCyB8CNZiVCFWdDHcfjX01AxvZhBoiWaJkhlrN5Kouj7EQbOJesu/DPRJV8y7AyoHLc+hBAaU/EcUG062Cq19+uo3Z9gmAidnNLEZGx3BUciDo50ELwouH23+fadOucoWvr1M6019zXKhyuCome+ZR5hoqafLQILEIKqKr1TZK/pfEM2xtwMrl+FxdiSWIDfb/+pHcmaHXCrID54s4duJxdStJV5UcPG72EFCKN5ynVhXCXg0DIjXiWjx3wCoxMcs1fkU+tsDn/9ozlC1nPE/N5YqIfGsfS1NAkIObzndWaTWr8PXm1VlkYgjRm1datqniW1UA1akEHcvOIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R561uTQBhZBSz8uAOZKo2bsmvp3OIVgL5zpxbFjQcY4=;
 b=vKU+zTJdVe8ScbNORROs/FU1E4rZ1oXlwF8YADhT2rPNRfvgARDDTSmTkbeXXWBgGloCJPI1nFrRw5waWc1y8qARohOid6vxgypbJL/oscQS/r/RE44T3xSCrblhK8ff6aU4DDmGvt+bnjOps74GlLdbEtm6PUGsHZrU/oY7V1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH1PPF8423FDA82.namprd12.prod.outlook.com (2603:10b6:61f:fc00::617) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 03:56:29 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.8632.017; Tue, 15 Apr 2025
 03:56:29 +0000
Message-ID: <bb316bcf-6842-4f11-a4db-d3cb23f31593@amd.com>
Date: Tue, 15 Apr 2025 09:26:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] dmaengine: ptdma: Fix static checker warnings
To: vkoul@kernel.org, dmaengine@vger.kernel.org
References: <20250312121044.3638028-1-Basavaraj.Natikar@amd.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20250312121044.3638028-1-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::54) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH1PPF8423FDA82:EE_
X-MS-Office365-Filtering-Correlation-Id: 3adbd202-f24d-4d09-5a7f-08dd7bd180b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alVPSjlmcmo3ZFdwbFFuTVFnZW9TL1pDRXFMejg3N1gwalE5dnE4QU9vMVNn?=
 =?utf-8?B?VW5Uakg1ajA5V3NaK0tnbDYzUHdVZkIzajNSY2x2M0IzZGhudlIzRDgrWHZI?=
 =?utf-8?B?dVExNFBCeEZYTkV0Y3l5eVMxdWw0TmNRMjFUU3JWZnIzS2dpbUZkVkN6TDha?=
 =?utf-8?B?b3d3ZTVnclBUZnRhZ0YrQVcycCs5NU1PaWdQRSt1d25YWWxtL1Bpa3hsK3Rj?=
 =?utf-8?B?dWNwOHlQMHRXbVFTTHVHSGxaZVo3RkFXOUkvaUtHbGlWQUJzRnZKTlpqUjlW?=
 =?utf-8?B?Wmd3WnJWai9PZHBWdVRPMmJSeWlORkhNL1Z5OTRDT1RsYVIrcm1ielV4Y3lG?=
 =?utf-8?B?VXh2QlcyVWF3M0xaSlY0a3VLb2FQYk1ObVNlTjkxVFVXL3NsQVFwQ3I2YTJs?=
 =?utf-8?B?R1JXNC9xdnF2aW9PQWlnVkVQb2sxWDlkYzlmMXUrZHVETXVLWUQ4ZWJBalI3?=
 =?utf-8?B?WCtNcGUwR1lYaWswT2Nibml6S0Q0Y3VqUXlNa2hCcVZXWGxSZ0NPejFteFRn?=
 =?utf-8?B?anNGUEh4N1FCMDRYRzlWVDNGTUhWNEx1RHdCVW8zc1VERVZuRFYzY2JjeWZL?=
 =?utf-8?B?c0d4OExFdjhSNnpNWEg1VTJtQllkejRSQ1dsbHlUdEsxVldYUk9BUHlWSUoz?=
 =?utf-8?B?bC9FU3Zva1NXbHpwb3h6b1FnbXJIcWRZUzhQT0M4ZDN6ZFlkSXdEQlg3RHgz?=
 =?utf-8?B?Q1FrUjhKc3daYW5LYTZYdDFJcjE2eC9XbXNRUURVcU5vRG9pSlFMSjg3VTJT?=
 =?utf-8?B?RGo2L3hxT1RPODV5czNlRW1CbjFqVWJMOVlFSzRoRUM5ckpCQ3pvTDZCcHVy?=
 =?utf-8?B?MklXTm0zaXZxaVYvWE1lMnlKSndlbVlaK2N1UUZWK2F2blFkQTJ4djhyV2s0?=
 =?utf-8?B?MmpscnRSVUZrQ0NsdWxrZU1QakY4b0xIVHJpN3N6U1YwSGtNL2IwdlFrbXcy?=
 =?utf-8?B?MHZUejdyVnRYdm13Nk44OVlEZ1hTNkhJTEwrQVJKWDdObHNPalV6c2twSFIv?=
 =?utf-8?B?VGZzbVlNRVBWY0xJZ2NUdXBMUXFoT1BKV2ZEOTRIdFZGNEt3OGFKSHM1b05s?=
 =?utf-8?B?MVNJclY5US9KZTZtY01aWmh6WGJVS29ETjhlL0pEV1ZwbHU0NVc4TWxsZ080?=
 =?utf-8?B?b2FiQjdCK0NYNkoraEZxcExmNHlwVEtHUnRDM3YreHltd0ZpRGRBaElLaVhF?=
 =?utf-8?B?RlRKTFI2V2UrTEFqSVR4dlM3d0ZMNE53MW01aThFVFBvN08vN0gyQzlYSkNw?=
 =?utf-8?B?UlJGLzcxNHFvcGkxYjJ3THByY0RRcThSSFpRUHAyWEZQbmpKTmtUa2pXMlBm?=
 =?utf-8?B?N1d2VjdnYkFJRG1WUGtrTWhEN0hFeG5BRE5PaG95dldVNkRSdlRqVWlsSVc1?=
 =?utf-8?B?SGJYWkdESytIT29aSzFYOVlZMDlzZlZWVG9vSWEzbGtoY0dYTFFXQ0Q3RU1J?=
 =?utf-8?B?dEp0TDdRczdWcURXN2VqV0FhbkVNM1hzazNYMllMdkZvN3E3bHRHd1M3Q1NG?=
 =?utf-8?B?MFNYQ05FanpvU1R2aDR4cnUyVlMyaHEzdC9oQUFPM3BNdXZDVm9sTkk4dFZv?=
 =?utf-8?B?dXdwa3k5ZjVzTDcveisrZjNJSmI4Q0Z0U3pMeFVwRldDck55UXJaeDh2RzVo?=
 =?utf-8?B?QlFhV01rcEo1T2RXSXhFclF0aTdXNmJicTJ4czdJblI4RnlwenJxbWQ2VW5F?=
 =?utf-8?B?YmlpZTVNMnhHeTRnbFpicGhhUGxLbk1hZ1FMYjFSWng0OW9PWTVnOTF6YXVJ?=
 =?utf-8?B?QVRWOWpqSTZaRDh1VDQ2V3JyZWpHMEhWc2RBMldMZm9yeWE3R3diVk9MdjZH?=
 =?utf-8?B?TFEyY1cvc3dBd1N0d0hXWGVKa00zUFNROTFwUFYwVzNMWGJ4UmxZeVdjYWcv?=
 =?utf-8?B?UWlXeDVibWRFeXphUmVjK3pSei8zeU9VQmQzWEh2TXBCRGVaejk2bjlzREJV?=
 =?utf-8?Q?R3pJxLq14Ao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3FIV2pSV2ZNMWd1bjl2YmdzbGxSZXBxYklZR2IwcmlEZXkvYkEyNzV0alFC?=
 =?utf-8?B?cStGeEoxT1ZneExmcThSWXJ0TDhoL0ZDZlpOQnNBNU5VUlZGeWd5MEFjNG9M?=
 =?utf-8?B?c1Y1SDV3b2lGcys0OWVKOGxVNWtkbGo5SitmVHg0MHczVUo4TUF6N2hDRzlO?=
 =?utf-8?B?SW5ycmx6anphaTJCVGFzdEV1Y1FwSitYbU1CS0MrbUFNTE5NOWE3Vmh6b0l2?=
 =?utf-8?B?RzA3NVFLN1liU0IrT0RKelZlaFdmb3RHVFhkK25OSmZtU21HTDRlamhwcG5u?=
 =?utf-8?B?bVhEd0pGOWRxdkFpZFlqQ20wY3ZidzFNanRBSEpZcGRZSzg1Q2pUTUVEaEdC?=
 =?utf-8?B?Vk5LUll3QWs1cGlYaVFtdnd5d3dtRmdQSkREejlRb1FiSHVxMzJsTmtySUwy?=
 =?utf-8?B?OE5tL0NhdG9aM0ZkeVZ3T1lLaE1OK0pvOGpDNGhjZk5uVGl3ZXhFNENKZTY2?=
 =?utf-8?B?Y3cxMjFYUC9GUW1raGx4dE1pOUJjemZBcTU4TlAzYXVQaG1UZUw5L05ORmND?=
 =?utf-8?B?QkZSMzZZQXNYR09XMFRZY1YySC93RmZ6VUJZb2RGeWw1aWg0d3BZN3p0N2lF?=
 =?utf-8?B?UytnUmlOUkUyOGo0dVV2ZVgwaXROTW15dUdOV2JKZDd2dFB5R2tROGxSNGJD?=
 =?utf-8?B?ZDFUd0tlSnBqRGxXU25XWTlpWVZFWUpUYnkrWkpMRUhhcEdUWXZ0NmNqTlBF?=
 =?utf-8?B?LythK3BPSkUvalQ2L0o0OXhwZUc1WDFibE9sUnFCbkp3N3V2MVdNNWlQU1Vo?=
 =?utf-8?B?RkVKTUxWeitjZ25aQngvcHJqNzVsWG5aQUUzOEg5ZHlNUXNMQ2ozSE0wRmFo?=
 =?utf-8?B?cE1hL29VMWtITHRLNytMM2NrYTBVaEdTMHpNcm9iMklQbHZ5T0FUNHZyZ0tT?=
 =?utf-8?B?RkdsWk1lZFZtcnVucUcvRU5jOVR4S1MxU3JxMm55eTRySXJxYTBDaFRGNFpE?=
 =?utf-8?B?dWJlV0pJbzBtR3Z6UGNKTVpKQ0NPckRzSXhWN0dkNHp5VVN3Ui9xS2hsZ093?=
 =?utf-8?B?eHBhWWVQdythS3Exc2NWRFY3YkdWSnFocWtvN0dYSzYzOGtxRUJuTWk2dS9I?=
 =?utf-8?B?N09FNitSQmxvWWh1VDVCMHcxSmRqb2grd0oybkNUekpKTXp3SUVic0RBdE5Y?=
 =?utf-8?B?QlZldmk4cEhRTUU3UnE3Q1gwMi9sd1lVT2F1TGViRjF3SkpUSGt4enhjVjRp?=
 =?utf-8?B?enRaS0lIcjMyamEwa1VseVBaSmFheTdneTVEMHIyRUZVTDQvNlVnY2dHTkhr?=
 =?utf-8?B?a1BncTZwNllxOXBuWlNyM2hFei95K1FwQ0Vod1hkc0RUUGRYYTFaMzF5SHMw?=
 =?utf-8?B?WG5FdVAxanR3bGtRYUhvNGVHVzVkRENMVitOalhQdmNaWHF0WkRuR3FRSEZM?=
 =?utf-8?B?QlNPeTFQNUJDV292blZrVTBDOFJldjVockswNStDSXVGYnBvR2xMRlQrS0hH?=
 =?utf-8?B?QWNNaWNWK2Rab21NN2ZZN0FTMlBFNGw0T0U3RllLckV6SHptWnY4RnY5elBC?=
 =?utf-8?B?L0Fqd2ZvK3R4cGZ4cThNTjgvYkhwNFp2OTRwbjMxdGhSb2FhN0J4Z3FOdUJF?=
 =?utf-8?B?NXRySUZBeHg4am5KUXJZOTlsQzFGaVVxNXlQcFEwWlRCZHhVKzB4a0ZnKzVs?=
 =?utf-8?B?OXNjdER1RHY5OWVlN21hWkhhaEEydkZTZjJpK2lac0tPSzFtUlRvVnVja3pM?=
 =?utf-8?B?YkNNSFlaQnJTRE9NM2h2aEhsTGF3ZDZRL2xDL2VleVNqSmFiNnpESUc1ZGNY?=
 =?utf-8?B?RlZFZ2ZLT2RlRUVtM01LVW1iVGR2ZjBScnBWSm5ZVkVwTzZiTGl1VHZ3SFRk?=
 =?utf-8?B?cXpYNStLZlQ2WVV1Q2tMbE1TR1VhRERNMVRyakVjMURzUFpKZ0ZmWElMWGVT?=
 =?utf-8?B?Q25NOTl6dFo5WUxzQzBwVEYvVHRuVHRvRENFTzByY3JQcFpiZnBJWVJzVnU2?=
 =?utf-8?B?Tk9QcE0wRUYvVWVzZjdrMFBmcnZON3oxYTVpRWlkWHFnb3dhOTdENTFuUFpw?=
 =?utf-8?B?eGhrRVlBZXdkMUZ2M0dWWThJYTRrYS9mTTAyRTZIbVJzVVpnVmZhejB3dEZV?=
 =?utf-8?B?RXZjSUlKTW5JMW1WTXRBYVRreE9Dak14UTRIQ3NwT2UwZ21NQ3NDUkJkK1Nl?=
 =?utf-8?Q?xMtTyyFXh+i6LEjEHOW4iVmAU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adbd202-f24d-4d09-5a7f-08dd7bd180b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 03:56:29.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23V9WesWeXbeWUIII7vvhyyOLbWLytqnesEw4CIlhbJWaD5ecfFAandKCVe+xq9LscNLTYTkY1w/fG54vch2eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF8423FDA82

Hi Vinod,

Just a gentle reminder regarding my previous message.
Looking forward to your response.

Thanks,
—
Basavaraj

On 3/12/2025 5:40 PM, Basavaraj Natikar wrote:
> An unnecessary extra check leads to the following static code checker
> warning:
>
>      drivers/dma/amd/ptdma/ptdma-dmaengine.c: pt_cmd_callback_work()
>      warn: variable dereferenced before check 'desc'
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/bfa0a979-ce9f-422d-92c3-34921155d048@stanley.mountain/
> Fixes: 656543989457 ("dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue functionality")
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>   drivers/dma/amd/ptdma/ptdma-dmaengine.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 715ac3ae067b..d1d38ed811c2 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -355,16 +355,14 @@ static void pt_cmd_callback_work(void *data, int err)
>   		desc->status = DMA_ERROR;
>   
>   	spin_lock_irqsave(&chan->vc.lock, flags);
> -	if (desc) {
> -		if (desc->status != DMA_COMPLETE) {
> -			if (desc->status != DMA_ERROR)
> -				desc->status = DMA_COMPLETE;
> +	if (desc->status != DMA_COMPLETE) {
> +		if (desc->status != DMA_ERROR)
> +			desc->status = DMA_COMPLETE;
>   
> -			dma_cookie_complete(tx_desc);
> -			dma_descriptor_unmap(tx_desc);
> -		} else {
> -			tx_desc = NULL;
> -		}
> +		dma_cookie_complete(tx_desc);
> +		dma_descriptor_unmap(tx_desc);
> +	} else {
> +		tx_desc = NULL;
>   	}
>   	spin_unlock_irqrestore(&chan->vc.lock, flags);
>   


