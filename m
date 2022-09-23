Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128205E791B
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiIWLJS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 07:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiIWLJO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 07:09:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2337511E5E6;
        Fri, 23 Sep 2022 04:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk4J6P2bIy3hOsMbggo3dYM4Dhn9mrshaiCp03cKRJJKkqXyNtOyuOQuFLDOIqGIdfg70FMRkLXS2uNxm9gvbXXYROUV8GS3UR3jqXM+H4DVhHrm/ds6bCeECxAscx1jj9dnjpf1jr5IbxyrXsqRx5epmpGsLFDDQFE602+JYSqf1gElOp3Xpom2uV1gxC8gPTkVwRFgxXy+OtDiN1wh8OCX6MOjnkC0qDJIGnnoI3XREzv5EZOAcKG8xkmK/aXrez/uDtt3Ej7qT++2E/Xr5Mj7eR31sDOQNeFhbgWy71+7RHnjRKvcsgeo+H4OGE3gPQH6/UNm8PASe4X2R17y3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS+CeDwqJ2Ufn/GAwIXnTB57XSjLhhZ7l8DTBMSUSEc=;
 b=X/BxQhNWHr6jLhV/CeIUGfacD/6cwH0ITNKbQdO0tgFvi9x69OIv9rhJRQLjhJjZLcWO4RQ05b+xJmUqAa+cI672jZoSpgE+GE4VJ3yYooq51oG3iTagUmLwhELogvov8+Kkct1Wk6gvjmVmUgBfapsGRCcSRbYt23BUdQaKDA/qQ3AqOQ1EvnKKFs4dNGMIPOBmLlylGdrXJJgtIb6nr+A6ugc3pe+ededphEtaULcNE7VSl7BgE1SzW9n0AUcWyfIFmIVEhWyvIGOLFdiWC/CwHDstXHVEYS43mUd1S+f5Z6EZNKIqFY5joSCBxdpB57VqkQIMIiRpeLyNTejx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS+CeDwqJ2Ufn/GAwIXnTB57XSjLhhZ7l8DTBMSUSEc=;
 b=oB4IS995UFCWrfUBWWAaR/z+1sN5keGj5tURSoCruohE0tGWp8mxWN2qyPZPREqYlA7P8kMYU/fcmGzF6X+zarlvGuPPZTdtGQoPrf38PoJNAbetGCH0sX524rE1Be7PqJu0S0RUlvLBU51+sZBooD3k6cbSpOmj14LIJHVr8v/YsiYHMyaohBD9uxV/oB1JBscphfOD9bNgCz0pBlFfQS1XkYRYTEsXTUqt36peHVdcqAra3e5mQAxaSCCW3aZgf8utW2SPc5oHX5EQBlyhFJjap9ucfmVPFw3VkFLT7YHmres2OKB85TgBfMNYnVmzfcCFUZ6JFa9cJU5mHjG4Ew==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 11:09:07 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::2db9:5c61:102e:dfd4]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::2db9:5c61:102e:dfd4%6]) with mapi id 15.20.5632.019; Fri, 23 Sep 2022
 11:09:07 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] dmaengine: tegra: Add support for dma-channel-mask
Thread-Topic: [PATCH v2 3/3] dmaengine: tegra: Add support for
 dma-channel-mask
Thread-Index: AQHYzBq1VH2N02dZjk2+4dPkKtVnFK3s0MSAgAABj3CAAAoPAIAAAqQg
Date:   Fri, 23 Sep 2022 11:09:07 +0000
Message-ID: <SJ1PR12MB6339660F292E63B2E0CDD85FC0519@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20220919112559.58195-1-akhilrajeev@nvidia.com>
 <20220919112559.58195-4-akhilrajeev@nvidia.com>
 <8d15c575-a490-e1ed-7e97-5a5cdea0925f@nvidia.com>
 <SJ1PR12MB633958099C6DDAA4A428ECBEC0519@SJ1PR12MB6339.namprd12.prod.outlook.com>
 <d2b4a1f5-200f-2560-c249-709e4e2817b1@nvidia.com>
In-Reply-To: <d2b4a1f5-200f-2560-c249-709e4e2817b1@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|SJ0PR12MB5469:EE_
x-ms-office365-filtering-correlation-id: fcb559d3-5e5f-4d84-0ce8-08da9d5408b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5EZV98cmkSGGDE8aAEemhDd5SKCPocBoBMo5j8soBxcQQB0N2o4keZT2uQ9HgTCx0IOZlLbXin4WIhkbyb6XHil169gGmppMVjcUA0QrSSyGttfAbfS0R0inXVmDAqriPSO7j/RqxrXdxBHZGgZhcbE40xOLTCX0kXCNNnNDp8BOD2elOHExgnRKA9MwVuvnjhJa/5s+UxXnFrPKHMlztV2EAZA1HfIHpWc5eHPnnMLu6LuP3id+WRp8ViKovAkW2zsZ9LyGcc6v32DlFC+HCDuvoMD0IfEkw7GhcU6ft3tqe1egVlRs7q9/MUp4gNZ7c9G8kAhyef+5F0E8fv+tXXVJkc2r+P1U0nvkkDPpoUANlsJqK9bAmfiOuPTMzxX8rnagaq7k1uilG1X5Wx81/Yban2gNBkgB98w7C0SuT81+v5wgoJ3tB8Lgc3+DINFdMPzhzOntahgUR8pXuhYodK243YR0JHEv8KXLsWr/+NDWVpaxhc0iAQAU7zUh8x3s24giPPmaCjtrzomu3QCPOITmoZyobZKS9x/5lKRgV7InVQMO1O4uCVNUUlRx/RNZk3Dx486bd7ECqZLC1RR+izZodtQI37Xdzx+nt4bJPL8Lda18uZiZSHg4V7iwagjXl291bAn8XCHl1Sbgq8edxeIgmbAmP3jLN2TesYa9T87WdtKmvht6n+mWzJzpmP9U3/JMcs0OU/ZGDlO3hH2+hD7OM63Qy68WqZF2oYQ7NvcgMFueUDUkyRucU94uFCfTCwnmvgoduca8Te2Wr/34uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(83380400001)(110136005)(71200400001)(7696005)(6506007)(9686003)(26005)(8936002)(53546011)(33656002)(5660300002)(52536014)(38070700005)(41300700001)(2906002)(478600001)(316002)(8676002)(64756008)(66476007)(66556008)(66946007)(76116006)(66446008)(55016003)(122000001)(86362001)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEI2UEdVcTExZDJXaHlnZkJnZWhwUG5VN2xEUEhibW9DditIWHI1ckN5bGl1?=
 =?utf-8?B?L1hkeDJpb1ZyVzR6eVNTNk9MS2pvektrSmxVK1ZtRUhhR2p6UGJaN1Q5ZC9a?=
 =?utf-8?B?M2NLQ1lxbnZNbVpwd1grNjVFZGx3dHBXRi9JdFRzVUFCMGYwSEVqK2xvSGtt?=
 =?utf-8?B?MkJxeTlwOTJES3pEM28vTDR1MEwyeHJsdmxTbk52QWxpSitZZXpVRHFYV3dx?=
 =?utf-8?B?THJHZ04rWU9pTUZTR015NFRrekUwVzF6MC82dHUzaDk3dVczaVhaZkFpL00r?=
 =?utf-8?B?QUQ1NTFSeG9mdWVRSzhvbHBmTEorVGNTT04vV0NnV2FzdVhvTjdMaTM3Z1Ez?=
 =?utf-8?B?Y2ZFTjlBb2hhUkhuWGx5TUQ2YWhIcnMwTWxVamtpUEkvS2RkVlhpU2YycTl2?=
 =?utf-8?B?ZGdsRHgxK1pZODRON1pPUmZDcUMxbUJEeHNDa3p3a3lJd3ZYYUQ5R2RXT0Y4?=
 =?utf-8?B?aDREQzVBQWw1cWwxTGVxWjhOZkFtZkhNWStaT0pLZHVpRXJJY3QxRGQ5WWtI?=
 =?utf-8?B?bEE4MGVkdTdMZjBPMEhrbTJYSkZjVUJkb2hrMDhBbzFKZ3hYRFJHTDh6RlZ6?=
 =?utf-8?B?MldYTWlNVDBBS2F3K29CWUkyRGhhbUxRdTVIbHNPSnQ2WVNIcndFaWM1MW1h?=
 =?utf-8?B?UFcwREZnU2lqemIyT0YrQzJaYk9sT1JtcnpyZGVjVjJlQ2xJbjF6RURzK0NL?=
 =?utf-8?B?c0Ntb1ZhNEJnQkxRZXlVdnFrbjlvS0dTM3VGWUNoMkF6ODN1Zk1TVW0xTUJk?=
 =?utf-8?B?M1c5Qm14L05SNXlqbnltWnA1YkEzbkdnc2JES1F2SU9pd3RKaSs2cFJFcHJR?=
 =?utf-8?B?RThSZHBKVmpSTitGeExnd3NpNExrZCtKQU1LcWlPQjRIZWVoeTA5cFNnZ3N1?=
 =?utf-8?B?MXN2Vm5qQXBCRDhjRitOd3h5RHE4S1YrbTV6bDNDTlNyUW1PcjFsc29ORE1Y?=
 =?utf-8?B?Rk14Z0ZxQ21kRzd0ei9xNG9FQXpLRGJYQlFhb050QUovbjJKTW1sbmxtWHA3?=
 =?utf-8?B?b2dQRlhiSFRIZHZZZ2I5YmNiazdPU050T2JxMlF5cXdNZE9oWWlHenowVW9v?=
 =?utf-8?B?UVZtM3FESG9QTldpd1I0dURvaDBraFBSVm9Ib0E0UEU5WE5idkFNWUxOTmVa?=
 =?utf-8?B?NkcvclNpQlJEa2c2YzRNdVFpcU9STXIyaXNPdDNyWStSMFlZY0R1S0xNWjd4?=
 =?utf-8?B?QTZOMXFPaWJBeHdhU2lSdlM2U3lhdzBuYjFPeEk0T0JzNUZNNFRYN3QvTDFo?=
 =?utf-8?B?Slc0N0VxSnd1elVLNXdhd0cxdDQ0UHQveXlVTUlOUndEV3hvTXdVTncyNU1P?=
 =?utf-8?B?MGk3b0RvVVpYSHZ4ZSszcEp1QVdOUFdYdDhUN252cVJGZ1JVVnhkMTVzZS9v?=
 =?utf-8?B?VGtPVC9Ib2xBWS9udExjNDFGSE5hWXY5ejNnYWlMQm5IOGgxU3ROY0wwNnpQ?=
 =?utf-8?B?bTBvOUdXcTZ4bUFpVzBLZm1aRDQxdFdiY3hZd0QySFo5RXJvbVkySG03VkFQ?=
 =?utf-8?B?WkpEK1kxOXdWVDhvQ3d5SE8yMjZ6YzNLR2J5V0hnZVN0YWV5cG1LVFVXdlYx?=
 =?utf-8?B?Y1M3UUVXalJ6N25qNE9ldW9XeWV5cVhISlZvUXlQN241SG9TUGVRc3hMdWVT?=
 =?utf-8?B?aU1XSDQrYTRYM2Zyd1doQ2ZVQUpqRWRIbW9ySC9NOEF5YUIwMnF4OHZZd2FU?=
 =?utf-8?B?TXJDZ1lEanBnVFJkSFBHRmlUMnJmYzFSWUEzRkJNa2N3Q1hLN2FOcGhLdFFQ?=
 =?utf-8?B?bXY0YWVqNGZab3V0QUlJN3ZSR1lRNkRycVVjVGVSbFIvdkYyVmxMTlVBcVV4?=
 =?utf-8?B?Vjh5NnRFTE5wcmdaU3kvZlg4bzd4ckdnSFNjcGxVWXBUVHhNRU5NOUNESjkw?=
 =?utf-8?B?TjNRMU1rNUUwUy9Nem5JT3BibWRiV2VmN0JrYUZzUm5wUFFwclNPUG1oU25m?=
 =?utf-8?B?cEhqWUY1eHhuc09Peml3VFF4bVJObTZWNnV2UzdJTTUvM3hQRWFzZUpKcFVD?=
 =?utf-8?B?SzdlYi9iQTJzWjRIOUpCQzJOQ3N5TkFjMkF4Y1RhSllJaW5FakR4QkRwOUg3?=
 =?utf-8?B?Z1FsVnZUd2tKN2lzRlVoSkZOZ3JndkFOUHN0S0RmSWVQTG9IazdGRnQyRHlW?=
 =?utf-8?Q?JePBdRY6B3rMPwV7R3HPgAgfv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb559d3-5e5f-4d84-0ce8-08da9d5408b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 11:09:07.4890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+1mTa8m0gb3rw5R3v3J+qr+cAtISQ6d3Gki+NJMOHCA4E5ZpDaa9JNqU9M6KPLrMKJ21JgD62H9gr0LWlXAiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBPbiAyMy8wOS8yMDIyIDExOjE3LCBBa2hpbCBSIHdyb3RlOg0KPiA+PiBPbiAxOS8wOS8yMDIy
IDEyOjI1LCBBa2hpbCBSIHdyb3RlOg0KPiA+Pj4gQWRkIHN1cHBvcnQgZm9yIGRtYS1jaGFubmVs
LW1hc2sgc28gdGhhdCBvbmx5IHRoZSBzcGVjaWZpZWQgY2hhbm5lbHMNCj4gPj4+IGFyZSB1c2Vk
LiBUaGlzIGhlbHBzIHRvIHJlc2VydmUgc29tZSBjaGFubmVscyBmb3IgdGhlIGZpcm13YXJlLg0K
PiA+Pj4NCj4gPj4+IFRoaXMgd2FzIGluaXRpYWxseSBhY2hpZXZlZCBieSBsaW1pdGluZyB0aGUg
Y2hhbm5lbCBudW1iZXIgdG8gMzEgaW4NCj4gPj4+IHRoZSBkcml2ZXIgYW5kIGFkanVzdGluZyB0
aGUgcmVnaXN0ZXIgYWRkcmVzcyB0byBza2lwIGNoYW5uZWwwIHdoaWNoDQo+ID4+PiB3YXMgcmVz
ZXJ2ZWQgZm9yIGEgZmlybXdhcmUuIE5vdywgd2l0aCB0aGlzIGNoYW5nZSwgdGhlIGRyaXZlciBj
YW4NCj4gPj4+IGFsaWduIG1vcmUgdG8gdGhlIGFjdHVhbCBoYXJkd2FyZSB3aGljaCBoYXMgMzIg
Y2hhbm5lbHMuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogQWtoaWwgUiA8YWtoaWxyYWpl
ZXZAbnZpZGlhLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgZHJpdmVycy9kbWEvdGVncmExODYt
Z3BjLWRtYS5jIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+IC0tLS0NCj4g
Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0K
PiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS90ZWdyYTE4Ni1ncGMtZG1hLmMg
Yi9kcml2ZXJzL2RtYS90ZWdyYTE4Ni1ncGMtDQo+ID4+IGRtYS5jDQo+ID4+PiBpbmRleCBmYTli
ZGE0YTJiYzYuLjFkMTE4MGRiNmQ0ZSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZG1hL3Rl
Z3JhMTg2LWdwYy1kbWEuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9kbWEvdGVncmExODYtZ3BjLWRt
YS5jDQo+ID4+PiBAQCAtMTYxLDcgKzE2MSwxMCBAQA0KPiA+Pj4gICAgI2RlZmluZSBURUdSQV9H
UENETUFfQlVSU1RfQ09NUExFVElPTl9USU1FT1VUCTUwMDAgLyogNQ0KPiA+PiBtc2VjICovDQo+
ID4+Pg0KPiA+Pj4gICAgLyogQ2hhbm5lbCBiYXNlIGFkZHJlc3Mgb2Zmc2V0IGZyb20gR1BDRE1B
IGJhc2UgYWRkcmVzcyAqLw0KPiA+Pj4gLSNkZWZpbmUgVEVHUkFfR1BDRE1BX0NIQU5ORUxfQkFT
RV9BRERfT0ZGU0VUCTB4MjAwMDANCj4gPj4+ICsjZGVmaW5lIFRFR1JBX0dQQ0RNQV9DSEFOTkVM
X0JBU0VfQUREUl9PRkZTRVQJMHgxMDAwMA0KPiA+Pg0KPiA+PiBXaHkgZGlkIHRoaXMgdmFsdWUg
Y2hhbmdlPyBUaGVyZSBpcyBubyBtZW50aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZS4gSWYNCj4g
Pj4gdGhpcyB3YXMgaW5jb3JyZWN0IGJlZm9yZSwgdGhlbiB0aGlzIG5lZWRzIHRvIGJlIGEgc2Vw
YXJhdGUgcGF0Y2ggYW5kDQo+ID4+IHRhZ2dlZCB3aXRoIHRoZSBhcHByb3ByaWF0ZSBmaXhlcyB0
YWcgc28gdGhhdCB0aGlzIGNhbiBiZSBwaWNrZWQgdXAgZm9yDQo+ID4+IHN0YWJsZS4NCj4gPiBU
aGlzIGlzIG1lbnRpb25lZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4NCj4gPiAiLi4uIGFu
ZCBhZGp1c3RpbmcgdGhlIHJlZ2lzdGVyIGFkZHJlc3MgdG8gc2tpcCBjaGFubmVsMCAuLi4iDQo+
ID4NCj4gPiBQcm9iYWJseSBpdCBpcyBub3QgdmVyeSBjbGVhciB0aGF0IGl0IGRpcmVjdHMgdG8g
dGhpcyBjaGFuZ2UuIFNoYWxsIEkgdXBkYXRlIHRoZQ0KPiA+IGNvbW1pdCBtZXNzYWdlIHRvIGhh
dmUgYSBjbGVhcmVyIGNvbnRleHQ/DQo+IA0KPiBBaCBPSy4gSSB3YXMgd29uZGVyaW5nIGhvdyB0
aGlzIHdvcmtlZCB3aXRoICdjaGFubmVsX3JlZ19zaXplJyBidXQNCj4gbG9va2luZyBjbG9zZXIg
SSBzZWUgY2hhbm5lbF9yZWdfc2l6ZSBpcyBhbHdheXMgU1pfNjRLLiBJIHdvbmRlciB3aHkgd2UN
Cj4gZXZlbiBib3RoZXIgaGF2aW5nIHRoaXMgcGFyYW1ldGVyIGFuZCBkb24ndCB1c2UgU1pfNjRL
IGRpcmVjdGx5Pw0KVGhlcmUgaXMgYW4gb2Zmc2V0IGZyb20gdGhlIGJhc2UgYWRkcmVzcyB3aGlj
aCB0aGUgcGVyIGNoYW5uZWwgcmVnaXN0ZXJzIHN0YXJ0Lg0KQWx0aG91Z2ggdGhpcyBvZmZzZXQg
dmFsdWUgaGFwcGVucyB0byBtYXRjaCB3aXRoIHRoZSBjaGFubmVsX3JlZ19zaXplLCB0aGlzIGlz
DQpub3QgYWN0dWFsbHkgdGhlIHBlciBjaGFubmVsIHJlZ2lzdGVyIHNpemUuDQo+IA0KPiBBbnl3
YXksIGZvciBub3cgdGhpcyBpcyBmaW5lLg0KPiANClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0K
UmVnYXJkcywNCkFraGlsDQo=
