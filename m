Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFB2585D17
	for <lists+dmaengine@lfdr.de>; Sun, 31 Jul 2022 05:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiGaDoe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 30 Jul 2022 23:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiGaDod (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 30 Jul 2022 23:44:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2383013D7A;
        Sat, 30 Jul 2022 20:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659239070; x=1690775070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3u1cr1pM2nkcb7PG5UfNA180ej6D+WtU/Z4ORjuqfAs=;
  b=oGTPxUyW3xwY3fzL+NuK9hUiQoL7LQWZeG8gVTQ0/BFaZKhS/oi+bzpl
   9ttVc2gM4pNrJhsKG8ZKuhYUIZwmG79XjnSj+Kkr8RN3v5XfVrEaojMyF
   gBNAiXx5TxdawsGy9VQfU+H+/X5iCLF/TbtlDKSH6QyX25NdoGszyLrga
   IlRVzadkAXJmRlwwLsRfyXJdUE9xlVKrWSvFcAP+Ax2GMAhkbPoMSBMn0
   HDCNZuQp7mHw6tRrWE1hRDlt390Qh6Nq5TN50ddawqrtgK3zh3R0FrALf
   iJx39KirjoTVKmcTOX32iNh+KIiec0NYjoXO962BpqFNj7vJryjExLpjU
   A==;
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="106874955"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jul 2022 20:44:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 30 Jul 2022 20:44:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sat, 30 Jul 2022 20:44:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdPN5B4SjVzu8hQAVHt1tRX2GfwwtCgnLbH2CuOkRdHgJZkHwBAM5bATIIbaW2w3gVXlqus/ZHaLLGnhWHyLqHbTDpa75huH9A1PiTIrY045AmSdixk7OxprLFTkI0W7HJOECSCY++VRS581EBcR0zgWl9vnfYkMDp3apZWUBek1W0mA9/nANI4Zi4v0eYXSBQh9rFjJXaG9LQWA8KFoZadmF/saWnaxEsCxjmaeFTl6v6SmVX49WLmSlNpdxz0c2UPvIqQTOriy01C8VyZcu70jHDVqyOe1hpblJFhGGEWl//ieCgNKlCm3g4WfuoXfUZ4QVPuLLVd4IV8jeINAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3u1cr1pM2nkcb7PG5UfNA180ej6D+WtU/Z4ORjuqfAs=;
 b=Z9dh/lhsMYiDqUtGyywgBQSfjQ6LiDQrDaPjVCtFKV6QZzVACATShQic2niHM9bqJcm0JuiJqhTjRZgG1oSpJjW6o7gaoePsqPlyXzSsSMMwnfKlCLjUYtAhofgM8tzzFrEwIyKF9i+BFMf6bYG0GjJ1KMsdEUahC1+1NBxsy9CTnttH5As27lMBX4mjvs4jV1+7pM/OwR4ymiPQIdLwuMV8hDC2SEv4hWOGcWa/flkOdQVfEcXWeWloECCAkCEtawJ2QtabpmalpiDAqadbNgmj9jJt2rlQyn6k3jQAAeqMMeI47bfdcztept/x1+FAxjCc+V+AkG2Ms8Tjfo1mtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3u1cr1pM2nkcb7PG5UfNA180ej6D+WtU/Z4ORjuqfAs=;
 b=PvdHq9BviwQFS7hfJ0rVh+r/rwu5jDOzKMfRJEn2Yhd1s6YykfM/JCOeBnqryY1qQciFeS2uXM03CThNKJXsJbcX5jI2LvMF2Lzi/cmrEdicPuChq+RbTcUzouJwdmnCZASW1n/YnlWGF1R+gZjUXoIKkLST38gMi0CmMNwQG7M=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM4PR11MB6383.namprd11.prod.outlook.com (2603:10b6:8:bf::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Sun, 31 Jul 2022 03:44:23 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35%5]) with mapi id 15.20.5458.023; Sun, 31 Jul 2022
 03:44:23 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <peda@axentia.se>, <regressions@leemhuis.info>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <du@axentia.se>, <Patrice.Vilchez@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <saravanak@google.com>,
        <dmaengine@vger.kernel.org>
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Thread-Topic: Regression: memory corruption on Atmel SAMA5D31
Thread-Index: AQHYL7i/by/02n1wA0qavxdAEojSfw==
Date:   Sun, 31 Jul 2022 03:44:22 +0000
Message-ID: <3105533c-d125-b8db-10e0-d85700e69597@microchip.com>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
 <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
 <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
 <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
 <c5928610-4902-27f3-7312-e8c85eefad39@axentia.se>
 <bfb4cb27-e2e1-e709-1c27-d938e4d30eab@leemhuis.info>
 <6b1bae01-d8fb-1676-3dee-9d5d376e37f1@microchip.com>
 <0d8b2d9c-af85-7148-ff13-aa968a7f51ad@microchip.com>
 <AM0PR02MB4436C535FDD72EFE422D8B10BCB39@AM0PR02MB4436.eurprd02.prod.outlook.com>
 <272fb9f0-ad33-d956-4d0f-3524c553689c@microchip.com>
 <dc500595-7328-999e-6fa7-7e818378bb0d@microchip.com>
 <9104267f-6dd5-4e49-6a81-f377edceffe9@microchip.com>
 <684f7262-13e0-f519-ffee-bbdb3ed80717@microchip.com>
 <0d3beabb-5786-14a9-2918-5fc76b38034e@microchip.com>
 <52c3b37f-dde2-9dde-df92-8ae114fa43fc@axentia.se>
 <ae13fd5e-050b-b41d-b8d5-c8b339ee4528@axentia.se>
In-Reply-To: <ae13fd5e-050b-b41d-b8d5-c8b339ee4528@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cf80e62-2809-485f-fcdc-08da72a6f52b
x-ms-traffictypediagnostic: DM4PR11MB6383:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W03J7hLQlmAHW39tubpsh2ecOeZnyDhzG4WJyFqoZQkjXmZsf1KR4UXks5djVAnIxh2I6xR+j21Ub0LU23XfOb9Cj/4NsSHPh2ndWi7cOb2hPGMohUbcCE2f7SUzgVu5TiDqr7K143dxUwVbDUBokovYXQI1qr3rYFCgbGKXsH7lGnlfIMN3+vcW2+MTMIsNDB7O2wGYcHYXyMQQMVepidMJHyq1/LcMxv1anlLckIyk6iuYtCWNZtmBswzd2PpBvNFFAtrBT/ADpUP8URrUos8yz4uo+dYscE5NaTbDnHZuoufhmS81Gz1U6J5kz16q8zlaN7pkUz5ND4n9xkh/veuPZE9jEWzs4agz60KmkYDNgmNS3GcWAKgC/2P+4Jt5jzqXVcnfsCGSge+bYl/ZUiTSV+804MLb2617DxCnBEuN7X3n5pSwWl0aOQbln/Oq8aOkK0ff5VPdbn+AVBRUFKtdJ5vKs/v0/yXlzynHZzjOSRIK1+BbkYbLP+DZIp2hKXZncUYXjsFDg/MbROUKL0xxBhAR/jJOc/KhC6DSMuScq8pn/Tf00p+iZ43O0zDVGEJC09YgXmXLTdqb1BqAFjUfuPFyCSAmDqarCKNDRtdP+20qK4qh4F6mIeoo9ny+QhfTwUrsJ9DEoa3ewbObfBxBxs/PPP1jcge/pE8mdQicZmGL973VuXZ4nC6N6BJXtlUkIb/q47FyGwOGuyIZMO9JIMPisIlhvzTlVBiqdVpexeA7TLA8UFSIvbPUGK53Jg4UX2l2HSIBxwUDX+OUbo8VOMLFS/hnJXYby6+1sJgprFKhOJl+dCnOa4RiM0SoXW2ch+vddU5qQWjpIvMcG4qpJZcy5mfBO8FXUSBPWvv/wG9uPNTB41wcYoltj810
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39850400004)(366004)(346002)(376002)(91956017)(2616005)(6512007)(31696002)(86362001)(38070700005)(38100700002)(478600001)(122000001)(6486002)(5660300002)(8936002)(2906002)(66946007)(8676002)(66476007)(76116006)(64756008)(316002)(66446008)(71200400001)(110136005)(66556008)(83380400001)(186003)(53546011)(4326008)(41300700001)(54906003)(6506007)(26005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk1FZnhsR2o1LzM0STMya05LQmEySGlucEZ2SDcxSmh4TkNwYkFTbTNYN3Ry?=
 =?utf-8?B?OERDNUkvT1YrcHdJOXoway9ZVkdLbDI3eG1aby84aktMZWdKRXVtYndldUd2?=
 =?utf-8?B?ZWQ4TENSQkVRdWhRTTd6eE03cWdSdHRmYTJndyt4dkw0Vms4SGRuUjBycXc3?=
 =?utf-8?B?Rm1rd1RZdTBXcGRDaFkvU2hPRnNMZFQxOHovOVk2NHlUWkt5RjlnbmlXZldp?=
 =?utf-8?B?dS8vdlNnWGJIN3N3VDlvVEc4SzA4SE81TldUTExtcUpPa3Q5N3g0eTRlNjVa?=
 =?utf-8?B?SWV0MzFsRFltSkRJTjdKOVlDTnJmZXpGL21oOGwwMWlSVTRMMTFxLzgzenND?=
 =?utf-8?B?SURXSlVuMkQzR1djb21ERzFYVkY5enlZdnBmSmg1SjN1TnhKMkdRMXVIZC9y?=
 =?utf-8?B?ZWsrYm9tS0hUcHdtU3YwM2s2ZUNsN0h6cENhbktZZFhGR1lyM2RHUVdiWXhI?=
 =?utf-8?B?Rkl3WW9HQWRmdmdDWFJNM2FGVjlKNTh1T3JHcnZBTy9ETDFjSno3K0ZsQUlU?=
 =?utf-8?B?WW1jdkZRTHBwWW5xdEY4VlBCM0VzbnBkdUVTUk1iUjlVUGY0Ukt0dUlpbWM5?=
 =?utf-8?B?c1NIQ0M2QXp5RjVCMXNYU1pWU2VLOHY4NFA1RmgzWGd0QjhxTDJ5TFIwTnJE?=
 =?utf-8?B?bXBIUDlqeTFKMk00em5vR2lzUWIvR1doNmI2ckQvdmlMcmtUcUxPNEtjNm1m?=
 =?utf-8?B?RnNqK001ZDVnNks0Nk1kSXFNWFpZZFh5amtiTFArNFRnM0lRbXd6VGtSNjNB?=
 =?utf-8?B?NW9JcWpJTjNhU0dMWkhNaEZ4QWJFaXpMUjcxUTRibFFyQkRZQTIxNlYzRTIy?=
 =?utf-8?B?WkhCU3hMZW9lMnRLL0pXSkh6U3Q4cWl2N2t4LzR3WFBxbDRwMllML1RCS0Fm?=
 =?utf-8?B?T0VmUDhlTG9BUlhyVlBnejE1Z3lBR1J6Z1FqS0d4K1FWb21iQmdpYUo4QWtu?=
 =?utf-8?B?akJMRitEZWNLUGczVUZvT2c2UElzVDFPTkRyYUJwTFdNemh5Mm54MmE0dm8y?=
 =?utf-8?B?cXFmcnBDeHN5cC9jMFdjUWtCam10SSs5bG81a1RIcldHS2VKYjEzRjVTM3dB?=
 =?utf-8?B?TUlJbTQ1S1pCbTdMMDVIekNBUVdyaTVJSmdBOCswS29MMnRPWnQ5UCtQaVVJ?=
 =?utf-8?B?QTNKcW5pZ3MxRkpJQmw1NUtPaitmb3pHRXg1MHpnNUoxWjZHZktFaVZ6Q3JL?=
 =?utf-8?B?T0htUEFyTlRGdGxSTUZod2tEVDdWQkxacllNSlZuTUxzQXBwbmpFMjhkYkNq?=
 =?utf-8?B?WCtGbzNCTDRmRlRuS3p5L1RQNTBqOHAzUDVRUHhTV0xyTXZ4NG43WDRGMktz?=
 =?utf-8?B?UXFhcGhQV0VmN3B0VnE1cEV6YS9HbGg5NDRGSmkydkZMb0hvUXhJd3M5RlRw?=
 =?utf-8?B?MDlHY0c0L2ZpZXlHalY0dmdpOUp3Sk5Ma3Iwb3RRaWJrOVhRZklqUXJFaXU5?=
 =?utf-8?B?aWxaa0dISTFqdXBxdW1EczdLT2I3L2hsdkRLR1NHZTRSVlpYYmhkM0t6bStt?=
 =?utf-8?B?b2JZMmlPSERFY0RNMDZGR1cvU0x0MHMyWURwWGVGcXVRU2hxc3RjNXBJc0k1?=
 =?utf-8?B?V240TDV4bGNjYkJIRkUxNzkxdldqVHlSSHE5aWRNdEhIbHlHYUN1QnpHT0RN?=
 =?utf-8?B?ZmZhUGFieDU3dnN1Rmd5UzlIVklZR3htdWxoVitJVTdqYVk5UVV3ZnpoWXBl?=
 =?utf-8?B?Sm02YmdnYmlLTGgvNEZhT0JMcmo5eVpsOGI2YnBBdUxJclFka0poMXVzcXpy?=
 =?utf-8?B?TDNtQ3ptUHNzMEEyMjZWU1NsZEU2dXBQQ2xwU0wxOWg1UFJMN3AzSnowaThk?=
 =?utf-8?B?RGQraHhnS0RLTm1VMkZDOHFXdnVPZ0JoZ21CUUJyR0lYZ282eEdDZFdOa3VI?=
 =?utf-8?B?UXNlOFc0WWJYZ3Z2UUY1NlNycjNsemYwQkxTQVdhbGtqK3laUGFCNzZFM2ZT?=
 =?utf-8?B?VjJSWlN6SW5NUTVNY1MwbENqL1dRU1lxU1daUUFCZWRka0lmTWpIcGxOMSta?=
 =?utf-8?B?NnZpbUxBeEkxWHJRbTd2R1FsUnlhMDFnZk1nNnZLVmUvWEVOSGp6ZUV6WHdW?=
 =?utf-8?B?RUhOS01ta3hwNXdjOGEyU2hLNHRvdnZweGgrbmpqYjZ0djB6ek1OR01FRzVU?=
 =?utf-8?Q?d3XSRZpq5i7akcZOzSELKt3r5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D61C265444A6E42BBE022DDBBBD887C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf80e62-2809-485f-fcdc-08da72a6f52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2022 03:44:22.9627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxU/dbpfA0oW6X3Yu1wrZh3tUe48LDaQ8OsGxsEHht+vJVZa944VBL7bJ/uMztMxNs+bjnEXpeULpV2s0s1/97+2eF1Ca6fWO0wyUxqAxtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6383
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gNy8zMC8yMiAxNDozNywgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gMjAyMi0wNy0yOSBhdCAyMjowOSwgUGV0ZXIgUm9zaW4g
d3JvdGU6DQo+PiAyMDIyLTA3LTI4IGF0IDEwOjM5LCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+Pj4gTG9va3MgbGlrZSBJJ3ZlIGFscmVhZHkgY2F1Z2h0IGFuIG9vcHMgaW4g
YXQtaGRtYWMgZHJpdmVyIHdoZW4gbm90IHVzaW5nIHZpcnQtZG1hLA0KPj4+IHNlZSBiZWxvdy4g
V291bGQgeW91IHBsZWFzZSB0ZXN0IHdpdGggYWxsIHRoZSBwYXRjaGVzIGZyb20gWzJdIGluc3Rl
YWQgb2YganVzdA0KPj4+IHVzaW5nIHRoZSBwYXRjaCBmcm9tIFsxXT8gSSd2ZSBydW4gc3RyZXNz
IHRlc3RzIG92ZXIgbmlnaHQgYnkgdXNpbmcgWzJdIGFuZA0KPj4+IGV2ZXJ5dGhpbmcgd2VudCBm
aW5lIG9uIG15IHNpZGUuDQo+Pj4NCj4+PiBDaGVlcnMsDQo+Pj4gdGENCj4+Pg0KPj4+IFsyXSBU
byBnaXRodWIuY29tOmFtYmFydXMvbGludXgtMGRheS5naXQNCj4+PiAgKiBbbmV3IGJyYW5jaF0g
ICAgICAgICAgICAgICAgYXQtaGRtYWMtdmlydC1kbWEtMm5kLWl0ZXJhdGlvbiAtPiBhdC1oZG1h
Yy12aXJ0LWRtYS0ybmQtaXRlcmF0aW9uDQo+Pg0KPj4gSGkgVHVkb3IsDQo+Pg0KPj4gVGhpcyBs
YXN0IG9uZSBmZWVscyB2ZXJ5IHByb21pc2luZyEgSXQncyBiZWVuIHJ1bm5pbmcgZm9yIGEgZmV3
IGhvdXJzIHdpdGhvdXQNCj4+IGluY2lkZW50cywgc28gZXZlbiBpZiBpdCBpc24ndCBmaXhlZCBp
dCdzIHNldmVyYWwgbWFnbml0dWRlcyBiZXR0ZXIuDQo+Pg0KPj4gSSdsbCBsZWF2ZSBpdCBydW5u
aW5nIGZvciB0aGUgbmlnaHQuIEZpbmdlcnMgY3Jvc3NlZC4uLg0KPiANCj4gUmVwb3J0aW5nIHRo
YXQgaXQncyBzdGlsbCBhbGwgZ29vZCBhbmQgdGhhdCBJIHRoaW5rIGl0J3MgdGltZSB0byBkZWNs
YXJlDQo+IHZpY3RvcnkuDQo+IA0KPiBUaGFua3MgYSBidW5jaCBmb3IgeW91IGVmZm9ydCENCj4g
DQo+IExvb2tpbmcgdGhyb3VnaCB0aGUgcGF0Y2hlcyBvbiB0aGF0IGJyYW5jaCwgSSBzdXNwZWN0
IG5vdCBhbGwgb2YgaXQgd2lsbA0KPiBiZSBzdWJtaXR0ZWQgdXBzdHJlYW0gaW4gdGhhdCBleGFj
dCBmb3JtLiBQbGVhc2UgbGV0IG1lIGtub3cgd2hlbiB5b3UgaGF2ZQ0KDQpSaWdodCwgdGhleSdy
ZSBqdXN0IHNvbWUgcXVpY2sgZHJhZnRzIHdoaWNoIGRlbW9uc3RyYXRlIHdoZXJlIHRoZSBwcm9i
bGVtDQpyZXNpZGVzLg0KDQo+IGEgY2xlYW5lZCB1cCBzZXJpZXMgc28gdGhhdCBJIGNhbiByZXRl
c3QgYW5kIGFkZCBzb21lIHRlc3RlZC1ieSB0YWdzIHRvLg0KDQpTdXJlLiBXaWxsIGFkZCB5b3Vy
IFJlcG9ydGVkLWJ5IHRhZyB3aGVuIHN1Ym1pdHRpbmcuIFRoYW5rcyBmb3IgdGhlIGRldGFpbGVk
DQpidWcgcmVwb3J0IGFuZCBmb3IgdGhlIGhlbHAgc2luY2UgdGhlbiENCg0KPiANCj4gQ2hlZXJz
IGFuZCB0aGFua3MgYWdhaW4sDQo+IFBldGVyDQoNCg0KLS0gDQpDaGVlcnMsDQp0YQ0K
