Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D63F56A051
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 12:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiGGKrp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 06:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiGGKro (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 06:47:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF894D4C4;
        Thu,  7 Jul 2022 03:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWn63dzntEHpPeCpCZGJKE+A2GScD3GwQ2HH98QWvbDHSU8oqkph6cPLnF9RHRRS7y8yXD/OtdlhQkca20dksAcUf0sjTIbdOZuSd9EuoBrNLVLx1dV+3TyamC4NbmEJb6cnxaln+bCQt6k/6Ki2Xed38dP3dr5gbAfxox5MRJePxal8QUOzpv/aBO+vMmO9KKUdek4tRI7v8VWYeRs0BblEL1EutZV/l17LHthz1Xj6iCoqkaKfEtixq7GWBbOhFUkKEdpi8Hb1mwd67uM6MBxy1m7p6c5m0K6q6NLQkVPipWWgJFg/JLVricz5sPpvFxg2d3MOnAYc79Boh497cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KGZ1TjWmg1xu6Mo+dFcCvJn8QAMey5nQrCnOl9q2eA=;
 b=CBv88iE+roJ6GecBL4W7MmVG5RkeQFpR+3oJxXFvyjaevrEeHOSy2C1OmDqxLF4qKUIL7tXHMWJMUZz58L5M3UnAwkrhpiMpKtHlHY4j0rTiqo40vSqZd82aUXvjNBQfS5xr7Hq+qoYVbYh+UmsjQBOBnZdodHmT2IVcBHYmZbRYNUt/nuJdMsXKDJWJsHIk+yCVXUzQos3ogz7lWjgU8rRdSjuX5GTgOZpuWNSwNF2bVZR4PAExA5pdFE/MvKV/pBzJzu8ZKmKr6mYRFQW6+YHo7w1k3u+ueIN70e0SSmrckI7wu8IYwpw2Ei8RdTA1QI1H4BpOvwpHQbyJKuTXgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KGZ1TjWmg1xu6Mo+dFcCvJn8QAMey5nQrCnOl9q2eA=;
 b=KhGV/51hwLWlvGa3rQp8KsSkW+2KakJt/EVMPTLCI4Y3TPhxfWROKtzJHgPmQNTQ4Y33twN9lxnhYhVa/AljADic052nF3JSkp3Z4w6twlMD4yk0mWTQMXzuAHTIWKjrcCJjOyJJfcakstjKwxjxdKerighxadahZQY4N+Y7sZG6Ckj1O2yrz358APIYaojuJbz0QEJg+7t6Qq9PGYdtyamlu0ND7lcUmtrCvQVxkXZ9FXj0d+79O5oPOVcbvaCS5VF6Hnwr4/1nmwbDzA1KzZywEd4UhIa0eOjyQ6AbsX+m9BKhnW8n1jSALXfOudDGb7Q8h3nOGStqbry4Pv3LxQ==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by DM6PR12MB5566.namprd12.prod.outlook.com (2603:10b6:5:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 10:47:42 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::28e6:129d:a1f:84d3]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::28e6:129d:a1f:84d3%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 10:47:41 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] dmaengine: tegra: Add terminate() for Tegra234
Thread-Topic: [PATCH 1/2] dmaengine: tegra: Add terminate() for Tegra234
Thread-Index: AQHYkexET5/QPk+MHkWN9gLl8ccF6a1yt/oAgAAAXrA=
Date:   Thu, 7 Jul 2022 10:47:41 +0000
Message-ID: <SJ1PR12MB633907810FD7D59B7BF433A6C0839@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20220707102725.41383-1-akhilrajeev@nvidia.com>
 <20220707102725.41383-2-akhilrajeev@nvidia.com>
 <1d0826ed-97e7-9571-b5e5-9da12286a626@nvidia.com>
In-Reply-To: <1d0826ed-97e7-9571-b5e5-9da12286a626@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa09295c-6045-459e-ecb5-08da60061e3c
x-ms-traffictypediagnostic: DM6PR12MB5566:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2WOci4LSHDhhyXkuEfiqgBjbxNJmfEOTSYOsRHTvBu4iXcuEVxgXtgNqidPmkP4lPm0raqRlkMYuUyPZXCcGE8uog+xWmt378BOMgI+d3op0vFvaSSZ6m4tMo/z18RT0BrzzFYWotfUp7oHrrmIXpSul3AOBaCyYxAyW+j5hWi554w7I6MPiuwACLjfWtx2vpSmV5w0huSnQSQrPxhVoaO6yKiWMF97XpQbie0ol6mRHr8co24QaA8dC2YydKGYGF7Bzc5uoT1eFSRselFGsQvO/63ow6TivR9+w2AjcDG0sd2Wl+Df8eNfKmpt9UeFgeejZq0UdZdu4MXcyTFeP2kRrdyxUrYuDA7pYUdG95iesNzeDhBB8xV1ILe5ar8WulbSlG1RdAbMEC3NQukCl1iEjvDI2JJbUEyn8EYQ1mcx2C3J3Fj8ppxlVUrUOfY+vbl2KV6fksin2ncfRXzj6l6Ng+LD00OvTCcb1F6Gn7Z1dfi/iD4pmSFM2ClIn7gXY/inSm5fzmh4fp8CREPOp6jd7vfq4vmmmhT2VjuWBu2hZDXOhP5mbEnZiaBj9HpijVotEcWkXGT4fZSHT4YHm09SvCE9HA7B3KAYGGBwKgT+F/SlUI7uPiBB8zA6WCFAcmLEz7hcfvicgU1V8XieS98Qbc9iKhcawPe90TatIhIgfu+U69xupVxqRksD9SMXNPRXpybhLGlSfbs/A2V/FBnDZawTRLZaSsDz5b+Ck0vgto5bfiqqDoO7TYhtFOwDWQHxgBQJqXL2YCqGUCZVra2Cp279qMEjRREY4ZMk18YyEhX0MKa5mzrrUYi+WiuHkRdNluIl7dJXmqDnUjBeOiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(186003)(26005)(9686003)(316002)(86362001)(38100700002)(5660300002)(53546011)(55236004)(41300700001)(6506007)(7696005)(8676002)(66556008)(66446008)(66946007)(2906002)(478600001)(76116006)(66476007)(38070700005)(71200400001)(55016003)(83380400001)(33656002)(110136005)(64756008)(8936002)(52536014)(921005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akhwaGgrMzdWcGZqWEk5WS9teG5jeXpMRkZDS2NoWEVMOEJFMm5Nb25kL3BX?=
 =?utf-8?B?WXdLZmlvODVBRWNvbEVNZjJlMlVmUU1oMERDbzFzVTRTYTlJVWdaVldBMjBM?=
 =?utf-8?B?ZHRRTmdtallMaW9ZeVJEK1IyZkpFWXp0djRRSnY4RGhYRDNiUElzZXg3R2RR?=
 =?utf-8?B?Nys0UFFhRWVtbVNZaXpYUW9IVVgxdXlBVTFDdEhTeXhxK0lrZmttNmJRc0lK?=
 =?utf-8?B?TDlQaW5DcmdMd2FFeStsQW42UllnYld4ZklhQUlmL1VmNmtMRHpKQzBkSXpJ?=
 =?utf-8?B?UHhvQSsrN0Via0dOM3VVejVyOXd3MFJXYWFjT0hzbkM5SmlkZFhQQUljaHVY?=
 =?utf-8?B?alkyUEl4S3ZCUnJkNzhGM1RjS0xuWFBYZnNIbStKdG5WdnpERi9VRkZvYjB4?=
 =?utf-8?B?Y1JNT3p5YlVzYWFPMnQxRmVPSm5jT2NMRmlnQnNWZUNqZjFDdk05Tk55WWJy?=
 =?utf-8?B?S0NmZDQwZ0l2ek9iaTdWVGZ4S2ZNaFo3NnlDanJOYkwwTWpZSzV0cFUva28z?=
 =?utf-8?B?SHN1UEZaT2VRUjBhZXlJNklVTjd5RzRyVVVkL01jR2l4ekVVNG5FNW9Udm8y?=
 =?utf-8?B?V3hZUkhvNDliTTNpMkFySE8xRVNGSHdIdFpnM2FWYW1MbTJwQkcvTFI2N2Fq?=
 =?utf-8?B?OEZMckc2b2RrQ05RRmwvQlVLUFpFZktrRVl5QTV6TWkrTlBtSlRWK2EwSFo1?=
 =?utf-8?B?WXJHZ2pUT291TGtXREY4Mi9JazlRcVU2NGZQaHd0a2ZzbForekVmcExBNFVp?=
 =?utf-8?B?NU9qbHh6OE1mdVpkdEt4b3BBbU9DaEluTzduUWEwTDQybU95dHdvL3Z2cGRH?=
 =?utf-8?B?RzV5QTl4d3QrSURQd2lhRVBvTmlEMXFyZDBEZFNNdW9mcE1vSEV3eEJPUGJW?=
 =?utf-8?B?dE9PdXNBL3lZdE9kNVdFYWFyRGY1OHJ3VmVEUEVBcG5YckUwVXhsOEUzZGgw?=
 =?utf-8?B?dnk5bXR2bS9zU0ZycjloNmIzOHE4N2MrVm1QdjBVODZaOXlzMTl3S1pMRlJ3?=
 =?utf-8?B?MkRla1VLM2lOQTJsTU16bFl4UVduUEFHRzNQek82TG9NcGNYTnF4bGx2NUU5?=
 =?utf-8?B?dXcrdmttcDVxSkdXT2xheGxra2ovQjZXTXVXT2pub1VmdTZWOEVXWUNoWHVM?=
 =?utf-8?B?anJBUVk0Tk9VOERIaEIzTFVya2c4LzZKdXlLYzVRMVltMndnbGhoRjlTc0FX?=
 =?utf-8?B?azBvZWQ2MkVhd1d5SUZiZGY0QmhYKytoQlhVbzY5ZTJXWUwxL3l6TEx4UGdh?=
 =?utf-8?B?Vys2MHBnc1RNMmZQdHpnRVVBWEdXcGpQQmVXa1B4SGpRdlFpb25ZOWlDOTZR?=
 =?utf-8?B?WEZRZG1aRlQ1NTJBb2ZheGlCdGRPcU1sRnlINW41SytQTFBkQS83N1ZYbG5m?=
 =?utf-8?B?M0NKN0dUWSt3NEIwR3ZGTTY5K0J4T2N2MnNMYTZyYlFSMnA1MFdUZHdTa2FJ?=
 =?utf-8?B?MDN0c3JKVkRIOURKNnRtVDNZM2RPdWcwRXBtQitRVVBVUk42Z3BFZ2ZueW8x?=
 =?utf-8?B?V0hiYUZlV0I4UzlDZW9FOFhycFY5RUNxVlVSckVxSm5ZakRtODhJRWkyRXk4?=
 =?utf-8?B?VDAzc0E0LzFzTjVVWjhyeTM2MnMvTkJ0Nkc0UlVOZ1pNb3JBZEpNSmdRNjNa?=
 =?utf-8?B?Mm9tOUFUL1lEL0x1eisvV0VLeE5iR2ZqSDRvRjlTdHlGYTF1eEtrbVdUVytK?=
 =?utf-8?B?UkVlRDFhUlF5VXYzeXRXOHY1emdGYnJFVE81T09xMGpETXB0akNUM3E1NGVN?=
 =?utf-8?B?eVg2Q01VQmVQeHlPMmVnQlNFMmxTdnkxaVJGMHNaUytoNWRSWGhML0ViMllD?=
 =?utf-8?B?MzBZcU5hWlFQL3lTdktBN3pNRGxONGpXMlFYcHhNS3RRd1RWMW5nWmtySWI2?=
 =?utf-8?B?QW52amEzVzhTQWlZQ21HSXNLTjdWMmZEUGhrcHRMMjBnRUMvWXRxRmQ3UnlE?=
 =?utf-8?B?K3hJVTFIejRTcmUrR0NiT0VMdmgxYzBkUUQwa00zYVJaTUpLR242RDlyMm8z?=
 =?utf-8?B?ZWpJVjBFL29hN0F2TjBYdHlEWWVVNFpMRE5SZ0EvVUgyRmpoVHkrWEJJSkZK?=
 =?utf-8?B?UXBFOTE3cEZpbkV4N3R6MXBFOU1RM1Q3cm5wS3pteWNOeDRROWczbXpZNlFI?=
 =?utf-8?Q?jh4T3jgCh6YagpnPKC9S7KEbE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa09295c-6045-459e-ecb5-08da60061e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 10:47:41.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: koTUBD0KY1vbPSS6I2lUFKSQnfv2t84f4dd0O4BVY3qTR97FO+0FYMUUClFikHQnzdvjmWWSQaj9AIN0wWYxlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5566
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBPbiAwNy8wNy8yMDIyIDExOjI3LCBBa2hpbCBSIHdyb3RlOg0KPiA+IEluIGNlcnRhaW4gY2Fz
ZXMgd2hlcmUgdGhlIERNQSBjbGllbnQgYnVzIGdldHMgY29ycnVwdGVkIG9yIGlmIHRoZSBlbmQN
Cj4gPiBkZXZpY2UgY2Vhc2VzIHRvIHNlbmQvcmVjZWl2ZSBkYXRhLCBETUEgY2FuIHdhaXQgaW5k
ZWZpbml0ZWx5IGZvciB0aGUNCj4gPiBkYXRhIHRvIGJlIHJlY2VpdmVkL3NlbnQuIEF0dGVtcHRp
bmcgdG8gdGVybWluYXRlIHRoZSB0cmFuc2ZlciB3aWxsDQo+ID4gcHV0IHRoZSBETUEgaW4gcGF1
c2UgZmx1c2ggbW9kZSBhbmQgaXQgcmVtYWlucyB0aGVyZS4NCj4gPg0KPiA+IFRoZSBjaGFubmVs
IGlzIGlycmVjb3ZlcmFibGUgb25jZSB0aGlzIHBhdXNlIHRpbWVzIG91dCBpbiBUZWdyYTE5NCBh
bmQNCj4gPiBlYXJsaWVyIGNoaXBzLiBXaGVyZWFzLCBmcm9tIFRlZ3JhMjM0LCBpdCBjYW4gYmUg
cmVjb3ZlcmVkIGJ5DQo+ID4gZGlzYWJsaW5nIHRoZSBjaGFubmVsIGFuZCByZXByb2dyYW1pbmcg
aXQuDQo+ID4NCj4gPiBIZW5jZSBhZGQgYSBuZXcgdGVybWluYXRlKCkgZnVuY3Rpb24gdGhhdCBp
Z25vcmVzIHRoZSBvdXRjb21lIG9mDQo+ID4gZG1hX3BhdXNlKCkgYW5kIGRpc2FibGVzIHRoZSBj
aGFubmVsLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWtoaWwgUiA8YWtoaWxyYWplZXZAbnZp
ZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3Jh
MjM0LmR0c2kgfCAgNSArKystLQ0KPiA+ICAgZHJpdmVycy9kbWEvdGVncmExODYtZ3BjLWRtYS5j
ICAgICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ICAgMiBmaWxlcyBj
aGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3JhMjM0LmR0c2kNCj4gPiBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3JhMjM0LmR0c2kNCj4gPiBpbmRleCBjZjYxMWVm
ZjdmNmIuLjgzZDFhZDdkM2M4YyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L252aWRpYS90ZWdyYTIzNC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9udmlk
aWEvdGVncmEyMzQuZHRzaQ0KPiA+IEBAIC0yMiw4ICsyMiw5IEBADQo+ID4gICAJCXJhbmdlcyA9
IDwweDAgMHgwIDB4MCAweDQwMDAwMDAwPjsNCj4gPg0KPiA+ICAgCQlncGNkbWE6IGRtYS1jb250
cm9sbGVyQDI2MDAwMDAgew0KPiA+IC0JCQljb21wYXRpYmxlID0gIm52aWRpYSx0ZWdyYTE5NC1n
cGNkbWEiLA0KPiA+IC0JCQkJICAgICAgIm52aWRpYSx0ZWdyYTE4Ni1ncGNkbWEiOw0KPiA+ICsJ
CQljb21wYXRpYmxlID0gIm52aWRpYSx0ZWdyYTIzNC1ncGNkbWEiLA0KPiA+ICsJCQkJICAgICAi
bnZpZGlhLHRlZ3JhMTk0LWdwY2RtYSIsDQo+ID4gKwkJCQkgICAgICJudmlkaWEsdGVncmExODYt
Z3BjZG1hIjsNCj4gPiAgIAkJCXJlZyA9IDwweDI2MDAwMDAgMHgyMTAwMDA+Ow0KPiA+ICAgCQkJ
cmVzZXRzID0gPCZicG1wIFRFR1JBMjM0X1JFU0VUX0dQQ0RNQT47DQo+ID4gICAJCQlyZXNldC1u
YW1lcyA9ICJncGNkbWEiOw0KPiANCj4gSSB0aGluayB0aGF0IHRoaXMgc2hvdWxkIGJlIHNwbGl0
IGludG8gdHdvIHBhdGNoZXMuDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS90ZWdy
YTE4Ni1ncGMtZG1hLmMNCj4gPiBiL2RyaXZlcnMvZG1hL3RlZ3JhMTg2LWdwYy1kbWEuYyBpbmRl
eCAwNWNkNDUxZjU0MWQuLmZhOWJkYTRhMmJjNg0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZG1hL3RlZ3JhMTg2LWdwYy1kbWEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZG1hL3RlZ3JhMTg2
LWdwYy1kbWEuYw0KPiA+IEBAIC0xNTcsOCArMTU3LDggQEANCj4gPiAgICAqIElmIGFueSBidXJz
dCBpcyBpbiBmbGlnaHQgYW5kIERNQSBwYXVzZWQgdGhlbiB0aGlzIGlzIHRoZSB0aW1lIHRvIGNv
bXBsZXRlDQo+ID4gICAgKiBvbi1mbGlnaHQgYnVyc3QgYW5kIHVwZGF0ZSBETUEgc3RhdHVzIHJl
Z2lzdGVyLg0KPiA+ICAgICovDQo+ID4gLSNkZWZpbmUgVEVHUkFfR1BDRE1BX0JVUlNUX0NPTVBM
RVRFX1RJTUUJMjANCj4gPiAtI2RlZmluZSBURUdSQV9HUENETUFfQlVSU1RfQ09NUExFVElPTl9U
SU1FT1VUCTEwMA0KPiA+ICsjZGVmaW5lIFRFR1JBX0dQQ0RNQV9CVVJTVF9DT01QTEVURV9USU1F
CTEwDQo+ID4gKyNkZWZpbmUgVEVHUkFfR1BDRE1BX0JVUlNUX0NPTVBMRVRJT05fVElNRU9VVAk1
MDAwIC8qIDUNCj4gbXNlYyAqLw0KPiA+DQo+ID4gICAvKiBDaGFubmVsIGJhc2UgYWRkcmVzcyBv
ZmZzZXQgZnJvbSBHUENETUEgYmFzZSBhZGRyZXNzICovDQo+ID4gICAjZGVmaW5lIFRFR1JBX0dQ
Q0RNQV9DSEFOTkVMX0JBU0VfQUREX09GRlNFVAkweDIwMDAwDQo+ID4gQEAgLTQzMiw2ICs0MzIs
MTcgQEAgc3RhdGljIGludCB0ZWdyYV9kbWFfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QNCj4gZG1hX2No
YW4gKmRjKQ0KPiA+ICAgCXJldHVybiAwOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbmxp
bmUgaW50IHRlZ3JhX2RtYV9wYXVzZV9ub2VycihzdHJ1Y3QgdGVncmFfZG1hX2NoYW5uZWwNCj4g
PiArKnRkYykgew0KPiA+ICsJLyogUmV0dXJuIDAgaXJyZXNwZWN0aXZlIG9mIFBBVVNFIHN0YXR1
cy4NCj4gPiArCSAqIFRoaXMgaXMgdXNlZnVsIHRvIHJlY292ZXIgY2hhbm5lbHMgdGhhdCBjYW4g
ZXhpdCBvdXQgb2YgZmx1c2gNCj4gPiArCSAqIHN0YXRlIHdoZW4gdGhlIGNoYW5uZWwgaXMgZGlz
YWJsZWQuDQo+ID4gKwkgKi8NCj4gPiArDQo+ID4gKwl0ZWdyYV9kbWFfcGF1c2UodGRjKTsNCj4g
PiArCXJldHVybiAwOw0KPiA+ICt9DQo+IA0KPiBUaGUgY29tbWl0IG1lc3NhZ2Ugc2F5cyB0aGF0
ICJhZGQgYSBuZXcgdGVybWluYXRlKCkgZnVuY3Rpb24gdGhhdCBpZ25vcmVzIHRoZQ0KPiBvdXRj
b21lIG9mIGRtYV9wYXVzZSgpIGFuZCBkaXNhYmxlcyB0aGUgY2hhbm5lbCIuIEJ1dCBJIG9ubHkg
c2VlIHBhdXNlIGJlaW5nDQo+IGRvbmUgaGVyZS4NClRoZSBmdW5jdGlvbiBpcyBzZXQgYXMgLnRl
cm1pbmF0ZSgpIGZ1bmN0aW9uIGluIGNoaXBfZGF0YSBhbmQgaXMgY2FsbGVkIGR1cmluZw0KdGVy
bWluYXRlX2FsbCgpLiBTaW5jZSB0aGlzIHJldHVybiAwLCB0ZWdyYV9kbWFfdGVybWluYXRlX2Fs
bCgpIHdpbGwgcHJvY2VlZA0KYW5kIGNhbGxzIHRlZ3JhX2RtYV9kaXNhYmxlKCkgaW4gdGhlIG5l
eHQgc3RlcC4NCg0KUmVnYXJkcywNCkFraGlsDQoNCi0tDQpudnB1YmxpYw0K
