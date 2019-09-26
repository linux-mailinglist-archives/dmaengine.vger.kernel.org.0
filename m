Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB6BEBF8
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 08:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390345AbfIZGdJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 02:33:09 -0400
Received: from mail-eopbgr720046.outbound.protection.outlook.com ([40.107.72.46]:43318
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390250AbfIZGdJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 02:33:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgOm/tlSf1If+XCxQUDMX/QL4Ms1qatJe0+5vDd4GfzLmqrsBHqcGbwPE0hjDtLX5LnyAJxvBfb4cCuVEMffbLP+9kLJmxkrmBJXRcXy6Y2oJMQtpFpADznRWm4am9HRfsMEn87CmAO+34cQy72e0lD/wEh02uMaG06He4v/xDKP4uZ1l+jswSneoxKMpkp1yvmrvAuD640dhEtzpADbxKjXKRjZbxNFfgpY4slgDIdOm7vOZ4izL6bpyHQKcGeZ7lGr9NA75DRbgf2bOOUNJj7utusS71LPSVxfTqpjaul/IMlGxxEvQWb8Ujk/6Q0z2k2SCUb6hVHquYHYpCYmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3kwKeXhgxZs5FZbWCsbVbjtmX2L2pIgVI9jtlvZwCE=;
 b=G3Y0PaaFE8sX0xBnmJskfk5knhTGvkuMVVR9I4vd4y6dS5TKVIeo8qCMLLPRu+w6O6xmVoJL8hauMSvXyGzjsA9oECSOLt9VKj2mhlWr3eJFnAOZ1Mj1noE1J3xl818z+p5oXHKqdM6jbW+1guts+klofnUlM7mEhNGPZjqsg4z0gZhx4PbYY2hY/iPYevDoQamBuVnth5aptbAr8gB4BLDREvNjX7ZYj/5KDbzo+j49tHzVwncR7nWcq71TnlGVWeXz0sJPoSdsQX6qNvr2GDIhVMc7FJLy/ejvqu+bubHdXSNLQtndDtuJdyv3sHfxmxvthKD0v6zYWXxHjWbSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3kwKeXhgxZs5FZbWCsbVbjtmX2L2pIgVI9jtlvZwCE=;
 b=s2EQCyMvaHP4XXXXn6W2v4FvlSlViVWO8+O6ibmrMBcO+REbC33KGm3INf9pz8fd+rTWWbqWQnvqyvx0JXTbsuEEBZVOzZ11pMNU5Rgx/AJQT5GCfid+WuriAVEKYeymGB8psNca8DtZRAgKdTzMKtkO1clKrWesIvrAwrnymRU=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB2895.namprd12.prod.outlook.com (20.179.82.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 06:33:05 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36%7]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 06:33:05 +0000
From:   Sanjay R Mehta <sanmehta@amd.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
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
Thread-Index: AQHVcqpMx6HFMYask0qZb2sW/KwVyac6eDWAgAMK6AA=
Date:   Thu, 26 Sep 2019 06:33:05 +0000
Message-ID: <0b3db0a6-304d-05de-76c4-108dce4664f4@amd.com>
References: <1569310357-29271-1-git-send-email-Sanju.Mehta@amd.com>
 <20190924080503.GA564935@kroah.com>
In-Reply-To: <20190924080503.GA564935@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::21) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfddd106-2f0c-4c5b-fc0b-08d7424b638b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB2895;
x-ms-traffictypediagnostic: MN2PR12MB2895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2895706A21A53E84BDDBA0B3E5860@MN2PR12MB2895.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(305945005)(66476007)(6116002)(81156014)(81166006)(8676002)(66556008)(66446008)(8936002)(5660300002)(316002)(66946007)(64756008)(110136005)(54906003)(2906002)(52116002)(4744005)(25786009)(3846002)(6512007)(26005)(6436002)(76176011)(6246003)(4326008)(102836004)(386003)(6506007)(53546011)(2501003)(31696002)(66066001)(6486002)(486006)(476003)(446003)(2616005)(11346002)(31686004)(229853002)(71200400001)(186003)(7416002)(256004)(6636002)(99286004)(478600001)(36756003)(71190400001)(14454004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2895;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ukpa6jhpkLBw5D4zMCZaSckyCD+ZA4s2IwmmWPnakk9DAozRkmHw7X6iAsRVkCn8N9chYUMQawj09eF+cfSvRsSwTWT57eqwdfIQKNUHjnkHt+/60C7sABbCVODpae+d5/3EyzAnhbbMSM7O+JrISKJJ2TsUJ/jYyBLdVE8OHw4k7q0rqcFuk+nsNW0Jq4grbYq/HlGRwiXmjwvJsv/GIxN2SqYHugAUX8Wk1rM7/VROKNEgeiHkMRNySQO9m8zMqoC5VKel5uyocu6y6dH/T8Tx+Gma/rTGT+9kWC/iKsLuMRJDF34vkhwVpOJwwnnhnyt3RSRY5+N/gdjff0Z9U8PT3wD6eRyABtb1bsUIlJFy7fXBJm5GxSiUPh5DqoLfhIqXyWtWhSfM+XpFqoiyf5OYLXhRiBzhcnCZ67yhgTs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <410768B264060E4DA9BF74336DA49B31@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfddd106-2f0c-4c5b-fc0b-08d7424b638b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 06:33:05.8642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkSwrq8jobEDJDzNIiJbm1/sv8jQlDaa6CU9FZIJsNTQNA2e+flJhCoEOEIErHjzEj/cj5FBKa0HpTJq6bC9eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2895
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
VFRSSUJVVEUoKSBoZXJlIGludGVhZCBvZiB0aGVzZT8NCk9rYXkgR3JlZywgbm90ZWQuIFRoaXMg
d2lsbCBiZSByZXNvbHZlZCBpbiBuZXh0IHNldCBvZiBwYXRjaGVzLg0KPg0KPiB0aGFua3MsDQo+
DQo+IGdyZWcgay1oDQo=
