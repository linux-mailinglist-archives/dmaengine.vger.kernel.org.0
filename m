Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861594A37B6
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jan 2022 17:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243168AbiA3QeX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 11:34:23 -0500
Received: from mail-bn8nam11on2069.outbound.protection.outlook.com ([40.107.236.69]:3884
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234464AbiA3QeW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 30 Jan 2022 11:34:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvC9kWpCdfBLnRWgUHYH4soJWzlJ/zZm8RElr35r3hDBCdRNwjkjMqP3rw4D9TIcuqBGQp7nqx07SNtHBVWgT1vjYSvp1uDrniYNH0mUKZSdHcU6tL2Ch/n4ZJ+W93onW5M6mQemgq0VnUFYz2Of/qzsRoNRNBCiTrAXaDbPonGsnwgwWy0X2xrKVznTQAxMZsvmqWnvrx0THHlQB6U1cNuIi9kfZAiCeeLS46GqctpaDZPNmf9WN8EYSm0oAJPeQL2vhZpwkMr3MJLTaRrGfNgxprog1AAOuotuKXlaHnFGSxl/J6NbTskzidKXUe2rUGUJCJnuynqNLco7790K8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yzcEAo8gkFtU852vLNMOvhwlsfwP0uulb5fC98Eeu0=;
 b=cSPeHuUc9C6uJqxNjN0uXthk5NNmTtyfY6FdwSwLQHw6zoBCy+sh0C+fek9G1o5rvWdP4g1rB4MbBw2jJRHT5/O36atFnezgYV6R5cySrZNQsCJXek4Wd/tG1wO81ANJxfv6YuAJtvkuTeINSk/CiZILsu/YNiivyr8zkUad9fX2Vlx5COFcQtgi16v5rRByyU1cbO3v6zGe7uahjG5WJNn9SGiTtS1QuBn9pyw6/vqDeL6JXi3scnnYFX+s/+HEsmFwDBkG0aYHrLc0+s9E7l62jDXOCBBdSI7PR0KWHVGMmAXcnuAm4MicJtXTygFX+Qy/QAe8PKfogc9gBoYF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yzcEAo8gkFtU852vLNMOvhwlsfwP0uulb5fC98Eeu0=;
 b=Sg0thacZhzSVPuod21Pm29NuZxeN9DlDFg24E3qSKcyNX4NZ8MLqxuH/vnRrIgOblbu3jWQuwhXEFZ08sGdIudlPDVbzQ9bx86bZ/JWYmsOjaw4K9V40Q1cNglHdnDaq94Tv7/1ufQeJQJkr46TeW0NMXzxhO7nr+EUQQQbHabVDI3G9T+bHvfgv+SCZpmdSkryVWuccix7GCdVwBGqAPqSOTNj5yPp9AbZhrxtwBo7XJia8kelOD8/MZfVWIJGqfFDapnnwWwJ+kaIaM5k1NWWsPuUY+Ry9w2/3WEvWV8txVNa6QBvtK4KDV+GQ3mduA4gXABgkG3QVLGmwNgMPjA==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sun, 30 Jan
 2022 16:34:21 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.4930.021; Sun, 30 Jan 2022
 16:34:20 +0000
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
Subject: RE: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYFS8ttZm9vnsYMkmLjfwGSkse9qx7V3sAgABn8UA=
Date:   Sun, 30 Jan 2022 16:34:20 +0000
Message-ID: <DM5PR12MB1850D836ACDF95008EF74CC7C0249@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
 <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
 <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
In-Reply-To: <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62f22b8b-95d6-4a0c-f72d-08d9e40e5df5
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_
x-microsoft-antispam-prvs: <BL1PR12MB53346A53141B3C253F0DB95AC0249@BL1PR12MB5334.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Opc4eQIKGbwUSIn7ftNuJDoLrR17EwDtGh4SX5Pw4+NICDnqJtPmsQU2R+FRx3v/HjKkCgiVzbk5KwfD6W7ns8OjIKcYDcJqMQRf6uqU5QK3GlwSU77uOMVkOgg7FE1x93FUnBLKI8M3ydCyoRTM0fW9eM+RftxV0/efUKxQQLQbrTU3ozTX7rXldhROu83+7jJcJ2NEz3aF8s58fwtfLIBNY90s/VQxhok/wupe7LTM6Cp5/Qa62SHRoGgjLhGGOMM/fKh9zeJPHg7Hju/mTMaTFPPu4G6yWAz+CkRVquh1Ol7lfcHPJ2neUzG8DKkbAsWWAUZAxMnBuAWOpkMz9gP4pOP8vQPVMD1iugyiB6JAdSmOP7it8fP6L6n8MqV3zrzLrPo6SXtNQcI84oYeYUFbkiTNbB6eR/jXUOwZ/+saKOuBufXKMjYwcvJHNn7cFoDywd9iJMUuJs9fUxI3fUK86mRib4OGsjJFjn/ITGPVCU93XZsSwtEjQk6sheryjTIUBXm2/MKXoUeYpi5WFRmru+31A7tcZVF2GRu2yzI21uJ+8JTwuIej2GazbZaGLeZOtvk9Uu8DCSTyO2DqOZhe22zACXh5mJpoMrGckp6q4Gj5aHwGVXAkHmLeGmsZZm6omtwF+fM9cVKFWHePxewUozAk5dps3PgkiNdL634xDsgZyahGOpyjE3yu6lU15RjigVUXO5qqEdXLRDVEh1YRNtsa0EELdC4NgBAfhOqOiqY90iKg24NsMJiP17FYD9DV56EVeAw2fQ8JKW+ymZm1NAsLHD1ECCH1xMVLJpNzYHouSW+SndfjaRGGmWr/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(9686003)(107886003)(52536014)(5660300002)(2906002)(33656002)(26005)(186003)(55016003)(508600001)(921005)(122000001)(86362001)(83380400001)(38070700005)(8936002)(8676002)(71200400001)(4326008)(316002)(64756008)(66476007)(66446008)(66946007)(66556008)(76116006)(966005)(38100700002)(110136005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTJjSzdmdUo3c0hTV1UzdWlzb0srNFF1NHRJUG42QnN0ZTNrdklESjRkOC9B?=
 =?utf-8?B?aEtSdmNXcVBUdXFWeG9Tbk9HTE9rMU14aUZWTlBRMFhUY3R1RHlZOEhnUDlV?=
 =?utf-8?B?QU53TzFaTXFhWUNOUldFYnAwZFFWZ3BXenQrRkdLMkpVMEtvTDBiTnJCUGNx?=
 =?utf-8?B?RktERStubkR5V0Z5OS9TcXNaOUZVZWdHMWw2czFVVUFhUFc4c0ovVzFGWHQv?=
 =?utf-8?B?cjAwTVdiTjcxMnQyTE5zZkVXc1JsVWNIK21WSHROK3lQekNBaEF1YmtOd25o?=
 =?utf-8?B?VnNhZEUzOUZUNkh5V3pIU2l0WjNJQkxDaS9OUko5RzZLNUdON0pEM3hkcEpU?=
 =?utf-8?B?MGIxZmdNMndHSEZ1YXlLZ2wydGdCNFZmUFVqTUNQL2c1NFQyUHIzQWp6QTR3?=
 =?utf-8?B?K1VjeVhQemM2WWZkb2cxWXZxRVFSc1ZuL1B3M05Cd3RsajdBZFRIVkFvOWJX?=
 =?utf-8?B?YWoremhwbG5xRTRJK1ZIeHJKMDdubExHRGQ1QXZkMlhnMTU2bm1ZR0EwSlpi?=
 =?utf-8?B?SnBkSzNiREdCQ0ZUMCt5QnhpdkZkZDZUVGszSHdzOVpuYklqYmhCaVVpVC9Z?=
 =?utf-8?B?OFpVZnlXMjhSSEFMZzJVbHczNHJCR1dQUVoxaWtOVXRHSld4bTVCZkpkaHg1?=
 =?utf-8?B?aWtMSERrazFvbkMvMkROcVZHMTlTMVkwWmtWbnVqOHludU9qUXhPTGk5dlN3?=
 =?utf-8?B?aHA0OWxtOFcvWlJlM1owZDdoMVB6SSs0M0pkMEJNRlJEZFl5WGtjUklrUnho?=
 =?utf-8?B?dG9pN0lYWjNzOTduSWVIR3hHcHhaN05XUlR4S3MwRDIvRU5WYnQybXNVZ3Fl?=
 =?utf-8?B?blhtc1UwQzhkZ28rNlhYU2p5Umd1ZlVFMGtDTjRJZkoxaTlaeUs1Yy9KT0dF?=
 =?utf-8?B?VXJsQzBXNFJKZVdkaEFIVmZhK2dhTyt2QVZoMldWdUZGdEg2SEdneHJDTFBn?=
 =?utf-8?B?Z2R5Tzc0bmh4VGc0MXNyTHdXUlFDTDZ4cFZ4N2FERlFjSDRlbG9wZjRZN0Js?=
 =?utf-8?B?WWRDd2U4WHE1UlBEZG5SQVVGdk9jS2VJN0FERlp4Sk5aNHh4cEgzSzRqMytJ?=
 =?utf-8?B?cUdqZC8wclRWWHdNbzZPMmhqRkQybUZ1ZHV2N1ZEYXg0c3B4Wm42TDdQT1B3?=
 =?utf-8?B?TEh6Qk9teDM5OGhuQjk3RXRjVGQxR21Hek1hYk04cnJVM3dUWGZkNTJmSUhL?=
 =?utf-8?B?VHluc3hTTlNRNXhMYzhwYm5XZVlEcEFtSWdPNXVrQWRFZy9HanZOdXpqRTdM?=
 =?utf-8?B?aG1DTDZVZk9aWTJhYnBJcEZhQjRTaUNyT1ZVc0czamwrK3dPVFlMVG5KbDRZ?=
 =?utf-8?B?aGhZcFlrT1d0QkdsdkFkUXJ5WFMvaUtLWVU4WG1tc2M2RGFNRHBBYk9rdmsx?=
 =?utf-8?B?UUU2OGRxV3M2M2sxNUZoRVNVVjJuUHpPbFVveEQ0V0dyRkJQNnBDS1JKcnFU?=
 =?utf-8?B?MW9DTHVQYzRMUjQ3dTRpaVlNd0F2TEIzRzM2S1B4bTl4dUVzYkVvenZnZDNV?=
 =?utf-8?B?TFR2djZNRGJiaEFIY0R2TWE5VFJYQ1k4NURGSHhNWVB3Z1FVc3hTR2RoNlpZ?=
 =?utf-8?B?TXFaYjNEMkFGQjBaVm00SXZYSlJuK3p2Wm1rSDJZcVh1b0xCZlltc2NqODRt?=
 =?utf-8?B?VUtmMTZqQlhYUXdrYmJtV2YzNHZoaDNMbVZTL0RxRU1iNWJXTnlYVTkzaVk5?=
 =?utf-8?B?U0xXbVhNQVJjZGtBcHRGK0RHOEFSTEMrcENRUUpkbGpkMHp0NnBBb3k0QnZ3?=
 =?utf-8?B?a1RvN1drcWVGRkF2SW9zTlQxdVNTcGd1YThDTms3c0FEL1VGR2xQWlVxbFpl?=
 =?utf-8?B?eVlGZHhrUzlwM0NIVWh3dlpSRjE3OFZxQzI1OWNTek9oTDkzQmIvUlBjSEI4?=
 =?utf-8?B?Vk5RcGZycTl2QlUvWllkcmdmUXNJdFd1c3FkdkhwRlQ4cXA3ekdkRHNXcTEz?=
 =?utf-8?B?MmNuT3VUMVJ6cVpOdHE1bDFJblBUV2FaeVpYNlJHZks1cmJtdnhzQ3lOcVVG?=
 =?utf-8?B?NGZMdWxqRzZmZTNUOUQrSmZPbVp6dUM2UEVwS2FkN1BzbDlXUW0wYk1jZlIz?=
 =?utf-8?B?Zm43NXFWdE9GS0tTdDRTTXl1cC96em1ublZhSGo3WHBsZWE0YXl1aUVkZVpB?=
 =?utf-8?B?THhkWUw0SXBaVGc3RGlZeThuZEtkV1Y0a0tNeXR6VWM5dS9MU0VtT0hkRitU?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f22b8b-95d6-4a0c-f72d-08d9e40e5df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2022 16:34:20.5774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pP69RxeYwmErqP/Y74mk/d5tEQTSrxbsDfYnW4t9HZbAqJGmLnYGVeL8kYAsYqin6KdQ/6Hht+y2Xu9bTt+i0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAyOS4wMS4yMDIyIDE5OjQwLCBBa2hpbCBSINC/0LjRiNC10YI6DQo+ID4gK3N0YXRpYyBpbnQg
dGVncmFfZG1hX2RldmljZV9wYXVzZShzdHJ1Y3QgZG1hX2NoYW4gKmRjKSB7DQo+ID4gKyAgICAg
c3RydWN0IHRlZ3JhX2RtYV9jaGFubmVsICp0ZGMgPSB0b190ZWdyYV9kbWFfY2hhbihkYyk7DQo+
ID4gKyAgICAgdW5zaWduZWQgbG9uZyB3Y291bnQsIGZsYWdzOw0KPiA+ICsgICAgIGludCByZXQg
PSAwOw0KPiA+ICsNCj4gPiArICAgICBpZiAoIXRkYy0+dGRtYS0+Y2hpcF9kYXRhLT5od19zdXBw
b3J0X3BhdXNlKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiBJdCdzIHdyb25n
IHRvIHJldHVybiB6ZXJvIGlmIHBhdXNlIHVuc3VwcG9ydGVkLCBwbGVhc2Ugc2VlIHdoYXQNCj4g
ZG1hZW5naW5lX3BhdXNlKCkgcmV0dXJucy4NCj4gDQo+ID4gKw0KPiA+ICsgICAgIHNwaW5fbG9j
a19pcnFzYXZlKCZ0ZGMtPnZjLmxvY2ssIGZsYWdzKTsNCj4gPiArICAgICBpZiAoIXRkYy0+ZG1h
X2Rlc2MpDQo+ID4gKyAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiArDQo+ID4gKyAgICAgcmV0
ID0gdGVncmFfZG1hX3BhdXNlKHRkYyk7DQo+ID4gKyAgICAgaWYgKHJldCkgew0KPiA+ICsgICAg
ICAgICAgICAgZGV2X2Vycih0ZGMyZGV2KHRkYyksICJETUEgcGF1c2UgdGltZWQgb3V0XG4iKTsN
Cj4gPiArICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAg
ICAgd2NvdW50ID0gdGRjX3JlYWQodGRjLCBURUdSQV9HUENETUFfQ0hBTl9YRkVSX0NPVU5UKTsN
Cj4gPiArICAgICB0ZGMtPmRtYV9kZXNjLT5ieXRlc194ZmVyICs9DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIHRkYy0+ZG1hX2Rlc2MtPmJ5dGVzX3JlcSAtICh3Y291bnQgKiA0KTsNCj4gDQo+
IFdoeSB0cmFuc2ZlciBpcyBhY2N1bXVsYXRlZD8NCj4gDQo+IFdoeSBkbyB5b3UgbmVlZCB0byB1
cGRhdGUgeGZlciBzaXplIGF0IGFsbCBvbiBwYXVzZT8NCg0KSSB3aWxsIHZlcmlmeSB0aGUgY2Fs
Y3VsYXRpb24uIFRoaXMgbG9va3MgY29ycmVjdCBvbmx5IGZvciBzaW5nbGUgc2cgdHJhbnNhY3Rp
b24uDQoNClVwZGF0aW5nIHhmZXJfc2l6ZSBpcyBhZGRlZCB0byBzdXBwb3J0IGRyaXZlcnMgd2hp
Y2ggcGF1c2UgdGhlIHRyYW5zYWN0aW9uDQphbmQgcmVhZCB0aGUgc3RhdHVzIGJlZm9yZSB0ZXJt
aW5hdGluZy4gDQpFZy4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3Nv
dXJjZS9kcml2ZXJzL3R0eS9zZXJpYWwvYW1iYS1wbDAxMS5jDQoNClRoYW5rcywNCkFraGlsIA0K
