Return-Path: <dmaengine+bounces-11576-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YTTmE1OKMmrv1gUAu9opvQ
	(envelope-from <dmaengine+bounces-11576-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 13:51:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBFA6994AD
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 13:51:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=UsNTJtqM;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11576-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11576-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B12231BAC10
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18E92E7387;
	Wed, 17 Jun 2026 11:32:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E17933FE0D;
	Wed, 17 Jun 2026 11:32:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695965; cv=fail; b=BUoShaDgoCxTcFOeHT4FsafbRlpPc5rVmS96WF9he+nPJICyRv44ds7+HHF29/3DspfltASSmHuv5u3PlaUgUP09sC4+nawAEh3ty05idjvziyEWos7le95Rwqdfy5LY4ldn7HK7Xc3PxxcuosfXPhuWNRI9kTe0/GosQC5AkAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695965; c=relaxed/simple;
	bh=v+tOTQsyF7VeVljVK4PxHKDRLdBGtLpEN+NZsumJjz0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XaRXWoZZZqJXJ8pa/Fx77V0sOsWuTU2AdZtKp+PaMOYTtBtp8E1fFkTOH8bFLGdcBTE5kyPyu7vEPBtlLknCHhPrgcHoDfZ6a/wiaZSQikt/LAVpWZHq1+EBwXr6qWKH2hVvvcr4fb8BvTCuVoPdyJW94TZwiVUrXwsp/CGWaNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UsNTJtqM; arc=fail smtp.client-ip=40.93.198.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBZ0p+2V9swMKrQi1887Y8HVvzh5+n88M72BRR3gttXvL6qv2/GhZYZ8vxU4zzRhIsRA3NLX2pyRAq5g2ZHsCQe/iy5v8o2SFwfKCIozZ4i28YoZDORJCZgInIH7UgmQxFNRji9dLpx/SCkekY3O6MYUmIpMjKmgDiIR0NLPj62sJRVig3PYFZ32HAtyIdipbvWT2Va1tgRRA1qAN3GYuc/1+IWGqLOyuaOMLPUhOWlBZPMK2IcSjmeEOeKMfob+fnGv4OURawuYKEXezMSRuNhTzm3rQfwyyVIaCSPEc2dqqeMLW/f2bXiagD4WT6yRZAKyJ/wfhecv9AwnsTvAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMfzyISPMH57VbYXMSb0TJWmlb6cP/WkxRbaB5pfjBM=;
 b=brxPSFNTURAWkb7pXHF1s8RSyTcHAnVjbDr6Ic5Kh6Atk3WnAMTXP7w9OwcSxqATlMx/6pF21WJuWvmnxZ2ype2ygVTNHl8ZotEc4Xim3lRSPHL74FBByW+YVu4IyTwtMx52Lbc+hHXh7N1S8TemQ01wzEf0QooUbndMrqvwWKtolUPX08hOEQfr3EqGWx4xhku/EJ9HR+rkk2TuxznVfUPu8wNbZ7Mnv4C8jpXSy/Q3USTxEF4AQVTbB8EHHStAhO612yE2qgxwIvkjGeLjjABfUNz2psC4J3oPkzzvXgCyO/BoTgb+u1kAPYvW261mOj0sMd503TVVUO9waaNG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMfzyISPMH57VbYXMSb0TJWmlb6cP/WkxRbaB5pfjBM=;
 b=UsNTJtqMr/WPOg7QDWBBhtAicpqURWeSyndShgauQHCgQe0nQrdbNjDzweL68WNEWOAfnyG9+iNsBmZy6ZNtIwzUX/4oBetNqSbtfCsK2kuYwExrpI4Ajn/NWub8vGgHkeAQ9IoT8v6SjCRtOJBrMdRGepvzj3FiGgqCjRoFhN8=
Received: from DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 11:32:38 +0000
Received: from DS7PR12MB9503.namprd12.prod.outlook.com
 ([fe80::62c0:6aa0:897c:44d9]) by DS7PR12MB9503.namprd12.prod.outlook.com
 ([fe80::62c0:6aa0:897c:44d9%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 11:32:38 +0000
Message-ID: <a9359a0a-a10d-44cf-b204-d4f185edd5f4@amd.com>
Date: Wed, 17 Jun 2026 17:02:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/2] dmaengine: dw-edma: Add non-LL mode
To: Koichiro Den <den@valinux.co.jp>,
 Devendra K Verma <devendra.verma@amd.com>
Cc: Frank.Li@kernel.org, bhelgaas@google.com, mani@kernel.org,
 vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com,
 "Verma, Devendra" <Devendra.Verma@amd.com>
References: <20260318070403.1634706-1-devendra.verma@amd.com>
 <20260318070403.1634706-3-devendra.verma@amd.com>
 <zhpsuwq5agslelgebbtvrg4uks4xweov7ywhmkxdngq7lzajip@e4umiii6kzko>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <zhpsuwq5agslelgebbtvrg4uks4xweov7ywhmkxdngq7lzajip@e4umiii6kzko>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::14) To DS7PR12MB9503.namprd12.prod.outlook.com
 (2603:10b6:8:251::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9503:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: d632d4ca-03db-4a66-11f4-08decc642237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qXFzwtPT5NAzma+BRa/ikAKWo4TxdSB0BNKdgUJxvRt8BZ7bvSLuby9MUa93ed7mjXN8L/DsPB5KdhkUy8d4RckkPa0GF8Xzr5uTo6eSAvvQAnCY8FtqFVmykJ3mkizEtHfSDo4K0Y/29HeSm6FA9Nr11A/fZNels/vpdJ1WsVGyQtWqP4en5/oG18ZYCEgqJ4w4PGZux4gdXs4yhPb4Xq/v7Ht3JYE1M82x25BCbA0G3ATIeNHBKwus8jjYYvF5wA6D8vIShIGmwnwsHdxFna+NTtIcW1ADfLT7tPjDDQj4+vo81gHKA2bFFve9fRyJiRKfvSWp0OSMOXxzW9jxP6elUDW74v1Gi0+rRjEX3pP+n/g5f1kc/ltyHZajswrO3q/qEi9LDqAcia3xusQrCKWTWjb1MVeG0mwJ1Cp+bXRSWXIlWRhANC3HbmYrJx2hRCza5oRVrMWSFeWQDbdrsWtbOrpQ+v+a+o2LEGmeJy0qZin9vpn2oU2K/ssW4CvfIxfdx4FunIcYQzOhZSNHXpedBiH2Jt5Pjtdttu0VuWMvD7oE5TT8cvzEH+8hBGQjVDFnUcvx048hUW2hG+4Sdc8Kfc0/cdtGRD5MDNOzEJSnSRf89sVwUTv2HNEBjyYTnwusFKJy5epSKGnU2mrnE8SvPGrj4x6H+bIkDdtpatUICxAJizLwiQl0x4P1mTOOzT2GvHCV9SDjkT2BsyxKOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9503.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTVnVTZqbmpWYWIxbUg2d3JLQWZlMkwvY05MS1hYbWE5cHV2Z1EwNUlVcnVn?=
 =?utf-8?B?SVFwc1Y3VHJiK3k1dFE1WHhpeC81WnRiTmFCaE0yOWFkVVZGSDdzbXBCNGgw?=
 =?utf-8?B?UDZBYk1BRkNxb0ZhMHZwRXJ5YTNCSWNBaWVSaTdkNDFSQ0ZuQmlhZ3JHYWFH?=
 =?utf-8?B?ZUJ5T1ZtMlNKWDdOSzVLdE5sMUVJUU1JUGM2R0hVMnN2cHVLeFdQQUhzNmxy?=
 =?utf-8?B?YkdBT3BqaCszb0R0a3BmMUMrZ0taRExDTEtmYmJvT1Qxc0U3UFdJRC9id3ow?=
 =?utf-8?B?WWF1dHhJYkYyOUEwVSs0NjFlZGltMDNERWh4ZGpMN1NoZ0lkZzkvR0cvUjhX?=
 =?utf-8?B?QlJaMEsxemFocS83SHh6ZnJLRUZCcXdLYjdIdWdxVjNsdmZsQ1dwOGpJakl6?=
 =?utf-8?B?Zi91Z3hHRy9PeXVCVDNUeWsrZ3JEeXpKYnI1VUhrSXBvZ0tiTjlUQWs5SWwr?=
 =?utf-8?B?YzlYaFcwdGd0Tmx4RUtpbWE1RXlKVHJNUm0vNnVhTzV6ZlBXQTZqN1BzRVl2?=
 =?utf-8?B?SFZBK2hzdFZLTmp3dmtEeHRvUjg3R3NxNFlyeStjU090dUNBWStIekxkazIz?=
 =?utf-8?B?V2NmMnphKzBMWTJTMXR1MnE5MDZMUDF4TGhzM2orWFFrZ1BrZnlOQ3RNRG5a?=
 =?utf-8?B?ZWZKZFZsenp2MmtCTy9UTVdwZlhsNWxqVk5QSGhrWVpwREFlS0dtb2ZzQmZO?=
 =?utf-8?B?Umc2a1hkdk5xSm5sWmVZNmVqcUVBSUt0ZEJVQk1ZZTVPKzJPSUV2UXBJaDVt?=
 =?utf-8?B?QmU0Y2F6Ti9tUjYwS25PU2dtc0pmZHhxQmMzQndsQ2MwdGhxUkU0ZDl1M1h1?=
 =?utf-8?B?cUxVTlYzSlhaLzFpMHFQdEVkTEozYWR3SlltMzVTWU5oTU51UWViNHVVYTVN?=
 =?utf-8?B?NEpRRCtxaGlUdy9HUy9rZmVhbzJQVUdzVzRGRHdsVm0xQkY3UU0zb21peGVJ?=
 =?utf-8?B?RU4wbmtyRFJzSzZyWUM2RkpkSkNNbnZ6VWhtbkE3TUF3L0RkZU15TXRyU2Fp?=
 =?utf-8?B?VFgyVlBqeWJGbUxFaC94T0ZuSkxTbEVFTkd2dzV4MVo4cHJ4cVJ6Kzl4ODl0?=
 =?utf-8?B?YnM0bkVWd29TdDF3QS9yVGtQdkhrNjhUWW1VNzdwUUVpYVJtVi9yOU5DMlB3?=
 =?utf-8?B?WktsTUpiVE9RZCtFYVdLSXc4dTlvblZEUWZwaHpta3BwcjBzajRINlRjWDdw?=
 =?utf-8?B?K05YREVMWUtidXlwNWgrQzA5VVhnaFZta3BTQXVSV0ZSZHpINHhEbXFTZ2tZ?=
 =?utf-8?B?NmZ2dU56bXZFcWpYUys1OWlNcHpTbkw4dTk0RUtsY0dGMGlsWmo4MTJPREFy?=
 =?utf-8?B?Z2NXUUtnd0g5Y25oRDFlNDR4a3RlYUUveGRid0pySzJ1QmxVZVF1NkI4Ym5T?=
 =?utf-8?B?TmY0bVFNVHBTdDRLa29ZUU5zalJxZ2cvT3hpYittbEhJTHI1TVBLdjltUHBO?=
 =?utf-8?B?UXg5TU9WNitNZ0E0blNxT2hXYkVQbFM2ZkRzWnVHWUwySGRqU2dsa2Nid2Rp?=
 =?utf-8?B?UDdMWlUwdUdQT2RPMk5FZHRpTmRqMkQ0VW5rQmZMYzRqcUgza2NEd25TbWxk?=
 =?utf-8?B?Q2E2N05uSTEvdmdRMFUxaG5PK3lVNldKQWQzRC9vTmJyd1NhM0tsUnJiNVU5?=
 =?utf-8?B?VE83KzJzUExKSU16QlN5V0tDTjdGTW1YMGdFSlQ4enVSbFJTanBCYlJvZkIz?=
 =?utf-8?B?ZzJySVdMU3ZBKzJhMXdCVm9PQjFuSEg0VjVmY2UvN0JLSzNJQ3h5ZHA4Z0dV?=
 =?utf-8?B?NFg1czdMVUw3UU1jMkVURGFiNU9EWDZhZE9NTHJ6aHhjdWtZd1JKNFA1MFkw?=
 =?utf-8?B?UVZVVk1GMUI1NmYwTXNkN0RlczBoZzBsWGFlallPMTJiMjRUaVQ4SVozcmU5?=
 =?utf-8?B?ZlJ5Z2w1dkR3OGJNanZHeVkwNENpclJNREpqNitkbzUzWEpqT21ka2p4RDNi?=
 =?utf-8?B?Z3JaZlU1SHhlSWREVGJJaVoxRDhsamxmdmIvWXBJSlJnbVhpQUdXZmRtVHJJ?=
 =?utf-8?B?bnB2VHIxOUxzQ1lYUHhZUUhOcDJCTG5KUGxkaVlIR0pTVlhkQ3ZNQjZONlNr?=
 =?utf-8?B?dUdNMmt4b01IUlNxSm03bEdCRWs0MVdMSm9sWW40V01JKzhTY1crckk3QUVH?=
 =?utf-8?B?UFNUUzJRZXRPT1NCT3VmMVFzaG5WQzJlMEtlSjRPVEYxSlFVNklFaXNDUUM1?=
 =?utf-8?B?bWZuYmNBYTRtcEdoeExwNmJSMWFLRTNVK3J6MkR1ZUU3amt6UTU0cVg4STl0?=
 =?utf-8?B?Smg5RFFiUzFsTGFLaG1zTHowVXR1L1BxQ2dPOVNBbjU4WmxpTzAwRzhSSkxu?=
 =?utf-8?B?ZW1TT05tenA5cUZrUmxhb1JSWEJaTndsTEZ1ZjFrOHdLUStEbERDQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d632d4ca-03db-4a66-11f4-08decc642237
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9503.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:32:37.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhAIxWA4p6917uQO3bXRy47HIIkYbzTIDBw3SeDYP5s7F85UKJRfGZfSJG7UAUk63XtKzy9QVZ3c9DHpRaOvoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302
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
	TAGGED_FROM(0.00)[bounces-11576-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:devendra.verma@amd.com,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,m:Devendra.Verma@amd.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FBFA6994AD

Hi Koichiro

Please check my comments inline.

Regards,
Devendra

On 17-Jun-26 08:47, Koichiro Den wrote:
> On Wed, Mar 18, 2026 at 12:34:03PM +0530, Devendra K Verma wrote:
>> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
>> The current code does not have the mechanisms to enable the
>> DMA transactions using the non-LL mode. The following two cases
>> are added with this patch:
>> - For the AMD (Xilinx) only, when a valid physical base address of
>>    the device side DDR is not configured, then the IP can still be
>>    used in non-LL mode. For all the channels DMA transactions will
>>    be using the non-LL mode only. This, the default non-LL mode,
>>    is not applicable for Synopsys IP with the current code addition.
>>
>> - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
>>    and if user wants to use non-LL mode then user can do so via
>>    configuring the peripheral_config param of dma_slave_config.
>>
>> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> ---
>> Changes in v15
>>     Rebased the branch
>>
> [snip]
>> +
>> +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>> +{
>> +	struct dw_edma_chan *chan = chunk->chan;
>> +
>> +	if (chan->non_ll)
> 
> Hi Devendra (cc: Frank),
> 
> Sorry for dropping a comment now that this has already landed.
> 
> I'm wondering about the lifetime of chan->non_ll. This patch lets a client
> select non-LL mode through dma_slave_config.peripheral_config for a transfer,
> but the state is stored on the channel.
> 
> We use chan->non_ll in prep to choose bursts_max, then read it again later in
> dw_hdma_v0_core_start() to choose the LL vs non-LL start path. If the channel is
> reconfigured between prep and start, or before a later chunk is started from the
> interrupt path, couldn't we start a descriptor in a different mode from the one
> it was prepared for?
> 

The mode is implemented with the intention that after prep, the 
submitted descriptor shall completed with the chosen mode. So, yes the 
mode is decided in the prep call and all the subsequent descriptors are 
completed with the chosen mode unless it is overridden by another prep call.

> (Note: Frank's not-yet-merged dma_prep_config v7 series [1] also looks at
> potential races around config+prep on the same channel from multiple process
> contexts, as I understand it. But this seems like a separate issue, since the
> state is read again at transfer start time.)
> 
> Should non_ll be snapshotted into the descriptor/chunk, maybe as
> dw_edma_desc.non_ll, or is the rule that clients must not reconfigure the
> channel while anything is pending/running?
> 
> Or was this already discussed, and there is some implicit restriction that
> clients must not mix LL and temporary non-LL requests from multiple contexts on
> the same channel?

I am not aware of any such rule which specifies that modes can not be 
mixed but it would not be a good idea to mix both. Let me give an 
example, in the non-LL mode the channels *can* utilize the LL-regions 
for data transfers. If for such a non-LL data transfer where LL-region 
is used and intended by the user then changing the mode after setting up 
the mode to another one can cause data corruption.
Eg:
Channel LL-region = ADDR
Mode set to non-LL -> DDR destination to ADDR to (ADDR + size)
First non-LL burst -> writes data to ADDR till size bytes.
Second burst configured for LL -> overwrites the data at ADDR with 
descriptor information.

This one causes the data corruption for the first burst.

> 
> [1] https://lore.kernel.org/dmaengine/20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com/
> 
> Thanks,
> Koichiro
> 
>> +		dw_hdma_v0_core_non_ll_start(chunk);
>> +	else
>> +		dw_hdma_v0_core_ll_start(chunk, first);
>> +}
>> +
>>   static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>>   {
>>   	struct dw_edma *dw = chan->dw;
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> index eab5fd7177e5..7759ba9b4850 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> @@ -12,6 +12,7 @@
>>   #include <linux/dmaengine.h>
>>   
>>   #define HDMA_V0_MAX_NR_CH			8
>> +#define HDMA_V0_CH_EN				BIT(0)
>>   #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>>   #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>>   #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
>> index 270b5458aecf..61d6064fcfed 100644
>> --- a/include/linux/dma/edma.h
>> +++ b/include/linux/dma/edma.h
>> @@ -97,6 +97,7 @@ struct dw_edma_chip {
>>   	enum dw_edma_map_format	mf;
>>   
>>   	struct dw_edma		*dw;
>> +	bool			cfg_non_ll;
>>   };
>>   
>>   /* Export to the platform drivers */
>> -- 
>> 2.43.0
>>


