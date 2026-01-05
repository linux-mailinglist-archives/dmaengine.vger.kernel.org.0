Return-Path: <dmaengine+bounces-8031-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5DCF5111
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 18:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F96E3019550
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73A33E35D;
	Mon,  5 Jan 2026 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g9vQa39G"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190B2FE057;
	Mon,  5 Jan 2026 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635272; cv=fail; b=KOwZnVkzMdjGwstmJB7MGfHfH8GBbwRlROVjrxPgRcC+eTdJBK3M7myuJCUoqR5y92tap2M/NiGcviq7xTl3OdK9uqZ150Eh/mOxfX/3P3/mq0Geo9GxcJSjhR2JrQqgNm5+n9ML1nLEWUf9gBGnloHkeVj4YCLXijoZjBZnKYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635272; c=relaxed/simple;
	bh=1zyDy+zad64ec0M9uZEwHejvXaedUicXkXsGXr3299A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BlEVBbvhRxJrwq0z84wipDxSGRcqg6UVPwtuciLEuGuKrzPjdPGLIq0Mkj9sr6LXv2zEu78Uii/+CsPV7nyU4MvN9m9KCUCZA0wPa50/U0gLjSed/9payMsRzj9iXmL0tfLEfBInzFd7CP8xoslD1GGR3rEDfYP9RbXkkNuI6eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g9vQa39G; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJoQJcDe8GL4jF1EdbhtasRAnqhEDePKioPO0o9VNNkddXR3veI6bTjjnL/82VDOw7mbqD5EGtaH4JH9vbiYOtGmDLTvAgUHvY7IXWqJW+aTfmpnuhTwRJaTO6bHWKqBZa8hakqS49VeW3WnKbVMvCJwjK7ZhYbCDeIq7oy8vwmFUPYpnZeD2TFvh4TaaG+vDSeWIJ2DOPKoXai5bYh69awIys8efqb2ir5TpM0GYoj0Q5ulla5SM8g2C0vmDW2gzP5Ih8FLDFq9yAPq1Ily8j1dlfEZ1+0JPIQFmO/MUjjpkeUgcf1BgAat6NQeJLw88ALde2FEE4bwJokpNRJq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y03mSxobG4LYN+Jn78YRiCCzys1qu26ZDBQ8cutfvtk=;
 b=edBx4YbNxPus9LIFqYhsOf3bi2rga6a9ChQO1Vcdad0tEHxLCWIHSp/+4QcEG151zB099Gh5wzAohnyxevmMHFb1Zzh42RJ3JGMxRC/kfiPbslRewgJ3q1Wlx7wk5iKveaEAnN5i9Nxee5hIrhiy4/F52hGWffQXKTjz14n2mULf7KH6sSOzYS2bVlucpPDdeUpG2UmvE/KRLeg32+5ovXV0e01dv8gB/L89WLRalBi3ktCIQpB7ind1QIlEUVfKUvuiRzNOpmeqqUAo4UsxAbx8CXvf+F5AHY3ss8yMkpMgDKSmy/ZW/mwNCwf841zAtDRZRw7n0kHK6eGeXmnDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y03mSxobG4LYN+Jn78YRiCCzys1qu26ZDBQ8cutfvtk=;
 b=g9vQa39GtjyodEq+tbi7yud+Zz/odkNTCii313kNMxGm813tz2ExFHhTwig/JKbBJuu+CToOixihx+M5iE2pb96D505vNhBa/DqIscn2/OlVQIGsjwgnRtPW2oLLthbEV53p7cqAdOIckTMR4J808Ef2Vv4Dn4y/A/bDUMJ6N7TSWjOJGPOv6BMtVlTg/HX9ISG8HQjnJ/uQR1HKv3aPTqtnXzZQT2u7eqAXTXzGBWePNZim3KmLoNst7PaZyOxRnVp6oN4GulGrXbEJbK2pZdLor6eHi2OvMrtZXMYdGTZG9ILV92rkyTQq+6lTXUCzYbrYr+CZbB4JFSUrNHAy8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI2PR04MB11244.eurprd04.prod.outlook.com (2603:10a6:800:29a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 17:47:45 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 17:47:45 +0000
Date: Mon, 5 Jan 2026 12:47:36 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 09/11] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both edma and hdmi
Message-ID: <aVv5OLSorjVITZwR@lizhi-Precision-Tower-5810>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
 <20251212-edma_ll-v1-9-fc863d9f5ca3@nxp.com>
 <lo5yj5eaqny4m5m4dxic4i2hnftnlgs32loed7x7wlwxpl72lj@bccj3ayuuyf5>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lo5yj5eaqny4m5m4dxic4i2hnftnlgs32loed7x7wlwxpl72lj@bccj3ayuuyf5>
X-ClientProxiedBy: PH7P221CA0076.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::32) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI2PR04MB11244:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb93d75-1f62-4245-1f86-08de4c82884c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0xpRGVFS0o3WkJ3OTNTQ3NUQWJLYno3MDU3b2UyVjhwNjR1eVZrUkhUcE95?=
 =?utf-8?B?aW5kOUphWXlFVWFWTHVUSGh3SlFIUi9DKzZESFlmZHh6ZFNlV21EMmo3TzVo?=
 =?utf-8?B?S1BjWWNsOEtqN0U0NnM1RUF2bDBhUWs1MlFaVU1jenI4Mk9rU1VMa2ZFbUpl?=
 =?utf-8?B?NmltS2ZDRUNGYlJFMkFWVDBiU0cyVzQvRSt5S3FtSlA0bG5ZaUN2YUR3N2NP?=
 =?utf-8?B?OVNKZ0dLOE5vV0FCU2IrUlVjMjk1MlJZR1Y1YnFZTmFLNlB5VDBZOUhNVzd5?=
 =?utf-8?B?K255TG9Kd0JIa0xabGxCY01UdUJTQzMzdjl3TE40bFlOZmJDbmxhUi9oajRY?=
 =?utf-8?B?U0ZlMGNmbEFWREt2bkN4eXluajFOT2dsOGl0amdNVm8xd25XQTRZV1BmTzlN?=
 =?utf-8?B?WUZGdWhETlJhR1MwdVNnWXJxMFlnWlA5TndpdDAybnQwNW53N01aM1hmTHhS?=
 =?utf-8?B?eHpHUVhNQk0zLzZNTnJiRW9reVBnU0pXWC8zaHpHR2lhM3JMNzlsMUdUeVVL?=
 =?utf-8?B?VUplSlJQTXZmSUEyRk1mZ1I2Z3JVa1hVaXBmaWRqTExnRmFrbS9zRWEzdkY5?=
 =?utf-8?B?alh3UTZUeDJ1a3dpQm95K2ZsTVNmSWRwSVZCYVRaTk5JY3VKVlhuZk8zcHhx?=
 =?utf-8?B?OWRCT2o4elM2a0RDemhSRENodU1JeDJ3WGlGL0xSSzZKVHdDNElUVXIwV1c0?=
 =?utf-8?B?NTJwWGwrUHcwYVZQWDUvbG02aTh5WUViYnpuVHVES3ltSHV5RUE3S3lzSXJE?=
 =?utf-8?B?NEFmU3hSQVo0VjRxQ2FUcGJlcTlmc3dSaktESlBKV0xZWnhqd0h5NXNENVhX?=
 =?utf-8?B?Z2FydkJ3OGdRSmd4bnpYcksvcGhlY1JNNFNHUmZTbXRZS3RkZ1JyeHFSb3FM?=
 =?utf-8?B?SnQ2Q3pXYXFPZDQzS1l1bk0zSUsyM3VpeDB0cmdOeURkaDNZMHJGUU9QRklL?=
 =?utf-8?B?S08wNU8yVFVsVy9udlZwWDhmU2ZPSkgrZmxiZXh0L0FCUTd0Y3ZmZ1ZudG9B?=
 =?utf-8?B?bkRIT1RMbW5QaVN0Z2tPK2RDY29MMnJ4Ylp2ZE1Ld2xoSDlZaWdnSUU2clEw?=
 =?utf-8?B?TVFRL3RCNFZOK3FvUUU5MmIwUlJNdGdIOVFPOGY1bTNQZW1qeWdCUDdBM1dk?=
 =?utf-8?B?U200amhVcElVMXlLSEFJWXIwUEJYS0FzYzNNeUhuZU9Sc0w3VWtFZFhidGti?=
 =?utf-8?B?SXJXM0g3VDNPdGI4R0ZIOCt2cFVYcmpMdER1dElNUGFoZzAvZEtoZTZBQ1kx?=
 =?utf-8?B?RGZMcVdTZGJ0NWt0UE9mOVNVQjNRTmFYcHlsalI1dU9QN01wUzdRKzdQa2F4?=
 =?utf-8?B?L01DaEE2RC9JYiswdXNQMm8yd2JRa0FEc3UvdDd6blFHdkdNcVBockFTcDR6?=
 =?utf-8?B?eVF2SHNzeFNsekhxU3V3QmVKRzl5VjQ3RzBZY3pnV2tvaTA4VFA2b3FTbnd6?=
 =?utf-8?B?Z0lINGk2T0NKbHBRTU5lNEtXOE1pM0lKbUNZWmlmNFZLUE1SNVlvd0U0N3J1?=
 =?utf-8?B?c2g1bjdXVkRlRHhXbVlUVE10czVOR2dOYk9SUm9ySFowelhURDAreTBJTkdu?=
 =?utf-8?B?eW5oRzY3b1ZKQzJwNzRsMnBFMzgrSCtiTlV3czExbnV6cVM0Z2I2bzlnaVhq?=
 =?utf-8?B?Yi9UOWxScnFEY3NyOTg0MUhWSWp1L1Uzb3FMSFdkQjYwNm0zLzNweFhOZWY5?=
 =?utf-8?B?eC9XcG1QUkpqeURrNVpoWXY0RU1kTGpqaXpRY1g3cEsvUHROaGJQWTBmRnlr?=
 =?utf-8?B?ZlFWWlFaK3psb3JpNXZDRFM2VkE0WGppbEx1MDFkMTZvd01UZDJ0bFhJMmF0?=
 =?utf-8?B?NzA0cUU1OHRUSVp6UTJtdytMYTJqQmZkdEpMM0Nna0NRdFNxRHVTalRxajFa?=
 =?utf-8?B?akNIY282WjN4dUVKVXpzNWJMWUo4WEZPUFhFS092di9oeTdNUVdJYU1RS0xW?=
 =?utf-8?B?bXhDeUY1R25jZUF6RDNROFVPNmowbFJ0U1dlSXllbHR0N21oazRyNU1LUk5E?=
 =?utf-8?B?cG4waUxITGtqRFFoOXFzYWhhellVdEVGYTF3c3h5T1lLZWFHaHZnR3lDVUlJ?=
 =?utf-8?Q?qqPQVE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bSsrWGsyMHU2ME5rWlNob3A1VzRIMmQ2MzEvVGtKeWVlN01JT0RZTk9zdS8y?=
 =?utf-8?B?bkpBbEZIWEwvQk1uR2RGS091V2lBZE11WnZsNjA0ckh0Uk5iSlFVcjlhL2Jw?=
 =?utf-8?B?SGlaZE96UzVyVkhlL2hyK3Y1cGdnZllidzE4d2hJQU9ialZkbU9RSjJtQXc5?=
 =?utf-8?B?d0loUjJETmV1N3NpbG12R2NBRVQ2dENUYmpvSjdIdDdrb1hKcGRkZHZ5ZVIv?=
 =?utf-8?B?V250VjZZQXZxU2RwOUtLQlFrSEpwMUoyZXEwMnR0RHROU0hMY1h3bUsyS1Vv?=
 =?utf-8?B?TEtmWTBLN3F4THpWdGQ0N2JBRkhZZStiaTN1NC9LcU5xZGJWMVRvb1oxZWpK?=
 =?utf-8?B?eDZnSWhYQUZXQUVoY1FZMkpMUk81N3c1bDVNVFFQekNuR0FzaUZPeW05UVlY?=
 =?utf-8?B?WGxVS1c1WjBKa1RIeE44V0VqYzZQaGpwNU9TVjBnOGFiT0pwMnNnamdGall0?=
 =?utf-8?B?eGFVdVlZWDhVVnEwdjNnQjBQditSZkxObXRHbmRqMUV0b3Y2T0x1SFlPL0Fo?=
 =?utf-8?B?OUtDVURLZkZSK2RPc0V5bWhOckZxOHdqUEIxcGt3b3VJSlpRMlllU1UxRVR2?=
 =?utf-8?B?NkxhZlB1WWlFUkM3S3RDeFpScmFtQ2tzMmpqaGJUMGJlMTFqeGRCaVJEMWU4?=
 =?utf-8?B?RlBERy83dGVjTDdiemNlT0hOREVkZ3hkc0V6L0puMGtINU9SUGQrY1BEdHZX?=
 =?utf-8?B?WEtENzJDTFJsK1krdlhIUTk1UXRIV29qazJyN3NvdWJJTldrTmIrbjNSOTlU?=
 =?utf-8?B?S1AxQ3dkemR6S2xpeEZ5WU16V2FTT2k4WjJLKy9lUGJVRzZCenljNXZ0dlF1?=
 =?utf-8?B?bDFhTVhPY0h0dUlqYkVTYi9ZV2srSERrMytranROeW8wMURLblhkUC92TUhF?=
 =?utf-8?B?TEQydm9yMVNTd2ZHSmJmcWtSRVJ1eGxDbnBYaWRKOG01N2UrS3loM1dDbGxG?=
 =?utf-8?B?S1BnOXdNMnNPOHBJR1JPRzVReldidmh0WUNpbkFLaFJLSFVzYmJWQzNvQXAz?=
 =?utf-8?B?ZGZKUi96akpXU29sMmhoV1BFSTNaY0FjazYvWjNLcjNQTWFrTkREQTdyd2Nw?=
 =?utf-8?B?Z1JENFp5ckhoOEhFMFVYd0RwZCtrK2VWWjlBZ2VmNzAwTnA3dThTemN1Y2Rh?=
 =?utf-8?B?YkJXZHU5R0E3cFlKMytONWVFKzJJMVErdmtkVnEwL1Z4dTRYOUJPN1hPb0l1?=
 =?utf-8?B?RVdQRTIwdWJuckhnMlF3MVNJbGc1aFRhSWw0b1IvUk9nTXp2U1hxbWtlR1cr?=
 =?utf-8?B?cVdiS1RHbTQ1cXhzQWpsRHR1aTdxVUxYUnhkRkFLNFAxaHVlcVVDenkvN3pN?=
 =?utf-8?B?N0Jod05pRjJZUndaQlRuWVY3WlFEcktqdXdUMDFoYW1Vb2FMZWZ4aE9RZmtp?=
 =?utf-8?B?RzBtcHNJcGxoQjhleUxzMTMwN1JQY0pNaURCWVI0cXhGSlVvUVVnZ1VDaEN2?=
 =?utf-8?B?UU5BT2o0VlIwdHd2eXZCV1RCUlU1dk4zd2VWT1M1NVZLOXQrbUZHbjM4czlu?=
 =?utf-8?B?aGhmUW9md0tzZVJXc1ViM3JhZ2VpeExWSWRaUGRBVnNac1pYWWt5SXVJejJK?=
 =?utf-8?B?OTFWQ1BsWlBwUk5iaitQS0g1V0xud3BNUGxoSXJ5cEZqRHJTZ0UvS3F1WGhX?=
 =?utf-8?B?cWsyVmZvK0E3UHFQb3dSb1gzMGMwNVlONGJCd2JWc1Z6VmhYVTMrOG9qUWcv?=
 =?utf-8?B?a2xZUFloZ1FvdXhyczd1SXdyVkRBeDhTbGo0ei96YUNkZXViUVR2NmpJdWRt?=
 =?utf-8?B?S05QTVBycXZUeE9uLzM4N2RZaW9wclJaRGtJVS9DdUhKQ3dNVnRPb29DOEht?=
 =?utf-8?B?d0F4Z1d4bW5kTEs4cXZtdVVPa1BHa0laOS80QmJGK243ei8rTmo1VTBaaFBT?=
 =?utf-8?B?aytDcjZib1BMTnVRYTZ6ZFV2U3htL0pqT3UxTkYyRUNKcHhMT3Q3YnlaTW53?=
 =?utf-8?B?OGNScjcxR3RYSUdUY29Dbm9MZjlIT0JvbVRPWjF0YzUrUk5MS01MK1B6TFEx?=
 =?utf-8?B?WWFXU2FQUlZRekV2NitQanh6N08zbFozNGRuUURrUVB1em4wajFTd0F4bDNy?=
 =?utf-8?B?UllOYUViWS81S2Z0WUhlNnpadExTdWVwRGxhYVl4WDBSVGFRUXVxdURKSFF0?=
 =?utf-8?B?R29QaTdLeUMvM3Nya0JaamFHczdXb2VsOWxWeER2VFlzYlJENVVidHBoQXpM?=
 =?utf-8?B?KzM5RXE4ZnEzeHQzNytadjRUVWxEWDA2ajhPWnVWTVpQTVYwTGd2K1Z5cFdp?=
 =?utf-8?B?RFErbjdVQjlBc1h0bHYyUHNJWEZIbEpWZXppZEpkS3BqejU5YTZrRmlHUzl2?=
 =?utf-8?B?WE96djFueTV2ekl5ZTRZQ0pDcFlLdDdwK1J5QjVyTUpUdEZPYlF3dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb93d75-1f62-4245-1f86-08de4c82884c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 17:47:45.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TheAcWZ6TPyj7nahcIIdNPCb8d824Iu8mnlCHhfY/PC02VSuflASbmwWK1EU3IGhT2yptPrheoQHViNGL/B6tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11244

On Tue, Dec 30, 2025 at 10:24:20PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 12, 2025 at 05:24:48PM -0500, Frank Li wrote:
> > Use common dw_edma_core_start() for both edma and hdmi. Remove .start()
>
> s/edma/eDMA
> s/hdmi/HDMA
>
> Here and below.
>
> > callback functions at edma and hdmi.
> >
> > HDMI set CYCLE_BIT for each chunk. Now only set it when first is true. The
> > logic is the same because previous ll_max is -1, so first is always true.
> >
>
> How ll_max is related to 'desc->xfer_sz'?

No relastionship! why have this question?

Frank

>
> - Mani
>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    | 24 ++++++++++++++++--
> >  drivers/dma/dw-edma/dw-edma-core.h    |  7 -----
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 48 -----------------------------------
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 43 +++----------------------------
> >  4 files changed, 25 insertions(+), 97 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 5b12af20cb37156a8dec440401d956652b890d53..37918f733eb4d36c7ced6418b85a885affadc8f7 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -163,9 +163,29 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
> >  	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
> >  }
> >
> > +static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
> > +{
> > +	struct dw_edma_chan *chan = chunk->chan;
> > +	struct dw_edma_burst *child;
> > +	u32 i = 0;
> > +	int j;
> > +
> > +	j = chunk->bursts_alloc;
> > +	list_for_each_entry(child, &chunk->burst->list, list) {
> > +		j--;
> > +		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
> > +	}
> > +
> > +	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
> > +
> > +	if (first)
> > +		dw_edma_core_ch_enable(chan);
> > +
> > +	dw_edma_core_ch_doorbell(chan);
> > +}
> > +
> >  static int dw_edma_start_transfer(struct dw_edma_chan *chan)
> >  {
> > -	struct dw_edma *dw = chan->dw;
> >  	struct dw_edma_chunk *child;
> >  	struct dw_edma_desc *desc;
> >  	struct virt_dma_desc *vd;
> > @@ -183,7 +203,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
> >  	if (!child)
> >  		return 0;
> >
> > -	dw_edma_core_start(dw, child, !desc->xfer_sz);
> > +	dw_edma_core_start(child, !desc->xfer_sz);
> >  	desc->xfer_sz += child->xfer_sz;
> >  	dw_edma_free_burst(child);
> >  	list_del(&child->list);
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index 2b5defae133c360f142394f9fab35c4748a893da..7a0d8405eb7feaedf4b19fd83bbeb5d24781bb7b 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -124,7 +124,6 @@ struct dw_edma_core_ops {
> >  	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
> >  	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> >  				  dw_edma_handler_t done, dw_edma_handler_t abort);
> > -	void (*start)(struct dw_edma_chunk *chunk, bool first);
> >  	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
> >  			u32 idx, bool cb, bool irq);
> >  	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
> > @@ -195,12 +194,6 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> >  	return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);
> >  }
> >
> > -static inline
> > -void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
> > -{
> > -	dw->core->start(chunk, first);
> > -}
> > -
> >  static inline
> >  void dw_edma_core_ch_config(struct dw_edma_chan *chan)
> >  {
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 59ee219f1abddd48806dec953ce96afdc87ffdab..c5f381d00b9773e52c1134cfea3ac3a04c7bef52 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -379,36 +379,6 @@ static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
> >  		  upper_32_bits(chan->ll_region.paddr));
> >  }
> >
> > -static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > -{
> > -	struct dw_edma_burst *child;
> > -	struct dw_edma_chan *chan = chunk->chan;
> > -	u32 control = 0, i = 0;
> > -	int j;
> > -
> > -	if (chunk->cb)
> > -		control = DW_EDMA_V0_CB;
> > -
> > -	j = chunk->bursts_alloc;
> > -	list_for_each_entry(child, &chunk->burst->list, list) {
> > -		j--;
> > -		if (!j) {
> > -			control |= DW_EDMA_V0_LIE;
> > -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > -				control |= DW_EDMA_V0_RIE;
> > -		}
> > -
> > -		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
> > -					 child->sar, child->dar);
> > -	}
> > -
> > -	control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
> > -	if (!chunk->cb)
> > -		control |= DW_EDMA_V0_CB;
> > -
> > -	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
> > -}
> > -
> >  static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
> >  {
> >  	/*
> > @@ -423,23 +393,6 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
> >  		readl(chan->ll_region.vaddr.io);
> >  }
> >
> > -static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > -{
> > -	struct dw_edma_chan *chan = chunk->chan;
> > -	struct dw_edma *dw = chan->dw;
> > -
> > -	dw_edma_v0_core_write_chunk(chunk);
> > -
> > -	if (first)
> > -		dw_edma_v0_core_ch_enable(chan);
> > -
> > -	dw_edma_v0_sync_ll_data(chan);
> > -
> > -	/* Doorbell */
> > -	SET_RW_32(dw, chan->dir, doorbell,
> > -		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
> > -}
> > -
> >  static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma *dw = chan->dw;
> > @@ -562,7 +515,6 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
> >  	.ch_count = dw_edma_v0_core_ch_count,
> >  	.ch_status = dw_edma_v0_core_ch_status,
> >  	.handle_int = dw_edma_v0_core_handle_int,
> > -	.start = dw_edma_v0_core_start,
> >  	.ll_data = dw_edma_v0_core_ll_data,
> >  	.ll_link = dw_edma_v0_core_ll_link,
> >  	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index 94350bb2bdcd6e29d8a42380160a5bd77caf4680..7f9fe3a6edd94583fd09c80a8d79527ed6383a8c 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -217,26 +217,10 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
> >  		  lower_32_bits(chan->ll_region.paddr));
> >  	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> >  		  upper_32_bits(chan->ll_region.paddr));
> > -}
> > -
> > -static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > -{
> > -	struct dw_edma_chan *chan = chunk->chan;
> > -	struct dw_edma_burst *child;
> > -	u32 control = 0, i = 0;
> > -
> > -	if (chunk->cb)
> > -		control = DW_HDMA_V0_CB;
> > -
> > -	list_for_each_entry(child, &chunk->burst->list, list)
> > -		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
> > -					 child->sar, child->dar);
> > -
> > -	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
> > -	if (!chunk->cb)
> > -		control |= DW_HDMA_V0_CB;
> >
> > -	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
> > +	/* Set consumer cycle */
> > +	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> > +		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> >  }
> >
> >  static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
> > @@ -253,26 +237,6 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
> >  		readl(chan->ll_region.vaddr.io);
> >  }
> >
> > -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > -{
> > -	struct dw_edma_chan *chan = chunk->chan;
> > -	struct dw_edma *dw = chan->dw;
> > -
> > -	dw_hdma_v0_core_write_chunk(chunk);
> > -
> > -	if (first)
> > -		dw_hdma_v0_core_ch_enable(chan);
> > -
> > -	/* Set consumer cycle */
> > -	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> > -		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> > -
> > -	dw_hdma_v0_sync_ll_data(chan);
> > -
> > -	/* Doorbell */
> > -	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
> > -}
> > -
> >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma *dw = chan->dw;
> > @@ -332,7 +296,6 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
> >  	.ch_count = dw_hdma_v0_core_ch_count,
> >  	.ch_status = dw_hdma_v0_core_ch_status,
> >  	.handle_int = dw_hdma_v0_core_handle_int,
> > -	.start = dw_hdma_v0_core_start,
> >  	.ll_data = dw_hdma_v0_core_ll_data,
> >  	.ll_link = dw_hdma_v0_core_ll_link,
> >  	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
> >
> > --
> > 2.34.1
> >
>
> --
> மணிவண்ணன் சதாசிவம்

