Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF836A7D23
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 09:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCBI7Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 03:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBI7P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 03:59:15 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F10113DC;
        Thu,  2 Mar 2023 00:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677747554; x=1709283554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IYiIAJZ2v8huV25dwxySJjHJPAnIGb441Oqr0GiTWoI=;
  b=iGluIR6hT4Vrp1K85ZRdiOalNLGHJU1J06e/6nTXe3SzgGNmz+6ZgsUU
   55IrdFaRB1XTcIOwMsPizR2Btxi0eyGmK9fsCaNGZKXfFdCa9FJk2Gicc
   8eeY4VpUFfLS4qSIg0RTaPvViZq22/1BSvrcQ645bLOMe/KrFtnbnn/9p
   ZiEv2NC3tGmq04qjgIL39sXrKsEwmWm6UFj6zwd+uKdkvGhuhcMgL/Hre
   ArApQ0NG3GlAzspP1Y4KspekrwZWCbcePMe1pyoOqMU+sZwcgjbjqczo3
   RZmo6CrqzpTnMdkS2aDbElgcRl24pNBBZt7U9+/+ttIoZTUyNF+aBClBO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="332149589"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="332149589"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:59:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="798752915"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="798752915"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2023 00:59:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:59:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:59:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:59:10 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 00:59:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjRVOl5QacLyWzXUfvOVe7X2797Yq3jJnZQdQ0P/7XNKC2W6CWEsqQL066A3ncuan0dG5ipcReM8ExOf9IZQxauBAejxD5KhMU3KpeQzlCFzQXTfAJVo34vXd1wm+Tsj4GOHiWbxQGF55r+ltW9a2K7E3RK08PIStFeWJtxvte27nR8KF6wrrG6uZdHQVyd9FnA3xbJyLMtcQZeSBblmB52fUGUukAiEzLNCygb666NLl6SQ9KM5qorcrWL26ojt5xvI+7pqTG0m2rq9JrLzYXs0t0774Puq2zFAxankRH2AofGEkiPFClzxHHEIYHf+Yqr8qCqs1nsMTd9xfAwJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYiIAJZ2v8huV25dwxySJjHJPAnIGb441Oqr0GiTWoI=;
 b=OIk6TewIIbohkO0+uzstOAZ6zDSg7RRHtKc1yC12QQUf3p4iQB5SIKeIiDhjxbryj3VEYt6d59GqLQpPtu/3WPyNyZ4TCg5nU9w8SLDrM5sxnP03uAgJyov5/MF5IWsP7aFwZn9D0eWijowz9BQtuIGl2TopTGM+aCV78WcYH+8+K25Ab7zn3e0it9aHKeHDQWpErapXqRu+Df2PKYDBLHRWNjvwTcPaGF7pLyRJ77+/xcSMv6tdZbWlKOnf+jOLr1Eu0vYOKDmsNLoJv6JGKHQDbKUEn3mqVaBQSpeJS9LlLHxnkBL4+TDqoaOjD7Mjc3eGyKEV7I4xwI79wBRvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 08:59:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 08:59:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: RE: [PATCH v4 4/6] iommu/sva: Use GFP_KERNEL for pasid allocation
Thread-Topic: [PATCH v4 4/6] iommu/sva: Use GFP_KERNEL for pasid allocation
Thread-Index: AQHZTJj8e+QjWFZhkk+SelGAjpM5Z67nMSMg
Date:   Thu, 2 Mar 2023 08:59:04 +0000
Message-ID: <BN9PR11MB5276E9F762825D26360516008CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-5-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230301235646.2692846-5-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5015:EE_
x-ms-office365-filtering-correlation-id: 01414f68-6c2e-4a19-74e5-08db1afc5fae
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7X547irkEqqZRudZmYnqZhdhIEz0YBTZ4IDzwHvsiyNB0rpW7QA+Fx4/Imb7WN8wauAHzL2xVDaQJ6x3TxtahzMO0IYd9iCv40SDkY7Yutk9MzvQFvu381XcMXFYTg67/ljeRdQGzTmC93gBRTyeIGAKPJgrG0AqLA8buQbudzpAMsKUiQqlVIoYVCYWH4qN2IxuOLCVfuYd2D4YZnP+RnMbnpQra5QlvWSChoN1jI4dMsPv+GaEoqdyOoNJgtWnSNGFPBVc/4wT0FLfKO5uytn8IAc497mYgj2XnxFKb1OjDzBO52UTlgo9OdYhLDUfRoTZbcGnoEInzlKCJLMfdKMCtdOeLZF2xIlbhT8Fh11pftftrPE5QbpC1SRHDaTKCS1SnsyFLY50GSNfVEabm0+Tf4N3If/A4WCVZXx3dR0nKpl35diEeTtrLqzD4TzNPKegc3JDxXxXcyxV7F1zB5MqGhw+4IEeKeFTq1STC3/VVldhIw1VCRgbNKfj3caZpCBHet/oMz1gc4WGEB7dkid/25WI/0n8QcRuB+2+btUY69zVo4Va+hum1GYg5FuEjQxJiczKbwo5LLrP9K0tBfZGk3t6XhEETg4fVCO2hxoqM07P6JpnUcWK5xbjZhxWIBF+tdeYhRO6H+n7bC0GvKLRbR1MIdJh7kwzUVSaoZQosHkyE9R10r6fxBQZKT5h/8HR7VE8ank5YBrfgj8jC3g1VCFAYswFP1H0jUENkE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199018)(83380400001)(33656002)(122000001)(52536014)(5660300002)(8936002)(82960400001)(7416002)(478600001)(921005)(66946007)(558084003)(71200400001)(55016003)(86362001)(38070700005)(38100700002)(26005)(9686003)(186003)(6506007)(76116006)(66556008)(64756008)(2906002)(8676002)(66476007)(7696005)(66446008)(316002)(41300700001)(4326008)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MitkN2hKSm56bzE5dTNqR21pTmluVFpVOElMUW5TWjlKcmk5RUMyRWJUb0Jl?=
 =?utf-8?B?ZHJ5b2tjZ3Z6dGpJdkYwbU95RGR4Z1BGY1VUVWdpMDhqY0lwT09KVUxybng2?=
 =?utf-8?B?QVlwTk0reldQVG41RkZibGl3R0hrdFBWd21FcVo0T3o0TFZCTWFMdXBMWVJE?=
 =?utf-8?B?a094Z3RYYWNvMDJlSk8yOS8wQmhIamZnSi9oeFVDTW1LY1RTMUFYVnRaRDhR?=
 =?utf-8?B?ak96WUFSQmtEcVlvSWpsenJjSU9CZDZlTzRIOU51TVlWVDlTK3B5bHFuSlA1?=
 =?utf-8?B?eU5DaFJpaXBjWkM5WSt1VTE1akR0cGtmeFgwZlpFUUV2TWlPWTFCUmhLejlj?=
 =?utf-8?B?dnRLZUlmZ2Z5ZGIvd0dmNDVxQ01SdEVkT0xkVkhpRG9IWE94aTlQeWJoV1lo?=
 =?utf-8?B?SkZURGxGVjk5Sm9CWWJrMG1iNWl5Rnd2dnVOTmk3dEh0ZGNBREJRVUg4U2Rh?=
 =?utf-8?B?WEE5aUpVQW80MCtST2FoeFZlZFd1U1JRViszUUVmRjA5b1MzVXI4MzlzODAy?=
 =?utf-8?B?VmxYTE54YXcrQ09ORks2bDBFNWdlMU13Zzg3enpKM01VTWRobEs5TlE5ZHI4?=
 =?utf-8?B?eE05dFpXZ01GYkVMVVlvaUl2dnRoMHBEamIxcUdWLzN4dmJXNUJZcnhVMXJm?=
 =?utf-8?B?ajJJVFl3T0JnTFhoYUtHK21sSDkzM3lsQ1JMTHk3Wm9GZXhCbndSSDZoV3NF?=
 =?utf-8?B?bmRFSjBTYWtuNXg5ei9xOWFYSWozNm41cCtzMnB5ZUs5U2krcmx1em1lWmJy?=
 =?utf-8?B?SWpPSXdKUkhFTm5iY003bjBQL3NyUlZkUDFyeVBZbTQxR2FXVE9XTUVaQXZk?=
 =?utf-8?B?MXMvcTlvM0pTMkc0aU9QaFMveTJYcEFFSGw4NVlrbU14TW9BWmFlV3czSjNs?=
 =?utf-8?B?VG40WWIvZkl1eGRySUVlZU5LVXNDNFNBYVdzaTl3elZML1RZalQyVUlGdGZz?=
 =?utf-8?B?NXZSTzM0OWNNT0NlSlFhMWM3K1RBTHRyT3JrYzNWWW9JWUhMWk5VSTJSRnRv?=
 =?utf-8?B?MENPenZicVU5WXBHeGlRNVU4Vjg3VS9JSUQzSmZTMXppMGcreVpZZERHQ014?=
 =?utf-8?B?V3J1ejhLdGxkb2pQM3NCVTlZUmhpMnFobC9hT0Y3a0ZSc3NTa21oT3IxOUpt?=
 =?utf-8?B?bTRaZ1NST3JNdkxjdnY0T204UWdHL09FZklXNFZzaDRaL0VtQ0hMZGIrOEMr?=
 =?utf-8?B?eU9mcGF1TVU2ZWF2bm5pVVJSN0VOS1hHcTF5ZTNnaEp5cldEZGFOd0xQT3lj?=
 =?utf-8?B?WU5ZL3JpTDZ4U1ZjVTJJcUptS1kzeDBRRTJzQW1uSk1UeVRtOG9ycXdWUjE4?=
 =?utf-8?B?ZFYvR1B2d3lpYVE1WkNxMURjVkwzYnRSZ3FHUk5BMnlIUDhXdVJpMUExZUNY?=
 =?utf-8?B?QVhNeWk1QkRYMExMNklXUDg1eEx4b1FOL3NGczl4RXVtb29RTEN5NDR1eS85?=
 =?utf-8?B?aXUzOW5ZSjlWUThPUklaU3BHbXMvcStIa2Zobi94SkE1Yk5QWXR5Zlo3WEp3?=
 =?utf-8?B?aWprRjV1dXFOQ2NSa2dZZm5uQTRkbmp3dzFmZ3BNMW5sOFhSL1pxdkhlN1Zy?=
 =?utf-8?B?blYzZTlWSmxuNndMcUszV0V4ck5VUWFPbEI0OUVDcDhOWUh4RXh0bkhjY2du?=
 =?utf-8?B?Y1FaRGdhYjJJS1dYeWxaOU8zS1gwMnFaTXl2ek40RDFFY1J6Q2E2OVlDWGJO?=
 =?utf-8?B?cXZ5R2MzWFpmSG55SThreTVSTWRQWVM2cFppOUVVcVo1enMyR2d0cWQvUTdR?=
 =?utf-8?B?ZzZIRUhhQTkvVUpVS2dLZUxDRTdzWER1M2VIZTJsNVBQMFRwVm4xQ2lFM3Ro?=
 =?utf-8?B?OG45TkpuWTNKTUZnMmFrZ3IxSjdod1ZDdkpyRkloQmJ4SFpJczllMHpoYmI4?=
 =?utf-8?B?UVIzZG9rTkxQNVJPeW9TOVAzQWJuWVovNTJPTXNsQ0Z2Wkp6WGc3WHM0dSty?=
 =?utf-8?B?TytWTFpuRWxiWVdNaCs4T1hTK2RubkdxQytGaWxOem80NXc3cmpURHY5SVpo?=
 =?utf-8?B?RDdJQWdQVldNaityQi9KUXVlOVVyN2NKV2RQaElXQmVDeUgxZldLbk5JbDNQ?=
 =?utf-8?B?NmNKcmMzRHo5TXA1a3ZIbHVuMU1wbk1DdFNMdTk4VG5YanlXUE9qdnRLa0wx?=
 =?utf-8?Q?O/R7j0eVq/KLOPyadGYwoAcIw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01414f68-6c2e-4a19-74e5-08db1afc5fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 08:59:04.1938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuu/3CuNWzMq+Fos46dd49Bd6FZSmU1RePoBhG7oYzt8JVjh9eDV2xcUBrgBEQK7O9UCiNe08l6UNpkKlpXtyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgTWFyY2ggMiwgMjAyMyA3OjU3IEFNDQo+IA0KPiBXZeKAmXJlIG5vdCB1c2lu
ZyAgc3BpbmxvY2stcHJvdGVjdGVkIElPQVNJRCBhbGxvY2F0aW9uIGFueW1vcmUsIHRoZXJl4oCZ
cw0KPiBubyBuZWVkIGZvciBHRlBfQVRPTUlDLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFjb2Ig
UGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEtldmlu
IFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0K
