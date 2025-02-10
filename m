Return-Path: <dmaengine+bounces-4391-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE66FA2EF87
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1D01653FB
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68F4236A9A;
	Mon, 10 Feb 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KYFZ+4f4"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71066236A93
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197130; cv=fail; b=YBvsTxvVXCHQvYMX01WPhlPhHEmtRKPjZXrQmUrQQmyao8H8v+oqiBcMOXzIahvuBNFGJ8HLd+7dQ7i19vwnqZVkHVNw3WkNr3df5iiGT0WnClW6yGujdRGZt8xpUzeOtQbLaS2Ve6SfWxjtb9QkkV8Hr0HNoyzvX65ku02LzpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197130; c=relaxed/simple;
	bh=L4xev4jOKq7fOxIaHAAWTGx7PvvaIiVNQrE+YJS9t98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=toV7ZWtjH1ioPZVmBuRj7EzrpPS1TGTSwyTRZSK0GKHMMqZDOWSLZC+i3V2Mn0+KUlrl6nd7Lqc09i3rmgi0K1QWNrmabTyAPsoAktg3dM6pN0PRZ3x+rNcDo2JoMIhWzABYxYfSDnIEd6MBw+d7VBEf+ssJaXiDfgS+a+F5jMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KYFZ+4f4; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpgGyfgcz0rcRgkLGqikbGRNbijuwwdXdl3xtwpSPfHj5m03xSk6PAqD6PpG61bS5cl8+PTAB1CPKnnYUi+xPTP2GT9n3OS1yAyPjMpXeClYVS8FfeuyYN9Ou8CC1dip3+djOZYO5kNPivyG/pGYorGDcqdfk3FUAwGsBLt2lMFEDEseMS1LcvRPNnyE8KhazHZw/MAHXsM5KFU/xlt4mS2mFZ/ilf5GSU9hcKEIP2Vbtafkqm6m7J86LuGeELjOna4PuNm8YmM2YP3VD1/AoTYzLKqwKltqBsgtBpMpjKvUQJep9cVkuR5yCfZ6xvIDlz0rS3FFdhtv5pyQpOPxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtNNxfQBIw+EWDZg+lgDGLObna2D2ZTgyrAkuwOLO3A=;
 b=diEmXDsrye1ZHlle/mV7VBSTvWhOj8lEoN6Snib429cBXmHg5VsAsOhoDzjfQatfP1rsu9WmQ++wAx2RMCBEgm6EtUyCDP/QAgYcfBx3e2+PUgqCqcbAfR7WjSZb59cU0d1/aqWmqgRq0Xc97eJX4k+b48P57qoUPSom9p6ZrqUMU8yi4rxen3RCb9p0xsqBj/bvn9isC8HiWHyQrO3dc8z67kzNxNjczUEGS5bmAFKsdvv/hydcDAq4ksn4AVNJyH18Sj4VuwGz1vm/eU5QVg4GyXhgaEVshEm61hVaLmGF0IdSrivYGayK0s4PMaVOBoCVPaPfqeBdSRNvzcEtgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtNNxfQBIw+EWDZg+lgDGLObna2D2ZTgyrAkuwOLO3A=;
 b=KYFZ+4f4MVN1lYHbPxTnZvyA0qlLiCi8DE5UiLu7d6yZwGC7dGLybNFHySlr7/9WlzgYvyY0hUKkZ4GO9hCJC59mr4jlY0n1A+cxMWj1h0C9yCs+TW/l1ioroIGVJgzZu7euu9mMbYJEm8p/jUNlKXD8SozzhddP2zVU5vabzkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 14:18:46 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:18:46 +0000
Message-ID: <012b9838-c648-4b28-8a7b-469417472682@amd.com>
Date: Mon, 10 Feb 2025 19:48:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dmaengine: ae4dma: Remove deprecated PCI IDs
To: Vinod Koul <vkoul@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org
References: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
 <20250203162511.911946-2-Basavaraj.Natikar@amd.com> <Z6oGUao+26rThmub@vaman>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <Z6oGUao+26rThmub@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b5c57a-9f2f-487a-85ae-08dd49ddd3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzBEN2RvWVprZ24yYlArWWxkanJKOFF1aTJER3d2eStEV0xoQmR2aklRNFlM?=
 =?utf-8?B?UzNlYlN2cERDTkxOVVo2NEVSK0VjQkYyNmZlSkF0S29BYnY1bHNZOWtCcmN1?=
 =?utf-8?B?RWFuUmlPWlJ5NzZyRTlvRnNXTDRvem5hcG1SQXVWekplVkxrQ1R2dzMxMW82?=
 =?utf-8?B?azlWdEtyUnVjN3dublJIcEkzcTBKaVp1cFZ2ZkoyWGdTcEhRV0dpdGdvQVQ0?=
 =?utf-8?B?RXJxM1NQdjAzOGxvOWNmcjBVRkErZkVISUZQRUowRUZPMWdEMDA2bHZvOE1L?=
 =?utf-8?B?WWpwMFp3ckRKK1hHN3FncjF1WjZRY0FqNGpoYXBWam9EelFCMFdnQkd2Y0pS?=
 =?utf-8?B?UjBTZVdjTE9admJ5Z1V0LzdXSnJiQTIxMmQvOWlINkg1anBDMHhRZnl5Mmto?=
 =?utf-8?B?N3o3TmIzOUh2WXM2ZmRhRnNkRVJSWEV2dnpxdGZ6M2FnakhJamlueE9SdXZO?=
 =?utf-8?B?VVRqSHBFeFdEU1pITkRwNnJlTWR2YjFpSHNUTTV2OU9obmdYMXhTOEhFMmNC?=
 =?utf-8?B?RjdiQ1pSV0xiRGdWUTk4QkJZeUhwNlB2UEM4SUtmRnNqRGRCeGIxSkVtVlRZ?=
 =?utf-8?B?OGl2VkNkSVFQL3UwL1ZodnJqc1pacHVScWpac0pYNEYzeWpyRGhERllwUUlZ?=
 =?utf-8?B?YkFvWUtzZUtsOHR2MWoyWXdFTzE4anpLWUprNEJsUlhFVDFJdndXNmJjZlNG?=
 =?utf-8?B?R0J2YVhLbUFrQUZjQWI1L3pFT0xtKzlOTStZRXd5TWc1a09kZ0U4QmJJQzFh?=
 =?utf-8?B?QW1RYlVESlkzTnJXcXdaTDJKblZJNE1IU1ZFN1NreEtkdDBFSHJRWlVlWU9T?=
 =?utf-8?B?TzE2ZEI2aVh1S2NIMEZXVzFLeWNqRU1xWHR6dURETHVIYVpYamR0WjRPeFd0?=
 =?utf-8?B?UE80K2d2aDV1cW1ZZzNYNlVpakVRZ0YveWpLOEczOVVoTnpCbTNhS0lxS2xU?=
 =?utf-8?B?Yzc0L0RLVnZTWko3RGxPVjlmblRpQzl5eXBVMXc0cWcxdlhyS1dzNnRYd25p?=
 =?utf-8?B?QmxhOEdhY0lJS0lYQ0QvdnM2bjg2d1puVnlDU0RNakFEcjVYYUk0R2YwZGFv?=
 =?utf-8?B?TGJUYXovUFpLS1hhU1dCUURxUVNneDBlU1pYMjB3dzhGOVAwaXdPSytXRTZs?=
 =?utf-8?B?TjB2WlpjYmJVMlV5WHJ4bzBSSDVqY2RrQmNVQmFYYTlSLytTbmpTQjcxZTlS?=
 =?utf-8?B?RTVPR2FnMUtnV1ZUbU10NGxvNEtkVDQrOW1pK1JkM1BmMmc5djhTMzhxMlBH?=
 =?utf-8?B?UjJWYUp6QTArYk0xZzV0NTJrZ2VLNmV6cFMxRGloK0RFcTJ4UEYxdXFQWFdU?=
 =?utf-8?B?ZjhpVW1qbmRqOEZwRk05eEV1ZjJhbkF3RVJpcCtQY0o0VW8xMjROcFA0MDF6?=
 =?utf-8?B?a2lkN1VOdm5DL01sbGdnNlVjQmJIL2JYcTd0eE9OUUt2dHEwR1pNUGE3djdP?=
 =?utf-8?B?bU1RditHR0FTbEpBNGl1ckZTbVd6cnNnZkR5d2NoSERiaEV0bVNFMFN2aW83?=
 =?utf-8?B?aGswYUZ1MDkvVDRLM0VXQUVGOURwbTd2U1RWdGxodTJhUTVtRUwzUU03UjhW?=
 =?utf-8?B?RWhMeVN4WlZwZU1HZ3dheHJqaDRSUzZqVncwRkNzVXB4ODRWekJYbDlZSmxn?=
 =?utf-8?B?ejBkbjRkUXFiaGNac01IRUJheGhaT2xrYXJ2c3FLRmRZaDVBdUViL0Y5RlIw?=
 =?utf-8?B?NGJXTHJhZ0dhYTlwYUJPSmRiQmxlSFZiK0pvZEtXa3hvdC9Ndk1GU0o3K2Nx?=
 =?utf-8?B?N1Q0bTdHV0NWWVo1bDVscWplL2hSbzUwaVo2KzNTdXFzYnhqZXltdUU1UXlE?=
 =?utf-8?B?OGNCekhJWEVaeVpFT2dGMXkzL2ltZklKcUxtcGlLd1lLbnhPdVZrQkZQaTM4?=
 =?utf-8?Q?cc15+CQ67mx9q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXVlaGREMG43dUplNzUxL3Y2WXhqUGVCSjVjZHNJSHJ6d1dQM21MdVVheHdU?=
 =?utf-8?B?ZnU4YWxxVC8yT2hrbHFDdE85aUFDa0xJZitveFNCZ3BwcmtwaHA3TS8yVHg2?=
 =?utf-8?B?bm8yaDlYRHQxVytvb3YyVzNBdVZvYVMvaGs5Y1ZFUllGcUUvZkYvNHFsSVZZ?=
 =?utf-8?B?dzlSeDNkTkRzNzVIQUNUNUFYMGdRWVNhUkJ5VDNyR1FWckFhY2ZMaG5PaFRJ?=
 =?utf-8?B?UGVNQ2ZrUU02aFlCQnRGQUNBMVRIemgzRjRkUXBoVnM1TWk1bHY5cWhVUith?=
 =?utf-8?B?SmdRTXZUNmN0MzNpRFJLRVBCQ2tzZmNhZ1dOSzJPQ0ZyZ1M1Qnhic1dQcVdo?=
 =?utf-8?B?dzlBd3RBeVkyTWl4SFdiR1I0TlhXZjh4MlRjeHgrdHBYT2NLWmFBazNUQ21w?=
 =?utf-8?B?QVZyWDArVUZOV1QrSVNuR1pVNG9tYjVMOEVIRzczOHllZkNEbnJqM3p2VFNy?=
 =?utf-8?B?aUhCQUFVRk4yaDdLN3pEVDFKRGxkNWlLdUxlMDM1K2UyNnVOdFVpYVcxT2Jq?=
 =?utf-8?B?UTNNYjA4MmVFM2VNRkRsUFZuZU1kU2dYWDV6emFFMFY3SGp3U1ExRnRBUnNz?=
 =?utf-8?B?Qy9SeFppOU53NDJUd2k0NThFejE4VndyTkRTSEJIck1BRG9wTVZxTEJvTGNo?=
 =?utf-8?B?cVNmcG5RMXd3Q2wvaW1Xc255NWFqTStVUkRudHZZZzk2YXZxeDBoNGVtNmEr?=
 =?utf-8?B?aVYvS295d0UwZDVpOUZxYy9PZEl4MWFUbFZvR1RVTTdOdkpBN2gxQmhBMGtX?=
 =?utf-8?B?M3E3VENkc0syMEp3QThMbE43eWs5WWxnelFPTWZ5QS9SWU5zTURaV2pMOTl6?=
 =?utf-8?B?dlVucXVEMC9iUU1ObkdZRllJWFZQUWZCTE9SdXNJTTFmQ2RiTGZXMVEzS09M?=
 =?utf-8?B?Zng0bm1velBjY2NQekFJTjF5Y1QvT0k5ZWhWV29udGFVNmR3aFM0Rll6MFE2?=
 =?utf-8?B?WEU3cjY3U2o4RXpEUHpFemRNbGd3ZG1TbmE4WmJqdGp1TlpPRzVCQ3JCbTls?=
 =?utf-8?B?aHp3SHpZQnd0blF0cFNUTitYc0UxdUVzUkJBWkF0c1UvdnRsOGRYbzZhVnE0?=
 =?utf-8?B?SVAvTGw3eDM2MFJ3N1h3ZVhneGo0Q084OGZRU25qSHRpcFdrMTZYUCs4Tk94?=
 =?utf-8?B?VXJTcTk0UHdDNFE3T1VSNDA3eWd4RTgvaWRIRDMwN3UzRzBVd1ZzK0U0WEQz?=
 =?utf-8?B?RWNVaUpJQlRVdTZIVjNPNENkMGZQOS9vaXU5NmR1c2VQMFhKb2JmMDlyT1ht?=
 =?utf-8?B?MDlYS1lSemFlWnFSUzNlMjJyMExYRHNxQWpud1l5aU1adFlIM3hMdnBPZHk3?=
 =?utf-8?B?ZWVFOVZoQll2S1NRQ3I1Y1dXU1ArMU81L0Jxb0pEMXhCb2VvR2t5SzRvYjJP?=
 =?utf-8?B?b0xoeFp2aWhpT2hCT2hSSkwvc09CbHNPU2dlOWtlZU9majRTVkt1ZTZVSytE?=
 =?utf-8?B?QlVUdStvTEpaeUFPcnpJYXZhbWNwSThRWGhmdlBHdDRIM2VONHJuTFVUbWUz?=
 =?utf-8?B?eXZrQ09ZdC9hOCt0bTkwQVJpRTdxKzlNS1V3cmlyR29YMkZBZStXc1Z6ZnpR?=
 =?utf-8?B?ckFlWW1WKzZmUGtiM1RBWDFzYlhwdy91RDByczVsU2xJcHJucnpYNlRoYzNh?=
 =?utf-8?B?NnNmZXM3VStjQTkzbkhvNjl5QzY5dTMyNUx2L3pZUFlmTUlkTUFYYWNqQjZ6?=
 =?utf-8?B?bUpHOEJxb29PZjVpd2xwNjhrUmZ2Tit0a2ZUQVlzMlVDZGNZV1VNQ2Irc2pt?=
 =?utf-8?B?aHpIQmNhODJJQmdCdzJJd3YyamhORHNTMXlrNU00Tno2U2JZQ2ZwemVrUTlI?=
 =?utf-8?B?b3hGWmlQNVVNOXBWWTZlekd6SDF5ZUdJYzIveGNvNmNEZU9Ic29iK2szTm5C?=
 =?utf-8?B?b1Y2T2d5RTE3aXYwcDRuYjF1bW1tRUJvQ3NjRUFYOWpXL0pkNVNpSXBkbXdT?=
 =?utf-8?B?dzFDVXhQTTlyVnJleFNIVENWeGZSZkw3OWdhREZHU3FBUnVUOEtYRTQyODcy?=
 =?utf-8?B?a3d4OHc0ZkVvZ3JNc2dSakFHbjBZYnk4eWxFcnMyYjN6ZldtZ0IrQTNSbExM?=
 =?utf-8?B?MDVqS2IrMkU4T2tiZ2M3YVpWaXJhdEpraFRVZERGdWlIUVBqQXV4VDRIcGg3?=
 =?utf-8?Q?H4UH36UVVlu4MhE8MGJy5ok3J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b5c57a-9f2f-487a-85ae-08dd49ddd3f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:18:45.2861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PH1qwToo5Wr0pFqjkzIJefsi5gi4jmFXbCkqZhsHA6199syhgXVnLyd7IQmMTm+mmsmnSnecH9sCoiLZDfTinA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909



On 2/10/2025 7:29 PM, Vinod Koul wrote:
> On 03-02-25, 21:55, Basavaraj Natikar wrote:
>> Two previously used PCI IDs are deprecated and should not be used for
>> AE4DMA. Hence, remove as they are unsupported for AE4DMA.
>>
>> Fixes: 90a30e268d9b ("dmaengine: ae4dma: Add AMD ae4dma controller driver")
> Why is this a fix?

Yes, as these changes are needed to work only on supported devices.
If it loads on those PCI IDs now, since they are unsupported,
the probe will fail.

Thanks,
--
Basavaraj

>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>   drivers/dma/amd/ae4dma/ae4dma-pci.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> index aad0dc4294a3..7f96843f5215 100644
>> --- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> @@ -137,8 +137,6 @@ static void ae4_pci_remove(struct pci_dev *pdev)
>>   }
>>   
>>   static const struct pci_device_id ae4_pci_table[] = {
>> -	{ PCI_VDEVICE(AMD, 0x14C8), },
>> -	{ PCI_VDEVICE(AMD, 0x14DC), },
>>   	{ PCI_VDEVICE(AMD, 0x149B), },
>>   	/* Last entry must be zero */
>>   	{ 0, }
>> -- 
>> 2.25.1


