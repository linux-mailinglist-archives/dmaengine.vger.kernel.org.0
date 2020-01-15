Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7690B13B923
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 06:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgAOFml (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 00:42:41 -0500
Received: from mail-eopbgr770048.outbound.protection.outlook.com ([40.107.77.48]:37093
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgAOFml (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jan 2020 00:42:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsQNvglnRtat2vJQ9k5NrVT4spsgNGFaD7e1CD8qt3fF1LAj/pxrNBI3O26aWmpGV/f+//Y1DY187E/DmkGj6DNFn5cynJWgLGHqyPDADMkwQiRiVjnTEMO6T1Hg4hCVTTiky3OM1kIMq/6hlQvzzYBdZrqu90PqwkjL2BhdHdsMFrGxgDI2XBWcy6UzKOdblx2L5EQOAfbbqU7Nf8J6kax1ujDTmw8xiVa8MzTOuhuzajJvJ9AZrVcQ/7Wc+1HitzBWGpdoJRhLnR7e+Ljc83GHV0pAAVURvNqV7qsEqa9KMUTpiEmgpvoNOCswn0b+p/jN0qvjKCJUiRtegem0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRV1W+jiZ4ZyzAL3/jG1CIKfWeFMg4YBzIk2tPxU0VY=;
 b=mUDMqid61L3EzhWmB3sVJNg+NNNM8L0d9VTUvFU1iVMWJbWmidhMTxJFXjrmMNrQXehamBBxGz+lmtZMjQqH5ev2QTg6V8XTUVZcxoilC+hynF6uC2J53y2SA0cM4P1fyaX61S/fVRLuWmicORKo3y8jFAV6rOh2BSvhIJrvYyJLxj2X8/13UlgizFyb3zH0ET2VLhEE2EjVx1RYgsi3GKeAl39755BasjuF+J0GAxxeURO9S+HIqOq8LBi3PQKdWJrPMxDvif1ZXCB3Sw9N/nuAp0ZwjxZRpTAXhWsfW7CY/HBsb6XYBs6ucmiBxI9X/CuYNEraglHaxa7nSh2tlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRV1W+jiZ4ZyzAL3/jG1CIKfWeFMg4YBzIk2tPxU0VY=;
 b=hAP/FApO3elECF2D+2/5vT+9RNQwgj7QwucwoEHMlFjd6pLG4K8NQ/EchE8fSleVFzcdgO2sD/Vq+UuvzarKzDeXqa8Nl4lCXAUFUo8sAUrZ7xAQ14A6YZBJq7q+GezJvxE8zJ5BvRtDNt05dDaI/VsaBDhjxoCRY6eptpfAAmY=
Received: from BN7PR02MB5121.namprd02.prod.outlook.com (20.176.178.80) by
 BN7PR02MB4034.namprd02.prod.outlook.com (52.132.223.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Wed, 15 Jan 2020 05:41:59 +0000
Received: from BN7PR02MB5121.namprd02.prod.outlook.com
 ([fe80::ac81:30a6:e1df:fda7]) by BN7PR02MB5121.namprd02.prod.outlook.com
 ([fe80::ac81:30a6:e1df:fda7%7]) with mapi id 15.20.2623.017; Wed, 15 Jan 2020
 05:41:59 +0000
From:   Harini Katakam <harinik@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        Matthias Fend <matthias.fend@wolfvision.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Radhey Shyam Pandey <radheys@xilinx.com>
Subject: RE: [PATCH] dmaengine: zynqmp_dma: fix burst length configuration
Thread-Topic: [PATCH] dmaengine: zynqmp_dma: fix burst length configuration
Thread-Index: AQHVx5K2bU2wqJwJJU+7xM+Dn7mi2KfrPF6g
Date:   Wed, 15 Jan 2020 05:41:58 +0000
Message-ID: <BN7PR02MB5121D2FEF76CF4A69BDEA7FFC9370@BN7PR02MB5121.namprd02.prod.outlook.com>
References: <20200110082607.25353-1-matthias.fend@wolfvision.net>
 <137545d8-466d-e2f6-1e3e-8879dcee423d@xilinx.com>
In-Reply-To: <137545d8-466d-e2f6-1e3e-8879dcee423d@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=harinik@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24d1e420-62af-4944-e0d6-08d7997da38c
x-ms-traffictypediagnostic: BN7PR02MB4034:|BN7PR02MB4034:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR02MB4034568E1544722E22A2B48BC9370@BN7PR02MB4034.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(199004)(189003)(71200400001)(66946007)(52536014)(76116006)(2906002)(5660300002)(86362001)(53546011)(66476007)(110136005)(8936002)(6506007)(54906003)(81156014)(81166006)(478600001)(66556008)(186003)(8676002)(26005)(316002)(7696005)(64756008)(33656002)(66446008)(107886003)(55016002)(9686003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB4034;H:BN7PR02MB5121.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HOiCvfd9gkFZKUdenXmojHgT9RSUzlxuXwXKtifUsRffQ6TIbNZeb8BHW5WAswI4AdZsrgJ9XVwlG1PvvcDwPu3CPsjHjz0bTlniM7zwlrLDh38VblYKTGXIC9QRZ2jCTnQyPwdOAMXn3tL15dUVE/iovcYvrQRTs1XipmMmQPByfxwE8GxQAptuLkyQ9/JpK2GQIfcxKcgYgzQ2rveOfOVXK0oHKO0VBpcAs4O3lcG0AqZkOSQmWP1lOEUMY3JnNKsE305cNYW34Yj17qiinBZCXvjAAvKYVBo7T5WgQR/KWZNuPSzUC7YqnDcTQVk2vet32xXGZm8pPT0YxQ8VD9YWU852KUuREDZK+j8hqFzP+KywqkrD6RD9lD3J1agIpc5xbiIrWbzqmDelFBBBaWFDmBgkiDNZBIbpgpQbHvYhJb+uPNr2JDguyTNUyznY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d1e420-62af-4944-e0d6-08d7997da38c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 05:41:58.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVyVzXXgXv94w2+78wLWSJKDG41pcQ9qwYCDHlp+sOGFxzgGEV7mIQ5oTECE3fNkZZ8mKevo6gidNwfTXclKyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4034
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlj
aGFsIFNpbWVrIFttYWlsdG86bWljaGFsLnNpbWVrQHhpbGlueC5jb21dDQo+IFNlbnQ6IEZyaWRh
eSwgSmFudWFyeSAxMCwgMjAyMCAyOjE4IFBNDQo+IFRvOiBNYXR0aGlhcyBGZW5kIDxtYXR0aGlh
cy5mZW5kQHdvbGZ2aXNpb24ubmV0PjsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgTWljaGFsIFNpbWVrIDxt
aWNoYWxzQHhpbGlueC5jb20+Ow0KPiB2a291bEBrZXJuZWwub3JnOyBSYWRoZXkgU2h5YW0gUGFu
ZGV5IDxyYWRoZXlzQHhpbGlueC5jb20+OyBIYXJpbmkNCj4gS2F0YWthbSA8aGFyaW5pa0B4aWxp
bnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkbWFlbmdpbmU6IHp5bnFtcF9kbWE6IGZp
eCBidXJzdCBsZW5ndGggY29uZmlndXJhdGlvbg0KPiANCj4gK1JhZGhleSBhbmQgSGFyaW5pDQo+
IA0KPiBPbiAxMC4gMDEuIDIwIDk6MjYsIE1hdHRoaWFzIEZlbmQgd3JvdGU6DQo+ID4gU2luY2Ug
dGhlIGRtYSBlbmdpbmUgZXhwZWN0cyB0aGUgYnVyc3QgbGVuZ3RoIHJlZ2lzdGVyIGNvbnRlbnQg
YXMNCj4gPiBwb3dlciBvZiAyIHZhbHVlLCB0aGUgYnVyc3QgbGVuZ3RoIG5lZWRzIHRvIGJlIGNv
bnZlcnRlZCBmaXJzdC4NCj4gPiBBZGRpdGlvbmFsbHkgYWRkIGEgYnVyc3QgbGVuZ3RoIHJhbmdl
IGNoZWNrIHRvIGF2b2lkIGNvcnJ1cHRpbmcNCj4gPiB1bnJlbGF0ZWQgcmVnaXN0ZXIgYml0cy4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHRoaWFzIEZlbmQgPG1hdHRoaWFzLmZlbmRAd29s
ZnZpc2lvbi5uZXQ+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZG1hL3hpbGlueC96eW5xbXBfZG1h
LmMgfCAyNCArKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9kbWEveGlsaW54L3p5bnFtcF9kbWEuYw0KPiA+IGIvZHJpdmVycy9kbWEveGlsaW54L3p5
bnFtcF9kbWEuYyBpbmRleCA5Yzg0NWMwN2IxMDcuLmFhNGRlNmM2Njg4YQ0KPiA+IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZG1hL3hpbGlueC96eW5xbXBfZG1hLmMNCj4gPiArKysgYi9kcml2
ZXJzL2RtYS94aWxpbngvenlucW1wX2RtYS5jDQo+ID4gQEAgLTEyMywxMCArMTIzLDEyIEBADQo+
ID4gIC8qIE1heCB0cmFuc2ZlciBzaXplIHBlciBkZXNjcmlwdG9yICovDQo+ID4gICNkZWZpbmUg
WllOUU1QX0RNQV9NQVhfVFJBTlNfTEVOCTB4NDAwMDAwMDANCj4gPg0KPiA+ICsvKiBNYXggYnVy
c3QgbGVuZ3RocyAqLw0KPiA+ICsjZGVmaW5lIFpZTlFNUF9ETUFfTUFYX0RTVF9CVVJTVF9MRU4g
ICAgMTYNCj4gPiArI2RlZmluZSBaWU5RTVBfRE1BX01BWF9TUkNfQlVSU1RfTEVOICAgIDE2DQo+
ID4gKw0KPiA+ICAvKiBSZXNldCB2YWx1ZXMgZm9yIGRhdGEgYXR0cmlidXRlcyAqLw0KPiA+ICAj
ZGVmaW5lIFpZTlFNUF9ETUFfQVhDQUNIRV9WQUwJCTB4Rg0KPiA+IC0jZGVmaW5lIFpZTlFNUF9E
TUFfQVJMRU5fUlNUX1ZBTAkweEYNCj4gPiAtI2RlZmluZSBaWU5RTVBfRE1BX0FXTEVOX1JTVF9W
QUwJMHhGDQo8c25pcD4NCj4gPiBAQCAtODg3LDggKzg5Myw4IEBAIHN0YXRpYyBpbnQgenlucW1w
X2RtYV9jaGFuX3Byb2JlKHN0cnVjdA0KPiB6eW5xbXBfZG1hX2RldmljZSAqemRldiwNCj4gPiAg
CQlyZXR1cm4gUFRSX0VSUihjaGFuLT5yZWdzKTsNCj4gPg0KPiA+ICAJY2hhbi0+YnVzX3dpZHRo
ID0gWllOUU1QX0RNQV9CVVNfV0lEVEhfNjQ7DQo+ID4gLQljaGFuLT5kc3RfYnVyc3RfbGVuID0g
WllOUU1QX0RNQV9BV0xFTl9SU1RfVkFMOw0KPiA+IC0JY2hhbi0+c3JjX2J1cnN0X2xlbiA9IFpZ
TlFNUF9ETUFfQVJMRU5fUlNUX1ZBTDsNCj4gPiArCWNoYW4tPmRzdF9idXJzdF9sZW4gPSBaWU5R
TVBfRE1BX01BWF9EU1RfQlVSU1RfTEVOOw0KPiA+ICsJY2hhbi0+c3JjX2J1cnN0X2xlbiA9IFpZ
TlFNUF9ETUFfTUFYX1NSQ19CVVJTVF9MRU47DQo+ID4gIAllcnIgPSBvZl9wcm9wZXJ0eV9yZWFk
X3UzMihub2RlLCAieGxueCxidXMtd2lkdGgiLCAmY2hhbi0NCj4gPmJ1c193aWR0aCk7DQoNCkp1
c3QgYSBub3RlIHRoYXQgdGhpcyBjaGFuZ2VzIHRoZSByZXNldCB2YWx1ZSBvZiB0aGlzIGZpZWxk
ICBmcm9tIDB4RiAoYWNjIHRvIHRoZSBzcGVjKSB0byAweDQuDQpJdCBtYXkgbmVlZCB0byBiZSB1
cGRhdGVkIGZvciBmdXR1cmUgSVAgdmVyc2lvbnMsIGlmIGFueSwgYnV0IEkgdGhpbmsgaXQgbWFr
ZXMgc2Vuc2UgZm9yIG5vdy4NClRoYW5rcy4NClJldmlld2VkLWJ5OiBIYXJpbmkgS2F0YWthbSA8
aGFyaW5pLmthdGFrYW1AeGlsaW54LmNvbT4NCg0KUmVnYXJkcywNCkhhcmluaQ0K
