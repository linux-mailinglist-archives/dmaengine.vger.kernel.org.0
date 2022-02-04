Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5974A941B
	for <lists+dmaengine@lfdr.de>; Fri,  4 Feb 2022 07:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244905AbiBDGrp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Feb 2022 01:47:45 -0500
Received: from mail-bn8nam12on2079.outbound.protection.outlook.com ([40.107.237.79]:16576
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233514AbiBDGrp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 4 Feb 2022 01:47:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LS19IeB46Ce5vTnQTF5D+Qw7Zg3d6nFV8ZGJVFp/6sJbYuSpJXk8p2zFu4972PnS9jiJTcb/GClHMDBF2KBgEg8IOoIa0icNd11Mn2N565Y6Xl2/A8ZmgVh9n6Y/FChldebBTXcDacFarqgm6IodFeQ9w2vrVTw8FQWEfRIsordvUUfNGNY3pQzwHYy2XEmBPRy6/JR7iKEEQ8iqQpCO0YtPuG6f8orLM0rga0144hsU4CGHsXa3iJTXzAlNjyW/3AVhaY9dz+9q1awSjWQ1evQqawR3K/skP6AWkI0mIjXeyTrUuaA8zedQaQenGunJX8swZzValb04OlX6yShEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVl91QntY4ox5L0E3hz1VV1ZaE6wmMmzLgLMnAgKZfI=;
 b=dCeK2H/NI3c2vfSeIT3QiQ9IQJqkxX6RkFyJzsFyjypDQlB/pu6DYauA5Bq9zJxPNub2FNy/KzIa4hefFbll6fResAeetkQYk86ClocmA1KfWPjNsVpPLumBQvF1cMsoymBHmYq4CjjMwccXKJEjSDBXgNXA+L/Gqr5UzBlxI5igRmI87JZrOZaM8V01crDh0Xvitkw+v+6NA/EdWYtuLefc6uZ9N5NeegL+Sg9DWZJ8HvwTk+H3vc3xLnvgLac3qgT0/JjTWWCzQKJ9vHiEr9AJyFVtmqDTRHCBpdCjMjeBeYTOIwwwZvdd9MkhsODm1cVTyyZ3LxCEj/Ja5uE4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVl91QntY4ox5L0E3hz1VV1ZaE6wmMmzLgLMnAgKZfI=;
 b=eD8efaLsYv0A5SGom1JTP3bdBRrThiama/TTC8Ft+7FAlPcm0Q0XiCxdmOguOQmswNywK53D+KBlozr6tnQMeSGrE9cg9+xQ/fpMILAIr9SiihcjYwxUmrlrJZzimA7KRlefYsYecbpFf48ydEHOfVJn7yXvGZqEajQCB1uiO1ji1BXiZjWNWmsJiz1/jyWuMOmqZg5UY1BlfsKkrCPXNx4YzeCBv8D/a4fkfdON+8ICPEvj9hKbLj0lJ5lykGU1DqEmkmDApnPK9EwI9kyotHvJqo7DyHr6V7Mx3cP+6wcR2IU7MkrMXrANFKlYBLB1C2S3Um6Qnph6UNhywNYkMQ==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by MWHPR1201MB0174.namprd12.prod.outlook.com (2603:10b6:301:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 06:47:43 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 06:47:43 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v18 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v18 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYF4A/XHCT9pN4OEO1Gc8heOMMp6yAaLaAgADG1FCAAPeOgIAAvqrA
Date:   Fri, 4 Feb 2022 06:47:42 +0000
Message-ID: <DM5PR12MB18501E2343121A9FEE013F15C0299@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1643729199-19161-1-git-send-email-akhilrajeev@nvidia.com>
 <1643729199-19161-3-git-send-email-akhilrajeev@nvidia.com>
 <3feaa359-31bb-bb07-75d7-2a39c837a7a2@gmail.com>
 <DM5PR12MB18509939C17ABEB5EEA825FFC0289@DM5PR12MB1850.namprd12.prod.outlook.com>
 <d6d70e52-a984-d973-f3bb-f70f1a4ce95d@gmail.com>
In-Reply-To: <d6d70e52-a984-d973-f3bb-f70f1a4ce95d@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70c374df-0b94-4856-e5de-08d9e7aa3e98
x-ms-traffictypediagnostic: MWHPR1201MB0174:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB017402CCE61E18D33824E243C0299@MWHPR1201MB0174.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pajCf+hAnRhHqCtSgGwOocmzCP7bvVI/CxdaSlPT8UXD/52Sdkc5BW9ydwP5S6PMRsIX+3qjKPnCUMkuFcZdIRiNXkqlfRi2QCFW3iwqF5JztxHOAvIeEyH3GjFNZxArGOdpHxT5YkizlYN7jllSdnGdYEDy07T5cEI6KPS9SX8ZsSWotwCl8q3vVvAedgnKlt23Cvbcwn/zTq8ambtPqhpMuffEKzm5zTvlBOAFTwoLGebYdazWhF0OPfXD7PCAFom88ZFeDjRZmmfYoUtJ4AkiufkJLIg3ar6GBT0Hzifk7dsBp1BVKQCO8GhfRO2tpGAz2wyRt9eufVlSYt/6Qaz8lQKwmN7J0UXll6sPz2LZPjZs8s6a15X1hfFK8W2UXlG6C3+L3y9eJMdyUtGYaH4Qpf9xKNt1r2XFGCFXj+Q3rhv0z51NZ699jQN2BPWqbQw9hD8WRb+kvB6i8u5j2vXxOufjS2G1Qx3UQL2uifpIKUMc1V2X94e+THSJHNUWyu9jW6sSpPjTaZQbpL9EBwfdZmkv7gOsg6jsQKyLMtpfsBw6Ris+mqsaEb7T28is1YwxoOI9dvCsm0HPaH+RNtoNlZayxlDJvhZx2+jTX9223mwOaCq6wEEDUM7qAtp69nlIPpZ8fiZWzQ1r74ZvhVaX9alyuf+0F9X9kCMLCatcld6Y9S9g5yApnRW49WuWC0tbRWoFwSS8tTB05v3bXUGkuzNOHdu6UsJHM/mCmNs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(66476007)(66446008)(316002)(64756008)(921005)(55016003)(86362001)(4744005)(66946007)(66556008)(71200400001)(4326008)(52536014)(26005)(186003)(110136005)(508600001)(76116006)(8676002)(38100700002)(5660300002)(2906002)(6506007)(7696005)(9686003)(38070700005)(83380400001)(122000001)(33656002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDFZeVZWT3daRWMvVDZpb0owZ2tKTTFtbE9sajZsVEFGNlVMS3FFMjhBVE9I?=
 =?utf-8?B?ak04b1ZVNHorNVZlY2ZBL0hXZzZOQkZ5NTM1Y0ZudXg3dDVwNXU3VUtlQUI4?=
 =?utf-8?B?Vmp6VktXazJwSkxrRUhZYnRMbklmV1NGSVU3QkFES3RXbXo5UGtMTXJTTGQr?=
 =?utf-8?B?Z2dJVFNCUUF5ZHYxU1dUSWJkNXFMKzJzTXZYd1JYZGV2VkJKcnZTR3JCQUJj?=
 =?utf-8?B?WlBvbEZaZENaQWtWUUpPbXV4MzFrNDNidjZoLzU1ek1qbnlHWVFzTnJmYmxi?=
 =?utf-8?B?VmkxQlYzS1A2SE1MbElIa0xiTnNiKzBqeDFWdGlIYVFrMFFaWStjT3c5N0o5?=
 =?utf-8?B?THV1NlFCSXd4VTkzZ0NTN1g0UWNpLzJOd3RvOFBOV2RSTnF0TkRSZGRDV1M4?=
 =?utf-8?B?K2F6S0VjVjhzREU1MHo2SEJvRUxId3NreTFZampzOFdsSDI2RXM5MEwxTlR5?=
 =?utf-8?B?V3piSTFOMDE2VlpYVlhWMmdVVHc4U2FFMGI3VEhua2xFc0dxenVVdGxXS0J5?=
 =?utf-8?B?enBSdGZiUTEzMG5raGdiRm41YkxvMkcvdjJJcDc1RzNnQUdZTG8vcjlsUTR0?=
 =?utf-8?B?MXh0Qmg0L0J4Q2lHVXhzaC8vMnBROWt6dUhqRFpyaStBRVNYT0JJUGJtQUJF?=
 =?utf-8?B?Qnp1MThvSjVmb1NqZ2szQVZVSkhCZ3U2Vmc1bXJYbXNJTElRcjJDc01wOFlV?=
 =?utf-8?B?R1BnWU1nRkc0YlZZVERlZWxNd29ocDVPZjg1c3JRNjJSVDY1dE8xeTdpRDdk?=
 =?utf-8?B?MUhBRmlwckMxMG9ITStWZERMdFYzS3VoN0t2UzQ3RWFSUkRMMVBpd3JIVm12?=
 =?utf-8?B?Tmx3a0UzdFlNY3NoWVg0VE5FUlFCOUxML3N4eEdYWFhrVVJzSHUwVUkvc1I1?=
 =?utf-8?B?UDVvYXRvV1JHenJUNS81V3F1S25iemFvNWczMkFrR2l3dzRHZUlWakF0Mkor?=
 =?utf-8?B?M2J0MmZsYnEveHYyNllnYjF3WENxc3ovUnBEeGhZdmREbjMxSTNCdS90cGpK?=
 =?utf-8?B?bmxXWjNDQkpDRjdDNEt5djh3WE9USnU1R2RLa3NLc2hCSmtDRjUrRVdpdmxl?=
 =?utf-8?B?Mm9vRUhadXF5bFZLTzR0VFJxbHlydCt1K1l4cG5LMmJHanVTTHFNaVU4Sjgy?=
 =?utf-8?B?WlJMV05Sa3lBSXBaQ21NU1M4NS9DU1BIbkduTUtKakRqaFdjeWlobzQ4YVRL?=
 =?utf-8?B?NlVnMEtST01ubTIyaFpaTWhxMS92c01GT1YvZTh2d2FLYnVLVU1jM0RQRXp1?=
 =?utf-8?B?MVlaTkR6T095bXRSUExnRnJ5bFNNQ3BvUVo5SGRFbVZ5ZitCbXZ1STM5eVph?=
 =?utf-8?B?dFhzT1R0R3gxRGVsYjhIZzRRUUdXWE1UUjB4elZMRFVaNE9PTDFQWFpwYmxt?=
 =?utf-8?B?NWZrOURreFZlb2xhZDhiaitVa1gvQ3VYZTQ1TUJSd2lsZG5WSGtldk5nQUJZ?=
 =?utf-8?B?MjdjVkJpanNPcHFlZTNuQzlnRnprSGFuRWZFRnA4TVAxNUZ4T2NPQUV0T2lx?=
 =?utf-8?B?YlRPOVZTc1FoaHR1ME04cCsxQ3Y4RXU3OXJHZjVFQ3Q5Q1ZRZVFBYmc2ekkz?=
 =?utf-8?B?UHdrMXFidnFPWnB5K2xPRmUwZ21mWEYzT0ptZVdjQW9GZlN5dlI1TDNjcDJi?=
 =?utf-8?B?d2JDOWpJdE9lNEFhdHBUenhOOHI3RUdPelZEY3k1eDZUOVZMcEZweUxaN0RX?=
 =?utf-8?B?NjlRR3NKS1lrTk9oazArREJhVlJXcWRwVmJ0bFlveXRDeUtBVmJ4NUFTL3c3?=
 =?utf-8?B?NjVSMDZTMHlQa3dhM3NGa3I2TjF2aDhMZ0VmdGYxQXJNM3hSSU5UYzF3elVj?=
 =?utf-8?B?ZEc3NEpYSkVoeU5vNnJWR3hVZTRLcHFEMEpQMEZMb1FRS3hrR3VmS0RnQkxT?=
 =?utf-8?B?R3JCd3VKVGZtdGF3WGpxV1dwY09scnNGbTRLUFdRYWdlUGgxZjBCRmxxV01B?=
 =?utf-8?B?QkZTWkZpL1FQZkVCVklVNGhCU1JETmNCTzQ4YWVDU3YvMCtNbStvS0w5aG9M?=
 =?utf-8?B?c3YvREZMeEdyRkNSRGo2djl3cS9vZlBkK1VrODVpYTJoa0JrNTBPczJQcTlH?=
 =?utf-8?B?WmNWeGlRWjZFcmhJdFNDWHBCWE94M2xqVVA2Ukd5R0VGbTI3WTREaXovUk1R?=
 =?utf-8?B?MzZoSXAwTkxzbnRRYkNBUFBEeHVOU3F2d1p1Q3pWbklJU2dDaFdFaEc3Znhj?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c374df-0b94-4856-e5de-08d9e7aa3e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 06:47:42.9362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASlOV/30Sxo8RRUe8OQ2EnIbsirzZvFLaaPRK1fbNJUKtvuksG0JK01i5x3pXRuJ+yUpBA1AZbT+jyjFG48Y3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0174
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAwMy4wMi4yMDIyIDA2OjQ0LCBBa2hpbCBSINC/0LjRiNC10YI6DQo+ID4+IEJ1dCB3aHkgZG8g
eW91IG5lZWQgdG8gcGF1c2UgYXQgYWxsIGhlcmUgYW5kIGNhbid0IHVzZQ0KPiA+PiB0ZWdyYV9k
bWFfc3RvcF9jbGllbnQoKSBldmVuIGlmIHBhdXNlIGlzIHN1cHBvcnRlZD8NCj4gPiBUaGUgcmVj
b21tZW5kZWQgbWV0aG9kIHRvIHRlcm1pbmF0ZSBhIHRyYW5zZmVyIGluDQo+ID4gYmV0d2VlbiBp
cyB0byBwYXVzZSB0aGUgY2hhbm5lbCBmaXJzdCBhbmQgdGhlbiBkaXNhYmxlIGl0Lg0KPiA+IFRo
aXMgaXMgbW9yZSBncmFjZWZ1bCBhbmQgc3RhYmxlIGZvciB0aGUgaGFyZHdhcmUuDQo+ID4gc3Rv
cF9jbGllbnQoKSBpcyBtb3JlIGFicnVwdCwgdGhvdWdoIGl0IGRvZXMgdGhlIGpvYi4NCj4gDQo+
IElmIHRoZXJlIGlzIG5vIHJlYWwgcHJhY3RpY2FsIGRpZmZlcmVuY2UsIHRoZW4gSSdkIHVzZSB0
aGUgY29tbW9uIG1ldGhvZA0KPiBvbmx5LiBUaGlzIHdpbGwgbWFrZSBjb2RlIGNsZWFuZXIgYW5k
IHNpbXBsZXIgYSB0YWQuDQpUaGlzIGlzIHRoZSBkb2N1bWVudGVkIHdheSBvZiBjbGVhbiBleGl0
IGZyb20gYSB0cmFuc2ZlciwgZXNwZWNpYWxseSBmb3INCmN5Y2xpYyB0cmFuc2ZlcnMgd2hlcmUg
dGhlIERNQSBpcyBjb25maWd1cmVkIGluIGNvbnRpbnVvdXMgbW9kZS4NCkkgZ3Vlc3MgaXQgbWln
aHQgbm90IGJlIGEgZ29vZCBpZGVhIHRvIGRldmlhdGUgZnJvbSB0aGF0IHVubGVzcyB0aGVyZSBp
cw0Kc29tZXRoaW5nIGRlbWFuZGluZyBpdCBjb21wdWxzb3JpbHkuDQoNCkkgYWdyZWUgdGhhdCB0
aGUgY29kZSB3aWxsIGJlIGNsZWFuZXIuIEkgd291bGQgdHJ5IHRvIHNlZSBpZiBJIGNhbiBmaW5k
IGEgY2xlYW5lcg0Kd2F5IHRvIGRvIHRoaXMuIFBsZWFzZSBkbyBsZXQgbWUga25vdyBpZiB5b3Ug
aGF2ZSBhbnkgc3VnZ2VzdGlvbi4NCg0KVGhhbmtzLA0KQWtoaWwNCg0K
