Return-Path: <dmaengine+bounces-2809-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A64F9480AD
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 19:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA471C20DBE
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 17:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F78313C80A;
	Mon,  5 Aug 2024 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1GuGQmA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10E815FA96;
	Mon,  5 Aug 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880001; cv=fail; b=sFzn8qkUz2b9EwjmkMHrBepgJjcUNAN/JHwXodbZWPzBjSNyESzIqlNRmA8uOnoN4DdrrkgRIO/keoM9q2vyPrjskMsshFDS3EAX7FRy1WYY5M3vVYXcAV3rKMA55ErFR4Ci8xPY/FtSEsjxPm//EM+f94tiIdO7gL0VQ7crBpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880001; c=relaxed/simple;
	bh=DbtxxRMTQ7Ed9DqJD7DwMBqWpuhy5BEsuQM3b6wTX/g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bQleSOt8LLxetFk5XfFd/yTKMa3AqlLR/yxk285At+LC6H0gXkRkUMnwXRlJjfNMnKNI3ICxaBSazqo0C+s5UMYlve5aQkH6K2eLYFaQw3I7jyswtJt98o5hrPBeFfo9PIU+SCGIccmtfoHQadqYkjnLLnIafvNDXFei2eQ+jJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1GuGQmA; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722879999; x=1754415999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DbtxxRMTQ7Ed9DqJD7DwMBqWpuhy5BEsuQM3b6wTX/g=;
  b=A1GuGQmA8rV3PGgCimCxBf0ZCEMdEMSU6dR5oWhnm4wYS+2SyScKyPLg
   uE3O3F3bziKEtf/nnW8gjnh+/ckLKPO2KUZzkXyVf5FaRa0pBUGkbiu57
   ptZvt6LvLpPuAMAtCj4TICyin65oiyv1cPTjc2X9hjPnujk7yG9mHcADG
   dc5aXByl4RQmC/5XR0TgVlcYYnZOzkKxcqp/am6s/BdkNawUqfda+wVNz
   xHrUrXkYuEL3R7Ag7fOXBTxr5dCULw24maXlPQ7nTOIJsK6y/cuoJh0dv
   9wTReCxw/afU7wDlik18CjWBPEWCb7pV/2twv0imFeLkZka9oQHohHoBd
   g==;
X-CSE-ConnectionGUID: oc8r9TvESq25Qk+5+6+ZpA==
X-CSE-MsgGUID: HVeTZF6rR6ywyTja7jRiMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="12873360"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="12873360"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 10:46:38 -0700
X-CSE-ConnectionGUID: of6blwNVSvmasCufMJBrSg==
X-CSE-MsgGUID: rUo/RL/NQC27vTtlUPcyaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="56806479"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 10:46:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 10:46:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 10:46:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 10:46:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 10:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrzXfRomCgHGkJyyU2D22wbisXkDk6DyY8Uas8TKBBxdaNhBjh7oMJlYtWEqcOCO9lrUjmqPDr25JvkejKcv0sqFdvdbK82CIkk8bC8cjhssI7YBJ0g+YeM1q3RZma7cKW/Ed12lig09BRQuy/Y2Gh0mcO06jG93TERu1miUVd3xLJB8tmJzgLToOBS9BDd5daNrX7Cg3JVi2RXT7ZVmdCTAF6b8rhJdDFf8x9u7y3+Zu/9wHwk4nYIneGmac9TJ3tDDKhVTf9cJ/BkCvBGegJ5slcX1OKp2OI9OmdKQz6bT4Q2KRLyStfuF3F/QwuoH6vVAGS7D8sZS2ckBWp+idg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2Egr+BJBmdcm/nuMarEW2aCaBl2J9yRIa/ByBC4LBQ=;
 b=ySlVYrk6fhzWjs4pausN89kNTfSuhc1I/TORELbIj0I8d3muuZc4enocu59m84emvpjsnK3wuWvH5muIOyFiy9azBlCZhZrSdw7yd329gOlN2YFhol7lFv2xdGYKgbC+fY9lbMeClQn1XIfT091YLxbqmge7IUJ5vU197uPBy7VabeBfUpSRqSZPwjyFL3CAb7JbHpt7iKuRz4Cvkc1IT+5FNp37TQ7n/SdE45bOXNM33GPjLgkxxgS8tSG/bcP0iXCNpFQMsaSsmuvno29ZCkCJ5rGlRDf6KWJjoI8Y/R4Sodm/NZh0PkMul7SGVSqebjvJtljj1XdlqWJH1+IZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB6093.namprd11.prod.outlook.com (2603:10b6:8:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 17:46:34 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 17:46:34 +0000
Message-ID: <f337259c-1084-9715-c8cf-0845b4332578@intel.com>
Date: Mon, 5 Aug 2024 10:46:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 5/7] dmaengine: idxd: Clean up cpumask and hotplug for
 perfmon
Content-Language: en-US
To: <kan.liang@linux.intel.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<linux-kernel@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-6-kan.liang@linux.intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20240802151643.1691631-6-kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:a03:255::7) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: b49eaca8-a388-4956-6669-08dcb5768bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZU1TVjREUzhSM0lRU0lMVzZsM1NNT2g5bU1oSTE0ZGt2aTY5MnBPdjlMdHEy?=
 =?utf-8?B?bkdLR0IrV1pqMEhqRTBOZTI2dFFQU1B3VFAxS0piYzNmU0lyTXo1SUxvcllF?=
 =?utf-8?B?ZHl4cDh0NkhKbDRVSWZrcnRhOXFOOEJEUGhMVXQrZ2QrcXRPdCtPZThiUFg1?=
 =?utf-8?B?RjVBZUdyTCtoRW9PMXI4VFh4TmxoMDNHMnBTSlB2NllIVGZpbzd2U1dhMVcv?=
 =?utf-8?B?SC9VWUdrL1V3ZXZwaFBEMkxiSmJSV1ZTMFJkVWl0dHFGY2hVZmJhTmU1OFI1?=
 =?utf-8?B?V3I5eG01amlOajBFdCtuaDJVc1FpcXJGUDdiRW4zTnBMOFB6Ulkxc1g0eUZv?=
 =?utf-8?B?ckw1Vm13VzFJYWFnM0toRVN1bWU1dGtoWXpSbkRrb2RIa2tqcnJOZ2EyVjBR?=
 =?utf-8?B?Z1A1L2YvSkQ3N2F3aSt3QTR5clRjdTV2RmIxY1M2akI3cE5ZemZhZFV1QnEy?=
 =?utf-8?B?UFc3U2VIbmJydkJlLytkVHJJckJLTDR5L0JCdW5GQ3BkaVFaZG80QWtCc1pk?=
 =?utf-8?B?TUdxUUxhUWN5SldmbjJWcmtqdHdtb040eEdXZjZjOEluU3RUbGxadGZvbyt6?=
 =?utf-8?B?RmNJNklvNzAxQnorUFU5NFRnK24reXRkTUNMcVNLMGQrTXk0T1V0L3Z5Ykxz?=
 =?utf-8?B?Tk5LT2NqRWdsaVZ5VXFmS3JhcnZ5VTdDVjd5Z1U0RHMrWlRyL2pEK1FjZXpY?=
 =?utf-8?B?cnBGVWR1QlJpZUtGLzhBRFpmUEpzb1hxYlBrODRHZWQzRUJ4U2N0c1dteWNU?=
 =?utf-8?B?SWZyNExtbm1BdFZ4UmVTQmkvRC9VRFgxSUpyUWZjUWpqVHdYL3VHNzNibWZS?=
 =?utf-8?B?ZXk1MlB2Mkg3TVBKdnhrNkpCRnhNUHRicjVwbEoyTVpGcGVmakM3TUNTRDk4?=
 =?utf-8?B?VkM3bmRscXBrdThXLzQ3VnAxVVg5UmRkcExYSTBhVFNNcTR2V2dXbjJabFFk?=
 =?utf-8?B?UXkwM1BGeUpjaWk0d1VxV2lGWDgvbVRPUXRTN0ltSGg3dkxCNlBZRGRZZDVX?=
 =?utf-8?B?MjZyOGhIcGxHNGhURjRTTGM1MnZ3REdweE1SeW1pbjFwanJUWSs0Sk1kVlBJ?=
 =?utf-8?B?QnA4cXR5VEJQWTZjTUx6Z0Vtd1lIMGpZbjNUbVBLV1k4OHZHQlBpeFJ4c3pK?=
 =?utf-8?B?TjBjLzU1S0xFVVlSU1dwaWl5NXB2NHNEV1h2N004R3FEb3dGSy9jMGhYNFNH?=
 =?utf-8?B?QVJUU2w1NXRVbGZ2N1c1N1hWMExHQ1U5RkdVNGEvUmdoVXFZV3B3VkQrY2Iz?=
 =?utf-8?B?NUNtNnJ0dC9Kb1hiRzRGWUxENGRTcHpibk9vaUlyNmVmbERkc21UajFTbjVT?=
 =?utf-8?B?NGx3Qy8xdXFNaFVMNmNLVHZQdWhyYnNjeHlvMVAxZ0VQUUxXcnYxOGVDTUwv?=
 =?utf-8?B?MHEzaXBJaTZjSU5UTElFRGpTZzJ1eG1hR1Q0dHFmeVVvQys5QzAzRldLa3F0?=
 =?utf-8?B?Wm1yL2M4c1gzVG1Zd1RiQ3VPTWJaRmFuYUxyM01LcTkxd0VWL2oxSE85TWds?=
 =?utf-8?B?NTRSTlY5dU12aE9RaEZqZ1M4NVJZMk1zTjljcm1rS1ZxdEx2V3hMazRPSVNE?=
 =?utf-8?B?K1F4U2xpdEh4aE5DTGRhdDRqRFNrYlpQWml0akJQN1lEUFRBYXI2Ulhaa1Uy?=
 =?utf-8?B?ejlrWVZvdW92VWhHNks2R2c1U2dlNVZvb05KWWNpQk9jQWc1ZGFmTDRXeVJU?=
 =?utf-8?B?THFlajBVQnVCQ2JieXp1NmhCb3k4c3ljL2g3L1VzUHZqM0VnQ1A2WTZUQ0Ix?=
 =?utf-8?B?UGlPSUIrWFJyejB5d1VpWmx6MGdxQjM2eUNoc3VISjdvbWhGazAyd0ZYU0hQ?=
 =?utf-8?B?dlJnVER1Q01ITEQ3aEgwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjhmeFhjTGF5OUh3cUFLVWIwTnh0L0Q4UFF0U2F0Sjd4b1ZaRDlHcXdDS2xx?=
 =?utf-8?B?U2ZEUzlaQmlDUWg0VVVPUSs3OGh2RW4rVVp2K2VoYUhnTVlxbHZlYzFubzVZ?=
 =?utf-8?B?cE43Tlg4YlVEWmVFcUQydFN1THNjZXQxRmd0eHRGcnFlUzFnaklBTGF1Unc3?=
 =?utf-8?B?T2xpNWd3bk15VThMU3Z5N285QzZRTlhVYXRyUlNjaTJvajN2TGtiKzBqa0di?=
 =?utf-8?B?bkw1SjJqYWJFZU0yNk9idFhSVFB4dkNmNVk4QUZ1cWJEU2JFQUNjSXNGYTRW?=
 =?utf-8?B?a3p2T0lucnRKRXM0amE5NnhCcmpSMXRtMG9SUnhwcFIzTERDdWhqcnJESWVJ?=
 =?utf-8?B?ZWd4dXQrMVpVNnZ2T1FtQkQ4YUpxVUJqNm5CMXZCek4rcXBLMWpIQjdFY28y?=
 =?utf-8?B?dk5OZVpPdFl5MmFWS2RSMGJIQm9QVFVla3kzZHN0M1NpSld3NjdCYkhXMDdL?=
 =?utf-8?B?NmhIU29OZDY2aDBEK09qc2VxYllaaXBLQk8vZXgyNjhwZ0x1VGFUS1pXNU1p?=
 =?utf-8?B?MTkyd1JvTzlMV1hrMmVuUGNDL3FPNS9NdXpnWS9kSURrUUh5ZnU4Ym5xSlha?=
 =?utf-8?B?TXQ5YjgzRkU3S3JnazQ3eFIvMmhvZXQ4dlUvREowazNjeGxhRHZvSjdhbVlV?=
 =?utf-8?B?RzZFc1VoTVB6SHRKeEJleFhkVFo0NVJHOFZIdnJianUxcXpxT3AxbEtkeHB4?=
 =?utf-8?B?Y0ZURkx1TXJZbGkxb1AvWG1aNTNScDBwNnBLVFpBUkhHNytoclA0QUlOaDAr?=
 =?utf-8?B?MGZGZktKRzJSNUEyNFlSNDdCekkxalY2SmhJRDd1Yk1uY2V4eHEyRVRtb3BM?=
 =?utf-8?B?emZsM2wrMWM3anpmUzNOdjV3dmRFQWZEVnRYOGdsVHBLcjBubU5odEVEYUhI?=
 =?utf-8?B?NzlVRllUNUhCeTFzNEhDWStKbmhjV1hQMlEvSm1HS0RvRzFpQXVLNEZiRWFL?=
 =?utf-8?B?ckhtM2RuWnZ4TlJkMENzem5FeEZLb3d2L2lhUkxlMldnZjM1N3A0RkhrL3hV?=
 =?utf-8?B?eHpxSEpWZ0J3QTJrcGR0bExkbnpRaGYzMzljaE1zQk1YK0JUSmkvOXJ1QTJ2?=
 =?utf-8?B?YkF3MlowSitqVyszRzJtNnhZemdrOFZxd1A0QW9jbTRsQU1aOXhmZ3JKTW5q?=
 =?utf-8?B?cHpmek0yUG1JMGdiMlhaNUkrRmZ4Wkl0VnBGcjdVNGdNNU9md2xuVnZqcTMx?=
 =?utf-8?B?SDFEZENTdEF5Njk0YVBsSTZvVm1oL2Znam1ZQ3YrdUE1dWZVT0JiOG5zbTQ1?=
 =?utf-8?B?dGZYcTBIUGhXcHVIYzFoQk1YZmVyTWdwb283OXF1c1JyaC9UbmhsTExSOHE4?=
 =?utf-8?B?SW11eHZIWGQrYU5FKzAvdTN0ZUYyc09BcjZIZDdzY2ZFTFh5eXJDMm5FL3pF?=
 =?utf-8?B?WDBXb1RObDYyeUYwYVN1b2JlU3JYK3ZqSjVkMVZKWkNET0ppUm5FK2dSY1Vz?=
 =?utf-8?B?b0t0WXNHU3gwbzBLcEl0V3JXUHk4MVZZaS9CdEZKTjVNY29wU2Z3RTFoelZp?=
 =?utf-8?B?aU1HUWl4anVCbnB2cXJJUUpUc25lQndkRWdYRDlGT25mMFd1RENSTlNYTEFx?=
 =?utf-8?B?Sm9EaG9NZkp3QXRTWGFZUVBoVGtGbndvZ1lWVE0ySjZMeVlYQUtFWW9PNkdt?=
 =?utf-8?B?VFZTemN4b2k0cTNkbjVWME1GYmp0Tk93ZmErYjZRVExnUG9Hc21NNW0vWWxS?=
 =?utf-8?B?WlZxOXNlZ2R4Q2ZNZUo5QUJTbGx4Vk5iRkV3ZTFDcm1nQmhEdCtoQUtBSzlh?=
 =?utf-8?B?N3ViL0xPVng3L0k1bEFKU00wbzQzTFBtK2FsWG1SN2drVnZKbDhTQjNzNFhW?=
 =?utf-8?B?bTQxUXpSV1RaR1o5VDVNVEFIcFNadDFaeTJPYUpxQWZSa01WWGEvdGZ6OWti?=
 =?utf-8?B?UjhzN0NzZEtXOVpoMy90SWVNdldwRXRtR2tpdndLNkJUNTJESWFLOU1sM0hZ?=
 =?utf-8?B?WTRqcVlQaDhoVkVDamZONXZIVEwxclhVSVphWm5BeFpSRUVuRDJuZjB5NFRt?=
 =?utf-8?B?UXNyWWtFZEV6MVF2MkwwdENOeGJlVElZeDZqVTVNajFHSGgxcldML3JOMjlE?=
 =?utf-8?B?dGU4OTJ4VWJRRE1KcG45cU9uZHhqRVVnMVVRQmpyRUttZEU3TVd0T3Rnc2E2?=
 =?utf-8?Q?sE+JP7IGNfXvMilPB0JHeXbkV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b49eaca8-a388-4956-6669-08dcb5768bff
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 17:46:34.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZqYDDyU5iPnmhIYTp3FAOhPkBtsS7TGQtLW29XiT53KsDDifapT/deaCl17uwqQ6WAE5Js534E7Oj4V7weJYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6093
X-OriginatorOrg: intel.com



On 8/2/24 08:16, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The idxd PMU is system-wide scope, which is supported by the generic
> perf_event subsystem now.
> 
> Set the scope for the idxd PMU and remove all the cpumask and hotplug
> codes.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

> ---
>   drivers/dma/idxd/idxd.h    |  7 ---
>   drivers/dma/idxd/init.c    |  3 --
>   drivers/dma/idxd/perfmon.c | 98 +-------------------------------------
>   3 files changed, 1 insertion(+), 107 deletions(-)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 868b724a3b75..d84e21daa991 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -124,7 +124,6 @@ struct idxd_pmu {
>   
>   	struct pmu pmu;
>   	char name[IDXD_NAME_SIZE];
> -	int cpu;
>   
>   	int n_counters;
>   	int counter_width;
> @@ -135,8 +134,6 @@ struct idxd_pmu {
>   
>   	unsigned long supported_filters;
>   	int n_filters;
> -
> -	struct hlist_node cpuhp_node;
>   };
>   
>   #define IDXD_MAX_PRIORITY	0xf
> @@ -803,14 +800,10 @@ void idxd_user_counter_increment(struct idxd_wq *wq, u32 pasid, int index);
>   int perfmon_pmu_init(struct idxd_device *idxd);
>   void perfmon_pmu_remove(struct idxd_device *idxd);
>   void perfmon_counter_overflow(struct idxd_device *idxd);
> -void perfmon_init(void);
> -void perfmon_exit(void);
>   #else
>   static inline int perfmon_pmu_init(struct idxd_device *idxd) { return 0; }
>   static inline void perfmon_pmu_remove(struct idxd_device *idxd) {}
>   static inline void perfmon_counter_overflow(struct idxd_device *idxd) {}
> -static inline void perfmon_init(void) {}
> -static inline void perfmon_exit(void) {}
>   #endif
>   
>   /* debugfs */
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 21f6905b554d..5725ea82c409 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -878,8 +878,6 @@ static int __init idxd_init_module(void)
>   	else
>   		support_enqcmd = true;
>   
> -	perfmon_init();
> -
>   	err = idxd_driver_register(&idxd_drv);
>   	if (err < 0)
>   		goto err_idxd_driver_register;
> @@ -928,7 +926,6 @@ static void __exit idxd_exit_module(void)
>   	idxd_driver_unregister(&idxd_drv);
>   	pci_unregister_driver(&idxd_pci_driver);
>   	idxd_cdev_remove();
> -	perfmon_exit();
>   	idxd_remove_debugfs();
>   }
>   module_exit(idxd_exit_module);
> diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
> index 5e94247e1ea7..f511cf15845b 100644
> --- a/drivers/dma/idxd/perfmon.c
> +++ b/drivers/dma/idxd/perfmon.c
> @@ -6,29 +6,6 @@
>   #include "idxd.h"
>   #include "perfmon.h"
>   
> -static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> -			    char *buf);
> -
> -static cpumask_t		perfmon_dsa_cpu_mask;
> -static bool			cpuhp_set_up;
> -static enum cpuhp_state		cpuhp_slot;
> -
> -/*
> - * perf userspace reads this attribute to determine which cpus to open
> - * counters on.  It's connected to perfmon_dsa_cpu_mask, which is
> - * maintained by the cpu hotplug handlers.
> - */
> -static DEVICE_ATTR_RO(cpumask);
> -
> -static struct attribute *perfmon_cpumask_attrs[] = {
> -	&dev_attr_cpumask.attr,
> -	NULL,
> -};
> -
> -static struct attribute_group cpumask_attr_group = {
> -	.attrs = perfmon_cpumask_attrs,
> -};
> -
>   /*
>    * These attributes specify the bits in the config word that the perf
>    * syscall uses to pass the event ids and categories to perfmon.
> @@ -67,16 +44,9 @@ static struct attribute_group perfmon_format_attr_group = {
>   
>   static const struct attribute_group *perfmon_attr_groups[] = {
>   	&perfmon_format_attr_group,
> -	&cpumask_attr_group,
>   	NULL,
>   };
>   
> -static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> -			    char *buf)
> -{
> -	return cpumap_print_to_pagebuf(true, buf, &perfmon_dsa_cpu_mask);
> -}
> -
>   static bool is_idxd_event(struct idxd_pmu *idxd_pmu, struct perf_event *event)
>   {
>   	return &idxd_pmu->pmu == event->pmu;
> @@ -217,7 +187,6 @@ static int perfmon_pmu_event_init(struct perf_event *event)
>   		return -EINVAL;
>   
>   	event->hw.event_base = ioread64(PERFMON_TABLE_OFFSET(idxd));
> -	event->cpu = idxd->idxd_pmu->cpu;
>   	event->hw.config = event->attr.config;
>   
>   	if (event->group_leader != event)
> @@ -488,6 +457,7 @@ static void idxd_pmu_init(struct idxd_pmu *idxd_pmu)
>   	idxd_pmu->pmu.stop		= perfmon_pmu_event_stop;
>   	idxd_pmu->pmu.read		= perfmon_pmu_event_update;
>   	idxd_pmu->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
> +	idxd_pmu->pmu.scope		= PERF_PMU_SCOPE_SYS_WIDE;
>   	idxd_pmu->pmu.module		= THIS_MODULE;
>   }
>   
> @@ -496,59 +466,17 @@ void perfmon_pmu_remove(struct idxd_device *idxd)
>   	if (!idxd->idxd_pmu)
>   		return;
>   
> -	cpuhp_state_remove_instance(cpuhp_slot, &idxd->idxd_pmu->cpuhp_node);
>   	perf_pmu_unregister(&idxd->idxd_pmu->pmu);
>   	kfree(idxd->idxd_pmu);
>   	idxd->idxd_pmu = NULL;
>   }
>   
> -static int perf_event_cpu_online(unsigned int cpu, struct hlist_node *node)
> -{
> -	struct idxd_pmu *idxd_pmu;
> -
> -	idxd_pmu = hlist_entry_safe(node, typeof(*idxd_pmu), cpuhp_node);
> -
> -	/* select the first online CPU as the designated reader */
> -	if (cpumask_empty(&perfmon_dsa_cpu_mask)) {
> -		cpumask_set_cpu(cpu, &perfmon_dsa_cpu_mask);
> -		idxd_pmu->cpu = cpu;
> -	}
> -
> -	return 0;
> -}
> -
> -static int perf_event_cpu_offline(unsigned int cpu, struct hlist_node *node)
> -{
> -	struct idxd_pmu *idxd_pmu;
> -	unsigned int target;
> -
> -	idxd_pmu = hlist_entry_safe(node, typeof(*idxd_pmu), cpuhp_node);
> -
> -	if (!cpumask_test_and_clear_cpu(cpu, &perfmon_dsa_cpu_mask))
> -		return 0;
> -
> -	target = cpumask_any_but(cpu_online_mask, cpu);
> -	/* migrate events if there is a valid target */
> -	if (target < nr_cpu_ids) {
> -		cpumask_set_cpu(target, &perfmon_dsa_cpu_mask);
> -		perf_pmu_migrate_context(&idxd_pmu->pmu, cpu, target);
> -	}
> -
> -	return 0;
> -}
> -
>   int perfmon_pmu_init(struct idxd_device *idxd)
>   {
>   	union idxd_perfcap perfcap;
>   	struct idxd_pmu *idxd_pmu;
>   	int rc = -ENODEV;
>   
> -	/*
> -	 * perfmon module initialization failed, nothing to do
> -	 */
> -	if (!cpuhp_set_up)
> -		return -ENODEV;
> -
>   	/*
>   	 * If perfmon_offset or num_counters is 0, it means perfmon is
>   	 * not supported on this hardware.
> @@ -624,11 +552,6 @@ int perfmon_pmu_init(struct idxd_device *idxd)
>   	if (rc)
>   		goto free;
>   
> -	rc = cpuhp_state_add_instance(cpuhp_slot, &idxd_pmu->cpuhp_node);
> -	if (rc) {
> -		perf_pmu_unregister(&idxd->idxd_pmu->pmu);
> -		goto free;
> -	}
>   out:
>   	return rc;
>   free:
> @@ -637,22 +560,3 @@ int perfmon_pmu_init(struct idxd_device *idxd)
>   
>   	goto out;
>   }
> -
> -void __init perfmon_init(void)
> -{
> -	int rc = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> -					 "driver/dma/idxd/perf:online",
> -					 perf_event_cpu_online,
> -					 perf_event_cpu_offline);
> -	if (WARN_ON(rc < 0))
> -		return;
> -
> -	cpuhp_slot = rc;
> -	cpuhp_set_up = true;
> -}
> -
> -void __exit perfmon_exit(void)
> -{
> -	if (cpuhp_set_up)
> -		cpuhp_remove_multi_state(cpuhp_slot);
> -}

