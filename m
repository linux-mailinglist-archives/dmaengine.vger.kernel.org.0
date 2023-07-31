Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C982676A47E
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 01:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGaXH5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 19:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjGaXHx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 19:07:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE68133;
        Mon, 31 Jul 2023 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690844870; x=1722380870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gAoXaaguvOMPyaYhYtrAhXoAZsjMExRPN2SixWvFN18=;
  b=ZRc6/ZzPCGDYMlCZDy5fR4MFkVh4aU7buptkpW5aZCEDLb4V6l6PNnMW
   APIqwm+HGi8EMpLbQuJnppNVjMPIfoj8tKB/34fXip9XylHn53TUiBkpD
   QCdEiubq6FuwIHDbAMnlX+06tVlpTnAvFjr54nOabURB7iBzGw8r4nEhg
   46QaVNwkx0xAfbd5AMOqgHWq5sy7MlGR7PvP6fHp2U01ZvjytGwPOxDr6
   Rlsx+ul5c+MJtlWPipRsZ/Rd4fmNPi3JXKE8lJCYNb4XoDSdVNkNBwN1s
   9c4pWcIGQMLaa+aA+kDfAmyqkhsFxUnUAzK7fmGSMJCkfCV07VNs6+tTZ
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="239003573"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2023 16:07:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 31 Jul 2023 16:07:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 31 Jul 2023 16:07:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSJpB8irXxqW9/2MhkhzPUeJotiDfD0lygt/YxCG1TRSu+fnakvNBp+HNXwLwNieHkzZYrfb+fOM/oxVfcuNx8874k6m4782StW7vU5K2SiPem1xGeLGpJUmp2nfKG8crf8aowcuRY8cnzUVF31x0t0iAWMsFE0MCFhRluTENsH3wyHOa3YmXSb6U0F9+GrznwyaCeyPb8180+IhgBFVUg57WEYLrsliWpXgOcUlWXxGHazBTrugIpFzXblYMDOzwRrgOjTc/nYVwO59eQxIYR4L44A47m1j8zrqp0ALSluz+WLe88H8xmfNJa9+SqVXhcSYlDCily6aOO8Mm3nasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAoXaaguvOMPyaYhYtrAhXoAZsjMExRPN2SixWvFN18=;
 b=SpP+iKTmzORM0EvUnd7Jr1HkzSr6OP0FXLltdgFyBvG3afb7yBiyvo3OK7Hus+3HvT0BjudwVn0R6AaPPFfwc2d1YKwHpHar7tgCQ046c2WQoJYUi+kh+3zDDR53KZOC9T+IPorj8q2awodqJS9XZeiE1AuXBres9Rux1/JahS/UKJu5OPGoGdsteIe+KezzVq2LW0GoJa3GGcoRNih9D2rF6LxCfstw3h6sk5xVk4oyuPpkMu6J/xZ3SAA0GQknbNBGsz3kVX/zDSM0ZIabLyl80tz9j09+UkJ7bEKGhSXEX8T47UtzXOtWI/6gmgBNWZ02ZRqLclssDht/2gDy/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAoXaaguvOMPyaYhYtrAhXoAZsjMExRPN2SixWvFN18=;
 b=Nwua9zu4dwNcsYnSYMBBY7asvvGwxsI/T2hLMNAZPbKGxDVy5tG9oZC0YzWq5iWQCLJ7dZ4QI78cnucXyWEf1yj3FzS9ywSKg+vb7Blusqj7gWdSSX3n7YOvvdhvi1HEqgs5cR7qDgFJHwohkpUU2+DrCHWVne7xc229QbtIm/0=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 23:07:12 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::344a:f9ac:98d2:7e7f]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::344a:f9ac:98d2:7e7f%3]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 23:07:12 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <hch@infradead.org>
CC:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <George.Ge@microchip.com>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>, <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZwZllP9AErauFFUmKz13YRSBKD6/TeFyAgAEL6oA=
Date:   Mon, 31 Jul 2023 23:07:12 +0000
Message-ID: <f4dc2a4274a4ba98042acffbeedf610c61892a9a.camel@microchip.com>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
         <20230728200327.96496-2-kelvin.cao@microchip.com>
         <ZMdd4SpqhLnOxqwb@infradead.org>
In-Reply-To: <ZMdd4SpqhLnOxqwb@infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|BL1PR11MB5399:EE_
x-ms-office365-filtering-correlation-id: 7d31044c-3823-44f8-4f44-08db921adfda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F9mam0Evivl1ORppTZauYSzVLjXxAjQIayKdxAsT1uRAEAVdAm+yWSPwzyY07AnsR/Xwo2IFE+h/2lJjwNUOuzXXvZTz7fFL2l3Iyuk9sFwWS3yd8cYbZ8XtJT6STxlV2eGhTsFeD0VOy4gVE8tuOrpbcemS8i8ujGROsAsHRQUg4NhRAfByMd9XPm7UyCrdvFNb3+WrMR2sfmUEAaJK8p/C5Om0L+tzkO2qqPwJWV4Fc/Ua73WxZWwYLzb9RfvpDq+MC79DK2frf2Wid5AGhbi6A8Ri4HP9/3EUa+FjLoAOX7DRLP9WCs+isGNF27zC/XhX9/A7X0wiBo/4FzyJ3e/sVS/wSed6OXlo9gIWh357Oh3qjjZk3F84jWkZlLIC2SU7MJJJNwdjlmvgH0dWrOkn4zYSPjBTCuTSxfZK9qzeSxBiif6RFSdJksayPme3iV0k0rGrMVMNKEZUCo7jkwNIiuk6JiqQoQzE1F/c1E+ncarSjRmJ1fm+AchFWc9L7Kp+Knd3Nn/8ihmZjsm860LT4Sd81zBEIaa9K2/TCPmChi5wLBS4eOB5RQqlhP9dwy/VxoVKAf7soCPBoM7y/5KCQ8AgWBoRBnG5JJxRiNjr6D0zuAsfSX0bbcVwMWgZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(6486002)(558084003)(38070700005)(6512007)(86362001)(71200400001)(186003)(2616005)(36756003)(6506007)(26005)(38100700002)(122000001)(5660300002)(8676002)(66556008)(4326008)(41300700001)(8936002)(76116006)(66946007)(6916009)(66446008)(66476007)(64756008)(316002)(2906002)(478600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGFHUnN4aHJTTVFiS1QvV3VNTHpERHh6UExxU1hyZnU5MHMrK2F4L2sxbUZ3?=
 =?utf-8?B?bVl1V1R3V3dPRlN6VENleXBWOHFVUE4yYTBFRG9hVDRrR0J3cE1SSzZSMHk1?=
 =?utf-8?B?TGgzYTR1Q0o1UC9wZXlHNmxCUTgyaFJ3cm1NLzVzMmJTNHh0aXVrc2tHM2M1?=
 =?utf-8?B?N281c2NYdTBaaC95RHV5Q1F1VnJTVS9zVnljSmQzMS8reHVkRy84YVBlanBZ?=
 =?utf-8?B?QWhZS2I4eVZpN202TWxCKzBGdTlhYk5UTlIrMWlxVkRiTk5oNXhOWUNaUmM4?=
 =?utf-8?B?YWozeUpvVi9YQnFrWXRMbzIrWUdlenkxa2grcXdYd1U3enR1cnMxRTQ5Vm9Y?=
 =?utf-8?B?VVJVT0lCYVhtc3dUTStydmhQdFo5dW1MeklxTkViemFLaDJaM1JXQmVrQmNC?=
 =?utf-8?B?dHNwOVVJT3hWS2lFbnY0U0pkUmsreGJUS3AzYURPNzg3d1VxL3lHVnlFVFdT?=
 =?utf-8?B?clVGb29UbjRyZXlISHpDSTVXcXJSd1djc1IrODdvc25HazdvczZhdFpmMW01?=
 =?utf-8?B?NHREU25weFRrTlhHY3VPZjZMcG1zMkJNNGtiVFp1VUQxZ2EzWVA0WnNnWEsv?=
 =?utf-8?B?VWY4TGNOYzlNN1U4MWxTMDQrUEEvWnBYcUpSMEVrMEJ1eVFtSVRkdlZETDda?=
 =?utf-8?B?VndlVUd4aW1pTWVZamtVM1RqWDNEUlBTcjBFSnBrSUZ2VjNSTTQ0Qkgyc01P?=
 =?utf-8?B?eUhGRDJ6ZWRqZXh6RXRlUzl1WnZKOTJEY25VUUZqOWlRMW8wN3J5N3JFNWZx?=
 =?utf-8?B?aTNndzJIUHZoMnArdGZzZ1dsVGMwOGVlNU5ucnVzTjNpODFGVG9kYUsxRWVs?=
 =?utf-8?B?Z3Z1YSttclAvaXBWaUVCSWZNSXdIUVpiY3FlTndMMzlwTEpiSzhpWVQ0WjZQ?=
 =?utf-8?B?ZTRVTGNDb1h3aFNXMHZhVE95RnpEaGhXdlM1dzkrK1hKcldSbDdFS3BqODNK?=
 =?utf-8?B?TmFTNE9GSFZQTVV4SmdmVE1xMnA2VVU5clEwemlpK2xTMlVBa1NrRWdoMlZu?=
 =?utf-8?B?RGdRZ2x3bHpUQ2JxUysrcitGQnVhRUlXVnFwSzdvMTNSU3BMeGJucjE5SHQ5?=
 =?utf-8?B?Qkt6MGsyVGRlWEFwZ0pzOGRMTzMxZWwra0NSSnNCaUlVNUdUOVc0SXp2NzBO?=
 =?utf-8?B?MDFYd0JmbUlnSU9VUk5SbkVkVjRpYVplakZuWTRoSUFTaytNcHUxM0FGTDI3?=
 =?utf-8?B?K2hLd2k3Z3Fvd2NhN0trUDhYRklsTFNickE3T1lYSmFiUTFwTWxwc1RzS09M?=
 =?utf-8?B?ajJHaThha3E2TWEvL2UzcjhZUGpIaGVOeUtmVjJadTBibmVvWDJ5OGo4Vm9H?=
 =?utf-8?B?c0JWVlFma3Zpeml2dkIxUWVtcklyeHc5OTd5cUxFMHRjVHprUk9YT3lZajUx?=
 =?utf-8?B?ekI2aVk2UktSSTNCb2RTVFlwWFRUZUY4U0NvaEMzUjVMeFRSbDVhTWpYMzdy?=
 =?utf-8?B?ZFg3ZGd1K3hpSmVpL0lCQTgvOG5QNTQ5UjMyaHlLaHZQazZSVHBIcVA1b25r?=
 =?utf-8?B?U29Fd2xPZCtqbWRjdDR4Qm11N1Q0a2JKbGM3azg4enVjN0tEWDhhaWducFhs?=
 =?utf-8?B?cHROM202Z2pMQUhZNkRheGdocVFFdlNsSTZRZDB6UEk5RHZVNGViUGVmcmNQ?=
 =?utf-8?B?SkFEaWZBbkEzOXFhZHlGUVRSZmxVNmZFNTJ1R2V3NFU2V0NEcmhxR2JjenZh?=
 =?utf-8?B?THlFVXEyckNudG1HQ0doenRVYmF4TmRsZU1PQTV3Z254OTYyS2ZMYXJLQjJC?=
 =?utf-8?B?RWpmd0dWSEt0TEhBdVl0MUg2THZzejVYVUNSQit5VnJNa1c2VjJYYmxQR2tn?=
 =?utf-8?B?QmxhdnJZUkVJRGg1bnpFK3QvdGNnUzdTSjlYOVI3cUpsV3J3RHZkQUFpY1Ex?=
 =?utf-8?B?WjFsYW9yTWVCYWNUdjBuUnlZVWxoYzhONUdMMXdML3JEQVVKa1BMbE5NcHpi?=
 =?utf-8?B?ZllZNHVyRUlvY1hJYldPRDcrOVIvV3ZlT3NuYlZUWFhvcXVZbVE2Myt2S1Ny?=
 =?utf-8?B?MGd3bGQyV0JGOEo4dUtKeG1qNlBmakt4bVl2UU9EYjFEWkdXMVl5anlGcFll?=
 =?utf-8?B?YUhFTTlBRVRmSEZmZVhpUnRUbG9DZVBhWHdwSW1YdGxTRENjQkFwNW5TZnNC?=
 =?utf-8?B?cTRtRXlZbHpRSWdCc3FxdVhpdVhGeHR2Z0RQSk9Jbi90VmI1OURqdi93MnpS?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <656BBC531A457546BA126B5274BBFD62@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d31044c-3823-44f8-4f44-08db921adfda
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 23:07:12.5270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRzp01oaSO4iBxAYXPdSDo05uFeQ5s74XA6uHH6I4m0Ir0yXS9Ccc4ArxOkwVVMCVBcpobYmYNOUSa0qAOa6Na81JW/7e1zcv5KEpo//DNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5399
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTMxIGF0IDAwOjA4IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBMb29rcyBn
b29kOg0KPiANCj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0K
DQpUaGFua3MgQ2hyaXN0b3BoIGZvciB0aGUgcmV2aWV3IQ0KDQpLZWx2aW4NCg==
