Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01596E183D
	for <lists+dmaengine@lfdr.de>; Fri, 14 Apr 2023 01:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDMXW0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Apr 2023 19:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDMXWY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Apr 2023 19:22:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45083BE;
        Thu, 13 Apr 2023 16:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681428142; x=1712964142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=roSf18wx8Bp2y75YFBaw5PqcGFPQqgwRYsRsz0k+KaQ=;
  b=WSeCpuKeY41BZrG2/8cl/YJ9oK+H+ImhXG2dvw/M7Qqa3bb76t1bZFSR
   /Z5CTYOAH0cV4uyoXBJyjSXXaFtqGOxuaUQh25QhuXsCnTjMAwJCAaKYi
   xC12ub8X88+zKst3paNYauYOm3KY+PpOL2L7tZ/YcEArI+l7ULw0qFDMD
   Y5GNvaSFiUe3bIe8JFfbCCVrHyfBmzEwwMwrylr8kbBncOTiaFFnOxhKR
   NYvCCWXywGF5B61PfEE4tPjDrFLRrfniW0OhTN72upKJYw3rMy4dAV5Re
   942fhl9V8bn+h68rgQeXaBTkpxOYD/JsN8LE1ZFc6j1lSyMUO5fY0DAh7
   w==;
X-IronPort-AV: E=Sophos;i="5.99,195,1677567600"; 
   d="scan'208";a="206446365"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2023 16:22:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Apr 2023 16:22:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Apr 2023 16:22:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsAATjk8AdKCeheQuNbZtjp2cgexHw0F4g/dDW4iF89yNpIGOZTmYKE84OMhdiiMMUJ3bj8OOWuZJn7CLK45Fuwp/6rjYvHFqkJOGkH2IaCVrn2SYoLGzPDEOHHDzTJ0KRkr3yiojM3Bzf9YNqK/IxK7/rdYZpIG9tNtVjNfkw4zsyCknhXk1eWQ81t7+HswQzfW/JiDaNSnFkcmL3DYH3TnxSC6ahqk2EBi6zO7byr1gphHHb7G0SPnUesd0EijgM9q2Uuz7dyn5gC7C+anBASX1gA1jXNhimqwSHIlxMWkzVaQ+CepmpaBaT1c4bEt6DTtxeN//VFtvikGBREesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roSf18wx8Bp2y75YFBaw5PqcGFPQqgwRYsRsz0k+KaQ=;
 b=CO9UfKQMtur7IseX+f/uFaL3Zl+9LYvZPN5LrSRW5yRYZ3A1Haxd/m0QupvWkMYhlNBn4BKqOLWOjairhRzT5Pcz6e1Kad5m6E/vx/VzIsxlZPC3WQgsGQdvw/4338pLBgEQ1geWR5FwHe5eGjH7iYXCLewpmlagBcb4XmfgXFR+k7n+GxZlJgRyXHHfsnEsXpWRecJYDkTI3o9HBZAzR3Uu6lpNo9D8Cybdar+YFMr//GowKlrGa1D+/TVBsYU+hIVQK1ltHAzRCIlyIHB+1wIyGvJ9wnpAFU+CG/yHdV46XwGwz9nCJuwhrp0agaw1ej0sM8QL5aDAPnKAtNKCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roSf18wx8Bp2y75YFBaw5PqcGFPQqgwRYsRsz0k+KaQ=;
 b=HCMzafRYpazrXK0v9EtJHAGgVKpMOc5pSTsFVC2eYsrtW/RHIAgKsg6fIXy22k27qvJjOplkGGm8ngfSo5hkHx3lSNGBV+/6z6SPCNicN5Kk3M5B0U3q5ke0A85kYcioWvHxLWtIPB3SFE6h/6HXkKBIobR6qLvIDXfG1qFIW9w=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by BN9PR11MB5338.namprd11.prod.outlook.com (2603:10b6:408:137::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 23:22:14 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b%6]) with mapi id 15.20.6298.028; Thu, 13 Apr 2023
 23:22:14 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <hch@infradead.org>
CC:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <George.Ge@microchip.com>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>
Subject: Re: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZZmFWCpgZadogBUKZpBFKgoENK68kyiyAgAUmn4A=
Date:   Thu, 13 Apr 2023 23:22:14 +0000
Message-ID: <c86fe78f384295d5694b1534efa1f5b070c8123c.camel@microchip.com>
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
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|BN9PR11MB5338:EE_
x-ms-office365-filtering-correlation-id: 573e8b85-9184-473f-589a-08db3c75ea86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8jEgWWe9+p7G7UT9K9wHh8zukVBAzYguLFfcVriJJcQ/rASCpIHq+rJBXAbuCQ+utlkyTRsPgdieOwDHV34U1+fl3rK8tOkzM5mxlYspkH/yJjrmNOspHqhnjyBNbrS2higA1QYucyeCxhs2wlCBOQYun/3AGxkyaRiG89Rj4p79Y+sCmx5tT9ZoFs94ksWCSonBsgDjgiEdKJY7sv7TTOHFFpXBq6bXhMhc8YlRsU6/mAuNkQeug4c2lhdtFNfClK4+STtnHb9NVOdfcGn5oKfC5lI+SfhKTmXfV1Q0DAxqxr8LFL+M5kpcirme1u9FcqZ/b2X+6edG9ejQS2VicZ9Ba8cN0w1XCe8Ok09Ke/liNeXY61UR5I22G/qEcSCMN/PPdYAvgplMS8jZlcnoh/4WJZFoY657OzNIRPREoCxDZoYCCGzPj3cHo3/JQYznv47ZTe+fZUYhNz+4gkoVoqK8r7cj6GqiYqrV01AyGdNJQ6lrFGBG6q3m4WtwD9EjidJZ0KuDSzxOtalJ26C6m0a9XlG5HCYY5UOyIcXpEXOKxv1Gp4mSozOm2Ll3VkrFjW9PHds38sWZEG1t0qAi/NmaDu0O2dWrb7U4wRd4qDEDrYOm5iH/pq9AsF1wLA4l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199021)(71200400001)(6486002)(6916009)(66476007)(66556008)(66446008)(64756008)(4326008)(66946007)(76116006)(36756003)(91956017)(2906002)(38070700005)(86362001)(38100700002)(122000001)(41300700001)(5660300002)(8676002)(8936002)(316002)(478600001)(54906003)(6512007)(6506007)(26005)(2616005)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXpRNlpnamxsc0dyS1ZlYTJUMjN0NVBzZG85STEyQ3VkdFRGV0wwMnBNaGRp?=
 =?utf-8?B?V1VuRFJzNU0xSDNrOFJFeUpDTUNZc1NJYnVlZHdEb2ZGTVNuUUx2cUM3eC9E?=
 =?utf-8?B?WFRoeWFldEt1UWx0QXF6NTRDbXJpd1ZTMlJvRXBPTTdqNDJGRWEyTjRJUHFu?=
 =?utf-8?B?dG9la29TRzdyTTNmYXhGVUF2YWp1ZFdWdDNnekJHaURjNkh2MkNOVmxFM0Na?=
 =?utf-8?B?MXhRd05MRW85cWl0Rlg5VGpQc3BwVHhxUEJVYXhJZDh1ejJjeUt3YkV2dWZp?=
 =?utf-8?B?ZFJPekFqYkVKaUZtUWpTWmN6MGk0T3BrTlY3L0hONVBZTHAvMkxld1RISlJL?=
 =?utf-8?B?ZUNqcnlHUEQvS0g5djUxMEdtT1BkYkMwcnZ2RUltRDJES1RJR2JYVVlhK0sv?=
 =?utf-8?B?NHRVbXE4SS9oNjYwNDdyYlY5Tlgxbm9zbWxiWCsrRVFiOHd5bDhjVU10VDRY?=
 =?utf-8?B?R3NVeDRTamw0RTVpS01yQTNSbW52OUFScEREcDJpUDdGRGtFMEp1bVNuTmhP?=
 =?utf-8?B?ajZPaXl4TitzakZhZnorbHFOWGw5ZnFJdmVTNHhSTVBBY3VvT2ROdThwdVlx?=
 =?utf-8?B?aGIvQzJ5aGRYYnRib1JDdjUwdlNMN0MzQk1KNUQrVmd3dGhBVUc2RUo5Z3dE?=
 =?utf-8?B?Mkwrb3duUEdyZzFMbnRSOUlOWVlNTFBrTUpTeXMzdUZyaExhWHNuaGgzZFRt?=
 =?utf-8?B?Z3lvMzJ6ZUl4SjlrejBGYXhuRmJycnVMeHh0WmFzKzdkRS94R1o5c3IzSUxW?=
 =?utf-8?B?Y05nT3Q5NEljaEpFRHU3ZDgzdUptSWFWMmg4NFVNM1BwTmJxWkZOb0N6Slp2?=
 =?utf-8?B?L3Jkd1d3Zkg3REMwblJIWXlvczREamRDeE9ybHprNG9uM3NtWDh2eUZ6aEF1?=
 =?utf-8?B?eXZDWEFNeStVbkVybUVxL05VRzJhOGdMU0ZDUDByV24yQ0pNaExNVU51MVhi?=
 =?utf-8?B?NjkxcERWOTJzZUJjMjZsVHMwU2Mxb3RWQ0k2WW01UlJaWGNwYVNjY2RKbnMv?=
 =?utf-8?B?SjRoM2JzZUhSTnhvUEl4RVNyTHVtWEpOcU5HaEZPbDBSdDJtd1orZjRCaUJ4?=
 =?utf-8?B?RTBxKzhmelZGZTJ3cnFBclFKS3FNOHZNd2N6WHptejNlVlIvQnpYTzNFYW5T?=
 =?utf-8?B?cG9TRlIvWSs0QWJudnV3YmRYUm1KRzJ3cVVyV1FPRENZTXI3Q21tOE1wMG9z?=
 =?utf-8?B?VGRSajRaSnQ1UmhGUzZzMlNDNjNBa0FMY3Y2aWdMY3RTWVVYbTErOE9OZFJs?=
 =?utf-8?B?OFZhbnZpdjBCV1JhcmJOWWFzd0dsTUhCa2wvbUJaaUFySnJTNUluWUJENEY3?=
 =?utf-8?B?TGVQSGdzdk0wWm5hRXRNaTdjT1l5MHFaWENnZHJhN3k0eExzeWgwMFlkSzlS?=
 =?utf-8?B?STBiQm1hWVBER2NQNU1HWjNyb20rTlhOUW9QZlVhNXJLVjQyUm45SEVsUUUz?=
 =?utf-8?B?VTZuMFVGM3RqQUlIMmgyYzVXS0k3TjZHNnRMMzROWHNhOU5KUG1WcEJwTS9x?=
 =?utf-8?B?a0huYjV1VXIyYW5DdlpKYlNJWThmLzRuTCtBOU05NVdEMnZTWFZ2TGZGdmFl?=
 =?utf-8?B?M1NuczhUa3JzSWpzdGJZemJVS3lQeFY2RGhEMDB6cXZSbHVnVjNtcnpmVm1G?=
 =?utf-8?B?dDBBSVV2Vzg1K3ZKOVdGRE5lclVHWlYzRk8ybmxJMXR4cG52Wk5jc2g2a0Zi?=
 =?utf-8?B?clh1QVN2bDd4TDkvUFdQZWlaaFlVdFdWcGcva2NrVzJ5b3hzYWYyMUNNd0Vj?=
 =?utf-8?B?SXYyamxjaHdYeUUrODZ4REJaNFZucEV0TGdPVDdqSTQwdjNyQUhiSnQ1THk3?=
 =?utf-8?B?aXJhbG5FM2Z3RWRYRFQvY1BuNzVzRHlkc2d3anJpQ054QllaZ3pSVkNqQ3k4?=
 =?utf-8?B?S0hjOEpJVzN6eS9RaHBxL0NRdzJOWnBPNFlhVko1Uy9iSUxaeHJta1BiOWZy?=
 =?utf-8?B?NThYVUU3ZFNMTTJWdnVvRXdJSitzbWRpY0Qvb3JXb3IzejBDWWxneG5FVmNu?=
 =?utf-8?B?NC9PYnlNUlh3cjVVbHpUdDFCOTRicW5CS2tPbGtSb0psTUYxYS9zWU9lRHNY?=
 =?utf-8?B?U0xXRUE0d3VBaHVNeVVzekxId0pMaVJ0YUh5ZExIcUw0c3R2U3ZOdmxxK1hy?=
 =?utf-8?B?WVhwWlBuSEdEcHdjVWZiWDZ3WnI2cWRPeSthMUgxd3IzaldiVXNXN3piYUQ2?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DCA49EC365D284EBF96E96BDB8CBBCE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573e8b85-9184-473f-589a-08db3c75ea86
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 23:22:14.6517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFwtiL8f2vSS0BWHLvOJ6uq/WzO9p1vUZqZ863omNI3LvEalIWhJIHAkz/lZB6DDysoLjXI6OIiIH2KqFWTHCT6jjlZD2n1uv9FNMMa9u/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5338
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
ZToNCj4gDQo+ID4gK8KgwqDCoMKgIHdyaXRldygoX19mb3JjZSB1MTYpY3B1X3RvX2xlMTYoU1dJ
VENIVEVDX0RNQV9TUV9TSVpFKSwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmc3dkbWFf
Y2hhbi0+bW1pb19jaGFuX2Z3LT5zcV9zaXplKTsNCj4gPiArwqDCoMKgwqAgd3JpdGV3KChfX2Zv
cmNlIHUxNiljcHVfdG9fbGUxNihTV0lUQ0hURUNfRE1BX0NRX1NJWkUpLA0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICZzd2RtYV9jaGFuLT5tbWlvX2NoYW5fZnctPmNxX3NpemUpOw0KPiAN
Cj4gVGhpcyBsb29rcyBicm9rZW4gdG8gbWUsIHdyaXRldyBhbHdheXMgZXhwZWN0cyBjcHUgZW5k
aWFuIGFyZ3VtZW50cw0KPiBhbmQgYnl0ZSBzd2FwcyBvbiBiaWcgZW5kaWFuIHN5c3RlbXMuDQoN
CkRvIHlvdSBtZWFuIHdyaXRldyBhc3N1bWVzIHRoZSBwZXJpcGhlcmFscyBiZSBsaXR0bGUtZW5k
aWFuLCBhbmQgd2lsbA0KZG8gdGhlIHN3YXAgd2hlbiBob3N0IGlzIGJpdC1lbmRpYW4/DQo+IA0K
PiBBbmQgaWYgaXQgaXNuJ3QgYm9ndXM6IF9fZm9yY2UgY2FzdHMgbmVlZCBhIGdvb2QgZGV0YWls
ZWQgY29tbWVudA0KPiBleHBsYWluaW5nIHRoZW0uDQo+IA0KPiA+ICt2b2lkIHN3aXRjaHRlY19j
aGFuX2tvYmplY3RfZGVsKHN0cnVjdCBzd2l0Y2h0ZWNfZG1hX2NoYW4NCj4gPiAqc3dkbWFfY2hh
bik7DQo+IA0KPiBUaGlzIGZ1bmN0aW9uIGRvZXNuJ3QgYWN0dWFsbHkgc2VlbSB0byBleGlzdHMs
IGFuZCB0aHVzIGRvZXNuJ3QgbmVlZA0KPiBhIGZvcndhcmQgZGVjbGFyYXRpb24uDQo+IA0KPiA+
ICvCoMKgwqDCoCBpZiAoIXN3ZG1hX2RldikNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArwqDCoMKgwqAgYmFyID0gcGNpbV9pb21hcF90
YWJsZShwZGV2KVswXTsNCj4gPiArwqDCoMKgwqAgc3dkbWFfZGV2LT5iYXIgPSBiYXI7DQo+ID4g
Kw0KPiA+ICvCoMKgwqDCoCBzd2RtYV9kZXYtPm1taW9fZG1hY192ZXIgPSBiYXIgKw0KPiA+IFNX
SVRDSFRFQ19ETUFDX1ZFUlNJT05fT0ZGU0VUOw0KPiA+ICvCoMKgwqDCoCBzd2RtYV9kZXYtPm1t
aW9fZG1hY19jYXAgPSBiYXIgKw0KPiA+IFNXSVRDSFRFQ19ETUFDX0NBUEFCSUxJVFlfT0ZGU0VU
Ow0KPiA+ICvCoMKgwqDCoCBzd2RtYV9kZXYtPm1taW9fZG1hY19zdGF0dXMgPSBiYXIgKw0KPiA+
IFNXSVRDSFRFQ19ETUFDX1NUQVRVU19PRkZTRVQ7DQo+ID4gK8KgwqDCoMKgIHN3ZG1hX2Rldi0+
bW1pb19kbWFjX2N0cmwgPSBiYXIgKw0KPiA+IFNXSVRDSFRFQ19ETUFDX0NPTlRST0xfT0ZGU0VU
Ow0KPiA+ICvCoMKgwqDCoCBzd2RtYV9kZXYtPm1taW9fY2hhbl9od19hbGwgPSBiYXIgKw0KPiA+
IFNXSVRDSFRFQ19ETUFDX0NIQU5fQ1RSTF9PRkZTRVQ7DQo+ID4gK8KgwqDCoMKgIHN3ZG1hX2Rl
di0+bW1pb19jaGFuX2Z3X2FsbCA9IGJhciArDQo+ID4gU1dJVENIVEVDX0RNQUNfQ0hBTl9DRkdf
U1RTX09GRlNFVDsNCj4gDQo+IFRoZXNlIGFyZSBhbGwgZWl0aGVyIHVudXNlZCBvciBvbmx5IHVz
ZWQgb25jZSBvciB0d2ljZS7CoCBJJ2QgZHJvcA0KPiBhbGwgdGhlIGV4dHJhIHBvaW50ZXJzIGFu
ZCBqdXN0IGRvIHRoZSBsaXR0bGUgYml0IG9mIGFyaXRobWV0aWNzDQo+IGluIHRoZSBjYWxsZXJz
Lg0KDQpXaWxsIGNsZWFuIGl0IHVwLg0KPiANCj4gQnV0IEkgZmluZCB0aGUgd2hvbGUgcGNpbV9p
b21hcF90YWJsZSBjb25jZXB0IHZlcnkgY29uZnVzaW5nIHRvIHRoZQ0KPiByZWFkZXIgb2YgdGhl
IGRyaXZlciwgYW5kIGdpdmVuIHRoYXQgaXQgZG9lc24ndCByZWFsbHkgdXNlIG1hbnkNCj4gZGV2
bSBvciBwY2ltIHJvdXRpbmVzIEknZCBzdWdnZXN0IHJlbW92aW5nIHRoZW0gYWxsIGFuZCBzdGlj
a2luZyB0bw0KPiBvbmUgd2VsbCB1bmRlcnN0b29kIHdheSBvZiBtYW5naW5nIHJlc291cmNlIGxp
ZmV0aW1lcy4NCg0KSSBkaWRuJ3QgZ2V0IGl0LiBEbyB5b3UgaGF2ZSBzcGVjaWZpYyBzdWdnZXN0
aW9uPw0KPiANCj4gPiArwqDCoMKgwqAgcmMgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KCZw
ZGV2LT5kZXYsIERNQV9CSVRfTUFTSyg2NCkpOw0KPiA+ICvCoMKgwqDCoCBpZiAocmMpDQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYyA9IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQo
JnBkZXYtPmRldiwNCj4gPiBETUFfQklUX01BU0soMzIpKTsNCj4gPiArwqDCoMKgwqAgaWYgKHJj
KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJjOw0KPiANCj4gZG1hX3Nl
dF9tYXNrX2FuZF9jb2hlcmVudCBmb3IgYSBzbWFsbGVyIG1hc2sgd2lsbCBuZXZlciBzdWNjZWVk
IHdoZW4NCj4gdHJ5aW5nIHRvIHNldCBpdCB0byBhIGxhcmdlciBvbmUgZmFpbGVkLsKgIFNvIHlv
dSBjYW4gcmVtb3ZlIHRoZQ0KPiBzZWNvbmQNCj4gY2FsbCBoZXJlLg0KDQpCeSBkZWZhdWx0IHRo
ZSBrZXJuZWwgYXNzdW1lcyB0aGUgZGV2aWNlIGNhbiBhZGRyZXNzIDMyLWJpdCBhZGRyZXNzDQpz
cGFjZSwgSSB3b25kZXIgd2h5IGl0IHdvdWxkbid0IGFsbG93IDMyLWJpdCBtYXNrIHdoZW4gaXQg
ZmFpbGVzIDY0LQ0KYml0Pw0KPiANCj4gPiArI2RlZmluZSBNSUNST1NFTUlfVkVORE9SX0lEIDB4
MTFmOA0KPiANCj4gVGhpcyBpcyBhbHJlYWR5IGluIGluY2x1ZGUvbGludXgvcGNpX2lkcy5oIGFz
DQo+IFBDSV9WRU5ET1JfSURfTUlDUk9TRU1JLCBwbGVhc2UgdXNlIHRoYXQuDQo+IA0KPiA+ICsN
Cj4gPiArI2RlZmluZSBTV0lUQ0hURUNfUENJX0RFVklDRShkZXZpY2VfaWQpIFwNCj4gPiArwqDC
oMKgwqAgeyBcDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAudmVuZG9ywqDCoMKgwqAg
PSBNSUNST1NFTUlfVkVORE9SX0lELCBcDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAu
ZGV2aWNlwqDCoMKgwqAgPSBkZXZpY2VfaWQsIFwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC5zdWJ2ZW5kb3LCoCA9IFBDSV9BTllfSUQsIFwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC5zdWJkZXZpY2XCoCA9IFBDSV9BTllfSUQsIFwNCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC5jbGFzc8KgwqDCoMKgwqAgPSBQQ0lfQ0xBU1NfU1lTVEVNX09USEVSIDw8IDgs
IFwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5jbGFzc19tYXNrID0gMHhGRkZGRkZG
RiwgXA0KPiA+ICvCoMKgwqDCoCB9DQo+IA0KPiBQbGVhc2UganVzdCB1c2UNCj4gDQo+IMKgwqDC
oMKgwqDCoMKgIFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9NSUNST1NFTUksIDB4MTIzNCksDQo+
IA0KPiBpbnN0ZWFkLg0KPiANCj4gPiArwqDCoMKgwqAgU1dJVENIVEVDX1BDSV9ERVZJQ0UoMHg0
MDAwKSzCoCAvL1BGWCAxMDBYRzQNCj4gDQo+IGFuZCBwbGVhc2UgdXNlIG5vcm1hbCAvKiAqLyBj
b21tZW50cy4NCk9rLg0KDQpUaGFua3MsDQpLZWx2aW4NCg==
