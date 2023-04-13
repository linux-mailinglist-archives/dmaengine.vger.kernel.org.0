Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D025C6E14BD
	for <lists+dmaengine@lfdr.de>; Thu, 13 Apr 2023 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDMTAQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Apr 2023 15:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjDMTAP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Apr 2023 15:00:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02983C3A;
        Thu, 13 Apr 2023 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681412412; x=1712948412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y54FUizICEJmL9563LyfS+pjFic8At0l4qaYGWfu74Q=;
  b=2sXH5VnTqBq2c1HYrKBQwBqAnM6F7BwPmStzo3VJVhWK4QbNDgdrZ+T0
   0lUH6LhAPcMk844JkfHNZY05DmHFTtI+nxKRhpuBQHuUemUpbn4s5AtMf
   5F/khu/GDsXz7PfiZSfn4n0Xz3xGRSeE84765EivXXc3R9B/mPXUGjgW6
   M5ob/WE4tTjIOUS1E4eNabSinEDAo/65pWjkSWp56RQjhHpvZKRpTCruD
   UK7uaW6CoE2mmBNA9nOrg2k+9mdDH5GH5wg5m6oXI8uAi64hdHoAs1p+G
   mVE78lLDVEkOmxsD/UxkkkySq3kp+PxJB6KINMvf+xbAbwFXqMMeUXmYg
   w==;
X-IronPort-AV: E=Sophos;i="5.99,194,1677567600"; 
   d="scan'208";a="209454524"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2023 12:00:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Apr 2023 12:00:08 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Apr 2023 12:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ybe4swNmumxX1XbHYMeR35TN3xI2LsMd65ZBiu1LJ6V6atYMa28mDXdE7fHZICPeFe2SzV6JoDzLXEyMOCP1hu+BbGh78+BBJoWkgMqTnJpGhoNh5oOGEvm2J/Z/okBgBbTURJvE9Ix/BeeOkqJ49a6D4I2TIJSR+yNqwflFhf5I5KdiUZlnn5zRJK5LLJDPsRURDvhZzyWU1r9QWUY2OJFHzAoOba7wHInutJaTxsZMad21Ao5IIIQPr4i8bZZeLEYyBa4mcjOdLRyqRu/D2enI2FY2jdp0syhm9CR3b5JET2u8EP2jhCo1Zbp2wJbTeeQqBi8HULCQO3raWc+w9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y54FUizICEJmL9563LyfS+pjFic8At0l4qaYGWfu74Q=;
 b=PBt2izrSkj76JPLq6e7U+13h2emGTgj1+fgQFosPWIwb3AqX+6R/ltmMdqopbJ3NNvC41UnWKz/ovErlZAR1egNA3F1f4th0WuYmqsvKfUWECQfCHfs3SHJSpzHakRRmORPYvicfuihVyiAJncY2/IGSKMS0wUSUPbxMcvQxS6XubXlYsFncRHZmbZnvdtklXoVIwlXtoOtsXvjUeSplM1NrnyZbs4Dti2nSmRHvqO1UdGoskNqqzYgaTrpy83Dl9Mx6GJQDp70F0kGYTupfjWrcAbCbNo2xv9kIcRtbpf7EKBVTYWATL7VHBXzQ1TMXjrX/2t+leozuGmGIpPLnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y54FUizICEJmL9563LyfS+pjFic8At0l4qaYGWfu74Q=;
 b=vpseC7bhkBsjg4tPvEzCAx+MFK12s+R8AyaeQn9iVVWZ898ESfdO0k7XDfJ7FEIYuKqDY90TXA8by5ZirKIdUxmUK64GmOTtmBZwsNLOZO1OPoIxM0WAiyyNPG7/a2U0tMsWqJtk12upzFt0VqySUCGg4bVpyxgjxthlzirW3aA=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by PH7PR11MB7961.namprd11.prod.outlook.com (2603:10b6:510:244::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 19:00:05 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b%6]) with mapi id 15.20.6298.028; Thu, 13 Apr 2023
 19:00:05 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <logang@deltatee.com>, <hch@infradead.org>
CC:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <George.Ge@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZZmFWCpgZadogBUKZpBFKgoENK68kyiyAgAGC1YCAA1qMAA==
Date:   Thu, 13 Apr 2023 19:00:05 +0000
Message-ID: <b55469e7a0bca09ed6b41ac78368b9578767eb7d.camel@microchip.com>
References: <20230403180630.4186061-1-kelvin.cao@microchip.com>
         <20230403180630.4186061-2-kelvin.cao@microchip.com>
         <ZDQ8geSEauTsd2ME@infradead.org>
         <500092fe-71cc-b07c-fe6d-396a580c8252@deltatee.com>
In-Reply-To: <500092fe-71cc-b07c-fe6d-396a580c8252@deltatee.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|PH7PR11MB7961:EE_
x-ms-office365-filtering-correlation-id: 960f0f20-9666-4191-246f-08db3c514b23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: buy3xGbrVH+zrhf8how974EOe4sT25NpIhQibHRJc1pooZmqJGeey7XI0Nc1RwhZsFq5Wa0KmmT9jzyxik+f1ACUz+Cwc0fThRFC4T/nQ1yI9RZhs3zvNAQF3zZlq8yor6cjAQnMcLC7PUbIyLJMuGVWcgwpYwB/7jDov9L37+9fWNnaO5i2J1Bndk5olBzy8hqrDyvESekOl/MrIyI6fRWwGDeCF3NiEmlpsvY5nzmiK7wTaTbsvv/wxj5Bvi6lirRtmI3vn8gl27/tr5FtSL5/ZsQBVlq1Oi5iQDSVkV60rPTRv5XG0vCYma5ld283HZ5XcO1MgmWkRXWMGmIjravueTBNKDgIxKxzeOBiX4+TbhAC4xXVXfb6w3ZGv8sTW55XO70yxWl6YT4O3l1agkVePawuQzDPe1BvKE648hT6GRk0pCG69pgeH4e8goSZMSjUlG9bEM0Rl6lqqXM0BAPWDzO4RODhuY5A5m5Rho3DkYSr73l/5s0oJ96ijiU8ptrWVlsISVi7yiXBrYDtXKJYlr2NSjO4KRvekZ7Ce4ClwQHG93OUlGN2+8EMy0kYP7zt/6xo7Bqd+FGFhscahFdSheSa6+toC+JdjtBsw2s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(8936002)(6486002)(966005)(5660300002)(86362001)(66476007)(64756008)(66946007)(91956017)(76116006)(66446008)(4326008)(66556008)(478600001)(38100700002)(110136005)(38070700005)(122000001)(54906003)(8676002)(2906002)(71200400001)(53546011)(6512007)(6506007)(83380400001)(2616005)(186003)(316002)(36756003)(41300700001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alZsdGEvbDRPU3NiTFlPNEVuaU0zQWs5SXlMdm5tdjNsRU9HQ1V5NXpveE5u?=
 =?utf-8?B?UVZkYnhUYW9PczgyZ1E5OFlTVXRvRHBPQkIwazM1Q1pZY2QvNUJlOHhvTENa?=
 =?utf-8?B?WlJORCtSWHJ1RHRTME00UW9xYUVsTEVnaVhZdXRCbVc5L2dDS1NJMVh6TlBP?=
 =?utf-8?B?cUR1TmN0TmxDSE82NHlkMzN5bzUxWXVlOGo0T01kL2hZZEFFcTFnSCtkTUxw?=
 =?utf-8?B?NEphQTlVcmFoRFlwT2F0UzFLM0ZYbEJWYWZ2YUtEVTJTWXJVZjFEUkNCMm1n?=
 =?utf-8?B?V202VStVRHVZdkV2RExZWGhaT3dEMVFVeFpNbE95eUQ0SFkvN1c4T2dDbTRU?=
 =?utf-8?B?U0didEp2MGpxbGQ5K2RYZFJYN0M5dk90MSs0MVY4WEdGM3N5TEZjQnBOWU5P?=
 =?utf-8?B?cFUrQW9EbDl6cmtoUU15RXYxZjg5OHF1em9BQ2hLMGpjZzc4QXphY041VVNl?=
 =?utf-8?B?SC85eUo1amdyckIzV0FDT3J6N1lzbFpXK0VKcGN4bWZ0QU9uWEluZHNGek5p?=
 =?utf-8?B?Y2diN01McVFqRXlYaGJZNmFNQm5CYjQ1WEpnaHhmS0JMc1RhMzVMVkx6cXNl?=
 =?utf-8?B?UE9qRm96UG9OMXMxL1FoLytVZUNwNEhrakpKb25WVDNsQWZUS1FuRzdqQ1Nk?=
 =?utf-8?B?aTM2QUNldWpOZ25wUlhBd3A0Z0dueVhZaXdmUE5JdklwMDZQQ1VDcE02UllP?=
 =?utf-8?B?bG9Mc0dEVFhpQS9VWTdSRFlnUUloMmo4NzJQUlBVcGVKNzhSdVRZSzlnVEFY?=
 =?utf-8?B?TkFTS0ErVlBpZ2dYUFpkZXNIMkZ2T3l5VHVmcFBvcnI1RXhFek9UQlJPc2FJ?=
 =?utf-8?B?U25hR1ovWFp0RXRXdnZiVitFNWVkaS9sbFl6NG9ubFdvM1ltcDErLzhLd2Q0?=
 =?utf-8?B?UEVsV0lhdzAzemZhYTBRbnVMMjc3K0ptU1ZTeldFbEl4MDU0SmQ3cEJyK3Jt?=
 =?utf-8?B?ZVEzVU40d2hsanc0OG1IVW95RTBydndtanZiVVkzZytyckFLZFkxU3hYcFpu?=
 =?utf-8?B?VEJlRzRUQm1xRmorbFBsVWwyb0hNdWwvcE1SRnM2SUxPQWFpYUVzdXRFS0JL?=
 =?utf-8?B?ZlJlMVdpSVRRZUhiUUROeEFIa1VGdGplazJqWWJxM052R25VZjQ4ZExpb0FL?=
 =?utf-8?B?dHIxdTVNR29PbHl5NFl1ODF3N3dmdWZ3bzVDUnlKS3FzbUFZMldnSDN1ekVo?=
 =?utf-8?B?dnlXNVZ5ZDVsMnE4alVaK3dVNTFmM2NGdFhNeDY0YXRDV1plZExkU2IxZmNH?=
 =?utf-8?B?dWxlOFJLYTNDSXBKZDRsZysxN0dwZndZNmh4dUZsLzhmeG1TMXdCQVo3Witx?=
 =?utf-8?B?cnNqSW5nMnpPYTg3cXZ0UTNUNnRlQnYrNUF5L0UyRkRWdGJuQzg4MFlGdGFj?=
 =?utf-8?B?SitBQWEvclRKNVh1cFRJbEhuSml0dlZZbXY1Njh5RThac0g1QWVYZEVTQVV1?=
 =?utf-8?B?YmdDU05wbkRQNWdRU0NhSHAzbGhzcERmYi9IbXR3Nlg4RDAxSVc1czNiUnhu?=
 =?utf-8?B?ZnFzVmhBMDM5Yjc2dWtLdXJrQzRGbTEvckRyV2Q2N2FVbFVpS1owODEzekFi?=
 =?utf-8?B?QitwSzRIeCtIQ0M5R0IzaXNaMVE1VWdWM29YaWJvbndBTit6Ky9EUjFKeFZX?=
 =?utf-8?B?a0lXTE1lcm1UaEN3YXB1K0gwdjVFMUZTRGVkOXlobzZOZFJ4OFRETGRIOFlS?=
 =?utf-8?B?WXdmb1RMRmZqL09rNkZQaUpUQXpaMEd2RG91VHAxaTNidDA0WUh6SHpEQ0x5?=
 =?utf-8?B?TlY1WFBzQVBZd2ZHUkdPU1kydmUvSzNtT0FLRFFjc3h1Ri9Ud3p6emlMbWdC?=
 =?utf-8?B?K1NweEtWamQ1SnpYb0VTOGRFcGVNdEUzdnE5b3BCaUFiR01wRXpzTDNhelJB?=
 =?utf-8?B?Qyt3bjBRUDlCNmt4UEdyWFhXU2F6MnpzcUFucXFxRXpZbWlGb3hvZGgwK2lM?=
 =?utf-8?B?cVV4Q1A3TkVSMXd2M3JwWU9GbWZ0UCtuQk5ZT2FjQ1dtR2RQK05Lcng3SzNC?=
 =?utf-8?B?dU1DeUl0anllcmNqVzZZNklqQlBXV08yb201cW9HMmVGYm1PNTk0cDM2dWZz?=
 =?utf-8?B?MFZYK3cwMjgrRnJHMUp4cDAxWDNCTUFKbk9EbmpMMGFiN2J3UStoSjRwZ1lT?=
 =?utf-8?B?UFlRZUJzTzZ1dytSN1ZNVHk2c3BQNk9jSmVrUlYvazlCN3ZJN2FuRXFTVE1O?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A247BE7A0442F4428152AAA16B133FF2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960f0f20-9666-4191-246f-08db3c514b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 19:00:05.3285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Xlu9Uz0tueB43RzDyVF7SjC69oCXl+QaQxa9Q8B08g1YSH1OIFl0ayJvWo9DG0TqqxTqp1jZJIOYXtB9j1coKfm6I+2OzyMtFJ4khlZh04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7961
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gVHVlLCAyMDIzLTA0LTExIGF0IDA5OjQ3IC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+ID4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UgPg0KPiA+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+IA0KPiA+
IE9uIDIwMjMtMDQtMTAgMTA6NDIsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiA+ID4gPiBP
biBNb24sIEFwciAwMywgMjAyMyBhdCAxMTowNjoyOEFNIC0wNzAwLCBLZWx2aW4gQ2FvIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gKyNkZWZpbmUgSEFMVF9SRVRSWSAxMDANCj4gPiA+ID4gPiA+ICtzdGF0
aWMgaW50IGhhbHRfY2hhbm5lbChzdHJ1Y3Qgc3dpdGNodGVjX2RtYV9jaGFuDQo+ID4gPiA+ID4g
PiAqc3dkbWFfY2hhbikNCj4gPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gPiArwqDCoMKgIHUzMiBz
dGF0dXM7DQo+ID4gPiA+ID4gPiArwqDCoMKgIHN0cnVjdCBjaGFuX2h3X3JlZ3MgX19pb21lbSAq
Y2hhbl9odyA9ID4gPiA+DQo+ID4gPiA+ID4gPiBzd2RtYV9jaGFuLT5tbWlvX2NoYW5faHc7DQo+
ID4gPiA+ID4gPiArwqDCoMKgIGludCByZXRyeSA9IEhBTFRfUkVUUlk7DQo+ID4gPiA+ID4gPiAr
wqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpwZGV2Ow0KPiA+ID4gPiA+ID4gK8KgwqDCoCBpbnQgcmV0
Ow0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK8KgwqDCoCByY3VfcmVhZF9sb2NrKCk7DQo+
ID4gPiA+ID4gPiArwqDCoMKgIHBkZXYgPSByY3VfZGVyZWZlcmVuY2Uoc3dkbWFfY2hhbi0+c3dk
bWFfZGV2LT5wZGV2KTsNCj4gPiA+ID4gPiA+ICvCoMKgwqAgaWYgKCFwZGV2KSB7DQo+ID4gPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAtRU5PREVWOw0KPiA+ID4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byB1bmxvY2tfYW5kX2V4aXQ7DQo+ID4gPiA+ID4g
PiArwqDCoMKgIH0NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgd2hvbGUgUkNVIGNyaXRpY2FsIHNl
Y3Rpb24gYXJvdW5kIGV2ZXJ5IGFjY2VzcyB0byAtPnBkZXYgPg0KPiA+ID4gPiA+IHNjaGVtZQ0K
PiA+ID4gPiBsb29rcyBhIGJpdCBib3RoZXJzb21lIHRvIG1lLsKgIFRoaXMgbWVhbnMgdGhhdCBh
bGwgdGhlIGxvdy0NCj4gPiA+ID4gbGV2ZWwNCj4gPiA+ID4gUENJIG9wcyBhcmUgZG9uZSBpbiBS
Q1UgY3JpdGljYWwgc2VjdGlvbi7CoCBJcyB0aGlzIHNvbWV0aGluZw0KPiA+ID4gPiB5b3UNCj4g
PiA+ID4gY2FtZSB1cCB3aXRoIG9yIGlzIGl0IGNvcGllZCBmcm9tIG90aGVyIGRyaXZlcnM/DQo+
ID4gDQo+ID4gSSBzdXNwZWN0IHRoZXkgY29waWVkIGl0IGZyb20gcGx4X2RtYSBkcml2ZXIgdGhh
dCBJIHdyb3RlIDsoLA0KPiA+IHRob3VnaA0KPiA+IHRoYXQgZHJpdmVyIHVzZXMgcmN1X2RlcmVm
ZXJlbmNlIGEgYml0IG1vcmUgc3BhcmluZ2x5IChvbmx5IG9uDQo+ID4gc3RvcCwNCj4gPiBpc3N1
ZV9wZW5kaW5nIGFuZCB3aGVuIGFsbG9jYXRpbmcgYW5kIGZyZWVpbmcgYSBjaGFubmVsKS4NCj4g
PiANCg0KVGhhbmtzIExvZ2FuIGZvciBqdW1waW5nIGluLiBUaGUgUkNVIHN0dWZmIHdhcyBjb3Bp
ZWQgZnJvbSBwbHhfZG1hDQpkcml2ZXIuDQoNCj4gPiA+ID4gTm9ybWFsbHkgd2UnZCBkbyBhbiB1
bnJlZ2lzdHJhdGlvbiBmcm9tIHRoZSBkbWFlbmdpbmUgc3Vic3lzdGVtDQo+ID4gPiA+IGZpcnN0
LCB3aGljaCBtaWdodCBkbyBhIFJDVSBzeW5jaHJvbml6YXRpb24gYXQgYSBoaWdoIGxldmVsLA0K
PiA+ID4gPiBhbmQgdGhlbiB3ZSdyZSBzdXJlIHRoYXQgbm9uZSBvZiB0aGUgbWV0aG9kcyBnZXRz
IGNhbGxlZCBhZ2Fpbg0KPiA+ID4gPiBvbiB0aGUgdW5yZWdpc3RlcmVkIGRldmljZS4NCj4gPiA+
ID4gDQo+ID4gPiA+IENhbid0IHRoaXMgZHJpdmVyIChhbmQgdGhlIGRtYWVuZ2luZSBjb3JlKSBz
dXBwb3J0IGFuIG9wZXJhdGlvbg0KPiA+ID4gPiBtb2RlIHdoZXJlIHlvdSBzZXQgYSBzaHV0ZG93
biBmbGFnIGF0IHRoZSBiZWdpbm5pbmcNCj4gPiANCj4gPiBUaGUgZG1hZW5naW5lIGNvZGUgZGlk
bid0IHN1cHBvcnQgaG90IHVucGx1ZyBhdCBhbGwuIEkgYmVsaWV2ZSBtb3N0DQo+ID4gZHJpdmVy
cyBhcmUgbGlrZWx5IHRvIGNyYXNoIGlmIHRoaXMgaGFwcGVucy4gV2hlbiBJIHdyb3RlIHRoZSBw
bHgtDQo+ID4gZG1hDQo+ID4gZW5naW5lLCBJIGhhZCB0byBtYWtlIGEgYnVuY2ggb2YgY2hhbmdl
cyB0byBkbWFlbmdpbmUganVzdCBzbyB0aGUNCj4gPiBmcmFtZXdvcmsgZGlkbid0IGNyYXNoIHdo
ZW4gSSB0ZXN0ZWQgdGhpcy4gVGhlIGZyYW1ld29yayBpcyBwcmV0dHkNCj4gPiA+IHRoaW4sDQo+
ID4gc28gdGhlcmUncyBub3QgbXVjaCB0byBzeW5jaHJvbml6ZSBvbiB0byBpbmRpY2F0ZSBvdGhl
ciB0aHJlYWRzIGFyZQ0KPiA+ID4gbm90DQo+ID4gaW4gdGhlIG1pZGRsZSBvZiBpc3N1aW5nIG5l
dyBJTyB3aGVuIGEgZmxhZyBpcyBzZXQuDQoNCkEgYml0IG1vcmUgaGlzdG9yeSwgdGhpcyBpcyB0
aGUgdW5iaW5kIGlzc3VlIExvZ2FuIHNwb3R0ZWQgYW5kIGZpeGVkOg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMTkxMjE2MTkwMTIwLjIxMzc0LTEtbG9nYW5nQGRlbHRhdGVlLmNvbS8N
Cj4gPiANCj4gPiA+ID4gPiA+ICvCoMKgwqAgdGFza2xldF9zY2hlZHVsZSgmc3dkbWFfZGV2LT5j
aGFuX3N0YXR1c190YXNrKTsNCj4gPiA+ID4gDQo+ID4gPiA+IFdoYXQgc3BlYWtzIGFnYWluc3Qg
c2ltcGx5IHVzaW5nIHRocmVhZGVkIGlycXMgaGVyZSBpbnN0ZWFkIG9mDQo+ID4gPiA+IHRoZQ0K
PiA+ID4gPiB0YXNrbGV0cz8NCj4gPiANCj4gPiBBbG1vc3QgYWxsIHRoZSBkbWFlbmdpbmUgZHJp
dmVycyB1c2UgdGFza2xldHMuIEkgZG9uJ3Qga25vdyBpZiB0aGlzDQo+ID4gPiBpcw0KPiA+IHRo
ZSBiZXN0IGFwcHJvYWNoLCBidXQgbXkgdW5kZXJzdGFuZGluZyB3YXMgdGhhdCBpdCB3YXMgZHVl
IHRvID4NCj4gPiBuZWVkaW5nDQo+ID4gbG93IGxhdGVuY3kgaW4gcHJvY2Vzc2luZyB0aGUgY29t
cGxldGVkIGRlc2NyaXB0b3JzLCBvdGhlcndpc2UgaXQNCj4gPiBjYW4gPiBiZQ0KPiA+IGhhcmQg
dG8gcmVhY2ggdGhlIGZ1bGwgYmFuZHdpZHRoIG9mIHRoZSBkbWEgZW5naW5lLg0KPiA+IA0KPiA+
IExvZ2FuDQoNCg==
