Return-Path: <dmaengine+bounces-3680-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B1B9BA322
	for <lists+dmaengine@lfdr.de>; Sun,  3 Nov 2024 00:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD8B1C20FF2
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0453F166308;
	Sat,  2 Nov 2024 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAelpd/X"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDDB16F910;
	Sat,  2 Nov 2024 23:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730591361; cv=fail; b=ChlSfTl29HxT5ol4RYIgrrUAijMp9YlRVeZ9Sq5Lvx+0jjA7RLbtuK+iqqlqvG0WUYCQYiZGg0jGw7erB5jIIQvDrxvMIgjR2BC5kisT20E6BGNwC8KpmGLPr+dhBc5T6e7u/cyJtImzTjJ7cSN2qColYdFF+pTBi2HwE1HrK+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730591361; c=relaxed/simple;
	bh=qYeWjudWJ/gARvv2Y/yJMk/yO68GR6EkTwqRjw09EHo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mbLFQyphhBCoOZSHmavvACgj4ik+t9LKN0XQ5igFF6XuN+XpZFA0K0Ck3RjfafEjI7NCpcbcbu4gWohiuKVOlGNaDBzGggZf0Xu1nH9vnLxW16EWzERp9QHS2gH8GzOisOT4ewMfZ77kfkW8VXqxyOAPYUrxLagJAqTTydClePc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAelpd/X; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730591360; x=1762127360;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qYeWjudWJ/gARvv2Y/yJMk/yO68GR6EkTwqRjw09EHo=;
  b=AAelpd/Xv6OkG2jcTVPi9smT54Dw4pnsuTcPDIa2YwC9hiKHO1k8QKDp
   bcfTHq0Y3wPdSQMzbgP7bW4h0ty2t1gzqPbaa0mGAnkQZMvp+ihfRHAlE
   hbAI5Cd0nAHhL0eX0C1iKKKt7ATc3MoFZEbrUbQyS6o54lYVDxkuf0tRy
   eRmOgqcwVGd4l1Y07dpdEqERQfUk5PE4tpcRMR9D6yel/cgX35ghtNK7j
   gAyE9ab1g26QIEHz4at6Vg0tOc8DwsiL7y6epGQBYS1bkWQux+zHINU8g
   b2AnmLxLHR3Qm54LZ6t8jBjF/tx07vrTOkLFmsjF3CsrEaKDqupG1Y1pu
   g==;
X-CSE-ConnectionGUID: 6RF2Bom4TbmvmpCukoCKHA==
X-CSE-MsgGUID: VF3XodwtSn+tLnnQ/6XWbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41413869"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41413869"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 16:49:19 -0700
X-CSE-ConnectionGUID: d6agJw1xTiSFxrNdZ8GpTw==
X-CSE-MsgGUID: Xy07Gg6iSMCBerDaDt1Opg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="83179710"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2024 16:49:18 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 2 Nov 2024 16:49:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 2 Nov 2024 16:49:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 2 Nov 2024 16:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIyN7Su2I8s4v6fQWr44W7cOfKw0G98O/Fmm/z6kSq01UWqc6JTZ3/HrTj5qxDDcbnWxRTx4mRfIAOBX0u6TxDfJ+keq5iWy29vSEM1iIe55AZ7bFAMZ/+S2V6HWWxQeAfnA8ieK4GLCDWuQ/jRFloebeFcwQQplVmY+jA6uGegtqdE/D4FMUeq/6idCz23O2jyDt+sWYckEu4hQG4ae1a/RN4E5KQfc4TDoDZkuGfbNN4reK3L8wpT+8kMYm8HqQY0lG0oiFdumNHljBcj3Uo8E/jVrKVUn+x9VUimEOopwnd3U3GW9I13EYqJm7dOUuIUbz1JnFGginpzskKBnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6tE8o4nj38ez3UhSNYsXnDdc5bYfnPxVr3wxWSTonw=;
 b=GAOWVU3VJPir9aesDdo3aKfUxf6Jp/sAvbGeG9K1g02Wz4Ko2QjPrvzevslWZ0OQbCl5cC1YawFby6zVjwfz3rz++V+NmXudWM41yJpX1O5ZfCB/nU6ymkJkcuy/vzOcWLz/VF4FPSjx/vc+nARpe76uMze9ptW2DfmOVboH7vtUIcJvCvkyVJjPGlDEH/6Vx3abpqOHNqTpSwfF9EV36DtGpEZfVIMKxDHC0jjz0ug3QVD8cBxl4mpT7cffnw1InN95qKerLkh7stakcPMEhAvhvNe09VDewtVVULAcdNo798LqpH35kntuUWHIpX9AywQ8AFqZT0ijXbLUJCGHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA2PR11MB5033.namprd11.prod.outlook.com (2603:10b6:806:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Sat, 2 Nov
 2024 23:49:15 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.8114.028; Sat, 2 Nov 2024
 23:49:15 +0000
Message-ID: <5bcd5045-d1f4-fa0f-acc9-31517cd456cc@intel.com>
Date: Sat, 2 Nov 2024 16:49:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Remove a useless mutex
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dave Jiang
	<dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
References: <e08df764e7046178ada4ec066852c0ce65410373.1730547933.git.christophe.jaillet@wanadoo.fr>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <e08df764e7046178ada4ec066852c0ce65410373.1730547933.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::36) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA2PR11MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: d817c393-85e5-4dbd-5fbc-08dcfb98f556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2NLR1FlTUEzL3gvMFc2c3VxRGRYVTFmVmplS1h2dWNrWXMxdmpMOXVKTWhR?=
 =?utf-8?B?OXpzRlVSdWNubjlPWVNFby9idndoVG5lZVZRTk5zbmxTSmdqaEFXSkpicjRz?=
 =?utf-8?B?S1E4WFQxTzR2U1lIRy93S3BYZzVhOFVWOVVGT1dOTGtPNE00TmtKRk5lU2s0?=
 =?utf-8?B?NXlpNFJ0NG1SSU9kNVFxdUFiVzljY3hCeXNCeGZOQW5uaDZDT3lLRGlFUlcy?=
 =?utf-8?B?T1p1Mk9TWCtKS3hDOXFORWZnUnFmdnlUZXpERzJuclJOREtFY3RQK1l4UU9S?=
 =?utf-8?B?Q3NadU03MEMxSUovM0tyMDFPTmxiY08vNUJjcWVKWVJGU2RrOFNZQ3VFOGpF?=
 =?utf-8?B?SlpFRmI3K0gxQjlFa0crWE5sS3V6UERjZnI3WVI5NHM2RDVXT25tUWRzdk14?=
 =?utf-8?B?T2l0Zk15UjhGL1VmblBrMzVGYzVKbmxIQ3hFZHg5N3E0c3RzYXVGQTc3cCtH?=
 =?utf-8?B?VHBjaFRjZXBVSnRUOGFnR0J4OG5VODhBMzA5VlJyRW1xdmFTdVRybURCbnJ2?=
 =?utf-8?B?ZWkwRzBiVTJOZEczdG9wMHZkYWM1c0YvZnpRUEpIbCtLZTdlbkxtbEdKRkh3?=
 =?utf-8?B?VEVGWTBTSXBKdnBMMjBXejNIRzE3VzUvYmY5dnRpbGwwWkVUU055S05OOC9l?=
 =?utf-8?B?OWdNS0lmNnd4bXJYWCtsbk5vQlZTVUtQV3dlOVdwd1JNeGVBVGI1Wkc1bkZ2?=
 =?utf-8?B?SVF5VWFRYXV3Y21hejhPK0RjZnFwbEcrTXI2NlNlSmxWSnVNdnBzT3JSTldC?=
 =?utf-8?B?MHV2ZkdUT1BVUnY2VHhVN0xRUW1BWXViN3hFc0lMcU1QK3ovRkwyNWs4U3BJ?=
 =?utf-8?B?WW5WWGdsMFNDVEprazA1TTUwVlMxUSt2RFZDcHIrbnhkc3dia3lJUnVZOC8v?=
 =?utf-8?B?cDFsODM1dU1qSlgvd2R2bmZ1dXNGU3RsY3BLTy9KZUR5SVhJSEJ6Njd5c0tY?=
 =?utf-8?B?T1J5M2VBYzhvQTVoVjBqTlBBaENNaUhRWUtVZ2cwVTYrY3MrYlk4c2Jma2ls?=
 =?utf-8?B?bEJHZjJYSy9xUW5rc1drR0VCTVg4aUJtdmwzdnpoZEhrU0ExQnpxbDhZVy9L?=
 =?utf-8?B?ZDJsNitESFVYVWFSSkFRSEhGbXJEOWVtWFlpdHFzMzNMeEpKUkpoN1VGVkZK?=
 =?utf-8?B?MmhFc0Y0TzBzS2ttYVBjcFovdE1JTWJzZHdpV0VlU3haaDZjVVBJYWkwWGpn?=
 =?utf-8?B?L0JXcUd4dWluQk5YbmhVMkFNbVpjb1BGYjNOOXdNTEJIR2NDWWNBV3pqLzlE?=
 =?utf-8?B?NlBSN21tZnJ1elNaNHZuTVNuMU1qQUFTL2l0UDBmVlFOTUM3b3dXYks1YXN5?=
 =?utf-8?B?SENJUkMwVHRZMFdibVg5UHczSXFpQi9TSHZyOHdxVVRiR1htTndBM1lEbnQr?=
 =?utf-8?B?dkFxWnFpZ0NMeUhObDdxUUZpT3Y3K3NJaGlBcE9IcVVhWWZuYkNVeXUxbkRB?=
 =?utf-8?B?RTBhUmxHemRFamdyS1kxTkxEbklnWk9RZDU3ZGx5MExsOENhSW1HK2pQdGhO?=
 =?utf-8?B?WUdydnNFdHAwSDlWbjNSWUVXSE1ZUUZDUGpEaEJyN3FsazZheGhWOC9SUHFp?=
 =?utf-8?B?WkN3K294S2dvNDRYSSt2R1dXa2xxZGZzUzhnN2FlZEJ2bnRNWDlLNFc0eVdJ?=
 =?utf-8?B?RGk5UjBMZjRVSXU1d0FmUjRjaWJlN0tiOHd6MTRFM3FrUmdSOHVuTnV4VFA1?=
 =?utf-8?B?b3RRQ3YzZlRWVWE1M0pzbnJRT1R3WGFxakUzS3IrQ0drSWVKcTBWV1N3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzZOblgzTXpNcmhkK1RRZnFGckNYaXVTeWVwSXByK21mNWxHaHEySWQ0SStJ?=
 =?utf-8?B?cE9ndHVDSUFOak94Q016WFVZWDRJZlYrTHpnUTBoQUJMVHRBNlRvTTk2cllp?=
 =?utf-8?B?c0FPV0FmRXBNTDRlOHo3RnYzRmNEVjBsbzRIcXJjeGJldURrR01KNlpDTjhH?=
 =?utf-8?B?SURuYlBrSTJuK2JqL3VXYWhmTHdYdklXZnBWdjNXY0NQRTlYOVJ0eENPZS91?=
 =?utf-8?B?OEttbElvRWhIZk5LaWlFZXdiNjh2L3dYY1dkVjBPU205NVhBK2xRNXJQRzdm?=
 =?utf-8?B?bkpEem9JWGwxc2JiM2NLS2JISDg2NEVMS2l4YVhnTXJHWmJ6aERuZFVPRThH?=
 =?utf-8?B?K0pWMWJiRFpPOUpuakpUYjNHcGxIQzFRQkJodjgvTmFXM1BhOGJVWkdMOXJ1?=
 =?utf-8?B?RU5NdkNQSVpMb2Fhcm95SFUvQVdIV3FvcWdlOFp6MTFqZDNpNE9jaU9hSUNm?=
 =?utf-8?B?MFpvSnAxMFhjZzQ0YUU1Y2JsTjZQd0w4L3J2VUdIVStrQzJWMGErc1FZa2tL?=
 =?utf-8?B?aTBmU3Z6OTZFZVZpTGZ3QTRjR3prb1Z3WFlWOFJVbm5Zb3RLais0RmlKVVMv?=
 =?utf-8?B?ZFdVQW94UE0wallUbEhyRlpnM1VpbVJxbzdCdVd2WlRjc1lxTW04YnVCUFJ2?=
 =?utf-8?B?eHNFSng0U2daODZuai9ndkRiZmQ4ZGJmd09hYXh4LzlVbTZPU01kbGNIU2o2?=
 =?utf-8?B?ejJndS9aa1FBaiswZEdWOGZGSjlnK0tOaUZpZ3dzQVNVMWVHdG1yYzZVSSsv?=
 =?utf-8?B?S1N0UFVpaEh2N2JuUE5sTWhjeXR6TTFyZmlBZnRPVlJ0NENjUTYyN1ZXNElU?=
 =?utf-8?B?bGJ6Q1VGWXVKQ3FUSCt4U1dMdXJhekFyTjVaRHc4ZFFTQXhXWnlxVkNIeWJG?=
 =?utf-8?B?TlZ3Nk5LaCtBbHgzL1ZMbE90MXdyd1NzUCtrcTNyWldzdkcrazVQdmpXcTFR?=
 =?utf-8?B?VHVyRktVZnField5Z3REYXBLWHBzZHVDTEdCZkNuL0VkTWFTRlg5WmJwdzdU?=
 =?utf-8?B?cHkzUkZKbGtBeVpuOVJHNG9Ecjh0SUx0TmUyam9HVkE4WldKYkIrTkljOXBU?=
 =?utf-8?B?YzRSUHhLQW9yUHllditXYkRFVXdON3YydEFjb3FUYXZPNm0vMDNhZ0ltMHc1?=
 =?utf-8?B?L2Ewayt1cjBpK0JLcnk2Vnk2U1M5Q0NETDJ5Q1VhT1VUVzZSbWxpdGtVNGxI?=
 =?utf-8?B?aWI4b0lzVDdwbGZXeHUyUlFOS1lTNllqOUt6Q2xOa21qUjV1QjVOYXk4ajc1?=
 =?utf-8?B?SUZXWUN1bTBWMzlNU1F0dDFnZ3VhMDkwaTVpRFRWMFpTaGFhdno3cVFkWm9O?=
 =?utf-8?B?cGlOdGg3ZG9kMFpkVFZKY0xtVTNYazRsK05DYjR0dGxHUVBlOWFvZlNRcC8w?=
 =?utf-8?B?WU5JaE9RNlo1bjQxa0JXc3YyV1pDd21LVVRtT2YwRUtsSzk4VXphRTN4QjRz?=
 =?utf-8?B?YjZJbkZITU9rQ0NDenR0Q0daZ3dwN25oUzFmUHY4dWgyRkc3MWM1TUFlYWVh?=
 =?utf-8?B?K3QwR3NSVk9CTklYaE9MK2M5SVRqdmlJOGR1SkhubzI3dlhHTmkvYWhseFdO?=
 =?utf-8?B?bFRtMWhCMU9rbkFndXF6dURBU3BrdW8wSWtlcjhRMGc1ZEh4OElBR3EzTG9J?=
 =?utf-8?B?c2d6em9xYmd5OUdPaWVPQzROQTlUa1BWaXpabHQveWs3azkzdGVCMVBlWWtI?=
 =?utf-8?B?NENmc1lmLzJVcDBqNGdyTi90c0V0a1doVG1rRFJkbStTemhYU1k1ZTZKenNy?=
 =?utf-8?B?V3FPSzUvVXgxbFNmRkZFUFVxVW1xUlc1WlQ0TDZ3V2xLSHpLbXZaUmZxM3pZ?=
 =?utf-8?B?WTM1ODlzZWQxd2NTbFduMHZnOVFIMUxmTERYcnRlY3ZKQkFvaldNYzZTTU5D?=
 =?utf-8?B?Nk9GbWI2RDIwV2VJVTRBYkZxM21vYmk0UEN6YUlxNHpFVnNEM1lzWCtPN21m?=
 =?utf-8?B?TEZub2d6ejB2T0cvTG94VmI3WlJ5ZjJPekhtVlJkNktxQUtSNnMybFhsem9u?=
 =?utf-8?B?MkhyQmU2WHJoK0NBRXB2NmV1ZXFkUFJlcDk0Nm96ZzQ1T0c2YTRteGZSS01p?=
 =?utf-8?B?MS9xRWtVVXpFNWlzQk1VK3BTU2duSEk5M3JkQVBGRVQxZDNVeTlwVTcxMXY5?=
 =?utf-8?Q?Du9bN5vTBstNbJLslyJQOL244?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d817c393-85e5-4dbd-5fbc-08dcfb98f556
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2024 23:49:15.1741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwVbwrLvJa7vhM/VG+eRcvNugS0xVDE7P/5YJYgqoW7EQ5taUjOIl22H5RHGt2ejzTm9/iidCB85UswLSSPTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5033
X-OriginatorOrg: intel.com



On 11/2/24 04:46, Christophe JAILLET wrote:
> ida_alloc()/ida_free() don't need any mutex, so remove this one.
> 
> It was introduced by commit e6fd6d7e5f0f ("dmaengine: idxd: add a device to
> represent the file opened").
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

> ---
> See:
> https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L375
> https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L484
> ---
>   drivers/dma/idxd/cdev.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 57f1bf2ab20b..ff94ee892339 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -28,7 +28,6 @@ struct idxd_cdev_context {
>    * global to avoid conflict file names.
>    */
>   static DEFINE_IDA(file_ida);
> -static DEFINE_MUTEX(ida_lock);
>   
>   /*
>    * ictx is an array based off of accelerator types. enum idxd_type
> @@ -123,9 +122,7 @@ static void idxd_file_dev_release(struct device *dev)
>   	struct idxd_device *idxd = wq->idxd;
>   	int rc;
>   
> -	mutex_lock(&ida_lock);
>   	ida_free(&file_ida, ctx->id);
> -	mutex_unlock(&ida_lock);
>   
>   	/* Wait for in-flight operations to complete. */
>   	if (wq_shared(wq)) {
> @@ -284,9 +281,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>   	}
>   
>   	idxd_cdev = wq->idxd_cdev;
> -	mutex_lock(&ida_lock);
>   	ctx->id = ida_alloc(&file_ida, GFP_KERNEL);
> -	mutex_unlock(&ida_lock);
>   	if (ctx->id < 0) {
>   		dev_warn(dev, "ida alloc failure\n");
>   		goto failed_ida;

