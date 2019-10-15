Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C4D6FDF
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfJOHG0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 03:06:26 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:15660 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbfJOHG0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Oct 2019 03:06:26 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9F73T3u013442;
        Tue, 15 Oct 2019 03:05:53 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2050.outbound.protection.outlook.com [104.47.44.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vk8kaadwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Oct 2019 03:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MToZgZepgHDSWBTA4FWWiTWdG3XbVEGmXkFFdXdt7/R4KCYNm/j8U/EtZpdGFTBdcP0gBhcTopG0Mn6CcbPZFyvXpj+k35+xNCMyJPk+1/a9sxikcZzsEOgKafMRs+VBHxJBTOk/rVjsfGuuWWzp9ZWTg5OAu3WqVwoHoCjPEhlM7YAGnEsdr19RRdpTplicBp/BoffrdJSJ9DBYiGDauyQoZcXR/Ub5H6Eq4m9oMMkFDvoC3u55AezPkhQgnnEnBY1wSy0Dsz6ZPnzfq9p8uaS1AOlyo04Ls+VFdfbm8uCv0Xd35mfl9qVBr6hBHhlDS2F8NfLn7ZAy/eKSq+081A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CAqMz3kVtzWI6cpIJ829CuwphijtIpON1XMSixPWsY=;
 b=SAMjdJXI1Df/wv00UW6V1QalEGWKzGGE3qWErIjZUoU+rBnUFdqzm7oReDruAYLGJkHjOiTgCM004R93963ZfZAjYRYBlICSEmpXbhZdAfBaBaVYdVKIJ21gEXIClGGAEonlmcc1cdapuMwxdUlJMkAl7IXk8GM+C6ZJhIrV7OINw9rj3EBJdu1mrtnpYtefHTHLtDcEm6oWuQdlNOAFNrpdEPwRImXOq3AlaVMXsZRRBUrUY7zmxzIzCAtf9s6YJwRxBUkCnZtW9h1qsylR60iTdvRyr9mitwdMPLyvJ2tazfJ3hn/4I/AXkEyytqJbbZG3K+xtAzIo5i4P5egZuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CAqMz3kVtzWI6cpIJ829CuwphijtIpON1XMSixPWsY=;
 b=rzD944vplVJP1sMenfzCsGiXEgr2Yivo1Bmk3hieH1+RJIdh8bA/JpL6wldQ7lv3WlXOjbzh8Xgl9hHAQqRYxQFLPxu9kRM+v/+clTPszDb9GbJH8RJbExiked1EObw8s5vOT4iujGEjQZqF0mTwUnhKEFWfrKmQQEtQp8P5GdU=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5270.namprd03.prod.outlook.com (20.180.13.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Tue, 15 Oct 2019 07:05:52 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 07:05:52 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "alencar.fmce@imbel.gov.br" <alencar.fmce@imbel.gov.br>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] dmaengine: axi-dmac: simple device_config operation
 implemented
Thread-Topic: [PATCH] dmaengine: axi-dmac: simple device_config operation
 implemented
Thread-Index: AQHVgl1XDQuPzs7EEUSctiEEmydhCKdbSU+A
Date:   Tue, 15 Oct 2019 07:05:52 +0000
Message-ID: <4384347cc94a54e3fa22790aaa91375afda54e1b.camel@analog.com>
References: <20190913145404.28715-1-alexandru.ardelean@analog.com>
         <20191014070142.GB2654@vkoul-mobl>
In-Reply-To: <20191014070142.GB2654@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55ed741b-4b8e-450b-3714-08d7513e1daa
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR03MB5270:
x-microsoft-antispam-prvs: <CH2PR03MB527005DFB57F6168B16C3744F9930@CH2PR03MB5270.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(136003)(396003)(199004)(189003)(476003)(25786009)(118296001)(36756003)(99286004)(6116002)(54906003)(3846002)(66066001)(76176011)(6916009)(11346002)(446003)(2906002)(2616005)(486006)(6436002)(5640700003)(7736002)(6512007)(305945005)(4001150100001)(6246003)(26005)(186003)(4326008)(14454004)(229853002)(102836004)(14444005)(64756008)(2501003)(256004)(6486002)(5660300002)(2351001)(86362001)(478600001)(6506007)(53546011)(71200400001)(71190400001)(81166006)(66476007)(66556008)(66446008)(76116006)(8936002)(8676002)(1730700003)(81156014)(66946007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5270;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i1444iOUoIuFFLIFcNMwj4cjbBkTAsLvKiZfdu6LVs+TGW5dcDqTVc9x8qFfKK/jJCQIyUxgw+rrUAor+c2O7Rbp+VbivrpDOkzIforfyT3l9PsPsM+fC8fpaUY6kMLg3MsCGIjRZWpSzx8KPsxTpgKtRbJeVzSVj22Yii43QZnyffK4EOK7Y+c5+RmpZS05SbRhFDFJqSjJ0M7o2M/c9wkHBsCrkkFOjCIV3u3ebgCCM2gLi068S6amEkw/Zatu1tIFFO2uZW/ahIY0UHvza+dQF8pLQHOAEILBOPsJQ8GMqaUPKPrpT8GNo7AXsm3K25j+xdQD+hqOrrFK8p7k2Iw4t/oXpusvahoAAcUZzuPJWr1ePybuWoJ08x6j+FEDGQNw5urrVrzFr4dG4g8uK53DKP8XVRCO8dUgAfS2v00=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3500B076EFABFD458CA5BC0B90123BD7@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ed741b-4b8e-450b-3714-08d7513e1daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 07:05:52.1929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4h3g1gJmK4g9/+0lrEBmLjDB1z8UENfmkdaLTSPrmFb/8n0KK1yf01/LrXSEv7BGwpHu1FezIsnw7R9G7N36g/GZ+NYYLpRy6J+pjc9Th1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5270
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-15_03:2019-10-11,2019-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910150063
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDE5LTEwLTE0IGF0IDEyOjMxICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KDQpIZXksDQoNCj4gT24gMTMtMDktMTksIDE3OjU0LCBBbGV4YW5kcnUg
QXJkZWxlYW4gd3JvdGU6DQo+ID4gRnJvbTogUm9kcmlnbyBBbGVuY2FyIDxhbGVuY2FyLmZtY2VA
aW1iZWwuZ292LmJyPg0KPiA+IA0KPiA+IGRtYWVuZ2luZV9zbGF2ZV9jb25maWcgaXMgY2FsbGVk
IGJ5IGRtYWVuZ2luZV9wY21faHdfcGFyYW1zIHdoZW4gdXNpbmcNCj4gPiBheGktaTJzIHdpdGgg
YXhpLWRtYWMuIElmIGRldmljZV9jb25maWcgaXMgTlVMTCwgLUVOT1NZUyAgaXMgcmV0dXJuZWQs
DQo+ID4gd2hpY2ggYnJlYWtzIHRoZSBzbmRfcGNtX2h3X3BhcmFtcyBmdW5jdGlvbi4NCj4gPiBU
aGlzIGlzIGEgZml4IGZvciB0aGUgZXJyb3I6DQo+IA0KPiBhbmQgd2hhdCBpcyB0aGF0Pw0KPiAN
Cj4gPiAkIGFwbGF5IC1EIHBsdWdodzpBREFVMTc2MSAvdXNyL3NoYXJlL3NvdW5kcy9hbHNhL0Zy
b250X0NlbnRlci53YXYNCj4gPiBQbGF5aW5nIFdBVkUgJy91c3Ivc2hhcmUvc291bmRzL2Fsc2Ev
RnJvbnRfQ2VudGVyLndhdicgOiBTaWduZWQgMTYgYml0DQo+ID4gTGl0dGxlIEVuZGlhbiwgUmF0
ZSA0ODAwMCBIeiwgTW9ubw0KPiA+IGF4aS1pMnMgNDNjMjAwMDAuYXhpLWkyczogQVNvQzogNDNj
MjAwMDAuYXhpLWkycyBodyBwYXJhbXMgZmFpbGVkOiAtMzgNCg0KRXJyb3IgaXMgYWJvdmUgdGhp
cyBsaW5lIFtjb2RlIC0zOF0uDQoNCj4gPiBhcGxheTogc2V0X3BhcmFtczoxNDAzOiBVbmFibGUg
dG8gaW5zdGFsbCBodyBwYXJhbXM6DQo+ID4gQUNDRVNTOiAgUldfSU5URVJMRUFWRUQNCj4gPiBG
T1JNQVQ6ICBTMTZfTEUNCj4gPiBTVUJGT1JNQVQ6ICBTVEQNCj4gPiBTQU1QTEVfQklUUzogMTYN
Cj4gPiBGUkFNRV9CSVRTOiAxNg0KPiA+IENIQU5ORUxTOiAxDQo+ID4gUkFURTogNDgwMDANCj4g
PiBQRVJJT0RfVElNRTogMTI1MDAwDQo+ID4gUEVSSU9EX1NJWkU6IDYwMDANCj4gPiBQRVJJT0Rf
QllURVM6IDEyMDAwDQo+ID4gUEVSSU9EUzogNA0KPiA+IEJVRkZFUl9USU1FOiA1MDAwMDANCj4g
PiBCVUZGRVJfU0laRTogMjQwMDANCj4gPiBCVUZGRVJfQllURVM6IDQ4MDAwDQo+ID4gVElDS19U
SU1FOiAwDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUm9kcmlnbyBBbGVuY2FyIDxhbGVuY2Fy
LmZtY2VAaW1iZWwuZ292LmJyPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVh
biA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gDQo+ID4gTm90
ZTogRml4ZXMgdGFnIG5vdCBhZGRlZCBpbnRlbnRpb25hbGx5Lg0KPiA+IA0KPiA+ICBkcml2ZXJz
L2RtYS9kbWEtYXhpLWRtYWMuYyB8IDE2ICsrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9k
bWEvZG1hLWF4aS1kbWFjLmMgYi9kcml2ZXJzL2RtYS9kbWEtYXhpLWRtYWMuYw0KPiA+IGluZGV4
IGEwZWU0MDRiNzM2ZS4uYWIyNjc3MzQzMjAyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZG1h
L2RtYS1heGktZG1hYy5jDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvZG1hLWF4aS1kbWFjLmMNCj4g
PiBAQCAtNTY0LDYgKzU2NCwyMSBAQCBzdGF0aWMgc3RydWN0IGRtYV9hc3luY190eF9kZXNjcmlw
dG9yDQo+ID4gKmF4aV9kbWFjX3ByZXBfc2xhdmVfc2coDQo+ID4gIAlyZXR1cm4gdmNoYW5fdHhf
cHJlcCgmY2hhbi0+dmNoYW4sICZkZXNjLT52ZGVzYywgZmxhZ3MpOw0KPiA+ICB9DQo+ID4gIA0K
PiA+ICtzdGF0aWMgaW50IGF4aV9kbWFjX2RldmljZV9jb25maWcoc3RydWN0IGRtYV9jaGFuICpj
LA0KPiA+ICsJCQlzdHJ1Y3QgZG1hX3NsYXZlX2NvbmZpZyAqc2xhdmVfY29uZmlnKQ0KPiA+ICt7
DQo+ID4gKwlzdHJ1Y3QgYXhpX2RtYWNfY2hhbiAqY2hhbiA9IHRvX2F4aV9kbWFjX2NoYW4oYyk7
DQo+ID4gKwlzdHJ1Y3QgYXhpX2RtYWMgKmRtYWMgPSBjaGFuX3RvX2F4aV9kbWFjKGNoYW4pOw0K
PiA+ICsNCj4gPiArCS8qIG5vIGNvbmZpZ3VyYXRpb24gcmVxdWlyZWQsIGEgc2FuaXR5IGNoZWNr
IGlzIGRvbmUgaW5zdGVhZCAqLw0KPiA+ICsJaWYgKHNsYXZlX2NvbmZpZy0+ZGlyZWN0aW9uICE9
IGNoYW4tPmRpcmVjdGlvbikgew0KPiANCj4gIHNsYXZlX2NvbmZpZy0+ZGlyZWN0aW9uIGlzIGEg
ZGVwcmVjYXRlZCBmaWVsZCwgcGxzIGRvbnQgdXNlIHRoYXQNCg0KYWNrDQphbnkgYWx0ZXJuYXRp
dmUgcmVjb21tZW5kYXRpb25zIG9mIHdoYXQgdG8gZG8gaW4gdGhpcyBjYXNlPw0KaSBjYW4gdGFr
ZSBhIGxvb2ssIGJ1dCBpZiB5b3UgaGF2ZSBzb21ldGhpbmcgb24tdGhlLXRvcC1vZi15b3VyLWhl
YWQsIGknbQ0Kb3BlbiB0byBzdWdnZXN0aW9ucw0Kd2UgY2FuIGFsc28ganVzdCBkcm9wIHRoaXMg
Y29tcGxldGVseSBhbmQgbGV0IHVzZXJzcGFjZSBmYWlsDQoNCj4gDQo+ID4gKwkJZGV2X2Vycihk
bWFjLT5kbWFfZGV2LmRldiwgIkRpcmVjdGlvbiBub3Qgc3VwcG9ydGVkIGJ5IHRoaXMNCj4gPiBE
TUEgQ2hhbm5lbCIpOw0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gU28geW91IGludGVu
dCB0byBzdXBwb3J0IHNsYXZlIGRtYSBidXQgZG8gbm90IHVzZSBkbWFfc2xhdmVfY29uZmlnLi4g
aG93DQo+IGFyZSB5b3UgZ2V0dGluZyB0aGUgc2xhdmUgYWRkcmVzcyBhbmQgb3RoZXIgZGV0YWls
cz8NCg0KVGhpcyBETUEgY29udHJvbGxlciBpcyBhIGJpdCBzcGVjaWFsLg0KSXQgZ2V0cyBzeW50
aGVzaXplZCBpbiBGUEdBLCBzbyB0aGUgY29uZmlndXJhdGlvbiBpcyBmaXhlZCBhbmQgY2Fubm90
IGJlDQpjaGFuZ2VkIGF0IHJ1bnRpbWUuIE1heWJlIGxhdGVyIHdlIHdvdWxkIGFsbG93L2ltcGxl
bWVudCB0aGlzDQpmdW5jdGlvbmFsaXR5LCBidXQgdGhpcyBpcyBhIHF1ZXN0aW9uIGZvciBteSBI
REwgY29sbGVhZ3Vlcy4NCg0KVHdvIHRoaW5ncyBhcmUgZG9uZSAoaW4gdGhpcyBvcmRlcik6DQox
LiBGb3Igc29tZSBwYXJhbXRlcnMsIGF4aV9kbWFjX3BhcnNlX2NoYW5fZHQoKSBpcyB1c2VkIHRv
IGRldGVybWluZSB0aGluZ3MNCmZyb20gZGV2aWNlLXRyZWU7IGFzIGl0J3MgYW4gRlBHQSBjb3Jl
LCB0aGluZ3MgYXJlIHN5bnRoZXNpemVkIG9uY2UgYW5kDQpjYW5ub3QgY2hhbmdlICh5ZXQpDQoy
LiBGb3Igb3RoZXIgcGFyYW1ldGVycywgdGhlIGF4aV9kbWFjX2RldGVjdF9jYXBzKCkgaXMgdXNl
ZCB0byBndWVzcyBzb21lDQpvZiB0aGVtIGF0IHByb2JlIHRpbWUsIGJ5IGRvaW5nIHNvbWUgcmVn
IHJlYWRzL3dyaXRlcw0KDQpJJ2xsIGFkbWl0IHRoYXQgbWF5YmUgdGhlIHdob2xlIGFwcHJvYWNo
IGNvdWxkIGJlIGRvbmUgYSBiaXQNCmRpZmZlcmVudGx5L2JldHRlci4gQnV0IEkgZ3Vlc3MgdGhp
cyBhcHByb2FjaCB3YXMgY2hvc2VuIGJ5IHRoZSBmYWN0IHRoYXQNCml0J3MgRlBHQS4NCg0KQnR3
OiBpZiBJJ20gdGFsa2luZyBjcmFwLCBvciBJIG1heSBzb3VuZCBsaWtlIEkgZG9uJ3Qga25vdyB3
aGF0IEknbSB0YWxraW5nDQphYm91dCwgdGhhdCBjb3VsZCBhbHNvIGJlIHRydWUuIEkgYW0gbm90
IHF1aXRlIHZlcnNlZCBpbiB0aGUgRE1BRW5naW5lDQpmcmFtZXdvcmsuDQoNClRoYW5rcw0KQWxl
eA0KDQo+IA0KPiBUaGFua3MNCg==
