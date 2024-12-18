Return-Path: <dmaengine+bounces-4019-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383DE9F6741
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 14:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C641188BA3E
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 13:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31F41ACEC1;
	Wed, 18 Dec 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WMDni723"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2065.outbound.protection.outlook.com [40.107.247.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57671A239D;
	Wed, 18 Dec 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528284; cv=fail; b=MHFL26cGeOJwdsTER4cIJyK9MxKDRsmuRrGtdJKWMqrQbG7YsQkYqB7gpSooh5YfjcagmGs3SWFs4O5JAi0NfO5iCEfE9NeOChmjz/qxbd8osak9eB8o3TKZ1qRHdPcqcyoZaEpyDeqFfPixXC3uZ/qq8ZFCj2RE8gIINnUhdkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528284; c=relaxed/simple;
	bh=awJc9np/WW9i5jmjAnAFNv3N4UO057+y0ngzWGufDE0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aheV+W5TO/T03hkTyUMMRjkE+xeKIP6q3caSR5HnvWaAoMdGv8LGqtHPrT5C7fYJzPmnFQolkJUWquPhEkgCniQmNfEF3PF2WDFf1tqktjM6NMene2QbtWHHc+fs4px+AYAC1Hm7cV3DhB7Vtl20BmldFpsqZhTl9E+tySkv6eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WMDni723; arc=fail smtp.client-ip=40.107.247.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwF1wLRiNYa5UppTy8Z6lixUL8vwrITQgmjJh7ZSKSWH7wZENyKiGnfxjmsJI/IyQBGU3+sOBdotOSRn0/aZYvgvq9cveNEWz+GkJfi0DzPUz2/umfynjEeq2h8sGGMvx6gJahoGdzf5QKbI/1RHHvvbDS434k9bIEGhmH6b9PJZCf3nodzsktxgzVKPyIjCLcyWZSSt1nE3MlA8Vu+RSkYpofMAGxTgqgGXbvAj3rh4mrpZRmgDmi8HIUr4zyMAiiAGwAGDJT6JmNya5CEsU33HxeNerptQS0lQmtIHfwULBYzp6eSKzaw6uBeKaXBj4FNmVHxaATcWwhHJBj2PJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMB/Mz+Kxu3F+Nqsy9av8nanokeOX89/CR+lLWspXu8=;
 b=oYrR92FGKxYcbzX4vL9ewO2crm9Px4QTwec+RsLNrAsMtKiDSnLWYLX9oaKWwvyLiymLUithasQUQ8OPRLLPENZW/5SO8B6oboqK2OTvyXNQg6b1SDWhHfxNp21kDTFVPljv5vZrTTQ+DUh65CZ2S3pd3YmV04/RrShHOMw9cyU0mdhHJ7ZiKM+6yCriPnCm3ek3ASar0QtKNFtXhh6KEk8q4Ji7dOyRzwYinjOV6iDzKBgCfrVfHq7l4T6wa3H9xFoUp9WAHZhbOPiPc45UREvaxukXC7PCvawvOB1jZ6MaoRzjr6aGHjVTM5GjxsunWpp5sO6QcYd044LPLFNOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMB/Mz+Kxu3F+Nqsy9av8nanokeOX89/CR+lLWspXu8=;
 b=WMDni7233t4bypPLKiLmm4UMK5qXdX8hi3X6Pr5b/aRKkyfBCOfQhnVjF8M9AYCtG6zPv1LkXVJcjPzl3cBTqvxY6JSNtDfeHf/MoMfu3ELFmwrPYpmDK9MDNVQc4JZfAwjfwz4af5F7StI/yY6SQNJi8a/hGA46ecahWgPggBVSyQQcvw93ihbOORbwRVGbcSo1LbnM0UD0/Lp6430yAeM7JBVBsA19hnWGTTnjHLerzHzvZGbY7cFYUcw2VckrUF1uzfnZKsG0n+dB45UfcAcDeoUZ0QhYM5f5nYpW0Sla2FhwaYS/zx9CJJg7XkbN/93s9h5iSEeCbU3tWalsIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9567.eurprd04.prod.outlook.com (2603:10a6:102:26d::9)
 by PAXPR04MB8077.eurprd04.prod.outlook.com (2603:10a6:102:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 13:24:38 +0000
Received: from PA4PR04MB9567.eurprd04.prod.outlook.com
 ([fe80::83be:fff8:5a00:a515]) by PA4PR04MB9567.eurprd04.prod.outlook.com
 ([fe80::83be:fff8:5a00:a515%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 13:24:38 +0000
Message-ID: <458f8940-4451-4dbd-bd50-75a43e4248d3@oss.nxp.com>
Date: Wed, 18 Dec 2024 15:24:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] dmaengine: fsl-edma: wait until no hardware request
 is in progress
To: Krzysztof Kozlowski <krzk@kernel.org>, Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-8-larisa.grigore@oss.nxp.com>
 <d4afb25d-5993-4f80-9f80-0a548b6532cd@kernel.org>
 <d5badfcf-58d7-49d4-8a5a-d31de498f015@oss.nxp.com>
 <2e0e1fe3-af5e-4416-8b34-3fecb923b481@kernel.org>
Content-Language: en-US
From: Larisa Ileana Grigore <larisa.grigore@oss.nxp.com>
In-Reply-To: <2e0e1fe3-af5e-4416-8b34-3fecb923b481@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR07CA0017.eurprd07.prod.outlook.com
 (2603:10a6:205:1::30) To PA4PR04MB9567.eurprd04.prod.outlook.com
 (2603:10a6:102:26d::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9567:EE_|PAXPR04MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8df2a6-8e50-47a5-b47a-08dd1f675282
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUZBeGJwR2VVSFZmUjY3NWp1anJ3YUxoRWV2UVAxUkJZVXJvQUhSbFN5T2t6?=
 =?utf-8?B?SDVob1dMVldwemo5dVM5Nkd2MzdLeFFtbUt5NEI1VlFEcWxLZG1lVG5zdlI2?=
 =?utf-8?B?YzRzc01rMmlyRFZUL3JYQjVZOGFmclVicEJYdHhRaXV1V3ExdG9EdUxIanJk?=
 =?utf-8?B?T3E4ZHF4UnZYNWI5S3lrSVdjWjdSWWpYTHJPK1ZHeVdzNDNSRzlrZWtkaDNa?=
 =?utf-8?B?Nm03MXJ3eVY2dzZQdi9SM0F3RUl1bFo1Mlo3MU50TmoyTi90V05HRi8zQ2pV?=
 =?utf-8?B?TW55ek0yZXF3MGVrdFRDTWZ1VzM4dmZFVThLd2tEa09ETWdIVHltZFo0QUxa?=
 =?utf-8?B?T29NOUptS2c5NGZ6ZHFteGdMMDFXUGpkU3dKcmthWXhEUHpOQVR1UUYwMXhz?=
 =?utf-8?B?ZEhwbXlmOGhyRnhtWW1QRU84d01kNk5tQjlIT0NXZHJ2Zk95bnFkanF6c0Vl?=
 =?utf-8?B?MFgzaWNzYzBqMUpIcGdVVS9rL0tQRkpMbGFNU3VTcVd3WkRjTFY1R2hPY1NH?=
 =?utf-8?B?S2JCWCs2cFdPKytGLyttVDhlQ3hqVkd1TWJIYkp1NXF5d3BPTVlmbG93b2oz?=
 =?utf-8?B?SEN5c08ya1ozRFQ1TnY2dzNwQnFYK0t6M1Z0WUVEU2V3THhONU9vR1E3OWgz?=
 =?utf-8?B?VGhzZFJYRlcvZXo4cFo1UWJSbDlzVVZYbmJLVHJmZVJUbXl1ejE2MlNtQjZk?=
 =?utf-8?B?UTRBSE5XQk15NHJKN25IemdYL0phSUVqcFVzcE04UUxRNWFRVUtPb0c4WHZI?=
 =?utf-8?B?Ty9abUxwdnNYR2Fjd1JBd2NJUmJOWk14MUNXUzZVTExJWFg5YjRuMklYRXBN?=
 =?utf-8?B?YWI1ZUdFaUVsVlVJNXdHdGFuNkVrMjNCT0U3Q3hDdEgrOVNnRTNacXdpOVFF?=
 =?utf-8?B?T0ZJZXFSS2Z0Y1pVVnQ5ZThYY3JrckEvU1dRdG9aZFdiMURJREJSWSs3ZDVl?=
 =?utf-8?B?d2VtSmpKWm1PejZmNmV3VExWbHBPZkw0YXlvdmNPR0lYU3ArU2JvRzJwRGQ2?=
 =?utf-8?B?UjU1VnFSQzk3U3R2ZUtZTVFyWjA3MXcvKzFYY29OZTZhSEJqdmhhQ1FORVdS?=
 =?utf-8?B?QzkrR1Vac0lyNHZNSHZMVzJsaHFSVzNhV1lRckpwSWR2NmRrRjNYN1NuUmg1?=
 =?utf-8?B?YXFWRGFCV1FFUWwwZEErRTdVVVN6M2xkOCtTUUw3M2pHTnZZb2oramxSR01n?=
 =?utf-8?B?SDNGMndRZGVkTmlYNjB2TmgvQktha1FlOHpYZzk5Nm1qRjZYSnczYisrNUNR?=
 =?utf-8?B?UWpsdE9JUHROVVJWSWJYWUFpVEZkejJGVHVrVDJiYW1SOVA1WmRsVlRFTDdv?=
 =?utf-8?B?a090cjlDWm94dUEzZmVoMkJEMlZZSEk4cmlyTWpJMVBsNnovNkh4MUtXVi8z?=
 =?utf-8?B?c2p2UGpaVnV2Q0RneGc4em9HOWR0a3M0VnV0aHhjWXA2WHhiU1p1OUc0SWtO?=
 =?utf-8?B?Q2xwTXovWHNzaG9TQkNERlJlU2VYWThyajc4SDlnUFBvbUErVHFMMFRnSFpY?=
 =?utf-8?B?QkYrb1h3S0tTL1EzdXo5WXR3RzAvNVlhaEtQbDM1Y2RkR2ZHUGVZeDJSakg0?=
 =?utf-8?B?TFNINWRNV0UwU0tIQ2E2R2dLZENwTzNzRTFxaXJJQXJXQ0g1YjVzZkpobldQ?=
 =?utf-8?B?aW5oZjVoLzk3UWtYQUtLRTNhVmI3eElEa2NqUmc2bytCMEZPc1pHM2tXQ3Zh?=
 =?utf-8?B?OVJPZTNNcUEzQitYN0hESFA0WUp3emhHVHloSUltTHZJNWNLZUZPVzZ1UkYv?=
 =?utf-8?B?MjR1RVBnVFlPUU9MT1NNMWUxcFRyZjI3a1dPL0dpWmpwVlI3MEw3TmltTGo0?=
 =?utf-8?B?MFNxLytybHlFZFFzRHhMQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3FVRWZHbFVPSnYzRG00c01DdlZaTktyS1BVZlJoMXZDQkRLRUhyNWhmaXBB?=
 =?utf-8?B?N21TQ1NXaTVWeTlGVWkvem9yM1R1ZnpRWTFybzVaeXhab3BXc0QyN090SXNw?=
 =?utf-8?B?UmtzOE41Z2FDaFhtMHc1UDVFL29wUmtXV3JiMmpUS2l3NmVqaDJQNlByUVZP?=
 =?utf-8?B?ZDAyUVl4TmFFM3hwSXpDQkNtQnduQlgrRkN5Sk9mYTJtc01VbG16dTNadVFW?=
 =?utf-8?B?MnB0Z0RyZjhBUkQ3ZXFHZ3UwT2M0YnFmQUJzcEZHN3N6S3U2Wm5kVXg1eVNy?=
 =?utf-8?B?aWNDSTIwM3lRbWYrWC9rV0FGNE00Q1lSR2MvaUF0YURtcC8vTFgwVmpPQ3Iw?=
 =?utf-8?B?ZUVCelA4Y3R1TFhtMDcvUVhzWWpLN2ZsT2swMXpJaVRQMG45a3JDNEpjd1hh?=
 =?utf-8?B?MEVhTVgzcWI3dWFMYStYc2pSSi8xV1R3ODM3NzVPMW9WamlVWUd4eGo3NHRn?=
 =?utf-8?B?N2tSMTlnMkRDbTlVMU5IaS9jbmhXSXRqOXY0S0VnSlJpVXNXS1l3NGp0UUFZ?=
 =?utf-8?B?QzhJcTJ3aGMzZlY1TlA2bDM2Ukd6RjFVU2FhOHVWOTA3WG5rN1ZoYnNYbXVa?=
 =?utf-8?B?bU9Oc3FDR2p1Z0dxbDR1eFlrdHExRHA0ZnBHWE0ySEpIY0MzYlRVY0Nid3VS?=
 =?utf-8?B?azNDWHhVM1NFUFlZclQzV1RCa0ZRM3VYZHp2OSt1SmVnbm9GMDBxUTZEMDZv?=
 =?utf-8?B?R3pVN0l2azN2WDlYVTQvT3A4aEpVcXR6bkxEUzE0cDR4dmdRYU11ZVhEUjRR?=
 =?utf-8?B?T0pJaWE2S0VBbFYrZTllUUxpM29FQ3VsODVoSURDUHlsWEFBTi9nVzNYNjF4?=
 =?utf-8?B?TFl5TDV0eWRGdjdSUFV0ckcrd0J3RHNTdFlRUnppWS82akp3VW5obTQzNEFE?=
 =?utf-8?B?REYrdTUwTzc0V3pyWWtJdnV6ZlJpYksyWTExTVphSjNZMFpCT21NU0ppTWxu?=
 =?utf-8?B?eWQyZ2F5VmJoemp2TFJoa2U3cGhaU2V2dFgvT1ZyTjRNdi9tTC9UVmliUE5O?=
 =?utf-8?B?eTdGZldad0RsOGZ3bm1TU016T2ZmMVpsb1dGR0toRHlaaloydlVDc3l1UTdO?=
 =?utf-8?B?WURFdlZBalFnM3B0b0dMUU8vSloyZGNpcXZ5bUdsVHlNeHZjd0lKNE1wNWcr?=
 =?utf-8?B?RTROb3FMeEo3QVREL0FRZmZPZlVCSmZqZmkrOHZ5N2FDcS9ISFJZb1Z3L3Zi?=
 =?utf-8?B?UWpYZnJudXI4ZDBTV2JSblY1UDFzN3FKZTg0US92d3U1ajNWSVgzRWZOUlBj?=
 =?utf-8?B?Wklud3R4S003VFYvOU1XanVDbFdYdzBTZkpoTTAySXNGQlNTMDlIV1BmU1lV?=
 =?utf-8?B?V05BS0p3TG1tSUQramJLSWVBWHpHdXJzQklmYVU0TFhaZHBLanZwenYrSkNa?=
 =?utf-8?B?bm9neDNOcHdaK0pFQ0F2U2EycGdtQkpGeGVSNkNyS1Z5T1JoTmZXZmlvRW5q?=
 =?utf-8?B?L2RoS2VSK2FPUzdzSVJaUElWaXVCc09ncXdJZThyMXppcHNVZlNGaTM4VEFT?=
 =?utf-8?B?QUF6RDYwTlBVYlNRaWRORDNiRDZ0ZGRyZ25qZDZEaTRveURLaVYrOE9jT240?=
 =?utf-8?B?N3JVampGbXRCRkgra1VzSGlQNy81a0RNa295NXM2UXZneXp6T3kyTzFNQm0x?=
 =?utf-8?B?bHBTQUFXdDA2NlFYUXhnU1loM1crMUFZVGNnMEU3Sm9sWHJrcnhFTndleThx?=
 =?utf-8?B?ZEh1L09zL2wrSHh4WkFaWHV3WDBhVmNScVRCNWhoeUluWHhaS0cra0hpNXZK?=
 =?utf-8?B?YU4yR3pTV3R5bEQ5QXFKUTd4V1BHcnpFcDhSMTM3VUV3aDZabTk5dXRENC9n?=
 =?utf-8?B?SDRrb043RllBZll2Tm9teitraUxtUGhYTGw0WXNUN1ZxQldPWUk5L0hHUkRF?=
 =?utf-8?B?K2xMM01iNkVNUTh0RTV4Tk5JalVZQUFGNENjVXJYM21OcFFVdStxNE1lUHJJ?=
 =?utf-8?B?MFFtbkpFQ0ZqZzhjTWY5cDBTOENad01vdlVIT2hPYXBXMTgzZ2VyUlJLWG41?=
 =?utf-8?B?TmV2YVJzdzdsekF5T2xLbVkrSnVya05HRDRINlNRLzcwM3R1RHhEWUl5dmVv?=
 =?utf-8?B?eEpGK1BGaC9XT1NhSHBWUU0zbVVGWjBYOEdhRVZrR0VLenhFNzVlZG5MTm05?=
 =?utf-8?B?UzNvOHFnalM3RTF5NnQ3WW1lR0ZwR1JOdC9IWDhoVkdiRmVyU2Z0NktFOFVq?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8df2a6-8e50-47a5-b47a-08dd1f675282
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:24:38.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs4E5iIwXZqSd0+whpr9tP9L+ngcI4xaDTEroEofAyuH6kW9xbsWq7sfRIga0STgRs8pK09mINE96Qa8l31apg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8077

On 12/17/2024 5:27 PM, Krzysztof Kozlowski wrote:
> On 17/12/2024 15:19, Larisa Ileana Grigore wrote:
>> On 12/17/2024 7:27 AM, Krzysztof Kozlowski wrote:
>>> [You don't often get email from krzk@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On 16/12/2024 08:58, Larisa Grigore wrote:
>>>> Wait DMA hardware complete cleanup work by checking HRS bit before
>>>> disabling the channel to make sure trail data is already written to
>>>> memory.
>>>>
>>>> Fixes: 72f5801a4e2b7 ("dmaengine: fsl-edma: integrate v3 support")
>>>
>>> Why Fixes are at the end of the patchset? They must be either separate
>>> patchset or first patches.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Thank you for you review Krzysztof! Indeed, this commit should be moved
>> right after "dmaengine: fsl-edma: add eDMAv3 registers to edma_regs"
> 
> I don't understand this. Are you saying you introduce bug in one patch
> and fix in other? Why this cannot be separate patchset?

The bug was introduced by 72f5801a4e2b7 ("dmaengine: fsl-edma: integrate 
v3 support"), commit which is already upstream.

In the proposed fix, a channel is disabled after checking the HRS 
register which is a eDMAv3 specific register.

In the upstream implementation, "struct edma_regs" is created based on 
the eDMAv2 register layout [1] which is different compared to the eDMAv3 
register layout.
The "hrs" field, which is used to access the HRS register, was 
introduced in one of the patches from this set [2].
So, this fix depends on two other commits:
"dmaengine: fsl-edma: add eDMAv3 registers to edma_regs"  [2]
"dmaengine: fsl-edma: move eDMAv2 related registers to a new structure 
’edma2_regs’" [3]

"dmaengine: fsl-edma: add support for S32G based platforms" [4] depends 
also on [2] because it reads another eDMAv3 specific register "ES". This 
is the reason I've sent all these patches together.

Please let me know your thoughts.


[1] 
https://elixir.bootlin.com/linux/v6.12.4/source/drivers/dma/fsl-edma-common.h#L123
[2] 
https://lore.kernel.org/all/20241216075819.2066772-5-larisa.grigore@oss.nxp.com/
[3] 
https://lore.kernel.org/all/20241216075819.2066772-4-larisa.grigore@oss.nxp.com/
[4] 
https://lore.kernel.org/all/20241216075819.2066772-7-larisa.grigore@oss.nxp.com/

> Best regards,
> Krzysztof

Best regards,
Larisa

