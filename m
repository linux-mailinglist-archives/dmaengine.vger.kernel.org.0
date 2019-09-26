Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E80BF4B3
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 16:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfIZOJ3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 10:09:29 -0400
Received: from mail-eopbgr1410114.outbound.protection.outlook.com ([40.107.141.114]:11468
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbfIZOJ2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 10:09:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jilNIPOvw354Mq22RA/S0HrVRQb+2fZU+4gf0MvLvJFdsKCvLIDUd0WtsW3cvilzz8HoKK6Va2+HSe7q4Mu3WPS2aSLDQEtvu9Ennv25XI9kMUfhAMtV4PHiAIObB6bYMbZ9bYnbzeDQ318a40K0ldEhSPDvvgKkAcTXzDX2zjM34nuLGSdnWWF/inj60JnXH/uqm5UGagyGsG0CWAEhJTA+Jm7Su1VA7ttKxsyWtvMzy3RBypH9HAeiXiy6/RoRG1u+GxncqOb0sWglb4JaQf2+jlEN35KdhMjX5sVY35syTSBTDpk6Ox93x4Za2Of8GDQmClB0QH8gpWmxMWhS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpjzVQDH2SMKqkCilgtIB5dv3EIHMnQp5Ey6RB480Ek=;
 b=caFqQ6TUnOBi83p8EuTri36xZI5njGEk+ICbDjPeuBdZeEzfgmUn8kCTG17lqzBiirH8I11wl4Ug+Oq74rB2icZfnjkTVJ9FJRJ9zn4yV5DDvJkWN2/v+kmYAiG7YqsPRFyZKckWtD7JW1yPq70K/wKkeG+S4A8TlVijLtwbo21G0MEtTnjTH3KmR/bBf3zupOL5raj0CF0RkV0dACpTA/PmMe0Swhm4q2KRyBixpJc1UUNkh+aFq7P/TeEATHDZZGuMkggD5Lj+uHdA/p8Xp7v6/OS3ZQYa//HEdH26shdwEbq48wJ3Qkjt0d7btBvw0kkCVFG8tOOk7o0CEiXN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpjzVQDH2SMKqkCilgtIB5dv3EIHMnQp5Ey6RB480Ek=;
 b=ChlwUncAw4eo5wn4CJfJeY7vI3/Yp28bNo+IdK8F5irBQPhMzh+8kpysneIquzEPFTMhwYdV08cYWpW4DWASiduD8Kb/dufejey1zxhEzJpwztVQtqR64ak4SX/g3l3CN7Ef2/yrNj6f42PhlaDUUUI8fOLw2q/Kp9v1DsJ/AiY=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
 OSBPR01MB1495.jpnprd01.prod.outlook.com (52.134.228.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Thu, 26 Sep 2019 14:09:24 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::746b:49c1:925d:e9eb]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::746b:49c1:925d:e9eb%5]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 14:09:24 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: dmaengine: rcar-dmac: Document R8A774B1
 bindings
Thread-Topic: [PATCH] dt-bindings: dmaengine: rcar-dmac: Document R8A774B1
 bindings
Thread-Index: AQHVchJJj9K9GNCdBUSdWHd8WwIIqKc96AiAgAAaSKA=
Date:   Thu, 26 Sep 2019 14:09:24 +0000
Message-ID: <OSBPR01MB210380CE9A07266238A03B41B8860@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1569245078-26031-1-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdW+AwUFTbN6+084jZdYdVHYdi1wzBGAxkreqcQCGXm8zw@mail.gmail.com>
In-Reply-To: <CAMuHMdW+AwUFTbN6+084jZdYdVHYdi1wzBGAxkreqcQCGXm8zw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23714bb5-8d74-4f68-38f4-08d7428b22e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:OSBPR01MB1495;
x-ms-traffictypediagnostic: OSBPR01MB1495:|OSBPR01MB1495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB1495DF7081650528E0AE3FD4B8860@OSBPR01MB1495.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(346002)(136003)(376002)(39850400004)(189003)(199004)(51914003)(52536014)(54906003)(81166006)(66476007)(11346002)(446003)(66946007)(7736002)(8936002)(33656002)(14454004)(26005)(86362001)(2906002)(6436002)(76116006)(476003)(66556008)(74316002)(102836004)(4744005)(305945005)(4326008)(5660300002)(25786009)(66066001)(7696005)(3846002)(256004)(6246003)(186003)(99286004)(55016002)(229853002)(71200400001)(6116002)(6916009)(81156014)(71190400001)(486006)(44832011)(8676002)(9686003)(66446008)(478600001)(64756008)(53546011)(6506007)(316002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1495;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rFP4muNBu1YprqNGEj/TyRkbenuaKQCaVxhouq/7IBznhXozdoZ0CONFFKLzbWlU6lRbGIiSKaNtrH7T+a+f8SSpDsJFhytEYx7QvLTYE0x55b9k8mNwxQWZLX921X6ASVH4mOaArs4YPpdzZ0DQN5lrmOdbl5QCcfU15Hh5VlYr6xTztaCr8GnyE+aPJlDx8TfOwh5qni5kLoKA5sWlJb3tkFfqRoUE3xIcRTWZbsMzVEI6myVqyPz9rrdIRpywE8Lo9hkimVrhR21F8aVyVSVgiAdPM7rqjny7VMPUvm7rD+JtY08eJE5dPh+/ONV1dOGU1H1qWO2zTv4KiGXs7xP74SnM60fq9a6k2/OWAU/18n/+D20oPnq5mwXqcvuG/LvjnDFKKvZECzW7oQwYY5Ct6xaiq3/dFY4qZQ9acXw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23714bb5-8d74-4f68-38f4-08d7428b22e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 14:09:24.7392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8wSbVYQ6Pnn2Z/cbn3vdgNy5HJXO+zptfHfhHaNJI+qOsYd9sSMbnK7nArXPxe+P7O1lvEQ+WEH9oMTJmklmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1495
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQpIaSBHZWVydCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gZHQtYmluZGluZ3M6IGRtYWVuZ2luZTogcmNhci1kbWFjOiBEb2N1bWVudA0KPiBS
OEE3NzRCMSBiaW5kaW5ncw0KPiANCj4gT24gTW9uLCBTZXAgMjMsIDIwMTkgYXQgMzoyNCBQTSBC
aWp1IERhcyA8YmlqdS5kYXNAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+IFJlbmVzYXMg
UlovRzJOIChSOEE3NzRCMSkgU29DIGhhcyBETUEgY29udHJvbGxlcnMgY29tcGF0aWJsZSB3aXRo
IHRoaXMNCj4gPiBkcml2ZXIsIHRoZXJlZm9yZSBkb2N1bWVudCBSWi9HMk4gc3BlY2lmaWMgYmlu
ZGluZ3MuDQo+IA0KPiBQbGVhc2UgZG9uJ3QgbWVudGlvbiAiZHJpdmVyIiwgYXMgRFQgYmluZGlu
Z3MgYXJlIGludGVuZGVkIHRvIGJlDQo+IGltcGxlbWVudGF0aW9uLWFnbm9zdGljLg0KDQpPSy4g
V2lsbCBzZW5kIFYyIHdpdGhvdXQgbWVudGlvbmluZyAiZHJpdmVyIi4NCg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhc0BicC5yZW5lc2FzLmNvbT4NCj4gDQo+IEZvciB0aGUg
YWN0dWFsIGNoYW5nZToNCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQr
cmVuZXNhc0BnbGlkZXIuYmU+DQoNClJlZ2FyZHMsDQpCaWp1DQo=
