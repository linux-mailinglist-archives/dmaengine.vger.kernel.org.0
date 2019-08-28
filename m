Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7A49FDA2
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2019 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfH1Izk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Aug 2019 04:55:40 -0400
Received: from mail-eopbgr1400095.outbound.protection.outlook.com ([40.107.140.95]:11515
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfH1Izk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Aug 2019 04:55:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWwOZLIEloD0yYgsKLw6WQ0s7rgVKZTGZhfczMDrHAlneTlu+uOofMb8tnsBTrf4Ds4EKGyL10kmmsekht0K8V34h3mfhUSv073ChURynp6GfNSqIGXgvw2qxa73TC2VzBR/iGPng29eryyizXoESbY65h6DSYhzXNoi6KkLOUs6dgvt/FRUqnaL+G3SrE/Iyf0JAGaHL/KDoCxKgGHi5Bd5FyyZ6VQ2ta0QmpbFVj2Lbs1oPQ793k0P+udmFD6wK9Rshnt7jChPiC2QBbhsN5VEk67FOoUGhBSJEq0VI2wyP3wr8SC4xouRfN7Rz/1PAb2wPf3dfT70bDTdPgQOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRy9x5J7dqJvFuYaVZRJ79PHtTVgA6VNDe6dCB4YZQ4=;
 b=kD+1hRbATTvosGEr+EDS1M6TyxQGPJJfLnUzxe2sZlQctkiKJDbkooRm9dpwEoVjZVtz41ndHqH9vyxELeV5/5brWzgVrgs4rObPnnffdimXAaGTCPtwGQe7BlDdLs2mcTEFrE8HO/GXS33T4aZUel6b5K3+RzSz9KbXpdNOLkEIS01Gok/P703DKdJE7u7T9PlSaMz/1n0Ti9emYuxFIDkPJNxHZZPRAMP1FhJPnvZljj62g0zrSrIvGk+AaL2d1aHB2H76uV3Z49rK9WAcSmVfzruQ9RKa5GwdSmkLYF1CJN3nRzw1XI8zIKdpglxHvrYD1VCrJG369Vui7/IleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRy9x5J7dqJvFuYaVZRJ79PHtTVgA6VNDe6dCB4YZQ4=;
 b=Hy7KFgKE7mDnu5cvUBFQD/z4pYawCoP8clDBTvaSqMYaXQE+5vdqymfAIH+VVuUpajqfn7aJXw4wNy2jeeLsSXW5ILbSoZIED3D3J9TZo5wyRubx1gM7kj0B217J8R+YLnlSToxntDCnhZDTuURrzKrcBjCuXlKpRNIku7XBBUo=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB5040.jpnprd01.prod.outlook.com (20.179.186.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 08:55:28 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 08:55:28 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: dmaengine: dma-common: Revise the
 dma-channel-mask property
Thread-Topic: [PATCH] dt-bindings: dmaengine: dma-common: Revise the
 dma-channel-mask property
Thread-Index: AQHVXWuY7BBEFyXtZE29P6wjBVSPHacQKKaAgAAX70A=
Date:   Wed, 28 Aug 2019 08:55:28 +0000
Message-ID: <TYAPR01MB454400436713332F1075D424D8A30@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1566974375-32482-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <eb823985-5cf6-0d83-8613-1baeeaf7d9c8@ti.com>
In-Reply-To: <eb823985-5cf6-0d83-8613-1baeeaf7d9c8@ti.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 602f2dd7-5f43-4583-8847-08d72b957990
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB5040;
x-ms-traffictypediagnostic: TYAPR01MB5040:
x-microsoft-antispam-prvs: <TYAPR01MB5040454A8BE4D3739558C60ED8A30@TYAPR01MB5040.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(52536014)(6116002)(71200400001)(71190400001)(3846002)(102836004)(81166006)(8676002)(81156014)(4326008)(2906002)(86362001)(5660300002)(14454004)(256004)(14444005)(66574012)(6436002)(486006)(186003)(478600001)(99286004)(55016002)(9686003)(6506007)(229853002)(2501003)(7736002)(305945005)(33656002)(64756008)(6246003)(66446008)(53936002)(66946007)(74316002)(66556008)(66476007)(76116006)(476003)(26005)(11346002)(54906003)(110136005)(76176011)(7696005)(8936002)(446003)(25786009)(66066001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB5040;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FDqHaoqrx2p1i51u5sDsAFxoZV4facdk/PZAj1dZVYFAat8YeJSDlTEjvAAEuweXBs1OuhPWJn0TeJoy24fUeIbdvl0bVPr5cX+QB6csdAtX5m4oT9DjZCNc+ajdj4am35z6pgepp4lyncr5nvGMfFcEEbTkn9cV4z+NCBMuiotCrJdupi6XwdAwFRYE6Kqr68DZqZHXLTRxDjMKgpLEER/tXNlF/Lysmzsd+UXIxzQUzs8RBaDaC7KGDxrR6mYRYsJxLwtYAbXEw16E4w1elnF/No1O9mLRooBea+X7Jb/7w8E0H5Umn6l/SDywyLw0z1YjHbz1PBfwvrnNGAKN0cSOLRPfCTYyr4w8JVmaCCoIfz0hmyUL1jtspw+IDvVKNVJQEkO28c/m4jUwrT4P/FaJRRt+RtDEciJN7dhFUgM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602f2dd7-5f43-4583-8847-08d72b957990
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 08:55:28.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mcAKtUKp+vGvoSSLOj68ntPWN0Ab29tWDhEbVh28HUZcmV4gndUQ4CzHEowzxxbd8NnSCMocWVpGnBy2JB9znnbcqPfnC1bWwRhyFeu0eBHWNf6ZN2FygcX6qgJTYulI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5040
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgUGV0ZXIsDQoNCj4gRnJvbTogUGV0ZXIgVWpmYWx1c2ksIFNlbnQ6IFdlZG5lc2RheSwgQXVn
dXN0IDI4LCAyMDE5IDQ6MjUgUE0NCj4gDQo+IE9uIDI4LzA4LzIwMTkgOS4zOSwgWW9zaGloaXJv
IFNoaW1vZGEgd3JvdGU6DQo+ID4gVGhlIGNvbW1pdCBiMzdlMzUzNGFjNDIgKCJkdC1iaW5kaW5n
czogZG1hZW5naW5lOiBBZGQgWUFNTCBzY2hlbWFzDQo+ID4gZm9yIHRoZSBnZW5lcmljIERNQSBi
aW5kaW5ncyIpIGNoYW5nZWQgdGhlIHByb3BlcnR5IGZyb20NCj4gPiBkbWEtY2hhbm5lbC1tYXNr
IHRvIGRtYS1jaGFubmVsLW1hc2tzLiBTbywgdGhpcyBwYXRjaCByZXZpc2VzIGl0Lg0KPiA+DQo+
ID4gRml4ZXM6IGIzN2UzNTM0YWM0MiAoImR0LWJpbmRpbmdzOiBkbWFlbmdpbmU6IEFkZCBZQU1M
IHNjaGVtYXMgZm9yIHRoZSBnZW5lcmljIERNQSBiaW5kaW5ncyIpDQo+ID4gU2lnbmVkLW9mZi1i
eTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0K
PiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2RtYS1j
b21tb24ueWFtbCB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2RtYS9kbWEtY29tbW9uLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZG1hL2RtYS1jb21tb24ueWFtbA0KPiA+IGluZGV4IDAxNDFhZjAuLmVk
MGE0OWEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2RtYS9kbWEtY29tbW9uLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZG1hL2RtYS1jb21tb24ueWFtbA0KPiA+IEBAIC0yNCw3ICsyNCw3IEBAIHByb3Bl
cnRpZXM6DQo+ID4gICAgICBkZXNjcmlwdGlvbjoNCj4gPiAgICAgICAgVXNlZCB0byBwcm92aWRl
IERNQSBjb250cm9sbGVyIHNwZWNpZmljIGluZm9ybWF0aW9uLg0KPiA+DQo+ID4gLSAgZG1hLWNo
YW5uZWwtbWFza3M6DQo+ID4gKyAgZG1hLWNoYW5uZWwtbWFzazoNCj4gPiAgICAgICRyZWY6IC9z
Y2hlbWFzL3R5cGVzLnlhbWwjZGVmaW5pdGlvbnMvdWludDMyDQo+IA0KPiBIb3cgdGhpcyBtYXNr
IHN1cHBvc2VkIHRvIGJlIHVzZWQgZm9yIGNvbnRyb2xsZXJzIGhhdmluZyBtb3JlIHRoYW4gMzIN
Cj4gY2hhbm5lbHMgKDY0LCAzMDArKT8NCg0KSSBmb3VuZCAiZG1hLWNoYW5uZWxzIiBwcm9wZXJ0
eSBhcyA0MCBpbiBhcmNoL2FybS9ib290L2R0cy9zdGUtdTMwMC5kdHMuDQpIb3dldmVyLCBzaW5j
ZSBhcmNoL2FybTY0L2Jvb3QvZHRzL2hpc2lsaWNvbi9oaTM2NjAuZHRzaSBhbHJlYWR5IGhhcw0K
dGhlIGRtYS1jaGFubmVsLW1hc2sgcHJvcGVydHksIEkgdGhpbmsgd2Ugc2hvdWxkIG5vdCBjaGFu
Z2UgdGhlIHByb3BlcnR5IG5hbWUuDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2Rh
DQoNCj4gPiAgICAgIGRlc2NyaXB0aW9uOg0KPiA+ICAgICAgICBCaXRtYXNrIG9mIGF2YWlsYWJs
ZSBETUEgY2hhbm5lbHMgaW4gYXNjZW5kaW5nIG9yZGVyIHRoYXQgYXJlDQo+ID4NCj4gDQo+IC0g
UMOpdGVyDQo+IA0KPiBUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1
IDIyLCAwMDE4MCBIZWxzaW5raS4NCj4gWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4g
S290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kNCg==
