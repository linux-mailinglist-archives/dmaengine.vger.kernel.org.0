Return-Path: <dmaengine+bounces-4519-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC4FA3A8A9
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 21:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A578173FB9
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 20:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F281B6D0A;
	Tue, 18 Feb 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GTWF/Hp+"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665E9475;
	Tue, 18 Feb 2025 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910262; cv=fail; b=j9juDB43agyUp9aBoXB8//ut+0rsFQa74/pqZ8FdxhW6BQC/51w79j788gZ7Qrjtj9uYqYLQSgfaUBY/Q1T+mSVpb+cjezKrt1nRCjTrMU82ya6oueALh/cVgyHsWYi+uDDa0VZEwfQQ+rYFQcbjpu15Gv4iFs7xAcsU+ki/Fk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910262; c=relaxed/simple;
	bh=HeRocu9hCaQgh31hn/RFSRbHdRJV1bsVt/7E8sgJx6E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D7MK30pZVKqk5bOISE1yEFqBjXqSAqzBsfqTQtan/t9z3sSyBVIRiS0u5IcQ0grhPLLjtqEsjs2UvyCx5TONdau8O/WQe6QkoX9RlNrFDo/Xh6LfPAGH66ku7B1j3FKSsBpnSco3WkWtVtyTbR6P11ynDMp7mxWgIeW3dEMaJl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GTWF/Hp+; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SER+BsLZTY2jjUStzeBhO8EKfQbnlW+2X++JpoF69yfZmbp4ZWwnABDWsgOLLlUvKVhRw/yW/YsNkOJTo7HwOjRAK1CAwOT4rUWiZFfex+MnCgRGzbqTpnw98cCCeTtbvLKaZNpGVIWm4b6ad2D/X3y8Tf1nNJ794Em5Za48S5r4q64+8J7OtxAMHBmfMCkV5GA5w7hgiCBcXd4RGPPoB1p6h6BtyTtTs6Biy7xotXewwVfATNJp2pyiLX6svJdi4GIIweRUy3VAg8SC4F+nx3LvkBaXq1A4c9zZrXjEsNVOzwvNcsP9MmQKgKjvtIYPJqghEJF94xYJKuC/7wZtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7owlGHXPqZtPV7WC6rlaLMO1GRVHJ3lX000xTn9R2DI=;
 b=tacRU8vkVAOh7TEnXROFDuhjyCYUMS1QNESotoo4whP/cH+iQ8W/C1ENntYd0qcNs0rWoJyill0XZyzWaD03Dj04SXLk+EPJ6NBeytYgbBusytBgbtDPHLkeop50n2OdYsebLfK/cB4yCABSg88fQWp1A6zXOECmATEpy2bp4EKnp60eHXyR3vHhlDFZsYGThhK8q4UCwnArrSN6mOGC26B6jhZShw3gdFN+hrp7dLs9XnafqJVKDAfnL8rRRc7ylyWZYLbjqycH4iP6D66T/NpH2dvhGkxEbGkYPLpPt2kY1D5EIvghzTyPpjudO/Yds32aV6BqEKO6kEUhgLb1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7owlGHXPqZtPV7WC6rlaLMO1GRVHJ3lX000xTn9R2DI=;
 b=GTWF/Hp+5D3aTl7wejcsH7cmtW7VfnXvE6gjDeZYx2qls2NGfajYWUAir7tFjTcresW4lphWGKtXJJP95Q5llbjPfLARF546kHPxnRK9TxM4D82T5b3G8ZFCvJihXWVL/SQSNL1L6win5JVvab9BrxVwYsZOPEERBuHs3o8D3CDA49rRXPmxyidMlCy5HACjCHyDMFgriM66T8YHQXe52YSeWZjF9I2jCg9pF0I55mDRu9/+u8BxbcXqVDPbcLUpA5b5akvNUmrj/l6iRTrWv/LOfyH9oGdC59Fax7jA0lpfys5z3jWo98htvEFvqMFPWAY1ACcwrR5ylM8Pc6xr8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Tue, 18 Feb 2025 20:24:19 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 20:24:19 +0000
Message-ID: <8f57713e-2581-4317-9166-dbcaeabceaec@nvidia.com>
Date: Tue, 18 Feb 2025 12:24:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_engines
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, vkoul@kernel.org
Cc: nikhil.rao@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
 <20250215054431.55747-3-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250215054431.55747-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6d1a1e-92bb-4c45-4638-08dd505a38dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWFZR1gxcG5NTDFVVEs0T3FkZmVSbTRTUyt6QTVackJYRWNYSzRmVlZSODBt?=
 =?utf-8?B?NzJRUk9XUXZVck0vbElUYUM0WURqamJZeW5HVnJYYm93c3Azdk90WUtRK1pI?=
 =?utf-8?B?eVFOVEVCaGRwQ2JxNlFTYjVERlkwYzRIZTRzN1VMTENibDZ0WEx2ZVpibVkv?=
 =?utf-8?B?REtZaXdYQVRRSnpmWjRady9UVUxCQUlKdStZUXpNMXNNSnF1aFljVm1KdmhK?=
 =?utf-8?B?cnNiYTFiK1VGbWlmOU05Z2RETHUyejhPN0MxQ3hKaXlnVnpGcnF1OGFhVlRx?=
 =?utf-8?B?QTBuZDhnM01WaVRBUWtJQkoySWgycGVYV0lNUFJqRlIzUVR3akoyQnBZc3Vm?=
 =?utf-8?B?cjk1V1JOMXlMNjZWYjkrcnl5RzlLZXlWSTh1dDdhQmh5SUZaNFY3YWYxR2dC?=
 =?utf-8?B?RXdjZXA4RVlqemtYd3laY1dFWTUwWjBVUEhVdDNtdlQvYndqaDVMVTQ4WmNr?=
 =?utf-8?B?Q203RHFHTkZPczU3R1lWL0NjdUR6OTJiL3VmL1MxVncwUkRQOWxEeWFDekFY?=
 =?utf-8?B?cXhOd1VtT2l6VkVPQUgzN3pBSjJVYmRCSENkQTdaMEVXWEZSY0EwTWw5SnFU?=
 =?utf-8?B?ZWplMXBtQ0hyZnVDQkh2czNScE5rMkU2N2VRVzkzM1l0NVFMYnVxaHdCN1Jn?=
 =?utf-8?B?Y1p4ZjJ4NFcwam02N0cxTVd6RXpnekFOaUFnRWxVUEpwTnJvZmQvNzQ4K0Z4?=
 =?utf-8?B?dENtNlVTeTg0MlFMRDI3MXRJbXFNLzdFU1JBYW01VFVCdmRNTXNpL0FrT2pE?=
 =?utf-8?B?VmE0SFdBdGk4aFRCM3Z3SFUzRzhBSmZXT2gxaVU0b0JiRmZDZHRVcmxlNi9x?=
 =?utf-8?B?ekEzbWplVWNwaGRKMExoZnZDd0pCdjgyTEVVUGJnWkxFYXc5aGFpL3B0dERv?=
 =?utf-8?B?SVVUMjFNeTQ2dHRVbjhtcFNUUTdDaEdXU1p2cXErejhsQUJTYjlFOXZIT3BT?=
 =?utf-8?B?akhSZCtqNitDSTljbHluTi9nUjhTRDQ0U203RU5oNEQ1ZytXSkJhMFZ6R2pE?=
 =?utf-8?B?TUJxbmoyWlozazU3d2NiVGkzbkF1WmpJbzBLcVVTNGdUZHljNEhKdWRTL2Js?=
 =?utf-8?B?bDRvWjkyTXB6Wm10Ylk1M2kzRXVtc012QmNUck9iZXFrbnpKQzE3REdDcVNY?=
 =?utf-8?B?L2sxR3dFVGJaclJvNXZmMlhYS2NVeitiZm44R282VmltcTRMQ2ludUVMVnhh?=
 =?utf-8?B?aVk4UUZwa0xsVlpaN29hSzk4ZlRWV1MweTVZLzdlbEhNMERXdk14MXQyR2c0?=
 =?utf-8?B?dGc1aHB2SVZ5UGd2WmZuNzFDYUJlV295alA0VEZHcGtPSWE2eG9EZXFBTFYv?=
 =?utf-8?B?Kzh5Z3VZYldHOXJ3U3l0VXM1R25PQU9hc1lTZGtnN0VJU1pmMWphdThJWGpo?=
 =?utf-8?B?NlRvSHdpQVJ6RWVpaUd0OTZsVkgvaDFOcGlNU0Q5ZGh0eUpJc2JVdVZ5a3ZW?=
 =?utf-8?B?ajg4T2lkRXBQcDBhQVU3K0VNMkVDQjV5cWtJOG9PeWhrSWhmZWNicktrVUln?=
 =?utf-8?B?a2hYcG1uSjJEWlgrbTlQQU40MnlXMURpZnVIVDhRd3NGRjJZZlFWNng4b2lV?=
 =?utf-8?B?bXdab3NhK29hQVdoS1VmYlFsSkh6VkVseVg3RmVCeUZPaXYyekFjUFRTNnZ4?=
 =?utf-8?B?RXNiN0craUVUQjJzaU9RcEVMaGFGTlNra3N4M2JIdWxjM1Jua1I1WXBWMzJh?=
 =?utf-8?B?N2Q3N3ZYRWFReGxhaG9hNGViTnczTXhHS3ppSldIR1RIeklML2QwZ3ZIZnFM?=
 =?utf-8?B?VkhuUHlIem9pd1RrVWlDeDNmdjdnVVUxTERaZE9OSXpFT3JGMVVxc093OWg1?=
 =?utf-8?B?N2hkUGtsTFlsY3pqbnRlV1JVR2o5M0VGNWZhMHluZE05UmNaS1M2bTlxS25O?=
 =?utf-8?Q?HnsAdH1Nl8Soc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXNQUGM1WjdYeGNnWUZmblc3MGhHbWMrNk9mZ1dWb3BseVc5Vi9JUnZTeVVK?=
 =?utf-8?B?cjZITGtKZk1EZ055OXZTWFcxVTI4VDFaTlRCK1FLYUZFU0pyeERtYlZSRVJF?=
 =?utf-8?B?cFZCeS9vVWpHOXhIbHltQkxJZ2JYcUlVK1R6c3Z3N05pZXQ4eVlkeGdVbXpO?=
 =?utf-8?B?eGc5dFpGV3pZWEgvWi9xZnh5ZnRVeTQvajJMQkRRS0JKdXZvZUJ4WGlvRTVK?=
 =?utf-8?B?YUdWY2ZmSUJEck5OUWtxa3BWWE5JSHVrVWVraHRQTUFHOU5tV042NmUzRFk2?=
 =?utf-8?B?TVpPcDhVeUNjTzBOZG5PTG5BTjdRS0RxMXFseHlMM0lGKzJaZEF3bExNU0li?=
 =?utf-8?B?UzlneTNzMnhXZzVFWWxjUVk5bzYrbnlRMk1yRlZXMDBJbWRDMVlXT3JQR3pX?=
 =?utf-8?B?NGVnSk16dlM0azlTREZOQ1N2eVltajdBV0NZVmtSbmNkbWZjRUpaeFU5UXZZ?=
 =?utf-8?B?dURvZ2NBNzNYcDFXQmRTaGNmaXFXZTJYM2JhKzBCMUVrdUJNNHVldGJBdHdR?=
 =?utf-8?B?OFNadFBEYTRPS1RZWWVMdndFb0IxbkJ2bVdMb05BNy91TFpoS1dzNkdzYi80?=
 =?utf-8?B?WGV5bGtpRkpZaThRTFRJakdRdFQ2TDJ1WFNtQ05WbEZ6Nk4reGg5UmZsZ0kw?=
 =?utf-8?B?R0ZySjBuMStYVVFsWDNjVk5qZ2t0cFV0ZE5JM3JYdWxhV0RGajFYaVhsaXRi?=
 =?utf-8?B?a3dUWXlyWE5UVEtNcGtvMmR6cnUzSWZXUi96L1JLenZ0VEpYblY3Zm5wTnQy?=
 =?utf-8?B?VGEyY0J4bTAxU2xMWFJBZkFjamVicllSMHNwOFkxbFlmeUttY3Z4elNEZUdy?=
 =?utf-8?B?bE03dnF5amlQaFZrcWhJVzJEeHUxWkwxMUNGQ1JlN1o1ZzJYbDVZWmFEZEhY?=
 =?utf-8?B?eEZxdmlhU1VmZW51YzlkL2o4cTdTVDkyZXBxN2VCY0hTUDA2UWIxRW4rNnp4?=
 =?utf-8?B?QWNnZkZGSkdlWDhSOEwrR2ZSSTJnek1ScERQTWFqOHJPV2F3c1JRRS8wNXBT?=
 =?utf-8?B?VTVuVTBQMXF3dDU3Q0hKTVZ5MGFTSkFOY0F3U1RCdHRuU3VJUTZ1bEdVaFFG?=
 =?utf-8?B?T3BLbSsyNzcrTHFmaEJ6Nk1wNm9xbkx2NVFtTWRxWnV3ZEVlWTR0dTRaZTI1?=
 =?utf-8?B?Rmt4aDhVZW42clpTWEZDcWZjYW1WYkNhVFYxMU00bVYrU2ZVRG5wNEM3M2F6?=
 =?utf-8?B?aVloN2luc0h6TDFMb3U3YzJFMHF1T3lXREFuSVlxelY4RnNwVnBVVEdZTlBr?=
 =?utf-8?B?L1o0RTJzeHk2SjhBN3BQZXR6eWx1bTNlWlhHK0p3VEUvbGM0V1FBL0YyaWpD?=
 =?utf-8?B?d0VBUjlta1dLVGFRWkVZUWxhVmFDYno0RU04OXdUWStzK2FrZmFsa01KT0Zm?=
 =?utf-8?B?U3NvbDYvbVRGK0JaZ0cwYWVnVkE4WWVYQ1hVY1ZKbzQ4V1BJREc3UDJ6OSsy?=
 =?utf-8?B?OVFBam0wMzRjMzc0UmRnV1RQYXl6WllZa0xFREMxdnlRNTZSTUwvUXpsWkhN?=
 =?utf-8?B?d2ZLUy9WTnFlMVJmeHJmMWV1NlB5RERJSFltbC94dGVNWTh2K0MwcUhxb0xy?=
 =?utf-8?B?Yi84dWFxVys2VVpBWWhIZ0ZuV3ZtSXliUGpLcWdLRmpEb2dtelFSbS9IaVpt?=
 =?utf-8?B?TmxDZi9CT2twOUhzUUNMeG1JQjZibjZ6cVZwc0tjU2dqN01VVzVQSThmK3Zv?=
 =?utf-8?B?TitVY2VwNllScW1mY2JqSkpDdHYwK2RBNThMa0NadzNWbzlCRDhjL3JkTGR4?=
 =?utf-8?B?SWFGaEdoY1Y2OElBSUk1bDY2dkdGUWJOVXJKY3Z2aVMzazRPaDlTUTQ1cE9r?=
 =?utf-8?B?YnIwS25FWGM1VFM1Y090TWFnVU9vVUI0NWNqczhjWkZSZWY3MkllM0lnNGxh?=
 =?utf-8?B?NUlHcDFvcWljZFhWQ0ZKMC9KWkxKZHFKU2NKT2hzY2ZYTm9tRE4vSTZTaWlU?=
 =?utf-8?B?V1JWTjZYSVN5d2w2M3hTOXVhdytBRWFjNFZBeHJpWTluZVhWcGhwaFFIZGZS?=
 =?utf-8?B?cGR2Y0dJS0FjY2k3ck15RHI1bW1Fa3FrMytITHhsUjErZXRSSEN4SFV1eDlL?=
 =?utf-8?B?WStyOWVqa1EzanFNOVVaRncyVG5FMGl0bTRoVDhmL2piejU5aXV2N09DRlRX?=
 =?utf-8?Q?hytaUQQcAevMhQxtgK0pgEZmh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6d1a1e-92bb-4c45-4638-08dd505a38dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 20:24:18.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQ9UU2xHdLHiGDNQh7xFlNWlrG/4xH4nG7xDQeHl6iwYRI9vp4LNRwYGlwO2eKvxvBw8v/06mSuTZ8eIQmijMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275


On 2/14/25 21:44, Shuai Xue wrote:
> Memory allocated for engines is not freed if an error occurs during
> idxd_setup_engines(). To fix it, free the allocated memory in the
> reverse order of allocation before exiting the function in case of an
> error.
>
> Fixes: 75b911309060 ("dmaengine: idxd: fix engine conf_dev lifetime")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

> ---
>   drivers/dma/idxd/init.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index b85736fd25bd..4e47075c5bef 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -277,6 +277,7 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>   		rc = dev_set_name(conf_dev, "engine%d.%d", idxd->id, engine->id);
>   		if (rc < 0) {
>   			put_device(conf_dev);
> +			kfree(engine);
>   			goto err;
>   		}
>   
> @@ -290,7 +291,10 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>   		engine = idxd->engines[i];
>   		conf_dev = engine_confdev(engine);
>   		put_device(conf_dev);
> +		kfree(engine);
>   	}
> +	kfree(idxd->engines);
> +
>   	return rc;
>   }
>   


Thanks.


-Fenghua


