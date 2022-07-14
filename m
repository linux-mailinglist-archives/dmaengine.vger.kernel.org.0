Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F3A57458D
	for <lists+dmaengine@lfdr.de>; Thu, 14 Jul 2022 09:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiGNHNR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Jul 2022 03:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiGNHNR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Jul 2022 03:13:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4B13137E
        for <dmaengine@vger.kernel.org>; Thu, 14 Jul 2022 00:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657782795; x=1689318795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BUMqQihQ4HjrBFcJXCYjUYJMBJclgMpulDeuVNRvUf0=;
  b=R2f3O2df0jyoGlVvEDbqqEI3Hrj+/ArGbFYfX6PUEQzp/wg1fq6wzs1U
   dZKNDjIMRKYJRLX/zL+2QKTboaUKtkT9VKbfP/965SX03ejjNupdjJGKp
   5ZoyX9npQdt4wq2YXbgvJumTFEVjtkWS25p/H1WgFVuNermNh+hpnmMrn
   I0aMiVzBmxUhdmqmI6furC7SiCGlybP9FGeWl1oVn+5u7m8BgngfyXEFy
   41INjTWebw200T8sfmvuHGQlX3/5q6iAYVR//Vtns49Hq7wsMM7RXTbb+
   MDNYnsvvY2+93mb8Qc8ymVoUleoma6so4DXLVUkeDa4OEL3I0hZaGiM5X
   g==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="104412661"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2022 00:13:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 14 Jul 2022 00:13:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 14 Jul 2022 00:13:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJFs7dLzNcqkfT+j9uUG12E963p9rcvnIMS/u+6Y7CLAscsJ6zuuoQHG+Bk9hgS5Cb9yffev2ckE04rXmVpbBR4hmPmcmF1pPWodhJ2T+Nofcgjg2vVxUx2jMSwrDf+tiMIuQfu2DscImEjLFey+59R/LYl/ikcApCZw7AOv9mfmFhpPlnTEoQINC242pgfK5wi+5iKuEOl5sYzeaiNFVLQ0+QvQFB+wapk9jopm2F41s+Ag3sVlZGfeTYqtuyQ7VsaPDhp+IyAWNgsJJee7H3YWxHt7iI2IuYMufd6SpGzuAYxfhGtjpyo3kvyKU17NjHr4yBKdcO9FDdAGItQwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUMqQihQ4HjrBFcJXCYjUYJMBJclgMpulDeuVNRvUf0=;
 b=ELhtto7jRb6A3hr9kbox9AjRT2CYazlKzHbaAPv8wOP7L0dc9mn65xqsNXSzvPEaiGQHh39oAx8BZO3sQ5Uvc9G9LUCOuWu24MiJYTB2jEOfrvS5ofKmIPUPav+qUpGDh3L/mfLUQ4mw3LWYS7uHi5SQsWzDbEW2oeOp6NqoFdabvG6udFsn+/yi2Olu/hFYvSGGF65c9TwSjrYbQKF81kb14expBhL2IkGwCcITg1iIGXI5B92a7jYy2dFH1TIPpgiMvzmPM/xm1arzsAFS6AEknWLF3pItkf7mrNZUGxQ7vx+3Qjq+xJLx5hhqFNZukS8X9O1ZPjlh8T4d0+aG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUMqQihQ4HjrBFcJXCYjUYJMBJclgMpulDeuVNRvUf0=;
 b=Pwgoki2eG7UarOp1rgT8pEHs9Sl/o1ckgHfl8LwlQ0hOoyhb6svzGT1rAin9q7sYg6Z0UuoWXelvslWYhccS70cLuxmEtOWakV5e0ngamTbtmnSm/6tI4POFcRPC2ThKxWm2yaE/KFj+Mpe72yPKTbJtaCoj/FeRhBLahf0FryQ=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM5PR11MB1481.namprd11.prod.outlook.com (2603:10b6:4:9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Thu, 14 Jul 2022 07:13:09 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%6]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 07:13:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <jiri.prchal@aksignal.cz>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: Re: atmel usart and dma tx
Thread-Topic: atmel usart and dma tx
Thread-Index: AQHYl1Er6utfw2u0bUShvvclhNCqlA==
Date:   Thu, 14 Jul 2022 07:13:09 +0000
Message-ID: <c0ca74a3-448f-7f00-41d8-99b2cd7c5b86@microchip.com>
References: <0f560987-151f-b844-e5b4-a3a10c8d46a8@aksignal.cz>
 <611a4f8c-917e-a0ba-c5d9-25651afa2a04@aksignal.cz>
In-Reply-To: <611a4f8c-917e-a0ba-c5d9-25651afa2a04@aksignal.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db0cb01c-f0f6-47e9-b374-08da65684eb6
x-ms-traffictypediagnostic: DM5PR11MB1481:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: et5D4WlqkN/WqA9FOnL74CceZdnv73zsXSvhcVSA29TEubw0BwgGIh5xB9fq7Y1bOss07KFhuYQZZ+BptLN7yiq7/kPSQbLuwDiMK56ty/Wv/dPwxmlnnJszjrRgTwR7P4TUX5TAnxcoxUqlOmII90pMKAc5idLdhsuuvlcE4Y+4Nl8n7Kr9Uzo1fdBd2d9CLgyH03CipOssE26ytsoYTK+ZInzKq/qLpIPTgHOkfCHZsnH2k+PBZD1se7hiXpytX9Wyw9RRPD0z3LHGXx3HfRGiaEEVxB43VbOojFzM3mmo+m2zXrTw5q2y+xCvJwEDITA+eE3zwCy9slLXFe9T6pm3NszA5QxAWOYVhxYZ5Ltccgb1FX9mMovBWER7d0fQRReVS/06mWL3VyDEdsTk31IMhfP2pxL/5qxrndW+om80AUTWXzHUFPFac4Vq1lG+u8nAKLvC0obWuXAlyVQKo7NrBh7n9lUZUsTAYY5K/PICA2KOUdUq06qqqS+5IUQngTV0ufljcrcTvqKxDUcoZ1er5fzuLrtD/6NQKMXEKF9clr8tH/3Yqw5zeZICwuhnGnYNZYHOtZPDgnz61OSrZ46rdKT6XSQ8c35LYZduM1/1rIN/hcHa+CYlLACU7I98M0pFwHuCY/sn4FWVTtj2/RT/6lBAvZrSNwavo8Vlk62n/UxNV9fsZ0byyJhitOGFa9NNtbWkZqUaGkD/SW71O+uh2mXpoz3hEmPfuQF5vBomJK2E5o/J56Akk+J/tDGY82imRpxoW20/Us//KB8QA3Nb8qxBxCMdxzdXpfHVG18Zt4VUFsvCQgvKzUSfeh6gCUr4kZk4gCcTLWQx6r203uDQ1eU6xGD0ewDU9AciQgrlxQlSEsR8Wd0Azun0HTxK4oDghdXq0B3AnddDk/vJWtNOrTeNXGMlFR0CUkgRuRMGTzaP1w1T7ih3kSPQ48d1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(346002)(366004)(39860400002)(396003)(478600001)(54906003)(5660300002)(110136005)(38070700005)(122000001)(8936002)(316002)(31696002)(86362001)(66556008)(966005)(6486002)(91956017)(64756008)(76116006)(66946007)(4326008)(66476007)(66446008)(8676002)(71200400001)(107886003)(83380400001)(186003)(2616005)(6512007)(53546011)(26005)(38100700002)(2906002)(6506007)(41300700001)(36756003)(31686004)(43740500002)(45980500001)(10090945012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzhNSTcrcVpmU0F2Nzd6VVVXTzRqdWwzSkhrYnk2T1BlZGZUM0d0Tm4yRUlV?=
 =?utf-8?B?RWZOeXhJN2F3czRYeE05Tzlia2xrODYrZy9zZEJwSXY5T0czM0NQNEtRd3pz?=
 =?utf-8?B?M3o4Sy9xbm5DSmhUYVNHUFdvZElvOW5RKzlvanBFc1hyMGRYL2gxYytXVVZo?=
 =?utf-8?B?KzJraENqUDl3TTdkRUQyTFJicVlIS2ZBNE1RUzJvdW10aGNPYk1XbW1XaC9Z?=
 =?utf-8?B?bWQ2RE1KdEhaeVNkL2YwSFVTRU5FdGhIMW91SWZhUEhaT2ppNHhORE5Jb01G?=
 =?utf-8?B?VndPcWFRQUhwdVh6QzdyRUd1Z25QcFptSnQvSGZQSjE5SHArT0VXWldrOWND?=
 =?utf-8?B?TXRvdXhXY1NSNmk1TWtyVndZa1pGTUI1by8raWIySnk0ZEtrc20wenk3dndC?=
 =?utf-8?B?RWxIK3ZWaTB1aGdGbXhaMVFvMWRhdWpkYUNzOEYxNExOT0tVRVVvZXB5alM0?=
 =?utf-8?B?MldlZXVLSTRXY21tTTYyM0hEbTc1MW9YaUJNR0szN2prKzhmNzZ4aHNaZ0dJ?=
 =?utf-8?B?K2k4Q2l0NUVkUkNkWE1NVmIyeDBkQ2prWXJyZ0V5YmhhdGdtSXMxWTByM2lN?=
 =?utf-8?B?bjNyeTdTVW1nNGRNV1JLdnZzeEpSVzJMczZ1QWdib0I3enBCZzhSc0tSTzZ4?=
 =?utf-8?B?VDMyeUlLQmw3T1RCT0pKNnEwcXZGYzZNRlpsYjlYeFlsOVFHWWJGS2lLNHR5?=
 =?utf-8?B?eDc2alJCc1hOL1VhYnZ4NEpLVnZjU2NKL1hjR1BJd0RKSVZZYWtlNmdUZG1j?=
 =?utf-8?B?TTB3Z3JSZnFsSm9oeFNwS0VUOVpSTFlUQTZMaGZhMjNjNWwyNzRGRFhKMk83?=
 =?utf-8?B?OFllUDNpU3gzaTl6blR3N1N6OUFYM29YTVJCc0FwbDl5Y1hpYzFFUUVXS1lv?=
 =?utf-8?B?RWpvU2Mra0w2MXRJNGZQa1JTYUlwNHB6amJmY0FVdjRsYlR5eTNVWS9tclYw?=
 =?utf-8?B?TVV0cTQrNjE0clVTa0tKRlJNSW1Zb3BERXJRT1daZFJUNEpmdEZBcVlXRWkw?=
 =?utf-8?B?aDNWZlBrT2hUa2d3UHNOTUVGanZCRG5pN0ZSL3pwOS8xQ3JrWmZCZXcvZ25H?=
 =?utf-8?B?b3Z4cTRvVGJOQllaNE5YZVBNN2dBTEJ1RVFKU01Tc3dLWnVQOXFmdHlSbW9B?=
 =?utf-8?B?OTREYjhuVzFJWlVualExdGd0aVhQYklUUmdFWVlxTTVIb3p6cjB0RDJkUWg5?=
 =?utf-8?B?cC95SHoybW94NDJWL2JPNHQ0SUVoVEtLQzJsc2VhOGlXQVFmY3FncStkcUgv?=
 =?utf-8?B?YlBFR3RjZ0lFRU93Y1dPQTRONXhEODFLQ2RMM0lCM0xPNnBFWG0rdC80NDda?=
 =?utf-8?B?THZ4K3ltMUYrUGppUEsvR2VxQjl2cXZzNm84UndBRDBXZW5rZFFnN2ZYbVB0?=
 =?utf-8?B?Vm5PMmE1S3ZLTHNtLzFhdWN3ZTRPSEkrbnZFaG1mcEZ1ZUw5VDQyVU8rKzcr?=
 =?utf-8?B?bnVic2QvNzQ3d1l1SjFQYVZvVGR2dERqTUxtcmRzLysybHAra3RIRGp2aFlZ?=
 =?utf-8?B?WVNtdG9BMmtwUktTL2kxYytyeW5rd1NzNTFZcDJPWEEvc3dIdTZTcWxiSmhG?=
 =?utf-8?B?SHdDVDNES0Jlb0VYUzcycnJNSzB6RkwwN3dyNnprNlgxNjhXKzJodVE3OE9R?=
 =?utf-8?B?U2JOd2ZZN1VkUzF1QWFFUGk0WFVPb21FcUxybVFuZFd4RHF2bTl1cG5mZHpi?=
 =?utf-8?B?ZS8wOG5zWnozQXRmY0hibmhSTGRxU2FGajhiWHRxQVoyeHU5ODFjZTBwQ0pr?=
 =?utf-8?B?QTdUaCtYR0cyRWRkYm1IUUFaNGN2UmJiTDZCN0UzMWprRnVaU1ArU0k3Qnpq?=
 =?utf-8?B?WERyQk5iN1ZmVTNUZEFNVHZ3elRzeThQc1pFNnpqNDVsSDZ3SFZEOVMvdUl5?=
 =?utf-8?B?TUwxUW9uM2ZiMnlNTkt1MUJ6Wk00bFY4bTBiQWxHUG93Mi9XRDdNVzZuNG9a?=
 =?utf-8?B?Y3ZKSlUyT1RoYU1Xd1UzNTY5VEVIaFZIaUdleU56S0R6blFZSDE0cmlTTVk3?=
 =?utf-8?B?aHVhaUhodld0dDVDZ3VvdDlBTHZoY1ROemMzVlMweUpacEp3WXJJQlJxL3p3?=
 =?utf-8?B?VElnbVNQeG9EZzdLemxmWUkxZFVxUStFUE1TWTVSN1R5Wmc3NmV6V2UwMkwr?=
 =?utf-8?B?aG9nd0UremVqSzkzVUVuV1V5QmdldmZkV2lTWk1oQTV0ZWRtNW15TTlVbExx?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2015644CE0F5E4287E278AC24DEF288@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0cb01c-f0f6-47e9-b374-08da65684eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 07:13:09.7634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjmoz7/EYyyClWCcrK5bpFfTNZat6mfoj1hyl7sFNNMg8VIY6l1goGbY1KAMEIUKfdlh3UNugSHDFg35ciPjcFEePZBy/4RQaxKuq5EIVu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1481
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGksIEppxZnDrSwNCg0KT24gNC8yOC8yMiAxMjowOCwgSmnFmcOtIFByY2hhbCB3cm90ZToNCj4g
W1NvbWUgcGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVt
YWlsIGZyb20gamlyaS5wcmNoYWxAYWtzaWduYWwuY3ouIExlYXJuIHdoeSB0aGlzIGlzIGltcG9y
dGFudCBhdCBodHRwOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbi5dDQo+
IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIGV2ZXJ5Ym9k
eSwNCj4gd2l0aCBrZXJuZWwgNS4xNywgYXQ5MXNhbTlnMjUgcnVubmluZyBhdCA0MDBNSHogSSBk
aXNjb3ZlcmVkIGRyb3Agb3V0cw0KPiB3aGlsZSBJIHdyaXRlIGRhdGEgKDY0IHRvIDEyOEIpIHRv
IHR0eVMgYnkgb25lIGNhbGwgb2Ygd3JpdGUoKS4gQXQgc3BlZWQNCj4gMjMwNDAwIG9yIDExNTIw
MCBCYXVkLiBJdCBpcyBub3QgdHJhbnNtaXR0ZWQgYXQgb25jZSwgdGhlcmUgYXJlIHJhbmRvbQ0K
PiBzcGFjZXMgbG9uZyAyMDB1cyB0byAxbXMuIEl0IHNob3VsZCB1c2UgRE1BIHNvIEkgdGhpbmsg
aXQgY291bGQgYmUNCj4gdHJhbnNtaXR0ZWQgYXQgb25jZS4NCj4gSXMgdGhlcmUgZXZlcnl0aGlu
ZyBPSyB3aXRoIERNQSBvciBzb21lIHNwZWNpYWwgc2V0dGluZyBuZWVkZWQ/DQoNClRoZXJlIGFy
ZSBzb21lIGNvbmN1cnJlbmN5IHByb2JsZW1zIHdpdGggYXQtaGRtYWMgdGhhdCBoYXBwZW4gYXQg
aGlnaA0KbG9hZHMgKGNoZWNrIFsxXSksIGJ1dCBJIGRvbid0IHRoaW5rIGl0J3MgcmVsYXRlZCB0
byB5b3VyIHByb2JsZW0uDQpDYW4geW91IGRvIGEgZmxhbWUgZ3JhcGggdG8gdmVyaWZ5IHdoZXJl
IGluIHRoZSBjb2RlIGlzIHRoZSBzdGFsbD8gV2h5DQpkbyB5b3UgYXNzdW1lIGl0J3MgYXQgdGhl
IERNQSBsZXZlbD8gSGF2ZSB5b3UgdHJpZWQgdXNpbmcgdXNhcnQgd2l0aG91dA0KRE1BIGFuZCB2
ZXJpZnkgaWYgdGhlIHN0YWxsaW5nIGlzIHN0aWxsIHRoZXJlPw0KDQo+IA0KPiBkbWVzZzoNCj4g
W8KgwqDCoCAxLjYzNjY2Nl0gYnVzOiAncGxhdGZvcm0nOiBfX2RyaXZlcl9wcm9iZV9kZXZpY2U6
IG1hdGNoZWQgZGV2aWNlDQo+IGY4MDFjMDAwLnNlcmlhbCB3aXRoIGRyaXZlciBhdDkxX3VzYXJ0
X21vZGUNCj4gW8KgwqDCoCAxLjYzNjY2Nl0gYnVzOiAncGxhdGZvcm0nOiByZWFsbHlfcHJvYmU6
IHByb2JpbmcgZHJpdmVyDQo+IGF0OTFfdXNhcnRfbW9kZSB3aXRoIGRldmljZSBmODAxYzAwMC5z
ZXJpYWwNCj4gW8KgwqDCoCAxLjYzNjY2Nl0gcGluY3RybC1hdDkxIGFoYjphcGI6cGluY3RybEBm
ZmZmZjQwMDogdXNhcnQwLTA6IDIgMDowDQo+IFvCoMKgwqAgMS42MzY2NjZdIHBpbmN0cmwtYXQ5
MSBhaGI6YXBiOnBpbmN0cmxAZmZmZmY0MDA6IG1hcHM6IGZ1bmN0aW9uDQo+IHVzYXJ0MCBncm91
cCB1c2FydDAtMCBudW0gMw0KPiBbwqDCoMKgIDEuNjM2NjY2XSBwaW5jdHJsLWF0OTEgYWhiOmFw
YjpwaW5jdHJsQGZmZmZmNDAwOiB1c2FydDBfcnRzLTA6IDEgMDoyDQo+IFvCoMKgwqAgMS42MzY2
NjZdIHBpbmN0cmwtYXQ5MSBhaGI6YXBiOnBpbmN0cmxAZmZmZmY0MDA6IG1hcHM6IGZ1bmN0aW9u
DQo+IHVzYXJ0MCBncm91cCB1c2FydDBfcnRzLTAgbnVtIDINCj4gW8KgwqDCoCAxLjYzNjY2Nl0g
cGluY3RybC1hdDkxIGFoYjphcGI6cGluY3RybEBmZmZmZjQwMDogZm91bmQgZ3JvdXANCj4gc2Vs
ZWN0b3IgNCBmb3IgdXNhcnQwLTANCj4gW8KgwqDCoCAxLjYzNjY2Nl0gcGluY3RybC1hdDkxIGFo
YjphcGI6cGluY3RybEBmZmZmZjQwMDogZm91bmQgZ3JvdXANCj4gc2VsZWN0b3IgNSBmb3IgdXNh
cnQwX3J0cy0wDQo+IFvCoMKgwqAgMS42MzY2NjZdIGF0OTFfdXNhcnRfbW9kZSBmODAxYzAwMC5z
ZXJpYWw6IG5vIGluaXQgcGluY3RybCBzdGF0ZQ0KPiBbwqDCoMKgIDEuNjM2NjY2XSBwaW5jdHJs
LWF0OTEgYWhiOmFwYjpwaW5jdHJsQGZmZmZmNDAwOiBlbmFibGUgZnVuY3Rpb24NCj4gdXNhcnQw
IGdyb3VwIHVzYXJ0MC0wDQo+IFvCoMKgwqAgMS42MzY2NjZdIHBpbmN0cmwtYXQ5MSBhaGI6YXBi
OnBpbmN0cmxAZmZmZmY0MDA6IGVuYWJsZSBmdW5jdGlvbg0KPiB1c2FydDAgZ3JvdXAgdXNhcnQw
X3J0cy0wDQo+IFvCoMKgwqAgMS42Mzk5OTldIGF0OTFfdXNhcnRfbW9kZSBmODAxYzAwMC5zZXJp
YWw6IG5vIHNsZWVwIHBpbmN0cmwgc3RhdGUNCj4gW8KgwqDCoCAxLjY0MzMzM10gYXQ5MV91c2Fy
dF9tb2RlIGY4MDFjMDAwLnNlcmlhbDogbm8gaWRsZSBwaW5jdHJsIHN0YXRlDQo+IFvCoMKgwqAg
MS42NDMzMzNdIFJlZ2lzdGVyaW5nIHBsYXRmb3JtIGRldmljZSAnYXRtZWxfdXNhcnRfc2VyaWFs
LjEuYXV0bycuDQo+IFBhcmVudCBhdCBmODAxYzAwMC5zZXJpYWwNCj4gW8KgwqDCoCAxLjY0MzMz
M10gZGV2aWNlOiAnYXRtZWxfdXNhcnRfc2VyaWFsLjEuYXV0byc6IGRldmljZV9hZGQNCj4gW8Kg
wqDCoCAxLjY0MzMzM10gYnVzOiAncGxhdGZvcm0nOiBhZGQgZGV2aWNlIGF0bWVsX3VzYXJ0X3Nl
cmlhbC4xLmF1dG8NCj4gW8KgwqDCoCAxLjY0MzMzM10gYnVzOiAncGxhdGZvcm0nOiBfX2RyaXZl
cl9wcm9iZV9kZXZpY2U6IG1hdGNoZWQgZGV2aWNlDQo+IGF0bWVsX3VzYXJ0X3NlcmlhbC4xLmF1
dG8gd2l0aCBkcml2ZXIgYXRtZWxfdXNhcnRfc2VyaWFsDQo+IFvCoMKgwqAgMS42NDMzMzNdIGJ1
czogJ3BsYXRmb3JtJzogcmVhbGx5X3Byb2JlOiBwcm9iaW5nIGRyaXZlcg0KPiBhdG1lbF91c2Fy
dF9zZXJpYWwgd2l0aCBkZXZpY2UgYXRtZWxfdXNhcnRfc2VyaWFsLjEuYXV0bw0KPiBbwqDCoMKg
IDEuNjQzMzMzXSBhdG1lbF91c2FydF9zZXJpYWwgYXRtZWxfdXNhcnRfc2VyaWFsLjEuYXV0bzog
bm8gb2Zfbm9kZTsNCj4gbm90IHBhcnNpbmcgcGluY3RybCBEVA0KPiBbwqDCoMKgIDEuNjQzMzMz
XSBhdG1lbF91c2FydF9zZXJpYWwgYXRtZWxfdXNhcnRfc2VyaWFsLjEuYXV0bzogbm8gZGVmYXVs
dA0KPiBwaW5jdHJsIHN0YXRlDQo+IFvCoMKgwqAgMS42NDMzMzNdIGF0bWVsX3VzYXJ0X3Nlcmlh
bCBhdG1lbF91c2FydF9zZXJpYWwuMS5hdXRvOiBHUElPIGxvb2t1cA0KPiBmb3IgY29uc3VtZXIg
cnM0ODUtdGVybQ0KPiBbwqDCoMKgIDEuNjQzMzMzXSBhdG1lbF91c2FydF9zZXJpYWwgYXRtZWxf
dXNhcnRfc2VyaWFsLjEuYXV0bzogdXNpbmcNCj4gZGV2aWNlIHRyZWUgZm9yIEdQSU8gbG9va3Vw
DQo+IFvCoMKgwqAgMS42NDY2NjZdIGF0bWVsX3VzYXJ0X3NlcmlhbCBhdG1lbF91c2FydF9zZXJp
YWwuMS5hdXRvOiB1c2luZw0KPiBsb29rdXAgdGFibGVzIGZvciBHUElPIGxvb2t1cA0KPiBbwqDC
oMKgIDEuNjQ2NjY2XSBhdG1lbF91c2FydF9zZXJpYWwgYXRtZWxfdXNhcnRfc2VyaWFsLjEuYXV0
bzogTm8gR1BJTw0KPiBjb25zdW1lciByczQ4NS10ZXJtIGZvdW5kDQo+IFvCoMKgwqAgMS42NDk5
OTldIGF0bWVsX3VzYXJ0X3NlcmlhbC4xLmF1dG86IHR0eVMyIGF0IE1NSU8gMHhmODAxYzAwMCAo
aXJxDQo+ID0gMjQsIGJhc2VfYmF1ZCA9IDgzMzMzMzMpIGlzIGEgQVRNRUxfU0VSSUFMDQo+IFvC
oMKgwqAgMS42NTY2NjZdIGRyaXZlcjogJ2F0bWVsX3VzYXJ0X3NlcmlhbCc6IGRyaXZlcl9ib3Vu
ZDogYm91bmQgdG8NCj4gZGV2aWNlICdhdG1lbF91c2FydF9zZXJpYWwuMS5hdXRvJw0KPiBbwqDC
oMKgIDEuNjU2NjY2XSBidXM6ICdwbGF0Zm9ybSc6IHJlYWxseV9wcm9iZTogYm91bmQgZGV2aWNl
DQo+IGF0bWVsX3VzYXJ0X3NlcmlhbC4xLmF1dG8gdG8gZHJpdmVyIGF0bWVsX3VzYXJ0X3Nlcmlh
bA0KPiBbwqDCoMKgIDEuNjU2NjY2XSBkcml2ZXI6ICdhdDkxX3VzYXJ0X21vZGUnOiBkcml2ZXJf
Ym91bmQ6IGJvdW5kIHRvIGRldmljZQ0KPiAnZjgwMWMwMDAuc2VyaWFsJw0KPiBbwqDCoMKgIDEu
NjU2NjY2XSBidXM6ICdwbGF0Zm9ybSc6IHJlYWxseV9wcm9iZTogYm91bmQgZGV2aWNlDQo+IGY4
MDFjMDAwLnNlcmlhbCB0byBkcml2ZXIgYXQ5MV91c2FydF9tb2RlDQo+IA0KPiBbwqDCoCA0MS42
MDY2NjZdIGF0bWVsX3VzYXJ0X3NlcmlhbCBhdG1lbF91c2FydF9zZXJpYWwuMS5hdXRvOiB1c2lu
Zw0KPiBkbWEwY2hhbjYgZm9yIHJ4IERNQSB0cmFuc2ZlcnMNCj4gW8KgwqAgNDEuNjEzMzMzXSBh
dG1lbF91c2FydF9zZXJpYWwgYXRtZWxfdXNhcnRfc2VyaWFsLjEuYXV0bzogdXNpbmcNCj4gZG1h
MGNoYW43IGZvciB0eCBETUEgdHJhbnNmZXJzDQo+IA0KDQpXaGF0IHNob3VsZCBJIHNlZSBpbiB0
aGlzIGxvZz8NCg0KVGhhbmtzLA0KdGENCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMTNjNmM5YTItNmRiNS1jM2JmLTM0OWItNGMxMjdhZDM0OTZhQGF4ZW50aWEuc2UvDQoNCj4g
V2l0aCBrZXJuZWwgNC41IHNwYWNlcyBhcmUgdGhlcmUgdG9vLCBidXQgc2hvcnRlciBhbmQgbGVz
cyBmcmVxdWVudC4NCj4gVGhhbmtzIGZvciBhbnkgaGVscCwNCj4gSmlyaQ0KDQo=
