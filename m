Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161C27BC23F
	for <lists+dmaengine@lfdr.de>; Sat,  7 Oct 2023 00:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjJFWeo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Oct 2023 18:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjJFWeo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Oct 2023 18:34:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D2A83;
        Fri,  6 Oct 2023 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696631681; x=1728167681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jpMmgeD+R2UYQiMhLDlJhA0+dUntcx6++GDJMy/9cS0=;
  b=vR5L0EwvXKiAzAYu5py1YhdMCCEWzmc5pM3w+s5+v7/YYRnvizcn2Oq8
   oorT14cWJNV2frZcC/9btPU9iSkaDB3vym/rJIRvxhy0ngmEtUp7xa0nS
   9bZ8S6ewZ+1Hgp/IyFf3GTJPJGKcibK+SiitlwJc8HIe3EE5Dg7toENps
   uYQsO1K45vgp1RPG4zumb3SAsoq8pg18Il42wlAOtkDLLjqWIqPx2VYld
   CRlH2xxVhXUDItaz4UWvA/RtGsrv/NG54m2UPn2e0f6XZyDlR56JxK5wg
   I9keO8fsoaYOth+X8RbdzOdSJnIIPZZgrjN45gbknrF94ThMZGiGqWmRH
   w==;
X-CSE-ConnectionGUID: q/G+pcXQR2S6A8VFQ2gYGQ==
X-CSE-MsgGUID: wXb4uESBRmiXX8aTtP4OMA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="8851014"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2023 15:34:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 6 Oct 2023 15:34:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 6 Oct 2023 15:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWNSL5CPrDRTH3sRSg+o3yz9geITBarsmG1jutWNMTAQ6jluNVSvK4Q6O0FsTqXV6EKMNPG68xACM203dvOVgnXk7qVN2j48kkRebtbS6U4qPor090UgoqDP+1dicw8vmi3pn3zQTNbOSooHXt1twW7G7aeJWjMZZq8ugGXu95CkxTJuQW7i69rk+vjEQ8QefeCZeePTXgRTQ2JvUvLDz9CSk0opTCj7ArSg3rd1MgDnpwy6j2F2wm8PkYQEq+fHrs2kUQz+muu9fQuxOSTTQPTaSRw8blRyPcMWGCF9K80yOTBSI9fPBzzWaxVaadAXrZ4DGZytIzwFo4JtoHcfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpMmgeD+R2UYQiMhLDlJhA0+dUntcx6++GDJMy/9cS0=;
 b=JPXdHAEt7D9UghnwsjZt9HMpMxLZz28SBRN2SynhxfYmKd5qeyGDGl2zg7CEQV2grAiLqyxmNOOoIQJ3nbWpzgWqAInm3bT/marXFw9SDW064LBBK3CxCXuCkrPHHFItjwFQ8p1c9+oCzEBduzTPkMxO6zN9iSai9sOgJCHsiP2FcR+2dNQjdEd7RHjmFz2X3+KV9cQ431ak2XNO5KEwdqlRJRHW8DEJavx63DIJlmCegCiIIxHB3qYipEAdwmgHYdZVbWIOjNptAJVBXG/HbqzooMa4nejGEjX4iOLrLChlHjDcpdE6PZdu/EeexmyzQwFM5MN1JyTrA3Ol3vF3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpMmgeD+R2UYQiMhLDlJhA0+dUntcx6++GDJMy/9cS0=;
 b=IWw4myit0VpbnkI2mRs77Zo/XEC4TReAb/u2jUP5B8b3sjJWF99cFlOIS/z37M4b8PgUj8h/MYHh7gJGdjCyDL7AkD1U3zTu6jscnzN5dXkOxLDt3WEFOdx3yZhg6NyL317NiDVKYUToJh8dDtYqZjAQqViXWAv5/GeniQ15blQ=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 6 Oct
 2023 22:34:19 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::db2b:c4a2:b71a:95da]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::db2b:c4a2:b71a:95da%4]) with mapi id 15.20.6838.030; Fri, 6 Oct 2023
 22:34:19 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <George.Ge@microchip.com>,
        <logang@deltatee.com>, <christophe.jaillet@wanadoo.fr>,
        <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZwZllP9AErauFFUmKz13YRSBKD6/VzMKAgAIhf4CAZAP1gIABCsYAgADKTQA=
Date:   Fri, 6 Oct 2023 22:34:19 +0000
Message-ID: <f72b924b8c51a7768b0748848555e395ecbb32eb.camel@microchip.com>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
         <20230728200327.96496-2-kelvin.cao@microchip.com> <ZMlSLXaYaMry7ioA@matsya>
         <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
         <b0dc3da623dee479386e7cb75841b8b7913c9890.camel@microchip.com>
         <ZR/htuZSKGJP1wgU@matsya>
In-Reply-To: <ZR/htuZSKGJP1wgU@matsya>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|CY8PR11MB6988:EE_
x-ms-office365-filtering-correlation-id: 41406e70-3219-41ca-1ce1-08dbc6bc616f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3ywotnxNEYvAtprPyVub+dOqnHEYjowCVhAJKnDEq53dXNvk7dSZugkc0Mssylb9z9Mt6UxsHkJpW5Sb4Us71env9Oa257496c6tWN3KMrve5QH5rP3xp6vKUj2XsVPHm7EIZxsO/YnTqRd9N2qrngSJlz879ek2aYVpkoyFIPLK29DS4w2orYbjorujz2CVmWmCBi34ao9S6r7txSXi1zuh5/aQx7U/F+0oBBkO+9QGUAPCAQRy/6VuLpTzTII9Lm/mKUKTCtYFLDhVuIvnWW97ZVMwgHdEtXFcw5c6FKuq+39Pna7X5WB79X2lIRsxxPPigB78zYMMx8pbWDDzqhApn8K9LiAro/W1FPT07+MSFXwpxSahOu3s+AVTWE6+pIxVfBH32r2KdU3zm1velwLgOX1r5aEa1rAHjDg3pMtx73G/lARWSXFYeM1vVoVNJaDrig/tBe0N5qxrz974Q2mGn2+ik+AscP1RMLjEOlw793G7qEJVs8R5BdnflpGCg7lvU2jVVjEgozyp4tMLvV3cAwYfM3EKj3oNwY4qMurtF+XzbBvT4e90oKZ5z8qt8DDUYLPndm1bJ8uTKHPKgkaqGczZXE4DYGs5jcODXAbZa0XzxdN/VKWbYlSvIoE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(478600001)(5660300002)(316002)(4326008)(8936002)(41300700001)(54906003)(66476007)(66556008)(6916009)(64756008)(66446008)(76116006)(66946007)(2906002)(8676002)(6506007)(2616005)(6512007)(36756003)(53546011)(71200400001)(38070700005)(26005)(83380400001)(38100700002)(6486002)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlU1b05RaDNjbTh4aGxmT3QzeEFyenZzRkxRU1dQMVpRUzR1UkJYdkpzSmpG?=
 =?utf-8?B?eVBGaGNGOGg0cUxiNmhwQUNXRmg3ZUxsUTlIN3UzWGNvSURGbXVpOTJHcit6?=
 =?utf-8?B?VnBXMjZ3cS9SR1JEYmpYR1pXTVVtR0ZSMGNod1hRTytZOUQ1M3dnYldwd2RV?=
 =?utf-8?B?QlJyRWZhbG5DWGlyZ3JnT3VaOXRXaDBrYUZhRUhoT1k0bG1EUDNCVmMwZmx3?=
 =?utf-8?B?N2NhbjU4c3Zsc0xLSkt5dG1Gb0xZNjJIZ01Cc3g1cDlXVitzNS8wKzJlWnVs?=
 =?utf-8?B?c0lTVjVOeEVJbjFkb2ZnNHJ1VnNTZmkyZXEzMnRmT0xRMXE2dENKRFlZK0t6?=
 =?utf-8?B?dFExVkJoQkkxcXltRnZEL3A2a2lYVjhZRk5VUmNWY0RhZjNvNUVVeW80U3J2?=
 =?utf-8?B?bGZKOGlGdzJxbWtmdCtDNkJ2VitSR2xHaCtzM2xxQUYyZWdtSG5Zd0xpbjVZ?=
 =?utf-8?B?Y0g4WTRucUVqeU13TXJvS2RzS2xoWnN1ekJtOWI0WVJEZnU5RVg5THFLRVov?=
 =?utf-8?B?cmZlbktVK0cvQndxV3RpU09rcGh6V3d0cFl1OTdNbjBBUFJNZ2FsRkhNeE9x?=
 =?utf-8?B?VzFSZWNXVm9pTnZVdFdmd3lBbS80S2tzbU1waFJCbnNlazNkVzZtSmtQUDN6?=
 =?utf-8?B?dWhCTTFKN00vYm5ib1JtNzFHT1RmaStUUXpobkxyRitWWnN6V1RjazY0aEt6?=
 =?utf-8?B?SGVOTzh3VlhWaDZGelU3NDJxUTNtR2lxUGZkYzkzdzloanZ0c2kyRFY0OE84?=
 =?utf-8?B?YWNzQWtlUkE2M3hVTC9hUDg2KzA1QW5pR2F6T0l6WjhrUU04ZnhJWkJ4RzV6?=
 =?utf-8?B?WjM0S1R3dlZSbDhVN1JqaEovdGQxcnlKVm5mSkVMc3c0TUFDWEpMQ0NoRDc0?=
 =?utf-8?B?TEhnblR0Z3pOT1dyZGdCRWFhUmErMzZvZmtLTGptdldVeS9icTdEaEpUTC9q?=
 =?utf-8?B?U2VCSWZUSEFOZGxiQXNPL0E0WVQ3OHZ5S2VVbGV3SE8vNjdyaVY5U0RoTHBy?=
 =?utf-8?B?S2Q0L29lRWRXZEdEUmgrVDF0ZFZWNlBnYTZHbmplUDFCQUl3cHJxL2R4WkZo?=
 =?utf-8?B?bHc5R3JLTlVjOHE0Rk1wei9UYTZaa3g5M2pvTStpRlJ6eVAwUSs3dFV4ZUY0?=
 =?utf-8?B?R0VWd0RCTkUzY3BudnZvcit1c2NRc0RyYit1LzlaamtxbnZNZWMxU2lVK2hW?=
 =?utf-8?B?VnlHanFpUG14WmhmY0ZpN1RQUElnU09ZVnhlbkJraW5RNjZFYWMwbUdBMEpE?=
 =?utf-8?B?NVM1MWFNbXVIUzR3dU9PUnoyT2RGUWlaRU9PbHd4TmZFNGp5OGJOS3FmZU92?=
 =?utf-8?B?QWFjZGQ5RVhVSXNxOE1WVm9TeW9ScGtzMmtyajNPZUowb0FTYlBlaTMzWlRk?=
 =?utf-8?B?ZDJBNDdEeENXNmJxVmUxYXdOaGxUWEFtM2l2cmxBaTllVUY1WVp1K0UybDJw?=
 =?utf-8?B?a1NyY2cvUUpXUUJZck96V2Q1clVCbkJHdTZFMFBLTzdub21EYVA5L3lBUzJF?=
 =?utf-8?B?VTBWUjlQRGV1U0E0ZFhIZnpVU1EvWDVFZVBiUFA4MVRnUC9BcEt5R3MrWlZ4?=
 =?utf-8?B?eWI3U21KanZEaW9ha3FBQjlmQkFkdndwemIzU3pDR0VUSTNkYVZuM1RtVFZw?=
 =?utf-8?B?cHFlejNURFc2ZWRSc0psMlUxbThLbUdhUUlRMnM3SlBLT2RRdlFscWV6YWQz?=
 =?utf-8?B?SUhhc2JUeHZlTWxJb3dFRnEzMnlTLzJ6N244SFFyMUxaWVFTQ0g1NFBZU3RB?=
 =?utf-8?B?ci9OY0pudUFpUzJOVFhDVnhwMnBXK1IvdkRzQVJYdHBKZlBjdi9Zcm0rYTVX?=
 =?utf-8?B?QnlQOUtYMElVdllPVHNIaVhKMVVTTVF0dEVsVGtGb2hKOTRweXFEMisrMlJJ?=
 =?utf-8?B?eTd0STk1ekhRWXNhdDNWdEloR3RKNkZIV25qSnpwNzk0cEk2eHdCY3U0dFU0?=
 =?utf-8?B?UnBGelgybkgrWFBFaHBlc0ZTaEluL3VHaE43ZkZ4blhtVVh4K3NMek9tNnNR?=
 =?utf-8?B?aTFaZFVkbCs5VFdZTlRCY1J5SHY0UEVWemc5MzNib1hSUlpaVzE4RktyZTFa?=
 =?utf-8?B?VndYTExOU2pBbEQ2a0JKam5OMHdEZmRqR0RyTEhBMm5aV3orMXJuRXBzR1pk?=
 =?utf-8?B?VDE2QzBTYTlOMy82NW9DQVBTSUZac0luK1hoY25WS2R3cmJ1YVlFcnFOdWJv?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05F2284112B2B84E90CE24470599DB00@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41406e70-3219-41ca-1ce1-08dbc6bc616f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 22:34:19.3336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: of2oSbkLwFahv4x5pr/+jVaG1Go6oL3/ReYCcqlmWGnLtihfzAMCXtAmrkfEpS+qyvbLW6qFeoWi42y9v0xe+vKIA6a//uShZeKhjJmPLVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTA2IGF0IDE2OjAwICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA1LTEwLTIzLCAx
ODozNSwgS2VsdmluLkNhb0BtaWNyb2NoaXAuY29twqB3cm90ZToNCj4gDQo+ID4gPiA+ID4gK3N0
YXRpYyBzdHJ1Y3QgZG1hX2FzeW5jX3R4X2Rlc2NyaXB0b3IgKg0KPiA+ID4gPiA+ICtzd2l0Y2h0
ZWNfZG1hX3ByZXBfd2ltbV9kYXRhKHN0cnVjdCBkbWFfY2hhbiAqYywgZG1hX2FkZHJfdA0KPiA+
ID4gPiA+IGRtYV9kc3QsIHU2NCBkYXRhLA0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGZsYWdzKQ0KPiA+
ID4gPiANCj4gPiA+ID4gY2FuIHlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0IHRoaXMgd2ltbSBkYXRh
IHJlZmVycyB0by4uLg0KPiA+ID4gPiANCj4gPiA+ID4gSSB0aGluayBhZGRpbmcgaW1tIGNhbGxi
YWNrIHdhcyBhIG1pc3Rha2UsIHdlIG5lZWQgYSBiZXR0ZXINCj4gPiA+ID4ganVzdGlmaWNhdGlv
biBmb3IgYW5vdGhlciB1c2VyIGZvciB0aGlzLCB3aG8gcHJvZ3JhbXMgdGhpcywNCj4gPiA+ID4g
d2hhdA0KPiA+ID4gPiBnZXRzDQo+ID4gPiA+IHByb2dyYW1tZWQgaGVyZQ0KPiA+ID4gDQo+ID4g
PiBTdXJlLiBJIHRoaW5rIGl0J3MgYW4gYWx0ZXJuYXRpdmUgbWV0aG9kIHRvIHByZXBfbWVtIGFu
ZCB3b3VsZCBiZQ0KPiA+ID4gbW9yZQ0KPiA+ID4gY29udmVuaWVudCB0byB1c2Ugd2hlbiB0aGUg
d3JpdGUgaXMgOC1ieXRlIGFuZCB0aGUgZGF0YSB0byBiZQ0KPiA+ID4gbW92ZWQNCj4gPiA+IGlz
DQo+ID4gPiBub3QgaW4gYSBETUEgbWFwcGVkIG1lbW9yeSBsb2NhdGlvbi4gRm9yIGV4YW1wbGUs
IHdlIHdyaXRlIHRvIGENCj4gPiA+IGRvb3JiZWxsIHJlZ2lzdGVyIHdpdGggdGhlIHZhbHVlIGZy
b20gYSBsb2NhbCB2YXJpYWJsZSB3aGljaCBpcw0KPiA+ID4gbm90DQo+ID4gPiBhc3NvY2lhdGVk
IHdpdGggYSBETUEgYWRkcmVzcyB0byBub3RpZnkgdGhlIHJlY2VpdmVyIHRvIGNvbnN1bWUNCj4g
PiA+IHRoZQ0KPiA+ID4gZGF0YSwgYWZ0ZXIgY29uZmlybWluZyB0aGF0IHRoZSBwcmV2aW91c2x5
IGluaXRpYXRlZCBETUENCj4gPiA+IHRyYW5zYWN0aW9ucw0KPiA+ID4gb2YgdGhlIGRhdGEgaGF2
ZSBjb21wbGV0ZWQuIEkgYWdyZWUgdGhhdCB0aGUgdXNlIHNjZW5hcmlvIHdvdWxkDQo+ID4gPiBi
ZQ0KPiA+ID4gdmVyeQ0KPiA+ID4gbGltaXRlZC4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIGV4cGxh
aW4gbW9yZSBhYm91dCB0aGlzICd2YWx1ZScgd2hlcmUgaXMgaXQgZGVyaXZlZA0KPiBmcm9tPw0K
PiBXaG8gcHJvZ3JhbXMgaXQgYW5kIGhvdy4uLg0KDQpTdXJlLiBUaGluayBvZiBhIHByb2R1Y2Vy
L2NvbnN1bWVyIHVzZSBjYXNlIHdoZXJlIHRoZSBwcm9kdWNlciBpcyBhDQpob3N0IERNQSBjbGll
bnQgZHJpdmVyIGFuZCB0aGUgY29uc3VtZXIgaXMgYSBQQ0llIEVQLiBPbiB0aGUgRVAsIHRoZXJl
DQppcyBhIG1lbW9yeS1tYXBwZWQgZGF0YSBidWZmZXIgZm9yIGRhdGEgcmVjZWl2aW5nIGFuZCBh
IG1lbW9yeS1tYXBwZWQNCmRvb3JiZWxsIGJ1ZmZlciBmb3IgdHJpZ2dlcmluZyBkYXRhIGNvbnN1
bWluZy4gRWFjaCB0aW1lIGZvciBhIGJ1bGsNCmRhdGEgdHJhbnNmZXIsIHRoZSBETUEgY2xpZW50
IGRyaXZlciBmaXJzdCBETUEgdGhlIGRhdGEgb2Ygc2l6ZSBYIHRvDQp0aGUgbWVtb3J5LW1hcHBl
ZCBkYXRhIGJ1ZmZlciwgdGhlbiBpdCBETUEgdGhlIHZhbHVlIFggdG8gdGhlIGRvb3JiZWxsDQpi
dWZmZXIgdG8gdHJpZ2dlciBkYXRhIGNvbnN1bXB0aW9uIG9uIGRldmljZS4gT24gcmVjZWl2aW5n
IGEgZG9vcmJlbGwNCndyaXRpbmcsIHRoZSBkZXZpY2Ugc3RhcnRzIHRvIGNvbnN1bWUgdGhlIGRh
dGEgb2Ygc2l6ZSBYIGZyb20gdGhlIGRhdGENCmJ1ZmZlci4gIA0KDQpGb3IgdGhlIGZpcnN0IERN
QSBvcGVyYXRpb24sIHRoZSBETUEgY2xpZW50IHdvdWxkIHVzZSBkbWFfcHJlcF9tZW1vcnkoKQ0K
bGlrZSB3aGF0IG1vc3QgRE1BIGNsaWVudHMgZG8uIEhvd2V2ZXIsIGZvciB0aGUgc2Vjb25kIHRy
YW5zZmVyLCB2YWx1ZQ0KWCBpcyBoZWxkIGluIGEgbG9jYWwgdmFyaWFibGUgbGlrZSBiZWxvdy4N
Cg0KdTY0IHNpemVfdG9fdHJhbnNmZXI7DQoNCkluIHRoaXMgY2FzZSwgdGhlIGNsaWVudCB3b3Vs
ZCB1c2UgZG1hX3ByZXBfd2ltbV9kYXRhKCkgdG8gRE1BIHZhbHVlIFgNCnRvIHRoZSBkb29yYmVs
bCBidWZmZXIsIGxpa2UgYmVsb3cuDQoNCmRtYV9wcmVwX3dpbW1fZGF0YShjaGFuLCBkc3RfZm9y
X2RiX2J1ZmZlciwgc2l6ZV90b190cmFuc2ZlciwgZmxhZyk7IA0KDQpIb3BlIHRoaXMgZXhhbXBs
ZSBleHBsYWlucyB0aGUgdGhpbmcuIFBlb3BsZSB3b3VsZCBhcmd1ZSB0aGF0IHRoZQ0KY2xpZW50
IGNvdWxkIHVzZSB0aGUgc2FtZSBkbWFfcHJlcF9tZW1vcnkoKSBmb3IgdGhlIGRvb3JiZWxsIHJp
bmdpbmcuIEkNCndvdWxkIGFncmVlLCB0aGlzIEFQSSBqdXN0IGFkZHMgYW4gYWx0ZXJuYXRpdmUg
d2F5IHRvIGRvIHNvIHdoZW4gdGhlDQpkYXRhIGlzIGFzIGxpdHRsZSBhcyA2NCBiaXQgYW5kIGl0
IGFsc28gc2F2ZXMgYSBjYWxsIHNpdGUgdG8NCmRtYV9hbGxvY19jb2hlcmVudCgpIHRvIGFsbG9j
YXRlIGEgc291cmNlIERNQSBidWZmZXIganVzdCBmb3IgaG9sZGluZw0KdGhlIDgtYnl0ZSB2YWx1
ZSwgd2hpY2ggaXMgcmVxdWlyZWQgYnkgZG1hX3ByZXBfbWVtY3B5KCkuDQogDQoNCj4gPiA+ID4g
PiArwqDCoMKgwqAgLyogc2V0IHNxL2NxICovDQo+ID4gPiA+ID4gK8KgwqDCoMKgIHdyaXRlbChs
b3dlcl8zMl9iaXRzKHN3ZG1hX2NoYW4tPmRtYV9hZGRyX3NxKSwNCj4gPiA+ID4gPiAmY2hhbl9m
dy0NCj4gPiA+ID4gPiA+IHNxX2Jhc2VfbG8pOw0KPiA+ID4gPiA+ICvCoMKgwqDCoCB3cml0ZWwo
dXBwZXJfMzJfYml0cyhzd2RtYV9jaGFuLT5kbWFfYWRkcl9zcSksDQo+ID4gPiA+ID4gJmNoYW5f
ZnctDQo+ID4gPiA+ID4gPiBzcV9iYXNlX2hpKTsNCj4gPiA+ID4gPiArwqDCoMKgwqAgd3JpdGVs
KGxvd2VyXzMyX2JpdHMoc3dkbWFfY2hhbi0+ZG1hX2FkZHJfY3EpLA0KPiA+ID4gPiA+ICZjaGFu
X2Z3LQ0KPiA+ID4gPiA+ID4gY3FfYmFzZV9sbyk7DQo+ID4gPiA+ID4gK8KgwqDCoMKgIHdyaXRl
bCh1cHBlcl8zMl9iaXRzKHN3ZG1hX2NoYW4tPmRtYV9hZGRyX2NxKSwNCj4gPiA+ID4gPiAmY2hh
bl9mdy0NCj4gPiA+ID4gPiA+IGNxX2Jhc2VfaGkpOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAr
wqDCoMKgwqAgd3JpdGV3KFNXSVRDSFRFQ19ETUFfU1FfU0laRSwgJnN3ZG1hX2NoYW4tDQo+ID4g
PiA+ID4gPm1taW9fY2hhbl9mdy0NCj4gPiA+ID4gPiA+IHNxX3NpemUpOw0KPiA+ID4gPiA+ICvC
oMKgwqDCoCB3cml0ZXcoU1dJVENIVEVDX0RNQV9DUV9TSVpFLCAmc3dkbWFfY2hhbi0NCj4gPiA+
ID4gPiA+bW1pb19jaGFuX2Z3LQ0KPiA+ID4gPiA+ID4gY3Ffc2l6ZSk7DQo+ID4gPiA+IA0KPiA+
ID4gPiB3aGF0IGlzIHdyaXRlIGhhcHBlbmluZyBpbiB0aGUgZGVzY3JpcHRvciBhbGxvYyBjYWxs
YmFjaywgdGhhdA0KPiA+ID4gPiBkb2VzDQo+ID4gPiA+IG5vdA0KPiA+ID4gPiBzb3VuZCBjb3Jy
ZWN0IHRvIG1lDQo+ID4gPiANCj4gPiA+IEFsbCB0aGUgcXVldWUgZGVzY3JpcHRvcnMgb2YgYSBj
aGFubmVsIGFyZSBwcmUtYWxsb2NhdGVkLCBzbyBJDQo+ID4gPiB0aGluaw0KPiA+ID4gaXQncyBw
cm9wZXIgdG8gY29udmV5IHRoZSBxdWV1ZSBhZGRyZXNzL3NpemUgdG8gaGFyZHdhcmUgYXQgdGhp
cw0KPiA+ID4gcG9pbnQuDQo+ID4gPiBBZnRlciB0aGlzIGluaXRpYWxpemF0aW9uLCB3ZSBvbmx5
IG5lZWQgdG8gYXNzaWduIGNvb2tpZSBpbg0KPiA+ID4gc3VibWl0DQo+ID4gPiBhbmQNCj4gPiA+
IHVwZGF0ZSBxdWV1ZSBoZWFkIHRvIGhhcmR3YXJlIGluIGlzc3VlX3BlbmRpbmcuDQo+IA0KPiBT
b3JyeSB0aGF0IGlzIG5vdCByaWdodCwgeW91IGNhbiBwcmVwYXJlIG11bHRpcGxlIGRlc2NyaXB0
b3JzIGFuZA0KPiB0aGVuDQo+IHN1Ym1pdC4gT25seSBhdCBzdWJtaXQgaXMgdGhlIGNvb2tpZSBh
c3NpZ25lZCB3aGljaCBpcyBpbiBvcmRlciwgc28NCj4gdGhpcw0KPiBzaG91bGQgYmUgbW92ZWQg
dG8gd2hlbiB3ZSBzdGFydCB0aGUgdHhuIGFuZCBub3QgaW4gdGhpcyBjYWxsDQo+IA0KVGhlIGhh
cmR3YXJlIGFzc3VtZXMgdGhlIFNRL0NRIGlzIGEgY29udGlndW91cyBjaXJjdWxhciBidWZmZXIg
b2YgZml4DQpzaXplZCBlbGVtZW50LiBBbmQgdGhlIGFib3ZlIGNvZGUgcGFzc2VzIHRoZSBhZGRy
ZXNzIGFuZCBzaXplIG9mIFNRL0NRDQp0byB0aGUgaGFyZHdhcmUuIEF0IHRoaXMgcG9pbnQgaGFy
ZHdhcmUgd2lsbCBkbyBub3RoaW5nIGJ1dCB0YWtlIG5vdGUNCm9mIHRoZSBTUS9DUSBsb2NhdGlv
bi9zaXplLsKgDQoNCldoZW4gZG8gZG1hX2lzc3VlX3BlbmRpbmcoKSwgdGhlIGFjdHVhbCBTUSBo
ZWFkIHdyaXRlIHdpbGwgb2NjdXIgdG8NCnVwZGF0ZSBoYXJkd2FyZSB3aXRoIHRoZSBjdXJyZW50
IFNRIGhlYWQsIGFzIGJlbG93Og0KDQp3cml0ZXcoc3dkbWFfY2hhbi0+aGVhZCwgJnN3ZG1hX2No
YW4tPm1taW9fY2hhbl9ody0+c3FfdGFpbCk7DQoNCg0KVGhhbmsgeW91IFZpbm9kIGZvciB5b3Vy
IHRpbWUhDQpLZWx2aW4NCg==
