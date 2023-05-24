Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BCB70FC0F
	for <lists+dmaengine@lfdr.de>; Wed, 24 May 2023 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjEXQ6j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 May 2023 12:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjEXQ6i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 May 2023 12:58:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2EF12B;
        Wed, 24 May 2023 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684947510; x=1716483510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=14n/Rs/4gzDsuzDXDWNiQATKfyeUplwckdz4OHBPpFs=;
  b=IvL+4MA3WW4ey6iiYNYeyaZ5aYUpOOx5GebDuz9rYja3S6d6VXVz9J76
   dnjhQmKsdmG9V7XlJfA5X66fQlpVBO+4HbgCnFxG01+Ee6fowoTuWvu6g
   ponSQQHb/+XvW9DWrGP5duJr6RWhua7w6pYjhx9P3n49e04CqCqWJ/AQi
   c5nymhdBt017kaQfvOrpBu4jBoLfyWewgi/2asUOtbL/8h/g2JIgvNzaF
   sGDwCIw0UCLZ6fugVtNQwZnrc8mDCr7HgVastKth7EmcBcp+9EsTu6VAX
   +cIIq5YdyfM4W2ArcgtkuvThdTkIEiiLMePRLh57ZowaOnmWAnfcz/z1b
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="226836667"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 09:58:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 09:58:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 24 May 2023 09:58:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtrL48p13aVWEjwh8SjgGWvT6rIkDKrTYHHeY8gdIPl0jIqd/g0EL5rW9ZfHN+Byd8mnYEYWB+9mbVzVqDIw0lZYVjdVxWyjKIvyOWZt9QwyQwbDXI21Eap5lO3LkS4UEUTQ9bjf3JQY0zqw36B8z2kU7W7wisoiNX2DssPQzCH95B3UT7NmiRbK15SyS8vB6XaeLwW+LhuCqR0hfdyk2PUla2lzNDOUQd/0PEK5MSp1Er8csmLzXgzYweuGPI1SOQ8f8bsPDN203hawZVDTm10s+6Mmbhs771AWzQZVMrxwSnV1Au9ywHuJm61wiNnJew0YGuY/To2BNcm84QiVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14n/Rs/4gzDsuzDXDWNiQATKfyeUplwckdz4OHBPpFs=;
 b=MCHnMezdKcI2ubwq/4opoIDMq+6NeyrNef+hZlmdDqqzwCK49LOFVnJPJa2KMlP40SD0b0Nnh77xPi8a570WzWCXg6OXxWLBEfYVAdSjYrt93tUtbruYVxoBFd94jIJROwhW6WqyIdEaVK/FamV4Qd7YkE0bJvUOeBC4dKbSxWskX8T/jiNg0+mldwTZ4bwwsMU/Gf0cx395Z6cOaIQeBV/y00bpbpdvHruVC4nMvqhhGcG2puV5LgislQlo0RhuwZst8Z6B/vceVZTh5S6/m4Dh1JJ327nzTDgmWpnUyj0vVp2Ttg+KhbCP3nBkByZK35fpRsAhikk3FTFnMRqwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14n/Rs/4gzDsuzDXDWNiQATKfyeUplwckdz4OHBPpFs=;
 b=kK4YQqykXzRMyTVyMNuxRbYjpKhRQfm991jlUv8Xky1coq1EfdgELYXQ427WIvk5jEooxJW7GALGBGPbI537Sa0dzOQtMn2oIR541oTdNxCmVDuT+uBdKz2qvjiDohg35yoEbvPcIfTmkjYdX/BoIAvRHQwdM4oBAiOB1BsZvjc=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by BL3PR11MB6388.namprd11.prod.outlook.com (2603:10b6:208:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 16:58:21 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 16:58:21 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <George.Ge@microchip.com>,
        <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>, <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v5 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v5 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZibSHx5SO3XCpNUCUzf4fdZr/3a9hdPaAgAg5gwA=
Date:   Wed, 24 May 2023 16:58:21 +0000
Message-ID: <0f04479bc1d0005f80caa984b83743653620555d.camel@microchip.com>
References: <20230518165920.897620-1-kelvin.cao@microchip.com>
         <20230518165920.897620-2-kelvin.cao@microchip.com>
         <ZGdb8c2JfPTRexJT@matsya>
In-Reply-To: <ZGdb8c2JfPTRexJT@matsya>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|BL3PR11MB6388:EE_
x-ms-office365-filtering-correlation-id: d7e7e9c9-2426-4910-ade7-08db5c78146b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cT9jDEWRz7d1X+BE7Nh/9W24CCIzwTsIxRJTJHPViN3ttJhtDq7nm0zBaQxysELtW2XTKMhuzQapBb+v79ngXXHHJ5Y2nQl35l5FUxOstybD/XPBZU73A2X2WwUt7GPL+q2wbFT53aYdj12SR1GvZa6cv363wHrYk+xYBKY4oHNNelq4who0ArMlZXTEoH3GHAg+BruKpme/bNUPQZfxwIRwlrvO6kYYOcCmjxiJZmSSnUXbvB7P4JIjBSj2yVQuYiUOkwO+wN/lg4ykW7kpaixTyGcE8ai3cjFkj1tf0UywTh1MEpB05T/TSmLU62MR298SkNZc8dxyZaluy40TQH64g81jaJE9q+W0UgWAuyP1wYfs5PegxiwR+0yGZo9jS/ZTEPov8B4++W49LPPvmuwFQKk56UjXgb+0EyeKLKlpDKx55jPFufZoXlT4f70xBh7bgnJuXDa7mEIQekSwwWoFhtuKKF95WDgw3NUvin5kbqEwLfRxGYFUH0cPzDqjYrDYnvzNR3Ck242Ab0zRqHSyarelsGnOnEETDpft/tu+rJZxyFRj8vB+f/YnyDOjkwl7Jep+4rKlR/Z95aIx7jMeF038pBC7pKzrVB3PSCc3JV4vv5L3ZyXHR/9ysUg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(2616005)(83380400001)(2906002)(186003)(38100700002)(36756003)(86362001)(38070700005)(122000001)(8676002)(8936002)(5660300002)(66556008)(54906003)(64756008)(66476007)(66446008)(76116006)(91956017)(6916009)(66946007)(41300700001)(478600001)(4326008)(316002)(71200400001)(6486002)(6506007)(26005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUFrSnNHWDgyZllrTnhWTnY4U2F3WndwNkxWYzNLQXZrS1Z2U08wUndxSm44?=
 =?utf-8?B?bXc2UTZVbXpQRlhTWWRKQzZucUtUV3NpR0hjaDY4cEJvays0V0dPdCtweXdn?=
 =?utf-8?B?Ujliem9DZ1NTajFGOHNhaEtpZ1lmZkR0bWZlcDVnODkwa2VjcFNXSGVVUndp?=
 =?utf-8?B?bGVMNVk1Mm5sWk5qODZyV25GaUl3ZnJoYVk0eW41bllXZzdRY05ZeU9kM0J1?=
 =?utf-8?B?UG9IY1NMeWNDeG0xNUJ1Yi9PWnRsTTF0YUlQejRFSHBXUjkzN1BNaTMyM2l6?=
 =?utf-8?B?TTFQYURzNWJrblJUdVUrYlhwNUw1OEpwV1JXMDAycld4V2VRa0pYMnMxTW9k?=
 =?utf-8?B?anptZnNnVG5GMThKTUNnNEN6S0hCbUQrZm9NbzFzV2JJTlRsQUluRkNWRnY2?=
 =?utf-8?B?ZVo0RnNOMVkwQVFJRHlvSUhNbTZ2UFZFa045OEp5L1R5OHdLWTBHYVBSUlkv?=
 =?utf-8?B?ZzVNTEZnT2UxbDRrWkFsRkFtYXc4d29CRXArSmdoKzkzM1J1Y0hPRldLT1Jq?=
 =?utf-8?B?M0hWZ0JGd25KUENTVjNyWDJtOHdPN2JWWk43eEpmVE9LNE9qMnFKU28zNFlH?=
 =?utf-8?B?MGxvZmJSN3NJcEtpVVVtQXpteXVFeVd4TTI0c0kxSlFZcGVRemcrVks3cklx?=
 =?utf-8?B?NDg2d2ltdk44YWFTN1NKSnd0WHRpRjQ4YjBoQzFZVXBDcmI1RjVPUXNMZzA1?=
 =?utf-8?B?WmQ0dVAwZEFkQldLaThNb3JQWVY3WllKNUJCYkdzTEwvK1diR3lYVG5LWEZK?=
 =?utf-8?B?aGNjajlpNTZ3dmZpbHJNaUpxcWZCelptZDBURW1ZOFQwc0dZbUdQUWZCaXk0?=
 =?utf-8?B?QlY5UG5DM1ZFN2cxWTZVdkh2d2ZlUHdNQlllQzcvNDVZcFV1NTZNNnJVWHcz?=
 =?utf-8?B?ZlR5eHNtMUs2cWVON0RvTTl0M0xVaEVpQnp6TEd6S2ZLYS9LRDdOQTlhR1o3?=
 =?utf-8?B?UGczTFhxNk5lbXB1T0Q3MXgrYXVLN0t2cGRUTnJkQlJpc3lHVnRqSkFHN3RL?=
 =?utf-8?B?U3F4ZkF6ZG1ydWlEd0xTbGhQMWRFcjhWaytGdGp5OHJRVDhjY21iZzV4TTRH?=
 =?utf-8?B?QVRUS1VHSGtUblArOVdJUHE2OVNnMzZNbGl4Y2wyZ2hQV3RHeERGemU4b3Bn?=
 =?utf-8?B?ZUFYMzVxUGtvY1RLQytZWHQvSm4zRko3SkR4NkpkSi9GMUNnNUhMZXNGWm5s?=
 =?utf-8?B?cXpqUlUwMStsR0tLS3N0VG4zQ3VkWkE0cDFGSWpOamVUQ0FaUUkyMjQvcXdE?=
 =?utf-8?B?eXkrZWFEbEFwanNxdFo5NFlHak8yYjJRV3FpdjlVclltckF6eHh5YjhPMDJu?=
 =?utf-8?B?S21VbDA4OXZnREg1WksxT1hTWEFqaStNcFlSdmZVUkwrL0hzLzV5THhKZEFP?=
 =?utf-8?B?NWdLUy9yMXNLS1RHT3B6Q3VYU05GTzgzL3dSWDBDNS9JalloYTN1NDQ0UkF5?=
 =?utf-8?B?UXhSQnNLakRDOFhPWEkzdm9ENUs4TDNEellHc3NRMEVHRmNYcXovc3QzeFBY?=
 =?utf-8?B?WHBVTUFUNXpiUTViVEZ1UUxIWmZ2anZkMEZjRktrTnlrUWxZM0hPckdpQm5B?=
 =?utf-8?B?RGxIcC9qZkE0MklXUHdrRDlQUlI0VjVVZ05LSW1zU255d0Jodi9lTVhtQURZ?=
 =?utf-8?B?aUxRc3ZibldpV3pENTZodElxMnZXYkNQUmhVOS9UVCtPU2lpUGFTT0FldzJG?=
 =?utf-8?B?dzlaU05CVlQxbFdrQlRkdVE2Tm5tZHVyY2hzSEc5ZzJQcVBrelQzbm5WMlJl?=
 =?utf-8?B?d05hTVNicjVnTVJwMDN1RUJnMnpyRDc4VEZwaHlqNkQwVkEzbnlUc3RmTGlL?=
 =?utf-8?B?OGNpdjV2VDBkd1dQUmFuUXl1TS8zeTRsTnVZamFqK2Z6VnJMZHRkMjFsR3pL?=
 =?utf-8?B?MWhJL0NqaUNDMWlkVkg5cCtWSlBKMW84aHRuWFpKZGtYTDltbmN2L3VOVmgx?=
 =?utf-8?B?NlowQ3lnNWdSbGlHTjg1dEoxR2crMzE3VWtkei9DdWVrdzNVWWVVSCtMaS9T?=
 =?utf-8?B?RVJVSk13VlNCMnVnRmtFWmpPMndlenpKOEVnL1FFd3J2RW5BT0FETGxpdEJr?=
 =?utf-8?B?T0lFd1ROZUIxc3VTKzNlTy9xUjA2WjNIcnNLUWhzaEU3dkVkUVllUkdxcXRt?=
 =?utf-8?B?ZUw2ays4M0NVZWl6eWp0Wm9tUmRrZzg1aHJ1dGJ1TUJQUzhENHdEanhxSVFq?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10979280CCC46E4DB1A810909667ADBA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e7e9c9-2426-4910-ade7-08db5c78146b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 16:58:21.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VpiNGWrmGQE5J8IYYLdnu2rGRsNEsakay7Ct8eZELvdiBKzn12HY/U8+PJ6JGZkwbCV3yQfghWh3PWd+2xJrd5jnqdYaa88K7t3wA7gyY7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6388
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SSB0cmltbWVkIHRoZSBxdW90ZSB0byBtYWtlIGl0IGVhc2llciB0byBmb2xsb3cuIEkgaW50ZW50
aW9uYWxseQ0Kc2tpcHBlZCBzb21lIHN0eWxlIGNvbW1lbnRzIGZyb20gVmlub2QgaW4gdGhpcyBy
ZXBseS4gSG9wZWZ1bGx5IEkNCmRpZG4ndCBtaXNzIGFueXRoaW5nLg0KDQoNCj4gPiArI2RlZmlu
ZSBTV0lUQ0hURUNfRE1BX1NRX1NJWkXCoMKgwqDCoMKgwqDCoCBTWl8zMksNCj4gPiArI2RlZmlu
ZSBTV0lUQ0hURUNfRE1BX0NRX1NJWkXCoMKgwqDCoMKgwqDCoCBTWl8zMksNCj4gPiArDQo+ID4g
KyNkZWZpbmUgU1dJVENIVEVDX0RNQV9SSU5HX1NJWkXCoMKgwqDCoMKgIFNXSVRDSFRFQ19ETUFf
U1FfU0laRQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCB3YWl0X2Zvcl9jaGFuX3N0YXR1cyhzdHJ1
Y3QgY2hhbl9od19yZWdzIF9faW9tZW0NCj4gPiAqY2hhbl9odywgdTMyIG1hc2ssDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib29sIHNldCkNCj4gDQo+IHNpbmdsZSBsaW5lIHdvdWxk
IHJlYWQgbXVjaCBiZXR0ZXIhIChoZXJlIGFuZCBmZXcgb3RoZXIgcGxhY2VzKQ0KPiANCj4gQWxz
byBydW4gY2hlY2twYXRjaCB3aXRoIC0tc3RyaWN0IG9wdGlvbiwgdGhhdCB3aWxsIGhlbHAgY2F0
Y2ggc3R5bGUNCj4gaW5jb25zaXN0ZW5jaWVzIChpIGFtIHNlZWluZyBzb21lIGJlbG93KQ0KDQpP
ay4NCj4gDQo+ID4gK3sNCj4gPiArwqDCoMKgwqAgdTMyIHN0YXR1czsNCj4gPiArwqDCoMKgwqAg
aW50IHJldHJ5ID0gMTAwOw0KPiA+ICvCoMKgwqDCoCBpbnQgcmV0ID0gLUVJTzsNCj4gPiArDQo+
ID4gK8KgwqDCoMKgIGRvIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9
IHJlYWRsKCZjaGFuX2h3LT5zdGF0dXMpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKChzZXQgJiYgKHN0YXR1cyAmIG1hc2spKSB8fA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAoIXNldCAmJiAhKHN0YXR1cyAmIG1hc2spKSkgew0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IDA7DQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9DQo+IA0KPiB3aHkgbm90IHVzZSByZWFkbF9wb2xsX3RpbWVvdXQoKQ0K
DQpHb29kIHBvaW50LiBXaWxsIHVzZSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKCkuDQo+IA0K
PiA+ICsNCj4gPiArc3RhdGljIGludCBkaXNhYmxlX2NoYW5uZWwoc3RydWN0IHN3aXRjaHRlY19k
bWFfY2hhbiAqc3dkbWFfY2hhbikNCj4gPiArew0KPiA+ICvCoMKgwqDCoCB1MzIgdmFsaWRfZW5f
c2U7DQo+ID4gK8KgwqDCoMKgIHN0cnVjdCBjaGFuX2Z3X3JlZ3MgX19pb21lbSAqY2hhbl9mdyA9
IHN3ZG1hX2NoYW4tDQo+ID4gPm1taW9fY2hhbl9mdzsNCj4gPiArwqDCoMKgwqAgc3RydWN0IHBj
aV9kZXYgKnBkZXY7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCByY3VfcmVhZF9sb2NrKCk7DQo+ID4g
K8KgwqDCoMKgIHBkZXYgPSByY3VfZGVyZWZlcmVuY2Uoc3dkbWFfY2hhbi0+c3dkbWFfZGV2LT5w
ZGV2KTsNCj4gPiArwqDCoMKgwqAgaWYgKCFwZGV2KSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByY3VfcmVhZF91bmxvY2soKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiAtRU5PREVWOw0KPiA+ICvCoMKgwqDCoCB9DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCB2
YWxpZF9lbl9zZSA9IHJlYWRsKCZjaGFuX2Z3LT52YWxpZF9lbl9zZSk7DQo+ID4gK8KgwqDCoMKg
IHZhbGlkX2VuX3NlICY9IH5TV0lUQ0hURUNfQ0hBTl9FTkFCTEU7DQo+ID4gKw0KPiA+ICvCoMKg
wqDCoCB3cml0ZWwodmFsaWRfZW5fc2UsICZjaGFuX2Z3LT52YWxpZF9lbl9zZSk7DQo+ID4gKw0K
PiA+ICvCoMKgwqDCoCByY3VfcmVhZF91bmxvY2soKTsNCj4gPiArwqDCoMKgwqAgcmV0dXJuIDA7
DQo+IA0KPiBvbmx5IGRpZmYgYi93IGVuYWJsZS9kaXNhYmxlIGlzIGJpdCBvcHMsIEkgZ3Vlc3Mg
d2UgY2FuIGhhdmUgYSBjb21tb24NCj4gZm4NCj4gd2l0aCBhcmd1bWVudCBmb3IgZW5hYmxlL2Rp
c2FibGUNCg0KSSdsbCBtYWtlIHRoZXNlIHR3byBmdW5jdGlvbnMgd3JhcHBlcnMgdG8gYW5vdGhl
ciBmdW5jdGlvbiB3aGljaCB0YWtlcw0KZW5hYmxlL2Rpc2FibGUgZmxhZyBhcyBwYXJhbWV0ZXIu
DQo+IA0KPiA+ICtzdGF0aWMgc3RydWN0IGRtYV9hc3luY190eF9kZXNjcmlwdG9yDQo+ID4gKnN3
aXRjaHRlY19kbWFfcHJlcF93aW1tX2RhdGEoDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgZG1hX2NoYW4gKmMsIGRtYV9hZGRyX3QgZG1hX2RzdCwgdTY0IGRhdGEsDQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGZsYWdzKQ0KPiA+ICvCoMKg
wqDCoCBfX2FjcXVpcmVzKHN3ZG1hX2NoYW4tPnN1Ym1pdF9sb2NrKQ0KPiA+ICt7DQo+IA0KPiBj
YW4geW91IHBsZWFzZSBleHBsYWluIHdoYXQgaXMgbWVhbnQgYnkgd2ltbSBkYXRhIGFuZCBob3cg
aXQgdXMgdXNlZD8NCg0KU3VyZS4gR2VuZXJhbGx5IGl0J3MganVzdCBhbiBpbXBsZW1lbnRhdGlv
biBmb3IgdGhlDQpkZXZpY2VfcHJlcF9kbWFfaW1tX2RhdGEoKSBjYWxsYmFjay4gSSB0aGluayBp
dCdzIGFuIGFsdGVybmF0aXZlIG1ldGhvZA0KdG8gcHJlcF9tZW0gYW5kIHdvdWxkIGJlIG1vcmUg
Y29udmVuaWVudCB0byB1c2Ugd2hlbiB0aGUgd3JpdGUgaXMgOC0NCmJ5dGUgYW5kIHRoZSBkYXRh
IHRvIGJlIG1vdmVkIGlzIG5vdCBpbiBhIERNQSBtYXBwZWQgbWVtb3J5IGxvY2F0aW9uLg0KRm9y
IGV4YW1wbGUsIHdlIHdyaXRlIHRvIGEgZG9vcmJlbGwgcmVnaXN0ZXIgd2l0aCB0aGUgdmFsdWUg
ZnJvbSBhDQpsb2NhbCB2YXJpYWJsZSB3aGljaCBpcyBub3QgYXNzb2NpYXRlZCB3aXRoIGEgRE1B
IGFkZHJlc3MuDQo+IA0KPiA+IA0KPiA+ICsNCj4gPiArc3RhdGljIGRtYV9jb29raWVfdCBzd2l0
Y2h0ZWNfZG1hX3R4X3N1Ym1pdCgNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBkbWFfYXN5bmNfdHhfZGVzY3JpcHRvciAqZGVzYykNCj4gPiArwqDCoMKgwqAgX19yZWxlYXNl
cyhzd2RtYV9jaGFuLT5zdWJtaXRfbG9jaykNCj4gPiArew0KPiA+ICvCoMKgwqDCoCBzdHJ1Y3Qg
c3dpdGNodGVjX2RtYV9jaGFuICpzd2RtYV9jaGFuID0NCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHRvX3N3aXRjaHRlY19kbWFfY2hhbihkZXNjLT5jaGFuKTsNCj4gPiArwqDCoMKgwqAg
ZG1hX2Nvb2tpZV90IGNvb2tpZTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgIGNvb2tpZSA9IGRtYV9j
b29raWVfYXNzaWduKGRlc2MpOw0KPiA+ICsNCj4gPiArwqDCoMKgwqAgc3Bpbl91bmxvY2tfYmgo
JnN3ZG1hX2NoYW4tPnN1Ym1pdF9sb2NrKTsNCj4gDQo+IEkgZG9udCB0aGlzIGlzIGNvcnJlY3Qs
IHdoeSB3b3VsZCB5b3UgcHJldmVudCB1c2VycyBmcm9tIHByZXBhcmluZw0KPiBtdWx0aXBsZSBk
ZXNjcmlwdG9ycy4uPw0KDQoNClRoZSBkcml2ZXIgaW1wbGVtZW50cyB0aGUgU1Egd2l0aCBhIHBy
ZS1hbGxvY2F0ZWQgYnVmZmVyIHdoaWNoIG1lYW5zDQp0aGUgZGVzY3JpcHRvciB3ZSBhcmUgcHJl
cGFyaW5nIGhhcyBhIGRldGVybWluZWQgc2xvdCBpbiB0aGUgcXVldWUNCmJlZm9yZSB3ZSBzdWJt
aXR0aW5nIGl0LiBUbyBhbGlnbiB3aXRoIHRoZSB3YXkgaG93IGNvb2tpZXMgY29tcGxldGUsIEkN
CmhhdmUgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIGRlc2NyaXB0b3JzIGFyZSBwcmVwYXJlZCBhbmQg
c3VibWl0dGVkIGluDQpvcmRlci4gSSB0aGluayBpdCdzIGFsc28gdGhlIHdheSBzb21lIG90aGVy
IERNQSBkcml2ZXJzIHdvcmssIGxpa2UNCmlvYXQsIHBseC4gDQo+IA0KPiA+ICvCoMKgwqDCoCBz
aXplID0gU1dJVENIVEVDX0RNQV9TUV9TSVpFICogc2l6ZW9mKCpzd2RtYV9jaGFuLT5od19zcSk7
DQo+ID4gK8KgwqDCoMKgIHN3ZG1hX2NoYW4tPmh3X3NxID0gZG1hX2FsbG9jX2NvaGVyZW50KHN3
ZG1hX2Rldi0NCj4gPiA+ZG1hX2Rldi5kZXYsIHNpemUsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICZzd2RtYV9jaGFuLQ0KPiA+ID5kbWFfYWRkcl9zcSwNCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX0tFUk5FTCk7DQo+IA0KPiB0aGlzIGNhbiBiZSBj
YWxsZWQgZnJvbSBhdG9taWMgY29udGV4dCwgR0ZQX05PV0FJVCBwbHMNCg0KU3VyZS4NCj4gDQo+
ID4gDQo+ID4gK8KgwqDCoMKgIC8qIHNldCBzcS9jcSAqLw0KPiA+ICvCoMKgwqDCoCB3cml0ZWwo
bG93ZXJfMzJfYml0cyhzd2RtYV9jaGFuLT5kbWFfYWRkcl9zcSksICZjaGFuX2Z3LQ0KPiA+ID5z
cV9iYXNlX2xvKTsNCj4gPiArwqDCoMKgwqAgd3JpdGVsKHVwcGVyXzMyX2JpdHMoc3dkbWFfY2hh
bi0+ZG1hX2FkZHJfc3EpLCAmY2hhbl9mdy0NCj4gPiA+c3FfYmFzZV9oaSk7DQo+ID4gK8KgwqDC
oMKgIHdyaXRlbChsb3dlcl8zMl9iaXRzKHN3ZG1hX2NoYW4tPmRtYV9hZGRyX2NxKSwgJmNoYW5f
ZnctDQo+ID4gPmNxX2Jhc2VfbG8pOw0KPiA+ICvCoMKgwqDCoCB3cml0ZWwodXBwZXJfMzJfYml0
cyhzd2RtYV9jaGFuLT5kbWFfYWRkcl9jcSksICZjaGFuX2Z3LQ0KPiA+ID5jcV9iYXNlX2hpKTsN
Cj4gPiArDQo+ID4gK8KgwqDCoMKgIHdyaXRldyhTV0lUQ0hURUNfRE1BX1NRX1NJWkUsICZzd2Rt
YV9jaGFuLT5tbWlvX2NoYW5fZnctDQo+ID4gPnNxX3NpemUpOw0KPiA+ICvCoMKgwqDCoCB3cml0
ZXcoU1dJVENIVEVDX0RNQV9DUV9TSVpFLCAmc3dkbWFfY2hhbi0+bW1pb19jaGFuX2Z3LQ0KPiA+
ID5jcV9zaXplKTsNCj4gDQo+IHdoeSBpcyBoYXJkd2FyZSBiZWluZyB3cml0dGVuIGluIGFsbG9j
IGNhbGwsIHRoZSBqb2IgaXMgdG8gcHJlcGFyZQ0KPiBkZXNjcml0b3IsIGh3IHdyaXRlIHNob3Vs
ZCBoYXBwZW4gd2hlbiB3ZSBzdWJtaXQgdGhlIGRlc2NyaXB0b3JzLi4NCg0KVGhlIGRlc2NyaXB0
b3JzIGluIHRoZSBxdWV1ZSBhcmUgcHJlLWFsbG9jYXRlZCBzbyBJIHRoaW5rIGl0J3MgcHJvcGVy
DQp0byBjb252ZXkgdGhlIGluZm8gdG8gaGFyZHdhcmUgYXQgdGhpcyBwb2ludC4gQW5kIGluIHN1
Ym1pdCBvbmx5IHRoZQ0KY29va2llIGlzIGFzc2lnbmVkLiANCj4gDQo+ID4gK8KgwqDCoMKgIHJj
ID0gZG1hX2FzeW5jX2RldmljZV9yZWdpc3RlcihkbWEpOw0KPiA+ICvCoMKgwqDCoCBpZiAocmMp
IHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBjaV9lcnIocGRldiwgIkZhaWxlZCB0
byByZWdpc3RlciBkbWEgZGV2aWNlOiAlZFxuIiwNCj4gPiByYyk7DQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBnb3RvIGVycl9jaGFuc19yZWxlYXNlX2V4aXQ7DQo+ID4gK8KgwqDCoMKg
IH0NCj4gPiArDQo+ID4gK8KgwqDCoMKgIHBjaV9pbmZvKHBkZXYsICJDaGFubmVsIGNvdW50OiAl
ZFxuIiwgY2hhbl9jbnQpOw0KPiANCj4gZGV2X2luZm8oKT8NCg0KQW55IHNwZWNpZmljIHJlYXNv
biBmb3Igc3dpdGNoaW5nIHRvIGRldl9pbmZvKCk/ICANCg0KDQpUaGFua3MsDQpLZWx2aW4NCg==
