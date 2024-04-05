Return-Path: <dmaengine+bounces-1745-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DF89A55F
	for <lists+dmaengine@lfdr.de>; Fri,  5 Apr 2024 22:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BED1F23150
	for <lists+dmaengine@lfdr.de>; Fri,  5 Apr 2024 20:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597817334B;
	Fri,  5 Apr 2024 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bm9fW/+P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7530C173328;
	Fri,  5 Apr 2024 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347526; cv=fail; b=bgsCcWuygO6pOn37fi8Dy1ku1KE2iWEU5xP0l0ZB0hcSbEDUIoZ0+I5EbFAT5VAYK9hDg0GnclTAxPBEmoTxb0rMwHhlxM62UjZOqalwfoY+ephq3meSjR3hhq7gf1442hEaIrDrQy11kP3C14ZT860g4ETY7rsghsbmeK/5E28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347526; c=relaxed/simple;
	bh=FcWIPXFpGRpOIyz9W4cQuTCYekeDTrx5M7mdUktVKUs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AYfmgWXVqXKgOiyVD9KaDRxIR5BTQZLH0xodZq43h5iz5gBijIFmA1r7Y8faw2irc776zgqkDGltZd4Ap65GpTc9lcS3WJlCkSgx4Ae8Q0W/OYv53V2QL5LsBnyqEF37HZy51a+aSHHuswgsllVlIVLEyqzvO5Qx5RS4Wmz6gP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bm9fW/+P; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712347524; x=1743883524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FcWIPXFpGRpOIyz9W4cQuTCYekeDTrx5M7mdUktVKUs=;
  b=Bm9fW/+PqRMIt/UKEgDxiEh+QbXGz8axloDsHK1WavmLL+wB7vunF9BS
   nTJ5LOTJ7c3JbI19jPe3NmxPyf1CUQFmQxGbCLgsgadLjpct1qkcLJ8h4
   EzrHfH3vbvx+lT/DUlAEECFWq5u6luxo+0hAeqPJf3JlPXQMCzaZxNCXC
   aDsgH8LimsFG1rQQOwkyNhEURk7wEosxxjm/jDn7JCKOoiCNWWugPpCZk
   Msh+X8iw85YZUjMD+754Iu7qtcoYz+npza8Wd0i0KbWF6DRbUxP0lA3v2
   MVCbbyfnc2pduVANY9HTu5WXsTq0+6xIQK3ZSiJsfFODObxL6rPT5m5jo
   w==;
X-CSE-ConnectionGUID: 4I2PoasZR2KNdCvXhfx64w==
X-CSE-MsgGUID: fxHpRoIWRPO/9H2wS0hUVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="11486746"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="11486746"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 13:05:23 -0700
X-CSE-ConnectionGUID: 4luq+uH/TvqQWM7CgH2mJg==
X-CSE-MsgGUID: Nvq+AvfUTCSCUkMJl0Ky2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19291434"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 13:05:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 13:05:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 13:05:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 13:05:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu1rugHfqPRDer66Mepi4jecGY4cXCVgbAdgBoEnzalLKxugkJD10hdM/klOZHa/3M3UlwF9AYT1khJcf6WOcRODLuvuYe49GAyCeWEmjesaxP6ovOxmSygFrl2gYwRNAETuaAjhY+1sv/vSCMuadR/OkQZC08JsfCATKX7ZCXVMeAjgpWjqu+xrHtbtZVVkcH/LIsMCwGqODi2bUD27UgdfFS3XHkH2P+Yct+hbnvr6w2xUKqC8xe0GlyXGtArYDSoommRZ/VBz6e18iSqac8s8A4XkMSqfI0ximr1DwycPpT4/GBP4G6wEi3bNneJ2JmOOGGhUUky6VnX+RtZBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAc0BvLlLnKNQ1Id8rVs/6P/5ITKJR0g+qm+2sgY4ak=;
 b=JwBViWRLo+W6O4ZpZZ7Yp9tFp94v8S9o5rIR/Yx79lGmZcWcSZSWc5P0eGJmwOBYz9yKYV4XmASMM+aByF8pJdcgHqDGZBpG/+eDSzuiRP7pRv4+dadQP65I7Za3WM9yUNZTbTPtqKIQ7AR9ceJ+HCPzjyUnA8sah5TGBralXyyetji2j7BDwb5xVV4E9tgzrzeH6XjQqH7Nu8EKOQLlqF3VxkdA7gKEB0iRafaOeL//o/QnOaoQ1GPPz33MdrwHe+9wxvgOuEJWtDxGmpmMZ0lX8D3ruUGVnn09Rc1lxa9dIQtQ5r0pIFqzaTwRjNnH2QvMdtieBZchX1uVrz4cNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA2PR11MB4985.namprd11.prod.outlook.com (2603:10b6:806:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 5 Apr
 2024 20:05:20 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 20:05:20 +0000
Message-ID: <20666f18-7762-7e26-64e0-5cb7adc46548@intel.com>
Date: Fri, 5 Apr 2024 13:05:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Check for driver name match before sva
 user feature
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>, Dave Jiang <dave.jiang@intel.com>
CC: Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240403050710.2874197-1-jsnitsel@redhat.com>
 <9a07a658-dbd4-47e5-bc36-598a456fceca@intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <9a07a658-dbd4-47e5-bc36-598a456fceca@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA2PR11MB4985:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuGQW6UeCL2Ma4D/v5giXXlbSkugDZOHnSd8OXIldclSgh3mf5M6VIOdV/WWlHZLrsEr8K3lf2yNXxldK7BUsgAoLXEuEL/sSnfzaGVyHY/IvjXrBbQWQmx0bAOEPa9XL9efGMwrZIgmH98lP7ZlzTxqsBvGu+GnSU6CPqxbv+rtNblA7REkWFMz/XC7dnN0r1k7HeKwRj4dOgjPSIPzXlR6xdZm4icsljl3XI3b/pOmQAGgFEXkwtqDboepJjwNWaJJXVuJiMZFOi04OUQ95FPh+k5f47TnKlXyll1h5/MveNfQyd+4PQW9PdFdIadTHDeVu8PvnXQVcveRmpQUNSs0XewSPDMmJEQ4HkK7zE2H2qh4ehXUsO9Mv4BZhytsJN8+qplBqGUkTscXJ0pWTdH08k+9RwPwOkOV+Oam6QQK9l69HBJdHnzqyOfKjwA7f5BIXhFxZ3kMD73GMAfbEAnXpVrfc4U/eg2SlWOJ0bMZFyAC9Y6n2Oe9+NoPnjyfWQDLQgeSsFutq9hIiujXV8xyU7HOL0N0FhKIV1nj/66ggN23kej5W8vFwXLHkHGNr+LblRcHO0JzrsRMp2HA4tQqNBDwVpfgameN95G/HMhJvacqj2Ryg5Zn8jdREsI3Awfi4o98ptBcBi2wsJQnn9PKb5jG6v7tiJguTb+YaJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkk5SXBtR0djRG95dGk1RHM0N2M1Qm01UVA4enVicHk3RDlMMGlBR1hpNlk1?=
 =?utf-8?B?UW1EOWZvbXBXZlpYSXJUanUzY2NIVFlMYk5CSlU5Ri81RXkwQUg0ejQrc1h0?=
 =?utf-8?B?aXJDT09OSSsrM3pmMGdvREZrSTZVRngxczFzRStzSVA5RjNGSVBkWlBSL0Nn?=
 =?utf-8?B?N05KUVdocGxLMUZSTG5tbXJoOWIvY3FLQkV1S0JrcDlIOVJMN3NhQnhYWjVU?=
 =?utf-8?B?SG9UQzF0UDRtSWI5dm1wWktoZFhJY1AvTDhqQ3FTUk5zMlFqTHFEWDlzNlBN?=
 =?utf-8?B?VzR1NzZTdG44QjRNOFkwQTF1SFNyNzdleEFVZFJueCsvOFpKNW02THNCMWxZ?=
 =?utf-8?B?V0QvN1B2WUQ1ZDJ4UlB3dTlGcmRid0V5S3NWT3ZrM3ZFRnF5cU4veFZUV2kz?=
 =?utf-8?B?U2QrMTRiK2tRY0VhY3ovV2k1azVLSTY4dDJrcEU2SWQ2RFpEaGlrL0xlUVJk?=
 =?utf-8?B?RkM3RlhXK09jUEZUNjlSdjg2aE8rcDhmK1dZVDV4MENuN1lmVmVTUC9DUE9F?=
 =?utf-8?B?Uk52b2xXNndRalAzNXUvTjF4c3VuVW1UTml5dEpTRm9VUnRSTzJDU0cxeHlz?=
 =?utf-8?B?dXZ6WGZ1cTY2b2s2Q05samo4bW1nOXRrUzFvNG5YYVhQbll2L0NVTTlNMGZa?=
 =?utf-8?B?OWlUaGtNenVTM0V5OEN3V2RoWHpmSXhidXprY0Z3NXpQSXpVRkZlQWt5UHJ5?=
 =?utf-8?B?K0xNdTVWUUtPaTUrMDY5MEEwMU9tUW5qY2M4U2tIL1MweWl4alZiSkszMXRB?=
 =?utf-8?B?R1ZweGZnL3R2TndYMytjTmxyY25PM3JYUGRCUG90Wis3WEkyNUF4MDQ3RzJx?=
 =?utf-8?B?bjQ1VG9FRTVEODdFMnBJSDRqQjg0VEpWWkJTZCtjQVNzME9OR0FtOWIrUVJW?=
 =?utf-8?B?TkFQSEVZY3dsM3B0bDJQQTA3TnRkSFdFazFnV01CdFNPK2RhV01UWDNTV2ky?=
 =?utf-8?B?T2hkNkxmR2J2S1NIWWxKc3czSlJqNVFlRlc3N2NPTlk4bS9adVRJYnFMRUhk?=
 =?utf-8?B?cnJMVDAzRmNWdGRMaUF6YnZFOFMxZnlhN0pocHJaMXlRTGh6a25ERDIxS2xO?=
 =?utf-8?B?Yjh2Vk5xUlovZmxORlZINEpmYzRvcnVGYXR0bzcxL0JsQXAvRGROM3R4WWdG?=
 =?utf-8?B?WDUvQ2NGS0ZQUkhXL1NGV1ViZjg5RUsralhBN3ZQdVNGN0JGVVJ2STlYck9a?=
 =?utf-8?B?SUtENFBENkRGdmtrcTQyOEFSSy93bmx6WU1HTDMrVmVoemw1TWlOemFPTGYr?=
 =?utf-8?B?dzBIcWF6N3lReGFSVTJmMzVUc0Y2YzRYWWlETDV2aUYrSk9xRXJqUnd4NXZC?=
 =?utf-8?B?d01kK2dObWQ3VFdHaU5yam82d3VLOUFZRW42aTFKODZuRnlyWE0vajUyVU5z?=
 =?utf-8?B?eENhQUVMWE9iSG85SWhiOXcySmkyU3JjNldBUlJxU1JWZVkvUmpma2R5QVpx?=
 =?utf-8?B?WmRhSDM2ZE5uenlsV3VWRUlFSEZRdkc3TVBmOEQxSkNDYUlxY3Z5bS9ZbENh?=
 =?utf-8?B?RVJVNE1sd3dIN0hSUnVubk9Lbi9iVDdkZTM3QURNQ0FPUVlrNEdJMW8wYXQx?=
 =?utf-8?B?aW1YQy8vazR1cHYxbE5vOFBBOVhlUFhKaWFKZTBWRVUrTG0rYWY2S0RSS0JW?=
 =?utf-8?B?dW1FbEorRGdLNkpHOHpuSjBWUkszZ08rRUREQ1RRNWx4UytRdlFTRzQrV1FR?=
 =?utf-8?B?SkswZUtHa2JtR1Z6NDhDcjZCZGV6QnlqQmU5MTJPeUpSUVpZNDVLQlpmRDRq?=
 =?utf-8?B?SHJPQ05TYzhmSWF5czcwdU1oK3RUbVhZbkNxVjlKcXNWMHdGenA4OEQwOGp6?=
 =?utf-8?B?WVNyWU9FaE1Ob2hVTzdlb0FTUlE0dmlldGgzM0hWS04vYnNoWEdON2EyL0Yw?=
 =?utf-8?B?bTFrME5TRGZsZXdENnlzM2lsMWEvM3NHb2dDTWxlcjZkMEtyZlE2dGY3Tm0w?=
 =?utf-8?B?aXZFemNaaGdPRGxsQ2hTWmk2Rm13ZW1KNTJYOHAxbUg5amY0OGwyVUtic3pv?=
 =?utf-8?B?ZzJGam1yZDZabEFVTGIrMFVXM05UaDVlSjByTU9UK1VqQ0dmd3lCTTBOT282?=
 =?utf-8?B?V2dqYm5laEdxU1EvTFNheG1wcHhCdHRCZ1N2dEFla3Y1ZjRJVHlsUzFMZWRG?=
 =?utf-8?Q?lvJbo2zRh1eLcSQgSoWBVqNiT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4d8a55-df5b-47d0-f44a-08dc55abb888
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 20:05:20.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgBeQZc308srq5ufWr56YcTnK0NjVOsTnhRxFzFA5fiA35VJM8dVgHuMG16gFfHueAHWuWAwn4wYIE/SxoFLjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4985
X-OriginatorOrg: intel.com

On 4/2/24 10:07 PM, Jerry Snitselaar wrote:
> Currenty if the user driver is probed on a workqueue configured for

s/Currenty/Currently/

> another driver with SVA not enabled on the system, it will print
> out a number of probe failing messages like the following:
>
>      [   264.831140] user: probe of wq13.0 failed with error -95
>
> On some systems, such as GNR, the number of messages can
> reach over 100.
>
> Move the SVA feature check to be after the driver name match
> check.
>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Other than the typo,

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

