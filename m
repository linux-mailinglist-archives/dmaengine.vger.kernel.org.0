Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B5FBEC21
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 08:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403817AbfIZGny (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 02:43:54 -0400
Received: from mail-eopbgr800053.outbound.protection.outlook.com ([40.107.80.53]:16512
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730840AbfIZGny (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 02:43:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ07XCT+EtuMXvAy8wtnPsE4Kil/Kc2Ua/zaQzpnX38Pvi3/Hx8TfaWPfvOgjIKH6aXpENSY8vx3bIT/+CzZb1XQITmHkO3oroXOeDR2ErLG6AxiwDvMIgYJyjfsiAlaMt9mtYdqeT5qEnKh5hRqHiwKYGnShPXP1f9MpUB7Jz44wwOPRaoi5Zc4z6dPudAFxH4td9ryphaJU7VEQbWuJMmRI8wX9hwCxuUkDZDvZDUvyFt6GjNocj/xLalHzpQ7MUSZQtRZWRa1KkEvkDoecBKL/pI9dVwq6zC80QqUYXC+RgVdvFvHh3kBlJ+fSTGd7E1PS/1fipjBQrsv178ivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHP5/ZOmiqgJoxengdi/qvG7pPXVBoppv2lheKHtn6Y=;
 b=YyqUYUmPHYHTZnh2XbtI+Cz/r56sbp2GDfOGpyW1BeKeVg7WD1oh1ORJAF1gOOMqFobCH1KbXx3lVy6ycsjjI21C8nmV3beEUGZ+qzERE/wvMNYQZUqPOy1hpPIZ8aYCUWCZIjz3HQYSF2ecIfNr8tBM9JQwFKSoIv/1LNpWEhIYyt9C9hrDYwapnUf6NoMlUR5H8dC/iqB5LpgvQhLdQ6C1QZIAn/wq4xVkQJ0V0oDndLEMtgno8eOMrF++Xx+N4nWj9JbO5ikf7K9cpOuGsfuFvSFt50+axt5oKCnOZl3AF7SzgF6+nMR7NSi4zw63uUNprxicjZP3B7OM0PyHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHP5/ZOmiqgJoxengdi/qvG7pPXVBoppv2lheKHtn6Y=;
 b=tcLBfNd5qf8KfrT9cM5Ut4CMRhXQFBWLOMkIzzOGJO9d1QbrsESoYajFplHXsqhqiHN+lGh2+G3xPQ28Fj4s1fING7alZ4xb0Y88SYqHRWji6zgpfnaGZfMHLQT03UNf476CwZ39QkzozAfH4cKLFAJ6Gw4P6Jwdda1VadsyhMk=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3198.namprd12.prod.outlook.com (20.179.82.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Thu, 26 Sep 2019 06:43:51 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36%7]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 06:43:51 +0000
From:   Sanjay R Mehta <sanmehta@amd.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Hook, Gary" <Gary.Hook@amd.com>
CC:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Kumar, Rajesh" <Rajesh1.Kumar@amd.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh@kernel.org" <robh@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 4/4] dmaengine: Add debugfs entries for PTDMA information
Thread-Topic: [PATCH 4/4] dmaengine: Add debugfs entries for PTDMA information
Thread-Index: AQHVcqpMx6HFMYask0qZb2sW/KwVyac6eDWAgAMN64A=
Date:   Thu, 26 Sep 2019 06:43:51 +0000
Message-ID: <b334d159-531f-4e0a-c5bb-11de7968dcd7@amd.com>
References: <1569310357-29271-1-git-send-email-Sanju.Mehta@amd.com>
 <20190924080503.GA564935@kroah.com>
In-Reply-To: <20190924080503.GA564935@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::21)
 To MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1b47440-2e80-44c9-0ef8-08d7424ce471
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB3198;
x-ms-traffictypediagnostic: MN2PR12MB3198:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB319849F40D7FC8B47BA7BC24E5860@MN2PR12MB3198.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(186003)(102836004)(256004)(2906002)(31686004)(7736002)(4744005)(305945005)(6636002)(99286004)(66066001)(26005)(76176011)(52116002)(2616005)(476003)(7416002)(71190400001)(71200400001)(486006)(8936002)(386003)(446003)(6506007)(53546011)(11346002)(3846002)(6116002)(66446008)(54906003)(64756008)(66556008)(66476007)(478600001)(8676002)(14454004)(31696002)(36756003)(110136005)(316002)(66946007)(6486002)(6436002)(6512007)(81166006)(81156014)(5660300002)(2501003)(229853002)(25786009)(6246003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3198;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iqrTlTDVqgfgJ/1gbq0T3LaNPnV4d97xC6+hIQG9wygjzs7kBuTnBYDO8u9slrrw1nL6fgSjOt60+xZAiqvWH/ynCiNfHzFd4muWkcqUDM25U1fvxOwU4WOlsnqlnOhfkNteq0cSHeEezj2Xck7b01yAXIc091pz4cUV0tyBPsLYvYyYpPpOfE/lqn5JcJyoKJtRvul6vowVQ9zwYbruFO0K7O+jXtQd2SIm17Yp1hTzCcpvuuFckgrzceGGxpJakWDXaYz6fT6PEgQNz7ln4tRME+icbz+f9XadGA51QJ7XjHxOey/Jxd5cBSv/cPmGvujj+KzbUuuOoydEBZDsAcvIQZgw5XNwvAsgSpJEjosN/qL9hCO6qO5XaJIfqiqJyML3VR0XbslSHsEqAELFgmND03XuxvqxkkXizAZPPNA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <653F7D09F4AA9F4EB31DF026DAB33BD1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b47440-2e80-44c9-0ef8-08d7424ce471
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 06:43:51.5595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdxWL9yG7j9ZO0WBv9nEJUA2qLFxC+1ITGYPiOKfG7D6Vr5URk3+qybo302cpS4rTRbQ8BdYUDdL7EIHrlM/dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3198
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQpPbiA5LzI0LzIwMTkgMTozNSBQTSwgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgd3JvdGU6
DQo+IFtDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbF0NCj4NCj4gT24gVHVlLCBTZXAgMjQsIDIwMTkg
YXQgMDc6MzM6MDJBTSArMDAwMCwgTWVodGEsIFNhbmp1IHdyb3RlOg0KPj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHB0X2RlYnVnZnNfaW5mb19vcHMgPSB7DQo+PiArICAg
ICAub3duZXIgPSBUSElTX01PRFVMRSwNCj4+ICsgICAgIC5vcGVuID0gc2ltcGxlX29wZW4sDQo+
PiArICAgICAucmVhZCA9IHB0ZG1hX2RlYnVnZnNfaW5mb19yZWFkLA0KPj4gKyAgICAgLndyaXRl
ID0gTlVMTCwNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVy
YXRpb25zIHB0X2RlYnVnZnNfcXVldWVfb3BzID0gew0KPj4gKyAgICAgLm93bmVyID0gVEhJU19N
T0RVTEUsDQo+PiArICAgICAub3BlbiA9IHNpbXBsZV9vcGVuLA0KPj4gKyAgICAgLnJlYWQgPSBw
dGRtYV9kZWJ1Z2ZzX3F1ZXVlX3JlYWQsDQo+PiArICAgICAud3JpdGUgPSBwdGRtYV9kZWJ1Z2Zz
X3F1ZXVlX3dyaXRlLA0KPj4gK307DQo+PiArDQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxl
X29wZXJhdGlvbnMgcHRfZGVidWdmc19zdGF0c19vcHMgPSB7DQo+PiArICAgICAub3duZXIgPSBU
SElTX01PRFVMRSwNCj4+ICsgICAgIC5vcGVuID0gc2ltcGxlX29wZW4sDQo+PiArICAgICAucmVh
ZCA9IHB0ZG1hX2RlYnVnZnNfc3RhdHNfcmVhZCwNCj4+ICsgICAgIC53cml0ZSA9IHB0ZG1hX2Rl
YnVnZnNfc3RhdHNfd3JpdGUsDQo+PiArfTsNCj4gQ2FuIHlvdSB1c2UgREVGSU5FX1NJTVBMRV9B
VFRSSUJVVEUoKSBoZXJlIGludGVhZCBvZiB0aGVzZT8NCg0KDQpPa2F5IEdyZWcsIG5vdGVkLiBU
aGlzIHdpbGwgYmUgcmVzb2x2ZWQgaW4gbmV4dCBzZXQgb2YgcGF0Y2hlcy4NCg0KPg0KPiB0aGFu
a3MsDQo+DQo+IGdyZWcgay1oDQo=
