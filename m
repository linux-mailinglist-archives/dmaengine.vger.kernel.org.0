Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA396D5331
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 23:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjDCVNT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 17:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjDCVNR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 17:13:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC8610C4;
        Mon,  3 Apr 2023 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680556394; x=1712092394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9MSZb94qBImJjb67Yl/F8Xo90LaWmX5Q8/fAQvqGIrk=;
  b=Sg1Dfi3cwAywmDgzNxDGrI7014TCGpTgc0jVJHkJZ6mvfu6Lh0VA3Div
   28fP3Tx8Yk3ob23u+alLjaE5tz9RMlp+wGiM3tVObNwzQPmPFqehU5GVR
   B8UHtNhWghOi1LmKRxJKOwsg+MDBJzpZ3NrXz5QeNRKnRI1sNstYG0aYV
   yFBHVu0dvZQbO9wNX1sYWH30nibr38oeknWlkLJTHx/5fpkPTTGlVZGZY
   UNspez4OTj2ThpBGaqwykgUfIpOVH/OP0AoAMTJX1RkMZI7++5c+g/akX
   eohosfv7B+p326/FjBmioGny8nYG+ZW1rLruaEpNZy32zgs9OAGj9ns3t
   w==;
X-IronPort-AV: E=Sophos;i="5.98,315,1673938800"; 
   d="scan'208";a="207977477"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Apr 2023 14:13:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 14:13:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 14:13:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff7QKeMmOGEo8aJtBhQRtLRQ8s5bWSGZxnQljO6EdE0/Z1zAZi7dxgpP7IrNLjlvyKmaSTAC1TCoPhmZqzKt5KkuNFwqGQdfqulOchPh+MptGuJgr1Trq6hjhIjti1AfW8VNkJ4TtxzLvavXcB9w06AZFVZ2bp3K3ECfGvkYuuayQsIQo2fuQjdqTUCE1vxTOuxD3AuyWqFprcnrs14gWTNgNYkvRhn+s/XwGoodlxwvsWEtPhL8EmsBS3a+XHcWqtgOYK3KhT2BTWSC+xi8bDmq9JBgHlX03R9CT85UfIk3tNrbndq4Pn2SVgUBMaERVKAztUkEYalFkI5LxeXpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MSZb94qBImJjb67Yl/F8Xo90LaWmX5Q8/fAQvqGIrk=;
 b=A9qbvM9Atm+MXQUBekwyMlMofM+711Uv9qWEPd/JJd2eK85IM9MWi7TEfEBWvOfQHJpf9kJgfvKSIKbUmqeh2zfN4BGTxkH35mgbChX7cXWMxilGef3vz2D5qIQzmOioMuYAJoCgJ/89ubonqUx1AONKJsM94f3v4CZEro3GdeWFADzP1ZIF6j3/lMwGykKLz37y0FZHw0nYkFp6aFd56wI9OVcM1h2dGVeB7KM2V2GctNYq3HRcxo/nyckIvQmyZ0jyHO2tXz/KoXth9f20QeN1XdQOs1Ck1/3NNTjBpG4Z6BYVBO4p7t1D6FwXkFGJZTq2uPGF4pXtuTsDmm/Uhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MSZb94qBImJjb67Yl/F8Xo90LaWmX5Q8/fAQvqGIrk=;
 b=ZfrP+fu8uIOY00pM+TMcHbDBNRe4cbDd11gxt+kfqUO0VS4mbK54+OXLWxrr09AMq7oUQ9Hcv82aj0cesClXsA9HjnNbdvkV26Jn2fS5uBE2tTrGgXeRFY3cp/4mzKLN+iQnvGA+Nx/VvIawEvburcJ08+6pTnzcDelCEGfZkmI=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by DS7PR11MB7906.namprd11.prod.outlook.com (2603:10b6:8:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Mon, 3 Apr
 2023 21:13:10 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::2da3:928d:62ec:7a91]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::2da3:928d:62ec:7a91%5]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 21:13:10 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <christophe.jaillet@wanadoo.fr>, <linux-kernel@vger.kernel.org>
CC:     <George.Ge@microchip.com>, <logang@deltatee.com>
Subject: Re: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZZmFWCpgZadogBUKZpBFKgoENK68aCGAA///4tQA=
Date:   Mon, 3 Apr 2023 21:13:10 +0000
Message-ID: <9e90cdfb6838dac66294ee21b0c1408b9534753a.camel@microchip.com>
References: <20230403180630.4186061-1-kelvin.cao@microchip.com>
         <20230403180630.4186061-2-kelvin.cao@microchip.com>
         <83cb23dd-9c42-b7fe-c859-c453556d1a27@wanadoo.fr>
In-Reply-To: <83cb23dd-9c42-b7fe-c859-c453556d1a27@wanadoo.fr>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|DS7PR11MB7906:EE_
x-ms-office365-filtering-correlation-id: 483d7df4-63e1-4989-8021-08db34883a50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nud8zomXFoEs5kbR742XG/szgWEjulXfbp71pmO9rdfDZ3FHFiZb1NL99vIPaLl02YJRlosCGRPiIgGI9dOG4bZZzZbBXlKflc4yOsvfK4st/Fn45ip8d5axHsWax97grfvAtLqztcg8RQrpBXtzAf2ep0bmtCTy1MRLaU+sGXz1THHfm++UGxEowDd1X4EqMJ7DV+fEYMUCGqG2coVaFcTic5bOubecRsigYVYZ7FOpv3eFaJ9r3XEedj3hau6ID/TYEpuiXVR2GMP/62y5tdEneJf5UI3tpsWDQC7MFLISSLXmFhyfq8NaBgKuH/bnZvuMttxXKO06kuQyUVwF1Wbo4ovltZtAMwztUME9wBugatQHFhz4wSrsREXT1ofubPDtSWeUJvbgOPwfg9LK902dTHR9ax6gY/TtVqCGyMfYypfjwH/aN3ZdHekNaIbfwvUJRqONvTOCXsJ4J3tRh0hd21UXghSmrkCUe04DZoeIO2QBeGgt7syZl79xN2UbqlaimzS2TH1P9np2AyM0l+wj8SpBhQ8KAmqM6tgGx6XA+avrZX7d/hsoYKOeJN4eCU1eYikjulOfUuv7Po/06y02lN3HgZxwJQEZjkevvTsLD3Qcten2tM21FKXz3Nr+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(8936002)(122000001)(2906002)(8676002)(41300700001)(36756003)(86362001)(38100700002)(38070700005)(6506007)(316002)(6486002)(478600001)(66574015)(71200400001)(110136005)(54906003)(5660300002)(186003)(2616005)(26005)(6512007)(66556008)(76116006)(66946007)(91956017)(66446008)(64756008)(66476007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MERON2E2ZUJHWGpXY2dkMmxFbk1LOW84OTl3YUptaTRnTWVPT0RjQjI2WTNO?=
 =?utf-8?B?OWhvWWhpWEd6aCs4dVZ0YXVmby9SWTZGajVtblNjWUVmbi9ZdlBKazhidlVw?=
 =?utf-8?B?M05XdGx0SU5OTmxDM0w1SFMxdXNQNU1qY3NDOWNCUUN2VEtWRXdGVWV6ZkxE?=
 =?utf-8?B?QUk3cWdCbVhpK1pHRHN3NlFlbU94UnFQelhXcERkTkRYQ3l2YjhCZTVLdU9t?=
 =?utf-8?B?cU8wblhsTURPQmNsd21oNkF4RXhldnAzaUJmSGlrREtrSklZUm5KemlwV1dF?=
 =?utf-8?B?UE9ORGVPV2FUWU5KMk56QmVFL1QxaGlXampYbXdrbnR3clgzOHhncnJKeEx0?=
 =?utf-8?B?ekpoVWxQN3VQYSs4dTg0citYc0pDWlpWUG8vR0RtY2h2UGtQSFM0MVdkZFQw?=
 =?utf-8?B?K010WGdqT2NLTlhMRW8ySnlkdDRURUloS3h6ODRtMTFrVUNlbHBGcTMyQmFG?=
 =?utf-8?B?b1lXVEF3MTRPU1pSMCtWSzZKbTRDOThUUE1xS3VZaUNGYTJXdlJ5Tk5zUW5R?=
 =?utf-8?B?dUJFc29MZTlWeWdiT2Z4NXF4ZnpVazl1dG1pNUxGT2NIdXlkd3hoeWtTUkEz?=
 =?utf-8?B?c1lUZy9WUXl4bWsvWTQ2UzlxWGNsb0FqYXhsNjRZRmVDTGp1L3JIblN5N040?=
 =?utf-8?B?Z0VBUlNiRUI2NGJXTUUrOFdnZGI3Sk9QK29iT1dIYktJQ3BLWDJneFk4RXJI?=
 =?utf-8?B?ZG9CcXRpKzB1NGFHZEFqT1YrVjk2SWhoNXdSWFV2dVFCMTVWeGhIbXpSblRN?=
 =?utf-8?B?bTdkUElpenA3UGhtY2ZKcjFyMGFlOUptbTBzbVptaDA1ektRclZPcDdUQm9J?=
 =?utf-8?B?RmV6emlmSkE0VlpNZmVqc0hDZk5vblV1MDJuN0oxL1QyNkY4dHpSNlljRmlO?=
 =?utf-8?B?eG9uNlc1VmRRTXgraHZVeGxxdGpnQmdSSms0ekl2aGhPWFh2UjltampibVVX?=
 =?utf-8?B?MGJEczBGdk5RREpHcmFPQjZYdWtBM2RERUc1VVp0V0NUaENkVU5JblIzNXJs?=
 =?utf-8?B?MEFleFJwMjdnRWwyekYzL3ludkRnai9VQ1FvMGVmc1RQc3R0cGUzd25SR01R?=
 =?utf-8?B?alhRYmpVMllPM3h5WCs2akV1aUhlZW80ZFVyVmZIYzU2aC85d2lWYkJpTitp?=
 =?utf-8?B?SDFJT2MwUkhyWHFUYnF4YlZVb3hXbXhJK1lKendSUjd3YkQ0WGtGcEpTdmtj?=
 =?utf-8?B?U3ljR3ZhYlhtemJ4TDRLSEV5MnE1a3VYQUpCeEMzWHd4L05CVDdYMUNaNXgv?=
 =?utf-8?B?ekdCZ1ZuVGhWU3ArQ3RYUEFvRjNaWXZBOGt5dmVVNW1aeUpaNkdsZTQrc2E2?=
 =?utf-8?B?cFl1UUljd0pCK1Z4UHk1aWRrWG9rc0gyQnBFeDlnWktMeWFBQ1JLeVlVWUtk?=
 =?utf-8?B?anUyUlJNL0NZZURDeTUzUDc2RGdtV3FYY2NUV0VnLy85Y1A0VnkxNXVDeHdx?=
 =?utf-8?B?YzBwT0t2dnhvVWx4V01jdHVQOTVyTmxuWWtrdlovTW9wMitmQ2lIVUt0Mi93?=
 =?utf-8?B?bHo2SGdDb2RWSWV3bHNlVHFCV0VQT1d6TVZRdWM4TkIzUDhhU0lQMzlBSUJR?=
 =?utf-8?B?NDI3eGFSNVI3YlVVSWRUOVhYREpBRDZ4MjdCeW5ERmE1VU5YL0M0RG90N0FT?=
 =?utf-8?B?MDRrL2R6VFRHcmhtbnc3NEFxUGZDQUNRWnhIRzBiaEhyamR0TTQ3cjRPcjVK?=
 =?utf-8?B?eXkwQWhjRy8zTXdWd0FxaEViMXFkWUdCZDFndk1oL0xaZ2hHM3kvNTdZQTZS?=
 =?utf-8?B?SHlrSlg1d0NSR3BjT1R0TnJ3TGJjUVk4dFpCTHpFN0FsVzBoNFZIV2psWUhs?=
 =?utf-8?B?c2Y4enFCYU43SWwyb1Y1THhYSGtNNmJPVTlKck1ZeXZPbmZIb0ZjbEIxS3ZP?=
 =?utf-8?B?Y0NDL0hCdWFwa29iZzNFQjJmSExIck8rMG56ZmgrRzRzS1JZRk1NZmJwa0VQ?=
 =?utf-8?B?NENPbDBOb3NkaVdaRW9QN1F4S1M0UTZpQ2gyNCs5SXZPYnNVVndoRGVYLzFY?=
 =?utf-8?B?MkJiRFVNSTJodlRTOU15NVBOcHYvQzAzTUxpb0lEcWV0Znp4OExXQXFyZm0v?=
 =?utf-8?B?YTdIbWdtTStBbFI2bEswYWVMMmJSSE5ldkZzdkdUNXU5MTM5ZnJpNlVUaC9I?=
 =?utf-8?B?S2s0THBVS2l1NmJpYS94bFYyUHQ2bUJVdW14U0NaZkEzelRXMHIwdWlKVk5R?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30D4C64402686749A30D61BB6B3F201D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483d7df4-63e1-4989-8021-08db34883a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 21:13:10.1143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9hsJ6RNa0WdGqTpb9x9Mypnjo4qbGkp0HxlDmi81yY6v7Exe81z9muQpHU38jflnycsB+DZ2L1C9sULzPCzeMlBiudvbk4x4Du8NkwZviGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7906
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDIyOjI2ICswMjAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gTGUgMDMv
MDQvMjAyMyDDoCAyMDowNiwgS2VsdmluIENhbyBhIMOpY3JpdCA6DQo+ID4gU29tZSBTd2l0Y2h0
ZWMgU3dpdGNoZXMgY2FuIGV4cG9zZSBETUEgZW5naW5lcyB2aWEgZXh0cmEgUENJDQo+ID4gZnVu
Y3Rpb25zDQo+ID4gb24gdGhlIHVwc3RyZWFtIHBvcnRzLiBBdCBtb3N0IG9uZSBzdWNoIGZ1bmN0
aW9uIGNhbiBiZSBzdXBwb3J0ZWQNCj4gPiBvbg0KPiA+IGVhY2ggdXBzdHJlYW0gcG9ydC4gRWFj
aCBmdW5jdGlvbiBjYW4gaGF2ZSBvbmUgb3IgbW9yZSBETUENCj4gPiBjaGFubmVscy4NCj4gPiAN
Cj4gPiBJbXBsZW1lbnQgY29yZSBQQ0kgZHJpdmVyIHNrZWxldG9uIGFuZCByZWdpc3RlciBETUEg
ZW5naW5lDQo+ID4gY2FsbGJhY2tzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEtlbHZpbiBD
YW8gPGtlbHZpbi5jYW9AbWljcm9jaGlwLmNvbT4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IEdlb3Jn
ZSBHZSA8Z2VvcmdlLmdlQG1pY3JvY2hpcC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogR2Vvcmdl
IEdlIDxnZW9yZ2UuZ2VAbWljcm9jaGlwLmNvbT4NCj4gPiAtLS0NCj4gPiAgIE1BSU5UQUlORVJT
ICAgICAgICAgICAgICAgICB8ICAgIDUgKw0KPiA+ICAgZHJpdmVycy9kbWEvS2NvbmZpZyAgICAg
ICAgIHwgICAgOSArDQo+ID4gICBkcml2ZXJzL2RtYS9NYWtlZmlsZSAgICAgICAgfCAgICAxICsN
Cj4gPiAgIGRyaXZlcnMvZG1hL3N3aXRjaHRlY19kbWEuYyB8IDE3MzQNCj4gPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxNzQ5IGlu
c2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2RtYS9zd2l0Y2h0
ZWNfZG1hLmMNCj4gPiANCj4gDQo+IEhpLA0KPiBqdXN0IGEgZmV3IG5pdCwgc2hvdWxkIHlvdSBm
aW5kIHRoZW0gdXNlZnVsLg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gK3N0YXRpYyB2b2lkIHN3aXRj
aHRlY19kbWFfcHJvY2Vzc19kZXNjKHN0cnVjdCBzd2l0Y2h0ZWNfZG1hX2NoYW4NCj4gPiAqc3dk
bWFfY2hhbikNCj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCBkZXZpY2UgKmNoYW5fZGV2ID0gdG9f
Y2hhbl9kZXYoc3dkbWFfY2hhbik7DQo+ID4gKyAgICAgc3RydWN0IGRtYWVuZ2luZV9yZXN1bHQg
cmVzOw0KPiA+ICsgICAgIHN0cnVjdCBzd2l0Y2h0ZWNfZG1hX2Rlc2MgKmRlc2M7DQo+ID4gKyAg
ICAgc3RydWN0IHN3aXRjaHRlY19kbWFfaHdfY2UgKmNlOw0KPiA+ICsgICAgIF9fbGUxNiBwaGFz
ZV90YWc7DQo+ID4gKyAgICAgaW50IHRhaWw7DQo+ID4gKyAgICAgaW50IGNpZDsNCj4gPiArICAg
ICBpbnQgc2VfaWR4Ow0KPiA+ICsgICAgIHUzMiBzdHNfY29kZTsNCj4gPiArICAgICBpbnQgaSA9
IDA7DQo+IA0KPiBObyBuZWVkIHRvIGluaXQuDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArc3RhdGlj
IGludCBzd2l0Y2h0ZWNfZG1hX2FsbG9jX2Rlc2Moc3RydWN0IHN3aXRjaHRlY19kbWFfY2hhbg0K
PiA+ICpzd2RtYV9jaGFuKQ0KPiA+ICt7DQo+ID4gKyAgICAgc3RydWN0IHN3aXRjaHRlY19kbWFf
ZGV2ICpzd2RtYV9kZXYgPSBzd2RtYV9jaGFuLT5zd2RtYV9kZXY7DQo+ID4gKyAgICAgc3RydWN0
IHBjaV9kZXYgKnBkZXY7DQo+ID4gKyAgICAgc3RydWN0IGNoYW5fZndfcmVncyBfX2lvbWVtICpj
aGFuX2Z3ID0gc3dkbWFfY2hhbi0NCj4gPiA+bW1pb19jaGFuX2Z3Ow0KPiA+ICsgICAgIHNpemVf
dCBzaXplOw0KPiA+ICsgICAgIHN0cnVjdCBzd2l0Y2h0ZWNfZG1hX2Rlc2MgKmRlc2M7DQo+ID4g
KyAgICAgaW50IHJjOw0KPiA+ICsgICAgIGludCBpOw0KPiA+ICsNCj4gPiArICAgICBzd2RtYV9j
aGFuLT5oZWFkID0gc3dkbWFfY2hhbi0+dGFpbCA9IDA7DQo+ID4gKyAgICAgc3dkbWFfY2hhbi0+
Y3FfdGFpbCA9IDA7DQo+ID4gKw0KPiA+ICsgICAgIHNpemUgPSBTV0lUQ0hURUNfRE1BX1NRX1NJ
WkUgKiBzaXplb2YoKnN3ZG1hX2NoYW4tPmh3X3NxKTsNCj4gPiArICAgICBzd2RtYV9jaGFuLT5o
d19zcSA9IGRtYV9hbGxvY19jb2hlcmVudChzd2RtYV9kZXYtDQo+ID4gPmRtYV9kZXYuZGV2LCBz
aXplLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZz
d2RtYV9jaGFuLQ0KPiA+ID5kbWFfYWRkcl9zcSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBHRlBfS0VSTkVMKTsNCj4gPiArICAgICBpZiAoIXN3ZG1h
X2NoYW4tPmh3X3NxKSB7DQo+ID4gKyAgICAgICAgICAgICByYyA9IC1FTk9NRU07DQo+ID4gKyAg
ICAgICAgICAgICBnb3RvIGZyZWVfYW5kX2V4aXQ7DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4gPiAr
ICAgICBzaXplID0gU1dJVENIVEVDX0RNQV9DUV9TSVpFICogc2l6ZW9mKCpzd2RtYV9jaGFuLT5o
d19jcSk7DQo+ID4gKyAgICAgc3dkbWFfY2hhbi0+aHdfY3EgPSBkbWFfYWxsb2NfY29oZXJlbnQo
c3dkbWFfZGV2LQ0KPiA+ID5kbWFfZGV2LmRldiwgc2l6ZSwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmc3dkbWFfY2hhbi0NCj4gPiA+ZG1hX2FkZHJf
Y3EsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0ZQ
X0tFUk5FTCk7DQo+ID4gKyAgICAgaWYgKCFzd2RtYV9jaGFuLT5od19jcSkgew0KPiA+ICsgICAg
ICAgICAgICAgcmMgPSAtRU5PTUVNOw0KPiA+ICsgICAgICAgICAgICAgZ290byBmcmVlX2FuZF9l
eGl0Ow0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgbWVtc2V0KHN3ZG1hX2NoYW4tPmh3
X2NxLCAwLCBzaXplKTsNCj4gDQo+IFRoZSBtZW1vcnkgYWxsb2NhdGVkIHdpdGggZG1hX2FsbG9j
X2NvaGVyZW50KCkgaXMgYWxyZWFkeSB6ZXJvZWQuDQo+IA0KPiA+ICsNCj4gPiArICAgICAvKiBy
ZXNldCBob3N0IHBoYXNlIHRhZyAqLw0KPiA+ICsgICAgIHN3ZG1hX2NoYW4tPnBoYXNlX3RhZyA9
IDA7DQo+ID4gKw0KPiA+ICsgICAgIHNpemUgPSBzaXplb2YoKnN3ZG1hX2NoYW4tPmRlc2Nfcmlu
Zyk7DQo+ID4gKyAgICAgc3dkbWFfY2hhbi0+ZGVzY19yaW5nID0ga2NhbGxvYyhTV0lUQ0hURUNf
RE1BX1JJTkdfU0laRSwNCj4gPiBzaXplLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgR0ZQX0tFUk5FTCk7DQo+ID4gKyAgICAgaWYgKCFzd2RtYV9jaGFuLT5kZXNj
X3JpbmcpIHsNCj4gPiArICAgICAgICAgICAgIHJjID0gLUVOT01FTTsNCj4gPiArICAgICAgICAg
ICAgIGdvdG8gZnJlZV9hbmRfZXhpdDsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIG1l
bXNldChzd2RtYV9jaGFuLT5kZXNjX3JpbmcsIDAsIFNXSVRDSFRFQ19ETUFfUklOR19TSVpFICoN
Cj4gPiBzaXplKTsNCj4gDQo+IFRoaXMgaXMgYWxyZWFkeSBrY2FsbG9jKCknZWQuDQo+IA0KPiBD
Sg0KDQpIaSBDSiwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LCB3aWxsIGZpeCB0aGVtIGluIHRo
ZSBuZXh0IHZlcnNpb24uDQoNCktlbHZpbg0K
