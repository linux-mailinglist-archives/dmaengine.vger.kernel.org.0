Return-Path: <dmaengine+bounces-11501-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bx5pKettLWr1gAQAu9opvQ
	(envelope-from <dmaengine+bounces-11501-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jun 2026 16:49:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3F767ED25
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jun 2026 16:49:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="EE//Z5nq";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11501-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11501-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DF46301779D
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jun 2026 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B9A2D780E;
	Sat, 13 Jun 2026 14:49:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36117293C4E;
	Sat, 13 Jun 2026 14:49:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362148; cv=fail; b=rHuEC/1T4KzrB5432eEZn8lrrMdvbnPMR66scDdkzzlK9AWbjHQg3uiV98kmrZahHWz8i6jpEX8GRVaq8DYpn4aeCEwGVRHb8AJJNLrkkDGIuBnIFofIbLYmGVsMIrj9Xkyz9eKFD8fd3onprMn7FnS7C2BW+ow8El0eicKuKhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362148; c=relaxed/simple;
	bh=+uKbPNKJOiEeIttWwWV7v6aHTVqmeqCCTvwsjiMkNUw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vChgl+ewJygXhHcUNc6FlNuaPlFStvTM8IUcZCrtdRdyAEIALsGAdeyjJwpTIrfF84gqWkqHkZhJjhWLqjujcKjED5fRQZcDiEIH767SU7+fkKzXsx0nqJgIVrLMmcjxoq9So2mNPI7fgmzDfk/CTlLov35ZrpkF1xQVwfNyFhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EE//Z5nq; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjZ6bkLzUDp3VkxG/IlhTirFWioOkeXgW74ULTHxuljRyNQvKr9TUM54DEa10z1zGJY+Zcovs90k5wT9rJ0KI+d74Ud8/EeM9FYssgmXrYZ6VAwUvxPJiiRHoZVbuCfpZd7RKGPCvndobnwNgp0VSdGcLgBy1BcG/b+zD5H7mZU+DPRHwBBjl402VGix8LJ6/qRHLZSzqP0ruJiiB7TLOsPWQw/a5+FgRqdYwBiNkGNT1L4TXRfzsDPuqL6bfDUxm6pSqz/hADv98Lv3OAlnBWI2FQ+6t1hZfyuX+R5ww9wI/Wz9d3nvyhoEH+wRAoxP4nDbaqt1BB67r3Ppz/YRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UYt5FVpWx9CGCL3RoQYiz39yliDSvkJGCuNN2LqBTI=;
 b=TvBRC9XkNaGHJ+QWjVerSruWyedNTo/fmnsGq0nIt5va6sfZPBdZIndwWS9E4qx5tsi1VQpIACUDeVxfqhfr8t3CUzkMgYg4UcFbP8JlrxbW6UcISN7VC1sWMAJhfeDfsjdhAXK+gMU/wm0D0XWX0R9ZQ/YJhlJrficLLLC1wyqmQ/KiaHvx6d2MDXk1/jcBGJYPqcAjI6TwhlNR23wu1SGWayapZ/oMQRgTft9TiditFPhEm1QjAIesYN9PjeafFYrzA4GKmC4bCb1wN13GPuyLF81YlDnJguC4QZFS9tI+4y3m3FITE6CQmKX+29tFAOeqrZ43WVg25wB0+pZx9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UYt5FVpWx9CGCL3RoQYiz39yliDSvkJGCuNN2LqBTI=;
 b=EE//Z5nqr0ABNLLmw1XYdnbB6kRvvDfR2A7XiFBRieWF8xy1jOodKAaJ82TsGlKonRkCTcA5TUdYe31ZZBQ3lf7x6uYogP4gbriCwqGnQNMOUHG3iYhqxdjFAkJz62IGnedEROJLSI4wV45Dy8JZy/5fOzsSd4Km7do5huu5sAA=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sat, 13 Jun
 2026 14:49:01 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0113.013; Sat, 13 Jun 2026
 14:49:01 +0000
Message-ID: <824dfd2d-cc7e-441e-9635-4004da298f73@amd.com>
Date: Sat, 13 Jun 2026 20:18:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: dma: xilinx: Fix "xlnx,irq-delay" type
To: "Rob Herring (Arm)" <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Shyam Pandey <radhey.shyam.pandey@amd.com>, Abin Joseph <abin.joseph@amd.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260612215226.1887726-1-robh@kernel.org>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260612215226.1887726-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::25) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c29e46-b3e0-42b8-24ee-08dec95ae842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	waT5zyGQX38Hll51QcwYNCmPJNxYw8Wf3n86QjUkDbYyty+8/N+OI2X5cVve2KYFwXOSbeGz+MZHO1vD/6A6CCUnh9WdFau9fJ/C4kh83C6YG5nl/yZsfKGAnf9ChHmqFO0/89wExZIWXYz0zTE+JuVbCwMHe+SDxkyiKUrdU+UDr87fwqS/si84jqgRvTf6MuzjRzVN9vSvg6XBTJI+rEXBhtgu0dAzH9uPqBHvu0UOdbJQN/QKcaLDtYKGZYLHC8yAXCg+aNJt5NEIffvGxLlsUF9OdB4MUNklYMylJuBpe+YuKCFKZURT5uBmSXIMRFa9gxsf2WV2P8V9I4xaWzjUPkFx0093mJ+ckeMJFiVtdxaHsyg8WmKIeQV1A81Rm1JJfNl+LkdMvcI/HM6X6ty4Y3Z5yM8t2gmwv9q+oOKh+EMVGXn98te8Jw3dIVcoIcfmxn1SWczmVQ5xl5qBvKdJsCd2Zb0GX8ghkcvow/s944od7Em/cY/aaK+qB0Wu3a7Z5EkwuCo29nHC3R+F4tSZT9606qKBEt0c8sXAcPxYC24g6Uy9iYS6pgvuPn8Or4gDnzsujyOPmwg2oL87vQg1KBGhrb2+iH0nR2Ei42nIywFVr9bv3v6SEuKslaIudmkAR2iioHyDRWEeOz94e1jzMmD/ald4Rs47CF4OqYkhFKEkZk8kbVunumkYq/Hd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnpWU0xES3BPdTJPbURUaTduamo5LzFwdW55ZjFYaUFEOEtBeS9JZ3RYUHJT?=
 =?utf-8?B?YkRHY1p4WDhFZlZWODNzSjZnZExGQ0pkQU9OYWM0MGVScjdoQStpN21IeTNt?=
 =?utf-8?B?ZGVtZmMzUU10bFdsUUYwb2xBcVBSUVVaaVZvc2t0VDZqeDNwK2tnZHBLWUpr?=
 =?utf-8?B?ZmhwRUdEMVRCbHhrMTV4eFRtdXZaQWtJT0Q3anBSTGd1N2dLSkxNeVdCS3BK?=
 =?utf-8?B?VWxkclV2R2Vma3ZpR040bmFRb0RYS0prMnNTbXdpelNjcThqckNXUU14MU8y?=
 =?utf-8?B?b2VWQkxxTGxiN2htR0owVkc2WEw1MWxTSHVMUXYwQXoyMEdLenljTjMrU0gw?=
 =?utf-8?B?aFpSbzFZQjFtU3F3c05QKzBOSTBGM29sRFdZR2xoVUZXQnVoN25GbUd1bTdL?=
 =?utf-8?B?V2Q3UmV4SmVuOEFjVUNYMVBzalczRGg2VnpzZHhkem4wZWRRKzZ4c1c1L2FS?=
 =?utf-8?B?WEs0aFdJNEtha21OZzR3M0JnUkV2amcvdGFYN0xuSHlvc1c0dDhSczFWVFNt?=
 =?utf-8?B?Q1JheGlEUnYvT0lwemVoVG51WGV0QnhuWlVJR3NwN1MzYkFDM0RNMytEbVlS?=
 =?utf-8?B?VVpLY3pHcTQxbXo4U0tLbVllcWVVZUJ0UmF2aU5NQzVIdGY3Zmp4eWEwZlNi?=
 =?utf-8?B?VHNid2oyeENkYzZmV2pNRU1SeXE3a3Uzb3B1UW9hVEtEbklwVENkcGRuUWVw?=
 =?utf-8?B?MGEzZ0swNDJtcGo5QkFROElPTVJrekFjeFZ5d2ZBeVVPYmJIMlBKZGgxQzRX?=
 =?utf-8?B?bUhRRHVVckF1cjliWmtaSmJLQXJGcVUxME5HSlJQNWlPS2JobjRxb2VlTzE0?=
 =?utf-8?B?YjlWUDFnRHlDOGtObURBeGRBRHVxb1pPbnh4dWVPKzB6UnVCVFRZb09TRlZr?=
 =?utf-8?B?QmwvNGMwNFAvMnM0N1FVc2JMbVRQL3F1eG0zNTQzSWJna29nUjNGdFgrU3B5?=
 =?utf-8?B?d3ZUYWsyNDc3azByTTZhaHFvbkxkOW9GSWpWZ3A3bDJ6WS9jV3Y0WWVRT1g4?=
 =?utf-8?B?dXdMeXJ3KzV1bGJ6VFBSNlFHL3JEYkFqZlgzaS9jY1I1YlJLeGZNampEdW0w?=
 =?utf-8?B?QlE2aG5NVlhJbzNPcVVkZGlRV0R1NVZGUHVldjBVSzJqRmVOQVdob0Z3ek9H?=
 =?utf-8?B?alpEMlpnbUtDM1piblZvL3JaMml4K1ZzdTg1QXZ1NVJFTDhmMnpRYlFBTGRj?=
 =?utf-8?B?VlgwbkI1eXVvRlErdDF3TWFOamtqcDN3TE1WbzBtUFp0RTJRMENsTlZOekRp?=
 =?utf-8?B?SzMvaWdWblFLK1FUVUY1UWMrY29ZL3AycUx6WitiN0kwZmdDOTAxUk1pMkVQ?=
 =?utf-8?B?bU9ERVFSeDVDMU8vaHM3eTRwYldtenBGRFlJNzFIZUErc1FoK3pIUTVBU0FN?=
 =?utf-8?B?eENXVHFkdU5LeVBoSC94YTg5UlR2d0N5dzNPZWZqOG1WS0VtYkhhc0wvMSt3?=
 =?utf-8?B?bUJNaDBIUGFtYUxaem9Ya1FIVHFiUnM4WFNvUUZMc21iQjBKc1htenlnN285?=
 =?utf-8?B?WU5YNXBiZUNxUUp2NDUva3JuWCtkbVlmQThJWDVaYmFDYldRS2I0YUlESm4v?=
 =?utf-8?B?NlZUMjYyRTJ3bWg4UERFdDBObEVlaXpyb2h6dURPMkVEV1hjT3RRVW9BSm83?=
 =?utf-8?B?V0FOM2xQTlEvUkZpR0k1T0c4eDhtUGxLMEdmTC84ZTNSK3dBYnJ6RXp2SXFO?=
 =?utf-8?B?S21laExqQkZCVGZnM2Y3VC80T0RKN2tQaEtKWlYyc1RFZ1BkUnh1dmZId2dI?=
 =?utf-8?B?NTZOV1duYmgyUCt0RHFQVlRUdXRDRDVEWWJWdUlsTzhmNlIvWHo3S0p6QWhB?=
 =?utf-8?B?UTF5Ym5OMHVvNjd3c0dVeStkMDhYbk9tL2pPazF0OWlKQ1hxcjlJN2x3Rlcw?=
 =?utf-8?B?OEdQcEVWWEsxclhFZndZSVhqMEpxbWtzeHhFekdiOXQrRTNCZ0VsN2Z2eVNz?=
 =?utf-8?B?bVJGSlVGQUZONjZ1c3hiK2ZoWW40M1VDWEVjWk9Wb0V1SDJLZGdORU41dmdp?=
 =?utf-8?B?TUprTWFteDVBcWNwK1BKUmJ6eU82em5pNDVKMnlVN0E2blZ1YlVsRmxld1Z5?=
 =?utf-8?B?ZGJuam1OM0VVRXNYR1FVUVI4a1A0SG5UeHVIRCtoYnFobUFoL1hIRHNJS0Fv?=
 =?utf-8?B?bnIrN2NHdmFIakgwSHNuMGcvdU5GZUV2czgvRFdPZFVLYy9SamRPMlhVSklR?=
 =?utf-8?B?SnoyR0RWcXcyWWNydThya3kwcXRPbnRSTlRFQWNkeUltSG1RL3VRYjJzRGpR?=
 =?utf-8?B?bXJRQlZJQW1sdXIvMU5KcTJtNENMN2ZZSm50bWk5Y1NOVzlTeHBaUlljRmQz?=
 =?utf-8?B?bDBZQm9yb0NJNEFhWmpHcUFVQi81Z1E0U1Jhd0h2MFdVVzk4VHNLQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c29e46-b3e0-42b8-24ee-08dec95ae842
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 14:49:01.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k36Z1DSQ882GjNVKMK+QLrPmGVDZ396mIZCZUXyAeTxZBqSZUAL7yqN2jfJHk4vp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430
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
	TAGGED_FROM(0.00)[bounces-11501-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:michal.simek@amd.com,m:radhey.shyam.pandey@amd.com,m:abin.joseph@amd.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE3F767ED25

> "xlnx,irq-delay" programs an 8-bit delay field in the DMA control
> register, and the driver stores and reads it as a byte. The binding
> described the property as a uint32 cell, which made the helper type
> check report the driver as wrong.
> 
> Document "xlnx,irq-delay" as uint8 so the generated schema reflects
> the hardware field width and the existing driver access.
> 
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> ---
>   Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
> index 340ae9e91cb0..ba0fc515d825 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
> @@ -93,7 +93,7 @@ properties:
>         Width in bits of the length register as configured in hardware.
>   
>     xlnx,irq-delay:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> +    $ref: /schemas/types.yaml#/definitions/uint8
>       minimum: 0
>       maximum: 255
>       description:


