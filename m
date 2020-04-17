Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104171AD7AC
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 09:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgDQHp5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Apr 2020 03:45:57 -0400
Received: from mail-eopbgr1400108.outbound.protection.outlook.com ([40.107.140.108]:55078
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbgDQHp4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Apr 2020 03:45:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpLIb9h+IgM6VnVaY0hh1fJOlrae4O8zIiqmpJ1abgk3RVFdJuxzA5D/gyvR7CBEofiEJIDEx2o9HRN9RgWeaqiazyeAWxCNvSpmC3mk99WWNBCOaskGWxrfRzCO3N3cgFXspZNKaCGChARTdbnNaln1JvC0d5knwsFU0+Y974hzS2gSrMhY3uuaFfyAHvVYQ8glu/hvgEZxC7xI7B+vcbPCVC7LM3lYC1gnBLH5tj41ENif5ujbnZgIH/1h91WRSSQTVgYyanL+3+1EZcDKFRJcJP5Qpdl51e87Na+UphuMsIJPBfvkWEu4dKpGhcLRnCvvrlEeigIcKjG7IZY1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7nNjdsijVQP7A5SL9CVnoj1WuTIoaF29isWRKSe3Kk=;
 b=nlOPmD0fg4iH5bqw0qBquik/yHp2GSn6CzZHMN09xUwSO9MePdWmQ41LihZLCLGV9uQPhV58WhJamDuRkc23qRegvubL968Dk/7jGeA9CAPNv0mGCFo5nPDYfRJhXH6Dw1QLf/DayNOJHkdPkNpLznhzgzJgZmUmEz/oIS3RW46CbIUdED46MtkXAPigIg0sPOGL48f0iYwIKwwsp75vV9RNPzn1ena2f8WSGA9xlvKixpzrET9VTUTrsqmfudJBqBDDrSADUYDHWUByHU3mD2n3yOBZ7H4E7qYn8T13mMcN6bX8yI5dzb8dXIpb3CDaGZ3xrAvh7IWBsNLpNmxfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7nNjdsijVQP7A5SL9CVnoj1WuTIoaF29isWRKSe3Kk=;
 b=MboaLkoyEkGN9m9rVT4lEeZbTGC+HQRH6YWECx2v/CZjC/MDAE3DIpQik+U/6vlw471e7JrhBIksUroHTvMc3Yv5P6CeAszvSkarVAtAEBcyf32YngKvwy5JZtrPLJY7tsBAPHuCifL66Pby/Qk0LjXY6o8iI4DqCy69bPfISMo=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3582.jpnprd01.prod.outlook.com (20.178.138.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.20; Fri, 17 Apr 2020 07:45:52 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 07:45:52 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] dt-bindings: dma: renesas,usb-dmac: convert
 bindings to json-schema
Thread-Topic: [PATCH v2 2/2] dt-bindings: dma: renesas,usb-dmac: convert
 bindings to json-schema
Thread-Index: AQHWFGwH58E0smxgi0SC/Y0NfeYxM6h87XgAgAABxDA=
Date:   Fri, 17 Apr 2020 07:45:52 +0000
Message-ID: <TYAPR01MB454463E4E71DA4FB67D34A85D8D90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1587095716-23468-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1587095716-23468-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWXMcSgjOGwzMD+7R37at1v7db-neM9VgMRh+hMVp-aYA@mail.gmail.com>
In-Reply-To: <CAMuHMdWXMcSgjOGwzMD+7R37at1v7db-neM9VgMRh+hMVp-aYA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16f3b932-0c9e-4d0e-55c9-08d7e2a35ad7
x-ms-traffictypediagnostic: TYAPR01MB3582:
x-microsoft-antispam-prvs: <TYAPR01MB3582AA48403C1546D97BA025D8D90@TYAPR01MB3582.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(4744005)(54906003)(66556008)(2906002)(81156014)(8676002)(86362001)(71200400001)(478600001)(33656002)(8936002)(316002)(55016002)(4326008)(66476007)(53546011)(55236004)(7696005)(52536014)(76116006)(66446008)(5660300002)(9686003)(66946007)(64756008)(26005)(186003)(6506007)(6916009)(142933001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gj4BqVrgvJfv4yzN20U+lZSWxlb4Ws+zJ7vnSzEONBGpd6qLjygbrPtTOVlzhqcpgq6VGZ7QHXa/wndnO5ITYZ7UqTrm/PgiuC/FLIjVJFrhR9h0QHKwIMEHudjwiqWd99boII7q+nFMbVocV774b/yx5Lpo3hk0gCVdjdUlVY8jutuq5tpN97pMe5Q69fLtMNRMROmqgVrgOcSL2uJJrqwUpZjac3tVhaPeRx1rstydhjRlGXpMFJEo47tsNyKOKnFprW7JULVY2sL1rBS7CJ6qjAg/Zuv87aRsVpDTUvQCphpcV8/EKhNPsPeudjtse/DwAVVhaV10PG8yM9igv2mnmOlk1Q0Bh+8+wOSEfpX+gENkZHi51bzRhPyLBtEED8I0ocF/x4gC/kPJbUks+bYPst3lI1748cPxLl1pLoAXigECGqo4OyVtR+KN84YouGlJx5GzxKuJBtVPNXm3brLGjDkWgtJFApiGHMmWafZ884fTXspePXe0QV42HXTB
x-ms-exchange-antispam-messagedata: IC/NSsILzlIJoV9YQ/V1CHcsK5GEEConI0OCos2S9hYLCUCmGMUErcKjpMzWiJzf01rvxQN3ufIxHUl8iyNA+xh0voNA66x4AYSXFu47ZfTq0Ibm2VWdZIi/CJuqsc4Bx983C8oEoNVfB9G7Q71CbQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f3b932-0c9e-4d0e-55c9-08d7e2a35ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 07:45:52.5933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpE/g8VnvfsaUbroUnK/kBSmR7gUE8vzRVdspDlMy7vhO22+3MV2ylgKZHUkuz3Syk2+IWl9pdXWfM6DBfSJHOMvpwhd88cyDUHzCLt4g1cSP6OMAolcmD7lqDoRPQTW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3582
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IQ0KDQo+IEZyb206IEdl
ZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogRnJpZGF5LCBBcHJpbCAxNywgMjAyMCA0OjM4IFBNDQo8
c25pcD4NCj4gDQo+IEhpIFNoaW1vZGEtc2FuLA0KPiANCj4gDQo+IE9uIEZyaSwgQXByIDE3LCAy
MDIwIGF0IDU6NTUgQU0gWW9zaGloaXJvIFNoaW1vZGENCj4gPHlvc2hpaGlyby5zaGltb2RhLnVo
QHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBDb252ZXJ0IFJlbmVzYXMgUi1DYXIgVVNCLURNQSBD
b250cm9sbGVyIGJpbmRpbmdzIGRvY3VtZW50YXRpb24NCj4gPiB0byBqc29uLXNjaGVtYS4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9k
YS51aEByZW5lc2FzLmNvbT4NCj4gDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvcmVuZXNhcyx1c2ItZG1hYy55YW1sDQo+
ID4gQEAgLTAsMCArMSwxMDEgQEANCj4gDQo+ID4gKyAgaW50ZXJydXB0czoNCj4gPiArICAgIG1p
bkl0ZW1zOiAyDQo+IA0KPiBEb24ndCB5b3UgbmVlZCB0byBrZWVwIHRoZSAibWF4SXRlbXM6IDIi
LCB0b28/DQoNCk9vcHMhIEknbGwgZml4IGl0Lg0KDQo+ID4gKyAgaW50ZXJydXB0LW5hbWVzOg0K
PiA+ICsgICAgbWluSXRlbXM6IDINCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIHBhdHRl
cm46IGNoMA0KPiA+ICsgICAgICAtIHBhdHRlcm46IGNoMQ0KPiANCj4gQWNjb3JkaW5nIHRvIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9leGFtcGxlLXNjaGVtYS55YW1sDQo+IA0K
PiAgICAgVGhlIGRlc2NyaXB0aW9uIG9mIGVhY2ggZWxlbWVudCBkZWZpbmVzIHRoZSBvcmRlciBh
bmQgaW1wbGljaXRseSBkZWZpbmVzDQo+ICAgICB0aGUgbnVtYmVyIG9mIHJlZyBlbnRyaWVzLg0K
PiANCj4gU28gSSB0aGluayB5b3UgY2FuIGRyb3AgdGhlIG1pbkl0ZW1zLg0KDQpUaGFuayB5b3Ug
Zm9yIHRoZSBpbmZvcm1hdGlvbi4gSSBnb3QgaXQuDQoNCj4gPiArICBpb21tdXM6DQo+ID4gKyAg
ICBtaW5JdGVtczogMg0KPiANCj4gKyBtYXhJdGVtczogMg0KDQpJJ2xsIGZpeCBpdC4NCg0KQmVz
dCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0K
