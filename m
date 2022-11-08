Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC66620F88
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 12:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiKHLv1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Nov 2022 06:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiKHLv0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Nov 2022 06:51:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20394303E7;
        Tue,  8 Nov 2022 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667908286; x=1699444286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PA5PPvzCWsS/nHBKDgh1b3BKexZpIiC9lh37QzQleWY=;
  b=CcfbOBST/S1n0jQanB7fmsFfmMCrSy3ZfrkaSzkEdfOeF1nbDodmN1+l
   guD7JYQJPQdSZACQQjCI6LP8B5iftXysuEnVyQYLmNMaX9GVX1/w32D20
   k9vbTU6utE9czjxIWsxApqavvL2n6cjrm02ghOmJlYEK/ZkYnnHyQl+Mp
   fYGdQJk5dteXiJx6K0zyKybCGsGS5KK9t/b7fiYMJW8LBfcIts5Nr5+qK
   EjaRqptFFD3nYNq0BdBFmvBFp2B17UylFbh8aF7RStjDL8hZf0XTiRKhr
   eSIEPIxJ+gxD5lgBPwnvHGJSYf6prmiCz9lCxnA9Wqa3TC5YMxHK+wJgf
   g==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="185892781"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Nov 2022 04:51:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 8 Nov 2022 04:51:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 8 Nov 2022 04:51:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEZ8XRBBHOlS8tS86WU+hgoz/+jvydPR/UQ+Ux9vjn5L10iki87oQFTSXyArkncNlo3bB6PTsRzJGCrc4Mmx1XHZXhols7wZzvHaRrjAZMT4flkMIOZQolbJ1FIeY0Xhq1njN1OqERhaD/HBRiTR8siUBOIcRQGRhfXA+zKrnzZK5bvXJ0alGyrMnY0I5wFMPC9vyf6WvR5QK8bzImE64RzdF5lmfgg6WU+8lnGXR+iRgejmIn/WlJRwY5HYIlk89FQarzfuK8GI4cPRrfwNCsYroaMbjUrdvHk46/4+dTuuwiuXs5Isez0W2+4xnCL1woR4AAcM4A3XaWvORon9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA5PPvzCWsS/nHBKDgh1b3BKexZpIiC9lh37QzQleWY=;
 b=X9GnTXKQX21zr6g0MqCUUubxKguMBv1lf25F8UgzI1A8V8lA/qTv5pre1lpSSvkOvw6VcikI8XFmjuG1picL7gW7J5z5Fa0QMx86IH7ubzcCWWqz1NGQOdoElRcNTULS+699noFQlUOAICgRvA3UTmXNw7Cs3J6QVqRhbxPXWdeHi7WfPeyCuUe6NY3MaQOTPkag/avZf25gNn0Emcy/WPyRvXhqnAXORvS8copisISB5ecfKXZakhVEFxmE+3nNPs/KzkOVI33TOIUnZ5bnUovYwfcGBX6LTiqn/mgelZwGwhHMxQWUGzOWLbDvg/VJPMeP9KlgYN1UUXbD8RNyRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA5PPvzCWsS/nHBKDgh1b3BKexZpIiC9lh37QzQleWY=;
 b=MFKdEF0Ze6JVl/BcDPcGemHPJ1lHzDGkOPBAwVZ0KTWMMFg3mRsSFAPnG9/QfEAjaSs5+DSL7rI9Hx2VjmL80UqT24w15ChPa7NTzhz2gzr+7gkSJdLrw0+9ieVzlnMEfCgoskTm48lZxX+8zjOoj69bljY2NBX9FjZfNjD2yCk=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 CH0PR11MB5220.namprd11.prod.outlook.com (2603:10b6:610:e3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Tue, 8 Nov 2022 11:51:20 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 11:51:20 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>, <vkoul@kernel.org>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH v1 2/2] at_hdmac: return actual status when txstatus
 parameter is NULL
Thread-Topic: [PATCH v1 2/2] at_hdmac: return actual status when txstatus
 parameter is NULL
Thread-Index: AQHY82hqVy8QqOGaxE2Ne4FlEQWx4A==
Date:   Tue, 8 Nov 2022 11:51:20 +0000
Message-ID: <7289fcc5-154f-f720-853c-31a8eb6f233c@microchip.com>
References: <20221108074938.48853-1-andriy.shevchenko@linux.intel.com>
 <20221108074938.48853-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221108074938.48853-2-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|CH0PR11MB5220:EE_
x-ms-office365-filtering-correlation-id: 41dab02c-aaa7-440e-7006-08dac17f8d80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ooex6+bgt9E6tWrBfh3n40TAvJJiNgm74eNlYg4778eNrPtKk2lVtIwOaC3odnYmvjkrhnpYXf4jWauxvwNzkmJREpePlZzHNmy/jiSNbpXzUe9jTUnSng62JDLIQMFqkJwmajzn5/OsPAGgjtPhPR5nQ0vV0QGvdDICg7nDcws/O4YjyW5mRK5U2Hhfz5l2e9DAl+5uXq77Z+lJALvboj4Kxrm1vVkl0b9O7RJN/OjIsg+4Au2U3TC5UwxtB5t02hVOu2s03UFdZ7Mm822UkY/Vx8b8r9qm2SdoPznWdjuN1WXQrvbQg2T25B6DO34MY7ldvjTSFqz07TWIWEKqIrLWsTsrNjiQwBt5mnCkfzX3F+LYT5n5nRoIWRPXxo5FUAQy59rYrXOs8fQeV/3kSDM+NaK+ongsDgI1PUSg3DLpx4Y3KW0z8GVjppAW/D+rT8u8kdYaS14IUTzzMfjRlRC+zwdyBEZGHpy1poUPVYldYvfTBfYDU0ntCQN3hvStrRx2klwc0kFNnwSyooeI8PVafd49/sh2g9NxHW0UwEtj8RZsCp7ugQNG1KL+xV9naE5e/KeraGc+z+2toaZV6wevjCdDhpLPSlFLUu4skbizNWVKcBqtN9Jwhfjy/N/mPoWq8lnGJKoOUJCxVhVOrVzXitcsiN3OlzpTyvrKCzbb+TvmOvR74wntxXDsA/c/DS3+CVzJyXvlJcIgapYnX56yLAVbwHjxwkbRZym5JBITQd9CobbRW51E02JD4bZyH+9vArM7C1klvRnRu2dEgX/CRa4s5hqOzc+qPLvaxklEo+THq4yOGI1q+fOJtiDZ8yk/qlbCKJSy0Kj7R1q5Hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(36756003)(31686004)(38070700005)(31696002)(86362001)(83380400001)(4744005)(2906002)(186003)(26005)(6512007)(53546011)(38100700002)(107886003)(6506007)(122000001)(66446008)(66946007)(66476007)(4326008)(64756008)(8676002)(66556008)(2616005)(316002)(110136005)(76116006)(91956017)(8936002)(6486002)(478600001)(71200400001)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHQ2YzBsSVJXNDAycThxbXVMTENCbXlZM0hzb2hIOFhUYVlDWmloZDA5L2pt?=
 =?utf-8?B?MUQ0RS8xVHNCYXd3M3drb0xKY0R5THpmVGpBeDloZVpTdGFDVmhQamVaVzZl?=
 =?utf-8?B?aHJjNGs1aGRmVUVuQWIvVEhsNFg1VzA1dHE2M2NncXUzdEk0RTRJZHBQV2RU?=
 =?utf-8?B?SUFTM0dsOE1YeFZEUGk1L2VlK3hublM2OGVxSkZLeFVSRWJOZVVBN0wyb3Fp?=
 =?utf-8?B?VnV5ZE1HK215S1pneHRvVGZnVFdHeFZNQ3NoNCtzdkh4c1pBY2ZXUk5VL1Bu?=
 =?utf-8?B?SytBcXJNdmxma3IxWm54NUFKWUpSUEd5Nm92VTduVDNhUWk1S1JsN2trUVhz?=
 =?utf-8?B?cE0xWGJYREhaV2F6SEdIVzFyYVZ4Sk1rQllxTHFCK3lOSDlUREVoazNYYlBM?=
 =?utf-8?B?SUM4T0JkZjdxYkxaV0VlTWtXaDFzSDBnZGxyNDlDdVhqbkFvc3JLaHU1TnpH?=
 =?utf-8?B?QW9GL3VDV2lrSkdWaXM1YW1ma2RodWYxdU9DLzUzUzBaa2dpOHRnMDdpTzJx?=
 =?utf-8?B?MG5OQjgwT2tkRWZ4WVk5MUdGOUFWVXEzanJnbzVhUWhsd0lYVkFMSGE1Rkd2?=
 =?utf-8?B?U3VFTGV3a3NGN1VxRS96eitDWitQeWR3bmVnOEkxMjVmc3RZV0ZKbEYza1Yy?=
 =?utf-8?B?WHBvZTZ3bzhSOFl3a0Nad3BuQjBkSkFxQTdsVW56MDcrYXUraHF5ZnluNGo0?=
 =?utf-8?B?Wk1SVitYck1NaUd5cU1FQ1pUWjgxb25QWEZpNjFLNWRtMnFDZlFQSnlneTJS?=
 =?utf-8?B?Y0hka0FHQUVCNVpEdmlnQXlSb0M5RkVnNWlkMkErZ2lVelhUNFkybFFRZzVO?=
 =?utf-8?B?eVlGM0xKNFYwdncwTFFsNENFZE1sS0liaWNsMnhLMVFZS1Q2RjV2OHJJNlhu?=
 =?utf-8?B?bVUveHpUb080cWt3Wm0vUkIxb1YwRjdUNCs0UTMvenk5NDdNcVNueU5IWVZG?=
 =?utf-8?B?aUxJTWk4SmJrMDRmZ05VSnhSMDQ4VkwvL29JRDAyamRiOGNSTTBMQVJmS1VT?=
 =?utf-8?B?NXh2endiWUhKQ2hyUjZGY3BITld6bmU4R2ZJc296UldncGp4MlprNVIvaHBx?=
 =?utf-8?B?OW1SNVNUL0c0UmpnWXkrYjFoaFdyOVlsYWE5UmdtSm1mWUFzSHFDT0txVzRj?=
 =?utf-8?B?akZnSUI1SWZtY0xGVFBBM1ZRTDBQdExUYWpxVExBd1RPSCtBN0RHeGpxc2Zy?=
 =?utf-8?B?U09HQnBZNlNtRldRVkJOSUdDTkMzYUwvL1pIT3pvNXk4M0QzYmZubDJSdnFi?=
 =?utf-8?B?QlQwQWNxbE9hQ0RGY1R3WEZiN2NyK1JnanM5V2NmUWJCWlVRQzJHaDFwSG9U?=
 =?utf-8?B?aGxOblBmTW1GSE1XSWJzWXZodEg1WGlVb1VoUXlZeUF4cFJtQTU2Z1JEZFpH?=
 =?utf-8?B?dDZ0UEJ1ekdvd0FEYkJRczZjbkRqWXdNUU1BMHNpMDBiaTl1LzhaQ1Y0N2ZT?=
 =?utf-8?B?TDZFTUhQSTZaS3hOMFJmUWVSRzFKUWJyQWVCYU80S3JUdkwxT05vcTFibStu?=
 =?utf-8?B?MkZWZW52N1ZoWnVocEhwZXVtREwxNkNQeDNtd2JHMFdTL0FWNWFpOFMvNjFY?=
 =?utf-8?B?aHRTUnJsTUV3aHBHYm9FSGFJRVpHekFiNUpGNTd1Skk2Uk92VzRIUFZjTnVC?=
 =?utf-8?B?bHpDaXdJdVRBTXdGUFl5SXFYUFMvQWlybTBaclpSNmYvQ0Z0andEV0R2UHdJ?=
 =?utf-8?B?M3VYTmtCc0NMYW9CdkVER0ZjZ2NoZjZmTlZmUm10Q21Fbi80UVlkQitUTnY0?=
 =?utf-8?B?NGpzdzI5YnByL09VRmhtWllUYXFVUGs5Rm1PeU9Eb2o0bTdQcTVLMXNLd1BE?=
 =?utf-8?B?dzhTZFlkODBXTTVTZjR5U1ZNajlkSy9YdGlsM0hrQmJCcFVBb0dKME1nZ1dK?=
 =?utf-8?B?UlFEbHdwNDNlU2sybjZVMEg5ZlZxQStFNW9JYTNIZFBZUXNpTERNS29laTZI?=
 =?utf-8?B?dHFJZGdyais0R0pmUFovbnZLMlBtOGlPc3VjY3VWaHRQL3lKcW4zZEMrRWtN?=
 =?utf-8?B?OVFmZVlLMWRvQnRzUCtSaGJWUGtabWlMcnVnaHFxQk5nRlBTZXJCdlVpSmNN?=
 =?utf-8?B?S0V0M05CU0c3Vi9ucTlxamNpazg0blZUQ1laa3FsK2NOcjlzZXBnMjhWc2hk?=
 =?utf-8?B?QmlXTFFnVGlVVk5FRWtJOVMybHlrT1kzK0tHU0Vkc0N2K0kyVFp1VTdpb0Rx?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87C69535E7B7CD4C80A9BE0B07DB91FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dab02c-aaa7-440e-7006-08dac17f8d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 11:51:20.4889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVfzc15PruUzp5HxbpC8AlideFPn1NE4zNgpKcPVJwhgnccEguMU8mK+m3XLsS1/RdrOEs53oh7L3zPFJ9Z+6Nozq96VH4VB/Ssl+cAIjvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5220
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTEvOC8yMiAwOTo0OSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZXJlIGlzIG5vIHBvaW50IHRvIHJldHVybiBE
TUFfRVJST1IgaWYgdHhzdGF0dXMgcGFyYW1ldGVyIGlzIE5VTEwuIEl0J3MgYQ0KPiB2YWxpZCBj
YXNlIGFuZCBzaG91bGQgYmUgaGFuZGxlZCBjb3JyZXNwb25kaW5nbHkuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNv
bT4NCj4gLS0tDQo+ICBkcml2ZXJzL2RtYS9hdF9oZG1hYy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9kbWEvYXRfaGRtYWMuYyBiL2RyaXZlcnMvZG1hL2F0X2hkbWFjLmMNCj4gaW5kZXgg
YTlkOGRkOTkwZDZlLi40MDM1ZDU0Mzg1MzAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZG1hL2F0
X2hkbWFjLmMNCj4gKysrIGIvZHJpdmVycy9kbWEvYXRfaGRtYWMuYw0KPiBAQCAtMTY3OSw3ICsx
Njc5LDcgQEAgYXRjX3R4X3N0YXR1cyhzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4sDQo+ICAgICAgICAg
aWYgKCF0eHN0YXRlKSB7DQo+ICAgICAgICAgICAgICAgICBpZiAodGVzdF9iaXQoQVRDX0lTX1BB
VVNFRCwgJmF0Y2hhbi0+c3RhdHVzKSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IERNQV9QQVVTRUQ7DQo+IC0gICAgICAgICAgICAgICByZXR1cm4gRE1BX0VSUk9SOw0KPiArICAg
ICAgICAgICAgICAgcmV0dXJuIGRtYV9zdGF0dXM7DQoNCm9oLCBJIHNlZSB5b3UgZG8gaXQgaGVy
ZSwgcGxlYXNlIHNxdWFzaCB0aGlzIHBhdGNoIHRvIHRoZSBwcmV2aW91cyBvbmUsDQp5b3UgaW50
cm9kdWNlZCBETUFfRVJST1IgaW4gdGhlIHByZXZpb3VzIHBhdGNoLg0KDQo+ICAgICAgICAgfQ0K
PiANCj4gICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmYXRjaGFuLT52Yy5sb2NrLCBmbGFncyk7
DQo+IC0tDQo+IDIuMzUuMQ0KPiANCg0KLS0gDQpDaGVlcnMsDQp0YQ0KDQo=
