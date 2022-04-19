Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE84506931
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 12:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbiDSLAG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 07:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiDSLAG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 07:00:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FADB87;
        Tue, 19 Apr 2022 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650365844; x=1681901844;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=pYdZAO1ynETF1Sby3WVzDpm3Wbn3r1X6Ex/GjyxpedM=;
  b=08OW0tkbntFFsLwMkPFFerOWaviZ0FRKzhPH+vWG6a7xeB0DtsoV1gC7
   /ZaJaNpfvObEawsAzI0aUxHSKLtwtoLzQGcRpZjCe8Gnb6k/NqxSA1F/P
   f5mmXpFYwXY/WXUh02eysPKjPaRTUdJYoix6eKbQyBuzpAbLW1mqPSlht
   8/jMaOYY9sbZpkQz9OdPm2LmEkOP3UbCeMp+Hwdf+iP5NJIIKMrtxy3JS
   vj6SA9NSHzTyuZP34Vv7UtkUImAVONgQXKS3DqzMhy8he5G0c81UyNc1A
   HtFo1xEbNinsJjE8LUuZn7CCkPFweXkAZpI8U2yutohTWJ/1VkrKdVtpd
   w==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643698800"; 
   d="scan'208";a="160941474"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Apr 2022 03:57:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Apr 2022 03:57:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 19 Apr 2022 03:57:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G50eov5dKl9o0soPqbYkpIkWlM1289FGikqBBTDVgydsqxTlbJOuwzMYbTBN1dzplcA2UE4lkns2qTRW92/TkHCeCc5badzvAl5ijrSTdWf3EPe/YlZHk1HHwvC2ODuMuT086567x/u+w4ylTKp3is3p4rLctL8t8+TrIhK7p72xpi/1G4aNRTMdEE3FBzBNpsZVq6nagRVnBtMACFqgoqrnoSYz195sz0oG9+oR3ChD/6wfx5kbh9e6lFCcW0RMSSSFOVpwnTNDTzVX6v2stb+YlKzG+z1gQf9QqXPqLpP6QKrjIejJutP906MnzU/ggy+SSGa7p5N1fXMtS5/6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYdZAO1ynETF1Sby3WVzDpm3Wbn3r1X6Ex/GjyxpedM=;
 b=ge/uMa9cbAwGcVbiroBHwxQk+8qJ7S9rmBLFte3FahzXywfonPZcRWFSaJVBoQI8ay2FU6h0g0O5auCz+R0dVkZ/zA9GOXwAD4rXin73+CWAhE8FkkPMAConmE3RNxNCaBnCv3vN6CsEczSyTVtlWtyTEukAVRnrHXTx1k/y6iMoNZDJxhBNu4AWZ2lcKCJfnD0MGz5OQ+Wv+jtnyJlSWFOekNmrOygWGaBDSlC5veqyVkzjBdAvcFYmUqrK2ojSmEPWMMWErOxxNhIKzor3M4Zfn+kmq7f65DFdq3NB6ubzGdOXGvIfIUqzqMHZN00pGd7o2rQJKGq8K+gOFWLTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYdZAO1ynETF1Sby3WVzDpm3Wbn3r1X6Ex/GjyxpedM=;
 b=uN1WjtEuBIdDLpq5kbVQvPxsa/jGQIGmKOC0+NmChls7KlSTPVwz9kcp6jkR9U+RnJXB8Fpm7y289Gh25KkXVbcb7yCngJAXYLGZKsYM+D5rEeiH8ksysNdaGLHfX2MFq9qmsrMWTcw3ZABfodLknQgANqm5C/8OiMBhSXPLPv0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Tue, 19 Apr
 2022 10:57:17 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220%8]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 10:57:16 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <green.wan@sifive.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <geert@linux-m68k.org>,
        <alexandre.ghiti@canonical.com>, <palmer@sifive.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] riscv: dts: sifive: fu540-c000: align dma node name
 with dtschema
Thread-Topic: [PATCH 2/2] riscv: dts: sifive: fu540-c000: align dma node name
 with dtschema
Thread-Index: AQHYOuRQqw5OBaULxkWhWo/jlioa5az3NWKAgAAJ9YCAAAFyAIAAAc6A
Date:   Tue, 19 Apr 2022 10:57:16 +0000
Message-ID: <9f8faffa-0b0e-2fba-7f2c-56c82ec7936f@microchip.com>
References: <20220318162044.169350-1-krzysztof.kozlowski@canonical.com>
 <20220318162044.169350-2-krzysztof.kozlowski@canonical.com>
 <a8c5d574-c050-bbc3-efa6-9b45f5f27524@linaro.org>
 <03e28a55-d3bd-f3e1-f418-557306d65505@microchip.com>
 <61923e45-6594-6dfc-5e2f-e808af99e7c1@linaro.org>
In-Reply-To: <61923e45-6594-6dfc-5e2f-e808af99e7c1@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0aa4bfce-d462-442a-bd97-08da21f35e58
x-ms-traffictypediagnostic: DM6PR11MB3322:EE_
x-microsoft-antispam-prvs: <DM6PR11MB33225CC12D1E68CC1398F02898F29@DM6PR11MB3322.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGBvO0s3YUoOoCLJ3rw9DgCZGP2W9yST6QXcrngfmxogIzoEhVtfnWse7x5Wns0eQcmPBdzefCvZM6HQupA8A5Lsdwu7EVKmBZwQE9dFxceYwERYc8HSVDyaiwDWULc2mBa6+lgC6EGQMEeyYCYLOZbui6qeUiu99/InxP26fZkKh0j0QqYWIjrffiBwNol0SjiURbAtGLlpES1Uj85dN95qvGKAKxlw1tJXCIdVqwUmnEjSslF8jQxS/hZtGMYRLVqw84wsGvmkaQCb0XYmEp5EWtgbd0t5rlDHme/FY5YcKAK298giz+SZTnHxvaZFeH/vHr9t+JY0o9sGVcIPCBKLFLYQcclRx3mdzXdL1DODZkIfn0RZ4JjdvP7vQSqhlpCUzMTxTcbZWAE98YGCIZYlT8DVgdOqIRpJ4SuFOEnqWcW60TAHIVzzq1wotVBmcIvw7vLeOUtIPNDKGbKBa0N1d9PBYS+1Wr3ZUyr+UIFFRUOA/1fHCEGFLoRpZjp5K9TQAg0H7fbzHmqsLUZEwTd0uyn+Ye5WWjTb0LT6X5Qde9M9jRsYZ2nHADFh8h9gtGzhm684UPKGftqcio0IKWCJg4QljU/LGAzX45z0amGhoqaZ7/h4JftVi3f82rkbnv0HmaUF+3+TTwTfmp0/jYLNoKECyAPSInDMjvw75ljGmVJxyPptyO8EcE9Z/OSHzEIa2WCckzV0CnNzJR6EkMdQDzpJtdeqI+vDoryZ/rKhVXca7UOqdZPzwqsgIN6ztmYI71CJgKzrCgXoCrjV/73w386Hn0Ik5qzg4gWP0jd7hxgjDphkXTZuudt4Wq3WBp1+E6ww7dL2u4WMrunNiTacRWPYyLaZZQUHjnRkGHxdR44QjaSywuz/Wk+USnn3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(122000001)(86362001)(921005)(8936002)(31696002)(53546011)(6486002)(316002)(110136005)(508600001)(966005)(66556008)(91956017)(66476007)(64756008)(66946007)(76116006)(38100700002)(71200400001)(38070700005)(66446008)(6506007)(186003)(8676002)(5660300002)(2616005)(31686004)(6512007)(26005)(83380400001)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkFUbjVQL0xWRk9nNWhBM1Y3MkxQemMrR1h6UzFNSUNNdEVqeGtGWDkyU2kx?=
 =?utf-8?B?WmRTcDZFQjVaQVQvWnZ5SURpWm03U3dOOVJaNEtDTzFMbzJrUzhXNXhFcVEv?=
 =?utf-8?B?cXJuZTRSUFhsVFZ1YktIM0pCVUNrVHJ1ZWxXc0xKOWFDREhvek1QT3dMaThG?=
 =?utf-8?B?SnhpYWJLVk5ISXhZMndueUUwQkI5ZHBQaWNFV3UwK3BrWHlxVGtDRVAxaXp3?=
 =?utf-8?B?WnhldlBiV0NBOWVOdE0yb0FHcyszd0lIalBzZW81ME5EQmVzZjM3VkVSODR6?=
 =?utf-8?B?dEdpa2xsanlVOXRUazVaNlpPaDRiNUx6STdmcFQxRmxWZ2dkMnIwUm15YXBh?=
 =?utf-8?B?VDBlaHlLaGtPaEN5cXl5U2lwS2ZlWnJHeXhOS3V0eEt4MGZYWHNaN0lPbHdJ?=
 =?utf-8?B?TGVjblg0U3lRVjVXeGJkNERkbndFcXFhTjlSTWZ6OGg3WHhnK3crYXNVR0dF?=
 =?utf-8?B?WlNRVGxPUTdGdVJrSUpvRW1uM2gwNXlwbVpqY2FuRm9hRnV3NkZIQXFnU3hh?=
 =?utf-8?B?ek5rcDExRVVnK3pHeVZyeXo4OVBGcytWTnJGbUI2S0REN2g0ODdQb3Rpakxu?=
 =?utf-8?B?d2l4WUhjeExvQ0Y3bUxKL1hpTXBvZnhFRG53TGNUUVAzdTdmOFE5MDBOYnVS?=
 =?utf-8?B?MTE4N0NmTTF2NmQ4dk1oQ01NNisydThNQmRJS3MyT0ZXc21SOElyRWx0ZXJh?=
 =?utf-8?B?UTYyNFlBcXJYUlBaQmdjOFhEUUVSZVdWMEloR3Vab1czUHF1T3Q5a2JqNFNG?=
 =?utf-8?B?dTdBT2c2V0FobUdqM1JEMG5HWEkyNUR1ZE9VbFpmVVhmZjFwUGhFK3VKb25n?=
 =?utf-8?B?TGVIQ2ZGN25YRUFBZi9mN3RWQVdjM0FFZitEMG1YcndnTy9jRmVLWEJjTUgw?=
 =?utf-8?B?dGVHOVVOM2NoL0lLUDRCSm9TL1BNbG4ydGU5dTNjMkcyR0pTUEtJZXZnLzhD?=
 =?utf-8?B?K1Q0a3NJaThncU9zV1lIdmFRNk5ldkxpYnJUbmI4Y0pObmVHN1NYOXpKNUcy?=
 =?utf-8?B?OUpRWG83eWc3UDdVQkpYNU43QVI1NE96WUVHTTF1bm5iVktjd0QvUmxQUy9X?=
 =?utf-8?B?ZE5jUzVLM2ZzazlqUFAyRDU2L2N1bEdzclBzV2JuN3FSNE5tdC9pa2VWZzVY?=
 =?utf-8?B?YlRyVU8xQ0lnVjNsRlNtN0NuOVY3T1Jud3VqTjhZYkZoOVgvWC9aa3M3aktX?=
 =?utf-8?B?ZytaeEpUOG00UUQzUnNkMUFpZW1WRmhyMFRMOVY0WEwxRU1pY3JXU2huMU1O?=
 =?utf-8?B?OGNEOEpSZHJld1Y3bktZNHNYdjBkU3NZVDFQZE9ic0sySE9sempaS2xjc1ky?=
 =?utf-8?B?R0tEazhtM281SzI4ei9LL2dBUkNZWnhsaGY2QUtUR3JRMER4ZzFXSVlmVHBH?=
 =?utf-8?B?YWVSR2FlVGdSZ05NREpnU2Q5SVVrUWI0VFJzeEdsRnU0d0hoUklHMVJrZm9T?=
 =?utf-8?B?RVVyYmhBUXVTWUFsVU5BaUhsaDU3OERvTDczL2dwUWNCTDJyRjF6bFZUUnF3?=
 =?utf-8?B?WVlXWXlMYWRhaUtBcnJqZ2ovN3RZK01ZVTFaZGs3WitHckp3cDRRcHBwOUh6?=
 =?utf-8?B?V2tjaCs3MjBpTVgvRlhNWjZpSlBtUzB0STBPeE9ETk9XdFBZdURlRXFFUFVC?=
 =?utf-8?B?ZjNEQ1lhSTE5MVFZMkNWaThabm5OY05hczR1NEdjeloxd0NLRm1Sd2dYaUMy?=
 =?utf-8?B?MTdMcHVHd09Na2w0Ylc5c3J6eWZ0RENIZ2xYL21oRXJVanljNUVCcTljeE9n?=
 =?utf-8?B?aGpWNUMxa1N5VTlNdU1EVEErcU1Jc2tGakU0RnUxS1QzZHJHTFB6VVJEYjRQ?=
 =?utf-8?B?V1BUaUZpOEJpOUMwN0t6emFQOTkyemtNSVNjYkFyZG80eGRPbno2eHRmNWtI?=
 =?utf-8?B?NmxENHBpSXdScXArdC9UN1Y4c2hyd2o2SHZFdmNldzhmamhMVWtjVkNBQW81?=
 =?utf-8?B?dTdlSGVhWm9JVnlEeVdzcjlvaFhpTXczb25odW5OZkNuc1BpTUdQMGdWSEpp?=
 =?utf-8?B?SksvelFRekU5SGl0ZnpyM1JrRkw1QURNSkhORElTaENlb29xT1lnY2E3SExS?=
 =?utf-8?B?SXJGTTVIL2xRY0FFYSthTTRKU3ZFNFVMckRwZTB6UHBWdG1QRC9BMFpWUHNz?=
 =?utf-8?B?OGZCeGpaRFFkeFE2WG1neUREQ0MvaFRlMERxV3BhRytpV0RVaFR4MjJncDJC?=
 =?utf-8?B?Y0lIYkd1SXd3RlZTQXBCSURHQXFzQlJnUnJhUFY1b0xjL2JYOEJQNlVEOEJl?=
 =?utf-8?B?a1dQUGgvZnlGdVY5a0xlZGhLZXoyTXlBOEIvdDYyQ3EzRWFPWGJVMVp3ZjE5?=
 =?utf-8?B?SmpHNEJjcHdDZHhNeDcvc2d4ZU51cmNZWDhXc2tGdUhOOUtDVStJdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A4751460B6D9941905470B7E865BB9E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa4bfce-d462-442a-bd97-08da21f35e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 10:57:16.8740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTufZ+GWVh/hU0hBBGkY/b+7u6hpT3kVJ4gfCBjXAaOTR+TC+CfOC7EAjFCcmxqKK2PZyl472MKmTKWGpHhNnTFWfKBkmlRPF9ckogToFP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3322
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTkvMDQvMjAyMiAxMDo1MCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxOS8wNC8yMDIyIDEyOjQ1LCBD
b25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDE5LzA0LzIwMjIgMTA6MDks
IEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiAxOC8wMy8yMDIyIDE3OjIwLCBLcnp5c3p0b2YgS296bG93
c2tpIHdyb3RlOg0KPj4+PiBGaXhlcyBkdGJzX2NoZWNrIHdhcm5pbmdzIGxpa2U6DQo+Pj4+DQo+
Pj4+ICAgICBkbWFAMzAwMDAwMDogJG5vZGVuYW1lOjA6ICdkbWFAMzAwMDAwMCcgZG9lcyBub3Qg
bWF0Y2ggJ15kbWEtY29udHJvbGxlcihALiopPyQnDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6
IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAY2Fub25pY2FsLmNvbT4N
Cj4+Pj4gLS0tDQo+Pj4+ICAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvc2lmaXZlL2Z1NTQwLWMwMDAu
ZHRzaSB8IDIgKy0NCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+Pj4NCj4+PiBBbnkgY29tbWVudHMgaGVyZT8NCj4+DQo+PiBOb3Qgc3VyZSB0
aGF0IHRoaXMgb25lIGlzIGFjdHVhbGx5IG5lZWRlZCBLcnp5c3p0b2YsIFpvbmcgTGkgaGFzIGEg
Zml4DQo+PiBmb3IgdGhpcyBpbiBoaXMgc2VyaWVzIG9mIGZpeGVzIGZvciB0aGUgc2lmaXZlIHBk
bWE6DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi9lZGQ3MmMwY2NhMWVi
Y2VkZGMwMzJmZjZlYzIyODRlM2Y0OGM1YWQzLjE2NDg0NjEwOTYuZ2l0LnpvbmcubGlAc2lmaXZl
LmNvbS8NCj4+DQo+PiBNYXliZSB5b3UgY291bGQgYWRkIHlvdXIgcmV2aWV3IHRvIGhpcyB2ZXJz
aW9uPw0KPiANCj4gWm9uZydzIExpIHBhdGNoIHdhcyBzZW50IDEwIGRheXMgYWZ0ZXIgbXkgcGF0
Y2guLi4gWzFdIFdoeSByaXNjdiBEVFMNCj4gcGF0Y2hlcyB0YWtlIHNvIG11Y2ggdGltZSB0byBw
aWNrIHVwPw0KPiANCg0KT2gsIG15IGJhZC4gSSBpbmNvcnJlY3RseSBhc3N1bWVkIHRoYXQgdGhh
dCBwYXRjaCB3YXMgcHJlc2VudCBiZWZvcmUgdjgsDQpJIHNob3VsZCd2ZSBjaGVja2VkIGZ1cnRo
ZXIgYmFjayAtIHNvcnJ5IQ0KDQo=
