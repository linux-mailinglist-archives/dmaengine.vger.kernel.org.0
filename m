Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E366E2CEA
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 01:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDNXeN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Apr 2023 19:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNXeM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Apr 2023 19:34:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380B9C0;
        Fri, 14 Apr 2023 16:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681515245; x=1713051245;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iGEtWjwBtltHPW4MjUsYv5JPyccsKvvDCWP/Hm7rIhA=;
  b=LCJ34B6zUOV83dJQermv1AdB4NoOCBCBMBmaG6Ad37Ui+PWGfaaVetqv
   0TzQW+FRgStAqngpAybgILRghEVCSbEWHyiuMzsTY5ISrtbn3TD3x5L8n
   K1LYkKL4AXVdHT4cA70FAWytNB2Hl9JWiUenxyJbHbeHtWSl45iFgiHkx
   tp3UMbJUdnMs8dJYfhP1yrPuJlL1tFjBDEjFfSC8qTJRWOZa1vx2TDIv1
   /ldQpJBPu3V/kwWNB97Dneg2Uhsxl8mS4NpYfMneJZJuRkipKeyW1OOhX
   UnDHTj924vb2yo6pCOzBcP8pFpVQ7iEr0aV3fyxtLtn/N6n2m9ZNet1QX
   g==;
X-IronPort-AV: E=Sophos;i="5.99,198,1677567600"; 
   d="scan'208";a="206609899"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Apr 2023 16:34:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 14 Apr 2023 16:34:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 14 Apr 2023 16:34:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnYX+9BjZ08zaWRMfp97t9xatpFwrlYAc088+B0zOnfL97TLjBFt4pr1mbBacl5yEOfOmA4t5EvhHMBzgGQ+FSaGVvOmBC4x2vEypV3aVMTClCWIAdsDiL8HqI4TJzUPut7EcclZxKJBO1pCvB4sCYL1qMmhGXIW8vKNookJRiHHdJLibzSE87pY5lOn67d4WL3pmF2ZYnGXcG0JqCJyePBkmeRQR402pP73lWgezZkEAnEMk1G3RjY58fZeg6XJyb5RQEpr3hU3YLKxY6EXiTkJMmLf1gWOTPd5OGGvWNRaCCZBIuILYo/eLa+/srZqSVV/M/nb6XxUGIL6HRRFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGEtWjwBtltHPW4MjUsYv5JPyccsKvvDCWP/Hm7rIhA=;
 b=D2hCbtM8j0n7Qa7PfbppRlLDW8hz7XBsVFhVSg59t2g5iR11H4+uuECHYwslOYjrXLAqbW8gVEkXJfxVI8fn/GviV4MsbaOD4GYQ/ksdHu5tJNU/TES2gBPC2s11iHeg1pmpnjeEn9gvxxPaEnzvrjBkUw+YUM12aqgBCiHKwVFkVme356C1pueamD0enwGA2KWdQI2hFifD3ko+cYOW//iOvwMV/PLtPRevAGJVh5JFtNWZ+KIcuI+QAubZ3WbtXauboSzl7sHuL/oHHQZuDBtYB7jr2zvke+iaG/DsDPKUjafGVWz8kqopazuiDclgt3zm+1YdDBC1nPypqIaYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGEtWjwBtltHPW4MjUsYv5JPyccsKvvDCWP/Hm7rIhA=;
 b=HCE28eglH1pR+riH+h2pUG6VUzKdgfaUJqz24HkMM2e40UFZoDifaIWQbllGiZHeyqts4rWGcvGfrvmYLPL3+NnAY1NQ+qQR+9l5yHSqjMKD4IWr3wmA85x2RNpFCds2nu1Ipw3JIYDBAmbZYvd97fOOlaPqHOx8ahPs6IXRQwA=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CY8PR11MB7338.namprd11.prod.outlook.com (2603:10b6:930:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 23:33:59 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4de2:6d2b:430c:ef6b%6]) with mapi id 15.20.6298.028; Fri, 14 Apr 2023
 23:33:59 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <George.Ge@microchip.com>,
        <linux-kernel@vger.kernel.org>, <logang@deltatee.com>,
        <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v3 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZaNWGdssdDNSctEm686/OqYigAK8n78SAgAORvAA=
Date:   Fri, 14 Apr 2023 23:33:59 +0000
Message-ID: <fec615f661c6d244ee37ec082df25b1943add135.camel@microchip.com>
References: <20230406210323.1018163-1-kelvin.cao@microchip.com>
         <20230406210323.1018163-2-kelvin.cao@microchip.com>
         <ZDbkZxppP/bmj7DD@matsya>
In-Reply-To: <ZDbkZxppP/bmj7DD@matsya>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|CY8PR11MB7338:EE_
x-ms-office365-filtering-correlation-id: b8bd4a50-ab51-46f0-86c8-08db3d40b8f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eEFUQGDp5vPWWICi5XYU2CfOpZKwnBnnDbidplMxTY6WPJlBSaRH8ace1Y24sitTesoEqE5mZ4utfAcaqJuEIwfwLEOARnbz9jVUtWhro++8ZLUc6/HuetdcxKOj1d4gSvOHSU983F1Las8Y6lxeMVtITy/gs/MV93Wt2C/OJfP4Wll7a+h6XrAu+Q+pSziWFfR2iyx52rYdYe0SyF8SxNtvtWRylg4BFHIzPzuqxVyvqOBOn4jxLiuADLnluoNwZlQjN+dH+cybpI629pbDA8RDmLhF3nFIU3gyWNIpxOPYRaqb7GPAdCYeXvxHSBCXzptnzEXCyL6iUaSDNwVhxCW4kH9XEx+vFHJxZg4IAFQSFtBo/onRTuYvjvRmFbeCT1agsgPaQIJ1laVYOypaVFdrwYgKjh40DwtLvAIYSte5KPNUvPj/yK4dUKDsHGXhrWO6mxc/YBFH1E+VafCPzdcGenMnP+CFAvvV75f1r+3kpO60QdYSqGkWDiOB5Shrocef8vg458TutkiYxpy2RRc1V2aN0RnM+/nLnnUHsT2jzEuDfizxObTcMR21Hy9tfkugaben4LGnnBV9mI+dxeIDrSHtISramV36lOf8W4g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(2616005)(66476007)(66946007)(91956017)(76116006)(6916009)(6486002)(66446008)(66556008)(478600001)(64756008)(54906003)(5660300002)(122000001)(4326008)(8676002)(38100700002)(316002)(8936002)(41300700001)(83380400001)(186003)(71200400001)(6512007)(26005)(6506007)(966005)(86362001)(2906002)(36756003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU41dk1qT2o2QjQ3c0JjK05SakNnYVgrN3dqclhNVzhvbkpxRnZnNlJXOUxi?=
 =?utf-8?B?bW1KQmE1VmxlRGJ2Q0ZBdVJXTURxTDRFOUhyRlJFU0JUbEx0bGN6eDhpcktX?=
 =?utf-8?B?Q0t0aEdCaUk4VGk3SW5Oems0ZnNYZnJneHhEZXp0QjVXRGtzR0JsQ0dhUmlj?=
 =?utf-8?B?bmtlS2thWTFVQkdid0dTUFIwRjliWmFPQUkvZzZOUWlpKzdrczVzVGs5bTN5?=
 =?utf-8?B?d05Ndm41ZlJZRi9ld2paWHpUSjdid2QrYzlUU3MrNWVMNTdtekQrWStNRW13?=
 =?utf-8?B?Qi9wZE42K2JrYjhoM1dtWVJtNXVBWVRtclJaS3FZbW02TFdSZkJUV3JPbFo2?=
 =?utf-8?B?NEFnbGNTN0xpKzhwNExHckRuR2hRcGt0U1dLd0k1Q3ptMVg5Zkxjdk1nMkNs?=
 =?utf-8?B?bHZVd25scUtydUgvVUtsQ1l0SmJsM3VLaGdVSGR6bjBEdGxtbUEzRjd3ZlFp?=
 =?utf-8?B?SGp2cnM2TkRKb05ZOVdCK09DVDNPZU8rS2FDd2RCbjRFQTRpcFMzZllRUmg2?=
 =?utf-8?B?YlFweWM0dDN3QytCTlZuNXBMeHFXc1B2Q1UycnpNYlF5c2lHalVwR0dVM3ZR?=
 =?utf-8?B?Ry85QjFKRmh4eVN3NzRORk5wQWN1MFJSYjhYbnZNSUFGRnRGd1RCT2hrZnBq?=
 =?utf-8?B?OE13NlFkRWVlYTdwUnYrRkZwMCtOaGg2YkV6RWgzc3FaTURMdmg1akdRTzMw?=
 =?utf-8?B?OEEyNS9WamNCb0hVOVk2R3ByN3Vnd05aWTI0UjVNVkpkbjdJTnR3ejV2OERJ?=
 =?utf-8?B?NUdOTVcxNlBLa1V5ZzlieEhUZWpLcTJveHJ4TVlaYi9Cb3docEdVeEEzVG5n?=
 =?utf-8?B?RHBSbXFsZ001VDkzbVVMdndOZW9HalhpMkFPMUNlL1QxazJCNkY4NUd5VmJW?=
 =?utf-8?B?ZkE4YUJxMzVteWFRRTBxRjI5b254UkFxVGdkLzhmSVZ5emdNS0F0WFQxbkh3?=
 =?utf-8?B?WlNMRkRtdjRqblNxdnNDRnBXQVIybG83TGlNRkplZmdUSG8zS1dKYmVjbzhP?=
 =?utf-8?B?QVNQT09PUWlCR01pN0dNMEVvWmUzVmVXOGFaRFN5R0dSTFkxakNkWmlEb2Y2?=
 =?utf-8?B?VE9vV0t6UExHS3dySVdmTkxMRkptK0djQ21DcUlhMmlVNG5Bam5XNGkyTU1S?=
 =?utf-8?B?dDZCOWFhc1FIMThPMWk1aWN1T1IwRzVIQnExRk9DMktCWDY5UFVUZmdobjhT?=
 =?utf-8?B?VGtmQVpZUGdkbkZwb2hFekZhN25rd1kvUEVJdXpqSmRyTEg5TEdQWk5HdmNj?=
 =?utf-8?B?UWwwZ1haaWlzbUNWRDBKOWpkWUhtMHhPdXZ3ZHhzcEVHVTFROVQ3bU9sNk5B?=
 =?utf-8?B?eWsxWlZTN0xlL25EN3VKUFYvWmdVZ0tHN1FHa1FKcjgxN2JXRUVDZHVmbmZK?=
 =?utf-8?B?L0djUC9BNHFoWVBJNEZHM1ljSThJRVI2alZlSWNwbEEzLzBVTEVBTDA3eXhU?=
 =?utf-8?B?YnJPb3duZTBVN0tBNTdkZHZQUyt4Y05maXVPckgvZ0dpdUdpdXZyZjI0UjNJ?=
 =?utf-8?B?d2p0Um1NWlArL0dxL0hkVGFpZFptRmtQOEdTQU90blRneFZCN3dpOUM5eUJD?=
 =?utf-8?B?emt5aTViRmtrNFBoSm9ndDZ3c1FLa3NqN1JYSjltV2lNNlFyQ20zY1FOcHZG?=
 =?utf-8?B?NGVPMDJwVnY1dElVaFRnaWdpaE5kb1I0cm14VzVxcHB6dTRjSzFMcUpjSnhP?=
 =?utf-8?B?S3E4OGtENGx5UkxZYmhoSG1ZQmJqTEZacWQwaFQvR0JpSUhtWkVzdXA4Mzdk?=
 =?utf-8?B?WENFeFRHV040RG1aQmJBNTNUV0x2ZUc5ZFpSeCtuTFB1T0VObnY0eE1POThQ?=
 =?utf-8?B?cXZEVlB6bFpFd1BBOTlnVnlmQ29XbW1BaThTYU1RMC9kcDVJa0FJSzNDSmF0?=
 =?utf-8?B?czNxOXJRc1FqaHhSZmM2anlnS1NoMTZKenI0Y1ZML3NySzVENkw0dC8vY2Ur?=
 =?utf-8?B?SDNZUXNVSmlNMWt5eEdJMHFvZzVrV2hJdVAyQ1B3QnhwRmNYblhkR3NDQ0dV?=
 =?utf-8?B?TWZSQXdiZDk3L05JdDVZYU96NitCWHFvbkpPaTFaNUI2Y2dtTTVFNVBGMk1F?=
 =?utf-8?B?cHB0dDRLTGhlbUlxTitKV3FCamdkWDVFOGI1bDYya0FDelhtVWxJck1aWmZD?=
 =?utf-8?B?bVNUMWR3YisxS1dYQ0N6b2VnYVJoUXc2TUVQU0Y0NTdpUmpRR01vOTIvT3RL?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5392FCE77D1FA648991C7341E92BAFFE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bd4a50-ab51-46f0-86c8-08db3d40b8f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 23:33:59.3405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6/dqYQnyv9Lik8sbDAJLS6Hjo4SYGimVnpd6isDu1F9nzr6F+1J+FGZ/4UGweBG1lKMJXu08PdkdTRro9If0x12dBopNUUWtoUEFBgQ8fU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7338
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gV2VkLCAyMDIzLTA0LTEyIGF0IDIyOjMzICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KDQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9jaXJjX2J1Zi5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZG1h
ZW5naW5lLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiArI2luY2x1ZGUg
PGxpbnV4L3BjaS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gPiArDQo+ID4g
KyNpbmNsdWRlICJkbWFlbmdpbmUuaCINCj4gPiArDQo+ID4gK01PRFVMRV9ERVNDUklQVElPTigi
U3dpdGNodGVjIFBDSWUgU3dpdGNoIERNQSBFbmdpbmUiKTsNCj4gPiArTU9EVUxFX1ZFUlNJT04o
IjAuMSIpOw0KPiANCj4gd2hhdCBpcyB0aGUgdXNlIG9mIHRoaXM/DQpOb3Qgc3VyZSBpZiBJIGdl
dCBpdCBjb3JyZWN0bHkuIEFzIGEgbG9hZGFibGUgbW9kdWxlLCBpdCBzaG93cw0KJ3ZlcnNpb246
IDAuMScgZm9yIG1vZGluZm8NCj4gPiANCj4gPiArI2RlZmluZSBIQUxUX1JFVFJZIDEwMA0KPiA+
ICtzdGF0aWMgaW50IGhhbHRfY2hhbm5lbChzdHJ1Y3Qgc3dpdGNodGVjX2RtYV9jaGFuICpzd2Rt
YV9jaGFuKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgIHUzMiBzdGF0dXM7DQo+ID4gK8KgwqDCoMKg
IHN0cnVjdCBjaGFuX2h3X3JlZ3MgX19pb21lbSAqY2hhbl9odyA9IHN3ZG1hX2NoYW4tDQo+ID4g
Pm1taW9fY2hhbl9odzsNCj4gPiArwqDCoMKgwqAgaW50IHJldHJ5ID0gSEFMVF9SRVRSWTsNCj4g
PiArwqDCoMKgwqAgc3RydWN0IHBjaV9kZXYgKnBkZXY7DQo+ID4gK8KgwqDCoMKgIGludCByZXQ7
DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCByY3VfcmVhZF9sb2NrKCk7DQo+ID4gK8KgwqDCoMKgIHBk
ZXYgPSByY3VfZGVyZWZlcmVuY2Uoc3dkbWFfY2hhbi0+c3dkbWFfZGV2LT5wZGV2KTsNCj4gDQo+
IHRoYXQgc291bmRzIGZpc2h5LCB3aHkgZG9lcyBhIGRyaXZlciBuZWVkIHRvIHVzZSByY3UgZnVu
Y3Rpb25zDQpSQ1UgaXMgdXNlZCB0byBzeW5jaHJvbml6ZSBkcml2ZXIgdW5iaW5kIGFuZCBsb3cg
bGV2ZWwgUENJIG9wZXJhdGlvbnMuDQoNClRoZSB1bmJpbmQgaXNzdWUgd2FzIGZpcnN0IHNwb3R0
ZWQgYW5kIGZpeGVkIGJ5IExvZ2FuOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMTkx
MjE2MTkwMTIwLjIxMzc0LTEtbG9nYW5nQGRlbHRhdGVlLmNvbS8NCg0KPiANClRoYW5rcywNCktl
bHZpbg0K
