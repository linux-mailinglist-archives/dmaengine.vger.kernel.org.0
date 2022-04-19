Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089CA5068F2
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 12:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbiDSKse (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 06:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbiDSKsd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 06:48:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9F5E08D;
        Tue, 19 Apr 2022 03:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650365147; x=1681901147;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=VO28EpyKOAMAOHhZNDlzthLZwLAjDslbPO8x6HMunjY=;
  b=U7maKvTtV6hlLazqzMb4pu9e0b/pR7uypct7moCgt5GURGVhzlfZSpo2
   NPYpxQOogghOZHq8pyhwHxslXLv8oaQd/z+FPSwQq+2bfCUgFEG1EIA3l
   mVkZGAK3iAmIjfmopSIZiyYwHot85PnzH/7X5qIQEQK0qBJLdscbAgHiB
   t2B44d7TPcu8Z/LSurxhtZ1PpYdHXpvkwx0OXuxofGDWcWakgIyRQFt1X
   4RoeGn1nq4U7RCTbQSSpN8sDsT69a6pJb+eMIyFDJXUXKDR9mYSy5xrPG
   AcgVj98Eoa+TE/3JKDFot++YAuP/3EuZtLMkvEHu+r67wKfjYuiYntKa8
   g==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643698800"; 
   d="scan'208";a="160522641"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Apr 2022 03:45:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Apr 2022 03:45:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 19 Apr 2022 03:45:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciHuuH652JLKPmbBDVmKzlEL1y2bZLQDnqSTE7QrcOQcXqUcZXtNQI4wLMl4eFCbZkF0JQCtVcE2YJonTSEQRrvxKMe76qqqKW5fP/DcZWfkrWBmgT1fgXvngZyg49lr40TO1KTVO2GL9MGGpIlVd5pERgeA6eCKgvmnhwOPnnV76mTtvcwAD/kyj02SRIqVCPz/RcakeGJmpcXSS9XT/kU8josI4mlwk6DCqW8uSGdUgARs8njyNzroPPzyjPL227A3ePPz/UTFG/H6eKAo/Ju/R9w7yHonRLBuiYmQSIIVcGYZ9KVk2kWyGLLIr0b6waWxKvmeHKoMs9aY7S2F/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VO28EpyKOAMAOHhZNDlzthLZwLAjDslbPO8x6HMunjY=;
 b=Ksjlt+qNQtotBaPathfTM7PAUP1E9rz+0JPpsqxfW38fR1u4XbN++h5MFJmV7xZzf9KRcYkcG+Rd00HjHCyASP/2DgTJ0MW3GdVhonFVEQAwksa+3xG2SPAi/hRI8VxkB7cowlC32f7eW4YNBFndsDPFQavpM+7fkEGqH8t8c67ICM+Ate++tRtjiJZfgp56Y9rmInLGtEW8Ro/4N1ooBRKfXYDMogCON2sZM6JhdDR6MZWWLTZOGly0ULF2x3vDUC96M+eRexPXZPJYMCu37vqV8ZO1ky8ptPpC8oJ3LnEjx4J+tRBKothl77bynnooRZStzOj88z9QGLE/4jgP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO28EpyKOAMAOHhZNDlzthLZwLAjDslbPO8x6HMunjY=;
 b=NByEr+hwfuCA+ICbZSM1QCLF+Sbjl6MLYYRuEtppu46zpFbQti/pgqnvXtXgF7CUT43xf+E6LM9RvDy7FxydXEYxjBaIIrDZ0pUEvfDrMi7stzB10Wcye5DiYMx5Ya/cRVJ8cGLIWffIUbqp6EfA2iVBaNDBuS00hp0JnUhxqzo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by BY5PR11MB3991.namprd11.prod.outlook.com (2603:10b6:a03:186::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 10:45:38 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220%8]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 10:45:38 +0000
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
Thread-Index: AQHYOuRQqw5OBaULxkWhWo/jlioa5az3NWKAgAAJ9YA=
Date:   Tue, 19 Apr 2022 10:45:38 +0000
Message-ID: <03e28a55-d3bd-f3e1-f418-557306d65505@microchip.com>
References: <20220318162044.169350-1-krzysztof.kozlowski@canonical.com>
 <20220318162044.169350-2-krzysztof.kozlowski@canonical.com>
 <a8c5d574-c050-bbc3-efa6-9b45f5f27524@linaro.org>
In-Reply-To: <a8c5d574-c050-bbc3-efa6-9b45f5f27524@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2740b16-55f4-4bda-52dd-08da21f1bdfa
x-ms-traffictypediagnostic: BY5PR11MB3991:EE_
x-microsoft-antispam-prvs: <BY5PR11MB399109EC6C5A5ACA2E0ECF4D98F29@BY5PR11MB3991.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zI4fhoYamFR7CeWHdS/j/BKNlsf3QrGlAIwPbwQPV+nMklPG6JQT9f8MqewCKDVqZsbekCv6Od50ev48UQLyY0d7rU+L8caGl5Im/B7yCmQ6AnW32IJR5F0acoWXDQcyi97B9aQmEfrrzGzJ0D/uiJwAg2HVc5R+8SP/V7HmIGbRG9YwVoZ0myoKZhGuDQ31beeVJF5xEJGgSP+/lozg2Bd0XMiGfG7HyarzZNUMgdexckDqAbWit4dAEDhURzKz21rtWH8P/okkQh58HB9sIfeHe3ISRivndAoGj46tASnyU6rdDOaekFwGYUvTQdAF9p0qNzKqu9TJD31TTxfj92/xRMENDLpgzvM4SL3VLcSGaX/3qAb1xjgFFCGImWZjFJZnwQe4PhWEeNlXKpPXGz/wSlQDaXmzFnktQUz5BPkW/CAFG8+ZrzA2lhZAyTxA8VWG29xoXtv42tzXfaCgLw3k4U8cxmMOixTHRi7VWNZht7x3nBsill+Z16JySo58m+HTXPU6HNXGcw8Izxms+fVn0IF1fNn6BWrzFkatiWg1GmpP8sEdfAU+xh/sO9/yOJaZUz7pppkL+sxJHn0QT9BCRaCWfjye7inzBrcrgtKo3/VZxI1ckqTmRcwEnOjUOfnxYkndWi+HmMm0YtqBTNLgCDU+dK9jC3mSmnC6Hxsc6Vcc01i7ZOngiPfRvjfq0GAlDG66omXb6LHG8/Z0NexkADuoR0l6BAcEAxsUDqqTureL8v36tDHawadWArU4N+k0D/GHdJYPkhXTrrjMmiKDVX5x00jyyNFo0teZXtwoocOn/Eg5OOrOyAVhWsULEWDx8g87sC/azDL277wxRgwit7aayX4uAb3W0ag+khAQ2RcUKJC426PjmVqy+SwB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(110136005)(6512007)(38070700005)(26005)(186003)(2616005)(6506007)(83380400001)(31686004)(36756003)(71200400001)(316002)(6486002)(966005)(66446008)(122000001)(8936002)(921005)(38100700002)(7416002)(4744005)(64756008)(66556008)(66476007)(8676002)(76116006)(91956017)(31696002)(66946007)(86362001)(508600001)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alJUUmJoVklMczQrS0FFVExDdWZSTWlPOUJQUnFPTjM0VGlkTjc2eWJ5aGlK?=
 =?utf-8?B?WklwS2VYTUExaVhUalJ4UlIvN0pYR3U2ZWJuczQxWmM4WVJ6cmU5dzZaSkJQ?=
 =?utf-8?B?TEN3UitDNitxM3B3UUo3djVvb05rSEhYbUx2d2ZUaU9mQ0FqRmtxWDNxNzZZ?=
 =?utf-8?B?RVZ0aHE0aGM5aUN4WjN2R0FRVWRkRUVySnYyaS9BMHRLZTZCc0xUY2xyWXJU?=
 =?utf-8?B?TjVpc0Z3NGkwVEpZR2tzOEM3VHlKQzJGR3A2UG9Od2xvZE03cjQ2YlFoWVdr?=
 =?utf-8?B?dEZPbTFhVEhTTXJOb0tUKzkySFk0YUYvSVRMbmhvRmhBVHlkdGVjTHR2MEs2?=
 =?utf-8?B?bUxpa3ZJS0loOWtpZEJ5Qk12UzVLT3NZb2RxWDRqQ2VMMTlCam01U0RjTUtO?=
 =?utf-8?B?NjZoV0JNNHlDaTBjSDR2TExjOGhxcU1BbmFSMSt0SlE2YlVqYmwwM2d2VDJm?=
 =?utf-8?B?NkZrVmZhVXd5aGFPWVNaYTlqSzAxQVVJY1YyMFZlbnRWSGgrTlYyaXMwcFEr?=
 =?utf-8?B?RkdwZGFQWDlMRVFFMkJheWJxOUgxME5GNGFJS0hZeEpTekpROTdtSTJZT2pB?=
 =?utf-8?B?Wis3MlF1ckZJVXFJNmJXNHNjczU5S1FaUEhFUVNWNml0Nm1tT3dBQWtLRXJG?=
 =?utf-8?B?OTR5cWR1aUVZdngrMDlKUU9ET3U2WVU1L21OU0FQbThPeFlJek56TVNpUElX?=
 =?utf-8?B?ZUI5Ymk1REROcEt0UHRrOVloMzRKdS9yMGYydUtmRWhSZnZKK1lRQ2pWOHpo?=
 =?utf-8?B?T2dpRC9ldWg3RHRBNHFqVTVUL1JIT2wzUUJNc1BHbTlENFZDaXcza3ZWeUZ6?=
 =?utf-8?B?TGd3U3pjK09kSmFuOFFlcG1qWG4zRXBRckUrRUxVeStDNUovMjNtZEo2RjNZ?=
 =?utf-8?B?K3RsMmVzU0R1WUxUcW9aNkhjR0Vsb1FyenpmUUxrS0ttUkZBWWFwVjBFZDZn?=
 =?utf-8?B?SGJGTGpaTU03T04xbWtTWDB1Y1V0d1U3RUJwNXJreG81eWZyYWxxdVZUaDFq?=
 =?utf-8?B?MU45RnRzQjJZeHdHTnJubHFjbkRyVC9yNXFpTW1RWGZlM1IxTm9TbFZQZU1T?=
 =?utf-8?B?QXBIMm5hQWRseG82aXBFREsrOHhVRldpZjJRZjl4c1ZGb1Z2WVZoa2N2Mmx3?=
 =?utf-8?B?ZGZ0ZUZmbW9KNXd4R1IwUHVSd3ZieU1KcWhFcSt5Rk14UmgxTENjcC96dDVx?=
 =?utf-8?B?eUlkek11Y0VJTThjNHBCWk5zeGQyNEFERFlVNWJKSnY4UXRYTzFSUnd0bDVa?=
 =?utf-8?B?bWpFcmJLUmJ6cUs0QldjWTVvZVpiUmlHMHM5ODhwYlcxR28vaE5STlpaV2ZL?=
 =?utf-8?B?RlZVbDJBMWdwNVZKOVIxV3QzNysxNlY1TGFRQ3NZUVA1REhIUVJFcTRyWDIv?=
 =?utf-8?B?a0VOVU9xYkorM01iajJidmp4dkNhUHRBNzc5Y0ZiT2RHOTJSNThzbXF1eGtW?=
 =?utf-8?B?M0RIZlRpQ1k5dnExdEZkakNWMmx2ZTdCdXRmNGNkQXN0Zk02SldPSTRDY0pl?=
 =?utf-8?B?TzZMekZBb3FNSVg3d3NRTEFzaUZyU2UvR1BnWnBoNitKTkpjRVBRb2RYR1JU?=
 =?utf-8?B?bjZXZGlqZHQvdkFVNkJ4eWlsS0RSektoMHlWZ1lRcDhFanVDV0NWelk3cldv?=
 =?utf-8?B?SjloZ0lDQ3lJcUt4U0ZBYjk5RHBVekY2UDlHTTJXLzJYTWR0Yi91L1k3QXl4?=
 =?utf-8?B?a0NIMGRzQU1OaDN6R211OS9yNmxNdUovSThTdFB2Vk9vTTNsNGFqaVk3bW1o?=
 =?utf-8?B?d0puVUM5TXBMN053WjJZRFpreXhJL0l0by9CZWFCMGpLMU85NGtLRURoVUk3?=
 =?utf-8?B?Z3g2NlBiZnYzZStiOGJzV3Z1N3NoWTNFelBBOXJmK0hYQ0JLQklwcmh3ZWp5?=
 =?utf-8?B?TG5oSkM2eFYxN1lCVVhjbkNqSWhaZk9CS1d5N3FpeXZKRUh6enpqWjBBWUt6?=
 =?utf-8?B?R1p3eDRHWkdFNDFnWS9xbmUvZDVjMzdSRkxvOThSb2EzMXVUSkpvNDBLYjh3?=
 =?utf-8?B?V2YzWEovSmtSYWMzcTArUks4TmtYQnJ4N1V5T3BXU2FucnhlOHJ6b1d0QzJr?=
 =?utf-8?B?QlZQZGc2OTRyc2ZQSFlmSG1DVDBwYmFiaytKckVMSGJoekZlVTZ2bysvVjJS?=
 =?utf-8?B?VFI4OGNZSmFxZVJLcTQ4cm5qVTRySkxhb0FnMHlGYWVLc094azZwaXpUcEww?=
 =?utf-8?B?bHdYaW9EdkpvSXVXMWE1VEVuYm9EVWg0Mms2dVJwNm9oZ1lNMnluTXhCM3Nx?=
 =?utf-8?B?dFF3bkJtZ0RtTjNBb0k5MjE4dVVuNlJpNHZFSG00NmtWelpDSkdkT1lsbWk0?=
 =?utf-8?B?dlI2djc2MlBhVThCY1NlcEJJTWdzZnJqekh0L01qSmRxdytVUnB6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2CF1CCAC7CB8049866648EE6002F468@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2740b16-55f4-4bda-52dd-08da21f1bdfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 10:45:38.3230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLm2hlJuTssTgQykFepEvI42YsGFTXXnyaYH2t6kIPQed9+K3+kbbHLShonCOyx96tf6rMi60JW0wfunqMxw/khyI1wPhKRdXG4GG7vxY54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3991
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTkvMDQvMjAyMiAxMDowOSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxOC8wMy8yMDIyIDE3OjIwLCBL
cnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4gRml4ZXMgZHRic19jaGVjayB3YXJuaW5ncyBs
aWtlOg0KPj4NCj4+ICAgIGRtYUAzMDAwMDAwOiAkbm9kZW5hbWU6MDogJ2RtYUAzMDAwMDAwJyBk
b2VzIG5vdCBtYXRjaCAnXmRtYS1jb250cm9sbGVyKEAuKik/JCcNCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGNhbm9uaWNhbC5j
b20+DQo+PiAtLS0NCj4+ICAgYXJjaC9yaXNjdi9ib290L2R0cy9zaWZpdmUvZnU1NDAtYzAwMC5k
dHNpIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IEFueSBjb21tZW50cyBoZXJlPw0KDQpOb3Qgc3VyZSB0aGF0IHRoaXMgb25l
IGlzIGFjdHVhbGx5IG5lZWRlZCBLcnp5c3p0b2YsIFpvbmcgTGkgaGFzIGEgZml4DQpmb3IgdGhp
cyBpbiBoaXMgc2VyaWVzIG9mIGZpeGVzIGZvciB0aGUgc2lmaXZlIHBkbWE6DQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1yaXNjdi9lZGQ3MmMwY2NhMWViY2VkZGMwMzJmZjZlYzIyODRl
M2Y0OGM1YWQzLjE2NDg0NjEwOTYuZ2l0LnpvbmcubGlAc2lmaXZlLmNvbS8NCg0KTWF5YmUgeW91
IGNvdWxkIGFkZCB5b3VyIHJldmlldyB0byBoaXMgdmVyc2lvbj8NCg0KDQo=
