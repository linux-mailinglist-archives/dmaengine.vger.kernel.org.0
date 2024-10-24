Return-Path: <dmaengine+bounces-3490-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 089809AEE0B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 657BCB28413
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 17:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD6E1F80CB;
	Thu, 24 Oct 2024 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="o922Q69y"
X-Original-To: dmaengine@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazolkn19011036.outbound.protection.outlook.com [52.103.37.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F6A1EC01B;
	Thu, 24 Oct 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.37.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790890; cv=fail; b=S1lUfSukUdnI2s8qL0kJpKGYjF3ojnlt4xDuQruYU8k0k/bcVbNInrRRheJTe3lNFFExeS1f1tzUyMbvj3YYEQdL8DtFbAvAwvM2OhyitfhgmVT9JKmQCOaCbrglXFrBMy54civIjJbBRBc/xsBngEawNLGV0saTWJ+iATszLqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790890; c=relaxed/simple;
	bh=VV85186u6M9h+sbYRkTycsnawutw9QK9fJUvzuUqsJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uZ1wLQCTaRjABmoCAeRL6OlxQ8pTm6TqZgAgvS2Gu3Qn7ZDWfsAFjZo+lzUkcjRZTQR/l+EDuCURe3M4sZqxIs9Wu19hJG5rKsAw8QnmL/1m3rzVbXv8Y7fcThhWmrgLuk3nIO7BNz8r1CO/tXHKiLYGIxLoBapPJ847AtR/In8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=o922Q69y; arc=fail smtp.client-ip=52.103.37.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUVGT5SsIKZrYwIZJNJStlkss+rc17M72JdZ+UFdHzxOpn3gfyA53FueQZytgQvj5QXQ8erieNgikTKelYZa87GiYp6kWsDIS+EpzykhZCt1pNqnLx5QWtR4ookH28KCiaxHWy8LKxAyOFQRyVZmMqxI6/szmDOYJmR4ebVOewniR0juregFzUYUMhKe6w4B4ryCIcB+BVEu9G8TDjZpAVH9EAalLTE6LzVUt7F50PV12b346PClNXcLRrx6CLkAu297GsmnSNOSK5MjvefHCAJYu3dlk4UFC+S4vCwJ7J50BBgur1xDI8R+s0KsIte0Y6X5gcmBA3rjUZtHq6e7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV2qbjmwJ7sbK2f59q12HaBPJaQ1XN5dFnSbf9YGAag=;
 b=WzuSa1cUicUqArMOfC3z5yyQF/V8o39J5iIu+7IuMoAEQnm5waQEqvZgYLLVcNHHC5+kREmyqzMk5lwOSIYog3WqrTLhK1md2F7KeSph2BsyRGwlo+CrOkau5YdyX+TgSOA6UZNfJnGsy+sB25tcHbVrLZZjwsz/51D0mNh8rukHFFF7BuKEZZJazB/T7X1rT4T29HcqALx3w+znROI7XtZs1nqUdp6aY6MkV/XfRDVAzLjeJD8Ok0Yq4I8C1m0An4bJERQzgzyM9w0ZdVZF2JILKYhUQ0LmRZzDiWeix2elHgvNbJ91ib6gST9pqbhfHPOQltVjUEETLVsbcwvfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV2qbjmwJ7sbK2f59q12HaBPJaQ1XN5dFnSbf9YGAag=;
 b=o922Q69ylkqbDXxxfWrtY7FXTiNRGjBbkWjdb3KxS4iD0XxrQjbmmU7Gz4ff//tMgctvBNkw8O/2qjsHDab7i8fyFKFb6hjHhiwyQMs4n03ODMDDjE6IWA3ZHyfbLTp0okSeHRb8YeJFUpuWeYglS7F7BWjV7Jjx/SsN/L/w5Pc4G17Jjws8NCDLzWtqlS2AGr/CY+He2jxj3rFMDg1GWXAW/RnXFMgygzuRdCq8kkW4fEZbCk4JQ70mPJ9MjmSVLoLLUeoyuJPkKw9Z5o92MiYNT6nW+kHVX65u5fu0AkCq58pi2t+vzf8k30g55dEpk+FI1SvarVt1utYVvVhPog==
Received: from LO0P265MB3211.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:158::14)
 by LO2P265MB7186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:32d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 17:28:05 +0000
Received: from LO0P265MB3211.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b500:c582:9cd5:f0c6]) by LO0P265MB3211.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b500:c582:9cd5:f0c6%6]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 17:28:05 +0000
Message-ID:
 <LO0P265MB3211CEE441161D66701B6DD9AA4E2@LO0P265MB3211.GBRP265.PROD.OUTLOOK.COM>
Date: Thu, 24 Oct 2024 18:28:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Guenter Roeck <linux@roeck-us.net>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ivan Epifanov <isage.dna@gmail.com>
Cc: torvalds@linux-foundation.org, aospan@netup.ru,
 conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
 dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com,
 geert@linux-m68k.org, gregkh@linuxfoundation.org,
 hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, jeffbai@aosc.io,
 kexybiscuit@aosc.io, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, mattst88@gmail.com,
 netdev@vger.kernel.org, nikita@trvn.ru, ntb@lists.linux.dev,
 patches@lists.linux.dev, richard.henderson@linaro.org, s.shtylyov@omp.ru,
 serjk@netup.ru, shc_work@mail.ru, torvic9@mailbox.org,
 tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, wangyuli@uniontech.com,
 wsa+renesas@sang-engineering.com, xeb@mail.ru
References: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <20241024095708.189649-1-isage.dna@gmail.com>
 <Zxpqnf1M8rPTB4DN@black.fi.intel.com>
 <61a622bd-7597-45e2-96d9-9cba02fba407@roeck-us.net>
Content-Language: en-US
From: Nopempele N <nopempele@hotmail.com>
In-Reply-To: <61a622bd-7597-45e2-96d9-9cba02fba407@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0182.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::26) To LO0P265MB3211.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:158::14)
X-Microsoft-Original-Message-ID:
 <abf18714-fb03-41e5-8e52-7f70c967b323@hotmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO0P265MB3211:EE_|LO2P265MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 079c24d6-12ec-4214-32f5-08dcf45137f2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|8060799006|19110799003|461199028|15080799006|7092599003|3412199025|4302099013|440099028|10035399004|3430499032|1602099012;
X-Microsoft-Antispam-Message-Info:
	013K+YcmGazcTfx2N1BbHUFLJzjcyR0lKZFMuVouCNgFxIN/0jznLUrY4iEDFJwPpWgJe6001777DfrqzGmnXm61Upf6uPRk4/v0NS2jFbs3bsCYIhrZRq+l2wyXF73oayKs2g0nfVkH5HZys2ZpOoMDwSZb0/rOmgA8C5eo9PZ/wUiixixy6tAQYcSm88ddzNh3B4kP1YAROkXCfKK4tRNkEbD2TasA+0bclbOlY3D1DJt11/yqpkDnzX0mVfAhbhG4X4YZmdC7bC8eAsTHk6doJcm+/73zp4SAtDoxeOLVJdGgwmx20GxnzfX3WAx9T5GHvieP0iuaj+KJZgui/xRo24ofhKN0Heh/RstbmWT3iSmDZqvCtJrUIyytGzv6lGWiXh7i6A5UoKVl+xWMUczE4KHlQFQcfcEUr7aioi5h8vkrn0hAT3E9Q8PsBNwOgB7Gnn3yRJkG40IBlSffvzdGhUdDOUpxCMJI382H3tyOQd6w7EsSphHYzJue1UJriO3CRKx1P5jO95ElpFcR0Y+h3sGeCIr8pIzsrwlz1C5fVN+06U8Mg8ImgGhXyGyxp7Fun7icI4e4sxoyvvwHPi/ddxJZqlC2bz23e/aUBl5+n5q7et2/BvbDTOkaqmqr+xqGVnXVOfjkGwYmb3lnWqBNP+rTiAbyGVJdkWaBTHAeKTKFPphKWADV40oncYFyCIqzUEy2VK7H3JftmuL7kZ0V4BNYNHP/INsT66E9rpjFPXxDa5xd4a6Jj/gNswh2sGnpzmgvlVys6X1i6YBPAZH5Llgw2erFv2BC4xMuK+OYGX6iJCHucB67Uy9fgdagLYay/eY7cSU0FFeZxIeDPdmz6Tnb7KeWQ9pxbHDZRTMWGD+V0M4MRSQvUKM+iEFHMiZsC5eOkmKK4yLqJOG28eAXO3mRimkw6D3dxcaqqUg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHdETWJ2Mi94K001bjZoWmIvbDVBR1RkTTZSVDhvejY0bXJwV0Q5dCtITVk2?=
 =?utf-8?B?eEkvaUV6U29FUkpOSm1hNUFFeG1YZUJnQWtkaDBnWlpwaFZCbE9XdUpvMmcy?=
 =?utf-8?B?MTB6R0cybGNiY1lxUTZuUVMybTg0ZDRQQ3J0UURxelF4TExLR0xob2RTc3Iv?=
 =?utf-8?B?NVRsRFlwdkI5QnlrREswN3ZacW1Qb21EeFBKa3NTNDRJWk5CNER5TUpiWURx?=
 =?utf-8?B?aTJ3enZpR2FRUUFUNWNOQnVBRXA5SXo0WHU0cHA2M0swUDZsbFh3VkV0YTRJ?=
 =?utf-8?B?QUc5bzZISE5IbFFkVUtKOWEyNmpkamRQbHpOSXY0bEx4cDJ2TkozTUVXekU2?=
 =?utf-8?B?QWJYNEREY1NvNmF5ZWFwZDN2c25QUmpoQVRYNEhGcytyRlRsWnBSWk4xNUpt?=
 =?utf-8?B?SGFoVUd3b0lkdW9WOW1Sd1JQVlhvREd4TmRaSUN6eW1yUmVITlhFc2dSYjg0?=
 =?utf-8?B?UWJDMEt3bHZQV05xRldDRFB5RG9ncU0yK2dVMEtKMitmWlBRTXFGTW54eG5D?=
 =?utf-8?B?K2pSRDBzaDVQSTdCcUhDQVhrNTZFNW92cjh6dkdPbGVFYTVLcmNTMmJMMlVC?=
 =?utf-8?B?T1FUbytYd1pkc1lWL2l0UTVsWnorMU9MY0E2WDBDWnIwdHpRVmNaUHhKZU9t?=
 =?utf-8?B?NVAyOXNPKzZ2OEhnM0w4eFJUVnZrVkx0eVdVRWRYR01ySkN1RnM3UmxlTEJI?=
 =?utf-8?B?M0dZVWorVnIxMU5vcG9iTXlaTVhHa0N0Z21xai9Pa3A3Q3ZQQzB2U0ZiS1lw?=
 =?utf-8?B?UEUrUjJlOUJCZmlPRk9UV3ViUVNhZmJYTkQvNmc2UEdQbG1uNFRtQ1ZjRklT?=
 =?utf-8?B?RFNnOVNoN0pkZ01ZcUxNRVNMTmRVNkNLOGMza09QTVcya0gzU3RTY3ZOSGc2?=
 =?utf-8?B?djFmZkloRjY3Q0xiczlSQUdyMm9DeEZIYnVKTEU0OE9FVlJaOUk2TWtMYjVZ?=
 =?utf-8?B?bGFiZHp6OVZCUGgzZWRodFYvNUEvd3lkQThYUE93a1A4NkdBTzY4REIxNjhH?=
 =?utf-8?B?d2E1aE5SWmpCL2UxdjVJNVNXc2FrcUVqZ2ZTVzBNazhJS3lzbk8wQ1AzaVg5?=
 =?utf-8?B?TTIybVVNc3ZYbXcvakg2bzhUd3M5QW5QU3ArUkx5bkIyZk9MYkxpQXdMTi9D?=
 =?utf-8?B?MThJZklqNHhnZWRqbmpGRmRRZCtlNTJia1A2c2dyVUh2blVpOGkvOUxOL21W?=
 =?utf-8?B?T0dQODJaVWhaRHBra2Fqa2lLeUNGaGl5TzJyTVNwYk1hbkp1czFHelNybTNB?=
 =?utf-8?B?SlFYR0hOYzdhbFR1Vzh4WlVKZXcrd2xYclBoMjRiTUlZc0RGSWFMNUdJc2Vp?=
 =?utf-8?B?L1JVVHQxd2FZYUUwcXNHNm9EU2JFMzBIV0dWL3RnM1VVNWVaQlNGaFF3T0dD?=
 =?utf-8?B?RjJwRFp5bjNsekc0K0hKVG5BVVp0dDQ2Q0pzZzllL1dxTGE0K0p5VnpXVFo1?=
 =?utf-8?B?V0EwK0pMRWQ0S29jMGNURTZ5bUlzWVhzYnBoU0ZWZkV1bmdCVlBpVFlSUkZi?=
 =?utf-8?B?NjhmQ3Z5V1hVL0dGdHRLYWFqK0pxQmdZU2JYWkp0T2VqcmtiTytPcnhSWnFq?=
 =?utf-8?B?RG5zL0FGSERlYXlzVElsZ1VQS25CaG5nV2d4cXRvanptMUZZTFBNV01WUWF2?=
 =?utf-8?Q?MUzpqSLGNrNngw/3CXc+MB7beRsWER3l09TLg7oNaKqY=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-93a97.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 079c24d6-12ec-4214-32f5-08dcf45137f2
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB3211.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 17:28:04.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB7186

I really did not want to get involved as well, but Finland (together 
with Germany) also participated in the horrific Siege of Leningrad which 
lead to immeasurable suffering of its population:

https://en.wikipedia.org/wiki/Siege_of_Leningrad

This is something that many modern Russians living in Saint-Petersburg 
(ex-Leningrad) can relate to. Am I going to blame Linus or the Finnish 
nation for that? Of course not! Because I am not an idiot or a racist. 
And I can use something that Linus has mentioned previously - brains. 
Can you please do the same, Linus?

This really turned ugly, please stop trying to use history as your moral 
compass. Also, if you'd like to place a collective guilt on the whole 
group of people for past or present wrongdoings I would like to quote 
the words of famous Holocaust survivor and psychiatrist Viktor Frankl: 
"Collective guilt does not exist":

https://www.youtube.com/watch?v=leGKtWlwHt4

On 24/10/2024 17:15, Guenter Roeck wrote:
> On 10/24/24 08:41, Andy Shevchenko wrote:
>> On Thu, Oct 24, 2024 at 12:57:08PM +0300, Ivan Epifanov wrote:
>>>
>>>> I'm Finnish. Did you think I'd be *supporting* Russian
>>>> aggression? Apparently it's not just lack of real news, it's lack of
>>>> history knowledge too.
>>>
>>> As an avid history lover, you've seem to forgot, that Finland fought 
>>> on Nazi side.
>>> So yeah, we're well aware you don't like Russians, unless they're in 
>>> concentration camps.
>>> Which is exactly what you do now: segragate, based on nationality. 
>>> Strip of credits and names.
>>> Once a nazi - always a nazi. So, fuck you.
>>
>> $ git log --author="isage.dna@gmail.com"
>> (no results given)
>>
>
> I really don't want to get involved, but this misinformation really 
> goes too far.
>
> https://en.wikipedia.org/wiki/Finland_in_World_War_II
>
> provides context. And it does sound familiar. Turns out the Finnish 
> defended
> themselves against invasion from the Soviet Union. Sounds familiar ? 
> Guess it's
> the same as those alleged Nazis in Ukraine nowadays.
>
> Guenter
>

