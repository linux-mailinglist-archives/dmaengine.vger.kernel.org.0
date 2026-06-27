Return-Path: <dmaengine+bounces-11829-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qkDnD4T6P2q9awkAu9opvQ
	(envelope-from <dmaengine+bounces-11829-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 18:29:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3166D2463
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 18:29:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=QccG940s;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11829-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11829-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ABE1300D31D
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD6E2EEE7E;
	Sat, 27 Jun 2026 16:29:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6138A149DF1;
	Sat, 27 Jun 2026 16:29:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782577793; cv=fail; b=keu4a3dw5qhRf/4xrk43QkSbBOW4iULRgOiQBTE6v2IiW1kar866MzCFGzPO0uJqC6hRobUSzMRsXn+FUAh31EbsRIEhE0xg5J7UxTAD/dAr+jNqzSW8jpiTBU0Qtf2ixy1LIH4NAQnlCE6K+IB3KtMa9aAKm5essJLvz9nPVhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782577793; c=relaxed/simple;
	bh=XRoyE88tmcAD0C9w9GyTnMhauoXthmyz6FkUd3up9/k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GKUZqvoiLw27m6JHWszkJaVLpLEUZ7Utr56qsEhnmVkc1NbXBtuSZ9XFniheIqdasFif81X39CjqBtISHwLhwFoqtfaFBPsmTLhfUg94jIC6LmGlQ1wlvMwWon5NCrWySguhKjWsuag46tmUIn7mezVd51vAaLrqsKwk2ZXLSZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QccG940s; arc=fail smtp.client-ip=52.101.85.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Luj2JFuz+eXQHnBqUtsKEXiAOa9ajoPWvV7A7XWCnTmduNtV7/dqvNSgD8823gOKxUROaLnLfuW8bA6FqRnQd31kB/x75VsWhTZr8do8b/tMbUSlBWJ3H12dWK4yCwiX2hmadqF+hLOG7om+dxskRxq6r0AOliwbzJXaEgwPVuzm5UQJCUN4ZgbMZtboPd24kDU1fv9VvUHf/7wxSJPKQUN/IQtvQNX4rV5YuRh7AOrUbP9wwMU7vEtuY5ztXpiVPvLzrfulYS2+qRZUv1PrVQDsw1dVzRazghvPewmoKCKcdjOB8fukEppb7CW7XLEeSLIID5Kq8czG+K0nNpHJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6nU8N0aNR2bBgU/zRpsvdF/WFHhxV2G9zAK78vrscI=;
 b=WCDk94OrFeB+Vix/drHdiIChe0+geU1W9RRW9DvdObj+G+OiSnZK6Sx9f17qB78FfFOX8+0EwkmikXYbxwo9n83y2+gLS6Is8UUmL9+iZvVTq+w07Wfk4k6tijoigecLbfPAiU1eqa6g9QyqrUM1CPjmZH0mN9bTT5cUKkkVWwp/njFxlrAQ/679BK4K1YFcD2aUHr20AHF5TvjdJhYxLMh+diwoy9x5sWEXR6wl3vPliIBRZnWWTeAVMgGPlZG6gkDbTEqF+1RxkF7Bi/aT0NpiAuFmU6P6cuu2/bYUn+UIhicCpeyHdO4HMRb1LY6atpIENgj8yNlZzWiyiGg5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6nU8N0aNR2bBgU/zRpsvdF/WFHhxV2G9zAK78vrscI=;
 b=QccG940sKdzrwPZ50Ivqp8stvS3ww0LZJQzL15RTloC/HbctH9bUjlQd0kS0YTp+4wwjAxM20dzPmtqez+bRh37CtUuJPxoJP1t4O5nIe79IPPezvFg390ChIBFCXBh8rtA7tP2njKVC4LTaSOXalNkl4ovgWYFEXiqYVuPLcqA=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 16:29:50 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 16:29:49 +0000
Message-ID: <e0e5faf5-bf25-432a-88f5-50017e6a7983@amd.com>
Date: Sat, 27 Jun 2026 21:59:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dmaengine: xilinx_dma: Enable transfer chaining
 for AXIDMA and MCDMA by removing idle restriction
To: Suraj Gupta <suraj.gupta2@amd.com>, vkoul@kernel.org,
 Frank.Li@kernel.org, michal.simek@amd.com, dev@folker-schwesinger.de
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260626092656.1563871-1-suraj.gupta2@amd.com>
 <20260626092656.1563871-3-suraj.gupta2@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260626092656.1563871-3-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::6) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: be85b5be-a041-46c7-9fd6-08ded4694f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7nXq2lrdjTFfwlLA70/rQeEere+q6Xg2EwuxSFp8NaSSLo3H4frDwTTQU1eR0o9nOltJaTkGCs0a/PwOjC8NXJtgBoCk2f3lTzKfhId5e7tZ1zGA+0rCaJGvP+I6QMG7Rv7o/1SH2BCswdjlfjfWJgT8gngaukCrm0ppl4eEiTW3JigUEq3QK8XDLu+isVDUvMsXBLz+bFNWkSehfOmV7GC8DVgg3fc59Hkk8tFzQLgz302Tp0HrldsVLBVQFGbMI4Fb69JS2l8agIZLspBa3OdznP1bit0KIpxYFHRpUY6poZPu7VKPqrcuqHM3CSKjW+czn4hsNCJt+D+G4NzXEtkn/WNvQ6tNdYVmq+4peDXK3zrqjq2LszPh2sbsOBbUC7mx2qgjK4ca3qo+Lwv4xM7hhucxXw0YktWzCUmWvOGv2/4X3UfYVqeJJyVQH8VAPZYVx4gdXw9qkaNKWuUE9k5u/pzMj3Y1JwF/wf14KAYD0PrVKIgoIU8R1F2AWBgV4SChq2zMarxxj1Yl2gfIbjFBOHn6HLQFZftXw7jVkc5xBYjI8wHC52HDO8ZkDJOJNN1WiLZcpUnVzQrOGDeyAMDZt4gyYrsTkXmFNSqkdvYtgBua1HcPIk0Gw7Kw1NYeKxM8RqtFV6k3qcWARiFzV9wMs88GnShcPGQUsgyx9YA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTlldllJc1RkTXVhU2cxMm1meGN1NzZpRkZtQWNBdEV6TzBoelM4OC81bnJv?=
 =?utf-8?B?endYcEJ4N1hkdGdTS1d2Z05Nb1pQWk8vZTBCdW1aZGNtbjQxZDlLSktaalRV?=
 =?utf-8?B?QlZFMUNSTVd6aVAyejRNNFpTODM1OWJkTDFZalhydm1TRW1VQXM0ZjdWVWJy?=
 =?utf-8?B?bHZlVTZlZzJrQmxUdU1reGIwbEFBYngwMm5rZ25hRk92S3F3M3RqalFoZnZq?=
 =?utf-8?B?UWQxR1VaTXJ5OUxuUUxlenVOS0NxZFY0VmEzU1ZYbXQybWtUQjNNTlZkbVcr?=
 =?utf-8?B?V09peUp4SXdXUVpweHh2d0IxSldzTkswWjJmRWl2TyswaDZmZGdnbEtlRE9m?=
 =?utf-8?B?NytxazF5RTFEdlpQL3B0dS9SanNVb2hFb0o2NGpjUHlPd3hsTFJsQUJScUwz?=
 =?utf-8?B?SW50dlJyMjhsaHU4Znh4bFFXVWc5NjJDRFYweU9zUHZHWDdURnZkTTV0MlNk?=
 =?utf-8?B?eFpsK2VaMEkrbjJSQWdFWjErZGJuRGczeVlNc2RnU2JOMkpJZUtSblNLTGpw?=
 =?utf-8?B?T1B0UG1SSjFKSnI4WFpLY3ZNWGNSeFc0OHdWM1lhekxIN25rcHRMMCsyNTdp?=
 =?utf-8?B?cXNwQ3QvUEdpbGt0VGNtMVhsRnhIZ1FEN2dEV2szRStuVzNOZ3dSa3UvdEZ0?=
 =?utf-8?B?ejdQcXlZSk81K1hOeXRzVjBFZkJkV0E1V1B1ZFFCNEtDZlpWQWM1Y2FOekZt?=
 =?utf-8?B?UlpkMWVmRG5nT2RhTHJFdm1xRDJ2NTNFQ1dOcVdNWC9Ib1o4TE5oRGx6WXZz?=
 =?utf-8?B?Um1mU2JHQWNJaHBycnZQcWhqcDNzZlJrZVFEaXBrdXdEcUJKQ2huUG8ybG1K?=
 =?utf-8?B?SllEQ0o0SlZhb2kwYm50TXh5WTF0Q05ZZ0JlRE84cERFa1l0N1dYajNaOE12?=
 =?utf-8?B?VVZvM2RuaUJZWURxYmFRRkdFYVFPNklLV0dXZ1NvRHZLRVk4S3locXBtV25l?=
 =?utf-8?B?UlNNSVhxSXNGd2VGcE9VUU16bmROQlpRc3dIbVhOYW1Sem9pRHV2aWFqdkEw?=
 =?utf-8?B?QjZ2dUJNaTFDMkZCTExzMTh0SE1rRm11V1h2bzNvenhaRUJvY3VyanJkYU9C?=
 =?utf-8?B?alBQNU5Pd1ViZDFTeTc4R3FjaXh5NGFtQWpUeXF0QnU4WTNvaGJWVnBqeDZy?=
 =?utf-8?B?M253d01tNkZwZnVLaHVwemFjR2tJMjZtekZUQ3c4NVhGQi9Zam9ONkVMMDdX?=
 =?utf-8?B?YUs2UStJVTJUeml0SUZnNDRVZW5nQlQrRjcybS93L3ptMHpOZ2FvZjg2d2FO?=
 =?utf-8?B?YjEzRXB1TjBwTk9MczRSMjJaV1JZTmJvenZVU2pJSnpnOHZ0emUvb041YVE1?=
 =?utf-8?B?Q0xKVEVkb0tGK3JYNklqVjZYT3AxZGVnOHdleWRLeGVaZzlEdGFxY0Vtd0dx?=
 =?utf-8?B?dVByMkE0WUVEQWV6M0N4dlQ5S3RnZ0FBdkY2K2FvN0xQNHlnbThWWDgwKzF5?=
 =?utf-8?B?TTVuYW90enBMTlQwcnhNbFljYTdyVDI3QmxLK2FiSC96T3NIcDBsYjNzOXNk?=
 =?utf-8?B?NnkyYVFubHFMZGIxV2FUWk5kM3JOSTFaT1FyOUhmNGpWaHM0VGdrVUFYeThy?=
 =?utf-8?B?Sm9Xdm1IeUU1TCtNZU1Ga1h6dThiYWZKbGhSTmdiSWtka2dPcFl1TDNsQzM3?=
 =?utf-8?B?cWFhdjlNNm1JZ1czQ1Vhb0xaSXY5US8xSHFEbXN5TkFGb20vOUpKVnB1L01h?=
 =?utf-8?B?L0FtaWNoczBaRkpJOW5EVVIxNmFndWZYZ0JrNWo3ZnNacWp6ODJmSC9JUUxI?=
 =?utf-8?B?djJUUWhIV0xJT3MyUzhMS1RSckdxcE52ZlRQaFJkOTF3N2t1eHJLcVJxaWRh?=
 =?utf-8?B?dDFxaVVkMVU0UnNMaTVRV1poSGg3T3h3Rkp4Q3Z2RlpJQnBZVktDZmYxWEhK?=
 =?utf-8?B?TUY4TTB5cGFzM1gxdVpUS2FGTGx2TnA3Y2o4aC9vdytDc1ZLdFNuMTZDZk1Y?=
 =?utf-8?B?ZEI0YlJocXc3THpkMHFDeHZJQ2ZXR2NPMVNEby9oM0cyZ0hHUmJncTA1MGN5?=
 =?utf-8?B?MTF2VGVONXJicTIvNTc1ZFFTTWpHNDFnVnNYWUtJSXVEdjRlNHhickRzSUlq?=
 =?utf-8?B?QzlPdUNrZTlTTlRONWVSVTI5OXZDbnp5TXBUZVRiREpyY3lsNkl1Z0YrUnMr?=
 =?utf-8?B?YTM3c2tWTGZqTGt1YUEyWXRXM1NvZFNVL2FLOE4vOG54TnYxdE1YcTJjbEla?=
 =?utf-8?B?K1dZWHhYczFQZHNoZ0NPMDRpT2FkdjBublQ3bjFjV0pBWWVpRnZ4UWlrOEpU?=
 =?utf-8?B?ZVRWZGVuWDNINVpaZFk5SWptVk9MQkpIUkpHWTNZMnYweUFoYUJDaXNoaE5I?=
 =?utf-8?B?aWlnRGUzOCt0MWlxNXR1ejd4Tkg5LytUVGpKdU1CcktrdUt5YTBNUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be85b5be-a041-46c7-9fd6-08ded4694f33
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 16:29:49.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ysbBvXqGrQYdUQOuF7qan4Y5lsz5uMSbNs9d0aP+BIsUv/YjnYlWKUtCo1TpCy+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11829-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:suraj.gupta2@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:dev@folker-schwesinger.de,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B3166D2463

> Relax the idle check in xilinx_dma_start_transfer() and
> xilinx_mcdma_start_transfer() that prevented new transfers from being
> queued when the channel was busy, so scatter-gather transfers can be
> chained onto an in-flight transfer.
> 
> In scatter-gather mode, only update the CURDESC register when the active
> list is empty to avoid interfering with transfers already in progress.
> When the active list contains transfers, the hardware tail pointer
> extension mechanism handles chaining automatically via the descriptor
> next pointer chain, which is set up at channel allocation and preserved
> across descriptor recycling.
> 
> Direct (non-SG) mode has no descriptor queue: writing the BTT register
> launches a transfer immediately, so a new transfer must not be programmed
> while one is in flight. Keep those transfers serialized by retaining the
> idle check on the non-SG path. MCDMA always operates in scatter-gather
> mode, so it is unaffected.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> ---
>   drivers/dma/xilinx/xilinx_dma.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index ca396b709742..6e7b183cb499 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1580,7 +1580,14 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>   		return;
>   	}
>   
> -	if (!chan->idle)
> +	/*
> +	 * Direct (non-SG) mode has no descriptor queue: writing the BTT
> +	 * register launches a transfer immediately, so a new transfer must
> +	 * not be programmed while one is in flight. Keep such transfers
> +	 * serialized. SG mode supports chaining onto a running transfer via
> +	 * tail-pointer extension, so it is allowed to proceed when busy.
> +	 */
> +	if (!chan->has_sg && !chan->idle)
>   		return;
>   
>   	head_desc = list_first_entry(&chan->pending_list,
> @@ -1599,7 +1606,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>   		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>   	}
>   
> -	if (chan->has_sg)
> +	if (chan->has_sg && list_empty(&chan->active_list))
>   		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
>   			     head_desc->async_tx.phys);
>   	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
> @@ -1660,9 +1667,6 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
>   	if (chan->err)
>   		return;
>   
> -	if (!chan->idle)
> -		return;
> -
>   	if (list_empty(&chan->pending_list))
>   		return;
>   
> @@ -1685,8 +1689,9 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
>   	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
>   
>   	/* Program current descriptor */
> -	xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
> -		     head_desc->async_tx.phys);
> +	if (chan->has_sg && list_empty(&chan->active_list))
> +		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
> +			     head_desc->async_tx.phys);
>   
>   	/* Program channel enable register */
>   	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHEN_OFFSET);


