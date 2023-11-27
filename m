Return-Path: <dmaengine+bounces-264-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A72A7FAD2F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 23:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243F4281376
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 22:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21028487A6;
	Mon, 27 Nov 2023 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMupHAzQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239887295;
	Mon, 27 Nov 2023 14:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701123290; x=1732659290;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xQhhVvwBXP2pIuAXN24hc2EPa6c+XcF1w3gkhjt/1cU=;
  b=fMupHAzQxBmqcmAca4d693Fk7whtkh9SfJAAN+6NPHwy+te6YFVKHNwo
   +Bf3GJghBnzYze6d3f5FJvVR5K8N+yYAgYVa4/FLNrsqyv2JPlce0c8Hk
   76C3TlDY1LiWLNJ9V3cgoE/AscyKpLJBtQHu2k1XBpOFTxcVOvCQZyNo2
   oVrhUsfdF8tmj0t2duyKte9cyezsmK/uUVOIp+5BPtcGoPCNANlgbH2BJ
   0WbrxxDrji0gu14SsqQ4W/wFeTiAw5UGHPuFryvKXeMw7J5w+0OYy1Z1q
   NbTWMRuiGfDbjQwFuF2x7JT4tj1cDCLBZVgKGbDt/09+tLK4S7xoriLWb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="395617913"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="395617913"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 14:14:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="859199803"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="859199803"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 14:14:48 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 14:14:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 14:14:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 14:14:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltSAu66fpTYsbeyxTpV4SaxheP3f8JUMGt0t3SebTySz1FtC7ePoMTxGEvylVEHzXPokbp+J+hJ/VOTP2ajtb2JODdTK1skIPaAtb3uYN6uuCFdaeFWIKCHKBwBup6p47hM8/Wtx7x3ECaqJmEvERyLLi8WIopYa8oMMUyDXLz99CX1tx6gI0rSeLLUjvH4RBpBlCGxBjpyJuR/Yn2Gx/hGLVMPEdtELR2lkt43imOrPHpiPrcFy61LPu7U9SfpiDZZHI4+YIQv0CkU42N/CwIzd6wNzC878+v9+PdyBKAEKAmffsV1UI2xesdWlI2y7IqwqHfox295RhVP1xFTr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHxHUmuStG5DIHEhtBzjK9VDCIFkfGpiHge2goOyUHg=;
 b=Y+LeAWnoofqhfLU8omNCgTbuWSIcjKvCosstAvYlUff9+pGyyr139IwZ6Xfps2o1KdfnUXlp0pE4hHIasFU5+LqdAtCHZqpef4ewZA7JgtL2frSrtxGSQP/bUYYBnGlDivS6U7545B2dLeA853D4ZGM89uY1GxFgJ0p7j6tKAOaqpRIzzUNiIrYjrVGLi+eSFhYMWugxLb5xKoLnXGmwls6+hivJSTgw/ODeNp9KdGClO1FgPHHBDgjh1eFazsQfVxVj/ViQ3PyTAZSHxxNvUpfzCExGMV08tdIq9IRECiHgofvDGlP7GCSmUxnttMRAYlh7sy9ajp7E/oNnGqXQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL1PR11MB5955.namprd11.prod.outlook.com (2603:10b6:208:386::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 22:14:45 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 22:14:45 +0000
Message-ID: <6d68774a-1f2d-4a9a-b96c-0e9c93655021@intel.com>
Date: Mon, 27 Nov 2023 15:14:42 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v10 14/14] dmaengine: idxd: Add support for device/wq
 defaults
To: Tom Zanussi <tom.zanussi@linux.intel.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <fenghua.yu@intel.com>, <vkoul@kernel.org>
CC: <tony.luck@intel.com>, <wajdi.k.feghali@intel.com>,
	<james.guilford@intel.com>, <kanchana.p.sridhar@intel.com>,
	<vinodh.gopal@intel.com>, <giovanni.cabiddu@intel.com>, <pavel@ucw.cz>,
	<linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
References: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
 <20231127202704.1263376-15-tom.zanussi@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231127202704.1263376-15-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:a03:60::47) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL1PR11MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dc6932-19ca-475c-401e-08dbef96430f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVbL+weq3hSLdKFCylSbUdWr+LljC2rmPb7QZ49FHTO2s5XLTo0SPIoB223XLRJlogXqIZC3Mc3VzAXgO+y4Y58DWB+T/kEJsv1IQ92xDKIxXTPwP8hUZN3V8WDFZEVEMZasdR34JwhPbdqT3v7Wk9UKhIDjZaxdNsgZEUvztVayR2L+2iq8pzyCJoZuc6rcvJzlX5W2HeA3kruV8Ftgux//Ag+C03z038XkVWHU7/SbLrm2JGbokw2uaBsTOJMEby3d77wFi6o/K0wy29NMLKiU9JQvrnK3eYKgDKfG6BCccxLGRQik650O79rxCNsRq+/na5pVNTAXr4y9r/q7VnRIv4jbWtSFQnQUlo1X9BTkxUQtCQ8blfDHMTmjOOUTBvdJSspQ9fuNU4FVP/4MHCptgxUX2et+pS1dIyRHFMOz3mV6+gDQkofUk3GgdGzpTuJFjDgX7DnvlGZXvaUBnI2qCSsgnL4BYCateidyc7TmQ4y4giCgeHCtBKXKmcT8VIM2eiiwAQUfiTlg75d1TN7atMG3PESi8UmCIOQiqhCKQeWRANHYrfjDhEMZ48azETv+4tJ+2UtrCKb2J5FYPy48/h0ieEXv9h1FWQHjLn9dAwZ6pPzF6kmcLr13dkPm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(36756003)(41300700001)(31686004)(2906002)(83380400001)(82960400001)(5660300002)(26005)(86362001)(2616005)(44832011)(6506007)(8936002)(8676002)(4326008)(53546011)(6666004)(6512007)(31696002)(6486002)(478600001)(66476007)(66946007)(66556008)(316002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVFTYTlBTU9WclNPT3F3bktENUVPcGIxSnJGK0g2SEczclY2NVcyKzNPN1hy?=
 =?utf-8?B?alVXa2Nid1ZDVnhpTXNiRHdrLzlUanRkMlN4djVEUFRrUUpQazZ3a1JERThB?=
 =?utf-8?B?bUZlS1c5eWo4MHAzbjFPeTg5Y1UzUUNZUkgyNllZMW5TR2xzSjlsTkhURHRo?=
 =?utf-8?B?YUJ5VENuNnptVHRCMTNnSkF4dHlGWWZmd1lWbWRYNXZ1M2VxMnhLUEtpWXpI?=
 =?utf-8?B?TUZDeHRGcTRkSmNmM2l3cHBTV3hTSnI3L0RlaVRrRVowZUx0c09hNDdsYW0r?=
 =?utf-8?B?NVphS0RMRjZtS3daalBucWl5UGJnNUl2NlV4NjhCODJmV2dBaFdHUXdyRlc4?=
 =?utf-8?B?RG5YbGk0RGhxY1BWNjBIRERIZ2tIU2VqTVNlcXVQM2M4YmFBdXQvdWJ5NWZq?=
 =?utf-8?B?K2VSbU5meERrMnR4anZ6S3JzZmNYN2UyaFBaNUdFeVBVUzY0am4rZnhWbnFO?=
 =?utf-8?B?MXFlRFdmWkp6amZ5bWJGKzNlUjRnbmVBVVBOMGE4Z1VjcFRoK1R1STF6QkJP?=
 =?utf-8?B?ZlVmclZCSERRMnRvVGJiZTB3ckMwTG1odkVYbmNTVmllTmhFU3FtSGpBU1lC?=
 =?utf-8?B?TzBkWlNXYmFwWGlUSmRPNUIrQkNVbDJqUTBPV0pCMDZsczQ4a0tiL2gvZVdw?=
 =?utf-8?B?SDFEUjliMFdCV25kMGdqblRaVzRmRUFLeWVoTjdmZU9CbWtXT2ROcVRCNDdm?=
 =?utf-8?B?Qko5a1M1VzhSNWZyU3JMVkdzQk9lWjl1U01kMUZ5UThFT1E1MTh4N3BVMEIr?=
 =?utf-8?B?Z0kvVXBTUU1wREYxVkJqd1FUVG1mbTRiVmNKYXNGbVBUMDlVUVB5bHY0ZGlM?=
 =?utf-8?B?Z29mY0tUMHlNd3pmUzBKcFNXWG1rN0xwYTY1Q3FhQUM2cUxvaktMNTFqN3RI?=
 =?utf-8?B?MjZIVzg2cHRncnZXL1RSZ1JiaXd0QlZzZGFmRGxJOHZTeHpwMTJzV0JCQVY3?=
 =?utf-8?B?Nis3bUhiRXBobVBsaEVKTWZaWC93ZnpQajk0NHpCNTBKTmp2QjVEVXg3OWNn?=
 =?utf-8?B?NXpPZW9USVdaa0xRb0QxWWNtMFRtd3dKU1VNVzZmd3JGR3ppK1Vlc3dycDVk?=
 =?utf-8?B?NXlBV2pJNmptd2dxYUFXYXRVYVdRN1F0L0lYSDA0aktUZm0xb0pYT0pzNkxN?=
 =?utf-8?B?VkVJZ1ZwYXhhTFpKclV1T2FuSUZhSDN1K1VuUEdMSmQva1JwT1BPWDA1bCtF?=
 =?utf-8?B?ZzE3dS9uMmtGUmVmYUhYYSsxcWJtZ1k5WCs0dGdkaHZ1V2dUOFU3bWQvMFFr?=
 =?utf-8?B?SHU5YnN4R21KVTRVa1V5VExGTTByMjlzWUwvS0IvcFVxYjQzNnlZWkE1U3o5?=
 =?utf-8?B?UGc2YjRIRWdiYWJHUHlqYldvVmJINVBWS3I0Z0tYVW4rQ2FtbVNRbnlmb3g1?=
 =?utf-8?B?NnduNVNEbk9KY29XMkhsbExDN3Z3ZWt2aW5EbHZZOXlHMzNXSWQrMGZKaGlF?=
 =?utf-8?B?bnd2UWZzUkphYUx2QnNhM3h2eDhlSTNNSHlwTFgvYkQvSDdtMjVNV0tTT041?=
 =?utf-8?B?THgyVXVHaE5YRXpMVGtTR2RZZWlpUlBaK3hjTmROT1VKNXQzQmFaSUxmbENa?=
 =?utf-8?B?T2NCby9GZkZBc2xydHBVeUhPZjlKaG5tTy9jclVTM1dMYUp1ajY1TzJsS1ph?=
 =?utf-8?B?Z0lqbFFJYXRMV2d0OUxBbnNwWjVBVTBoT2ZZVllMVHFWNG9MdlZNR2dHazFZ?=
 =?utf-8?B?cjFWSUt6amVnSVBKcEJ5THdkVWxIb1UzWWFBcFYwNHVpamdrb0FtRFozRTd4?=
 =?utf-8?B?ME9tQVU1RCtZZXZ3cWZ3MnYrZSszcHZBcDJmbVd0KzVsbnVUSVhoNm93bDJa?=
 =?utf-8?B?S2l3b2VZRE92WXd3ZE9vakZzRzRJaDIzclVHYXRIMXhXLzNTNEhrTTdxcmt2?=
 =?utf-8?B?KzFyOWNTaTdySlNtSkNya1NtUnVicXhXRXR6ajZTVDU2dEZ0ZXJvTm1Sa2ZL?=
 =?utf-8?B?S1Z5L1BGam01OUV3SHNqaEQzTkVKN1dUTDFOOFpCVHVGWFlVUGhFQ1JyZmpH?=
 =?utf-8?B?cHhyZ0kwdzJiay92MzZlaU8yMmh1Kzd4NE12VGdDS2ptVHZlbzVkcXgybzJZ?=
 =?utf-8?B?RzN5T2M3VUl4VWM2QmZuRVlxWWRLVkpIS09GN3RDbDZaSm5vT1IrUm9jZFRt?=
 =?utf-8?Q?F38aTGUL/Ujd9vvWe8ndltpN/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dc6932-19ca-475c-401e-08dbef96430f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 22:14:45.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDduZNf6jpIdemWlMEKZO6LKX4CffRcYmE8jFZZ9M5vlSyK60D199ZppqM6JEa+G9gl6F+tsRAv47zOe+D061Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5955
X-OriginatorOrg: intel.com



On 11/27/23 13:27, Tom Zanussi wrote:
> Add a load_device_defaults() function pointer to struct
> idxd_driver_data, which if defined, will be called when an idxd device
> is probed and will allow the idxd device to be configured with default
> values.
> 
> The load_device_defaults() function is passed an idxd device to work
> with to set specific device attributes.
> 
> Also add a load_device_defaults() implementation IAA devices; future
> patches would add default functions for other device types such as
> DSA.
> 
> The way idxd device probing works, if the device configuration is
> valid at that point e.g. at least one workqueue and engine is properly
> configured then the device will be enabled and ready to go.
> 
> The IAA implementation, idxd_load_iaa_device_defaults(), configures a
> single workqueue (wq0) for each device with the following default
> values:
> 
>       mode     	        "dedicated"
>       threshold		0
>       size		16
>       priority		10
>       type		IDXD_WQT_KERNEL
>       group		0
>       name              "iaa_crypto"
>       driver_name       "crypto"
> 
> Note that this now adds another configuration step for any users that
> want to configure their own devices/workqueus with something different
> in that they'll first need to disable (in the case of IAA) wq0 and the
> device itself before they can set their own attributes and re-enable,
> since they've been already been auto-enabled.  Note also that in order
> for the new configuration to be applied to the deflate-iaa crypto
> algorithm the iaa_crypto module needs to unregister the old version,
> which is accomplished by removing the iaa_crypto module, and
> re-registering it with the new configuration by reinserting the
> iaa_crypto module.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/Makefile   |  2 +-
>  drivers/dma/idxd/defaults.c | 53 +++++++++++++++++++++++++++++++++++++
>  drivers/dma/idxd/idxd.h     |  4 +++
>  drivers/dma/idxd/init.c     |  7 +++++
>  4 files changed, 65 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/dma/idxd/defaults.c
> 
> diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
> index c5e679070e46..2b4a0d406e1e 100644
> --- a/drivers/dma/idxd/Makefile
> +++ b/drivers/dma/idxd/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
>  idxd_bus-y := bus.o
>  
>  obj-$(CONFIG_INTEL_IDXD) += idxd.o
> -idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o debugfs.o
> +idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o debugfs.o defaults.o
>  
>  idxd-$(CONFIG_INTEL_IDXD_PERFMON) += perfmon.o
>  
> diff --git a/drivers/dma/idxd/defaults.c b/drivers/dma/idxd/defaults.c
> new file mode 100644
> index 000000000000..a0c9faad8efe
> --- /dev/null
> +++ b/drivers/dma/idxd/defaults.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2023 Intel Corporation. All rights rsvd. */
> +#include <linux/kernel.h>
> +#include "idxd.h"
> +
> +int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
> +{
> +	struct idxd_engine *engine;
> +	struct idxd_group *group;
> +	struct idxd_wq *wq;
> +
> +	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
> +		return 0;
> +
> +	wq = idxd->wqs[0];
> +
> +	if (wq->state != IDXD_WQ_DISABLED)
> +		return -EPERM;
> +
> +	/* set mode to "dedicated" */
> +	set_bit(WQ_FLAG_DEDICATED, &wq->flags);
> +	wq->threshold = 0;
> +
> +	/* set size to 16 */
> +	wq->size = 16;
> +
> +	/* set priority to 10 */
> +	wq->priority = 10;
> +
> +	/* set type to "kernel" */
> +	wq->type = IDXD_WQT_KERNEL;
> +
> +	/* set wq group to 0 */
> +	group = idxd->groups[0];
> +	wq->group = group;
> +	group->num_wqs++;
> +
> +	/* set name to "iaa_crypto" */
> +	memset(wq->name, 0, WQ_NAME_SIZE + 1);
> +	strscpy(wq->name, "iaa_crypto", WQ_NAME_SIZE + 1);
> +
> +	/* set driver_name to "crypto" */
> +	memset(wq->driver_name, 0, DRIVER_NAME_SIZE + 1);
> +	strscpy(wq->driver_name, "crypto", DRIVER_NAME_SIZE + 1);
> +
> +	engine = idxd->engines[0];
> +
> +	/* set engine group to 0 */
> +	engine->group = idxd->groups[0];
> +	engine->group->num_engines++;
> +
> +	return 0;
> +}
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 62ea21b25906..47de3f93ff1e 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -277,6 +277,8 @@ struct idxd_dma_dev {
>  	struct dma_device dma;
>  };
>  
> +typedef int (*load_device_defaults_fn_t) (struct idxd_device *idxd);
> +
>  struct idxd_driver_data {
>  	const char *name_prefix;
>  	enum idxd_type type;
> @@ -286,6 +288,7 @@ struct idxd_driver_data {
>  	int evl_cr_off;
>  	int cr_status_off;
>  	int cr_result_off;
> +	load_device_defaults_fn_t load_device_defaults;
>  };
>  
>  struct idxd_evl {
> @@ -730,6 +733,7 @@ void idxd_unregister_devices(struct idxd_device *idxd);
>  void idxd_wqs_quiesce(struct idxd_device *idxd);
>  bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
>  void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
> +int idxd_load_iaa_device_defaults(struct idxd_device *idxd);
>  
>  /* device interrupt control */
>  irqreturn_t idxd_misc_thread(int vec, void *data);
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 0eb1c827a215..14df1f1347a8 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -59,6 +59,7 @@ static struct idxd_driver_data idxd_driver_data[] = {
>  		.evl_cr_off = offsetof(struct iax_evl_entry, cr),
>  		.cr_status_off = offsetof(struct iax_completion_record, status),
>  		.cr_result_off = offsetof(struct iax_completion_record, error_code),
> +		.load_device_defaults = idxd_load_iaa_device_defaults,
>  	},
>  };
>  
> @@ -745,6 +746,12 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto err;
>  	}
>  
> +	if (data->load_device_defaults) {
> +		rc = data->load_device_defaults(idxd);
> +		if (rc)
> +			dev_warn(dev, "IDXD loading device defaults failed\n");
> +	}
> +
>  	rc = idxd_register_devices(idxd);
>  	if (rc) {
>  		dev_err(dev, "IDXD sysfs setup failed\n");

