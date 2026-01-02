Return-Path: <dmaengine+bounces-8003-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F515CEF2AD
	for <lists+dmaengine@lfdr.de>; Fri, 02 Jan 2026 19:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15D3630361E8
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jan 2026 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776532FB97A;
	Fri,  2 Jan 2026 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q9v+SZKO"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90BE2E0401;
	Fri,  2 Jan 2026 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767377687; cv=fail; b=RUAU9QhCo1fG9adPqkYfieEMJl8yCZWjaXK12F4EDtLVsiVz2Fmnj1U5jA3Cc0Xx37GADrIt4k+jzDcfofQ1HS8wD3yGi4yv80ApWaQZvyhSRMWZMJWfWfTP9bpta1Ubg+hcBxTuTxVAy4tb8qej7ZDi3Cg/ULAOtgklpglnssc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767377687; c=relaxed/simple;
	bh=hY78y9APovDre/gAafgHziufE3VcrPw0/WFYs0dh5xo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CURMj80AV3vUnJxYt45yImpUitqI8JFwNJVgO+IXM/YdRgkd0SZQFvduhvvu9N3cQkwC+NAfiIgJt/GX2oySk7Ldh+8V+TJLDPTDixkwtKl5leSi2WxODlZpo1ELWpv/Sq7yS8ClG2teptdH/4830vmwogA1GhSQ/QMlUfZlYKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q9v+SZKO; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xctdCHEuyj6RWOheIStSKjMJF5hylpcghM366IkzK2pwvpl9eLAskQaiSfV2GOKSLr3W4Jsm3f9yXe8+rMyXl10MEvFwH47hcFCyQYdJXMosmuoZUi4h6ZqUu9t3atbk4Uo8gna/UY2SPFT136ArUA5t6pj6fMhfzCeza4xIG8c9G+KXrc/nwPF0XXxzeglQgybLB+AeYbEzHZD4cfE8ubZHGxsCJV7QIFtjk2duzyk+SZCSYZ72d1q0qyzqC/YneBnv5XJAthD8jmq/OSUQrM8eWTGtf2oG3lzXzltBEIm/4WIQWzkvcdGpAlWwLten3A8QWTulgMr+/Yt5IHAYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoIjXLmlDbOR+R/zYhFHo5wZHAR0R7ssdkWQTf0VHKw=;
 b=n715FIYZ7Nfo4mLu2OJMe84amjc+vBLAB1/BJmwBSh//+hdKY762BLeVOld2RviN/25COBOqXyxAmYfTeYTkSlmyuXzICqn9dupLf5/pGeHnXQELqDK+C+bmrslHn61ERe+W3Z4rpGOB60UKWzcPPFdB+D7gxz1rHkd2fgMYaTaDGNG1V/TsYFWZ8mVxsZ/TSvitoOyvuZ42Kf/4PTnoafxDlDZxndZpHRljEi32Yi1DHF4IlfxRNJmSYFt3yp3cfQCXgTBkP6yP5s05AuCU56j1cgZ/2bIPA+gfDuaKgf0APbLbnKJOinIF80boKV04IyF1fo+Z1ZDXFgKOG3j2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoIjXLmlDbOR+R/zYhFHo5wZHAR0R7ssdkWQTf0VHKw=;
 b=q9v+SZKOY9DHu6o6tCylOFzWbXjBvgDCjoytA4LeIOh5Ewgd41LA8FD+w3oUQOv5AjN8sfu5MnieDxbbnXvDQdE2BkXK1nFP66ce2M6sg0xbtdSs0IfREB4n6MfsUo+3cE2MylmdZpsulxwBK9JA3loa2Yj/g0wORzgsHvpVEa3DinFKklPxNt6HzrZ8XmFZ4T2JZegjtkfl9afM/9b1cE1wCds1QnDozmODUTRl+rnczGoVmebWtk05R66rdeKVKyeck+twQ7/XC3FpbSFoqAWgr8Tnle+kX+BApngiQCDKjXW/yJj9OvfYkfrTkjI40wIQghpbkrzKo07Ax+KDyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 18:14:41 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 18:14:41 +0000
Message-ID: <87277d5f-428c-432d-9de7-e000c2c1cab9@nvidia.com>
Date: Fri, 2 Jan 2026 18:14:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: tegra210-adma: use platform to ioremap
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251223204646.12903-1-rosenp@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251223204646.12903-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: e5269b09-bd4e-424b-5b0f-08de4a2acc80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGVYSXBLbkN4eTNGZzJKZVZHQzRjOW04cVZvUEp4RDlibUZRN0xxb0JKa25V?=
 =?utf-8?B?ZEhsbUJOWElUVk0wYUN2TVRsZ01sMjNrOVo0OTJrQUR6ZGt5cldNdzJGMENy?=
 =?utf-8?B?cHpqcXlwdXpsQjRCd1JqZW5NQnF5eDFDV3N2V2lSZmQzaUJ4aDBKRVA3K3Z3?=
 =?utf-8?B?K1VtQU5RN05Jbm5RU0pKZVVwRHkwY1NuVWhSampBOWFKOWVoQmVHeXp5akkw?=
 =?utf-8?B?b2lmYk9tazhZaE9SZTk3UlFaam9aVEJlTTR0UEdPQ2RWdjFHYVkxS0FnKzh5?=
 =?utf-8?B?aWh1OS8vSUR1QnZRR3hHdXNVaVBtUG1NSEcrNjFZb081R2JVQ01rb2lhVDZK?=
 =?utf-8?B?b1pMRUdmdDFQTXdPa2t2VjlDRzkyWm15NlJYZkhKMXVnSVFqNXVER1N4Rmxx?=
 =?utf-8?B?Yk1kVGlzUXhDT0VERGlCajZKeUR2bHV4c1ZybDBIbVpDR1hwKzdkK1FYcGhG?=
 =?utf-8?B?MVdYZzF1SHlHT1hhdGNQK1JjZ3FMeHJxQVVoUHVrVTIzUUpVbnJPSVBaMHU4?=
 =?utf-8?B?bExWZFJUWGRpaUo0ZENsVFlRSWtqalpLeW9FZnlpOW9RRFFDNTVPcVlsU0I1?=
 =?utf-8?B?bkVuWnpXd2JnQmJETkJyZXlXT2dENEU3bUw5QzRmY2JYanZFV0czL0NSZFJB?=
 =?utf-8?B?SnV6M2c2dEhVRndkOVljb1E0cFRoWk1TSmo5ZlZhUk1YVlpZbmpkWm9Wb0dU?=
 =?utf-8?B?ZlZJdE10N2I2YitHcE9CMG15MDBDV2pzbk9Gb0VCK1FLM1VqNjFkOVlsZlpu?=
 =?utf-8?B?U0dLakFXUWFoK0ZiUWZSUTcxTVB2MnFIaXpPSEdCQUpHOUVOTXNqVU9la1pB?=
 =?utf-8?B?WXdWdFo1RkxzSitLRHIxSHlRRkk1SkEydCt3R01yOGhmMndKNnJ3MWN3Ykhp?=
 =?utf-8?B?VVYyOW5ramluQWFuYU90K1Z1YmdRWkhVbjhqY3NKSzNmS2FuNk5uYzhYOHdx?=
 =?utf-8?B?UzNSc1l4UHVRR3d4bDh3eHYzeTVWUXhJSEFYRFA5TGg4dUo1N1c3aktiblVm?=
 =?utf-8?B?VzBsWG5tMExDZmVKYjFNdS9DeSttWDd2QXptZW1md1hTZ1RKbVBkZDlETkQ5?=
 =?utf-8?B?eEc4aGp2TVlLWGExS3ZGRnRjNU5SWkxoRDA5SE8zYUxUeDJ2NVdyLzdVNkEv?=
 =?utf-8?B?cisrOHFGWmhUbGNhdDB3UWFGS0pPRHEyRFNGY3pWTHBUbXFRUzZXMkk1eStO?=
 =?utf-8?B?WkZnem1DcGtSbytGWnVOeUswZ3hVcCtFZUo3UERJRTFqK2U5TW1Vb0NrZVpS?=
 =?utf-8?B?aGlTQlFMK1RKYmkvUXlrT2ZRbTN2VkNVWHZobHplNGZ5N09QOUE1WmRTTm5U?=
 =?utf-8?B?VmxPWllsUy95SHJXMUcybmFzbmVCTkM1OVJINndjcHB2dTNDc3hqMjM4Ym0y?=
 =?utf-8?B?ZUFLUHMvTVZWSXFPNXFTM3RtNWRLWmVlKzhyMWJERFg3S3BXOSthSkpaUlVZ?=
 =?utf-8?B?SWlIM2V3UUlvU28vd0NuZXk3N3ZyK1p2VloyZHhFZkhpWVM2QWJmeWgwbEN6?=
 =?utf-8?B?ZEI2T2JjeG5SSENmNW9QWUxKbTFFeno5Q01lSEF3RHo2OUNZOEhwOXhRc1dH?=
 =?utf-8?B?TWsxT1d2QTRMOEhPYUxBVWhOb21vazFxTGt4K1hGQjZ2c05Qbk9FVTdqb1dR?=
 =?utf-8?B?RUhRR2VuWEdjaGpVZmRDU0Nvb2dDSndkSlFxNkFqWnV3bHBLNUZHakU5RkR5?=
 =?utf-8?B?b3h4RHlCanRuc2dsdDNrbzdFRmNoQ2JuYTFNNkx1aS9ZNWRpekFFVWUwQ0Fu?=
 =?utf-8?B?NzM4YWlsRTg4aXdpYytyMkwyblZNVW4rRUpsWGNhUzYrbEUyM3RxRlNyNFhV?=
 =?utf-8?B?dlRSSnVFZmwrU2N1c1prd3BrNW5WcnF6blNMaWY5RlJyajVHTXVlZHNHa0FM?=
 =?utf-8?B?SkJOQmxFS3dXb2pFYnFBNytOQUZlamhUODhsQlY2WGtkQnFEcDRxd3VKSjE0?=
 =?utf-8?Q?kZ3oBeWdKUP/yGvY6L3BGfMDaKRtT6zs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmY1NkNic2l3a3RGeVMvdWVOYVhPcWFlQ1ZZa1RJeDZ6eGVWSmpwRDE1bkRv?=
 =?utf-8?B?Y0JnN3NkVm9IbE9ONElqMlF1eFQ4SWFNNTBKVlp6RjhiaGhCaDU4U21SYklS?=
 =?utf-8?B?a2tiTjlEdEJWdkpySlVmL283ZmkxSVNBaEQwZzR3M0RoRXRTVzFJT0JZSWhZ?=
 =?utf-8?B?b1pVUXJiQktSdXNFMm80QXdMVXQvOTlSTjZiWUlPZmYwZVMvTnNKZU1RdzFr?=
 =?utf-8?B?NytjYkp1YTAwQXd2eWNlZ1kyQ1FOWVg3dTlHdGRQWldYS3ZZYmE2YTVDNFZs?=
 =?utf-8?B?MmF0U0s4V3kwamRla2E0QS9IeTg4dzVLSlE5aGgrNkk0SEtVZU82NG1pTkZt?=
 =?utf-8?B?Y2JsOTBoRzkzTUcwQVF3N0ZkUmduVTU4aW9wckpKdTZXcUxGci9UTG1JQlli?=
 =?utf-8?B?SUIzMVpCS1d1V3lpYkMxZWlmU29BOEVjUEd1WExsbWpxNnpwNGNrbUJ3ZWI5?=
 =?utf-8?B?YnFsMDlidk9QVzA5SHBGVTk1QVRzbGNXekF2aTJWT0p3L0V4RHVBaVB1bmdE?=
 =?utf-8?B?R0dnazFxaWdVemFlWU1ZanZrZEtqaEY2OWNWcGs2VEorMTRzNHBMbmpjM1dw?=
 =?utf-8?B?MWRMOXZsY2hoKy9HalZaM29LQzZtRHRmK3dwSXB2S0I0azc5MlRlMW1sNkZt?=
 =?utf-8?B?UVVXTHptM0dsZnJQb0pIRE52T1Niak5Ec0dMMWc1SWh4Yk5WUi9BK2FZYnl4?=
 =?utf-8?B?QlFQd2hhMWpLRXBSdkJicTlpdWVaV0RnNmJUR1ZwM1MyTWd4SVN0WWlTWUJY?=
 =?utf-8?B?T2NHNGl5UE92aFdCeDcrQy8zVk1TQ0RiL002MXp4TWhWS0U3YU95b0d3byth?=
 =?utf-8?B?Z0JveTVoRERwVDdOSHhKR2dBMDIyUURSb1lGaVBUazZQTUVac3JTVGVJajdR?=
 =?utf-8?B?NHVaTjhYRklxUDJkc0REZDNFN1hNajEzVk9Vb0l0NlpQOStid05pcXVUd282?=
 =?utf-8?B?WWlyVXdjYnhqQUZOWk5JZ2FUMlZOUHJvSmkvbk5sSHFFREFSOFlhblA0UzQ1?=
 =?utf-8?B?NXFmTHVLS1ZLT3B4QkJMeWM0NXh4Sm5DOWdpY1REWDVZdmF2S0FTM2pQYlU1?=
 =?utf-8?B?R1E5M09DUFhzZDhtUEtMaFd2R1JhcXoxWGo1V2lES1QzNVpFY3U0YWZsRkFm?=
 =?utf-8?B?cURUQ3V3WnFybmp2VENUaFJrTmc3RHFVMHJEK2d3Mjdidnh2c3JMSll3bXVj?=
 =?utf-8?B?cWVoMFVWTlRsNDJDNXhINXU1ZGp2d3B4SE9xSGtub2lwbFp6RmwzWHF2Ykl0?=
 =?utf-8?B?cXpPNDBrYW9KanVaNXlnb2EycTAxbERtVEluNUNaZ2FObmRpMERSc2lla3c2?=
 =?utf-8?B?b21iZmFhT0xidFlVSkdiM1R0aDBMQmlsazljckNGdFF3cGlmV01DTGJpRS8x?=
 =?utf-8?B?SHZqd2VjODg4VmpmaFA0NndkdURSSnBOVDg5YWt3VENpZHBySXFuQ1NoL3pV?=
 =?utf-8?B?N1dpek9TSlkwQllDREd0WVZvVW50bzZYQ01uSW9PZ3VrOWxxTjFVYXV5Ym9F?=
 =?utf-8?B?VXNVdk9wNm5Ea3N1T1h4UE5JMGhuZ2I0ejlLZ0gxL0swUGZFSXFsRUVZMDNo?=
 =?utf-8?B?SytBTnlFc3cvbkRxOUx0cWJFbms0ZER1OVRHUkZ6YUNvY0tqOU85R2N3aitK?=
 =?utf-8?B?RnVyWjZCNVBoMEFUZ1BvSER1cmREd0ltUnQxK01pdGF2aEpmRW8vYWZpdm9E?=
 =?utf-8?B?ckZwQm1OaWRNSVY2WExod29pKzE0UzEyTVpoREM3N3A0TjZBUm5DQTlGVk5U?=
 =?utf-8?B?aXB6emJ3Tm5nTDkwWDFvdnpJTWRSb0JvcFRtWHBoNDIvaHZoTit2cmdPM2hn?=
 =?utf-8?B?Z3VWenV5ZzFGUGd3eCszNE1Ia1ZvK3pFdWpPc2lqNklKOWlqSDYweXRQazNy?=
 =?utf-8?B?Qm8yYmZVMm9rT1pYa0NWWklsT242ZnAzK09rTGJUTVk0bTJOeGtsRjhnM2Ey?=
 =?utf-8?B?MngxM2hianZYbDRwdEprU0RabXFrMmpRcTUxSW8wK2V4OEhlOWFKWVFZWmdt?=
 =?utf-8?B?RjAxNGs3RVZIaXNqK0t4WFpSRFRZVTN6L2YyeUgvVzFYUEFieFQ0enVNbURy?=
 =?utf-8?B?VkgxY3RoNklHRkxxWURiVThpK3AvWU9sRDRnci85aUxJbTA2dXV0ZWt5TzJH?=
 =?utf-8?B?RUNxSGczRGtYWjAzVjFTSFdtYkhjaVZudWNIaHlYUzcybE1LVE9qejR5aGpq?=
 =?utf-8?B?RDhuWFlBTG5jVFExejVNb1hqdlJtL05UbXFFQlIvM2V2NGpPdXNQZFJLUWR2?=
 =?utf-8?B?QytJRVNZK3hZVlAwbFNFWGp3UDk4Z1JqQjlabTc3TVVsQ3Ivd2IrbjBSUTR4?=
 =?utf-8?B?UFFFWE84NHZjL3lyQktHZlZvdVV6bm82RGQxS1V6Nml6MndITmFEUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5269b09-bd4e-424b-5b0f-08de4a2acc80
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 18:14:41.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uPfio8qIgMeRsj2pmiiGH6Zqd/j7Lw22XJYSuzaWKo4mg9evDmvs27q2GtjNNamTKNL3zeTn2P12QmLJzKHgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918


On 23/12/2025 20:46, Rosen Penev wrote:
> Simpler to call the proper function.

We are using a 'proper' function. I think that what you are trying to 
saying that we can simplify the code by just using 
devm_platform_ioremap_resource(). Change looks fine, but the commit 
message and subject could be improved.

Jon

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/dma/tegra210-adma.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 215bfef37ec6..5353fbb3d995 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -1073,14 +1073,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   		}
>   	} else {
>   		/* If no 'page' property found, then reg DT binding would be legacy */
> -		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (res_base) {
> -			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
> -			if (IS_ERR(tdma->base_addr))
> -				return PTR_ERR(tdma->base_addr);
> -		} else {
> -			return -ENODEV;
> -		}
> +		tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(tdma->base_addr))
> +			return PTR_ERR(tdma->base_addr);
>   
>   		tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
>   	}

-- 
nvpublic


