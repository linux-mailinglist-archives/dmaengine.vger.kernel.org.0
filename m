Return-Path: <dmaengine+bounces-7815-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1838ACCE393
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 03:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B72DD300B6AC
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 02:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E30F23EA82;
	Fri, 19 Dec 2025 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="j37bG41f"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022139.outbound.protection.outlook.com [52.101.126.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545DF1EEE6;
	Fri, 19 Dec 2025 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766109862; cv=fail; b=i/7Cxy+lFoc7eF74UsfJ4YIefWrWsYaeZdIv39Uw96J3cF0YrAZvWSUftdAP7JVuYqdV0x8MeqYw/JYAHGAod2UszOKM1d6YF8+hDLZ2kTPDevVqQLKDupNZjiXA1z4p7Fbg41gBSs5w0Nm0W/MS3nlxeAYQyDBbQ3ZOPuVVHzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766109862; c=relaxed/simple;
	bh=arTPAMnRp9R9gqxGTGpSzmbL+Iq9hMzo4jzNE9VZPYg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TtF5b92ruof30gZCNzpOUAPutzlqyWdqHX30W8O5anVlZC//+kD+/4XG0xu56kvjLx3g0Nc9nyU87Y59acu613Of032PfQy2zTnNht3JeO6MueuJRWMqxR9MxbSIhDipGyfS68quBp5dp3QO54CE1VgD6FKTGmAnvYzJHd4taDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=j37bG41f; arc=fail smtp.client-ip=52.101.126.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEvyi6ynJLYsYJlcnyBHySD622ojthfdIT37QSEItAWXeE/t6tFaL5Q4zkaHhZm8X1T4zpnBPnegBvBoGf10mWaSLhaMGhQDqTpsFCp6KomHBwX+Z1/A3SqV+7e2NOeA3LkF2/dvtsnaUc9rpAZkIMNzy9eTJsGOFXH1ZmpZdYjO9/gCzC8yybmGzPnaBIhaaiDqYr0lyfuK4KDpwODsHcWmvesHT+1n4shQr020t3v/DdkzDOYCvvKWatN+5SarKzPshFXnt4K0beidKuEfng7Mzx1FmEB14XnhJFx5vlYAvbxHD17JqJ8vggtPwRI+ymVScmqxQWnuILuKbZD45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chmy+u3NPqJWpYqGq8HcgCxOyux8xty1xe5oasKUWDI=;
 b=ijp5rardA7GEvLYwWRWL/qwkHThTr4wj1JaNxkQnBwN/eAWPGbQaStpP52Z4+f4G2GrNKXzFOkODM5TDO1hNPVluMR67PohBtgHhX3STidAvqPh2pZyAI6Q40WfRcfvtQKk/sJAaClCEWTMWqY5PE9fy/do7yIlyYl092vN/HhQlXyiS6e+wLrZWbZSP0+nDyhFb/SaU3/S0LZ1Iks3kUMFnMxt/LpztyeFHeYCW95Pz6tHbuY2gXikIB4Q5hVVsyLjKlU/AOSpc++HsIpWr7yyX48k2OknHqB4pEfhf4FZrRdx6MYMLogCSqbMPVPecvTEZfDAObR8u6ZehwwS+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chmy+u3NPqJWpYqGq8HcgCxOyux8xty1xe5oasKUWDI=;
 b=j37bG41fCzcgQPirJ7x0Ac9LsSfXmufYFJVsdCY+t34hAsXDSxonhp4whv/NUIBXoQ0oj6gP5NoYZYLTq9MGX2vLMoksH+gkOCTSqkY5LXVCQhij21g+EZZx2vL3Vgp7NrdSKM1sWspd/GDOyK9GUU0uXT3v22VCgYpRQyAccTLZP3H2tT2C03lCFpM07A1KQG02JE51YL0yJIpP/MJqgYcJaX+PwkVQwo94aIhdaGXLMhsGQo7x4Sy4queyPSNMKIoo8Kst2kZIvfEos+Te/lLfkmhdVvr8wPiuKJMvaeIochwAA5h2VwUldG1mRXaOrD2bKlBUB8HNr1Nhya+EOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com (2603:1096:301:100::7)
 by SEYPR03MB7249.apcprd03.prod.outlook.com (2603:1096:101:c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 02:04:17 +0000
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::5fc1:b7a:831:340f]) by PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::5fc1:b7a:831:340f%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 02:04:17 +0000
Message-ID: <d8a81447-d16e-4abc-a115-5c05ab506792@amlogic.com>
Date: Fri, 19 Dec 2025 10:04:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma: amlogic: Add general DMA driver for SoCs
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com>
 <20251216-amlogic-dma-v1-2-e289e57e96a7@amlogic.com>
 <176db27e-a689-4de1-898b-527420bf68dc@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <176db27e-a689-4de1-898b-527420bf68dc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0218.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::17) To PUZPR03MB6888.apcprd03.prod.outlook.com
 (2603:1096:301:100::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB6888:EE_|SEYPR03MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 792959ee-af9c-4a27-fb8c-08de3ea2ea24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHZNRjlkUFBkYjFmK3BHbjlqZ2JnWFllbnNBdjk2Qm5DMVdXNVovY2YyeVBC?=
 =?utf-8?B?QmhrZm5CYm9QZnYvaERRNm9CN1MzYjc2LzJCMTVYV1hYOGVsV3lObjJzVE1P?=
 =?utf-8?B?bGhsdGg5YWJjSjdMbU5FZmdtL1RFSklBV3A0SnlSdXdwN0w4Sy9RUVA3RGsr?=
 =?utf-8?B?SVRMcWMrZGo1WnRTTGxRSnlORlhJN0lBUkhVUWl4Um0vM1Q2Si9jQTRrdTZp?=
 =?utf-8?B?bzVuaXJtSjc2UXNWeU5iYTJ1bm5XQ01LRXJleDhoUzlGdGV1Z1ZPYkhCSEhI?=
 =?utf-8?B?Skk1dmdyWmVKTmdVRVNUanliUlFsNzRXS2lhV2ZMYnMxc1JGSmV3cTFGcUVZ?=
 =?utf-8?B?dWVZMm9zNkJabHNUdUxNQmtZUDArZHAya01YR3VqMHE0emZWcXFYL0xLRGda?=
 =?utf-8?B?L2RXRTFYaVh4azNKQU4vSnFGWHFFK0h2UTlsc1pPSFJkanNjQ3hlVmNMcG1C?=
 =?utf-8?B?cWNUVGpSVjlueUhLNnVRNmFFdDY4dmFnSEp6RDVrL0xwNXNqUXhCcE5aRzB0?=
 =?utf-8?B?VFB3R3d3aEd5eHMxNm8xR3QyS0tQR2R5YWF6WUxHdEpSSXdpeG81ajMvTy9U?=
 =?utf-8?B?N0YzVzFud0p2VmtUYVNITXZ5MHAvUVQwdFY1MWE4TEZSRkZ6VTJNdlg0dXBy?=
 =?utf-8?B?Rzd3ZXBEbGJCOXRsTXl5ZGhBUFV3eFRGUWxIU1BnMDdpTjdlckF3cnZGVnBG?=
 =?utf-8?B?T2FTWFZCdkN3WGZRMXhpVXY2U3Qwc01WQlhCNXdPMUJGVCt1ZU40bVpXUGlG?=
 =?utf-8?B?SG9Bc0ZJOFNDMW5FRnN4bEs4NzlwcDNac1NDV2dUc05xWXlUc29DTEZqYlNl?=
 =?utf-8?B?am1BTmVRYUY4UEpucmVubEtzeDZZMG5SbllxbWNRQ01oNjVtWkowZnNtcWdO?=
 =?utf-8?B?Z0pDaS81ZnZxYUNFNlNJdlJpdllQaEJDNUFoNFBFeGpRVldSZW1kaGlqSDVn?=
 =?utf-8?B?UHJtNFJvTFhCTG94MUh3ZTFFTkdMSnFybm40UHZnRHZWK25ZbGZsamV0b3F6?=
 =?utf-8?B?MTZjNVpURmJNV0JLa0s1Q09weGw3V2NyOHVhcXBKM2xlYXRUSUpjOHBNaUNo?=
 =?utf-8?B?Vk9YWGFtb3paTjJaR0tGSnpTM2k3UG1McERPRzFkcTdVcDFPSVdTaWtqTlAw?=
 =?utf-8?B?ZEFDVnhHZ214UmRScTMzV1RvYmV3b2YzTmR3MDVBZkVZRjFHLzFXQXV5eEpD?=
 =?utf-8?B?QktyeHd1VzI3Nks0TG5sY3ZMS08wbVFJRm5QKzNUelMzZEFOTVZxYkdvY1Vi?=
 =?utf-8?B?SGJJZEpKTnBhZjh2MEd4RUFIMTdCOVFhUURRZWNGVlJPTEo2djd5N1dJRzN0?=
 =?utf-8?B?ckFPOXEvNG0xdmkySlRXZVhaM1lId1pHZ2NyRVNmYURrZXZWcVdIWHNEUWho?=
 =?utf-8?B?Sm5mYzBtcjBVc05hMm1hbnZPUE00UEpDSTNGTWs4Ukphc1lRdXBQdnFmeFM4?=
 =?utf-8?B?UE1GazcxTzJxd1hmYjB1QVFLSC8ycjMwUVgzVFU3aGZDaStFSHhVK0N6WSs3?=
 =?utf-8?B?RTRNUHBrYlJhandJaUw5RGZzby9rSjYwNjdjYnlTbHEyTlJ2NHpBVGdSaTFT?=
 =?utf-8?B?UHZ2NFVRY2QvOS96WDAwNzVMT3FIcHM0YVVYNVhrTUFTZ3UwN2lxRlJGYjN1?=
 =?utf-8?B?VElIMTJTb2RVUldIbUFhZmNPUUN6N1UrRkNlaFVNMUhmNkxlT3dSRERydVJL?=
 =?utf-8?B?QlVBZ0YwZlRaRkROaTg5T0hnZ0ZvVXJqSHkrME82WWVQVGY4ZGtNbzhPcHlR?=
 =?utf-8?B?WWUxM01GR0FQdmtqNm94YmxMbXNVeW9nYld4Z3BUNkhscjVJMnU4OWJ2RzJP?=
 =?utf-8?B?STN3eEFONlcxWmhmWU16bER6eFduUUpjNDl4bktvVmkrc3VyQjJiam1PY2Iy?=
 =?utf-8?B?N21rbExkeHFkeVlBOTVWMG45Um1saTRPR1N0YXBFcFo0T0doajZKZjdBOHAv?=
 =?utf-8?Q?msVyD+mTMTk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmZaQWxTVUI5aURzcDFVOEY4dDJGRkNlZVNwU2RLa0ZGYnZEUTJPS3plTGVJ?=
 =?utf-8?B?TXcvQitaVThieGlCNm1Ha2RTK3hjb092K2JmYjNWOXE1ZGhwUXR4disvbkpr?=
 =?utf-8?B?Njk0ei9qeGJaTzB5UGhWak5aMlRENnFEeUI0Q2V6VEdGcEoyelJPejFkV2JD?=
 =?utf-8?B?TS93eVlpdXhTL1JXNE9aQkJHNzliQ1NSMDZlbmJ3REh6U3VocFA0WHFIRUZ4?=
 =?utf-8?B?UVU3bmtmSkM3c1kwdlFzQmJaQWVYMHZUdDFWRGJ0Y05TWDB4ZURSak9LdVpm?=
 =?utf-8?B?Uk5uRzhrdlVkdUtpWVAwWUdoOUh4UWFhdFBQV090VTFRTEZQK2VadDA2NGg4?=
 =?utf-8?B?c1ZMRjI1RDcweDBKcW1FWUgyaXpIU0UveGlaNUhSL2ZuZ2VMZ1pNc3czbzgz?=
 =?utf-8?B?OUNBak93MENySk15L0pKV3JTMEVxaDBBaVRvMmZ2NkE4djQwdW1OcTZ3NC9M?=
 =?utf-8?B?emFrdG5Ya1lmTkszVzdQMWR0dTkvL2lYN2hFWHkwWDZZOGc3T0ZoR21yclds?=
 =?utf-8?B?YlFNWWZkbmtZYW4zRTAzek15TVBwQW5ua0xOMG4vamZudDNWTWY0WVNVNzRX?=
 =?utf-8?B?bmpUVVpsa2krZ2p6bVVONWQ1dFRQeDY4MlFTanBrblFicTNJSUxOcTNsUTRC?=
 =?utf-8?B?emorTFc3ZzRQRmRjT3paakhIa1FWUGRvZzAyREVtekdML0xoT2ZDbGRwK0VS?=
 =?utf-8?B?S25pems2bzE2b0RqZWxlZzdDQysrYUo2NDhWV1dNZTNUbkwxS2ZTMDVPYmxY?=
 =?utf-8?B?cms3bTk1c0MwQ1REbjFLTTNwTG42eEJTS09iVEV3Q05RQmJ1V2NUS0RkUTBO?=
 =?utf-8?B?WkQyaDh2a1NLSS9RVUJQMjFkaG5hYnk1RjkrWHptalNTZDNLR3J4Y05wSFFo?=
 =?utf-8?B?UmVtbTBBa2lKL2U0aU5SUFJtc2hmOWlJV09wRDgrYU5LUUhsUkVoQU02T0ZU?=
 =?utf-8?B?K3ZnRllMRjJ5ZWUzemRlY01ESmZ4L1UrYS9hejE1eDFPNHJVMktscVJuZnlk?=
 =?utf-8?B?TVE3d3lBSVhkSUY5bDBrUDBlem94ZVlsc0xXZkExOFhqQTg3Z0FhNGZ0WVZl?=
 =?utf-8?B?V0ZwcHh3M1JzWC9PeDFYQ0FGWDNYUC9DMmh3WlRFdXZmdEpXeXpSVnk4R2tm?=
 =?utf-8?B?Z25mQzFlR0twbTVKV3ZXUHp6Nk9ESXBxZVN6WEJhU1psaUtLMnlSKzE4T2hF?=
 =?utf-8?B?QjU4amIvbnFFaUladDlaV205aG9YaW1JYnBCa25EU1VBNzRSY3hYSWhDdWhM?=
 =?utf-8?B?YlBOK2lUODc2RVdGUVZtUUY0d0RCak13UmVSbTQvcG13bDdPZ3dWWFJmTGwy?=
 =?utf-8?B?VjcyN1pFaTUvVzhGTFQ0OXJ1S3k4RUl5V3hPU0RtYWtEZDZ5MzU1azc5UEZE?=
 =?utf-8?B?UjZjTGkyRVdtd3NvZmV5YThhdm9PVzF4cEZ2RGdmQUV5bXVDR1I1RWUzU3hJ?=
 =?utf-8?B?TzNUS0lBbytvRmlKcjhiNENNTFZ6YVd2OXZjTEZVN0JLV2kwWi9CWENMbGtV?=
 =?utf-8?B?T1gyYTdvM2VEaHIvVHYyVTNpWXY2NGJQWjQxVGxkTU14bUhIdm5wRkoyeG1B?=
 =?utf-8?B?Sk1NM0JGMWRqamJlQVRlQnFwVXd3L0VIVHd5a05XVDlEa0FMalVwVlhMVnRi?=
 =?utf-8?B?YmtQVkNGZXJ5Yk82bTYzTklXdVF5bnhJQWZaREZ1cVVFUGlmRzBOSVUydDJJ?=
 =?utf-8?B?TEZwK3N1WEZVN3N5S1p0TU5PWXJIUDR4SFAzUHF6ZjFLSDVIZVJld0tvSEU1?=
 =?utf-8?B?eDgvTzFmVUtQb3dWNHp2Zy9sN0owT3VldXZmRzBtSnlSSWkwRUg1UEtmcjFm?=
 =?utf-8?B?cERHVncvaWU0VGxkTktJcTdCVWJTRCt0b2M4d0VOV3krZ0FxTkMwQi9VdHNK?=
 =?utf-8?B?bEI5TlhIYURtWGxnRW9IRkNVcHpZMzRPYjFObXU4MmxyRkJXUzdzQmlNU3hM?=
 =?utf-8?B?cVB4S0psYVMyajdMWFZLOFg5ZzZQcU5VdDlNT3gxUm1UMDhsc0FKOWhsa3Yy?=
 =?utf-8?B?WTE4OW1pWnlLckw2QjBmdnlDZ0xHdi80VDRmV2NQa29qckpIcjZieDdjTzBy?=
 =?utf-8?B?bjhkQlBQSnhqQVhUWWJoZ3VCZjVZQWFjNkk3UlpiNXUrR05NbGxwSDNFTFpo?=
 =?utf-8?B?UmZxT0wzMjExQXJVa2k0MnJkejRQb0hWanJ1eHlPL3VrTExPN2k4dTRZQVA2?=
 =?utf-8?B?Rk9OejB1eWRCemNTVW41Y2xsbVhxQ2xBbzRvdWZtWEY5V1NSdXRSdUU3TC9K?=
 =?utf-8?B?eWV1aFlyR3NibHpBc1JyZFhKL2NjOWQwYktOZ3R5UHBmZEZ3d2p2SGcyWE93?=
 =?utf-8?B?b2drOXV3ZGY5RVo0Y0VkRDRDTmRLTXhzbjFTbkJldGhKVG9PT2Vodz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792959ee-af9c-4a27-fb8c-08de3ea2ea24
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 02:04:16.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GIQ2/v4BXClaTw1cx00LSdm7ml0uLvEl186xf3aNlABQpn5CSjbKJa//Ci9lAMKNnVuUzQA4wZh8XyAGIJU0wEdprkBkbIOWagU4sktbNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7249

Hi Krzysztof,
    Thanks for your review.

On 2025/12/16 16:46, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 16/12/2025 09:03, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Amlogic SoCs include a general-purpose DMA controller that can be used
>> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
>> is associated with a dedicated DMA channel in hardware.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/dma/Kconfig       |   8 +
>>   drivers/dma/Makefile      |   1 +
>>   drivers/dma/amlogic-dma.c | 567 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 576 insertions(+)
>>
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 8bb0a119ecd4..fc7f70e22c22 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -85,6 +85,14 @@ config AMCC_PPC440SPE_ADMA
>>        help
>>          Enable support for the AMCC PPC440SPe RAID engines.
>>
>> +config AMLOGIC_DMA
>> +     tristate "Amlogic genneral DMA support"
>> +     depends on ARCH_MESON
> 
> Missing compile test.
>

Will Add it. depends on ARCH_MESON || COMPILE_TEST

>> +     select DMA_ENGINE
>> +     select REGMAP_MMIO
>> +     help
>> +       Enable support for the Amlogic general DMA engines.
>> +
> 
> 
> 
>> +
>> +     ret = of_dma_controller_register(np, aml_of_dma_xlate, aml_dma);
>> +     if (ret)
>> +             return ret;
>> +
>> +     regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
>> +     regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);
>> +
>> +     ret = devm_request_irq(&pdev->dev, aml_dma->irq, aml_dma_interrupt_handler,
>> +                            IRQF_SHARED, dev_name(&pdev->dev), aml_dma);
>> +     if (ret)
>> +             return ret;
>> +
>> +     dev_info(aml_dma->dma_device.dev, "initialized\n");
> 
> Useless message, drop. This does not look like useful printk message.
> Drivers should be silent on success:
> https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/coding-style.rst#L913
> https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/debugging/driver_development_debugging_guide.rst#L79
> 

Will drop it.

>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id aml_dma_ids[] = {
>> +     { .compatible = "amlogic,general-dma", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, aml_dma_ids);
>> +
>> +static struct platform_driver aml_dma_driver = {
>> +     .probe = aml_dma_probe,
>> +     .driver         = {
>> +             .name   = "aml-dma",
>> +             .of_match_table = aml_dma_ids,
>> +     },
>> +};
>> +
>> +module_platform_driver(aml_dma_driver);
>> +
>> +MODULE_DESCRIPTION("GENERAL DMA driver for Amlogic");
>> +MODULE_AUTHOR("Xianwei Zhao <xianwei.zhao@amlogic.com>");
>> +MODULE_ALIAS("platform:aml-dma");
>> +MODULE_LICENSE("GPL");
>>
> 
> 
> Best regards,
> Krzysztof

