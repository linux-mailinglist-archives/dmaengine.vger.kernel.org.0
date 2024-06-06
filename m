Return-Path: <dmaengine+bounces-2293-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9318FDE17
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 07:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37D61F242B6
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 05:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B620330;
	Thu,  6 Jun 2024 05:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4wtdh2WC"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F82E3FE
	for <dmaengine@vger.kernel.org>; Thu,  6 Jun 2024 05:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717650924; cv=fail; b=pWCH8urQC6iMqqnUABZv3piPIf3aEDxG1IgJlU4QA7S0dJXeX7ruSCtjLkrXy6VZQZAMmkk/FkvOrHe6haD9kibaoU3Adqh6k+RX7pmlhiQ56iXT3cbqk4vxeJ0fUl7h+ppOO52Hqm9u7CbStbBJzmBZ9wB4JExcu7E6/7eclUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717650924; c=relaxed/simple;
	bh=oglBBf0kRCht7JaeqviE/fMFjEfDmegYIDGNSofHhK4=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=EcI3tzNIH5FjMxcH7EX7+gEU/D44Gq2jk/Mw7hRG0n4krrv4CBRUaRqtbVWCSu8tO8OnLEUDhAXA3DBvVkS4d7bxnzLMCqp/zx7nzaTixC5jH85IxfZReuTzKAjJGG6U8QEwjEgKx7WHEKWJNgkfYsYKCZ9PXZLaYrUc0CTdYvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4wtdh2WC; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLwC4KANhNf4Oit3xxcg3MG/4o9ES0xZeA7GGSzmH4x+RAk1gm0F9eqlxnA2eVvOFJB8vGRt5AhQ5ZBQpQGn2a+GckVjr5dE2Kf4CekTHhCznLKUH8KYZXV0DrB2TgzlrhN5CkvAeqlQ/fnTKHiLsC6c7scHYlvSd/tnWROSI5+ulMMmyA3u/hX1xciqqC0kQgGC+OtmhXHN+tYxhAYAB5jDX6CVWuwboO7stsRsmnyu8G/z8oVoVEBldYGfiyo6z6nk7LL2aPwEMnYjuGcXRLOtqvxm9muYLcYjUt1LO5v7xiSqtgX2DslhTx005zN5pbP3ZBrjZPRnXwzyEXvRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S5V4S1NBzqn5zY7b0LF20S8nZuNWadI9+YMQsReqxg=;
 b=K2QyJkomyXFpMZ544hP1LqxHREqckLGLugFRanA42kmSaEptAMT7LCrORymhW1HDvuGUp0Lc1izahQbNQXhw+LRHSPjFA09FRqc9jBJQUOeuq2oS+QyskkdAbWFRvxJu2lPVI5KeJvT/2vdU2wW8vBxOIhmJpzieesJOLOppyVKMgH9CQnrmdXT+809cDV6tRmRriOTfVX+1oMpXJvkOFe7smg0RtVfF/oX06esZmy2vDrvUOXQ8vM7vQvRowq6ETEEebMSK4gmnuhePHSQUzJuNVKZj0bDbvALS2kH7s/PgLbBPodrm2/fWrOzf0pd+6gO/BhBEkOi+qVdcvYpLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S5V4S1NBzqn5zY7b0LF20S8nZuNWadI9+YMQsReqxg=;
 b=4wtdh2WCLlQcQ6u9aFOx/GHumo3sbF+gCml6L6l0iQ9E+oKSn7WYv0lSRiXfmbSh+TOxBuKg3Iqnbuc2oPGcgWt5SNw+LNYb4n3MtIiNx3VlNEDbrpxquM4lqC/PcMbPV8ymabLZSKzGwpwYE/RRuC9eWYQ23JrNoRVJ88hu3wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Thu, 6 Jun
 2024 05:15:18 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 05:15:18 +0000
Message-ID: <23afcee2-e936-4e99-8fa1-6fef9740ffa7@amd.com>
Date: Thu, 6 Jun 2024 10:44:44 +0530
User-Agent: Mozilla Thunderbird
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
From: "Garg, Shivank" <shivankg@amd.com>
Subject: Understanding behavior of memcpy_count and bytes_transferred in
 dmaengine
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::34) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|IA0PR12MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 82df4433-19a4-4c6c-edbf-08dc85e7a7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amZEL05NT0tLTnRlOGxiRHp6L3M1V0RiRHZyVG4zZ0F0eEgyUTJBK0s4TjE4?=
 =?utf-8?B?L09FeHY2Y05oeTByd3Y1aWpMNVpVbVBkbE1OV0E5U3lrSUMxWjZQYnZ2aVBy?=
 =?utf-8?B?a1NMZDZpY1AyaFJkT0FvY0duMVlBY0ZsYnB6bkNKTWVLdUpzRlJNVmFJeVpy?=
 =?utf-8?B?bGZlcy92SkJhVE4xaTBrUEw3TVp1Z2wzelRPT2RUNGNsczIwcFlnbXd5aVQ3?=
 =?utf-8?B?Mk5SdGYwR2dCaHN1NUVQMkRWUDRpR0M5SDJRQXlnU0RmemZRMmlkdjVrcWZt?=
 =?utf-8?B?RVlzRnNBdjBZay9jbVpPdEZHK1ZlcXRoQmxTNk0yRUF1UHc0MDQrSEVhK1F3?=
 =?utf-8?B?cnJZby80dVFGVlZ2cUR5d1piY3dPSVVRNUtLQzBPcG5CNER4U0pWYzNHRnd1?=
 =?utf-8?B?RUZwOG1wM0pWYkVjY2cycGlMS0RoWWhZaFdqQzFkSDRkU3Fqa3hJKzdZZytT?=
 =?utf-8?B?VmhyQy9Dd1FKV1lIdHB4UG05bXlkaUV5L3RXUWVnVlhxbTFXNHExbmY4VEl5?=
 =?utf-8?B?MVc2TjI0aXZxTW5rVGtaUXZHd3h4NnY4NXJXdytvMXFaUC9nT01iVVoyWjFa?=
 =?utf-8?B?Q2VPbVg4Qlkrd1BpTjdOY2krWEY1MWF2WVBhNUFWa01YRVlZR3BTMTVmYWpE?=
 =?utf-8?B?MnpQOFJXcC9wUXVTUDA2c2dEV2xIV0E0b01wUi9UYjRtd0lCSFFUMFViUzVP?=
 =?utf-8?B?aUp2ZENxOUtMeXBSSlU0czJJR2VpK0NhK3VEVGl3VzAwVjdNTWY5L3ZGOUpn?=
 =?utf-8?B?aG5ES0Q0RWVYcjZKbTE4cmZrVDhJRERndk96NjFOSnk1ZU16eXFxNTJZZENj?=
 =?utf-8?B?TVRBUzZZbFErSmRRSTJzUTZCQzAxbGI1Vi9PdER6d3huTUZjMURpZE5Pb1NT?=
 =?utf-8?B?VWJNeHo1VlJEQjBKeEJMVGNsT1RkempSWVVXeStQZjFaUzdFalRiSkRsN2JL?=
 =?utf-8?B?YXhpV0dlTzZsclRiU1kwOVJiVkNHK3NpL1VmYXplckdxenZlWmsvbFNpU3RY?=
 =?utf-8?B?RE9nRlI4UUdsVGdmMGhGSnJSVUNNYXZKUE5nY3hETUtHZUM0ZEk4M1ZsaDE1?=
 =?utf-8?B?VnNYYTBvcFNRRFdBYjVQbVYzVHJIdHRzWUl0RzMrSEtVbkJ2Q3JRWnNRWm9T?=
 =?utf-8?B?VHFhbFhKemNBdm9EL0ZMUkt3bGQ5UWdRWjBnNFI1bzRPa0FCTittOFlkamlS?=
 =?utf-8?B?MjZHRksvQlBhT0dPTUthNFZjZUlwZFc3MG8vSDdiQmxMdS9FdFk3dFhIckUx?=
 =?utf-8?B?U2tRdGRJUGo3TVA0eHpZcWdHYm5NOVQ4VWp3OU5CcVFuRklDYnZpN2E0RTZw?=
 =?utf-8?B?N1FhZ3dzclRWTzBoQkRMVTMxbk9VbW82TEttdktWTW1PUUxaalF3alhTQm5Q?=
 =?utf-8?B?enRXdXljK0d2NnppalpzWFFLb1IrOGJTK05kbGlWSFo2bzNXdFErR1l5UzRJ?=
 =?utf-8?B?QlNXcVFLS3hTNTRYbWZsM1VlMkhvVGp2ZUtvOWNkcTl3dUdsNmw3Mzl2NXNh?=
 =?utf-8?B?K0JETWRLN1BaL0FsWm9vdDgzUnUwb1VZVGFVMGFoODI5YnFpSVdUNFJLbWNQ?=
 =?utf-8?B?WDk4d3RtQndBRXpnaHJHQ2FQeC9ISnFtWmZRV1hkY05qZ1NuSDBza2g3aWlQ?=
 =?utf-8?B?QjIxT0tRelZCTGNMVlRteU4vMEFPNnAxWlcwUm9MQVNtV3IrVVpGS0lBNWJF?=
 =?utf-8?B?ams2TFd0SEJscmQvVnZyZ0h6RUdpd1UxYmJ0WjBZV2lDSHJJWmJwNjU4alJY?=
 =?utf-8?Q?z0xkNfnWoz6tSCjKUENtAPXSF8VNyRr4Jb7tJ19?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1JMaVljRlVHeXhqVWZNbUVNNVRMVmdxUXFwTldNME1oUCtiT3RjbDIyb3VJ?=
 =?utf-8?B?ZFJhMGsybjI4M2NidzYwYXB3NE9Pam9zUmo3NWc2RlBpZTdOU3FLS0VHQ0NI?=
 =?utf-8?B?cHpvNGxZYjZuaFpmNCtNc2pUc21vUmx3NzB1N1V0SlBSUkpTd1JYUjJhMS9K?=
 =?utf-8?B?UzJudUgrM3BXOW1Ndy8zRXdxTjRqeFNRaTNOYW9ZU2Z6OHYvQVV5U3FFQzkr?=
 =?utf-8?B?T01DTjRZblF5YWJyN2Z0b2NDc3Z0N2xHM2ZtVnhwT21ZQ005UkF4eFBGOS9k?=
 =?utf-8?B?UDQ0bHRtNnJIWXVaRTlaVTZTNHV5cjU3cm5odUdKR1NXeWNtMEgwUXJILzJw?=
 =?utf-8?B?Vmd5bkVKZGU5QWtSd0oycjM4SmRPL2wxeXVwemI0cnp2OGd5WFhRVmdhbi9n?=
 =?utf-8?B?eFY0SFphQzlFTk80VldMQ2JLUnRlMFZsNVNJZ085S0wwSnhLVmdhNHpnaE15?=
 =?utf-8?B?UXMya0thTCtGSWxiSTdFQWxwcHIrRDJ5TnZzR0RkbUlZL1oyNEhMZ3ZuSmFi?=
 =?utf-8?B?SXBQekJraXVwckVFY0lZVTVQbFl2WGlubldPbUdwVkpFWGNzM2lwNFNwUUdq?=
 =?utf-8?B?YldKZjNkUFcrUW0wZDBzaVRPbXJabFhTUjBocDJEVjFiWWVFVFMyNVlXR3o1?=
 =?utf-8?B?QmRPY0ZRYVo2OFpGbTNEOHRiRmt6U28xNUk1eU55LzVRYkNGZDVYaVBrcDEv?=
 =?utf-8?B?NnUzREdqQlhDTzVmY2UyM0lhSDVMNDZveDBiRFB4azZRcE84U2N3MFR5SlJ0?=
 =?utf-8?B?UGNCcG1SNGNIZFNnMGRxUzdSa21hRXIyU1NqZVBOMlMvZ1h5NmRDeXUwNmJ1?=
 =?utf-8?B?YXo2RWdIS1o4TXp0TzJPNGk1RzhLd2dpYjQvckU1bDNuOGlvT1RHbWFVRWhG?=
 =?utf-8?B?ZmdwaXhyNC9YNnhrb2lwampvN2JqYXJwaDlldktrazhzbFRTN2JYM3RiYTlI?=
 =?utf-8?B?ZWFHbzkrOUZ5QVJRMDN3SVVOdWFsZ2Z3SFpoNmVrWENpVHhTd3RHUDgxOENK?=
 =?utf-8?B?VFdQSG56emhSaU00dHZJSkVFTGxFNDRNbm0wT05KblV5OGVSK2J4dnJMNGJ5?=
 =?utf-8?B?TGYwU2hFaWFYLzJMeXc5U3VjcVc3a2o2OHBacExjUUxjOTUxTjd0ZWNubUFZ?=
 =?utf-8?B?eEhjd29WNnpNejRlL0lRNVZDNHBCYUlqSXVWRFM0RlZXUEc5U2pwZUh5aklR?=
 =?utf-8?B?bDlkM2FzcThmQ09qODhwS1RwU1FoL1I4RjlMSExnN0w0WFg3UmNjV08raHhE?=
 =?utf-8?B?d2wrVXVaZjRUNVBIRVBHdFdtOXAwU0xDend3VWRFR0J0VmRjc2ZqODdUK3BV?=
 =?utf-8?B?WWh0VGNLNUxyL2ZkV0lWQjVRanZmQzJNblBEbjVkWG1CQ2xlNzRzYkZwMGh0?=
 =?utf-8?B?ZHc4azNCS2l1elhqVUoyV1FWVEVoM3VwNEVUcTMzU2kxdGprb0l3WFNMTm9r?=
 =?utf-8?B?RUc3TW5tNUtNK21JVXZ0T2l5Z0l5UDlQZXNYTkVxaGdCbHNUaVVBM3dUVysv?=
 =?utf-8?B?aE92QklUaXAxNnJjWnpJSnQ4aXBjUlMyU3pHRkVzMCtJM0tvTVMyUVRSQ1hi?=
 =?utf-8?B?KzBqZEZ0MmxGb1NCWVMvbXNzTDZOU0VLSyt5aTBXZi9pbHlscWdDL1Zlb24x?=
 =?utf-8?B?L0lYT0kwRWdjR01PS0Z3T1dabEpCOGdpSmtXbnlxMUl4TTJwdHpPd1Z1eFpU?=
 =?utf-8?B?SlV6RExHNlJ6MDRMb0RqcHhKUUwxTVFoTGc5N0hPbTA2Tk40NjNvbklzVFpZ?=
 =?utf-8?B?d0t2WjlGUXZoTnZqMy9LVE1JUWNMVzlqdDZuMHBzZUtTQTRZZXlqclVXbEZi?=
 =?utf-8?B?YmtVV2RBdWg3TmdOeFI5WHZMd1VQb0h2Z1gyaGxIdlZyQm5Sa0t0TVNudmFL?=
 =?utf-8?B?dGxXUWJiNjVOMldta3pTci9FYWZSV1hRaWJKOS9yOVpIMFB6TUo3K3dWQ0wv?=
 =?utf-8?B?bVVIN2lWRmc2d3U2dFJCa1JqbmFVV2g2NkRvek9SOU1QQy82b1B6QXdKbGlU?=
 =?utf-8?B?cDlvbTFLVTZLMFcvTHR2d2JHQjhJeDJLTHFtclk2NGJjSlNEMk95TUJVdUNp?=
 =?utf-8?B?L2hCRkYyYW1kYnVFbVkrR0Q0M1JsSXRDdGgwYS9NbVJINUdDa2VSSTZuenhT?=
 =?utf-8?Q?S26ikvns0VcNk/VQupBqjGrhY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82df4433-19a4-4c6c-edbf-08dc85e7a7cc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 05:15:18.3143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3fk+8xTbPETxIFDatyQx3hm5iB1MHbisIGeKJN+MGlWFICxvSciLCnWq5N77rvgMNUNEfNThAYbj1Aq4g6pEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225

Hi Community,

I want to understand how/when memcpy_count and bytes_transferred are increased.

/sys/devices/pci0000:00/0000:00:07.1/0000:03:00.2/dma/dma0chan0$ ls
bytes_transferred  device  in_use  memcpy_count  power  subsystem  uevent

I did some experiments with a test kernel driver (doing simple memcpy from 1 NUMA node to another) and dmatest kernel module.
 
In my testing, both bytes_transferred or memcpy_count remain zero in all testing.
However, I observed in_use is changes to 1 when the channel is requested.

Inside the dmaengine: count += per_cpu_ptr(chan->local, i)->memcpy_count;

I checked these variable to understand if my kernel driver is actually copying any data using DMA but it left me more confused.
Can you please help in understanding its behavior?

Thanks,
Shivank

