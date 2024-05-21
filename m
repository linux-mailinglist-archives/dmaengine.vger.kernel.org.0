Return-Path: <dmaengine+bounces-2119-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECF78CACF9
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 12:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033661F22CBF
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C274C08;
	Tue, 21 May 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iNIFBWXz"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC374BE4;
	Tue, 21 May 2024 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289143; cv=fail; b=G+oXX8f37/O4jyu21dwwsdBlHQVLuMVrnd8Yp2OGkJUCD4YkONkSGe03ZKBRhCh0oxWkDP1Pd0XxvdKqq7Ma6C3VeOzYzx6jeTB2lclXTpLlLonFWN66ug3S2hfNYeoXQYPPO7JayXXsyrCQ+0/kUuS9ur7MzLqLX2xtmJAa5V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289143; c=relaxed/simple;
	bh=rQRccPHsIJJ0QNRbv6Dp2BCMmPQENfaZENRANLubbiI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dG9YrhMWMlDcz5vUAVHS3hOdnvQWVGYv6kbNXIcww2/qSNF0MPiCuEPhtUuIfV8fJWYcOaMKIPiDsBFS7UEizIc3aP8hXhJoIghcZDEiZBe6n+ZRxixFqWCfY/+lkXmvnYLEJ/vqra5DNIGRL3JqOdQ48hi0HfhucNy1TDoyPCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iNIFBWXz; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YS6eixIWCbSIcMPeZLj2uar6c+Ou9oh6p/zzAhFOO+2qkND+/Z2zp1+rXdA0peBqdyJCt4ClXmfVupMyfxvthKohaRRvV0LOXhNubHUdfAnFd6Khk3/iMztmXnnGxSXtBb2AolTzqGk6f0Nrl7PsySbTtM3NRvzHfuj2i4u1DvUBLl7tpJDZ5lxB5UW35tWyGMhLjZCxk+6GQ3S4a0W487DX4X1tcZEg3/Vnyk0dSt/wu9gXxQba7AevdB3EsMEfzcjBIlWosowzWJvEjncOZMURKGyg2y+4Id1+iDnGejMFbH/f8pbO/S52ZFlOjYQbAxYBWOaFOBmrOhbyH5DO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQRccPHsIJJ0QNRbv6Dp2BCMmPQENfaZENRANLubbiI=;
 b=AdBBKKWviw1rhCC83GGYU9vbTQ9dp+kJcae487fMmFxzdgEm94g47D8Rkp6u7UesemLeJJdQSPjBrqCUuIHgY2OZPMlyjt9PdUoB24EKHXJWEawIgnQGtf2QmFJzR1F6etySOqZcPohPSc8FyNfatRrcLzTK1ylasQ2M+lI/Sl08Q9tiR+gQhYDr0G/CEbuVW3E6cxagGysoMGcwj4GVuIeMhWDpqTnT2Fh5Y7LMvnApYAS56FHFBhMb0Vhmt0v+6N849l/VlcTtTFHPTj3oSe0yO0uA0HBPWz65HGxHrRVXqjNtPouYIYplQxerp1FpV7OuHASgAjp2EYvcmJkFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQRccPHsIJJ0QNRbv6Dp2BCMmPQENfaZENRANLubbiI=;
 b=iNIFBWXzCw5J+PNMgSOHMI1vYCPrqo/33FY8yHXDjuwDs8bpzXE4CsgXdTMPajRJZLN28V8GBtjWt5EvlYXiLHP4uRHRgkI8Z/3z2H2q8xcIrARUYiWzPaiSJ/ASd/wsKg08uvnVE/MB7dt8jy9v9tclavp/1XN2tME6+idbRFHe6S67/6fckOwkc1oS2RqbFENqdhMgqtc5mxiKVNRj3D9jwGEA6jdc7B/pc0Re5ypSgjbQbfo0WnfwzI0R/wCVDcV3mdKc3XuCM/+1+8tC9ccCLikxGA4IgPso9VPq493xwgonOkFFJQAsQPGD8ARNZZIqbJ66TyZKIAOXqc+ngg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 10:58:57 +0000
Received: from CY8PR12MB7706.namprd12.prod.outlook.com
 ([fe80::eba:a472:8ec9:b80b]) by CY8PR12MB7706.namprd12.prod.outlook.com
 ([fe80::eba:a472:8ec9:b80b%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 10:58:56 +0000
Message-ID: <40621383-dfd5-4438-8bfb-75edb92abba6@nvidia.com>
Date: Tue, 21 May 2024 16:28:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: dma: Add reg-names to
 nvidia,tegra210-adma
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org,
 thierry.reding@gmail.com, dmaengine@vger.kernel.org
Cc: jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, mkumard@nvidia.com, ldewangan@nvidia.com
References: <20240520122351.1691058-1-spujar@nvidia.com>
 <20240520122351.1691058-2-spujar@nvidia.com>
 <918ca28c-2498-4c98-a257-33e828134087@kernel.org>
Content-Language: en-US
From: Sameer Pujar <spujar@nvidia.com>
Autocrypt: addr=spujar@nvidia.com; keydata=
 xsDNBGYqYXcBDADHIGvXQYflJq+W1ox2LXyMVw8W+FMrjsPc+amt7am0SqOs++ujNsmxKUU5
 R1qfkCq6fdoyu6wivKJsVENYYuJxBzqwrD8JbgXdgio+ErjINbdgekRvrhgYLgR++MbqWHMz
 Qddn68X70uqj/DcCeYtZ9WfMkxfUjR6bdNZijkT0OSlNJ1GkJpEk+9vKj+C5CxqyBt7bn1xm
 bIU/Nc4wTfwKAeVB3CqeyuTjKJhQpayu3g5jxGx7ymZ89gikGSq42PukSC2C37N/+QLZM/lj
 YbIesiPsQklBvVG3KFXT215L+Y33SBNdHShVw0mx1V2KIrfaXmKgcTH9xV9BX1TuMTe+rOw1
 Qk93vhmdZzeXbfd6A9sIl2wv43xaiVRyvVEgwB2WI3juY6plNvpm+1xvx0cGKaFqKl/ZOi7H
 Nvoi5BnXPYDojIVEh3kI4CNWKDS5IvOKToygoiwStsTdIPUgTr/ZUwBZ2mqRSqG0k2jpXBsr
 /f8xFL4UZDQH/MShEDMeRS8AEQEAAc0gU2FtZWVyIFB1amFyIDxzcHVqYXJAbnZpZGlhLmNv
 bT7CwQ0EEwEIADcWIQSnDI1YueUy/3lua0zaG1jDPHbs6wUCZipheAUJBaOagAIbAwQLCQgH
 BRUICQoLBRYCAwEAAAoJENobWMM8duzrE0ML/jKV+rtJqc2ILKRnaU21nPRfVH5q/QetC3ZX
 uhVBziTJSJinFN/00Iz2DCVc6htkNtWDE006SH7HeoyBKyaScwFic74AHQylG+QCW7GkyY8N
 TFpbJ1jQpWeBQmB8fGVoT3rdBsOzwQCHD5TqICnj7Vgi4lqx+NgzUqrX0QTbtgyQC/UGPBWR
 zK2N4tK/ypcR8cYfarCpbkcTpBPnUOG+I1Xy11Hyqo44JCGazf8YBZLi45UaGctbqGZgxaKW
 E+KXTi996aSSNEjUaqdUslLnma1nINmG1zHGprmFFfxiuFKeke2iJ7YkSc5iTDWpTYO8EKws
 2xw1GbCspXYP81slNNYEQsbV+DHrJevzVW5fdUWLKkOtbnNoo9+D4r6VuhveXP4wpmo9ZjU2
 tneavy3uzt0E6HL69b0ZlQdHfu88trH+oNrnZ7tozTCPKawtkeeePajQnZ0pG4zWsJ5O59pU
 tgH4h0fMAp2NMY1dwv4UJK9fC8ouTcF8moIUs9RgyQBA487AzQRmKmF4AQwAwFFPRVrDpCWx
 kHk5ONNBqdbUu6M/SXh2U76NZp2BUb79dqlc0FF/lgKgvCDqSvgW69R+ET5vP8flfccd96Jx
 7GIVVBJ4WSurIgKpq1t07amWAR+21h37/XLUgbeEqEoyLsgvzpJ8cFH6spq3FvCB/zXTGCVQ
 KgJEkLrKdvMnu0s04cuZH1edM9VxYOMmJkm3JodOKUqgmwcrFcCWW9lSmLSiMnL1QNH3PpNz
 yeqLvuDvn7sohH6QNFfpP4gKLMyU1gRZERvjycbROnEhRAujV1sXyV0fRKpxRmvAnPQtQYNn
 6GzCsPP6XPjHFMxoKvnPBECfBoGeAzpsDV1/a9Eu9dVMe38ndtZYzKSidJfoFs4X5Au8+ieG
 NXCZMSWB85Xb2DAR2Qmsxe2KOOp+oKFE3WZS0dtdocWKysUVE4uxtSpaym34cq6N3XioHoez
 ze9zqcF8TSA0kOJVFJfcqmKdf+TzwQ3JeXRguD1OcpRRq4zEFO0r7kQ1cixh74xXlp2LABEB
 AAHCwPwEGAEIACYWIQSnDI1YueUy/3lua0zaG1jDPHbs6wUCZipheAUJBaOagAIbDAAKCRDa
 G1jDPHbs60FXC/9fCHL8/ZeP5ckL50CTkeiiY6yjWMvbtsr+B0lYXMz1ljPcGLExaqxUN8KP
 aQFcJQNR8npPDlQMBY39OlzbKXh+nIq9NVfbm0hrgOsBhtksXGFVOiKVQCXIOk/ntNT0NVpH
 iAmgfLPXBEzmiuoFWH+1XTCCfQOWtPFFuKfsqT3y0HJla6k/6+UV6jCD1d1Mlo8ricjfeW6h
 85+/dxdiiGPYPcVwa4c1iBbrD5RDkpHHNDCYsBvcweBwZu0b5T9wjPCba1K7TujQGT+ItQL7
 9UUdlMWj4GNVcRqNYdUJ3LPYefWymdM+W5/fF+QPrLHSxS4B4BBTjk90Hj/rIh0AdCpW4gko
 0G/IyfzJ26SaKmMk9SFYZBMthYgoEqDjxPfvFKZNB8q9zv34zQ5j73YbQjE6NctcpOBNRQIH
 5vZ6eC7Qly8qPznjRV9MF2DIT4D2J1s6ncJVcuULnSDqgNaayYmNsi1aZFQUWBYL0SIP0vFi
 tFh1Kv06N2eJoLklRzTKy6I=
In-Reply-To: <918ca28c-2498-4c98-a257-33e828134087@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::6) To CY8PR12MB7706.namprd12.prod.outlook.com
 (2603:10b6:930:85::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7706:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3e1cfa-4577-4c57-5ebe-08dc798502dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjlvZ1RJaGJkLzdORzJIcURrZlNkclNBNzd6ak5hcWk0RmZGTy90eUQ5T3F5?=
 =?utf-8?B?WEdmNEgyZ1AwSFFkYlQrNVNPRGFQS1JHeEQyOEk0SnYwNVppUFlvME1ENGtJ?=
 =?utf-8?B?WWtjMm1JTU93VTF5UjFTVTJidm0vSmR1VlRJbklpaVVsUjBlTlN3NHB1RUh2?=
 =?utf-8?B?ME5QSVRtdk5RaDZkTXNNakg4M3pWRk1TbjFZVVFSRlhuMHRDbDdZR1VwS2FH?=
 =?utf-8?B?VDFDVHZjaHJXUHQvKzVjUDZ1Q25yM0p0bm01bDVVNXM4em9YL0ExYmExWk1O?=
 =?utf-8?B?bTJ2R3FMT1RjSFhKQkc4NzFXRnZZMVk4T08xd0hqVGpSRFR0ckFFQWI2RFlv?=
 =?utf-8?B?VjRmeGVNR0o0blpWRVdZRW05c0pOWUZSNkR0Yms3NmtSZ2g4NVByMGthT2M4?=
 =?utf-8?B?eXNseWJTT0QzNE4xRzFIU0YrK0J6d1BDd2Z4QTRzZGdzcHg4cTdOaUQyZ244?=
 =?utf-8?B?Qy9Ea0R5U2lPeldlVXMzRkhBdldkWDJkQlQxYXorcXlQU3RBNGVpa2VtZ2dj?=
 =?utf-8?B?Rm0vbWFNUlhvU3pNRzJIeGdkSjVLYlFpelA5QmgwZ3J3ZnN1cDBPSXZjTVdl?=
 =?utf-8?B?WUUrQVdiUE5NckpMbUxqVmV6am1zcFl5SDlRZ1FKZXpEN1hmWHY3dkQyZ3Zu?=
 =?utf-8?B?NWUvMkhHSUtVOTVBZzUwZ0YxcUVLZlgxN1NrczFWdFRpaCtVL1V2WStpWHZ4?=
 =?utf-8?B?S08wNlpxWXQ4cTBOZHF0UTRIMlgvczZPVXM3NnM1bEhuSTJ5ZjNFRVQvbHdy?=
 =?utf-8?B?Q2x6RUR6SWJ0SENRRjBJaWduSkVxemdhVTNoaXc1WjlWTE1XWG9uMkp1K1JS?=
 =?utf-8?B?NlM1SjlHQUt4NXN1UG5vaTVhMHQxaGprd1JWOXg5ZVFpMStLQlY1dk1KaHJm?=
 =?utf-8?B?aUI3U2U1OTN2TVF3V21JWWtublhzTi9vQzRvS0diNzZEb2dlN3NiVGdlVXVs?=
 =?utf-8?B?VjNEaWRrNkx1UmRiWFh0eUpxUWtxZnRGY0hiZGtJdnlTQWltQTZaSUlDbDk4?=
 =?utf-8?B?TTNwNElCK0pOdHNJSzVkNHFWYndqYWo5WSsvcGdpMG40QXB2bzNpMW9sTXlV?=
 =?utf-8?B?QzVTeWgrWjlNMi81OHp6dU94WERqMC9Td3pHY21GZlFROFJyZWhyYWJFOUk5?=
 =?utf-8?B?Q3A4bkhmTU1aTHVlMGQ0eElNZGpNS05OVERlUjFFYWVlWGlva1pmSkdnd2R6?=
 =?utf-8?B?dmsyeUozbUNjVTBXYU96a2hxV3QxY1N0ZGZBcHRXSEVEQXVMcE5lbjY3aVIy?=
 =?utf-8?B?dGpRVWlaMnYyWkU0Yk9tN1FKc2YybW5rYWFBeEE3Z2toNmdXSy9KZ0RXVEVa?=
 =?utf-8?B?azQrN2lGWUdQQW11bEs5MUFCQi93N1g3NUpkdk02SWFNcUZJY2pzVHo2Smg4?=
 =?utf-8?B?SmdSb0FhUWIrRDFiVXVrdnRZZ1RUSTJkenhHc3d2bVNmaXoyMDdmWU51VGlF?=
 =?utf-8?B?VllQVGlPbjR2YVpXb0duZGJXUjJvc0h2VU53Z2w5dS9odW5XTHhLUHNyVTFM?=
 =?utf-8?B?S0FJanFIVlFlWDJTQVArZkF1Q25HZWJBK0lMdWxRTENENjBYMGtCL0d1M2xz?=
 =?utf-8?B?Mm5YaXZZbHRuU3FUc3RrOGc3ZjlLNkJsM09TUWtNQ01MRFFGT0swMW83a3FD?=
 =?utf-8?B?LzZzVmR1bmJ3WTJseUpOamh5N2hHakZ3QThVQVZNVTRhTU0zeDVITDdKdC82?=
 =?utf-8?B?ZmtBSWRjeUdtYnJtcUpya3pOVUJqU2dpWUhoNXBLNjFkai9oWWZ5R3ZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7706.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFhxUFJQM0J3Mk9pdTBFTHFFUTBpUVBiT3lSVUZmRHlTN29EV3ZRZGEydldD?=
 =?utf-8?B?R1FabmVsMVN0b1M1a29hS3R1a0I4N0VtSHoyMjlMdGdNb3BTR1NBNjMxK2NC?=
 =?utf-8?B?bFhrOHF0emVoN0xRUXgyV3hMVWxtemEzMk1ETG9DUHF1Z21wTU93Q2E2SHFM?=
 =?utf-8?B?SWVoeHZIZmZ4NTdwSStSc05JS003THFrWEwxTmk1R3cwRlBEbGtGU1BiNmUx?=
 =?utf-8?B?RGVOQkozdHdRRmRLZDFKV2MwRyswTktPREtpeXZwejNvTTlyNEpGTmNaOWE5?=
 =?utf-8?B?QnVIbGZ2L21zZXRURzg3RVRBREYza1F0WXUzc3RFOTFpUTVRWTg1K1NLVXVZ?=
 =?utf-8?B?VnRaenZzZ25DTWVSSEp5ZG85RXliaElFRlJvWFBKQVhzK09DMmZqd2NkY0NW?=
 =?utf-8?B?VFRKdHNMc3IvLzdpVHYvU3RNR1lKQTZjS1NvMk13eWpjdnAyWEYyWWFEcjVh?=
 =?utf-8?B?UWQvd0loQXhoelJKOEdyTDM4b3UrRHlWY3poL2R6STZsZmZOSXpsdHV3a1NX?=
 =?utf-8?B?VG5NRlVtbjhwVnJ2dUozYTRrMDVLLzQ2MTNHaXh2ckFCT2loUWJBMEVnV2dh?=
 =?utf-8?B?dVdIbjdxbUR6NldsZXJpbEtTVkVWWlRuOWp2NnVGdkJDMVREbVdZZjcxeXJk?=
 =?utf-8?B?OW9XQjMvUGlhbkw4ZWw5NWFzS0ZOekFheGtGbWFJbFlncnNES2FySTNtbEE0?=
 =?utf-8?B?QXJLZENGMVZxR1cwOWVNSHRYdzcyendxbG9TWFZpc05mNU04K1RGMGZObHNj?=
 =?utf-8?B?SzMzbFR5cHdFV2NEbzVlVXFKV2FWaXhlZHFQOE9pUWhWekJ5enBudEx6cnNN?=
 =?utf-8?B?RFlEWm9IbmRNTHlaM3hFYzhJOWV4SkpzbkdlWFgyN0w5VkQ2MXBrNG1oVkx4?=
 =?utf-8?B?SGpJMUxMbGhEUERMSDBMRUlzRUNZODZMZzY1MlpCVHk3enhYY0Y0SkFHMmc5?=
 =?utf-8?B?eGxMWDMrdjhhS3ZVSXVKa01jMVk3K25xZkRBeC9BOHdsOFM1R05MVTBwdjBi?=
 =?utf-8?B?N3V1NUZUZ0V3aFFlSlpiNHJYbXVDQlg1NWRJTG9jcnU3dFFEazkrL295bUNS?=
 =?utf-8?B?dVZKRml2dWNQb0hneWRoeEtSQ2VQQTEzUkR3MnVvbjBvVUI2MEJRK2lFQXN6?=
 =?utf-8?B?WERRektQKy8yMTJtTFd1NHJkWFBESG85TUlwSzdZbmpYWFZxV3JtUlQwUStB?=
 =?utf-8?B?MG8wMlljSTdXaVU1a1JQVE8zdGh4aTM1dTBJTkZ3Z3ZOVlQweXFOa201cVpI?=
 =?utf-8?B?K1E2NVB4VTFSLys3K2c4Z285aHpmRUtPb1lEZUNVdkdNZjdLYjZWOEQxVmVy?=
 =?utf-8?B?bW9leFU4c0owY29jOGgwRWNrZEpMTzlIenhOU3lqR0lVbkU2QU8rRG5DanJm?=
 =?utf-8?B?UlpYU3NKQjlhM3RBcUFVVWNzMUdHenY5V1RXdWhJZGdrdi82QmF0dFhIaDRp?=
 =?utf-8?B?YkJEVFpBYkF2d3RPMUdoYnNoWHVGUXdqNzM2QmR4Snp0T1pwYkQwS1A3WElW?=
 =?utf-8?B?Q2psYVVXR0tBdWJWSkVZL0NONUJIcE1yUWlaa1FYWERqZ1hnbkcxam5IOGJk?=
 =?utf-8?B?M0ZIc2Mya1U4RFJpbzFQLzErUkVPWm56a3lVRnB3RVpLbk41UExXd0hJNWdK?=
 =?utf-8?B?MnV0K2s1U2tLNkYxaTNway9hQ3FzdXIzaGJNVGNVOXpKQkdjbTdNZ2JWQmxm?=
 =?utf-8?B?SEhZc01sUTliQ2ltY3hsYWlvRmZYR3doOTFzZ2ZqUlRZeWJhNUY3ZEtFRGJS?=
 =?utf-8?B?R081Q0xSQkVhb3p6d0RsSkJHajVMU05hdzNFSkQ4bnFUQXFxMnhkYW9jZkJp?=
 =?utf-8?B?QVhjME5uRnVLWWgyRm44eWtnM1g3NHFOV0laMUJmNDladEZNK3JrSUNzV2Vl?=
 =?utf-8?B?T0lMQkRMM1RwKzVwNHA4RlhvNFZGYTBKd1ZyaUIxRjc4SEEyZUZWNitrZE9j?=
 =?utf-8?B?R3lzUy9nU2ZNd0Mydm4yQVVuNE81YURGdmZwVStQK3JGQWV6VzlrWHlYMExF?=
 =?utf-8?B?OXVlejBuMEd5YkZBN0xCYzYyVnRaZzJtVmpqcU5RejdneUFDcGFBSzQzWlFm?=
 =?utf-8?B?bWZrOTV5MG5kT2FZTkplcTBqekNHem5XNEF6eXhDa0pMSDluZVVnbThYTERu?=
 =?utf-8?Q?Aac7OmCCq5URH09Y/zpQ8lka5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3e1cfa-4577-4c57-5ebe-08dc798502dd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7706.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 10:58:56.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kE5VAxSs6fPfUdsFLFr1sthU7prjT0DXWFVacTSofQuNtY+SmV7rvezUuGmrwEdBjaKCH3M1/krTDmx9UUhpaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241



On 21-05-2024 14:54, Krzysztof Kozlowski wrote:
> On 20/05/2024 14:23, Sameer Pujar wrote:
>> From: Mohan Kumar <mkumard@nvidia.com>
>>
>> For Non-Hypervisor mode, Tegra ADMA driver requires the register
>> resource range to include both global and channel page in the reg
>> entry. For Hypervisor more, Tegra ADMA driver requires only the
>> channel page and global page range is not allowed for access.
>>
>> Add reg-names DT binding for Hypervisor mode to help driver to
>> differentiate the config between Hypervisor and Non-Hypervisor
>> mode of execution.
>>
>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
>
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
>
> Please kindly resend and include all necessary To/Cc entries.

Sorry about this, I will resend the series. Thanks.

