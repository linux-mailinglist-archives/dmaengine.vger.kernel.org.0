Return-Path: <dmaengine+bounces-4522-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A80A3AA78
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 22:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E8C3AD922
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 21:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359B71BD9C9;
	Tue, 18 Feb 2025 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="opGNR+uv"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B2286292;
	Tue, 18 Feb 2025 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912524; cv=fail; b=W0SrW0mU9QidqQBurg6o8SN77Ie7u4YOJW786ItPGmK2L44agUoalSdbcwqPM9mbeIUCffOf7kk9VtCWf1eHuSyQGxaNtOnCQzr7BJHtLdJb4HJmgtA5gvi/29GcO20A20Sql7R18+N8BNJo5W8aeISbi87shZMNlGhvy7FICKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912524; c=relaxed/simple;
	bh=/2Ln6y1PAzMSq4jMhyRs0dDvvz9F9lNCyr1IyY/aTqQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=toq6nCMEvvcs1hjOPgfVOB2cxm8Cgxsj7nUIZou104slQEZargXyy1/hybqtbmTfcTw0DuiVpFYBW31j2vjvb0+XwH4/ts7RBACJkcOBQtbxuXZMVgRIPCxFfsQyZJrc7VCxgaz4QxqTve2SG5gfkFn1bmU2y9zT14LztUUQbcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=opGNR+uv; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ev5Ka5XDJtrEBODFCFxMiSkRBTtRHsifas60ik0k28PzDvkcJw6WV5MzYls0srUzb1LAkZkm+e8LNR3+3bqwUy9GisHCMA+Azgih0dZACvqYk07oQueRL+4QCbh3uFs/bfF/jDkbdW/S0zx4ZIC8HpDHhPZWlq7f6Q0h2He6xBQv+DF0DBE/lMr40YtHj7/tw256pKaxuP50a7kLfufX9tIG36JjYS37adn0OsFFl74/lMl8fYPcDbnJ08OzCBoL/2Gu702QH8nimJ6I8Mvlphw68HUk4EZHXUXk5vGn/IoPTB2UTdUFNLayUP6jK5WpSCiG83BZg4ctsZPO7+HQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NAa02WmhEvdqMtiei7nSBKsU01umKzLcvThaawJWZY=;
 b=wZRwXKyvTC2fiG/zTzlkU9v/wOUFdgUiXFxwSczcTMWJb6A9m5t1VE4ghg7awh0TVEo0XNtEtRoKBrDYeGphSRBAMeFLGyg1fC8mMpjLQTnUG0qe3ZhvJBOWrdn1xfcmOclXXjAbFLwWz/JIM3Q1ytJq81eHeuLGUh811Cx2wCTgKAcy7vRM6Qtl7zLXpEIJhy8d1SostC/PmEWEeH7z8d3e/d5wBiIZHOqhxxM4Q66tyYxYzDHUtHguS6WkfC8TyaAYd/UinGENiE5zGPYdXV32qbuJKwamhBVknJ/L9qYHH1ux6TAv5Va71mFTEGmuAMf4JEw9XcKbbCs3rzFkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NAa02WmhEvdqMtiei7nSBKsU01umKzLcvThaawJWZY=;
 b=opGNR+uvNAmwuwhrmf5st931IXlWDtS1QReelSiIlZNLPcA4QnB+skqVsiGOJ2MvLzFUtQ4a5ZMApk1BsPfV4ouz4emsULO6unbyv9pqNjPL6bKDAQ6krN6nBQanhxtfwZ6I4H+vgcUQR4wrh9HLbdC0PCxTCoJiFT3hGS4zGFXJqqi4uoZTxWHC1L5CURTUT/xOxL0ChNwrIt2P0vEbBWuQ7XW8tGtcKr5qn+ruiaW1Tsz6E7JoHWxGW8PGHNiIVoi3z9FZWZcMFvdtP0kHx6OZZ5ByceSpOGDokh9osb4xWvvdD06U/+1khRJ/nbmMxHdixsxf0XOzpxo+MPGH/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 21:01:59 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 21:01:59 +0000
Message-ID: <4b5b45b3-76a1-4850-aeba-ff4d6777e97c@nvidia.com>
Date: Tue, 18 Feb 2025 13:01:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] dmaengine: idxd: Refactor remove call with
 idxd_cleanup() helper
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, vkoul@kernel.org
Cc: nikhil.rao@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
 <20250215054431.55747-8-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250215054431.55747-8-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0139.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::24) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: d24e78e7-94b9-4fca-8a05-08dd505f7c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2pTSVhVdFNqZUc2MmtKMFYxY0RuR0MxYVhPUTZiYVI0SHpqNTV3aGNXaGRn?=
 =?utf-8?B?c215akx1Q1N4RzA3eEFVaEZPRXBtU1ZIekFIeUxwYWlSdC9idEFxOXVFNjFy?=
 =?utf-8?B?NGdaeUwrdStubXUveXlHR0xDMDVtanRIamZzM1AwMVAwTU1RY2NPeHVlSmN6?=
 =?utf-8?B?Vm5taGNWNlc1UzVKNVFldE9OdUwxOGYyNFJaSnFaQ2oxSkJ5U3p5MUE3R3Vo?=
 =?utf-8?B?d003dk1jTElIOWsvVklUaldOTG9HOXVWNUxWb0Y5TnBOVmIvdkVSVndTMklT?=
 =?utf-8?B?M3lPNGZRT1hUYmI1WjROd1k2MFZZNGlXa2NiM2Z5cXRlcWlZZU1kV0I4dXRt?=
 =?utf-8?B?WlhDcjZ4ZWhqTGxUQWsxa25VOUxlS1I2L1lnNFNZQ3p1bXlFNWZDMVo0MFEr?=
 =?utf-8?B?RUV0SXp3dmx5Q01FVjI4NHBhQWdzaWVXMWNzMWpRL29PdjVySWdvZzRXTllC?=
 =?utf-8?B?ZWMvWVBsOThnbWRpSEZhODRGcERiQS9IU2NYWmtHMmFHSmNYQVh6NFVUMFZO?=
 =?utf-8?B?RVQ4QlFkQlAzVy9ua09FTWdGZldFaDdQbTAweFJMc3dCQ2NwL1N2TFJ6a2Va?=
 =?utf-8?B?WS90cU1QS0tWT2w1VGF1RkgzRlBiSko3Vko4VXJkSWdldnczcmx1MlRtV0pP?=
 =?utf-8?B?MmRKNEVMTDlTZ2lZdjNibGJ2NFBSdWdqdDh3bnhwdXpPV04vdGhIMmVUQlZw?=
 =?utf-8?B?MkVScmhzK0tCZEJGODU0aXAwSFlUTWovV2duOCs5ZTMydzlwTjFZTFpVeXZ6?=
 =?utf-8?B?MUhMWTlmcDlkSWZ5WThCV09DNGs4d2kzeTBrM3pQeSsyUlA5enZMcUl6QVdC?=
 =?utf-8?B?MTNjTHg4WFBlMlRjb1RkaFRUelFyM3BDWUF2dG15TXZwTlpwV0NMRGJIWnpp?=
 =?utf-8?B?REZ6ZzRzMks5ZVlDVW9odUZzODA1dEY3WldxWHZUM2xJVm1MTjY1eEdxMVhz?=
 =?utf-8?B?Y1NrUFRKeWRGckJPM1R2alIrVGxLTlEvNTRKcHJ4Q3BydEViS0NiRVlOUEZT?=
 =?utf-8?B?ODdqai9laC9KN2YxYVJhM0NOSW5Dc01jcmRLeERqY1A4eFNBaWMzTlVOS3hM?=
 =?utf-8?B?TVBRTjAxQzBLZU1lY2ZDaWFiOUc1d2dWTjh5bWNQYUw3U0RTcnl1L2N0YUMy?=
 =?utf-8?B?OUU2ZkJOakxla1gwQy94TXY3Qy9aL3VFd2w1QmZHZUJrckNmMnZwK1o0ODZl?=
 =?utf-8?B?QXJnWXJQc0IzQzlYZTZ4UWo3SGhLbHVvOTdPK0QwcjBkTUNSVFBvZDVCa2Yw?=
 =?utf-8?B?TVhobk1PTVdlUmVIRnMrN1BSUW9yK0xjeDE0c2c0SDdYa3k2RmIwTGpuUzVw?=
 =?utf-8?B?elJMNThzTDc0S203WTNTd2RzRUN6OVlqUTdKNWcvODFIU0VMUnc2RG5mdWk4?=
 =?utf-8?B?Q2JoelpHa0ZQME9UMThpa2tXeWlLeVZPQ1dHZ1dTY2FtcGcrNFRGYXJIMEhZ?=
 =?utf-8?B?TUN5eWRXS2VUV2o1azFjZUdqMmF0UzB1TWJLZDI1a3ZrUmVhL2F5RjBia1dQ?=
 =?utf-8?B?UU1Ha0NsMnU5eEFxdjMrR1YrZmw5NCtXTEh0ZENiSjNuTXlxaXBoVXNrTTNi?=
 =?utf-8?B?SVJPenQ1aWxXTWxkOStJRUdLZ1FuMFNEMWdIYlYwVkx1c2Z2SUpiK1ZsQ3Np?=
 =?utf-8?B?Z3VwZjFlNG9WeGJTSmtPc3ZlcGVzSUtsZkRDdExuQU42eUVkcGJ6ZmlyaUIy?=
 =?utf-8?B?MGM5bzdKTHQ1d0x5NHRpcnZCd1kwL3lhQko0ZlBDTnBNcmFMZHV2aW1zTzJG?=
 =?utf-8?B?RkJ5YzIxWWlIZWxuMjdLYmZ5TzdSMWlaaVlPUEE3ejU3K1VQKzQzV3hEblpm?=
 =?utf-8?B?OWN5cGhmektmeXVaUUhSRGJGYTFwUDVOVWRJZjl1aWdNaHUzR3k5dEhtdm43?=
 =?utf-8?Q?wjJf7APJMCUpA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2RIWFIwWUpPVlFtREVyN1hxOU85eHdBd3N2dTRRQWcrVE9lZEgzaGpqbkZE?=
 =?utf-8?B?NTl5Yk94UEo3OGhNUGI2OG55bjhxWUZqcTRWL21BTTI5L1VDZEhFcUhIUVJO?=
 =?utf-8?B?YTc1YUlWT3grYXpvT0ViYWhHRmNiYW96Zjg1b0VMMkk4QnpVeE9hSk5DRXFl?=
 =?utf-8?B?QjM5MUl1YWtWVzBxS2tMU3lxSDZqeTIwMHl1RkNoWDNiQlJ3cExKbnhmbmtj?=
 =?utf-8?B?eTMrby9QKzlDdUlHaGY0OGtWQm1xVWpOTHJpVHVicnNnUGtmL3RCRXBCY0lP?=
 =?utf-8?B?TU8zN2pxMEtSV0tNbFBpOVJ6ZVBENlVuV0JKL1JQaEx1VDV2Z3B5QTV5clo0?=
 =?utf-8?B?VUdtOXFjdzNzb1JYbnh2NWVsOWlOQnU2dkZ2ejI4YUpWUTNuQVVlcUwzZHA5?=
 =?utf-8?B?RDFVNnBYS01rWWwvTEZSWWZiU0Z6aTJIYUdFK1pXVWhSc3Y2WEkydmUveU5T?=
 =?utf-8?B?b1NhbWQ2dWFQaWtGbUdzeUVyOUo5eTdUUTNqRnNxL2hqLzA0N0tINDJJUUNX?=
 =?utf-8?B?WDBtcUlqbysyS1FwcWlNS0RQUmsxMUE1eFZUOEdHdkNJNjBuVHBNUUhVU0Ft?=
 =?utf-8?B?ZVg5SDhBS2tWSExETDNDQjNaOHgwSEZPZkp3UU1vMThSOU1EaFdzREY4dkNO?=
 =?utf-8?B?aUtnTlVUZis3dEFNS3JZVkNwRWpUWlgwUWV0N2xjZjk4WC9QUGl2TUdDN1lp?=
 =?utf-8?B?aEMzV3N5VkdmQW5EOWRGVUordm55MXllWXM4Z1pvL0xuTlE4WmdFMVgvejVy?=
 =?utf-8?B?Zjk4ZVdMTFJxV1VqdlpFaU9SMlJLY0d0TDk1bXpVRWpVak44VnF0RnZya1dp?=
 =?utf-8?B?MnZRRCtCcGx2a1ZYN0p6V2ZXWGRlQzVNVk1hWDdHY3VSeFVCZERENjRtVVdu?=
 =?utf-8?B?bU5Lck9FYjlLRUxEUFVQR0ZWVHd4dERoa284Y3ZTZUUyS3M0YmxTbzBJajBI?=
 =?utf-8?B?bmtPNEtWMmJSMVMzNHdrZkdiOTM2dXc2c1IwazFaQ284OFRKUUFJeVBvUjY2?=
 =?utf-8?B?VnBmS0NuQ1hvdDdFamZmeTFPUy9ncGR6QS9JWS94aStrVklyT2dCckFuR1lp?=
 =?utf-8?B?ekxsNUVsc3RjdlZoemFTQ2pWTURpNTc1cW9XenlXdk5OSVYvalVTd3prM00w?=
 =?utf-8?B?MTZWV3dxWXI1eWQxVTRBYzBFTVBMdFYrZHNMd0ZSSnc0eGJSanJCRkEybTlt?=
 =?utf-8?B?N2pDaTZ0TWlJVVRwVW1zNXd5UFpwdCtLU3JXSUFpbHY1TUEzZzVUc1ROeUtr?=
 =?utf-8?B?aVNhRGI0T3U0Ujhzdm9Lc0l4VU81dnJCOHk4RFZrWTVQNzhLWkQwTHhqK1lC?=
 =?utf-8?B?R2tIS2RwYUxtbEhiR3ltVGluamZLSGFVVnhraklJbUJEUnNnMTIyT1Q5ZjQ2?=
 =?utf-8?B?eUZSMjdLVFpXR056N1NlYXcyenZFMDl0UjE2cVhsZ2llWUJpVkZKL1VlbE82?=
 =?utf-8?B?TThlRWJPRStNY2h3VUt4eHphd3RmamNMQ3l5ckJ1TnNhd2gyYUdkQ1FWVzNa?=
 =?utf-8?B?Rko5NzJnTTFrUHV0Q1RNM3l1UXJST2xQRzlZRnNNb1p6ZWhMczlRd2dDMjh4?=
 =?utf-8?B?SnFSa3ZmSDd1TXpRU0RKRGRyaUZkQ0RiWDhQcDZRdERmb1hESi9YT2ZRR0tv?=
 =?utf-8?B?ZTFZdnFtekhBTVJBSGhHREU4QXVuYXJENXpray9qdWkyQytVVnNGd3oxRUV4?=
 =?utf-8?B?dW9IblRURERESWJVUlY2djlCSGpwbFVQOHNIeXhvNk1RS0NySGhSUzRqelRa?=
 =?utf-8?B?ZktOVlJXd3VSRDB5c1lLM25pTGhSMXQwbXhPNTQrdmdRR0tvS09PNkZCQ21a?=
 =?utf-8?B?RUJXcFh1dUdjeTc4V2pTQVBXUitmbFJFS3hoZVRUMDBqV1pwb09zNlVUcTE1?=
 =?utf-8?B?MVUxZEZDUmVvRjA1RTBwMWZaWFBPN0xZU3Y2ZlJJSUVvSkk2SnQwTk8zb0dh?=
 =?utf-8?B?bnA1RjlzZEhPNTFOb25FaEJVa2FBTFhRTFliMjh6aWdLcEVtcjZzRFkwQWhV?=
 =?utf-8?B?SXUydHFFc0dlTy9zOFRXM0RwdHBlRjNTUmRTK2VUWENlc0Zka2d6Y3RreTRR?=
 =?utf-8?B?OEtHbGs5YVAwaTN6THNrclVyTWNyNlpsNDd5a2NwZXNpRzV6SElRNWw1ZTRF?=
 =?utf-8?Q?01ngzpEP8LCDCDK8Jmia2zSBJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24e78e7-94b9-4fca-8a05-08dd505f7c26
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 21:01:59.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wt/C7Vl13F/kdkfbyIKqFYB+6YRMTJOkNbB/eATm85bOYIsR1+OJByhDaNQwYjtnu0auhcV82aKq05BdeBU8Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737

Hi, Shuai,

On 2/14/25 21:44, Shuai Xue wrote:
> The idxd_cleanup() helper clean up perfmon, interrupts, internals and so

s/clean/cleans/


> on. Refactor remove call with idxd_cleanup() helper to avoid code
s/idxd_cleanup()/the idxd_cleanup()/
> duplication. Note, this also fixes the missing put_device() for idxd
> groups, enginces and wqs.
>
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>   drivers/dma/idxd/init.c | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index f40f1c44a302..0fbfbe024c29 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1282,20 +1282,11 @@ static void idxd_remove(struct pci_dev *pdev)
>   	get_device(idxd_confdev(idxd));
get_device() is called here.
>   	device_unregister(idxd_confdev(idxd));
>   	idxd_shutdown(pdev);
> -	if (device_pasid_enabled(idxd))
> -		idxd_disable_system_pasid(idxd);
>   	idxd_device_remove_debugfs(idxd);
> -
> -	irq_entry = idxd_get_ie(idxd, 0);
> -	free_irq(irq_entry->vector, irq_entry);
> -	pci_free_irq_vectors(pdev);
> +	idxd_cleanup(idxd);
>   	pci_iounmap(pdev, idxd->reg_base);
> -	if (device_user_pasid_enabled(idxd))
> -		idxd_disable_sva(pdev);
> -	pci_disable_device(pdev);
> -	destroy_workqueue(idxd->wq);
> -	perfmon_pmu_remove(idxd);
>   	idxd_free(idxd);

put_device() is called inside idxd_free(). Seems not easy to read code 
to match the pair.

Plus idxd_free() is called only in non FLR case.

Maybe it's better to change this code to:

1. call put_device() outside idxd_free() so that it's easy to match the 
get_device() and put_deivce in the same level of function.

2. idxd_free() called here is OK because this is not in FLR handler. But 
only call it in non FLR path in idxd_pci_probe_alloc()

?

> +	pci_disable_device(pdev);
>   }
>   
>   static struct pci_driver idxd_pci_driver = {

Thanks.


-Fenghua


