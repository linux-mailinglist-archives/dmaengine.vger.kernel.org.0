Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 442EACAB00
	for <lists+dmaengine@lfdr.de>; Thu,  3 Oct 2019 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbfJCRZv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Oct 2019 13:25:51 -0400
Received: from mail-eopbgr750058.outbound.protection.outlook.com ([40.107.75.58]:23845
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730588AbfJCRZu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Oct 2019 13:25:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THKqEt7sQng7I/eb6YZC7HVoV8xun0MizsuGyepk4nR/iZ+5LQOGBqgCAlwyR4q4PT1iBBoc081F3CVX8LlUa+NRKt6frRpM9LoSzOsiiR6nJ8YrPDSXbTU9O2tvud2DsqYDCwZVTtDaczxTrqtpzeJZrijXNJ/YjkWo0JltVydWgQ4CwTwrPLBQCOG1PoI2/qzf/UfBM0jdKZtoMuzawaqUVfzmb1S1XF3SVGLXTSaz2zU3cbSkCjCg7K+WyFAHyjGTV3GNAWcSoeFOGzS0kYaqz3gZu8af0tqqYLdlRXu3kuhfloJBZJG51Voqysc0GkJJ/JfgwWl0vkSKjlVQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giJHT+aGfUYJMdwrVdaOHnLqvj21FzX6UNf7gnBoQ6s=;
 b=E7KHA7vsCxhVTxvPUFhaN56TA7YBJ625PNJZmmzcd2wm7nG7KpSpL3xp0MHN6HbpyZuNqOmbYZxiSfGbbm09gttSWs6hh5VAp3Lr7JYGuO6mocbfjdhi0ion5eifYzYiqErdwI/Fvh2HFwQi9V5vAHRz/W8y65sUENBY6kv5OdX+yDDbWRjhIyrvHEK+E7TT6beKsarsWoRTeom2a0Xo/xbrvD2CpL1WSYByQdnNzW2aCbztKBgrC1JObxD2fYIwt8tXIYR5DFHx5fV1OahvbUCMHHyjb23tGRFg0G5+i1UqQeRYc83aE1K7GPieanxFVRUATREbGrIG+GFiL2/RIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giJHT+aGfUYJMdwrVdaOHnLqvj21FzX6UNf7gnBoQ6s=;
 b=hfbN2EK39upsNBOmzwou85ecXzbr3qN18/WWlWkm4y2s4RQR3QABUKmk1eUebx0wE99+OI3F5FKXpFPxY0yBqv4mO/8X3VCkpzKmFjhVzjwvHbP6jKy462IhNmAPekVutpM53+f3RADCTnM3Np4R9EaXHS4/aFctecun/H/1coI=
Received: from DM6PR12MB3451.namprd12.prod.outlook.com (20.178.198.218) by
 DM6PR12MB2810.namprd12.prod.outlook.com (20.176.118.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Thu, 3 Oct 2019 17:24:46 +0000
Received: from DM6PR12MB3451.namprd12.prod.outlook.com
 ([fe80::2970:ffc7:bab:4e32]) by DM6PR12MB3451.namprd12.prod.outlook.com
 ([fe80::2970:ffc7:bab:4e32%3]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 17:24:46 +0000
From:   Sanjay R Mehta <sanmehta@amd.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Kumar, Rajesh" <Rajesh1.Kumar@amd.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 1/4] dma: Add PTDMA Engine driver support
Thread-Topic: [PATCH 1/4] dma: Add PTDMA Engine driver support
Thread-Index: AQHVcqoYFCdjRu+vbE6D9/1LZkEgHqc65WsAgA5UGIA=
Date:   Thu, 3 Oct 2019 17:24:45 +0000
Message-ID: <bcd96f78-9b5d-bc9e-7baf-20c6ed031473@amd.com>
References: <1569310272-29153-1-git-send-email-Sanju.Mehta@amd.com>
 <064f3abe-7d6c-0ab3-1362-61ba6b09840e@infradead.org>
In-Reply-To: <064f3abe-7d6c-0ab3-1362-61ba6b09840e@infradead.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::11) To DM6PR12MB3451.namprd12.prod.outlook.com
 (2603:10b6:5:3b::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.206.13.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aaf7cefd-80b4-4790-da88-08d7482695cc
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR12MB2810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2810BCC264F6358EE6FF5E6FE59F0@DM6PR12MB2810.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(5660300002)(71200400001)(2201001)(316002)(14454004)(6436002)(6116002)(7736002)(36756003)(52116002)(478600001)(3846002)(4744005)(305945005)(110136005)(66066001)(54906003)(7416002)(6512007)(55236004)(102836004)(31686004)(71190400001)(2501003)(11346002)(386003)(476003)(76176011)(229853002)(446003)(6506007)(53546011)(66476007)(64756008)(66446008)(66556008)(2616005)(66946007)(2906002)(25786009)(26005)(4326008)(186003)(99286004)(8936002)(8676002)(6486002)(81156014)(81166006)(6246003)(486006)(256004)(31696002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2810;H:DM6PR12MB3451.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rvF9YzBQ5vgpeJivZbpahRXbb3dtUr3oRPuQMxKyhcJ+8QUAhbGj0HiF0St5Z8l0fXSIE5SPyDt5vmH5zaoCqdBa/TtUS0OwPUd66Mjybynb5qTdm+go21Ys+zMIz53Rv1C4Ccp1DLb2Mp0LteMBPnozT9mJ13nWpwp2cBbM44cNLcEw4+J5j/wSYDh97ub6MHupHjr9U8DJlz7eSthw+UcxgECbuo0axfarkdmkvO8rkKZ7JKdJsqFCpUzku47nIJEZkgTM9Rr9/CCY2YEHxB2zTouOGku2tH46MGQ7+/op23K/gtYKut0ww9aUUO4c+uT9kuRVc7ZhZ/hKrLgRgxu2xYP+F+gY0uCE1MjKQxYloBWG2mbjSgIMDJNQtjufIB10nWPxtCOl3DCXvnE9g4VlG6jUgf+Pra23N3sYgA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75950D68A5A2B344AC8FE09DC445D48A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf7cefd-80b4-4790-da88-08d7482695cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 17:24:45.8990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGei72urOiOFjOsplu4F+qnHyFoKiDG4rEsUg8XE2da8hbmL4Xi1R7PwqXzBED9iFed0odMuyoNURb8ZO1PlvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQpPbiA5LzI0LzIwMTkgODowNSBQTSwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiBbQ0FVVElPTjog
RXh0ZXJuYWwgRW1haWxdDQo+DQo+IE9uIDkvMjQvMTkgMTI6MzEgQU0sIE1laHRhLCBTYW5qdSB3
cm90ZToNCj4+IEZyb206IFNhbmpheSBSIE1laHRhIDxzYW5qdS5tZWh0YUBhbWQuY29tPg0KPj4N
Cj4+IFRoaXMgaXMgdGhlIGRyaXZlciBmb3IgdGhlIEFNRCBwYXNzdGhyb3VnaCBETUEgRW5naW5l
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2FuamF5IFIgTWVodGEgPHNhbmp1Lm1laHRhQGFtZC5j
b20+DQo+PiBSZXZpZXdlZC1ieTogU2h5YW0gU3VuZGFyIFMgSyA8U2h5YW0tc3VuZGFyLlMta0Bh
bWQuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IFJhamVzaCBLdW1hciA8UmFqZXNoMS5LdW1hckBhbWQu
Y29tPg0KPj4gLS0tDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvcHRkbWEvS2NvbmZpZyBi
L2RyaXZlcnMvZG1hL3B0ZG1hL0tjb25maWcNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBp
bmRleCAwMDAwMDAwLi5hMzczNDMxDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9kcml2ZXJz
L2RtYS9wdGRtYS9LY29uZmlnDQo+PiBAQCAtMCwwICsxLDcgQEANCj4+ICsjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4+ICtjb25maWcgQU1EX1BURE1BDQo+PiArICAg
ICB0cmlzdGF0ZSAgIkFNRCBQYXNzdGhydSBETUEgRW5naW5lIg0KPj4gKyAgICAgZGVmYXVsdCBt
DQo+IENhbiB5b3UganVzdGlmeSAiZGVmYXVsdCBtIj8gIE1vc3QgbGlrZWx5IGl0IHNob3VsZCBu
b3QgYmUgaGVyZS4NCkFncmVlIC4gVGhpcyB3aWxsIGJlIHJlc29sdmVkIGluIG5leHQgdmVyc2lv
biBvZiBwYXRjaCBzZXQuDQo+DQo+DQo+PiArICAgICBkZXBlbmRzIG9uIFg4Nl82NCAmJiBQQ0kN
Cj4+ICsgICAgIGhlbHANCj4+ICsgICAgICAgUHJvdmlkZXMgdGhlIHN1cHBvcnQgZm9yIEFNRCBQ
YXNzdGhydSBETUEgZW5naW5lLg0KPg0KPiAtLQ0KPiB+UmFuZHkNCg==
