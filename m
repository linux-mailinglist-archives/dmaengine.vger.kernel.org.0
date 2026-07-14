Return-Path: <dmaengine+bounces-12485-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gz3IAVolVmr7zwAAu9opvQ
	(envelope-from <dmaengine+bounces-12485-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:02:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C9C754383
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:02:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=weidmueller.com header.s=selector2 header.b=awlRFEYr;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12485-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12485-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=weidmueller.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F42393032F39
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 11:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3875F38D3E2;
	Tue, 14 Jul 2026 11:59:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56A8387585;
	Tue, 14 Jul 2026 11:58:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030345; cv=fail; b=mHeqU2/hg2Ah2RCwED3QAplvZcgYpAMhjJXjDvNdm/UZwY0P9tUJVeKeDdVU5VXTzWPHGWV+ZdYffqknjj2t1xUGacceq8RdZvXEyY1KxwMepCyOtj6cMvAFRLgRdi7wRv0e1knQjR0iM9lXjv+SNdkbs4QD4RUotLE8Zz/wkhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030345; c=relaxed/simple;
	bh=H930La7zxkQAUYCbBdNtHWSzHrj0VQETBQaPP+kDWXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMmfPw2yE3sRwLMzNuHc6+S0TuaGqV9J3Vh50hqiq+3d3WR8iDFS1e1lpSktl9NdjeREWhpTZP527fuMUpFa7gcOZmpXapL6D7po2EqIPXc6FF8MXZLuac1ncbAHMgmFFdjBbxDTRyZsJgXXFuN66uWVjMAJ1gfRtuW18dmyDG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=weidmueller.com; spf=pass smtp.mailfrom=weidmueller.com; dkim=pass (2048-bit key) header.d=weidmueller.com header.i=@weidmueller.com header.b=awlRFEYr; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0M07ZI+8aF8V9p1WAqZLMmxJtyEiIvE1ptCljvw+4qdP/kiC5/ibZkC3mtx2gD/rCyoal2dNSM46lEcw1EiFxaKcM8+hs+oZb9NcbyMq+9lntA5R+d0JDYlCxE7jIurBXut2OcjGoBIJ6+h2fLBFushhHrDIVMYGtiE+x9fuu9xv9J3l/Gb1s23rx1od+gYT8GR2DPK3lRwp/Hke/TWs7z8/VksHlnAykrmhv31Xoj9t6yPgOYqSZOXc2AOyTfyMpI4iGdLirHhRlFbNV1i57e2Rhb5OhO1Xxo3WaooSbHRG8TTjKdCk3iQ1Yu+GTskBwjd38JmUIwo0MFRQxQioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EybbyUKE3eZtng4vClhZoYBQ5Y5PTkqrAm10KJ3gqg0=;
 b=rB8S1ARo3IGQ1PcBg+JEivQ+vmoTk/V4nAp261zj1SzV8KH0P/RevtXHvges91fgsYKl9oS9E4At0irbSiSgP7hWzsL53e0hHsV6CCkFvlFDKFEk18nbcs0QltMpKYDHV8MuBNIXIrFz/eKChz/bS27VhFPho4dzT9Phnv9I1d/kssInoLEtPluoBjmEwo/3BuZGYewpehTknjXM2TEZzrycua4rKYdTbtHM1z1OKZ2YgY5IoTZqSI2Dp1zOpQ064rh0+ldku5ixMvnGepPrCrUAXn28iDiWh65CeN6brTkZjVJHMWyh0LiravrRe37s5g4B2gRkzHdSjy7I3TBDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EybbyUKE3eZtng4vClhZoYBQ5Y5PTkqrAm10KJ3gqg0=;
 b=awlRFEYr3m3D3XWAopKxoexm1vnyhdOD4rGOLlJTP8Mn6xMU9AmqCDzM4+R038Ukt7SnuKQSswvD/wapxwK4fWwHEvjtQX9al6CJLxPjMmrs7FA6G/SGXPaNPLI+dAl8l7UJSpWqIJEwK/UlbIfgWlWz5bJx37mFt1x+//0eZZie4ik5Hyo37l1g3jhhmSzhYiNV8PeTl7VraYee5P69j6OuPEI61t8IWRNQr2ItEWJCIh2gOi18Ykx4B+ftS7I8vYdnjmb5Rg5yGmHy7iBdNf3nChNViLKKYqxZfm3cBynHNuK94eeGqgBszX1M0Lv446LWq12oQkPe9OiIXi4EmA==
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com (2603:10a6:20b:578::22)
 by GV1PR08MB10421.eurprd08.prod.outlook.com (2603:10a6:150:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 11:58:54 +0000
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778]) by AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778%2]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 11:58:54 +0000
Message-ID: <84676bd8-3815-433b-b531-2715b8e8693f@weidmueller.com>
Date: Tue, 14 Jul 2026 13:58:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dmaengine: nbpfaxi: Fix setting channel irqs in
 probe()
To: Dan Carpenter <error27@gmail.com>, christian.taedcke@weidmueller.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>
 <ak96OkpYvJrK1Vbt@stanley.mountain>
From: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
In-Reply-To: <ak96OkpYvJrK1Vbt@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To AS2PR08MB9199.eurprd08.prod.outlook.com
 (2603:10a6:20b:578::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB9199:EE_|GV1PR08MB10421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b59648e-ab5a-4a18-4ae2-08dee19f470c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003|4133799003;
X-Microsoft-Antispam-Message-Info:
	J7Xt0CjWyEmIJtM2PNR/iKr3ThpuwOY5YDn+Zs0p+vcLq6kzpkrOnvcL+wCcPvpN64MrFPo9xVGNeoFOaOrOZ5T3XgaO1CDUEOF/2TMr+mKPKC56wfEY/ktqSrLDjEK5c79mz5/wdYoatyQ+xs0XzmDiw1YIkergSn16IeD3urLEprRrQ7tV1JG+HN+xd+wncGqP5j7YaInFhiDNrwRyWUgo4yWbdSWGXcFNN9yyiXuiO1zBA+34GD7AM0kzHWPGXZ6+K+Vr63Kzr+qMZ1ST7H1Hy+Zbf4wAMt+mXLKE3XZcKtMvpEexsLd7m683vmFOzIhxV8Z5v+meLMJcGC8yaESkJ8V1ACPOB9HSjxccZRsokXteCf4QDgWm83jjVABy0IIO1haWVZVJ3ZC7dB7c2JuyJNtqe/o86wVkFqx7Si2JbBf/68s+XnFvcYtMZv5Ic7VFm7otBxMPGvDmhrzFHF4unelseosAzUfABakMpLc0GRGwj42d+Uka8h48ecXF0vH0ex4d9fC73AdwYVeFutIwpba8DVsoQF9NM8S5JRqTVk48jQrLwOxXyETOCcty7UO3GnQrKFBdGqXAJDJYQXwwZsMf4/lGtwO3OJRA4nEcQcRor702JyRgLnUgobs7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9199.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUdqYmtNQzNZSTQwZ2RDZG1VQm9SS0ZCQjcvVWFZM0ovQ1JxQ0gzZlliWnd6?=
 =?utf-8?B?amZvMEJ1QU1ZdFBmYU8zZGV5ZHpoZ1lidUZRZzJqRlNzQ0xReEZpbko5Tnlv?=
 =?utf-8?B?Vmg4NVFDTFhBNS9XNVZOUFNEWXVtaHlWV3BBUHp0TWpsMVB2bzBTVzc4ZUFh?=
 =?utf-8?B?SzR3SjB3VzVKSTVia1JOd09lRFZuc01JamhhSmMxWGpHUFRyYWJWUlRqazJh?=
 =?utf-8?B?M2dTL0RacUg3ZExLdTY5QmNibkR4dk1BTHF3N1ZhMHZnOXBDUWlsRlArOFZu?=
 =?utf-8?B?bGM0SDB4aXpmTHE3Z0VUNzVTUXV2SGREMGJZNldyUjhuOWltRitnck81V3Bv?=
 =?utf-8?B?L2VGc3YvbEx3Q3lFQXZmQTZ2ZlpzS3lnTnBpS3I3bjhiYU4rcFF5ZjdhWldH?=
 =?utf-8?B?QXlqdldDYTNDTzVFY3J3c0NLUm8wbTlBNFdCVmVMUzdHbGFvRWxsVzVuamxT?=
 =?utf-8?B?S1QwSEJ3WUpTamJHbG1BS3VnZ256RkptVWRhQzVXZVJlTTlpMEFOMkhqY2xP?=
 =?utf-8?B?RWh6Ny9JMTlselZYSTVXWVhoVHUyUVpFZGt2UDFmYlBtTTcvQnAyVXhKMS9T?=
 =?utf-8?B?OG9tVDFRdnBSS3NQSjBXd1JBMnZWNVlJNVNmL0tSNWhkSU94Y1l4TkYwSTZM?=
 =?utf-8?B?NDgrYkEyb1JtaWFPNXIyVXUydmwyZXltdjBxeFk5SCtONzd0NE4zcVd2VzlE?=
 =?utf-8?B?TTBUOTJsSUFsNFBlaWNDWlIydXFnRG5OcEN2RXZwSEVrdFhRK3liVTBCSC9C?=
 =?utf-8?B?L1pVNUlHRlJuTHV5Vm1sa1FYdjlhQUtRdDljNVIwNlM5ZDNHSXZqNEs0MklV?=
 =?utf-8?B?V2hWUU1jZ21LeVBlelBNVVVqR09ZTEl1dXRJNlBBSHh0Z1Evem1uK2RxZXJT?=
 =?utf-8?B?RjdPZ2pnT2VQNTNyTGMrMjJBNUhwSGt5cndSVVUyWEY0S2NMQnlYNCs3azVy?=
 =?utf-8?B?d0NKdU41aHFrMCtlSjBEdE1Odm1lNWJzaXVMMlp1K1VVYm1TR3JRU1VRQWR0?=
 =?utf-8?B?Y3BVL09SbCs5M0dpdjJFOXJibGswK3BJdklvdU9FNDJCL2hGb0ZVdThabzdB?=
 =?utf-8?B?c3VCNTdRNnFzZTJRWVVQQzBKSWhHWVgveVBhY2ZMQUt1dW4yOE9zUVNNbGc4?=
 =?utf-8?B?RWJTREpMb0VPaFJMR0xPVXhJL0pPL1B3UTdGY3BIZjJWUWNqdC8vc3c1MzFt?=
 =?utf-8?B?UWJ3SnNzUVFZaTdLVE9jUzVTc3RxclZyeXdYZzk1VjdjalU4U3VoYWdjTUlL?=
 =?utf-8?B?ZnJHL3EzRHNWNitqMGFFejlydWlXa2VzL0FLYmNHVkFrS0htb0ZPaU5FeEth?=
 =?utf-8?B?cERMSVZrZ2gvY2pON0xiMmxtSUU2YUYyMmVGL05IdXlUN29OOWRRMk9EZjlk?=
 =?utf-8?B?SDBGUU5VVFRPdHdYRVJOWlBmYm9KQ2tEbDZrbmRxRVFabmJsQ1h4SDVxNG5r?=
 =?utf-8?B?TUJOQmNuSk96cUFONnJ4QnZnaktiMzhWNW5UTW8yczBwVkZiSHlTellaZERK?=
 =?utf-8?B?WEZOaDhWYlczQWs3aEdXbTVxR2F1VmpWdjhmcUFtaGMyZHRQUGhqMUlIWEFt?=
 =?utf-8?B?SUQ0Y3ZhV2pKVDkwOEFlTkl5QTl5WkJTUkp2ZkxsdFdFQ1krYmZ2bzVZNndP?=
 =?utf-8?B?QVN4U0JralFTYm1HS1ZxQjhyazZrejl3U1VKQVhhWkQyTVJ0aGFQQW4rOEtU?=
 =?utf-8?B?cm95WnQ1SjZCL0VOaCt6R0NZV2E0cmdpQXFJbDZkd0tLMjlKSUhHa3J1RWlH?=
 =?utf-8?B?Mm5hVnhLNnJjckY4Q3BLVlI1RmIxdVArN1JuTzFlcGI0dWpuWHhwY1FRR2hR?=
 =?utf-8?B?NFVyK21pMHhCQVVQMkVQVzZQWklvT2FYWXA4Y2VBczNuSXB0Y29vblJWNVdj?=
 =?utf-8?B?eHJhOHprR0ExOSsyWHJocFlOb2Y2ZGxsOHpFRHhHcFNiTXJyOE5BM0NYdHY2?=
 =?utf-8?B?TlhrUzR4ZndBVEZPRzZ2UlFsNlgzWnlHNHI2ZFJwVXVLdm5MSjVRNUNuU2lE?=
 =?utf-8?B?eUdMU2Njb2Z6dUFOZ2pjYlVSQmRVMDAyUGk2ZmpMUXU0bGZBaldTM1p2Zjd4?=
 =?utf-8?B?RzZzR1dxY216WjRMUkd0dFE1S2tvRlhIclR5Qlk5ZWF3YkNlN1dmYWdOaVhR?=
 =?utf-8?B?cGJveE5xL2lkN09JSEo3NTBCRTlBWkJFY3hrMk1BQit5VjJheWJvRCtteEJ4?=
 =?utf-8?B?R1dONEZrWEFodDdEWHlEQVNqcE40UjlxZVJqTzBpdER4MHg1ZSthK2l6ZURO?=
 =?utf-8?B?R29zRHMzeThpbHlrVDQyL0kzam1QWkovSEtZYVpGT2ovV3hGQm1leDcxbUU3?=
 =?utf-8?B?SHd3WTA1ZnhsalJ6bjdCMW9wbjlsNnV6N24vWVFJNDZzbE5yUWNJSjhCWnJR?=
 =?utf-8?Q?mcj6zcgXKPlPjgCfTlBckFqDhU6uoUXfqKcGy?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b59648e-ab5a-4a18-4ae2-08dee19f470c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB9199.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:58:54.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYjdzQLSWUxHCmoAAb5XphWeMMSAimrSwQp5s48sj9ONd+6S3ZaEjplj0tndVXyqK2oiTqJPj5g96QmgyAUZISCJqG597nMwgUS35sx/jG59yMI4yWrYo4WhmHcg6K/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10421
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[weidmueller.com,reject];
	R_DKIM_ALLOW(-0.20)[weidmueller.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12485-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:error27@gmail.com,m:christian.taedcke@weidmueller.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[christian.taedcke-oss@weidmueller.com,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,weidmueller.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.taedcke-oss@weidmueller.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[weidmueller.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[christian.taedcke-oss@weidmueller.com:query timed out];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,weidmueller.com:from_mime,weidmueller.com:mid,weidmueller.com:email,weidmueller.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71C9C754383



On 7/9/2026 12:38 PM, Dan Carpenter wrote:
> On Fri, Jul 03, 2026 at 09:56:12AM +0200, Christian Taedcke via B4 Relay wrote:
>> From: Christian Taedcke <christian.taedcke@weidmueller.com>
>>
>> When one irq is used for errors and each channel gets a dedicated irq,
>> the total number of irqs is num_channels + 1. If the error irq is not
>> the last entry in irqbuf[] but an earlier one, the loop assigning
>> per-channel irqs terminates one iteration too early and the last
>> channel is left without an irq.
>>
>> Iterate over all collected irqs instead of num_channels so the
>> error-irq skip does not shorten the effective channel count.
>>
>> Fixes: 188c6ba1dd92 ("dmaengine: nbpfaxi: Fix memory corruption in probe()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
>> ---
>> Changes in v3:
>> - Guard against out-of-bound writes to chan in case of an invalid eirq.
>> - Link to v2: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com
>>
>> Changes in v2:
>> - Advance chan only when assigning a real irq to fix out-of-bounds
>>   memory access.
>> - Remove now redundant ARRAY_SIZE(irqbuf) check.
>> - Link to v1: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com
>>
>> To: christian.taedcke-oss@weidmueller.com
>> To: Vinod Koul <vkoul@kernel.org>
>> To: Frank Li <Frank.Li@kernel.org>
>> To: Dan Carpenter <error27@gmail.com>
>> Cc: dmaengine@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  drivers/dma/nbpfaxi.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
>> index 05d7321629cc..b1f06f0bd0d5 100644
>> --- a/drivers/dma/nbpfaxi.c
>> +++ b/drivers/dma/nbpfaxi.c
>> @@ -1374,14 +1374,14 @@ static int nbpf_probe(struct platform_device *pdev)
>>  		if (irqs == num_channels + 1) {
>>  			struct nbpf_channel *chan;
>>  
>> -			for (i = 0, chan = nbpf->chan; i < num_channels;
>> -			     i++, chan++) {
>> +			for (i = 0, chan = nbpf->chan; i < irqs; i++) {
>>  				/* Skip the error IRQ */
>>  				if (irqbuf[i] == eirq)
>> -					i++;
>> -				if (i >= ARRAY_SIZE(irqbuf))
>> +					continue;
>> +				if (chan >= nbpf->chan + num_channels)
> 
> Prefer my check, but sure...

I tested changing the condition back to check for i. But after a few different approaches, i think the check in v3 (chan >= nbpf->chan + num_channels) is more robust.

It handles the following cases well:
1. eirq is the last entry in irqbuf[]
2. eirq is not in irqbuf[] (which is not expected)

This check also makes it clear that the write destination is verified.

-> i would prefer to keep the v3 patch as is.

> 
> It's pretty annoying that sashiko bot doesn't CC the CC list.
> 
> regards,
> dan carpenter
> 
>>  					return -EINVAL;
>>  				chan->irq = irqbuf[i];
>> +				chan++;
>>  			}
>>  		} else {
>>  			/* 2 IRQs and more than one channel */
> 

Regards,
Christian


