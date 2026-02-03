Return-Path: <dmaengine+bounces-8675-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN4fC+pWgWkFFwMAu9opvQ
	(envelope-from <dmaengine+bounces-8675-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 03:01:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81609D394B
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 03:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C06E030037C0
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396C22ED858;
	Tue,  3 Feb 2026 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="IHfSfXsJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021128.outbound.protection.outlook.com [40.107.74.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC52DB7A7;
	Tue,  3 Feb 2026 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083957; cv=fail; b=PlpzJl2kx8Omx/48vgzezr5S1FY4fULgD+mc19pyNZvI4LVefTqw8D0Cp0Z7QP+ex5QBlOa1Jb0WxDr1QPgEUr48h78+R99oinCyRSsv1f4L5LuVZlIstWpCXMzDVQPjjhm+jkxC6kw+0gIJbYq6Rah+ts48tnT4wMnP/mzkwxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083957; c=relaxed/simple;
	bh=8WWu/PIcbKtPZTgAPf3Csgv/MafgP/ra1/uqTovWLc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YbhZw28vSAKTM4XkINucftG5bYOV0XgcEbfTwQY277Hyzng5EtmdasB8SBU72N0HukikeQQbeQcJz1a4OCUfiR8rAck9b0vJerOuDhfIszNLJzq6zk9jfHNmJSIqMtP/t4ynecPzh4qQYbz+8ctf3exXZjwABfCPEXDL1bx3GKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=IHfSfXsJ; arc=fail smtp.client-ip=40.107.74.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKxUVRn7oqI5DPPvcF3XEfK0eQWjQF5GDCuAFfyuBzcB+S7hZUX7kkRvQ077SD/ZOLbU2tiUC/NIrJId6HGOYfqpNUpk7yRToJqEFm5GGPlxQZngCIfXIVrs+eOts/Eg3tQjKC0w6+hReDXT42anb6FlvjxM5MbR1+hgNeKiKhOaW3925umu5HLzLqda0DzluDKVIsZjps02/Rw05+wELmq4TSRXULr33XBI8zVxdddfalbHwBT+Hqkw1/RjmLFN8D94qhO2LcoSgU7z1MkcJm5EOGTt48AYXT46jmbctP6Raxe1Dp/rtsv3aPwyqNtvjvYB6XjKC0Xh7yNbaTRMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/0LjwtWRlHDdCj2MHcTWDPM0gmAql38K0DosNdVSLg=;
 b=QfdA/AbPYMaSfkE8V90CYU3/0F/+lr0jKuO2xYwfYByZ3AWkCjq2YUhjIwV16Pv23+KBLNVt54OAFCf3vV5aHl0bPvuu8r+EwD/jxldk0vnpGUNUqBO3EYXRsaAXjCs3xAn2a+OnlfxatnjRm1l4hSxKE8OAuKI3df8l+wcj7i8oZgrWQe/Pq9KkTDAKYHodxMkvbmpIRG6z4olfZJwPi6AQoiiBsJAZuM+UFn/UuPjwbWdfj/JOBfIAVReE28KMwydfDfmovlTiqSdlhdyH0Oz7O/mxmMPWBoMf7w2iMCzliL7BK7CSbUAXPeSmdmRIicdLkByw+E3DiszHh3kjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/0LjwtWRlHDdCj2MHcTWDPM0gmAql38K0DosNdVSLg=;
 b=IHfSfXsJ/zoPY0+eBA/I/diY6hrbELsOb5xj9oQux6SEXfR40zmB2rc4/7PkWGpMAKTZjUD7DGyNAbm8JWhgLky5vVjYTzj1SLEv7NDOMTwJufhQl2rPuRPI3gYoOOv4kPW1iP1WzrEGTihQhG37dUII8dViD6K8S/09uHJ/WBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6821.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:419::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:59:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:59:11 +0000
Date: Tue, 3 Feb 2026 10:59:10 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] dmaengine: dw-edma, PCI: dwc: Enable remote use
 of integrated DesignWare eDMA
Message-ID: <cujofbyvnhwaqpto5pjyxdl3gosat2frixuyhic6tr6zf32rzs@rvtfrcueqq2h>
References: <20260127033420.3460579-1-den@valinux.co.jp>
 <h3uhcd426u32lmn4ajjcrclabuptiy3d4lmtdbwhtu5ca2dv2s@co5piltmkhx6>
 <aYDX2Y0n8lD/iUcJ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYDX2Y0n8lD/iUcJ@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4PR01CA0071.jpnprd01.prod.outlook.com
 (2603:1096:405:370::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e536a3-d411-4daa-6893-08de62c7d328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnVYUXo1Q1pnQlRreGpPbng5MHVUeEtwWnRlSGh4OUU5dlA4RHN6S0xHcHRE?=
 =?utf-8?B?L3c0eDcrVW1NTXBUd2UwZ0VTbUgwSDVOTzhyb3pHRW5NTjE3Wko0TXEzRkl2?=
 =?utf-8?B?SHUyOFJVdy9NYSt5aXBkUVV5WGJBdFpLbVhPZkpzVTBTaXN3bzNyUFl4emZY?=
 =?utf-8?B?QURLekYvL1ZqeHpMRkYycmJvYk5vV0wxNW9xVTkzbVV3OExBMktGN1JMdUVN?=
 =?utf-8?B?NW95ZzVsMHQydTliTFFzQ1lVYUJrdS9pWjNXbzlIUXp0azNzYXFlNXFHRUR2?=
 =?utf-8?B?bU5pNWFZV0lnTzNMZVJnUkpBeDJRWGR4VXpHNVhwaHJVQUdFMTVHOHpGbDBr?=
 =?utf-8?B?eitiVHBsZWNQSk1uclFnNmxqSUVpZXdpMFdMdWVrVkJOa0hwNHZXY0p1UG1u?=
 =?utf-8?B?MWVnUVJIVVk5ZFhlWTZ6emd2aHFXVXBpMTEycGJvdjRidnlLMUpteExnbXow?=
 =?utf-8?B?MDdTeTQ1bHJGd2dyOGFycjYvaUdPOFk4N1pVSDhPc3NIN3l3TFBRVDY0TWYx?=
 =?utf-8?B?Q1YzeVhzR3VZS2Ivcnc2VURpY05FS3hMYUpmOU1IaEgzYS9XK2lXWVFCVnlE?=
 =?utf-8?B?TTQ4aVVyUFJGbm5QNG5ERStBNyt6VXNlMlZYZGNjc1lMV3VVS2hxTVkxd3ZJ?=
 =?utf-8?B?MjZ5UEhEZ2hzTVhweHVSdHZIWHpxbUxzcTVBcjZ5blIxTGpLKzZid2UwWWNS?=
 =?utf-8?B?b1NBOS8vQ1V3b1dKalFsNzR6MEdHTWJBTDdML244ZTN5UFFiNUVkVkp3YXVq?=
 =?utf-8?B?Z0RkTFNyTHlHaUdadUhqZmNGVDBoOXBIRlZsbjlhakE1V25PczVWSmhiL2ht?=
 =?utf-8?B?Q2srWU5LMVFPa0RMWGtIZGF6enVORHhyeWlEOE5nRUpTUmFoUkhlQStJV0Yv?=
 =?utf-8?B?eDBOSWMydDVEWXp0NFFycjQ5QlpKL2RMako5TEcyY0U3ZWVrSUhXM0hUUjd4?=
 =?utf-8?B?USttSnllNTNvYTArTkp3VjdXMlY2bm1nU3E4K1R1RlZ2cFhXN0dxWGxYNmxU?=
 =?utf-8?B?RllQUVVYSHFYd0xFOWRmTG9NbHc3eVNPc2Y2eVY5bEJtUnFqM3IzT3dvRjRo?=
 =?utf-8?B?VVdOQ0RyS2o1SXc1cnVwYUEvVnBYN09ESXlMSkJZU1pBWHBXTE1KYURRRGU4?=
 =?utf-8?B?cEFKTTduTU1nVmxTWE45dlluSlA2SVd0NkRnaWFaZnp6TlZBY01qQVVvenRW?=
 =?utf-8?B?d0kvZlNjSW5IVlF0aGxZRmZzbFNvaGszVjZmM1l6OGZuOVhVc1lneU1xSENX?=
 =?utf-8?B?TkhjZjdjd3VjNHFpdW05c3RUYTNHRWxaNWRTWFdodFhqN2cyT01GdXlvUkFr?=
 =?utf-8?B?bThpUDZlU3BXT0hwNTdwZnRQblZpZGZlaU52NTZsYXRoRmg1K3ZMcmNrYnAy?=
 =?utf-8?B?VFVmTk9Ha3pubGl3RDkvdlp5VTBXWmwzN1kxSzc0cytRbWUrZ1gwWGlteG84?=
 =?utf-8?B?WlhHY213bXNsdmo3RTdncFlYOUZYaVI2ZVIrNGRrZERtaWpzSkYyL1VHLzU5?=
 =?utf-8?B?WHVhU0NoL2Y2RnRkZFpMVUl1Q3crM210T1dDYndHcGwyYmV0dDJZUmRhVVNV?=
 =?utf-8?B?NHRKTDBZU0RQaGRrdEl5ZG4wcHZLWkQ1WFp3RW1NaGZrWXlNM3l0T3B0SE93?=
 =?utf-8?B?STNZTi93MTlvUE44dk9LNVViODNHTjZTb0JrVHFDOU42UXNRMEtTcWozOWVn?=
 =?utf-8?B?WW4ydVJabHFtS1c5U2tRRkZhdHBzYjRqZnJwR01ZdFg4K2kzaWFlaS9wSmU3?=
 =?utf-8?B?aUFHRFArSkkxODA4RjZybUw1VjBVYkl5TnpqaDVIeDgxYThHYVdVRzRqK1BI?=
 =?utf-8?B?VW5lZkdqaEdQRlpRVndreTRjUGxwcitFVHdJOUwzS3VxYlJjeEZpM254RlNL?=
 =?utf-8?B?ZVdmZHVYUHJrd0MvemJqSzhmVGhIMERzaktHSG9Zd2p1aDNrd0FWbXdnVXNT?=
 =?utf-8?B?a2p2WVJldlNzN2o0cFJlR3lrNXpVNTRZN3pvTmdJN3p3OEZLSWtyYWFyLzF4?=
 =?utf-8?B?RFQxbXliMVJmL0N4Z2RCNjJQSUJJcUFUMHdLVGpaM0xlSWdqOW5rNEd5dFVs?=
 =?utf-8?B?Wk4zSVE0TFdmVlhxb29HQW4vQzI4V0l2Z3p2U0IvMzhjbDE1cGlSQVdybzRJ?=
 =?utf-8?Q?MVHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWZSYk4wVXp6Mm53aU9vMW90Ykk0bmltZ0xuYnM5NUJ3aXFyK0pRTE12L2ph?=
 =?utf-8?B?bWhhL2hDWnpxREJRcVN4STlwVmpmRFJZdzMzSll5RzZMTGV0MkQrVG94SmFK?=
 =?utf-8?B?TEttcUE2b3I4b00rNCsycTZtOHdKaGxlODNKZXhhTUhJcUREdFNaSVk1Nmdq?=
 =?utf-8?B?K1lSbnY4SlErZEpSc0xUWG1Wbnp2NWFrbUZtMUdEQ0JmeGF6Ylo2MlZKeHhR?=
 =?utf-8?B?dmdCOFk5T1B4VDVmQWt3bVc3K3VERklLdXYxOVd1V0x5djkzSTUwRExYeTdw?=
 =?utf-8?B?bmp1TExwRDZVQlpLTjI2TERFYW92M2l5NWlDWjB0OXhjcmRydTVBU0pZR2xV?=
 =?utf-8?B?RlpIUVc1SkNOdUlMK2RCNVFFNlRtNmtCSnhuVUVRb2RzMmJMSzZnc1g1VXVZ?=
 =?utf-8?B?V2RmOXJVUUhJbGh3ZFdqTGlDWmNCVXpSOVRwdWliVlFIV1JVQjMwTEFuZkFP?=
 =?utf-8?B?NlFVaVNMYXZvZzFRWU5mck5obENPNjkybWkveDhCczV3M2cvM1VmSm1Hang3?=
 =?utf-8?B?eXZjSFVDOWFhSmdQNGNnYTdyL1NwOVRZWVhmS2RYalhQcngyV0lnOHkxS1hL?=
 =?utf-8?B?RHlYMG5yU1JIWkRUR1FOV1h1Sk1XVDBPaC8zY2gvREQrKys1TCs0Y0t3elRG?=
 =?utf-8?B?L3hzWjhqZnhWMkxSd3BLdDRiKzh0djk2M2kwcDJOVHpwQkJSd2I2MkF3Sy9l?=
 =?utf-8?B?ZEt3NEcyYnpEdW4yQzVrYjdFTEIrMU4zc2dXUVoxUHlINGhOSG1ia0paaHVU?=
 =?utf-8?B?QmhYUWsxVWsyYXlCK0ZuSm01WjhrL2dsVWhNZlVwaDNhRTVxVDFkSy9va3R4?=
 =?utf-8?B?QTFZdXZzRHFlTHVGbmo4cnhJVGJmbmo3eXVpMzhzOXg4SDJzZGt3WFlUT0R2?=
 =?utf-8?B?ZHlOajg1NTNmMDNqUlF5RnNtOVc3dkxxU04xWGZrTW54dC9hRU1qL1E4QTZG?=
 =?utf-8?B?RTMvTUpSQm5ZbE1neUJvb2NWck5jSzhSanYxVEZML0RHTkIzVTROUTZlUjFl?=
 =?utf-8?B?UUVrU2p3TlZyZCtLZEdkbzg1eEZQZk5EYjdZbVBiQm1pWHlKZ0JSUzJlZXZ5?=
 =?utf-8?B?TXo3TVd6ZFRrRlMzZmU1eEk5ZytXWXB4Y1B2UTBYOG5DamZDSGlDN0hXa2hK?=
 =?utf-8?B?OWNIYVFFRlducml3L3R4MVgzQjFjeUlWRGd5OWovTVRJc3YrV2YxNFJKRFhO?=
 =?utf-8?B?dzkyakc0Q1NNenA0c05zWUFHbys4SURLUmRlVlNZcjYzRjRQb0N4MjZ2YXVE?=
 =?utf-8?B?Mk0yb1prYUUrRnJKWlExbkVrVFFXNlFYaUQ4VEFpb2ZlQmVNWVJIL1F1eGVU?=
 =?utf-8?B?MHpjODlCSlB3RkZGaGJjbUNIWDlORlgvS1owekQrTlFwRG5oazQxeWVJSlA2?=
 =?utf-8?B?M1dsLzJaVzVDbXA3NG5Sb21mb1dXMG1tQzRCQVp1ZThmQVpaYVlNZmc4VEtl?=
 =?utf-8?B?U0RaYXdCQnAzZW1UNENFSTJSejJiL0JYT0VQWTQ4V1k5d296LzBINUJubUNZ?=
 =?utf-8?B?VEx1NElsT3prQkQ0U3Fud0lOYnVCS0J3SzdlM3BONGwvRlBIWFp5MDl1RU85?=
 =?utf-8?B?U0ZkaVlJcy91SVZ3UzV4Rzd0d3FTcWFqd2x0djZ3V25tMmN5Ymg2WFN5WXJN?=
 =?utf-8?B?WlpNbFJIMjZIaVA3ai9IdmhZZDBEY202cEV5dncyOWNIM2MzMUN0UlI5QU9Q?=
 =?utf-8?B?R1A3b2NJNDVCRGFzNHYvSGpFZ1FtTVRqZ3FaNHNoOUVUN010MWxzWDlpWXZw?=
 =?utf-8?B?Ni92bWE1Wk1LVkFiUGVBalBQeWc2U0ZpRkJxY21tbHNUZEVYOUJKTERNY1Jz?=
 =?utf-8?B?QWs5S3VQYWRQUjd2YjAvQ1Irc0I0QTRxWmt4Vkw5QncwYlZJd0ltbGRydTNO?=
 =?utf-8?B?SklTakZueGhmUW5IZG9oZ2VldnM1dUpSNkd3YXRobEF1VlE2bVRVNEZxdDIy?=
 =?utf-8?B?T1FocGlMVHlEeEVyYzQ5R2tvbkVGVUZQYWpkdXcxb2prQWNiTDgvQUVyanlh?=
 =?utf-8?B?amg3bHk4NjZaYXIvcUxzbzdDVEFJZGozamhxSktLSmtKdVRlcFFBQVJBWW1M?=
 =?utf-8?B?M1lxUHhKa1pmM0ltUHJ1WVRlZjVwd01rYjN3VGVSMG5rTnRsY00zZFI0Tno5?=
 =?utf-8?B?ZnMyZTY2aVY4RktERElXcGZpaHVRZm1vdkQ3K3hBQzJUcEI3Z2VVR3hENXpm?=
 =?utf-8?B?bjlPYk1tSmNoRllZdFQrL0xDZGpSQk5jaGNGLzRZLysxMkplemRMMWJFU2tC?=
 =?utf-8?B?anpjYS9sNEY1MDcrdmFNbUZDdDloQ2tKNERqWHNqa3U4VUJpRU8wWDVUeUNF?=
 =?utf-8?B?WWFQWU51RmwreEJLNXVQaFA4cS9WcnRJbnRnQld0RzBOajdSdVRkcmxxbFEw?=
 =?utf-8?Q?EMP6UpjrKRYzHITTXPfa7CONX5qkgPpmJeW8Z?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e536a3-d411-4daa-6893-08de62c7d328
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:59:11.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W428WRhw+kkzcwcMnB1BkNgIf7/ZJRizhQUG/aFKAUTsT9yWfN+IvOqKXG8PC599TfH/t8HmnXnIvX2MQS9dzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6821
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8675-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81609D394B
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:59:05AM -0500, Frank Li wrote:
> On Sun, Feb 01, 2026 at 11:32:23AM +0900, Koichiro Den wrote:
> > On Tue, Jan 27, 2026 at 12:34:13PM +0900, Koichiro Den wrote:
> > > Hi,
> > >
> > > Per Frank Li's suggestion [1], this revision combines the previously posted
> > > PCI/dwc helper series and the dmaengine/dw-edma series into a single
> > > 7-patch set. This series therefore supersedes the two earlier postings:
> > >
> > >   - [PATCH 0/5] dmaengine: dw-edma: Add helpers for remote eDMA use scenarios
> > >     https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
> > >   - [PATCH 0/2] PCI: dwc: Expose integrated DesignWare eDMA windows
> > >     https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/
> > >
> > > [1] https://lore.kernel.org/linux-pci/aXeoxxG+9cFML1sx@lizhi-Precision-Tower-5810/
> > >
> > > Some DesignWare PCIe endpoint platforms integrate a DesignWare eDMA
> > > instance alongside the PCIe controller. In remote eDMA use cases, the host
> > > needs access to the eDMA register block and the per-channel linked-list
> > > (LL) regions via PCIe BARs, while the endpoint may still boot with a
> > > standard EP configuration (and may also use dw-edma locally).
> > >
> > > This series provides the following building blocks:
> > >
> > >   * dmaengine: Add an optional dma_slave_caps.hw_id so DMA providers can expose
> > >     a provider-defined hardware channel identifier to clients, and report it
> > >     from dw-edma. This allows users to correlate a DMA channel with
> > >     hardware-specific resources such as per-channel LL regions.
> > >
> > >   * dmaengine/dw-edma: Add features useful for remote-controlled EP eDMA usage:
> > >       - per-channel interrupt routing control (configured via dmaengine_slave_config(),
> > >         passing a small dw-edma-specific structure through
> > >         dma_slave_config.peripheral_config / dma_slave_config.peripheral_size),
> > >       - optional completion polling when local IRQ handling is disabled, and
> > >       - notify-only channels for cases where the local side needs interrupt
> > > 	notification without cookie-based accounting (i.e. its peer
> > > 	prepares and submits the descriptors), useful when host-to-endpoint
> > > 	interrupt delivery is difficult or unavailable without it.
> > >
> > >   * PCI: dwc: Add query-only helper APIs to expose resources of an integrated
> > >     DesignWare eDMA instance:
> > >       - the physical base/size of the eDMA register window, and
> > >       - the per-channel LL region base/size, keyed by transfer direction and
> > >         the hardware channel identifier (hw_id).
> > >
> > > The first real user will likely be the DesignWare backend in the NTB transport work:
> > >
> > >   [RFC PATCH v4 25/38] NTB: hw: Add remote eDMA backend registry and DesignWare backend
> > >   https://lore.kernel.org/linux-pci/20260118135440.1958279-26-den@valinux.co.jp/
> > >
> > >     (Note: the implementation in this series has been updated since that
> > >     RFC v4, so the RFC series will also need some adjustments. I have an
> > >     updated RFC series locally and can post an RFC v5 if that would help
> > >     review/testing.)
> > >
> > > Apply/merge notes:
> > >   - Patches 1-5 apply cleanly on dmaengine.git next.
> > >   - Patches 6-7 apply cleanly on pci.git controller/dwc.
> > >
> > > Changes in v2:
> > >   - Combine the two previously posted series into a single set (per Frank's
> > >     suggestion). Order dmaengine/dw-edma patches first so hw_id support
> > >     lands before the PCI LL-region helper, which assumes
> > >     dma_slave_caps.hw_id availability.
> > >
> > > Thanks for reviewing,
> > >
> > >
> > > Koichiro Den (7):
> > >   dmaengine: Add hw_id to dma_slave_caps
> > >   dmaengine: dw-edma: Report channel hw_id in dma_slave_caps
> > >   dmaengine: dw-edma: Add per-channel interrupt routing control
> > >   dmaengine: dw-edma: Poll completion when local IRQ handling is
> > >     disabled
> > >   dmaengine: dw-edma: Add notify-only channels support
> > >   PCI: dwc: Add helper to query integrated dw-edma register window
> > >   PCI: dwc: Add helper to query integrated dw-edma linked-list region
> >
> >
> > Hi Mani, Vinod (and others),
> >
> > I'd appreciate your thoughts on the overall design of patches 3–5/7 when
> > you have a moment.
> >
> >   - [PATCH v2 3/7] dmaengine: dw-edma: Add per-channel interrupt routing control
> >     https://lore.kernel.org/dmaengine/20260127033420.3460579-4-den@valinux.co.jp/
> >   - [PATCH v2 4/7] dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
> >     https://lore.kernel.org/dmaengine/20260127033420.3460579-5-den@valinux.co.jp/
> >   - [PATCH v2 5/7] dmaengine: dw-edma: Add notify-only channels support
> >     https://lore.kernel.org/dmaengine/20260127033420.3460579-6-den@valinux.co.jp/
> >
> > My cover letter might have been too terse, so let me add a bit more context
> > and two questions at the end.
> >
> > (Frank already provided helpful feedback on v1/RFC for Patch 3/7. Thanks, Frank.)
> >
> >
> > Motivation for these three patches
> > ----------------------------------
> >
> >   For remote use of a DMA channel (i.e. the host drives a channel that
> >   resides in the endpoint (EP)):
> >
> >   * The EP initializes its DMA channels during the normal SoC glue
> >     driver probe.
> >   * It obtains a dma_chan to delegate to the host via the standard
> >     dma_request_channel().
> >   * It exposes the underlying HW resources to the host ("delegation").
> >   * The host also acquires a channel via the standard
> >     dma_request_channel(). The underlying HW resource is the same as on the
> >     EP side, but it's driven remotely from the host.
> >
> >   and I'm targeting two operating modes:
> >
> >   1). Standard use of the remote channel
> >
> >     * The host submits a transaction and handles its completion, just
> >       like a local dmaengine client would. Under the hood, the HW channel
> >       resides in the remote EP.
> >     * In this scenario, we need to ensure:
> >       (a). completion interrupts are delivered only to the host. Or,
> >       (b). even if (a) is not possible (i.e. the EP also gets interrupted),
> >            the EP must not acknowledge/clear the interrupt status in a way
> >            that would race with host.
> >
> >                                   dmaengine_submit()
> >                                           :
> >                                           v
> >        +----------+                 +----------+
> >        | dma_chan |--(delegate)--->: dma_chan :
> >        +----------+                 +----------+
> >       EP (delegator)              Host (delegatee)
> >                                           ^
> >                                           :
> >                                 completion interrupt
> >
> >   2). Notify-only channel
> >
> >     * The host submits a transaction, and the EP gets the interrupt
> >       and runs any registered callbacks.
> >     * In this scenario, we need to ensure:
> >       (a). completion interrupts are delivered only to the EP. Or,
> >       (b). even if (a) is not possible (i.e. the host also gets
> >            interrupted), the host must not acknowledge/clear the interrupt
> >            status in a way that would race with the EP.
> >       (c). repeated dmaengine_submit() calls must not get stuck, even
> >            though it cannot rely on interrupt-driven transaction status
> >            management.
> 
> According to RM:
> 
> WR_DONE_INT_STATUS
> Done Interrupt Status. The DMA write channel has successfully completed the DMA transfer. For
> more information, see "Interrupts and Error Handling". Each bit corresponds to a DMA channel. Bit
> [0] corresponds to channel 0.
> - Enabling: For more information, see "Interrupts and Error Handling".
> - Masking: The DMA write interrupt Mask register has no effect on this register.
> - Clearing: You must write a 1'b1 to the corresponding channel bit in the DMA write interrupt Clear register
> to clear this interrupt bit.
> 
> Note: You can write to this register to emulate interrupt generation, during software or hardware testing. A
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> write to the address triggers an interrupt, but the DMA does not set the Done or Abort bits in this register.
> 
> 
> So you just need write this register to trigger a fake irq. needn't do
> data transfer.

Thanks for the comment.

One concern I have with using the fake interrupt mechanism is that it is
effectively channel-less, while the only documented acknowledgment path is
via {WR,RD}_DONE_INT_CLEAR[x], which is strictly channel-based. The RM does
not describe how a channel-less, emulated interrupt is associated with (or
cleared by) a specific channel's INT_CLEAR bit.

Because of that, I don't think there is a spec-backed guarantee that
writing INT_CLEAR for an arbitrary (even if reserved) channel will reliably
clear a fake interrupt, though I might be missing something. In the very
first RFC v1 series [1], I ended up writing 1 to all enabled channels
simply as the most defensive approach. However, that clearly does not
compose well once the same eDMA instance is used for real data transfers,
since it risks clearing real completion events.

What's your view on this?

[1] https://lore.kernel.org/all/20251023071916.901355-16-den@valinux.co.jp/

Thanks again for taking a close look at this.

Koichiro

> 
> Frank
> 
> >       (d). callback can be registered for the dma_chan on the EP.
> >
> >                                   dmaengine_submit()
> >                                           :
> >                                           v
> >        +----------+                 +----------+
> >        | dma_chan |--(delegate)--->: dma_chan :
> >        +----------+                 +----------+
> >       EP (delegator)              Host (delegatee)
> >              ^
> >              :
> >       completion interrupt
> >
> >
> >   Patch mapping:
> >     - (a)(b) are addressed by [PATCH v2 3/7].
> >     - (c) is addressed by [PATCH v2 4/7].
> >     - (d) is addressed by [PATCH v2 5/7].
> >
> >
> > Questions
> > ---------
> >
> >   1. Are these two use cases (1) and (2) acceptable?
> >   2. To support (1) and (2), is the current implementation direction acceptable?
> >      Or should this be generalized into a dmaengine API rather than being a
> >      dw-edma-core-specific extension?
> >
> >
> > Any feedback would be appreciated.
> >
> > Kind regards,
> > Koichiro
> >
> >
> > >
> > >  MAINTAINERS                                  |   2 +-
> > >  drivers/dma/dmaengine.c                      |   1 +
> > >  drivers/dma/dw-edma/dw-edma-core.c           | 167 +++++++++++++++++--
> > >  drivers/dma/dw-edma/dw-edma-core.h           |  21 +++
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c        |  26 ++-
> > >  drivers/pci/controller/dwc/pcie-designware.c |  74 ++++++++
> > >  drivers/pci/controller/dwc/pcie-designware.h |   2 +
> > >  include/linux/dma/edma.h                     |  57 +++++++
> > >  include/linux/dmaengine.h                    |   2 +
> > >  include/linux/pcie-dwc-edma.h                |  72 ++++++++
> > >  10 files changed, 398 insertions(+), 26 deletions(-)
> > >  create mode 100644 include/linux/pcie-dwc-edma.h
> > >
> > > --
> > > 2.51.0
> > >

