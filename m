Return-Path: <dmaengine+bounces-4908-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D6AA9155F
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 09:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D132162938
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 07:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE5E1DE3AF;
	Thu, 17 Apr 2025 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QKUxDKg5"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202FC1A2642;
	Thu, 17 Apr 2025 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875323; cv=fail; b=j/IzSXdxYbhyROJRqE4Tz9k5LFZk1KulaHbVWb/zbCM/ersZZ+WLkp276d2gJZhNn1sA4/PVU9ge5DxKZBGZrg23JGyUPS+IsDW93nGSWOVMm9JNRRKDqsx7U15Ie/tZMlx7bkD90dUYKKsNxWicL8z2T0PHbodqVgssICxqSUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875323; c=relaxed/simple;
	bh=CNSXOG1jAbZt4o2KrllOhmISmg/00lQ4x3IojRe+OlU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gTZSAQYxcSiArAHCPYWLWV0PfK0PnDepCoV20cW6DCOyY/3fwMn2v4292VNuiEo+PDiiI1qgYXoMl3bG17z8omzMQ9flgc5xUiftpxYylMRD72tWtKSLiLyg/2mpWhlcnbwDPGPDD50wwvKsbmf4Vs4WnpWKn9fFDTKGGc8T2pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QKUxDKg5; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGBklyMuCC9CId6IO2jBMVmVZHZ60/+ejIVozZpC1LiKWqskSyUFltMAop2zgxyulFi7dwN3OQ4bjVFR4vQ4Wwnq+Cwo0ncWPm5uAO7/WL8f+Ik3GIooSYsuMJj6PZKB6IV9lz/AHe3E7mdDFmWRUFrlgHtQPbcbNh9sj7mLhWZcmWCQflfptYpDXkcGMNcbpXXqBdbge8wDXeTIWysWjr4Ve1iPmL3Azk/ZNiu7g+n5uLicdgO1Nxl3ROaly9fMVlqDCzNGIy6cEay3wdYDQwe8Qx7I0zy4l+Uq9HdQMhfYhoZiWk3j2bxRIh5NahWdDP1/YVDl+PFZqV5OV0vW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0puypaqaN/JH+NKAfx3oTIJdG1DGnMGqyJair1szPk=;
 b=koHkGHIu3BRVBe1B2ho3CHLW0JsZEc2AlFN6yPdyB6Iwd7D0RXt3LMuoPixHt+EhZYTAtKHoEWQKxpSczIpvAy68/+sqVJEErb3xGslJUDZmGSLdUHyYAIuFuE6bBNRcB90Bvk4K/uYj6XfxipcJn/2VifN2RtDfCSGb/r4MAszdvW8JQ5QLj3rx5VLffjKzch7ON+5JOfGhIdBts4TFQ8gprBVA6t37JB/Fpb2RpPhOKLxPALf4d8ZXuAdP+w6xkokmbzuEePO8Fny93+zxDRxD9LDwVt+7v6mfLKS5PB1Uhedn28hv1zLUUFdZzScc2qrIUfnSxRwsgQoEl5ihzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0puypaqaN/JH+NKAfx3oTIJdG1DGnMGqyJair1szPk=;
 b=QKUxDKg5fd4oRO7EsfATMdjeRh6eTaArrosdXbO+RP4bH/Nx0IP2FjnWwEGL/43MxGQEfzb8WcUWV1m3OsA9wC08WTf0TEH3/zmB07h3/0gCuATpu0T/hv1Yk7gIpHNx5aeZmOLb8gZ2MTftGKCaDlkz7kKo9xbdF3jM5n6Pzek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 07:35:17 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.8655.021; Thu, 17 Apr 2025
 07:35:17 +0000
Message-ID: <2b81a054-b716-44e8-b2ea-5012a4536629@amd.com>
Date: Thu, 17 Apr 2025 13:05:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: ptdma: Remove unused pointer dma_cmd_cache
To: Eder Zulian <ezulian@redhat.com>, nathan.lynch@amd.com,
 Basavaraj.Natikar@amd.com, vkoul@kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250415121312.870124-1-ezulian@redhat.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20250415121312.870124-1-ezulian@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0109.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dd52b3-a9c7-41b2-6a31-08dd7d8265cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEswckJ5SUg1QVBHaTBId000QWk0QnB6Q002SkJ6RVJLWTN0bncva20yMCtt?=
 =?utf-8?B?S3pXaEZlSDJ5TW95eWM3bStrTnBUa2NRUjZvWSsrQU42Q2dLZXlkcVJmYlYx?=
 =?utf-8?B?MXB4VEJ0NzV2MFZYZG5RbXpndk5EazZCK0JwbkRhUC9lend3UXJiVmZxZTZv?=
 =?utf-8?B?YytGWnJEQWh1VlB2QnJBOVNqR0RLdFJOQ01ZZ1E1M3FUN0RNbTlndkh3SHoz?=
 =?utf-8?B?cDNBaG4yUk1xNXhXWVVkUGtHTzZZeGFHZjN5VXREdTNFVmQxNGtkT0JmMU5y?=
 =?utf-8?B?WE4xVko2eVdML053bmg1eVlzdFdHVFFWM0Q2V3Bnc0JyczB4cmdkeGtTeDhG?=
 =?utf-8?B?dldVWkFLWVJMbGMzMmR0aVlSTm4zbVAvdXZjZ21hdUdtSzRCdE5xTEUwSkw4?=
 =?utf-8?B?NWU3eVgxdm9MNTFXSnk0d3NZa21tdnc4VUVabTBhS2FWOE14bG9pZGR5VTE4?=
 =?utf-8?B?dnI0eUxJZHByTG4wc3Qxdk1jM1NqaEtDZEdGMlRLRE9CWjBNWnhKcHM1MlNx?=
 =?utf-8?B?a1dieGdWTnNHaUNtR0xDSk85b3oxeHlwd1djUjBhLysyeTlaaFQ5OFhCOHhz?=
 =?utf-8?B?bzF4aUlTbzR3NEovWG5ESGFtajFha1QzcWxFSVRlbEZlUWI3eFV1KzI4U2gx?=
 =?utf-8?B?K0ozZGU5eVE1a3labWNCbDFUVjRpaVF2NjJpN240T3hkVWVGQmZWWG9OaDZ2?=
 =?utf-8?B?UVEwV0hnZEpZNGJ1c3A0WVRlTEhGamhFNVpnTk53bTFwZGo3MmY0VDdDcVl0?=
 =?utf-8?B?NnB2VGE0T1dMSU5zZkJRckVhWCtLZlQ4UG5sOVpFNTVWVE5yNGFBVkh6ZWRu?=
 =?utf-8?B?V1dvVXRlbDMxdjZRdlY1SDBqeDdYSDNhbUhabkN0RXdvME02MFZVU2hYRkxZ?=
 =?utf-8?B?NXJjaTZHT094Vk9pZFFZK3Y4NWc0dTlQcG5SMnNaYXA5NVpyVjNibkhLcXJw?=
 =?utf-8?B?VzNSQ3g4S0p5bFNEZE1kM2VtOTkzM3lhVTgwWUk0cXRlOUxYcjE5aEZmTUVt?=
 =?utf-8?B?Mmh5cnJheHFKNVpvYm9VUlVqdG5QNnlCTnlPakpQVEdaUDFiZ1JSeUJsWGhi?=
 =?utf-8?B?WTdFMkJvcFovcmhDRkpNNXFhNUt5RFcwbzY0Z21YeEFkb0JxN0dLanZ3Q21T?=
 =?utf-8?B?V2pVejIvckU5Rnp1M1RqWW1GcEswVVpuSEMxa0VNR2ZjLzhLZC9qL011VVYw?=
 =?utf-8?B?bDFyQk1FVmVxbFZtVnQxRFZnNEhWTjdIQWRESjF2MERXeFU1UVkwcGdXemEv?=
 =?utf-8?B?b3hLTEszR1JibVJiVmhFd0MwM1JRMm82bGszc3dsMUNUczZ4dEsrTGFKejJr?=
 =?utf-8?B?NW55VnJaNGVLNmp2d201K014TWdoSzZaOTdvM2FuK3hha0Yrb3lUUVU3VHly?=
 =?utf-8?B?Q3hjYnVZTkM5eXNUa3llcnVkWUhVaW10TW5GTTkra1IvSC9YTWovcEw3K3dB?=
 =?utf-8?B?NlJwd2c1WjZtSjJHTlBMN24wWEdjbkp4VDJUL25rTVBCVldRdWozVFNEZ2Jt?=
 =?utf-8?B?ajNHT2liMkJhYTc4dFp0MXNWK1VlTmgzNXZpSzVBaUk1dXQxWHdWbndEWldt?=
 =?utf-8?B?cDZ6dnVGOWg1bndCMnhGQXNZMmIwWjdoSEpOa1FkNUhPZks3Y2pWR0VQYnhQ?=
 =?utf-8?B?a3hnaXJpMWZtVXJsenVLamZtajY0QXZTbE1zOUN2YWlzZEVQV3VteFdvWUhy?=
 =?utf-8?B?cnlwSUxHWnVVZzJPa2JGTVJTMGFuK3ZqMC9MTngvWEVVTjgzL0s5YnovVlll?=
 =?utf-8?B?a0lHZ2x0UWo2MG1hZHYzQUw1dHM0cmhvWktpRk9zRFVaRVA1WHd5WjdJakQ5?=
 =?utf-8?B?OHhzbkFKTHVYUHQrNWVrZkJGRWRKK01oUkRtRWxMUVgrWlF6bjg4bzJxRVNJ?=
 =?utf-8?B?Q25sU2xEb3RWdWl6d3VpUzlaUFk4UzNMYW41KzFhdWpWV1Nmc1pZZlZCN0k2?=
 =?utf-8?Q?pTPFbPfMjhk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1kwOEptZHFyZk92Tkd6TjIreFFBZG5lbkpCWmRwMTVtbXd5L0RGMzJhdVdV?=
 =?utf-8?B?TFZlWDlpYjBqb1c0S1o4SHlZS3V0ZkMzVndIMUtFOE9XUnUrS1RMZ1UzbVU4?=
 =?utf-8?B?NDNnZklYOHp1QSs3S3dBbVpoTFJFbW14cmRDVzlrcGFPaEdYVFVSM0VldVdG?=
 =?utf-8?B?dnF0MHo1MlNqQlhYRHhacVIvMU1LcDlvN1ZzbHZZc2JqcUZGOEFSMGxWaEI3?=
 =?utf-8?B?dXJkdzFiUzI2MW55cFc1RmVtdmlWR2tlRXpWOHFhQ1pzaEtJamJxS0pWMU9I?=
 =?utf-8?B?RFVnMktFcXd0RGRqaFcweDJxWTVuVFlIWjIrVWdsVTVmWWJaWUhjSWc0SHpo?=
 =?utf-8?B?U3hHemhDNGMyVzgvekgzN1Fid1RxRWxVSnh6aWVPcXNITVRWM29MbXZpWmUw?=
 =?utf-8?B?dHhyQS81MkVUUUJGakdtUWtQUEt4UmJQYUgwaVdXYXYwRnFtTGZrVlhWQWVG?=
 =?utf-8?B?TkVqZUR2TDJSdVkzcmp1NGRHMWxFM0dEZmJJYU1kWjVHTVZJZzdoeXducnVS?=
 =?utf-8?B?N1hjU2M5aDkvUHl3blYrZVVtRUVMYjdyK2NoTnpWZERxaVpnYmVBcmI2eklX?=
 =?utf-8?B?czhsVklGclFOYS9CdjJESkRweTNiQVI1MDNkdlI1RU5jUE0wb2Q2UGdlN2Fq?=
 =?utf-8?B?NFFMOG9USWlraWJJL2hEQXYxcmcrUHZvcnBYVGxXSDNLWTFXdE9kSW9hOGVK?=
 =?utf-8?B?NmJXdm1MY2pSckI1MkJlSnV0WjlIaE1wdGZpMXNjNVZ4K3BjYXlzYStZUE1Y?=
 =?utf-8?B?dkFVNmRlQ2w5OVRkdjFZN2d6VjlQbndwQ1B6Z2I0emY4MnJwMUhyOTYzV1FB?=
 =?utf-8?B?dGhkVW0zc1k1a2FmYmRSMWErQnFDV3NQTWRtVlRIM2tocnFpOUxlWmhzMlNu?=
 =?utf-8?B?cXpINzdUWHh6VEV3RS9WTXF1NGVrRkxtczBGMUJVenJyNEw3MFVJSWlOT0ZU?=
 =?utf-8?B?Q2w3VHRCaDVsazhmb2FXNXNvRGZBSU1PU3d5ZkhvcExsWkl2TFBMWU82d0ZO?=
 =?utf-8?B?Z3l4UFBQYXNSdzV1Q3FLeEllZmFXbjgvUnd6Ym9ZcjNOSFp2enpvWHRSakw4?=
 =?utf-8?B?ZmExdzVXSkdIK09tamVnUUJWSWZkZVFFMHhrNFNwQWhmQWViT2ZwSWtpSis5?=
 =?utf-8?B?Y1pBbEk1aGVmamRlTm9obnRXZlpjQSt1dkZNYTBqZjFkLzlObVdSbDBBZ1da?=
 =?utf-8?B?Q3pxOW9WcVR5azdNU1cyMHNIaHQ5T2UzRWF0SE9Gd0o2dXh2NGtlNmd2YjlY?=
 =?utf-8?B?emNEbVRadXMvTFVRU3BIbnNIWmRaTTFpMjB4Qy9SSTh4cit5Zk55QjViSGZm?=
 =?utf-8?B?ZWh3WW1peHFrMVFSc05zMFVjcENGN25qT0NDWGhzdGVwYXhWaER4Ui9oWDNm?=
 =?utf-8?B?L3RQWVNYam12Vi9JWEVXNEx2MDM5enZEOEZ5WGVPMHVVYmpzWjl6aFJLcWJo?=
 =?utf-8?B?RHc3TmVkR0dFNCtITDl2bzNienJmZ3hxcUJWUk5tVTFpY2UzT24zZzFySklI?=
 =?utf-8?B?ZjNPWDMxUHk0Z1hYbjdKWjZ6TloweWhHK0xsSjZNdGdxdjVyRm5vbUh6d09B?=
 =?utf-8?B?emZ6QWtFVmJsQ05VWlZpZXlxTlZoZEZqVCtEYjVvdTVVT0lXTGFaRDN2R1Ft?=
 =?utf-8?B?VGpoM1FTQlVDb3hrczFaWFZQM3FibEdtQ3ByUHNuWVdidEtrTFBxbjBIajFZ?=
 =?utf-8?B?bm0wTmt1bkxNb25BUzVzN2NuWkErUFozWUJqTXl5S0pnUHZEaUljNTMwdFVD?=
 =?utf-8?B?ZWM2Y3FDbmYxT2VIUTBBOUEyRldHOEROQm4zQXdxb2JmNWtob0dvajl0Y1o4?=
 =?utf-8?B?NjBFTU9VNDJoeFBXa3VXVmtuUTNaeEpDamhuaTBvMXQ1cGtUVDEvbm9MMGJp?=
 =?utf-8?B?aGl5TlVMUXNON3hHWjU0aVJuR2hXVDR0RGMzaytIM1E3VWNIc05neERNd1RX?=
 =?utf-8?B?MmhWMmxVdHBvdkpXVVJWZGdjV0QwSS9VK2FsT2VkTGcvbUkra2xnakc2WkpL?=
 =?utf-8?B?TWtoRVdMYm9TT0xIYnUwSnViWk13dDUyNzg0dnRiODBIY0JnK1B5dHhlemds?=
 =?utf-8?B?ZWVEQTZzSUZMY2lSQU12T3V3cFAvcXN0VkZKODhqL1hTWUdjMWdHV04rUkcr?=
 =?utf-8?Q?+DX38X961mCZrbHh65gEj853O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dd52b3-a9c7-41b2-6a31-08dd7d8265cd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 07:35:16.7716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddJrQ2KAJnoLcIRskYuDGU2nEoUT0e0k9I5wKuwukm0vxpvXes8ENXd84NYCE88XuzKdRwa7NOZtk2AqfOGN/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745


On 4/15/2025 5:43 PM, Eder Zulian wrote:
> The pointer 'struct kmem_cache *dma_cmd_cache' was introduced in commit
> 'b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA
> resource")' but it was never used.
>
> Changes since v1:
> - Remove the 'err_cache' label and return -ENOMEM directly instead of
>    assigning -ENOMEM to 'ret' and jumping to the label, since there
>    are no unmanaged allocations to unwind. Based on suggestion from
>    Nathan Lynch.
> - Fix checkpatch.pl error: ERROR: Please use git commit description style
>    'commit <12+ chars of sha1> ("<title line>")'
>
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
> V1 -> V2: Addressed review comments and fix error detected by
> checkpatch.pl.
>
>   drivers/dma/amd/ptdma/ptdma-dmaengine.c | 16 ++++------------
>   drivers/dma/amd/ptdma/ptdma.h           |  1 -
>   2 files changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 3a8014fb9cb4..aefb91c29bb5 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -583,18 +583,14 @@ int pt_dmaengine_register(struct pt_device *pt)
>   	desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
>   					 "%s-dmaengine-desc-cache",
>   					 dev_name(pt->dev));
> -	if (!desc_cache_name) {
> -		ret = -ENOMEM;
> -		goto err_cache;
> -	}
> +	if (!desc_cache_name)
> +		return -ENOMEM;
>   
>   	pt->dma_desc_cache = kmem_cache_create(desc_cache_name,
>   					       sizeof(struct pt_dma_desc), 0,
>   					       SLAB_HWCACHE_ALIGN, NULL);
> -	if (!pt->dma_desc_cache) {
> -		ret = -ENOMEM;
> -		goto err_cache;
> -	}
> +	if (!pt->dma_desc_cache)
> +		return -ENOMEM;
>   
>   	dma_dev->dev = pt->dev;
>   	dma_dev->src_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
> @@ -648,9 +644,6 @@ int pt_dmaengine_register(struct pt_device *pt)
>   err_reg:
>   	kmem_cache_destroy(pt->dma_desc_cache);
>   
> -err_cache:
> -	kmem_cache_destroy(pt->dma_cmd_cache);
> -
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(pt_dmaengine_register);
> @@ -662,5 +655,4 @@ void pt_dmaengine_unregister(struct pt_device *pt)
>   	dma_async_device_unregister(dma_dev);
>   
>   	kmem_cache_destroy(pt->dma_desc_cache);
> -	kmem_cache_destroy(pt->dma_cmd_cache);
>   }
> diff --git a/drivers/dma/amd/ptdma/ptdma.h b/drivers/dma/amd/ptdma/ptdma.h
> index 0a7939105e51..ef3f55632107 100644
> --- a/drivers/dma/amd/ptdma/ptdma.h
> +++ b/drivers/dma/amd/ptdma/ptdma.h
> @@ -254,7 +254,6 @@ struct pt_device {
>   	/* Support for the DMA Engine capabilities */
>   	struct dma_device dma_dev;
>   	struct pt_dma_chan *pt_dma_chan;
> -	struct kmem_cache *dma_cmd_cache;
>   	struct kmem_cache *dma_desc_cache;
>   
>   	wait_queue_head_t lsb_queue;

Looks good to me.

Acked-by: Basavaraj Natikar<Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj


