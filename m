Return-Path: <dmaengine+bounces-7267-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B61EC73D79
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0F0422A635
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BEE32FA09;
	Thu, 20 Nov 2025 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JeO4f16U"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86732C33A;
	Thu, 20 Nov 2025 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639802; cv=fail; b=ABwZawSglT+W4KtMbkgNeq1iEEFe0eHsFf/U15NSAprU2TEtolSqVAREMWwSfdFfJUW9t4EbQ6wiAy6e5XkEnoOs03is5hLeW6h0kcaIOouCb1Eh4ubLdmcGsmzuHWjLuFHqXz2B4tCnBsMo7k6RkqlWiKrASSd/P8q1cFATR4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639802; c=relaxed/simple;
	bh=Y5vSMfQW6EyTTffISTNf2zoKDA9RYhEXxdfiaPdPpjI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b8wKZuCe74RGPu4hldVw7aH0MOHo9I6q+NooZySBkzonwTyincAm+G9MC4cVyzRp8obAHZTEHPO1icJFUmu2SsoJI16pzFOrtkAvo5mwP3sTnEtHiVErcrC0z26MjllfzUE+aYcTeMupCAq/DB4w/aKPRBMk2VlXJ1cFy7R69QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JeO4f16U; arc=fail smtp.client-ip=40.93.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMUrfPFzrQ1ah92Q1hJguBTLTClok51A+FZK6SS1JKgQIpcm8ZnXR0sYcTaQWAkBXrgelx44EUG9WH80shxy0DkbYs0Qqf3K8tnKNUJNm31/mC34cTHbE6MeU295WBpkssks7ZSPg5WSKlYm2091Ix1hOLY3KelhBRUv0Uw0NxUgKkGEnUxcZypbLzqxkT/te3P5EzXIABmaW077O08WZ2Z66UJUM+9yYPn87Jq7fq3rN4atp3kCns+25C3UgjWuDpEpxV7pse6nf5F76mmNVQiVDI0jW+5uAumiZE3JNGUBVCXXqhuQ+rrLoRp3PEzmHI8+HIRR38vYv8ndbzYbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=707eWki5ER6h9gT6OiMnTlc9OwtlkXWq8ptDdr6/dGU=;
 b=p/cOCE/1ZATD3c5yE6bJzlS+MDtp1nUjSk1oivQCDLkSwFVRPu1khIw5qozbjrrwF4Jsl+mZUYLADxbu7So7TzvPAmD533drZVg33L7FQcq6l1kbu1vvd8vHqBsa3bUJzxb9WvPfz/lMXxq4ONugnPcEKZBUzTnD7682i80u9P59rl8FIRFk+uRZ0kzbMtUjnV6kVePRtbBjoBuz9owCvqgX0B+z+yLNCP9iSjEYKGiKSKh437HiiBBDZ048SjG1apkJjvDjwFJYKgbc9vfulu8GvYmDvhKdl5PH4Ny4uUK9F3knxMkRaYhcP8DHwsHCb7p8gLYcDR+Wx995fkSB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=707eWki5ER6h9gT6OiMnTlc9OwtlkXWq8ptDdr6/dGU=;
 b=JeO4f16U0xjc4NjfKcP/d9csQfT8MKXKWsYviJH+BqEtHULbY5rnFScMQMeTqTZ+IJtO7lU2DIWo4mEb1dSRupXe1FvoD7GTlyoBXigKqI3BfBAvKT3xcC5av8CIMowpckFG+uHx5zBqbSQV6MidM0CS5yVkOtWluM78OzjKEI1xeUuIA3bV2ZvvVUcwXuXB2kQH2nwSqA0pbyKIJf+86MuWiyf8hqjFn+ufbuSSRXnkl7oJrfoLCnL2VOCdhRCVqfE5PVBcMG+nOe1fS84x+AZDj455WKTCh16gp/PNX9iFkLjgCiVruyp2ie2Z6ZD3kD9UBkB8OYw2m56MGwqHOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15)
 by DS5PPF4A654669B.namprd12.prod.outlook.com (2603:10b6:f:fc00::64b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 11:56:37 +0000
Received: from SA3PR12MB8761.namprd12.prod.outlook.com
 ([fe80::4d63:f057:7c2f:c157]) by SA3PR12MB8761.namprd12.prod.outlook.com
 ([fe80::4d63:f057:7c2f:c157%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 11:56:36 +0000
Message-ID: <ae3b3171-5f16-4a8d-85d4-f29133015445@nvidia.com>
Date: Thu, 20 Nov 2025 11:56:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] dmaengine: tegra210-adma: drop unused module alias
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Viresh Kumar <vireshk@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Frank Li <Frank.Li@nxp.com>, Laxman Dewangan <ldewangan@nvidia.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251120114524.8431-1-johan@kernel.org>
 <20251120114524.8431-10-johan@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251120114524.8431-10-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::26) To SA3PR12MB8761.namprd12.prod.outlook.com
 (2603:10b6:806:312::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB8761:EE_|DS5PPF4A654669B:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c640d4-0690-4031-ec61-08de282bdb27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVo4K1l4OWpnZnlabzk1UHFLaWluWGdCVGhOYXlSL25BeHp1S3EwMzRjZGRv?=
 =?utf-8?B?anlMWmxZYXRWR244SDRXb0N6Yk5zcE03UlFZQnI4OGQydXhVRFo3cDV5LzRY?=
 =?utf-8?B?b24yVmZwV3doSXpaQUc0M1BLR0R2UjVmT0pXOTFVOXNtZFNHditYM3R3anNx?=
 =?utf-8?B?WjFUL3MyUnFHT2szc1ZZRTd4aHV0UVJZb0l2WUowKzAwZklsMjJlWUJ1eTNC?=
 =?utf-8?B?M2Q2NXE5bHNrNElwZVhSTTJMSnprQ0RCQXVRWWpHUTZ1NFN3c0p5TXFTbHRH?=
 =?utf-8?B?VEk3ejkzWUFJQ2VIZFdCekoxT2JxWVBuS21TYkNPZFlZSEpyUEhyeiswdVpO?=
 =?utf-8?B?c2c5YW9RbFFoZ1VONjlyR2NzWnJiRDB6dTFEZWhodCsrMGJRL2oycE11UFJZ?=
 =?utf-8?B?N1h1WktFNGZNb3E5TEdqZlo3cHVHWHFzL2J1NEVuY1p4eGdrUmN4NVBEcnhr?=
 =?utf-8?B?U3c2NXIrVlFJNVBxdXdZQlVUbFIzMElPWXpJN1lUSmtIL1dMQUk3YkRLRk14?=
 =?utf-8?B?UzRONU5JdFZNT3JnSFFLNFN2RWNFNkxJd2xNVTJLakJsTWxhUjczM05HaGlK?=
 =?utf-8?B?VFgxWGpTUjN0WEJhTENDSXRkUHgrb3A4QU42SW8xZFZTc3E3NG1pZTVadHY4?=
 =?utf-8?B?UjNQL1pKRVE0bktwaGpTbFlnWHdpNHlHM3dBWjVsQlEvZG9VWGhnOEFHV3cz?=
 =?utf-8?B?QnUxMDcxKy9ZbWh2bitWc3EvMVJtL1ljQ2VoQ1ZGQWd5b3ZneDdoM0NwVXlx?=
 =?utf-8?B?SUw1RG1DVUgvRXFtQndDMXdJUmpEQW1MSzd0VmtGSmZjSmthbmNtUXFMNG9x?=
 =?utf-8?B?UjdwTVVvblpsaXZWVEREUUFicVM5YmRyNWVPaGFGVDNlcWw0QVJmQlY1dFBE?=
 =?utf-8?B?Z1VzUE5DQXNkMm04bUg3VU9IOFhDUzVUMDdqdmVzRVQwazArSFg4RkxUdXgx?=
 =?utf-8?B?ZXdKOEI5aWMycmtKUDNKYVd4YTFBdytreWJOUjNDTmJLejYwM3VhNlkwNDBk?=
 =?utf-8?B?emIwaVY1ZWl3TktQa3Y3ZmJUMkN3TGY2UkdHYzlVSEJoOTF3bE5mTHpnT3Rh?=
 =?utf-8?B?aW8ydVBoTHJJWlZndkY5ZWdnYkwyTDJiRENjblpocVE2MnVBSDIyUVdJeWpm?=
 =?utf-8?B?Mk9zMTRsZ1BLL1NYZDdnT3I5SHEraU5UMzNiaVJMdTZvUm9DdHJTRGkvM08w?=
 =?utf-8?B?Z2RmMjY1R1dnOUhXZmpkUFVGVTlWNWFReW1pcHBHMm9YMi9hYzl6cXRvT2tM?=
 =?utf-8?B?dkFubWRuVnVGWlhDRGNFUmhkWGdqcXVmZXhWZjgzejlTTTBEQVdWL1Y2MXhz?=
 =?utf-8?B?VXVoakVCWll2cjZsNThJUXc4L1JWMzBBYkUvSVNiL04yeDJtQW5LNHBsZlVU?=
 =?utf-8?B?cmRjbkwxL1ZXUUZCMjRTQnRGRlZwSEF5UnpTa3ZnSUN3ZW00OVZRUHFhZTBF?=
 =?utf-8?B?KzdsTWFnc2dEeUdTaVJHNnhsanZOTCtkN1l4b0l0cU81RGJJL0hNNWpza29j?=
 =?utf-8?B?TEhPOFl2VVQ1dFZMRDNSKzlGRGZCZ3Y4ZDZ2bDFVRTRQV203N2Z2eEZ2MU9D?=
 =?utf-8?B?dzNJNlZGVXJnUEVlN3FxU1NGd3BBaDBuMXJYNHJGejFWUDlQRGR6bExKcHRx?=
 =?utf-8?B?L2YvaWx2S0hscXRxeWlHVWNuN2hPWGRnbGNoMFpnL1oyRXNFTVlKVnF1VHVt?=
 =?utf-8?B?ZkVadmlVNHplTUUyOHVpWDhPRU1zTDdKS3h4bktWL001QVZETVRUa3RHU2tX?=
 =?utf-8?B?RnMrZU1zclFQWFJIMm9HeGkyWm15STZrcENhdXRYemR3SG94SG4wckJLbFVu?=
 =?utf-8?B?KzdwWUhDYVZMVVFYeEtVUlpTaDVVbllrc0lVZHY2QmZIaXBJeEQ4TzlGUHBu?=
 =?utf-8?B?Lzk3RjU3MStlOW9qNndRTmt6WVBWNCsyU2QvQm5lWi84T2hvblRoSmd1MFBQ?=
 =?utf-8?Q?Rd1OGooThqCfOJqfOVeHgO2JI1KAZauw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB8761.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clVoRXlyeHVrditycmFXUXhZQ2FRbkppeUNlU1B0Z0RnNHVHS1p0WWtxem45?=
 =?utf-8?B?cjZwZm1GTWtJdk9mendlRVo5dVkxekRxc2VGbE5DbzQvaktEUHBYT0MrcTRn?=
 =?utf-8?B?Qkgwc20ycHUzZE5BMCtaNFFjSURoUG1uakpYOExzL05IMUNGZk9rZkF0Y2FQ?=
 =?utf-8?B?QkRXekY4V0wzTjJWNzdad1duWFFQQzBVTzMxbko0YkhRNmdIcEljdisrZ2Vl?=
 =?utf-8?B?WVRyWlZjeUlsc3M2UWZyYlgzcjdkeVNhUjJtU3c4azNKRXdnZlhxek40c2Nh?=
 =?utf-8?B?VWdubzNjbFV1c3ZFSGhkREZ3QkN3TG9OOWR0U0psNGpEQ2hiK3lRSU45d3dX?=
 =?utf-8?B?d0lOSmhiOVQxMGdnbHlOWkI1eWIwVnVrTHNGRHE4b3RNUXl0eEZrQmlwTHh2?=
 =?utf-8?B?RGRuV2ZkYThtWFhWQ045N3hhS1ZJdG5EVmNLc1diT2JDN3RBbUd3LzFHZHc2?=
 =?utf-8?B?NnJnaS8wbWtyRU1GeDhobjkrdG11OTJ4UVYvVXB1cTdXTmprMElTYUFvWHlF?=
 =?utf-8?B?cVJjWWdhbllFU1BmRFVTMXJac1hBMFU4alZycXRuQWVYVkdFZUZVWG1jT2hm?=
 =?utf-8?B?SUptT1RLamZpQ2xqVkp2WnQyNUQ4dXFwZGNNVzl4RWYzWjUvQjJTM3hBR3Mv?=
 =?utf-8?B?dzgwR29peVlOZHVkbEJ4cUZZMVFaNUhtRkYyRFFRSk4vTUhPSmpCc0hNWE9m?=
 =?utf-8?B?MGZjN2ZyanRzLzd1bDRjYm9acnh6SzllK1NjclM2M2RDL1FvdDRVdTh5RHdh?=
 =?utf-8?B?YXhZdEFNMml1aXZ0RTl3U3dmVmRyQWdFN2IzNy9aek4vMG5PVnRwSndVaXZn?=
 =?utf-8?B?dHNMMUFQUHJSMk45bWJRNmZrL0liSVlrZkw1R3VCL0hkTFJaNktUa0ZrVnpw?=
 =?utf-8?B?eDM4MmY3d3B0YURCdjZXNmZqNXU5UXcxUFEzYVVNYmw5dHRLR0FlRXFDWWR1?=
 =?utf-8?B?d1Y1TGh3U2Zqd2lSZ1NBZHR5NnlwWndMYXRidFRQWTFxVzZhOUtFdm5Qb3kz?=
 =?utf-8?B?ZW5NTzRoV1grOG5kMlZwRm9RWE50bjlQRi84aWE5dGVwRXArZWlEVHFEQTVz?=
 =?utf-8?B?bnUvaHhGUXNQUUhPTVRvSy92K2pvK0VzcTV2M2JvTDR0SkFoNjFhaE96QmUx?=
 =?utf-8?B?bmtWdWI4T1VHUEs2QzU5QkNEdVZEK0VnTmp0c1BuKy85Q0RraHRBRlBHMDZZ?=
 =?utf-8?B?cEp5QlZvWWFsOTNzSlJtemNNc0JZTkF5a0t2aFMyMW5lT2ZTdXFDZnNLTHdr?=
 =?utf-8?B?alhrYldmbFpnMDBRM3dsY2RXWGhDUE81Y3krbTRpLy9YZy8waTBzQktEL3Z3?=
 =?utf-8?B?QmJaQkI0S0VhRE1qaU9nMWVhSG1wMG1MN2NBcDc1Z3VzLzRrQllIdzdHOW5W?=
 =?utf-8?B?Smh2elJ4UHRwcWE0Vlh3Ylh3d1dlTDZrb2h1ZHlJbzdwZElsVGdyaE1QRTFm?=
 =?utf-8?B?bkJQbnhHZENTd1lGYmNLajExTlQ3czcxUjJNODlSUmZ0a29leVd4bFE2Tk1y?=
 =?utf-8?B?V0haT2tJSFl0V1RkUXFhbi9pNUgwK3c3cE5heDdPekpZN0s4L3BTc3l2Q2xF?=
 =?utf-8?B?Q0hVZlo5bFRZaWh1eXBpbENweFMvVVFtMFd1YU1pYzVnYjJDSVFNUXF0VHd4?=
 =?utf-8?B?WW50TnNUTHlURFpiblZRNGFIeU96WEVJT24xZkFEaDUyTVNvSzYrSzZNc3NK?=
 =?utf-8?B?dlNqTFcxK2NrMG5naDZKUitoVTd1SlZyVFFqa2hMZWxhZ1pyQU4ycWg4bW9H?=
 =?utf-8?B?di96aGc0TW9OcHA4MUtPTFVvRzJtVUlhdnNwTkpEQnovTk5RODRsUjM3L3Rk?=
 =?utf-8?B?anpqNU5VQzAyVDY1SnVFT1pINjVSWE5BRndHamdtYU1NeFUvbDRDT1RCbEVz?=
 =?utf-8?B?ZmNtMXJmQXZQUzhleEQwQ0lEQUtmTElJcjhUMlZhN09TWmVqRTN1NDJnaU1Z?=
 =?utf-8?B?Sm51YjRMTllnbWJPb0lhUFlJLzJoUmpKcVNEeHdQWFIyNFVocnZFNDJFbzk4?=
 =?utf-8?B?aVJybWpPOEtncVRJa0NJVHhJYWZPeEVQUGdTeUZVYzQ0c1FZWlBaais3WHl3?=
 =?utf-8?B?aGxTVDlYVlFJd21CNVd4dy93dXhPQ1YyWnhrU2doMUs2bmt1bURXaXJEeC9M?=
 =?utf-8?Q?eIloG4tJb/Z4rrxjHR/xGIYoy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c640d4-0690-4031-ec61-08de282bdb27
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 11:56:36.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87jin7rAb6MpHk2QOg7qni7KsDmpiSlngyAHTJXrMBNDNFsx917nB2/JtHs460xioR+ifGEbKcf8iv9HozDq+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4A654669B


On 20/11/2025 11:45, Johan Hovold wrote:
> The driver has never supported anything but OF probe so drop the unused
> platform module alias.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/dma/tegra210-adma.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index fad896ff29a2..d0e8bb27a03b 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -1230,7 +1230,6 @@ static struct platform_driver tegra_admac_driver = {
>   
>   module_platform_driver(tegra_admac_driver);
>   
> -MODULE_ALIAS("platform:tegra210-adma");
>   MODULE_DESCRIPTION("NVIDIA Tegra ADMA driver");
>   MODULE_AUTHOR("Dara Ramesh <dramesh@nvidia.com>");
>   MODULE_AUTHOR("Jon Hunter <jonathanh@nvidia.com>");


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


