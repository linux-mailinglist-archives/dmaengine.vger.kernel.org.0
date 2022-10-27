Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03AD60F4A1
	for <lists+dmaengine@lfdr.de>; Thu, 27 Oct 2022 12:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiJ0KNH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Oct 2022 06:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiJ0KND (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Oct 2022 06:13:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C80C110B25;
        Thu, 27 Oct 2022 03:13:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlYa+CEU0vpl0wTvGQm1Nx9mkljPaQtTfCXMrOs9KVh9jaCQ2aJ95GwO5ExpIp7t/85dnhdMAa1QdbWoJ5mfSdC47sIQFGFEXutQY7cUGIGUDRJyGd2kC8G4hXWXyxOtigMFmXZEpQdwWsWfs+ZdwlV4Um9/kBRyFCfisIOvdqWIP00Lo8ezNmqQab4F03d+CM+jejiiw7X9h+7xNdRG5jKEoEInvEFDL/t5rcj1zC3xwtKg9jkYzEd1rkJ1J/GXEARp01tcYtsssL0JnXjrB8M0YH9ivkemStYlkgJ5tlWzcDVuth45pBZNV3sSdRrti1erz9j2lGR2mwk9SBWUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTl75Elpzlq1EHRcUU9Fav2gqMQ74PP2RYclx0cvLzk=;
 b=MJeLU/H+b3+vNRvl4CZrlXGfRdDf8e6QPC88HnSj86/iPxz0gxVVwoe4KhSw4PJ+fzzw1px7dIqNXD4eQBYtFpRkJ8wIn5QQVeZE3mmT5b0KPuGdZYLpNuoktMiWNsmDw++XuBM0TsGFyh7CuoImamCkZ3DHluPF4AUL8nspVN7iVlg5wSTeut0FYIsLHan7LKeIcV0wGRSdWH5QpLZv40ct6qrapvMMHOnsKRskfTI2idBoZQoSFiYJf/bvF/jPYk8+3Y/+7EJwisDiYpSR6JqnU/n6/PJQSkw1Xn4rD8+X+V8neXl8J9Wfi48UIFIHr0KzCOUU6y7Pf4QHLKnOWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTl75Elpzlq1EHRcUU9Fav2gqMQ74PP2RYclx0cvLzk=;
 b=eY3R/19VQkqViTiFSQCM0kTAsqyu0PAYL9ITfIZ7df6Geen5/1xsbYrkhN6GDYJ2T0nbl/nc5imMRgjBHudfzA8qmuimKtSPH5XCq/yXPvYUYC2TfjFg6clrAwwV1VQ2guFp+w2zUcSMWW+V8vLw9FT0CecRDf0ZWCc+5wngop67os9eYS/wTjPxHiGbH1LGWePU/yr8ut/sRVM2xZJCUHDj25nFhtZIMfw335Ks4y8PRCWNcieAdsDXSAWHC4eRjYkbHpWAcaQvABHWYb9qZMbNfmjwsNLJw74BAZYO3u0VryyzvKn0yrMRo6xJUDWKTqaA1Gjeu0SQPJy6+/7PrA==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 10:13:00 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::a79a:f9ad:49ba:bf32]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::a79a:f9ad:49ba:bf32%6]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 10:13:00 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: RE: [PATCH RESEND v2 3/3] dmaengine: tegra: Add support for
 dma-channel-mask
Thread-Topic: [PATCH RESEND v2 3/3] dmaengine: tegra: Add support for
 dma-channel-mask
Thread-Index: AQHY5F69UPkfFaxUi0yvDnZJOZcJza4YHWYAgAf/RmCAAFXOgIABbF4w
Date:   Thu, 27 Oct 2022 10:13:00 +0000
Message-ID: <SJ1PR12MB6339F181734DA0A05B4862AFC0339@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20221020083322.36431-1-akhilrajeev@nvidia.com>
 <20221020083322.36431-4-akhilrajeev@nvidia.com>
 <20221021021604.GA2181729-robh@kernel.org>
 <SJ1PR12MB63399B01D750CD4725A13A03C0309@SJ1PR12MB6339.namprd12.prod.outlook.com>
 <76617e20-2a1d-baba-719d-bd8b32fa69be@nvidia.com>
In-Reply-To: <76617e20-2a1d-baba-719d-bd8b32fa69be@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|DM6PR12MB4941:EE_
x-ms-office365-filtering-correlation-id: f1f2cb03-b253-40b5-835e-08dab803d3d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KY11xExBgbs1/dvo3AovBlK8C+TUqO1Yv0pv4aBiP+fQJGvpqIgeLrtDNuyz4QVVIsuMbt4fC+uruNPId1TxJtFnYJevCbyWJzn9i4zAy/DeeuufJu/p1prKp1iZxIgojtvc7Haz0r6B6Ym4OzzTfWhV7p0u07KoicQEfda0zqmC0ZNeVEbSNqlKF59yvm2RQTmzI1YVHuSlJXbjlFAqMfGlbCZSq5Ra0qK41J2cJo4yGVCakSSudbrL5Hy2AM+nFVvdh1ACGzSMr9SScz6P74MTneWTtSp9XSydHaUpMVZAYmRsR/d4S4sGy8gLKorAqzIsWEQphs2kFqhYmJtgbC4NBSR1uNwYh4iq1j0L29a3DpK74csMVaodBshdfbMMjZ6oP5W2a9KEH5Hpe83xZ+bsxw6FEGlP60kD2SKUZ5PilGDrWjcFX7xXeKXiqlkjNxb+fO224ER31C39CE+RfBUdCYg5N9rmyO3tMu4NHiMm6B74rWZCWAhK/S04r6BRAVsOSieUT1AhnF6gKhpNezIe0vAy5Bqe3jPUFcivhWdlAfWoh0MzVNiALnRRkQfyWVxpWUpXS8ME0dtNrqXcG3PFYwizw2YMl1y6XgHNyPu70lJ2nOiNuhMCIe7hVhltCqgrP9bju9RWAJH8mPg49KWyHdLYh8vHuLxAvjJrmF3fEz8efVvRlyIs0BrEdvHdf74tKA/i+hVK1L4bYpNpbo4WM3Jqk2N9G0qVDwSQTjVXKIjIbV+d5PBKVanR1yH78MxMeS9nkOi5pJ7BSbRVqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(83380400001)(186003)(122000001)(26005)(2906002)(5660300002)(7416002)(316002)(9686003)(52536014)(53546011)(7696005)(6506007)(110136005)(41300700001)(38100700002)(86362001)(38070700005)(33656002)(64756008)(66556008)(55016003)(76116006)(54906003)(66446008)(8936002)(4326008)(71200400001)(66476007)(478600001)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUpLbWNKTHRzZk16eHR1a2dYT3lzRVMzaUVqaE1MSVpuVWhkYW9JaEh5eXB0?=
 =?utf-8?B?MWRQT3JTdHpscGZ5UlhnWTVqL0dPdk9IQ1NhYm85Q3lTK3VORVloUlk1bzJm?=
 =?utf-8?B?K3BjYmlVNW9HdWh2RUpIVUdjUWFoT0VnMisvN2lwV0lBRWRibXZDN0k5Q1I2?=
 =?utf-8?B?bHNVcVBMb25kNkNzUFpDS0ViRHlBNnhZNDUvdWVhV3cvMnhrMTUyenBEbVdi?=
 =?utf-8?B?RmJNbWgzZFBZODlLbHd3eW1QWkNhc1kzd1FIQUIxTTRTb0xKNkkrL2dtUThE?=
 =?utf-8?B?YVdjclZQU2RER2w5d2NBNWV2N0NFQW5sOVlYaFVtRHJYOFp2WGJ3SE1yTlls?=
 =?utf-8?B?djhsU05iRFNPSm9pZmJpaEdnTGNJUmFiSGZEVHQxZ0N6THFsYkN0MkFLOFhL?=
 =?utf-8?B?R3JxYUh5OE1pamtRVTZNVDNZOTZKUVBudnRRQ1FJVkdMS1k3TlJUSlo5ano4?=
 =?utf-8?B?ZW9DRTg0NHljYXdCTTdaWFVMS1RESGJMaWFpbnVaV2FZUk5pcUx1WWVHYnNp?=
 =?utf-8?B?NStady80NHh5VVJkTytTSENLSHNDaHVuOW9ZTkgyei9uaXozQXh4RDl0QS9j?=
 =?utf-8?B?M1YrZFpsZWltNGZJMGQvYWlTT0FBVmQxOUVoNWpsYXZuU3UvaHpkUXNEbitF?=
 =?utf-8?B?UUd2K2JITVR5aVljU3hOanpESkFwSUVJNnA1eUwxNmlLUCt2Z0pkM0NYR1B0?=
 =?utf-8?B?R2tiWmkwQU8zMnRDQmx3VVFUSHBqQVN1TUtuOWJVTmh2eUl4MGlQKytQbHVH?=
 =?utf-8?B?MzJUVmFZMVhpQjFrTHVDY1FTNmlwdlZISGdWSDczbGJWdHJ2K09ab29ZN0xh?=
 =?utf-8?B?c2lKMlpURnBGRmtSZ1VOT1gzdFRhc2x4bGY5c1lQSldIeExjcTY0d2VJZzJS?=
 =?utf-8?B?MlNRNzN2eHUwekpoQ3N2V1p2VGx4MVYveVlKclFINVk2bEU3MmpES1BIQk0w?=
 =?utf-8?B?U2R5VkhGSG12UC9IM1dBWkp6TXAwdG5mWXVSbUlPQUFMQ3RPTUNRLy83RmJH?=
 =?utf-8?B?c1RTOWEzRmFialVQVnpybDVCVGVJLzYxVGkrTXRVQ0k3U2VNRmY2cnBhUGEv?=
 =?utf-8?B?SWVUaTRvQ1dwTytyem9Ea3d2YXRzNGorUjhOYzFNNml1eUVFS0VXNktlQllx?=
 =?utf-8?B?azJqbTFqc3ZBWUprTCtweXkwMXV2aUtpYnRDbGNnejRnazRVVGZwZFBlQ2FL?=
 =?utf-8?B?bW9mVnhTTVE1OFYybWhzalpGbitxdTNSU1RnTUZadnNJbDFRTTA2VUxnVHFy?=
 =?utf-8?B?SjlyNkNTMDM5NlpxbjlXL1UrN3pWalAzVStPZkkySjRHanF0Q2x6em1yamN5?=
 =?utf-8?B?WFZXTXYybEE5UnJQRVE1UW5LTmxIYVU4TVBEM3RxSWp6U29qN0hBZnZ6VnNj?=
 =?utf-8?B?SVZ0ODd3QjVSSXlKYVBlZ1F0Tk9iNmd0RHltNXc3WStvazFTWlpFc1hEWEZW?=
 =?utf-8?B?U0pCaTRGUEhLVmRXdkdOWmJUdFNxZFlmQ0Npd2pFUUI5M1Q2Sm1JTnBwM3Zh?=
 =?utf-8?B?YUtaSHBIWVA4ei9vL3lGak14SnRyd1YyM2IvRlFLaGZaYUo2cHFMODUwVXYv?=
 =?utf-8?B?KytxWXN1V240UjlmVDEwNjZKRDZOc1RUWVVuQzhDL2VxZis0MG1HUGN2MjRC?=
 =?utf-8?B?VHpER1cyQjJKWG5HanRXcGhCa2NLdDhUZk9OSnhtMkU4eWppUTZZaEltK1dx?=
 =?utf-8?B?dGNrd0c2VWxpWTBlNmRtVjJ4SzA2R2ttU1ljZUFVcnhZVENMRkhVaDhOQ2Nk?=
 =?utf-8?B?aGwyVTI3V0VrWnp1NnNSY0YxMHArT2VPYXFSbDhoNHY0YVZLRGQ4Q3VxNytD?=
 =?utf-8?B?ZEVWN3RZZS9YWkRSMWV1TStFbjBwRE5kOEpXUE54MG9JS1RONmllTjdOS1Er?=
 =?utf-8?B?UjhER2JPbkFONUNpakFYY0Vybm5pck9jZDV2ZUtOVS9ETHR1dXZjc3phc3ZV?=
 =?utf-8?B?dk9GcG0xdzZXZnNyVHBnc0FkSHpWb1JWaHlYZmlCa01WTEc4eFZzK0p0eVRM?=
 =?utf-8?B?ajU4aHUzVTg3Wll0Z3VHSEttYWd2TlZEaEk2eGZVVnB4L05JMjYvNzlxQWZJ?=
 =?utf-8?B?SFVjRXZxYnZ6ZzBMUFBRajJpYk9qVGJiZUlSR1dPSTdTQ3c4UndrY3R5bkdX?=
 =?utf-8?Q?f5b3bq1R8J4uxXuFoTzNiRQJ5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f2cb03-b253-40b5-835e-08dab803d3d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 10:13:00.4718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dHH+/J5M4QOeeOy7Pivaegx5OwkdEUAv7XFk9FJ52ktLjPvK3zvBXHj4wpTJZL28biuY2RCn9SZCWDoE8mNAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBPbiAyNi8xMC8yMDIyIDA1OjQ0LCBBa2hpbCBSIHdyb3RlOg0KPiA+PiBPbiBUaHUsIE9jdCAy
MCwgMjAyMiBhdCAwMjowMzoyMlBNICswNTMwLCBBa2hpbCBSIHdyb3RlOg0KPiA+Pj4gQWRkIHN1
cHBvcnQgZm9yIGRtYS1jaGFubmVsLW1hc2sgc28gdGhhdCBvbmx5IHRoZSBzcGVjaWZpZWQgY2hh
bm5lbHMNCj4gPj4+IGFyZSB1c2VkLiBUaGlzIGhlbHBzIHRvIHJlc2VydmUgc29tZSBjaGFubmVs
cyBmb3IgdGhlIGZpcm13YXJlLg0KPiA+Pj4NCj4gPj4+IFRoaXMgd2FzIGluaXRpYWxseSBhY2hp
ZXZlZCBieSBsaW1pdGluZyB0aGUgY2hhbm5lbCBudW1iZXIgdG8gMzEgaW4NCj4gPj4+IHRoZSBk
cml2ZXIgYW5kIGFkanVzdGluZyB0aGUgcmVnaXN0ZXIgYWRkcmVzcyB0byBza2lwIGNoYW5uZWww
IHdoaWNoDQo+ID4+PiB3YXMgcmVzZXJ2ZWQgZm9yIGEgZmlybXdhcmUuIE5vdywgd2l0aCB0aGlz
IGNoYW5nZSwgdGhlIGRyaXZlciBjYW4NCj4gPj4+IGFsaWduIG1vcmUgdG8gdGhlIGFjdHVhbCBo
YXJkd2FyZSB3aGljaCBoYXMgMzIgY2hhbm5lbHMuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1i
eTogQWtoaWwgUiA8YWtoaWxyYWplZXZAbnZpZGlhLmNvbT4NCj4gPj4+IFJldmlld2VkLWJ5OiBK
b24gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICBkcml2
ZXJzL2RtYS90ZWdyYTE4Ni1ncGMtZG1hLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tDQo+IC0tLQ0KPiA+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvdGVn
cmExODYtZ3BjLWRtYS5jIGIvZHJpdmVycy9kbWEvdGVncmExODYtZ3BjLQ0KPiA+PiBkbWEuYw0K
PiA+Pj4gaW5kZXggZmE5YmRhNGEyYmM2Li4xZDExODBkYjZkNGUgMTAwNjQ0DQo+ID4+PiAtLS0g
YS9kcml2ZXJzL2RtYS90ZWdyYTE4Ni1ncGMtZG1hLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZG1h
L3RlZ3JhMTg2LWdwYy1kbWEuYw0KPiA+Pj4gQEAgLTE2MSw3ICsxNjEsMTAgQEANCj4gPj4+ICAg
I2RlZmluZSBURUdSQV9HUENETUFfQlVSU1RfQ09NUExFVElPTl9USU1FT1VUICAgICAgICA1MDAw
IC8qIDUNCj4gPj4gbXNlYyAqLw0KPiA+Pj4NCj4gPj4+ICAgLyogQ2hhbm5lbCBiYXNlIGFkZHJl
c3Mgb2Zmc2V0IGZyb20gR1BDRE1BIGJhc2UgYWRkcmVzcyAqLw0KPiA+Pj4gLSNkZWZpbmUgVEVH
UkFfR1BDRE1BX0NIQU5ORUxfQkFTRV9BRERfT0ZGU0VUIDB4MjAwMDANCj4gPj4+ICsjZGVmaW5l
IFRFR1JBX0dQQ0RNQV9DSEFOTkVMX0JBU0VfQUREUl9PRkZTRVQgICAgICAgIDB4MTAwMDANCj4g
Pj4+ICsNCj4gPj4+ICsvKiBEZWZhdWx0IGNoYW5uZWwgbWFzayByZXNlcnZpbmcgY2hhbm5lbDAg
Ki8NCj4gPj4+ICsjZGVmaW5lIFRFR1JBX0dQQ0RNQV9ERUZBVUxUX0NIQU5ORUxfTUFTSyAgICAw
eGZmZmZmZmZlDQo+ID4+Pg0KPiA+Pj4gICBzdHJ1Y3QgdGVncmFfZG1hOw0KPiA+Pj4gICBzdHJ1
Y3QgdGVncmFfZG1hX2NoYW5uZWw7DQo+ID4+PiBAQCAtMjQ2LDYgKzI0OSw3IEBAIHN0cnVjdCB0
ZWdyYV9kbWEgew0KPiA+Pj4gICAgICAgIGNvbnN0IHN0cnVjdCB0ZWdyYV9kbWFfY2hpcF9kYXRh
ICpjaGlwX2RhdGE7DQo+ID4+PiAgICAgICAgdW5zaWduZWQgbG9uZyBzaWRfbTJkX3Jlc2VydmVk
Ow0KPiA+Pj4gICAgICAgIHVuc2lnbmVkIGxvbmcgc2lkX2QybV9yZXNlcnZlZDsNCj4gPj4+ICsg
ICAgIHUzMiBjaGFuX21hc2s7DQo+ID4+PiAgICAgICAgdm9pZCBfX2lvbWVtICpiYXNlX2FkZHI7
DQo+ID4+PiAgICAgICAgc3RydWN0IGRldmljZSAqZGV2Ow0KPiA+Pj4gICAgICAgIHN0cnVjdCBk
bWFfZGV2aWNlIGRtYV9kZXY7DQo+ID4+PiBAQCAtMTI4OCw3ICsxMjkyLDcgQEAgc3RhdGljIHN0
cnVjdCBkbWFfY2hhbg0KPiAqdGVncmFfZG1hX29mX3hsYXRlKHN0cnVjdA0KPiA+PiBvZl9waGFu
ZGxlX2FyZ3MgKmRtYV9zcGVjLA0KPiA+Pj4gICB9DQo+ID4+Pg0KPiA+Pj4gICBzdGF0aWMgY29u
c3Qgc3RydWN0IHRlZ3JhX2RtYV9jaGlwX2RhdGEgdGVncmExODZfZG1hX2NoaXBfZGF0YSA9IHsN
Cj4gPj4+IC0gICAgIC5ucl9jaGFubmVscyA9IDMxLA0KPiA+Pj4gKyAgICAgLm5yX2NoYW5uZWxz
ID0gMzIsDQo+ID4+DQo+ID4+IFRoaXMgaXMgYW4gQUJJIGJyZWFrLiBBIG5ldyBrZXJuZWwgd2l0
aCBhbiBvbGQgRFRCIHdpbGwgdXNlIDMyIGNoYW5uZWxzDQo+ID4+IGluc3RlYWQgb2YgMzEuIFlv
dSBzaG91bGQgbGVhdmUgdGhpcyBhbmQgdXNlIHRoZSBkbWEtY2hhbm5lbC1tYXNrIHRvDQo+ID4+
IGVuYWJsZSBhbGwgMzIgY2hhbm5lbHMuDQo+ID4+DQo+ID4gSGkgUm9iLA0KPiA+DQo+ID4gSWYg
dXNpbmcgYW4gb2xkIERUQiwgdGRtYS0+Y2hhbl9tYXNrIHdpbGwgYmUgZGVmYXVsdCB0byAweGZm
ZmZmZmZlIHNpbmNlIGl0DQo+ID4gd291bGQgbm90IGhhdmUgdGhlIGRtYS1jaGFubmVsLW1hc2sg
cHJvcGVydHkuIFRoZSBkcml2ZXIgd291bGQgc3RpbGwNCj4gPiB1c2UgMzEgY2hhbm5lbHMgZXZl
biBpZiBpdCB1c2VzIGFuIG9sZCBEVEIuIFNob3VsZG4ndCBpdCBwcmV2ZW50IHRoZQ0KPiA+IEFC
SSBicmVhaz8NCj4gDQo+IFVuZm9ydHVuYXRlbHkgbm8uIFllcyBmb3IgYW4gb2xkIERUQiB3aXRo
b3V0IHRoZSBkbWEtY2hhbm5lbC1tYXNrDQo+IHByb3BlcnR5LCB3ZSBzZXQgdGhlIGNoYW5uZWwg
bWFzayB0byAweGZmZmZmZmZlLCBidXQgdGhpcyBpcyBub3QgY29ycmVjdA0KPiBiZWNhdXNlIGl0
IG9ubHkgaGFzIDMxIGludGVycnVwdHMvY2hhbm5lbHMgYW5kIG5vdCAzMi4gU28gSSB0aGluayB3
ZQ0KPiB3aWxsIG5lZWQgdG8gdXNlIG9mX2lycV9jb3VudCgpIGhlcmUuDQo+DQoNClNoYWxsIEkg
cHV0IGl0IGluIGEgd2F5IHRoYXQgb25seSB0aGUgdXNlZCBpbnRlcnJ1cHRzIGFyZSBtZW50aW9u
ZWQgaW4gdGhlIERUPw0KV2l0aCB0aGlzIEkgY2FuIHJldmVydCB0aGUgaW50ZXJydXB0IGNoYW5n
ZSBpbiB0aGUgRFQgYW5kIHdvdWxkIG5vdCBicmVhaw0KdGhlIEFCSSBhcyB3ZWxsLg0KDQpUaGUg
Y29kZSB3b3VsZCBsb29rIHNvbWV0aGluZyBsaWtlIHRoaXMuDQoNCmludCBjaGFuX2NvdW50ID0g
MDsNCg0KaWYgKG9mX2lycV9jb3VudChwZGV2LT5kZXYub2Zfbm9kZSkgIT0gaHdlaWdodF9sb25n
KHRkbWEtPmNoYW5fbWFzaykpIHsNCiAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAiSW50ZXJy
dXB0IGNvdW50IGRvZXNuJ3QgbWF0Y2ggd2l0aCBjaGFubmVsc1xuIik7DQogICAgICAgIHJldHVy
biAtRUlOVkFMOw0KfQ0KDQpmb3IgKGkgPSAwOyBpIDwgY2RhdGEtPm5yX2NoYW5uZWxzOyBpKysp
IHsNCiAgICAgICAgc3RydWN0IHRlZ3JhX2RtYV9jaGFubmVsICp0ZGMgPSAmdGRtYS0+Y2hhbm5l
bHNbaV07DQogICAgDQogICAgICAgIC8qIENoZWNrIGZvciBjaGFubmVsIG1hc2sgKi8NCiAgICAg
ICAgaWYgKCEodGRtYS0+Y2hhbl9tYXNrICYgQklUKGkpKSkNCiAgICAgICAgICAgIGNvbnRpbnVl
Ow0KDQogICAgICAgIHRkYy0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCBjaGFuX2NvdW50
KTsNCiAgICAgICAgY2hhbl9jb3VudCsrOw0KICAgICAgICBpZiAodGRjLT5pcnEgPCAwKQ0KICAg
ICAgICAgICAgcmV0dXJuIHRkYy0+aXJxOw0KICAgIC4uLg0KICAgIC4uLg0KfQ0KDQpSZWdhcmRz
LA0KQWtoaWwNCg==
