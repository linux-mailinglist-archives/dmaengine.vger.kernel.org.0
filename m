Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7C47C4262
	for <lists+dmaengine@lfdr.de>; Tue, 10 Oct 2023 23:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjJJVXc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Oct 2023 17:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjJJVXc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Oct 2023 17:23:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F73F92;
        Tue, 10 Oct 2023 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696973010; x=1728509010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=egy17lEqGstGN4lqxk0j4oXcFIP95lCJzcV097I/qa8=;
  b=R47uZI+i1KYdI/U29lLTYmzKVYNB83e4ShRS9Vtal1LgIsM0clNEKcz2
   Ah5FohqXf3tgkAmngsCGA3OcDknO+4LtFTifBuyunRG2T1htaTCexIRy0
   RyW9PF4Jc5nWITScZ/JIk6yKtm1nuhkScybC72OY+HYgEnEWyp3UxVLbJ
   Oef1dh8rCgQFdbac0OVhXIieWa1eOS4bS9gyIjE5iYLnDnxTLT8oGBh6O
   /WPu1hbpAXligqpliuDOdD1mdumPmiTlZIomoCq0LF/na1frO7JFXEsQo
   IHOEoEnNfLKCxg+Nbbg0Zb4MiRA521c3m+PUA5hb0qWx88DK4dZI0+wcx
   A==;
X-CSE-ConnectionGUID: 6OaCub05T92O94KrwPITwg==
X-CSE-MsgGUID: 36b+ct3ZTYiohBaPtBczDA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="240432377"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2023 14:23:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 10 Oct 2023 14:23:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 10 Oct 2023 14:23:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DN35vax2cqhkLWQ02cGsEsN9d84MOU+4eVN9Ufc3ZY3hj238rbrNQgrQD1VjuqH5xcs58f6ogfXXwKkIdgle6zc76ef+lghlhHVY1CBiXTHx5Jjc5p7rMEX3Rrj6fQgxaQyTSKVIhDyB3l5Po9KGz6wlWX4jsW+qdYQaLgTg8odxst4pShcrjqWbT6L+3bUwhcwuBNOftb9AQseF/AOJFUjVzYoyJQ6Wpa4biBb4ztUGglsiVxRTReO+uIkoBw2TahEkd0U8UZM8EwYxx+oAK7WiTns79jldufnwfMM1Z/R7x99b1u+PeTa11d7yFiq1YdkBD5TiZtbpMTT6dn7lJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egy17lEqGstGN4lqxk0j4oXcFIP95lCJzcV097I/qa8=;
 b=TFdpuQAVTqwe7Wm1xH/vUS8HQLG5XYQvxvb2WXTrhLpyelFf15G1IN5a2w0mhqJ4wS9yqcxdbWRdi3rEY6iUBN6YN9zqT6MI2n1ukjsT14xvdDDU+F9ruIUm+/4ghT1sFCfwUv3ZP7dKTax5u2Pl+aZRQbZSUT/Zc8AyjprBGnh+ayiI4QBaDaONYpdPgTu7OmGEFNxew9R35dopvDQ/huYo9bGKryuqYbnHprzX9IZaRUuR9AXhfx55bfXupILqFlQRNKSQPREjV1uVSDWBbCY1Je8Inki/g8AgdgTVWK6x/2+GC1g0k+Wbu16sDuvl9lEshHB5+PWwXdJrZafr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egy17lEqGstGN4lqxk0j4oXcFIP95lCJzcV097I/qa8=;
 b=Va1eG7cyJGhmH3srYD8eCgbTrI607nY2xazu7SpoZArWrNvss4QPzHkymZjnZ9nZ1KAjfxJbRVhZgvLMeBcchJ0JcR3xYs/72Ik9u2pU5LpTTCWKD6XjyleYL4u1uebNW0Oz+jT2RxLiJmnggmaY4BhSp/tN2USXN8fzp3q9IqA=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by SN7PR11MB6797.namprd11.prod.outlook.com (2603:10b6:806:263::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 21:23:04 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::db2b:c4a2:b71a:95da]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::db2b:c4a2:b71a:95da%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 21:23:04 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <George.Ge@microchip.com>,
        <linux-kernel@vger.kernel.org>, <logang@deltatee.com>,
        <christophe.jaillet@wanadoo.fr>, <hch@infradead.org>
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZwZllP9AErauFFUmKz13YRSBKD6/VzMKAgAIhf4CAZAP1gIABCsYAgADKTQCAA5sdgIACmkmA
Date:   Tue, 10 Oct 2023 21:23:04 +0000
Message-ID: <1c677fbf37ac2783f864b523482d4e06d9188861.camel@microchip.com>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
         <20230728200327.96496-2-kelvin.cao@microchip.com> <ZMlSLXaYaMry7ioA@matsya>
         <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
         <b0dc3da623dee479386e7cb75841b8b7913c9890.camel@microchip.com>
         <ZR/htuZSKGJP1wgU@matsya>
         <f72b924b8c51a7768b0748848555e395ecbb32eb.camel@microchip.com>
         <ZSORx0SwTerzlasY@matsya>
In-Reply-To: <ZSORx0SwTerzlasY@matsya>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|SN7PR11MB6797:EE_
x-ms-office365-filtering-correlation-id: b9e40f3f-4e6d-4a77-4f9f-08dbc9d71704
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UdQCvVy44tM7fZ5djFVxBCReJTNeTN4cBrzbKAalHnsnh6CXXDDfefbuH5VyKTqf7IlM8pMahdvVriR12a6Wv77z0UMJ9sFvO667hhTJHkR5p/xOActc2AoLZyW1h4L2sulVE3DCVp7v/CAlPbkAjL1563DDLDxTsTx3p/Yc+2GtH0QAFdWOmP2hXAzagY5auPgh9SS5vKTwhY86PbN71xta7qY7wxbSuuTu7hbrAWx4bv3klINNPVg8Uaq8egQb/4TMsNv0gk+CAc0L/3Xh/l9YOdP1AAY4bLZWDDNUWqy7wzj7QNwD/UEceV3yPvVbaLsXh9wbdtlxm+1L7Nmz8ymEsTyasA4FLpy8PZ1aipDx6XyqyCV7QpRdXn2GmRSfsMf6iCKzceHztk1wqM/ESiIfLjCFp2wIcvpVUxg7cbl7TiIb0BcyTu2AShSgl8awUys/zXjIxP6gHxb5Jjna8uR5vwDvaw6XFX4x7sQ/H73s+9wgV5O6PlwaIVldEFq8ri7/ftZRQLVX52/69okGdjzVtil3WO3i9K5kra0gDA3hYI7Td6a0lvguCXgEe+zu9IXmV4nvWeY/HnzHDGv0nPsg4QRzPC6vrwMEgnlr00ndAH5NEmi6scqIi0OA7AaT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(53546011)(6512007)(36756003)(38070700005)(38100700002)(86362001)(122000001)(2906002)(26005)(83380400001)(71200400001)(2616005)(6506007)(478600001)(6486002)(6916009)(4326008)(8676002)(76116006)(8936002)(41300700001)(316002)(54906003)(5660300002)(66476007)(66946007)(64756008)(66556008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3hNUHNubWh5bGQ1WE0xdXFYZTAvT3V4NDZSdnNiN1ZYSnJFcXZNaGFBb08w?=
 =?utf-8?B?T2QvZkR1WVFobGhIckw2TEtlYWRKZkNsaTU4aEdqcDFRZTFGRFJKMnc0TFBB?=
 =?utf-8?B?cVBmRElWQ1JueWRCQVlvQ1lFWkFHUklkNEpKNDZCRUFnWnJudG8rbEFXWWNR?=
 =?utf-8?B?ZDJuLzU4S3c0UkFTMkFnUzljcFlXRDdQckxLM0ZMWFVubngzcjFYT05SNVl4?=
 =?utf-8?B?akZ6UGFNeVdLUFJNdFhwM01PRlMydmFrNy9UNldmTzJmV0s2dUtFdnQwd0kr?=
 =?utf-8?B?aXJRa0VubjR1eU1xNGJHcWhWQm1XaWlQZ1JaTDUyOGN1MjRDcnNtaFdGMk1n?=
 =?utf-8?B?bVF5Y1pnV1BrVjQyWERzYW9HWkIzZEJTN1NlZ1pONjRwekF5dEZMRXNGVU0y?=
 =?utf-8?B?WFF6eVc4ZDNNNGR2SVNVR0hTMzRyQVhSNHVUczVyeFVVK0dqS2JCUnFwa3J2?=
 =?utf-8?B?TFZ5V0RnNkN1cG9MRmRzT0U1RVl3NUVCNmtFVlZZZWtKNkRiV2JPeTZWTVcx?=
 =?utf-8?B?eitmSURyRFNVbFVoL2JXU0VHQ2VZcEZDbURxOFc4b21ZMkJZdnJ2ZzZEMnN2?=
 =?utf-8?B?UFBEYThndmhIcFJtM09Hb3B5OHpDOERKOXk1SUZYcytPUzI2SWtyeGdjbFNa?=
 =?utf-8?B?cWh3Zkw5eXZRODBvSFU2cXRHNzJGNmgzWHBvTGtlb2JOcTFmWkVNMm1YZ05n?=
 =?utf-8?B?R0NaSTA1b1E5WUNHbThHS0lYcTVrNzVmNG1IVGNZQW10YjNLN0YzQTNpSTVr?=
 =?utf-8?B?bThDbUdDcTJpcEg3bGtIY25aK3pmc3RVY1hUTUIzRHFJZnNSK2FVdkdKcDdz?=
 =?utf-8?B?NDBaY3lDTUZnUHpWU01MWllHd0VhcXB1WGlrckppUFpQYnVWMy9JTFhweFhM?=
 =?utf-8?B?b3Z4QTFlcm5hK2t4cGdZNFZvVXdzdzE5T0phU29MZHdFTDVDT0RIelVzMDAr?=
 =?utf-8?B?WDM0ZHdFRUc3ZUJtY1VuWlRKeDREOWF1ei82VUpocWQvRERyeWZqTlJFNUZi?=
 =?utf-8?B?eXROeUkyaTJId3l6TWYvYlRPOUtVb0JuazFoZlkreW1UU1g2SVkvbDJMNU54?=
 =?utf-8?B?R2lGR0x5SkFBZDh6NlAvaXJHSVMyMGNRMXFFQWNmb2hTYkowbkRMWjkzNFI0?=
 =?utf-8?B?WU9kVms5OFdUQ0pxL3k3RThnVlluUTFCT1RDTDRVQ3VtdzNhbkZnUXhuR2Vl?=
 =?utf-8?B?bGN1aUQ2dmhGK1AvTjFXcG1aSmNrUzJkV1dOdlVBWlhzdUVXMUlKTG1veHNa?=
 =?utf-8?B?ZTkvVG51bGpnOGQ3YmFHd0pXZ2pRYWdNZjRPL2xFR1J1RWFOZ1ArQm02WUVp?=
 =?utf-8?B?VmNkK0VUSE9qMThDUGZFd1RoYWdNRkJHUXREL0RNLzd0SEE5dGZkK1V4aDAw?=
 =?utf-8?B?blVtekxoQ0lQcmFuTXovNnBrOHBKQkVpY3Y3WHhXaXJQODB4U3c5Ty83VGp1?=
 =?utf-8?B?ZFJHcjhIck9HT1M3c1ViTDlqTytnTWE2RjRiQlZHNUNlRVhsNFBtNTNjUTVa?=
 =?utf-8?B?RU0yV2RuMzdObUFQQ3FWKzdJUG5RK3ZTZGhFbnRrcHZ2MHpHTXprN1QwTS9U?=
 =?utf-8?B?YUl3cExwbVozRldrLzFCV1Y4T2hMdFBFVFN6b1YzeDNUdmdaQWM4WC9LQlZ0?=
 =?utf-8?B?anVLc0tjZndRalhWVWRSY1R0dmxxRk9WZlFYOEdjZXpubnhuNHh1R2hLTGhI?=
 =?utf-8?B?NnpQNWVMRENWQWhWSm8vMkNrSDNsaUpDUmk3eFBuWGNVOHlBYkpOY1hKNkk4?=
 =?utf-8?B?a2k2QTZCQWQ2cDlhRlV2MDVoL0F1Ynd2RGxXTnpGQkNxc2VuWTdsQ2JGTkk4?=
 =?utf-8?B?RjY4anlPbDcrUjBQQzJJSGxkUWJ0K1gxandnMm1OZWRxamFlcHFuaXlYRTFn?=
 =?utf-8?B?dUduWVBMOWNGa1RFMTJ2Qzg1QkVvSnZZQXladUJoNVBtZ1drMWJWczVCU1F1?=
 =?utf-8?B?Wm9SQWlJYWszZ1gvdDEwTFN5alVZckhaQkFEUGVMR212M0JwYWNHc1hTZCsz?=
 =?utf-8?B?eTRnV0xOblZ1bzRZY0lyc0xWOWpZUnVXWUcxbC82OFFackRHYUE2S3VWeFZB?=
 =?utf-8?B?bGs5bVdDMEpsT1RTOVc3REExcW1OM1VjTk9QUWVIMUVoRnM0YkwvRnFWalpm?=
 =?utf-8?B?TlU4alN0czZnaVNuQlYwNm1tbHJDaGhXY3ZXa1hGcXVuTzN4Yi9EY281TEhO?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B4C3131CD5AB842A23C4FC5E3149785@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e40f3f-4e6d-4a77-4f9f-08dbc9d71704
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 21:23:04.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwimfdqtUJLY9jMxnf5HCt2LYi2YknXpmhYccTCmJ5q59sZ9PRJAjkd/7KRhLUkwouLTPE2oxbI7EDmXzx0jmx/aSLVBr1jsiN/2V0hxvOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6797
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTA5IGF0IDExOjA4ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA2LTEwLTIzLCAy
MjozNCwgS2VsdmluLkNhb0BtaWNyb2NoaXAuY29twqB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjMt
MTAtMDYgYXQgMTY6MDAgKzA1MzAsIFZpbm9kIEtvdWwgd3JvdGU6DQo+ID4gPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0K
PiA+ID4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+ID4gPiANCj4gPiA+IE9uIDA1LTEwLTIz
LCAxODozNSwgS2VsdmluLkNhb0BtaWNyb2NoaXAuY29twqB3cm90ZToNCj4gPiA+IA0KPiA+ID4g
PiA+ID4gPiArc3RhdGljIHN0cnVjdCBkbWFfYXN5bmNfdHhfZGVzY3JpcHRvciAqDQo+ID4gPiA+
ID4gPiA+ICtzd2l0Y2h0ZWNfZG1hX3ByZXBfd2ltbV9kYXRhKHN0cnVjdCBkbWFfY2hhbiAqYywN
Cj4gPiA+ID4gPiA+ID4gZG1hX2FkZHJfdA0KPiA+ID4gPiA+ID4gPiBkbWFfZHN0LCB1NjQgZGF0
YSwNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgZmxhZ3MpDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IGNhbiB5b3UgcGxlYXNlIGV4cGxhaW4gd2hhdCB0aGlzIHdpbW0gZGF0YSByZWZlcnMgdG8u
Li4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSSB0aGluayBhZGRpbmcgaW1tIGNhbGxiYWNr
IHdhcyBhIG1pc3Rha2UsIHdlIG5lZWQgYSBiZXR0ZXINCj4gPiA+ID4gPiA+IGp1c3RpZmljYXRp
b24gZm9yIGFub3RoZXIgdXNlciBmb3IgdGhpcywgd2hvIHByb2dyYW1zIHRoaXMsDQo+ID4gPiA+
ID4gPiB3aGF0DQo+ID4gPiA+ID4gPiBnZXRzDQo+ID4gPiA+ID4gPiBwcm9ncmFtbWVkIGhlcmUN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTdXJlLiBJIHRoaW5rIGl0J3MgYW4gYWx0ZXJuYXRpdmUg
bWV0aG9kIHRvIHByZXBfbWVtIGFuZA0KPiA+ID4gPiA+IHdvdWxkIGJlDQo+ID4gPiA+ID4gbW9y
ZQ0KPiA+ID4gPiA+IGNvbnZlbmllbnQgdG8gdXNlIHdoZW4gdGhlIHdyaXRlIGlzIDgtYnl0ZSBh
bmQgdGhlIGRhdGEgdG8gYmUNCj4gPiA+ID4gPiBtb3ZlZA0KPiA+ID4gPiA+IGlzDQo+ID4gPiA+
ID4gbm90IGluIGEgRE1BIG1hcHBlZCBtZW1vcnkgbG9jYXRpb24uIEZvciBleGFtcGxlLCB3ZSB3
cml0ZSB0bw0KPiA+ID4gPiA+IGENCj4gPiA+ID4gPiBkb29yYmVsbCByZWdpc3RlciB3aXRoIHRo
ZSB2YWx1ZSBmcm9tIGEgbG9jYWwgdmFyaWFibGUgd2hpY2gNCj4gPiA+ID4gPiBpcw0KPiA+ID4g
PiA+IG5vdA0KPiA+ID4gPiA+IGFzc29jaWF0ZWQgd2l0aCBhIERNQSBhZGRyZXNzIHRvIG5vdGlm
eSB0aGUgcmVjZWl2ZXIgdG8NCj4gPiA+ID4gPiBjb25zdW1lDQo+ID4gPiA+ID4gdGhlDQo+ID4g
PiA+ID4gZGF0YSwgYWZ0ZXIgY29uZmlybWluZyB0aGF0IHRoZSBwcmV2aW91c2x5IGluaXRpYXRl
ZCBETUENCj4gPiA+ID4gPiB0cmFuc2FjdGlvbnMNCj4gPiA+ID4gPiBvZiB0aGUgZGF0YSBoYXZl
IGNvbXBsZXRlZC4gSSBhZ3JlZSB0aGF0IHRoZSB1c2Ugc2NlbmFyaW8NCj4gPiA+ID4gPiB3b3Vs
ZA0KPiA+ID4gPiA+IGJlDQo+ID4gPiA+ID4gdmVyeQ0KPiA+ID4gPiA+IGxpbWl0ZWQuDQo+ID4g
PiANCj4gPiA+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4gbW9yZSBhYm91dCB0aGlzICd2YWx1ZScg
d2hlcmUgaXMgaXQNCj4gPiA+IGRlcml2ZWQNCj4gPiA+IGZyb20/DQo+ID4gPiBXaG8gcHJvZ3Jh
bXMgaXQgYW5kIGhvdy4uLg0KPiA+IA0KPiA+IFN1cmUuIFRoaW5rIG9mIGEgcHJvZHVjZXIvY29u
c3VtZXIgdXNlIGNhc2Ugd2hlcmUgdGhlIHByb2R1Y2VyIGlzIGENCj4gPiBob3N0IERNQSBjbGll
bnQgZHJpdmVyIGFuZCB0aGUgY29uc3VtZXIgaXMgYSBQQ0llIEVQLiBPbiB0aGUgRVAsDQo+ID4g
dGhlcmUNCj4gDQo+IFdoYXQgYXJlIHRoZSBleGFtcGxlcyBvZiBETUEgY2xpZW50cyBoZXJlPw0K
V2UgaGF2ZSBOb24tVHJhbnNwYXJlbnQgYnJpZGdlIChOVEIpIGZlYXR1cmUgb24gdGhlIHNhbWUg
c3dpdGNoLCB3aGljaA0KaGFzIHNjcmF0Y2hwYWQvZG9vcmJlbGwgcmVnaXN0ZXJzIHRoYXQgY291
bGQgYmUgdXNlZCBmb3IgZm9yIGNvbXBsZXRpb24NCm5vdGlmaWNhdGlvbiBvZiBkYXRhIG1vdmVt
ZW50IChvciBhbnkgb3RoZXIgbm90aWZpY2F0aW9uKS4gVGhlIE5UQg0KZmVhdHVyZSBpcyBwcmVz
ZW50ZWQgdG8gaG9zdCBhcyBhIFBDSWUgRVAgYW5kIHRoZSByZWdpc3RlcnMgYXJlIG1lbW9yeS0N
Cm1hcHBlZCBpbiBCQVIuIFdoZW4gY29tYmluZWQgdXNlZCB3aXRoIERNQSwgYSBETUEgY2xpZW50
IHdoaWNoIG1vdmVzDQpkYXRhIHRocm91Z2ggTlRCIG1lbW9yeSB3aW5kb3cgKG1lbW9yeS1tYXBw
ZWQgaW4gYmFyIHRvbykgdG8gYW5vdGhlcg0KaG9zdCwgd291bGQgdHlwaWNhbGx5IHdvcmsgaW4g
c3VjaCBhIHdheSB0aGF0IGl0IG1vdmVzIGJ1bGsgZGF0YSBmaXJzdA0KYW5kIHRoZW4gbm90aWZ5
IGl0cyBwZWVyIHRvIGNvbnN1bWUgdGhlbS4NCj4gDQo+ID4gaXMgYSBtZW1vcnktbWFwcGVkIGRh
dGEgYnVmZmVyIGZvciBkYXRhIHJlY2VpdmluZyBhbmQgYSBtZW1vcnktDQo+ID4gbWFwcGVkDQo+
ID4gZG9vcmJlbGwgYnVmZmVyIGZvciB0cmlnZ2VyaW5nIGRhdGEgY29uc3VtaW5nLiBFYWNoIHRp
bWUgZm9yIGEgYnVsaw0KPiA+IGRhdGEgdHJhbnNmZXIsIHRoZSBETUEgY2xpZW50IGRyaXZlciBm
aXJzdCBETUEgdGhlIGRhdGEgb2Ygc2l6ZSBYDQo+ID4gdG8NCj4gPiB0aGUgbWVtb3J5LW1hcHBl
ZCBkYXRhIGJ1ZmZlciwgdGhlbiBpdCBETUEgdGhlIHZhbHVlIFggdG8gdGhlDQo+ID4gZG9vcmJl
bGwNCj4gPiBidWZmZXIgdG8gdHJpZ2dlciBkYXRhIGNvbnN1bXB0aW9uIG9uIGRldmljZS4gT24g
cmVjZWl2aW5nIGENCj4gPiBkb29yYmVsbA0KPiA+IHdyaXRpbmcsIHRoZSBkZXZpY2Ugc3RhcnRz
IHRvIGNvbnN1bWUgdGhlIGRhdGEgb2Ygc2l6ZSBYIGZyb20gdGhlDQo+ID4gZGF0YQ0KPiA+IGJ1
ZmZlci4NCj4gPiANCj4gPiBGb3IgdGhlIGZpcnN0IERNQSBvcGVyYXRpb24sIHRoZSBETUEgY2xp
ZW50IHdvdWxkIHVzZQ0KPiA+IGRtYV9wcmVwX21lbW9yeSgpDQo+ID4gbGlrZSB3aGF0IG1vc3Qg
RE1BIGNsaWVudHMgZG8uIEhvd2V2ZXIsIGZvciB0aGUgc2Vjb25kIHRyYW5zZmVyLA0KPiA+IHZh
bHVlDQo+ID4gWCBpcyBoZWxkIGluIGEgbG9jYWwgdmFyaWFibGUgbGlrZSBiZWxvdy4NCj4gPiAN
Cj4gPiB1NjQgc2l6ZV90b190cmFuc2ZlcjsNCj4gDQo+IFdoeSBjYW50IHRoZSBjbGllbnQgZHJp
dmVyIHdyaXRlIHRvIGRvb3JiZWxsLCBpcyB0aGVyZSBhbnl0aGluZyB3aGljaA0KPiBwcmV2ZW50
cyB1cyBmcm9tIGRvaW5nIHNvPw0KDQpJIHRoaW5rIHRoZSBwb3RlbnRpYWwgY2hhbGxlbmdlIGhl
cmUgZm9yIHRoZSBjbGllbnQgZHJpdmVyIHRvIHJpbmcgZGINCmlzIHRoYXQgdGhlIGNsaWVudCBk
cml2ZXIgKGhvc3QgUkMpIGlzIGEgZGlmZmVyZW50IHJlcXVlc3RlciBpbiB0aGUNClBDSWUgaGll
cmFyY2h5IGNvbXBhcmVkIHRvIERNQSBFUCwgaW4gd2hpY2ggY2FzZSBQQ0llIG9yZGVyaW5nIG5l
ZWQgdG8NCmJlIGNvbnNpZGVyZWQuIA0KDQpBcyBQQ0llIGVuc3VyZXMgdGhhdCByZWFkcyBkb24n
dCBwYXNzIHdyaXRlcywgd2UgY2FuIGluc2VydCBhIHJlYWQgRE1BDQpvcGVyYXRpb24gd2l0aCBE
TUFfUFJFUF9GRU5TRSBmbGFnIGluIGJldHdlZW4gdGhlIHR3byBETUEgd3JpdGVzIChvbmUNCmZv
ciBkYXRhIHRyYW5zZmVyIGFuZCBvbmUgZm9yIG5vdGlmaWNhdGlvbikgdG8gZW5zdXJlIHRoZSBv
cmRlcmluZyBmb3INCnRoZSBzYW1lIHJlcXVlc3RlciBETUEgRVAuIEknbSBub3Qgc3VyZSBpZiB0
aGUgUkMgY291bGQgZW5zdXJlIHRoZSBzYW1lDQpvcmRlcmluZyBpZiB0aGUgY2xpZW50IGRyaXZl
ciBpc3N1ZSBNTUlPIHdyaXRlIHRvIGRiIGFmdGVyIHRoZSBkYXRhIERNQQ0KYW5kIHJlYWQgRE1B
IGNvbXBsZXRpb24sIHNvIHRoYXQgdGhlIGNvbnN1bWVyIGlzIGd1YXJhbnRlZWQgdGhlDQp0cmFu
c2ZlcnJlZCBkYXRhIGlzIHJlYWR5IGluIG1lbW9yeSB3aGVuIHRoZSBkYiBpcyB0cmlnZ2VyZWQg
YnkgdGhlDQpjbGllbnQgTU1JTyB3cml0ZS4gSSBndWVzcyBpdCdzIHN0aWxsIGRvYWJsZSB3aXRo
IE1NSU8gd3JpdGUgYnV0IGp1c3QNCnNvbWUgc3BlY2lhbCBjb25zaWRlcmF0aW9uIG5lZWRlZC4g
DQo+IA0KPiA+IA0KPiA+IEluIHRoaXMgY2FzZSwgdGhlIGNsaWVudCB3b3VsZCB1c2UgZG1hX3By
ZXBfd2ltbV9kYXRhKCkgdG8gRE1BDQo+ID4gdmFsdWUgWA0KPiA+IHRvIHRoZSBkb29yYmVsbCBi
dWZmZXIsIGxpa2UgYmVsb3cuDQo+ID4gDQo+ID4gZG1hX3ByZXBfd2ltbV9kYXRhKGNoYW4sIGRz
dF9mb3JfZGJfYnVmZmVyLCBzaXplX3RvX3RyYW5zZmVyLA0KPiA+IGZsYWcpOw0KPiA+IA0KPiA+
IEhvcGUgdGhpcyBleGFtcGxlIGV4cGxhaW5zIHRoZSB0aGluZy4gUGVvcGxlIHdvdWxkIGFyZ3Vl
IHRoYXQgdGhlDQo+ID4gY2xpZW50IGNvdWxkIHVzZSB0aGUgc2FtZSBkbWFfcHJlcF9tZW1vcnko
KSBmb3IgdGhlIGRvb3JiZWxsDQo+ID4gcmluZ2luZy4gSQ0KPiA+IHdvdWxkIGFncmVlLCB0aGlz
IEFQSSBqdXN0IGFkZHMgYW4gYWx0ZXJuYXRpdmUgd2F5IHRvIGRvIHNvIHdoZW4NCj4gPiB0aGUN
Cj4gPiBkYXRhIGlzIGFzIGxpdHRsZSBhcyA2NCBiaXQgYW5kIGl0IGFsc28gc2F2ZXMgYSBjYWxs
IHNpdGUgdG8NCj4gPiBkbWFfYWxsb2NfY29oZXJlbnQoKSB0byBhbGxvY2F0ZSBhIHNvdXJjZSBE
TUEgYnVmZmVyIGp1c3QgZm9yDQo+ID4gaG9sZGluZw0KPiA+IHRoZSA4LWJ5dGUgdmFsdWUsIHdo
aWNoIGlzIHJlcXVpcmVkIGJ5IGRtYV9wcmVwX21lbWNweSgpLg0KPiANCj4gSSB3b3VsZCBwcmVm
ZXIgdGhhdCwgKGFmdGVyIHRoZSBvcHRpb24gb2YgbW1pbyB3cml0ZSBmcm9tIGNsaWVudCksDQo+
IHRoZXJlDQo+IGlzIG5vdGhpbmcgc3BlY2lhbCBhYm91dCB0aGlzLCBhbm90aGVyIHR4bi4gWW91
IGNhbiBxdWV1ZSB1cCBib3RoIGFuZA0KPiBoYXZlIGRtYWVuZ2luZSB3cml0ZSB0byBkb29yYmVs
bCBpbW1lZGlhdGVseSBhZnRlciB0aGUgYnVmZmVyDQo+IGNvbXBsZXRlcw0KWWVzLCBJIGFncmVl
LCBqdXN0IHF1ZXVlIGFub3RoZXIgZG1hX3ByZXBfbWVtb3J5KCkgZm9yIHRoZSBkb29yYmVsbC4N
ClRoZSBkbWFfcHJlcF93aW1tX2RhdGEoKSBpcyBqdXN0IGFuIGFsdGVybmF0aXZlIGluIHRoaXMg
Y2FzZS4gV2UNCmRlZmluaXRlbHkgY2FuIGRvIGl0IHdpdGggZG1hX3ByZXBfbWVtb3J5KCkuIA0K
PiANCj4gPiANCj4gPiANCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIC8qIHNldCBzcS9jcSAqLw0K
PiA+ID4gPiA+ID4gPiArwqDCoMKgwqAgd3JpdGVsKGxvd2VyXzMyX2JpdHMoc3dkbWFfY2hhbi0+
ZG1hX2FkZHJfc3EpLA0KPiA+ID4gPiA+ID4gPiAmY2hhbl9mdy0NCj4gPiA+ID4gPiA+ID4gPiBz
cV9iYXNlX2xvKTsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHdyaXRlbCh1cHBlcl8zMl9iaXRz
KHN3ZG1hX2NoYW4tPmRtYV9hZGRyX3NxKSwNCj4gPiA+ID4gPiA+ID4gJmNoYW5fZnctDQo+ID4g
PiA+ID4gPiA+ID4gc3FfYmFzZV9oaSk7DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCB3cml0ZWwo
bG93ZXJfMzJfYml0cyhzd2RtYV9jaGFuLT5kbWFfYWRkcl9jcSksDQo+ID4gPiA+ID4gPiA+ICZj
aGFuX2Z3LQ0KPiA+ID4gPiA+ID4gPiA+IGNxX2Jhc2VfbG8pOw0KPiA+ID4gPiA+ID4gPiArwqDC
oMKgwqAgd3JpdGVsKHVwcGVyXzMyX2JpdHMoc3dkbWFfY2hhbi0+ZG1hX2FkZHJfY3EpLA0KPiA+
ID4gPiA+ID4gPiAmY2hhbl9mdy0NCj4gPiA+ID4gPiA+ID4gPiBjcV9iYXNlX2hpKTsNCj4gPiA+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiArwqDCoMKgwqAgd3JpdGV3KFNXSVRDSFRFQ19ETUFf
U1FfU0laRSwgJnN3ZG1hX2NoYW4tDQo+ID4gPiA+ID4gPiA+ID4gbW1pb19jaGFuX2Z3LQ0KPiA+
ID4gPiA+ID4gPiA+IHNxX3NpemUpOw0KPiA+ID4gPiA+ID4gPiArwqDCoMKgwqAgd3JpdGV3KFNX
SVRDSFRFQ19ETUFfQ1FfU0laRSwgJnN3ZG1hX2NoYW4tDQo+ID4gPiA+ID4gPiA+ID4gbW1pb19j
aGFuX2Z3LQ0KPiA+ID4gPiA+ID4gPiA+IGNxX3NpemUpOw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiB3aGF0IGlzIHdyaXRlIGhhcHBlbmluZyBpbiB0aGUgZGVzY3JpcHRvciBhbGxvYyBjYWxs
YmFjaywNCj4gPiA+ID4gPiA+IHRoYXQNCj4gPiA+ID4gPiA+IGRvZXMNCj4gPiA+ID4gPiA+IG5v
dA0KPiA+ID4gPiA+ID4gc291bmQgY29ycmVjdCB0byBtZQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IEFsbCB0aGUgcXVldWUgZGVzY3JpcHRvcnMgb2YgYSBjaGFubmVsIGFyZSBwcmUtYWxsb2NhdGVk
LCBzbw0KPiA+ID4gPiA+IEkNCj4gPiA+ID4gPiB0aGluaw0KPiA+ID4gPiA+IGl0J3MgcHJvcGVy
IHRvIGNvbnZleSB0aGUgcXVldWUgYWRkcmVzcy9zaXplIHRvIGhhcmR3YXJlIGF0DQo+ID4gPiA+
ID4gdGhpcw0KPiA+ID4gPiA+IHBvaW50Lg0KPiA+ID4gPiA+IEFmdGVyIHRoaXMgaW5pdGlhbGl6
YXRpb24sIHdlIG9ubHkgbmVlZCB0byBhc3NpZ24gY29va2llIGluDQo+ID4gPiA+ID4gc3VibWl0
DQo+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gdXBkYXRlIHF1ZXVlIGhlYWQgdG8gaGFyZHdhcmUg
aW4gaXNzdWVfcGVuZGluZy4NCj4gPiA+IA0KPiA+ID4gU29ycnkgdGhhdCBpcyBub3QgcmlnaHQs
IHlvdSBjYW4gcHJlcGFyZSBtdWx0aXBsZSBkZXNjcmlwdG9ycyBhbmQNCj4gPiA+IHRoZW4NCj4g
PiA+IHN1Ym1pdC4gT25seSBhdCBzdWJtaXQgaXMgdGhlIGNvb2tpZSBhc3NpZ25lZCB3aGljaCBp
cyBpbiBvcmRlciwNCj4gPiA+IHNvDQo+ID4gPiB0aGlzDQo+ID4gPiBzaG91bGQgYmUgbW92ZWQg
dG8gd2hlbiB3ZSBzdGFydCB0aGUgdHhuIGFuZCBub3QgaW4gdGhpcyBjYWxsDQo+ID4gPiANCj4g
PiBUaGUgaGFyZHdhcmUgYXNzdW1lcyB0aGUgU1EvQ1EgaXMgYSBjb250aWd1b3VzIGNpcmN1bGFy
IGJ1ZmZlciBvZg0KPiA+IGZpeA0KPiA+IHNpemVkIGVsZW1lbnQuIEFuZCB0aGUgYWJvdmUgY29k
ZSBwYXNzZXMgdGhlIGFkZHJlc3MgYW5kIHNpemUgb2YNCj4gPiBTUS9DUQ0KPiA+IHRvIHRoZSBo
YXJkd2FyZS4gQXQgdGhpcyBwb2ludCBoYXJkd2FyZSB3aWxsIGRvIG5vdGhpbmcgYnV0IHRha2UN
Cj4gPiBub3RlDQo+ID4gb2YgdGhlIFNRL0NRIGxvY2F0aW9uL3NpemUuDQo+ID4gDQo+ID4gV2hl
biBkbyBkbWFfaXNzdWVfcGVuZGluZygpLCB0aGUgYWN0dWFsIFNRIGhlYWQgd3JpdGUgd2lsbCBv
Y2N1ciB0bw0KPiA+IHVwZGF0ZSBoYXJkd2FyZSB3aXRoIHRoZSBjdXJyZW50IFNRIGhlYWQsIGFz
IGJlbG93Og0KPiA+IA0KPiA+IHdyaXRldyhzd2RtYV9jaGFuLT5oZWFkLCAmc3dkbWFfY2hhbi0+
bW1pb19jaGFuX2h3LT5zcV90YWlsKTsNCj4gDQo+IEJ1dCBpZiB0aGUgb3JkZXIgb2YgdHhuIHN1
Ym1pc3Npb24gaXMgY2hhbmdlZCB5b3Ugd2lsbCBpc3N1ZSBkbWEgdHhuDQo+IGluDQo+IHdyb25n
IG9yZGVyLCBzbyBpdCBzaG91bGQgYmUgd3JpdHRlbiBvbmx5IHdoZW4gZGVzYyBpcyBzdWJtaXR0
ZWQgbm90DQo+IGluDQo+IHRoZSBwcmVwIGludm9jYXRpb24hDQoNClRoZSBkcml2ZXIgaW1wbGVt
ZW50cyB0aGUgU1Egd2l0aCBhIHByZS1hbGxvY2F0ZWQgYnVmZmVyIHdoaWNoIG1lYW5zDQp0aGUg
ZGVzY3JpcHRvciB3ZSBhcmUgcHJlcGFyaW5nIGhhcyBhIGRldGVybWluZWQgc2xvdCBpbiB0aGUg
cXVldWUgd2hlbg0Kd2UgZG8gZG1hX3ByZXBfbWVtb3J5KCkgYW5kIGJlZm9yZSB3ZSBzdWJtaXQg
aXQuIFRvIGFsaWduIHdpdGggdGhlIHdheQ0KaG93IGNvb2tpZXMgY29tcGxldGUsIEkgaGF2ZSB0
byBtYWtlIHN1cmUgdGhhdCB0aGUgZGVzY3JpcHRvcnMgYXJlDQpwcmVwYXJlZCBhbmQgc3VibWl0
dGVkIGluIG9yZGVyLiBJIHRoaW5rIGl0J3MgYWxzbyBob3cgc29tZSBvdGhlciBETUENCmRyaXZl
cnMgd29yaywgbGlrZSBpb2F0LCBwbHguIA0KDQoNClRoYW5rcywNCktlbHZpbg0K
