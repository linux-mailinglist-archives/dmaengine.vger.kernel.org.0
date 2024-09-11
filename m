Return-Path: <dmaengine+bounces-3150-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3687975D55
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2024 00:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81516285565
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 22:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4F1ACDF5;
	Wed, 11 Sep 2024 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkcoLj06"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9624186607;
	Wed, 11 Sep 2024 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726094314; cv=fail; b=puitQt2CG+VozIj34bVsB0TQDvX7nJHVZM+oWfppF+qI2kvCl4qWkR0Z7GMtCdztcaxuBSUixZ2cX9RkqU8H62boD1Z/8lhemmzVhqjimZe45l+NiNIflskPekdwqjndtyjN87DYY9Tc6VIE4hPqthPxAG83gCCumj7ty9d40HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726094314; c=relaxed/simple;
	bh=+b3VYdsk4K9FTy3svzUVs0r8CZgEBzh/7a/PPqQ72sw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HMmVD5oyHXJ3y+SxvWliN/aQwuD6jlIA/Qd1N6EqBi5bnj+hnA7++NUsWc8W2Gx6EPZQclJI/XsLYT84PMc4wIyjL1F4SgHwYQTTaA1JDhEXEOdWZ5wxCwnE9jpS1sqTj64zqmdXbwpGSZ0owNnf76/hJPP5QLn7xNF13C8OY6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkcoLj06; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726094312; x=1757630312;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+b3VYdsk4K9FTy3svzUVs0r8CZgEBzh/7a/PPqQ72sw=;
  b=lkcoLj06OJhEgUV/pY03rAs8iSD2rBvRmcobKnN/YiLKoChoWNPjAfEY
   9JzJS6W5RorFVBR6U9csXp6ZqDok8bzhpic5fTyGpJ/7E121ZKft/GwVv
   gTmwFThHMtq2TZN+yIVrc3oigiVLKNHY93+BCOpAIjn1AzkmlNtAGiAC1
   XP8RjkPD/cwS+gk0T3AwcAkePU2sg4kovgEHgJ4twWcIdzpByZErsJS+u
   wPzikK2jHTALd/m+ao7KcWiJ00Tj4WKI0qEXgGbtIiqp5tpXY0uwvxDX5
   7eri7b/rJD+0+We+IkWZDiBOWaELrL65oQGEYYi5fKmqG/+e34382hdJH
   w==;
X-CSE-ConnectionGUID: 3RrMyK9sQ+yWsom6SmI74g==
X-CSE-MsgGUID: 8HfqS/cSRQeSR5p+wV5e6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="47437001"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="47437001"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 15:38:32 -0700
X-CSE-ConnectionGUID: 9Kj7LzhhRdeLl2p5qz7sfw==
X-CSE-MsgGUID: 4zKrYWlaTHS5HSdHrvmeIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67508681"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 15:38:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 15:38:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 15:38:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 15:38:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 15:38:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2NCyuERfMQb1JsZthBrUU6D8KNxSq6PkU6QwoKTq7gGgEnoEV0H6ZyMvJYsbgoh11iZ0jTMebj9V3YH+aea+BznLDp6uzdjCmIpqM5LaiKpYMRH3VwabN3bXgKQ54GJeEnFC5lbbBrd9UZOB97Cfd8B0fForQhv6++npppsB+z5/wpPVa4Cd9WiFXXntwfuwtUTIcMaUysxhnVp8IvPUFMq+CGQwvIZWKdHufBdHTHphsl2JMB63cEJLNSMwBZ/aRSIlqNP0mDd/xk5Hle/hExn59bHY8FO8PEV4LjCKDDEtgf9ZRI4dLBc8prXwH8cX9Mp2TNFpMe3+vp66IjmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrLdJClPwq6DkO47/rYbbdE1+1gUykfR4xnmq0bqCCc=;
 b=h6ETbN3LOCvo0yCUVw+GuKdDeW4ygR+hi15YsUzMvDhTxNWaW9gXEKINTjdc+AwlxaUqNDK2iCbkoavinSxRI4GJTTzo8rKydBcBFjeOsec2Q4EaWvo2lCBPmmrw8RxI5F0I3ZeDByXvmm8aod/uTpk6PqQdWCbo92IGbpezqpK0zqt/xnW+xCloro4kt/Pxq7bRpSgy2ftdpQMB7KihOz1Tx5qRrAIfDbLpn2dBI2JyoE6bXzgfjSwgjX4oG0RevCemI8y/Cu/1Ui6lDIz4G3eWod5uecnqM95CbNHgrCLTHU8FD5Dky2MswE4XnDMG95/FRwjv1QmI+h3vPuQL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH7PR11MB6793.namprd11.prod.outlook.com (2603:10b6:510:1b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 11 Sep
 2024 22:38:21 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 22:38:21 +0000
Message-ID: <326a2bdb-d4cc-2cf7-d4a7-c2c84e222d10@intel.com>
Date: Wed, 11 Sep 2024 15:38:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Add a new IAA device ID on Panther Lake
 family platforms
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20240911204512.1521789-1-fenghua.yu@intel.com>
 <2878ef8c-6ceb-4530-956e-92cc3504f9f3@intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <2878ef8c-6ceb-4530-956e-92cc3504f9f3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH7PR11MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f364f89-7d1c-4da6-88a9-08dcd2b2703c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlBQKzg5L3U1WThYZEM0UlFHTFQvMDBsOW94TGh2VTZwOVhubnRPVkxPRFVj?=
 =?utf-8?B?VVM0b0dTc0tnWXNOVTJ1WlcyY2M1d0M2VEUyK2NBSUhVZ29lUHdONU00WTVm?=
 =?utf-8?B?enlHQ0RTOXQ2L0g2SlY2WkNzSWlaanMwczFkNEFIVThUZVE2MzJJWmszbTVq?=
 =?utf-8?B?RndpZGdSREJwQkpTOFU5UFg0czJwNHFmcCtMMm1qL25veWVmZkE5UFJJdnpM?=
 =?utf-8?B?ZXVGVjMxVlJhM3VyazcwcS9TWlZieE42Y1pnaXJUbkFMbXZtVEYxemcyRGFX?=
 =?utf-8?B?SEtNRXlyTExWb3hvQ09xRGgwOERwK25KV0p2SGYwYnEzQkJMdWQwSC8zUkRV?=
 =?utf-8?B?ck54clFITjQ2K1l4UHVXd2NXK0ErQW1TVzJtdUhOQU5yVXNoWDNPSjBIb0hi?=
 =?utf-8?B?L3YyMDdKczlZVTF3U3B5V0NFMkdqa0dRL0NBajNIaGJLeWsyN0lzUTlGdXNJ?=
 =?utf-8?B?YjFTc1lHblJtNTRlOGxBdWloSTlyVGtCbllVSkVYUVc2OVJqUG44am12OXlY?=
 =?utf-8?B?YnFKSy9aNjR2cy95UXpoYThLblY5TmIxb0ZjRk9rcFhnckZGRFhaZFJSaXJr?=
 =?utf-8?B?UGcxN1pHY3ZvMXZZSUh2WkRXNjJUV05kR1FMeE83N2lpN1llZTVnQzZDbVhi?=
 =?utf-8?B?WkJ2cld0d2trTExpcS9ZbnZYNHJYOVEwZ0V1QWhzOURFK213ZDZuQVhVbnFC?=
 =?utf-8?B?QkM0NEpxdmJ5NjEvcjBGbmRqcldNK3h0blNFWm1abmV1clI5cmVBdkh2MCtp?=
 =?utf-8?B?Y2daekJZUWE0WTNTSE16K2Vab3l3alZwbU5scU5pNjhFby9raDNneTM5TlAy?=
 =?utf-8?B?WUtIUXlRN1RhZ2xUYVJmVzlVV0FkL3Y1RzdrWFNabUh0L0lzazBTaE51RTZ6?=
 =?utf-8?B?KzZyVU12YmNDS3kvak5XczRDV29pOWt1eW9XUTRGNTNxeXhiZW50L1RaU0E2?=
 =?utf-8?B?c01NTDZzV0VWYU1GdnJieHJPay92Y2l3ZjZMNi9pa001VUF0ZVA0VlZQcGsy?=
 =?utf-8?B?ZTJGOEdZT1Qzb1U1SDRDbGJLbW5Jckt4QVl6UldPZStEK2dMdm15TTduV1hP?=
 =?utf-8?B?cW9BcllwTEFoM2gvSGo2TDFSZjVuaG1DZDJueWxhZFc4cGI5VElFMEJxbGEw?=
 =?utf-8?B?cUJtaFU5ZXpkaDJOa2ZuRXd6a0tmemlsVTkybGpBUWVqN01jV0RWU0RybUlh?=
 =?utf-8?B?a2xFek45MmYwRDlXeWVENXdxc3F5Z3FVVjc5RktHQURnd2dUcTJwN0VaZVkz?=
 =?utf-8?B?b1YyQXEra1IrNU1ZQ2x1a0RHU21yMndQdHdYK1p4VUhCWDhpZUxzUGMrL2FC?=
 =?utf-8?B?YnBDbGpLREZKS3pSWFJXUGlSbWwxTEJrR2taY0t2Wm8wNEl5ZW42YnJVTkZB?=
 =?utf-8?B?NUlXRDhVV29DeWxmZWNLbkFUT292Y2JpOFI3WStDZ09HVjRVM2RrUEd2ODN2?=
 =?utf-8?B?ajM5YUhZT2UrNytYSVB6UldJQ1V0NHZZYWI4TlpidFMwR2xycktsK0c0eWxG?=
 =?utf-8?B?cjNIUTh1QnYyMjIraFdZc1JmUUJwMnlJNERIblVCd3NHcEpJOWJoNVNvSVFl?=
 =?utf-8?B?OGkrU3dQenlwYkR0cHNlUExRcnMwZEVMalp1UUo5eXV4Z0VpT3MwVWRobFNv?=
 =?utf-8?B?cTJrRmNsTU9SR09LTUVLTVRFbC92dStOUUJLQlBmSFJuem5jRGVxQTNlQ05j?=
 =?utf-8?B?dEc2bmQ3Y3lWSmQzMFREOWNqSFZGeFhCTnZaWFhkRGluN01qUUd0aHpwaXB5?=
 =?utf-8?B?RG9Nb0pBZkJRODJselRRbFEwK3o2Q2xCUTlTNHNqRnRLOFVINW83Rk1rNDJy?=
 =?utf-8?Q?W7zB2+b/pp6BLVJly0i9TvoOX/WEZs3UPi9u0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJQU0RsdzVxLzVxS3B2RWp6VkxIelJqMDBDMkFiM3lSL2VJczdzazRzaEpX?=
 =?utf-8?B?REpIakdzSXBNU1VrczMrNEtWeThUNG5BK29Jc1lYOUhSUHNsSURSSG00UFV4?=
 =?utf-8?B?ZVRRaCtYK3Y4VWdDSHNvNTR2WGZRUjRUOEFTYjgzU0ZuUnpCZlo5bnRjRzh2?=
 =?utf-8?B?QVp0VnE5VlpXOUxrQkpra3EwQXZUeEZ6REhUdUJoeGRwYVJSNFR2dEJDV0p2?=
 =?utf-8?B?anRnOFEvTVVaZ09OaEJLaUtQYW5xYmNvaUtVZXFnakRzQlpZQmJzQ1FjN0FO?=
 =?utf-8?B?RkhUZ25hVVdTclYxVmJhRFM2Nk9qWUxEVThKTzFWQ1BINW52Q2RHeXlZbHFy?=
 =?utf-8?B?cy9jazF4dk9peHp5c2Y1U3pINk4vdnI2Z08zalRjL2NhWkRCSmtqSWticE5F?=
 =?utf-8?B?bkV6aUhpSVp2bHp0bWgySGdJUkdUQWF0Q0grMXdKT1hRZEhJZ1l5c3pKS0xZ?=
 =?utf-8?B?bUx5RHo2LzJMMDR0a1dRaVZFejJzL2hSRHhOc3pnb2UwUU5BZWJVUlpaVk55?=
 =?utf-8?B?MVNCd2E3R3FQdmxPMlRpTHBHQlhlMDhaNDJkQkVKSkh5SkgzZzY0dzVBTzdS?=
 =?utf-8?B?bnFvcjZMTXA2d3cyNlFwMzFSZVJQYnNkdlN0WlFpWThpVG9EeWNWTm1LelhL?=
 =?utf-8?B?SW9NeEUrK0xhb0cwYnFWVEt6ZUV4UlowRm1RbEEyc1l3c3ZQK3RJNjBLY0tn?=
 =?utf-8?B?amRKSHhrMDZYVG90RHk2K1FONGd4azg2WlBwOVJCUUw5S2xoalVvU2ZHakNF?=
 =?utf-8?B?WmFJN3RkamRIREtOYVBVanlqcVJ5LzR6VVVKcFVGeXc1MEF2QXFmd3JPMysr?=
 =?utf-8?B?ZWU5d280TklvN2tJZkQ5eVpTK3NtN0pyc0JwRGxXZDBzZHFNajRCbUFJM2hZ?=
 =?utf-8?B?Qmgvd2l1LzV5QVRWVHRSdlBFM0pHNVdSZWxrR2hXK3p0Ylg1OE04dXN2UzF6?=
 =?utf-8?B?c1lPay9jQWtuWUZ4ZEgrd2pnNXN4SWFDV1NnbEdacHBMRDJkSmZzK1pZR0po?=
 =?utf-8?B?a0F5d0tqS1pFQjJsZVlycHRVaTJhL1F6eEhCVVR0VkZlc2pmRVFnd1NkM3d0?=
 =?utf-8?B?bmgwNjI1Zk5EWlRTYi9vNnhXb0RFM2daM1YySldZa3loMThHTm4razRjcC9P?=
 =?utf-8?B?TEZsOFdiOWE2RzdiLzJKWm1QaWYveGRLRXFpSzNMZStKY01idkZ0U1M1am9k?=
 =?utf-8?B?WFpwazAzMjY4OEpLelNiN0hmOWVIei9Zb0RPNUVZV1dRTHhiaENqOW9iQ3RY?=
 =?utf-8?B?YzhVNnVoNGZMYWZ6UmFrVzZEbFB1RHB6YWlnOWpBTVk3N0tYTzhRc1FINFIx?=
 =?utf-8?B?SkFweUcyaGxEQXh1cmVMajRsVlNjUk1WYW9wQUkvVXlqQm1TUGVxVWhkSU1Q?=
 =?utf-8?B?amtuVzhLVjhuMkFwQzdFeHYvZFlpRThLQ0gxdEFoZ0o2VEwzMWhQbnVQaUZG?=
 =?utf-8?B?Q01aaTZBTGpydllUV1lYRk1tN0NML3pFUm1tMUloeVVtS1VSN2dOMXM5b1F4?=
 =?utf-8?B?cWszRWFSMkRGTkxPbzhzM0QrbitHcGRhRExzQXNwc09tNlA4YldjbTBuc0pF?=
 =?utf-8?B?dDJobDMvaUE2SlZ3WldSc1NWcDJibHltclhJV2hzZnhqVXhJSHYxcytkRXFj?=
 =?utf-8?B?eXZtaThkWERiS0NnMmU4Wmo5Z3dGd25adk1EMlU2N2tsdE5lWXI3K1FHRGt0?=
 =?utf-8?B?ak9Fd0M2a1dIc0Y4K0w1QkZTQUMvMEFhZmhFa210SW8vaUU3cXFvOThnZXFC?=
 =?utf-8?B?M1JBQ3d3OFZNdnRGaGs1ckZ2OFQwNkkvSWQ5eWVpOFJsN25VdndyemVLWE0x?=
 =?utf-8?B?TERtcHVPdEZYcStyVlRGYndQVDV4UUYyakZVcGQyLzhBSTdBaVRPL2Z1U0pL?=
 =?utf-8?B?QVBPVldwdmMvZ0IzQWJSMG5zTmRqdFRVNHRCY0U5cUhOeUhGbmhFODJydk1r?=
 =?utf-8?B?OEs4TzJxak1TbkJSN3dUREF4T293QlFVREVZS25HYjMxN29ub2szQU5lYjMw?=
 =?utf-8?B?ZkhHV1o2d2ZGUDlLcUJmeFc5dzVYdDdUdC9PTXJtOVdJUFFDVTFWK1ZueEVR?=
 =?utf-8?B?ZmRTUVJqb3FmTVhGTk1FbEhsODFoVFVlNU5JNTNkYkNQelBTVDNrcGNRd0R0?=
 =?utf-8?Q?NzZxagmyxuiSujDxBHEJIYG1S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f364f89-7d1c-4da6-88a9-08dcd2b2703c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 22:38:21.0421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ump6WhcogkTAtYzoOK+y7yC+8j7NepK92bQTzMz7rTLACXMMY1QSkZuFFK7E8eoSoT2lDY1Q7DGfoE5coyxS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6793
X-OriginatorOrg: intel.com



On 9/11/24 13:58, Dave Jiang wrote:
> 
> 
> On 9/11/24 1:45 PM, Fenghua Yu wrote:
>> A new IAA device ID, 0xb02d, is introduced across all Panther Lake family
>> platforms. Add the device ID to the IDXD driver.
>>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> ---
>> Hi, Vinod,
>>
>> This patch is applied cleanly on the next branch in the dmaengine repo.
>>
>> The next branch already includes a few new DSA/IAA device IDs in IDXD
>> driver.
>>
>> Please check the patches and the reasons why the new IDs should be added:
>> https://lore.kernel.org/lkml/20240828233401.186007-1-fenghua.yu@intel.com/
>>
>>   drivers/dma/idxd/init.c | 2 ++
>>   include/linux/pci_ids.h | 1 +
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index 0f693b27879c..3ae494a7a706 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -78,6 +78,8 @@ static struct pci_device_id idxd_pci_tbl[] = {
>>   	{ PCI_DEVICE_DATA(INTEL, IAX_SPR0, &idxd_driver_data[IDXD_TYPE_IAX]) },
>>   	/* IAA on DMR platforms */
>>   	{ PCI_DEVICE_DATA(INTEL, IAA_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },
>> +	/* IAX PTL platforms */
>> +	{ PCI_DEVICE_DATA(INTEL, IAX_PTL, &idxd_driver_data[IDXD_TYPE_IAX]) },
> 
> Use IAA going forward?
Will fix it in v2.

> 
>>   	{ 0, }
>>   };
>>   MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 8139231d0e86..e598d6ff58bf 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -3117,6 +3117,7 @@
>>   #define PCI_DEVICE_ID_INTEL_HDA_CNL_H	0xa348
>>   #define PCI_DEVICE_ID_INTEL_HDA_CML_S	0xa3f0
>>   #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
>> +#define PCI_DEVICE_ID_INTEL_IAX_PTL	0xb02d
> 
> What is using this devid beyond the driver that needs pci_ids.h addition?

No other usage beyond the driver. Will move it inside the driver.

> 
>>   #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
>>   #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
>>   #define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428

Thanks.

-Fenghua

