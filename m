Return-Path: <dmaengine+bounces-6757-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC4BB762D
	for <lists+dmaengine@lfdr.de>; Fri, 03 Oct 2025 17:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC274A1D42
	for <lists+dmaengine@lfdr.de>; Fri,  3 Oct 2025 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69D628724D;
	Fri,  3 Oct 2025 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOeOBWDd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5102857C6;
	Fri,  3 Oct 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506543; cv=fail; b=SlwHxcerKA25xR5V0hfSJ0F+7gROpHeAqLGe/t2QvjzWvlShoF5Z/4QkbOymoNTrYCRkzpw+TeNr7+YzJFmrX5ESg5V7eRlGH3nzNyxsCdwtIz451GzsP/BlLQTOWPL3GTmwNyFaikTMo7mGcxqtMidSNWzcQ2t0gR0LTkQYVnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506543; c=relaxed/simple;
	bh=kUBLGgRU6QCc0GCPXnf49QlQUqHnDYKeCJ2dLuF2gVY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EzwCFe553Vi66fpdPcpuelYF6LxNbWlVZO391oH3CEHAnC55QmC9u8O5/3feOPeULIF+luuDkO1ljOkxqNlCc+M10PdtOuu+rf3BP44rs1c1L3m+Z6aOCNmXfes31S4iPw1NJDbDxCCXWIrG6P8U1DD0VjX1PBplSW4IQ8+uLW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOeOBWDd; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759506542; x=1791042542;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kUBLGgRU6QCc0GCPXnf49QlQUqHnDYKeCJ2dLuF2gVY=;
  b=MOeOBWDdTBeyxcJpTbww+hfDDOEtOeHFNs1T6i2HMj991uOZSWDWxI82
   umSqf1/KojT5xM99ysuUBnMinB7/Go3gdp1alcY8Zka6j4E0quLnHMnar
   SGkghXVhEMvBmyftepj4k90tQuIbe7hL4RNSPpE+o1TWFqgyLdh8E7OO8
   kIZLansUemz6eXEryCFF8FIt2xpJ05Yrj5p9ZPV8/MPnJhL/UZZ02TIk2
   kQeuO9SKlqWhi4Grd+EV+LWBf1wX/mDwJEKgitd31BlrEEVEpqaxoPX84
   baReDsShppMCUoK3Q3JO1lpvYjl4FGG/O9BjqYGMg49K/CdP1nc6FF6R9
   Q==;
X-CSE-ConnectionGUID: IubGWMugTnW6BtiGns4fLw==
X-CSE-MsgGUID: +qHsGlOpT5KYWm9Iwyzcrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61891920"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="61891920"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 08:49:00 -0700
X-CSE-ConnectionGUID: 5i2Nt0s7SqKD0Ubf5aaY6w==
X-CSE-MsgGUID: af3iRD6VTLKyTCGa2Hv1Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="178609190"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 08:48:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 08:48:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 3 Oct 2025 08:48:57 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 08:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oj8nDwKOPMjVhXRVwGh52kjU4YElnWrGJLof+5V2Tu6TDgqpSN1vbZCoUH8nFy0lINx1aDlS5CciD+esoz4rzbxkwrponJKi9clGcspWP694583unMEmpPtUIViEvckTBUazcwwpx6Bk3vAP1wP/0XofilIUVschqzMDv/5rXniSw6Ws9mUIoS5OvJM6rOdV0UwhQ1UEMbnvewkSQ4gL2CjFi6Y0oClyguv2uhJT52St8AX7m89/I+/2gdcDDWuXI7XhCt51Qc3QnqPdi/b/fbHkCTkZkPOblT9thObEmBo9Ivqb4Nr60xW9v3dwRyDHmlHywZHj9r7yVesXxTP+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUBLGgRU6QCc0GCPXnf49QlQUqHnDYKeCJ2dLuF2gVY=;
 b=YpMknOXXIPTmZhtUtaDVMwEL8Mk0NiQkVyFiCJzD4OV1+PCVgIePSk6xh22lWX2NXBVUxXTUOQInl1zSmZqVzxdd5n+GkfYkXjAaAx9aaiZwJRtfl9+qWzzdSZhfIiJVnmwB9eED9E8+BWNanV38phPPgs07p0Ah6QBn7gHPlGrZy/S6aU1H+Z5UhUv6ijaH48hbDqpfk5p8gWxhs42UZPkk0OQdjj0oj05KYc7cMZ3zIK/nwHaPvp7DXZYevrEzEmqTB9oXsVLl7K/nqwEQ6aW6P0c4UqtanX7Mjxi7T6u8gzr+FIv5BHVk/kHbAmOEN4zLbp9dbNV5P84PRCmp8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7604.namprd11.prod.outlook.com (2603:10b6:806:343::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.17; Fri, 3 Oct
 2025 15:48:50 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 15:48:50 +0000
Message-ID: <87371abc-e43f-4afb-83d0-b9a04fc015c0@intel.com>
Date: Fri, 3 Oct 2025 17:48:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: what about CoC?
To: Michael Shigorin <mike@altlinux.org>, Michael Shigorin <mike@altlinux.ru>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Tor Vic
	<torvic9@mailbox.org>, Kexy Biscuit <kexybiscuit@aosc.io>, <jeffbai@aosc.io>,
	<gregkh@linuxfoundation.org>, <wangyuli@uniontech.com>, <aospan@netup.ru>,
	<conor.dooley@microchip.com>, <ddrokosov@sberdevices.ru>,
	<dmaengine@vger.kernel.org>, <dushistov@mail.ru>, <fancer.lancer@gmail.com>,
	<geert@linux-m68k.org>, <hoan@os.amperecomputing.com>,
	<ink@jurassic.park.msu.ru>, <linux-alpha@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-fpga@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <mattst88@gmail.com>,
	<netdev@vger.kernel.org>, <nikita@trvn.ru>, <ntb@lists.linux.dev>,
	<patches@lists.linux.dev>, <richard.henderson@linaro.org>,
	<s.shtylyov@omp.ru>, <serjk@netup.ru>, <shc_work@mail.ru>,
	<tsbogend@alpha.franken.de>, <v.georgiev@metrotek.ru>,
	<wsa+renesas@sang-engineering.com>, <xeb@mail.ru>
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
 <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
 <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <20241024095339.GA32487@imap.altlinux.org>
 <20251001101148.GA30625@imap.altlinux.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251001101148.GA30625@imap.altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:803:14::35) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dac509b-db06-47ab-b974-08de029458ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVBhRGI1cTFFK2NNQ3VaWU9ncEdXb1phYjlZVTI5bERSSXVGYzJMRUc1VHNr?=
 =?utf-8?B?OXU5VlcvSGNZcERFRVByZ01HSU1sWXVxazI5b0lHV3BXZVZCeTFtdW1kM2xp?=
 =?utf-8?B?MDYzMEJFUlJPQW1OanJ0RkI4Rkdqdzl2cjRISURvMWxuU2ptTWxBV0p5VGla?=
 =?utf-8?B?VFFhbjc5UlU5bFgxUnMrNUtIbmJIQnFwNk5WMlNGZ3d4SHRaVVlTc2J2ZlFv?=
 =?utf-8?B?Mm8xSHRRTXVXNXBaSmMwWU9uOHF5bmNKcDF3S2o1RG16NFJ6aWdqS29ETUFr?=
 =?utf-8?B?c1ZuQmg4K3ZPdG04TGxkOVBxWXlnZHlPU3hEVlJpaEZHdlFaU1R4VDdad2xP?=
 =?utf-8?B?NXpyQ0lpNDg2dzgzVnpTLzBUT0h5a1czTERpMkNrSlE0aUUwM2tzNzFtMFJ2?=
 =?utf-8?B?Ykh0UUlpTjNhT3BjYkZ3alpiRmpMSWZ3dndsQXFrRWV3bEZjenlTT2JTQ1pC?=
 =?utf-8?B?MUdlMWtoYWRvSlFwbDU0ZHJRdmg5Um5mYUorVFZPWlVRK0JLaEVyQ3Y3cVFY?=
 =?utf-8?B?UzBGVGxQbnE5dkFlWGk3SGhyWVB5KzNDNUxYZW8vSm5CMTNXc3NHbXJWdnN1?=
 =?utf-8?B?bGpqeGhIZzl6TTBObGQzeWJaSDdHMmVCOTFobnNESUtGME9oOWdiVmFWdVpZ?=
 =?utf-8?B?ZzM2dDA0SGF2NUFHbDRYTTNZaXZiaDJQRDhVUHlEWDRHOUx4cTNReUtOVDla?=
 =?utf-8?B?TWdpc0RNd3hEN3p3WnRsNEovd2Vhc1cxbFhyazNhV01YRmVtUUJNQVRsYVBT?=
 =?utf-8?B?Y21KaFp3YmdZSmFGSW5RY3ZlL0NWR2dQT1ZWY3pWRUJLNi9mYW9ISThhNDhh?=
 =?utf-8?B?Wk1QY21KaDBuSGNGUEgycjRrenlGV2dXcDJIb2VBdlQ4RTFXREQ1L3ovQUlM?=
 =?utf-8?B?TERRL3dWZTA3a3VZZ29XRFl5ZkNQdUZ2L251RWZjWS9HbHdaZWpxSlJHam1Q?=
 =?utf-8?B?NlV1OWd1NXdrek55dXUrUzJ0REQ3eHRYSUUrV3BsZUFUWXVPMmlYZGFBSG13?=
 =?utf-8?B?R2ZLUHRRWUlFS21iODFzY3dENS9pczdFV3E4Sm5QaHVLeGFER1YrT013YXlW?=
 =?utf-8?B?SDA2OXZacEJzK3JOSGNuZ0xNR1A0aVphQ3cxbVgwMGxpeDlNVXVFekJ6d3Zv?=
 =?utf-8?B?MkVoa1krOEo2YkdVKzBpUzhZMkcwR1NxZEFhN3NERUJKb2FqRVVVNXdxYXA5?=
 =?utf-8?B?bjR2YUxZU1ZmS0c5bXluMmhJVi94MnpCNGI1QzBuWDJFMzZtekpXamlVY01T?=
 =?utf-8?B?K3MrRGhDdmg3YnFtc0VhQi84VXhHSmFTU0E2NGkxcStnQ2JnaE9hQTBnOEhi?=
 =?utf-8?B?aFhvb2N0TUp6Z25USTNRMEZiWDBuWktUSFlITzFFRWxMYTkzMld4YnFJVG9Y?=
 =?utf-8?B?bWZRTXFSNlk0NDl5bytGZlBVUWlGM0tZNzVwZVFsdFQ4QXNyeVRacGFDK3ZD?=
 =?utf-8?B?VkFZMFNVSnRrd0VEV2ZjaVZQcHl6THZTVTRoUzV4RE5Ed25TQUxZR0NoZWJs?=
 =?utf-8?B?YW9DdmZPZWduWk5ReWIrRFJMbE5zT0Ntc3dIdEFJNG41Vkw2M0lFQkFnVHY5?=
 =?utf-8?B?VWpmd0RGU2N3UzEybUtjeFR1ejlmMW90eUp1Tm5sQThPbDg2NWpoZ0t2Ynpy?=
 =?utf-8?B?bWhra3hGMVZDOEJ4YlpYeGRJN0N3RlpoaXo5Tk0rUEZTcjJ4SlRhUzNzQVpy?=
 =?utf-8?B?M3g0TWdxaENaZC9vR2JaUytUeHJMVjZnOFNsVDNZczYyMDFIRXpGbXZCekht?=
 =?utf-8?B?K3dLbUhWRytDWEp0bXFsMVJqLy91b09KeVBuN2d0VjgzR1pSdzNycGIvL3po?=
 =?utf-8?B?YU1CL0xxa0RGTkVOYjVqdTVybXJYdHBjWmhlZER5Z29TalZ5VzgwTWdHdnBm?=
 =?utf-8?B?Zmo2RVdCNzJLdE5rbWRqRldBWHU2b2JZWURXamk4cFAwMVpEdWpsbUIxaUVC?=
 =?utf-8?Q?vfEhWA2NCZGUSs6vq8745Nk93K8a09W6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNPc1V1ODBrRC9SQnpQRWVWQ3lETzkrM25XZW1VWCtpNXBIYWNTbjM2M0J2?=
 =?utf-8?B?N1d0L0FLTUQzaHNxNk0zRFBKUWZrZGR6MkZjZWFQUXRqaDhDZ2E2TmhJZnZv?=
 =?utf-8?B?YWpuancydTBnemxOVzZsK3BBYWdUVFlNRndWNTZ2ZlhqK1VCV29CZlBPcm9N?=
 =?utf-8?B?RXRUUVErSzNtN3NGTjAxWFMzQ25nWWVtU3BTa3ppM1RBRit1T09IL1pyeCtl?=
 =?utf-8?B?VWV1Z3BUeVBsUmZXL25uQVlzMk1keGxLVzNUb0w2NU1QWWdlRkE1Y0RXZk9r?=
 =?utf-8?B?QlEyREV3ZzR6RVo0T2JCUVUxRWNCQ0xKenpNdlRiaUZJS1V3K3loVXAvQ3JQ?=
 =?utf-8?B?UGVWeU9YUk14bWUzRXVCd1VEanZaRW5nOHVra0E2ZG8rK3IyZFNUY0F3eVZj?=
 =?utf-8?B?TGNGejhPUVVzd2IyZnVJRk1ZSURkbzlNR0E4bXhvbGtJRkI3dGZtUWcxTDVY?=
 =?utf-8?B?cUpobDdnbDVXNkIwL0lVeUd5V29EY2xCc204K0ZBVHNsajlhRForUVd4U1hn?=
 =?utf-8?B?S3p4eUhTOURaVHdDYVFpWG56T00wY1IrQ01qSWNyaXNXdjdTbUZHNTFDS1Ny?=
 =?utf-8?B?STlvV20yeXR2c1ZkaTYzOEJZL1BFTWF1bWt1MUROblR0dFUvcHU4d0dISHV6?=
 =?utf-8?B?WE9LNGF4VXFuUDhuOGhzbUtMc0s2Z2ZFVjc4Zkk0UC90VGlnTUZEak5QbnNM?=
 =?utf-8?B?YVF0NjZnT1d6a3VRYUUvb3NOTEtISzF4M0RTSjZGcUVzcjFXbUE5bGp5VkJ4?=
 =?utf-8?B?Vk9YK1F5bktGbkN0RmRqdU8zc1hCbFZEa294ek1RTDRyV29yMHFHZng1RmRj?=
 =?utf-8?B?STdwRkJDN0pjU3gyZTdmcHpGejRYMkxzU3hKQjFGTENBNXJBQzc3MzYxK0xl?=
 =?utf-8?B?S3EvQXVCRnUydmIvYmJGYXJVWkRvajQyWUtGZ0hrOE12V0RCMElNdlRDU21N?=
 =?utf-8?B?b0hoVVU3dzgxQTBOVXZzdi95NVd5NCtzcGpMOXlQZk1MbE41SXdsYlJqSzIy?=
 =?utf-8?B?SkE0UVB6T09MUlpxN0VYUWVhR3lHamxHNHhKT0wwN3FlYlQwUHM3WnBMRUUv?=
 =?utf-8?B?NTlkQU8yTVlhQ3lBdng5ckM2bGppY1QvV3hWQU9IdHBWYm45VFdpWHlwL3Fp?=
 =?utf-8?B?RnpyWDVqamtzMXZDZjBoWml5czNUK25nODFBK05xdEJGQTBjZEpJNUhiWlJ4?=
 =?utf-8?B?SDZuQjlNQUFpQWxnMHB2WTliWGRXZmhrZlQ4aFUwMUhMdGhCK3NDdHp4Y2ky?=
 =?utf-8?B?dHVLK1BLYjNUbURVVVhPQnlYVGVuWnVucUZFaTYxdTZwUUJmMXhGRkpRcHZy?=
 =?utf-8?B?LzRML3FGNlpoL0VBa0tlZVY1NjVqOTVYMDYzUUxUWDVxM3lmdG1SSUlaZksr?=
 =?utf-8?B?VHJXdE0wWVNlNE9NbU9RMk9qM2NDQ2FKWlE4Sm51RjBWTFI1WGVpOEJvWU8y?=
 =?utf-8?B?Mk5aVUJXZkJ6WElVRlpEUEl3b3pENU9CMFN5M05SUUtkZUZQV1p2MFE4TFhD?=
 =?utf-8?B?aDM5T0lIUGVxM0NxRE8zZkV3am1rVkY4OEowclNkNk9FK1BuU3BYLzZ6ZHds?=
 =?utf-8?B?Szc1dTRERXVLY000NnF4Rk9OS2o1UkRXTVB1MW9lTmRFazRuWWZvakNkamRu?=
 =?utf-8?B?Y1dsOVdad1hYa29xeE1uUGNmZGNCelpoR3NLTVR0ZlpIS3ZEN1BuQi9MWWZZ?=
 =?utf-8?B?K2E3VHZJVXZJN1JLT2daRE5LQ2Zmbk9LeUlpTE5RNFFXbHpsaUV1NUdDclhl?=
 =?utf-8?B?dHVPSGx6UUl2eGlMUWF5MFlRT0NEam50M0V3Y2hpL2xXQnNyMVhVd1JoT3Rs?=
 =?utf-8?B?RTJJdStSaTQwSUZrbG9SRDRJZmlnV2Z2VHAvZFp0R3lYdDZEc1RKdXBpUERZ?=
 =?utf-8?B?SHVGN3RBVlFmaUIxYkJxanVQWG4xYmEzZU1WQUFmdXlYeVVKSFVNUGFxbDNT?=
 =?utf-8?B?MjBMN2ZCeUM5QnFSOGJrVWNNUFJnWjdUd1ZUd0h6VThsdVVib2VwVGhEQ2ZQ?=
 =?utf-8?B?K2xvd1NCZDN6OExRbFR0NHVFdCtqaWhUbEJXdUI1WnJ6K1VJejJWeERLcWhi?=
 =?utf-8?B?YzdkYzhnZ3ljbktGd05iWHI1VDJXZ0toalpOTkxlZ0E3QXVUNHdkK2lPL0gr?=
 =?utf-8?B?WnJHWm9GcGNyb3FXUkxDT0pMUnY1WTFhZEt2SWpydTdON2s5UHBlQ2FXalEz?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dac509b-db06-47ab-b974-08de029458ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 15:48:50.6325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nV3bymv1Wz6e3RtyX9Czh+WNorBbWfWqydjltySSx0tzs3Y1nyD2ODuC9YnT19fqoTwU9a91Vo8BqAWm2hkfgOGDXrU4Zb6n0YPW24Sbq6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7604
X-OriginatorOrg: intel.com

From: Michael Shigorin <mike@altlinux.org>
Date: Wed, 1 Oct 2025 13:11:48 +0300

> On Thu, Oct 24, 2024 at 12:53:39PM +0300, I wrote
>> It's not about the patch but rather about the attitude;
>> Documentation/process/code-of-conduct-interpretation.rst:
>>
>> "regardless of ... ethnicity, ... nationality, ... race"

Lemme necro-post as well and insert my 2 coins here, for those who still
yell "it's all about ethnicity!!1".

No it's not. It's about companies that sponsor the war or are a part of it.

I wouldn't exaggerate if I say that at least a good half of Russian IT
and HW is dual-purpose / gov-owned if not most of it.

You want to talk about poor Baikal? It was under sanctions even back in
2013 before the Crimea events for being dual-purpose and ARM refused to
give them the license, so they fell back to MIPS.

Most, if not all, Russian Linux distributions are used by the govs AND
military.

So banning the `.ru` domain etc. on LKML would be like 90% precise shot
and 10% collateral damage which is a fair ratio nevertheless.
I'd rather reject a patch than get a rocket in my face powered by this
patch. Even if it's "focused on what is best for the community".

Instead of citing the Code of Conduct and all that stuff, refer to the
kernel documentation about the international restrictions for certain
HW/countries/purposes (including dual).

>> "Focusing on what is best for the community"
>>
>> "Examples of unacceptable behavior ... insulting/derogatory
>> comments ... Public or private harassment"
>>
>> Get back to single-standard integrity for yor own's sake.
Thanks,
Olek

