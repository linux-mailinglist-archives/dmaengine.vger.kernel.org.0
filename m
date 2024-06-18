Return-Path: <dmaengine+bounces-2408-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFE390D30C
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAFA1F214D7
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C9213A245;
	Tue, 18 Jun 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fNs+s6iR"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906613FD72
	for <dmaengine@vger.kernel.org>; Tue, 18 Jun 2024 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717556; cv=fail; b=if4nN2pNxsKsAJNSv+Fb2WvIGjPDyaUKvkLx1T1PNt6QyTxl+3YDC2awZfbmIFxCvb0EEV5TZFd+kYglrpmORWMpyYp1DPGnCmpsE5BGc91O3oDWHvw6Tl2jAK9j0DnMcgH4vWmQbisexALbLwK3Th27Gi7sDcwN/J8RfrwOiQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717556; c=relaxed/simple;
	bh=VHEwFXxx+nrN+kg+ETFwqaTDEzEO7Kbop4GpnojEiHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMV3PMGaumZJEeqVQcu9DcGAxiRG4lx7IYtCx3Imws0yM0O7bvM4oK0RD8ZnkVjBlK/egi7OUKOsYeOtqrMZntk4isMFFHkow8oS1aXth0y62S2ZMK814WRvTcQQLoN6E18S4asl/+00iUryFvaJqwlMhSXxShXWYJ4vcW3O70c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fNs+s6iR; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVTLw5m0Lf7x/9xU+0AXLhZiwJOv9HAG9V/qWsn4I26UWFh+4B+3tk3lY5M0YKjrBqSvsF94xl0M3vGXP/rK3Li3fRxEDgPnBM7t6NCcLOXn3ewO5JRg4KP1IZrwgWn7OT4NljOE2Ua2IDIqWRc1iKXDEHT8aIRxMarfEq0StGrjsUQuLKQSTNj0/AbkJD+2w9kXZNIOgTd1ScvtghbLdxiiThRf9tfwdyM4OCdUuerP7kqHaMlL/X9m9yqpKLXQ0OvuvD90SvOhBoR0xIgc0Pm9hNvE+2DWm3DkTlJiDnCiGHtN4oPHlnazkofaPpR/QYWkTLIggnJUBkAFqck/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHEwFXxx+nrN+kg+ETFwqaTDEzEO7Kbop4GpnojEiHo=;
 b=ke68XQZ5zgmGVhwETAG7T7XUTi1RKmjD7lt+L4nT7ahVlw2N/UOTGt0PG5OZKV2BfnEnEu9a1LQDVC9+AGePmjlQkl0BszCpwaxAkUdul+5e9fvyZUWTj+HVTrmBPPa/8SJR3WhJ0t7LYJTy/410G83kphc3EwLHfC60ZUKvlFBKP54kuz/woft0oWTlEMPPJjL40nJN7fZ6Fc4D1VcGS/99lky9tyl5w6ZaSTAGPWLUTGSc2m9LO88xO+cMFhveNFXOIpEP5ihcsJi5Z2g0HccC5rlBJookLE9VMB6ZbK2KaXvojnPMwtvDWTaQXtayoX8kn9ldontKnXKiNtbPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHEwFXxx+nrN+kg+ETFwqaTDEzEO7Kbop4GpnojEiHo=;
 b=fNs+s6iRCE+VayFGkhZQr25wem8anYIaH/X+5j/IcM1qUlH02I9QjxrXJqqxoYi2jgKGIsZDd/UfMh0XtDqDea4+/WEGwc6tbqvfcyjF5dibY0+Ye8Mjh5k8PpexcN5vWmKR5EWLSNQVC/qMVTPN2t81xUdUqp2W9yNps4BmO3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 13:32:30 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 13:32:29 +0000
Message-ID: <62312da1-6f31-41b3-a8b9-8b6d9a4c880f@amd.com>
Date: Tue, 18 Jun 2024 19:02:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dmaengine: ae4dma: Add AMD ae4dma controller
 driver
To: Philipp Stanner <pstanner@redhat.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org,
 dmaengine@vger.kernel.org
Cc: Raju.Rangoju@amd.com, Frank.li@nxp.com
References: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
 <20240617100359.2550541-3-Basavaraj.Natikar@amd.com>
 <36f3d8d4f88f57ab28976899d27809696355392b.camel@redhat.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <36f3d8d4f88f57ab28976899d27809696355392b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::6) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c20502-89fc-4af1-ae47-08dc8f9b19bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlFWRDlPWFR3dXlkUnc5TTFDWWJ1T1lUTWd1VWt4VTVNVmhSNUFIY2IyVVNz?=
 =?utf-8?B?NmRtUDhKN2tLRGxOamk2SEZ2b3lNd21Bc3VxTnNoeWdIYkdySHRNUlNOME8r?=
 =?utf-8?B?dzJVQ1VYbTYrNk55YkYzRnlBZmQ0Y3JxSk93Z2tSTHREczJ5UE1YbnJRcjEz?=
 =?utf-8?B?WUdXWUdNMHhvUGFtUmZsR25peWFvTnZoZDVDc0lyZUMvM3dmNDMxaU5CTnFG?=
 =?utf-8?B?bDJKWXQxTDF6MmxnVkxtbGNOT2YrZHcrSjUvZEhCRi9kcjMrZldhSFZ4Qkp3?=
 =?utf-8?B?MDQzYVZKN2FldG9jRG5vVi80OGNmQjhaUjdDcW4xdnI0dnZJTWdmVkwvREla?=
 =?utf-8?B?dklTY0N4bEdkUTFTYmVjT2VhcXV5cUROSW5QOTVzVnF4Mnl2ZzAzL1pDRWZn?=
 =?utf-8?B?TVhCaVVaMmlsbjgyL2Q2U1pvaG9ibmhySUt1UjFvdkNSQWQ1OHJvMUxmbElE?=
 =?utf-8?B?QUJLdU44ZE42eFlrNDB4eEhIS0xJc0ZlNENWTnBuTno4ZXNVQXo4Mkc2SURw?=
 =?utf-8?B?RmRBWVlheWJSaGlIL0xSYmxsVXhKRzEzd0VBV3FqRDBmdmFab3BDam16dllL?=
 =?utf-8?B?NWxRbXlUSjZNSmZKOGhwelNZQzJ6dU9vUXZHOERkSnFEVUZjdHBad0U0QXhO?=
 =?utf-8?B?bTdlNjRCbTdvbmxyYXQrQzZLdm5CNUZEZkZqUytGSjZtMVlsTGQ2YWIyQmU1?=
 =?utf-8?B?UlhFS2RFMkxLMFlBek5CcFI4TEUzdGI0Z01GV000Y1BmdFFXN0M2bGttWTJp?=
 =?utf-8?B?TGZjMHREZFI3YjBOSnJRZ2dpemZIckN4dXdOQlNveVdGdGI3NGdtdllZZ0NC?=
 =?utf-8?B?Qmc4d1hVMkRUOWJldHk4cTVmbmc4R01sWmVFOWdzMVR2bW1mTHFhOVhkSU9a?=
 =?utf-8?B?bWhtMkpIQkJjdnBUZHZPQWQ3a0RLcEtQTUtUS1IwbDFIMHpOYVdlRmRkMjlF?=
 =?utf-8?B?Z3RUZ0lmb05WdVJSaEgrUEJ1MXlyMDdKVnNNSGgrc25pWjFpaGp5VysxTlFI?=
 =?utf-8?B?dHYyYm1UZmh6dzc3R0xQM0Y5dHJVSnFSM3ZNZ0lTK0RPaThIczdRT1QrNWVO?=
 =?utf-8?B?K1ZOb1NIQXpqQTFqSGFtRW5ES3MweERUSjk5SjY4ekF3d2YvN09QOWptMFpR?=
 =?utf-8?B?cGpTdVVSTXFic20rWDVGQWhtZ3E4cXpWTmRMUVpHc0ZmY25LcXhuMno2LzVJ?=
 =?utf-8?B?THl4dnp0WnJ4ZGRrYWptSDlETjFKUVRZR2VhV3VERmk2dEI5OEVpRFBUZERG?=
 =?utf-8?B?M0llOER4VHR6UmRZYTEvQ1NqazlMQnpDRnBIa2gzWjQxTitwZGxuZG9RZis4?=
 =?utf-8?B?RER6MDlzNS85Y2Q0VVhKQyttZEpsNlFIUlpoSzdYam5xWHU2eU1vMXZvQy93?=
 =?utf-8?B?b09FQVZScDBMWXlYRUtuOC84NlNBekJDK29xdktvbnN5M3hlMGhiWFlGcS92?=
 =?utf-8?B?dFpxQUVmY2pqNjJLck9JdWRpYTdqRVF3Y1p1M2dVeGwrK2hZMkhXcHhZOGVO?=
 =?utf-8?B?YjJyQXFaOVFuSGJlTHZOM01lUGRjdVg2dG1Uckc2R1JFL3NBOUJydDRBWFBs?=
 =?utf-8?B?TUY4ejVwWmpJeHQyL1kxd2d4UUd0czRZR0hkdnpmYUc5V1ZLSmNYNUxzNTdm?=
 =?utf-8?B?S2xpbnp0Tk9oMHpQbE4ya2NSeUovVVo3SE55N0MvRTRqM0lldG5LSER0Q29O?=
 =?utf-8?B?V1JDT09vRit2SUpVSnh6Y2Y1akM5YW42aFZSNFFwOHk0Y0lEQlcvQ2FBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek04cHNTejVERTBNYlNXWlJFZU83MUk5T2g3ckRVWUVCdGVRb2YwMTlHMmYy?=
 =?utf-8?B?N3M4YzBvd0U4SStqVjV5VGRnREZHRStQeXViMWxPQUZvd3RMYnQwREdNd3pN?=
 =?utf-8?B?dHJwMk1IVjM0K2daNUlpTjVhM3N0enRibFhkOEF4WGxzT21ReTJOVWdkbW5m?=
 =?utf-8?B?ZTkrYXh5VE1kRCt2VDRmOU1TQVpyWkNwU2JoVTVqS1pWeVRGTXBvMTQvNDRE?=
 =?utf-8?B?czhGQVM4THdUZ1lNUUhPT2Z3czNTdmFwSDNmbjFaVnJqZFZwdkt6cmtMb0hB?=
 =?utf-8?B?WlpuMUcxdzI2Q0hVWTVsVU91dktBUFVzNXVRZHUwTkpuWDZKY0h1eEE5dU96?=
 =?utf-8?B?SHF3N0p3QVhMbzRYUmd5Vkpua1dNRWJlcThPL0o0QzN4VVdORW9ERHd5ZkxB?=
 =?utf-8?B?K2g2OTBTK2VnUFRVVTlmTisraERsZlZYOENSVitHV01qTTJSNVJIZTFDRFhU?=
 =?utf-8?B?ZjFrOCtzMWwvdzk1dTFkd0NSSHFtb0ZTMFptcTdvd04vZ21LV1B5YkU4aktz?=
 =?utf-8?B?RzFsSG1aZGJqNERleFZmZGQxLzZDVjhEc0g3bnk4THJsZ09pNkZTVnVnT1ln?=
 =?utf-8?B?dmdMZmd1aGs4aC9KVWUrYlVuRzlQQWpjMFhpTnRHYkNBYWJBUDBsYUUvYVFj?=
 =?utf-8?B?SjNET0l0cVRINHRyN3ZpTG5lZWZVZTRhT052WWxNa1R4UmFpQ09oNlprMEFC?=
 =?utf-8?B?aC9IcnlEU1I1U1FvV3VwN1BFOXA0ZzF6YU5YTDJBeDJ6YlJzUklqOHNDb2pm?=
 =?utf-8?B?YnM0RmRvTmhobDFkWVZsUXB4ZTRGZGZuWmxna3BZeHI0Y1Z5Ym1zQlU3aUhZ?=
 =?utf-8?B?R0I3OW5kOFJ0VERIeXpoUEwrZDlCUll2R1VFb2N4UlhNMElhdkVZakhXQWZR?=
 =?utf-8?B?TjNVaGRYOEdadGJ2TXhZU1pyZmlGYTBNVmJRRC81MmF2MXV4VFl3L2VuWHVp?=
 =?utf-8?B?YjJ0WGt2dEpDaG5GT1RoSE5VVk4xU29Db29hNkhqdlpGc05kR1YvZmkwN1hC?=
 =?utf-8?B?b0pqR2ZLY0psUEJ3TDhqUlY2eDNVMElvcmxGMzhsM2E2VHE3K2szb0JzR1pU?=
 =?utf-8?B?djgxQjZ6NVZYQkMvb1B0T1E2bi81VFNYaGpnOU5mVXF4SEw2VzRZQzNJTU0y?=
 =?utf-8?B?UmNrQzJQYzF0RkgwMmtCOGxmUXhMM3JGZ25IalY2dEVRa0lwd0loeW5LU3hJ?=
 =?utf-8?B?MXQ3SGx5S2ppTldPaVl2bWVoVE1TM2k1OXFEb3hBTXY2Z0xvY0pMVGtpYkZn?=
 =?utf-8?B?MUVXZFhHVXNLTk1zdjQ5cjg5YXZITXA0UjNsZ0w4b0pHUGVTRGV6d2J3NTR4?=
 =?utf-8?B?RTZ3RVNhNzdnMVNtOU4xSnIvTFI3S1NXc0VUU0NaTnZCcEpzQWZNUmxMbUFY?=
 =?utf-8?B?VEFKTWV6cEZsZU8vUVhtM3RDUUgvR3dRTkpzamcyNnk3eDBxRUQ5OW9RaFdO?=
 =?utf-8?B?Z3IxNVV3VklFcmhPQ1cwckc2TVRvVnptWjE0amQ0WlRYV2lFNlBWcWk5UGZS?=
 =?utf-8?B?b1F0R3d0SGxDZkRGTjg1aXJIa0ZIbGxsREkzeXprQit3SlhpcWFRbWlEb0E5?=
 =?utf-8?B?SVQ0cGNmd3dXM3NqQkhMWmJ3VDdsZ1JTTWFjOFdieHBlRVEzb1NIWENZdy9D?=
 =?utf-8?B?dVFPQ1N3OTdUT1krWThobmN1ZXl0WVFXUktjUWZOa0tDbEFEZVF5bVhwN1BJ?=
 =?utf-8?B?SE5ibXNteDltSGRHUnNITTgwTjkvZnA1b1Fzd1N0RnBpWWRGNHFYSVdpbEZG?=
 =?utf-8?B?WmI1N043UEl1d0ovOG5FYWY3ZG8rY2ZTcVo3RkhoZE5PS0c4NGR0ekhZeTFB?=
 =?utf-8?B?TlZMWFBaczkxUlNkZ3dSWDBQOHE4SEhKRkNzVjVBS211TllLUU8wNDZpZkhL?=
 =?utf-8?B?d0RNTUV1QzRncG5iMnpIaFdDK0ozd2FmM0dzZjZ1aFl5T3dLR0xnYUwxbEhQ?=
 =?utf-8?B?U09nbVZpTitzekJSZElxNEFPdHpIRFN1WEM2NkVRektOOHlRV20wY3N1UnI5?=
 =?utf-8?B?UncrUjUxRkxsMlRrR1ZZK3JmdjlJRUsrVDBUSGdKQm1JUGZoZStBQkRGZXJZ?=
 =?utf-8?B?RDFicGFPbk9HZlpia3JueHBxWkt1d2k1MW53Umd6MmJUblBXT2xHRzBaQ3hy?=
 =?utf-8?Q?LbL7f+vMc/PITVbzpMCVOUVWr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c20502-89fc-4af1-ae47-08dc8f9b19bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:32:29.8882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTjUIraEMDHFBtaDdGew5fKFJWmTiG3cE3nKzZQSiERQ7+UEVX8HgT7mBHqCZA14jNWO2DxaFmd/mypFaeJcHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911


On 6/18/2024 1:44 PM, Philipp Stanner wrote:
> On Mon, 2024-06-17 at 15:33 +0530, Basavaraj Natikar wrote:
>> Add support for AMD AE4DMA controller. It performs high-bandwidth
>> memory to memory and IO copy operation. Device commands are managed
>> via a circular queue of 'descriptors', each of which specifies source
>> and destination addresses for copying a single buffer of data.
>>
>> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>  MAINTAINERS                         |   6 +
>>  drivers/dma/amd/Kconfig             |   1 +
>>  drivers/dma/amd/Makefile            |   1 +
>>  drivers/dma/amd/ae4dma/Kconfig      |  13 ++
>>  drivers/dma/amd/ae4dma/Makefile     |  10 ++
>>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 206
>> ++++++++++++++++++++++++++++
>>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 190 +++++++++++++++++++++++++
>>  drivers/dma/amd/ae4dma/ae4dma.h     |  77 +++++++++++
>>  drivers/dma/amd/common/amd_dma.h    |  26 ++++
>>  9 files changed, 530 insertions(+)
>>  create mode 100644 drivers/dma/amd/ae4dma/Kconfig
>>  create mode 100644 drivers/dma/amd/ae4dma/Makefile
>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
>>  create mode 100644 drivers/dma/amd/common/amd_dma.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c500c0567779..0d222d1ca83f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -947,6 +947,12 @@ L: linux-edac@vger.kernel.org
>>  S:     Supported
>>  F:     drivers/ras/amd/atl/*
>>  
>> +AMD AE4DMA DRIVER
>> +M:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> +L:     dmaengine@vger.kernel.org
>> +S:     Maintained
>> +F:     drivers/dma/amd/ae4dma/
>> +
>>  AMD AXI W1 DRIVER
>>  M:     Kris Chaplin <kris.chaplin@amd.com>
>>  R:     Thomas Delev <thomas.delev@amd.com>
>> diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
>> index 8246b463bcf7..8c25a3ed6b94 100644
>> --- a/drivers/dma/amd/Kconfig
>> +++ b/drivers/dma/amd/Kconfig
>> @@ -3,3 +3,4 @@
>>  # AMD DMA Drivers
>>  
>>  source "drivers/dma/amd/ptdma/Kconfig"
>> +source "drivers/dma/amd/ae4dma/Kconfig"
>> diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
>> index dd7257ba7e06..8049b06a9ff5 100644
>> --- a/drivers/dma/amd/Makefile
>> +++ b/drivers/dma/amd/Makefile
>> @@ -4,3 +4,4 @@
>>  #
>>  
>>  obj-$(CONFIG_AMD_PTDMA) += ptdma/
>> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma/
>> diff --git a/drivers/dma/amd/ae4dma/Kconfig
>> b/drivers/dma/amd/ae4dma/Kconfig
>> new file mode 100644
>> index 000000000000..cf8db4dac98d
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/Kconfig
>> @@ -0,0 +1,13 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +config AMD_AE4DMA
>> +       tristate  "AMD AE4DMA Engine"
>> +       depends on X86_64 && PCI
>> +       select DMA_ENGINE
>> +       select DMA_VIRTUAL_CHANNELS
>> +       help
>> +         Enable support for the AMD AE4DMA controller. This
>> controller
>> +         provides DMA capabilities to perform high bandwidth memory
>> to
>> +         memory and IO copy operations. It performs DMA transfer
>> through
>> +         queue-based descriptor management. This DMA controller is
>> intended
>> +         to be used with AMD Non-Transparent Bridge devices and not
>> for
>> +         general purpose peripheral DMA.
>> diff --git a/drivers/dma/amd/ae4dma/Makefile
>> b/drivers/dma/amd/ae4dma/Makefile
>> new file mode 100644
>> index 000000000000..e918f85a80ec
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/Makefile
>> @@ -0,0 +1,10 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# AMD AE4DMA driver
>> +#
>> +
>> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
>> +
>> +ae4dma-objs := ae4dma-dev.o
>> +
>> +ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> new file mode 100644
>> index 000000000000..958bdab8db59
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> @@ -0,0 +1,206 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD AE4DMA driver
>> + *
>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> + */
>> +
>> +#include "ae4dma.h"
>> +
>> +static unsigned int max_hw_q = 1;
>> +module_param(max_hw_q, uint, 0444);
>> +MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any
>> non-zero value, default: 1)");
>> +
>> +static char *ae4_error_codes[] = {
>> +       "",
>> +       "ERR 01: INVALID HEADER DW0",
>> +       "ERR 02: INVALID STATUS",
>> +       "ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
>> +       "ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
>> +       "ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
>> +       "ERR 06: INVALID ALIGNMENT",
>> +       "ERR 07: INVALID DESCRIPTOR",
>> +};
>> +
>> +static void ae4_log_error(struct pt_device *d, int e)
>> +{
>> +       if (e <= 7)
>> +               dev_info(d->dev, "AE4DMA error: %s (0x%x)\n",
>> ae4_error_codes[e], e);
>> +       else if (e > 7 && e <= 15)
>> +               dev_info(d->dev, "AE4DMA error: %s (0x%x)\n",
>> "INVALID DESCRIPTOR", e);
>> +       else if (e > 15 && e <= 31)
>> +               dev_info(d->dev, "AE4DMA error: %s (0x%x)\n",
>> "INVALID DESCRIPTOR", e);
>> +       else if (e > 31 && e <= 63)
>> +               dev_info(d->dev, "AE4DMA error: %s (0x%x)\n",
>> "INVALID DESCRIPTOR", e);
>> +       else if (e > 63 && e <= 127)
>> +               dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE
>> ERROR", e);
>> +       else if (e > 127 && e <= 255)
>> +               dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE
>> ERROR", e);
>> +       else
>> +               dev_info(d->dev, "Unknown AE4DMA error");
>> +}
>> +
>> +static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q,
>> int idx)
>> +{
>> +       struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>> +       struct ae4dma_desc desc;
>> +       u8 status;
>> +
>> +       memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct
>> ae4dma_desc));
>> +       /* Synchronize ordering */
>> +       dma_rmb();
>> +       status = desc.dw1.status;
>> +       if (status && status != AE4_DESC_COMPLETED) {
>> +               cmd_q->cmd_error = desc.dw1.err_code;
>> +               if (cmd_q->cmd_error)
>> +                       ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
>> +       }
>> +}
>> +
>> +static void ae4_pending_work(struct work_struct *work)
>> +{
>> +       struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct
>> ae4_cmd_queue, p_work.work);
>> +       struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>> +       struct pt_cmd *cmd;
>> +       u32 cridx, dridx;
>> +
>> +       while (true) {
>> +               wait_event_interruptible(ae4cmd_q->q_w,
>> +                                        ((atomic64_read(&ae4cmd_q-
>>> done_cnt)) <
>> +                                          atomic64_read(&ae4cmd_q-
>>> intr_cnt)));
>> +
>> +               atomic64_inc(&ae4cmd_q->done_cnt);
>> +
>> +               mutex_lock(&ae4cmd_q->cmd_lock);
>> +
>> +               cridx = readl(cmd_q->reg_control + 0x0C);
>> +               dridx = atomic_read(&ae4cmd_q->dridx);
>> +
>> +               while ((dridx != cridx) && !list_empty(&ae4cmd_q-
>>> cmd)) {
>> +                       cmd = list_first_entry(&ae4cmd_q->cmd, struct
>> pt_cmd, entry);
>> +                       list_del(&cmd->entry);
>> +
>> +                       ae4_check_status_error(ae4cmd_q, dridx);
>> +                       cmd->pt_cmd_callback(cmd->data, cmd->ret);
>> +
>> +                       atomic64_dec(&ae4cmd_q->q_cmd_count);
>> +                       dridx = (dridx + 1) % CMD_Q_LEN;
>> +                       atomic_set(&ae4cmd_q->dridx, dridx);
>> +                       /* Synchronize ordering */
>> +                       dma_mb();
>> +
>> +                       complete_all(&ae4cmd_q->cmp);
>> +               }
>> +
>> +               mutex_unlock(&ae4cmd_q->cmd_lock);
>> +       }
>> +}
>> +
>> +static irqreturn_t ae4_core_irq_handler(int irq, void *data)
>> +{
>> +       struct ae4_cmd_queue *ae4cmd_q = data;
>> +       struct pt_cmd_queue *cmd_q;
>> +       struct pt_device *pt;
>> +       u32 status;
>> +
>> +       cmd_q = &ae4cmd_q->cmd_q;
>> +       pt = cmd_q->pt;
>> +
>> +       pt->total_interrupts++;
>> +       atomic64_inc(&ae4cmd_q->intr_cnt);
>> +
>> +       wake_up(&ae4cmd_q->q_w);
>> +
>> +       status = readl(cmd_q->reg_control + 0x14);
>> +       if (status & BIT(0)) {
>> +               status &= GENMASK(31, 1);
>> +               writel(status, cmd_q->reg_control + 0x14);
>> +       }
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +void ae4_destroy_work(struct ae4_device *ae4)
>> +{
>> +       struct ae4_cmd_queue *ae4cmd_q;
>> +       int i;
>> +
>> +       for (i = 0; i < ae4->cmd_q_count; i++) {
>> +               ae4cmd_q = &ae4->ae4cmd_q[i];
>> +
>> +               if (!ae4cmd_q->pws)
>> +                       break;
>> +
>> +               cancel_delayed_work_sync(&ae4cmd_q->p_work);
>> +               destroy_workqueue(ae4cmd_q->pws);
>> +       }
>> +}
>> +
>> +int ae4_core_init(struct ae4_device *ae4)
>> +{
>> +       struct pt_device *pt = &ae4->pt;
>> +       struct ae4_cmd_queue *ae4cmd_q;
>> +       struct device *dev = pt->dev;
>> +       struct pt_cmd_queue *cmd_q;
>> +       int i, ret = 0;
>> +
>> +       writel(max_hw_q, pt->io_regs);
>> +
>> +       for (i = 0; i < max_hw_q; i++) {
>> +               ae4cmd_q = &ae4->ae4cmd_q[i];
>> +               ae4cmd_q->id = ae4->cmd_q_count;
>> +               ae4->cmd_q_count++;
>> +
>> +               cmd_q = &ae4cmd_q->cmd_q;
>> +               cmd_q->pt = pt;
>> +
>> +               /* Preset some register values (Q size is 32byte
>> (0x20)) */
>> +               cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
>> +
>> +               ret = devm_request_irq(dev, ae4->ae4_irq[i],
>> ae4_core_irq_handler, 0,
>> +                                      dev_name(pt->dev), ae4cmd_q);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               cmd_q->qsize = Q_SIZE(sizeof(struct ae4dma_desc));
>> +
>> +               cmd_q->qbase = dmam_alloc_coherent(dev, cmd_q->qsize,
>> &cmd_q->qbase_dma,
>> +                                                  GFP_KERNEL);
>> +               if (!cmd_q->qbase)
>> +                       return -ENOMEM;
>> +       }
>> +
>> +       for (i = 0; i < ae4->cmd_q_count; i++) {
>> +               ae4cmd_q = &ae4->ae4cmd_q[i];
>> +
>> +               cmd_q = &ae4cmd_q->cmd_q;
>> +
>> +               /* Preset some register values (Q size is 32byte
>> (0x20)) */
>> +               cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
>> +
>> +               /* Update the device registers with queue
>> information. */
>> +               writel(CMD_Q_LEN, cmd_q->reg_control + 0x08);
>> +
>> +               cmd_q->qdma_tail = cmd_q->qbase_dma;
>> +               writel(lower_32_bits(cmd_q->qdma_tail), cmd_q-
>>> reg_control + 0x18);
>> +               writel(upper_32_bits(cmd_q->qdma_tail), cmd_q-
>>> reg_control + 0x1C);
>> +
>> +               INIT_LIST_HEAD(&ae4cmd_q->cmd);
>> +               init_waitqueue_head(&ae4cmd_q->q_w);
>> +
>> +               ae4cmd_q->pws = alloc_ordered_workqueue("ae4dma_%d",
>> WQ_MEM_RECLAIM, ae4cmd_q->id);
>> +               if (!ae4cmd_q->pws) {
>> +                       ae4_destroy_work(ae4);
>> +                       return -ENOMEM;
>> +               }
>> +               INIT_DELAYED_WORK(&ae4cmd_q->p_work,
>> ae4_pending_work);
>> +               queue_delayed_work(ae4cmd_q->pws, &ae4cmd_q->p_work, 
>> usecs_to_jiffies(100));
>> +
>> +               init_completion(&ae4cmd_q->cmp);
>> +       }
>> +
>> +       return ret;
>> +}
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> new file mode 100644
>> index 000000000000..ddebf0609c4d
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> @@ -0,0 +1,190 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD AE4DMA driver
>> + *
>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> + */
>> +
>> +#include "ae4dma.h"
>> +
>> +static int ae4_get_msi_irq(struct ae4_device *ae4)
>> +{
>> +       struct pt_device *pt = &ae4->pt;
>> +       struct device *dev = pt->dev;
>> +       struct pci_dev *pdev;
>> +       int ret, i;
>> +
>> +       pdev = to_pci_dev(dev);
>> +       ret = pci_enable_msi(pdev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>> +               ae4->ae4_irq[i] = pdev->irq;
>> +
>> +       return 0;
>> +}
>> +
>> +static int ae4_get_msix_irqs(struct ae4_device *ae4)
>> +{
>> +       struct ae4_msix *ae4_msix = ae4->ae4_msix;
>> +       struct pt_device *pt = &ae4->pt;
>> +       struct device *dev = pt->dev;
>> +       struct pci_dev *pdev;
>> +       int v, i, ret;
>> +
>> +       pdev = to_pci_dev(dev);
>> +
>> +       for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
>> +               ae4_msix->msix_entry[v].entry = v;
>> +
>> +       ret = pci_enable_msix_range(pdev, ae4_msix->msix_entry, 1,
>> v);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       ae4_msix->msix_count = ret;
>> +
>> +       for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>> +               ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
>> +
>> +       return 0;
>> +}
>> +
>> +static int ae4_get_irqs(struct ae4_device *ae4)
>> +{
>> +       struct pt_device *pt = &ae4->pt;
>> +       struct device *dev = pt->dev;
>> +       int ret;
>> +
>> +       ret = ae4_get_msix_irqs(ae4);
>> +       if (!ret)
>> +               return 0;
>> +
>> +       /* Couldn't get MSI-X vectors, try MSI */
>> +       dev_err(dev, "could not enable MSI-X (%d), trying MSI\n",
>> ret);
>> +       ret = ae4_get_msi_irq(ae4);
>> +       if (!ret)
>> +               return 0;
>> +
>> +       /* Couldn't get MSI interrupt */
>> +       dev_err(dev, "could not enable MSI (%d)\n", ret);
>> +
>> +       return ret;
>> +}
>> +
>> +static void ae4_free_irqs(struct ae4_device *ae4)
>> +{
>> +       struct ae4_msix *ae4_msix;
>> +       struct pci_dev *pdev;
>> +       struct pt_device *pt;
>> +       struct device *dev;
>> +       int i;
>> +
>> +       if (ae4) {
>> +               pt = &ae4->pt;
>> +               dev = pt->dev;
>> +               pdev = to_pci_dev(dev);
>> +
>> +               ae4_msix = ae4->ae4_msix;
>> +               if (ae4_msix && ae4_msix->msix_count)
>> +                       pci_disable_msix(pdev);
>> +               else if (pdev->irq)
>> +                       pci_disable_msi(pdev);
>> +
>> +               for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>> +                       ae4->ae4_irq[i] = 0;
>> +       }
>> +}
>> +
>> +static void ae4_deinit(struct ae4_device *ae4)
>> +{
>> +       ae4_free_irqs(ae4);
>> +}
>> +
>> +static int ae4_pci_probe(struct pci_dev *pdev, const struct
>> pci_device_id *id)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct ae4_device *ae4;
>> +       struct pt_device *pt;
>> +       int bar_mask;
>> +       int ret = 0;
>> +
>> +       ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
>> +       if (!ae4)
>> +               return -ENOMEM;
>> +
>> +       ae4->ae4_msix = devm_kzalloc(dev, sizeof(struct ae4_msix),
>> GFP_KERNEL);
>> +       if (!ae4->ae4_msix)
>> +               return -ENOMEM;
>> +
>> +       ret = pcim_enable_device(pdev);
>> +       if (ret)
>> +               goto ae4_error;
>> +
>> +       bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
>> +       ret = pcim_iomap_regions(pdev, bar_mask, "ae4dma");
>> +       if (ret)
>> +               goto ae4_error;
>> +
>> +       pt = &ae4->pt;
>> +       pt->dev = dev;
>> +
>> +       pt->io_regs = pcim_iomap_table(pdev)[0];
>> +       if (!pt->io_regs) {
>> +               ret = -ENOMEM;
>> +               goto ae4_error;
>> +       }
> Please note that we are about to deprecate pcim_iomap_regions() and
> pcim_iomap_table().
>
> The details are in this series [1]. Code is currently in this branch
> [2].
>
> That should go mainline in v6.11, hopefully. So you might want to
> consider waiting a bit with your series so you won't end up with a
> deprecated API in your new code?
>
> The new way of coding it would then also be a bit simpler:
>
> pt->io_regs = pcim_iomap_region(pdev, 0, "ae4dma");
> if (IS_ERR(pt->io_regs)) {
>
> We'd just have to make pcim_iomap_region() public for you, since you'd
> be the first external user.
>
> Cheers,
> P.
>
>
> [1] https://lore.kernel.org/all/20240613115032.29098-1-pstanner@redhat.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=devres

Thank you for the info.
I will be updated accordingly in the future once all the changes are available
in the mainline.

Thanks,
--
Basavaraj

>
>> +
>> +       ret = ae4_get_irqs(ae4);
>> +       if (ret)
>> +               goto ae4_error;
>> +
>> +       pci_set_master(pdev);
>> +
>> +       dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
>> +
>> +       dev_set_drvdata(dev, ae4);
>> +
>> +       ret = ae4_core_init(ae4);
>> +       if (ret)
>> +               goto ae4_error;
>> +
>> +       return 0;
>> +
>> +ae4_error:
>> +       ae4_deinit(ae4);
>> +
>> +       return ret;
>> +}
>> +
>> +static void ae4_pci_remove(struct pci_dev *pdev)
>> +{
>> +       struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
>> +
>> +       ae4_destroy_work(ae4);
>> +       ae4_deinit(ae4);
>> +}
>> +
>> +static const struct pci_device_id ae4_pci_table[] = {
>> +       { PCI_VDEVICE(AMD, 0x14C8), },
>> +       { PCI_VDEVICE(AMD, 0x14DC), },
>> +       { PCI_VDEVICE(AMD, 0x149B), },
>> +       /* Last entry must be zero */
>> +       { 0, }
>> +};
>> +MODULE_DEVICE_TABLE(pci, ae4_pci_table);
>> +
>> +static struct pci_driver ae4_pci_driver = {
>> +       .name = "ae4dma",
>> +       .id_table = ae4_pci_table,
>> +       .probe = ae4_pci_probe,
>> +       .remove = ae4_pci_remove,
>> +};
>> +
>> +module_pci_driver(ae4_pci_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("AMD AE4DMA driver");
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h
>> b/drivers/dma/amd/ae4dma/ae4dma.h
>> new file mode 100644
>> index 000000000000..24b1253ad570
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
>> @@ -0,0 +1,77 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * AMD AE4DMA driver
>> + *
>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> + */
>> +#ifndef __AE4DMA_H__
>> +#define __AE4DMA_H__
>> +
>> +#include "../common/amd_dma.h"
>> +
>> +#define MAX_AE4_HW_QUEUES              16
>> +
>> +#define AE4_DESC_COMPLETED             0x3
>> +
>> +struct ae4_msix {
>> +       int msix_count;
>> +       struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
>> +};
>> +
>> +struct ae4_cmd_queue {
>> +       struct ae4_device *ae4;
>> +       struct pt_cmd_queue cmd_q;
>> +       struct list_head cmd;
>> +       /* protect command operations */
>> +       struct mutex cmd_lock;
>> +       struct delayed_work p_work;
>> +       struct workqueue_struct *pws;
>> +       struct completion cmp;
>> +       wait_queue_head_t q_w;
>> +       atomic64_t intr_cnt;
>> +       atomic64_t done_cnt;
>> +       atomic64_t q_cmd_count;
>> +       atomic_t dridx;
>> +       unsigned int id;
>> +};
>> +
>> +union dwou {
>> +       u32 dw0;
>> +       struct dword0 {
>> +       u8      byte0;
>> +       u8      byte1;
>> +       u16     timestamp;
>> +       } dws;
>> +};
>> +
>> +struct dword1 {
>> +       u8      status;
>> +       u8      err_code;
>> +       u16     desc_id;
>> +};
>> +
>> +struct ae4dma_desc {
>> +       union dwou dwouv;
>> +       struct dword1 dw1;
>> +       u32 length;
>> +       u32 rsvd;
>> +       u32 src_hi;
>> +       u32 src_lo;
>> +       u32 dst_hi;
>> +       u32 dst_lo;
>> +};
>> +
>> +struct ae4_device {
>> +       struct pt_device pt;
>> +       struct ae4_msix *ae4_msix;
>> +       struct ae4_cmd_queue ae4cmd_q[MAX_AE4_HW_QUEUES];
>> +       unsigned int ae4_irq[MAX_AE4_HW_QUEUES];
>> +       unsigned int cmd_q_count;
>> +};
>> +
>> +int ae4_core_init(struct ae4_device *ae4);
>> +void ae4_destroy_work(struct ae4_device *ae4);
>> +#endif
>> diff --git a/drivers/dma/amd/common/amd_dma.h
>> b/drivers/dma/amd/common/amd_dma.h
>> new file mode 100644
>> index 000000000000..f9f396cd4371
>> --- /dev/null
>> +++ b/drivers/dma/amd/common/amd_dma.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * AMD DMA Driver common
>> + *
>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> + */
>> +
>> +#ifndef AMD_DMA_H
>> +#define AMD_DMA_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/dmapool.h>
>> +#include <linux/list.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pci.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/wait.h>
>> +
>> +#include "../ptdma/ptdma.h"
>> +#include "../../virt-dma.h"
>> +
>> +#endif


