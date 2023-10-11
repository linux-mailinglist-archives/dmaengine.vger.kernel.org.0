Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DA97C5949
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 18:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjJKQha (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 12:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjJKQh3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 12:37:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CFC94;
        Wed, 11 Oct 2023 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697042246; x=1728578246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/s2rla7LByYnQtmOzemaqEGSbQdyRNVkIbtRM1gRr2o=;
  b=Rmo3hStAwmY0O/orl8Ebpf3CTCjDjyZ70dpJ1IKrkyu1cIqofcMMk3mp
   tUcFPuNqxQ2ARnKb1ogeKzJkL5KZ8PQMvecQkjMIjG2t2TYouOjwXLb+K
   Q2gIGUDeyezwNX15IqgG3JjqFl+eM86X2HbOtSoG9p879cZlTf6Kil4aA
   Ax7BytIjqzOE3Je5mF1+i4HWz/Y50N+byxoa8RvcjyiwMMR+pTXfUTwkB
   CgcvA5K+MePe3waNbKh7XzTgrwNMVuam46drt+RpNaWm49CXZdopk9B7z
   tfNBPYK/iIQhcb0zU4Xqdso+dqEBwoxCPu+I2kf+7TwBF7gC0cue2J7Fq
   Q==;
X-CSE-ConnectionGUID: zXqx0+U+RPeUoRn7qHMCNg==
X-CSE-MsgGUID: 38ErOI91TGqaJymsOXvICA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="10293727"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2023 09:37:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 11 Oct 2023 09:37:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 11 Oct 2023 09:37:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGHIXHqpU1TypG2k0HP01uZi2cKpY4QMxhTcVCc8pzhUirW5/DIDlOgWZ1q6/D4jLK0fJ0t4Kk8/ongBE9loZwJW1sLsE3bf2/dBdUVmg4VHo0tz/XN89etVJiv+4olblsvBqeMn6Ez9E1SK6XFc0ZfsVfkYlhl80t21gh792GDThJXXyMiyZHEbpImfcCZt3GTy2etpwQBO1zvRScS9oOtnt55CJjbyjt0rGw3o3Gh3UEWZWay3wNH9V1EROaRGwmSiT97NsIxLK13nmPLpIjxy8dzeX2Dp09UJiq+zF7gLjCz0UEpV7CSlwPpxXd6kX83H2jSEMphNPy0PIBFd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s2rla7LByYnQtmOzemaqEGSbQdyRNVkIbtRM1gRr2o=;
 b=n98H2potwXhtfgugAfQrw7zMPfpVUsG1NlPvjjsTEJG2F1J/64Un73GguWKp4HIHhp04PvsT3C+bx7HCHeH1jlx5RXne10xN4pSZY36JEOxMyJwQ9XtrMpSgeg6P7nDVzAPi4Nw8KZ92zhzVDdxgYUPc4F0TmiSKoNyIlqaRWU08l36rkxM8hgxwaQwNinV/NNJniqpeTzT3ijiPxppAsBJBvtitT3u9F1ED2REiwyy0CTvzH4KnuHMq8C+J/ERIHhkiQIBQFxiUdWbwuP9XjFQ4dpZ3pmD3Lgeuny21SAK4zQnxHw5SHgks27kmQwzp0GAXl78xo3HA9k4llKCM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s2rla7LByYnQtmOzemaqEGSbQdyRNVkIbtRM1gRr2o=;
 b=OmkFA4BwvfePfwSkKgGap7On9jsHizlzqVYUVuO+C9KTJWW5V2OO9CO8nX4BI6++kq+eX7i82mg/jRxCdc7F7tXTelcXlA5g1S0RH45IqP4d19zU0wU2twPFWt/3SfjNmZgdZmzjuI152IZX+/ljZsO/rohKm/2G/foYZfjixFc=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Wed, 11 Oct
 2023 16:36:57 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::db2b:c4a2:b71a:95da]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::db2b:c4a2:b71a:95da%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 16:36:57 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <George.Ge@microchip.com>,
        <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>, <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZwZllP9AErauFFUmKz13YRSBKD6/VzMKAgAIhf4CAZAP1gIABCsYAgADKTQCAA5sdgIACmkmAgADx6oCAAFB+gA==
Date:   Wed, 11 Oct 2023 16:36:57 +0000
Message-ID: <f6beb06cc707329923cc460545afd6cfe9fa065d.camel@microchip.com>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
         <20230728200327.96496-2-kelvin.cao@microchip.com> <ZMlSLXaYaMry7ioA@matsya>
         <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
         <b0dc3da623dee479386e7cb75841b8b7913c9890.camel@microchip.com>
         <ZR/htuZSKGJP1wgU@matsya>
         <f72b924b8c51a7768b0748848555e395ecbb32eb.camel@microchip.com>
         <ZSORx0SwTerzlasY@matsya>
         <1c677fbf37ac2783f864b523482d4e06d9188861.camel@microchip.com>
         <ZSaLoaenhsEG4/IP@matsya>
In-Reply-To: <ZSaLoaenhsEG4/IP@matsya>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|DS0PR11MB6351:EE_
x-ms-office365-filtering-correlation-id: 2bd95c98-9595-45f6-fabe-08dbca784947
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HpXBYO7AusCECesWmfKCv+HKftrTxqa7VQelXdFprRr7zWYmRhlQ8RnWzm34fkIT4AWf8YERdilvMsudw7eIZRKcuNI/D9l308GIBdHuFDnQ22diIO4dK1uvauMv3LHjcQcYUErYyuWVdt1Myjjh6WihmqqdwzkKNCJnjnuQkG/RbiSVwL1NRogSYn6sYwNYc+hd5YhMV15GapqEPAY9vJ1zMcEHDTDsmFKNdysB8gZsOMGLVSG1MoZ6aEbl1U+C8hNbOYU/uyWJPHszaiWO+fQmjNcvZ0u/LNCThBG3bhrox9svpE+9gw7EOxOw3MGhxguIXnd3KfXRhn4Jnhd59BRs6hEdIkrOsYhMxKrCNQ/PuR4ww8V1fuSfSEmkBPFUWMgzar1icpbRW+vTERVinDVvsKTICAiH9Kwndqoq7qtGpAGt76fv2LB+uJVET5FSbep8T8eG4BvLXQtqKF+VfXP5NsaFkaBuCxsfadyGd8Nc4Zk1yXx8POSnFUA8KoVxvHLcNVni3/FwRBxt4UCMaAKM2i9Q0Dq3Ak/Pv3x19cnku3qpudBD7HQlkHmNNec3Q4SHtDXgk0iIMU1AfPPqYifSOvfIsqEpWH529sGcXnurfWRtyS1BeQpGOIBH3eci
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4001150100001)(2906002)(41300700001)(66556008)(2616005)(6916009)(64756008)(66946007)(26005)(83380400001)(76116006)(66476007)(54906003)(316002)(66446008)(8676002)(5660300002)(53546011)(6506007)(8936002)(6512007)(478600001)(6486002)(4326008)(71200400001)(36756003)(122000001)(86362001)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0RUYlZuMkpNUEg0dlNXTUU3ODg3REEvbUM0cklWTHNjYW85Z3ZRQnY3QjQz?=
 =?utf-8?B?c09yZEYwRjljSzRGU0ozays3N3pQMjVkL2x0OWREdmQzMFBVd1FvWVZJZ2pi?=
 =?utf-8?B?bUVFZjBLMFRJa3VPYm1FdzZxUkJmRUk4VVdyZU1ENE10VXU5bW9KTU9wWnFk?=
 =?utf-8?B?UjMxeUNLWE5uU0ZTWk5sUTVPU0FmL3NUM1ErYVozTFRHanRXRHZhL3IvdDNv?=
 =?utf-8?B?QVgxOWZXMGJyNVFISFlNWlB4SFdRTmF4VFBnaHA5b1JyNTROWU1heXJ6WG1P?=
 =?utf-8?B?aWNjZVdsUk9jamljR25SZDg1U0hBQkdmcjRhNUpGbEN6czFrUEZ4bXBDMWJw?=
 =?utf-8?B?d21vS1MzOUxQaFkxcWlCeXdRd2VEM21PNFBXMEVBWnhWL3VNcTRhSlRYT3cv?=
 =?utf-8?B?Y2hFU0VLdlRja2ZMUkZEMHQ5V0tTOHZDYTFzMGtYaTBJZFFWMkFVQWFJa1pw?=
 =?utf-8?B?RlZxaTU1M2JtSVNsR004N3pXYU0zVmhMNjhlZkdLR0xmbnU2UU9RbHBpZGRG?=
 =?utf-8?B?SlRUVGoxVVZkY1pRZS8zTDlBc2ZDSGVuRVJUdFdOY2xqcjIwb1dMaC9najV4?=
 =?utf-8?B?dXJGd1dnNXZWbFVaNCtERzV4OWhQcXhzSG5UNHJ5SWQ1Z0F1NVpieEx2Tjgr?=
 =?utf-8?B?RjREMDZ0WnJxVk9tWk5KMUhjV1R2c2taRGhTWEwra2prQXIrQjN5d2VCdEdH?=
 =?utf-8?B?RUdockdHY3pIK0d5emZabnNZV1IwUm5TUnladHlOSXRmMTRJR0VubDRic09E?=
 =?utf-8?B?ZjB0MmZ2OFc1UFBkSG9nMnhhQ2krQUtCUkVKeW9MYXB2VW5iUGl2Qmd2VzUw?=
 =?utf-8?B?b2k4SS92QlMzY1F4SGpESEptcEZHN3BGS1ZLcVNzaXdiajBlVVRxSzdIMGdm?=
 =?utf-8?B?TGxQZkFJZzZ2bkwwYlNnZk5LdEFkUXRQZXVydE41YmRBbjR4ZXFiWjBubGNw?=
 =?utf-8?B?SWxSYXhUK0tvdzluRG1HWmRkTThxZTZQUForbWVmdjRyOUhzT3NnZHJacExN?=
 =?utf-8?B?NS9NcW0wZlJWU0xYVDVXd28ydXBxcUh4WEpMSEZNbGdYU2VhV3BpZC9iWDN0?=
 =?utf-8?B?aDlZV3ZqdXdPWXlpaHRicGZ0bFhLaUdDd1hMOHp6aEoxSmF4S1BiK0VkRGdx?=
 =?utf-8?B?STdyMlVuZnhyQ1JBTG5CRWJ6SWdlMEpyTWtVQklQM1kzSC81RlNoQ3RTOXhM?=
 =?utf-8?B?R0VVT0hBRUxabEtkczk3d29PcVhIdXV2MHV1TjQwQU5TUjdNcUEvMU85UUVO?=
 =?utf-8?B?UWRpNVRVMEhiQ3pDV3ZHS1l6SE91R2c2MGNTK1o4MUg3VERuSnhoaTIzb0lp?=
 =?utf-8?B?UExtWjh3alZlMEZOMGZOMFE3b3hnajFrSWlzUXl3dElHTHU4K1htVEMvK0tz?=
 =?utf-8?B?VWdzbHNoT3B4QkNEbjVJRlNwL3E0em1NTCs5aHBpZEcvVThxSXVzdm45N01Z?=
 =?utf-8?B?SHQ5OXhaaFYranh1TWlhTHprTXNIaUNXQmpMM1J1SEFvbjFIazdwK2o3VzA0?=
 =?utf-8?B?c1NQa0tvekxkM24ybE5sMitsWStLazkwTjJoSzd5ZFMyS05NTjZDY3gzdkF3?=
 =?utf-8?B?VVkrU2J0QUpBT3JJVGVEaVVVNlFOVzZnV2x4Wm1WZURQcVZXQURQbHNlSXkr?=
 =?utf-8?B?bUJOR1lZelZzcXFNZ1JVR0UzVXpSNTEwY3ZnSkMxNzdKdks0dTBJSDRPdmpH?=
 =?utf-8?B?WUNJeFg0eG9RTFhxRmVzekRHZU45ZEIveVNubnBaRWlxaVM3MmNPUnFHV3NY?=
 =?utf-8?B?TkRQWm5jRDBYbjFjZmlpNUErcUsyTmljVHVSTzMzSXVJQWRwUFpBTDJzak9y?=
 =?utf-8?B?WXlpRWZuWmZEL0lFbG1sQ29qRDJINXI0akluU2NjcXVRUllUOHVObi9RY1hj?=
 =?utf-8?B?Y245Zzh3TlVuMmZpcytvRjg3c3lmUW5IK1FITG1MZ2RjRDQ3aU9BbEpmNER6?=
 =?utf-8?B?VHNDdDR4TDEvS2tJWEIwdGVFNklWczI5cDNHOFpDQUlsRVFXM3M1VHpFcFpG?=
 =?utf-8?B?cEY3Ym96RjliTkVLQnl2OG1DRk1na0QwUlhsaWk0bHlYempXOUJUek9EaVZM?=
 =?utf-8?B?T0poWUtraklZUUNiWllqemNMU0JzZHhOVFFIVm5zUHR4MWVFRGRiNzBKelRR?=
 =?utf-8?B?bFFOV0tkZ0xhT2p5cmRUUGtkcFpyallkcGFiOXpqald6S2NGVU5WS1dRdzZs?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B02D494C95EB104198CE05CE9335DB1D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd95c98-9595-45f6-fabe-08dbca784947
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 16:36:57.6983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4Nt3h/2GyyTrsyWnU5uWuEAsH45OOrmJa4//H1B4jqm2eUGLMRScV6WkftHXncit7jlJGqpUslykAHl29PMPsiJ6qTH3jFkS7Fj2t3uNag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTExIGF0IDE3OjE4ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDEwLTEwLTIzLCAy
MToyMywgS2VsdmluLkNhb0BtaWNyb2NoaXAuY29twqB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjMt
MTAtMDkgYXQgMTE6MDggKzA1MzAsIFZpbm9kIEtvdWwgd3JvdGU6DQo+IA0KPiA+ID4gPiB1NjQg
c2l6ZV90b190cmFuc2ZlcjsNCj4gPiA+IA0KPiA+ID4gV2h5IGNhbnQgdGhlIGNsaWVudCBkcml2
ZXIgd3JpdGUgdG8gZG9vcmJlbGwsIGlzIHRoZXJlIGFueXRoaW5nDQo+ID4gPiB3aGljaA0KPiA+
ID4gcHJldmVudHMgdXMgZnJvbSBkb2luZyBzbz8NCj4gPiANCj4gPiBJIHRoaW5rIHRoZSBwb3Rl
bnRpYWwgY2hhbGxlbmdlIGhlcmUgZm9yIHRoZSBjbGllbnQgZHJpdmVyIHRvIHJpbmcNCj4gPiBk
Yg0KPiA+IGlzIHRoYXQgdGhlIGNsaWVudCBkcml2ZXIgKGhvc3QgUkMpIGlzIGEgZGlmZmVyZW50
IHJlcXVlc3RlciBpbiB0aGUNCj4gPiBQQ0llIGhpZXJhcmNoeSBjb21wYXJlZCB0byBETUEgRVAs
IGluIHdoaWNoIGNhc2UgUENJZSBvcmRlcmluZyBuZWVkDQo+ID4gdG8NCj4gPiBiZSBjb25zaWRl
cmVkLg0KPiA+IA0KPiA+IEFzIFBDSWUgZW5zdXJlcyB0aGF0IHJlYWRzIGRvbid0IHBhc3Mgd3Jp
dGVzLCB3ZSBjYW4gaW5zZXJ0IGEgcmVhZA0KPiA+IERNQQ0KPiA+IG9wZXJhdGlvbiB3aXRoIERN
QV9QUkVQX0ZFTlNFIGZsYWcgaW4gYmV0d2VlbiB0aGUgdHdvIERNQSB3cml0ZXMNCj4gPiAob25l
DQo+ID4gZm9yIGRhdGEgdHJhbnNmZXIgYW5kIG9uZSBmb3Igbm90aWZpY2F0aW9uKSB0byBlbnN1
cmUgdGhlIG9yZGVyaW5nDQo+ID4gZm9yDQo+ID4gdGhlIHNhbWUgcmVxdWVzdGVyIERNQSBFUC4g
SSdtIG5vdCBzdXJlIGlmIHRoZSBSQyBjb3VsZCBlbnN1cmUgdGhlDQo+ID4gc2FtZQ0KPiA+IG9y
ZGVyaW5nIGlmIHRoZSBjbGllbnQgZHJpdmVyIGlzc3VlIE1NSU8gd3JpdGUgdG8gZGIgYWZ0ZXIg
dGhlIGRhdGENCj4gPiBETUENCj4gPiBhbmQgcmVhZCBETUEgY29tcGxldGlvbiwgc28gdGhhdCB0
aGUgY29uc3VtZXIgaXMgZ3VhcmFudGVlZCB0aGUNCj4gPiB0cmFuc2ZlcnJlZCBkYXRhIGlzIHJl
YWR5IGluIG1lbW9yeSB3aGVuIHRoZSBkYiBpcyB0cmlnZ2VyZWQgYnkgdGhlDQo+ID4gY2xpZW50
IE1NSU8gd3JpdGUuIEkgZ3Vlc3MgaXQncyBzdGlsbCBkb2FibGUgd2l0aCBNTUlPIHdyaXRlIGJ1
dA0KPiA+IGp1c3QNCj4gPiBzb21lIHNwZWNpYWwgY29uc2lkZXJhdGlvbiBuZWVkZWQuDQo+IA0K
PiBHaXZlbiB0aGF0IGl0IGlzIGEgc2luZ2xlIHZhbHVlLCBvdmVyaGVhZCBvZiBkb2luZyBhIG5l
dyB0eG4gd291bGQgYmUNCj4gaGlnaGVyIHRoYW4gYSBtbWlvIHdyaXRlISBJIHRoaW5rIHRoYXQg
c2hvdWxkIGJlIHByZWZlcnJlZA0KPiANCj4gLS0NCg0KT2suIEknbGwgcmVtb3ZlIHRoZSBjYWxs
YmFjayBhbmQgY29tZSB1cCB3aXRoIHY3LiBUaGFuayB5b3UgVmlub2QgZm9yDQp5b3VyIGNvbW1l
bnRzLg0KDQpLZWx2aW4NCg==
