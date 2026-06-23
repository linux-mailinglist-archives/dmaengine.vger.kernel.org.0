Return-Path: <dmaengine+bounces-11759-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2x7RDICvOmolDwgAu9opvQ
	(envelope-from <dmaengine+bounces-11759-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 18:08:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 931356B8921
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 18:08:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=fKBuCKnE;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11759-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11759-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A94113059189
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A55130DD11;
	Tue, 23 Jun 2026 16:08:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC930C368;
	Tue, 23 Jun 2026 16:08:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230901; cv=fail; b=LaSEdFbke3aI1N0U8RPdaYPfn/9uYGHm9HenujFhHdNGEiONPX08iPC86v9zvzFYJwp3g0Kmz6zD3EJKWhzF0ZMgmG+/zw0cvxPNH1g/Bwf0SN4IrEDQtdoPnOdkmvdPXPS5tHPCRtcRSKP61/qORNPuFAw1P+DupgQrcl6ZHUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230901; c=relaxed/simple;
	bh=vC0PTC68xbRu3X6Jm5EMQPHPaXbip4OLbtpVc2kHyrw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dC0iK0f4Hj9SFWSJLc+IWRo0zqJyXGYt+bxaANZPd9N+80gPCOdL2UTwk1esBTwG1McgzOn+zmJJ8OlmsaHqV9qvcjTf7nQHQ7lmzSnqh0UKooFSXC7fEqNB0N31LzQMZubX1BQwChs7Lni8klKRq5oX+vil8YrIK4lv6UumX0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fKBuCKnE; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT9A8Tq3uAW2YTFWdoaBpLTN5X0xSwXNt7sf1cFdoP681UDdVxJf++jnndLWrNaviUQ5Tb0EEKDODLzXyE/lEkNbVKamuYtmcZ1WFp7+ohB2QJ9xPxdTMkL6MWCXtmaA+KXyEeDMy4N61RtnMTUFWINOTyYAizI7hDIpX3GRUHkw53xhEnzUbx9Ez2mLc7+IM9JtLq8AxnpHiDPblvcjDitqGqZiH1xy0OJceJa7TW8C62DtWmzv00URr8VOCF+nUQ3s63/+Y7DenAQzYBU5NV/FzDQfDhBQ9QQZwlu/+aHsZG9E/X9KyhrdDOnt837aNJqhlb8EjiacueZnK8cZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SB58M0Alubw2LnKT9ez6zSMAWIuS6gNInpJj+UOuNg=;
 b=QdS2j/H7+P5OEnwN/gl2Jt6o+jS4zwHN50r7M/WYywNXHOfTANe1wehxn23owTR4QcE/fouYPlNiRGxEHFWryRZPr7gqY64NWEywhqL1t2sXg8AxyaT+5CjsWWRT64ZFZlCEr3mUg4Nmm2GBwj+wJ6+SO9p/8GR6tgywniLUKozM0Cp9OKcMaIjOwidXQGsV5h8uMKlGAZy42QwI3VE0dUmheAxdBWth3QtdAToRlSFa+bDYc5M5apseVh9q0Deq7lWMK7w3DYgayTjVaod96TXHsKIxAO2bfFkiCuJN+Xs3w4dcfYc6lXxwFFmqi2Iulk3A0AJpy7w2eihsofqa+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SB58M0Alubw2LnKT9ez6zSMAWIuS6gNInpJj+UOuNg=;
 b=fKBuCKnEl0LhqLObv7ZPdl6z332S9qIKzHUuZ87nmyNCreufSSuxNCw4JajiXCbOpbjzMwwXk4MmtIZtDEcGlsJLsC+A0Gp2eMpg7lcrBAJsoL8S4NJWKL/yi7QpqgcVfPXvSehriX6YxPCjINknjBHwOnd8d+8BSBU+sybRfy8=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by SA5PPF5D41D38AD.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 16:08:16 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 16:08:16 +0000
Message-ID: <cbd4668d-e56e-4a5f-b029-d7570d66b659@amd.com>
Date: Tue, 23 Jun 2026 21:38:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 3/3] dmaengine: xilinx_dma: Optimize control
 register write and channel start logic for AXIDMA and MCDMA in corresponding
 start_transfer()
To: Suraj Gupta <suraj.gupta2@amd.com>, vkoul@kernel.org,
 Frank.Li@kernel.org, michal.simek@amd.com, linux-kernel@vger.kernel.org
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srinivas.neeli@amd.com, dev@folker-schwesinger.de
References: <20260620203417.4000360-1-suraj.gupta2@amd.com>
 <20260620203417.4000360-4-suraj.gupta2@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260620203417.4000360-4-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0148.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::18) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|SA5PPF5D41D38AD:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d500073-8677-4784-2e64-08ded141a26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kocdCwQf9pq7g/KN9P4I4OAfFSUEpJgaw002OZMENpOIq16iyXtDWw+J/29xKs268tcq6BNY3bjnZ8UDGHJg7Kn44eo45q3OyVotBGzZJZ4x/xMnWh0JzcFTSUv8KizDHhWDX0z+agN/tlySAiXEP7R4J1BPTy3P3fPqXFYxVQbTvlg28PpRkbvZ26WgOz/LqlA5zUFJUG7vYE+emTap9xTdZSz0kWIt0/wL79QVS4Vd/MKaG7n8vPcRO5nkHV6G3qPrYKB3ZJ7QBDlSHiZ7gCmrxFUJQSEh9mswZYE5xTDyN9RpBhBbMTjXsZ+A84zIuGvyzwgtf7QfHjxj4gHd5kEJkX/qj/Ogsp62RMt6ACrVtSaWom2gtD+0pTRpsFS3BAKGn3Pbh/FKedbImzcGo7vspXXem06bkG/ZAcvSeRJoF5cHD0tUv1M5931vcy5yEnSJgxpAdSBS8gQxY+lVCSK4SrVLZcQvF9Y/z4JG8v45Nqegk+tU17pEU3iddafqCvNPcAKLFbAe/VUL7OPrBAd3eLSNFiweHpCSaGuRH0ufdLmq+bN+Jmk3Oxxhw2Z/+Sb/lS84c+4HYx1Hrle6cu7Bul9WrIjV0jCxqIzSSoe/eljhbgZZYz+koAetTDA2RGf4DROSdpnW+rX7Huxy5smXP4X/F7Oh5qSLMHs6G40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHhtQjc5Z0swN2w4VW9Wdjg1enZ3bm1XWEpjaUFZaHNPaDNUb3lldDltdUdx?=
 =?utf-8?B?dFNVZnVwdFNWNmoydldETkpqWDdLLzhtZU5RVzdDS0xncllra2tPZmo0YlA2?=
 =?utf-8?B?bmRWR3hnOHBOMld3SGdTVVlXZmF5NmVHT0hVSWhwZ0U5Q1RSa3RTbDJsQ2sr?=
 =?utf-8?B?ZVZHNHA2WUtCTVdhaWFvUk1NNkdETmZDcmg4dllKeVh6L25wNXFjaFZPQ0Zq?=
 =?utf-8?B?NjI5eEY3QjNuVE9sZThZZnJqeGsxdUgvQi9NVGE0blpMWk9KaWR6ajVnR2py?=
 =?utf-8?B?UzVJNGZCOENYYjkzMUNodGZtSE54RU1KYWRiSjJLMzYrYVQ3WEhnRzR3TDhE?=
 =?utf-8?B?dnhSMFh1WFR4M3Y2SVVvWGNwNlBxcXRzbUhiZ3Y4RFJkcWNDQ1EvRGRBaFhH?=
 =?utf-8?B?Qm5mQ1Z3ckp3VWwvOXRmNE9FZjRwTHFhaHFQTFZTMjY2ckV6Ry8wRmZmTmVV?=
 =?utf-8?B?am9oVmZOUVVJNmY4ZDFmT0phUEwrL2huTjNkMStsTTFIUFlHa1AwMk45ZDUz?=
 =?utf-8?B?UjJ0a2pXQVE5aHN3UC9WSk5ZQlBzajJydmpzZGk5Q2lOWWk1UjJUa09ENnZ6?=
 =?utf-8?B?ak9IenFzUFpnNnFJR01Cd0Rkc0psSW13T0FLaGU4VXNOdERUQkFMQi9ZbXB6?=
 =?utf-8?B?akpOdVhUSCsrRGpBSTRKY1lHNEhPL1UyeEFPQTAzdjlweXZPUWJ5QUZ5aXJq?=
 =?utf-8?B?aVFTaURwSGE3VnBVREFGLzRqRVlMUEVHbmxQaCtyR1owN3JMRXgrbmxiTGlE?=
 =?utf-8?B?N1B4WHQ0TkhRcHFuL3hNT1h5b25Oc2syZXFDSDFxZEIyMGVoZFp4SklHWDZu?=
 =?utf-8?B?VitWeDJyTGIzUjJiS2lMK2taNWNDcFhoYWo4WHp6bVNWTDlyM01UUG9tQU5u?=
 =?utf-8?B?anVYNW9NQzRzdGhZOWdVc0E0c3pNcTFZWDA3OVRDcTFJN2ZuS2R4VHV0cEo4?=
 =?utf-8?B?U3MwZ1laTzUwSWhsRmxZWGZOWUg0RXBXdEE1T1JrUTRzUDBSYlE4dVo4L2k0?=
 =?utf-8?B?a2NYcFhucEgvYkJaMTRXN3ZNbHRBV21uOWt0MGdidEZxQU9scTU1Vm43OEV0?=
 =?utf-8?B?emR3RmhvdUVaNlVMQ2RXendyM2JEUngvNDdicjI0b2o1cUpKb0s0Yk5kaG5m?=
 =?utf-8?B?dHZQK0k1TUFVS3ZhNDlqazFIOHhGNTNFZzM1MENZTm9UMnFBYXZ2ZnlXNmJl?=
 =?utf-8?B?V1pZL0VtelBKMFdJR3RxbmZqalpxK3VRT3p6VUlZVVRHV25uVUVEemd5cHM0?=
 =?utf-8?B?YmtLcksrMFp3d21lYUNSb0NLRlFlQUVXWFZMWHdnczRTZkFmNmVoL2hqMXcv?=
 =?utf-8?B?TjRWTGRiOHZyd3REd1h4cFQwbm90Q2d5bURBTS8wK0d3RjVPcVJOVjlEMmhH?=
 =?utf-8?B?Yy84WkU5V29rTWtua3ZHbW1CN0luZFl2REVwWW5RaEZ5eitMQ25paEFob0JW?=
 =?utf-8?B?Y1lybVpDdWdhR2tlMVE0M1p4WDQreHlTMjJhS0NqVy9sVmxudDBqSnJRSGR6?=
 =?utf-8?B?U0tVT00xY1UwZ1dLQjlUL0xKNDZaOWZVODVCMFlMeUlwR0dSbmdiUEFNTFlZ?=
 =?utf-8?B?MFZMT2kxUHBDZEtZRFBWRmpVb1RDU09IUTA5TDBHYkNTZlRITW9zNllqcnVa?=
 =?utf-8?B?OXkrL1diekd5VTEzNnlXYnZZNUJqem41b2tiNFBLNzRicU1iUlVaNjN0V2xp?=
 =?utf-8?B?N3N2c0tobDFndThwZUZJRGQvK3VweGVlMWUxelUvN3I2V3pPV3g0STgrcytY?=
 =?utf-8?B?bGpkaG1DQ0NvQ3ByZW5xWXlvQ3lLREN4clBnMDlxaGNrUUxESUZ1YnZLRmMr?=
 =?utf-8?B?eHZ3cGVwMFFOUEt3TTdQRU1WaHBBamxqc29CL2tZbXlVMEtVWFFYQXZvaHVX?=
 =?utf-8?B?RFlBOGo1M2RCVE43UGpvYTRKczZqaTFzeW5ZYVFkbEdZV0hKdm00aHNTMy9n?=
 =?utf-8?B?bDFWVjJFQkZ3aktEOU9rcGtqOEN6cjdDam1tcHM3SjRtWE5zdjFqTW1wYkZt?=
 =?utf-8?B?cjg1ODVuRVQ4bEVtTTBLVHVYSmVTWkQvUjBwdmNmcDRSSGNaeTBKYkNIdzdn?=
 =?utf-8?B?eEo3QlJVa3NJSnF5Tzk0R05qOW8wY0FnRS82VTNsZmpNaXM3VlpxUnF6OXhj?=
 =?utf-8?B?RmpTdndGRkZOTE5YRG5tUy90UVc3OU8vcWt6b2p1eWZBR0NHQjV4dVozR05J?=
 =?utf-8?B?dWlBNjFsdkVtc252eGtvbHRyS3RhQ2ozTUtTbjVzVTA4ejNLbE53dmNpVzl2?=
 =?utf-8?B?b3ZQSXluTmxsSVdORFRHc2pIQ0hHTXRpVndEM1VBVDdRYytmS3FrUmlweWtx?=
 =?utf-8?B?bllXZnFSWGZ3cU1jaTNPelZtNXAva0w2Wkk2UHRXRE1XOUZRQkwyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d500073-8677-4784-2e64-08ded141a26e
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:08:16.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esR4CtrcD5GOZNiDkhMq5c0lr+rtEzAdrG6zkj8rK3mmXsjgc2yuHJM9VA6rgloJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5D41D38AD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11759-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:suraj.gupta2@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srinivas.neeli@amd.com,m:dev@folker-schwesinger.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,folker-schwesinger.de:email,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 931356B8921

On 6/21/2026 2:04 AM, Suraj Gupta wrote:
> Optimize AXI DMA control register programming by consolidating
> coalesce count and delay configuration into a single register write.
> Previously, the coalesce count was written separately from the delay
> configuration, resulting in two register writes. Combine these into
> one write operation to reduce bus overhead.
> Additionally, avoid redundant channel starts in xilinx_dma_start_transfer()
> and xilinx_mcdma_start_transfer() by only calling xilinx_dma_start() when
> the channel is actually idle.
> 
> Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
>   drivers/dma/xilinx/xilinx_dma.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 35b553ee3205..aa3dee0dc2fc 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1593,7 +1593,6 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>   		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
>   		reg |= chan->desc_pendingcount <<
>   				  XILINX_DMA_CR_COALESCE_SHIFT;
> -		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>   	}
>   
>   	if (chan->has_sg && list_empty(&chan->active_list))
> @@ -1604,7 +1603,8 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>   	reg |= XILINX_DMA_DMAXR_ALL_IRQ_MASK;
>   	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>   
> -	xilinx_dma_start(chan);
> +	if (chan->idle)
> +		xilinx_dma_start(chan);
>   
>   	if (chan->err)
>   		return;
> @@ -1693,7 +1693,8 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
>   	reg |= XILINX_MCDMA_CR_RUNSTOP_MASK;
>   	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
>   
> -	xilinx_dma_start(chan);
> +	if (chan->idle)
> +		xilinx_dma_start(chan);
>   
>   	if (chan->err)
>   		return;


