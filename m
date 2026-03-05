Return-Path: <dmaengine+bounces-9261-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OECnHOj6qGnVzwAAu9opvQ
	(envelope-from <dmaengine+bounces-9261-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 04:39:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C844D20A9C5
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 04:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C36693048B08
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 03:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D3263F4A;
	Thu,  5 Mar 2026 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="aNADtNHa"
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023081.outbound.protection.outlook.com [40.107.44.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47FF23BCFD;
	Thu,  5 Mar 2026 03:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681725; cv=fail; b=oiIYW8PW1FeOjtRdRugCa69PXrZyHeg1KI6bjEgY7uUafYG6pKDXgPtTz9R95fkSSm7SudFovnlfeicgeKP7k8fNHDiUzgQQ8Xt9e+nbGGqpyKiNDNIpmPEf32aX8xP7OS2nCJoh+jBOdkFzf6R+pTWce5I2ReMgas1NRGrkMqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681725; c=relaxed/simple;
	bh=R8eVmzjwawiOFoyL0qa1zLoHD9nXzi37fDGxf86fgoA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HwVdJRhNayqrQ4aebVkpucXkvLdubwRxVtAaUcOWgcdm3Bs0xkQ/j7ITMxIm2QDUjffLITb+26wHl06WdKBvA0GwDpylmouzd6EIHXn2mX7z8yajd0ZJNNEeSr5H3BDV7/FZCV9hgeVb4oYyFic530IW4H5oaT0gpw3r0lWpDjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=aNADtNHa; arc=fail smtp.client-ip=40.107.44.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NX1jXLhY+pLcnNi8sm2JEv2h6Og3NYe8xDzpmdhVxCz7lS9jxDsjk78GAFxi92DUfMXRmZFrL7xo3rotlRE03pRoMu8bupki+/jnjycm6PybQQ8FMexkGjPMUhPN40s7g92GjMr1oP2Vf3tBs1fpFx4wwLQYWxZBre4fO8ps4Psf9vA5rZ/nGokTUzIFpSWPru/r/FNcUb75lTv4ggR/2Gaxj39Iv8rTu8U0KiShR2cwbttkgFJ/rCSGIdkm8Fu5YLdUQlGTfYbidQ8x525F9m93jlNOtfK/IBCiwYb0lPWktjio3lHdBcGiImSqpPaqYvgcmsV6glz1aARbGpjq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlvQvNbgQ6CYLZ9+k+IhssPTHQmFgWNUWTtx2c4+OXM=;
 b=KO724JoKC7rWNSJ5it9NfF77inkazl2JC965VrrknaHTw40MyLOTdN96jeBx40NXTz0wsLQbf9INhszUxtdhzRBV7doiHA6S7Q+BysnGhVC8nClE3hokj+hdFTF6lynpAh+1TVjb/DsTw6Tv97OpQXBQOqqnXy016hQHhhZKY9svFr67Lh0Irpbx2RdC3GxSRPGmH0fjpmR4ULniXfkn36PdrHMzyjrkxKXC67N9Ne6ilYXnQbx3cUjf9fdxldYoZx8Lf25vrUG07rWbsse69m/53GD7t/uZNGoQufeOM8LiYvsCXWqXMLAljtIrYCIiRld8i9rWEctVS3yxR4tFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlvQvNbgQ6CYLZ9+k+IhssPTHQmFgWNUWTtx2c4+OXM=;
 b=aNADtNHaUX/9ax04Y7MpOC/AZsS+Ah2/uOKaqor9xbtMxjtOzLoVFcGhD2XMiC7FJIkXAo2oywTFESraP5F2EbSZSxyt7KzWAEv7SNoGG8yiKlNfjtITBxgL/Wiuy+uxqJ6AdKxFkyJ+rT4gt4uRBbmCOAia0vvCRf7FmBhO72B09E81ueaZbl4Yc/ZKknhGX+FxDRV7PQmwGXQGtDIOs5tgR5Gew1VuJjAYTvB5Cp4w9R3Z/o6oqrDyKBI9oB4Rs2GQ9PeChGy2MNYgNqawEoDNups/fWl4yZhfv4ck+T1dOu2h1HNOD88DxtHvsI7nHsK8U8VaoklIiypJy5bU8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB8190.apcprd03.prod.outlook.com (2603:1096:405:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 03:35:20 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 03:35:19 +0000
Message-ID: <501fe36e-a3b1-475d-ad79-8b6523fe95e7@amlogic.com>
Date: Thu, 5 Mar 2026 11:35:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dmaengine: amlogic: Add general DMA driver for A9
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260304-amlogic-dma-v5-0-aa453d14fd43@amlogic.com>
 <20260304-amlogic-dma-v5-2-aa453d14fd43@amlogic.com>
 <aahUTp3T6QWbZiaz@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <aahUTp3T6QWbZiaz@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 320b5dad-0bc1-4bf1-62b5-08de7a6839b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	uIXc/IP0Yq6EPrWnamAwZ6tFfPfMATGAVwYKFDW//B7cbcfLigz8+50I8Yu/4pv1v8U0HVIuQeV584Su9Em+JOCh2iChb5/Mb7+j2TWPSttbhwnKo9JnA07uwsNRZH9GGYyifyu/OkQVQGaKbZUyhCYOvpaAxNKAbP05e3sOjv05VfpRD+iIYohXawwpwUh0NunDFwEx9xkZB1TPrgiQxpPJeOvU9OgwXtgtFbgEqkBIrEjgrs5zt/PdU46H3n0UMVWo6LA4foU7KLPHmQXiJX12JJUtTPINbbWxFUBK0yE4lnF2/Ud3qdOJVzuTx6XwWop2On+0YlRUKZf9i6ewKPMrxI9A1AJSAyxUOM20GSFrAmOOGZetvVhIWr4d5Z3b3y05Jhx9ks7yJH7BnzFlL4INMGLFj1gnMQ1nYABKWLTnIcItbHiDopcU31YzwdqeRhBhXhZ08qBXfjoo9wpm4zdnK1d5gOaijFQKwqN8aZkJAoqk7akuTjHvclJSHOb9oKXPO/8lksjjdBEdjAK6PwLl/vB+KdwX/uMwW8Zy5cXDVKdK1XIe3PNSDuSstRnqJWD7T+1fxqKWyLh71Zr57jDPW7S8dllL+uXJq807/6O4dpp27ozI103zMsqgewiwMbU888r5yqNY8tO/fK1h3VuE+ZEndocoUSZVoj4iN8M2zwJmReaFvcvrDEtlAVMZvmaLcJFwANF34tHmVR0ZgavBBTASa88ZTNy7wMhOyOc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3VPeHlUTVAwUHlJYlplQXpRckZ1aXBGcHh6Rzk0UjJnMVVpbS92WVg0TVlr?=
 =?utf-8?B?eVNjK09FZ0JRNFhobE9JOFRnMld5dWwzcXZFbWJMN0xDcnlEQkJqdU9SYkc0?=
 =?utf-8?B?cTVzMUxjTitxZXVvc0Q3Zkh2dm56VlRURmNKdFdWYmhPSGVJaWd6VUs1UUZp?=
 =?utf-8?B?clZYT1I2aDNOOUYxRXoxeWhJQ3RyV0svcU1EaWFNQUt4bEpJd2J3czFVeTRo?=
 =?utf-8?B?UHNvaFplUmg5MzhiNWhGaVFzZVF0dCszODZwRVZ5aXlSaW9aZFhURy9WQzB4?=
 =?utf-8?B?ZXc2OHdZeldwdUV2Y0ZUSnorK0x5WW9hM2dldis5aTcwN0c3ZUNwdG1kOU1K?=
 =?utf-8?B?ZW8xN3AvTWY5bm1rc251R0NRVjQ1dW5SS0tIRUE1OHNnZWhzdEdoQnFsdytp?=
 =?utf-8?B?Nnd3cGtjdnovWXJrYlM3NEt1T1E4VFdjUTFidjJOSTZuWXRid2d2TWJUNXJ6?=
 =?utf-8?B?UGc5VVFQcmNDZlRlUG9JOXIyc01mTm1oeEQ2N2hQNk1IQXdISEhnU1lPb2kw?=
 =?utf-8?B?RWNJZ09PTW1oR1FIcDNvc3JhcGQ0Tm0yanF5azRqanl2US9CSmo3OFBxd2xP?=
 =?utf-8?B?MlhZL0xHYXBFd3pPOGxocGJNOEEvZjVHMEZqdlFJUjNiNzBuanZuSXRpeW1G?=
 =?utf-8?B?YllEdDBGYXpncU1qRU5tN3BwbE04bHEzSlowblNrcmVZaFhuTjNKRk93L3Vl?=
 =?utf-8?B?a2l4WDl2VEdXUVRsMXk3T3lTTFIwdVFVVHVoUHBlS0xFZXB2Vy9sbHAzMU5X?=
 =?utf-8?B?MzVtaFVmV2VuNkZVOVk2WGJhNzJMYjJRc0N1MG1oUTJRODhFSWNsVUdlTk96?=
 =?utf-8?B?bVcrSHBBeWhnMDk4UUhXemlRSnBxZ2o1bFdlRFh5OHFKYWR1NURQTVFkTnNU?=
 =?utf-8?B?eXgzbFhmajEyZmhJaDNnall3YndXUkNmeURONWxSRDdWVUxlN2s4TzNTZTlM?=
 =?utf-8?B?YmZMUmt6Y0NrRHZzdXdGbFN0ZTVybWtJNVBhRmtEeC9aUDAvdS8wZVd1MGdP?=
 =?utf-8?B?ZzErY2U0aDJhYnBCaUdJZXluT3p2ZHNYUzUwTmQxWGZRTzhEWEZpR0lUTGZp?=
 =?utf-8?B?SVZaRE9uc2RzWkZ2UE9xZERWaE9oZ0h0YVA5aWswMnJZbDc0T2piUUhDd3c0?=
 =?utf-8?B?djRmZU9kQVJPY3NVSkZ0dlZ2VEFIdnVUU1RYQWMxaFBNam5ZZVJ5VFROc3M1?=
 =?utf-8?B?M1NreHYvYnVHWXdKRGNsaGZWeEZlV2ZHSmdrRFVXNm5Tb2dWSkk1VlB3Zys4?=
 =?utf-8?B?WDB3cGJud3V5c0krUWwxYm9HaHdJeThlREFQZEtWVUFvMWs0ZXdvK2UyR2o0?=
 =?utf-8?B?dWhhSUY1Uk9VUGd3ZGdiWGY1RkRJTDdJdnE1VHJsa1FPYWFXM2RGQzc4S2gw?=
 =?utf-8?B?dmxxRnVYRmZCS1NuYkVsMHBVekVRN1RLaVBDQ0tRZ0JqdllPZUVoQ1RiQyt0?=
 =?utf-8?B?aE1KaEErRlYyVDJFblcrQ3JTeHRpcERsSFNoL0FZYjlmWDRlUUNrNGVKYTYv?=
 =?utf-8?B?bEtwZTNyNFVWRXZBYTZGS29hd0ZBOWVNWndidTZmQk9zbkRrbTZsa0ZzcTNP?=
 =?utf-8?B?Tnp0eU5QbWIxWHkyeWZ4ZHF4Slhvc291WXFCdm1rYWY3Vi8wRzF5U3NXWTln?=
 =?utf-8?B?OU1MKzVVTjB0QWNEcS9RRUtrQmlPVVdjYVQ0WmNXcEVST3hkYzZDMGpCd0U5?=
 =?utf-8?B?MExZTVpTdTd2S3ZHaHQyMmx4eHUxaVBtK1NRNUpteUphUlVobDdWRlBMaHJK?=
 =?utf-8?B?WVlscC9kUFJWNjVlUngvN2FhamhmbDBVYzAxbGlUUkNxRjU1NVlhbGdNdGFj?=
 =?utf-8?B?aVR2ZVdkTExtTG1KWmVVQU9LWm9TM1FnZ2pJWE5lK242ZnRHOFRWV2VjUTQw?=
 =?utf-8?B?UExRU1pyaDJTcU1xMVk0aVVjbytRS0d6b0tDdWhyeCtYcjlJYXlmOUdET0dQ?=
 =?utf-8?B?b3oxRll2WTBsSVdqQU00eXFxSWxYMGNkVFNUaHk2Sm5rSDRsSHVKSzdTQ0hm?=
 =?utf-8?B?Nkx4Yk9QcnN0QUVmbGxPY1h6U2xSd3VBMm9sWUdsV256bE83bk5GWHUrNU0x?=
 =?utf-8?B?bmJHaTdwMDBBeFREaHQ5Q2MyKzlXSnlhTzR4bkVZdERrWG9hZzhieTlJbk51?=
 =?utf-8?B?ODVIVmNsOWVtdGZzbkRhcXBmd095NkNLQU9lOHBiaWdTcVNySXBkbmpHSFZv?=
 =?utf-8?B?MExBVDcxZG1LUjBiUzl3Tm52c3pKRlBkOVk1ZkJub0JpVXp1dGhNaE4yYUJo?=
 =?utf-8?B?SjJtRzJLSVJHb2Q3Z0hHd0cwUjhWNmt3UjdEOUU4QXQxdWxUQXZSeUExNTZh?=
 =?utf-8?B?T2NuUzRtT2dtRVFjT2NJYkIrZDRHRGp0b1BoTFo3bTNwUWN5OVhQZz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320b5dad-0bc1-4bf1-62b5-08de7a6839b1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:35:19.8343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSRb3VLTVTM/i2ooYHRQPjyLS3YRhNiue0LIDrl9/WFQlio+pyZu7EALt3nBqhSLn2lvgrg3uB5lmJBRT8O/ECEXbndy1ttg3iDR1S7/PI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8190
X-Rspamd-Queue-Id: C844D20A9C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-9261-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amlogic.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amlogic.com:dkim,amlogic.com:email,amlogic.com:mid]
X-Rspamd-Action: no action

Hi Frank,
    Thanks for your review.

On 2026/3/4 23:48, Frank Li wrote:
> On Wed, Mar 04, 2026 at 06:14:13AM +0000, Xianwei Zhao wrote:
>> Amlogic A9 SoCs include a general-purpose DMA controller that can be used
>> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
>> is associated with a dedicated DMA channel in hardware.
>>
>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> ---
>>   drivers/dma/Kconfig       |   9 +
>>   drivers/dma/Makefile      |   1 +
>>   drivers/dma/amlogic-dma.c | 585 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 595 insertions(+)
>>
> ...
>> +
>> +static int aml_dma_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     size_t size = size_mul(sizeof(struct aml_dma_sg_link), DMA_MAX_LINK);
>> +
>> +     aml_chan->sg_link = dma_alloc_coherent(aml_dma->dma_device.dev, size,
>> +                                            &aml_chan->sg_link_phys, GFP_KERNEL);
>> +     if (!aml_chan->sg_link)
>> +             return  -ENOMEM;
>> +
>> +     /* offset is the same RCH_CFG and WCH_CFG */
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
> regmap_set_bits()
> 
>> +     aml_chan->status = DMA_COMPLETE;
>> +     dma_async_tx_descriptor_init(&aml_chan->desc, chan);
>> +     aml_chan->desc.tx_submit = aml_dma_tx_submit;
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, 0);
> regmap_clear_bits();
> 
>> +
>> +     return 0;
>> +}
>> +
>> +static void aml_dma_free_chan_resources(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +
>> +     aml_chan->status = DMA_COMPLETE;
>> +     dma_free_coherent(aml_dma->dma_device.dev,
>> +                       sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
>> +                       aml_chan->sg_link, aml_chan->sg_link_phys);
>> +}
>> +
> ...
>> +
>> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
>> +             (struct dma_chan *chan, struct scatterlist *sgl,
>> +             unsigned int sg_len, enum dma_transfer_direction direction,
>> +             unsigned long flags, void *context)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     struct aml_dma_sg_link *sg_link;
>> +     struct scatterlist *sg;
>> +     int idx = 0;
>> +     u64 paddr;
>> +     u32 reg, link_count, avail, chan_id;
>> +     u32 i;
>> +
>> +     if (aml_chan->direction != direction) {
>> +             dev_err(aml_dma->dma_device.dev, "direction not support\n");
>> +             return NULL;
>> +     }
>> +
>> +     switch (aml_chan->status) {
>> +     case DMA_IN_PROGRESS:
>> +             dev_err(aml_dma->dma_device.dev, "not support multi tx_desciptor\n");
>> +             return NULL;
>> +
>> +     case DMA_COMPLETE:
>> +             aml_chan->data_len = 0;
>> +             chan_id = aml_chan->chan_id;
>> +             reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : RCH_INT_MASK;
>> +             regmap_update_bits(aml_dma->regmap, reg, BIT(chan_id), BIT(chan_id));
>> +
>> +             break;
>> +     default:
>> +             dev_err(aml_dma->dma_device.dev, "status error\n");
>> +             return NULL;
>> +     }
>> +
>> +     link_count = sg_nents_for_dma(sgl, sg_len, SG_MAX_LEN);
>> +
>> +     if (link_count > DMA_MAX_LINK) {
>> +             dev_err(aml_dma->dma_device.dev,
>> +                     "maximum number of sg exceeded: %d > %d\n",
>> +                     sg_len, DMA_MAX_LINK);
>> +             aml_chan->status = DMA_ERROR;
>> +             return NULL;
>> +     }
>> +
>> +     aml_chan->status = DMA_IN_PROGRESS;
>> +
>> +     for_each_sg(sgl, sg, sg_len, i) {
>> +             avail = sg_dma_len(sg);
>> +             paddr = sg->dma_address;
>> +             while (avail > SG_MAX_LEN) {
>> +                     sg_link = &aml_chan->sg_link[idx++];
>> +                     /* set dma address and len  to sglink*/
>> +                     sg_link->address = paddr;
>> +                     sg_link->ctl = FIELD_PREP(LINK_LEN, SG_MAX_LEN);
>> +                     paddr = paddr + SG_MAX_LEN;
>> +                     avail = avail - SG_MAX_LEN;
>> +             }
>> +             sg_link = &aml_chan->sg_link[idx++];
>> +             /* set dma address and len  to sglink*/
>> +             sg_link->address = paddr;
> Support here dma_wmb() to make previous write complete before update
> OWNER BIT.
> 
> Where update OWNER bit to tall DMA engine sg_link ready?
>

This DMA hardware does not have OWNER BIT.

DMA working steps:
The first step is to prepare the corresponding link memory.
(This is what the aml_dma_prep_slave_sg work involves.)

The second step is to write link phy address into the control register, 
and data length into the control register. THis will trigger DMA work.
For the memory-to-device channel, an additional register needs to be 
written to trigger the transfer
(This part is implemented in aml_enable_dma_channel function.)

In v1 and v2 I placed dma_wmb() at the beginning of 
aml_enable_dma_channel. You said it was okay not to use it, so I drop it.

>> +             sg_link->ctl = FIELD_PREP(LINK_LEN, avail);
>> +
>> +             aml_chan->data_len += sg_dma_len(sg);
>> +     }
>> +     aml_chan->sg_link_cnt = idx;
>> +
>> +     return &aml_chan->desc;
>> +}
>> +
>> +static int aml_dma_pause_chan(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, CFG_PAUSE);
> regmap_set_bits(), check others
> 
>> +     aml_chan->pre_status = aml_chan->status;
>> +     aml_chan->status = DMA_PAUSED;
>> +
>> +     return 0;
>> +}
>> +
> ...
>> +
>> +     dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
>> +
>> +     dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
>> +     dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
>> +     dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
>> +     dma_dev->device_tx_status = aml_dma_tx_status;
>> +     dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
>> +
>> +     dma_dev->device_pause = aml_dma_pause_chan;
>> +     dma_dev->device_resume = aml_dma_resume_chan;
> align callback name, aml_dma_chan_resume()
> 
>> +     dma_dev->device_terminate_all = aml_dma_terminate_all;
>> +     dma_dev->device_issue_pending = aml_dma_enable_chan;
> aml_dma_issue_pending()
> 
> Frank
>> +     /* PIO 4 bytes and I2C 1 byte */
>> +     dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
>> +     dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>> +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>> +
> ...
>> --
>> 2.52.0

