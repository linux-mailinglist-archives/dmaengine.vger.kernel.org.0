Return-Path: <dmaengine+bounces-10568-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fgfuEdJSDWrAwAUAu9opvQ
	(envelope-from <dmaengine+bounces-10568-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 08:21:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A0C58815C
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 08:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 695EF300E61B
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 06:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BE727B32C;
	Wed, 20 May 2026 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v9zG3vuk"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCAE33B6D9
	for <dmaengine@vger.kernel.org>; Wed, 20 May 2026 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258062; cv=fail; b=so0Tralsak9T0qDKbjFERZ/b/oRue0QAWMgdG+IcRovJ2v4ikyagq5j4upDPQeYMF4uuH+Tp3QilnR8fVcif42g7k4jQ3RuE5AnvsMqjBo17S72580KubNM+KksXLmXYLgq3FySzoNrzE0Vz12X7XZgDnxyWz7m+j5ASLJ+CEdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258062; c=relaxed/simple;
	bh=RjkWeqtG5tb+BZ9K4Ka0a9YLCG4sv4LWXjpEso3G2xU=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=mjWKIsClDkyXBeOSvBjOVvTkfEeuHBMHgPvSymLBX6T+E+WC26HzigX82K7zqk7Ay0NhO80fXylbYJtN3eRU3MlaFDJFP3AaL5ckqnlI2I6LFvU4tckrV8L5mtXVFu17tWqYacCiVkV617+FmQ7MS1/4ES9x4uzLvmtdQBbovKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v9zG3vuk; arc=fail smtp.client-ip=52.101.56.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exFuLsJqsY+mTOF92KBmr8sGVRxzAVSKORkdCTr4OMIHTo6QlZ/dzfVo3Iy5PfrC+e5RLEU84d9QHLRzVFEN838aQfEQ9/14aWJn9gQFLk5YY4aQn7Zj/TEJ29w5jF89z4yq6ZnKafzj3P9xT+U/diDKG4LiP+/JP3EafTgluUSROaY3BrtJuA9xOxoIFjwsEiStdW7FJc1H8kHauLAqhHITfBn8VQuRGjTUf7s5dq5z9QU2S94WilfbctG3U3eGHv8W+6AjCx5Wvs19Qoq7FyPVD2OjiDwRTzJJQpP1Z9zaYFc6SbU+J2VuFzvu0bp45Hp8USyScgM/e+xDBxSE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwLYNMRHErWydzCVXyJyE/x1MioqrY5z+25SUHd/b2A=;
 b=lAGApat8PDIQME2zTe+8cLFZOTUTDpbEyPssRIYzKKk/PZ/Z2Nz1RNKRnbN47t10u/bT/MiqhAa4fq0amD5xuXL0wk+Hj3odpPjZNvlst9Hh4rnA/PNDfIrHc+RTIdjgXxuwAjiTTvrD0IO9T0vZCCzmu/fpfGNjAJUsJ2lSgpU6IS6ioAB9hmN78TDb0Kz3UOpFMr0kMEv9ZEe0s/RWokaKRcNFKr7avRbUqWMKlBScO9DEy/l7vdqov/G8e/rD2OqsP4N5A2lspS6Xdp19I+mRwOy6efNropWsNKukUc0iQmGbTdP6XIhckGPnMCZD2hNDJMqFpNdlvU+vMlSXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwLYNMRHErWydzCVXyJyE/x1MioqrY5z+25SUHd/b2A=;
 b=v9zG3vukQgR6pliBDk5rfMSpSli6xVcV8xAdQaLsoqYl+uLYd3O6Xv8Bur6FRshqGg90yEPJcMR1d8Y19SGs2ceX1HQjjV3OpY+pj4sa0sX3m2E0Iyc86iZ7NNN2/quywmgBBDHxUG3qGKTaascvCB8lbEnoP2115izPsuHnuLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:20:57 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::d735:a4dd:992b:2886]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::d735:a4dd:992b:2886%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 06:20:57 +0000
Content-Type: multipart/mixed; boundary="------------QCgfrrxZq2hwwzY2uh3O6ktk"
Message-ID: <fab85d17-e893-4907-81fa-7f339b872883@amd.com>
Date: Wed, 20 May 2026 11:50:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: Fix device kref underflow in dma_chan_put()
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org,
 logang@deltatee.com
References: <20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com>
 <20260518082920.B9BB1C2BCB7@smtp.kernel.org>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20260518082920.B9BB1C2BCB7@smtp.kernel.org>
X-ClientProxiedBy: PN5P287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:265::7) To BN9PR12MB5259.namprd12.prod.outlook.com
 (2603:10b6:408:100::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5263:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc04df3-52cc-400c-a67e-08deb637eb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|6049299003|366016|4053099003|22082099003|56012099003|4143699003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	XGZmFo1gzKcHYNZce2rzxDMYP3GUpOZ4/Q7/4E3f6QLTPPLnftBZ3YN0FA1gxjjNw2LJC3Dq8haRghN50uDZBzJ0zsbpjPP7gIInTV1FwWJhrh0o+IeqXHsE86Ca/CLo+rQNDVDlwd0pIi6X8gIkzddK3Gd9cgJaPrVdNVZuPWeys8HEL4fL8vGfrDVk5ROjl3KC3LJa0ppsVwLyCerTR7hL55gAeWs+jY+BAE2NXNlsMKo+9j/a6IAp1HxbwLMt3fvTOX+YlVWMp8w39XRamGyZYdPBjOcL4bIn/y9cPoUDLmho6gWHiGT7879D7ptuPi9sEdMvV7303/Dttn+1ZJdM7jC4bMVuFcqxVpJ8RmPEHgcRSL/JFp5IyJ618OjEKQHgjeaf6rJ3yC7L1915xOKQer/qn0l7BpuuMCh218P9EYKxyphrvJJQGE4xR9ttwZmwtbA9rPjAvnyopPiTCb8B0BnwbZ83lES9CuYg6EGvMi42s5JPOHVXDsvRL0RMuPPOogmHnNWsQOxrvvesb2RJ0n7bV29wnGaSIjKzqL3huU4wQmC+o33QojoK690Cp0aXLRWdOlP/YEB7rchi3ur+rGtDXhhhf71Pcsh2wMBrhyEwvIHJ1NxQQSeT//rH1zoLSfsWqiN0Zxa8UkdeDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(6049299003)(366016)(4053099003)(22082099003)(56012099003)(4143699003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkZ0SFJ4WUIrSG1wdmxiSkpibFMrdDM2bnkxM2ExZXpkNEp6bWZpVEk2M1ZN?=
 =?utf-8?B?K29NOFRsYTA4c1QvMExHUzVKRUtzUTBuMjVaenZ0ZU5uR3cxYitYSnFoMyt3?=
 =?utf-8?B?K1dtMnFMREFOalMvcmIvT1VxRm5TajZQU2tjdXJ4VkRBOHA3dE04c1kxNmdT?=
 =?utf-8?B?emFwK3lPRDRqdkYzWmFiMFJORHhaa2RZNGowVmRCOG9JRFdsMkcrQ3lrY2kx?=
 =?utf-8?B?Y1JpT2taa0xVc3BIN0NZUG5qYnpVMUlKVkcxMTZ6a0FhMkU2ZW5oNHBiK2Rw?=
 =?utf-8?B?R0xiRFg3NlFsNlpRM0svc0NvckZzZzNtcWNCWERZcmpRMEFSc0RWUFc2cnhs?=
 =?utf-8?B?ZGtyMUU2aUZwZDVOZVZRS2h1MmdnQ3p3dGI2WDZaSUxrRFVxU2Rxc2VnOXhv?=
 =?utf-8?B?c2hSeVJ3L2dGRFZxeENkYjVuamszRXpqeW9xV0tsNmsrMVdTZjhtcCtrRzlX?=
 =?utf-8?B?Y1NKODhIRUVMSVVQL0MwRGg3ZDdESklpU3BrZCtrdlpCRi9RVnJXVjV6Nysx?=
 =?utf-8?B?bXY0SVF3Y0xWM0Fmd0hqZEFEdlM5cDBSQk9UV3UwOXVNVWExeVVFbmpzNUVE?=
 =?utf-8?B?ZFRuakgvTVYyRkswdnNMSEpGc05vK2VuQlBwaW5VWDk5VmJFWXJjRlU0OXBt?=
 =?utf-8?B?MzRFN0RmZWdFMHFmSGNPT2I5YkJZdUk1NnZpWDA3eGR0RDhSUUpXSWRlOFgw?=
 =?utf-8?B?OG12bjN3Z3hyUWQwM0RpdnErdEhiQ1FaVVczb092U2Q2WjI4UmZWcGIyUDIw?=
 =?utf-8?B?SlE2a2pyL0h4RXBQNEdzbWVkbGViaU5sV2o2THBXMEFST25ETDdPcEJrZTI5?=
 =?utf-8?B?UWJQVW4zQ3NzU1FEaGlmRnRtVkdVSXZwTjBFcWgyL3ZyUDlWSTR2ajdNbDhD?=
 =?utf-8?B?TWtibUZSVGlkTUQ0eFRBdFZKdlVFOFJyWjNzT1hUSDg1Z2crTVJYN2pyelNj?=
 =?utf-8?B?eTR4a1BzbXEzYWE0SWJGcjY1OEdTQWxpaEpZeFB4UVp1UjJoRHFFQ3hyVTBx?=
 =?utf-8?B?Y2ZKMElOR2dQcnFmc1VWNmhJYVFOYjFjZDZ1WEE0eXUrYlMwMDg4QW5SMzky?=
 =?utf-8?B?N2RzV2ZSbGU2YjlQZ09MSk9MZlBEWGpYOTZOV3FXZHY0TXFDaUU0NWFKYmF5?=
 =?utf-8?B?citoNHk3VkliM3FacHNNd0NaNVpnUnB6cHhqTzZoQndEb2QvZHY1SVVQYXhy?=
 =?utf-8?B?dk1XUXRmNnovS0x4ODdJd0psajFVRTJ4aEFLTjFjTWZnZkV1L0YzNHF3SUF0?=
 =?utf-8?B?eW5rQkxzc0RCSldIT3kwV1pGelE4ei9TVVhzckRlRHNML3pjcTVVR3NtdjBU?=
 =?utf-8?B?Q1pvQXRSUFBXQWNySlcyRHdHTW5vYkFaV2JtNGUzMnpmUlRBSE5wRFEvdHBi?=
 =?utf-8?B?bUNrTWxjQlFtRjgxU0VBSXpDQ0lrMGZxZWF0VnpRd080WXBBSUNMcjhFbEll?=
 =?utf-8?B?WEZXTjR1VDg2ZU1id1Q4Si9kODlIMU1zd1d3emRiOEdFTXZYaUhBZnR5alli?=
 =?utf-8?B?WitZcEwyaWxTQXVPUk1xWFZuYmpvUlA4Ky9NbHcxcUtRRHpza1AxaUNNZzla?=
 =?utf-8?B?SmlPa1JRYlRvcG5kQlpwSUJmUVBFMXlVZHR3WUpHUU5pekxkV2pQOVBGQ2Rn?=
 =?utf-8?B?N0Y1d1dvbWdzSXpmYkNyYUFDVktBSjBBL3N2TkxCTkpJM0pHdElOb0J4ZDZv?=
 =?utf-8?B?eWZ3elZWV2FxSDJGTlEwZWpGY3pvN1hBLy8xdytWWnozdmp3REFnUjVJVUly?=
 =?utf-8?B?SWhjQVRZMDVRSjFQb2J3RTQzb1NUbEJQLzJIbmFCbmp0QktZclNhL1gxY3Jl?=
 =?utf-8?B?ZmVhVkhuVEt6ZnBzYnVIVUNTM2MrTVgzNW5CMTNab0Y1eDhFSEwzT0hEc3or?=
 =?utf-8?B?R3hyMEFHU3pHMTJ2NlJ0VDBuYmwxWG1wcENKTThoTFlCME94WE43S1Ztc1g5?=
 =?utf-8?B?N0JzbzZQR0pjVVYyMGdSc3ZhdHNUdWVsN1ZtV24wTVYzcnZOV1dVMGNwbXhC?=
 =?utf-8?B?Yzd0dUpKM1dBVGtRWTRvTHczK3ZBazdHVEMvc1RWanV2SytmWFdkdW9BWGhQ?=
 =?utf-8?B?YktCNFhBMXE2VllHOUlhaDNwQmE2S1F5Y1krczJZY2ZaMDkxZ05OM2VYaURJ?=
 =?utf-8?B?MVZ5ZEJWN3BXM3haMGZIOXJuSmhwejhzYkZhczErQklNNG9jaUFyNFRoNVdP?=
 =?utf-8?B?RXZ0R3pSbVQ5d1NObCs1a2N3MTJ5QzlKaTVoYWdDQVpBdWhVUGd1RWgyRHpz?=
 =?utf-8?B?a2ZXL0txZ2h5UFYzNnQyV21yc0pBcEJDL3AwVTZDdUdYN0RNcVRiUlBFY1gr?=
 =?utf-8?B?b3VjMHp0bk84ZEtvMFpzaXdDTXNLQ3FROGNCR2FBazV4UEVKTUwrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc04df3-52cc-400c-a67e-08deb637eb4a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:20:57.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sW7bmW1kfExUp3vP9qX2G8BT4bLuBRHKYO7KpBKhoBKkCSho9TfFxyFmEI3mxgeObGFwuAYtSIqLQA1T27ex+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10568-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivankg@amd.com,dmaengine@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 90A0C58815C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--------------QCgfrrxZq2hwwzY2uh3O6ktk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/18/2026 1:59 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Pre-existing Use-After-Free vulnerabilities in dma_chan_put() and dma_release_channel() due to device memory release before teardown completes.
> --
> 
> commit dcce1cbcc027c7a50b03bed56fe875a7390be677
> Author: Shivank Garg <shivankg@amd.com>
> 
> dmaengine: Fix device kref underflow in dma_chan_put()
> 
> This commit addresses a device kref underflow by ensuring the device reference
> is only dropped when the client count reaches zero, matching the slow-path get.
> 
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -515,7 +515,9 @@ static void dma_chan_put(struct dma_chan *chan)
>>               chan->route_data = NULL;
>>       }
>>
>> -     dma_device_put(chan->device);
>> +     /* This channel is not in use anymore, drop the device ref */
>> +     if (!chan->client_count)
>> +             dma_device_put(chan->device);
>>       module_put(dma_chan_to_owner(chan));
>>  }
> 
> This isn't a bug introduced by this patch, but does this sequence present
> a use-after-free risk?
> 
> If dma_device_put() drops the final reference to the device (for example,
> if the provider module previously unregistered the DMA device), it can
> trigger the device release callback and free the dma_device and dma_chan
> memory.
> 
> If that happens, module_put(dma_chan_to_owner(chan)) will dereference the
> freed memory, as dma_chan_to_owner() accesses chan->device->owner.
> 
> Additionally, when dma_chan_put() is called from dma_release_channel(),
> returning from this function leads to further accesses of the freed memory.
> dma_release_channel() continues to access chan->device->privatecnt,
> chan->device->cap_mask, chan->slave, and chan->name, which could cause a
> series of use-after-free issues during teardown or hot-unplug.
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com?part=1

Attached the patch addressing the Sashiko reported issues for additional review
comments before sending out v2.

Thanks,
Shivank
--------------QCgfrrxZq2hwwzY2uh3O6ktk
Content-Type: text/plain; charset=UTF-8;
 name="0001-dmaengine-fix-use-after-free-in-dma_chan_put-and-dma.patch"
Content-Disposition: attachment;
 filename*0="0001-dmaengine-fix-use-after-free-in-dma_chan_put-and-dma.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjMDJjZThjNjFhY2M0YTJmNGUyYzlmMDliZDE2ODFjNzJhOThjNGExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaGl2YW5rIEdhcmcgPHNoaXZhbmtnQGFtZC5jb20+CkRhdGU6
IE1vbiwgMTggTWF5IDIwMjYgMTE6NDk6MDkgKzAwMDAKU3ViamVjdDogW1BBVENIXSBkbWFlbmdp
bmU6IGZpeCB1c2UtYWZ0ZXItZnJlZSBpbiBkbWFfY2hhbl9wdXQoKSBhbmQKIGRtYV9yZWxlYXNl
X2NoYW5uZWwoKQoKV2hlbiBkbWFfZGV2aWNlX3B1dCgpIGRyb3BzIHRoZSBsYXN0IHJlZmVyZW5j
ZSBvbiBjaGFuLT5kZXZpY2UtPnJlZiwKZG1hX2RldmljZV9yZWxlYXNlKCkgcnVucyBhbmQgbWF5
IGZyZWUgdGhlIGRtYV9kZXZpY2UgYWxvbmcgd2l0aCBpdHMKY2hhbm5lbHMuCgpUd28gcGF0aHMg
c3RpbGwgcmVhZCB0aGF0IG1lbW9yeSBhZnRlciB0aGUgcHV0OgogLSBkbWFfY2hhbl9wdXQoKSBy
ZWFkcyBjaGFuLT5kZXZpY2UtPm93bmVyIHZpYSBkbWFfY2hhbl90b19vd25lcigpCiAgIGZvciB0
aGUgdHJhaWxpbmcgbW9kdWxlX3B1dCgpLgogLSBkbWFfcmVsZWFzZV9jaGFubmVsKCkgY2FsbHMg
ZG1hX2NoYW5fcHV0KCkgZmlyc3QsIHRoZW4gcmVhZHMKICAgY2hhbi0+ZGV2aWNlLT5wcml2YXRl
Y250LCBjaGFuLT5zbGF2ZSwgY2hhbi0+bmFtZSBhbmQKICAgY2hhbi0+ZGJnX2NsaWVudF9uYW1l
LgoKS0FTQU4gY2F0Y2hlcyB0aGUgZmlyc3Qgb25lOgoKCXNsYWItdXNlLWFmdGVyLWZyZWUgaW4g
ZG1hX2NoYW5fcHV0KzB4M2U2LzB4NGMwCglSZWFkIG9mIHNpemUgOCBieSB0YXNrIGluc21vZC82
MzE5CglGcmVlZCBieSB0YXNrIDYzMTk6CgkgIGtmcmVlKzB4MjI1LzB4NDcwCgkgIGRtYV9jaGFu
X3B1dCsweDM5NS8weDRjMAoJICBkbWFlbmdpbmVfcHV0KzB4ZjgvMHgxNjAKCkNhY2hlIHRoZSBt
b2R1bGUgb3duZXIgaW4gZG1hX2NoYW5fcHV0KCkgYmVmb3JlIHRoZSBwdXQgc28gdGhlIHRyYWls
aW5nCm1vZHVsZV9wdXQoKSBkb2VzIG5vdCBuZWVkIGNoYW4tPmRldmljZS4gSW4gZG1hX3JlbGVh
c2VfY2hhbm5lbCgpLCBtb3ZlCmRtYV9jaGFuX3B1dCgpIHRvIHRoZSBlbmQsIGFmdGVyIGV2ZXJ5
IGNoYW4vZGV2aWNlIHJlYWQuCgpGaXhlczogOGFkMzQyYTg2MzU5ICgiZG1hZW5naW5lOiBBZGQg
cmVmZXJlbmNlIGNvdW50aW5nIHRvIGRtYV9kZXZpY2Ugc3RydWN0IikKU3VnZ2VzdGVkLWJ5OiBT
YXNoaWtvIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPgpMaW5rOiBodHRwczovL3Nhc2hpa28uZGV2
LyMvcGF0Y2hzZXQvMjAyNjA1MTgtZG1hZW5naW5lLWtyZWYtZml4LXYxLTEtNGQ2MTI1MDQ4ZmI3
QGFtZC5jb20KU2lnbmVkLW9mZi1ieTogU2hpdmFuayBHYXJnIDxzaGl2YW5rZ0BhbWQuY29tPgot
LS0KIGRyaXZlcnMvZG1hL2RtYWVuZ2luZS5jIHwgNyArKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1h
L2RtYWVuZ2luZS5jIGIvZHJpdmVycy9kbWEvZG1hZW5naW5lLmMKaW5kZXggNjA1YmZhNDc3YTAw
Li45YzRlMjA2ZjI0NjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZG1hL2RtYWVuZ2luZS5jCisrKyBi
L2RyaXZlcnMvZG1hL2RtYWVuZ2luZS5jCkBAIC00OTUsMTAgKzQ5NSwxMyBAQCBzdGF0aWMgaW50
IGRtYV9jaGFuX2dldChzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4pCiAgKi8KIHN0YXRpYyB2b2lkIGRt
YV9jaGFuX3B1dChzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4pCiB7CisJc3RydWN0IG1vZHVsZSAqb3du
ZXI7CisKIAkvKiBUaGlzIGNoYW5uZWwgaXMgbm90IGluIHVzZSwgYmFpbCBvdXQgKi8KIAlpZiAo
IWNoYW4tPmNsaWVudF9jb3VudCkKIAkJcmV0dXJuOwogCisJb3duZXIgPSBkbWFfY2hhbl90b19v
d25lcihjaGFuKTsKIAljaGFuLT5jbGllbnRfY291bnQtLTsKIAogCS8qIFRoaXMgY2hhbm5lbCBp
cyBub3QgaW4gdXNlIGFueW1vcmUsIGZyZWUgaXQgKi8KQEAgLTUxOCw3ICs1MjEsNyBAQCBzdGF0
aWMgdm9pZCBkbWFfY2hhbl9wdXQoc3RydWN0IGRtYV9jaGFuICpjaGFuKQogCS8qIFRoaXMgY2hh
bm5lbCBpcyBub3QgaW4gdXNlIGFueW1vcmUsIGRyb3AgdGhlIGRldmljZSByZWYgKi8KIAlpZiAo
IWNoYW4tPmNsaWVudF9jb3VudCkKIAkJZG1hX2RldmljZV9wdXQoY2hhbi0+ZGV2aWNlKTsKLQlt
b2R1bGVfcHV0KGRtYV9jaGFuX3RvX293bmVyKGNoYW4pKTsKKwltb2R1bGVfcHV0KG93bmVyKTsK
IH0KIAogZW51bSBkbWFfc3RhdHVzIGRtYV9zeW5jX3dhaXQoc3RydWN0IGRtYV9jaGFuICpjaGFu
LCBkbWFfY29va2llX3QgY29va2llKQpAQCAtOTA3LDcgKzkxMCw2IEBAIHZvaWQgZG1hX3JlbGVh
c2VfY2hhbm5lbChzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4pCiAJbXV0ZXhfbG9jaygmZG1hX2xpc3Rf
bXV0ZXgpOwogCVdBUk5fT05DRShjaGFuLT5jbGllbnRfY291bnQgIT0gMSwKIAkJICAiY2hhbiBy
ZWZlcmVuY2UgY291bnQgJWQgIT0gMVxuIiwgY2hhbi0+Y2xpZW50X2NvdW50KTsKLQlkbWFfY2hh
bl9wdXQoY2hhbik7CiAJLyogZHJvcCBQUklWQVRFIGNhcCBlbmFibGVkIGJ5IF9fZG1hX3JlcXVl
c3RfY2hhbm5lbCgpICovCiAJaWYgKC0tY2hhbi0+ZGV2aWNlLT5wcml2YXRlY250ID09IDApCiAJ
CWRtYV9jYXBfY2xlYXIoRE1BX1BSSVZBVEUsIGNoYW4tPmRldmljZS0+Y2FwX21hc2spOwpAQCAt
OTI0LDYgKzkyNiw3IEBAIHZvaWQgZG1hX3JlbGVhc2VfY2hhbm5lbChzdHJ1Y3QgZG1hX2NoYW4g
KmNoYW4pCiAJa2ZyZWUoY2hhbi0+ZGJnX2NsaWVudF9uYW1lKTsKIAljaGFuLT5kYmdfY2xpZW50
X25hbWUgPSBOVUxMOwogI2VuZGlmCisJZG1hX2NoYW5fcHV0KGNoYW4pOwogCW11dGV4X3VubG9j
aygmZG1hX2xpc3RfbXV0ZXgpOwogfQogRVhQT1JUX1NZTUJPTF9HUEwoZG1hX3JlbGVhc2VfY2hh
bm5lbCk7CgpiYXNlLWNvbW1pdDogMDc1MDcyYjhmMDRlZDg5N2RkYzA3OWYwMDA1ZjE1ZmQ1Nzk3
ZWRmOAotLSAKMi40My4wCgo=

--------------QCgfrrxZq2hwwzY2uh3O6ktk--

