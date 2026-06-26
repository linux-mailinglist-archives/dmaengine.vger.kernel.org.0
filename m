Return-Path: <dmaengine+bounces-11814-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B9IBK0RYPmrPEAkAu9opvQ
	(envelope-from <dmaengine+bounces-11814-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 12:45:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BC06CC283
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 12:45:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=q04a+FNj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11814-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11814-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC9CF3006D68
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AAB3EF644;
	Fri, 26 Jun 2026 10:45:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241E43EF0A4
	for <dmaengine@vger.kernel.org>; Fri, 26 Jun 2026 10:45:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470719; cv=fail; b=TVp3cfcesIRGhuryO11FC4qYBoLpxB+xGJr11wz5aMnlubcS740/O7d8qY5kOIvZakskoNIzZWRKAL2X38YvSF2LaeOU7SnHEPuFrHC0diiHOvnIEzWNejmllOvzm+/Xntxh123OKEfXrmL8k8Z6OABKV54OIf2PKVy10gPpLN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470719; c=relaxed/simple;
	bh=Yv6WOYGAL0bqx9LkSV79iWGAb9CT3hxv9YOn+PIvCJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cIqaPwPAYN0QYqp3+3hUtCAeOMAotc4eXooUvTyqM69bcZY9P2474+qST5VTGCf+MnMPmvGyMEm5cHujUfpcCSn37Ih/VbBsKvDhwnrDBVnVAn8pUhMNSR7CywjK93SaWNJtw+rZgtiQgmmEJGYPjN5+2UR7LPZKTpri1lMVI7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q04a+FNj; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0Es3pXulUSfzDBKIo7xOcvPzyzL4aSPU31pZ9Ou0u52+HRN/tFQaVYOQMvSxXJPdCuGh0treNw/kLUpJIjjK7CQ+8ApaRUC+CjiyMoVxcx0RkBHaIMRamVYbOop6ae6ymO8Ytp8e0aB9l+4G8RHKQH1+jVjDdrGAaWz0ogDYxN5qYS/jxFNn7/SCzQaGeAayhjUNI2Rd8dpZdZOWdOJlBbr+orAxPYbD4SQRRl4ossDTYe5bkUs2MRrWzDQinitvfgrWAlL4jUPwMYn8sqYNa7oRLrChtFE4GgegMbDo9c0it8QPy+WZuffTc7ActtPW/iPbJJBL4YgTzIU5/VYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B8F9JvYNBKxZg/U5T8n56xgO3YGNjHIl7gdIYknp68=;
 b=mTIHcMs6AYfpDxTVvoLV5MB3yh1LP3cx4bpnwsXs76mG1jmggBY29MuFLCt3Wm3nn3f8Wb6RXnKRTHgGYBsqZg/v6fYj3NYkhcV5x2qGVQBjs5ow4kdd9U6Crra2CCGGvk7ucn43TYZVnbyIblU00kJXzNg8KU/ZqAS8+H1/vf6aBdmUnm6nlNmedSOfqyXKBEQvwncZU+4EwTBxCAtHQKtifxE/AYdCXr1WjDfPo3i6I4Mo+iGi+F0QJxcFjZCiY4juiLFuLCPZlPir1LVONcC1GbmndlI49Xr9MH1xUf6rR2YGCbgsTFHUKXwHz9Fl/68Tw8w/pLFgZNfPe58H3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B8F9JvYNBKxZg/U5T8n56xgO3YGNjHIl7gdIYknp68=;
 b=q04a+FNjblj/61jzipCAsCGsjx/8TcficpEpM94jes1hY8YLBiF3mtzz9NxBXKUiJYMH7Ddlk1eRrEXWm2rnoqJZ4qDF5YUhE/6soQMuu96UhlccqH3D7XubepHRTRJjjmhPle0ycGAXtR0ZKa61HFH80EbGLs++F++LxnZ8DQk=
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 26 Jun
 2026 10:45:12 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%2]) with mapi id 15.21.0159.012; Fri, 26 Jun 2026
 10:45:12 +0000
Message-ID: <cc79a319-ced7-4270-80d4-13e8cb20895f@amd.com>
Date: Fri, 26 Jun 2026 16:15:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dmaengine: xilinx_dma: Enable transfer chaining
 for AXIDMA and MCDMA by removing idle restriction
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
References: <20260626092656.1563871-1-suraj.gupta2@amd.com>
 <20260626092656.1563871-3-suraj.gupta2@amd.com>
 <20260626094826.3CF8A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <20260626094826.3CF8A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0078.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25c::14) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcd8a32-ba81-48f2-b760-08ded3700047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	RyBvWmos2eJWzCPWw4vSa3ZVsHXC0E5BRi0dFGyDKTXkGIjHf3GS0YgmQLPFU4ebv6xiEtKe02G+pMAVlzl6a4kuzuRgsd3H5yNKu3GDFYjS9yPv53SvY/Ob+RtSEQWltm1JSczp719+E43U97nJHxi0TLtkIodwZydRZYkCqSnStFSuOHu4sj81QZ11zN0UKngiEdQ10/YYq2cZGEJyBJrn1FjMGvYsv3F6FdkskcDH5y8OUF08Fwz+CB8j4Gduxl8KcwPf5KJlnPRObbc0DdC9XDjRGHuV9ogZ2mnAd7cKMRRsfAWcyFyqy77Sq1urs8VdutjNqPFrNJgOAKqpvwvARlBv2nwZ+Y+JSn+/xPfVE0QoE2Klt0R3nvvM4a/rl60NqYXIh52JFHdyEsLPPXlSSp50H5OWASt4VhyDvvaP9m40kck/ddjXnXKB5JHAO7bc7R2bFB0TKfANh/8/u2pVArGs5z0TfD/XEp7snF5boSht+aFkZ/PDK6tYYyS8NQVObC+lAk+yJDnGhrnzBTfRyigLAmFeH9UAdXBXGaVXv2Se/aVwvodGn4XrcZjn7wFOPSbBZeH+0HI5EhZCXPIkgg+ZHQsXDlqBAoi0q3c0orbE8GBsyAopYNLyfGAyzkaxdufKVuInV+PjgLQLZBcPDLHGYDQMrUACu8CTZbE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXQrK3VYRHRPcENkUGhBekJKVDV2WlhMTyt6MGlLN0x6SHZ5cnVCeDlTdnFm?=
 =?utf-8?B?N0ZPZmJjVDJOU2U3c3J3SzI1cjhKQ0E3Y2FYMUZEK2lKTW1IdXp2TFVwaUtv?=
 =?utf-8?B?OTYrMmU5b0hQeEw0R21zL2lsYmZVOTlFRWE5ZmRNVnFsaUs3ZDQyU1lSbFoz?=
 =?utf-8?B?d1o0eDFCU0xhM2RGVERPU24zMUFabGVOd1pxZHVKMSt6T0ZUTlh4NkhwRmUx?=
 =?utf-8?B?TlNQcFRhWnM5d0ZteDIzaGhoM3g2cTNHdEVpT3BUbWgxeEdPVnJqMmR6N0JF?=
 =?utf-8?B?QnY1Vll5MjNXaHdFN3ljZER2WWltMFdHQUQxR3RjYVdETEdSQXIwM1NTK1Za?=
 =?utf-8?B?aDRjbHVIWlBQQUdUczhFa3dYUnhFczNmeUR5MFpRSUt6SW53MldTK2d1NTRv?=
 =?utf-8?B?YVdOT1JXWXNPUUFmRXduN1RwT3FnSzR3RzNFUWpBeDRWRzNwdjNqRGc2VVFm?=
 =?utf-8?B?V2xnUjZGT1VsM0Z2dXFoRm5JckJpeE9YdnZ4cS8wdE5abEpiMzB2ZGlPOGlP?=
 =?utf-8?B?TEs2a1hyVy91bmFvR29uRGg3RzVQeWEwWTlVMVZ4Y09tZjdhUUpJM2tuVWY4?=
 =?utf-8?B?N01EdmFCMlpoSEo0OTFQbERHYjN0K3F4ZkJjUXhJazc4YVpoRUVLM2JvTFlL?=
 =?utf-8?B?bDVmOGYvUDlENGpZQVN6QmpNUWlKZDBIUmxIZkNpSHpySldwL2Y3ZXNJVGRX?=
 =?utf-8?B?bFV3dXMxUStWTUJyeXhidWx4OWlJc1pkQVlvR0szYnFacSttZXFRUGFwRGNG?=
 =?utf-8?B?Nk93d1hrZis5Qy9STER3ellQQWJwK3pqL1RpeG1jTndnMU5vc3RXRlFZWjhY?=
 =?utf-8?B?WUVlYVAzOFpuSHpjNGpjSmh1VGg5Qk9OZitHR3B4OUhPSnFRUDFUVzhlZzZC?=
 =?utf-8?B?VnlISkdIektHNC8rbWNDWGpFbXZvQklDbndGT0VrdzhQTkNQc0xLZVFOV1pH?=
 =?utf-8?B?S1VId1VuakFMQWhhcktiQUZwOS80aFRkZTdiUTdNNjVvY3NUMkttcWY0cE5O?=
 =?utf-8?B?WGdiMjdsZnE2NWxvdFVmTmdES052a2cxbkU1RGV1QmNkcXZHRHpDRTd6bmNY?=
 =?utf-8?B?WW83dGhuQjF0WHV3dEl3OTJ2Ymx1QkhDR1JXcE9ZcWg5dkZpdkxpTC9LYnlG?=
 =?utf-8?B?eWQyM1NHRWJFWTdNaEFQRGhWS2FvWUR2SXl2bCtMdEp3RGRaVG1CR01qQ3ls?=
 =?utf-8?B?TDN5bHJnOUxlZW8ybjZ0aG9GQytXUXJpbXdsWk5WMEtOSDV0K3VMTk1VeVBv?=
 =?utf-8?B?b1pDLy9Jc1BnQXVLRzhMb1BidTRnSXIvQmttZk43ZCtvcVlzWTZ2amVmNGZM?=
 =?utf-8?B?alMxSVpFOExVOXlhNGlicnU3MitaZ0ttUVFXZEMxYnFUN3B4Rzh5clRNT0cz?=
 =?utf-8?B?bG8yMzhXaTJCWHYyNE5FRW9LQUFkVHk5anYwcVZIRWo3YWw0TzVPZFhLTHNH?=
 =?utf-8?B?M1ZYSXQ2eFF5a0VNVVA3SnZZMllVZWxMYm1OS1o5YXJ3WCtWanE5Qzc5S0NX?=
 =?utf-8?B?MzdlZU9TcGc0WnNmd3kwOU9OTHMrNDI5RFFiS1kzR3RNcnZZVW10SzUrTFdj?=
 =?utf-8?B?dVFMWlNwT2ZTemZCWUpLUDIrRkErYnFMUGwrTW41cThmc2ZpRFVjbHdkbG9E?=
 =?utf-8?B?ak56VUM1SkxKVUJpK1FOMlY1a05JL1hxM2NZRTZlZkprS1RlczhqNDZpUjkz?=
 =?utf-8?B?NndMT08rYjlwZkNuUVZ1SWFtTGZLc25OUFJSbk0yZ2JFN29VQmxrVnMwUzNM?=
 =?utf-8?B?aFkvelN6RUcrQlNERXpvcmZ6WCtrVXFSbHBodzFBNmVhYWMxdFF2QmlScmxY?=
 =?utf-8?B?NWJCVSswa1lhdVE0QmhiQVRhMHpGajlnK1duWHZHeXpWaHBxTjAzOWZLZXM2?=
 =?utf-8?B?dlIrM0ZDYUhoenBGaThZQ0lXdnh4Qzc2K1NHZm9lL012UzZvaTMvaVNPZ01K?=
 =?utf-8?B?WkVhMVJqV3FCMll1cWZ3c3RLR25UWkZZWGhXdWZZRm4xWks4VGkrSERQYmlw?=
 =?utf-8?B?M1VUQk95Mk5uVG5CcDh3S3JsQkNzYUIvYS9TL2Q4bW9PM0huRmt4c0RxVktN?=
 =?utf-8?B?TzVVd294bTVGdUlrNnV0Y01TY05QOXFJb2k1aE5STWV6K1doRzFQbzFqK3Jx?=
 =?utf-8?B?dEJCODhSNDZlNkFOeVBvckR2NDIxc0M2cFFlb0NNQUxpc0Y2R0xKeHpCRnBw?=
 =?utf-8?B?WkR3RDR2bm9EMjc4R2M2WUlFU1RWMlpGNmJYRmd5NHpHSk0wS1BqMDF1bTVy?=
 =?utf-8?B?ZlVNbGNCRGxiT1FRSUo0ZDJQUE94RzFsRlZ2c1JnSjlRRSs3RElwMFB2eG5O?=
 =?utf-8?B?ZmtnUVZSSlpieVlXY2NBS1JXOUpZbm1wVFpFSkp6OGJTUzdMMlMxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcd8a32-ba81-48f2-b760-08ded3700047
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:45:12.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0CfTsmmvqn2GpYBVfUhR89CkYJpBhZI+DHo8PjE+4n/vnX20WwNgf0VPG5pRNN4rjqimUA04gwrE2eHe8TgZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11814-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0BC06CC283



On 6/26/2026 3:18 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Bypassing the idle check allows new descriptors to be appended to a running transfer, but the driver fails to link the active transfer's hardware `next_desc` pointer to the newly appended descriptors, leading to wild DMA fetches.
> - [High] Overwriting the DMA Coalesce Threshold register while a channel is running resets the hardware coalescing counter, causing the channel to stall indefinitely.
> --

I replied for same comments in V2 here:

https://lore.kernel.org/all/0f00a643-8aa0-48c0-b6e8-d1956e623cc4@amd.com/

Regards,
Suraj

> 
> commit 06494ab31953d1c39c050abca192d725ee06375d
> Author: Suraj Gupta <suraj.gupta2@amd.com>
> 
> dmaengine: xilinx_dma: Enable transfer chaining for AXIDMA and MCDMA by removing idle restriction
> 
> This commit relaxes the idle checks in xilinx_dma_start_transfer() and
> xilinx_mcdma_start_transfer() to allow scatter-gather transfers to be chained
> onto an in-flight transfer. It relies on the hardware tail pointer extension
> mechanism to handle chaining automatically.
> 
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index ca396b7097427..6e7b183cb4994 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -1580,7 +1580,14 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>>   		return;
>>   	}
>>   
>> -	if (!chan->idle)
>> +	/*
>> +	 * Direct (non-SG) mode has no descriptor queue: writing the BTT
>> +	 * register launches a transfer immediately, so a new transfer must
>> +	 * not be programmed while one is in flight. Keep such transfers
>> +	 * serialized. SG mode supports chaining onto a running transfer via
>> +	 * tail-pointer extension, so it is allowed to proceed when busy.
>> +	 */
>> +	if (!chan->has_sg && !chan->idle)
>>   		return;
> 
> [Severity: Critical]
> Does bypassing this idle check for SG mode result in wild DMA fetches when a new
> transfer is queued on a busy channel?
> 
> If a new transfer is queued while the channel is busy, the pending_list will
> be empty when processed by append_desc_queue():
> 
> drivers/dma/xilinx/xilinx_dma.c:append_desc_queue() {
>      ...
>      if (list_empty(&chan->pending_list))
>          goto append;
>      ...
> }
> 
> Because of this, append_desc_queue() explicitly skips hardware chaining entirely
> and fails to link the active transfer's tail descriptor to the newly submitted
> descriptor.
> 
> Since out-of-order frees can scramble the ring at runtime, won't the hardware
> finish the active transfer and follow a stale next_desc pointer to an unrelated,
> uninitialized, or freed descriptor segment?
> 
> [ ... ]
>> @@ -1599,7 +1606,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>>   		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>>   	}
>>   
>> -	if (chan->has_sg)
>> +	if (chan->has_sg && list_empty(&chan->active_list))
>>   		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
>>   			     head_desc->async_tx.phys);
>>   	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
> 
> [Severity: High]
> Does updating the Coalesce Threshold register while a channel is running stall
> the channel indefinitely?
> 
> Just before this CURDESC check in xilinx_dma_start_transfer(), the threshold
> is updated:
> 
>      if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
>          reg &= ~XILINX_DMA_CR_COALESCE_MAX;
>          reg |= chan->desc_pendingcount <<
>                    XILINX_DMA_CR_COALESCE_SHIFT;
>      }
>      ...
>      dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>      
> According to the Xilinx AXI DMA specification (PG021), writing this threshold
> automatically resets the hardware coalescing counter to zero.
> 
> If there are already active transfers running, writing the new threshold will
> reset the counter. As a result, the total number of remaining transfers
> (active + pending) will no longer align with the new threshold multiple. The
> hardware will finish the transfers and stop with a counter value strictly below
> the threshold, never triggering the completion interrupt.
> 
> [ ... ]
>> @@ -1685,8 +1689,9 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
>>   	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
>>   
>>   	/* Program current descriptor */
>> -	xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
>> -		     head_desc->async_tx.phys);
>> +	if (chan->has_sg && list_empty(&chan->active_list))
>> +		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
>> +			     head_desc->async_tx.phys);
>>   
>>   	/* Program channel enable register */
>>   	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHEN_OFFSET);
> 
> [Severity: High]
> This appears to introduce the same coalescing regression as seen in
> xilinx_dma_start_transfer().
> 
> Earlier in xilinx_mcdma_start_transfer(), the CR register is overwritten
> with the new pending count:
> 
>      if (chan->desc_pendingcount <= XILINX_MCDMA_COALESCE_MAX) {
>          reg &= ~XILINX_MCDMA_COALESCE_MASK;
>          reg |= chan->desc_pendingcount <<
>              XILINX_MCDMA_COALESCE_SHIFT;
>      }
>      ...
>      dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
>      
> Won't this similarly reset the MCDMA hardware coalescing counter while the
> channel is active, causing it to stall indefinitely?
> 


