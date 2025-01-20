Return-Path: <dmaengine+bounces-4157-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F763A165C8
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2025 04:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCD21886E3B
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2025 03:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8E554723;
	Mon, 20 Jan 2025 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IgYoQjTk"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67180C2E0;
	Mon, 20 Jan 2025 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737344780; cv=fail; b=d6piF2RYy0CVjGjFwiPCITSI6CA21pRcCRsccA9NbcgBWl62hOJHdtMUMhBS3LG9lgSIDTUMY1t3fMSKxnRJ31u05fN1GtXogJOBqAzPWK3hHuOhynh9G/3BNsGIFJMbBgx1Jw8EzVbqPy/LcN0xQk3R+e3HP6J4ASna3vMdBKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737344780; c=relaxed/simple;
	bh=EuN/ZveyMgL+q6DA164kl+yLeR9ke5t5otyvX5vcLuQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ifA0EJp0BD5g2vXREvXOAujXhRjsvkmeiTaQftXJD36SkBCM6elNMr42LfEX1pShcGwYI5haHgz8wPdomjcdA69NbutSm7I/Dxf6Amz4Gzr9WUNo+7FZUmzM/QOvdSyfQyg4vC2dLDJu2eTxQbC2R01J/Bx02sWSnxMWQ5oGnN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IgYoQjTk; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JViXN1M2YuCT+W6j4LyoRX2jatRo2yNnFVhN9FqLf6sZlCAEvmY8mOCQMWa6yljX06nYwuytW1oTn1zMfG1oNAQcWRmjGWpaN1/T0NBtYXHWFodASu8a2dV8NRNozZ5oQxyvoo1xi7U4PS9OJfcZ9sG50qb8riNDk3mcbMgoDxkzN/w9D0e1xnL2RztLakyM9WV6Cx5/pn1KXdDdP49ly2uRlhoZer2gtxTG/Fssz6Ru2JuIyQe8+3igfwj/KNfQZZI0lGP4Y2ySZbv9qXlCoXGTW0tpYGeyNg23F852w+TufoiBa8xqhb5sk48JmgsjyoXTXykxTUuAHeYitiy4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMvZlLpziEJuHfVdcdlAXYKea6O9PWX4mr7kDEdiK48=;
 b=UIkKpRHurWmQUy8yPVIukN7b6YQOvyMglm0pv53vIqE75sm3kb3mJu2rU5iii7mHfII1PC7pOJY1VELG3DYdBshzgge0it+vL9oc4f6+i3khQKSd5cwQEtTPJQ+DA1Yhve0DVuQuCxAhBUp3NHOyOEu5JD0SL1GlzKUqLLuVhCFvdI7tBxt09YFDTen8tnrjXlW9dmUTRpm4hEMfhw81pHbdj8HcmrpiFML7lSfLbgnLcsyROx68beXdqDJLhFGRpmn6k1TQhgvF+5WfgtP0s7fOzhR5N6gm8VFbiQOks/yY2Z/52dMnLpSRlnYHFU7uiFGc5q2UTSB+VVvqLCNB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMvZlLpziEJuHfVdcdlAXYKea6O9PWX4mr7kDEdiK48=;
 b=IgYoQjTk7pshTrW5oljTrUmrMEaAkSONP5/q3Us7dQ5Ug3ZDqrePRC6XFyDlh8/uesulbFOjD5O9alq5xxZJlFddQiIdy6QGv9PXsGeV1xup1JxmkpJ5MOd9HM6cGFEMiaE4GWa1lQoo1aidinZSREVu83RC2mtZRfwCO7j1JTVjm58lpzJSvsQR3kKhED/qmorgw526aMVNCnkw5565qCVhoWyrohJu2izu2JsP2fYAiJ/IVWMs+suTNMJEDCrY13wq0F5mRIrGaT1k5tYQcI9He2q6LTjqWJC+FlNvT4hwifFnOA02ErNNjzH3b0V+MlFWYzPxIzioq//EvomAhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Mon, 20 Jan
 2025 03:46:14 +0000
Received: from DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b]) by DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 03:46:14 +0000
Message-ID: <0f1df4ea-0b31-4431-b538-09dbd27845d8@nvidia.com>
Date: Mon, 20 Jan 2025 09:16:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND 2/2] dmaengine: tegra210-adma: Support channel
 page
To: Guenter Roeck <linux@roeck-us.net>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, spujar@nvidia.com
References: <20241217074358.340180-1-mkumard@nvidia.com>
 <20241217074358.340180-3-mkumard@nvidia.com>
 <77e9f23a-60e2-442c-9981-319fc650979a@roeck-us.net>
Content-Language: en-US
From: Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <77e9f23a-60e2-442c-9981-319fc650979a@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::15) To DM4PR12MB5101.namprd12.prod.outlook.com
 (2603:10b6:5:390::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f34692-85c2-4b46-4946-08dd3904fcbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejhnNWsySU56TEthOVc2SENGVFZXT1ljTHd6Rit1QXE3a2V3VVlYZmYzb0d1?=
 =?utf-8?B?RG5TOGtZckJ5eWYyOEJjTDdLVzI1REhwdThBUWhCTGpBWEdvNnhOd0F5VEJE?=
 =?utf-8?B?a2lHS0RPRm5rUS9nTlBJT3BLRDVJTkJkZ2tvZU1xOWhOYTZxMHI3cWZ5SEIr?=
 =?utf-8?B?cE1pcFRpSlg5dGtaaThPMlZJWStGVFlmQVRpOU9BaFo2a0ZzdXVTUE9LOW1T?=
 =?utf-8?B?c0E4dUNKUFduTHRRYXNYSHlleEc0T2Nlb1l6L2ZEOVQzM1hlem1IVGxQU1JK?=
 =?utf-8?B?ZWFOZTNDaWJhbCsyRFlsMkZkODJRenRLNjY5dUdrMGgxMkpSSlp3Q0wrYUZL?=
 =?utf-8?B?Qk52YytiOHBGcG5xdDNFeDA5U1REUmFSaVpvQUY2dTd6WnhmMDdnODZJcnlu?=
 =?utf-8?B?RWwvbUx0VEVudVRyUlZCTE03d0piU3RjNi84RGh1SEtVZGxGb0pSQlA3WmFt?=
 =?utf-8?B?NTB5SDRKaXdYTDZ0SVlyNDdVaHovR1ZMaG94enlrWkc1U3RMdm1KdjhUUXY1?=
 =?utf-8?B?bTI0VkFaVDRuUng1eHo5NldVVFFreGl4aTNidHAzWTd3SlpRUUpCVmx2a2NR?=
 =?utf-8?B?MENvVStIN0lxdHB5alZ5cDRMMDUwQUYxVDZyM0dqbThLenUvbzRaZ1ZPUFZS?=
 =?utf-8?B?WDFvaFJmRnlLQzc0QnpuUUNoZzAxbVNhNzdkNXFXRWtZSXRQSWpmdzhKM21Y?=
 =?utf-8?B?MFhsQzQyNXFEU1VyZHN0ZVBHbFozRUZKbWNnRzFVRHB3Qjh6RUJGcWM1MXhP?=
 =?utf-8?B?NmUrazZqNGQyZDJMVHNzZTBlR3hMdFg1MlhSeG5JejIwNE5hMnh6SXZtQXJ1?=
 =?utf-8?B?TXVnb0RacVVoUmYvQjJNZHZQMGRGV0pTRzZrZUJTdzhlWjI3UVRRTFhOYTlW?=
 =?utf-8?B?WlJkK2tPakNkNkppS0t1bEFjSmJmMkUwOW56UEJKSXNpZXFibjVEa2dGVFM2?=
 =?utf-8?B?Zk9SZHlYYi9VcnF4SmlZQ3JLYjUxS1BpYVhJejRFem9RQnJIcngvalAwNjRi?=
 =?utf-8?B?TS9vUjloSURLdC9FSE4xV3UxMlJVSjk2emJ1d2JSYmYzNUVZcE9QWTdOZDlJ?=
 =?utf-8?B?NnJXaEp4NHFLSmp5NGtUOEN6NVByN05PZ3UxTE44VTNMT2Nqc24rUmt0Z05J?=
 =?utf-8?B?UlVBM0tQdFFXQ2I2TithTk5rM0JzSU1yMzU3U0QydlJDZjJJbVNHbFc1OUVy?=
 =?utf-8?B?bWhhQlFGaUQ5eDVmWGNEOGVrUDJ5djNBYS83WUtnZmdLZVV5MEpRdjV5RldF?=
 =?utf-8?B?dExUeXV1WXhodjR0OG5TNzFWc09MMk1mTFlKdXBxZFRBOUFGUk1Gdzc4eGNN?=
 =?utf-8?B?U0xKYWNLbGlHOTh5U3c5SWhlUGxiMk1BT0VjdmxkMzY5cjBONEZzenIvUkFr?=
 =?utf-8?B?Q05wVi91TDBxcEdwQ1RXdnQ2MXhmcExCVTlHZVdRMVlrY3FOaExlckZOb2tt?=
 =?utf-8?B?KzVEbVhBTDdpR3NIWjdZMm5lSThQMDl6RHozZkJBa24vS1B6VDAwRGoxVEtZ?=
 =?utf-8?B?Z3NIK3E5M0xBekRQdk9mczFkd21lNlBLa3c2NjMvOWI0bm1Bc3BKbmIva251?=
 =?utf-8?B?THVOMTh4dVd5OUZiQzJCT0tnTm5ueWNLYVIrZmd2clc3a002T01pNFB1djJD?=
 =?utf-8?B?b21ZU3JyUmxzYnMzbm1Qa2JmemFubjliejkyYjdOalh1em4vVDJQSkFpbTZr?=
 =?utf-8?B?RmlmY1BjM1pIdkdpc29NQlgxYkNPNTI1TDdxREVNekVkMFlCMHlTN2tmV1NY?=
 =?utf-8?B?bVU0YUlXcFNWa0huZ2l3eTVSTUNyOW11VmM4TDB5QklmY05HSkpEeWxtZm4z?=
 =?utf-8?B?Q0liZjlNaW5TZ3dwVUwycWYxdUVuQTB6b1J6cFFTcmsxZ2lPZVpGdFI3SWMx?=
 =?utf-8?Q?Mn10pkEp466ZC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckRjL1czbklmWWlPS3A0dXo5NGpuNVdJVVpvTFAyOUN1SjI3R0RQOFBpVFE0?=
 =?utf-8?B?eW16aXRKUW5HZ2N5ZnRjK1M5cnJZMkZoTGZRRmYwWnFxaThnWmt6NWFBSi9m?=
 =?utf-8?B?cldJdG1oREh0c3ZTUU9YTDFISlNETjFOcUVUbWFnWWZPWmU2SUZmS2hMSnpr?=
 =?utf-8?B?c2NLM2FCT1BHZ2NIUjRVaVJKUy9FeHhlZ2VQWVpySGtQaDlQTHc5UU1KanRo?=
 =?utf-8?B?QXI0ZThMaXB6RE5OYm5aaWdQYkduVWZ6WlIxVFRwK1NEQ29CRCtMN2h3dHZh?=
 =?utf-8?B?SlV6S1Ztd0tDSWo3NzByL21LWlNuWExBeEh4VEl0ejRIL2lyaTMzeFFucGFS?=
 =?utf-8?B?SFhZTXFOUlNzVERtWGtqQ3duR2NmRXpOL2phbHFIemRBbkQ5bDlYSVdxdGlO?=
 =?utf-8?B?QzIzUGhEMU4xN3VHam1SWThteiswaWE2NlFZQjFhamFwc2N0UEZMNTFLMUVX?=
 =?utf-8?B?SGJQTGljME1BZ2pxTjRvdUg2aHJOZFROVTFic2F2VC9VSmludnZzT3VsOTBw?=
 =?utf-8?B?Vk5JVmtET0Mvc3FFeW9tRWgvU3hZbnZHL2JJVXppenc5ZVBKcE5taGVrSkRX?=
 =?utf-8?B?MnBMckRZQWNneG1jaE8yQTNtczZaRHBtb0J3Y1hyWk5PdXJwLzFNdVo0dDhm?=
 =?utf-8?B?Mm9OZVV0aDRsZWlZdG1UOE9XNTBnd1pTQWlHOGp2ZzB4RXNyeFZ3aGlRV3p0?=
 =?utf-8?B?cGhaemh5S1Fya1h6cFJRTDltdnhwSHJNWis1YVlTajRDY1RjTk9VQ0sxRDBL?=
 =?utf-8?B?czhQZDRmRmpaQkRmV2o2QlFCakIxUEMzNmFOR1F3czRpU2xvWjQ2clFrcERQ?=
 =?utf-8?B?eWJndERQR0swdHRTbXVSTTM4TGx3eUNPU3Joak5rcXdaSWNjVjlWWG9HQVRH?=
 =?utf-8?B?OGFxd1Nydm9ob1N4TENDWGV1YXdBcmI4ZnlPUEdkclBUVE1TZFh3RmZVdVQ1?=
 =?utf-8?B?dmo1TCtWY045SURnMGxGa0dzeFhNUTJuekR4U3lGR2M5Y29sV1cyVG5zQ2pD?=
 =?utf-8?B?aklsa1dyTnorNXpBVGlGRFdBd0gvaU1UbmFjODlJQ0lWUy9KNGVDNmpkS1M1?=
 =?utf-8?B?OXRCWFlLc01jTUthOUFaZFlvMy92MHdnOTFuN291ZzYzTmJyWk5aNlVZUERQ?=
 =?utf-8?B?ZEh2aTZBMkJGamtiYVRJV2VtVHM5NmFKRVlROGN2c2s2VlFSU044MHlwalJl?=
 =?utf-8?B?a1ExZDZaditKRUorVU9mUU4vWnRMSVIzNEdSUXRQVFgvTE1Pb0NKY2pXQ016?=
 =?utf-8?B?SzNVcWZuaE9iMnNFcW9vaDdYSTRwZ0pLYUZtU1I0em55R001Q1QreW5oblVJ?=
 =?utf-8?B?MWRXdTdmQXlaRGVDMCs1dWNiSkQ0cEFiazJGakxaMkdzbWJTd1ZhQTZmdHpt?=
 =?utf-8?B?Sk1xLzA2czRsQ1JVeFZQRUp0aklpd3B6QkJYMDdpd2RaMnFaNjJrU3kyRFU5?=
 =?utf-8?B?THNubVN5eUNvRUxqRHhUWTJzaE83ZWJ1eURBT1JVQ1NocEZ1bXZtdFd0U09j?=
 =?utf-8?B?cWxhazV1U0tOaGNxNTg3NWpnL2ZFcjQrQ2JSODZSczBiOG1KVTZNOURQajdp?=
 =?utf-8?B?MWk4VUhlUDlBTE43djF4blBZREdCRFFXaFZDRGg4cUQrc2FkdGwvVUFJWEdQ?=
 =?utf-8?B?aXE0cll6U0FiQ0htZ1V5UFVIQS93Y0Rtd25jeEx2NUZtTE5QSGxlQ3E2SVpO?=
 =?utf-8?B?b3kvd2NlcmNBWjZINkMzV3ROVE55OCsrWEwxT2Jxc3ROT01rTVY0SG1EdkhN?=
 =?utf-8?B?T2hnbnRFMGJvRisvbHJURDlheFNhU2NuR1RZeGMzeFlpSVl2OFVKeEgxSk15?=
 =?utf-8?B?SEZWWGorTjE4dmJSUVJmZElRUHRtWkE5SjdqSkcrSm83WG5RcXZhRGNUMndE?=
 =?utf-8?B?ZWw5cmg1aEJrOFdRN0hVWldhSGNuZUhEeFo0a2kxalJvSVd3TDNaVnFkUzhw?=
 =?utf-8?B?WGd1RzBrM1J1ZkxmaVJjZXlwcDlmRlFMN3VTSDRGUmJqVGlJQ0NiMlpJRDFI?=
 =?utf-8?B?SytyUytlSEYvWFpicGhEZGdLUWN1VE56RVN4bU1ud3A2eGdGKzRUQlIwZXRF?=
 =?utf-8?B?czJUWXNiZHB4b040Rm4ycGR4QmplaHRUTVFNVWtWb2xMNDhpTVNXMkNWWjUr?=
 =?utf-8?Q?i4UjWJmv1Ie09Z79GTsXlK+4G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f34692-85c2-4b46-4946-08dd3904fcbd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 03:46:14.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3G5LkQz2nVlfPCwjevfLP1Tz3YsIbPpISUG+m0VZHCokAB2kHCdoZi2pWMmqE3hAItuTZKzmUxKcSF5Q8PCtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542


On 18-01-2025 22:03, Guenter Roeck wrote:
> External email: Use caution opening links or attachments
>
>
> Hi,
>
> On Tue, Dec 17, 2024 at 01:13:58PM +0530, Mohan Kumar D wrote:
>> Multiple ADMA Channel page hardware support has been
>> added from TEGRA186 and onwards.
>>
>> - Add support in the tegra adma driver to handle selective
>>    channel page usage
>> - Make global register programming optional
>>
>> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> This patch triggers a build failure when trying to build i386:all{yes,mod}config.
>
> x86_64-linux-ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
> tegra210-adma.c:(.text+0x1322): undefined reference to `__udivdi3'
>
> Bisect log is attached for reference.
>
> Problem is
>
>> +             if (res_base) {
>> +                     page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
> ->start is phys_addr_t which can be a 64-bit pointer on 32-bit systems,
> making this a 64-bit divide operation.
>
> Bisect log and a possible fix are attached for reference. I am not sure
> though if the suggested fix is correct/complete since page_no might
> overflow on such systems. It should possibly be a phys_addr_t, but that
> is unsigned so the subsequent negative check would not work.
>
> Guenter
https://lore.kernel.org/lkml/20250116162033.3922252-1-mkumard@nvidia.com/T/ 
has been pushed recently to fix this issue. Can you please consider this 
patch series.
>
> ---
> # bad: [0907e7fb35756464aa34c35d6abb02998418164b] Add linux-next specific files for 20250117
> # good: [5bc55a333a2f7316b58edc7573e8e893f7acb532] Linux 6.13-rc7
> git bisect start 'HEAD' 'v6.13-rc7'
> # good: [195cedf4deacf84167c32b866ceac1cf4a16df15] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect good 195cedf4deacf84167c32b866ceac1cf4a16df15
> # good: [01c19ecf34e1713365346f932011facd7d2d2bc6] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
> git bisect good 01c19ecf34e1713365346f932011facd7d2d2bc6
> # good: [7fac8eef32d7735a3b01d08f2c98d5e6eaf254da] Merge branch 'driver-core-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> git bisect good 7fac8eef32d7735a3b01d08f2c98d5e6eaf254da
> # bad: [24c55da105e9a641fa77c8d8efbf92472a18bf4e] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
> git bisect bad 24c55da105e9a641fa77c8d8efbf92472a18bf4e
> # good: [73656a6ab6d428102eb5aaa9599b5fcba4a2501f] intel_th: core: fix kernel-doc warnings
> git bisect good 73656a6ab6d428102eb5aaa9599b5fcba4a2501f
> # good: [b995a104a0aa1d6b90ea4ba3110e657ae9e83213] Merge branch 'tty-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> git bisect good b995a104a0aa1d6b90ea4ba3110e657ae9e83213
> # good: [002c855847f718e12879808404dc8375207012dd] Merge branch 'next' of git://github.com/awilliam/linux-vfio.git
> git bisect good 002c855847f718e12879808404dc8375207012dd
> # bad: [54e09c8e2d3b0b7d603a64368fa49fe2a8031dd1] dt-bindings: dma: st-stm32-dmamux: Add description for dma-cell values
> git bisect bad 54e09c8e2d3b0b7d603a64368fa49fe2a8031dd1
> # good: [9d880452fb3edc4645e28264381ce35606fb1b19] dmaengine: amd: qdma: make read-only arrays h2c_types and c2h_types static const
> git bisect good 9d880452fb3edc4645e28264381ce35606fb1b19
> # good: [775363772f5e72b984a883e22d510fec5357477a] dt-bindings: dma: ti: k3-bcdma: Add J722S CSI BCDMA
> git bisect good 775363772f5e72b984a883e22d510fec5357477a
> # bad: [36d8cbd661c48f4c18eeb414146ec68a71fd644f] Merge branch 'fixes' into next
> git bisect bad 36d8cbd661c48f4c18eeb414146ec68a71fd644f
> # good: [762b37fc6ae2af0c7ddf36556fe7427575e9c759] dt-bindings: dma: Support channel page to nvidia,tegra210-adma
> git bisect good 762b37fc6ae2af0c7ddf36556fe7427575e9c759
> # bad: [9602a843cb3a16df8930eb9b046aa7aeb769521b] dmaengine: bcm2835-dma: Prevent suspend if DMA channel is busy
> git bisect bad 9602a843cb3a16df8930eb9b046aa7aeb769521b
> # bad: [68811c928f88828f188656dd3c9c184eeec2ce86] dmaengine: tegra210-adma: Support channel page
> git bisect bad 68811c928f88828f188656dd3c9c184eeec2ce86
> # first bad commit: [68811c928f88828f188656dd3c9c184eeec2ce86] dmaengine: tegra210-adma: Support channel page
>
> ---
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 6896da8ac7ef..1de3d84d3b7c 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -914,7 +914,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
>
>                  res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
>                  if (res_base) {
> -                       page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
> +                       page_no = div_s64(res_page->start - res_base->start, cdata->ch_base_offset);
>                          if (page_no <= 0)
>                                  return -EINVAL;
>                          tdma->ch_page_no = page_no - 1;

