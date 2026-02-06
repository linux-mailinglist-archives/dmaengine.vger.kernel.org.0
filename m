Return-Path: <dmaengine+bounces-8807-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOXvJsZChmmbLQQAu9opvQ
	(envelope-from <dmaengine+bounces-8807-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:36:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63E102D1F
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CFFC300874F
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 19:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70387305E01;
	Fri,  6 Feb 2026 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uc4XQWRd"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4C32857C1;
	Fri,  6 Feb 2026 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406433; cv=fail; b=by4LbT+l0XDt2IZBbWN8kmPIgV8C+b5vAZXmyFd3WvEa82gN7d95akzxcmvx4qrttCn1HX1fVJ/mZuFZlLPcHQkZGVuVenjI17LpOK5bTXfYRSEwLcsiHJdk1rk5lBA6A6Qe/SW/2/NE5T+69cZM1H+S7HdeanzanJCjJiTkgJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406433; c=relaxed/simple;
	bh=FS/4KB6/muSEu1Qlkf/lNXnG6WuMco6QBUVionJEHZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dsnmj/IIbY0gjPVaER2o8qYzq5xyc+nhDKUxeg43L5l76x67XJX3KMX8SQsagj0LJyou+lb1E32sVMO9WqKX6m+VTWlcnIr6Q4MHqpOyty5aXKjiRG8xlTw+6cJXiw1Oqx/veqCOIl+cNUXtlmUMpgv/Ime7XFiX9hLE+SX2am8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uc4XQWRd; arc=fail smtp.client-ip=40.107.162.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBk3wiZBdiK32wBm+6xLiRu2zxio0FwlafUAnRu2OCyGh+nh8TF6x3HuunSAOsWRZi1bXOBomOXQYKtFm6RG2DYKbP/ri8/rEfiqhWhJ6HAGLI2qP3Corh2os25i0T/lxJX7YxmYAZ/d7I1Mrw06h820vYPppHuGnrb74oO1LvYdkEXGNGNEPdJwhIk2ob3EZwgk5LRzluWEWThnARszpJTR415vKebC2whnpRqwGZN3gnlBbmHr6/LhISI+Q0TF7J93vRb1emz23khjWgkbImu/ckIn5GZiTTrtaZdX3KKW68a1wZs6uhuTuWp5GE9zwjXJpnbS074f6fAiNR8UdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PudXe6rihN3gvmtagqexciBMxRyb7Ovtz94K2Ik7Igw=;
 b=MGBwRUclY6HujQdXJpp0dPgMF4aoqeMO7SMRyjxmvvhCBVxvR1P19lJcGzVAn4F2r2M2RFUW4lzzdam7HREtNdRgQtxAMMA/SQtPOgJlOOE8ih3prJ6jc72kS3PhRfq8S+8jxgOjVO3fWasLnBwLOJ12Bp76JcEoDoJZO9D+TCXKxXuxRN2iyhpXZEzNl1YLpikMb2Ghvt/fIesjiVQMw9/gSgpfuaSGdPy+P6LdFIWbVCqpukW7v2321xjSNLEee6Ac74FRmRlWJzYtWsDXlP3EW9VyogxslfKceCR8W0OeasINuQ7CEpFNljFhPtvW420FoDLv7dkB/v/4JBJS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PudXe6rihN3gvmtagqexciBMxRyb7Ovtz94K2Ik7Igw=;
 b=Uc4XQWRdew0P4yt/d9fOqEORp4p7W2AHLDDMgxRNEzzU2yqH2s6DSnrlc461WHTRDZHu4ASkQvYXu4jxD2o4Q0j8UhFdzFBqOB+kUWtbjAns3VUDCYUDY1Bi/8YthHN7CUBBYcbj1JnbMs9nmY7vobNU5YOrj1Jhz88sn7kgxnEe1MSf1tpBhsIZGaQFcyM7sd4Scr9g8OBq7C8jR4kC+y8aaXgs9W+iRo2VbV4Okg0/yq95as3Q5tzkvaDEiO39DqotOdlMO4l701xuTeJmgtnpBtzlm7sGru/FB9v57l3GVEro3EglQoApZISBCfRPxYyMH4UKtjCo/+nLmSFa4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB8PR04MB6971.eurprd04.prod.outlook.com (2603:10a6:10:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 19:33:50 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 19:33:50 +0000
Date: Fri, 6 Feb 2026 14:33:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Message-ID: <aYZCFiI0PbAhabj8@lizhi-Precision-Tower-5810>
References: <20260206-amlogic-dma-v3-0-56fb9f59ed22@amlogic.com>
 <20260206-amlogic-dma-v3-1-56fb9f59ed22@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206-amlogic-dma-v3-1-56fb9f59ed22@amlogic.com>
X-ClientProxiedBy: BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB8PR04MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: b3262186-948c-4892-4aca-08de65b6a771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|7416014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dndrRnhTWkJXdG1VbjlJNklqWnVRZTJzOTBESFZiOHMzUTN4YTc1M3BsTjd1?=
 =?utf-8?B?ZVBUcjR4dEVLQVd3eVk5bE9yaE4yYmsxak1relk3SEd5dXhLL2pPM2twcGRz?=
 =?utf-8?B?a3p2RHhyVTU4L3RNQVVQV0JRS3lqTmgvR1JnQWJYZDQ0K3JsL0xsa3doUWZt?=
 =?utf-8?B?MmtFNG1vdGpRUWZVcW9FRUgwV2xtQTJqZVduamFodWlkOUExMytjZmt1bjhB?=
 =?utf-8?B?S2tyQ2U0bk5CRDk4SW1Sc0VoTkE3UXFrWSt5N2ZySWxyb3NwTHJlcTNhRE5R?=
 =?utf-8?B?Y1B2bk5yVjFrSXlxMEozQzgvWDJaTmJQb3ZId3ZpbklkVkV4ZVRpQVZTdGdO?=
 =?utf-8?B?eFZGdjlLQWZrUWtTWUc3UTFzMEJHb3hQUDk0Q0RGdzdXQ3NlaitvT3NCYm56?=
 =?utf-8?B?eGVCWGl1alErSFhPU1VuTlZiQjM3QUJZYlcwY0NBZHRYRDFLTU9MTk5uQ2R1?=
 =?utf-8?B?UFd6Skx2U1MxSEFlb3RhWkZCaTJiU2lBOG9rQ0h0MWZIT21OaEFzdC9pZUlT?=
 =?utf-8?B?UDlxQ2pRa0RSR0pCKzEwem5mODNDWGZRd1lyWEFPOUtoN0ZLZE1jdU9IYTNm?=
 =?utf-8?B?YWM5VnFpTGthS2NHaHdydU53OStkNHkvU2tiT2lkY1dab1lkK1BGellibXJO?=
 =?utf-8?B?WEZRZWpOZHBNdFE4V0VzcVFOZlNHWlRYTmpCRzhSTzdjK1RsRHkwd2lCRXBq?=
 =?utf-8?B?T0NFRmZlQWd0d2Z6NTJ1Qng4WkxDV1R5Y1NPbzAyaDFzd01RcDBzUkRucXhU?=
 =?utf-8?B?MWVFTjQ3THduL0kvU1Z0RVVwQi9BdGluKzJzYUo2R29NOStOQTZWeWgzdUhs?=
 =?utf-8?B?S1BpbnNUTGV6dTcwS3hWRDZnN2g4TmptSnZQcWsyNGpPL0UzdEpNYjZjemt4?=
 =?utf-8?B?UXczUHMxb1c4SkZDRXY3K25OYkRqZ0V4S2xpLzRSSG1CUkM0dU1SOC82ZjUw?=
 =?utf-8?B?Y3hFWWdxTU40bUdNSVBJQThRdXdQYThNR2ZwZ1FFZ1BCVjBEMVN2L0poUHhp?=
 =?utf-8?B?eWF2akFFb2ZsRU9PZTRKclBYNkIzUjVLVzZSM29nZlBTWWdnRFROcmlPS0ti?=
 =?utf-8?B?L1N6YjM0WnVhSDY0OHFOVlVOS2F2M2pWMVA0ck9XWmRCeUQ2L3I4c2M5MjZq?=
 =?utf-8?B?dmJ0eTVaYTE1YTRLN1B6aDdaaGQ2My96ZWpZU2VSbTRLaU00NGUwUTNsZVdU?=
 =?utf-8?B?TzVZaWU4bi8xNWNQUm51OXpHdE5LbUx3emNZT3FMa1hJOWgvbDRTTjAxYzVZ?=
 =?utf-8?B?MGFUdFZyS1JzeWVSVkJyMHdpOXFHelhKeVJWS09BRmRhWldSWlR6d2p3V1da?=
 =?utf-8?B?TWJvL3ZvRHFMcEk4dDZSanhoNWV5SXFjVXpQcVNTUTBqbU1TNHZqeU5qMHZS?=
 =?utf-8?B?cmRzYTgwalVEbWhxekZqVXliaVpPY1VGZkRvQk9ha0YyNGRSalRCVDN2UVZi?=
 =?utf-8?B?MURlQWRSaEM0TldncWpTYXFnWjBtbmQwNnRsR1l5NHZuRUtvbFptYk9YTVNv?=
 =?utf-8?B?MTVoNElzT2V6UG9YbmxlUW9oN29vRUp6R3pxck0vM1c2eis4eS9oa2xmTUNl?=
 =?utf-8?B?U2hwVGc3a1l2RHRpNkJCYjFVWGtuai9aVDdaVGQrbzBDeWY3bnE4a0lISnJS?=
 =?utf-8?B?OXFQaXJaU1ZRL2dYWFR0S3cwUjQrQ2I5QklLNmpabFJhR1d2c21KTktZeGVm?=
 =?utf-8?B?ZUNrVTZlSGEzakRDeU5rSkNaNFFaWUxyN3BJTnJjdDVTRHpQVlNCRzVRVGh3?=
 =?utf-8?B?eFJTbFpMd3c2Y3YvU1I4WGYveWdjbWcvV1YxSzd0QW5OUCt4Lzc1RWh0MVZq?=
 =?utf-8?B?bUF2VlhqcTZVNWxzS0VsSWYzUUdud3VpNi94UjNtbWNSanpIZjIzZUFlazJE?=
 =?utf-8?B?cnkycXlpcnVUcXRqTUUxdVpveUJpdm1IUHI0R01Va1EyUHdRRHk4UGUydmkx?=
 =?utf-8?B?OFY5RmZjTFBaWGI2RlVzUTZlRlQwcnFjcmVwZTlhUlF1cWdMSE00M3dwaS9k?=
 =?utf-8?B?b3UyNGVSMmV3bUpCcGNTektXbW8yMGQzTWdnanZBK1ZzUFhpQStlRlN2RVRN?=
 =?utf-8?B?VlV2enpWMGlIL1pteS95TzVvcVQyaGZwSFBPU0JORTdLVk1ZUXFwK3JrWUtK?=
 =?utf-8?B?V0tNMmNQOVI1RkJ3R01QaVgxWVFBOVJwOGdGSkM1aWtLd2R0bGs2bGNOcXNY?=
 =?utf-8?Q?tP8mQoKFuEPSmIqVIePKFX708SPHvEfg7GltQQXp5UFH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(7416014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG4yMnJobUJjd0RPUXc1a2dJckNESkJTVDFmcWdGVUFLc1RYUnBTTW51alA5?=
 =?utf-8?B?aEVaVkFOcVBpbWpFVUx2bjhacHVRV2RyS3ZPZ1VPdEJVWWFJSjN6bHl4ZzBs?=
 =?utf-8?B?S1JMckx1V1NaVjlhSmtxMjBPWmxXNktjZEp0SmI5Q3hNYk5jeFhFTTA3eldX?=
 =?utf-8?B?cmltN0k4M1YxVnBlUkNQc1gzRklvSGNUQnY3TXRlQVNDS3M2WjZDWS9iTWdJ?=
 =?utf-8?B?TW5QbnFLVUtWNnUwNSswcHFGVm1hNk9Sdi8zNUIrRWFJWXVhbmcxblQ5WWJj?=
 =?utf-8?B?a1pscTVpZ0xqK0V2enVvY0N2TklvcFJoa1VBb1VTNEVkT2NVVTNCSm9Denlm?=
 =?utf-8?B?bEpFY3V3bitMM3EwcmFvajJCelRYVFZVV3BlVVB6cUQ4RGhCVUhPRk1jTmtu?=
 =?utf-8?B?WDlmcUk3OFJSNzdBNDdvSkNhWnpkOGdFSWpDRHJrZHdUaHZFNXBIR3J0WXZi?=
 =?utf-8?B?SnF0L1pEcG00MFQ2SDloVml1bVVXaDN1ZG9nMXB0czQ0NVZIZmkvYlQ3Q0Na?=
 =?utf-8?B?SXBHTzZtSjJEZHJHM3FsUWdMOGtlMzlnaldSOVRNbUxqM3ZVc0NzT1QxOTc4?=
 =?utf-8?B?bm5TTUQ3akFQYUZlL0liV2huZmV2Z3FDc1RZWkZnRTUxK0xQY3RtVVQrTXl2?=
 =?utf-8?B?aHo3OUVBTktPZGZqMVBRcFRVYTJTZUQ3c0FQM3ZVbVV6aEViZ2Y0ZjVHZG04?=
 =?utf-8?B?dnpyVEdra3NlMW5MTTNZNGtTckpzNm5WTDRHc1VzNENoY2s0MXRjK0ZWOVVM?=
 =?utf-8?B?Z3pjMDF3R01hTUNNREYvOTduZEp1N2R1bHJsaHFnY1FadGlSejNFYUcwejMr?=
 =?utf-8?B?TE1ZbFRuNURJTGQyNUVtKzNXZEtpaHM4MnQ3eWkvVkR2aTZKS2YydmQ4blNQ?=
 =?utf-8?B?MEJnMEpoc0dMU1NIVzl4WHVIYXdzUmQ3b1lnNGp3b0x2QlhHZ1JYOVVwU3ha?=
 =?utf-8?B?TC9xMGFhUlZyak9WdEExMTZWNmVVVzE0MERZcFVZOU5iKzRRc0oyUVFQM1dP?=
 =?utf-8?B?Z3VvbUN6emNLeWM5U0NZSjBZTkhKREVIWUVnK0JMcW5SZXoxMDZndzVya2dH?=
 =?utf-8?B?UGh1cEJHbHhuSDZvMHNsWXI2NlBYVFVNV2tLeG1iRm16UnJnSjFNSlUxWkh0?=
 =?utf-8?B?bkFoelBiTTNGbnBDRVdON2JZak1ocVJzZEtIZEowY3BJZFQwUThDV3QwTXIy?=
 =?utf-8?B?cFo0MjdTbXJ0cFh0YkJFNUpIWGpnYWFZdGRSSlpSUWI5SWlkY3VpQzdLNjIy?=
 =?utf-8?B?clUwemJjSEJ5cnRHa2VBU2tTOHZtZ21udytJYVhtejJOM2E1TzAydi94cWJJ?=
 =?utf-8?B?NGM0eHdBZkQvT0hwRzdJS2VEaXRCdTZGUVd1aDU4T2xCYmc0YzBqSVNEL2Nu?=
 =?utf-8?B?bzY3Zzl1MWJ0djJBMHE0RG1oL0pCZ2IzRURYRUNjNzhpV0d1QkpFRmZqZktX?=
 =?utf-8?B?Z3BXZXhYOGhRMDNMT0YyOWN5cXZjelhtWmpiWEl1ZUZqZHoxYmFaT3VGQ1J3?=
 =?utf-8?B?WHI3aEkyQnoyNWlnbHY0bzVvYW42YmoybDR1TmFaRUZRbjJlNEF2b0FXTUVY?=
 =?utf-8?B?c0FGWGFQZlpEMWNZSFFiV2Q2RnhJOEVvY3Y3U0Y2N2hmaFdvN296bnZTVkJI?=
 =?utf-8?B?NFpoYnE2enlkWWg1RDJ3cDgvQzlmSDV0ZWdIZEFIZUJwOGhoTUpnSXAvK1RS?=
 =?utf-8?B?VmxoM0c0Z0xOeTFyRGZhOEl0Y1J5U0lNRGxUek1LcDZ5akdjOVRiK3VzNU5m?=
 =?utf-8?B?RU1qTmNCM2hTSTE5ZGsxaU9PNXlSU3JpRFBwdHdiajdwNE1HS1hMamdPZXFt?=
 =?utf-8?B?ZUs1L0c5akNEUXBmMmF3NU1OaUFDcWRhd3U1NEVXeEM0b1hQRmo3RFJQZUpn?=
 =?utf-8?B?Um9xVnc0cjRVUjdwdW9UQTJSY1FVNnJXTGpjUjdiMkYyZld4RXlaVnpBT2l5?=
 =?utf-8?B?R2cwcFV1MllFcTNNZGlEcVRKYXM5MExhdTF3TTF4STFBUExhYkl3ektvTGJR?=
 =?utf-8?B?a2d2WGttc3VvQ2MvY0x0SDgwMTM3VTR1K0xKVi8vVDNBTXFodXZNL0NaNWlw?=
 =?utf-8?B?V0thSjc2d20wdWNSUGRJYmR6bTd6T01FV0R6UkEyeHQxZW9FZUR4WktWMVB2?=
 =?utf-8?B?RTdobHNjbXlTdkNjZmlDNUUwYVN3SjMrS0RKVjVSS3IxSHkvQXlhM0dUbmUr?=
 =?utf-8?B?dFFlRUp5Y0NCQnRLNGNlQkhSeU1ia094Sk51RzdhNkJUcDZXM3dJZzFJVXpE?=
 =?utf-8?B?N2RibjRzbjBuMFRseGF5UU5FMkdPWjJJc08vb1oxbmlWdUhFWGhxWHJicDZZ?=
 =?utf-8?Q?xmahQabTi5cqQIbSSn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3262186-948c-4892-4aca-08de65b6a771
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:33:50.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: We2tTZpTO19CGdaTmZB1A8aD5Nf0KFB9ZLeMvV0m1g8+6bBmTX2y4Ops+h9ZavBYVx1VtTCIhsJy+yD5gFOHcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6971
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8807-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fe400000:email,amlogic.com:email]
X-Rspamd-Queue-Id: 9E63E102D1F
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 09:02:32AM +0000, Xianwei Zhao wrote:
> Add documentation describing the Amlogic A9 SoC DMA.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> new file mode 100644
> index 000000000000..3158d99a3195
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/amlogic,a9-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic general DMA controller
> +
> +description:
> +  This is a general-purpose peripheral DMA controller. It currently supports
> +  major peripherals including I2C, I3C, PIO, and CAN-BUS. Transmit and receive
> +  for the same peripheral use two separate channels, controlled by different
> +  register sets. I2C and I3C transfer data in 1-byte units, while PIO and
> +  CAN-BUS transfer data in 4-byte units. From the controller’s perspective,
> +  there is no significant difference.
> +
> +maintainers:
> +  - Xianwei Zhao <xianwei.zhao@amlogic.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a9-dma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: sys
> +
> +  '#dma-cells':
> +    const: 2
> +
> +  dma-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Needn't it, which is standard proptery.

Frank
> +    maximum: 64
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - '#dma-cells'
> +  - dma-channels
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    dma-controller@fe400000{
> +        compatible = "amlogic,a9-dma";
> +        reg = <0xfe400000 0x4000>;
> +        interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> +        clocks = <&clkc 45>;
> +        #dma-cells = <2>;
> +        dma-channels = <28>;
> +    };
>
> --
> 2.52.0
>

