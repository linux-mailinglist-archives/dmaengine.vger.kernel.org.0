Return-Path: <dmaengine+bounces-7814-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CDACCE36C
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 03:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE5563020CDB
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 01:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64AF271443;
	Fri, 19 Dec 2025 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="u92kvQpC"
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023073.outbound.protection.outlook.com [40.107.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C910A5CDF1;
	Fri, 19 Dec 2025 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766109552; cv=fail; b=BsZExQKLDSyZHBui+P+SlcxPBp/eKqyGXTkQOk+6L62upgxXxJ3O41uRvvJfS0vODR/1Vb9F2R6OUOkFeB/nikQS3LvOkq/J6KT6ZzpT+NBUaMabDssZ+zkWW0kWQOJag8vbzVdmi55mgHBhyydu7Mzwks7nAgPCRFFPhELdems=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766109552; c=relaxed/simple;
	bh=j+bHExTQAVmE0+NEaGE6Kwi9QoSQoxIS6d+23sk2nD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ot9PeHJnwJdAujtsZb0IPqDzmnlqYxNxcEFDW1TO75jleliG00NHWpJS4VYdhCtKDwHfdhJbF54o8YIjd7HA5PaYSXnrugYeWPi41eZG393PnhY6QLiPTt4VvwYg/sTyIOzLSl24Iak/ZO5+0wbChPbEkiZvRm930S8J0Fb3ZXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=u92kvQpC; arc=fail smtp.client-ip=40.107.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGfctZRk8GWiWxiV9Jmk/eGxFog5pk4KUq/CaSnUb5S3hRnFDKVwVg197nIzzQMauapaBGKay6jNSon1n3lV+nzcTV+aWMUKN4LmBDVXvPznKKpIsgDQgBL4agqtYrAilI2IIRjn+mPwjbKQGoJGIgQ5iDvJslKNMD3AAw9uQ/n/JmH3mnfabiyERu0odftucsI/ahOcw3yqdH8AJ7FnLyagLF0Gplrs7/wSATpwBFwQWF8CIkSQLB87+v3yFuWxTbNopj6sIN+6gHKlhwjBJUoEXkSVLZd+33Okyo+caR2xVIxOjNlFhfFrAwa8CwpV2fRaZVc4QcRCuz1fsmX0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFO16gC/JprhYDnjpX9RvnQCxAIfhmIyz9B44ulYMOg=;
 b=mBrkBQ7umtK0NfM2Vdjxwmjwf9/Gm58s1xKJY/S/oUT6LZMu+IIiKvlaKtXVH6gGRxEaS5HIlpYSZjtSuHJMHiLW5ZhzwP6wy9rJ7p3mtZR3xUhcKTJbqtTLTqjaQbu+zPZLp3moZcv7/a7J+EiMNalHIiowWi4M504PDA/k8Qt+Cj84Vk6HKxRplc0YWNMXeZMJxdNSiCjMhV4Dn3pcx/vY5CCzZx3VTO9CMaWvgmettKMKrHBH+ouS94UaN8x85UCL3B3wgDshLfOGtfDFEsv2IztxNkDb4CE1WIy5B9PRXGnA4b0ZmEQJuSzFpMdvJY6+rEa3KADEs9wNpLvk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFO16gC/JprhYDnjpX9RvnQCxAIfhmIyz9B44ulYMOg=;
 b=u92kvQpCCTX6ak3NnZ5QQTnfe9o1mMc0f1NHkd0YguZYIYY+jn3zJVXTgo/PgHcPk1nBva8L62CQQt634zDjhDCncq8q3aAOI2Zli1OJFWUjut//JNpVVPxg7nkl6B54tkUnAmtRrvriai/x3fXlMKi8KUIbK5kOxirv1WB5nKGeCfylgdG9O5m2fGeCMZoU/tp/h9Xk7BRafonKOLO3VcbAAZWICHsugjqu3uSuaACNfW8b6c8UCdb9V4ykYT///jDPFnUkmop8NG2JU/GoSXWfuhElzZvAcvq5nhMfgBRkjP1naGqt4XHuXqZps6K8ZFOxjcBNjiXZ1XMbF5mCig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com (2603:1096:301:100::7)
 by TY0PR03MB6449.apcprd03.prod.outlook.com (2603:1096:400:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 01:59:06 +0000
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::5fc1:b7a:831:340f]) by PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::5fc1:b7a:831:340f%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 01:59:05 +0000
Message-ID: <44150c9e-9a0d-411f-8532-ab03a632bfbf@amlogic.com>
Date: Fri, 19 Dec 2025 09:58:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: dma: Add Amlogic general DMA
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com>
 <20251216-amlogic-dma-v1-1-e289e57e96a7@amlogic.com>
 <83c771e7-f32b-48e4-91ab-d7c3b9746e14@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <83c771e7-f32b-48e4-91ab-d7c3b9746e14@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::10) To PUZPR03MB6888.apcprd03.prod.outlook.com
 (2603:1096:301:100::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB6888:EE_|TY0PR03MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: a792f5a8-0abd-44b6-4331-08de3ea23059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFh3MFYySHFsOTZ1OHRteEt0c1o5NFVhOTRoQ1BDNlVHT2NQeDRqV2VwMTNB?=
 =?utf-8?B?Uit5a0Zlb05abXBNRTgyTEExMTBaT3BRYUZPblQ2NXZnUkllWXZrRS91Qy8r?=
 =?utf-8?B?OXVKamVnSlpPUm1GbXdCMHZVdmVGeSthUXFnQ0J2OE9uQUlwZDE3U011eXc4?=
 =?utf-8?B?aU9IU1A0SjNSbUcyZkF1VjFCS2FVUEdzNmdOWjBYZWFxeWYxNXdqZ2ZuSThB?=
 =?utf-8?B?dHVuSW5DSmZTY0lvbkltV0N3Um1aKzB1M0I5dlhPZXZXLzNzQ2ZmTTFveXA5?=
 =?utf-8?B?N004NnVtSGVhZDYvZXdoK0tPa3N1bUdoNC8zenhNbjVKK2d6V3h5Ri9yMlpt?=
 =?utf-8?B?YnZCUG9CWWNva1pNWFNGNkxhanh3ZSs3cHYvS2VLL1pZU0ZEQlc2a1ZpN3lw?=
 =?utf-8?B?bGRUbE42WmN3c01vQnM4cEVBd3hrUFp1SGlxaGRsSDdSdHE3WU9qUGZDaW1v?=
 =?utf-8?B?UWNOajZ5T0xwU2VVQW5QbVpQWHNLOW9EbnZtMGxFZVpPVFJId1hUQWRtRDFX?=
 =?utf-8?B?TDU3cFVYTU9zc1ZGMlBEMHN6U21LTE1reERHelBwTmdpUHBLYkV6bDU4ZSta?=
 =?utf-8?B?WjVZRkt4QzZlYWJwbTFlMEcvU0UybjBKY282SlUxYS9hcG9lS2JocldNYnAy?=
 =?utf-8?B?aHNaaVI3WTBTLzg2Q2pLcWplbDVtTjh2Ti9ZcVNldmFmOEpLdXQ3eU5nL2RM?=
 =?utf-8?B?ck4wZzluN0g2VkFCMUJ0cXkrUUk0Zk0wTUVJb0xiMno1b3RhV2UzK1lxTlMr?=
 =?utf-8?B?T2VTYXdGeGNidVhsOVY3VkYvNXVweWF0VktwZ0pURENrTzk5cklXVmUzTjBC?=
 =?utf-8?B?RXRsN1YwbGtTQW1FSkJqOGJhcmptSitRWk4wMzQwQ2p3dGY0OWxRSUJ6LzBH?=
 =?utf-8?B?R1g0QmtwTFdWSEtHOXdHNzNwSjlYaEdsTWZIV0JsWDUvOVZNOG1JNHk2bFpl?=
 =?utf-8?B?Q1ZoQTVqVytzU0xGL0kvdnd6K3J6N0RES3huckVHbkNMK1NrRnFoUkpuVHhi?=
 =?utf-8?B?Y3F3amxDeEtGeUVlZHI3bGhnZCtDME14eC9kUGs5V3N5SzlwbmFhb3dNT3BV?=
 =?utf-8?B?SEpnRzYvejFiSzM1a2IrYnlBa3VYV3ZwT2loVGxxSlpGZityQnlna2g0QWNO?=
 =?utf-8?B?dmgzTCs1SzJtR3dDdVRJWjFVbS9Felg1SzdJWTV1KzZlWHB3RllBOHp1Mmtm?=
 =?utf-8?B?S2hZT1M2YmUyTlFZdFlFVkpJNG5FT0ZYNDd2YVk3a05VMDZzZHpjTGRBbUgx?=
 =?utf-8?B?ckVaR0IybGFuYmNYYWU0TGdaWER0Y2VuSENFMVJhVWptYWF4YVkrQUlTeDF0?=
 =?utf-8?B?c2h1NVIyMU45aVM4elR2S0pTRFFkcE5Fam00cytLZjBjOGJTWnpmWW14TDdY?=
 =?utf-8?B?SmFXbU51aFpnRjcyL0FmaHdzUkhpKytVdFhtQ2gwWnJwTFYvZllJZTRDME80?=
 =?utf-8?B?bW9FMWVEeVRzV1NLL1ZsM0VaSm15a1Fvc2VsZGJYYWh2TnZES29qd2Q5SS9P?=
 =?utf-8?B?QTJKU2xHeEVvTnJiMEJUbWdrK2NxYnRCV1Z0eDdiK3BMdW1vVE5qV1A3QW9R?=
 =?utf-8?B?MjdLRlFyVC9zcFdGQi9IOFNMcnR1empwczVDUUwxbGJsYkJSZDU3K3FqSExr?=
 =?utf-8?B?SXdnZDVXSkEwQllDYmcrQVJMb3FwUWs0NHlJWWtISGJKemR2MEFrU25hUUFX?=
 =?utf-8?B?dnd0UnM2WG96RFl5WkZDWFBBT0FYY0k5MnhhOG50Y0RvNVhpeG9nTFpZNVVx?=
 =?utf-8?B?UXZaY05zTDBzRGhhVklHRjdXdkZTcGtQdlM4WG9yYjBvMG5QWHJHODN1ZWh4?=
 =?utf-8?B?UFNWcU9sUFBMR0puQVRPQkpCelVTeERqUk9PWU5WRzYzYmxHTmhSOWQ0RW1k?=
 =?utf-8?B?WldySGtLM0EzNThWQXJFUUNmNSt3VmF1QUZMTWlsQkorR0duVnpsS1h2SDlX?=
 =?utf-8?Q?DrNPISxYs5Il81ucqLcNP1A6ondxW5TB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U01mbWpuNFBaSEorc0kyZFkvWjZEN0ZTVFZ5bEtUNlh1bEFWN1N1czNyQnQx?=
 =?utf-8?B?VjNWZm1aK1ZLVlQyUlhFUXJJQ0pscVdMYm02SW9xdHdURzJHemhac2hkS0ZD?=
 =?utf-8?B?WmJFY3lQYjlsQ0dxS1pVbnZNR3VRQ3pUNUxzYzk2UkkrOUQvRWlRLzFKMmUz?=
 =?utf-8?B?d0VMYjlIcmhZenZJTlFLQ3pXSFUrWmVWQ0h4cjlCQmZ3cUJCR3FXUVcvbzhG?=
 =?utf-8?B?ODVuRUY5WHdWUk11UkUzbGdEL05OdGNaTDI1OFE5S3c2OWhrSmNoc3AvK1B2?=
 =?utf-8?B?R1FlSXVZbGd1cDljdXprbkd6MU9CYWlrbzFDN3ZJY2NaNExFR1EvVGUwbzVl?=
 =?utf-8?B?NkhvM01VbE15T1Y1cVZ1TGZ4NU9SdDFGT3JiVWNBOHAySGVhRVZOcHJSQzBr?=
 =?utf-8?B?bzA3aUNCK295WlI5SnNHMjRsejdieWlWdUdvYXVzWGpkMmpuRGIrNlhpL0tE?=
 =?utf-8?B?cFllYnNoMzZGZU8rR3JvSW5Lc3dIcmJ2WCtMakhrRVBUVEMweWk2WTF3NGwy?=
 =?utf-8?B?d3p0cGQ2cEF4VG9ZWUkxQUswSnBqSzMyOEsvazVUbnBpVkNFOVduQ0YxOGpt?=
 =?utf-8?B?UmIxa1ZOM09NQ1ZIQ1hVVU0vNmpCMmhTc252NWg4c2FSNGFKQlhwMVkyLysx?=
 =?utf-8?B?clRTQ2xRSHVUSGVDbVoyVEVGbDdsM29jeVQvS010cE1xdUpWYjQxNzRpQ2Y3?=
 =?utf-8?B?c253clo4MmdNWExUK2tWSVhXNDlPTHpaL0tsYW9yY0pVSFg5eTROclJlOXUv?=
 =?utf-8?B?RDN0ZHBjS2s3TXd3RklYTFdYYXkvcUF2NHZWVmJzYXRJUVJYQlRIaUtRQlNC?=
 =?utf-8?B?Yk1QZUZYWmtlVXBBUEcxa0hTOCtpRU5menFXUEJJR1JRZGswWGJlVEVJbUZF?=
 =?utf-8?B?MFFsZ2I0VDdTcDJWUHdUVldPekpldmdxbS9SV1lVQUZHODk5UE5oUFdRWTNi?=
 =?utf-8?B?NnZ6MENEYzZiNDdHZDF6NWsxZzBueG9sLzhlRXJhV3I0UkhQUDI3clRYRmlx?=
 =?utf-8?B?aU80RStXL1ZWdmJ4OXJma0drTVYvaTh6WVlKOUptTWUvcVY4VWx1K2IrV3dK?=
 =?utf-8?B?ZERxWFIxUmtaNEtyaGRKQVpvZURaZ3htSEpZNjg0UG5CZ25nM2dVZWl1ZnB4?=
 =?utf-8?B?bDh3Q3hzaExNUVY0OFZZeG9uamVzcEUvV3hzd01BTDlTYzdSNkkvcUVRNFdN?=
 =?utf-8?B?LzRiUDVHd3lyL0VxcjFmeklwYy9nWG5sRWlEZ2ZzTGg0c1NTUDc4TVg5SGVQ?=
 =?utf-8?B?TlRtYkJEVGt4UUlmNVNlRDZzUlVoNE02SjNxR29keWZyMG0vZDNNZlNZbWV5?=
 =?utf-8?B?ZlYwRVczRE8wQjBsUUJzeCtUTEp3eE9RbW9OcTRwUnR3cVIwSmhtQWlwOUd0?=
 =?utf-8?B?YS8ybWQxaHhoY0tWUm9rRXlSdFYxU3VRU09HK1dKbFlLdkpseDRHQXhzcWla?=
 =?utf-8?B?K3l6UVZVTWZhQm55ZHJxd1Q2ckltWndaVk1qVUZUTnpXSjU3eXJiSEhmTlZU?=
 =?utf-8?B?SWVmTFVKaWxmRXN3YzFJQ3h2Q0phZG1JQU5CUjhjSXgxdUlkeXNHdGpjeEV0?=
 =?utf-8?B?KzdTZDg0L3dXak1YTitWem9FQm52SC9mZGh4eGdNZUIycVJZSzN6Yjc4ZnVC?=
 =?utf-8?B?dWx1RDVvRUVoMWlHbTNJVjNscGtqOTd5MUhCdlhiVS9hZ0ZRemh1TVhjcktL?=
 =?utf-8?B?eWFtell5NFg1cWJra0EzeGE1QnZzTUFYZ1RmMk5QVkxqUTcrM0lCcm9xdkI3?=
 =?utf-8?B?ZzF3dGZVN3RqQVZYbjkzbDBpcUZYVGJkYmJNQStJOThXRjBzTTh5VG9JWDJ5?=
 =?utf-8?B?dC9XOEt2blc4bDdFY0tiUnNQS3FVcmFZVVZUVWxobHBlQnNiUzRHSHNGYm85?=
 =?utf-8?B?YWdyYUlrVituWnYxNFk2VHJ5dm9HeFBYNmR6dGEwSks5eG1hd2pJS1BLTkNu?=
 =?utf-8?B?WTJCSkdSM00rUklpd2MzcmNVVUFGRW1mdnJET2lRcHVQd2t5djg1Q25qM2dP?=
 =?utf-8?B?eE1ibVp4QVplL2dSQzUvbVFmQ2pLQm15dk5IV3hXMldOQlRUaWFveGV3c0Jl?=
 =?utf-8?B?ZER4TG9HNGxVSFk4REpYUS9vMU1nU3VpOVc3dkJrZ1ZTampiYU03M1k2bXhI?=
 =?utf-8?B?alBMSG5oYWh3d0pBVno0dklUOTdLOVIwTDBSNndOc3NVRHNaekRLUlNXcngv?=
 =?utf-8?B?bmdKSlZvaWpGK21EY2tKdGZkRjFVN2g3MFE5RXJieG1xaERhSWZwWnNlUFdr?=
 =?utf-8?B?QWczN3V1U2FxK0dTNDFDRytxb0tCeU11cHQ5M0JPcHQ2RFVITFhhR3BkT2d6?=
 =?utf-8?B?Q2g1TmhLeFZQVDhDWjFDVDJqUDV3MWphU2FoN091blN5V092Ykdjdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a792f5a8-0abd-44b6-4331-08de3ea23059
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 01:59:05.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGWmdRTA1nlnXJPOU56p8hkooBZr1mxWm+4km/fyQdEb83562wMCgI2QeLW1t5a6n47lRHVOSra6UhlNzhcpq0mQLx2dfHA77aRUch9e09U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6449

Hi Krzysztof,
    Thanks for your reply.

On 2025/12/16 16:45, Krzysztof Kozlowski wrote:
> I don't know what you mean by "general" but it feels like wildcard, not
> SoC, so that would be a no-go. Read writing bindings or several talks
> about this.

I will named it using the name of SoC in V2.

