Return-Path: <dmaengine+bounces-23-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C40F7DC494
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 03:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBE81C20B51
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 02:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C37E15CF;
	Tue, 31 Oct 2023 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arzxUN0a"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E82715A1
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 02:39:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E19F;
	Mon, 30 Oct 2023 19:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698719994; x=1730255994;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KLPGkNh1JlKK1tqB/kStPW3DB6ATzM/u8OKsSTXyZeo=;
  b=arzxUN0aLFVozySqV+lept9ne+VdcVteYG23DXB7n+z7rfCmb1+1KFpl
   L0m4tXesAzKtW6eGaoE7XltFmnO05TR49vmb3rRYrREnP6iymbt5UtJQ9
   RybgQ5wVwcHXEN6ty2HxdoAvH9KRuQpW3gSzpYuwnw2mEUm5kdjOL3j5Z
   3Q+A2OXp2R1ZIAYu3k5eHbDaCfYMx8VZqu7VJFYSQWYku0QE9lSH7IhIH
   4KPPJAv7V5TIfA4M9aLbCwZyOK/SQ9xHJ4pbm2nO0bJGlgH8VpM7hqYZ0
   yCGkSe0PIHRBmKdzTDbr+J52hk45ntR6GQ59OuhTw9jverW2d5Y7Ja6q0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="368408561"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="368408561"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 19:39:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1007623787"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="1007623787"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 19:39:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:39:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:39:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 19:39:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 19:39:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d77VWVcNh/GtJrowSttui+OG7uChJxe3+UD0v399b7CaoFjfuAPUvvl9RNkAReUZJlOL6XE8++4LH44/G//WfpbOsEjDdozyGkW17srmDKqNiYjnVEzOKSQ0NrOpkkAox6IxX+EI0kNwoPuHLOcfzUHDuI7FOz2HwGSkR3OGhOgXGFe/KM84pf7Oo8qo+nxVzZbgWEtn65FUGOFjZ7MMYEs5M3V1gYFPqNAayF0T/31T+xObCs8nGLoYJNK7qzOnJuY1uJwacrAm15TwrLXvzMStFf+mdcFujZzDVn8PQwCRkM5sPyW48efezaRrGCL0GlS/piiaRAIL5hqK6ZSBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5TKsVOeyoqiuyrCcEtxx2nblAAKcF9Pc5jZYEdldYM=;
 b=Mdz70pLwm/aimZN/flZ7tWBShccdM6REdqh0l/W9mp+nPj3zrBvjGUfHNMlVFtReEuo+n1hMeS+uTd5a7aHqf+S8prK8Jcpt3UwB7mCdpaq4dFuPsO3q/f9bRJOacO4c/FJPvdVpTVhOfbJ5DlHis9MkcDuJJ3vIpPg0G8a0xJrOBYQTy72w4ctJbXW0Gpu1ANIdcl09FORPY0nEaFGTzQvwWpxFj+WQlTnlyYr76XkX6N+214+eesJ6l90PC2FXkpQwEqh7qZ+IVdEPfQ/li8hoVQOqDAhQFy0kmfJ7Wgt/ETKoDfV7+jos3UE4d0RjPcXJc5NyCni+JO6UIFMslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS0PR11MB8666.namprd11.prod.outlook.com (2603:10b6:8:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Tue, 31 Oct
 2023 02:39:51 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29%6]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 02:39:51 +0000
Message-ID: <656d4735-0e24-c9d8-ba9c-97f079d95475@intel.com>
Date: Mon, 30 Oct 2023 19:39:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] dmaengine: idxd: Fix incorrect descriptions for
 GRPCFG register
Content-Language: en-US
To: 'Guanjun' <guanjun@linux.alibaba.com>, <dave.jiang@intel.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <tony.luck@intel.com>
CC: <jing.lin@intel.com>, <ashok.raj@intel.com>, <sanjay.k.kumar@intel.com>,
	<megha.dey@intel.com>, <jacob.jun.pan@intel.com>, <yi.l.liu@intel.com>,
	<tglx@linutronix.de>
References: <20231031023700.1515974-1-guanjun@linux.alibaba.com>
 <20231031023700.1515974-3-guanjun@linux.alibaba.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20231031023700.1515974-3-guanjun@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DS0PR11MB8666:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f16601-8e68-4ec6-7308-08dbd9baa809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqVpqDyJOe4L+Thb05Wn1i7ziufKPOBO9P1Pe0I28fm8O2QWq4bhslmDAndnujYkYF8W/K9ccW93Pe+xkWUSbRIQMfpV1uyHOFwoXLI1/tIwizoav0WvT5Gd67u+y99oi4BcuBkt0deaqa8xna8TIcx/GIBThdkEwKPTCLj57LmoS/E/eJPRAOopoD2lqO9LBwUwa6EGDEWsbBgVMBD1769Koovl1Qm8IBW6uPvYOz8D1Zn/joiHsD2EVVTjts6JzDcNzXlyx8LNXb0l9XwDu9/C7Dz28C/2IFHvNe7lbUdQCiLThQRqjMVfY0Ek8tFlzXaCeEQzYnwGBznrlr1AAhOKPoVjY+YHLbf4vzzTiO1QBumgbGRdlEUSsRY0QsZXfwk3GQCF9NbGYQSEsEXlp0vs9OSrzbQVbRlZUj0jIvV3gSEH76+XVg0xU4zsHKhDwTV+aZBImT3lxdmiOTvrscpftoe4nkdCGPHCYDGytWrbh5EkE1YysPGIQ9TLcUdqnHS5N+rQAyWu17Uw2+tctf1zv36bZlJBBOT6+52CQH9ZMVKUXsu02AyKlTyLQa9jB5AcXb1j25sdoEyWqbvy/z1vwsZoNbzPJ7leu0Y7vDTzmEPnLsUXFlHSd221DOVgeeV4QPcOcvWirD2iyHlbzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82960400001)(38100700002)(6512007)(478600001)(6486002)(6506007)(53546011)(6636002)(4326008)(8936002)(8676002)(44832011)(66476007)(66556008)(316002)(66946007)(4744005)(2906002)(41300700001)(2616005)(26005)(5660300002)(86362001)(31686004)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE9sd0kzZHJYeDh1cGQ3SHJrWlNaZ2h5WVZ3VlJQRlZUTld4b0FnM0tjSEhJ?=
 =?utf-8?B?V1lvRTkvOFZzY2p6WkxJa3VVTExNV1dmQ1BWaDI0LzlUTHM2b0Z3aTNtTE8v?=
 =?utf-8?B?eW1RQVduYzR2Q3pLVitIWGRRMU5DYVE3eTZCQnFyUkNYREk0QWx3alNEYURB?=
 =?utf-8?B?Ym1zdENKKzhvdGpJNG95Zkg0Wm1pZFhobUtCaDdVRDI0OEFQaWxMRE56dHN1?=
 =?utf-8?B?bkZzUkVZK2IzeFMzc1p1cDgzRFcrTDRrYnVLR1FGQncvUGZvaitCcm5pZWw2?=
 =?utf-8?B?QlFDSTl3TTNYU0MrSjZUbWRtK2JFMjhmSVA3WjBER0s0WkpNUCtwQkV2aDE5?=
 =?utf-8?B?S3hFNytqT0V0bVhWYVZwcnN5QmFFTk9sTnZDSWtvRE1ZYW1MZ1FlbmZIdHhh?=
 =?utf-8?B?ZEwvSnN2VnpiajVVWDZHV2wwaHllQjhBTW5jYlBDa3lyQmxiM1dzaThhSmFU?=
 =?utf-8?B?ZnRFQXdqaFVoeUFWbW1nd2owRmg4ZTMvQTFvd05DQm5zRTZncW9YQ21yUjdT?=
 =?utf-8?B?V09SV0F1dEE5QWE3UkpRN1EveGxubk9odWVNVzdvdHVGTVNTcmpaWnZlNWNR?=
 =?utf-8?B?WS9CbXZvSTVXN3QzRUZZaXg4V0pGc3FyeVdYcVlqMm5hZUhLQWN5a0tMSlFy?=
 =?utf-8?B?VHFQQm1uY3JVaXVkRHlOVFdINUlhakdNaHh4Nkp4VHgwcG5CRnNjRm9WM29F?=
 =?utf-8?B?Yko2cjR5YUxEeEF0S0VtZlBJRnBMNzhweUFvSkQvQVlRTmZZVVZLNG5Qelp5?=
 =?utf-8?B?TCtTQU5WZ25XUnVLdGQyb2loWjJLd2p0eTRvZXBvVEVDRWZ4TFYwdDZWcWFm?=
 =?utf-8?B?Rk1DbTlvMlZER29qcWVUNTQvVEd3Q1BKS0xhbzVhVWdSa1hyV3dibDJXSklM?=
 =?utf-8?B?ckJlZVQveXh3OHlaeWxWbEtBNk8zQ2lOUVNPSmg2WUZtbS8zMitSa0tkZTFH?=
 =?utf-8?B?MG5LTkNLcmNUWlYxQ3RtckU5NlhWV2pHemZSQzhCQjFPMzNUNEdJS0dQMUgx?=
 =?utf-8?B?RC9meUk0VGdpdFpNcEUrdmM5SkNsbUpyYVcxSFRRekRZRGVuQVNrNGVaZHFl?=
 =?utf-8?B?YStXMWJkbWVmUFBzNnJYcTBnTXM2bTUzblJTc0VLdk5jVmYwdVcvRFBML1Ft?=
 =?utf-8?B?QU9SWjJWMnJrV0FqSnU5R25DaEwxcTArRVFDYlJteEZhcUp6a2JGcFVmSHVE?=
 =?utf-8?B?Q2d3YWp0eXkvaWJ6ZG9lcmhUYVlySnZzYU9sUzJ1aGxzTUtYMmdQM2lzZkFl?=
 =?utf-8?B?Ump6VHhZTHY4SFdVaFMzTTdYM0xCcDRPd2I1S0xFdkdDckRJRmEyUTJmcWlY?=
 =?utf-8?B?YlZYNW9DMDUwbUR4RGc2V2lmZkszTU12RTRlMEpnU3h5Nk9nYk5KQnRZaEQ1?=
 =?utf-8?B?T3VzNWNKRWxFRzBXS2Y5eUUwT25RZnBOVVkrNGVzZThpeks4ZzBjK3A5V0pt?=
 =?utf-8?B?dkR3WVNSc2p1ai9nM1NYMytNMXV0eTBPbk5hUUZCaWYwc3hrYkcrRzRQd251?=
 =?utf-8?B?MkNWTFNqYm5WUHdSUU5MSXJPa3Y3SENjNFQ5V0hGdTNhMytoK29mMHRPbnFX?=
 =?utf-8?B?a3pSTTNvV29qWVIrSDFzelZDbkxLbHdiQXZtbUpNbGpkd0pzTFRsYWlMUER3?=
 =?utf-8?B?ZlJQYUVUZ0dRWWFjQ0c1YnM1NlZPbWc0WnBhUDVwanMvRjJUc2R1Q29mN1hq?=
 =?utf-8?B?MlVIamg1bFY0YXhmWGFPZjduVzQvdW9SdUptOVNaQzA2bVRkUjkwczI0dC9H?=
 =?utf-8?B?SXdwQ3hJODh6VVBpaUJCT0RubjNZQXdPbVI4dGdYRWRweHphektGTHFIdzhS?=
 =?utf-8?B?ajhLVW1tZmFVODAyaloxMW1hWGNSSzQ3K2tlWm9mOWsvNHV2aE1yVzJYZ1lv?=
 =?utf-8?B?cmM4S0Y2RytMekNuVTVmbHVvSjgrWUNCK0ZVY0N5QUNPMHhNcEJ6Qko1c2Na?=
 =?utf-8?B?UndsTGpRdExDTVlGSnh2dzVDWVFSY2c3QXh5bWttaDMyZ0VSZjR4aVJrcHFH?=
 =?utf-8?B?UWRxalY4cHc0RDFoTWpqVTNsNE9yNXhROGFyelNTd2M3dmdnbTFTRUtrem4v?=
 =?utf-8?B?MTRiNUxqQnpaSUtDMERuYi9qeVdaWUlnVXZsb2VRZ3pMMktuNDZHRURYVzBw?=
 =?utf-8?Q?PbwVKJw+fx2q/wRJkVTm8ewPR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f16601-8e68-4ec6-7308-08dbd9baa809
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 02:39:51.1521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZpumhSdiJQ61mTqxF9xUMHQW8ruHCur1UHihGJ9i2G9MUgjxYvW1EtpPdo46/dx/eqft1RVi4qmUlK2j9coVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8666
X-OriginatorOrg: intel.com



On 10/30/23 19:37, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
> 
> Fix incorrect descriptions for the GRPCFG register which has three
> sub-registers (GRPWQCFG, GRPENGCFG and GRPFLGCFG).
> No functional changes
> 
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

