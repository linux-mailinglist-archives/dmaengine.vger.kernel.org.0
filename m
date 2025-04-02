Return-Path: <dmaengine+bounces-4800-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D210AA796CC
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 22:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 098937A5401
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 20:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C671EB182;
	Wed,  2 Apr 2025 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QL/0I/KS"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F07193436;
	Wed,  2 Apr 2025 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743626864; cv=fail; b=GpfFuGw3cWig6v/+cOzRQVDJtbV4o5LxnOv6smaU9Yjw5+iPd801SF4oL1Y35CNdCr2dRseznY2mhLE4DjSgq4OSmIFeqiwLoFOKEhqzfm8yRUDS3h1CT4qULN3hVx8xXW3T+rK1DoKwX+BmSH5vdca+E4gaGEk+DsgQVNMdPO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743626864; c=relaxed/simple;
	bh=UgqAALutbmKDbwLHPBlydZp87T7k3Smen6eY9f86i/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b7/xqMo5lz6Urfu9dGmU07O2OF4wKi21bVK+ftErAXZ1BfEAMy1gsrDolKVhvVvc7eb2CzRaorsbjTqf4b8WKZaJUxsHZ6bWXe+W32zs7Y+EYWNnDakb0kWaRa6mbY/OwlJY1/CBMGaOu6IdcktoN2GtbVIYrcAV171B1s0rw50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QL/0I/KS; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYHcAnTSG0NQA3Q6H1Y28kDMnezZofADRuNEI6ynZXZ4ACBXmz5FqhvjP9BaGnNi9QgYamEpVVATCaIzs9qhFO0w47Nr80q4IKjqjRRaLROujjGb8seX3P/K5dPy8UDURrwU3zzo0FtdbyDzn4dEDWpdjTwbfFooOHwPkDboyKKijDbNlVILepCmqm4OFWFCToe4EGV3gubIvEjqSwOpT+lPb1sMYkZFPOigiXNipANK6dzm0C/8MKPJJAByjbwMpCp7+XHP8SKUBmO0SM9mMy9KhnxDpw0u6Id3kNUxgoIyneqiNMhOBGw6MwN8k1QnsOAcPKceSokGxIE4zvIfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPbuB3LFulD80PSHnM3f5nid/zw6zVV6YOl7lh4gDhU=;
 b=LFa2l6bBK5MWUGIN7c30BaDu5DHbo6NaVeWv+c8KLQ2SiODzV6dRpYM8ul09ZO7JLwd07udJ/dkXRibjaXEU9lYr1a2psZE7/DYInhq8OjU73F/cgMFq9QtzfGTnpRhI3o9W/xkB0UtkeYZ1N3IXd4o2BriMzFTRTbK7PIC8Hf3E7UhOFKtCroUXWEXZkcwwnXBAdvU6CCdekVC356lN2h+NsyI6B7d2Rd8E9+XiCV9XRmBiGy7U78nHCdtgNkaDPovyVtN4uDlsXNeLYnoNbW9Rj48pa5HHvqmOQn3xYvmEacrpa1h6ledEL0P4PRMX80zMXcw3LO+W5pQ4UNduwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPbuB3LFulD80PSHnM3f5nid/zw6zVV6YOl7lh4gDhU=;
 b=QL/0I/KStMZiJv2AZ8B7yVcLMEVRrFNyXImaGvZ3VHYnvYNcxVzXpXnnZu5KWV6xBqSIUgZtfpqKe2v7R5RcmPMn7RRboNYQOK1SyZQh7Ogk79JBxYp3iYDYc9apRwY8aa8yQ9k+iKqAV6m94ZluTCVJgOKUzYvkZmzyOzuKXvCXW5fC05z28c3eBRgQN5jfEdtcToHZ0j01NfhYLboOGi04NJpWj6UVypVUkt5MAJUTfZkts9+AG0ryy4+ZIDePQLaiHkSVwfUeB4NKfNlqTn6Z414KePj6Fz7/auaCvVxRisk55WeuZkZ6nQyHv25zX3bQ+o0Op2x/XnDdto8/rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.46; Wed, 2 Apr 2025 20:47:38 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 20:47:37 +0000
Message-ID: <12bbcd96-9399-42ac-8232-729652f6f15a@nvidia.com>
Date: Wed, 2 Apr 2025 13:47:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma/idxd: Remove __packed from structures
To: Yi Sun <yi.sun@intel.com>, dave.jiang@intel.com,
 anil.s.keshavamurthy@intel.com, vkoul@kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gordon.jin@intel.com, andriy.shevchenko@intel.com, yi.sun@linux.intel.com
References: <20250320081807.3688123-1-yi.sun@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250320081807.3688123-1-yi.sun@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::29) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d1e927-2220-4302-0e3c-08dd72279a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmZwNGRMbDc0SXp1SG9WNXdXREhoczJvQnFZb1BKWGJuZFNKek5UWFVBME5I?=
 =?utf-8?B?Ris1RnljZFg1Z2JSR292WWtLSkk1cVIzdlVTditidmZOYUFjRlhJM2tFZ0tQ?=
 =?utf-8?B?SkxQVS8yMzlmZ2M3c2VZQWpWV3Fldmw4d1RuYU9QakhwcXdrQ3RQeWx6T2s0?=
 =?utf-8?B?YUtlUEtsK1FIMGdSRkwwdzk2RnBjOVRWa1FMYUFZcEQ3OUlVT0VYTnAvOHRi?=
 =?utf-8?B?dWR0NHk2MjM5R2hCY2R2V25kTXhtSFVQTVFXUjloMmo2VVA3S3dvSnU5WGsx?=
 =?utf-8?B?Y0gzU3RleGx5cmxZVGc5cm9tZHpIZVNseDNaQ3J5bk56N3QwQWEveDhFQ1Fv?=
 =?utf-8?B?Mm9DdFpsZ0FlYUt5QmxRQW5nOGtpMi9EWkZkNUlCTEdOMk9LMjNYODVFSDNM?=
 =?utf-8?B?SzV0ZngzWXExTUJBWkRXTnJ2L2J2YlBoVkR3MWxOWklNdjdrc3lCK013N3pa?=
 =?utf-8?B?U24rUHNHMndMZFpzRmsvMnM0Rnh3eDZrNVJsOEdLaFhOMTBqYUNMQkZFOFcz?=
 =?utf-8?B?R1k2bnpvMloyZk95VTdkRHdNRnQyaEg3TTNDcFV2cHBDaHNXdjJCYS95Y0ti?=
 =?utf-8?B?MzNOeGNTaHZNL3V6VnNMeTlUbDJPL29DQVNWb0kzK0FjV2JLeE95TUZYT2JG?=
 =?utf-8?B?akZYRnpUdDY0UXlXK0VDdVc4RVBqU2RubGFxbnR5Z1hMQ2JLTFQ2ckhWRzJs?=
 =?utf-8?B?V3pueDVYSkkzWnBHS2VEZm9wekRxRTRVV2ZJSGJTNThQWllYb0FBZjhSQ04w?=
 =?utf-8?B?ODJMRTMwWmpzUnZyZXRKSkt4VGd5aUZrdGRXMHpQUE9ON0QyK2Mwa1NHSStI?=
 =?utf-8?B?L2c0aXlhd1JMNkhXem9acGpENFhsTHNpemROait5Vjh1WDRCcmI4L0JiR0x4?=
 =?utf-8?B?MlVZak9WOGZrTklwRTd5TE9MdWRwT1VXQlE0OEF4WURjMytKTzNsbXdtM0Y1?=
 =?utf-8?B?eUMyVHRTRkM0S01tZ1Z2TDFvMThOcFR1UFpjVjV1Zk9iamhSNFYwQTMvOXRI?=
 =?utf-8?B?YzBQWUNpL1htOGw5dGw3bWFFNExPUmlZYTdpQlpVWDY5emQycDFacmVjVlJs?=
 =?utf-8?B?QnA3dHNsNGtjRkFiTHpsZ2tzSnU2bm42S0FVWTJScWNpT0JUWGZzdjlyT2hj?=
 =?utf-8?B?dVJTTm5teXhLQzNwSmZIOFl2OWluRE1UWnFxaC8rd3orYkFyek5WakZGVGVJ?=
 =?utf-8?B?SEg1OWN3bEVQUW5FREhnK1Zha3dldWxJMUkvNW1WR1hlMm5vbkp4RmRlR3dp?=
 =?utf-8?B?YXdYN2hoN1BDQWt1amVuSE9oTHlNcXpwY0JTYTRtajJNVkh3M2NaTHhVUUVX?=
 =?utf-8?B?Y3FnQnNrYmhrQUVRQ2hnU2tqREVVK1AwNzFwOUorZ3ZiOHNlVFlmMjd5UkVX?=
 =?utf-8?B?TEtyd05TV0VPV0JWUjlCRXQ1VERIMWVMOHFGT2pOM2d5YWZWam0rV0RXb25s?=
 =?utf-8?B?OFBnemdxSWZ0elo0N2hPNE56WERIR0czUkhtSmFOSXNwWGxYRnJGTlAxZHpD?=
 =?utf-8?B?T3NPMTFPbHR5clY5ZE9JRFhBby9EaHZtZ3NmaXdHYW44U3k4YTJhNlFVQVQ5?=
 =?utf-8?B?RXlUQkJJcDhEc095TEY4V3BUcVV5N3BZQ280cFpEWmRPZWl0ZHJtK25aWWtH?=
 =?utf-8?B?SENrYW94clNndnVmT2F3T2piWlFnM3VNT3BnMEpwUVZYb2UyUGJWNHBYaWdC?=
 =?utf-8?B?VmwrV3EyeFh4WHE4cWFVQWlSQjlDMXhIdHRnelNya2V2MklQTUF5YXc0b2VM?=
 =?utf-8?B?UitCSXpoY2J0NmZOL0t5ZTMzenlNdU44S2RUWnhoOWpEbjI5a3dJVVJKYU9B?=
 =?utf-8?B?dlBWVGxOcjZkMTBxQTI3RVUrUk05NFpqZmNMOEZ6ZHhTU2lva2pBRERqN2tu?=
 =?utf-8?B?NThZcEpNcmRzTGRZcU5kSFFjMzlRTnBkejdZZytuNWh0ZFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUN1ZnNMSmhJWG5mbUlKRmVHR09SZVV0VVRveHhIYU5YUEtPYzducUpHcytl?=
 =?utf-8?B?cUJ1cGxHRlpiVnlianZBZVFVZG1jOFVPTkJMc2svSUUyT1l2Tmh6VWRFWS93?=
 =?utf-8?B?eDl3bW9INUVDWG4zdnpaY0ZHOXlaMVRRckdlaE5QQWlQeHFhTi95aDE3NkNT?=
 =?utf-8?B?STJJUlZycVdCYVJTSmVwUHptZlNHWkVzNEhWaGV5U2hKK2I1dzllUjVvZGpl?=
 =?utf-8?B?R2FlUCs4M2ZaSlNxWVAxenF1MUcvVitsTm9penNHYStjby8yS1NyV3pCZVJC?=
 =?utf-8?B?MFdMeGh5VWI4OENubkxOSEJ0Mm1PUUhxZXhwd0ttVVcrNDZyOGZxU3RVUWpB?=
 =?utf-8?B?YmlJOVNBVDA2R1hSOHB6UzU5K21DUDIzV2ZnRVZLcVR2blg1K0JEN3A1MXhX?=
 =?utf-8?B?VFhSOGdRUHNRNTNjNXRxVTBpRWw1cXFWN0pCVkwyRTBFc2ZsTFlXVEZhWVV1?=
 =?utf-8?B?YnFLQmlnbEUxendLcFpxQXJQS0dJaUcrNUpURHBOTWpUMk1rRkxZVTlra3pF?=
 =?utf-8?B?M3NrSEg3eC9rUVpiQ3JKUlJwUW53dWdpUEYzNTJldmxaaWZGMHNIczFvd0xz?=
 =?utf-8?B?Y0YvTUFTMEdvTHhsS0pkMnlEOHBoUlJzd0ZXTlRvaEwrVU95bWpjWGNyRHFO?=
 =?utf-8?B?MVhmdzRtSk13cFVjdWFKWWpTcEh4bG5Bc1NiaHJ4KzYwb0E3eEI2aENGTmd5?=
 =?utf-8?B?dTNBTzVTYXFZeDdRTU5iZHRMckZHUVlEdW9MV3BZMHpqcnh6SkFVMUs3VHdR?=
 =?utf-8?B?RFl2Skt3Yk55c3RWMER1dTUzMS95TlBjemgxQlJFWmhteWZSWEgrYURnY2J2?=
 =?utf-8?B?NW1DQnFqV3ZhZEQ1dnltSTVjdlpZeG5TMWxpNTJ1aEowMjl5cXo0RlNYa2NR?=
 =?utf-8?B?YlFZTVRUTXpRbFlGNjJrNlNPZUtxcVFjbU1HNElERWhQVGtEVWNTWE1zQXc1?=
 =?utf-8?B?Y1UybExRUXdxMkNtL3E4ZFpzNWY1MmlDemI4MEtRbklVcXJsOVRrNll6cmpK?=
 =?utf-8?B?dDdLNnBOUGtwcitGV1djeDdnL0tmR2ZOTmRuSk9XenBFUERBMU5JUjRYeVUx?=
 =?utf-8?B?WXAvUG5EVE5CZDFzbXYwRmx0NUxqM1NKa1JoYytESDlwOHE3MjNXY3F5dnV4?=
 =?utf-8?B?WUIyL2laQytsM3ZUWHN2Myt6Q2NoUk5FQ2JjMnE1ZmZ1SWVCL0dPZjVRc1pY?=
 =?utf-8?B?N3J6SmJ1bE1kRDNRa241SWxUKzZ1SmJLYjA4K0pES28xSFRWbmswYzVsRngx?=
 =?utf-8?B?djJtT2RCbjVLeitxcU5HV0pJbm9ENzRnaEhvOGR0SzJsUFNQUUtscTRXeTlK?=
 =?utf-8?B?dDBaOFY3cGh4eDl1NWdLZUdzNDdxQ1hua0lLd0ExbVRtNXBQVlpmMFkxTEFC?=
 =?utf-8?B?clFQL0hBUTNjaUt2NXhMd1RPODI5UnFTdVB0eTJyanZqdDlQbXJLSXo4SnZP?=
 =?utf-8?B?YzBTK1BQb1N6djEvSFpDNFBZalRsWHovbHhqQ1Rnbitvd3NIYVN0RFp3aUVL?=
 =?utf-8?B?akM3M3FjOGlDdGlicWZtUGJybzhkWWpEcE5NWEJRdnBOa1hoUjM3Q1ZRL0Yy?=
 =?utf-8?B?bUpHYlV1bDhIUTJIVWNwcEJEV3gydlZzNUlNdmt0RTh0U1Z1c2poMmg3VDlG?=
 =?utf-8?B?OG94bHVqZUU4Y1NNWG9ueVB5bm4vNEplNy9SSmhtT3JIVXJTTStGUkpUMnpm?=
 =?utf-8?B?Umh3RHo3aVR3Zkw2Vzhjdi84MmdFL2U0b1RZOTRLZFlmeDROcjVOZTA2eGxM?=
 =?utf-8?B?eFhROEliRnVtMlUvdlFUUXd5NnNMY29PaTJkUmdPYXVjdFhOTGhWSTdETHNF?=
 =?utf-8?B?Y2pNbEdtYzFiQkppdExrV1hIa3Jra2tEczlIQ3lGSGQ4eXA2UXBURlNQQi85?=
 =?utf-8?B?YzVEclpwcmY5U2xUZnhWRDliMmhUWGtNQWhGNlFRTlJYSTVyWXpMWlVOTGNT?=
 =?utf-8?B?Z1ZvYk1KY2lSZmVGL0dGMmFOaW5XVXkwYUl3Z2xPeXFkMXc1c3AwV1pGYXpR?=
 =?utf-8?B?bzRvZFE5eWpkTXRYWFd4QkZXSWJyZ1RKY0J6YnpHdVBFR3BvZnJzYlBQaFpx?=
 =?utf-8?B?Z1puQ2ZNenNLMHdCWjZEajh0bUN3b0NmalJCamUvUkhIbktJdDkxbkpuaXha?=
 =?utf-8?Q?nn/zS/ZWmwStDCzKa/CZ+rwJt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d1e927-2220-4302-0e3c-08dd72279a46
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 20:47:37.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCLCX3cZ1b58r88z0ghHrx1mz4JzU464kRUBa+zYlofAyByFk5K0Ftz1MHBt2a7XyOCZRfHQ8qJxuc/Ns+fp+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633


On 3/20/25 01:18, Yi Sun wrote:

Please change the subject to "[PATCH] dmaengine: idxd: Remove __packed 
from structures" to match idxd driver patch convention.

> The __packed attribute introduces potential unaligned memory accesses
> and endianness portability issues. Instead of relying on compiler-specific
> packing, it's much better to explicitly fill structure gaps using padding
> fields, ensuring natural alignment.
>
> Since all previously __packed structures already enforce proper alignment
> through manual padding, the __packed qualifiers are unnecessary and can be
> safely removed.
>
> Signed-off-by: Yi Sun <yi.sun@intel.com>
>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index 006ba206ab1b..9c1c546fe443 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -45,7 +45,7 @@ union gen_cap_reg {
>   		u64 rsvd3:32;
>   	};
>   	u64 bits;
> -} __packed;
> +};
>   #define IDXD_GENCAP_OFFSET		0x10
>   
>   union wq_cap_reg {
> @@ -65,7 +65,7 @@ union wq_cap_reg {
>   		u64 rsvd4:8;
>   	};
>   	u64 bits;
> -} __packed;
> +};
>   #define IDXD_WQCAP_OFFSET		0x20
>   #define IDXD_WQCFG_MIN			5
>   
> @@ -79,7 +79,7 @@ union group_cap_reg {
>   		u64 rsvd:45;
>   	};
>   	u64 bits;
> -} __packed;
> +};
>   #define IDXD_GRPCAP_OFFSET		0x30
>   
>   union engine_cap_reg {
> @@ -88,7 +88,7 @@ union engine_cap_reg {
>   		u64 rsvd:56;
>   	};
>   	u64 bits;
> -} __packed;
> +};
>   
>   #define IDXD_ENGCAP_OFFSET		0x38
>   
> @@ -114,7 +114,7 @@ union offsets_reg {
>   		u64 rsvd:48;
>   	};
>   	u64 bits[2];
> -} __packed;
> +};
>   
>   #define IDXD_TABLE_MULT			0x100
>   
> @@ -128,7 +128,7 @@ union gencfg_reg {
>   		u32 rsvd2:18;
>   	};
>   	u32 bits;
> -} __packed;
> +};
>   
>   #define IDXD_GENCTRL_OFFSET		0x88
>   union genctrl_reg {
> @@ -139,7 +139,7 @@ union genctrl_reg {
>   		u32 rsvd:29;
>   	};
>   	u32 bits;
> -} __packed;
> +};
>   
>   #define IDXD_GENSTATS_OFFSET		0x90
>   union gensts_reg {
> @@ -149,7 +149,7 @@ union gensts_reg {
>   		u32 rsvd:28;
>   	};
>   	u32 bits;
> -} __packed;
> +};
>   
>   enum idxd_device_status_state {
>   	IDXD_DEVICE_STATE_DISABLED = 0,
> @@ -183,7 +183,7 @@ union idxd_command_reg {
>   		u32 int_req:1;
>   	};
>   	u32 bits;
> -} __packed;
> +};
>   
>   enum idxd_cmd {
>   	IDXD_CMD_ENABLE_DEVICE = 1,
> @@ -213,7 +213,7 @@ union cmdsts_reg {
>   		u8 active:1;
>   	};
>   	u32 bits;
> -} __packed;
> +};
>   #define IDXD_CMDSTS_ACTIVE		0x80000000
>   #define IDXD_CMDSTS_ERR_MASK		0xff
>   #define IDXD_CMDSTS_RES_SHIFT		8
> @@ -284,7 +284,7 @@ union sw_err_reg {
>   		u64 rsvd5;
>   	};
>   	u64 bits[4];
> -} __packed;
> +};
>   
>   union iaa_cap_reg {
>   	struct {
> @@ -303,7 +303,7 @@ union iaa_cap_reg {
>   		u64 rsvd:52;
>   	};
>   	u64 bits;
> -} __packed;
> +};
>   
>   #define IDXD_IAACAP_OFFSET	0x180
>   
> @@ -320,7 +320,7 @@ union evlcfg_reg {
>   		u64 rsvd2:28;
>   	};
>   	u64 bits[2];
> -} __packed;
> +};
>   
>   #define IDXD_EVL_SIZE_MIN	0x0040
>   #define IDXD_EVL_SIZE_MAX	0xffff
> @@ -334,7 +334,7 @@ union msix_perm {
>   		u32 pasid:20;
>   	};
>   	u32 bits;
> -} __packed;
> +};
>   
>   union group_flags {
>   	struct {
> @@ -352,13 +352,13 @@ union group_flags {
>   		u64 rsvd5:26;
>   	};
>   	u64 bits;
> -} __packed;
> +};
>   
>   struct grpcfg {
>   	u64 wqs[4];
>   	u64 engines;
>   	union group_flags flags;
> -} __packed;
> +};
>   
>   union wqcfg {
>   	struct {
> @@ -410,7 +410,7 @@ union wqcfg {
>   		u64 op_config[4];
>   	};
>   	u32 bits[16];
> -} __packed;
> +};
>   
>   #define WQCFG_PASID_IDX                2
>   #define WQCFG_PRIVL_IDX		2
> @@ -474,7 +474,7 @@ union idxd_perfcap {
>   		u64 rsvd3:8;
>   	};
>   	u64 bits;
> -} __packed;
> +};
>   
>   #define IDXD_EVNTCAP_OFFSET		0x80
>   union idxd_evntcap {
> @@ -483,7 +483,7 @@ union idxd_evntcap {
>   		u64 rsvd:36;
>   	};
>   	u64 bits;
> -} __packed;
> +};
>   
>   struct idxd_event {
>   	union {
> @@ -493,7 +493,7 @@ struct idxd_event {
>   		};
>   		u32 val;
>   	};
> -} __packed;
> +};
>   
>   #define IDXD_CNTRCAP_OFFSET		0x800
>   struct idxd_cntrcap {
> @@ -506,7 +506,7 @@ struct idxd_cntrcap {
>   		u32 val;
>   	};
>   	struct idxd_event events[];
> -} __packed;
> +};
>   
>   #define IDXD_PERFRST_OFFSET		0x10
>   union idxd_perfrst {
> @@ -516,7 +516,7 @@ union idxd_perfrst {
>   		u32 rsvd:30;
>   	};
>   	u32 val;
> -} __packed;
> +};
>   
>   #define IDXD_OVFSTATUS_OFFSET		0x30
>   #define IDXD_PERFFRZ_OFFSET		0x20
> @@ -533,7 +533,7 @@ union idxd_cntrcfg {
>   		u64 rsvd3:4;
>   	};
>   	u64 val;
> -} __packed;
> +};
>   
>   #define IDXD_FLTCFG_OFFSET		0x300
>   
> @@ -543,7 +543,7 @@ union idxd_cntrdata {
>   		u64 event_count_value;
>   	};
>   	u64 val;
> -} __packed;
> +};
>   
>   union event_cfg {
>   	struct {
> @@ -551,7 +551,7 @@ union event_cfg {
>   		u64 event_enc:28;
>   	};
>   	u64 val;
> -} __packed;
> +};
>   
>   union filter_cfg {
>   	struct {
> @@ -562,7 +562,7 @@ union filter_cfg {
>   		u64 eng:8;
>   	};
>   	u64 val;
> -} __packed;
> +};
>   
>   #define IDXD_EVLSTATUS_OFFSET		0xf0
>   
> @@ -580,7 +580,7 @@ union evl_status_reg {
>   		u32 bits_upper32;
>   	};
>   	u64 bits;
> -} __packed;
> +};
>   
>   #define IDXD_MAX_BATCH_IDENT	256
>   
> @@ -620,17 +620,17 @@ struct __evl_entry {
>   	};
>   	u64 fault_addr;
>   	u64 rsvd5;
> -} __packed;
> +};
>   
>   struct dsa_evl_entry {
>   	struct __evl_entry e;
>   	struct dsa_completion_record cr;
> -} __packed;
> +};
>   
>   struct iax_evl_entry {
>   	struct __evl_entry e;
>   	u64 rsvd[4];
>   	struct iax_completion_record cr;
> -} __packed;
> +};
>   
>   #endif

