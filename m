Return-Path: <dmaengine+bounces-4803-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76B9A798C9
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 01:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA584188B4D4
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 23:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521FC1F5845;
	Wed,  2 Apr 2025 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sb6lw7rk"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DEC1EF0A3;
	Wed,  2 Apr 2025 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636407; cv=fail; b=ErhpRb8x3sggVCaWDHimfAUHqyJSQDb2DH1DGfnYn5nDHkyXDE7iw+4oHpZtkCNZ6lsGomlauU6XMP9272s+BXeENYMYjkFBSaqsGeWm6tuKCUADBJ5pbspbVdo6WeWHXXNSHQlP4ggxAR8/ciezwtedAzOMSuWyBTRqw/VZCkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636407; c=relaxed/simple;
	bh=BH25iLgx5lgLQ7km7Vf5wbr4uZai2PgWYaayRy0bsDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rgl+axHNK7N8ycTf9bagHtACD1HQ3X99yxuFWAXbyCQfZZJXj5e9YR9YlLwsfpBi3XPqzNkzYppQF1EE1yjTlp+96EJhIdzofv/HVES9o1dSv27yGKpx5HqEycKKCFm+u0gUmx+R1rA+RjL+a95hmsO1ZVmmmdxfCRiHX1mFwIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sb6lw7rk; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsSIFcNiFas/CIr1ordsxh6PBAGCDOay7p6g8S3bPXDUgLTL+kBuYA3ZPdBPV8emCGRFrjEodY59sXkxJd9UQqPuUBN+dbPvofvN5AJBcbxTM9AzFGMAU/0C5Sel7UwV0NnB/hMoSCxT0NAnoG4Nt6YPK84V/sFx0wUrOIhAN8wv0bWxFyYsSvpyNG2guOdRoZlVy4OFxdKiHx56CMDc1/KKq9kmIiEtbQ+lnLgQu4QdGi7lcNMl3Dqyrjatq+e1Ot0s6X25ReHItZUyO3GFGxqbPnGGzDVrfAQ9JVytFjF7tWUVMlDJwbaqauLLb0JjyrSAqh9TjZd+05hfPRnAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOxKHktvAaV8JwIicphIbVJMPux5hmbqU0SKZ19aaxE=;
 b=tzvBLcY3QQWa66IgbPd+Pnt8ERvIkNteBIzoczBq2p+8OSCIluQaWFzEfq2tqHrZ/VlQBEQe/UIyI72N0EngXvI1JDSTI2k4z0rhvG0mDqivrmuX3/bSLdgUD6lcD1bgWCk/1Sgi2TTzyQ4mkIQaeraqW2H2qJVvM1+1sTFS9rNrBjt9an/YZkrB8awjC0mHohosvvxDRKs9CmW2lYCWPhlcJ8SSs58pTgE/Jokc7zO+YK0ItIkzPT1RRZg75n5mERccsezZzk9/g6wKANRZsvRoLiCyV3qnHtVvmCkBFmT6+lM52VclY9nKBOWeb8+mkg6Cb3QoWJueGN6QPHtLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOxKHktvAaV8JwIicphIbVJMPux5hmbqU0SKZ19aaxE=;
 b=sb6lw7rkCt9b7lANOgX4dkWgtUD3Q3Vqwl0SAV65sj8oWYiYyxWOlxW3jBFt+S6omTR4LHLeSed7avK8PgEX+suNf1ZH9N3YGITst3gu///vg7VTJhdDvyCeaxCTvnYmZZv8jIOSGxIZ9RDNwbEVz1JevXyBBV2QId6wCPtK05HfmjeVs2ptL8NMCtmS+0AamQJAfW+ygp/bpHF+v1KvTiekPCk8x91fyB8cuVidg6XbUTX6xt3hw3c+bCWVZvQ0j81NdHKeIHDzgXgz2bhVVi09WP0AYRurQwTvVXkTXekLEN/nitq/40wqNx62edJITEtJo4ZH7F2s/bhduCyfbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 23:26:42 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 23:26:42 +0000
Message-ID: <22b63198-2aab-481c-a4cd-74c3349e22f8@nvidia.com>
Date: Wed, 2 Apr 2025 16:26:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] dmaengine: idxd: Add missing cleanup for early
 error out in idxd_setup_internals
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, Markus.Elfring@web.de, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-5-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250309062058.58910-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fab38b-319d-4c7d-fdd7-08dd723dd38c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2p2NzhjMldBcGpkOUVlbzN6RmJwTXN0Ukg3RXFVQlN0SFdwN3NkeU5kdWxp?=
 =?utf-8?B?TUxnL2cvMi96OHRqYXh6V0VJL0hRdnBoSDd6NnN4ZVNTNzRTOUVrOGRNc09K?=
 =?utf-8?B?dVo0cHZDZDZvZEJlUmJjRHZwUkJpZnNTQzVUN3NlQ3JrSnc5YkphTWZWS0Yz?=
 =?utf-8?B?aDl0NmFTdWZPdlh4em43YjlVeFFCQ2VPVmdESHFucys4US9LUEdPY0ZqbCtl?=
 =?utf-8?B?T2lWRERNT3U0S3ZCR241WndnekRyQUtsQjNFV1doYU45S0Q5Zm15cDB1bFpz?=
 =?utf-8?B?dzdvS09IR245WDE3d0ZjL3o2VXRPY3dhcENzWkFuaGdlSGtOZVhSY05qNktu?=
 =?utf-8?B?UkJLSG9QbUhwUWk4RUlUWGx0aFdjV0hCeDRZSmdhYmxlMGdKVHJiVXY1NTBl?=
 =?utf-8?B?NWs5ZXVGVm5aNHd6dmhLa0VpUGxqd0RjT0UvZWN0VCtoaHI2b2IxMGpRMlor?=
 =?utf-8?B?VUY3bUFuYW5iTnlINDVDMlVQMFQxR21EV2xSRDlZeXpuMkEwYXBWN0xOeTA0?=
 =?utf-8?B?UWJSQy80cXRUVUdYb1BpdnpGN0pwcXN0UHlkV1J0V2pDNGpMejVnaWdmV3la?=
 =?utf-8?B?ZlBsR2hta0ltZjJNc2lHd3NVOWlWOUZKMjVZWDE0STY3dEdSTkhHeUFKMjlE?=
 =?utf-8?B?SGRQcjhzSGhkY0VxdDFPNlllMUQ3ZnpFSit6QkZZQTc2STdVWWpJNnAzdWRY?=
 =?utf-8?B?NDUyK1NHVmhMUmVJd3I0Vk91YzNhbCtoTGhISVptN05pVUJIY1B0bzlWUHhO?=
 =?utf-8?B?WklkM1IrUzgyN0pCYnpyQXBsTVFrVHpxemhSMGIvVmg5Q0JUK2JFNVJ5RlBh?=
 =?utf-8?B?U3NhRlVCa1pqaENXSXYwTFcrNllWTk81UzFEODE4L3ZwMGh4NlpreFRyMnNM?=
 =?utf-8?B?amduM09IRTVvUTM3VGpqUk9taXRYeGVtQ3lpbnN2RmxycnF5NlpQWFFqS09v?=
 =?utf-8?B?QlcxbVJBdFVaRkFyMnJVNWc2VDRJdWdkY24wdXVaaXpjYVE1SWliMXBFVjZk?=
 =?utf-8?B?b25YTDlta2U1SklJajBna1FqTUlZN3BTYi9LeCtvaE1PTGc2SDc3UllnUXB0?=
 =?utf-8?B?QmkyOVk1eEVOaXU3RWdFdzJudnNPU1VpaFQwZHNXYjlRRzVuazJTYTk0dmQy?=
 =?utf-8?B?akFPZlM0VkM2Vk9XT2h6THhhWkRtUXBPQThzcW1XNjNLeFZUMDFrZFZIeFMw?=
 =?utf-8?B?cVVmWTNiMVNDREJrN2tWamVmNUFnSjZEbURxQ1pHV0YyNkpHTjJidlo2ZmV3?=
 =?utf-8?B?SzNocHpvUHk2N1JiVk1pZENqdHZnT0lTdHBzQzhYbjBuT0l4bkYyeDhTdjhj?=
 =?utf-8?B?QndQQyszTzFSWXRRby9RMVJTVExwbWtoOC9qWmhIVTdSc2crQk0rMzZOS1N1?=
 =?utf-8?B?b2djaVVBVjJwam5WSHBCS1RKN3MySm1ZRlRFYitUMHMxTXh6Q3BQMmYrOXRN?=
 =?utf-8?B?TFdjWUYzUVBjYlRRaWJMVjRXRW5UcUtuRUM1L2pWc0p2NlV0YWRKYnV4QkVF?=
 =?utf-8?B?ZVBBak1RUTJsU1RrN2czKzFWVEY5Q2dNUDBkUUl5a3NQNDNpYmY1SFRCNVkw?=
 =?utf-8?B?YWxHQkI3SEJSdjc0ZnNuMUU5U1NOSVBkbXVmVGdWTjB2UjEvcWdpRGRmUElU?=
 =?utf-8?B?SmVJV3IzVCtEb3htWkM1OFBYaEU0ZTNCTERkWjRFVDF3SXR5OGFhQnhZQUtk?=
 =?utf-8?B?RlFxM1J0eC9wRkZsYW02NHVLME1waWNJSm10MWhlQm1EcGE5djNYT2JSVmVI?=
 =?utf-8?B?cFBEVmxtWldhZThCZWVFU0JZdXVtaFJTcERxTXUwMEpPbllLOEFHcUdIN3pw?=
 =?utf-8?B?ZDVBLzZnVHJZeGp1amlBNVBYOFZoRVROMmhnQ2FQRXBZR2oyRFdNUjB2c1gw?=
 =?utf-8?Q?d2Quypil3As0p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekNnbkJHSWF5VXN1WTdwS3R6UkZaVVM2dkxsRkUvcmJHeWdNZkFOYXdCQmVs?=
 =?utf-8?B?eUZjUDNRMkZyWEhjN1lkekhXUFdBZlBpcVQ2QXQxWDQ4V3pOSVpXM3QyR1BZ?=
 =?utf-8?B?anhPaDd4S2ZCbmlsYnhLMWVjQk1BZnRsRDFPMmZhcjZDMGlpSDZMaU41UTNo?=
 =?utf-8?B?OWhocmtVY1ZDQTRlUmlENjgrdXgzcmU3VlhKbURjTDdtSnI3ZUQ2WUsyeEcr?=
 =?utf-8?B?czBkWjU4MXFrQm1la0hqOW1JOGloZXVJdFovaFZxTHBYcnBsS0c0ZnNwYXU5?=
 =?utf-8?B?Rml2K285R21KVjFwdlRqU3krcU85TGY3MjJxQXNTU285S3JidXpjcVc3VzVV?=
 =?utf-8?B?ckFwS2puS1l4T0xTWmVUSHpJSHFRV3MxQ201Ni81ck5rZzFkOXZVb082ZGJh?=
 =?utf-8?B?TW5zYllCTjB0dGtDSjVUUVRpemt3WXRyNDdVaE1SY0k1aTVuZkMzRG9PRlZ2?=
 =?utf-8?B?aWZGaDZQVEtyVzRxVzIvdFNhUjFZbzVaM3pMbDJBVHZydkNDeHVzVk5QcCsr?=
 =?utf-8?B?ajRvZThMWXlBMklhem4wQTBsbVliRlBERTU1U0RXSnhqQTJuZCtCSGJnYm5x?=
 =?utf-8?B?QUVnRUxodWVVd1NBZkl1TTcwak5JczJHb0lMT2RnempvRFplcUMySFIwcUps?=
 =?utf-8?B?WFFhOWVJb0IwUHAwSjJZbU5tVlh4WDRRWjdRZGxRM0tSd2lXUFVsKzFlcmNG?=
 =?utf-8?B?ZEV5MklCUUN3eERMcGdhek1GNUtGL2tkTFh5VkEySXFsMGN4ZlQrU3JUQTE4?=
 =?utf-8?B?Sk9vREtnbGRjSE5CV3JxSzZpUklxaWZPaEtuZm5ZZEV5MlQ0bG9oaFJuK1Fv?=
 =?utf-8?B?Q0pmQnpqWVUxY2xzeUxTL0NONkFPbkpMUlE3YndZSEE2K2M5blNvZ0tlaUZx?=
 =?utf-8?B?dWpNV0xRMGs5elU2Q3BSSVZRVzN0eExkYzFwcjk2blRuVHhpVkNzbkkvdmJU?=
 =?utf-8?B?Q3pFS1I3MGhEV2dzdjVFemRyMW9OeEhpNEVoVGNZNWVadFQ3emtQRDJmam1x?=
 =?utf-8?B?UllSMWVFSmx6Z1UrOGhzNFVjajN6TjYwKytmT1BaN1R0YTVsQ3BHSkhzdUpa?=
 =?utf-8?B?aGRWTjNBMmp6L2NycHcrSmJPNW9BS1JrdGtveHA3NjFzN3o4UHJTVG4vQ20x?=
 =?utf-8?B?K2tSRHgwVWY1S1FCRkJyV3hqNDNEV0tzV0ludWQ0L0tvUU45Y3UxMVJEcG1x?=
 =?utf-8?B?eXQxL3E5VmNGQnRLY04xeG9RbUNjQk1pT1BwQ05NVEJ2L1l4K0ZyTFY5ZlVR?=
 =?utf-8?B?aUQ1RFNrUmR0a0ZmUm1zclJyZ1ppQW0zWS9zRi81am5xS3FJR3J2TW9wSGVU?=
 =?utf-8?B?ekMvZ0lVblNhbHEyc3JrNmRpOHFJQ0UyUGRFdFBFek5sNHdZdUhTTUtySEgz?=
 =?utf-8?B?WGkwek9PWmM3ZlAwK0VhaXh4SVNxd05iVExreFljT0oxVU1qOFFWYUxGQVFB?=
 =?utf-8?B?dldPdytBMEpyckF4NGt5ZitRcjFKWnNoUmJ6YTdTdHJnRGFQTTJhdlJ1N1pC?=
 =?utf-8?B?Rkl3Tk14dU1ITzMwNmkranlMMkNxaENTMERqblZxd1N1NUhBek8wcXY5YkRR?=
 =?utf-8?B?V29Bd3hTc1QycDNud2ovVTFFSUtIcmEvMm0zcUVUckdHV0FTaytMYVZ1MzFF?=
 =?utf-8?B?bFNrRXh6WjgzMzNhRUt1RnlSSy9ZNjl2MmY1SWFzRndFYmJPNmxqMXIyTEZl?=
 =?utf-8?B?WnFNLzI0MzUwSVNnS0I1M0Q1UjVmQTRCUXZiUE9tak1FM3dlcmkyUFZnTlpa?=
 =?utf-8?B?cUhCWjU3ajkyUWVuaUN0TGNwd3hwcmV2ZVYvRHU3bnR6aHVlM0xUYkgzaEpO?=
 =?utf-8?B?V3N4YnowTWw1aGFvYWgyYW0vZEVpYmdWcTNXUlovRjBWTkJzcE45MUFtOVFx?=
 =?utf-8?B?SmpTSWx4V2ZsR0QrbklWM1oyeEhRVmJRNDI0REo3WFZTSGJBVVhKbXo5QUtV?=
 =?utf-8?B?T0hyTHo5YnpPRlBrL0VOTllSUHgyTDBWT3hMeU12VWNuNGZoMTJNS09kVUpP?=
 =?utf-8?B?aTBjUzJ3REtBaFFQOWt1ZUF2M004eTFKME11dkkrQnE4bkhrOElDNmVOQTRO?=
 =?utf-8?B?SnZ0QjJvcStld2Q2NmdudWlwQ0VROGw5bUJYOUQxemk4Wlc3S1VXNkt1eFM1?=
 =?utf-8?Q?zQwfE8tGOG1vOCxr7NXSfQ4gO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fab38b-319d-4c7d-fdd7-08dd723dd38c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 23:26:42.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VrRM4Za0TnFaAfX5vABSce1+KeD5s2hiHkh2O0jn6yczyvJizvUCD/XThSPGToL3h5mritzHLVzENFcbphtkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161


On 3/8/25 22:20, Shuai Xue wrote:
> The idxd_setup_internals() is missing some cleanup when things fail in
> the middle.
>
> Add the appropriate cleanup routines:
>
> - cleanup groups
> - cleanup enginces
> - cleanup wqs
>
> to make sure it exits gracefully.
>
> Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
> Cc: stable@vger.kernel.org
> Suggested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>   drivers/dma/idxd/init.c | 59 ++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 52 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index fe4a14813bba..7334085939dc 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -155,6 +155,26 @@ static void idxd_cleanup_interrupts(struct idxd_device *idxd)
>   	pci_free_irq_vectors(pdev);
>   }
>   
> +static void idxd_clean_wqs(struct idxd_device *idxd)
> +{
> +	struct idxd_wq *wq;
> +	struct device *conf_dev;
> +	int i;
> +
> +	for (i = 0; i < idxd->max_wqs; i++) {
> +		wq = idxd->wqs[i];
> +		if (idxd->hw.wq_cap.op_config)
> +			bitmap_free(wq->opcap_bmap);
> +		kfree(wq->wqcfg);
> +		conf_dev = wq_confdev(wq);
> +		put_device(conf_dev);
> +		kfree(wq);
> +
Please remove this blank line here, warned by checkpatch.
> +	}
> +	bitmap_free(idxd->wq_enable_map);
> +	kfree(idxd->wqs);
> +}
> +
>   static int idxd_setup_wqs(struct idxd_device *idxd)
>   {
>   	struct device *dev = &idxd->pdev->dev;
> @@ -245,6 +265,21 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   	return rc;
>   }
>   
> +static void idxd_clean_engines(struct idxd_device *idxd)
> +{
> +	struct idxd_engine *engine;
> +	struct device *conf_dev;
> +	int i;
> +
> +	for (i = 0; i < idxd->max_engines; i++) {
> +		engine = idxd->engines[i];
> +		conf_dev = engine_confdev(engine);
> +		put_device(conf_dev);
> +		kfree(engine);
> +	}
> +	kfree(idxd->engines);
> +}
> +
>   static int idxd_setup_engines(struct idxd_device *idxd)
>   {
>   	struct idxd_engine *engine;
> @@ -296,6 +331,19 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>   	return rc;
>   }
>   
> +static void idxd_clean_groups(struct idxd_device *idxd)
> +{
> +	struct idxd_group *group;
> +	int i;
> +
> +	for (i = 0; i < idxd->max_groups; i++) {
> +		group = idxd->groups[i];
> +		put_device(group_confdev(group));
> +		kfree(group);
> +	}
> +	kfree(idxd->groups);
> +}
> +
>   static int idxd_setup_groups(struct idxd_device *idxd)
>   {
>   	struct device *dev = &idxd->pdev->dev;
> @@ -410,7 +458,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
>   static int idxd_setup_internals(struct idxd_device *idxd)
>   {
>   	struct device *dev = &idxd->pdev->dev;
> -	int rc, i;
> +	int rc;
>   
>   	init_waitqueue_head(&idxd->cmd_waitq);
>   
> @@ -441,14 +489,11 @@ static int idxd_setup_internals(struct idxd_device *idxd)
>    err_evl:
>   	destroy_workqueue(idxd->wq);
>    err_wkq_create:
> -	for (i = 0; i < idxd->max_groups; i++)
> -		put_device(group_confdev(idxd->groups[i]));
> +	idxd_clean_groups(idxd);
>    err_group:
> -	for (i = 0; i < idxd->max_engines; i++)
> -		put_device(engine_confdev(idxd->engines[i]));
> +	idxd_clean_engines(idxd);
>    err_engine:
> -	for (i = 0; i < idxd->max_wqs; i++)
> -		put_device(wq_confdev(idxd->wqs[i]));
> +	idxd_clean_wqs(idxd);
>    err_wqs:
>   	return rc;
>   }

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua


