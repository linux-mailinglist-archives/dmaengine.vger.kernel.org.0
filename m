Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AAC587F92
	for <lists+dmaengine@lfdr.de>; Tue,  2 Aug 2022 17:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiHBP6U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Aug 2022 11:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiHBP6T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Aug 2022 11:58:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC04BCB
        for <dmaengine@vger.kernel.org>; Tue,  2 Aug 2022 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659455897; x=1690991897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xngrzX9bFPtpW9U/4Vhsc+D7jGL7RWLvvkSxui8ygMY=;
  b=CzEEzodR9qlse0fzOrCjLpXxYcuW++QAicQQ+qdM1Wwil9jnCnAxYT5q
   XJ/PJJFlJJ2gukQACE5gcjXRKefPhAhD06qsh7DBfbKe0bex+XIbRr1d1
   P1Mjr9yrw+tgiv8KTn84bZFYxG7e3t53JO4vSkg4VEOpATn7BAAyb167W
   dIhe5oJ+quZBa6kyedEr4jhPme0xuCaiEKTN3XFnz7M941+WivRZPeqK8
   r9oSN1khIseAUq/R0rbjon8deOZe+Q/FKSDSAKpoAKk63OCWll0VdAjTS
   yxd+07ZXVpnjzCIfhc+29oNQPq9fKOp+FND/iCiMBPjBRSAzfl+/8I8ro
   w==;
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="184781695"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2022 08:53:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 08:53:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 08:53:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8xoBaE33TLCPpjbzJ/TrJ5g3OjARfbAzIyP62n/ok0QcI/5m+BAqq/JcQx+Lbjxoz7pfLTolf0fvVm/l+yea/eq4qD8wXIPkQWhjg+44sJQ2C7gYffiPjIUjqUYp8eLy3QUdNR8xXBLfFTyrAY2lIKZt8WPKFM88zFzFe3T8YKF6uTI1+qNuSIvqlWun+E1rBIFW39VbFF+dheuksXBGsYD7uLr0wvjxSk/ZqNGJatt3/R0Gryyhci2ymB+DGwTjvbQMUslWi0Zy1Cq2tu2ulgz5oFAguBNDpTCcH2Ms916PXDYUFoCh2xFtg70lbHFbZqiVxsPY4VbHmqW+7NIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xngrzX9bFPtpW9U/4Vhsc+D7jGL7RWLvvkSxui8ygMY=;
 b=baoQfUd8T1+Oo1K2b2jRwWj8dYMj8fQMHHOs88A43AjlGK2Kt2UvO5i9ScbACRbJwuu4WscXUm3FbnXxvm0s0qinKiAtrm9R0gzQQid2J812Qk0MrBOXirbn/IGUXhR6jPI2Ju1/iF0tdjyFJh96OuVwUdI7zXQkokaXVeHISfwsrv88D08mMzunhgnxwtWhWO/aaGWjL5epDBpLWT7NMnGtVJE9S5HEstl0JI2h8LTu3AlLX2YEPoPwiiggsDdE4O8JoHUsnQUMDcJzoSiZQFESsLYhlQ7wadrKcBIrRwNYEsjmJRBrIyf5H6C/PAS2NzkCZO0XgP4g57GeFH2j4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xngrzX9bFPtpW9U/4Vhsc+D7jGL7RWLvvkSxui8ygMY=;
 b=TVi6t5cy2zXDxLM2ZS9sKAQ5R0jklKy4zzaKRJ9zyuOQmfTyfVJ3ASzTPqBP7TNuRMIkeMlxU1TaWBujqUvSWjTwqsRgycX6IVC86rAutiTNtPQNmykycLuPHMWiwxryxmSGe2NqTBAEmR8XHxPp9isyOv5p1vN6YTSVthj9kSk=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM6PR11MB4459.namprd11.prod.outlook.com (2603:10b6:5:1de::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.15; Tue, 2 Aug 2022 15:53:04 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::d826:894d:b9f:9552]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::d826:894d:b9f:9552%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 15:53:04 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <benjamin.walker@intel.com>, <vkoul@kernel.org>,
        <maxime@cerno.tech>
CC:     <dmaengine@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <okaya@kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH v3 0/4] dmaengine: memset clarifications and fixes
Thread-Topic: [PATCH v3 0/4] dmaengine: memset clarifications and fixes
Thread-Index: AQHYpofy8OpwgYmfiUO0jnqCdjwdYg==
Date:   Tue, 2 Aug 2022 15:53:04 +0000
Message-ID: <e3728a24-71a2-f96e-a7f7-84e70ae1eb0a@microchip.com>
References: <20220301182551.883474-1-benjamin.walker@intel.com>
In-Reply-To: <20220301182551.883474-1-benjamin.walker@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f09294b-d85b-4b6d-4b84-08da749f15ec
x-ms-traffictypediagnostic: DM6PR11MB4459:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cL6TEt75RB5RqQ5d0aHG2Hy9gF8ttsc76GQgx1px7tUa5XLWW6htJ6cOfefXYwnOEXS+oXAtMucTJIoj+R9PSuWMMr51rTUuu4g+LqGVpMadNfx6tQBIDpw7kfk23Q73Q1p3pIlsSpacPmKO0UYgQE9HW2xKCCzkD5fwb2UpjYeU/OBngdPAFondJIHMS+hWrvYyJ1UqvUdJiO3HsFXcyfl6+ecNkLEcvQOTe53SPf5QM9YX0rpsoFBl8RPHKDDrtt7wNHto4rjcLUE0dJVeFRmnvmUT453FEcq0h9SEqY19G7OySzyl2qUgwLykkAeMYYTh3QLnMFM4genIlQZ04mccHWdFmXKRmLy67JuZpF/IeUzsb0lnYQxs0QyypVnhmbYEbit2FPNCvv6wfbkd5L2IZjmjYNZumoh5nZFhXmWGdOFLUJoTqGpy1iS3exfZF3RL7ZFE1mHq7jqeuRj5n6W6AmoQ50C8e7tBsqW35CXeTrJZWbYICUYoFPHAngK3q0HobyxMZXGQSw0uZv0JciSaUQiatAW7QkExTadBEhR8sjhPt0beEKVYOD+9ERFESSHc3R5GoMfAJK8MMJ41/iVIlQeoRBNTnTNwpgzjZ47wT/mdMtaih3ZcPrnT3O2hYqpMyOXSPBnPOnh2dPvRDMwS7A/k8qDuSk3U232YPk2lopSAts/V2eOv6Zg7xfKyvhN1D5a4i/JxNt4/rGepgOvU036JNaTVeMQMyt2NGdmKp0pxJoZCOrFUbhiEbKaaUzw3zmuKyE05nLNM4hU24u6pTSXhFeEvlPR770dM8WpnIFKjUQqIKloU7YWomycCfsMvkNTR7m6o5Y9dTLUYgJdb6gaIOmMTVLi5kZk81g5Q/60u3kyo4ggTEzSu9r8CDqIfI76ipaElf8hHLXwuEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(346002)(39860400002)(376002)(6506007)(6512007)(26005)(38100700002)(122000001)(53546011)(38070700005)(186003)(36756003)(966005)(31686004)(31696002)(6486002)(478600001)(2616005)(91956017)(66946007)(4326008)(86362001)(76116006)(71200400001)(8676002)(66556008)(66476007)(66446008)(64756008)(41300700001)(4744005)(5660300002)(8936002)(316002)(54906003)(2906002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGtUSWplVFgvYmovTlFhQVFLQkw1Y2tKUzVzeUoybXJLSXMzVytuVjQ5RkNP?=
 =?utf-8?B?WEVEejV4T1o5VFh6am81OVB1VFlOanlIY2k2SFB2Yk5ieHMwdWFQR3hRdE81?=
 =?utf-8?B?RVRMeE1TbmdGWFJFUGhrOHZTRjdlN2lGTWp3Z1VLRUsrWVA1ZHRGbFkzaUxw?=
 =?utf-8?B?aWZ6R25TcmV4NkcvV0YzN0RMWFp2RktvZEhXMzZRUGlyS1dhV0g0R3ZndDBp?=
 =?utf-8?B?L1haRGdkTmx6bVlqcmpRdmZJWDR4Y2owcGcwMVlHUnltN0lpNDVQR0o1cUM3?=
 =?utf-8?B?bjZOdU0weDMrMFlYMG1PQjZoSTN3UEJQWjg1V2VSOVJBUElKcm1LTVYvalRj?=
 =?utf-8?B?N0UvS2E1SmhJQkYzZWJKWm1zZ2RzMmFmc3ZVS1U4aDVoMXBUWGF6TlF4bVdM?=
 =?utf-8?B?cVBiZEljdGtKY1ZpU1plVGVabFpCU3k0ZUorWWplYWFoalhjRWdwK28rd01N?=
 =?utf-8?B?bGwvSitNbXdUckdHKy9XckRoZklEN3dkUHZrSmFRZEErWlQ3T1p4OU9NbTRm?=
 =?utf-8?B?ZFUwWDlnZXducUt0THBGZ245c1Z0R09lVzE1OFVUcjJUQmxrdURYd2R2YlpH?=
 =?utf-8?B?eTFvN2pzYTVVQ05aSkJVa3lrZndPTm9MYnZsaENETjZNYlZYTUVMNVBPTTBX?=
 =?utf-8?B?MDRXVkxiZzU1K1E2YWJBU3hmWm1sRCtFVFBUYWhQZnNUb0g3MmlFdDRndTBW?=
 =?utf-8?B?OWEwaUxPWjZNdkhCTUFhR3N4RnJvTmlIMmFJeFZlZzFuUnJFNkY2NitVMnZK?=
 =?utf-8?B?TUl5NXZ4SE1MeHVRSnluVXA5dmhRdFVrQWg3QkoydUcwRk1FZTFYM1RsRDY2?=
 =?utf-8?B?V05BMFQ0eEx4cm5kUzZXZUdHTWhWRjJXeE5vR0paVzFkWTd1UlYvMzNNZ01i?=
 =?utf-8?B?YS81K0g2bm5EcUxGdkhheWJ1SDBJVzlFOUxEWFZCLzRLc1ptVE95QlIwN3Ba?=
 =?utf-8?B?bk1OUUVXSWVzT1dwQWtvcW5CNHdFd1NnTGd4b0MydHJhMjMzM3pSQ3pJbjZy?=
 =?utf-8?B?Vmd1SXFIalQ4MWI2WFRaRGthY2Y4Q3Q1dUNGVmhJR1NtSG94RnA4N0htaWhS?=
 =?utf-8?B?b1ZXNzVBSGIxd2FGbWRqaWZkbjdpOGxCTFJCZDV1VTRYMTFPM3FKbW1MMXBJ?=
 =?utf-8?B?eG5DY1NZTVdKUDNaR0lJZUVGc0VOT3pUK2NYNk8xVFF4WU1EU09FdkM5ZEg1?=
 =?utf-8?B?UXU0TDZzQXdxYjZYSUpXSnVadjhvY0NUWHYzR1pjMXNBNGRGUjE3eUdMV0Js?=
 =?utf-8?B?U01GLytTSzRtNnhIWjhBMlJkam5seVYxdFYzdW8rV1JOVlRRMVlBV2xoaE5a?=
 =?utf-8?B?dWNYODJrbW5aNjcxVmVnN1dEWGNPRjIzUThQSkFpZHM3OEJVY3I0Sm8ySUFt?=
 =?utf-8?B?YWEyL2d0UjFLVlNBU21NTzN1SnNIRzdCWFFUSkprZG53YlpGcyt6TUtNWDFH?=
 =?utf-8?B?TnZVU21yV2F1MWEzL0RJTC9zK1d4OTUwZHdCdXBoeDZVb3BoN2ZuSVpTa3M3?=
 =?utf-8?B?L25ReG8wdStaZ3FFUmxGUS9TYlBSTDgxbk1od2xBdWFXKzZGRVRnaDB5eC9D?=
 =?utf-8?B?bVVxMk9aOVBqY0poZlpBOGpnelJ5L1duL2kwbGFOcTFJRTJCa2RTUEN5cVJT?=
 =?utf-8?B?d3o1KzlZeTBEOE9sSEVoUWdpTE5nbWtCU1N3SG4xVUpHbEp6VlhVRFFoUWhE?=
 =?utf-8?B?ZmtjM3ZxaGxtbWdTVHJ6MWVmNytreFlERjNpTklDckRWZGVBcVFKV21uQUVJ?=
 =?utf-8?B?NytwMVBDME52eHF2UHJZeVJlYTdGTGYvN1BSQlpkcmt6aGdOOU1IZTBxVXJN?=
 =?utf-8?B?ZVltQnRxeXRYNlB5c3BxV29kK3c0U20wVnJVZnJoUlRJRWE0dTkrNlQvVWVu?=
 =?utf-8?B?WTYzTUhQb01lVkFILzBvNjBGdjY4T3g3NGJ4QWpCN1VETU42bTRhZytjTG0x?=
 =?utf-8?B?UHJLMTBGWUhRSEhsaGhBeE95QXF1UFJ0RE15eDNvSnJTbDh0bnd5YldXOG5t?=
 =?utf-8?B?RXJ6Y3dIVldoQTIxNmZkaXNweWEzZFRkc1VoNTZ1MWYzQU9FdGVDQ3pHYVlC?=
 =?utf-8?B?UEtzbVE2eWZ3bFVZZUQ2ZXdoZDNUZmtRaGsrTjZJM1JITEU2VjVpWVpkS3pM?=
 =?utf-8?Q?amx1LPxjyPo2ZuBE/pALNL3FY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31E2CD3F20E52F41AD0C4B1A49753477@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f09294b-d85b-4b6d-4b84-08da749f15ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 15:53:04.2463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKx1xV0nHKJYLcMt35TlYdb395S06VOjhJkPrH0bcgSOUy/HqeCV/kAdIvnop15EThfIdZWldvagZDPh8uFgkmnbnxnINESGFovaB3N8c38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4459
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

KyBNYXhpbWUuDQoNCkhpIQ0KDQpPbiAzLzEvMjIgMjA6MjUsIEJlbiBXYWxrZXIgd3JvdGU6DQo+
IFRoZSBmb2xsb3dpbmcgY29udGFpbnMgYSBjbGFyaWZpY2F0aW9uIGZvciB0aGUgYmVoYXZpb3Ig
b2YgdGhlICd2YWx1ZScNCj4gcGFyYW1ldGVyIGluIHRoZSBtZW1zZXQgb3BlcmF0aW9uLiBJdCBp
cyBpbnRlbmRlZCB0byBiZSBhIHNpbmdsZSBieXRlDQo+IHBhdHRlcm4gYXMgbGFpZCBvdXQgaGVy
ZToNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2RtYWVuZ2luZS9ZZWpyQTVaV1ozbFRS
TyUyRjFAbWF0c3lhLw0KPiANCj4gVGhlbiBJJ20gYXR0ZW1wdGluZyB0byBmaXggYWxsIHBsYWNl
cyBpdCBpcyBjdXJyZW50bHkgdXNlZC4gQnV0IG5vdGUNCg0KU29ycnkgZm9yIGJlaW5nIGxhdGUu
IEkgc2VlIHRoZXJlIGFyZSBubyBpbiBrZXJuZWwgdXNlcnMgb2YNCmRtYV9tZW1zZXQvZG1hX21l
bXNldF9zZyBtZXRob2RzIChvdGhlciB0aGFuIGRtYXRlc3QuYykuDQpBbnkgaWRlYSB3aHkgZG8g
d2Ugc3RpbGwga2VlcCB0aGVtPw0KDQotLSANCkNoZWVycywNCnRhDQo=
