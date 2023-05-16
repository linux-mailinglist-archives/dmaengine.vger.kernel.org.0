Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48F8704498
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 07:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjEPFVG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 01:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjEPFVF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 01:21:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCAA44AA;
        Mon, 15 May 2023 22:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684214441; x=1715750441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pPW5Z/nQnk2RX6yqzT1fBUYh5AFBLIAC4eViZ2BQI3E=;
  b=zKulMGerSG58g2J+EoyUivMCyjVIiEqaJeGIeH2P1Ai0W9kiJLHXbuU/
   Io5GXPE3wb78M4SPhZLIxzd4JeIv4oKi2mnqVzqVdMc0a4VC9G8VvawsX
   pKlOyMcBPY+fD4mEdG3TdhQ2Hzy4HTbRhojonw+0Lsr0H4Gc6doNMJdja
   UNZVTOtzxMZdjpdUElg9kLG32p/HfEKcCnbqrEU53BHYWCGqPBEedgms6
   Qa3iQxgyscBEi+H9vJxSIQh5qPj96LdJqaJmrpYrMIWeb1HafK/V/Jju8
   E/q9G1dXUFEroLP8cQW0VR0d11qqR8kOocmZ0Wni4Rn0DvvLXERHsClJr
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,277,1677567600"; 
   d="scan'208";a="215590749"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2023 22:20:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 15 May 2023 22:20:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 15 May 2023 22:20:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPnygvWXl6J0zzk736ZU28kwOiw7+1Y59FscjzkubrII/4L9/eppytnwnnqNhmvOgBIQL/YwGSN7qtdfBC1jDWu/1OE+qDJWqrydQ5QRvSIOV3UoSwU6TS66U/QjekZnICIIQ91/4JyuiFIbczT446PHBQBrKIxpO8zYY6M83coPT4icSdlGCVoruMGO3AyWrHpHiyhB2cmaffUuod5WaMeibvOn57OzUUiPRHUMRgvQPh0ThxgIkGNSEbma/xtzpoLg48ZlyBiBjnnlAwHmohl5sL4a3MIsEx/GUmLhYJ/iYLXuuan1qAIHmmQ1Xadrg56vb+ZUW0mrkuV8vqwBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPW5Z/nQnk2RX6yqzT1fBUYh5AFBLIAC4eViZ2BQI3E=;
 b=fqgAakKCGUyu4ouYNDSd5hAq1gQ2gLr0MKQH2+IdNFZxU/JQlCWYwQhJ7EikAqThj36athU6fGYJOPdOrhkObusujrV91qfxiTmkGfuLDrGr5u9YYNkv7Txa+2inxGOlCxtSVp4LU5zoBIdtwcAiZ3uyqmO5PXFF6qqFgSX664HTxBHiKENeWg8U/0PzCR0KT2fK5IYljKOyfLepNdcXCmrWhqa4EHYupTQHFItEc/ODkD+aO8AbgOehWjJvBGRkkUBR4y8ENRUxKtIualzBZQONQYemtfQZ555goOfiaTEydm2buEA6vFjTkOXB3oZ1SfCbZ0v+ygnc+c5OnemCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPW5Z/nQnk2RX6yqzT1fBUYh5AFBLIAC4eViZ2BQI3E=;
 b=sFTs4GQPBlOwMZpJfO9VSMnnnX+D1m5oZk/j2ibs+EsyUf94B9MXzKK9YCvdAXjdzkqntnpVOSIM2ME2A36wmz/pytNmvYaTpMFeeU5uF/2WaHQS1x56Cp6ywsLcUmRO0vpH3owcp7tZWujVQ+mzMOLcodehDnBzDVUDJ161XCw=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by MW6PR11MB8368.namprd11.prod.outlook.com (2603:10b6:303:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 05:20:37 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b%7]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 05:20:36 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <hch@infradead.org>
CC:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <George.Ge@microchip.com>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>, <tglx@linutronix.de>,
        <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v4 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v4 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZdjYbp7JofHpSCkG4OMYCy0fppa9IJWMAgAK/9wCAEK3nAIAAM4SAgACzmgCAAAV+AA==
Date:   Tue, 16 May 2023 05:20:36 +0000
Message-ID: <ad8da5472b9e62dc4ca695c9cb58d2c735ce1594.camel@microchip.com>
References: <20230423213717.318655-1-kelvin.cao@microchip.com>
         <20230423213717.318655-2-kelvin.cao@microchip.com>
         <ZFH/xhyjm9VTZolE@infradead.org>
         <50e111a3cfecd0f232508d1b03e02d1e25d9d4a9.camel@microchip.com>
         <ZGJMKFrLfU2zc/2P@infradead.org>
         <0ee5aa616475cc39b04c6b9e84db119bc8fc4d53.camel@microchip.com>
         <ZGMOCBAVvAxMa/lb@infradead.org>
In-Reply-To: <ZGMOCBAVvAxMa/lb@infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|MW6PR11MB8368:EE_
x-ms-office365-filtering-correlation-id: 0d20bcbc-1c61-44c8-3c96-08db55cd480d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lo8KIj8t924pTwneEtNjR8cILR1O2Fmi9xPWpyGxkS56AhR6ZE/RRbCvEXJlmzDeIorOso4LgCc2o/i+GOWFGwh5nN+zmdty/mHFs6giRbU4dCJg9yWLCtIhZXZAd+7oyqvLLCoV9g+dHu6oP2O9iJKkm0j8uAjBAq4qoY2aA9J20dDdju+UDgYk8HZU5FzwWqvNOY5ciaPumy67yZ3UyoJ9n2v5op7Od/Q3EKmVX06oyeiHA5q5Vq2O6+OrJBf2t5a6bDBan8yOq+e6k9HjIGRuo1QldcGgw1OtIuuwBGbGLVWYWDAm8bmKYzXraSBn8RRWf7bvJJPsHd2oA448yZqiAbpKpm1HIQwkwqbSo2S3zfvQ+OhdZ/dno9u0RETR0+joRMiJIEdApyhK5Yz62A9NqZZHxPDCwnEtccTog2TZXYiE++chyXjVxAw3Ku5OXgnNi5xsMZgE4XnR20/Q1TqHAvItlhRfFkfTRLzL5D1Pti1IL4w+quddHMeyA/BsSgP+/hTLcla6nS6Q90L8a6Y1F+dKb1JYssCDWSqKLrv097aCUcvXRyDCuCOOw/6r10+5Doc1hpFGk3af7kGFIqC2qe2gDmm7y3QdOys7f0XwWfUrfWUtQgYhG6WYE/Bh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(6506007)(6512007)(26005)(41300700001)(38100700002)(6486002)(71200400001)(186003)(2616005)(478600001)(6916009)(4326008)(66946007)(64756008)(66446008)(66556008)(66476007)(91956017)(54906003)(316002)(76116006)(122000001)(8936002)(8676002)(5660300002)(86362001)(2906002)(38070700005)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3gyREtHcVd2L2xZSVNtSVk4bW94K2ExRXMzVDBQd1NYR1FhOERqZDZ5Yklm?=
 =?utf-8?B?eGlVWGV5QnMwRTdZemp1NWxmcUFRaklraGpVSTNOamYwTWNpV0dFVGRJeGdW?=
 =?utf-8?B?Q2N1bW1ac1ZJMnNNay8zZSt3ZnRYdnRXbVljNFYxVzVKQW1CZ0NDYmpZTWlr?=
 =?utf-8?B?V1M5RU9YY1UyL3VGVmFFS0hENVBLNDVwTlc2bzNOVXdLUStWNEREV09uQTU3?=
 =?utf-8?B?ZG9HYmFJWTFFVTJDVDh2Qm5aRHg0cEdUUmFiYzlic29jcGNsK2lXQ0k4Ti9y?=
 =?utf-8?B?ck5HQWNYK0U5VWp3NmJwSno0QnZQOHlWdVRyb0xmakt2NVdNZHFISVAzWEo5?=
 =?utf-8?B?VmtOR3g2TTQ1Q0c1cFc0Y3lhY2luZFduZ2NGbGgwa3Z4M0tZc0FLUSt1WVZL?=
 =?utf-8?B?alBURjdDRDNjSUVrWGZIT2RyN29PZ2lzQWc4RWJQbU14dDVsUGdGZUg3WFBQ?=
 =?utf-8?B?MXU1RXBvOUhvWTBvcW1weDllblJaK1p5am11VWRLdHN2T1hpZ1BVdncvaGwx?=
 =?utf-8?B?Zm5LUmxNNFlEMndhQzVQdysySGRnOXZTQXBxUG1zakFBa1RRb2JaRmExcHRi?=
 =?utf-8?B?S20zZ1ZaNUpNNHJ5R053bmJVK1dYYzdLSFVzZllkWVA3YnQ4M0JRdFFBRFFn?=
 =?utf-8?B?UWFmQmY2NGNhT2x3T25KY1JhNW01dUlIZlNpZ0FmUnBCSGZsTlRVWW1lWHBz?=
 =?utf-8?B?RHUvaGkxcHB2eHB5NXI1ZEFPS3dKVVBSNUNHUHducG5sNVF5VjNyZDhkUVdN?=
 =?utf-8?B?eGEwK0FSazk2MXJGdVpRYkI3dERhWm5GYzU0TDlheHlGUVRMUUhGVC9NWjU0?=
 =?utf-8?B?YW1DMUpQd0pxUWU2NE85bjhQK255V0llVm82bmkyeGEvYlB5THlXcThoeldt?=
 =?utf-8?B?NGRPai90QTRXOFE3OXpIQlpoQjI2elVaRUIvbWE5L2pJdG83L3I3SkpCa1lN?=
 =?utf-8?B?TXBTTUZnL2pFMU40MGljcTBKbFhFV01xeTkrelE3SUdQVHB5TStkSGZ3WmFQ?=
 =?utf-8?B?dzg2dFZvNXlILzZISlRqSUE5QkZaTXR2MCtxMGNpOGhEMTBzRFhrcVc5Sm9S?=
 =?utf-8?B?SUFmajc1bEtCN1U2bnl3c1dueWo4RmNNdkxPYkFFcHEyVG9iV3dnbEJOZlR2?=
 =?utf-8?B?MWJSVEFFeVZtbXNUc24rY1JFWGtUK1lVTFR5VkFTdnNZOXZyZVhYZUlNUXBv?=
 =?utf-8?B?NnllZW4rSWFpVi8reTg1dW55NUh0WEFGSWJFaTBIOVVGZ2FSVVVtNE9ySG9L?=
 =?utf-8?B?NDZqQm8zOU1VZjNGVndneWVqd3lYUXVCNnVEVVFlRDhzTGJGQ0ZuaUdBVUhh?=
 =?utf-8?B?TlNCdEgwM0ltTm5YU1J6MXFsOWlMNkJNOTFjWkxTelBMb0x3Z3RqZWxQdVE1?=
 =?utf-8?B?M0p5VFpwN0l5UTIzbE5Oalhub29TRjBMMmlzeCsxTzY0NVREM2VCc1kyNjJP?=
 =?utf-8?B?MXZTOGFKMlBPYzg0dmZYakpyNDJKUGVLdXFiODdYeE95dEV0WFVXTzIxVDVV?=
 =?utf-8?B?VmF6Q3VicXVTOWFadkQ4OUxXYWlXQTQ1di9BUVFBSFJwdkZSamtGdHV2S0pG?=
 =?utf-8?B?TkR2bXNxbVBlbi8rN0FFaDM4VTRXeElLczVqbGFNVE01blhHSU5NY3pBQkRa?=
 =?utf-8?B?NFlHOXNha1NOZGV0ME9nRmd5aWo1OStzTmpvWHZwdWpIeUk4aHc3bFgxVmtJ?=
 =?utf-8?B?WDBXclovSmcySU9uc3pRRnlSdTJHSHIxSFcrMG1rZlphSmp1V3k5M0lJeCsv?=
 =?utf-8?B?bXY1RUNScjAxRis3SWwyclZSN2xwQ0p4L1lxcHY5LzJaRTBMVGo1OTlUK09P?=
 =?utf-8?B?REN2eFh4VkFFb2pSY05GV2V6ak93SFJ3U2Zka0V4QjEvWFpxT3BsQk55RHpn?=
 =?utf-8?B?QXlIRGVDNENlSHpWNDcwTVNKZ3B5OGpPOXVQZVdRWkVJODdOYms0ODJLcGht?=
 =?utf-8?B?Ty9hdzBEaW5BQ2tjZjNMVGM3MllTVG5wTG0yKzNYQnlKVHR3QUhzWnFlcnZJ?=
 =?utf-8?B?QW5YOFFBZEZqK2xNRElaVytpMlUvM1hzZ1ZZTkZ0L0FpMGVIckxYV1NRUXNF?=
 =?utf-8?B?K2d5aWZLaTRXZi9FcmFpV1hDTnRFR3JkTDVBempGNkJiMitZeHlsbk9nOXpj?=
 =?utf-8?B?YTY5WXVuWmtPVldPY1JZRllodFBDMUFWQ25CampJRmZqYVEySEwyZFdkN2RK?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D075974B8150640BC26C77A3B4BE0DC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d20bcbc-1c61-44c8-3c96-08db55cd480d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 05:20:36.8419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uh3nGMKv43bqPW3Zc19KmZJbTxVhgOrAub2MXyqNKEPgBTmi2oii7pXX0KS16bRsZMEr1WtRl9b7GHSmt+z9t+MhgFJWcR/HgngKmi++PO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8368
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDIzLTA1LTE1IGF0IDIyOjAwIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+IAo+IE9uIE1vbiwgTWF5
IDE1LCAyMDIzIGF0IDA2OjE4OjA3UE0gKzAwMDAsCj4gS2VsdmluLkNhb0BtaWNyb2NoaXAuY29t
wqB3cm90ZToKPiA+ID4gSSBmaW5kIHRoaXMgcmF0aGVyIGNvbmZ1c2luZywgZXNwZWNpYWxseSBh
cyBzb21lIGNvZGUgbGl0ZXJhbGx5Cj4gPiA+IHN3aXRjaGVzIG9uIHRoZSBvcCB0byBmaWxsIGlu
IGVpdGhlciBzZXQuCj4gPiAKPiA+IEl0J3MgYSBoYXJkd2FyZSBpbnRlcmZhY2UsIGFuZCBub3Qg
cG9zc2libGUgdG8gY2hhbmdlIGl0IGF0IHRoZQo+ID4gcG9pbnQuCj4gPiBJIGd1ZXNzIEkgY2Fu
IG1ha2UgaXQgbG9vayBzbGlnaHRseSBiZXR0ZXIgYnkgZ3JvdXBpbmcgdGhlIHJlbGF0ZWQKPiA+
IG5hbWVzIHRvZ2V0aGVyOgo+ID4gCj4gPiB1bmlvbiB7Cj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3Qgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fbGUzMiBzYWRkcl9sbzsK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2xlMzIgc2FkZHJfaGk7Cj4gPiDC
oMKgwqDCoMKgwqDCoCB9Owo+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHsKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2xlMzIgd2lkYXRhX2xvOwo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIF9fbGUzMiB3aWRhdGFfaGk7Cj4gPiDCoMKgwqDCoMKgwqDCoCB9
Owo+ID4gfTsKPiAKPiBUaGUgaGFyZHdhcmUgaW50ZXJmYWNlIGlzIHNpbXBseToKPiAKPiDCoMKg
wqDCoMKgwqDCoCBfX2xlMzIgZmllbGRfbG87Cj4gwqDCoMKgwqDCoMKgwqAgX19sZTMyIGZpZWxk
X2hpOwo+IAo+IGhhcmR3YXJlIGRvY3VtZW50YXRpb24gbWlnaHQgZGVjaWRlIHRvIGdpdmUgdGhv
c2UgZmllbGRzIHR3bwo+IGRpZmZlcmVudAo+IG5hbWVzIGp1c3QgdG8gY29uZnVzZSB5b3UgOikK
PiAKPiBJIHRoaW5rIGV2ZXJ5b25lIGVsc2Ugd291bGQgYmUgc2VydmVkIGJldHRlciBieToKPiAK
PiDCoMKgwqDCoMKgwqDCoCBfX2xlMzIgYWRkcl9sbzsgLyogU0FERFJfTE8vV0lBRERSX0xPICov
Cj4gwqDCoMKgwqDCoMKgwqAgX19sZTMyIGFkZHJfaGk7IC8qIFNBRERSX0hJL1dJQUREUl9ISSAq
Lwo+IAoKSXQncyBzaW1wbGUgYW5kIGNsZWFuLCB0aGFua3MhCgpLZWx2aW4K
