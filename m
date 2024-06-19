Return-Path: <dmaengine+bounces-2417-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B197A90E4E9
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 09:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEF8B216DD
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E06F481BD;
	Wed, 19 Jun 2024 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IOgmnRts"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7C27733
	for <dmaengine@vger.kernel.org>; Wed, 19 Jun 2024 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783547; cv=fail; b=uGdO73Hg4fWi06+/S+V0G1oO63lqefX3SIud3x+Jsr4mXWG8HSQXNXJcY2iPro6rEtPWtGzVS6RXQ9tUZGK8Tue0/CYJ+JJw/+hHFvWiaFbeqz4+Pvhqop8MLBMJo+3FiMFRFLaUy4V7BhASmsNEVcRcGavnnV2WgUXFhBwDsRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783547; c=relaxed/simple;
	bh=AcNUlDlrFEnCDey+nbWXDpOkgKTl5tnw+j8kiP9C04M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=obVzLQ4TtZurJJc/aNX74U0meyFb3l+HnFRWrOWlda5emKGfaXpUimUK2LPwZLwTXNRcZ+MWOoqAynx+rGqG4KaS/rA5XpvjJfa+nlXV07JEhoKwH3BCGz9Kz6fgRrFNwiei++euOb/SzoCCtmXJ1RHR1B3NT2EVBuycvs5Mq0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IOgmnRts; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISnnfMdoOwCSLxyTd9OMnfTaI6N3UQ+tqlExJgfp4FdZt3qnDqcjCr/kMcB9O8capiHfJA7pFcsAJXjCElpw8kbAr2yMHFCj5zc2Z/NlIMagFYbZ+v66GFIRCDFLn6IbgmbZizIRWhyymvMKYpJiqXiXjPJ9DBBK1PjwB3d0nE2/nufOR2eCoKL4y3zuzi/MGuVNk3FAsiVBw+ZYbzzVP/M/bsy+p5GGd89R4Oo1DhTpP0K5MrPWkbnte5Gg6pqfpQdRFO1BUNqASvGQswC3YjrcJdOXbp29CmUByOGRXFRxjvN1BDKjlv3DZw9g2unon3ANjZnDvx0bNppgntGPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcNUlDlrFEnCDey+nbWXDpOkgKTl5tnw+j8kiP9C04M=;
 b=QLqjY2/YuU1+/F7/MaPLsICtD0Ez5Pn3w3VE/5OkSxYREErWR03r2/++mwkY4k8m8B0kx44rF6HCB24MDCLbOpZDqMAOz4tKNtlZ67I+TAG29E93hQ9vlJuQLxjv8GoblCEjsALayvCP0W9t9VDtH4pEatO0UfScYkFVBDWZFLPL5GQ9C2L6BFdWtPN5hoZ7AyHaYWmUJrgy2EeHJv4aoD+u5qjVzubqTqDN4d6xU8qft7aLsCURopVwLZ5ac1TuSGE9AyWqr/wT8EhbC+sINmnk0+OD51kU+0NyNuqPRjHyLRAWyNXcOeg3lZZSojZX7SKB4r8BnPVTgv9rxxazzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcNUlDlrFEnCDey+nbWXDpOkgKTl5tnw+j8kiP9C04M=;
 b=IOgmnRtsazJ4bXvL+b1qsNp2p90w67Tj2zVKE2lNxZiqfTkLVpILlH7Tp4AEtIX8IYRn85oCmfMSxpRwbQYp0xfJE0o1SMz+V+vp7Qo0VQEZ/+/ZBc00/RtdCiU2g8xEVPD1w4mUic9Q98v5F/BCgSKhqxlRFWEEibUBMvGRaMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 07:52:22 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.7698.019; Wed, 19 Jun 2024
 07:52:22 +0000
Message-ID: <8d874e13-f0b7-458b-a514-905df42499d6@amd.com>
Date: Wed, 19 Jun 2024 13:22:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] dmaengine: ae4dma: Register AE4DMA using
 pt_dmaengine_register
To: Philipp Stanner <pstanner@redhat.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org,
 dmaengine@vger.kernel.org
Cc: Raju.Rangoju@amd.com, Frank.li@nxp.com
References: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
 <20240617100359.2550541-6-Basavaraj.Natikar@amd.com>
 <687174ffdd9eeeefab5309b57bf0001c9d4dae76.camel@redhat.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <687174ffdd9eeeefab5309b57bf0001c9d4dae76.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7dbb4f-8ddc-43fc-6193-08dc9034c083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXM2YitKbzJSN3dsajVOaWZ5UmpYVkd2eFJaOWNXV0J1WUg1cXZnQUgzOTlo?=
 =?utf-8?B?c3JLMktma0dpaG9RazZUZ0I4K0RNMmZQSFdhRm5pUzNqMDZXa3pST3JGbzBt?=
 =?utf-8?B?TWw1SWFGUzUrSVppVm9iOHkzNWRYK3BFZ2ZoMlRWU09JRm5MUWJ6OWk4cEFo?=
 =?utf-8?B?cWFxeStoSUtaUzJlVnhmNWIvZFBCanI5OUZKaWZBTk90Z2ZTZTVTVDlEYnpJ?=
 =?utf-8?B?RlVtRGpSeXpZRStsbVFmZFMvUERNTEY1RlhmMi9SVmFueGZ0Ykl0VC9MajYw?=
 =?utf-8?B?SThyZlZYZVhSZ2RRMnR2d2lOSzdZZmJ2QVBzYXNCeVY4cnlxV2NKVUl2WjlV?=
 =?utf-8?B?bWRyTElxakd5OEJ0TFUrMFFtMy9CZXEwWGF2V2RnSHc5bnBVSXBjN2RLNXAr?=
 =?utf-8?B?OUw0VTFSUFkvaTUramdhSkhFRUU3OGJqL1hIM2t2SnE2ZkNaZmx2a1Rmc1Ru?=
 =?utf-8?B?bGxJaElsZFhsUWE0Q0lkRGF2dUJCMEdpblUzVndpdEpYTWd0cE5vWU5hQ1NK?=
 =?utf-8?B?cGxHb2hkQzREazVRWkdFeVR6bjhFN0hQajNGNW5qbzlPZ0lac3Q4QWJSTFdh?=
 =?utf-8?B?N0dlMmdUSlUySFVwNXRNazl2aytpUkJCZ09QUW9QSlZab2lxSEUyL1dHYnFB?=
 =?utf-8?B?aWR6RTAyZDJDT05oZUpkUUhRbHhmbnNYK05zS2xNcyswQjRlT0s3NUtlL1pQ?=
 =?utf-8?B?bjE5ZWtNNU9iT3FSenFFemw4UVJ3NnlvR0J4Q3ZoWG9NRmN2NG5GSFRVQzZM?=
 =?utf-8?B?aHpobUpqNkpkNlZ4YmJoZis3YWZZN2dsY3NYVlN1R0o4aHhDT3BCMXlXckM2?=
 =?utf-8?B?VEZ2aHVtU0UrakMrWGFVSEM5dm5ydXZiNVhpeHhYQ3J5M1ZCYXNMclhSc0JD?=
 =?utf-8?B?emtjYjBCelBpaG9ORitaanBZTW81R3FEZjN5VVFXYWpEa0QwVisvbmhjM0gr?=
 =?utf-8?B?WFdaNkVBWUppK2ZFbnA2T0s2a3BxM2hXVjdBdXQ4enRZNXBzZ016eTdhR3dx?=
 =?utf-8?B?T244VWlaLzJ2RTBpU05Fc09KM1BBMmx0YmZrTFA4RXZxMHZBSzZMUFpjVlRE?=
 =?utf-8?B?WXhscFo5dEF5SEVteGtxVlpTZTRMaHhGQnRWYTZZTUlLWDdyYkVWQ2pKZkNY?=
 =?utf-8?B?WmVtcjV1VldHQjFDL3lWVTA1bEl3U0tMYStLNGxlcW80V080ZGhCbUs2dElW?=
 =?utf-8?B?WG9BVk52ejhpZy9BWkJITHZjQVJNQ082WDZra3NRM2RIN0RMSDE1YVN3aEg4?=
 =?utf-8?B?VnY1OG1oY1dZRktXeTFrYjlIZ0R6dFYyeDNMQmlsVUROcEIwNVh0NG4yemdi?=
 =?utf-8?B?SUV6YUhETzl3QXlWWEpueGVFRlQ5eTJxa1EvVWdjRWFaTmRqaVV6T2FjWW5X?=
 =?utf-8?B?d283UUQ3d09yaWtlTldHd3J0bWNOTVZueXdIMC82eEliKzRtZzFGbjNQSjN3?=
 =?utf-8?B?VEJSWDRFc2Q3Q2c5bDZMcFAyTmxteGJrM3VzQ2cvSjFaeVpOU2lGdGsxcHg4?=
 =?utf-8?B?TVM2SVpxK2U2UDVESWFLazVFSXFZTStwZVJvLzFNcjJnOXovMUh2NmxzRkdB?=
 =?utf-8?B?b0d2VG5veVl2Z3ZseHk2RE1CaWgwYXVPcHpkcnlpWWwvYmFCNmMzWlFmMUha?=
 =?utf-8?B?K3NlQ0J6MmthaUpBSEk3YzhkTEswaHFoc0RvU3hMUkVabFM4RGQrenhoSDF0?=
 =?utf-8?B?SU1sMWV0YlNISk1FMnErTFlWbG9OdHdsNWtCQ2RBTzdiMy8xbXpsOUk1TEZt?=
 =?utf-8?Q?fbNviA5k17bQFJOK8bIJxQqUR7sYYyu1c8FuwpQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTA2T0FCOHhPSFZQYTVneGtGS0FNOXFnMDRpQlFvdThDcUlxS00xVTFOWWVS?=
 =?utf-8?B?NXl6MFFGSUs5NjFYKzg2czFMYkZpMDN0NlhBejdNM1p3MTZWMHRYNUYzanBQ?=
 =?utf-8?B?alllK3ZtZ0VEQ3lid1dkakpvYlV4S0VHS0JBR3NkYWsrckdWY0hVOVVLUHVz?=
 =?utf-8?B?NG41ZlVGK01UNTA0SlNVL0gxYzdHY1pCYzg5WjRpREZudmkzMW5UOWFOVDk4?=
 =?utf-8?B?K0x3SkR2QkJyN0hlZ3BVZFhIZDFyQ24wVXZ3bUw3NkdEY2krSVBIdlNQOGRx?=
 =?utf-8?B?cDBHR1l0Sks0Nm1Fb0hxZWNlWHVwYnUwQmlkdUp2S2xjcmwwa3daakY2ZWly?=
 =?utf-8?B?a1V1S1FRRzJPS2hOQXZaMlRhRG9xTkVTVEo1UHBkYW1ISUU4bGpvSzRBbHRN?=
 =?utf-8?B?dGFKS0Nhb1dZZS9aOXhEQ0d2Zkt5cFhyRXpJNzZVcXBwU2liRjg1TVVWRnRi?=
 =?utf-8?B?RFpEb2srM0RTS1FrS0dWYWhPTTRjb2xzM1MzamFFcmdCNjNHaDQwYmhyZjVw?=
 =?utf-8?B?dEhjaU5ra3NqczFzUmJoLytVaTlwRmFnVzNCaE1QN0V5TGdiMEc3Y29DSE1X?=
 =?utf-8?B?NU9ObUxrZnhmRkhGTGJyTnZWSlFjL3NtNU1uazM3VXExR2VUZ0MzNWRWbERt?=
 =?utf-8?B?NytIWFBnUm1WVGczK2I0cUVCaFZEbTBCOHU2eGkyWFVRNzU4ZWh5TTBtTjhY?=
 =?utf-8?B?RzF4SHlZZWIyODhCM1JGU1hzMVpvQ2NtcHRFTXlaS3FXamN5UVpESWFGdlBR?=
 =?utf-8?B?K2hMZ1REUDlaRjFFb2ZEdkxQZkFnalJjb0UzTUhza3k5N2t2cXZSQ0RiYThE?=
 =?utf-8?B?aGxwZkVJd1JqZTd3ZUpEUnZsbkpPNE94WFRUTFRZa0taQ1pReVhaSjZleE5m?=
 =?utf-8?B?Y1BXbERGS05NUU5venRjRU0xa0dobnBGRGVBeGJVbGZSRmlJdjdrRzRsS2ww?=
 =?utf-8?B?Y2xOckNUMGw1ejhmUWVPenBEUmhWYjVFeDFZdVJDd05kSWZCbUR3SitQazAr?=
 =?utf-8?B?K0MwSjdhbEc1c1R3UzM3c3Y4WE42OUJrUDNFN0h5Q2hIS1h2ZEJHdTRVeWhL?=
 =?utf-8?B?bmpzRXQ3YUJ0am5XZW83MzU2OGpnUnUyUXd3eVpxK1UxL2NaU3VQcWJIOHYv?=
 =?utf-8?B?N1FMem03R2ZVOUhvV2J4eXhGOHdoQ2Y2Wm9LZlNyUFVEUFhoazd1V2ttNlhN?=
 =?utf-8?B?UzdSbU1XWWhPK1RWVUFuTm5QSk1WaUMrTGpENTB3eHRWd0lPd3IxdSsrc3I1?=
 =?utf-8?B?dzR0cXFTODlXSmxiU1Jsb2Z6K2pvYTBXV2c1ck1SeUhCK2N2dDNNcjF5MWFx?=
 =?utf-8?B?bjU4Q1V3R2lrb0k0Y0RwcjFWM2w0YTY4OU1Gdm44dzdqR3ZmZXRKTUxmWHlY?=
 =?utf-8?B?emdHd08xMEhJMURibHJ6MDVkaFBzU1VDelF6L3NSWmlOaHg2YXBwK09VMlZ6?=
 =?utf-8?B?N0FldTM0K1F6eDV5ZlNGNSszVTZFeC9KSUdTKytlMGRYOHJyUGo4VXBUbHBk?=
 =?utf-8?B?RHRpY0RoUk8xY2EzdXU5TndkeFVKRzF3M3hMTHFzTHVaUENTcXpBQ1JrRTN0?=
 =?utf-8?B?bHhXMlZjbXIvN29BdWtPd01UbnErenFYeXlvYnBqU0dhQjI0RzdIYnlOR2Ex?=
 =?utf-8?B?eEZGeUZjSkhTeVRMdEJLQk41VTkwZC9PY3d4ZHJHRDRaOWhkVHd1VUpmLzZW?=
 =?utf-8?B?N09NQldPeUEvZVM2Y01MQXZFRG9RVHBWUDRzMjhoQlJRaXYxblY3b2U4MmYz?=
 =?utf-8?B?NGQ5R0k3T3RmMFVPM3VuSGRNYnpudlIvc2FRckFDTjRUR0dXZUNoV2hoQUFB?=
 =?utf-8?B?Ym9pMTdlOUE1ZEtrTEh4dkNvVmhkSGlYZUphZzZVa2NxUHhOeVpLWkkxRkNX?=
 =?utf-8?B?Zy9Lc2F4TE5OMks1dEl1alZPUTV3SHhLZFVFWnd6S1EzdEdxaDhtN3pNZmEw?=
 =?utf-8?B?dmRiNHE3c21Da1d4ZXVuam1MOEVDOWhxa3pnMGJ5bVc1bjlKZXdtOFFUanQw?=
 =?utf-8?B?dEJ0ZTZuOVBqY0FpOUorbVpXOUlEWjVSbUxuaXFZQ2lhMTJLcTJ1U2RLL3Vw?=
 =?utf-8?B?WkRJaDJ4VkhHVDNaVEh5QTN3OXE0Yld4TkdHWmhrMng2VlBoWFRyUHByUGI5?=
 =?utf-8?Q?eevBgtiLMlPNzkEbxsYSknZIt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7dbb4f-8ddc-43fc-6193-08dc9034c083
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 07:52:22.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7rv3OicGwh6hW5UP7BT5T37+ToK+mrR8YF3JRanxE3ZfoOhnOKf5YKu+KVqwtg9KZCfEUiJeeS3Dtw2u7Yy2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123


On 6/19/2024 12:59 PM, Philipp Stanner wrote:
> On Mon, 2024-06-17 at 15:33 +0530, Basavaraj Natikar wrote:
>> Use the pt_dmaengine_register function to register a AE4DMA DMA
>> engine.
>>
>> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>  drivers/dma/amd/ae4dma/Makefile     |  2 +-
>>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 73
>> +++++++++++++++++++++++++++++
>>  drivers/dma/amd/ae4dma/ae4dma-pci.c |  1 +
>>  drivers/dma/amd/ae4dma/ae4dma.h     |  2 +
>>  4 files changed, 77 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/amd/ae4dma/Makefile
>> b/drivers/dma/amd/ae4dma/Makefile
>> index e918f85a80ec..165d1c74b732 100644
>> --- a/drivers/dma/amd/ae4dma/Makefile
>> +++ b/drivers/dma/amd/ae4dma/Makefile
>> @@ -5,6 +5,6 @@
>>  
>>  obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
>>  
>> -ae4dma-objs := ae4dma-dev.o
>> +ae4dma-objs := ae4dma-dev.o  ../ptdma/ptdma-dmaengine.o
>> ../common/amd_dma.o
>>  
>>  ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> index 958bdab8db59..77c37649d8d1 100644
>> --- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> @@ -60,6 +60,15 @@ static void ae4_check_status_error(struct
>> ae4_cmd_queue *ae4cmd_q, int idx)
>>         }
>>  }
>>  
>> +void pt_check_status_trans(struct pt_device *pt, struct pt_cmd_queue
>> *cmd_q)
>> +{
>> +       struct ae4_cmd_queue *ae4cmd_q = container_of(cmd_q, struct
>> ae4_cmd_queue, cmd_q);
>> +       int i;
>> +
>> +       for (i = 0; i < CMD_Q_LEN; i++)
>> +               ae4_check_status_error(ae4cmd_q, i);
>> +}
>> +
>>  static void ae4_pending_work(struct work_struct *work)
>>  {
>>         struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct
>> ae4_cmd_queue, p_work.work);
>> @@ -123,6 +132,66 @@ static irqreturn_t ae4_core_irq_handler(int irq,
>> void *data)
>>         return IRQ_HANDLED;
>>  }
>>  
>> +static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct
>> ae4_cmd_queue *ae4cmd_q)
>> +{
>> +       bool soc = FIELD_GET(DWORD0_SOC, desc->dwouv.dw0);
>> +       struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>> +       u32 tail_wi;
>> +
>> +       if (soc) {
>> +               desc->dwouv.dw0 |= FIELD_PREP(DWORD0_IOC, desc-
>>> dwouv.dw0);
>> +               desc->dwouv.dw0 &= ~DWORD0_SOC;
>> +       }
>> +
>> +       mutex_lock(&ae4cmd_q->cmd_lock);
>> +
>> +       tail_wi = atomic_read(&ae4cmd_q->tail_wi);
>> +       memcpy(&cmd_q->qbase[tail_wi], desc, sizeof(struct
>> ae4dma_desc));
>> +
>> +       atomic64_inc(&ae4cmd_q->q_cmd_count);
>> +
>> +       tail_wi = (tail_wi + 1) % CMD_Q_LEN;
>> +
>> +       atomic_set(&ae4cmd_q->tail_wi, tail_wi);
>> +       /* Synchronize ordering */
>> +       mb();
>> +
>> +       writel(tail_wi, cmd_q->reg_control + 0x10);
>> +       /* Synchronize ordering */
>> +       mb();
> Same here as in patch №2, I think writel() and mutex can't change their
> relative order.
>
>> +
>> +       mutex_unlock(&ae4cmd_q->cmd_lock);
> Same question: can't everything be done by the mutex alone?

Sure , I will remove it in all applicable places.

Thanks,
--
Basavaraj

>
>
> P.
>
>> +
>> +       wake_up(&ae4cmd_q->q_w);
>> +
>> +       return 0;
>> +}
>> +
>> +int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
>> +                            struct pt_passthru_engine *pt_engine)
>> +{
>> +       struct ae4_cmd_queue *ae4cmd_q = container_of(cmd_q, struct
>> ae4_cmd_queue, cmd_q);
>> +       struct ae4dma_desc desc;
>> +
>> +       cmd_q->cmd_error = 0;
>> +       cmd_q->total_pt_ops++;
>> +       memset(&desc, 0, sizeof(desc));
>> +       desc.dwouv.dws.byte0 = CMD_AE4_DESC_DW0_VAL;
>> +
>> +       desc.dw1.status = 0;
>> +       desc.dw1.err_code = 0;
>> +       desc.dw1.desc_id = 0;
>> +
>> +       desc.length = pt_engine->src_len;
>> +
>> +       desc.src_lo = upper_32_bits(pt_engine->src_dma);
>> +       desc.src_hi = lower_32_bits(pt_engine->src_dma);
>> +       desc.dst_lo = upper_32_bits(pt_engine->dst_dma);
>> +       desc.dst_hi = lower_32_bits(pt_engine->dst_dma);
>> +
>> +       return ae4_core_execute_cmd(&desc, ae4cmd_q);
>> +}
>> +
>>  void ae4_destroy_work(struct ae4_device *ae4)
>>  {
>>         struct ae4_cmd_queue *ae4cmd_q;
>> @@ -202,5 +271,9 @@ int ae4_core_init(struct ae4_device *ae4)
>>                 init_completion(&ae4cmd_q->cmp);
>>         }
>>  
>> +       ret = pt_dmaengine_register(pt);
>> +       if (ret)
>> +               ae4_destroy_work(ae4);
>> +
>>         return ret;
>>  }
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> index ddebf0609c4d..5450fa551eea 100644
>> --- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> @@ -131,6 +131,7 @@ static int ae4_pci_probe(struct pci_dev *pdev,
>> const struct pci_device_id *id)
>>  
>>         pt = &ae4->pt;
>>         pt->dev = dev;
>> +       pt->ver = AE4_DMA_VERSION;
>>  
>>         pt->io_regs = pcim_iomap_table(pdev)[0];
>>         if (!pt->io_regs) {
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h
>> b/drivers/dma/amd/ae4dma/ae4dma.h
>> index 4e4584e152a1..f1b6dcc1d8c3 100644
>> --- a/drivers/dma/amd/ae4dma/ae4dma.h
>> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
>> @@ -16,6 +16,7 @@
>>  
>>  #define AE4_DESC_COMPLETED             0x3
>>  #define AE4_DMA_VERSION                        4
>> +#define CMD_AE4_DESC_DW0_VAL           2
>>  
>>  struct ae4_msix {
>>         int msix_count;
>> @@ -36,6 +37,7 @@ struct ae4_cmd_queue {
>>         atomic64_t done_cnt;
>>         atomic64_t q_cmd_count;
>>         atomic_t dridx;
>> +       atomic_t tail_wi;
>>         unsigned int id;
>>  };
>>  


