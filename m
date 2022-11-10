Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE462463A
	for <lists+dmaengine@lfdr.de>; Thu, 10 Nov 2022 16:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiKJPoK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Nov 2022 10:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiKJPoJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Nov 2022 10:44:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF1B264AA;
        Thu, 10 Nov 2022 07:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668095048; x=1699631048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+yLSzy8ySkxDugwjgI1gRWpsBxSADAzc8p/e+zfISGs=;
  b=dG6HLerG6PzCK1jMfLmDqd/9VcoUTBE8v40S2V7Cbi64/pHm36OPu1hF
   zNXorem6tN/ZmVewpz5Y3wiIqCwE6z0h+aBXK2XwZfJJahFsJiY/74DZ3
   2vgzzuUbtBZ08W1mFUqnumy0tF9GGu19X2XTM9XFK4WtPfV3f9StRDtCh
   FbT7uhA0kJRyi/xHzZG5gCJHt+Ei7dbbBg0HiO3s87ZaH7i0qQhCNjRXp
   BkOp2QFkRI/YfilL/Ckgx82U3gKW0+ogF6PDDvgmQf4DqYiyNVbBrP+Tg
   wFHK3Y/b95YJWbFZlj1TPiM9xtNdl1TPGXmmbarqCOo0MJQ2Vs3GvmORc
   g==;
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="186357063"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Nov 2022 08:43:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 10 Nov 2022 08:43:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 10 Nov 2022 08:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdFc0ZIMdkzPoe+7YCK8ZUY0z7kRHyUgTzn3VOAVMVn9SZwcA8tmao3UZH5dkXCk6WhcxuSFMNrhpqgdODPdrs7+jgprMtHsU0U1PoyqfCx2bcZPmeqHF4ZAVh+KsyoWHXBfbPRAfx1ef8lDGvHYrjRuCwGzCsXkLkxrUeFsSloF+ZZDNgz96wTem8TNykCrA/PPJJcYW0AkqS0ogKVywDvZFTq2pDjWDFWKc+wp3Rlf0LRlG7eiG/JuR3p9GwI54J8vKLVt30Ez2tA1wcAiM2Vjb8GgZz7wVcBNWlGVLSql5vFf3ASM9nsAD7wNzPT/THsjWYWtjUUhdr8GJMolnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yLSzy8ySkxDugwjgI1gRWpsBxSADAzc8p/e+zfISGs=;
 b=VCvTwnD80o9+Hxt0Q8OBGUE+atEbGZvsCwzSfjKFjYqNDIk/sgh7DTfCvh3+jzzClrfoi0OjK/n9cd12v71z68+JGI8IRgKYIhgiLK/RU/xQLPdbA8USzXNkudRhynT1dfT6iUlLe6i/WbqJhD+KdTS6vV1nd5UF55/zsR/8Cv7OKebCv9W72r/x0VPBy5u59UOwqerP8f4OU58xf1QWwv3TYmxckWIwy0GSepNM8cuJ9WJnD++LkgIIBh3tT2P/t1qgalWK7zvEaBUEz+gLb91/ercA8tUbB3BgT2rEO6jTyLnqhhTcyw2Vg1F5CDW3+FTa4MSZrnNIUrIj9V2MIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yLSzy8ySkxDugwjgI1gRWpsBxSADAzc8p/e+zfISGs=;
 b=RjUg1ivMjL0/LSOaeHyxgCDBOC5Ldc9/6N5QcCa2Ah5FX7PBknG9ITX/Q6kcidfr2jXkJmZQokWVJPp/QjR8PmhVjLkoMspXERnFyR3t/DlformuWqUMLd/aHAWej+zUy2oGFpRCkw372APtw2WlGfhP3tudY6rrdwltDs8Dfgs=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.13; Thu, 10 Nov 2022 15:43:53 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b%4]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 15:43:53 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <ye.xingchen@zte.com.cn>, <vkoul@kernel.org>
CC:     <f.fainelli@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <dmaengine@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: use devm_platform_get_and_ioremap_resource()
Thread-Topic: [PATCH] dmaengine: use devm_platform_get_and_ioremap_resource()
Thread-Index: AQHY9Rs8YesaX06/Y0WyG4XiEmLb3g==
Date:   Thu, 10 Nov 2022 15:43:53 +0000
Message-ID: <3f0622f8-f476-0c76-d033-373ba414abd8@microchip.com>
References: <202211101726100208529@zte.com.cn>
In-Reply-To: <202211101726100208529@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|PH0PR11MB4999:EE_
x-ms-office365-filtering-correlation-id: dc22f8b9-98d8-4755-469d-08dac3325f08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MrGKY+9kgjvnCIgmAIZ3XMPiKVFFcbl7GlusWugLrTlNiyM1OE45wbEJDbKHx7sVhjmOeTN0/mEOHgHypWfK18pwcc4Hxce3rdEzfS8FQbaHwKnzGBSArS+9pdDtKxnYgidvPeIMWxbvxk+/m8GuN5joe4LD5iXnH9ra37nVuAFFW5um62YfQdo2egtdCtDk7EJ2+hZINtcwZCApZUEctd3p3zYOGx6JMSnGAOfeHDRIMtFZAp8ktmqDUe6E5lH49DFs7Yy+aBB52/YUbPm5e2FiHjt3ApnC7aOGWHoFQKCtqg6XDLaVIL/6haniIX0TiYsBDiofh8gDzXjx2X7YmxoxDJix0sbLqwpImn0UA40aWCztt8J5iMX0rKkwiacjAeRGovWNuCiTRJRursGuR2stlvJhJdSRJSNZK3oVh/LjZDErzzNbr+F9MXxLFKbnGLocfY0mgHaw5Gc8FL4EBXsDpZCwx5Tdc7mGa9XpeSItnFS9q9jHHpYn//XkBTPQ1aXyyEvWlbrGujrWnm/Rmhy6q57iCBHv71qzCDmu2iHWyD7FUHhQrDnNsTUMnmfAegPSP+lbDKCI3a0/rDr6W4J6lM7Cgz3W57FiSl8y9CBk/91qC3h8+Octj0H9yz58Vs6M4OrsYPjoi/oUKK6P1eGvDrdCQO6yrGpVKjpAjB97NvnepQncAUWTz/bz0EgE0xPICXu9RWISSJfPWAmg+ybT8Q4a7IVVmuIXKlM2nnGxMFhMD49/Fz0Wfyjw+vQOsMVQsHajiszcCS/Sx77MIAryJZ/T1IfE9eOfDztUl5em/e/Ix0IDTv+fFGfhQ0KeBnPni0k/CTHyNhC7AiE/WnxnRIl2iMie8Lq2ZFoHnokXWwWapCC037e56X4cmLuYsLK9d8OK9MAEYf1OUzEqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199015)(71200400001)(83380400001)(31686004)(186003)(7416002)(6486002)(2906002)(86362001)(966005)(31696002)(38100700002)(64756008)(38070700005)(122000001)(478600001)(54906003)(110136005)(316002)(6506007)(91956017)(2616005)(53546011)(66446008)(5660300002)(66476007)(36756003)(66946007)(26005)(76116006)(6512007)(8676002)(66556008)(4326008)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlpzQ3l5UVZHZTBwZjVVeDB1SURzWnhNQUoyTVIzeHpROUVzdDRuN25JOHBT?=
 =?utf-8?B?L0pvVnlnQ3FuaXc3eFdvUzFkQlFQK09zQm54S3ptTGtPTW9ITjhVa1FKMzYv?=
 =?utf-8?B?MkFYM3FkaHd1b1kwLzZNbzNYcmZadWc0Qnp0bzlua1A2U3hVVklqN2dFaWZS?=
 =?utf-8?B?MzBSMU9rRVAvbXA5VGZmTDJJSTIvMVVPQ0toZmpuMG1NVmkwREcrM2tWd1Fn?=
 =?utf-8?B?MWlmMkF0cVRuYlhVcENGbWRwbGMrVFZWSzBEcEJyNjU0aW1WZldVUjdmT1dO?=
 =?utf-8?B?bE9Id3ZUbXZxSFlrVE8wRkpnOUV2Q3dHeEpaTXRtMm5wak9zbUgrdjVibVEv?=
 =?utf-8?B?UDBhRnZ0bDc1aFpVdTZlcFA2OUNnT2g2MVB5b2dwTXBqNEFkdFc1U1pZaHdH?=
 =?utf-8?B?YThrOXh6ZWdGdFE5cjhVemFtcjBiajZKZ0RsbGl4U3BvNldXN0kyM0ZlU0hp?=
 =?utf-8?B?S1duQi9nYStLek9iUEEyK2NTSlE0cUZsU3lYNWhBZFlCbW9meHBlTVpsNDlM?=
 =?utf-8?B?L2lYU0VEcldVTnk4clZCUXhueFBaQWlBSklybkJ5SEIzR1dlSVk0bXUzZUxj?=
 =?utf-8?B?S3VYY0x4dXFKUXRTK3pLM1lpQzl2OFpEUDhFYW1keDFobDJXQi9aOTJTaUZo?=
 =?utf-8?B?bXh2ZEdVVE96UlV0Wm43c3RlaDhxN1c3YWhXZTRFSGFQcndqTnFlZ0dCWDY2?=
 =?utf-8?B?WWJ6YlFIQVVGSlMybnpXWVNZN2VIUkhObnBvT2k4eEhPYldMVWloMkVrOC9W?=
 =?utf-8?B?WFJxU1ZnWSs4VzNkTHc5M2pxM0RWUEFNc3RpWjU5OHZ4V2VJNjNXRFphTDBv?=
 =?utf-8?B?cVJPdGtCK3ViamI0b2NuTldoR3hqS3FQSTg1ekMwdkRPYnZ4UWduMlZFSkxF?=
 =?utf-8?B?RHhBQTRLbTRnODJEbnordGN0TE83TmZseDZWVmRSL0Z6S0J6QnV4NkcvSEVH?=
 =?utf-8?B?bGkwUUY4dytHU1N3MnN5d2w4Vzg0TUZINnVUSi9LRUlWSFBxQTlVTis1WExC?=
 =?utf-8?B?REtsdTRjT2FSN2VLMkJUYjNMOEhqL2JRMk9XSUt6bTdHM0lwbUl3TjJibzVp?=
 =?utf-8?B?ZUJ5c0lPdExkcmM1d3JGejZyVkJ6TFo3NFlYbnZjK1FjQ2RHZEhvdWRPenpm?=
 =?utf-8?B?WklMeE54K204ZDlFcjV4RWV5VXNIdGoyNXg0aVJvR3k3bUFYU290bkw3N2ZK?=
 =?utf-8?B?aG96YTE5cHNlQ2J2VURxbFVKWlR4aG40NGI0QjRTOHVuM1Q4QVA5K1M0eDRU?=
 =?utf-8?B?a0JmTFJqekJmTFJxYTJEMlhPM2Y3d29GMnNOWHFrL2hkNFdEN3pxMUgvdDRp?=
 =?utf-8?B?d2hxTFN3REg4cE0vUHFRS1kxQTViUk9FWE1zdTdLdFVOOHMvL3N1c2syTFBE?=
 =?utf-8?B?cXMwR3RDOTY2NGk2dnorY3dZL2o2dUxlMlcyMTVFdTZSYWpPL0lLcFpCTE1U?=
 =?utf-8?B?OVQ1NWZKdHl5Y0ZPUTAzSVU2NVhoaFBSaXlEU2VKeUxtZ1FoeGJPemxGM0pi?=
 =?utf-8?B?VDFsUWtRUHVXei9zelFUbEEyNTFTU2d6WVRHaWhZVjFhZVo1TE9QQWtRdkF3?=
 =?utf-8?B?ajdJU2RId0dldkZiS0d2RjdDWEpRUkZFYTYvNGw5cU4xcnp4MWVYcGNtQUxL?=
 =?utf-8?B?cE1tSGg3OGxzRVdXOHJIeGFRbmo3TWEyaGc4WjBqQXAvcXhWcnIxMENuZ1dE?=
 =?utf-8?B?M3dPRXpXSVE5c2RxWU1kZ1FzQVliblc2ejF0Mnp3SGFheGhWNXJRZTZVR3dp?=
 =?utf-8?B?Z0dIM2hSZzg4MEdqZWU5NVBWNitReGZUK0x5Nlg4eXJwT0JMZXJaUEdkS296?=
 =?utf-8?B?b01SNEZlSlJJU2N3MCtmbXhrVTl2OHhZSFAzMFFLYzFWWXpjbGM2QUpiQ1lM?=
 =?utf-8?B?QVFpODR3MEtLQzZsU2hkRkcrQkhIeTFSemprQ1lVd2MrRm1NSEZWaXYwQkVy?=
 =?utf-8?B?UkRaRzlWV3FFVUdTTExKMGd0d2RRRFVsZzNUTWY2ZjB0YzgyUEV2TW9yM1Ry?=
 =?utf-8?B?K1hQa3A2L1VWN3VjVFdJZDVtZWFvUzcyNElGd0FzcmRnTzBDKzFaTkxBbDdo?=
 =?utf-8?B?U2VTMkJPUnl1R3M0dXplRG5LdjZuWktIcGJxTU96aUNqUWRLaXBYelI3SGtN?=
 =?utf-8?Q?JI6qSLBgaiVOlfkQ6GWiRMdM9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2DE2A52E124424DB4FD44EB0F65A018@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc22f8b9-98d8-4755-469d-08dac3325f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 15:43:53.6193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pePejtrbfjow9eGaQktXmYkQH2ufH8wmGzLIEagEFBNZzsHp53iyBQyWMntDuRR1OlVs0IzgCIaTsUGRZKpC4Lm2aXpZAa4DCCTcnddOxeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTEvMTAvMjIgMTE6MjYsIHllLnhpbmdjaGVuQHp0ZS5jb20uY24gd3JvdGU6DQo+IFtZb3Ug
ZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20geWUueGluZ2NoZW5AenRlLmNvbS5jbi4gTGVhcm4g
d2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJ
ZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4gDQo+IEZyb206IE1pbmdoYW8gQ2hpIDxjaGkubWluZ2hhb0B6dGUuY29tLmNuPg0KPiANCj4g
Q29udmVydCBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UoKSwgZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkg
dG8gYSBzaW5nbGUNCj4gY2FsbCB0byBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNv
dXJjZSgpLCBhcyB0aGlzIGlzIGV4YWN0bHkNCj4gd2hhdCB0aGlzIGZ1bmN0aW9uIGRvZXMuDQoN
CldvdWxkIHlvdSByZXZpZXcgbXkgdjMgaW5zdGVhZD8NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvMjAyMjExMTAxNTI1MjguNzgyMS0xLXR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbS8N
Cg0KVGhlIGludGVudGlvbiBpcyB0byBkbyB0aGlzIHNtYWxsIGNoYW5nZSBmb3IgYWxsIHRoZSBk
bWEgZHJpdmVycyBpbiBhDQpzaW5nbGUgcGF0Y2gsIHNvIHRoYXQgd2UgZG9uJ3QgcG9sbHV0ZSB0
aGUgY29tbWl0IGxvZy4NCg0KPiANCj4gUmVwb3J0ZWQtYnk6IFplYWwgUm9ib3QgPHplYWxjaUB6
dGUuY29tLmNuPg0KPiBTaWduZWQtb2ZmLWJ5OiBNaW5naGFvIENoaSA8Y2hpLm1pbmdoYW9AenRl
LmNvbS5jbj4NCj4gLS0tDQo+ICBkcml2ZXJzL2RtYS9iY20yODM1LWRtYS5jIHwgMyArLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9iY20yODM1LWRtYS5jIGIvZHJpdmVycy9kbWEvYmNtMjgz
NS1kbWEuYw0KPiBpbmRleCA2MzBkZmJiMDFhNDAuLjE1NDdmNTI4YTU4ZSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9kbWEvYmNtMjgzNS1kbWEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS9iY20yODM1
LWRtYS5jDQo+IEBAIC05MDIsOCArOTAyLDcgQEAgc3RhdGljIGludCBiY20yODM1X2RtYV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiANCj4gICAgICAgICBkbWFfc2V0X21h
eF9zZWdfc2l6ZSgmcGRldi0+ZGV2LCAweDNGRkZGRkZGKTsNCj4gDQo+IC0gICAgICAgcmVzID0g
cGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gLSAgICAg
ICBiYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQo+ICsgICAg
ICAgYmFzZSA9IGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAs
ICZyZXMpOw0KPiAgICAgICAgIGlmIChJU19FUlIoYmFzZSkpDQo+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gUFRSX0VSUihiYXNlKTsNCj4gDQo+IC0tDQo+IDIuMjUuMQ0KPiANCj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+
IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbA0KDQotLSANCkNoZWVycywNCnRhDQoNCg==
