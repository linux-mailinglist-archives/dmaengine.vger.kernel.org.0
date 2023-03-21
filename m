Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591E16C3505
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 16:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCUPE7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Mar 2023 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCUPE7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Mar 2023 11:04:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A964A1E2;
        Tue, 21 Mar 2023 08:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eboMZQ40Bzeta44v5ct2F5Gg7FsddNyAltJsgFoI4EWrn1GO56pmItjBOMy3zbnJOcPRC87HHLNJORX+uhlaw4xUEB6J5lLEIrLIdR3DLQ0SwksP9XesWfqkKWUUrNmOROgwOGXa0/LwqT636boac39Nvi6fWEM+fiVbU9aN5yohwO/6L3RvKYQUfAloSasd1fVPEnM88Fg8vDfFFeD5NZNVqmW2y9eiqwMzjffmnQPfrJxDN9QvgoloK9x/ipMwKa8TIqfbSuEG1cm5ZndhgEP6rmtsmj0NPLzC9WLBvrHGux6zwIhtUvr5aMlLmHsevmvnxDHiVY/CdI4KD3GiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y12FJ2Ri35WmXIyVfQj9QQN2C6iPMYyLGd+i/93iEi0=;
 b=QEW3VhDVpzMQtkDkhwlLUsXCAyKD/zXIfBsIhySXXkcXGGbD2hmBD4h50P2VEpGWidHKJbBaNJhxCEviorqRrS5MXJKYM47W1P+4UruH4+U0XicM1zVeRNbT4r8E7Of3sxVUsAoYfRWlfDyf43hGUEendDFNXvIlmpv1cmbCBwhLi4y/bBn7FGxDHn7M6sOa1Z5a7mITfOn5ou9q/05CVbHwmSA1PdAoJyNBGnhbl1xXVVU7tTTiNe0MF4fG8xTWp2n9PwLhoaQyVq0t3JYwsbzqsv/LAR5F29Kxkak6/FS36eh8omzq4IRQoUR40xvITAEbl7ETXxY6/6hHjdHKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y12FJ2Ri35WmXIyVfQj9QQN2C6iPMYyLGd+i/93iEi0=;
 b=lJi2KlbT+VAtHnGbUlCo4By44JA5hzYa+Kctp25mt2P1chJmWRCB4vW+l6TuJrA7lFPAMErrTVEG6JpMUB0nldJzfwdTfmBUqOURBufQnjY5xvmmtskxYK4ijp1eYPf5LbHaBFnOfkouALF6+eCUY6JX2UEOVnNlYDwWhLP4qXU=
Received: from BYAPR12MB4773.namprd12.prod.outlook.com (2603:10b6:a03:109::17)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 15:04:55 +0000
Received: from BYAPR12MB4773.namprd12.prod.outlook.com
 ([fe80::8709:da90:3d87:cdb2]) by BYAPR12MB4773.namprd12.prod.outlook.com
 ([fe80::8709:da90:3d87:cdb2%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 15:04:55 +0000
From:   "Katakam, Harini" <harini.katakam@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "romain.perier@gmail.com" <romain.perier@gmail.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "harinikatakamlinux@gmail.com" <harinikatakamlinux@gmail.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Subject: RE: [PATCH] dmaengine: zynqmp_dma: Sync DMA and coherent masks
Thread-Topic: [PATCH] dmaengine: zynqmp_dma: Sync DMA and coherent masks
Thread-Index: AQHZV+pbJ+vf4sP57UyqGow4SGqg7q8FV5wAgAAFOwA=
Date:   Tue, 21 Mar 2023 15:04:54 +0000
Message-ID: <BYAPR12MB47737C53AA67606A94B223C59E819@BYAPR12MB4773.namprd12.prod.outlook.com>
References: <20230316093318.6722-1-harini.katakam@amd.com>
 <18eb81cf-5a86-781a-0a2a-457bf265e1f5@amd.com>
In-Reply-To: <18eb81cf-5a86-781a-0a2a-457bf265e1f5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4773:EE_|BY5PR12MB4856:EE_
x-ms-office365-filtering-correlation-id: 21dd73d2-c6f0-4b53-95d3-08db2a1da123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NuiIydzhTsnEYNrPWVATAplbe02ovgSEZ4ZTBLwZVTSh4Xny1+ToD4apB2IwATcKLJoEZ4x63yQK2ltqzmGRCcwaOyLl3zpllx4NOac82VAgbU90DVTD8yQRmHDoiaE4Hq+NglRhSH1wEyMjv+7rOIhDcCfO4pHkAGtAHWDR7zsPyQwydgsm8ULHuY7xnDtNw833es7LV1SSQy3gaDhE3aNcqFPiLd1pttARidtzanTOE/rNk0Shh/lLb2lGKAesC7BUCblnctvPjbHyKJpNzE2VemoktZKK3gUvqihTz+ocU/ddNTlPhYNTMohjeE+JNuiH6u64TLm9iymHpfs/uAOvsCpY/67+4xTHgoqo8UHUJZYOJa2DL86mS+qKsirx+9XPMCuR+Ooo65a9+EoIMj8Lmom6TGDnI10XbXYFOF0/jMHHK869b2gkQZdeYF4jh/nnjMC1gTDIVR7uU0ABvZYx5r9KVYAR75OgwQCu3RI+QoI90rOyTccxNOQYCIcKmV9pQRVJ9eVFF1RGacnQMZZGEA2fMB15suIjmt0WLLFREcIGu0WoIIAqZ8Qds0WOXuS5dzD+c8uaTLX7znmtfmm6ikWISqC4Y48ockbmhPLgfetjfBOKjxtm+pV0xSoDEa85LMOfqLH6N+6qmelqU/ZK+DJNmQuQ1YUK6GzJeQNVhKugK7DlumukDWj6/Htx0PKXsmtu2ek0HgsLsTA4yQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199018)(41300700001)(54906003)(66476007)(66556008)(76116006)(66446008)(110136005)(64756008)(478600001)(66946007)(5660300002)(4744005)(52536014)(316002)(8936002)(8676002)(4326008)(38070700005)(86362001)(33656002)(6506007)(53546011)(122000001)(55016003)(186003)(26005)(7696005)(9686003)(2906002)(71200400001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFBXVm8yTHdCczlIckpEb2Z5VkRGUGJrQi9STDVlRk1WejJhdCtUWFdHbTVV?=
 =?utf-8?B?R1JydWpHbUxXQ0NidzFNbEhHMWJkelF0Z2NvZ2x4U0UxU3lpVnUxeng5dFlr?=
 =?utf-8?B?a1ozT2FZdDlkd0NVOU94S2Y2MkcvUkZXQlNQdURSVzdhTUJQNWxPMEQvYzlw?=
 =?utf-8?B?ejBRN0dPUm13NW1PdStEVUZMdDhHLythcUdOd3Qwc1YwWDUwQWhCQWhLM1Z1?=
 =?utf-8?B?bElqeUVhU0tEaVBPZWhNTmRyazdYaUk4dTJNcnR4UzMxQkgrV2M3Vy9VS0c2?=
 =?utf-8?B?WGI5YXJyTjE3ckFZY1RrTnpYTGtyY3hJSGJVVHNqRTBQeVczZWdqV04vbUpp?=
 =?utf-8?B?VlBUaFBFMjdlekRHWU1VQUpBbURIMmc5MUM2aTQ5OGhOZXZsV1lyRVExMWxP?=
 =?utf-8?B?UlBubTY1cGRpU0JpdlpnZ3k3cEZUNUVOaTRNZHJ6OUovOWpZWWZBY2diQTJJ?=
 =?utf-8?B?cTRZcVI1OWxabjZsWU5hc1NoeDdiaS9lOXRsdi8yOGlFL2JsUmplNXlKa2Zu?=
 =?utf-8?B?M1VLaVB6UWhCVDhlQmZqYUxUOVJPdHNMTmIxR2ZMbW42RVV6dnRWQWpHNEdX?=
 =?utf-8?B?aWg1RTkxYXZkTGp0YUxZMFYwd2F2L1R3Wnp4a1A0cDNsZS9kTjgvZHozTjJ2?=
 =?utf-8?B?M1pVcitOS01BWnlZQ1djNVNtV3d6bTRMZ1V0ZGUxMG5wLzBVVDBzeU1SUlo5?=
 =?utf-8?B?VkxSYkYvak95TDBtVkRKNTNualpZVE0xKzVVS0x3YXhSQkRsM0JkV1dyTVR6?=
 =?utf-8?B?cXk5SXhTRTFPWTFUQVV4dm1EZmxMT1ZPaERjV05lZ05LSkhyNGREL1kxcW5q?=
 =?utf-8?B?aVI1MFpjV0txZXpaTElDSUx3Y1BCbU9LTEhVa1hjUlh5T2RsYlFTNlo5SjVN?=
 =?utf-8?B?MlF4ZUc2bDlPckg4Q05vbTBWL05YM0NHelMxMzhScDNmbFhJT3VLM0dEQTVY?=
 =?utf-8?B?S2JyZ3ZjMjVpRDFxN282KzB0Q1liMUJRM2VIejhteGFNcUgzZkhGL3AwVnhB?=
 =?utf-8?B?ekxwTm9laWtWOVZQY2ZzdTFGMFJTQ3NZRVB2UFJHcEp0d1doN2Z3UWxOcDNB?=
 =?utf-8?B?Ti9JOUtOU1piSVBNalBtU296cGtxRXZ5aHdGV2xWdGk4UFpnN2pwY2w4eFB2?=
 =?utf-8?B?QmNPOXNEaE5YTGV3d09obWNzcElUcEQ5cEZ4b2czTzFCQjNWN2dDdGh1cW5i?=
 =?utf-8?B?WVc4MU5jSkxQaVlWOE91bzd2K1ZNYSt1SmpUTEZFRHc3OHI5WEo1M25sTXRo?=
 =?utf-8?B?ci9VRmJFdWtLTy8wNDlWb3VML2R3a3lqMGg2Z1VoOVFwSVI0bDVweDFiRmZw?=
 =?utf-8?B?V1lxUEJjTVBMY3k3TEpmdzNobnJsbU54L0R1emxyZjRPOUxkN00yandtNU1j?=
 =?utf-8?B?WWxpbk5lS3F1dGJyOFJZUGZNUDFZZkZubHNselVtc2lRZkdHejdNS1JyQ09V?=
 =?utf-8?B?YXRuSis5Yk1lYkx5TEE3N2toa0RHTytSZ0hSQ2dQeHQ0bUJWbnAzZW1KMVZ3?=
 =?utf-8?B?enphVHEzYkZsR2U3VDVvRXdkbkh2WXZYYjIxa1BlYVFvOTE3ZDVhWS9YeFNR?=
 =?utf-8?B?WjZqRTdNNUFKSkZINFFZTGJsQVVsbUZhRUkwRk5vZmwxejE0UUw3NU56RTRl?=
 =?utf-8?B?M2t0VHNuY1pFdEk1KzZCalVsanZYNWNwSmhxM3BTY3hMQVd5Rk5xOHlHUngw?=
 =?utf-8?B?VGpCTmFheUgrcHhSL0J4anZoa3RJTFE2ZDg2ZnZGNk4zWlpvS3YzdUtqd3RH?=
 =?utf-8?B?cy9BcCt3QUtwa29GWkhmd1pWcVN6NXFWWkx2ciszZXhrTkpqNTFBdDlRRFVz?=
 =?utf-8?B?QWh4b1Zqa3JkazJxcUI2ZzduMHJYRTB5VWd3cTdrSnBvZVlNVVFnN1psLzcw?=
 =?utf-8?B?bW0vV1gwc0pXYlNJTzQ5eEFrS0M3L1dJSlU1Q2ZMc09STTU2YnM0a1ByS2xS?=
 =?utf-8?B?THZmMEdwWGdUVkNOK3FJa2pjMzE5WEVBaUhCdVdtU3ErWW1Ub1ROMkFObUpX?=
 =?utf-8?B?VXNwNVZYNGJaL2dWTG50dmZTWkQ4S0srb0JYRU9Pa01pcm5lUTNWL1ZYZlZK?=
 =?utf-8?B?V1ZoTm0xZ3R1SW1ZYnFiM0pmMy9jMkJlMVhXYmkwSDB5c0hJRk5ycm5nUUxF?=
 =?utf-8?Q?jyG0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21dd73d2-c6f0-4b53-95d3-08db2a1da123
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 15:04:54.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6deP2rQpvnnsTJdP9oUrjCwoy7JVyxbiIXwBwr6V3wAiSsk0/+EhPqmkPteLBAzh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNpbWVr
LCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAy
MSwgMjAyMyA4OjE1IFBNDQo+IFRvOiBLYXRha2FtLCBIYXJpbmkgPGhhcmluaS5rYXRha2FtQGFt
ZC5jb20+OyB2a291bEBrZXJuZWwub3JnOw0KPiByb21haW4ucGVyaWVyQGdtYWlsLmNvbTsgYWxs
ZW4ubGttbEBnbWFpbC5jb207IHl1a3VhaTNAaHVhd2VpLmNvbQ0KPiBDYzogZG1hZW5naW5lQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgaGFyaW5pa2F0YWthbWxpbnV4QGdtYWlsLmNv
bTsgUGFuZGV5LCBSYWRoZXkNCj4gU2h5YW0gPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZG1hZW5naW5lOiB6eW5xbXBfZG1hOiBTeW5jIERNQSBh
bmQgY29oZXJlbnQNCj4gbWFza3MNCj4gDQo+IA0KPiANCj4gT24gMy8xNi8yMyAxMDozMywgSGFy
aW5pIEthdGFrYW0gd3JvdGU6DQo+ID4gQWxpZ24gWkRNQSBETUEgYXMgd2VsbCBhcyBjb2hlcmVu
dCBtZW1vcnkgbWFza3MgdG8gNDQgYml0LiBUaGlzIGlzDQo+ID4gcmVxdWlyZWQgd2hlbiB1c2lu
ZyA+MzIgYml0IG1lbW9yeSByZWdpb25zLg0KPiANCj4gSXQgZG9lc24ndCBsb29rIGxpa2UgZGVz
Y3JpcHRpb24gYWxpZ25lZCB3aXRoIHRoZSBjaGFuZ2UgYmVsb3cuDQo+IFlvdSBhcmUgdXNpbmcg
NDQgYml0IGFscmVhZHkgYW5kIHRoZSBwYXRjaCBpdHNlbGYganVzdCBjaGVja2luZyByZXR1cm4g
dmFsdWUNCj4gZnJvbSB0aGF0IGZ1bmN0aW9uLg0KDQpDdXJyZW50IGNvZGUgc2V0cyBkbWFfc2V0
X21hc2s7IEkgY2hhbmdlZCBpdCB0byBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50DQoNClJlZ2Fy
ZHMsDQpIYXJpbmkNCg0KPiANCj4gTQ0K
