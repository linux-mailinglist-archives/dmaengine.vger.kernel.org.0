Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B2B77D87A
	for <lists+dmaengine@lfdr.de>; Wed, 16 Aug 2023 04:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjHPCdw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Aug 2023 22:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbjHPCdl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Aug 2023 22:33:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2096.outbound.protection.outlook.com [40.107.244.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFD91BE6
        for <dmaengine@vger.kernel.org>; Tue, 15 Aug 2023 19:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMJySQ9ByRG/CRBNhpZesgaOfQTxWyW+ru9ZbtGhhMukT03C+xMhgrrDSgMfvRSeR6cJPQ3nPt7eVL+8SXnmWSmU8BKzRI+G2aABUZ5rd1LVx+PU2A6zOxyjkxPLXR5e5AA50K78oXYGw2RGxj9QQ1CiuZRkdwh9Ju5D8vSc250gbGvt/znH0cfxDEvrAYTEOcd0+q7NwKEiG097A2Z1j7Y7/TRsqs0j4NZC5iNAFG/YgJe4+D5G4UF5KDGVzp69RNTQbRulEA4rgbgw0dB7P2K3tIAL/+G9s5Kj/j7Rqnx4s6QtoiCbp8INKe9HGsnDkJMqWPol/c3AM6bfVuYGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2UT3hwxJMdM95R7AXZN6zVg0bLlGUHA6echcx25HMk=;
 b=Q9L0ADZ7LrbMGWl/XGHRSTJnTf1zDGtw6pHnmhVUxwdXfkNPZnAgtPBKJEltfVkTr5MwsKMcQBojrFE8IBDqeaoj/qFhEChhYPs4vWJiVmHSXrUXGwf8FwV5X/Bs/JyI5mqUeR0iJ+uxJhsmMdpazz8uB11W0tn1p61w1pvzd0VJ1doQPkqXTeRyIDxLmxanSpC0L96J9ZPToqZhjiOPybvqI6FmtBAQJ9AJTGyO8muBXmx9ocxcPbrG3Quz4hJzLEyNkxpiNZaEqkvJjh/D6n8AgP4k54b+HbO3S8RW27uVupt0DLGWGacB0yMeChYo29mlFIeFn2c2BxppGc4+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2UT3hwxJMdM95R7AXZN6zVg0bLlGUHA6echcx25HMk=;
 b=or1o6Sk3kceNHt0pXTIv4cJHRIboHUVbFCgEDdZqrMncIsRlc7dc0cKLSiyc0rbly5xRRC529iaisP7EBAW9siwErYFxTfkbqfZb0Qg0ToTH1OYAjycmr/q3cGaJycz5KMzJrJtlMDJX0kw3knU5QqRDaF4IHK2H2EyM0EeGlVY=
Received: from PH7PR19MB6616.namprd19.prod.outlook.com (2603:10b6:510:1b3::19)
 by SN7PR19MB7164.namprd19.prod.outlook.com (2603:10b6:806:29b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 02:33:37 +0000
Received: from PH7PR19MB6616.namprd19.prod.outlook.com
 ([fe80::622b:8df4:3ed:f68]) by PH7PR19MB6616.namprd19.prod.outlook.com
 ([fe80::622b:8df4:3ed:f68%4]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 02:33:37 +0000
From:   Peter Harliman Liem <pliem@maxlinear.com>
To:     Li Zetao <lizetao1@huawei.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH -next] dmaengine: lgm: Use builtin_platform_driver macro
 to simplify the code
Thread-Topic: [PATCH -next] dmaengine: lgm: Use builtin_platform_driver macro
 to simplify the code
Thread-Index: AQHZz07x9j4/5YSzXUK7k5hAp34T46/sNX8A
Date:   Wed, 16 Aug 2023 02:33:36 +0000
Message-ID: <2ca61eb8-ebf4-a0d9-1c1f-c645e261a20e@maxlinear.com>
References: <20230815080250.1089589-1-lizetao1@huawei.com>
In-Reply-To: <20230815080250.1089589-1-lizetao1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR19MB6616:EE_|SN7PR19MB7164:EE_
x-ms-office365-filtering-correlation-id: 92f30fa2-4c13-4646-4dfb-08db9e0131ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bEeskxpWrpJPktSexD9bx0/rIZLgUwfB3WhnHsmrIZ7n8nyWM7SbAKT2165cwOm/k/D6nukqsHTBcPqV5zFCgzwymXI3bVcHC23jH37BxU71QwloywrSs7b3avlNdPLeDV8GTlvpH9M/JQ/4gaNLBf1Jr41eXi2XAJgdOGArw0YrukGcT5rsDgkzZNTdaN6lL/DtnBj3WRCFrkIiKTAu9qQnyu92r5txsvExBeY26uK/ZxPjisZPjc20WCPl/Vr78SR9jVjqZPKUhu7t34gbGk8U7wa9I8r0jy+RtSRHsuAnHSCXBlvWMqF5I+isFPS6clpLnvB2xmrI6HRZMYza8VTPNKWh9Bx8+EAcgD8CoE14+bRCji9/bL8T8HhNtbU/2tniqw8i8iwzNJvplAUgSx+pT5iSZE39euYKUamB1X2frUwuQf+q5TDA7NxVZwYQSYBApaxltrzH6FEc4d6krOejFKy3ncAM0hNuENy9t1NgN5K4BRYs2pYNuNuh+EHGP2HmSVi6Tgr+7HpBiw6WVYhRki+75UDmlwZ7RLbLMDz2ZIAFB/dhbXU7S+xH7mg4AtxpOt2lG79DCwadvWDsQh3E6UdVQzEbeqbae4KDRyvCM3kxjs2rpD6lmh7czMbDg45Yh50ywyNopuNvTgOJXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB6616.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39850400004)(396003)(366004)(376002)(186009)(1800799009)(451199024)(122000001)(8676002)(38070700005)(38100700002)(8936002)(4326008)(86362001)(31696002)(36756003)(26005)(2616005)(5660300002)(110136005)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(31686004)(71200400001)(2906002)(4744005)(478600001)(6512007)(6486002)(6506007)(53546011)(83380400001)(41300700001)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFIrU2ZLSE9BbVRBanl4aVN0N0ZWT2RtNHBnTzROV3JPR3RDRUpuSHlCK1Bi?=
 =?utf-8?B?eTBha2pNMGRPU2pjNUEzbzlNaTY3S3J2ZHdNV21SVm51U2YzOEc5UFd5TVhh?=
 =?utf-8?B?Y3Fkb0FPcS9qRENkWnRSaVd6dWxkVk9oQjNFdnJwNzI0L21yRTY1ZGppYk43?=
 =?utf-8?B?RmJNUkxseElxcEJMcDFZNnczVzlZYVd3emxZYzBPd3JZQ0s3cGdtVkNabUFR?=
 =?utf-8?B?WjRDc1JkbHdmV1BMZUltT1VkZ3RJdzg3eU9pOEpuUVJ4S0I3emRDQWV5SmtD?=
 =?utf-8?B?QVh2eXE4V2QxK3oxZGNPa2JPTWF4Zi9jS3dPMWJrZlQ4S002bVFiQjZTVmV6?=
 =?utf-8?B?b2I1M3hyYmdBTVpmUVJWeFNuSEhLRFJWQW1YeE45SFNocWpCNW1wZXZYTnhR?=
 =?utf-8?B?YVZzNEhQMk5nb1NhNlBsc0dubEIxZ2lETWprMmdJNlphNTdQdy9saDh1Q1VY?=
 =?utf-8?B?bnh4RW1XeEhYaVorbDZRbGt3YzZpZ2J3NTFjaUR1YmIwMjJhTWFDeTZSUmwy?=
 =?utf-8?B?TUo1Z011TTFyWFlZUy9KelY0ZXhKZWVzSG8yMUNJK1BBWmsvOU9wem5jZVRn?=
 =?utf-8?B?SzQxSWdoVms5RWJxeEtEQmZrTS8zMlArMTN1bXlsMWVJSXpTd2dadm5yVXdC?=
 =?utf-8?B?UUMxTzZ3eHNpZEFsZTQ5dmtaWHpQZU9XTi9kNHZ4cWVuSlFwQ2o4T0w1Q0NH?=
 =?utf-8?B?cWE5bUVRZjVkSDVyY1hkbkI4WjJBeHRkSm5KYjBKNFJqdmhUQ25TQXVHU1Vj?=
 =?utf-8?B?Y2RyTE9vWGQxSG5vQlNsYmhuMUdIY3MwSjB6bWxaYzd1ekpITDJwTXJCZjEv?=
 =?utf-8?B?WGJGbnZrVmdXUEhsditjTWpacjQ2RWJDRVM5ZllWMDdCUExaRm1QcTVLVVZG?=
 =?utf-8?B?cHg1S1JHVjM1ZzNjdmNUNDR1eXd1TnlQODN5bjlTL2wrMXlCbUhRTGo3azVO?=
 =?utf-8?B?amRBVlMvS2xoZkFGbEMzNEhGS2RuaGkrOG9BTS9pMmxUM2xDRUVwZWlCejNv?=
 =?utf-8?B?OC9aUWZRYTIvUlllSHQ1WU14ZWxsdWhObWF4Y1dENzRDNFBMYWlyZEtIQ1ZU?=
 =?utf-8?B?MHZDVmVkNmJTMFo4M3VzcldIcmVsbDlFWWc2cTA2dnpGTkZubFVNMEE5SUI5?=
 =?utf-8?B?QUF5Y3dHYUFmRFBYM3JoeUFwRThRVnFLN3g0M05ZR1MwVkdJVjh1Y3Nhb2Vq?=
 =?utf-8?B?RDZuQ3RZSjducWU0a2xhclRIbkF4NWsvZWVKcnEyOE9EdTRHcWpVREUwVEo5?=
 =?utf-8?B?MWdtM2F5RUZoQ0h1cVhKTlBPZmlQQWRobWJmdjNtemxEOGdBWnVOcHZoWVV5?=
 =?utf-8?B?aDBIUlRiaXh5VkUveVZYcGQ4bkp6S051UWVsQTlqb2lzNUl3ZC9KYVBoN0d1?=
 =?utf-8?B?bTNBWTUzVzhITXVrTHFhNllGcHN3SktUNFgwZmMyUktnZ3lrNjZaZUFHT2F0?=
 =?utf-8?B?Z0wyNjZlazFDWGt0cFZvbTlmY2g3N25lenRZVWFucCtLSFRVN1NGWmxoSWV1?=
 =?utf-8?B?L0RQcUxETDltVFVDOEhwZkpTTEhpV092QStlNzM3d2tKTXNhSHErM0JQVXJX?=
 =?utf-8?B?Q0o4UjliaVI5MlRBMitvT2QwUFE5OWlSRk1sYUNSd1RUVzc5ajhuV0hyZUp4?=
 =?utf-8?B?V3JIVjM0UW15QW42d1R4a01UMzZZNjE2K1RpdDQvcmhUc3NVR1B3bklEMjNo?=
 =?utf-8?B?aVcrUFlHcHM5d01aRnBTQUlDRWJkL3kvMk4xQXVYaVFsSjV2a08ydG5DclBP?=
 =?utf-8?B?eXVxM1J3ZkpoNmN5QXFaMi9yYlYvSjRxYUhMUEpQNitCbEkxVmVhcVdBeXpX?=
 =?utf-8?B?UkZ0YXJxR3NNdmlwZHZoZnZ5NXE0cEF4TWdROHJBb1ZhSWNBd3ppSnA4d21m?=
 =?utf-8?B?N3BEZzcyVHlwTkswZjV6WjFzcVF4UVVSTDlZZEFibERxY1VCSURZTkMrdEd0?=
 =?utf-8?B?eFF2WjdhUXR0V2xCTis5b3lPdEg4RURMbEN5RStGbWxldWNyblNqOE1COXNV?=
 =?utf-8?B?dEFLTWtJdHZ3OVkrc1F5NnA2Y2syS1RGTmw3T3pDLytNRFNUeHd1THlzVExh?=
 =?utf-8?B?cTRrTGtEaXNpVXRPN2RqemcvZG55emwvM1h2c2J3UHgwVDBhSlR6RnpaaUgy?=
 =?utf-8?B?QnloVTFURlVwcWF3VDI3WWpJSUpvTEVrRmxVOUcyM0E1ZFpRVVlZYWNOb1Rs?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6242963DFA2A4448B3FBC7822959EFBA@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB6616.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f30fa2-4c13-4646-4dfb-08db9e0131ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 02:33:36.7959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAh1VNJUtBD0qZUh0F0XuFXmguAo5sCw0rlCAMu5LIpU2NhA1cpofpFvtkXAAIdx8FH1uRKURNgq3xJ/YWzr4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTUvOC8yMDIzIDQ6MDMgcG0sIExpIFpldGFvIHdyb3RlOg0KPiBVc2UgdGhlIGJ1aWx0aW5f
cGxhdGZvcm1fZHJpdmVyIG1hY3JvIHRvIHNpbXBsaWZ5IHRoZSBjb2RlLCB3aGljaCBpcyB0aGUN
Cj4gc2FtZSBhcyBkZWNsYXJpbmcgd2l0aCBkZXZpY2VfaW5pdGNhbGwoKS4NCg0KQWNrZWQtYnk6
IFBldGVyIEhhcmxpbWFuIExpZW0gPHBsaWVtQG1heGxpbmVhci5jb20+DQoNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IExpIFpldGFvIDxsaXpldGFvMUBodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZG1hL2xnbS9sZ20tZG1hLmMgfCA3ICstLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Rt
YS9sZ20vbGdtLWRtYS5jIGIvZHJpdmVycy9kbWEvbGdtL2xnbS1kbWEuYw0KPiBpbmRleCAxNzA5
ZDE1OWFmN2UuLjQxMTdjN2I2N2U5YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9kbWEvbGdtL2xn
bS1kbWEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS9sZ20vbGdtLWRtYS5jDQo+IEBAIC0xNzMyLDkg
KzE3MzIsNCBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBpbnRlbF9sZG1hX2RyaXZl
ciA9IHsNCj4gICAqIHJlZ2lzdGVyZWQgRE1BIGNoYW5uZWxzIGFuZCBETUEgY2FwYWJpbGl0aWVz
IHRvIGNsaWVudHMgYmVmb3JlIHRoZWlyDQo+ICAgKiBpbml0aWFsaXphdGlvbi4NCj4gICAqLw0K
PiAtc3RhdGljIGludCBfX2luaXQgaW50ZWxfbGRtYV9pbml0KHZvaWQpDQo+IC17DQo+IC0gICAg
ICAgcmV0dXJuIHBsYXRmb3JtX2RyaXZlcl9yZWdpc3RlcigmaW50ZWxfbGRtYV9kcml2ZXIpOw0K
PiAtfQ0KPiAtDQo+IC1kZXZpY2VfaW5pdGNhbGwoaW50ZWxfbGRtYV9pbml0KTsNCj4gK2J1aWx0
aW5fcGxhdGZvcm1fZHJpdmVyKGludGVsX2xkbWFfZHJpdmVyKTsNCj4gLS0NCj4gMi4zNC4xDQo+
IA0KPiANCg0K
