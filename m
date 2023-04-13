Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4E6E179A
	for <lists+dmaengine@lfdr.de>; Fri, 14 Apr 2023 00:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjDMWk7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Apr 2023 18:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjDMWk4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Apr 2023 18:40:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544B9423A;
        Thu, 13 Apr 2023 15:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681425647; x=1712961647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cv/6PfID3vCBjJtKsJUd0x4X3hxRPGLTah4DOpRfXAQ=;
  b=Bh9MrtpBM+NpMsKBgVwyto72wpc3/FwRcNx3TvaCb2lbG+UJny70P6X6
   BhRoZ6e5LVD9gDJNU/W5GkS9Am9bkBDc+BgyRNBbtRVKS+T0IUwR+2mSL
   fu7l3bweHGj/nLWT2+aH/T5kmXWssC/enuSbxElskHdYwEXqwJXBISP2U
   RU/pt73Y9+OE10MbwkZ+25KdP3E7c9fGlxwMqMUHqSQ8LQnDcI9oBNRii
   7+riqUd9KVenyvKG1bky/85065kRMDts09YRaikOeZfCnwdRvwpcrHueC
   g17bwsMhhTcPLYbXsSMCQ2rIpl2LmPkF4Lbbgzo6eVjsHOLcf/gd4qVpl
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,195,1677567600"; 
   d="scan'208";a="209470751"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2023 15:40:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Apr 2023 15:40:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Apr 2023 15:40:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9XvUoewductXAhH6kuIpZS1UrE60ZMpticI4dIYWXM7KehPgtXFotO7xcEdiD7HWLEwap00kc8npSfZ0KXH8EeOSzJzF1nUutEOyvYLcHeeLvm7TDLgnLBZvRrR7xjgng6xsGHfUv1VvISq9a3iFoxeL8qCVVlWCo7cncm9/CcidFIQtqooOS0DG2yXd5U6ONUiGcDJR3DZ0IjkdkiU6ojvMPdEkbzstSaX0pMnvk+P1iwZsvEGBs01Vf8dyuOmN4TlinECowXqrbfqxGETfcnToh7nsDfNcLx69/EZn43/Xl7YXY2qCigpcTNxJ6G2EoSdS4wedsRxAFPI/Kg9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv/6PfID3vCBjJtKsJUd0x4X3hxRPGLTah4DOpRfXAQ=;
 b=Kmbmli5YS6Gu3TjC9TF9qEcL/5BO0JCFuNDvpRZnOziC8xMmHfG03P4fDCzab4fBkx+jp/HmEzA9mBFkosg3c0rU9aLQvaHctRKDkqBUI8QN6r06WFiVoA9Kwa7luo5/rrr1EMjtyLC0AfP/kGYfaVMBUR0Om/VVZIVvvmS/xQaZGxrHy06vsIbISWidVWXdu/gKSDzHdDEURw9M8YnozRZcehIM6mYxmx90cCRPbN2OVn2jN/A/HfjKSJwKPwzWEPl+PVibt3/pCKXLVJGlLLwFhH3CHY8InBDXQnbyBE/itJpeKt58DBX2WT+doWe44ClT0/98skZJzSySohDMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv/6PfID3vCBjJtKsJUd0x4X3hxRPGLTah4DOpRfXAQ=;
 b=WnT6HeHWJlIhaIjnYZuJtLoi86qyClrzWMr+vn6CqKRGwjN8Ck87SZRCNA/iJdmQJC4tpXiODM8I+qTR43QslhlH6wszh6RuiPEfdvVO/MnOVsGs9U2hrkaupV2Mr1il6pqfg+OVg9FEr74cP3j+A6hXq218vxB1Cuzy19GEJrE=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 22:40:41 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b%6]) with mapi id 15.20.6298.028; Thu, 13 Apr 2023
 22:40:41 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <hch@infradead.org>
CC:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <George.Ge@microchip.com>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>
Subject: Re: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZZmFWCpgZadogBUKZpBFKgoENK68kyiyAgAUbAwA=
Date:   Thu, 13 Apr 2023 22:40:41 +0000
Message-ID: <cee60331584b0408f61652376234078d4049359c.camel@microchip.com>
References: <20230403180630.4186061-1-kelvin.cao@microchip.com>
         <20230403180630.4186061-2-kelvin.cao@microchip.com>
         <ZDQ8geSEauTsd2ME@infradead.org>
In-Reply-To: <ZDQ8geSEauTsd2ME@infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|CY8PR11MB7108:EE_
x-ms-office365-filtering-correlation-id: 4a5c547d-737f-46d6-9f23-08db3c701c88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJbzpAar/hXsDjbS7ZdFeEDIaWsGxHxSbzw/KgOezlgBqmuZcRv1GxdhrRyYp6x/suIrKFOyQ5f0kskcdkJY/9h8ukoZdnF022J1u33fjXSs6ksl+mtAFYBJ+6WXssOpC/ZSZ0ZGTA7KYN85QP+O3b+0tfiup3Xx/Oikgv2bkx+L2Eun2Q8Xn7bMmWj2fJcoep2iP7rdQQWIHsJIh7Kqf9FZINpbTxYNRmW0OKx8L1HDe1SJ4LY6G5pDf8gLdrlUSR1gWRl+QXNC8+g5yAtdWMhsU8EEcdRxLYeWvKKoobf8LQMrO1blt8tal9HaFNpNn0tTKQypnEPxpRvil4OwPl4AVQHFtnOFy6a5w8qqeBz+MSQOwPlE9EquxtRg/pn5Hh2Bj5+kREAY5GzB7hymvpkXjtv95F0nru5RWFSy7cxHF3tRFiy0f6HiN8YsuY8Naj/Ropl4b0zBNPIGmA55fqazJc8QEG6d2rA/xYoRZ7Pb8JIUVTlpWY8oTpFZboS4hXQb7E2y77/p8AEIZPnYrCk5H4J+xdXLimQfv0IZb3kDwQC2mM/+wHEMEWiTVvYYRqWfv5+9VYEcclG3alHRskuo6+cvcYU9/BXvl61m557xu6sIHXifaVKvFfgxM0xMKe2kdvdsFgcT46w8K8ZBWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(26005)(6512007)(6506007)(54906003)(186003)(83380400001)(2616005)(71200400001)(6486002)(5660300002)(41300700001)(316002)(8676002)(8936002)(86362001)(38070700005)(38100700002)(122000001)(478600001)(36756003)(66446008)(64756008)(4326008)(66946007)(76116006)(91956017)(6916009)(66476007)(66556008)(2906002)(3714002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzBNQzhTek90c21sUTRkb25PZHBzdmtHR0tuOENtaGF3NmJ5aWl2Q3RsaG9q?=
 =?utf-8?B?VDZrblR4cDVDYjNtYWRXT0Z3Tktlb0l1UHdqcnRFVTRwc2NWdzBBQUsrWTcw?=
 =?utf-8?B?NnNBdllxNTd3WUg5a3BicVhKeUJXcGpUUzl4ZEZHdWFUNUs2N0hIYmhpSEp5?=
 =?utf-8?B?ckRFRGUvbkpFSmFlYk5NRUZ2d0hhdlQrRW0wS3NLQ0FwZk41Y0V0T0hzMTBm?=
 =?utf-8?B?NzV0Z0doeW5LeTRmU2oxclVPMWZKejV5QS9Cbzgwa2dHRVhNcW8vVmtreW9s?=
 =?utf-8?B?MlErWjM0M0RxMkJnZW5SU05tL3VEazFSQVBmZWFXNXpaUDlVb3Nlb3d6bTlH?=
 =?utf-8?B?dUFEOEZFVFQxa1ZjenF4VkI4UVRWQm5CWGRaQXV3TnpYUEFOR3VpZmtZeXIr?=
 =?utf-8?B?WHJNUWRhcmJNYjVPbEZTOVVPMmM3eTJXdXRxaTFKUVlCL3ppYmNCOGdjQ0wz?=
 =?utf-8?B?M2YweGU3Zmc0MGc0Ym5ETVBwMlFBcnBlNHEzUGQwMVF5L3BURjJmQ0tGQThL?=
 =?utf-8?B?RnJabXRzdjBuZDBtZjY0VTVoYjl1akhOT3c1d2FMdU5ENE1hamNScmxaaEd1?=
 =?utf-8?B?aEp4ZmhlbHM4WDZUNmdkQXR0R3oxNExZckhDRnFjeGRKaG52aHIwaVlqaTZr?=
 =?utf-8?B?R3U3aEtpN2k5TEdGTmZ6MW1OZXZCZEJvcmNERzJacURoRlUxVURwbjJOTDg5?=
 =?utf-8?B?dDQxMUplbVk1eDk3anQ2Z0xoeSs1YUFPTnB2THFEWDBYdnNHUVJFUXVJOCtU?=
 =?utf-8?B?Q3VFZy8rRWxsM1BobXg0MjMwbk05SVd0VzdTWW1TSFRTTmdxVXVub05iUGdQ?=
 =?utf-8?B?Wi92Qkk0aTRnZEdNRWNXbnNiSVc4OXBlTWk1U1BnL2Fia3BhS2hWNGZFd3My?=
 =?utf-8?B?dEtuVmxDUjNPMTdEc2dic1cxbmYzakhmMnFhQ0poRFdPbTU1QmhpbWcyTnR3?=
 =?utf-8?B?UXpscG9Qb3E2RW5wbmRnR24xeUtGUDZqcXMrVzNyWjVrRDBjUE83RERmSTdl?=
 =?utf-8?B?K3RNKzNiaWs3YmdlQnhlaEhiUklsdjRtMzJ2V0UvUWtNOURYWnNkelA0L3Q4?=
 =?utf-8?B?djFua0VYR0NpcW5uQXZ3SFJyV2NYaEFCZGl5c1ByaWVCTis1eEJ1bGdyV2RY?=
 =?utf-8?B?SVRlMW1JK21rc2J1OUx0aVdyM1dCUDRkaEtveEovNmd0TFB2dVgybUhpdHdk?=
 =?utf-8?B?aGZMdzhMdmM4Y2FIeDk0eGdna255VjB0bEhkbDVtUU4wZXhRQVNoVmo0SXNR?=
 =?utf-8?B?UTVyN2Y5bmJ2dGpERUhCOHZhaVFPbTdGQWhiSzY0VTdyLzNFbHF4L0duVzND?=
 =?utf-8?B?YlZ2S0RnMHROVzVJVWZSUEZWOHVkM0N0T2xIQTBzNzE0K0dMUmNTTlZVM0Ra?=
 =?utf-8?B?bE9JeGsxTk1IVGJySmNVck9DTVBHZ3RhR3BNWkRKY21YTGpZQ3RkSDZsQk5n?=
 =?utf-8?B?NEw0a2syRG8xb2wvNm1Rc1VTMXdkNk43cVVMamFWbjJDWEltUkpzdFhva29H?=
 =?utf-8?B?dDVzSG9qTzZQNDg0SjRFRFZGbWliUS8rYVhNc0NuaWRnRXdCSFZhREIrek1J?=
 =?utf-8?B?Qi9FaHRvZlVMeVVmSkhLNHZrL1FIMjZhb0dwajkxbTNnTlY4SzZsN2p0QnZp?=
 =?utf-8?B?ZDZCRWJyWnZnL3Bsd3haRUJ3aGQ3RUFzMnRCSFJNV1hJckF0NHpjMStHU1Vq?=
 =?utf-8?B?Vi9ITUpxWVozbXo3WmlwZEJJbDRDVlNmK1B4T0dTQXU1UFpKU3kxVG5yK3p3?=
 =?utf-8?B?Sm40YWNPekE5Y0U5S1NjaUt6UC9zRnMrdjNNRThiUkpyQm5ZV0lGMTh1UldF?=
 =?utf-8?B?Mk1NRVN2NEY0S0c2MEtJdVJMeWlmS3pJVkcvcGlCcEE3OTFZYXhQTDBKNDcr?=
 =?utf-8?B?MzFOUzRqUUtVbjNDVkc3YUdYVnlYSDRQanRoSU1NR1BVc0VLUmxQK1Rnb1h3?=
 =?utf-8?B?NmtwdmNXQ3JJbEJUY09KWDlHRW9oRTBTT2RzRkpNTFFKdDZtcXU3OVJMTjls?=
 =?utf-8?B?c0hxUXdldVBFUDl5RGgyUmI1YXN5T1ZNaFpDU3BCT0t1Ymx1bTN4U2JhcXpI?=
 =?utf-8?B?OC9QWjJ5QjdVR2JrNUdiZGNHVnlzWEtCV3kzVkJaOGRkODlxczR3TExrK0VS?=
 =?utf-8?B?R080MlhTYXBDMjlSUjZYTERnYnZFMCtIS3AwaCs5NWVzd0ZyeS9SZkJpRGJ1?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3418FF5ED5CF6047B50DCAD0C9097397@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5c547d-737f-46d6-9f23-08db3c701c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 22:40:41.5349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEJU+bPCQz0JbmV6YYgmmxRrqc9AYPCk8ueywB1falzyq1VUXhsGRt8NAe9TvWTdtWsH3UXBuB8bla+jpB82/M+HIRQxG09R4QvvknsCK4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTEwIGF0IDE4OjQyICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiA+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91ID4KPiA+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+ID4gCj4gPiBP
biBNb24sIEFwciAwMywgMjAyMyBhdCAxMTowNjoyOEFNIC0wNzAwLCBLZWx2aW4gQ2FvIHdyb3Rl
Ogo+ID4gPiA+ICsjZGVmaW5lIEhBTFRfUkVUUlkgMTAwCj4gPiA+ID4gK3N0YXRpYyBpbnQgaGFs
dF9jaGFubmVsKHN0cnVjdCBzd2l0Y2h0ZWNfZG1hX2NoYW4gKnN3ZG1hX2NoYW4pCj4gPiA+ID4g
K3sKPiA+ID4gPiArwqDCoMKgwqAgdTMyIHN0YXR1czsKPiA+ID4gPiArwqDCoMKgwqAgc3RydWN0
IGNoYW5faHdfcmVncyBfX2lvbWVtICpjaGFuX2h3ID0gPiA+IHN3ZG1hX2NoYW4tCj4gPiA+ID4g
Pm1taW9fY2hhbl9odzsKPiA+ID4gPiArwqDCoMKgwqAgaW50IHJldHJ5ID0gSEFMVF9SRVRSWTsK
PiA+ID4gPiArwqDCoMKgwqAgc3RydWN0IHBjaV9kZXYgKnBkZXY7Cj4gPiA+ID4gK8KgwqDCoMKg
IGludCByZXQ7Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDCoCByY3VfcmVhZF9sb2NrKCk7Cj4g
PiA+ID4gK8KgwqDCoMKgIHBkZXYgPSByY3VfZGVyZWZlcmVuY2Uoc3dkbWFfY2hhbi0+c3dkbWFf
ZGV2LT5wZGV2KTsKPiA+ID4gPiArwqDCoMKgwqAgaWYgKCFwZGV2KSB7Cj4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAtRU5PREVWOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZ290byB1bmxvY2tfYW5kX2V4aXQ7Cj4gPiA+ID4gK8KgwqDCoMKgIH0KPiA+
IAo+ID4gVGhpcyB3aG9sZSBSQ1UgY3JpdGljYWwgc2VjdGlvbiBhcm91bmQgZXZlcnkgYWNjZXNz
IHRvIC0+cGRldgo+ID4gc2NoZW1lCj4gPiBsb29rcyBhIGJpdCBib3RoZXJzb21lIHRvIG1lLsKg
IFRoaXMgbWVhbnMgdGhhdCBhbGwgdGhlIGxvdy1sZXZlbAo+ID4gUENJIG9wcyBhcmUgZG9uZSBp
biBSQ1UgY3JpdGljYWwgc2VjdGlvbi7CoCBJcyB0aGlzIHNvbWV0aGluZyB5b3UKPiA+IGNhbWUg
dXAgd2l0aCBvciBpcyBpdCBjb3BpZWQgZnJvbSBvdGhlciBkcml2ZXJzPwo+ID4gCj4gPiBOb3Jt
YWxseSB3ZSdkIGRvIGFuIHVucmVnaXN0cmF0aW9uIGZyb20gdGhlIGRtYWVuZ2luZSBzdWJzeXN0
ZW0KPiA+IGZpcnN0LCB3aGljaCBtaWdodCBkbyBhIFJDVSBzeW5jaHJvbml6YXRpb24gYXQgYSBo
aWdoIGxldmVsLAo+ID4gYW5kIHRoZW4gd2UncmUgc3VyZSB0aGF0IG5vbmUgb2YgdGhlIG1ldGhv
ZHMgZ2V0cyBjYWxsZWQgYWdhaW4KPiA+IG9uIHRoZSB1bnJlZ2lzdGVyZWQgZGV2aWNlLgo+ID4g
Cj4gPiBDYW4ndCB0aGlzIGRyaXZlciAoYW5kIHRoZSBkbWFlbmdpbmUgY29yZSkgc3VwcG9ydCBh
biBvcGVyYXRpb24KPiA+IG1vZGUgd2hlcmUgeW91IHNldCBhIHNodXRkb3duIGZsYWcgYXQgdGhl
IGJlZ2lubmluZwo+ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqAgc3Bpbl9sb2NrKCZzd2RtYV9j
aGFuLT5od19jdHJsX2xvY2spOwo+ID4gPiA+ICvCoMKgwqDCoCB3cml0ZWIoU1dJVENIVEVDX0NI
QU5fQ1RSTF9IQUxULCAmY2hhbl9ody0+Y3RybCk7Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDC
oCByZXQgPSAtRUlPOwo+ID4gPiA+ICvCoMKgwqDCoCBkbyB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdGF0dXMgPSByZWFkbCgmY2hhbl9ody0+c3RhdHVzKTsKPiA+ID4gPiAr
Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoc3RhdHVzICYgU1dJVENIVEVD
X0NIQU5fU1RTX0hBTFRFRCkgewo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldCA9IDA7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9
Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWRlbGF5KDEwMDAp
Owo+ID4gPiA+ICvCoMKgwqDCoCB9IHdoaWxlIChyZXRyeS0tKTsKPiA+ID4gPiArwqDCoMKgwqAg
c3Bpbl91bmxvY2soJnN3ZG1hX2NoYW4tPmh3X2N0cmxfbG9jayk7Cj4gPiAKPiA+IFdoeSBpcyB0
aGUgbG9jayBuZWVkZWQgd2hpbGUgcmVhZGluZyB0aGUgc3RhdHVzIGFuZCB3YWl0aW5nCj4gPiBm
b3IgaXQgd2l0aCBsb25nIGRlbGF5cz8KVGhlcmUncyAobG93KSBjaGFuY2Ugb2YgYWNjZXNzIHRv
IHRoZSBzYW1lIGN0cmwgcmVnaXN0ZXIgZnJvbSBvdGhlcgpwYXRocyB3aGljaCBtaWdodCBjaGFu
Z2UgdGhlIHZhbHVlIG9mIHN0YXR1cyBpbiBhbiB1bmV4cGVjdGVkIHdheS4gSXQKYWxzbyBwcmV2
ZW50cyB0aGUgaGFyZHdhcmUgb3BlcmF0aW9uIGZyb20gYmVpbmcgaW50ZXJydXB0ZWQgdW50aWwg
aXQKaW5kaWNhdGVzIGl0IGhhcyBmaW5pc2hlZCBieSBhIGJpdCBzZXQgaW4gdGhlIHN0YXR1cyBy
ZWdpc3Rlci4KPiA+IAo+ID4gPiA+ICvCoMKgwqDCoCBzcGluX2xvY2soJnN3ZG1hX2NoYW4tPmh3
X2N0cmxfbG9jayk7Cj4gPiA+ID4gK8KgwqDCoMKgIGN0cmwgPSBTV0lUQ0hURUNfQ0hBTl9DVFJM
X1JFU0VUOwo+ID4gPiA+ICvCoMKgwqDCoCBjdHJsIHw9IFNXSVRDSFRFQ19DSEFOX0NUUkxfRVJS
X1BBVVNFOwo+ID4gPiA+ICvCoMKgwqDCoCB3cml0ZWwoY3RybCwgJmNoYW5faHctPmN0cmwpOwo+
ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqAgdWRlbGF5KDEwMDApOwo+ID4gPiA+ICsKPiA+ID4g
PiArwqDCoMKgwqAgY3RybCA9IFNXSVRDSFRFQ19DSEFOX0NUUkxfRVJSX1BBVVNFOwo+ID4gPiA+
ICvCoMKgwqDCoCB3cml0ZWwoY3RybCwgJmNoYW5faHctPmN0cmwpOwo+ID4gPiA+ICvCoMKgwqDC
oCBzcGluX3VubG9jaygmc3dkbWFfY2hhbi0+aHdfY3RybF9sb2NrKTsKPiA+IAo+ID4gVGhpcyBs
b29rcyBicm9rZW4uwqAgUENJZSBNTUlPIFdyaXRlIFRMUHMgYW4gbWlnaHQgbm90IG5ldmVyCj4g
PiByZWFjaCB0aGUgZGV2aWNlIHVudGlsIHlvdSBkbyBhIHJlYWQgZnJvbSBpdC7CoCBTbyBpbnN0
ZWFkIG9mCj4gPiB0aGUgdWRlbGF5IHlvdSBwcm9iYWJseSBuZWVkIHRvIGRvIGEgcmVhZCogb3Bl
cmF0aW9uIHRvIHNvbWUKPiA+IHJlZ2lzdGVyIHRoYXQgaGFzIG5vIHNpZGUgZWZmZWN0cy4KPiA+
IApHb29kIHBvaW50LgoKPiA+IEFsc28gd2hhdCBpcyB0aGUgcG9pbnQgb2YgdGhlIGN0cmwgbG9j
YWwgdmFyaWFibGU/wqAgSnVzdCBwYXNzaW5nCj4gPiB0aGUgdmFsdWVzIGRpcmVjdGx5IHdvdWxk
IGJlIHNob3J0ZWQgYW5kIGVhc2llciB0byByZWFkLgoKT0sKPiA+IAo+ID4gPiA+ICvCoMKgwqDC
oCBzcGluX2xvY2soJnN3ZG1hX2NoYW4tPmh3X2N0cmxfbG9jayk7Cj4gPiA+ID4gK8KgwqDCoMKg
IHdyaXRlYihTV0lUQ0hURUNfQ0hBTl9DVFJMX1BBVVNFLCAmY2hhbl9ody0+Y3RybCk7Cj4gPiA+
ID4gK8KgwqDCoMKgIHNwaW5fdW5sb2NrKCZzd2RtYV9jaGFuLT5od19jdHJsX2xvY2spOwo+ID4g
PiA+ICsKPiA+ID4gPiArwqDCoMKgwqAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gPiA+ID4gKwo+ID4g
PiA+ICvCoMKgwqDCoCAvKiB3YWl0IDYwbXMgdG8gZW5zdXJlIG5vIHBlbmRpbmcgQ0VzICovCj4g
PiA+ID4gK8KgwqDCoMKgIG1zbGVlcCg2MCk7Cj4gPiAKPiA+IFdpdGhvdXQgYSBwcmV2aW91cyBy
ZWFkKiB0byBmbHVzaCB0aGUgcG9zdGVkIHdyaXRlcyB5b3UncmUgbm90Cj4gPiBhY3R1YWxseSB3
YWl0aW5nIDYwbXMgaGVyZSBmcm9tIHRoZSBkZXZpY2UgUE9WLgpZZXMuCj4gPiAKPiA+ID4gPiAr
wqDCoMKgwqAgc3Bpbl9sb2NrKCZzd2RtYV9jaGFuLT5od19jdHJsX2xvY2spOwo+ID4gPiA+ICvC
oMKgwqDCoCB3cml0ZWIoU1dJVENIVEVDX0NIQU5fQ1RSTF9QQVVTRSwgJmNoYW5faHctPmN0cmwp
Owo+ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqAgcmV0ID0gLUVJTzsKPiA+ID4gPiArwqDCoMKg
wqAgZG8gewo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gcmVhZGwo
JmNoYW5faHctPnN0YXR1cyk7Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKHN0YXR1cyAmIFNXSVRDSFRFQ19DSEFOX1NUU19QQVVTRUQpIHsKPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAwOwo+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHVkZWxheSgxMDAwKTsKPiA+ID4gPiArwqDCoMKgwqAgfSB3aGlsZSAo
cmV0cnktLSk7Cj4gPiA+ID4gK8KgwqDCoMKgIHNwaW5fdW5sb2NrKCZzd2RtYV9jaGFuLT5od19j
dHJsX2xvY2spOwo+ID4gCj4gPiBTYW1lIGNvbW1lbnQgYWJvdXQgd2FpdGluZyB1bmRlciBhIHNw
aW5sb2NrIGhlcmUuCj4gPiAKPiA+ID4gPiArwqDCoMKgwqAgZG8gewo+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gcmVhZGwoJmNoYW5faHctPnN0YXR1cyk7Cj4gPiA+
ID4gKwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCEoc3RhdHVzICYgU1dJ
VENIVEVDX0NIQU5fU1RTX1BBVVNFRCkpIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAwOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQo+ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVkZWxh
eSgxMDAwKTsKPiA+ID4gPiArwqDCoMKgwqAgfSB3aGlsZSAocmV0cnktLSk7Cj4gPiA+ID4gK8Kg
wqDCoMKgIHNwaW5fdW5sb2NrKCZzd2RtYV9jaGFuLT5od19jdHJsX2xvY2spOwo+ID4gCj4gPiAu
LiBhbmQgaGVyZS4KPiA+IAo+ID4gSXQgbWlnaHQgYWxzbyBiZSB1c2VmdWwgdG8gaGF2ZSBhIGhl
bHBlciB0byB3YWl0IGZvciBhIGNlcnRhaW4KPiA+IGJpdCB0byBiZSBzZXQgb3Igbm90IHNldCBp
biB0aGUgc3RhdHVzIHJlZ2lzdGVyIHJhdGhlciB0aGFuCj4gPiBkdXBsaWNhdGluZyB0aGUgY29k
ZS4KCldpbGwgdXBkYXRlLgo+ID4gCj4gPiA+ID4gK3N0YXRpYyB2b2lkIHN3aXRjaHRlY19kbWFf
c3luY2hyb25pemUoc3RydWN0IGRtYV9jaGFuICpjaGFuKQo+ID4gPiA+ICt7Cj4gPiA+ID4gK8Kg
wqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpwZGV2Owo+ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3Qgc3dp
dGNodGVjX2RtYV9jaGFuICpzd2RtYV9jaGFuID0gPiA+Cj4gPiA+ID4gdG9fc3dpdGNodGVjX2Rt
YV9jaGFuKGNoYW4pOwo+ID4gPiA+ICvCoMKgwqDCoCBpbnQgcmM7Cj4gPiA+ID4gKwo+ID4gPiA+
ICvCoMKgwqDCoCByY3VfcmVhZF9sb2NrKCk7Cj4gPiA+ID4gK8KgwqDCoMKgIHBkZXYgPSByY3Vf
ZGVyZWZlcmVuY2Uoc3dkbWFfY2hhbi0+c3dkbWFfZGV2LT5wZGV2KTsKPiA+ID4gPiArwqDCoMKg
wqAgaWYgKHBkZXYpCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzeW5jaHJvbml6
ZV9pcnEoc3dkbWFfY2hhbi0+aXJxKTsKPiA+ID4gPiArwqDCoMKgwqAgcmN1X3JlYWRfdW5sb2Nr
KCk7Cj4gPiAKPiA+IHN5bmNocm9uaXplX2lycSBjYW4gc2xlZXAgYW5kIG11c3Qgbm90IGJlIGNh
bGxlZCBpbiBhIFJDVSBjcml0aWNhbAo+ID4gc2VjdGlvbi4KCldpbGwgZml4Lgo+ID4gCj4gPiA+
ID4gK8KgwqDCoMKgIGlmICh0eXBlID49IFVOS05PV05fVFJBTlNBQ1RJT04pCj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl91bmxvY2s7Cj4gPiA+ID4gKwo+ID4gPiA+
ICvCoMKgwqDCoCBpZiAodHlwZSA9PSBNRU1DUFkpCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAobGVuID4gU1dJVENIVEVDX0RFU0NfTUFYX1NJWkUpCj4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfdW5sb2NrOwo+ID4g
PiA+ICsKPiA+ID4gPiArwqDCoMKgwqAgaWYgKCh0eXBlID09IFdJTU0pICYmIChsZW4gPT0gOCkp
Cj4gPiAKPiA+IE1heWJlIGRvIGEgc3dpdGNoIG9uIHRoZSB0eXBlIHRvIG1ha2UgdGhlIGNvZGUg
bW9yZSByZWFkYWJsZT8KPiA+IAo+ID4gQWxzbyBubyBuZWVkIGZvciB0aGUgaW5uZXIgYnJhY2Vz
IGluIHRoZSBsYXN0IGxpbmUgaGVyZS4KPiA+IAo+ID4gPiA+ICtzdGF0aWMgaXJxcmV0dXJuX3Qg
c3dpdGNodGVjX2RtYV9pc3IoaW50IGlycSwgdm9pZCAqY2hhbikKPiA+ID4gPiArewo+ID4gPiA+
ICvCoMKgwqDCoCBzdHJ1Y3Qgc3dpdGNodGVjX2RtYV9jaGFuICpzd2RtYV9jaGFuID0gY2hhbjsK
PiA+ID4gPiArCj4gPiA+ID4gK8KgwqDCoMKgIGlmIChzd2RtYV9jaGFuLT5jb21wX3JpbmdfYWN0
aXZlKQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFza2xldF9zY2hlZHVsZSgm
c3dkbWFfY2hhbi0+ZGVzY190YXNrKTsKPiA+ID4gPiArCj4gPiA+ID4gK8KgwqDCoMKgIHJldHVy
biBJUlFfSEFORExFRDsKPiA+ID4gPiArfQo+ID4gPiA+ICsKPiA+ID4gPiArc3RhdGljIGlycXJl
dHVybl90IHN3aXRjaHRlY19kbWFfY2hhbl9zdGF0dXNfaXNyKGludCBpcnEsIHZvaWQKPiA+ID4g
PiA+ID4gKmRtYSkKPiA+ID4gPiArewo+ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3Qgc3dpdGNodGVj
X2RtYV9kZXYgKnN3ZG1hX2RldiA9IGRtYTsKPiA+ID4gPiArCj4gPiA+ID4gK8KgwqDCoMKgIHRh
c2tsZXRfc2NoZWR1bGUoJnN3ZG1hX2Rldi0+Y2hhbl9zdGF0dXNfdGFzayk7Cj4gPiAKPiA+IFdo
YXQgc3BlYWtzIGFnYWluc3Qgc2ltcGx5IHVzaW5nIHRocmVhZGVkIGlycXMgaGVyZSBpbnN0ZWFk
IG9mIHRoZQo+ID4gdGFza2xldHM/Cj4gPiAKPiA+ID4gPiArwqDCoMKgwqAgc3dkbWFfY2hhbi0+
aHdfY3EgPSA+ID4gZG1hX2FsbG9jX2NvaGVyZW50KHN3ZG1hX2Rldi0KPiA+ID4gPiA+ZG1hX2Rl
di5kZXYsIHNpemUsCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgID4gPiAm
c3dkbWFfY2hhbi0KPiA+ID4gPiA+ZG1hX2FkZHJfY3EsCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEdGUF9LRVJORUwpOwo+ID4gPiA+ICvCoMKgwqDCoCBpZiAoIXN3ZG1h
X2NoYW4tPmh3X2NxKSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYyA9IC1F
Tk9NRU07Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGZyZWVfYW5kX2V4
aXQ7Cj4gPiA+ID4gK8KgwqDCoMKgIH0KPiA+ID4gPiArCj4gPiA+ID4gK8KgwqDCoMKgIG1lbXNl
dChzd2RtYV9jaGFuLT5od19jcSwgMCwgc2l6ZSk7Cj4gPiAKPiA+IGRtYV9hbGxvY19jb2hlcmVu
dCBhbHdheXMgcmV0dXJucyB6ZXJvZWQgbWVtb3J5LCBubyBuZWVkIHRvCj4gPiB6ZXJvIGl0IGFn
YWluLgo+ID4gCj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDCoCAvKiByZXNldCBob3N0IHBoYXNl
IHRhZyAqLwo+ID4gPiA+ICvCoMKgwqDCoCBzd2RtYV9jaGFuLT5waGFzZV90YWcgPSAwOwo+ID4g
PiA+ICsKPiA+ID4gPiArwqDCoMKgwqAgc2l6ZSA9IHNpemVvZigqc3dkbWFfY2hhbi0+ZGVzY19y
aW5nKTsKPiA+ID4gPiArwqDCoMKgwqAgc3dkbWFfY2hhbi0+ZGVzY19yaW5nID0ga2NhbGxvYyhT
V0lUQ0hURUNfRE1BX1JJTkdfU0laRSwKPiA+ID4gPiA+ID4gc2l6ZSwKPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEdGUF9LRVJORUwpOwo+ID4gPiA+ICvCoMKgwqDCoCBpZiAoIXN3ZG1hX2NoYW4t
PmRlc2NfcmluZykgewo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmMgPSAtRU5P
TUVNOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBmcmVlX2FuZF9leGl0
Owo+ID4gPiA+ICvCoMKgwqDCoCB9Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDCoCBtZW1zZXQo
c3dkbWFfY2hhbi0+ZGVzY19yaW5nLCAwLCBTV0lUQ0hURUNfRE1BX1JJTkdfU0laRQo+ID4gPiA+
ICogPiA+IHNpemUpOwo+ID4gCj4gPiBrY2FsbG9jIGFsc28gYWxyZWFkeSB6ZXJvZXMgdGhlIG1l
bW9yeS4KCk1lbXNldCBoYXMgYmVlbiBmaXhlZCBpbiB2MyBwb3N0ZWQgZWFybGllci4KClRoYW5r
cywKS2VsdmluCg==
