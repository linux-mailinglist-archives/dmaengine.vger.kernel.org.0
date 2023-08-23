Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B56D785213
	for <lists+dmaengine@lfdr.de>; Wed, 23 Aug 2023 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjHWHzl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Aug 2023 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjHWHzk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Aug 2023 03:55:40 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6694CF1;
        Wed, 23 Aug 2023 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1692777335;
  x=1724313335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=05vSDz6aFV29FYVGq5rpTDDMW1sfKI+FtJpKYWGNxLA=;
  b=pR1FRlgqsB78IZs9p5sovHevdPZq6+MOOZFyx5cUIQw32HkqrQUbDkFe
   hHbMWyO3HeUXdnonk8aeInQFKCPFzn2dnAJPlY7ikcbiMq7cqFu8HHxBJ
   kMwU/EwK+OWKUj0dSyj30f08PVtI8K7dq0VilP7zU9hTHMR+JxB5cJtTP
   V+zTp43QpQ5jgJEnLcQoI5N/hOKvGj0iFp0YJ9MLHhymosamrMvhtSIyr
   pqb86j9NbexFEYZ+ai0SoORYKWZ5/LDRxHueoUl88UZY/CyYkkaIddXPA
   JnrX5OpiWQdb/caQJAm4JDuuE7vrwWGDhw6mauGjkRKgwqFHt86nXhSAj
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeoxpLKw/xUrQk61WzgNHSL5hWS9+aVPtOi7jYvoHIMVnlq7j20O0yB2Lg/ofjpGbHaTbiffD1vmABw38tWXU2teHlHZ1Rnype9rMGLiuA4bsjytJJi7ETqZ8Uez529r3rQIZsWDxUl7MH+wbNIuZP82lppiaLPpiw+Q72T0TlQsgOLKutcoz/PcZS86Zam/syGBl8PIc07s2MEfeZoL6FPpW2yS7WFzGiR1N33Gc62IKwO+kO6xEkmFPQpaUvdY/8p5l7Z9vZWjJJqFLsbMiz8N52H8m8QTE5QCtloft3VpNLQe+Db65G1C07U11eFIf+uwqKpzFWbHoZQTnf1XYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05vSDz6aFV29FYVGq5rpTDDMW1sfKI+FtJpKYWGNxLA=;
 b=BWzRYWR76+j/zRrGd7uvdGszcrNXEcYxXJ583ySZtcqYWRfDdLIwI4/HgCFxOgTMXMFhqRdl1tvpcAp61H2W2PF3cqh8utKUG3d7IyD8i8ARNjbRXjfz+hEZELsqTXgxVPRZyh8AFEaHmo4RXubogLG3WYLGcRVAzG9P3gsLJMJ/Yar04fu9obshxoFU0lrGNQbXuxSDo+3ghW8MC+w14NdkVfbUQXW1siV+JexrM0qU2YG2mOLz7hCQZ3MmmZcQOgv2RwRpKX6+ytH7+563WklNSK0CA+aiSKEAtOnfSv6MbEIKAjtltc54We5akE2+RE6YpcVVHfcy6+7o6LY06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05vSDz6aFV29FYVGq5rpTDDMW1sfKI+FtJpKYWGNxLA=;
 b=mn+w0cCHdFWcHhDiuXNv7OYkWBvIMqBj/Q5ojIV/+7P4AY3fV19UsWD2mp/S3YI6XLGAgEu3bHn9vCaPIcbMedGx6eCqU3JqRi9++aIz5IOotuWC+O875c1JALfzqWcKs9YeonOCF8Ibb/xkrPrTqte0xCyu807sGmC42XIHAAc=
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH] dmaengine: dmatest: Add option to exercise transfer
 termination
Thread-Topic: [PATCH] dmaengine: dmatest: Add option to exercise transfer
 termination
Thread-Index: AQHZXM2rAe8K4qfPgUCZaChhFtoXZq/4dMKA
Date:   Wed, 23 Aug 2023 07:55:30 +0000
Message-ID: <6dee9f4a150cc7a85aa70b5d31c3f2ec50f02e6c.camel@axis.com>
References: <20230322-dmatest-terminate-v1-1-2dc6bfaa018b@axis.com>
In-Reply-To: <20230322-dmatest-terminate-v1-1-2dc6bfaa018b@axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|DU0PR02MB9968:EE_
x-ms-office365-filtering-correlation-id: 5d7b9f0e-0abc-4403-62b5-08dba3ae5264
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pvcT5YaKtYTWsPwhlJbvEEtHc7wNf5hcP33OdJdVr9iH5g7ZK3mNORW/ylCNqEoXy8Ai9OpLhuaFzgggUVYEKp4IxUrhsewNP667u6lK3oOAMhEND3u8MI9/r6XAWXAP2kmyL/Pa2/8OhrIdrCmiaVsuKq87b5ErtDRaw3Y3QKREb0hnUHynlLYVGJycqxMFu1653Dfem5GgDwYKo1gb6DEInu59iUj6WnpcacfsHCiN72YT/Ich0zJh7LyBeOd+kBv8onu37/6sLxJCkA34xU6bTPuvDfFTAgnLQDHPUZl8olkApJQeAeJYLSkvcKjKs+0JE0iq6PgG92kKh6Gtgs2j+FEkTu0TdRv+aIb8/3KawGQLhOx4OZUwk6HZgHg8GLzBsai0/zS+7sH8YKnnoNYt5YWcyu6T3xX46s75kMKZ3sW21dUpAZAa+Yr+guC6nxEQv8ji/ZF893o9AIEpRMvZRf124A7lA/6cMSXDzPbobCvIUADbNj715/H0xeqfHaR64TWLR5qlKWtcunvb848mHkGV0pM8YrFWvTBtB4E7KMZxLbJ5lcS79B8pzkHojDjSAk/DMJ0tvJkTuK9fhQAhgcnUxa5BwsDVXZ/8IjhWVE9kZCC6C3Z6is5bt0BU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(1800799009)(186009)(451199024)(8676002)(6506007)(6486002)(6512007)(71200400001)(2616005)(107886003)(26005)(2906002)(4744005)(478600001)(6916009)(66446008)(316002)(54906003)(66476007)(64756008)(66946007)(76116006)(41300700001)(5660300002)(66556008)(8936002)(4326008)(91956017)(36756003)(38100700002)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWJZMTlSL04wd0dqd3pNRUk5Z2o0R3FHYzJKY2p1SG5NZGRFS2taWUI1c3Mw?=
 =?utf-8?B?VmhLV1FaM2I2TnJqb2VjWGJ3dk1ueXRVd2EveWNEVS9hOWZEZFI0WENHaHlQ?=
 =?utf-8?B?cE1wbFBaTTlsT1ljaDI0dUJwNG5SYTdPVStKUGhPMldlZkdMa2JiTVJKUGNF?=
 =?utf-8?B?akpVY2MxUUt1Sld6S1dUck0vRytPS2tOWGwvZ0JKK2VJd0pxL3lHWGxiOHBz?=
 =?utf-8?B?blVFUk95ZmdFcGlzM0dITXIySXdlYm5KNURiaGQwcG14c2ZGbnlldFBVNFpH?=
 =?utf-8?B?bWg4RlF5OWVLUVR1dWdHM1lERU8vK0NKcWZEM1hkS3U4TzZiZzJ3YWUrMkNv?=
 =?utf-8?B?bGhCZDBGcE0rYTY2Qzd6b1NvMjFjWThUckJqUG1SU1h3SHowcGcxbUErSFd1?=
 =?utf-8?B?NHREZjJ2OXlHQU9mcWh3cWNBWFRBQmtOaVlSWFk0TUNDTEt0Q0ZVR0UxSXNJ?=
 =?utf-8?B?dWNoRXk2Y1dIZFFsRitaU0xoMFhBQlYwN3oyekNZd1NkVlZaWTZCaG5QMS95?=
 =?utf-8?B?VVlaUzU0TVpralduNC82dk9VVXBrbW9oNVlOQWNiOTA2eWRCU2dzcVc5UWF4?=
 =?utf-8?B?MVZkUVdQWHljenhMekdkSHFveFlHWkFKbDFsTG9ESnZBVmhJZDByUkp5RTd6?=
 =?utf-8?B?SWlqVXpMRnFjeWladWNQZ3QzMnU2YXV3L2hocUNDelhBcStJVFFXK1l2QUVF?=
 =?utf-8?B?Q0FtZlJaTllaQXhObTJVRUJGOWdaMWV3TTM0dW1HYmxVSVRNbFVkNXY0TW9l?=
 =?utf-8?B?VkMwZkJPa1J6SWZpOTU1NFlFWWhWTzgyY3AyV0I3elpmNGtwK1BVYUVOeFl3?=
 =?utf-8?B?V0wzYlFnZmcxaUFTWEU3YUVTT3FUOE9ZZzNVUTMySFhabjFJemQ3ck5MMkFi?=
 =?utf-8?B?OTQ2bjlVdTdMTXlHV3ROZUZmTERidmdXdS9vVVIzc20zRHlmYUQrRWdkTThZ?=
 =?utf-8?B?RlN5T3hZb1ZxRDljMk9LbWgvb1FsbFk2RTlBWXA2NmJzdGZLOGk0MnJqajBl?=
 =?utf-8?B?cnpndHJLUDdPaGVaVW4vdERkWEFMRVQyV2hCWXE2bWJRWWhnaTdranRXQllT?=
 =?utf-8?B?YXBqRU96TXNNSmNBc2p3allqQ2IvSnBFSXhQNVBkNGE4eDBmVjRPTkcra0FB?=
 =?utf-8?B?VU9KSzRVU3Nldkl0c0dSKy91TjlNRXJqZ1pqajgrVElPRjFGaVdFWm91c3RH?=
 =?utf-8?B?VGxFUi9qS2krYms4Y05Ob3FpdCtPbFN1ZU9GV2hrR1crL2pVRDQ4UGE4a0ll?=
 =?utf-8?B?STRZdjBvTExiQVdML0ROcWo2Y2xXRGhrMFRWeG1Vc2RscFdBQnAxTU14aEpq?=
 =?utf-8?B?QkJkWi9mbXBSNzhTcUFkZUEwTFp6NE52ZWEwZVhQUXZmeFh0dEYvcnFQZzk2?=
 =?utf-8?B?aE1UWHg5WlJLVEdQcHlyWjhqcmZDZWdSWTdXcWh5Y3h2dHl4UWQ3K1cxK2tt?=
 =?utf-8?B?ZmpIQTl4WjQzWERPTk9mV0dwZUNPWGdhU3pQb3IyVlQ3WEZtcEFNUW1CNm9v?=
 =?utf-8?B?YzByWWxLMHVldzZEMXdIMUNBM3JsSzZkRUZEb0oxZ3RUaDhGQjF3WDl4Rklq?=
 =?utf-8?B?V3NyYkVDS3IrYmJsK2pOQVJhQlh6eDZIa0VwQzBaRnJFOVR3YjZmZFcva2tY?=
 =?utf-8?B?WjBxOE1mT25FeVoySUFwbEZFNWdnQ0JleGRrbFVYQ2tJMTlLTTMvZ1g4dE1E?=
 =?utf-8?B?aC9DYmhoMHRscTlsdStRTlRsV1YzSGphSVJVZHd5MmhKdGdkMi85ajIvZW5m?=
 =?utf-8?B?c09JL1Q4N3ZWdmRaNStQYTlkRGZDcHhlU3JodWJhNm9xNTZqL0hPdm1DSU5n?=
 =?utf-8?B?WnRuNm5vRDRsS2tmSmZTb1lWYldveDNoRCs0QVRCeVVCOTM5SVgzT0NZQVNL?=
 =?utf-8?B?Y1F2d3RCMzlqTUw3ZGVBVTF1bnppRFNLYWNVYy9MQ1VUY2k5SzVJVHM1dUJs?=
 =?utf-8?B?L0tBNDJBUUgya3BnTG92OEtJRXpOckE5QXFnZlRFWUkveDlwS3RUSFRmY1gz?=
 =?utf-8?B?QkVXUG54SnI3SmZUTWljaWplQ0pud3kwTG5ZakRKWXZiY01PcmRna01JcEpp?=
 =?utf-8?B?dU5ySGZETFhFUG5iZjhqWGt3ajNaeUlGQy9NMnpGYTZBUm1vUGJBSGxDVGhD?=
 =?utf-8?Q?PRnBpdHab+g98rBGpgcwZHDC4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9D58C807FD36A4E94F44B7D02B9D4A5@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7b9f0e-0abc-4403-62b5-08dba3ae5264
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 07:55:30.4973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOc53FCUktvvT5QhGepqu4j1uu0Q3aMP3jcLBKYtLVWkA5AeFyHHg9rgknotY53U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9968
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTIyIGF0IDE1OjUwICswMTAwLCBWaW5jZW50IFdoaXRjaHVyY2ggd3Jv
dGU6DQo+IEFkZCBhIG1vZHVsZSBwYXJhbWV0ZXIgdG8gYWxsb3cgdGVzdHMgdG8gdGVybWluYXRl
IHRyYW5zZmVycyBhZnRlciBhDQo+IHJhbmRvbSBkZWxheS4gIFRoaXMgY2FuIGJlIHVzZWQgdG8g
dHJ5IHRvIHByb3Zva2UgcmFjZXMgaW4gdGhlIGhhbmRsaW5nDQo+IG9mIG9uZ29pbmcgdHJhbnNm
ZXJzIGluIGRyaXZlcnMnIGltcGxlbWVudGF0aW9ucyBvZg0KPiAtPmRldmljZV90ZXJtaW5hdGVf
YWxsKCkuDQoNCkhhdmUgeW91IGhhZCBhIGNoYW5jZSB0byB0YWtlIGEgbG9vayBhdCB0aGlzIHBh
dGNoPyAgVGhhbmtzLg0K
