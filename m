Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810162F7CEC
	for <lists+dmaengine@lfdr.de>; Fri, 15 Jan 2021 14:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbhAONnZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jan 2021 08:43:25 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2533 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbhAONnW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Jan 2021 08:43:22 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60019bd10000>; Fri, 15 Jan 2021 05:42:41 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Jan
 2021 13:42:38 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 15 Jan 2021 13:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcE3AgidpokvxJ+tzy1h1mVJxQa6ot/kVtVsx/YX+KFyenUP4/y1bmkB4daIYa56PZWfiNqq5KMQ4jlY9Sb7LxMqW/g531a7t9WPfngjykCeqw2eX6jRUufnqIgPkxtpdyruX1J5Z3VWM5HsJCEe91GKybURl3PVbwA0RhfK3caROQyGZC2Q+tSBLtQQLyS2hzFH41BBd3hhQWV2D98EV1ugjLanuksH+mYmmwsyzIBdCEqpIxX56w9FFiMPrFAGTeWFsP0RfGbnkD/Fk2/thpNavVLsUTJ5HxhQ/TOIkyXwftb+7D0tx5dgKhS4uCYP9uCh2iij0qz53TjFnHauEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD0yoibQ3hallMVMLr9P2lYrvLnYMQ9g/PokIqYyD70=;
 b=NNwisfNcvXTf3knPL0HXsuzXwLxlKzuLMSyyXlFo8+kJyXiLz6V6JJIUiE45ucZTcYRqJ5w3wrZVaFyes9gJVaa4rFNh3IJHKU2Emkzp5ALfcgkQ6MXGSf8tP7G01WLUTKe6TXFhOL4OqFfAAOsVFizLMUFQh+moF9SyQMsJeFalEl7NVq+AQPuI0z1XKFPgOHd7Z+OkPp8sb5SEEMTwVukLgO9Jx4uPvWDEOYIPiXIJhdodYT9rHQhb4NNYLYwPLrSSL7R2P34XYNIPargmxB+MuBQIn89FDxMlZxtycZxbvnN8BAkkBSeQWq+ldEsajHMnr750aTFJpW9AiKWtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 by BL0PR12MB2466.namprd12.prod.outlook.com (2603:10b6:207:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Fri, 15 Jan
 2021 13:42:37 +0000
Received: from MN2PR12MB4143.namprd12.prod.outlook.com
 ([fe80::ccdf:99af:6ec4:d78d]) by MN2PR12MB4143.namprd12.prod.outlook.com
 ([fe80::ccdf:99af:6ec4:d78d%9]) with mapi id 15.20.3763.012; Fri, 15 Jan 2021
 13:42:37 +0000
From:   Rajesh Gumasta <rgumasta@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [Patch v2 0/4] Add Nvidia Tegra GPC-DMA driver
Thread-Topic: [Patch v2 0/4] Add Nvidia Tegra GPC-DMA driver
Thread-Index: AQHWa8N5oA3kMl/SR0mQgrMXcR0m3qon45gAgAFLWQCAAHwZAIAABOAg
Date:   Fri, 15 Jan 2021 13:42:37 +0000
Message-ID: <MN2PR12MB41438B94148A6D522C056771A2A70@MN2PR12MB4143.namprd12.prod.outlook.com>
References: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
 <2a99ca73-a6e8-bf7d-a5c1-fa64eee62e23@nvidia.com>
 <20210115055658.GD2771@vkoul-mobl>
 <87869e8d-43a3-b8dc-69b0-3c8a488eea4a@nvidia.com>
In-Reply-To: <87869e8d-43a3-b8dc-69b0-3c8a488eea4a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=rgumasta@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2021-01-15T13:42:33.8437404Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=1279c116-dc8b-490c-ba8b-e5415827813f;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.205.247.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 074e686a-0e2c-43f6-59ea-08d8b95b6b9d
x-ms-traffictypediagnostic: BL0PR12MB2466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2466F06C5EF4CB67249D3398A2A70@BL0PR12MB2466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NB43vOf3gRAM9jMSt8pvhNA9gliy/iBdWT85hco6wzee3HuAJgkGSiRIXnFbjaWi4WZIg45dDCzdLaOMSp2XYyW+Sh8F7UcDX0r5v7AQDARiSeHPgCDKksy34r7YLgoN91FfFzSjxNlX6AsnDqOfyXVI13GXeoCaSpJUDhP+7SAprgjT92dF6TZCfCQKwO4KeS+ewvLobnIJ/r2uq57V7ad+SFZ3zGS9NoHEnACVCzcOB+dtu2EgngUNfWJ1BClkW/TRSWgDk+zB8AXvwIgedvwP6uAQ3sG8wFaPB9KQMnZpmz60tUIl0ABfc2w/LyfcEqSfbl5x5oOuX4krZEcICHgY+6udvIlmVmOCOHScFBMom1Fzm+V1xs2bwoypxv9fJmJ8HUGRXHzjRpXVckzaWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4143.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(76116006)(64756008)(86362001)(66476007)(66556008)(66446008)(26005)(186003)(6506007)(53546011)(66946007)(9686003)(316002)(110136005)(478600001)(107886003)(4326008)(33656002)(71200400001)(52536014)(5660300002)(55016002)(54906003)(2906002)(8936002)(7696005)(83380400001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eElNMDdKS2MzckdldmpXN3YzdTlOZ202SXdISjBQdTVnREdnSi9SZjZjLy9K?=
 =?utf-8?B?NTBPSGROMmxrSXFtajl6VkNLdU0xcVVDNVlWc2xwNG9pb3owdlFjdGxmMS9F?=
 =?utf-8?B?OFlxTDZBTWpZRWxidkdFd1pObktiUVpoR1ZSK3A0VTBabFZIbUxKVUZpMmlD?=
 =?utf-8?B?MGdEYklHdlRDdzFsTzdEV3k2eElEM0x2d25ZTEkvcHpXbjdWM1owbWE3NFcv?=
 =?utf-8?B?aXh1VGJpL2hmc3VKaTRPY3F2MStQM2VjRDB2K3NCNzliQWcvSzU5Y0ltRWgz?=
 =?utf-8?B?TXNpUitPUEI5Znl5RUQ0dGtNOU1CckhRZFB4SkRPMEhqNS9ZTFhEVldjc0JF?=
 =?utf-8?B?ZDZhUDdqc2xCcWVKTExEZGMwNktrREpINzQraE9DYUx6dTBHSTRQcHdiYlV5?=
 =?utf-8?B?K2twL09JNWRha25mVGFOczBOZ2tCNjRNa3RxMDQyazlMTFQ4OG5TUWJZVWp6?=
 =?utf-8?B?bmxRWHNiTFIxOXRGaTVPMWQwbzJocnZsaG5PTy9RWnNsTVBHcysxMUkwbit6?=
 =?utf-8?B?eFZzSFJxci9qRW1mWVZJb0pPdzRleDRudW1HcTl2RFRmTjE5QmU5SG10Y25B?=
 =?utf-8?B?YlZ1akdrZ1hCMWZmZ3RBU1kxcE9mYW1XcHo0MENSNDdNR2NCM2lmRUdVOG1P?=
 =?utf-8?B?N3gweUFic3QrRTFxcUFXYlJVcVhYOEU0TUpQN0s5RzFiSTh1TmhRMDMyNVh4?=
 =?utf-8?B?NjZScWp4SC8xVFNHbnI3N0xOdnZldzdNcVBwRnZhMnphY01UVXozUXMzQ2N2?=
 =?utf-8?B?M3dDWUk2ZEhXdCtXdDJrdXJtSFp0MDFuTjJ0UE1EU3ppSmdJZkNjSDd3NFNa?=
 =?utf-8?B?ek9oaWRaL0I2d0RvRExQZHhDdDVWWWZuWW1HZ0NiQVJYVER5SkJiY2c3YzFK?=
 =?utf-8?B?OUpsZUxqbjJTcERIVVBST0tOOUxLZUJvOUFsUVEyUlorM1g1aTllQU9SSHVQ?=
 =?utf-8?B?TzN2Q1F3V29yL3dhaVp4OEFUY0dQckI0dmlNUFc4T0pEQkZNVTlYWHdTN0oz?=
 =?utf-8?B?MjUzTXI4QStaRWg5emx2S0lFam1PVzlZbDR2Q0gyK3hOMHpUbmlBZE12a3N4?=
 =?utf-8?B?TVRvaGZBVjA0V0dma3N6czEyK1FYdklJNkF1S3hoRElCaU55Q2JFM0ttUUh0?=
 =?utf-8?B?N3VnOXdjMytnWGJwdkF1K3BBVXB3ckNIMzVtM3NZZkJ0RXFiUFQwSXg4UTlL?=
 =?utf-8?B?TXNzVEFIOGk0TWRpUVB3eXBrTlMzb3R5ODB6eDhlZ1laZHZhT1pjYlkzTjB4?=
 =?utf-8?B?UlNrUWRIU1F1TlhOZ1QrL0ZyK01pajhrM0JkaDcyZ1lQT2NrMEpQTEg1clFk?=
 =?utf-8?Q?hS4uCg4aoYWzc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4143.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074e686a-0e2c-43f6-59ea-08d8b95b6b9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 13:42:37.0446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVpobaCJ/9MZWzUCqdGWCVE246dy1Yrd4GASHpVWPSLlojRuqu0P0QNEHogFf+IPbqzABDJURQdCncAjkmR/Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2466
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610718161; bh=XD0yoibQ3hallMVMLr9P2lYrvLnYMQ9g/PokIqYyD70=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:msip_labels:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         Content-Type:Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=QAzNT/bcuLKW0llaaa/Qq/gAmVyFTMUI2IDnR8gSSexKhWj3vsSAVsleVTFg9ZZyX
         zhnIr/G7utjvEZUkANYjLT95g3ftVJXVAt1BltOT2HwHUYy/6z1c31h2FqIvY7XdEH
         vlbl7KrsvPZUmzXCQdSQUPyy/i6BJsQwcFoLLlVrDYJOmZ7J7yoN2zE3Kn8Mfe54mG
         WGW4ynSsIUOeUKoVoyE9idMyUXNKf71oDi6yhm5eWrOrvZTfE3NoE+Q3tGP88y44eH
         D7ZYcs9cWA9f//DURyCMGIGiv30W2UAjsyxVulU6xSi73BlNa1X6N8BY88dEOb9SmZ
         sSAf23YktF+5Q==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gSHVudGVy
IDxqb25hdGhhbmhAbnZpZGlhLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDE1LCAyMDIx
IDY6NTEgUE0NCj4gVG86IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+DQo+IENjOiBSYWpl
c2ggR3VtYXN0YSA8cmd1bWFzdGFAbnZpZGlhLmNvbT47IExheG1hbiBEZXdhbmdhbg0KPiA8bGRl
d2FuZ2FuQG52aWRpYS5jb20+OyBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207DQo+IHRoaWVycnku
cmVkaW5nQGdtYWlsLmNvbTsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsNCj4gZG1hZW5naW5lQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtdGVncmFAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgS3Jpc2huYSBZYXJsYWdhZGRhIDxreWFybGFnYWRkYUBudmlk
aWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BhdGNoIHYyIDAvNF0gQWRkIE52aWRpYSBUZWdyYSBH
UEMtRE1BIGRyaXZlcg0KPiANCj4gDQo+IE9uIDE1LzAxLzIwMjEgMDU6NTYsIFZpbm9kIEtvdWwg
d3JvdGU6DQo+ID4gT24gMTQtMDEtMjEsIDEwOjExLCBKb24gSHVudGVyIHdyb3RlOg0KPiA+Pg0K
PiA+PiBPbiAwNi8wOC8yMDIwIDA4OjMwLCBSYWplc2ggR3VtYXN0YSB3cm90ZToNCj4gPj4+IENo
YW5nZXMgaW4gcGF0Y2ggdjI6DQo+ID4+PiBBZGRyZXNzZWQgcmV2aWV3IGNvbW1lbnRzIGluIHBh
dGNoIHYxDQo+ID4+DQo+ID4+DQo+ID4+IElzIHRoZXJlIGFueSB1cGRhdGUgb24gdGhpcyBzZXJp
ZXM/IFdvdWxkIGJlIGdvb2QgdG8gZ2V0IHRoaXMgdXBzdHJlYW0uDQo+ID4NCj4gPiBOb3Qgc3Vy
ZSB3aHksIHRoaXMgaXMgaXMgbm90IGluIG15IHF1ZXVlLCBjYW4gc29tZW9uZSBwbGVhc2UgcmVz
ZW5kDQo+ID4gdGhpcyB0byBtZQ0KPiANCj4gU29ycnksIHRoaXMgcXVlc3Rpb24gd2FzIG1lYW50
IGZvciBSYWplc2guIFRoaXMgc2VyaWVzIGlzIG5vdCByZWFkeSB5ZXQuDQo+IFRoZXJlIGFyZSBz
dGlsbCBzb21lIGl0ZW1zIHRoYXQgbmVlZCB0byBiZSBhZGRyZXNzZWQuDQo+IA0KPiBUaGFua3MN
Cj4gSm9uDQo+IA0KWWVzLCBzb21lIHBlbmRpbmcgcmV2aWV3IGNvbW1lbnRzIG9uIHYyIHBhdGNo
IG5lZWRzIHRvIGFkZHJlc3NlZC4NCkN1cnJlbnRseSB0aGlzIGlzIHB1dCBvbiBob2xkIGR1ZSB0
byBvdGhlciBwcmlvcml0eSB0aGluZ3MuDQpJIHdpbGwgdXBkYXRlIHRoaXMgdGhyZWFkIG9uY2Ug
SSByZXN1bWUgd29ya2luZyBhZGRyZXNzaW5nIHRoZSBjb21tZW50cy4NCg0KVGhhbmtzDQpSYWpl
c2gNCg==
