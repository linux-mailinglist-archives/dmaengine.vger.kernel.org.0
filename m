Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815E41F37AA
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2020 12:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgFIKK4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jun 2020 06:10:56 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:51679
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbgFIKKz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Jun 2020 06:10:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2G1THQLh4pVb2o6066X0SAl4vi/OAVSGIe2ICkTjwQV+VXHcp7EVwzToFTdFw53bv9EoRH80Bchf9k4cbqxlLzQy8gZLbr+WcxPDXX4Mg9xJjSQ4k6b3q7NglUUgkoIjqZLMFVFbdChud/R7aHFyKcx0V5iTAeGCic9gckmpkOkd5W7n7PBUoVAK7EL910z/4boZ0kH3zAVGUq8YNRQqfOTNYALNXW6aSSdHZAOG3NADtJVFyIgh5L0XA4mlRcuNDCJ4ny5tAVpTOFiqu+8eV/F+JOAyMIKI9z7f87pDBR11/2xeGa3KCgI+XEXvABePAdFqh8U2HOX5UfSLHST8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSGNTfCiTWhQa2GVPp0vAi0AnCFRCFK/kvfJhrciEX8=;
 b=hq93VmZmhhIrpRypduLI7EKuA+f0uKXxCwu0qT9a73qN4FM2gGY5Un9O+fxl4+2qZvUIv0ih6/0OpD66KcWt3UkAvVPnqIZ9TRjlv57yhq0bWLDA3Tc1g2uT1ovy31DYaDkHZZV9KSQDZ8B53on2IvlWieegk9IFtLyvAmU1ibAq0UI6LTIuH7zw1qi6gDAFll9xwLW1JnUUD9j6ZphieB4/ceKBuQH9nxOtKl/2UrpqIP+jS63ZU3940rSDQo1Vl6Q0DxPBbnwJPZL2lmf2BYBMmIXwt/HgtmXBQOamxIXDZB2m3rTMYqNWzipZyNeepKkY/+Dmq4Y4Bb1CkiW1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSGNTfCiTWhQa2GVPp0vAi0AnCFRCFK/kvfJhrciEX8=;
 b=L2Ni22/Jnv2mr+XdxdHUAVgD5RW4x4U2AcvBH/xSODDl/L8TRQ95FCu5KAMq4cCo2b/S8tBTFt7xnK93TSSiTJQYYpz/dFK3bWOg9CuXAAOARE3C8gV6sC7UobfJLDJuvcRqQH+IDkfOvIXE9liKBCm8JRsi2UaR3c8T+QmH6QA=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6381.eurprd04.prod.outlook.com (2603:10a6:803:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Tue, 9 Jun
 2020 10:10:47 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 10:10:47 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v9 RESEND 01/13] spi: imx: add dma_sync_sg_for_device
 after fallback from dma
Thread-Topic: [PATCH v9 RESEND 01/13] spi: imx: add dma_sync_sg_for_device
 after fallback from dma
Thread-Index: AQHWPBYcMy4ZpJEEjkym0JBjSJknZajOy8sAgAABToCAAA6IgIAAFFCAgACn/7CAAHmEgIAAASqw
Date:   Tue, 9 Jun 2020 10:10:47 +0000
Message-ID: <VE1PR04MB663812B887A6D8DDCE75399B89820@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
 <1591485677-20533-2-git-send-email-yibin.gong@nxp.com>
 <20200608143458.GH4593@sirena.org.uk>
 <VE1PR04MB66388F89015F774EE3FFF69D89850@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200608153139.GI4593@sirena.org.uk>
 <59ce3620-00b9-bac1-30e1-011a29583642@arm.com>
 <VE1PR04MB6638B1EC49D295C64292B7BD89820@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <bcfc3637-65af-577a-ddbd-890b6c83a6e6@arm.com>
In-Reply-To: <bcfc3637-65af-577a-ddbd-890b6c83a6e6@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [101.224.33.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14abfe5a-99a8-4d03-abba-08d80c5d6113
x-ms-traffictypediagnostic: VE1PR04MB6381:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB63814D75066B6743393EF09289820@VE1PR04MB6381.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YcFK6y5UHwkvpiiUBT50qAPBFydJtiQ0rxfHFI0DPjTKykAAVs2vGXa2C95X2xCWrKEnSuUngxfYTym45z2QVs1JL94r9iKomhIHKtDPDHO+YeX2WdFhzkGoRMvPvFPS+zo6CrZi+uoZBCN4/Ks8rh1vUvCXNs09xRAHXPpDW6k6ye4oB/HHNq+Z/u8QQ4rkP/A4jDuQltbBx/opoQIrxYQhVr/7R0NOIL2r5J4RID99AzG5iAt7ex/l3l+xquCOcU74eeGOg94aNAmBrk85iNSk4zmWpK/7/s4cZoWVrWTSDMmKQdTQOzQ4+yyeUHsCJTQKG9eK3MBb4uO5XvuMnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(26005)(186003)(7416002)(52536014)(8676002)(8936002)(4326008)(83380400001)(478600001)(86362001)(66556008)(71200400001)(5660300002)(9686003)(76116006)(110136005)(54906003)(316002)(7696005)(33656002)(53546011)(6506007)(2906002)(66946007)(66446008)(66476007)(64756008)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 95JuDsLEkvjLI4wvtIJU80R/BHJhM4NZ4B18Rvxi39hsYD5EAHotX/N3apXHt7jCGCw6ok39GNji1XoYZxODNEBu+R0zurJn/UXnkimOcRyFAWiEs5MLpf1bB6bsXsCaE1n3OppLicQ3H6xl+7/dv6yq0GymmSySnftA4xIbhnsHO3r0hDPOi5/GIE6IBg59ywbfm2jTwlkJFlPw8hopBLt2UPvgiKJ2vCii6GxY/trndTQLXlk4aT3IuWDFrxYFNc0GPcNq9hBPWNDE5L42/VDZSkVi9VLhsfllJ14fPWn6Kp7FlyYPb/1MO9i6x2IktZJdxMKicS9VFeSyxMC5a5AqxzLdD6NIyam1t5HrJrs+aOhzxjgmBv+Ja19Kqv1wRd4UuHk5QmDYe2FpXQW8sVQ/5c0iGCBvpljyzzzuKOyMgRKN5bhUGb1wVP7dtKPiVJSILX/Kvz3ETjuHf4DpdJnb1793wE5XYGlFnjN3sqQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14abfe5a-99a8-4d03-abba-08d80c5d6113
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 10:10:47.1557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2y48SDOenvVl8pwttcut9c722kV3kvVPVaBoOuy/C5fEJq1/GHZVOfHMDsSnz+qgT5BI8DSv/9UEW8g9Qd1ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6381
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAyMC8wNi8wOSBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPiB3cm90ZTog
DQo+IE9uIDIwMjAtMDYtMDkgMDY6MjEsIFJvYmluIEdvbmcgd3JvdGU6DQo+ID4gT24gMjAyMC8w
Ni8wOSAwOjQ0IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+IHdyb3RlOg0KPiA+
PiBPbiAyMDIwLTA2LTA4IDE2OjMxLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+Pj4gT24gTW9uLCBK
dW4gMDgsIDIwMjAgYXQgMDM6MDg6NDVQTSArMDAwMCwgUm9iaW4gR29uZyB3cm90ZToNCj4gPj4+
DQo+ID4+Pj4+PiArCWlmICh0cmFuc2Zlci0+cnhfc2cuc2dsKSB7DQo+ID4+Pj4+PiArCQlzdHJ1
Y3QgZGV2aWNlICpyeF9kZXYgPSBzcGktPmNvbnRyb2xsZXItPmRtYV9yeC0+ZGV2aWNlLT5kZXY7
DQo+ID4+Pj4+PiArDQo+ID4+Pj4+PiArCQlkbWFfc3luY19zZ19mb3JfZGV2aWNlKHJ4X2Rldiwg
dHJhbnNmZXItPnJ4X3NnLnNnbCwNCj4gPj4+Pj4+ICsJCQkJICAgICAgIHRyYW5zZmVyLT5yeF9z
Zy5uZW50cywgRE1BX1RPX0RFVklDRSk7DQo+ID4+Pj4+PiArCX0NCj4gPj4+Pj4+ICsNCj4gPj4+
DQo+ID4+Pj4+IFRoaXMgaXMgY29uZnVzaW5nIC0gd2h5IGFyZSB3ZSBETUEgbWFwcGluZyB0byB0
aGUgZGV2aWNlIGFmdGVyDQo+ID4+Pj4+IGRvaW5nIGEgUElPIHRyYW5zZmVyPw0KPiA+Pj4NCj4g
Pj4+PiAndHJhbnNmZXItPnJ4X3NnLnNnbCcgY29uZGl0aW9uIGNoZWNrIHRoYXQncyB0aGUgY2Fz
ZSBmYWxsYmFjayBQSU8NCj4gPj4+PiBhZnRlciBETUEgdHJhbnNmZXIgZmFpbGVkLiBCdXQgdGhl
IHNwaSBjb3JlIHN0aWxsIHRoaW5rIHRoZSBidWZmZXINCj4gPj4+PiBzaG91bGQgYmUgaW4gJ2Rl
dmljZScgd2hpbGUgc3BpIGRyaXZlciB0b3VjaCBpdCBieSBQSU8oQ1BVKSwgc28NCj4gPj4+PiBz
eW5jIGl0IGJhY2sgdG8NCj4gPj4gZGV2aWNlIHRvIGVuc3VyZSBhbGwgcmVjZWl2ZWQgZGF0YSBm
bHVzaCB0byBERFIuDQo+ID4+Pg0KPiA+Pj4gU28gd2Ugc3luYyBpdCBiYWNrIHRvIHRoZSBkZXZp
Y2Ugc28gdGhhdCB3ZSBjYW4gdGhlbiBkbyBhbm90aGVyIHN5bmMNCj4gPj4+IHRvIENQVT8gIFRC
SCBJJ20gYSBiaXQgc3VycHJpc2VkIHRoYXQgdGhlcmUncyBhIHJlcXVpcmVtZW50IHRoYXQgd2UN
Cj4gPj4+IGV4cGxpY2l0bHkgdW5kbyBhIHN5bmMgYW5kIHRoYXQgYSByZWR1bmRhbnQgZG91Ymxl
IHN5bmMgaW4gdGhlIHNhbWUNCj4gPj4+IGRpcmVjdGlvbiBtaWdodCBiZSBhbiBpc3N1ZSBidXQg
SSd2ZSBub3QgaGFkIGEgbmVlZCB0byBjYXJlIHNvIEknbQ0KPiA+Pj4gcGVyZmVjdGx5IHByZXBh
cmVkIHRvIGJlbGlldmUgdGhlcmUgaXMuDQo+ID4+Pg0KPiA+Pj4gQXQgdGhlIHZlcnkgbGVhc3Qg
dGhpcyBuZWVkcyBhIGNvbW1lbnQuDQo+ID4+DQo+ID4+IFllYWgsIHNvbWV0aGluZydzIG9mZiBo
ZXJlIC0gYXQgdGhlIHZlcnkgbGVhc3QsIHN5bmNpbmcgd2l0aA0KPiA+PiBETUFfVE9fREVWSUNF
IG9uIHRoZSBSeCBidWZmZXIgdGhhdCB3YXMgbWFwcGVkIHdpdGgNCj4gRE1BX0ZST01fREVWSUNF
IGlzIGNsZWFybHkgd3JvbmcuDQo+ID4+IENPTkZJR19ETUFfQVBJX0RFQlVHIHNob3VsZCBzY3Jl
YW0gYWJvdXQgdGhhdC4NCj4gPj4NCj4gPj4gSWYgdGhlIGRldmljZSBoYXMgd3JpdHRlbiB0byB0
aGUgYnVmZmVyIGF0IGFsbCBzaW5jZSBkbWFfbWFwX3NnKCkgd2FzDQo+ID4+IGNhbGxlZCB0aGVu
IHlvdSBkbyBuZWVkIGEgZG1hX3N5bmNfc2dfZm9yX2NwdSgpIGNhbGwgYmVmb3JlIHRvdWNoaW5n
DQo+ID4+IGl0IGZyb20gYSBDUFUgZmFsbGJhY2sgcGF0aCwgYnV0IGlmIG5vYm9keSdzIGdvaW5n
IHRvIHRvdWNoIGl0IGZyb20NCj4gPj4gdGhhdCBwb2ludCB1bnRpbCBpdCdzIHVubWFwcGVkIHRo
ZW4gdGhlcmUncyBubyBwb2ludCBzeW5jaW5nIGl0DQo+ID4+IGFnYWluLiBUaGUNCj4gPj4gbXlf
Y2FyZF9pbnRlcnJ1cHRfaGFuZGxlcigpIGV4YW1wbGUgaW4gRE1BLUFQSV9IT1dUTy50eHQNCj4g
ZGVtb25zdHJhdGVzDQo+ID4+IHRoaXMuDQo+ID4gVGhhbmtzIGZvciB5b3UgcG9zdCwgYnV0IHNv
cnJ5LCB0aGF0J3Mgbm90IHNwaS1pbXggY2FzZSBub3csIGJlY2F1c2UgdGhlIHJ4DQo+IGRhdGEg
aW4gZGV2aWNlIG1lbW9yeSBpcyBub3QgdHJ1bHkgdXBkYXRlZCBmcm9tICdkZXZpY2UnL0RNQSwg
YnV0IGZyb20gUElPLA0KPiBzbyB0aGF0IGRtYV9zeW5jX3NnX2Zvcl9jcHUgd2l0aCBETUFfRlJP
TV9ERVZJQ0UgY2FuJ3QgYmUgdXNlZCwNCj4gb3RoZXJ3aXNlIHRoZSBmcmVzaCBkYXRhIGluIGNh
Y2hlIHdpbGwgYmUgaW52YWxpZGF0ZWQuDQo+ID4gQnV0IHlvdSdyZSByaWdodCwga2VybmVsIHdh
cm5pbmcgY29tZXMgb3V0IGlmIENPTkZJR19ETUFfQVBJX0RFQlVHDQo+IGVuYWJsZWQuLi4NCj4g
DQo+IEFoLCBJIHRoaW5rIEkgdW5kZXJzdGFuZCB3aGF0J3MgZ29pbmcgb24gbm93LiBUaGF0J3Mu
Li4gcmVhbGx5IHVnbHkgOigNClllYWguLi5UaGUgb25seSByZWFzb24gaXMgdG8gYXZvaWQgdG91
Y2ggYW55IHNwaSBjb3JlIGNvZGUuLi5JJ20gdHJ5aW5nIHRvIGltcGxlbWVudCBmYWxsYmFjayBh
dCBzcGkgY29yZSBzbyB0aGF0IGNhbiBzcGlfdW5tYXBfYnVmIGRpcmVjdGx5IGlmIGRtYSB0cmFu
c2ZlciBlcnJvciBhbmQgbm8gbmVlZA0Kc3VjaCBkbWFfc3luY18qIGluIHNwaSBjbGllbnQgZHJp
dmVyLiBOb3Qgc3VyZSBpZiBNYXJrIGNvdWxkIGFjY2VwdCBpdC4gVGhhbmtzIGZvciB5b3VyIGJl
bG93IGdyZWF0IHRob3VnaHRzIDopIA0KPiANCj4gTG9va2luZyBhdCB0aGUgU1BJIGNvcmUgY29k
ZSwgSSB0aGluayBhIGJldHRlciB3YXkgdG8gaGFuZGxlIHRoaXMgd291bGQgYmUgdG8NCj4gaGF2
ZSB5b3VyIGZhbGxiYWNrIHBhdGggY2FsbCBzcGlfdW5tYXBfYnVmKCkgZGlyZWN0bHkgKG9yIHBl
cmZvcm0gdGhlIHNhbWUNCj4gYWN0aW9ucywgaWYgZXhwb3J0aW5nIHRoYXQgdG8gZHJpdmVycyBp
cyB1bmFjY2VwdGFibGUpLCB0aGVuIG1ha2Ugc3VyZQ0KPiAtPmNhbl9kbWEoKSByZXR1cm5zIGZh
bHNlIGFmdGVyIHRoYXQgc3VjaCB0aGF0IHNwaV91bm1hcF9tc2coKSB3b24ndCB0cnkgdG8NCj4g
dW5tYXAgaXQgYWdhaW4uIFRoYXQncyBhIGxvdCBtb3JlIHJlYXNvbmFibGUgdGhhbiB0cnlpbmcg
dG8gZmFrZSB1cCBhDQo+IERNQV9UT19ERVZJQ0UgdHJhbnNmZXIgaW4gdGhlIG1pZGRsZSBvZiBh
IERNQV9GUk9NX0RFVklDRSBvcGVyYXRpb24gb24NCj4gdGhlIHNhbWUgYnVmZmVyLg0KPiANCj4g
QWx0ZXJuYXRpdmVseSwgaXMgaXQgZmVhc2libGUgdG8gaW5pdGlhdGUgYSBkdW1teSBETUEgcmVx
dWVzdCBkdXJpbmcgcHJvYmUsIHN1Y2gNCj4gdGhhdCB5b3UgY2FuIGRldGVjdCB0aGUgZmFpbHVy
ZSBjb25kaXRpb24gYW5kIGdpdmUgdXAgb24gdGhlIERNQSBjaGFubmVsIGVhcmx5LA0KPiBhbmQg
bm90IGhhdmUgdG8gZGVhbCB3aXRoIGl0IGR1cmluZyBhIHJlYWwgU1BJIHRyYW5zZmVyPw0KPiAN
Cj4gUm9iaW4uDQo=
