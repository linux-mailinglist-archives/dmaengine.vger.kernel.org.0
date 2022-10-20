Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10546057EC
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJTHK3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 03:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJTHK2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 03:10:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520DA4E1B0;
        Thu, 20 Oct 2022 00:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666249827; x=1697785827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I7hOIkUzY2e+TSu7u+4dhxfirakw3dFh/YHd5X3pOyQ=;
  b=I2IE/bYK9sdGutxjQpphqsKdgmPpFESjwq/DrzJHxU6p5DvKFStiAocd
   LsUfnDVrwf/Xp9F4E8b07V1BMXSsmjnikAix0MFtxHDZJ0FeUTWQkuCTM
   mzkIp3HENVYqmlL1TfhaUA+opcsV2aieufAIKVbPgZdW/NJzjwvjhBlUG
   De18VcHIs4ZGzIK+KtE0tEf5NGTxa2Pr7VdBe0CEhf6MrW7jdpmPQKpAa
   hT+008d49MTwbIDvfuOc/GctehozPtg5W1RdEvr8hzqm10t1gn7ceh/zK
   b3hVxIdusB/EaNUdEVbkZk1aMgWIBA/fvpQONl8IPYEgyiqdEA0Rg6C9R
   g==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="183092684"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2022 00:10:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 20 Oct 2022 00:10:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 20 Oct 2022 00:10:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5EUet3nxVU7MgT60ZOLG9vb5FMIAOmQyHmAk/9PCsBE5tKJ0iQsbo+RrGE/2HhWQg41A1ibGehNkZ8Y5pelnCgZulMlDsoJVtDbfT8lNM7GZbRWSItm/Lx7asjHfh4V58VWwKbMl4JaE6lMS9LQEO5RgG1EEo9R3cDlKe8yFHtREAcqZr45BVnjUVnAG1sbi52EchnKq9Vki8/w4LMpsjDJIscS2RRNIgITRWcp5lf0DFX4PJApjif7/0CCUFmQHmlJ1oazV/BL2r7vIulWzZU00Bk0cXn3SWYtfQcyV+VKOdlA5NOa4Q5niD/ydYs8BILWEoeUSeUUhsXTjo1lRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7hOIkUzY2e+TSu7u+4dhxfirakw3dFh/YHd5X3pOyQ=;
 b=dLq70IfG8EMrl668W5g7f4B/snGrSVMas6X4Gn1l5fbojYFJIt+gK/IMQOMPGuj8XfFfW290TRhkCSy4FbDFDHzFchtSdeLcHxRiw5ehHX3llE8AI22vEtzZ0LSlrHSgpsL137gaiZ2IgwSsTmGd+renKg8eNOBU3a0XOKfECMD8Eou9h26+K6hO84LSDzUkr47CzsulMNCWEXD0WflWISnElfEBF1fwichYLNWbNf0p4ugAuTocM6CPJ+UJJdhOiMhjv1PuM4MWNPCowZxRThGHDtUwGHxRSkoVIbM1m3+rRqLKkPVl9K5XCa4+x5FyqY1mUcxFL4cB1Oj8o5SQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7hOIkUzY2e+TSu7u+4dhxfirakw3dFh/YHd5X3pOyQ=;
 b=KIWiuQz6W7K1wKujllk2IM3yBWL/J4J6UvNjTbbGS8VUm5Sv6AReAVjbGCTfwmyhIoo9rSEtVUedy9+82/vSmdyf5UZP+iLUcwUKpeyqwX5WyPiFVTl4N+drOIzgIh66PxGD66Eq230AlPTa4KDrfDXinofwkB9rnTbORLe23X8=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM6PR11MB4627.namprd11.prod.outlook.com (2603:10b6:5:2a2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 07:10:16 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::cf13:1785:f79d:9eb9]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::cf13:1785:f79d:9eb9%7]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 07:10:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <peda@axentia.se>, <du@axentia.se>, <regressions@leemhuis.info>,
        <Ludovic.Desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <dan.j.williams@intel.com>, <Nicolas.Ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <tudor.ambarus@gmail.com>
Subject: Re: [PATCH 31/33] dmaengine: at_hdmac: Use pm_ptr()
Thread-Topic: [PATCH 31/33] dmaengine: at_hdmac: Use pm_ptr()
Thread-Index: AQHY5FMBwM48+0wVvU6KDWIpYLhiQw==
Date:   Thu, 20 Oct 2022 07:10:16 +0000
Message-ID: <cbdf8ee5-ee73-82b2-a12c-5c66312e804a@microchip.com>
References: <20220820125717.588722-1-tudor.ambarus@microchip.com>
 <20220820125717.588722-32-tudor.ambarus@microchip.com>
 <Y1AqvN1gn/wyAf55@matsya>
In-Reply-To: <Y1AqvN1gn/wyAf55@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|DM6PR11MB4627:EE_
x-ms-office365-filtering-correlation-id: 7e4131cf-cead-4c46-aaad-08dab26a23b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sFLdt0C205A8598ydGb/lnIAP9uRC8yTdUdzdoUUFxgCyaThrfOZ7NHHM2cvCQXlE70nvvnszT4gJbpbRlE8wRYSCkjpO5TXk1ALJYptty7NvuERXUnV13/ZDpS9IIOu3OL5i57ZmYUNBetnAVeXYJmpeDLA2FN4/ejIjS64qxBnjoliNX7dAwxHF/2FWJS1nRz+57p4wI/83n1hSHyJSQtPJeXsiEfxDuZjtDpHDnrFHlgMImeMzJvHi5Q3zvCs4+T0YLXceLH5xlLaAtZDj48kvaUcnnWEs48lD48VdlWZPbTPVrD+3TzQCy6MIcMX1/Qg9+m+6M6+CUpaSAde6Do0No58tck755EAAAn7AhA3WkxHZnAGqSU0UOfD1Lljr16P99wULm7YLklqhxkNiCYdaHS9tgSrrbtcbhVBsR+tOR5vrim1RW/LYyRvwYqSkEPYnQgKWMun1ldbKSgxDI9B7rxOnsfhWYUL5qDJoo3Crp30MfInT5urJoV/aCt2ltpNrYnRnbbYkkZX6R/e8AnLKWqyWlp3B7tbeMlvMVYyoeSNBHLo3KjolyW05OqcTVlle5qZZkgTK0UeDtDVREiYSOd29gZbamVqS3jdOzkqrNTkXjUPku73cjROcK7pfj3lP+Ji6+lUWCHxck2/BHvfoiXaJVRxxZ0OPJAadK1/3wFAHabVBR9PxN3v7HHJX4tDpwmHkNipyYMB/AvHgUByEVx9qMex4k1jNFGPQl2Gjc2xiZyjf4QAEUBddxQ/6gFo11SRC7zZaA1j2AFogvjCc+cjv4polAOPrNV9gTF9jEz8cb5fD8csQFDkgog5QBBoNCmDX88EivkhKxXJGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199015)(76116006)(478600001)(31686004)(71200400001)(83380400001)(86362001)(31696002)(6486002)(6512007)(36756003)(5660300002)(91956017)(66476007)(66556008)(53546011)(66446008)(8676002)(6506007)(26005)(316002)(41300700001)(8936002)(6916009)(4326008)(7416002)(54906003)(2616005)(186003)(2906002)(66946007)(64756008)(122000001)(38070700005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGwxMUM0VXUzcUdUQUNXZzhIdG52Z0F5Wnp4czlqcnVNRURzY2F6VHU2QUp1?=
 =?utf-8?B?V21rZmd6YzZnbHdBWDluaUJxZUtzZ3RFL2VJNm9zVFJZVkpJNG5ncDVaVlVU?=
 =?utf-8?B?M0M0c1pFS2tYemxwNlZxSTNrUGliMXIvZVMvWVl3OEFNdVZWWWowTkg3SENW?=
 =?utf-8?B?SjBTRkExdE5vMXltZk9pR1NnTkM4YWJIZXNmS3RBbUltajRyczQ2ZlY2L1B1?=
 =?utf-8?B?VWU5dE1kMG5keGtFQWp6T1NXdTQ5dkVoOE41Q2JSRkd3WGZJTzVtRTVYaGxC?=
 =?utf-8?B?dU9GbXMzNkJQMUtVb2szcFVyc2hPYjViK0ZrOENPR0xpeTZmckFyL1lhUzhi?=
 =?utf-8?B?N0ZvckRlTXRxNzBNRDNiSXJPempRM1JoY2lrWDdybjR5bElGOU5VWSsyK2w3?=
 =?utf-8?B?SGcvanpQQjdxMUNxOW9ydnJBamp1Zk9ja1MxaEc5RXdHL0N1bW53SHpLd1hi?=
 =?utf-8?B?UFM0THRlTGorN2NiMHBaU2ZMamxqYzhJYjhxZDRCSGZNaDhvZkRYdTZGQVlu?=
 =?utf-8?B?QTB6cEhwT0VHTGZveUIxQndQZzFwVERNU29XWkxRL3FRdnFXaVd1YUEydUto?=
 =?utf-8?B?SHZUU05WWWVnSFp6aElNSEI0WTM0Z2NZYnVQcE9wRXIwTWQ1VDArN1c1RU1R?=
 =?utf-8?B?ZmVuUndhTFlaWDBBekNESUE0WFJwTXc5RkVVb3BpaldHWlU3ZXFmV0pGMzdX?=
 =?utf-8?B?dW8rSGswVWFQd1cydGtRSWtFUjZ2aTdzMS9CWk50QjMya3cwUkw5bjdoUjFZ?=
 =?utf-8?B?Q29TcUJoNUJQWXNDbWlxMXpJUmhySU54TjRiZVBpenBZVWxGZW03Umx6aXdZ?=
 =?utf-8?B?SDV1YjRxSTJGM0tKY0QzMitlanl4U0JaN01tMUZWNDIwdS9KNm4rYjJEZkRq?=
 =?utf-8?B?d2JvME1ycnd0WDYxWE5rWCtNdEt2ai9kb3JQeDRWcTQwOW5tM2N3bVpMR3Za?=
 =?utf-8?B?b3lRYjRWTFZnUDRVZlFablZrV0VlWkhMbjFLUjhKRklCMkdlaWtoZWF6dE1Q?=
 =?utf-8?B?ck1DOUJ1eWFMRlNuTXBSaEJGOEk0ajJneXFLdEtnVk95WS9weGl4NFVGWnJ5?=
 =?utf-8?B?UDRaR3ZobkExZytIU2pBckFkSmZONFZYWFl5OWljUnI0anRrSG50bVNWSE1H?=
 =?utf-8?B?WnByU3ZRK0FacVJuWTRSQmxZSWE1S1RHeWMxeEZsL2U1YzJhVEJyNEtiTStj?=
 =?utf-8?B?MnZ4Q0lpU1hjb3hGWVhTNlhPOW1IaVVxT0YzTmhjWkNRMitLVHEyc04xWFA3?=
 =?utf-8?B?MGk0UVNjL0ZKZlZJQm42RFpZUEc4WmNHZG1HS2FlQUJFMjkxQXRzZTloMnRI?=
 =?utf-8?B?UGNLK2t2R0t6Mmo2ZUxUK0NyUk55TlQ0akV5Z1hHS3dYUXpMREtDcG84Y1JZ?=
 =?utf-8?B?VUlXNDBab2tNV0JoVll2ak1Kd0RFcWk0R2diOTkvQ1dPZ0tTZkp5R2lXL3gr?=
 =?utf-8?B?OWhlYUEzVjloVHBNRytiZUJBL0tnd2JvVzYvaVpSWThOYzRwZTIzbGllaEw3?=
 =?utf-8?B?aG93ZHF2T0ErRzR2N1N0UURpSWdBL1NNNmFwRWRWQm1FOWFTenhGeXFzRWo3?=
 =?utf-8?B?bm1tdWJFTW1mMmFuZ25PZG9TU3NYNHQxUGM4NDVIbDkycWFWNmdzdWovUVdz?=
 =?utf-8?B?ZTZVczNZUDBkdkUzNmZQMWkxaVlZM0t4dStNY3paemNMUUcyd0dYWE5kaE5x?=
 =?utf-8?B?VC9JNGZhYytRV0pwN0hNRzQ0YUJGM1hma3F6Q3VtUlRXeHBhZlpXdUYwUlFO?=
 =?utf-8?B?c1VuQ1UzUy9PblpDazRJNi8vTENGMDRxQUo0RWZib0M1a2thczJaVWdtUlZ2?=
 =?utf-8?B?c1IybUg1VFlhbVVicldzTXFvUUw0d1Vxdms2SDZTK3NEc3M2bytUMmRMbmNo?=
 =?utf-8?B?VGc3aG5URmxVNXU2QVlickZPV081dW1HSFJpWmdOS2dZWSt0YjhqUHp2M202?=
 =?utf-8?B?OUtEcFFBTm81SDZPbkFaRENnNUxCbDNhSCtRVFp2VGF0OERWOUdvZ3BGMmZS?=
 =?utf-8?B?cTFZVEFXVWUxalhhWnVBV3BOdHlwZnpxV0cwUEx0V0M1ZzJTK3kwdmNoYStj?=
 =?utf-8?B?cmZnZjhqN2xSRTU1c1JuMFRUcHdlaXg1emo1b2gzRkJROXdmWHE0ZHB3M01n?=
 =?utf-8?Q?cP0PaWP8HWv/V0ZeRmNfVX47J?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68A56763C488DE4D8F50AD14C1E3A60D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4131cf-cead-4c46-aaad-08dab26a23b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 07:10:16.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vM1nxkHUwf/jVK+K/XxtxC+pkCa7dzGn52kOyTN6vGm7rpfd8Z92+7ntBEfJpuMfusTcZgOdgeI0jc2+4kAc/cP3oKhpMOhZtXtNGoAm2ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4627
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTAvMTkvMjIgMTk6NTAsIFZpbm9kIEtvdWwgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjAtMDgtMjIsIDE1OjU3LCBUdWRvciBBbWJhcnVz
IHdyb3RlOg0KPj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BnbWFpbC5jb20+
DQo+Pg0KPj4gVXNlIHBtX3B0cigpIG1hY3JvIHRvIGZpbGwgYXRfeGRtYWNfZHJpdmVyLmRyaXZl
ci5wbS4gSW4gY2FzZSBDT05GSUdfUE0gaXMNCj4+IG5vdCBlbmFibGVkLCB0aGUgbWFjcm8gd2ls
bCByZXR1cm4gTlVMTC4NCj4gDQo+IFlvdSBhbm5vdGF0ZWQgYXRfZG1hX2Rldl9wbV9vcHMgd2l0
aCBfX21heWJlX3VudXNlZCB3aGljaCBpcyBhIGNvcnJlY3QNCj4gdGhpbmcgdG8gZG8sIGJ1dCBz
aG91bGQgYmUgZXhwbGFpbmVkIGhlcmUNCg0Kb2theSwgd2lsbCByZWZpbmUgdGhlIGNvbW1pdCBt
ZXNzYWdlLg0KDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9y
LmFtYmFydXNAZ21haWwuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9kbWEvYXRfaGRtYWMuYyB8
IDQgKystLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2F0X2hkbWFjLmMgYi9kcml2ZXJz
L2RtYS9hdF9oZG1hYy5jDQo+PiBpbmRleCAwYjQ3M2U2ZDE2MWQuLmUzNWI0YjMyNTQ1MiAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvZG1hL2F0X2hkbWFjLmMNCj4+ICsrKyBiL2RyaXZlcnMvZG1h
L2F0X2hkbWFjLmMNCj4+IEBAIC0yNTI0LDcgKzI1MjQsNyBAQCBzdGF0aWMgaW50IGF0X2RtYV9y
ZXN1bWVfbm9pcnEoc3RydWN0IGRldmljZSAqZGV2KQ0KPj4gICAgICAgcmV0dXJuIDA7DQo+PiAg
fQ0KPj4NCj4+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgYXRfZG1hX2Rldl9wbV9v
cHMgPSB7DQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIF9fbWF5YmVfdW51c2Vk
IGF0X2RtYV9kZXZfcG1fb3BzID0gew0KPj4gICAgICAgLnByZXBhcmUgPSBhdF9kbWFfcHJlcGFy
ZSwNCj4+ICAgICAgIC5zdXNwZW5kX25vaXJxID0gYXRfZG1hX3N1c3BlbmRfbm9pcnEsDQo+PiAg
ICAgICAucmVzdW1lX25vaXJxID0gYXRfZG1hX3Jlc3VtZV9ub2lycSwNCj4+IEBAIC0yNTM2LDcg
KzI1MzYsNyBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBhdF9kbWFfZHJpdmVyID0g
ew0KPj4gICAgICAgLmlkX3RhYmxlICAgICAgID0gYXRkbWFfZGV2dHlwZXMsDQo+PiAgICAgICAu
ZHJpdmVyID0gew0KPj4gICAgICAgICAgICAgICAubmFtZSAgID0gImF0X2hkbWFjIiwNCj4+IC0g
ICAgICAgICAgICAgLnBtICAgICA9ICZhdF9kbWFfZGV2X3BtX29wcywNCj4+ICsgICAgICAgICAg
ICAgLnBtICAgICA9IHBtX3B0cigmYXRfZG1hX2Rldl9wbV9vcHMpLA0KPj4gICAgICAgICAgICAg
ICAub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIoYXRtZWxfZG1hX2R0X2lkcyksDQo+PiAg
ICAgICB9LA0KPj4gIH07DQo+PiAtLQ0KPj4gMi4yNS4xDQo+IA0KPiAtLQ0KPiB+Vmlub2QNCg0K
LS0gDQpDaGVlcnMsDQp0YQ0KDQo=
