Return-Path: <dmaengine+bounces-5282-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A6CAC86E0
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 05:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AFD37AEE21
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 03:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2E19004A;
	Fri, 30 May 2025 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3iBmwwk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6AF7260A;
	Fri, 30 May 2025 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748574419; cv=fail; b=HAwJczprgDViVPIXRTJ8Q5Kcc+51w83XzE2oOuwPvT7SSMZs9WCTjpydaGV/+3axO9I5211RZ8vpsAPoaweX+yrwfM+HdGJ4lpVjBfu1ZPSfwCglw3o1ekNUGNJg/iE8XxP8W/sFIJ/btsv5P1+nESi0KMFrIJYgoZfXVMYUr6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748574419; c=relaxed/simple;
	bh=cCHCMCluoQ8MLnGbL6m1n7QMGqwwtjS9xz7Ub+J0I2c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D7EmFP+3B07Nz6ANNIPY0hCIfCheJTzuN9khvNoGmYgFlCizOh0n0xasftmaYQfDsccuK7zCNg9AxBRhe6LpB6DwyZ1B2UZQR7vDAHmJ9WPHLvudAvqTXu2KgBzKZRPnVp5yemngT2eQzBakJdXPl9jrq0H3yx5rhj8lj+yEnE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k3iBmwwk; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748574418; x=1780110418;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cCHCMCluoQ8MLnGbL6m1n7QMGqwwtjS9xz7Ub+J0I2c=;
  b=k3iBmwwkl31Q58yO3caysXJE7cL32DIudQ9BzKoWFgENqxGbLQeza4a4
   hbvxOJGF0YVqVd/CO+bVDUx0DFG0BZJWISjLcSgZGCyz61Q94Wgf88+zA
   O+aMtRXfbL3FSyQTjArNh7Z7Ibyh7Rmms1BnUAb9qTfD1EisP/hFsmh7Z
   Z0uLYuVcxjBfOy2p/2Uozt07dS8ojg0xg7gAEyUGtf35qaaYr0JYDIIkS
   lwFeWyqUOeiLq3rQvTz800+aYP/5+ivSZpVM0kjbwuqWwSB4zgxEzvFMb
   YSyut0yoJLK7/cD8sDPqHLxyGnR5vsJAB+FqTav2u8V06JSL+6H/aNywj
   w==;
X-CSE-ConnectionGUID: VWB/edRDRH+n1jq3pXIjsQ==
X-CSE-MsgGUID: 1FTYJ3dnQcKkSdYPyl3keg==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="49902826"
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="49902826"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 20:06:58 -0700
X-CSE-ConnectionGUID: EUOFwO9LTeeb5hQGRGmgKg==
X-CSE-MsgGUID: xEwgLv5KQnuCFUuy4A1wXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="148780048"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 20:06:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 20:06:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 20:06:57 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.89)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 20:06:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv/qm4uLpVqUNa2MRtkvjV7rT5BitY/gK2G8KUXD0FYenMaQzCAV5LGsky2ePdYKSGIdtbNS7J25xAF7XYpk0JeeYRjD7IaHSSmoU4x0qvh37NmM3o3s71lyU3fMkV+nIGSiDMKsCfjaXKN+cx6dvPg79nktWVUcQdkjpzI5cng33JjcNfvj3KBV28kpPfJT1l0jaPPS/ejyF1LohW1sRMKDhx2Q55sDV2Xwdp92+5d5MrVogE5d4l/thoMjQYNdO7xiozSicoWCnGeQEBkxmt5bE/YtXAulDnOMobrH45HEvmbizYnn/ul6tlhxZC99KGx0MjStam0CvlsuVUdhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLaBeMzIvj+nSHb8RMr+IKR3MY/PfqvkMHRlKc2o50g=;
 b=T3YwNn7Vrt9f9Mvg4e/vIdrtG6Z1Zblw+tZjmJQGt4/5zQG2oVjJsI40cP2vEc5Q6SnQCQ9xEBO/9jpKYz4ID4eT7zvzHF3IjF++vxd8IolkYVe5R1LY2rP1iOmnkDiB/uTIKen54X+NIR96pZZIKdIW/5n0f+HPPd0SdryAxUt1RchWt9ovA0t5+ztQFpOv/qca1P13eRjoK5NhJATQUim3eyT1l8VNPCnx4Tvcy/8jXFk5U/uptgo74m3rJNqUADz3PJ8BmWT1kxeeQtG8Zr0tE6jaOO6wJuz7z0B6GMbpDfw0AeMb5KPr1/J4UHXnn7OBwbUA5zMG233AXEs0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by DM3PPFE9E88246B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Fri, 30 May
 2025 03:06:55 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 03:06:55 +0000
Date: Fri, 30 May 2025 11:06:44 +0800
From: Yi Sun <yi.sun@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
CC: <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <xueshuai@linux.alibaba.com>,
	<gordon.jin@intel.com>
Subject: Re: [PATCH 2/2] dmaengine: idxd: Fix refcount underflow on module
 unload
Message-ID: <aDkgxCsCtsEugTdI@ysun46-mobl.ccr.corp.intel.com>
References: <20250529153431.1160067-1-yi.sun@intel.com>
 <20250529153431.1160067-2-yi.sun@intel.com>
 <87msav9wm6.fsf@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <87msav9wm6.fsf@intel.com>
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|DM3PPFE9E88246B:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a685354-fde1-4e67-f9f1-08dd9f27084c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qzh6R3pwNFA5UE80OGd3VHdaN2hBSXEzeFZVNmZWUlU1SmNzSGs1WVdxcXRR?=
 =?utf-8?B?NFFxN3hFQ2l1aWZXKzYwNys3WlZPKzhYTmF3bnJxK0IxNXdlVzRhcytQMGV6?=
 =?utf-8?B?MllYYi84YU84YXlCengrRkpCMXZ6YW1kY2xYSWdmRlQvaXNWdXF5WTRhb1o0?=
 =?utf-8?B?Qk1rMFptaEtoVkMwQkM1UXpOSGZzSU1Mem5OVGVDb25BdjlJVUdtOGxLUXNM?=
 =?utf-8?B?bytEdS8vTHk2MDVkVWNXMG1zWmxIWmFZckQveHFsb0o0citnNWJVeURENmVy?=
 =?utf-8?B?OGNpRDZPRnZ0TG5XUElDbzhTVENiYU9FaFpDTktxbUxWb0tDUklLNEYxaGpP?=
 =?utf-8?B?TlFRZ1lrZGZUbkxFZU83eDBiYjl0UVRvOEt3ajZrTlg2LzloOHcxanpCQXBV?=
 =?utf-8?B?a1lBbEU0WXQ3NlpOZkpxM3ljcFdQcG5mY21hdUp3RWF5Wmk0OGNndVdxYzcw?=
 =?utf-8?B?ZU9BcVJMRi82Z2FiY2lFZTNaUWtTdmJHSXhFYjB6MzE0b0dzdnFKSlJMUVpW?=
 =?utf-8?B?cGJHczB2Y3kxTFRWWjZkczBycnpqR3NXZzFGbS81NzNqTThuZ3BpOVpwYWRn?=
 =?utf-8?B?Mk9xWTFMRExTWnpCblNLazV6NW5mYmpnQm5VLzBZMjhDdFdTZlYraUVLMjNo?=
 =?utf-8?B?UlhCUnFuaUt0UFpFb0ExRU42NzdUNDh5S0JLa0JsUnVRUStoaU44UTRzZ0JW?=
 =?utf-8?B?QkN1QzFYM0ZxYzJwQUROZTdzS0RCMHZzQ20wc0RMcldSWWtUVmUyTW1USGtv?=
 =?utf-8?B?d0VHWk54SDRBMTNEcGhuN1ZqT2VSUTN6anFOKzZuVERYUWJnbHordTFISTFq?=
 =?utf-8?B?azliRVhVbkpQQ2hMUjJzYU04MVpLZ2liSDNEeitIWTJNNG9ZS1dST2tBNG1y?=
 =?utf-8?B?YnJxZExFS24zOFNVUE02VkFXaE5hUnV2dmxTb1F6Tm1Da3dFQ2FPVzRBekF2?=
 =?utf-8?B?MU40THRFQmdNTUt4a3RyckpsZDd4V2tZQ2JWKzRoV0tscXl4N0JQdUEvb2FC?=
 =?utf-8?B?RDRZUTJ6VjVtOUY2YnQ2T2tud25XMUlRNUw4bk9ZQU9Ycy85cTdlOWR6SEky?=
 =?utf-8?B?bmI0UGFRelRJa2pma2ZjUGlQUDBJR0Y3clFRU0hUeXZJeG5iSTdVSEFIU0VR?=
 =?utf-8?B?MVlhcUdoZThKM3YzS3NFUU53WU9FbUkrb1JOUWJGOEdsMXNseUUzbEQvSHg4?=
 =?utf-8?B?S0xjUmtpeTNDTkNOcnd1YWhVN3d3S0d6SlFRYlJlYldNcEh4WWNmZjRXam9O?=
 =?utf-8?B?K29hTjE2OVNiaUthRk1iNWxhNlBoR0dodk1ENnVHL1NnR3h4ZGgvT2tpZ0hw?=
 =?utf-8?B?K0E0OWhGRGZVc0Fpa2lYaVJuT3JqbGRtc3M3Y1BtK2xncE5kaEpoZHE4MWhF?=
 =?utf-8?B?M29mbEtVV09FMGJpUDhZQ1Vyc2h6ZGoxR3Q5ZzR1WVlzdCtkRnZ0V05sMjRn?=
 =?utf-8?B?RWx0M1JxODFYUWE3TmR5b2dndS9GVjNDN2JEZk1EdHZNSHZ1MFNDQ0dEZno5?=
 =?utf-8?B?N2JoNVFVdXpCQjVzYU44SGRPUHpqenBRSjJDYzdrcE9zNXJ0WllQSWNDQm5q?=
 =?utf-8?B?TWJJVUNGNUUvLzBkL0dybVV1Rk5zcmxOOGZiL01pdk0yc00zQzBxdmRhK0lT?=
 =?utf-8?B?Mzhmdm0vb1ZJNEp3YnhMQ0lmbWxrendBRnNhWnVTQUtvaUJMNURHZlh5UGFO?=
 =?utf-8?B?ZHhuMVl0SWp6RUZKMklTQSs3RWFzOHhjSTdtT2o1MmxBbHFXQk8wdWFjZ2JU?=
 =?utf-8?B?U2ZkTEo0REx0TVpScE9yUy9KUzB6RCtkVmY3VGpQdmhFWVZNWXZSSnhsZHZZ?=
 =?utf-8?B?Vms1dlBpV3U0SjJ4SmJwMDM2bXVUbEI4VThoT3NPQXhNVWNRQjlrVGw5Z01J?=
 =?utf-8?B?alRUZUl3dlAzTHFrQ1JGL3Q4RGhEOXVYL2JyRHVDMHJHRHpKUmtFTnRIUi90?=
 =?utf-8?Q?eLUua7KsFG8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnhDejdvbi91WFhrczFyZW1jd0lhV2F3cVgxSVBGZ1JucXZhTWRwSjljcUVW?=
 =?utf-8?B?MldBQmJ1UXJ2QTZOK3RNUFBLZ1daank2cjg2NEtiNUZ4bDN5eEFadXhqU0Fj?=
 =?utf-8?B?OFZPdWVJSWZ3am83SU9wODd0V3FPZGo5VzJCN004K1cyNFpIejRYS2wrZm13?=
 =?utf-8?B?bXFsTmgyc3g3NGVRM3hheGxCRUVXMmRNS0x6clZ5dzVMUTFwdS94ZnljZ1Vu?=
 =?utf-8?B?Y2txMjlnNUVLdnJTSVZyN3UwN1lmVlFVTGNuYkNqNm1KOGg2YlZYSG9vSjFD?=
 =?utf-8?B?WjRvczFDejNPekZOaHFINHBtTkpsVXZvcXFBakJKaGFRdHlsaXZrdjVJTEhH?=
 =?utf-8?B?bnhPZnZrSFBTeHdkN1dpRzRwTnhJKy9pOTVlYW55U2N5dzNJSEFLbXBydW9l?=
 =?utf-8?B?UXNyYkZlZWZ5UmdrMTlhZ2ZYck5haGhFUlRVZWVvbGVtV1luVU43MTMwQmdm?=
 =?utf-8?B?TTM2bHgya3dtbEdnRlRSeDJhMENpTjNiZzFPejNvNGdVNFFYNVZCTUZDL2gx?=
 =?utf-8?B?MkZiZFBha2ZKWm1CMnVkNERQUEpjNnlOMW5SVmRVVTY2WWovci81cDRCS3pL?=
 =?utf-8?B?SjhEYXRTMUhZU1NEVithSTNCeEMyNFZ0KzBhYm1WSFI3U1FGd29FbEdwZFpv?=
 =?utf-8?B?a01RSlpTQXJDSlhOMEtyakdBanE0YzdDWmVSMnNBc0hBRVQxVnU4VlloTHRn?=
 =?utf-8?B?NDRGbmwzeW9KNUd6L1ZtSlRLSXAwTTZWa3pZZlowajlRbU5mUVRtTkNpUjd6?=
 =?utf-8?B?aDNhWjJ5bW9MUXpGWlZqZ3JFRm11VGNRZE1UV0FzczhUYjNlTWFmSlNTYVlD?=
 =?utf-8?B?MmNUNDl1c2FiVGFJSU9JcGhTTVk1OUZxMHJ2eDlUZjlwQXNiTzZxb242RTBC?=
 =?utf-8?B?eHBRaVZFekVvYko3UEwrZ1cyd3RpeG5wdXZWOGU3cjhiakNhK3lWY0Rmelg0?=
 =?utf-8?B?dm5rZ2RVT3hWanN6aFMyNG9UZGlTU1FSZUJwd2dMMGxBZWkyWnhoUnREcWNq?=
 =?utf-8?B?YU9yWlEyR1lWTWZOeEtncU52ZjlzTzFaMXZpWWwxQ281NWQxdTM1aTZuRldz?=
 =?utf-8?B?YmhBVTNVbGRJcit0WktsQ25lbnc0ZWxDWFdxZTZtRklXRXFTWEdsZzh2TEZw?=
 =?utf-8?B?YnRtSDVtUXViNkIxR1Y2SmZVS3REeVNRaEtDN3VmK1pZQjhNR0ozOHZaeUJ2?=
 =?utf-8?B?cUVqYzFjZ3RacjJJNmpRTGhnRnBBUnVPZ2hRWTFOeVYzTW8wdWh1Y2VtMUNV?=
 =?utf-8?B?NVhWWURTL2tlc0Jzd1RwYWQ5cUExQmE5d2U5cFVtS2FSMlBLVTRPSmVWZTF0?=
 =?utf-8?B?ekx0Q2kzU29lRFRleWRReTJlZ1hobVd3TjBEc0o4U2RUS3lVS0Q3cDk0QXdW?=
 =?utf-8?B?NFFrRzJJTTdQYzBTY1ltWjZmeXViWDZQeVcwR3dCNTJiODZ3K0JQUWRUL0Nx?=
 =?utf-8?B?S0hNQUZtMW5NVUQvN2xIUHZ6WTZvbEdvY3d6dW9iQy9rTGN5MUZTenNHQ2tr?=
 =?utf-8?B?VlRmUzdaQml4UTVQR1NsbVFOWjR2bEVhclBUWVRvUWhoTnFRVzQ3a1UxZnJC?=
 =?utf-8?B?ckd2d1dvN3BaWUxxN3VBOFdoN2dpYUthMjN1MmRFRFg1VzdFLzhHUVQ2Q25k?=
 =?utf-8?B?WkhiTitpbnVTOC9RWVAyTXhtWmlQdkwrdUVwVDcyMXc1Mk9QdlI0R284V2Q0?=
 =?utf-8?B?TU9ZUFkrNTUxSE53Uk16ai9MWXZLK1A2SVdXMXlsRWY4RTY5RXdFY0VQdU95?=
 =?utf-8?B?MFZvMkpjYys0TjA0R3pub2F5NVhGZzBxMnZQYU0wbS9xM1d3alFNTDhVU1Jm?=
 =?utf-8?B?WEFFL3pDL0dhM0s5V0dTVWxpMkRhSk0rUzRnT0V2alBaOTlVYmY4Umx0ZnpY?=
 =?utf-8?B?bnA1a1lkNTJubTJwTFY5YlNrWE1DTFlZRHhDSXJjUDV6Tm9yOW1mR0FDeEZY?=
 =?utf-8?B?aEtEcFBMYXAxc0FWb3ZPOE9tZTgxMncveVBvMllyOS92a1FwT0VPY1VhVW9H?=
 =?utf-8?B?S1FkcDUzUUV2bXpsbTU0ZXFzdFVMcWdNY1dNbzZKSVZpRlV4aS9Pd0E5b2Ru?=
 =?utf-8?B?Tk55djRYWC9vYTV5T2p2R294Y1ZmZGJQNUNZN0MwNlNZNHdqblEvMHNXdVdy?=
 =?utf-8?Q?QzgoziwrHRx3UgwubvseYQ28G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a685354-fde1-4e67-f9f1-08dd9f27084c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 03:06:54.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEVzpEnj4yzB8t/1ic4re1G7YwvNPxqKoyq0SyejyuPU94KRlxmzvtrrbR2cPXNDRxykktOEWeVH3q4CK/ag1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE9E88246B
X-OriginatorOrg: intel.com

On 29.05.2025 10:04, Vinicius Costa Gomes wrote:
>Yi Sun <yi.sun@intel.com> writes:
>
>> A recent refactor introduced a misplaced put_device() call, resulting in
>> reference count underflow when the module is unloaded.
>>
>> Expand the idxd_cleanup() function to handle proper cleanup, and remove
>> idxd_cleanup_internals() as it was not part of the driver unload path.
>>
>
>'idxd_cleanup_internals()' frees a bunch of stuff. I would expect an
>explanation of when those things are being free'd now that removed that
>call.
>

I believe the call to idxd_unregister_devices(), which is invoked at the
very beginning of idxd_remove(), already takes care of the necessary
put_device() through the following call path:
idxd_unregister_devices() -> device_unregister() -> put_device()

Therefore, there's no need to add additional put_device() calls for idxd
groups, engines, or workqueues. While the commit message for a409e919ca3
states: "Note, this also fixes the missing put_device() for idxd groups,
engines, and wqs."
it appears that no such omission actually existed, this part of the flow
was already correctly handled.

Moreover, this refcount underflow issue appears to be a a clear
regression. Prior to this commit, idxd_cleanup_internals() was not part of
the driver unload path. The commit did not provide a strong justification
for calling idxd_cleanup_internals() within idxd_cleanup().

For reference, the both two related bugs produce nearly identical call
traces, and I think both are blocking issues.

Thanks
    --Sun, Yi

