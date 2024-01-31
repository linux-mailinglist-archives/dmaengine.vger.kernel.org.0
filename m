Return-Path: <dmaengine+bounces-915-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5268434C6
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 05:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC6CB226FC
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 04:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E683F16436;
	Wed, 31 Jan 2024 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEY+ScTb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5E16426;
	Wed, 31 Jan 2024 04:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706674728; cv=fail; b=kePfADtjYMh8LeLqPcJvyqdFI9GgbptV8aDdtL+3nzk7754PVACH9nawgokE8t5S312DkgTgmscwjs7noY/IcnN7xna8RSchgS3mTHCRcxQq+LWb5uyh8ZRe9cxdHkrkkJJZWRE8cARzsOeupH1/WvM4SgxnLyiOHpFqNp6jC7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706674728; c=relaxed/simple;
	bh=dNzhi52MX54jcPY3EsaTKw5d6ArTSx91VD9suOgDtAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=abQN69ZFcuHkMckjkWBir9OBEHJQ6/YKXnceP6Ev8o28qPhnjKSn4dl5rnDihdv0FD6bbxH9K4rtNMltPPea0VxHjsL2sEhRLDW14EPQYFaEif96CD6qh2C9tL7f7qV9/AdOyue+DOGgVldEwVJQ7ZQZ7AbGjrNuBqFbInfGZzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEY+ScTb; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706674727; x=1738210727;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dNzhi52MX54jcPY3EsaTKw5d6ArTSx91VD9suOgDtAs=;
  b=SEY+ScTbCiD6R13va7ZIuxtDZ9gzXKKmyJGMj3OuiNFdZ1EYfFoHxF5W
   PX+ZIQd/+mLU3wVHaHf6MQJcDSviy50wlM9sjuHV0EjLVhekHLShWDhHn
   DsHfEnZdf+55WNr1EhVkEXD+hHoi8RQq9oVxCY4EFdvD3TRNEo7Hdu9y0
   AVxniDIHbzrTS2ujlkF/e4uYZy8jB9Re99B+0zWkWP0hczvSJPcHhTeC0
   gWQEbYcp3Jz4ccfevkNJLwYRLcC+uA4A5MryXM7Na1UmITGhSNY6YVRJU
   KNYtMwF5w8U0Z0Od6sJILyPyjsX5Eexja/ca281xYLXAOVjjReDbyN+DH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="21999344"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="21999344"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 20:18:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="30110120"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 20:18:45 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 20:18:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 20:18:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 20:18:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 20:18:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VInrAMPrIlgG/vk9ZdWSblcI1CGha4BHfZPfUlPU4dw8SVy28d+ikZJmKPlj/+yblYBDtIFpC8QaEGgk+revmpK3b54hEZVCApPVAYaNN2tcOgXn2F20hzS0tJh5N40q84zNRq1gdX9XvCjkX3Bm4rZ9p10nESWIyUVeRHMnr5QqJtlqL4+2/7Ute24UssiIc6psh9eH/bKBfHyb+krUo+uzHxT25XPtcRj+iACtaK+m2YTzZ9F2kYKZp8f9IHUvUmaDEVLcbzS2hWtjePhi5IZ5G7pLrY4xghwCUEbPRl7wV52zKBSFo1fsQrCfj5jbWG0lgr33wDHf44/734/M5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNzhi52MX54jcPY3EsaTKw5d6ArTSx91VD9suOgDtAs=;
 b=QioCZ7T9s7d2IwLtVutiHTCmLfod/qO40vb+FOt7x2Y7tp/N6TXRRZqlKz39R3h9de0wxv5k9HAHsq56ffN29AxwdYvGD4rNSEn+v7dnCMXFlJDkCW6GEXmvXa1m49HllgVJmk3CmvPza3ylAfp8gNfcbPfGEddiqpmAKKaywhOXty2NywE97SwEbqZ/gEoPTYG5EOsiUBHKShNeeQFyKj17+SKTY9W/KN+WK8fI9uRIFse9wchnNFURTJcVJAl6QEFaJ2NaXuWIp9d1eun4GRVZZ+PTscEmBNr1x6CYJ1Au/L+sMXUwtpEPKxWmeXvX+6aYErrWK10/Vyl8YcMqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21)
 by SN7PR11MB7115.namprd11.prod.outlook.com (2603:10b6:806:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.36; Wed, 31 Jan
 2024 04:18:41 +0000
Received: from CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::f142:af66:7629:2613]) by CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::f142:af66:7629:2613%6]) with mapi id 15.20.7249.017; Wed, 31 Jan 2024
 04:18:41 +0000
From: "Rao, Nikhil" <nikhil.rao@intel.com>
To: "Yu, Fenghua" <fenghua.yu@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, Boqun Feng <boqun.feng@gmail.com>, Mark Rutland
	<mark.rutland@arm.com>
CC: Vinod Koul <vkoul@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, "Zhu, Tony" <tony.zhu@intel.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: RE: [PATCH] dmaengine: idxd: Change wmb() to smp_wmb() when copying
 completion record to user space
Thread-Topic: [PATCH] dmaengine: idxd: Change wmb() to smp_wmb() when copying
 completion record to user space
Thread-Index: AQHaUyhEoy7wDnGRtk6ZOK20qOkpKrDypYUAgAAgPACAAApiAIAAAvWAgAB8VsA=
Date: Wed, 31 Jan 2024 04:18:41 +0000
Message-ID: <CO6PR11MB55868C091A77D9D5451D959A9C7C2@CO6PR11MB5586.namprd11.prod.outlook.com>
References: <20240130025806.2027284-1-fenghua.yu@intel.com>
 <Zbk4wGNcB-g91Vr0@FVFF77S0Q05N> <ZblTystHpVkvjbkv@boqun-archlinux>
 <388be136-f91c-403a-99e1-7a10c5bf9691@intel.com>
 <c6c45aca-e8b9-f10e-181a-f0ca8a79a64c@intel.com>
In-Reply-To: <c6c45aca-e8b9-f10e-181a-f0ca8a79a64c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5586:EE_|SN7PR11MB7115:EE_
x-ms-office365-filtering-correlation-id: 4c83a619-4188-42d2-ab75-08dc2213b4b8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L7wC6m7Nv1EdgKIen/0If6HrmYj8u6vRkW/vzl6k4Zg7BdkvYFcVk/b4GI8GSG3JJDQomRjIBI1XNT6RoOLshCnLgMQAOTBGfORInn1rKRQuGpSK2ae3Wq3kKfqDrLryPiQFj+TKuNhzbvuqcZ2KfPABkH0Yi2qY23EmmeYC3oNMXHz0SjJ9MEoeXyYooo4uZV+xpwBFAro48RziErq8nPRDAbbQt2uoT9ezCqZtGHsCXm2NgGGCy7+8x1qglaFGv/aKhCPoqgSqaX16HGz/FevnhEhCNMZatdOKaDAituLctQqd/u2gKnjxNJVpClsmLXUAvtnqzp0ezkPEBzipe5d/GTvWTnQjCnk88COR/iJsOZICW1I5CkdpZt0HQX59qBZREopuIzOQfMjpJ9mJ7CypyiDnsYXWKn6j9yqUvM6C5nuJfsvkx0u/GRO0ABu6ptWEiBfkb/P6ARCbPM6gagYbkWnoxyN8UE6mn8mdpUM2Zz2+6JO47ip3KZoghxKXVEtdfmmsZTlHFPzTGmTSPZIk/RFH4cpTy0W/z4zPImqfG0dt+5XgJjlORHlFzIx04OnF204upzJ6Q4AIbEmvlTq00M/33zhWryS+PoaPvSTG24fYHsx8efA0dEaXfUlP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(83380400001)(478600001)(53546011)(41300700001)(6506007)(7696005)(71200400001)(8676002)(9686003)(8936002)(4326008)(52536014)(122000001)(55016003)(82960400001)(316002)(64756008)(66946007)(66556008)(66476007)(66446008)(54906003)(2906002)(33656002)(5660300002)(7416002)(38100700002)(38070700009)(76116006)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVQwclBVdXFmYnBWQ3c2Y1RYbzJCZEk0S20xbzZDT01tbVZHUXZMM3d2Lzh3?=
 =?utf-8?B?NzlUMWY5Vmc5TnJHY3F6TlNKR3I4SXM2TkUzclVwejdSNDN2T09TanhsTGRJ?=
 =?utf-8?B?SHFyMnZMaVBmRHRyZ3NDeXB2M3BEVzQ2U0RneXVNcnBJNkt2L0pEdG8wdE1x?=
 =?utf-8?B?b2tBUDV2MTduOFBKSnFINnFrcldLWXVrRXlmV3lPc0FLWVBHT1h5UzFxa2Rq?=
 =?utf-8?B?OXlwVUN3QWxqVXIwbHFURmNIdjZxM3FvN2N1cHROcGFrYUNUM3JDcUM5NVVO?=
 =?utf-8?B?L09PbysxWTBSem5SL1V2Tk5INGJ4eUQ2QTdSTGk0TnZDVFpBUDFpWDNrS280?=
 =?utf-8?B?QkpLSGV4eFMrOXppSTY2anZyTWFwa0tWOWRMWlBDNkxUbWpidjFBZEdTcUZq?=
 =?utf-8?B?OFhCWlRVTUZBMFVoRGVMOFk1TU1hTkVOd1FUTXQ3d0hWUE03bFA5bGFIQmVy?=
 =?utf-8?B?cTVmdlhRWTRHOUxhYXNxT0liZklvSnZxV1dJQjBRWERHZ3Z6T2JGVHZzNDJp?=
 =?utf-8?B?U2pYZFFmVVJVeGZkWWRDMjhhMXk2UGpKYklmSmF5eHp3NG9CemN6Wjh4cE95?=
 =?utf-8?B?b1hEanA4RDJXVlZLT0x0dWNvU2E1UWdYK3NtZTYzb05YSjlCN25MQjVzdFFR?=
 =?utf-8?B?RHM1ODFhdDljVlBtUUEyd3laMkpPc2V6eTllTGw1Y0t4SGZtRHdSaTlscTZp?=
 =?utf-8?B?OFJsNS9vSitJM0F1ZHpVeDI2dGI1cDRRdVZKNUxJeEk4Y29zTmh4S29mUDZw?=
 =?utf-8?B?U2VqK2JEeFgwZVM3Unp5SHJOKy9vaVBaWU1hQm5RazVjdERMUXNuNHRNKytX?=
 =?utf-8?B?dWtUNG1JUlNWZ3ZzNkExOFFISGd0QWpVZjl5bTVZUjNJWnJJcmxQMkRFWkQv?=
 =?utf-8?B?UzhvbWVjTUI3b3drNlplb3A3T3g3QVVaOW9ZTTN1T2RjWE9qalg5WGdmbjRr?=
 =?utf-8?B?bHJ4M0E0Y2RoVmx2b3lvTHJzWWJhWUp5UUl0bnAyai9tY3hWVktJa2o4eG03?=
 =?utf-8?B?UmI4RTNxcE45VU5jZWZGVFIvbE9Rd041bE5kcmpDMzZxUjllRzdBQXdNZlAz?=
 =?utf-8?B?blg4MDZiaHFYaDRnT295WU9Oa09QYTRuNW14dTJ0bmFvTjZFR3RORnk5dzhk?=
 =?utf-8?B?R3R0dVFzMVZyVFh5QU02V1RjemJCYWJmb2lYRVIzQTRlOFFZZnhMejhyTGdo?=
 =?utf-8?B?eG1OMkNBdzR4UDNQdnY0NFdLOEl6Q0hTSlF4R2NNOVFCUTVzcUhTMzB5MlVD?=
 =?utf-8?B?QUxNenZtbnBLRmFHSmk5REtxRVZGc21ET3A0em1rZzlnZit0VDROYnR3SURs?=
 =?utf-8?B?RXgzbkJ1MW0zT25CUmI3MENXQ2NnUTRCOWJOZXc1S1pnVVI5Nm85bzlYUWZy?=
 =?utf-8?B?TkFoeUJpNUpYVDc4TitPYXNDRXM5SDJET1Zicnk4aTFoR0p3eW56Sjk1NlBJ?=
 =?utf-8?B?TVA2MWpHbUZZVTkzUHd1MFJWak5OT1VyeFZmUURaQzM1eGZoTkpxZmpWN3F5?=
 =?utf-8?B?UEFtay9KdEI0UHBKVnhsd1pyenNvSlJqR2xTRTZnek4xaFZmT0VhSXEwVTFC?=
 =?utf-8?B?Ly9KYnJqdEVCZGdUaS9TT1VYNEN3UVZXcWhadVJDN09CUmhtY2Q0TFpOQllM?=
 =?utf-8?B?U2dLVENlT1hPa1ZZQmRsN0VMbHBSRTRzYkVSMUE1S210d2tRSVJhK3BEQ09U?=
 =?utf-8?B?VFlZTFhYT09YVi9jQUxmTVdodldleDh3aTA1NXRzU09QbG9kbTBVaHo3UkxM?=
 =?utf-8?B?ZSswU3ZnaUFkUEJVaGVCR3NCME5wOUU2VnhuVEdLM2kxNlFmL0ZPS0gyVzBa?=
 =?utf-8?B?dmt2UHpiWlFSVGJtdnlFcEx5eEJjZEtDM0dtUGJURmQ2S1NGSHhneEFqc01W?=
 =?utf-8?B?MjROa1FCbjNMc0YzTFJsUnpqQllzUjJSRDIwaUthSURBWXQ1T2ZKT2xpVzVB?=
 =?utf-8?B?YnlUblZuazh1dHl4Mi93aERESWtCeEVneVNHUC9mK0pQdFF3RVpGSXE3eS9O?=
 =?utf-8?B?RjlMajU1cU9LLzJzNEJac1JNNTF1TVNCYWZYQkEzOVBJcDVzQURnRitSQ2NR?=
 =?utf-8?B?ZXg1RlBWWjJsYmdqRDZaVU1kcFZNNjZTN1NHbVQ1Qy94TGh3RVJUSERiMnQy?=
 =?utf-8?Q?Z6RujrQ4LOaWT4OgkTK8OdJqk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c83a619-4188-42d2-ab75-08dc2213b4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 04:18:41.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86h5EoxmH3pvPimRAooBgeNBEyPypVOPgfVf7Rv5VNpLY39I08+6BWQGvtb5BHPFaufDJepRaXrP0xrnruXjJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7115
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWXUsIEZlbmdodWEgPGZl
bmdodWEueXVAaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMzEsIDIwMjQg
MjoxMiBBTQ0KPiBUbzogSGFuc2VuLCBEYXZlIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+OyBCb3F1
biBGZW5nDQo+IDxib3F1bi5mZW5nQGdtYWlsLmNvbT47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRs
YW5kQGFybS5jb20+DQo+IENjOiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPjsgSmlhbmcs
IERhdmUgPGRhdmUuamlhbmdAaW50ZWwuY29tPjsNCj4gZG1hZW5naW5lQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgUmFvLA0KPiBO
aWtoaWwgPG5pa2hpbC5yYW9AaW50ZWwuY29tPjsgWmh1LCBUb255IDx0b255LnpodUBpbnRlbC5j
b20+OyBNYXRoaWV1DQo+IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29t
PjsgVGhvbWFzIEdsZWl4bmVyDQo+IDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBJbmdvIE1vbG5hciA8
bWluZ29AcmVkaGF0LmNvbT47IEJvcmlzbGF2IFBldGtvdg0KPiA8YnBAYWxpZW44LmRlPjsgRGF2
ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47DQo+IHg4NkBrZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRtYWVuZ2luZTogaWR4ZDogQ2hhbmdlIHdtYigpIHRv
IHNtcF93bWIoKSB3aGVuDQo+IGNvcHlpbmcgY29tcGxldGlvbiByZWNvcmQgdG8gdXNlciBzcGFj
ZQ0KPiANCj4gSGksIERhdmUsIEJvcXVuLCBhbmQgTWFyaywNCj4gDQo+IE9uIDEvMzAvMjQgMTI6
MzAsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiA+IE9uIDEvMzAvMjQgMTE6NTMsIEJvcXVuIEZlbmcg
d3JvdGU6DQo+ID4+Pj4gRml4ZXM6IGIwMjJmNTk3MjVmMCAoImRtYWVuZ2luZTogaWR4ZDogYWRk
IGlkeGRfY29weV9jcigpIHRvIGNvcHkNCj4gPj4+PiB1c2VyIGNvbXBsZXRpb24gcmVjb3JkIGR1
cmluZyBwYWdlIGZhdWx0IGhhbmRsaW5nIikNCj4gPj4+PiBTdWdnZXN0ZWQtYnk6IE5pa2hpbCBS
YW8gPG5pa2hpbC5yYW9AaW50ZWwuY29tPg0KPiA+Pj4+IFRlc3RlZC1ieTogVG9ueSBaaHUgPHRv
bnkuemh1QGludGVsLmNvbT4NCj4gPj4gU2luY2UgaXQgaGFzIGEgIkZpeGVzIiB0YWcgYW5kIGEg
IlRlc3RlZC1ieSIgdGFnLCBJJ2QgYXNzdW1lIHRoZXJlDQo+ID4+IGhhcyBiZWVuIGEgdGVzdCB3
LyBhbmQgdy9vIHRoaXMgcGF0Y2ggc2hvd2luZyBpdCBjYW4gcmVzb2x2ZSBhIHJlYWwNCj4gPj4g
aXNzdWUgKmNvbnN0YW50bHkqPyBJZiBzbywgSSB0aGluayB4ODYgbWlnaHQgYmUgYnJva2VuIHNv
bWV3aGVyZS4NCj4gPj4NCj4gPj4gW0NjIHg4NiBtYWludGFpbmVyc10NCj4gPg0KPiA+IEZlbmdo
dWEsIGNvdWxkIHlvdSBwZXJoYXBzIGV4cGxhaW4gaG93IHRoaXMgcHJvYmxlbSBhZmZlY3RzIGVu
ZCB1c2Vycz8NCj4gPiBXaGF0IHN5bXB0b20gd2FzIG9ic2VydmVkIHRoYXQgbWFkZSBpdCBvYnZp
b3VzIHNvbWV0aGluZyB3YXMgYnJva2VuDQo+ID4gYW5kIHdoYXQgY2hhbmdlcyB3aXRoIHRoaXMg
cGF0Y2g/DQo+IA0KPiBUaGVyZSBpcyBubyBpc3N1ZSBmb3VuZCBieSBhbnkgdGVzdC4gVGhpcyB3
bWIoKSBjb2RlIHdhcyByZXZpZXdlZCBhbmQgd2FzDQo+ICJ0aG91Z2h0IiB0aGF0IGl0IG1heSBo
YXZlIGEgcG90ZW50aWFsIGlzc3VlLiANCg0KSSBoYWQgbWFkZSB0aGlzIHN1Z2dlc3Rpb24gc2lu
Y2UgdGhlIGNvZGUgb25seSBuZWVkZWQgYSBzbXBfd21iKCksIElmIHRoZSByZXZpZXcgcmVmZXJz
IHRvIG15IHN1Z2dlc3Rpb24sIHNvcnJ5IGlmIG15IG1lc3NhZ2UgaW5kaWNhdGVkIGEgcG90ZW50
aWFsIGlzc3VlLCB0aGF0IGNlcnRhaW5seSB3YXNuJ3QgbXkgaW50ZW50aW9uLg0KbWVtb3J5LWJh
cnJpZXJzLnR4dCBkb2VzIHNheSB0aGF0IG1hbmRhdG9yeSBiYXJyaWVycyAob2Ygd2hpY2ggd21i
KCkgaXMgb25lKSBzaG91bGQgbm90IGJlIHVzZWQgdG8gY29udHJvbCBTTVAgZWZmZWN0cy4NCg0K
TmlraGlsDQo=

