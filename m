Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FBF30E86C
	for <lists+dmaengine@lfdr.de>; Thu,  4 Feb 2021 01:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhBDATp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 19:19:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:33582 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232745AbhBDATn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Feb 2021 19:19:43 -0500
IronPort-SDR: hA1fgC5NJNodATVqRJH9P/W0SVU209i5GUNEUffTzMQNbaDEAfVcBu/wBG4bBI1aLl7NRTOYwR
 OIoZ8zA/aQpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="180369390"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="180369390"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 16:19:00 -0800
IronPort-SDR: n4Q6qoxkSU0RMQovBpADB8paXHUAS9cb1Qr2InjAs5CQLMv5DPlZXOwF34GLIi6JLDsh7Yg4c/
 5ZUvUKPvKHeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="356197169"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 03 Feb 2021 16:19:00 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 16:18:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 3 Feb 2021 16:18:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 3 Feb 2021 16:18:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBai3X7alYyxPbH7cFhkwT2IEY5XvSOAghS4KuOoPV06sP5VjlGKtfRMThmfETOUq+OX93koxj1arUHIG4lLkOwrLZpga/heVXY9e1rFGeiGuCc5tjIZU+keUrI7qP4E50RFSBBR+Fqc2cfHRyJ5V8uNDKojdupAPlZT/IS2I1nZKKPSX2BMtLQx+6odxnYKurzpcfpbr7r+oMwOnVm/GfFgxfHr7Jn8wxm77ffWu6uJweuB/zFbg6QsAeE+6vTAsP9SCNIPX6mb62wQP2nR3IUMxanEijcEITS4j5WC1kGQttKhxPhAc3exBWEcnFGsFmT6JXvNRO2tstLYOCh9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tLy4YaykOJ0wkikFbUrFrYTAmNvRTwr4iQh8WvjLFE=;
 b=U+IZY0Rx07wkmAhTghM1pDWTearqppHR7uPrZh8ya2knoRYf+oYN860LVd4L/dwPxa/kATQZl711bGhgiPnoJdhOWN5yO2EzLxu1Venv+0jU6h1y0+Tg959mcdN7EMVDWUCw4iEvvF4+WqY8gUmVeKuRBco92JSMEU3MLSkCr4WjQ2w7/6BwVhJygGqzF53spjYDWWwh2zKVt0Ub6IXQdDUTtwoqo74xAZOGvxzBPrjoq/VC0iPkwQr903KuExe49SGGQ/Z2qHpdLKnE+Wm46MZy9w0BIz6mFmVS9DAqE8A0MYCBK5/n0gZZbe+8W947OPSlTPq7lUdgLShk2I5klA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tLy4YaykOJ0wkikFbUrFrYTAmNvRTwr4iQh8WvjLFE=;
 b=zI27UWNDgoQ7QzCsfn/7xr40MjlAJTitLRktsunqVzRATnyPB0vaYoIfarBsZwLRF0pg8nap57wlh5/BHCe+7vS6/J2IZ8/ZmVRDsk1A6G9gzMpeAIcFbHOq13NnQg74yCXLsrSbyS9NC3OfKYyjNrKrCAEaEmvZ+r/tY1zVCG8=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by CO1PR11MB5105.namprd11.prod.outlook.com (2603:10b6:303:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 00:18:56 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::b490:1116:e0fa:f42e]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::b490:1116:e0fa:f42e%4]) with mapi id 15.20.3784.011; Thu, 4 Feb 2021
 00:18:56 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Colin King <colin.king@canonical.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] dmaengine: dw-axi-dmac: remove redundant null check
 on desc
Thread-Topic: [PATCH][next] dmaengine: dw-axi-dmac: remove redundant null
 check on desc
Thread-Index: AQHW+jMRIRe+E+h1aUS1G2+XuBuFB6pHIEIQ
Date:   Thu, 4 Feb 2021 00:18:56 +0000
Message-ID: <CO1PR11MB502607E4DB3DD971956D6CF2DAB39@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20210203134652.22618-1-colin.king@canonical.com>
In-Reply-To: <20210203134652.22618-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0b567c4-25db-465e-29eb-08d8c8a275fa
x-ms-traffictypediagnostic: CO1PR11MB5105:
x-microsoft-antispam-prvs: <CO1PR11MB510517A5E2A28D13C67A5539DAB39@CO1PR11MB5105.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: thfQDJfvKH9yRa0w8FRMTgXJqBYMl2+Dy8y6RPCQGpd/ccCA9uQ7iasQlqnLJf61vKZRI1V55Wg5j5cU4qEcWk11Ho5LzUBecrFkCdxrhIeohI/nx1hmgJzPBK4Kd/uDavaqe/t75PIMUe8j9Aj7NwMK9cm5++VWd7GQfo1bbwT7SNeK5NlrmKBiQ5D1aN+kf5ueP5xE0Fiml4JcvNIfgOJmA5nlan+sMSp8m/ml3S6/JwmqlV33qwboSKTV6uTzC2piqMEtxHuo0E5MMkAg/yp+UayZWhzSGy/yi39Udsx/HRFme8N0L1wZXUCv66fWIWs5EAzz9JsQE3rT00tfQCySj31BTXwz6LHF71N0wwI1bWLOZejGUz0esZsc90tE7h+D/A2AwFX4VXv8MOxg4ZTh1kjNxk1j55wV1QCU1jzcFCP9ccoVZi6fc6LyiNz/6sriznRCw5DE6FafTFwnbsJaHhgm+trIfY+jEqfM/VwIuo5Q1QQUD4wiDb9drDQAI2+CniGnhvqoVmz/VQy9cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(376002)(366004)(8676002)(7696005)(66946007)(55016002)(71200400001)(26005)(53546011)(6506007)(316002)(478600001)(4326008)(2906002)(66556008)(86362001)(5660300002)(8936002)(83380400001)(76116006)(54906003)(52536014)(110136005)(33656002)(186003)(9686003)(64756008)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SXdwRkRDNnZmMTRZSXFLWHZCQWp2NktQTU1GTG1ZNFoxa1JSbDZVOHlrZnU4?=
 =?utf-8?B?TlZaa2x2bXBjWnp0ckFBQk9sazJaZ3dTWjRyRTVEY056WlpmTU4vZE5ac3Y0?=
 =?utf-8?B?V0E0K1RaUElPMVBRd1E0b3I1Z2xmNUE3cDFWdFJweTFoQjRWTTdHWnZrdm04?=
 =?utf-8?B?c3hGKzgzRmdaWnhtdVJHWjV3VzUxbkFaenRpbmIxS0FiYStGemtXb2VwVjNX?=
 =?utf-8?B?eGVGS2N0OXVaVlo0ZmlkOU5HSUl1b0pWR254a0tlSzJhajh2cVNTbFF1WmNQ?=
 =?utf-8?B?dkM4Mnp1KzB0VlpqeFhVajZWdDhaRFJZT0twUHpCQlhGMVptem9aL3pyZkUv?=
 =?utf-8?B?dmdaYlgzcU40TWhiSFVjQXBhVDBMK0hBUllGZ0QrTnBtUVNLRW5zT1hlSFY5?=
 =?utf-8?B?eWhjVWNMKzFlN2h5MGQxVTN1bFVDMWNFYnJYT0kxbmtlQXlMZ1A1NlRSZlFT?=
 =?utf-8?B?eWdaOHREalJDZ1NOMkJYWXpMaXc0WEQ2WXJiclBCLytvTUQ4V3FpakFJUmdm?=
 =?utf-8?B?bHpkbDloOTlMbTZjQUNLcFpXYzhPb1l0a0RBQU1jMDhpV2lsMXhRMllURDJO?=
 =?utf-8?B?aVBFYlVlRDJVL0lUR2htRld5aWVEaDI1YllHZk01Y0FmNmVYK0VrOXFueHpY?=
 =?utf-8?B?bi8wa1YwMEFYNDVxT3E1OXphSDJleTY1MTM5ZVM3aTBoUThKTmNmZDI1UW9D?=
 =?utf-8?B?N1pjNWhaUjczYTFMbW1tTkpNaTJOdGEwWDdSUEM0VnpSYVNhRkRYNjhQb1lz?=
 =?utf-8?B?aGNCMm40VFhZcDFXYjcvTVh3ckFpYlJyTFo3MHJNRCt5REVRR1VxNzZLeVll?=
 =?utf-8?B?RmduVkZxYXNXYjlyZklCUWJkYTRxREl5Qk5VYS8rS3VqUXEvYnBsRGM0RDZR?=
 =?utf-8?B?Q08zYzd1SHZvamJIWWFScUN0L1pCaDQzd1plMVRzSnovdUxSekRJTUpkZkU4?=
 =?utf-8?B?ZW53VGdvV3kzM01HdGlvbFRTUTR0ZzB1Vkp1Y2o0Mmo1RVplRXBPdTN4V1Fw?=
 =?utf-8?B?SEY0Y1VxdjNmQ2liSi83aVQwMmdKYnZIdjk2N0Q3NzFJTXdyT0ZSVDd1U2U3?=
 =?utf-8?B?Vk5qUExmODZFZkRrYzJJdzkyMGhMWFpDMDdDclBUM3ZpWVZhaXVNeHpPYVU5?=
 =?utf-8?B?cFFIQTh3TGprMUNYVkwzZ1dFaGtNVjdMbzZjaXUzdXZsdm5ETkpTNVY0cjJx?=
 =?utf-8?B?eTNLRWdUcENrOVRxYVRzUFZBTXU1eisxZTkzYXZVMGM5S1hFYmxpYnlYMCt5?=
 =?utf-8?B?VDhuTjJmYmJEZ0tZMWNzY1VjbWNFcnV1TVFGL0p2QWY1N3hLcW1TdEllZmNj?=
 =?utf-8?B?QTFsWGR1QlpUbWpHa0Z5M3JHVHNmYjlITTJZbGsvUnozY1JBdnhlWkt4SmRw?=
 =?utf-8?B?K2ZINUxhWnppcG0waFpmMzRZYy9OTDUya2I1QzBrYm9tM3IrRUJUOXQ2WnJw?=
 =?utf-8?B?NTZSa1ZSempJbTRZMW0yZzBLVDJZT21kclV2Y3AxWEx3bmNaV004WFduV2Ni?=
 =?utf-8?B?SkIvUHNIa2xnZmp2QWpadWJwQ0NGam9CSUtVU01abzdIQjhJYXhxdFJRUHRH?=
 =?utf-8?B?RWcyNTk4MWdSak9WL2l2cnIrUE84UWVwRmt6YVZ2eU85RExrS1BWMXdoWEht?=
 =?utf-8?B?WDQ4Ly9yQWU3U1orZXRqOVV3M3hLY3ZtcFRqV2RyLzR1NThGUEFQangwUDB5?=
 =?utf-8?B?bklVYW9lOWN3OGFxVTI4eTBrd01uVllmRkhINlZXTi94Ujk0OE5MdGpkbGg3?=
 =?utf-8?Q?8wmMnXmSLFjSAPpa43miA0CtxtFlRuMGXevQuPy?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b567c4-25db-465e-29eb-08d8c8a275fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 00:18:56.1256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBmJXsPy2kaQ9GxB/iHl12c4EFAFnAuxk04ilG3LDNvTtv7FwBlDpzK+Xp+DwaTY5KZOz0xzH/F47KwUTQHJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5105
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhlIGNvZGUgbG9va3MgZ29vZCB0byBtZS4gSSBoYXZlIGFsc28gdmVyaWZpZWQgaXQgb24gSW50
ZWwgS2VlbUJheSBwbGF0Zm9ybS4NCg0KUmV2aWV3ZWQtYnk6IFNpYSBKZWUgSGVuZyA8amVlLmhl
bmcuc2lhQGludGVsLmNvbT4NClRlc3RlZC1ieTogU2lhIEplZSBIZW5nIDxqZWUuaGVuZy5zaWFA
aW50ZWwuY29tPg0KDQpUaGFua3MNClJlZ2FyZHMNCkplZSBIZW5nDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IENvbGluIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNv
bT4NCj4gU2VudDogMDMgRmVicnVhcnkgMjAyMSA5OjQ3IFBNDQo+IFRvOiBFdWdlbml5IFBhbHRz
ZXYgPEV1Z2VuaXkuUGFsdHNldkBzeW5vcHN5cy5jb20+OyBWaW5vZCBLb3VsDQo+IDx2a291bEBr
ZXJuZWwub3JnPjsgU2lhLCBKZWUgSGVuZyA8amVlLmhlbmcuc2lhQGludGVsLmNvbT47IEFuZHkN
Cj4gU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPjsNCj4gZG1h
ZW5naW5lQHZnZXIua2VybmVsLm9yZw0KPiBDYzoga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdW25l
eHRdIGRtYWVuZ2luZTogZHctYXhpLWRtYWM6IHJlbW92ZSByZWR1bmRhbnQNCj4gbnVsbCBjaGVj
ayBvbiBkZXNjDQo+IA0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmlj
YWwuY29tPg0KPiANCj4gVGhlIHBvaW50ZXIgZGVzYyBpcyBiZWluZyBudWxsIGNoZWNrZWQgdHdp
Y2UsIHRoZSBzZWNvbmQgbnVsbCBjaGVjayBpcw0KPiByZWR1bmRhbnQgYmVjYXVzZSBkZXNjIGhh
cyBub3QgYmVlbiByZS1hc3NpZ25lZCBiZXR3ZWVuIHRoZSBjaGVja3MuDQo+IFJlbW92ZSB0aGUg
cmVkdW5kYW50IHNlY29uZCBudWxsIGNoZWNrIG9uIGRlc2MuDQo+IA0KPiBBZGRyZXNzZXMtQ292
ZXJpdHk6ICgiTG9naWNhbGx5IGRlYWQgY29kZSIpDQo+IEZpeGVzOiBlZjZmYjJkNmYxYWIgKCJk
bWFlbmdpbmU6IGR3LWF4aS1kbWFjOiBzaW1wbGlmeSBkZXNjcmlwdG9yDQo+IG1hbmFnZW1lbnQi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZG1hL2R3LWF4aS1kbWFjL2R3LWF4aS1kbWFjLXBsYXRm
b3JtLmMgfCA0IC0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2R3LWF4aS1kbWFjL2R3LWF4aS1kbWFjLXBsYXRmb3Jt
LmMNCj4gYi9kcml2ZXJzL2RtYS9kdy1heGktZG1hYy9kdy1heGktZG1hYy1wbGF0Zm9ybS5jDQo+
IGluZGV4IGFjM2Q4MWI3MmExNS4uZDllNGFjM2VkYjRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2RtYS9kdy1heGktZG1hYy9kdy1heGktZG1hYy1wbGF0Zm9ybS5jDQo+ICsrKyBiL2RyaXZlcnMv
ZG1hL2R3LWF4aS1kbWFjL2R3LWF4aS1kbWFjLXBsYXRmb3JtLmMNCj4gQEAgLTkxOSwxMCArOTE5
LDYgQEAgZG1hX2NoYW5fcHJlcF9kbWFfbWVtY3B5KHN0cnVjdA0KPiBkbWFfY2hhbiAqZGNoYW4s
IGRtYV9hZGRyX3QgZHN0X2FkciwNCj4gIAkJbnVtKys7DQo+ICAJfQ0KPiANCj4gLQkvKiBUb3Rh
bCBsZW4gb2Ygc3JjL2Rlc3Qgc2cgPT0gMCwgc28gbm8gZGVzY3JpcHRvciB3ZXJlDQo+IGFsbG9j
YXRlZCAqLw0KPiAtCWlmICh1bmxpa2VseSghZGVzYykpDQo+IC0JCXJldHVybiBOVUxMOw0KPiAt
DQo+ICAJLyogU2V0IGVuZC1vZi1saW5rIHRvIHRoZSBsYXN0IGxpbmsgZGVzY3JpcHRvciBvZiBs
aXN0ICovDQo+ICAJc2V0X2Rlc2NfbGFzdCgmZGVzYy0+aHdfZGVzY1tudW0gLSAxXSk7DQo+ICAJ
LyogTWFuYWdlZCB0cmFuc2ZlciBsaXN0ICovDQo+IC0tDQo+IDIuMjkuMg0KDQo=
