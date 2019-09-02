Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95AA5A52C9
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2019 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfIBJZF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Sep 2019 05:25:05 -0400
Received: from mail-eopbgr1400139.outbound.protection.outlook.com ([40.107.140.139]:22877
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729612AbfIBJZF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Sep 2019 05:25:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaO8L46LUR6hGX9OwKDbRAymBx7avKFUWEG8A7e3RnnqsiL/dJO8vyY1XOG3EIQAifhIv1TuA5edco7ij81xj5x04+YhMr0sBAzPLet6OWmQxurUVhml9wOkZQxBeTxjrR39hUQQR8ltgYr0LbfNwhQuewSnDi5+J9MdKAmQZcn54cRDoplpOl+mL4ulO6ijeOPvTN39qH39fDBYisecARqSSRP8+hI+vY/2AnQiXHX0KZQhoqaWncUfJhgHmj0Z0jYESI9Zse66+tIizlHRALXtXPz5STh2HuScoTGIxcSKHkpp280K5YG13+nslCX/fC4jIpcR2SBbevnb1PyopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvgJoy5FKKZN0RG9tFMUXYqyqjwq2lDkKyMCgkuCh5Y=;
 b=MyzZyz7iCRhF03eRQATc+1VHomTJhWHAHChQcapAjRUW1kRYC3P7ow1xqePiouju+D9PNq7+LaDcptIzveeLemQdbV/rm5vYOYUxttn8N7dIuHEIo13NkG3+KP89i1I/D9lifYKF2D0zCu/oLystdgmf38VPj/nIaErWEqVDv5iWEzxuUfgP0HazHOxx1LG1UFiCO8Dbegf1/HV2YyWzoMco0xZOKK9q+ABibVwunQDP4p811/j2RWzGd+074k8OgGSAOj9sR+65pDSNqWAHU0DyNbCM+tmNx74AQ3OAynZ7/5bai+bqvKJ90LJx9IMOPXz215zcfD35PkW+bqdpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvgJoy5FKKZN0RG9tFMUXYqyqjwq2lDkKyMCgkuCh5Y=;
 b=blULQv1yCvG8mw9sGIzsF3cOpG1oGeQGVioNtyYNsfnFWma8GsSk1n4ZRlaWZgqWOU1ZlkigMvo4l8OP6l57TuYp/mjo9gLKEFmPtknA4FLUwI7CW0X+typAxrPTudWzH1yS1VLE2amHr01QwI8nlZscKm2DBiJYvv6LG3DF/Cg=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2607.jpnprd01.prod.outlook.com (20.177.103.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 2 Sep 2019 09:25:02 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2220.022; Mon, 2 Sep 2019
 09:25:02 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] dmaengine: rcar-dmac: Don't set DMACHCLR bit 0 to 1
 if iommu is mapped
Thread-Topic: [PATCH 1/2] dmaengine: rcar-dmac: Don't set DMACHCLR bit 0 to 1
 if iommu is mapped
Thread-Index: AQHVXZHsInhhy3gzVUOxBjefYznvOKcYHFEAgAAI5bA=
Date:   Mon, 2 Sep 2019 09:25:01 +0000
Message-ID: <TYAPR01MB45448C4FD9B60E5F7A8335D4D8BE0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1566990835-27028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1566990835-27028-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdVbbnUj+S48oxBL0HDQsRjSBCLnfztj8WHsz-VQ=aWN5w@mail.gmail.com>
In-Reply-To: <CAMuHMdVbbnUj+S48oxBL0HDQsRjSBCLnfztj8WHsz-VQ=aWN5w@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e6985b9-d545-44bf-36b0-08d72f876ebd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB2607;
x-ms-traffictypediagnostic: TYAPR01MB2607:
x-microsoft-antispam-prvs: <TYAPR01MB2607D3B198B06A894C063A34D8BE0@TYAPR01MB2607.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(14454004)(6916009)(2906002)(229853002)(4744005)(5660300002)(86362001)(52536014)(7736002)(99286004)(8936002)(33656002)(8676002)(53936002)(4326008)(81166006)(81156014)(76116006)(6436002)(256004)(66446008)(64756008)(66556008)(66476007)(66946007)(26005)(186003)(71200400001)(71190400001)(6506007)(102836004)(486006)(6116002)(476003)(3846002)(305945005)(478600001)(25786009)(54906003)(11346002)(446003)(76176011)(316002)(7696005)(9686003)(74316002)(55016002)(66066001)(6246003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2607;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MoGa4P8xDsJ6gVvbkPh3W8gcp35xPKEmTn/MHBoG9zlnjgkjbHiBCaZicBjd+FkmBXsZXl4vBlVE6Vn35e4D4SnkiUjWmZupsThds7BfnuagFoRtzQC5IXUX6rkWQyINU+tkEZgt0UpD1PQPfGQbzW9MNnMjQ6ztJBu8P7sZgt75spMUfI1RE8r8b40Rc1YTPKNDlpnhnIZ2epgjoCEm8xQOudecyeDnD3Dk3Pf4zelMd/t9avO6hr54tCj4vUOy6dWSoWSkoNvc0eeizcrY55BZBve6RYS2igfQ/2VNgAL5QvkprylCEH9ZNp/lYNozdz7n8TUCtp4KyQS4DVxzxkrkvj0f7AF/iYwhB3McYdgLz5tFETYO0cTs9HruhoitSjmeTIkiUd9/jjwCHmJE/ad083utb40wD+ZKriVM4fQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6985b9-d545-44bf-36b0-08d72f876ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 09:25:01.8830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47dlfn/epPHmMv4u/EmO9Ck8jPh+TKiUqGL4LLbJqKP2C5iWe9qr/dTbmHziLQYA0IhovXXweTf6ku4cSKHnrC8/6ak21vh0+63UBGprQG34PlzkVa0IbKMNXT81mYf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2607
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogTW9uZGF5
LCBTZXB0ZW1iZXIgMiwgMjAxOSA1OjUyIFBNDQo8c25pcD4NCj4gPiBAQCAtMjAyLDYgKzIwMyw3
IEBAIHN0cnVjdCByY2FyX2RtYWMgew0KPiA+DQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgbl9j
aGFubmVsczsNCj4gPiAgICAgICAgIHN0cnVjdCByY2FyX2RtYWNfY2hhbiAqY2hhbm5lbHM7DQo+
ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgY2hhbm5lbHNfbWFzazsNCj4gDQo+IEdpdmVuIHlvdSB3
YW50IHRvIHN0b3JlIHRoZSBvdXRwdXQgb2Ygb2ZfcHJvcGVydHlfcmVhZF91MzIoKSBoZXJlIGlu
IGENCj4gc3Vic2VxdWVudCBwYXRjaCwgeW91IG1heSB3YW50IHRvIHVzZSB1MzIgaW5zdGVhZCBv
ZiB1bnNpZ25lZCBpbnQuDQoNCkkgZ290IGl0LiBJJ2xsIGZpeCBpdC4NCg0KQmVzdCByZWdhcmRz
LA0KWW9zaGloaXJvIFNoaW1vZGENCg0K
