Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9175273480A
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 21:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjFRToV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 15:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRToU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 15:44:20 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2019.outbound.protection.outlook.com [40.92.98.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDC1128;
        Sun, 18 Jun 2023 12:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkhVcCcpOETNHAUjyiuJSCf6TqYU5nHXHY0WAbK4+8GWWOLP5noEafTiFSVMUfWgkCk9YXpHGg4G/vm5PHmxTrCZBoflKWbPobEdD7VRdYX95z+zPsRdAUgmBQmIkNNNpilLFg5MIguSI9J0Pk+nDijWzoQpXZle5yzRQX6YoeqULvBXIlm7UGOnKCR6vnCqPMksco3T1D6o7xZKYXAs4axZW926oHS30SgCPm3Y147KY5U2oEjm0dnoHLLYKYMycnPNOgcR5nJ87RtXspZ3zjlyKJ22FWMpUrHqvyZ+zBcc7KuGTD2Xl9ebydLrWvx23NLDxDHjQDmPP2tyFV8DiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUR70LaRtrr2RyxBOumlL8kue0WnMuZPBdUwFhdzwDQ=;
 b=ROm8VnSrBK7TYVuK8jpQnt6pEnyjtqgKtG9jQBQYsUGozHh4SgnmzTn6iffMxGCEfpCr2IgWON51jMKOLVZ0L6TOhkDZRnUlOVo3ndcxpJdKQIxutYudRI8pOPDUCBOPUdtlshkWrybLNWQAcgEzPCNvoMa16/AOrY/gsWyiHvt6dsTc+8lF0j65jogdt/yGN0ZjBiGl1u4s5ZwXnCeUju/0K1pH15vXhIQK4ZOifxnYtsN0i37Bt1AoUaqYSrscR0iNFEhwOJu1ng94RJ2ZOQQaAiZJXKbvkUzH2nH9lfEh+qYzDIOK5e790VZL1hijKYmbyYLB37ChDxW/469ODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUR70LaRtrr2RyxBOumlL8kue0WnMuZPBdUwFhdzwDQ=;
 b=CLCLnWa1hcUPaOmwB7ZvW+Zj1BBW+PYP83htPYkMePHMiQD+VAohKAbQn7Ru7V3QGC/gYsCY+BhrAjE+feJpf+vfgCc9VAH95Oa2zZLD3+cIgnBvbQT1KXr9wiAsTxiuOCRDJQ28kXkSqTnP8egrHVgxLICZD4V0Gr/Wip8qbA+2Hju7YpB8xSD+2BfHJyV5LdTfoTTUW5F6KA5SbasF7X1GUEjIS1oD9Gp8c2AIntsYs0W/bTkpTQwWKtF7B9Rkr/YEGb1GVWUO0J8pvNvORTkHxvvoOlUHarwSScbRdlHnPOGzkEv1Sw66nMtfr0gZNKUOp3pOrskChM7BwcXz3g==
Received: from OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f9::12)
 by TYYP286MB1953.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Sun, 18 Jun
 2023 19:44:14 +0000
Received: from OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 ([fe80::62dd:c4c8:ebed:fa5b]) by OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 ([fe80::62dd:c4c8:ebed:fa5b%7]) with mapi id 15.20.6500.036; Sun, 18 Jun 2023
 19:44:13 +0000
Message-ID: <OS3P286MB259736F317E80CBAA2658853985EA@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
Date:   Mon, 19 Jun 2023 03:43:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     wiagn233@outlook.com, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-rpi-kernel@lists.infradead.org
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH RFC 00/11] dmaengine: bcm2835: add BCM2711 40-bit DMA
 support
In-Reply-To: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NqEqEmUIeuqgg5IOBvOik04B"
X-TMN:  [ReqvT5ncr6lZBTHHd9sMqTfHZ8Cma0Ug]
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f9::12)
X-Microsoft-Original-Message-ID: <43f9ed81-a35b-d408-5a51-131f3ca2d41b@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB2597:EE_|TYYP286MB1953:EE_
X-MS-Office365-Filtering-Correlation-Id: da6a124f-47a9-42fb-cb4c-08db7034647e
X-MS-Exchange-SLBlob-MailProps: RlF2DIMZ1qUvq2UaoA1ZyK4lJ1FnQcmbC1ox0IRP+WSnehEaAJbnic/v3AEgJfb7aH9trv2ng7R0ZDs66hNVR3m+ldFtY3EpbBt/Vjmw4BeVBhhooVhdK28NkLIsekCMWEzxzxJev54QU46N8JfgTdxv3lQzAcPXYSLIv1HFj0BF7fE5ZC/6upKed6WzAUAB7nomxmqlAdoBg+WegvgVAwaBElK+sqom9GuUcSQOy9Z4qL+OXCBwf3t/dzwtQA4oH1g/mKKXA4fNHg+JyGBccRSXyQS55r2h04ALlRIOQWTLV2lfxoB8nQZC7jWEy3Fqee1YigNy4B7WAdOSMfAvY0cvzVMvE1Ei1/y+lzJ2Kbp0uNKGc/8UflYwK69YTohxWUWjbEokydN5UC4o0KfUOnaYq0j7sq1mIen6O/0i65MYOnaQq6KqTt7wauRebd489cY9eAu5pMCAd6UvE6DVCqlgfpgTjld6mndhRa2i2ZseG+wcurOYxzrSD89nN4Va9t9YRin/SA/Si8cd50I+BAG+tD6M6pVQjs/MeNwm+CrdPxXy6Nip9vV6LPu6ZB9JU4fpnT/03nd2geqhHtP75YRl0zM0cLI7Zi1cIyYLFizEsOXxRBezy7qSHd33tCrFZ5YPcqHJOhncTcOJQCV6RG2UmA1ju6nkFbqB/v4vQH/oHVuViRXfPa7clJ/tq6+jnoJjEQ4PmuDfKXymNKpxBRWgOXJ3BgJJBWN9AcPls9nro+ayP94QdQBulHprN8TdessfE00rt6gc7ei0HlGKNNGziKrcDLzuWMw+62k8mxJrwIDo33XpG2heo7XfzBazB+0g2SASP6gVQq1+QR+QjeWNth36xhAu
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6qd100q4NAFbNZNlM3vQbKWDqe+OYT8UlUEH2oSL4ICFafKOHlLaAZwtW4xSwGfx3trixi0/rZtnKsZXqXRtgWFFoc0GqugMxl9KnBXRiE6lvuDpJpiS2mdB3qJ9Yq7bVxRXnJtlBBgCvxVw9GVsnIpVeI7CY0hq7hfC5vtSG5Xy3Bzl/j3luyE9BAPOTH3dZ7NO/V8qJv7pX0vLbq4AXCveKDytfdH/VaKGXa9ln6omX9ox+G69Lhyuy4Pm29AG6q41SQmoK5rPm/xcfj1lMoWENqGSwkOo3jNm4+Ap8w7wpL6ZFHIautwaDmB0zVlOKXjL4fm52MIMIQp/oHiwcCjeaEchvBasWzbL7Mm9NN70pqJoGH6xbTJ5laYEqXXUDR+c5DubSVyr5OMQLKR2bQMTB3O7SZKiod90zuV8shgrihwf4yQxHBXd83Q2qQVLZZjqh7jL/3n8bV5X1R3u8rgDidsFoC2UprqrJXlvq2kvZZtLXtkPppDEi/4NtLMUr/HCdm+fHAlUULQqj5xcrm8wNyZC57oSiBCIGUaBrwz1sSoWFRd1UG7pydwWJdKwWqiyNivkuUgMmw0cba7a5WWXMYfP/tYJhFkmzHxB3+NzvrHX6/F3G9RmQqvpHQ7ywJNA0N899JuwMsXUDdhMQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9GYW80b2gzNjYwUkdiQzExS0ZWM0JTb0dTbEFXUDNnemVXcm5SVXNzNzdh?=
 =?utf-8?B?eGNZRnVKN093SDF1NC9pUVNYeExRNDNXSCtHMGlVK3hMVEpGaGNvNWZuZTJz?=
 =?utf-8?B?M3ozdllJV2p1NmlPL01NMHpZUVlWWVptTzFHSW01eFBqcGlQL1dDQXpwdHpz?=
 =?utf-8?B?b1hGdktHT3BwczlHR3NycDhYdHR6VGdWNlFkaEl5RjQ1ditpaHF3QVU0b0tO?=
 =?utf-8?B?WmUvY244dlloOE5Zb2hnMFkrTFUvaC83Ryt3YkFIZDRCVmlVaXl6cXhVYnZo?=
 =?utf-8?B?blgwTzFmZm5rMFNUeDA2MTA4WFdjRmNsak1ibjV2UXI4UzFBcE0wK0twdmRv?=
 =?utf-8?B?QWVwN01tWnJLeWJ0ODgxTStEb1hyMjFLRHNVYWxhck1CZ0t1U08vRW0reUtL?=
 =?utf-8?B?NjgzbGJPL3RxUFlsc0xZUXVKZ1RaRkp2QzhaQVhrdDZLT3hsdnZuWitxd2Vm?=
 =?utf-8?B?dVNVUCtpSkdXdWszdS9haGtWeWRDb0x5YkxJUGM5eFhjTmN0OGk0dXk2L3Vy?=
 =?utf-8?B?eG12Vml1WVpsOHE2ZDJQZjRuNy9oeFZ5MzJqeDRmZ0lmT1FTT3F6ZDFDdXhV?=
 =?utf-8?B?aXJJdXRpYXJ5c250L0FESEV3Y2NQUzJJZ1FDeXB2SHhoNVo0dWtCVlRFdkNi?=
 =?utf-8?B?b0IxQlNCcjZiUnJESXRmWW1MSU96dUFNc25QeFd0d1VYWmRuMW9WVzZiQTVn?=
 =?utf-8?B?dFMwWFE2ODJRS1FVbkVWMW5mUW1ZMEVZVUt1Uis1cTE4d1NMbHBCNVNHSDB4?=
 =?utf-8?B?dm8vZ1NQazNrekwvZVVuWFBXSVRsV09xVXRFYk1sNUlkeFJka0VGN1dibC9G?=
 =?utf-8?B?RHFOTWRPVjA0S0VNZE1KalUzTDNtZU45azRWMzBZVXZZRWFZVWRSWW95UkI5?=
 =?utf-8?B?OGEzY3AwWlhJSWpWL08vT2I2WGtFMkduV3VNVHdNMmRnYTkvWUZSVXZnVFhC?=
 =?utf-8?B?T1B6Z1BKazNqVnRlKzFVZDcvK1BIWFRqVVZ2NXQ3OTlyMFhNZmdQNDZBQzdt?=
 =?utf-8?B?NGVOVm1vcW02NWVGak82emNIV1VNaU0wYlFVeHJIbXVqcnZ0KzJSTmE1RzhS?=
 =?utf-8?B?WlpMQXE3TXhlVVF3NlJ3clcrdmpGczVLbmY2V1BVOGltTlhYclZER2duVFBa?=
 =?utf-8?B?VHpsNFUzMGxyMHFZcWhMUGpKQzViN1BMZTI4dWhJOHpzMTQ2UEJ2Tk5rWkQr?=
 =?utf-8?B?YkxveDV1MHh4S3g4YjVRem96YllPSDNPV1E4eWdTaVQwSHg0OThwQWh0bHYy?=
 =?utf-8?B?dlV6d0U5MTE5MG93N2dsUXB2Tkg1cVV6ajQyWHFJdStpcXZlc1hYajYwTGdQ?=
 =?utf-8?B?ZDdJMHl1NGdDU1BrbEI2RDJJNkphK2JneWJITHNVUlFtYkZKd2JWRE5CK200?=
 =?utf-8?B?aWdmNVAwd05UczRqVVcyTG5NdWlmNkRlcThWUXNzcHRUMGNsQzJOWFBiVkd4?=
 =?utf-8?B?SmVBRWIyakFuUThYOFMwM3hoeVNaUGgreUFPcTcrWWFUcWptQ3FMMmhsOExp?=
 =?utf-8?B?QndlSmRoTUtscDAwYzNTcm9lVlJSSTNiVWFhbXRoYVUyU3IrTUY5RUZ2RC9y?=
 =?utf-8?B?TGFibHY4QVNub2ZSbllJS2djTm5Vc0hUcFk5T0o2eFp5YWZIamoyQW9lU2I3?=
 =?utf-8?B?M3Zlc3lJTGQwdWw0VnAyVTlZT294VFE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6a124f-47a9-42fb-cb4c-08db7034647e
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 19:44:13.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1953
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--------------NqEqEmUIeuqgg5IOBvOik04B
Content-Type: multipart/mixed; boundary="------------bJs0ZA4BZb16CVA5wGAny5Mo";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Stefan Wahren <stefan.wahren@i2se.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: wiagn233@outlook.com, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
 Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Lukas Wunner <lukas@wunner.de>,
 linux-rpi-kernel@lists.infradead.org
Message-ID: <43f9ed81-a35b-d408-5a51-131f3ca2d41b@outlook.com>
Subject: Re: [PATCH RFC 00/11] dmaengine: bcm2835: add BCM2711 40-bit DMA
 support
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>

--------------bJs0ZA4BZb16CVA5wGAny5Mo
Content-Type: multipart/mixed; boundary="------------HfV0zE6rI4jem7CuRTBWskF8"

--------------HfV0zE6rI4jem7CuRTBWskF8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8gU3RlZmFuLA0KDQpTb3JyeSB0byByZXBseSB0byB0aGlzIG9sZCBzZXJpZXMsIGJ1
dCBJIHdvbmRlciB3aGF0IGhhcHBlbnMgdG8gdGhpcyANCnNlcmllcz8NCg0KQmVzdCByZWdh
cmRzLA0KDQpTaGVuZ3l1DQoNCj4gVGhlIEJDTTI3MTEgaGFzIDQgRE1BIGNoYW5uZWxzIHdp
dGggYSA0MC1iaXQgYWRkcmVzcyByYW5nZSwgYWxsb3dpbmcgdGhlbQ0KPiB0byBhY2Nlc3Mg
dGhlIGZ1bGwgNEdCIG9mIG1lbW9yeSBvbiBhIFBpIDQuIFRoaXMgcGF0Y2ggc2VyaWVzIHNl
cnZlcyBhcyBhDQo+IGJhc2lzIGZvciBhIGRpc2N1c3Npb24gKGp1c3QgY29tcGlsZSB0ZXN0
ZWQsIHNvIGRvbid0IGV4cGVjdCBhbnl0aGluZyB3b3JraW5nKQ0KPiB3aGljaCBpbmNsdWRl
IHRoZSBmb2xsb3dpbmcgcG9pbnRzOg0KPg0KPiAqIGNvcnJlY3QgRFQgYmluZGluZyBhbmQg
cmVwcmVzZW50YXRpb24gZm9yIEJDTTI3MTENCj4NCj4gQWNjb3JkaW5nIHRvIHRoZSB2ZW5k
b3IgRFRTIFsxXSB0aGUgNCBETUEgY2hhbm5lbHMgYXJlIGNvbm5lY3RlZCB0byBTQ0IuDQo+
IEknbSBub3Qgc3VyZSBob3cgdGhpcyBpcyBwcm9wZXJseSBhZGFwdGVkIHRvIHRoZSBtYWlu
bGluZSBEVC4NCj4NCj4gKiBnZW5lcmFsIGltcGxlbWVudGF0aW9uIGFwcHJvYWNoDQo+DQo+
IFRoZSB2ZW5kb3IgYXBwcm9hY2ggbWFwcGVkIGFsbCB0aGUgQkNNMjgzNSBjb250cm9sIGJs
b2NrIGJpdHMgdG8gdGhlIEJDTTI3MTENCj4gbGF5b3V0IGFuZCB0aGUgcmVzdCBvZiB0aGUg
ZGlmZmVyZW5jZXMgYXJlIGhhbmRsZWQgYnkgYSBsb3Qgb2YgaXNfNDBiaXRfY2hhbm5lbA0K
PiBjb25kaXRpb25zLiBBbiBhZHZhbnRhZ2Ugb2YgdGhpcyBpcyB0aGUgc21hbGwgYW1vdW50
IG9mIGNoYW5nZXMgdG8gdGhlIGRyaXZlci4NCj4gQnV0IG9uIHRoZSBkb3duIHNpZGUgdGhl
IGNvZGUgaXMgbm93IG11Y2ggaGFyZGVyIHRvIHVuZGVyc3RhbmQgYW5kIG1haW50YWluLg0K
Pg0KPiBUaGlzIHNlcmllcyB0cmllcyB0byBpbXBsZW1lbnQgdGhpcyBmZWF0dXJlIGluIGEg
bW9yZSBjbGVhbmVyIHdheQ0KPiB3aGlsZSBrZWVwaW5nIGl0IGluIHRoZSBiY20yODM1LWRt
YSBkcml2ZXIuIEJlZm9yZSB0aGlzIHNlcmllcyB0aGUgZHJpdmVyDQo+IGhhcyB+IDEwMDAg
bGluZXMgYW5kIGFmdGVyIHRoYXQgfiAxNTAwIGxpbmVzLg0KPg0KPiBTbyB0aGUgcXVlc3Rp
b24gaXMgdGhpcyBhcHByb2FjaCBhY2NlcHRhYmxlPw0KPg0KPiBQYXRjaGVzIDEgLSAzIGFy
ZSBqdXN0IGNsZWFuLXVwcy4NCj4NCj4gRGlzY2xhaW1lcjogbXkga25vd2xlZGdlIGFib3V0
IHRoZSBETUEgY29udHJvbGxlciBpcyB2ZXJ5IGxpbWl0ZWQNCj4NCj4gTW9yZSBpbmZvcm1h
dGlvbjoNCj4NCj4gaHR0cHM6Ly9kYXRhc2hlZXRzLnJhc3BiZXJyeXBpLmNvbS9iY20yNzEx
L2JjbTI3MTEtcGVyaXBoZXJhbHMucGRmDQo+DQo+IFsxXSAtIGh0dHBzOi8vZ2l0aHViLmNv
bS9yYXNwYmVycnlwaS9saW51eC9ibG9iLzU2MWRlZmZjZjQ3MWJhMGY3YmQ0ODU0MWQwNmE3
OWQ1YWEzOGQyOTcvYXJjaC9hcm0vYm9vdC9kdHMvYmNtMjcxMS1ycGktZHMuZHRzaSNMNDcN
Cj4gWzJdIC0gaHR0cHM6Ly9naXRodWIuY29tL3Jhc3BiZXJyeXBpL2xpbnV4L2NvbW1pdC80
NDM2NGJkMTQwYjBiYzkxODdjODgxZmJkYzRlZTM1ODk2MTA1OWQ1DQo+DQo+IFN0ZWZhbiBX
YWhyZW4gKDExKToNCj4gICAgQVJNOiBkdHM6IGJjbTI4M3g6IFVwZGF0ZSBETUEgbm9kZSBu
YW1lIHBlciBEVCBzY2hlbWENCj4gICAgZHQtYmluZGluZ3M6IGRtYTogQ29udmVydCBicmNt
LGJjbTI4MzUtZG1hIHRvIGpzb24tc2NoZW1hDQo+ICAgIGRtYWVuZ2luZTogYmNtMjgzNTog
U3VwcG9ydCBjb21tb24gZG1hLWNoYW5uZWwtbWFzaw0KPiAgICBkbWFlbmdpbmU6IGJjbTI4
MzU6IG1vdmUgQ0IgaW5mbyBnZW5lcmF0aW9uIGludG8gc2VwYXJhdGUgZnVuY3Rpb24NCj4g
ICAgZG1hZW5naW5lOiBiY20yODM1OiBtb3ZlIENCIGZpbmFsIGV4dHJhIGluZm8gZ2VuZXJh
dGlvbiBpbnRvIGZ1bmN0aW9uDQo+ICAgIGRtYWVuZ2luZTogYmNtMjgzNTogbWFrZSBhZGRy
ZXNzIGluY3JlbWVudCBwbGF0Zm9ybSBpbmRlcGVuZGVudA0KPiAgICBkbWFlbmdpbmU6IGJj
bTIzODU6IGRyb3AgaW5mbyBwYXJhbWV0ZXJzDQo+ICAgIGRtYWVuZ2luZTogYmNtMjgzNTog
cGFzcyBkbWFfY2hhbiB0byBnZW5lcmljIGZ1bmN0aW9ucw0KPiAgICBkbWFlbmdpbmU6IGJj
bTI4MzU6IGludHJvZHVjZSBtdWx0aSBwbGF0Zm9ybSBzdXBwb3J0DQo+ICAgIGRtYWVuZ2lu
ZTogYmNtMjgzNTogYWRkIEJDTTI3MTEgNDAtYml0IERNQSBzdXBwb3J0DQo+ICAgIEFSTTog
ZHRzOiBiY20yNzExOiBhZGQgYmNtMjcxMS1kbWEgbm9kZQ0KPg0KPiAgIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2RtYS9icmNtLGJjbTI4MzUtZG1hLnR4dCAgIHwgIDgzIC0tLQ0KPiAg
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9icmNtLGJjbTI4MzUtZG1hLnlhbWwgIHwg
MTA3ICsrKw0KPiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTI3MTEuZHRzaSAgICAgICAgICAg
ICAgICAgICAgIHwgIDE4ICstDQo+ICAgYXJjaC9hcm0vYm9vdC9kdHMvYmNtMjgzNS1jb21t
b24uZHRzaSAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gICBkcml2ZXJzL2RtYS9iY20yODM1
LWRtYS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDc0NSArKysrKysrKysrKysrKysr
Ky0tLS0NCj4gICA1IGZpbGVzIGNoYW5nZWQsIDczNCBpbnNlcnRpb25zKCspLCAyMjEgZGVs
ZXRpb25zKC0pDQo+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kbWEvYnJjbSxiY20yODM1LWRtYS50eHQNCj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9icmNtLGJj
bTI4MzUtZG1hLnlhbWwNCj4NCg==
--------------HfV0zE6rI4jem7CuRTBWskF8
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------HfV0zE6rI4jem7CuRTBWskF8--

--------------bJs0ZA4BZb16CVA5wGAny5Mo--

--------------NqEqEmUIeuqgg5IOBvOik04B
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmSPXn8ACgkQX75KBAfJ
sRnVqxAAm6vfYZXkQ+hNQvVSe0FSMaY6onsDuC/9d4uB2sByNl/TfHXg+hZ4i9yD
u9O1u1r2/l5HPFPmJUXwL3dq/BX79UaYv9uyH9KaqpxoKdQOr6rbulYOJZz4pC56
V87+Ww93yTNpLyHf7dkiMJIxntb3Pd4H1n58mlePIg1v7mBt26Q1DtSKViZ7CTAo
HmPA9Am/j5Utsh24B69ICGAAGIjSmYKK0dsOIXTCbDn9PJVS3BJ7TRk3JqBQKtxl
FsvvekDBEaf/3ipCWhEd6PiCSXecftoaE7tPEe6dxl1MhqmsbE/focEJ8IplUwOz
ZTM4EvE/v/6uQTbPTAUheFmTZa+WtksQHAmvdD5xS462tf3phQ57TdIk83gd5of2
uYjcQ3+IQIiIpvof1RkiWU21nAr3hl62c6qayf+D1DsuJWaLQqp9hZLvbzZrQMT/
A6qNblA+eCYb5D3cCO2ctscnznnEIEk0xjwTY8WDycguKTL3Q+2EqHnF16HfyfOQ
J55mFxZKiKy1cBmuB33w1WuqjmdYomCevj2/j3q3/93JIRmT+KKRgTyGsEDmXadg
OhCjjxYQX5/OOUDJUKfecjw5KnCLfloPPLBbi9wI0fuJzh7gNk3VnJSGPMvZg1W4
nYu1nWF55YUouvppoDkahEzf7LMN16YDwyig5QGlOV662GCSrbQ=
=wC5X
-----END PGP SIGNATURE-----

--------------NqEqEmUIeuqgg5IOBvOik04B--
