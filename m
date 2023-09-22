Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71027AB101
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 13:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjIVLhB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Sep 2023 07:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjIVLhA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Sep 2023 07:37:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254FFAC
        for <dmaengine@vger.kernel.org>; Fri, 22 Sep 2023 04:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOmyO06g/r5FReTif+KzSoSJ971Y2C+lqp8p3zs0pfyLz38QDSNWLld/wxcOqCIB8PUddxAHKiO3Ld6zTX5u1nMOJtWM+MGWNMAufSGpPRCtrsBAxMsk/D3O9n50LUjyLo9uAUQHiznvNsEEtm6SvsCS1ZmGdzXJTeUgU9cZ2RMS/VY0FmtKmZimjZLir/JVi7gPptFrnV+TTJAwta9IUWzIaKzyXKoXsFGvSBz19ck3iNdTZ1EVvhoSFdeApikVCDgmyEtivdrnNjRGmwq9Z/f8UKo5MrGsezSNkJPyyTLfvwB8FqDMptm0zEJNOc27ujl9K8U/+7ZSR4mozC60sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLpO0r4fE8+MjKlfkFEnJZ2KxoOed2QNNclop82GP7E=;
 b=kJvzYjbVg+rswAnk43Tk6gZeoXDEhUY+B98wRCcm1DGh0C0tipkSFKUxdgE1nsgZwmdSJkw79fpXkGkSY10AkFaLc8WNA2aQyi/bBOmPyIOYMIQoLAAveqP/Du0+JzCzFBS8BykjwUEgpzdcTWvgrqoCk7JvwOgHFHoSPHHEhaCi+i3QhaWdZSKVhpOftiRL5YbNiXfw81fo7NBpwnVgrBJwP5AHAvegFf8gzKErHHqEWEpJlwNAfT+yJXRjWZoMlr+MJZ079nflk+7jqoLbXx8gQumE5zgcg9OKYQfTdeRsYbfaZLLp8Qh74/sED24RrIwWbclXxBt2o7xW7cSogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLpO0r4fE8+MjKlfkFEnJZ2KxoOed2QNNclop82GP7E=;
 b=jNew28toRPdO1D53o7KPRGS6TlWvowIR2DdwJ7/QHRbKkeMqM78MtolzzbTPML3e3pM3azE6UYBprWt1v65JjB45+ymonXfcopvNi7AI6Feo7vbKJyWLJbymnwG/2zMyXA3Mjvm8FdWjybWC81IV03uUbVvBKaSGnaYQsNybZgc=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 11:36:50 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f%6]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 11:36:50 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Vinod Koul <vkoul@kernel.org>
CC:     "Simek, Michal" <michal.simek@amd.com>,
        Rob Herring <robh@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        Liu Shixin <liushixin2@huawei.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH 57/59] dma: xilinx: xilinx_dma: Convert to platform remove
 callback returning void
Thread-Topic: [PATCH 57/59] dma: xilinx: xilinx_dma: Convert to platform
 remove callback returning void
Thread-Index: AQHZ6v2+GehuywWEQkW+vTJLH2ZtsbAmu0UA
Date:   Fri, 22 Sep 2023 11:36:50 +0000
Message-ID: <MN0PR12MB59538717A8FEA06243DFFBEFB7FFA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-58-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230919133207.1400430-58-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|BN9PR12MB5067:EE_
x-ms-office365-filtering-correlation-id: 9b7e804b-27aa-4c85-0c04-08dbbb603661
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6L33yJ7u8mzrX7JcdAJx1StBZK92F3fLXiTQiHuD8hb+EjL9jUOA8i5f+FO7IONL5zA/8ceoDKSYx74zJaE4ZJwQogEE16uHFbtT7SKKebNQpIPKhs8d253yBjX6467nTzzne+Op+rFxVqIk9tl5SIHQ4lOox2Zl6dXrKIbmoq+JnpJBlgGdayQqazmnmmR5jKM1X7GCO76yrwBAxC2UT67/wbaJitfpuscmk4KFTUGzV+b4Dck5x/lb54Jt7un1cil6I/yPqKEr7RR7u9TNfl90OoD+0BwDDGkaHYeSTZUzcHamkj3UTu8GpLm/JcZ9vRow8jthxdJPaxY5L/aU5o03cMWbWCmb4NWEjxVN8h6BL5dv9urzMnQJuE49nBra4TpoExiD01KdCkBihhoIwd7wbflISbPzgoq+pZticUnksVkRo3v7FfDO+dhBfUF850a9PHQJyZN5KN0f+ZGsmdlwm0qrh9mJuI8R7iG2spCvGHy4o8vPgsgJ52oCHmeQcp0nBKhZnxBFhARgoB+C1Up1gp++r065IrydUSjGSSCP+gQVsg1N9MwWtmwcqy5p3FNGEPvHJ2fqbkBeoi/GeiqjNyCYVMvyeIVut3zcZHIV7GYirV2Ca5M5k3B1uhw7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(186009)(451199024)(1800799009)(7696005)(6506007)(9686003)(53546011)(66574015)(26005)(71200400001)(33656002)(76116006)(66946007)(110136005)(86362001)(478600001)(122000001)(38070700005)(38100700002)(83380400001)(66556008)(66476007)(66446008)(55016003)(4326008)(8676002)(2906002)(8936002)(52536014)(316002)(64756008)(54906003)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1d1WDk3ZzMxVVVibERDU0wzTXg5MGM5YlgrVDNyUG9GSS9DUUVINHVNdFNJ?=
 =?utf-8?B?YVBSUXl0aUZaZEFlKzhJZDZBYjBwWmdTZ2dmT1FpRS9kd1VUQityUkVSM0dO?=
 =?utf-8?B?S2c4ZWk2Q3djT2t4Z09JMm12alBHa3JVMW1hQnUxVzYzYnRhMlhQOHF5alBa?=
 =?utf-8?B?Tm0xZWRPMzJUYlduODdrVXdsd1BqcFdpZ0pSVGRDaWpSRzRiT1JzLy9TcUY0?=
 =?utf-8?B?WnBGcUhKYnpZTFRlbkFwZHJOaTFlY1Ryb0JaSGFWN0VVVkQvVCtEQTRJaFcz?=
 =?utf-8?B?WFU3MlFIWmEveStONWVEUWl5Y2M4dVMwck03OW8vQ0tjcmdPUEtUbFIrZVkw?=
 =?utf-8?B?WGJwRmszeWIydDBkZ1VHbHExWllleW5pZk1QZFVkRUtMSkE2NHRTSGxnSWxr?=
 =?utf-8?B?WEI5VlFJcGM0TjhsaWc2eHhCZlQxOUZOQzVobHhrcjNiSHNlTXhRd1Q0OXJm?=
 =?utf-8?B?ZFU4aldHOERaazVhdm1XaW1DWEV5OElPeW9rc1VDNHQveXVWenNGczNPOGRD?=
 =?utf-8?B?d0d4WG52YjNvYzBJU3JERFVQVmhCZGRTK0NSYVBXZEVITVlrZTZvN1UyR2Jq?=
 =?utf-8?B?VkVTRFRpZ3RZeGFncE96SnBuUTU2cGh6ZWVyVU1Wdi9pZXNJMlRtZis4RkVC?=
 =?utf-8?B?YUpTU2gzNVlZZWxEcEZOYXFvaDRUQ3hMVkp3empmQjdiNEVjekw0ZGRqM293?=
 =?utf-8?B?ZWVoR09kYlBPVW0rS2dRWGdYZk5WT0RwWHI3aHlUamU3YkVNQmRyL1JUbEJC?=
 =?utf-8?B?S0t1U1BIZysvbFV6bDlwcE1xdWp2QmYzYmlFSVFLM0RSOUJkcTRTelRmQkRo?=
 =?utf-8?B?OXJtL0ZLVzdaNVpPdkxoSCszYytNUU1FOWVtUGxEMDBpenZzdVZ3ejFFeFpq?=
 =?utf-8?B?ZzlOTUU2L09wY2Uza1hWSXdiQko4K1FYWk5CR0VYbU9jT1NsdDF6NlBSQXJv?=
 =?utf-8?B?MVRjVDRhTldrWGVDYks1d2VuTmp2VUtyZ3FLdDZUWHRYbm9oZkxRZjBVS2tm?=
 =?utf-8?B?NTMzSERmc3RtakdWWTE0c1JqR3FVd1NtdUszNHk0bzU1RTBSNDMvMm5KN1JX?=
 =?utf-8?B?cWxYYno3R3dSbllDL01ZMmJzODhIaTVZNkFsRlZ3Q2haNUg0d2FpdEZaSEFv?=
 =?utf-8?B?WnUvdytncjNjOHNRSndUQ0wxSFdtQUZxcEJodUttUHdPNUpiZ0NCOFBjU01j?=
 =?utf-8?B?bEZJUFZ6RkRQWkRqYjI5Vjl3R2VadVlBUmJFWWp0N3NBN3B6dk9JYWdteXMz?=
 =?utf-8?B?cExwNkcxbXkxcE5qYnFOWC9VVVp3Sy8yNXU2UDNBTzU4TUhXK0duODhyVFQ5?=
 =?utf-8?B?NXJ2Q1FCZmY5YVhGSFFPeFpjdDAwcHVuOEM4MGRIMkJGcGhHNVZrOWJobkIx?=
 =?utf-8?B?eGNkM3lRWFdRME93dWxHSWxTNmtweVQ4NHZ0ZmlpZldvNkROZFF3R2lNVjhC?=
 =?utf-8?B?WkFZZnJvTHZOV2Y5VG9nSk1EY1FBTWlNaHZYV0htbXpEMDlta2E1bDBOMjc5?=
 =?utf-8?B?Tloyb3ZyclZaeXZ5Qy9aYTNYU0pxVndncWhibm90RExXMzdNUUk0L0xqTi80?=
 =?utf-8?B?SFhrTEsvZlZNejI0MVE0ZytTODFldS9CWmp1L0hhNXh6dS80VHNOdi9ra0hi?=
 =?utf-8?B?OHExRWpuVTdLcmp0ZEw2K3c0UC9iV0FjSWlVSGVKSWR2NEw1SEM4M0VRMWxT?=
 =?utf-8?B?NlpjeTl2MTN4NjMvWnZrTWpuRW1WeEFmcUlCU3ZTRnp3V2FnaG9jS3Q5ZUFH?=
 =?utf-8?B?bmxxcGZqZ0xhbUdVT2pNTU1ZUlRlSmkzcEl0VDNUY2ZOSzFMYzAya3FxOVlD?=
 =?utf-8?B?VkduQ3RsbVpDOHE1eURadzdWMFRMbXpleFpuUDFNeS9ZQTBQNnkvK2FSUnJS?=
 =?utf-8?B?SGpJVTZST3AyS0EwN1NpUUd3Nldua0hEeGRJa1JzYmdQY09tQld6eFc1Kzhp?=
 =?utf-8?B?d3ZvWTR0OC9kVk9rUU4wcUQ5Szg0VVhWRE9lUEFoV1lPdU5BbUlTd0pQWHds?=
 =?utf-8?B?Znd3cXlFMGdJZlNnMXEwQ0h1emltU0xaQlZXUHdIYm9xVUE3dFFYRGVadE1s?=
 =?utf-8?B?SXg2enozcUllYVJHTDl2eGI0eU95OFI5L2RHbHlSMTNhK1N6RXVUU21XZTRF?=
 =?utf-8?Q?K1mU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7e804b-27aa-4c85-0c04-08dbbb603661
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 11:36:50.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvsPpXcbDjJtpbq8ayUsrvt2L9NN8bCZQv6XFQO6jjQip/q04pehN8EBVDCwN1q6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8
dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1i
ZXIgMTksIDIwMjMgNzowMiBQTQ0KPiBUbzogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4N
Cj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgUGFuZGV5LCBSYWRo
ZXkgU2h5YW0NCj4gPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbT47IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+OyBQZXRlcg0KPiBLb3JzZ2FhcmQgPHBldGVyQGtvcnNnYWFyZC5jb20+
OyBMaXUgU2hpeGluIDxsaXVzaGl4aW4yQGh1YXdlaS5jb20+Ow0KPiBkbWFlbmdpbmVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGtlcm5l
bEBwZW5ndXRyb25peC5kZQ0KPiBTdWJqZWN0OiBbUEFUQ0ggNTcvNTldIGRtYTogeGlsaW54OiB4
aWxpbnhfZG1hOiBDb252ZXJ0IHRvIHBsYXRmb3JtIHJlbW92ZQ0KPiBjYWxsYmFjayByZXR1cm5p
bmcgdm9pZA0KPiANCj4gVGhlIC5yZW1vdmUoKSBjYWxsYmFjayBmb3IgYSBwbGF0Zm9ybSBkcml2
ZXIgcmV0dXJucyBhbiBpbnQgd2hpY2ggbWFrZXMNCj4gbWFueSBkcml2ZXIgYXV0aG9ycyB3cm9u
Z2x5IGFzc3VtZSBpdCdzIHBvc3NpYmxlIHRvIGRvIGVycm9yIGhhbmRsaW5nIGJ5DQo+IHJldHVy
bmluZyBhbiBlcnJvciBjb2RlLiBIb3dldmVyIHRoZSB2YWx1ZSByZXR1cm5lZCBpcyBpZ25vcmVk
IChhcGFydCBmcm9tDQo+IGVtaXR0aW5nIGEgd2FybmluZykgYW5kIHRoaXMgdHlwaWNhbGx5IHJl
c3VsdHMgaW4gcmVzb3VyY2UgbGVha3MuDQo+IFRvIGltcHJvdmUgaGVyZSB0aGVyZSBpcyBhIHF1
ZXN0IHRvIG1ha2UgdGhlIHJlbW92ZSBjYWxsYmFjayByZXR1cm4gdm9pZC4gSW4NCj4gdGhlIGZp
cnN0IHN0ZXAgb2YgdGhpcyBxdWVzdCBhbGwgZHJpdmVycyBhcmUgY29udmVydGVkIHRvDQo+IC5y
ZW1vdmVfbmV3KCkgd2hpY2ggYWxyZWFkeSByZXR1cm5zIHZvaWQuIEV2ZW50dWFsbHkgYWZ0ZXIg
YWxsIGRyaXZlcnMgYXJlDQo+IGNvbnZlcnRlZCwgLnJlbW92ZV9uZXcoKSBpcyByZW5hbWVkIHRv
IC5yZW1vdmUoKS4NCj4gDQo+IFRyaXZpYWxseSBjb252ZXJ0IHRoaXMgZHJpdmVyIGZyb20gYWx3
YXlzIHJldHVybmluZyB6ZXJvIGluIHRoZSByZW1vdmUgY2FsbGJhY2sNCj4gdG8gdGhlIHZvaWQg
cmV0dXJuaW5nIHZhcmlhbnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5p
ZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvZG1h
L3hpbGlueC94aWxpbnhfZG1hLmMgfCA2ICsrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Rt
YS94aWxpbngveGlsaW54X2RtYS5jDQo+IGIvZHJpdmVycy9kbWEveGlsaW54L3hpbGlueF9kbWEu
YyBpbmRleCAwYTNiMmUyMmYyM2QuLjBjMzYzYTFlZDg1Mw0KPiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9kbWEveGlsaW54L3hpbGlueF9kbWEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS94aWxpbngv
eGlsaW54X2RtYS5jDQo+IEBAIC0zMjQ1LDcgKzMyNDUsNyBAQCBzdGF0aWMgaW50IHhpbGlueF9k
bWFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gICAqDQo+ICAgKiBS
ZXR1cm46IEFsd2F5cyAnMCcNCj4gICAqLw0KDQpOaXQgLSBrZXJuZWwtZG9jIHJldHVybiBkb2N1
bWVudGF0aW9uIG5lZWRzIHRvIGJlIHVwZGF0ZWQuDQoNCj4gLXN0YXRpYyBpbnQgeGlsaW54X2Rt
YV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gK3N0YXRpYyB2b2lkIHhp
bGlueF9kbWFfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJ
c3RydWN0IHhpbGlueF9kbWFfZGV2aWNlICp4ZGV2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRl
dik7DQo+ICAJaW50IGk7DQo+IEBAIC0zMjU5LDggKzMyNTksNiBAQCBzdGF0aWMgaW50IHhpbGlu
eF9kbWFfcmVtb3ZlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCQl4aWxp
bnhfZG1hX2NoYW5fcmVtb3ZlKHhkZXYtPmNoYW5baV0pOw0KPiANCj4gIAl4ZG1hX2Rpc2FibGVf
YWxsY2xrcyh4ZGV2KTsNCj4gLQ0KPiAtCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHhpbGlueF92ZG1hX2RyaXZlciA9IHsgQEAgLTMyNjksNyAr
MzI2Nyw3DQo+IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHhpbGlueF92ZG1hX2Ry
aXZlciA9IHsNCj4gIAkJLm9mX21hdGNoX3RhYmxlID0geGlsaW54X2RtYV9vZl9pZHMsDQo+ICAJ
fSwNCj4gIAkucHJvYmUgPSB4aWxpbnhfZG1hX3Byb2JlLA0KPiAtCS5yZW1vdmUgPSB4aWxpbnhf
ZG1hX3JlbW92ZSwNCj4gKwkucmVtb3ZlX25ldyA9IHhpbGlueF9kbWFfcmVtb3ZlLA0KPiAgfTsN
Cj4gDQo+ICBtb2R1bGVfcGxhdGZvcm1fZHJpdmVyKHhpbGlueF92ZG1hX2RyaXZlcik7DQo+IC0t
DQo+IDIuNDAuMQ0KDQo=
