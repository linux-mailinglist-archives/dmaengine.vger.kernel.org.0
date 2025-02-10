Return-Path: <dmaengine+bounces-4403-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E6A2F006
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E813A883C
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49F425291F;
	Mon, 10 Feb 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h5/JkED7"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29992528F6
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198282; cv=fail; b=DZ4SZMn+a23h5GsClDhKpZ7QUKZIUFKvk3r4gRzE9kEvxZbMwDEQFYHCv4a8ortNixzrSxNHrftUf0wkODeGNpKjuxxRqU2Xg7R07wDOzLv4PU6jJwgWCpeUOH5yJ7ZGkSxSDkZVsBdN+5N1fbp2JqAv4avXxrX0ymyYjmWffUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198282; c=relaxed/simple;
	bh=GFvE8DyN9E/MFMAs4jrMWiZMC5ynxYIMm/mS73iGT3g=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ehc1AGYGgeyc7PJ5r/uvMlDUobxPAa2PpT9fkDVYgri0ELtGNgkkgnqbdAs1AXqL+00rBfxQ2FBwbxpV4WDwYv1hR9ZfbwOdVYyquwoyrkpt+96UZQjxD+T02Oy1YG/b4EEwkZPy9VpVqZhMj0Svw/xcWqif2WJYVcsaUI9bzDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h5/JkED7; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNl9j0dp8LPUMl9twE5rAZe8CgWBNST/5f9Z1kJiat7ZF69EGSgFcsfd+cLYbQzWoVxbiH85ZCECjNzkeV1RHWuCsHJjbJ/Irr66byjA3aX8T17kVIeaf4TNF49ljQrJSisq758QH1GnxJqC/hPKej9dUFYmgarDV8VXC5ckDrZclAm/sB1XQNKl8oEeRKJmyqxeGPJXuYaq4Sy1EvCBb/1dMdcNKy5uw9c5AnHy8Yrz5YRkouM5vapt63X8xlpuiTzaNA/XPmzDkg2/SSEZCvur1Ph8JtL5Xh/OrJ7zN6YaLJNLOCQ697n6MiQeP3/ODYf1x6rX8GUnHgrQxoM8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6aSWS1Y2mgzdkZb3aeRI7u5uLrsIDiUqBMz0nHjd5U=;
 b=HxhuPTkTBc+7DaEnForUq6rUFjg9zX2KtoJHIgBoUO2aALKASQ+lS5JuDWvb4ZkMLEjerNnU9qPAKrIKowrT/c2pZtDXsZYtZ1hkkSPAFwujeBp83yYAnAmXnzfl1a8ICKmUFsXAHn1zxCSMTBKO0h4U4oTOQB6JIjSASylGMk97qBK7yEj5PDI25k+djayP3bpExO5j8kh608LeMW6YVKgwrldU7EuBqhBIsuCitDPuI0AfE70zayK6OUnrxoNSRjQ5J1rJOeW4kNdEuySdF/j4bWDRLqeNR/sUDiBcQ6CmxXAQe6bEndNDxL8ETwOz1viXjU6VsRhRuCZoEIRn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6aSWS1Y2mgzdkZb3aeRI7u5uLrsIDiUqBMz0nHjd5U=;
 b=h5/JkED7jM3/uJljoNX0XOlI5P6Nm9PoTcfjguqMpwWOcGY6iUi5KP9BTU813D9Ma6KWA3wsJVkN4yljGK7BGC6IDtt7tHWs+DujNlQzquJFoHQyM82w5zkIbPzQsI72PaKa2m1nVoMuc7jRUj7zE/UzuVzEGhg5RNfo72UtHno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Mon, 10 Feb 2025 14:37:58 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:37:58 +0000
Message-ID: <e68380e3-4936-4982-b306-58c57bda9bb8@amd.com>
Date: Mon, 10 Feb 2025 20:07:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dmaengine: ptdma: Utilize the AE4DMA engine's
 multi-queue functionality
From: Basavaraj Natikar <bnatikar@amd.com>
To: Vinod Koul <vkoul@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org
References: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
 <20250203162511.911946-4-Basavaraj.Natikar@amd.com> <Z6oKqKncVc9AL2Tb@vaman>
 <c568caf4-c69c-4e41-a794-4756ca8fbd93@amd.com>
Content-Language: en-US
In-Reply-To: <c568caf4-c69c-4e41-a794-4756ca8fbd93@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0198.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e01033-ba19-4391-4248-08dd49e08313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVNPZlhRVEZwd3VHaE9lUmpqN05LaDZJMlpWNGZtV0xJRlZzMGdUVStFWi9v?=
 =?utf-8?B?MklnbGhIYUdiRUlnTUFoNHU2eTJoL3RaYTBza0hZOGtLREc3bGt2S0daUnJR?=
 =?utf-8?B?QzNFS2NHN1lTeTJkTFlmQi9KbFVGVmViejlEcDBVYWNabUtwQTVheWtJZ054?=
 =?utf-8?B?UU5iU3M5Z01TNVVmQ0VuZ1RZdlF4RzM4MW9lY1czTEEyeGxqdng2TW5oemdt?=
 =?utf-8?B?c2h4L24zRXIvQXVrcG9DWTZZUGZSaFIzSFNacXQvWVZ0cWwycVQ1ZUhTYVhX?=
 =?utf-8?B?aGVPY1BSNTFpMGF5M25zVlFOQmVMRXp1amRNKzh3WUdSV2tSbkZ1bjFUbWVM?=
 =?utf-8?B?ZnEvL0NqS1N4a2ZMcm81a0hCRkdGSCsvMm15elBFT0lMdGxDM2xsMEJ5YUV1?=
 =?utf-8?B?d0NtV2graGJuWWdLR3Naa2JHRWlSWmlRRmdMTmd1Y3FsWWN5MDlYWlFMMGlv?=
 =?utf-8?B?VW9xeHFpNU5zSkNkWXhlTXlodGl0bEVsS25pMC9RNTZuOGsvSmJJRkpYTG1X?=
 =?utf-8?B?dzdmOU91WGVldHo4bUp1WHR3YytaWno5TU5wWXMrQWEyYnlBMHlMWG1FNjZX?=
 =?utf-8?B?Z01qa2NDYXFmUVArUGMzcjFROFdLQ2RiUnJIek5JUEkxeCtJUkYrMDFIb2ls?=
 =?utf-8?B?aUNJdE55SGtFQnlEa01tQkRSaDhlSXdoRDZidWc5anloWHRPQjJsYy8yWjYy?=
 =?utf-8?B?T1VFUlR1M09hT3pQejNEWkRHQUJCYmlYU2QrdGJwbmY0cFErWlZRTDl1d25v?=
 =?utf-8?B?TDRvVHpUVFNaWWdnQlh6em0vQTl4alBielRnRlVUS3B3YUJEdzA4bWhqeEpV?=
 =?utf-8?B?dzdPeDQ2VnNOOHZwTkFsMXRjREx2bTJyZEtYS2FseUY3VEpIY3ovZkVrMDA1?=
 =?utf-8?B?L3JjVGxvMXpDd3JNZGVPYUNOYmVKaVdKQXFrbFZBVjllTG5KdVArU1NTbUJW?=
 =?utf-8?B?K00rUHlkcEFySTg2TFgrby82NXp5Mk1lTklUS1A3N0p5d2M1U2kraHE4dWdY?=
 =?utf-8?B?ejgraXFxZXlCWmZnVHMyYXpjcWg5cXZqNnh5T1hQUWFSemxoZktaUEZJOUh4?=
 =?utf-8?B?Q1g2MWJXQ2tQUERWa0ZkR3hHS1FJRXdyaXJtT1R2Y1p4UWxUcmhqTHNzTG9E?=
 =?utf-8?B?bmVreTJITHJOWGNZdHUxOXVSRzBPNkYyMzdKcnpGNEZrOW1xNU9DWkJsWmxj?=
 =?utf-8?B?T1BLb1dta1NSNXEzMHZLSUhkWm1CM050ak04amY3SVkzd09JS2tJTVlmbEFp?=
 =?utf-8?B?RGN6bVAyY1Vqdkd0eEFXbkFNcUMrZzVndjdrb0diajMxYndkZDRES2wwVlFU?=
 =?utf-8?B?TkFGTXBveXlXMXBtSXcwakhFa3lzWUlnSHFNM1dEek9SaXE3VHVsZERqSnFW?=
 =?utf-8?B?TWpNMHkzOVJ5Y1NjSVRUNnpWc1FMR1N6b054QmdnR2ROVUZSNXFpd1dmdzcr?=
 =?utf-8?B?aW9kK3RFNlVXSXVNcHhNL3NhbFB3ZWpmdUFVemJmRWdRbUZwUWVTVUM3cTlJ?=
 =?utf-8?B?OE1yc3hlMmxKdjl0ZGwvL1JYaWt4VmtLL0Y4alR2UHJMVjl5aEgybUhBM2tl?=
 =?utf-8?B?NDdyOUdSTStmMXo2dE9EeDFINDdqbjMzbllHbGxCYlpDTExNRGozTnV3OFgv?=
 =?utf-8?B?Rm92KzBLTythejBtTlI1Qk1MeVNhY3FneTAwakVJTzQ1THFGN2Q3L09ILzQy?=
 =?utf-8?B?RkxOQWFxSDNOUXljMmR0T2I4dnQvdGlVSjFPdW0zYk5xQlZPUEhFeHlNVEFj?=
 =?utf-8?B?QW9GRkhCQkViVlZDT1hnYWZaZ0RHYnpLL3J6bHBPVytZaFEyaitnQysrMGI4?=
 =?utf-8?B?UXI5OE40R2pZRFVpcXQrR2xnZkpuMXlJbWxVYUxGM0NuWkVnWkNCem9Vejh0?=
 =?utf-8?Q?jCPc94uPvvj/M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnduQTF5V2N5U0prUUx4NlBrRXZzZTdpa3B4TFpvTG53ZUFFV1g2N29vNVow?=
 =?utf-8?B?MVEwNUViRzVzeUlaYlZ2M2JPSkVyZ3Q0dUJkKzZjbENadUVhVnhhU1hnRnFE?=
 =?utf-8?B?bzlZNXlHQ3VSK1dzajVkVFZXaW1zWU5LNWJJUCttZmI3VjN4SUp4WXllSEpW?=
 =?utf-8?B?ZmdLTys4b2RFSTBuWVRtbmF5TDdYeHRCRDM5MlpxYWUvYnZNMjNRcUVyRmpn?=
 =?utf-8?B?anZVT1l2ZzhJUHgvMHhvSk82TTA0ZUxTc1lHV1hlc3NJNW5QVmFUbTFYdTlK?=
 =?utf-8?B?bkVhemU5R3J3N05ReTJUQ2xETlNtRWlVekJVWGQvZ1E4Qy9lUkJNQXJHTWdr?=
 =?utf-8?B?a2Vyb01aeStMa1E0TzRjWUtDQnNvVGRpRDBvVVFZbkRGVlJPOWo1Mmt0ZTB0?=
 =?utf-8?B?UGhIKyt6ZFhLRnJmQ21vY0dDZXdXK1dkZkgrblhsNTZXb1JRdlk2bnY0clMv?=
 =?utf-8?B?T3l4ZHY0YXBkNi9FZSswdVRsbE5GL1k2WHphSDJxVXRaNDQ1Qkx5WUlvSkI2?=
 =?utf-8?B?RStmNmFKSWRycXhOSGJVdVp6cHJrNkQwSUVEVDcrNGZlcnhERDdmUnFHVUVF?=
 =?utf-8?B?S1J4MUZTRW5HWHBOYVJPN01RRExKNDQ1WkRiYUZuTzRzQ2tpazI2MERuRDRZ?=
 =?utf-8?B?VHZWUWR3Sm4vNTlPcDJQY3p6bWRzMEJiM3BwbVJFRUJVY2pZdFV3cU0yMEd3?=
 =?utf-8?B?WU1zakwwMTMzVlNZMmlwLzFQaEpjTEhPVGNKMmgvWTk3OWU2aG5VdUY3UkJH?=
 =?utf-8?B?ZEdGdDI4eHpqVC9uelR4NnRjZlc3dHAzajRlWUZ4dkh1WHd3VG8xZ2RHMFU0?=
 =?utf-8?B?Ri9qR3RZKytyNEdFOVlnM1p4U2JZOEtLZE1aRW1EcHExT3BMR1JQSmZHbmZv?=
 =?utf-8?B?N3lkdHhNbm01UmpZSVdqN3BWMjhGaTRpVGo1UFZGQlIxb3BhS096ZStxLzIv?=
 =?utf-8?B?TFNTanNTTGhlM0hxNFQ2bzVQMWN0Zy9kbENuVTZydk1Mbm9mSmdoMnpZVW9I?=
 =?utf-8?B?bW5nYlJUUnNBd3o2Rlh5dGVjRzQ5MUhTdGpnZEg1NFUxbnM1MTRMcnVHNFhQ?=
 =?utf-8?B?bExrNlZ0dldEblV3WDJ2emtFcjZsZDZPSVlJeWtVNEk4Z3JjZVdrMDVpRW1y?=
 =?utf-8?B?WlJ5Z3NtZGl6YUZMaEVDVHdwQXpacG52Uy9rN0VWMENoQ0c1RnVka0EwMnU1?=
 =?utf-8?B?QlAwVXQrOFZiVW5pdDZlZWhMQTNGRDFKZFpXVUduWEVSOE5hMy8za0EyVFBw?=
 =?utf-8?B?bFJ6NG1rbUpoTEFYVTJEVUMwQjkxMEJ4djJsTlRpY2dkL3ZML21kNHhibkJp?=
 =?utf-8?B?OHhSOUhqVTN6S1E4eGhVa0QwdUpQZGo4Z1ZDREpMYTNwbVc0bzJ1VEtja2N5?=
 =?utf-8?B?Tkl6OFhWWHVkNGVMc1ZUTC9nSk02WGFHQU5yd0dhQ0Y3M3FQSjJvbEJPWVY0?=
 =?utf-8?B?SWNJNnpxTlpaQW16QjRDMmpvWVo0Ry9MWmxqc1BIWktlQmZlWDZRSEhhSkdL?=
 =?utf-8?B?YWEvdHIzZUphR1JQbnZtTUJJeXlqZ0JTNzg0aFNQYnIzLytLTjdxbnltcTFN?=
 =?utf-8?B?eGFiU3dKY1Y3NEJmL2wySWpGd3FRbWtRa1l0R21Xa0wzdE9jRjRKclovQlI5?=
 =?utf-8?B?czl3eEpoRzdEU2ZPUmFWOEJQQ2ZEdmRLT29ickpTMndFRlVLZFJEMjJENWNY?=
 =?utf-8?B?WnYrUXo1K2tBZWtnT25jRFRiUyttTTV5aW4xcE81NTdhY1dFaHVCR1FxRnV4?=
 =?utf-8?B?NFo5Uis2YzE4aVhVbEN3bmtjK29jUk9IQ2NBRkt3bWxJRXB6UnQxSjVEdXMv?=
 =?utf-8?B?Sjh6Sm9GTHFmWmVkQnkvN3BxVTBCci94RjdOaGx0dEhzM0IrbkZUR096akN4?=
 =?utf-8?B?N3plS2RQaUpqbHJldE9XSHo4cituNWFkQ2U5Q1JjQXJnbHNXQkVaV1FqdEZG?=
 =?utf-8?B?T0dUUmw4WmZYTXpQZzZjb3BVR005a3JRaTM5OUptMFFocUxmY01kRWFSTEQx?=
 =?utf-8?B?SDlDTGQrRFJZNHBGVkwybmJDcjRkN1l0Zm9adWdQeHRabGJZRHBGblFvYkFq?=
 =?utf-8?B?VjcyUDJ3K256L25vNWZ1RTRCVU9XbnpSRm5iQWYyZlA1aTZ1RFFVWGVzaGVJ?=
 =?utf-8?Q?tFUhIaVj4ZNMC6nzyl02AHRLF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e01033-ba19-4391-4248-08dd49e08313
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:37:58.0445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcpTnzFo6JaDZBTZOrvkenldRbI2lto2LXf9/st5RHHJm9XdpYoZmsLYwfM1ghOHVIpZ1eG6LgA0FLPnbpkjBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485



On 2/10/2025 7:56 PM, Basavaraj Natikar wrote:
>
>
> On 2/10/2025 7:48 PM, Vinod Koul wrote:
>> On 03-02-25, 21:55, Basavaraj Natikar wrote:
>>> As AE4DMA offers multi-channel functionality compared to PTDMA’s single
>>> queue, utilize multi-queue, which supports higher speeds than PTDMA, to
>>> achieve higher performance using the AE4DMA workqueue based mechanism.
>>>
>>> Fixes: 69a47b16a51b ("dmaengine: ptdma: Extend ptdma to support 
>>> multi-channel and version")
>> Why is this a fix, again!
>
> Yes, as AE4DMA is much faster with multi-queue. However, sometimes due 
> to multi-queue
> processing, it takes longer and introduces a timeout for the 
> synchronization of
> consumers and producers, which helps avoid long waits that could 
> eventually cause a hang.
>
> Thanks,
> -- 
> Basavaraj
>
>>
>>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>> ---
>>>   drivers/dma/amd/ae4dma/ae4dma.h         |  2 +
>>>   drivers/dma/amd/ptdma/ptdma-dmaengine.c | 90 
>>> ++++++++++++++++++++++++-
>>>   2 files changed, 89 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h 
>>> b/drivers/dma/amd/ae4dma/ae4dma.h
>>> index 265c5d436008..57f6048726bb 100644
>>> --- a/drivers/dma/amd/ae4dma/ae4dma.h
>>> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
>>> @@ -37,6 +37,8 @@
>>>   #define AE4_DMA_VERSION            4
>>>   #define CMD_AE4_DESC_DW0_VAL        2
>>>   +#define AE4_TIME_OUT            5000
>>> +
>>>   struct ae4_msix {
>>>       int msix_count;
>>>       struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
>>> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c 
>>> b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>>> index 35c84ec9608b..715ac3ae067b 100644
>>> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>>> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>>> @@ -198,8 +198,10 @@ static struct pt_dma_desc 
>>> *pt_handle_active_desc(struct pt_dma_chan *chan,
>>>   {
>>>       struct dma_async_tx_descriptor *tx_desc;
>>>       struct virt_dma_desc *vd;
>>> +    struct pt_device *pt;
>>>       unsigned long flags;
>>>   +    pt = chan->pt;
>>>       /* Loop over descriptors until one is found with commands */
>>>       do {
>>>           if (desc) {
>>> @@ -217,7 +219,7 @@ static struct pt_dma_desc 
>>> *pt_handle_active_desc(struct pt_dma_chan *chan,
>>>             spin_lock_irqsave(&chan->vc.lock, flags);
>>>   -        if (desc) {
>>> +        if (pt->ver != AE4_DMA_VERSION && desc) {
>>>               if (desc->status != DMA_COMPLETE) {
>>>                   if (desc->status != DMA_ERROR)
>>>                       desc->status = DMA_COMPLETE;
>>> @@ -235,7 +237,7 @@ static struct pt_dma_desc 
>>> *pt_handle_active_desc(struct pt_dma_chan *chan,
>>>             spin_unlock_irqrestore(&chan->vc.lock, flags);
>>>   -        if (tx_desc) {
>>> +        if (pt->ver != AE4_DMA_VERSION && tx_desc) {
>> Why should this handling be different for DMA_VERSION?

PTDMA always handles per command based interrupt and it is single queue while
AE4DMA we can submit multiple command each time with multiple as AE4DMA is
much faster with multi-queue.
However, sometimes due to multi-queue processing, it takes longer and introduces a
timeout for the synchronization of consumers and producers,
which helps avoid long waits that could eventually cause a hang.

>>
>>> dmaengine_desc_get_callback_invoke(tx_desc, NULL);
>>>               dma_run_dependencies(tx_desc);
>>>               vchan_vdesc_fini(vd);
>>> @@ -245,11 +247,25 @@ static struct pt_dma_desc 
>>> *pt_handle_active_desc(struct pt_dma_chan *chan,
>>>       return NULL;
>>>   }
>>>   +static inline bool ae4_core_queue_full(struct pt_cmd_queue *cmd_q)
>>> +{
>>> +    u32 front_wi = readl(cmd_q->reg_control + AE4_WR_IDX_OFF);
>>> +    u32 rear_ri = readl(cmd_q->reg_control + AE4_RD_IDX_OFF);
>>> +
>>> +    if (((MAX_CMD_QLEN + front_wi - rear_ri) % MAX_CMD_QLEN) >= 
>>> (MAX_CMD_QLEN - 1))
>>> +        return true;
>>> +
>>> +    return false;
>>> +}
>>> +
>>>   static void pt_cmd_callback(void *data, int err)
>>>   {
>>>       struct pt_dma_desc *desc = data;
>>> +    struct ae4_cmd_queue *ae4cmd_q;
>>>       struct dma_chan *dma_chan;
>>>       struct pt_dma_chan *chan;
>>> +    struct ae4_device *ae4;
>>> +    struct pt_device *pt;
>>>       int ret;
>>>         if (err == -EINPROGRESS)
>>> @@ -257,11 +273,32 @@ static void pt_cmd_callback(void *data, int err)
>>>         dma_chan = desc->vd.tx.chan;
>>>       chan = to_pt_chan(dma_chan);
>>> +    pt = chan->pt;
>>>         if (err)
>>>           desc->status = DMA_ERROR;
>>>         while (true) {
>>> +        if (pt->ver == AE4_DMA_VERSION) {
>>> +            ae4 = container_of(pt, struct ae4_device, pt);
>>> +            ae4cmd_q = &ae4->ae4cmd_q[chan->id];
>>> +
>>> +            if (ae4cmd_q->q_cmd_count >= (CMD_Q_LEN - 1) ||
>>> +                ae4_core_queue_full(&ae4cmd_q->cmd_q)) {
>>> +                wake_up(&ae4cmd_q->q_w);
>>> +
>>> +                if (wait_for_completion_timeout(&ae4cmd_q->cmp,
>>> + msecs_to_jiffies(AE4_TIME_OUT))
>>> +                                == 0) {
>>> +                    dev_err(pt->dev, "TIMEOUT %d:\n", ae4cmd_q->id);
>>> +                    break;
>>> +                }
>>> +
>>> +                reinit_completion(&ae4cmd_q->cmp);
>>> +                continue;
>>> +            }
>>> +        }
>>> +
>>>           /* Check for DMA descriptor completion */
>>>           desc = pt_handle_active_desc(chan, desc);
>>>   @@ -296,6 +333,49 @@ static struct pt_dma_desc 
>>> *pt_alloc_dma_desc(struct pt_dma_chan *chan,
>>>       return desc;
>>>   }
>>>   +static void pt_cmd_callback_work(void *data, int err)
>>> +{
>>> +    struct dma_async_tx_descriptor *tx_desc;
>>> +    struct pt_dma_desc *desc = data;
>>> +    struct dma_chan *dma_chan;
>>> +    struct virt_dma_desc *vd;
>>> +    struct pt_dma_chan *chan;
>>> +    unsigned long flags;
>>> +
>>> +    dma_chan = desc->vd.tx.chan;
>>> +    chan = to_pt_chan(dma_chan);
>>> +
>>> +    if (err == -EINPROGRESS)
>>> +        return;
>>> +
>>> +    tx_desc = &desc->vd.tx;
>>> +    vd = &desc->vd;
>>> +
>>> +    if (err)
>>> +        desc->status = DMA_ERROR;
>>> +
>>> +    spin_lock_irqsave(&chan->vc.lock, flags);
>>> +    if (desc) {
>>> +        if (desc->status != DMA_COMPLETE) {
>>> +            if (desc->status != DMA_ERROR)
>>> +                desc->status = DMA_COMPLETE;
>>> +
>>> +            dma_cookie_complete(tx_desc);
>>> +            dma_descriptor_unmap(tx_desc);
>>> +        } else {
>>> +            tx_desc = NULL;
>>> +        }
>>> +    }
>>> +    spin_unlock_irqrestore(&chan->vc.lock, flags);
>>> +
>>> +    if (tx_desc) {
>>> +        dmaengine_desc_get_callback_invoke(tx_desc, NULL);
>>> +        dma_run_dependencies(tx_desc);
>>> +        list_del(&desc->vd.node);
>>> +        vchan_vdesc_fini(vd);
>>> +    }
>>> +}
>> Why do we have callback in driver...?

PTDMA also has similar callback pt_cmd_callback
hence AE4DMA also has callback for the multi-queue command ,
once command is processed to signal upper layer that processing
done for that queue.Thanks,
--
Basavaraj

>>
>>> +
>>>   static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
>>>                         dma_addr_t dst,
>>>                         dma_addr_t src,
>>> @@ -327,6 +407,7 @@ static struct pt_dma_desc *pt_create_desc(struct 
>>> dma_chan *dma_chan,
>>>       desc->len = len;
>>>         if (pt->ver == AE4_DMA_VERSION) {
>>> +        pt_cmd->pt_cmd_callback = pt_cmd_callback_work;
>>>           ae4 = container_of(pt, struct ae4_device, pt);
>>>           ae4cmd_q = &ae4->ae4cmd_q[chan->id];
>>>           mutex_lock(&ae4cmd_q->cmd_lock);
>>> @@ -367,13 +448,16 @@ static void pt_issue_pending(struct dma_chan 
>>> *dma_chan)
>>>   {
>>>       struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>>>       struct pt_dma_desc *desc;
>>> +    struct pt_device *pt;
>>>       unsigned long flags;
>>>       bool engine_is_idle = true;
>>>   +    pt = chan->pt;
>>> +
>>>       spin_lock_irqsave(&chan->vc.lock, flags);
>>>         desc = pt_next_dma_desc(chan);
>>> -    if (desc)
>>> +    if (desc && pt->ver != AE4_DMA_VERSION)
>>>           engine_is_idle = false;
>>>         vchan_issue_pending(&chan->vc);
>>> -- 
>>> 2.25.1
>


