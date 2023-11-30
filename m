Return-Path: <dmaengine+bounces-320-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95E47FE4D2
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 01:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4D9282362
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 00:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AD26FB5;
	Thu, 30 Nov 2023 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzOdP+lh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BE3BC;
	Wed, 29 Nov 2023 16:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701304276; x=1732840276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rqppH7aaq6iGRXTfd8kflp1itekNBQGlKbs7MAY1Yck=;
  b=LzOdP+lhXu1lPVwkdfpE+3y7excSTiXEzOvDwiwOYmpjNvfxLoacaT8+
   OV3lNxipY3mUXVtGW6107GBl5Jv1zEHrOn/6h6EFo0hE4vyZs43ngEGNl
   36DVMoAHVJBmm9xRjNK7KXu69sOkSdNAJG39yX7kg+FyKJTpyfaot6BaJ
   epfnsxPOIGPCb0J3TcH/rZUeUzD9WTB5QVo3zFb0S52/GiZcmWoqQt1Yh
   l3hqLTC7O/FP2gn+v6ZXl8Qbik6ziKIV7LBTaEuVWu5UCdO2zJEOL98YQ
   zaoaEURdd2UBm+2IxCyKidFUgZWQQ0sPmXs4A6NKbGlSrJVfQaCRO3X3i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="147182"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="147182"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 16:31:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="913013070"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="913013070"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 16:31:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 16:31:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 16:31:14 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 16:31:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz8OMnNsFAFV8hlRQB5HoqejZW50IBYroEm9sSRFQfBIIOhUZ5wt+y4/a7cPp6X8KgXIUQfmYPaB+y734yd9haMCNlDlTEcZq32CH5w3By8dkeR+2b7dvsN2IMVADmOF0V8UgQsXpbZtMoxwDjxaW6NcEo6MAaik3EoPaQMmeG00ozcYYK+WhXj95GBSs1A1r/pANJ+uwJ+627vwxWVJylDYyQ5ruz6Kt4j55AQRNnk6q6GVr9Dwrs485Vou+Rd1whsZDvBBwu32GQUsX/o0ZYFo4ReoRhYQaT1mI81bbw7MOAcwX3LVcuVGBLGJ/crNQiaP1dbFjPghWWwhwdQ9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqppH7aaq6iGRXTfd8kflp1itekNBQGlKbs7MAY1Yck=;
 b=KcNuMX0amZon0Z/JCLg/mVkzfLMLDsb2Rhkj3yPdOLLEx7T3V6FlG/smM59jeBOwgK5wrDgKZbzdw9VUXuI7QWOtFXXhaptNhjNIwp65faO+fUjchNzFX4hcZpnRTYRIWOE1fIwXx2GU9gUG4dJh62FsghfvlpubGBOmH3rj+q7mEbrT/f/ECJAbIVbUywm7O7+aOknbyE9Az/IA2y0LwdJyFqDsDotpLkNi4EqVsitFSsPAvDbD58EuERYM5FcFowFHQc2V1ZLqC+Hon0p0CFcxAez+nl3qfio3C9zDtqnztk6fQmcCslrnMKuIHQZVY0ibbdvCOBi0tyClKFcM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MW6PR11MB8340.namprd11.prod.outlook.com (2603:10b6:303:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 00:31:10 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 00:31:09 +0000
From: "Yu, Fenghua" <fenghua.yu@intel.com>
To: Tom Zanussi <tom.zanussi@linux.intel.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	"vkoul@kernel.org" <vkoul@kernel.org>
CC: "Jiang, Dave" <dave.jiang@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Guilford, James"
	<james.guilford@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>, "pavel@ucw.cz"
	<pavel@ucw.cz>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>
Subject: RE: [PATCH v10 14/14] dmaengine: idxd: Add support for device/wq
 defaults
Thread-Topic: [PATCH v10 14/14] dmaengine: idxd: Add support for device/wq
 defaults
Thread-Index: AQHaIXAwYGaYFBqbek6cnnehCxSjJrCQMN+AgAAKfgCAAcoCYA==
Date: Thu, 30 Nov 2023 00:31:09 +0000
Message-ID: <IA1PR11MB6097D7EE44240E62DEA9AC769B82A@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
	 <20231127202704.1263376-15-tom.zanussi@linux.intel.com>
	 <00aa3b9f-d81e-3dc2-3fb0-bb79e16564d3@intel.com>
 <e0d1e4441dc7976450efd07322be0fe5a7526efe.camel@linux.intel.com>
In-Reply-To: <e0d1e4441dc7976450efd07322be0fe5a7526efe.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|MW6PR11MB8340:EE_
x-ms-office365-filtering-correlation-id: 711e5cb3-5b30-4914-e966-08dbf13ba601
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j5hx4SP7bDEUMWND86dWSDfLtLcrf29+FWjTxMo/ixhas3nSeCKkSWnz0+SxVx5SbgOTyUIeOBKkvblGtUOzh8yjrXISXRH2MlafICdjOhkCmyMijjEK2tfyP9VnyLR9U4/LkGPoTZr6/6KnLUcRaBWgMDB6rCLB59aSlFnCMqIenEc9DHd00n7RkokylX1rBIvgd/BFTLA2yekIcbpZ4/NKUlG2McuuMAifXVjnld1k1JdRNV10cqoKfZUt2unuajtxRT+ti/bomijwaU4o2usGiNA2d6GceZyZIYuwHUh43Nqs3a5j3ZnuwfWU+XTo6dMYILSNLOxSr0IO0v08IW/tuyhgFEC6/ub6N/zva5ke+d7fJBhM8VBys0sPWVSLDoE3jPrTfijzjGACK2Ukti98EG+SznwkiUZLox/IRGw6uoDfQhHfR6NZxCcZYI76m604ND7WhpvD3LtSUqJ1S0rV/Dbe17SwKPLTeIMcM+l8n5RDWV7+eTLt3531/M11zXGY84OJ1m6YLcCBekMbpX5BWUkqPAYALy9cxUBtKOjPn1i5/fcaWMJTkfNyOCA52uHh3osWQRLwIr8ki8gboBuRZuxzhySTtKD/6RX9AsPkzoT1qmuRPoCgOnhS27p0AQJSRz+BYk9kJ4bcFiRCxr8UfxubLzSY53GVQqaRmiU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66556008)(76116006)(66946007)(316002)(66446008)(66476007)(54906003)(64756008)(7696005)(6506007)(478600001)(9686003)(33656002)(82960400001)(86362001)(38100700002)(4326008)(122000001)(8676002)(55016003)(8936002)(5660300002)(41300700001)(52536014)(71200400001)(38070700009)(110136005)(202311291699003)(2906002)(26005)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTZYZmo4MWpPWlJyTXg3MmN3UHhRd3NOUmpsdXBrM05FWVVsREdjd0ZFbG1S?=
 =?utf-8?B?anNLUFRCTGg0cUoxQmQzcnI4M1d3THFCTk1OU2szRXd6WDcwTGNDYjNWS0Rw?=
 =?utf-8?B?STI0ZUEyNHZTRm1mSjVrVC90UjVUbng4TVFNNXpZK2VXS0xub3RMVkZNSzJU?=
 =?utf-8?B?NjlmNXZTMTVHaHZRWVdYN1IyQlI1cXBHNUJPeVpOZS9XWWdvcUE5Q1ZSWnZp?=
 =?utf-8?B?RTVBQWpSTFZaOWdyV0E5eTYyM0FRNEdnYytIZDRHclc2WXhKclljU214dEs4?=
 =?utf-8?B?YktPNUVCcHJSVnd6OGVqM3NkQzg3TDI2KzU3REIyWVlTZjV2SlJaOGw1TlJh?=
 =?utf-8?B?b1dlNFAyZnhjRkZYZ2lySXh4dDNNSXZnN0loTDJGVDlOSnRNK1JTbjAyUzFC?=
 =?utf-8?B?UjQ4cVpUNEJJMnZTWFBlUkZScHg0c29nNk9Ua2thZkxtTjU5UUY1b1BpT2lu?=
 =?utf-8?B?LzFtSStXTXhxbTQ2SmhGd1NRUDk1WStvcDlTaE9JamJFZlFKS0VCc2JrT25l?=
 =?utf-8?B?eXhGNlp5bW5veFluaytxUTQ0T1Mxb0J2NTRsbktsc3VIV0dEeVlMemQrRVNL?=
 =?utf-8?B?ODZqSjN3dTZablVpL3lvOHZwY0dJMmpXWWJwV0k0bUtranhRSEJrOFpYMzht?=
 =?utf-8?B?dkd2YzhUYkgvYXdGS1dVSzNodmF1Qi9qTWtQUXlIbENGZmczL3N3akxsM3Jn?=
 =?utf-8?B?N3k1OGcyNzhwM2FOM0paR3lUaklhanRTS0IxSTBadnBscTB0NFNFc3NwWGZ2?=
 =?utf-8?B?WVdoZzltdmM2QWtnak5sK1ROYlIzdkdodlZkYUVjYTZONExySkNGVmdkVVdK?=
 =?utf-8?B?dDNET25HRDdiZlk2T3FkSkRMb2kyRURuSDlYUWlvRHFjcXViYW0xSWhVQ0Qv?=
 =?utf-8?B?L2VwSjlRU09DeXV0NUg0U1BoaFdZSTVQMU85Wm4wSCtEcXYxYjNnTWRlaVBH?=
 =?utf-8?B?dXRsWWZyZXJhRzk0ZW1MQTduWUlqWXFmRklqd2pwRVR5NTRpVzlRckYyZmdS?=
 =?utf-8?B?VGMvRHN3a3prUWZtaTBIeFZRTGdWSHYwMjEvMEF3dUk5VDhYb044YmV6TnBY?=
 =?utf-8?B?dmhwT01qaHl6LzNtZWs5VHZiMm5wS0F5d0R1NlBjVTlyS25pOWtTSDFrQU44?=
 =?utf-8?B?U2hzOXA5VDM4Ri9VVUw5VDdwRUxiTWQ2TG5uYVNlNGR1bk5rNjdzSDVOZDk2?=
 =?utf-8?B?RThneEsxdDVLbVdDOFNzSXNEdmc0ZjNaak4xL3NUdi9HZmp3b3pqTnZRalAr?=
 =?utf-8?B?UDJGRVhiYThDRTBKTG8ySzBsd0V5VEhsRVNWOHduYWZNdmlEOEdnOW5JdjBX?=
 =?utf-8?B?Z2NmY05VdWpBTURCcVZUaG1MQ3NrcW4rZjVrMFkrTnI0S2ZaWnd6RnJ6UElo?=
 =?utf-8?B?ZGZpS1BzbTM5VGZ5bjVRS1NQMjdsTjRIMEF6UmVHSENVL0RmOFQvZnhFQWdD?=
 =?utf-8?B?RHZUak91aFNkeUEwNVZIcGo5ZUhXOWpkYXZINUE5UzlWV3Z4U1I1V0lHRVht?=
 =?utf-8?B?T2puaFlrb0FORFRCT01lbnFHUTFNL2FOM2lCOFdmWk4wMW1ma0VIQ1pnYTJR?=
 =?utf-8?B?Q2xHa240Nld5T29RVG5GNGFKcExzcWZDcWczVHI4WjNBV0VmRXA0QnlmeUpT?=
 =?utf-8?B?ZmNlZDRBUTlGZ1A4WkU5U3doN2Z3U2NjZnhFSExSYzZtRjM2YU1Hbktjd1M0?=
 =?utf-8?B?WEZZTzQ5Vy9Ob0cxUjQ3d1lTRkZIdE5GMVV3OUpLenVQUUk4akJ6WHZZTGFF?=
 =?utf-8?B?NnhjV21kMkp4L2dGckZERWlXNnZQeUQ4b1YxdHkweXRFMThybDE5ZjZLZzJS?=
 =?utf-8?B?cStTTFlLZVp4Uk1FRkZRRlBQYzRDditEbTFFenNOc1NRZ2IxTXNTODJEZ3Rv?=
 =?utf-8?B?SnhIdEdaMDRZUVRONkh3TzBqYVBMWmV1b0hQNnh0QktWWHBodHlPSXUyRUh2?=
 =?utf-8?B?VmthMUZsNjM3UXJDaS94eU1hMDgvWmNYKzZvUTQ2aFlxR05PNHkzRjg0cTlL?=
 =?utf-8?B?MXRPMmNpVWVCRlFZeU9IM3lKSmNpYXBkQXViaCtVZ0FvVklxTEcwaG5HdVlC?=
 =?utf-8?B?aHhFY0ZXY0lzenRiRno1VERQaXhaL1o2NTY5ayt1Ym5adVE5UGIvbWRMWnBN?=
 =?utf-8?Q?Y2Lrxl7hThJz7SpPquudWQUYi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711e5cb3-5b30-4914-e966-08dbf13ba601
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 00:31:09.2957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22Cohai3AJGdB9FFr4IlGSbRCtQ6+pNB1ZprQqrKZ2iYlktSVMPMCBIl9ASqfNy7YaTEQ9KUAoNdSPgYZ+UJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8340
X-OriginatorOrg: intel.com

SGksIFRvbSwNCg0KPiBGcm9tOiBUb20gWmFudXNzaSA8dG9tLnphbnVzc2lAbGludXguaW50ZWwu
Y29tPg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgLyogc2V0IG5hbWUgdG8gImlhYV9jcnlwdG8iICov
DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBtZW1zZXQod3EtPm5hbWUsIDAsIFdRX05BTUVfU0laRSAr
IDEpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3Ryc2NweSh3cS0+bmFtZSwgImlhYV9jcnlwdG8i
LCBXUV9OQU1FX1NJWkUgKyAxKTsNCj4gPg0KPiA+IElzIHN0cmNweSh3cS0+bmFtZSwgImlhYV9j
cnlwdG8iKSBzaW1wbGVyIHRoYW4gbWVtc2V0KCkgYW5kIHN0cnNjcHkoKT8NCj4gDQo+IFRoYXQn
cyB3aGF0IEkgb3JpZ2luYWxseSBoYWQsIGJ1dCBjaGVja3BhdGNoIGNvbXBsYWluZWQgYWJvdXQg
aXQsIHN1Z2dlc3RpbmcNCj4gc3Ryc2NweSwgc28gSSBjaGFuZ2VkIGl0IHRvIG1ha2UgY2hlY2tw
YXRjaCBoYXBweS4NCg0KV2h5IGlzIHNpemUgV1FfTkFNRV9TSVpFKzEgaW5zdGVhZCBvZiBXUV9O
QU1FX1NJWkU/IFdpbGwgV1FfTkFNRV9TSVpFKzEgY2F1c2UgbWVtIGNvcnJ1cHRpb24gYmVjYXVz
ZSB3cS0+bmFtZSBpcyBkZWZpbmVkIGFzIGEgc3RyaW5nIHdpdGggV1FfTkFNRV9TSVpFPw0KPiAN
Cj4gPg0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgLyogc2V0IGRyaXZlcl9uYW1lIHRv
ICJjcnlwdG8iICovDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBtZW1zZXQod3EtPmRyaXZlcl9uYW1l
LCAwLCBEUklWRVJfTkFNRV9TSVpFICsgMSk7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBzdHJzY3B5
KHdxLT5kcml2ZXJfbmFtZSwgImNyeXB0byIsIERSSVZFUl9OQU1FX1NJWkUgKyAxKTsNCj4gPg0K
PiA+IElzIHN0cmNweSh3cS0+ZHJpdmVyX25hbWUsICJjcnlwdG8iKSBzaW1wbGVyPw0KPiANCj4g
U2FtZSBoZXJlLg0KDQpEaXR0by4NCg0KVGhhbmtzLg0KDQotRmVuZ2h1YQ0K

