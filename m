Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F2F1ABA3E
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439622AbgDPHse (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 03:48:34 -0400
Received: from mail-eopbgr1400105.outbound.protection.outlook.com ([40.107.140.105]:37280
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439576AbgDPHsb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Apr 2020 03:48:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARMHbzGFfmnRh1eJBj7rMC/3jeG4T+tDm3wjOum2S/79Fc9RQW8RJx51FtH7Jn7QrtJTJHXw4xQE7u3qyeMHZbw/lBf2Na6DA/kelieB7W1pav8aX9zP/MObEz6IgPxRUo8G2VpPJgrJ4405ANWGWRcaL+D1Ox6GaGZki4ug2cyzM8yIg/Vqj0D0jTYwl+0umHq+x9MOSJmyVB6ZcVdGawmChqXvx2NX98/e0PP+5JQgAgbefmtbEWmyeuqaxFrX5k8PThAgukgzLyrvQ8dBnydJfpwRUjWfnxXW9IiNHK4vf5qLD+Nb6D9wndnekIVocmb/3u09GHN2NOdHRPkjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBhe8EuQh1xqc3u3NeiXmJt+ghTWSmGT+Xh17oL0D9c=;
 b=QgMTZoreHHnDJqjnM8666JBZrVVTtBIkwPZ7+8eSjM4dpjR0JCyxjQhIokQWbxFXi/uUpkuQgVGTO3tITnxAH+NwPRcQZAb7Gm3C2JoOcKawq/JuWDAfuE0iDTkeYdENbZnkN3smwIKAxXn2Uo8eAfBKUrIvbp7UXhgAIkOxyR/5FWSI3k4ZWohIAMYY0fQS3GvIiIxur1PlEBBKyJyhN0Hey8wF9d56EKLQRvdDTrTzQuOUTPpHDnCskmfdzfQrJIhLh5vcgRV481MtHj1EYuFWluH88A4/8JcbwAgV7VUl1e0m/gzh68KF0I1Ns/PeksliqfgJ7Zu06VPZQEFQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBhe8EuQh1xqc3u3NeiXmJt+ghTWSmGT+Xh17oL0D9c=;
 b=fRStXRJKbmhS6QOOGh0wLqCE7rAjihBfc4msRVJQrp10WRl0ANCudNLmzQO8gN+vRCLosyw134qufWUc0WtHuWsGa/fpvrdjgzzNBH3bxwzQdeFB4WwM4r2CUuE0R9Fd3MEo6XsIOnFyyv32KNU5Vr+X1jVfxVWe3IJfAAJ+S2A=
Received: from OSAPR01MB4529.jpnprd01.prod.outlook.com (20.179.176.20) by
 OSAPR01MB4242.jpnprd01.prod.outlook.com (20.178.102.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Thu, 16 Apr 2020 07:48:28 +0000
Received: from OSAPR01MB4529.jpnprd01.prod.outlook.com
 ([fe80::3056:e118:8a8e:b3ad]) by OSAPR01MB4529.jpnprd01.prod.outlook.com
 ([fe80::3056:e118:8a8e:b3ad%7]) with mapi id 15.20.2878.023; Thu, 16 Apr 2020
 07:48:28 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: dma: renesas,rcar-dmac: convert bindings
 to json-schema
Thread-Topic: [PATCH 1/2] dt-bindings: dma: renesas,rcar-dmac: convert
 bindings to json-schema
Thread-Index: AQHWDx8gfAei1qnt90WjEN4QnCOb0ah6MAqAgAAMC4CAASxIcA==
Date:   Thu, 16 Apr 2020 07:48:28 +0000
Message-ID: <OSAPR01MB4529E30B427D73716E776022D8D80@OSAPR01MB4529.jpnprd01.prod.outlook.com>
References: <1586512923-21739-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1586512923-21739-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdULExMNnKJWsjAonR1sVeTyQCH0shwO--Wo6dLzrWV_tQ@mail.gmail.com>
 <CAMuHMdWp8kNnZYXpp8LnKcE01OWZi2x7U29MLjQ4BTAcYJUyeQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWp8kNnZYXpp8LnKcE01OWZi2x7U29MLjQ4BTAcYJUyeQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 630b0e2c-42b9-4087-c489-08d7e1da8d35
x-ms-traffictypediagnostic: OSAPR01MB4242:
x-microsoft-antispam-prvs: <OSAPR01MB42423830C62F78C47CC044B2D8D80@OSAPR01MB4242.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4529.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(55236004)(76116006)(55016002)(186003)(64756008)(7696005)(8676002)(66556008)(52536014)(53546011)(81156014)(8936002)(6916009)(66476007)(6506007)(26005)(478600001)(5660300002)(66946007)(66446008)(9686003)(54906003)(86362001)(71200400001)(4326008)(33656002)(316002)(2906002)(4744005)(142933001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fuLkEQOAAKi+roirvgQAseTf+D5jCASnzkXjxkEeRVQGNt9oLEMpurLmChe/MtSvT3bnKr1J235fCS8BGiTmURS60h44M7wlPAcHwT5i5un6yJSkZFzpMYYQuAkzOPo0EM3QS2kPJQyOjC7646Ot7oU2afdZtQIvlF5BvjLEx3SAXiW27z1uai+LMAxo1J10fOHsM3Dajo6BFDhRWYyqmk0NZbrXIY+BES9Tg+3D1fcpacasNuBDF01NvqLBcJfPvYgF/PCGfCS6wC4lNbYzscYqpPzFmB1xJbFad4BP4ldacYVbxPDjQIaFPX2iI7l2vyQILGGrAzm6FvdGeS3xeZWQ9ph11/DjUTZPzwkDz8VY8qp4Dz5fPcyS+IbTdupv7d89JQXkMtocSMNmd6Sb0YUZ4iu00zdno4jr+pNR7SZxZdPN3HvKViuFYTsOkpsNX29eDWeV3MdQQP5ABMDhHCk4MoyIYWH9dxuJNMnbDtjsQtDytBB0CRvnNl84/K/e
x-ms-exchange-antispam-messagedata: V5SO1DefDNmIfe2MdO/N7bp/H1+/JkqEGHFlLtlTJW1BwlC5wOvhgCJ2Z0cf8GBQUen+TCxE/QXvWn6iR85azcCH65omFrv/ARKUCEauwBNl7ptGCi356i8Vw38mlmVZrvzBDyDPwfWPlQElqkq8pA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630b0e2c-42b9-4087-c489-08d7e1da8d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 07:48:28.3376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fekHgLTW7W6w6To1T6vnhVBE10O1XfwB2Sg+xjIyQTnsgpvoOKgvAppJgxatzH1kMioLEGf/OJyGrNbyUbyl7LIDNwD+/Kd+4iH7raxireNK1w2uEo7P3XZUNiR/Gc5w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4242
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogV2VkbmVz
ZGF5LCBBcHJpbCAxNSwgMjAyMCAxMDo1MyBQTQ0KPHNuaXA+DQo+IE9uIFdlZCwgQXByIDE1LCAy
MDIwIGF0IDM6MDkgUE0gR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4g
d3JvdGU6DQo+ID4gT24gRnJpLCBBcHIgMTAsIDIwMjAgYXQgMTI6MDIgUE0gWW9zaGloaXJvIFNo
aW1vZGENCj4gPiA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+
ID4gQ29udmVydCBSZW5lc2FzIFItQ2FyIGFuZCBSWi9HIERNQSBDb250cm9sbGVyIGJpbmRpbmdz
DQo+ID4gPiBkb2N1bWVudGF0aW9uIHRvIGpzb24tc2NoZW1hLg0KPiA+ID4NCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2Fz
LmNvbT4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3Jl
bmVzYXNAZ2xpZGVyLmJlPg0KPiA+DQo+ID4gT25lIHF1ZXN0aW9uIGJlbG93Li4uDQo+IA0KPiBT
b3JyeSwgSSBtaXNzZWQgc29tZXRoaW5nIGF0IGZpcnN0OiBzaG91bGRuJ3QgInBvd2VyLWRvbWFp
bnMiIGFuZCAicmVzZXRzIg0KPiBiZSBtYW5kYXRvcnkgYXMgd2VsbD8NCg0KSSB0aGluayBzby4g
U28sIEknbGwgZml4IGl0Lg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo=
