Return-Path: <dmaengine+bounces-2332-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39437902DA2
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 02:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F986B238E2
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 00:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E5B370;
	Tue, 11 Jun 2024 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bne7gk4c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039B849C
	for <dmaengine@vger.kernel.org>; Tue, 11 Jun 2024 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065416; cv=fail; b=Zp50KzyebF1s/AiWynQTYa01TIO4Pz6dSkBi9DORdSKLIb/DGQZ39p1/guRa74fcfYJRAd8Ch0OHTI+kk7GL9fYiaNdFI6GKzi/9oAlWAC0HDacWsPK8XPfgPa5C5atU4cVB+cy3cJL2R+LWN3u9DsZ2gnNQ4K+UvfPl5oIPfDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065416; c=relaxed/simple;
	bh=6yVDo6+Ex3F4YY1dIwkTsx5kLrYI7Kq4eEzchYZ0JkE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t1y3ezt8fHRaVWSB6UoLBvahyVx1FRdR/v6GbeMjHcFh4xaBLy9Wyy8pTzLUjsQS3sdqyzfbrLeZxqhWv9rfKn2TxNctNyv1Z3AtHi9v6EmlcRLs0OtRM7qOqXYw6A6B0ZeHA1o+wL7i2BwkMGHOmG50qVIJBR88ISM30Yl6z1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bne7gk4c; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718065415; x=1749601415;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6yVDo6+Ex3F4YY1dIwkTsx5kLrYI7Kq4eEzchYZ0JkE=;
  b=bne7gk4c77pysxUrRhew7c+9sGmvTMKedYvpJn4HWhkdGANi94viV+TM
   GOOD0I3X2EA7z03uGBwy3QeB1cW+nJwsnlSv/zXu/CMsu6Xe5iSv/zo3N
   PmjHjfKHsKZW2FlaViU1BGMyAGWm51dxk6au3xzyQVFZZQs3+CVXTgA9Q
   zmur2eT0TyflVZdq6W853Ea/hxHsOvEKuLHwpg9aWeMkTMcFL69SM0K+T
   ujDR93UlLlZHcHetxAQjWvVpcSDvw4VEu/7r8XLX6pjc+uzSO+TNFR0Xf
   djZ2HbmCfG2OP2b1MrF6lZdS8x+VNcs7v/5H6qiKzZPJ3AdnEqx57BYm9
   w==;
X-CSE-ConnectionGUID: TaucR5jxTQ2WmJaUWzQ28A==
X-CSE-MsgGUID: fiOnBTSkSY+QSrBGD6vrXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="32289165"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="32289165"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 17:23:34 -0700
X-CSE-ConnectionGUID: wUz/2fxrQPerHm4CQeLy/Q==
X-CSE-MsgGUID: BZY2u93PRM++o3ZbSZgTgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="70400228"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 17:23:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 17:23:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 17:23:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 17:23:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 17:23:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7Gj60N39qC0d48c6TK2KQ8UMmTi0zJD5Kj4RS565M0EyLpe0dHy4Z01aAUp6U6GTNbIF2ggSOEPcV498GdMCdjvYnLxakCqHm6/kM1X0Rffa0S9RVGtWNEZPtSibXIghpEFIDVW+y6s93iOVzdqVHBpegTLpxkwePb0XllKCcsAsW8KeEpO2nm/QMRz991EVedmNNTulLtATLQWgPiA4cWd74dwtmk70RQLHJP0W2l2gCy71KawEqxJ2/sN1JDueteizUocsp9kiF924h/rfIpW9GXbyE1p9zvprBq2nkl3INXeqzm1lUQ4tcfwCO/HoiisunUhkXt1AukNgtgUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJob7j6gCPzARhLAIutUlbLVl7W+nZ47o+/RhZVU/co=;
 b=SIgVdQrjjZsfuexwx8WEY3BjS/sedSwA539NflWxLY3gUFEy13SkVMaouzEsPFUoXITqFgLJpHdUsZ9N/XGC04KGATnLZMgEuACf8pX536rcfbMMUasbb2AHAvfmjdqPenzGjneCfn1scFdsu/qGF5zv7XSN2BXxBzVcko40631Jo6xtizQtgWTX0mmjjuXvkvLysJ4+z2xzc0I+vO7O8Z9Vdk7ozB2Zxrv88/Nki0wrdNz3MSsnFu4UGkkICrWm086k+w67Vpppme0GGBCqGgrT3haOuDJXHOnTudLf7E3UQF1WvL7qsS8o9V7gxR60cHbo6UQJCy00K3TR+iCMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA1PR11MB8221.namprd11.prod.outlook.com (2603:10b6:208:451::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 00:23:31 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 00:23:31 +0000
Message-ID: <df0df896-0f7a-b5d7-342a-d36a8794d9f4@intel.com>
Date: Mon, 10 Jun 2024 17:23:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH][v4] dmaengine: idxd: Fix possible Use-After-Free in
 irq_process_work_list
Content-Language: en-US
To: Li RongQing <lirongqing@baidu.com>, <dave.jiang@intel.com>,
	<vkoul@kernel.org>, <dmaengine@vger.kernel.org>
References: <20240603012444.11902-1-lirongqing@baidu.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20240603012444.11902-1-lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::11) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|IA1PR11MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 30481a51-4d5f-436a-ca39-08dc89acb922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tyt2eHZBcCt3aEFYL0ptOFVCZExuQUU2TVc2NmY3S0dlblBwQXNUS3RTdldv?=
 =?utf-8?B?YTU0dTUvL2dpd25rUGphZUh5K3Zvb29Jc3k5YnhTQ2hjYTdyU2YrSHcramlk?=
 =?utf-8?B?WUlKMkRSekNFWEJnd2ExOE9OYjhzR1BIR2J2cnVkWWgwSnFQbFZJblFpOUU4?=
 =?utf-8?B?NXBVZ0lMNlNxWHN5TjRBMGR0L012RVM0eTZ6RzhUQmxuNE9pNUFka0xJMjBE?=
 =?utf-8?B?RDRmTG10a1JDbEE0MTV2dXN4a0R2aWtLYXJNa0hFamJ4T25xV0dla2dOc1VB?=
 =?utf-8?B?eTlOcHdJcC9jMkJub29ncm9wTEw5R0Y3QW45MG8yNlpNTWdzTlFiOG02NzdU?=
 =?utf-8?B?ZFNBdWRBTG1Sa0x6dm92WlVnQkswbS91bXVIZ0Vmd3huWnJnb1NDczBVeGMy?=
 =?utf-8?B?NDgyV054SEo1VDBhakgzcytUcHFsUHlCdnVQZEw2VUM0aEVkNWl5K0N4dmEr?=
 =?utf-8?B?amY2MXdDNDRacXFCbWJWWkliekg5NVJMa0hyRnpuNDErdUlBY1U0UFcxTUlm?=
 =?utf-8?B?UnprSkYxb3lWQWFaZ1JTakY4cnhBYkRkU1JLL1lwdE40eUJUMkl5eGdNalpt?=
 =?utf-8?B?c3F2d3Q0clJ4VExLUGRzR3Mvb1hqT1EvcVZ6TDJKdWlUS2NjT0hiN3lZenFl?=
 =?utf-8?B?NVE4MVhjQUp1MXFuVEVNaWEvcGpMWHhNZTRURGFIanNXYTJNVkhOazN5YTRO?=
 =?utf-8?B?aDB4YzNvRUJkZ25wcytaR1pKa3psMk00OXBLWWh4MkpiM3BXbTVkTkRocFlP?=
 =?utf-8?B?VE1IN0Z3aGd3d05qZWdVMTJ0VzBsSldCTFp1eWxJTG9qZkhlcGN5anRrR01w?=
 =?utf-8?B?ckN5MWF0QXhwMFJoa1M0ZzRqcElDbXhwRnBETWFrV2c1aEhhbjJtWXYvdTJE?=
 =?utf-8?B?QkFESEZFTWNFNHBDb1lqNHFDam54MDAvQjF3V1lxKy9WUzFyRm14dlR2cFlt?=
 =?utf-8?B?S3hpVENpeVRJR2lCUTdOQUcwTFBlK21LR1pRMnVXN01NTlpYRVJLZFM3MEZ1?=
 =?utf-8?B?akh3MGdBTUZrWkZzYlNkVGxody8xRzdBSWZQRGczRktpSG5LU0JOeWZwcldY?=
 =?utf-8?B?Ym8xL0c2c3lyV1ZGY045cTZRMkVBYU03OXdidFhRQ011MUV5SHlkWHdDU0lX?=
 =?utf-8?B?SGV6OExjay9MZFJZNVBXU0ZsSS9OWkNZM3hVSXhoSXBGOHhsVHJuS2sraXVr?=
 =?utf-8?B?OTM5OE0yNVBub0RYSE50ZXJNQmVBUktFTzBHUFBiT1ZBbFNTc3lLQ3E1YlZH?=
 =?utf-8?B?ZW9hUUkxSEV0UjJuN2VwR09ZcG16N2RPZ1lzOXduYXdjMks4djQyYzd4cmRV?=
 =?utf-8?B?dVBVQkN3MmlLTWtGelFRU1JOL3NpVlZqWlB6ZkdQOGlQaHhLQ2JzdEFMMGdR?=
 =?utf-8?B?UlY5QnBFTkw2alR6K2pxUU1tTWM2Zm01T2FFdFdaUlhVVVllRGluRGZ0cEI1?=
 =?utf-8?B?Z0F4RHZ6SncrQ1VIbjhWY2M2dnN0VU5yek0rZ2lIN3hvMkhmdzc1Uy91MlZJ?=
 =?utf-8?B?cWExbVNmaTBXZEd2N3dZNlRnSGlXL1QwdkFWMjdpdlBCRGNkMENCeFUrTGZ5?=
 =?utf-8?B?VzZVYkQwR09qckpRbVB4K2VOZWc1ZzdYQTFmV1Z1aHZUeTJxTis4a0owdUJE?=
 =?utf-8?B?NElpMWRwMHJ0bVB0L3N3ajRuWEl1M0dKb0VoUkZrTSszdk5PS1ZFRGJxUVd4?=
 =?utf-8?B?V1NiUEVyb2VlbXF2ZkdxRjRUdm50TVBRQk9uSzljck02Z0hQdFQxN0YrTjlJ?=
 =?utf-8?Q?TzXw1rnz8hRmayaje+zvh90cTOU27njZevfYAU2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzhMVXVlWmtjUHhjWUl2VElqZ29zVUlZOFRWUU9TY1EvOVNWOXJMVXZ1VDZa?=
 =?utf-8?B?eEdkbzFySGJHU2dWVHJxbVlCeUJTRko5Z0dtclNsOTh5b0EyZE84SmlHZlNU?=
 =?utf-8?B?Tm44T25oS2F2R1hUSE9DYUhWTWdKSm4wT21jcnRwS0x1WkhGbEpVTXJvUGI5?=
 =?utf-8?B?SjVRQWNKUzNVblFPNTUvTlcwUzF2QnV6MmJ2SFBzRmtkQWo1aU1LbHpRVlpk?=
 =?utf-8?B?SnRLRGh1M1IzQ0ZCWUhOOENEb2ljYzZtb3RHejdDNEFQOXNqMVJHYWJKVGRQ?=
 =?utf-8?B?T3VWLytnbldZamRyNTJJU21ESVJmbkI5elJrZGtlVFU5TktrOEJGR0c4VHNM?=
 =?utf-8?B?Tnh2NURqTmJCWmFaTWQ1WmxuN0pFQzVkcFJsUWpLR3pueDl5Qi9PMkowNFIx?=
 =?utf-8?B?dW5reVBjY1R2T0lGY2JyTSt2bmc5REFObVhFNHltR2Q5bkdKOThiQmgyeWVV?=
 =?utf-8?B?S25McUoxeDRRTlBQNTkxdlp2R0FGTTM4ZTYya1dFbTJYTEFZaUg5N0xBVk9X?=
 =?utf-8?B?dURoRVBWK3liUzhSc3BaT1I3a2d0MmdXVWRyMCs5djZXb08va0FLZU9pY29M?=
 =?utf-8?B?QmsxK0xoWTBmRHB3bE9jT1lyQ0d3Nm1NSUJNRHVLd2s4TVczYzEvemMzb0tE?=
 =?utf-8?B?N2YyWDZGMmRiOE55eEU5OWlyY2dGRzM1MEl2NHlZYVlYSnFuUUpCblA3aTNH?=
 =?utf-8?B?S0RhSm1HajliOVBneVBnbmZJRnBHcnZXNkJxcU1QRnhxY3lWUDVKTk5XVEpO?=
 =?utf-8?B?bmNkemZVMzBzc0RQM2tXMlpDd1BndStsTkVGclpmT3Jqa29WQVY1S2U2VHVG?=
 =?utf-8?B?dWw5NFQ5QzdEUEl6SjR4VlNBcXYyaDU2SFlhZVFYcmdMeVdyM1B1RTYyR1pl?=
 =?utf-8?B?SlkzOVpreWd2ME1rT1U2bXBNd2grUGtjKzRyendtS3JqNU9RczlqeVIwVHdz?=
 =?utf-8?B?eFFoalZDempFbXQ2RGFHcmtzMXN4K3RwRTR4TitSVXY0bE1CNmwwSVRMS1BD?=
 =?utf-8?B?UHBKR3M4RXFicUlEejJpeDEzOEhCcHBNcWNxcHk4NDhzN0dlcDRkeTlmZnJh?=
 =?utf-8?B?WVJDYnZYZ1RiVEhjOCsrTlBoRFRxOXM5ZWpwK3UrMFBHUW5STXl1Zk5sandh?=
 =?utf-8?B?M1NYOEZoZFVZMjVGTjZhbW5RdHVWelBnL3RUTzJwMC9TZS94MDNOaHlnSHAv?=
 =?utf-8?B?dHlCVmFoeFZ2emVGSlQ1ZlFTd0lTK2xSaHUyRytPTXJFckg2bVpIdmRqbkVX?=
 =?utf-8?B?UUN2bndGUzNoOUkwbkRSWFdNV29KSDVZUWxkTVhsNTJ4d2pVNkZXeGVYMUZE?=
 =?utf-8?B?VlJrNGtOMTYzb0pwWGEzVWhHRXkxcmE1YW5EYkdneTU5Qnp0enk2WVQ3NEJY?=
 =?utf-8?B?S0NwMU5US25sYWNxMXJldHZsODIvUTJETVllazBRL0grZHRCMU92R1BQaHhq?=
 =?utf-8?B?Tkp6NVdkdTI2SzdDU1cxbkVrc1o5NitjYzkxODRHTUM3VUgrYjBnNVl3allj?=
 =?utf-8?B?WmFqOXMrajVjUnBQQXpORmMyeThlZGQ4V0VObFBLdnBRZEtkdEtNY1BkKzVI?=
 =?utf-8?B?UzExL1JTUTZPeHNlek4rQkk4bC94cFJpd0diTU03ZGpTK3h5dEZFaEpmNWNI?=
 =?utf-8?B?VnlYK0RRTnJFUkNucFp0RzZMdzBYWmx0ODhTYVh0TjIwVExSZjJkQVVQTjk2?=
 =?utf-8?B?bnFNYmNVekhQWGJXTGpoVnFwdWtEVjdLRXJhbHR0YUxXOG81RStyM0MyYmJk?=
 =?utf-8?B?UjBldk1uOVhXMUk4ZVp1M0pTNTBvWG1aRzhNaE5ZdDlxSjFWSjNlV3d3cW5J?=
 =?utf-8?B?dGcwRXNpbU9uMEIzMkxLUzAyWWxuc0p2Z05VeHlVNnVvNHdYVWhwbHR6ZFgy?=
 =?utf-8?B?alI0TFpDbi9mNTg1cENXSTdRSGdmKzF1Z0JZZ0ZzWUJoNW9sRS9aNitsVEdT?=
 =?utf-8?B?VmhrZW5kRTZOckpiWHRQdEx5VDFPRHRmWno0L2xsQjRheEx2Z3ZLcUN5Wm9j?=
 =?utf-8?B?cS8xWXZOdG5UcXFvN3p4RE1zV0d6Y29GYzFxaGhyT0NzdE55NW5Ha3pMVEJl?=
 =?utf-8?B?aXNhYW9uREJralo2aE5RZzAyMnZCMlBFbW40endSS3gyMHZkVmQ4a0JoNHF2?=
 =?utf-8?Q?crfgzbn3Gti32Kv5RJ/smErHg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30481a51-4d5f-436a-ca39-08dc89acb922
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 00:23:31.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUKTDXK/DWq7nbkjaiFJqq4JzOwG5FsaWpp6ucHSujBABCrV+ihKsmvM6yAuYaEOXtfdHMLghPiC67eGRUBBmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8221
X-OriginatorOrg: intel.com



On 6/2/24 18:24, Li RongQing wrote:
> Use list_for_each_entry_safe() to allow iterating through the list and
> deleting the entry in the iteration process. The descriptor is freed via
> idxd_desc_complete() and there's a slight chance may cause issue for
> the list iterator when the descriptor is reused by another thread
> without it being deleted from the list.
> 
> Fixes: 16e19e11228b ("dmaengine: idxd: Fix list corruption in description completion")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

