Return-Path: <dmaengine+bounces-3983-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 680459F2FA9
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 12:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D9C1881A6E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7982204088;
	Mon, 16 Dec 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJjRRUq9"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8C200B8C;
	Mon, 16 Dec 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734349322; cv=fail; b=UdgLBWdnZjNTEH1yLxKq3Ph8ItgJAnGIahXwiid8DHTpspjhav9elZlGjzhal6viGPPN0uN1rRFURDrL0GXEs3hwDuEOZ88O7Ny6T7t0HYhD8Y47XKZO2gBWHyc5kp+WdJ2jIUjPfmufhgIwDohH6qr8TsWv+vPmAkkEnD6cdAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734349322; c=relaxed/simple;
	bh=g0ihiFsO1Od6yM5K530egnoBFGuEG7qABntHUzO9geY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sTzzDuC5aM+ffCZyQLPFMF45BufjlWOuUmRWT3B4SkrJB6Wqd8BFKgTdvdVUX71NuUVaF/1QG9kKX7QYl69bgdiWWotvtC5iT/Riet6m2TJdhnaWi0QRQ1RMhETKeTjSIHJtbvkF3T1RIPgnXZp/3uCZ2cj5y6p4n1isaKNg3A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJjRRUq9; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIDg0/yFzt4Pu9S+0OcSLAnHQWv3VL74tk2EkwQuV+mw1nwhKAJDSpdGYLPGVkT+3i8O/a1wJTzPTZ3H579cCQIlrfGjw7Eu5vy/DVWQu7rVoJYHKtp4vGeVTTT4Cwe72EY9kXN++7S+stqPfUd2qSj5B3Vbxvj8LMr4xZ+IUWjp69AClBMVmM96hsDd9CjvkEZSqKEmGZ3UmYeBIJjqSMPvL9RF6aoAjdLfSZ1eL/ZE59EgA/ZYuTOWNYHTHWkUMGtJCS0ogD+C6NFa2BRs9EKL97uHF7oEU/53zVqVwfeJoC2P4U1ET9rL/uBVfME5pKXo/IB3d9J5UTeWVdlNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkWIRJNV/+hwdaJNsb0ryzaL+MsLn5KQEdgpZYhmAN8=;
 b=eKl63IW2ZmhbbhlphKKt5qJIlO3tzSVJ/ARs1uuvU3Z6Qyyl9RDvCohpvgi+W2QNWg6FkKZakO/DpJ5MsjG58XEwN2bQTQkaBQXLBQPDCeXDCtNVEUalhwQG2qJuOLQxkO+xujH8vAxCZMnSfBhBTdVp1BZQ4PFEVrfUo15esmRM6UoeNKq++mnXqEiMH2dMSJYRKQXQhTzfL2PpcJT+0t1F3etOx9uZmY85IP6qEyNVlpy/pXnVvyheOWa5ZFJIJTjU/BMmIb5oTXLPWvpWaOfi/QFlkiCyYmA27iGgr8LSwi3NRgMe5YweUodm/EsjE1Wi9fKKGVvhEvxxXQgPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkWIRJNV/+hwdaJNsb0ryzaL+MsLn5KQEdgpZYhmAN8=;
 b=bJjRRUq9FumTwCg3YhCB5BnCEtdKjRlgzl/rRuKs/QmpfHm3psVuvRDAwTrIHrvAdOAXhqFVIc3Hz27rZk3XaYbc9VSsS4xiPQ//M2T7QG7s3u8/JuYTziee3o00bveLqPZ28xqUmGi1XTr5Qk9Ig8un1Z/sAT+2OYTsIW2mgHeJoeypfg2Zh/5aTbpDAAVfHEMbklDRRAa0uvXkv91wR4ntrVCFM0+smknxAoP+1OqhAFczyMTHgeUIHQXVWXJYnxDl1x9lOXX1x4U/fS8tk/0Qt4rIhm5YrH/sy2hbt8z+ULrk+EdXPdG3XZVUe33QomReQV92GGG6RzLq1xvpOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Mon, 16 Dec
 2024 11:41:58 +0000
Received: from DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b]) by DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 11:41:58 +0000
Message-ID: <c632fbb3-ef74-428a-a2e6-eb178f430824@nvidia.com>
Date: Mon, 16 Dec 2024 17:11:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: Support channel page to
 nvidia,tegra210-adma
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, spujar@nvidia.com
References: <20241213103939.3851827-1-mkumard@nvidia.com>
 <20241213103939.3851827-2-mkumard@nvidia.com>
 <x3cp6ho3ovwwarj3767ryoufvcqh5fe5fabtsjvrsg6ek6gjqz@iezeaqtav77o>
Content-Language: en-US
From: Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <x3cp6ho3ovwwarj3767ryoufvcqh5fe5fabtsjvrsg6ek6gjqz@iezeaqtav77o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::14) To DM4PR12MB5101.namprd12.prod.outlook.com
 (2603:10b6:5:390::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 25956fed-d411-45fa-9a75-08dd1dc6a5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1ZoYzF6VTNuN1ZSdlR1Z0tUb1BzTi8xS01hZUtXQWJRcmF1My91UlNTRzBE?=
 =?utf-8?B?ZDQ1NzY1SFcrejVZa1V1WG13TmhlQU8yUG9nb0hab1JPRnh1ejQySGhYZFla?=
 =?utf-8?B?SDBTcUtIVHFjcmpyNHBDUUoveThHMmdjZExQbkZ2YUNQRXdSaUoydXp2RSsz?=
 =?utf-8?B?d0orbWxlcTkxRndqeEtPR2QwK0JJZnRRcDlUd2duamdRaWNuS1lqTkM2cmpl?=
 =?utf-8?B?N3JnZUxJRlJpY0FEMG5tb3cwaDJoTXBiT0ZvdG5LdEg3SDRvczF6cy9Kc2tC?=
 =?utf-8?B?YmUvb0tndW9xUEUrQXkrNFJSSjY0Q3lrNGgxL21HdXVYOWl1UURIQkRYbm5B?=
 =?utf-8?B?dWRWeWY5WGdTS0pZaVQxc2FpVGxHV2RqdllYT0ZlbnhiMmVvMXBna0dEcXdN?=
 =?utf-8?B?VWZvei9pUk05ZnVwQ3Z5TGtGNDBkQ3duUjluWldYeDg2Y3dXQW9XdWtSdE8r?=
 =?utf-8?B?YXhaM3V2endmTFAzVGhVVTA2SmhBQ0IyM08xanlLZVBUMEdpcktLWHMvaVpk?=
 =?utf-8?B?MEVib3VHKzdTK1BBZjdYSTg1NGpreW15RkRrUkplTFpILzh5cHdxN1NXRURz?=
 =?utf-8?B?b2RqZ0FNenV5YTNsV1Z3OGVwTVpONWxqM3ZBY3JwMjVXUmtoeTEwWS84Qlhn?=
 =?utf-8?B?dUcrbm9YNFNtRjd4MTMxWXNoeVVDWWE5VWlreHFBci9QckpBZVhYbzFneWMx?=
 =?utf-8?B?eDJSeXdIWkhXNmV2T2trVE1YbkwwZERBU3VjTDVncVcwdWg5V0dlOWhDTjMx?=
 =?utf-8?B?L255VVNjTXVJaWVIM0pLV0crVnFZSWo5dGRYUTFVRDZDbm5ZUGdRV3p3Y1Ir?=
 =?utf-8?B?NE5BaitWeUt6ZVdXSmRqN2U1ZnVSbXV2UjlhbWgvbExnVFdwNXBHYjZLWGZS?=
 =?utf-8?B?UGtpS3NxZmlsYkR4Q3MzTEkxSjdhUlZMekFFeW1OZHl6S1NlV1lZZWxubko1?=
 =?utf-8?B?SGxIZDJtazJPZG5OQnlwejdjRjFyTHlrSEt0eDJHZjJLVGpVZk1tWjM3Qi9l?=
 =?utf-8?B?bEVlbTBOUEQyTk4vZ2hnci9GeEEvT0luRzl0OVlNc2xzc1orOGZjejgrRlZz?=
 =?utf-8?B?RFdDS0ZUSXBwTUlHTFpiYms4WHd1eDB0eHVmVmZkZlQ3WUg2VEErbmxaK2JU?=
 =?utf-8?B?alNJN3VXN3FQczcrS3djTnppUjhZQmV0SUp5TUY5T1FSVEZMN1huekN5U1l2?=
 =?utf-8?B?VE51Mmh6ZWdxSlRQZGhuNmVyZVlFWGc0VTM3blE3anNZSW14NWZHRDN5bDlD?=
 =?utf-8?B?eEJ4ay9RdHU3eXk1MDNMMG50UFA3QjhCN3hSN2k3VlRKYmdlNFlXa0RmOXRS?=
 =?utf-8?B?cFhnTVU1c1hzU29TeDE4cTBUZXo1ZWtKNi9xS2tzYmlBWnpWaWxuSi9hNWIx?=
 =?utf-8?B?MEhCdy9TQ0JjSjNOWFN3VUYzVXJSSCtPT3F5dWRLL3dTblVVNE9MSXk1VTlH?=
 =?utf-8?B?NU1VU2Q3bU1FaFV1cExVaGNUSGErd0k3dWsySStJRlpHOVF4ekhoeVExTTFB?=
 =?utf-8?B?WXVkQVMyWG5CVW9RREpwd0czNnQ3Mi9tQ1ljWlpDeEE4cVdubmlBYzBOSVRk?=
 =?utf-8?B?MXNROXlkRjZnL3dCc2hkNWVKeEwzVC9hZklJRG1IU2lRTkdtY0dTaSt3ek5s?=
 =?utf-8?B?anJkVFJZODEwdm5DemtkZHpNN29RdnR2SWl6SzlhOVREY28wcUI4ZWY0T2N5?=
 =?utf-8?B?dlE1Vi9qR3RvMDhmUGN2U2wvZmdibDMrSG9nM3NOUjVPTnFwczl1cGhaYUZK?=
 =?utf-8?B?aXhoL2tsa3c3NHliYkFBVEIyL092cnMzN1hMbFQyRUFDTnFRZm1WSVEwaGI5?=
 =?utf-8?B?alRwUnJvbEtxeUJ6MWRnbmdCN05RNnZFRThEY2NLNVFUdFpNcnJDTFgvRGhh?=
 =?utf-8?Q?TVN1Ox0nW3vwo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlFvcXBpR1BWQWVJYWtEaUNzUVBrcVBZa2ZPK3JncjJCdlFmamZzcVBFMzIz?=
 =?utf-8?B?RmFFcFNjSEpvT3RSaEFWbVQrRlpNWTc2cXVhV3VPUGVRbm5CN01KUk1jMThJ?=
 =?utf-8?B?bnc5dFFhVzVMS1RFczlNMnNPcU5YYzlKb3JTU2s4NC9HbXZob1M0Q3QrZkxG?=
 =?utf-8?B?WE9KbjVRZjZLRlB5a0ROMTdLaEJ6Vk85cU1hZGptUUdsTWYwZ0NWUENoOTBW?=
 =?utf-8?B?bWRDbE1ISXNpMlJTcCtFWlpFaEtjUndzRVVIaHF3eUptUytQTUJiNzJ0cGFU?=
 =?utf-8?B?TDdhY29RT3hXenJ4NU9TQm5pcGwzSm5tNVBZSkU4TThWdi9OU2tXZGQvdTFR?=
 =?utf-8?B?cUN5LzlaVEMyczVVaDlicm05K1JNVEZNdzZ2cnlyNG9UU3QzZHp1WERWd2pQ?=
 =?utf-8?B?SUVnbGdYQTM0Q0VoWXNZRTJMSDNHZHVtcFQzNU54a3NBbTQvR0h0cGoyaTV0?=
 =?utf-8?B?dWlkYmM1YXA5UUpVZ3hxUzduRnRxSW1MQWkyQTBHVE5QUEkzMzBURmZDQm9T?=
 =?utf-8?B?N1ZiUTJRV1JmYlRDRFdHenEzdmtjRUJPZnZ4WDI5M0pzUmNpTk4rdDJsaUNV?=
 =?utf-8?B?WTdBd0NyZUZpOVdobzBOZnpFVzFxS2xUanAwZ3JSUWFvU1d0UnpBN0lJaHpV?=
 =?utf-8?B?cWh4bGVZaTNCVHVQUE5abmNDV3hLcFkvRURJVXNodU80QXh5ZzhmazVjZVkx?=
 =?utf-8?B?U3JmWWNGM3ZzZStKcHFuWVFJUS9SZWh2UEhOTVVMU1Q1dGpPdDJ0SDFkMDFN?=
 =?utf-8?B?VFZtQ1BKSWdzK3p1Q0FMbHQ4ZFliblB1K2h2Q3FvMmgzRy8zZTNlYmJlanVB?=
 =?utf-8?B?NWY3akZWT2x0WkU4Q0lCcXB2anNYeHEyQmxycGxNeGtoWFQ1aG9nRUJ4S2s1?=
 =?utf-8?B?MTBXUnFCaGl5QW9DMVBVQWQ5Z09PYi9QKytpbkxQWDhlZUltRHg0NFFRV01S?=
 =?utf-8?B?ZXpFOGdnbStSV1oycFV4bjVnaGtUd1FmVEdwRnhCTTJYRzFLNGkwbjZtTWhM?=
 =?utf-8?B?RHpYbi96a1FBWElaWHdDakszVUQ1Q1I1bnVxNnZEai94U0YzRnZvOVEySjNG?=
 =?utf-8?B?WFdxMFd0VngwejVKVHFSakJKY0hqZ3JtRjh0MWZ5NnpNOGNoSmNnU1UyR0k1?=
 =?utf-8?B?T0oxR09rQ1JOeUVvNHY2WGN5c01LYlNKTGJzeWxWMGZVUDJnZm9KdEUwRTNq?=
 =?utf-8?B?MWVBY0I5VzZXeS9TNTU5RVBuY21TcTZVeVZFMC8zVXhyVWthNHFFeUlDdU5P?=
 =?utf-8?B?b3E1V09YMXZ3aEF6VFpBUkNSSU84aHhMSllsamxYOTZuVTBEUXVacGdVZkZ5?=
 =?utf-8?B?YjVneDdVUGF4cW5Ielp0NVk2dDhNUnN0eFRTbzBNMEcrVUptRFJWZjlSY21u?=
 =?utf-8?B?VzhQMTE5TE95cVNFOXRyME9kVGxmSU5STFUyOW5HMloxUWI2cmY0ckVYVlBX?=
 =?utf-8?B?Z2VwdXFUM0ZYWDE0SDBPZjArSE1VZHkzcDVCaDROKytpbWVqUmRJWlF6TlVZ?=
 =?utf-8?B?a1JkNExGK3ZBelN6Vi8vc29EN2F4MkVVbjVvQUViUUhlbGYxR2tLdFhOZ2ta?=
 =?utf-8?B?Ynd4Mzd1WWhzYVN3dGFUeWd1S1pTVklkTUJ1LzZKU3ZFVCtWWDBMaTVrN2dB?=
 =?utf-8?B?aHlMYXZFcGRLU292VTJZTmxSRkZxRXJZUDM3Yld2QmlOSTNZYWErTE51dkFM?=
 =?utf-8?B?UjBiakxuVjg3ZjgyaHZUczVhZkt6T1N6L0hFSHhoZVM2eEVPVzJjcXp3cG11?=
 =?utf-8?B?RGhkdDRKWVhwVUN1NldVNHJpTXc4eGJPWk51T0xuaWhoWVpzandUcmgrdzJB?=
 =?utf-8?B?RTcvRTIzejJoc0lyRmkyeENKWHI1cEZCLzVUbUpYSGVFeENlN1g0MkNubnh2?=
 =?utf-8?B?d2dveFgvNC9aVGpQSFoybnd1WmY4WXRKZk90WlhhU0YvUTA0ZnFGVWtEV2Fm?=
 =?utf-8?B?MDhRVUhXRiszNmt1T0dqcEVnN2RaZDR1ek5XTTlLVDEwN3ZlVGZiQUxsRVdL?=
 =?utf-8?B?VzUvWEZHc1ZkeS8wV0ppYklOYzVwN0pNWlNXREpTYXUxNWgrZ2M3Z3dyQ29x?=
 =?utf-8?B?Ujg5aVVFSVB3dGVjTGNGU1pLSWMxeTJtY1NuKzNSR1YrdkJ0SXVRek14NUpP?=
 =?utf-8?Q?rqNT7/CBZSSpl/jrGA20ybVdB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25956fed-d411-45fa-9a75-08dd1dc6a5f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 11:41:58.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQHAKZejTXdLFsCm/Q36nrFoBvsaT/BCogoyEd027YbCZBW3G0SkWlNWws15hmZaM02UNdVx0svHscgWwBJzDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250


On 16-12-2024 15:00, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, Dec 13, 2024 at 04:09:38PM +0530, Mohan Kumar D wrote:
>> Multiple ADMA Channel page hardware support has been added from
>> TEGRA186 and onwards. Update the DT binding to use any of the
>> ADMA channel page address space region.
>>
>> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
>> ---
> This is v2 but no changelog, no explanation whatsoever... I assume
> feedback was not implemented, so please go back to previous version and
> address the feedback and then send proper new version with changelog.
>
> See submitting patches.
It's my bad to not include the changelog info, though I have taken care 
of the feedback on the ADMA DT bindings. I will include the changelog 
info and resend the v2.
>
> Best regards,
> Krzysztof
>

