Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A436A5E7F9D
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 18:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIWQW4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 12:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIWQWz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 12:22:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD691A213;
        Fri, 23 Sep 2022 09:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoW0wQYpPhXmGA+enURbjCTHDRAMrHQvSsxPzpoxV/A/UIEaO4tD1kmRorpehPZSlP7xPfKRcZjPN3LZTZN2c3k/QGljvYhM4S+jnNo+v6mFExY+qExX2BBd84Mw9n5E9DmfFccXKPzUaaE/A0QM1JhUZJNfgGQ+PD9lsB9kS1Q5/jIKYXZ1vJEKl2uq3YI9psF2lPP+qQvXjX2TW9ycGrj0r0CH8yWJ0kZ19UZdozVYEHD6vRLwvPhZMzXM7XUfUKN/QPBngFAGwkMbAxQ/7RG7au9EPRE8OmYRn/8rV2kbcpJJ+MMf6g6nnSZVS3JBRYnagwlqHY5zW6A8DFc91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYaRvfsz72cGMxA4mk6Qs+b4oPUKMtxoGGggYDAUarI=;
 b=B95ytpJYgxHlFkfaxChOsnrzf5CiPbTg+PZXl6Rx5wpKEg/76cUyEaj7m9lI4zaLt6oD95EBOFhl0G30GVh9RG0oAWAKuJQ0Hg3Vr0WmKGb33LQJUyzlcNTDSkXP3j50x8+8mRQb+wH/a319ZsuyBSnhcCdnmRCHrE/1x3tUfBcnYO++St6T3bQ9Pzqp+EbKYCoWLe6kwDXKWM7YpBCYJMwnidWW7ygB6kkkrZjsE6BCuveYlYUjH+U5mDGh4fH+q7YjnHOr0Cm9yul78dzjhfil5HGxpSQbjx1D8c/hDByT5t/hlwZSd7kY5hRaEoPhxViFtP5turp19kdWPlE0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYaRvfsz72cGMxA4mk6Qs+b4oPUKMtxoGGggYDAUarI=;
 b=rtLoR9ZOHhTwV9LrT3RmQ2TBfSIoGrkYmVfihqjm955XmjIxv31VdC6+fe4InNBnjUIhzqbBorI1uO+GUEXFKXarFK3CjJe1nP1ItKKVpBLJRTxDsQ3IfewZOliWvqVLTMDNc6fynIJ+bUJ00i6Iz0hD/EXJx5H0WsTbknkcqmFWkG/ikjjfEoXKjLyegYsdlOSFyewTTYysvcIgbcB8xxOTLpohT7xmq9KupTZxdRdu4ADPFVv8GGmp4ZMp8PJKSxroaYl9ChXmRBJzoPX0H4denKvs/uNXxiK5LRgCG3lUCoCD0IY4yRGHkIwLLVLWUGFVbG0CExm86eMAJsTffg==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 16:22:52 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::2db9:5c61:102e:dfd4]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::2db9:5c61:102e:dfd4%6]) with mapi id 15.20.5632.019; Fri, 23 Sep 2022
 16:22:52 +0000
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
Thread-Index: AQHYzBq1VH2N02dZjk2+4dPkKtVnFK3s0MSAgAABj3CAAAoPAIAAAqQggAAMtgCAAEzYcA==
Date:   Fri, 23 Sep 2022 16:22:51 +0000
Message-ID: <SJ1PR12MB6339A665889F4F4B55AE81E5C0519@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20220919112559.58195-1-akhilrajeev@nvidia.com>
 <20220919112559.58195-4-akhilrajeev@nvidia.com>
 <8d15c575-a490-e1ed-7e97-5a5cdea0925f@nvidia.com>
 <SJ1PR12MB633958099C6DDAA4A428ECBEC0519@SJ1PR12MB6339.namprd12.prod.outlook.com>
 <d2b4a1f5-200f-2560-c249-709e4e2817b1@nvidia.com>
 <SJ1PR12MB6339660F292E63B2E0CDD85FC0519@SJ1PR12MB6339.namprd12.prod.outlook.com>
 <d289e057-9709-1b4d-f64f-c3ed627cd0f7@nvidia.com>
In-Reply-To: <d289e057-9709-1b4d-f64f-c3ed627cd0f7@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|BL1PR12MB5923:EE_
x-ms-office365-filtering-correlation-id: 941c44e6-0d67-4405-58f7-08da9d7fdd0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bsUIegvjbu+zCCb4qjWLB00ypY0ZctBN/jqqcgrsNtB+oaZj2zKxwG3ApZXEsQr/8eGx9YyV55f4S+AoTSxIwMgP9cH0QuwhdunyODwNDTyH0YA3W9BXlsBN5oOGI1IHGzyNqy97QuoN3JgcHAD4mZY3Im0NACS2YUfky9Nr+nPh625zpVokIOisMu++t0Fl9hag/6x4InldVlMA1fhHEykWiZWQ84u1ecnl39AyY4P686At3lwxqbUdJEPmTzQlV+Lj7jnko7pg/iDgSOdefRahmfxhvlWyJlXgFKKTjJC51YGyq3WFC8XIGBZfxEhAJdRLK9dMDmXu2NRGPbcRl8gx40BH7SAjrEoQVmkQ4CApFUvdTLxVKOvcLtOQgjMwIlFJp/GbFsg/NI5n7SQjZ9bA+I5QOMwo3QnrfbT9J0U2qS5aXB9BUrMR2rVX2VP/6vqP3RYHS/3hz/mJGg4EHyIvzSh5mJ0HSjdem6htWp9qvRWsWDygmza45GAqfldjJ8IuDaYmr5Q8MZ7WIFlkaO05BQdm345c04HsvcdYfJiTUCKn886IvI5LzIGLh3NkisqoTE0Gm7974fxSxmS1vLLG99WLsprHyFUMtFkEFk2AOvJ0erxk+d+3JhcyE1UgrjkmD51qgiQsNkfyE9cj5rAoK1+2hIxhhurN+UBsasD8Cf2yKq0SZcn9hn9YwJf3u9FMQxMJzDxY1DmT7xIhew/4KOztLSDuoPGZXnrnyQaevvJYq0kqLUt7d/5lcTbDftSV8qjUYhHpOWHCnVfXkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(66476007)(66556008)(64756008)(66446008)(66946007)(110136005)(9686003)(26005)(8676002)(6506007)(7696005)(186003)(76116006)(122000001)(71200400001)(38070700005)(478600001)(5660300002)(316002)(55016003)(38100700002)(8936002)(86362001)(4744005)(33656002)(41300700001)(52536014)(83380400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnNnNkNTbC8xU1didFl5SWJZVk5ZVXJ5SkhDb0Fzamo1VFVENFVIQ1pWWmU2?=
 =?utf-8?B?V001bmp2VEZkSFBsNThaOGo4SUtYMWhPOHFCZjFRLzljeDFQbmZGb25ucGRh?=
 =?utf-8?B?elpKeHVGTlRTS2s0RUx1S0dSb2pkWTkwUjQxRTNZckVqcmpQL1VoYWdFZGRZ?=
 =?utf-8?B?ZWxzYnBhMUE5a2wzM0lJOUwzQ0ZrbDhCYzR2bS9Pdm5xdVAwMUxoenNIR0FK?=
 =?utf-8?B?Q0tsM29ZalBndy9qaFFFRTlZQy9BZ1B2aGVqSzhranh3aWFmLzBvY0dwOXB1?=
 =?utf-8?B?WWc2UndnNGRrbWg5ZFB4WlhtOWlOd296dTY1UWhCOHdKUjEyclREa0UvRlov?=
 =?utf-8?B?NjlLT2h3dkVGeTdnQzRGT3VWQ284TktKYkxtbHJnbXVYakpMN1NLVWQ4akl4?=
 =?utf-8?B?Y3JabDNmQnRUUG81eXB2M09oeDhPWFplclI2ekdwdytTWFo2SE9iODMyeUI4?=
 =?utf-8?B?b1NMVjFzcmREWEhiUFJ3OXpMNmNoLzFBNzdsUk5NeElXV2pPZXNrL0ZnK2ZP?=
 =?utf-8?B?RzFFVzV3NmN1eW1UZFI1azdGWm44OVB6TUhoUkV5UzY2ck0ycXh0R3RMQmVv?=
 =?utf-8?B?OE1VaDBJTkN1TmovMEhqMmVPRjVLWnE4UkdwbEc0cTRzSHBRVnNpTXlDYnpV?=
 =?utf-8?B?QTVKSkNMcEdqZ3N5U2grMzJ0THZUNnFpOXpxelhyYnk5RHcvVGlkYTJQZXVa?=
 =?utf-8?B?T3JGRVAyRG1TZnNWcG1aWGQ1dVJ1RzlvVjZLRWlpNUl5WUVTOFhFdndhL1J0?=
 =?utf-8?B?MmlXUDk0SG5FdzR0MjRLWlpYUmYrNjZmRFVmOHBxZk1MdU5sMmY2L1ExU2hR?=
 =?utf-8?B?OXlqSWlUc2hYeDhmRjVkR0t0RHRYbzJyTk5ZYlk3SUFaQ0ZPb3lFTjU3c1cw?=
 =?utf-8?B?MGxJOC9ib1FudGdRMXZRZ1ZieHVGVEUraFJGYkMycXpZUlVxMlhYeVhvaXpY?=
 =?utf-8?B?MDB0TTJuWFNDMURoUXJ2Q0ZEVk9Cd3ZkUFpYS3hveVAvNlJyVUFEM29LVXlw?=
 =?utf-8?B?emVmQWhmMXdXRXpsNGJmbHMxV0dnNy93K2wvS1orZUZIOXJVekhDaVBlRjVP?=
 =?utf-8?B?eU9mRzFhcHJpOEZMbFkwLzUyb3FPUkM5OEVWNCtrR2czWkRvYTZzY1piN1F4?=
 =?utf-8?B?OXZTMzRwL1pWZnBZT0I2SzFXNkRMU1k3aHo2UHE1RU9YZHZTTkFVVHpra1lT?=
 =?utf-8?B?dElkT01NSVhuaVBXMXJGM0RKU1ZQazFQR3lzQU5FWGFsTk1PSkplVVBDVzIr?=
 =?utf-8?B?dmZGWVkrRHRLbFdmL1FsR1hBSjM4MDlmcnVsQlpFTE1GdVo1L1BEa21lSW1n?=
 =?utf-8?B?MllTOWloOHVyZ295dENDWmNBU0Y0T1BmYktUMisxczBOTjd3TGtwTm01UUJq?=
 =?utf-8?B?WHlnNCtFZ1ZrZ3g3dXE4UEpQZ0RDenlScTNTU0M5VVN0S1hTYnlXUTc0ejhL?=
 =?utf-8?B?R0lIWHJvUDB2MFNqNkZ3dmlVMTVLeVc1MGdpOVhNNmF1WUI4UWlaRllRTTh1?=
 =?utf-8?B?Qkg2eEJEbVFud2tDUFEyODBBdWY5N1ZOL1NWNk1kcG8vcFpLSXM0Mko5dUhM?=
 =?utf-8?B?UmxMdnB5bGpqSDhsc3RkOTRSWm1XTE4yK2pxVGxNd3BEUUQzZzREZER3Y1Bx?=
 =?utf-8?B?UW5Ya2NWVWhrTHNieHJYSnNjVitydVpPMjc1TFMzb3liNkNxU2tIQUJQaGFY?=
 =?utf-8?B?UFpYakM2MnFaUDRSYkdpK0R4SURja2pHRTJtREhPTVZBcng3ek0xaGE2YVA3?=
 =?utf-8?B?L1YvS0Z3NmVNS25ybHpRVHlqRzNDMmQ1S0g5clRzRGM2dGsyV3oyRGpaR3NP?=
 =?utf-8?B?d3JZLy9WMjVlWXZaVFduaDJ0dHlCV2xTejZsZzk4eTErZ3dLV0NNTStKaTA1?=
 =?utf-8?B?ejl0Y2pKMnorUkI0NWFUOUZwbUp5Tm5VVUh1OTgwNHhvT3BsdHF0WjcxY3Uy?=
 =?utf-8?B?aGhUZjd0Uk1QUjJmWm9tMHZ4d0NjWU5GcitHZFVaQzdKZkx3eHNpaUk5TnR5?=
 =?utf-8?B?K2JTdGhOblV6ckp5SXg5aHRLTXVnS0J2TzNRWElMY0FaVCtQQTNHd0diVG1h?=
 =?utf-8?B?VE1rTHBlQjBGeDliaHBkc0tMQ09HbW5sdHZvMm8wZFRueXJ2SlljcE83RlZm?=
 =?utf-8?Q?6LQMQnWlRBQ2pIegifkHhSs8c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941c44e6-0d67-4405-58f7-08da9d7fdd0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 16:22:52.1106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kn5nWALm1+vXbHaPw6KuG+IlBjWwG5Ummn7+z4vsJpNjKOcGV1FLziDmY+I06z6iS3fX9tt31e/n+WG4lUmL8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiA+PiBBaCBPSy4gSSB3YXMgd29uZGVyaW5nIGhvdyB0aGlzIHdvcmtlZCB3aXRoICdjaGFubmVs
X3JlZ19zaXplJyBidXQNCj4gPj4gbG9va2luZyBjbG9zZXIgSSBzZWUgY2hhbm5lbF9yZWdfc2l6
ZSBpcyBhbHdheXMgU1pfNjRLLiBJIHdvbmRlciB3aHkgd2UNCj4gPj4gZXZlbiBib3RoZXIgaGF2
aW5nIHRoaXMgcGFyYW1ldGVyIGFuZCBkb24ndCB1c2UgU1pfNjRLIGRpcmVjdGx5Pw0KPiA+IFRo
ZXJlIGlzIGFuIG9mZnNldCBmcm9tIHRoZSBiYXNlIGFkZHJlc3Mgd2hpY2ggdGhlIHBlciBjaGFu
bmVsIHJlZ2lzdGVycyBzdGFydC4NCj4gPiBBbHRob3VnaCB0aGlzIG9mZnNldCB2YWx1ZSBoYXBw
ZW5zIHRvIG1hdGNoIHdpdGggdGhlIGNoYW5uZWxfcmVnX3NpemUsIHRoaXMgaXMNCj4gPiBub3Qg
YWN0dWFsbHkgdGhlIHBlciBjaGFubmVsIHJlZ2lzdGVyIHNpemUuDQo+IA0KPiBZZXMgSSBzZWUg
dGhhdCwgYnV0IEkgbWVhbiB3aHkgZG8gd2UgZXZlbiBib3RoZXIgaGF2aW5nIHRoaXMNCj4gY2hh
bm5lbF9yZWdfc2l6ZSBwYXJhbWV0ZXI/IERvZXMgbm90IGxvb2sgbGlrZSB3ZSBuZWVkIHRoaXMg
KGN1cnJlbnRseSkuDQo+IEFsbCB3ZSBuZWVkIGlzIC4uLg0KPiANCj4gICB0ZGMtPmNoYW5fYmFz
ZV9vZmZzZXQgPSBURUdSQV9HUENETUFfQ0hBTk5FTF9CQVNFX0FERFJfT0ZGU0VUICsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAoaSAqIFNaXzY0Syk7DQo+IA0KQWguIE9rLiBHb3QgaXQg
bm93LiBXb3VsZCBhZGQgdGhpcyBhcyBhbiBpbXByb3ZlbWVudCBpbiBhbm90aGVyIHBhdGNoLg0K
DQpUaGFua3MsDQpBa2hpbA0KDQoNCg==
