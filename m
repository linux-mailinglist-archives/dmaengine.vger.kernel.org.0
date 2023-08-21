Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E50783677
	for <lists+dmaengine@lfdr.de>; Tue, 22 Aug 2023 01:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjHUXo6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 19:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjHUXo6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 19:44:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A727CE4;
        Mon, 21 Aug 2023 16:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692661497; x=1724197497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RjWmkrjp61T+DEgxt+tYGm5Ix30GlsHMt73+DAVajF0=;
  b=H2ALhC4oDZ7ZFsuTZXs9c5sXkTBXgy/ZZpZgYRVNkkUPHMxK4f1o/ieC
   rU4Vwq4zS+jicE9/z+mnloNJHMrtvzgUEHXcpN5uO0WKDGRYmzTQYFK0E
   dO7lrnuVgJ3ZvQdxSSannR58jQPymY/gov9VqFCy3TjvG86xAj+FIKPho
   kPmkfv6hClAPpGRkpLBA8T0KgJcfGkmySaLE8BDKv3kCoN/RF+cnXjelK
   AgiAPYybM0ifZXJoE53lzFyvb9j1h5k1yvqdLPjTzSrIZ5TivSo094VWQ
   svU3/A22fM7YGUfM1WbspS40JDkELlO5423rRvo32uaceb4YTcS1EDdIs
   A==;
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="541211"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2023 16:44:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 21 Aug 2023 16:44:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 21 Aug 2023 16:44:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ6COnZ/VXGsO6VQnkkcvhqgbAzaMvdohm+rgRkL2SvF0Hy/HC7Lx4/sJJLBwEL1sBoi0uNt2n/LC1Z9MJ3j2a1wiykIJUBPpBKoMdJhkrn6Rg7RfJBOIgxnAFQmSshj6VUtZeKv9U5P3PwiRgUyrP1MTGYe11r8zVM9ivpt6V7KdQch+0hMODnpTEUkrYorz+VnDbOeEacgs4KAmia9WCCH4ANdRMrYP0JDHcg5j+UCTWUEpZFB0YWuGSwNcKnba07GPz2oSCBB1zTZ8q+6YpsPQWHFNKrmZ+1w/71G/71BBRmkpEXC+DfMnMnB+ba0fTOgi8veEWnBqmDLjkE2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjWmkrjp61T+DEgxt+tYGm5Ix30GlsHMt73+DAVajF0=;
 b=JTiRAIcxKjrG0YEJw9BUqqrMexgYL0QGD9H+b4wSkkXeB+71HqKzy9toE44YrkCVDL+qTo9oCf8F3Pom9Q6IfGe7C3Uuc1YreH07WEi6R+gM7M1JDYbZE/bSGOF1pZBVXL7Qo4W2Gio7BHO1wQEp/ZDfMN5Oq6s0008lqJiBoOhmf8lx7GoOVrJYHRtt91UTv00HjebGrTgYSyiNWsJWBPcUm1N8NkeYboj0xxkw/gY4qQ0MQ+hj6y2ioDVc72iKRWVAiG6fX+8C6M+ZGzVdlxsDsMb+np7DdnxBLGUYjOyb0Dy8uwyQRzeEgQyafFukEkUPfb40A/Oi6Hqlz9EeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjWmkrjp61T+DEgxt+tYGm5Ix30GlsHMt73+DAVajF0=;
 b=j7iyONMrSWN3GnvgsJxSXtb97GsE+p4Gvdmz4uFQ/qieb7u5Br4c288TrtYBef97Jxqaq5LvDy7pEtJTIlGJuqxRBym1oeTx1WZooanIC/ZLiZ44/mp395BQv43KvVxF7QR7nK0QE7B1992VQjnye+aTK1Xp0P4leiPYjRCQhR4=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 23:44:20 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::44ee:c980:b097:33df]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::44ee:c980:b097:33df%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 23:44:20 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <George.Ge@microchip.com>,
        <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>, <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZwZllP9AErauFFUmKz13YRSBKD6/VzMKAgAIhf4CAHaFYgA==
Date:   Mon, 21 Aug 2023 23:44:19 +0000
Message-ID: <fa5f1932c9adf1eacea839e8f4952f0e7bb53531.camel@microchip.com>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
         <20230728200327.96496-2-kelvin.cao@microchip.com> <ZMlSLXaYaMry7ioA@matsya>
         <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
In-Reply-To: <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|CH3PR11MB7762:EE_
x-ms-office365-filtering-correlation-id: d54ed4cb-9988-40d6-d180-08dba2a08a26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FUirwlLPN9q7aYtsKXmc+dZ+HPSorobZN0nUZEf2llaPF9dz7ZOaWXdtm4pnxCcsbyzv7VZm5TKeDv5xoumeaRwA4KKIeLtuAOnk2trSvEM+VyiR86A0hxv8UXGKqN8fW9YXrthJjeh/H9xjQmaxuWB+1aR2RCqr9tfjt0c0csBeKUJELeAnLArvVDcoN3VrbSUu2zLzS+TUA35wm6lyHgK1KbOWT2E6riwYwi5PlGi7ZKB5IEecv0F4hAY9/vS9uzEba+YiO73cHaw4DoMvv4bi+M+z3KbqAURLu16y4x/EY5z+s6yLn0aGyJA1PfjBS9m1CrMpOMvprroFimtEQmfV32G+oicjTNE1g6Mi/svade//y+K0N24sIHhAkAE4lCup2c7A0ztA/dDiucMVoH5ZCbljFCciyfT2LqlLPbmj59dvVVo/0uI+Rt/Ayi8/coblzwRA5dvSKlWa0OHk3McnUV7C0vSrqUaGdLZZDOZN3+yLLVDxiV552tsOC/jYmnQzaKBUvGS3rH7Il03TNi2n4nZNqZEVK0jamrx6RSkI/M6AS2NR8btpeBSNKYqaoYkUjE6xiXK5XY/uFY/gSkNquavYAHz+K30VA1xPi5gX2hTQxoJcza+gMYhBx4Po
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(54906003)(6916009)(66446008)(76116006)(66476007)(66556008)(64756008)(316002)(6512007)(66946007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(122000001)(478600001)(71200400001)(38100700002)(38070700005)(6506007)(6486002)(83380400001)(558084003)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STE4WmV4Q3NVN2JPVVhaQ1dDMTBGTmtENzZ3dExibElreVEwSXJmVkIrSHo5?=
 =?utf-8?B?TVkwcDFjRDQ2eHFHMjRaN1pLdEsrbjN6QnpDdXp5YnlzU2N1VHoyd0VLOXNG?=
 =?utf-8?B?UENENzgwdTVXQ0VDc2R6YStCaXpadmlqc2g5YnFVNkJkVmdySzJpUU12NHhI?=
 =?utf-8?B?SzlFd2Z5bjZteTdjaUl2UFlxcE9Da093V2JZVkd2YTJrc3NYQXdlK1Z3cVVU?=
 =?utf-8?B?T1RWdVpTM3FKN2NsaXdHbkFQdFpWOXFmcWNEeGNTSzNoODQwQmZZdmNjY0RB?=
 =?utf-8?B?NUFCSU02bjhnQUZkTFdxMjl5Nnh5cXFnZ3AxZlMrOWNqZmFzTncrSXlmVlM1?=
 =?utf-8?B?WDd4ZGNvSE5oM1A2UWFMak41SzE5cklKVkI5cU9pYnFzOTFZOTR6MW96K2h2?=
 =?utf-8?B?UFNERmV0TDdrTVhEbXBNclBRaGZRL2dXQnl4MXB2eDhJTzBYZjA0b2RhQ29u?=
 =?utf-8?B?VXBsdXFQZEJnaWM5RFJLMWZhYTNWLzlydkJvbTA4K3VEc3RnN1U2TDc2SjlZ?=
 =?utf-8?B?Yk85WUtSdnJITWhvdDRnUUdaUVUxeU5GbnA4dVNzd0ZSUVZjVGJ1L3FZdUVr?=
 =?utf-8?B?OXFocUtZZ2JGTzhVVmNYNC9VcCtETDR3YTFsQ2tUSFJNQlN6UnY3citYVXMz?=
 =?utf-8?B?R3dwcTFVL2UrRnVrM3BWa3AvM1JlMVQ4VW4wVDd1WEh1bWVuamh5ZWdGQjhH?=
 =?utf-8?B?RnRDVHl5YnNuZWEzQ0UwbXgvQ1BjNkNoK21RdldOdlpTcTkzRXN5ZlBIajY1?=
 =?utf-8?B?akR4NEpaSTBlUmxxQmNOT2QvQkJhYnIraVd2a3lhYndPU1V6ZUdjbUd6ZDRa?=
 =?utf-8?B?bzI1ZnBKaVRwQ2Y5VllRRTJCRW9XUkNGZmVkeGNjV0VvTlFwR1hJcm53VHZp?=
 =?utf-8?B?amRhQXVkL3RoMjR0M3FZa2xCMlNsdkwyR1lMRFNGWTRMSUdVRnpWSnFPNUhL?=
 =?utf-8?B?NUlRZXFjcDlWWEJZZXNrc0ZWTHpMTHRMTnBtb1hUR2xMM3JrN1NEYzVGTDVs?=
 =?utf-8?B?eDZrbHhBOW9IaDVMUWZqV1ExdDVRRkpjaTRmd3pnT0pLRUdrSExkRWM1OHps?=
 =?utf-8?B?dDFOUThBU1JvMkdvZUQwWnB2cURvZUE0T0dLbjNQWTVjNXFNRFFDYzVZWVVL?=
 =?utf-8?B?MzVoSHJLMzU2bFM5RkRzQndHVzVDYmZ1QjZhN1VwQS90RFRnTjZSaWJ0dDVB?=
 =?utf-8?B?K2pSbkJRSnFUZW5PYlFuWVdQdXZYNXZZbXludXBnZUJ0eWZYK3hsY0xET2oy?=
 =?utf-8?B?d1Q2VnlIRERPUlYwd291ZnBrQkNQNTViTFdCNlRoOTdRVlNnUFV2ekRMVlFO?=
 =?utf-8?B?Y3NDYng5SWZoYjBtcXR0dnFQVXdDTEVhNzkyMHBEdEdMTDhkQ1N2aDgvYldn?=
 =?utf-8?B?NTd4SUV5a2prT2ZsZ0pJenJLRDlBRnRmTm8zTmhjdnVKcFZkMzNrVTlHOEFi?=
 =?utf-8?B?WVlFVnRzWW9pSlk2U3hScEI4SVFDbEduUjZsUkd4QVRtWjRJeXRtZkcxVnFo?=
 =?utf-8?B?TEJOdklxTUpoMmd0WE9qR09CYklneWRaSzFoQlByQ1hhek85Y0xFUndsNVRs?=
 =?utf-8?B?RGdXYU9KTnNMS3VrMnBBRWVUTkFWNEZ1Ni9yUGhhMjRKTUFUUlJMVGdzaFZV?=
 =?utf-8?B?MmQwRjdoVytGWHBvRVgxQkl0b2ZiWStieFM0dUFCMzg5dGpFUDhZZG51UFBB?=
 =?utf-8?B?bXVxeFVqMFU4Y2ZCUTNTQ2MyVm93dU0rZFY4T1IvZ2ovV1FOL1czNmt2VnIv?=
 =?utf-8?B?OUZibXpVNkdXZmpteXRIU3FJdFM5VVVqa2JUeUhTRU5nUzRnYjZWZHdnNlVG?=
 =?utf-8?B?SVAxRHE0SnI2ZloycEpEZHlMd09TN3l6TEJ6em9Pa1FTU0orZGZHaE15dGdv?=
 =?utf-8?B?SFFUUFVyTm1Nbkx4dExKRzdUYSszWmdiQ2x2dWZPdHZ2TndsWktseUU2VENs?=
 =?utf-8?B?eXdwMDBVY1lZV24zV3NrMkp3MHZlOUk5WFdyWXAzbnZNVTd1K1BlbTkxVDVS?=
 =?utf-8?B?ZnFIY2dENlBPL1ZBYXhTTmFoOTFvdWlhV3ZBRGlHSkpLd1VwbjZuWUhkNi9U?=
 =?utf-8?B?YmZnd0xQN003UzI4MzBjeTVZR3g4QjhNVFZjVk1oSW42Z3RoWlNUbkFiMHZt?=
 =?utf-8?B?c3F4UnorT1RYZFZZa0EyZ1NCWHY0OU5CZ29HdmdmZ0FNZjVnV2xzOWRsZXdn?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE7231559903DE4EA466E93C59D48336@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54ed4cb-9988-40d6-d180-08dba2a08a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 23:44:19.9307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0z9iPgNz734cTz2dAZEjcP1YSEcbe2G68OsusfR/tfLUtiGsB53LdVnRxgSelwBCJ3gI1SZBlPOxkixtq0oRGdpkszjNQu8++ugu+H9c3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgVmlub2QsDQoNCk5vdCBzdXJlIGlmIHRoZSBwcmV2aW91cyBlbWFpbHMgaGl0IHlvdXIgaW5i
b3guIEkgZGlkbid0IGhlYXIgYmFjayBmcm9tDQp5b3UgcmVnYXJkaW5nIG15IGNvbW1lbnRzIHRv
IHlvdXIgcmV2aWV3cyBzaW5jZSB2NS4gQ2FuIHlvdSBwbGVhc2UgdGFrZQ0KYSBsb29rIGF0IG15
IGNvbW1lbnRzIGluIHRoZSBwcmV2aW91cyBlbWFpbCBpbiB0aGUgdGhyZWFkPw0KDQpUaGFua3Ms
DQpLZWx2aW4NCg==
