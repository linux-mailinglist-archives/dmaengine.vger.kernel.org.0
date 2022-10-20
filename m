Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347AB60585C
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 09:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJTHYP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 03:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJTHYN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 03:24:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D7215ECC1;
        Thu, 20 Oct 2022 00:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666250653; x=1697786653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lcY+6lhKWoFMKuE0EiNm+GRDj3bSrWO5DJ7mfWHiZPM=;
  b=l6Zff11PsDBjrJ6G8fs+U/4gnk2dqN6iTvCWYabADn5L3G0OABjtjX9I
   0IDIvWTkIeq5C2sJsKQwGNoBPCLY+gah0y76sSOj1k+Su47CrAeeM5Ud7
   gGfh4+4P6Ydu9hCMLHg2uuju6sT9jMe/Eqe8b1r2niDYdhaZSKrRVxI+2
   DCLC5Ua9z/cIV0xDxDprlxic4365suEBQf9F/sZ+F8l0nQFW+E3P8mFFA
   WGfc3wrOJ8BokWpd51Kj7rmoQl5bnJgGM3B9KZkwd9EOPUrq++4cc8Qee
   pzT1B27rTRhVMh1m1cbRx0gqD6FR4Ftmyf5A+ps0Zzw61kG3PdMSeVscI
   g==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="179693769"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2022 00:24:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 20 Oct 2022 00:24:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 20 Oct 2022 00:24:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pqs0rav3yxaI2U77pfZTd0pdSFwyT6THp4FZ6GslMCbuRCFtFs/1tvxoi8MhInsGBf2cQg41pzghIBog20u4nbO41fnAFVvanbwXrEozbfS/ApEmAME8bBgicOsG7fuYjx5Fk1nXQIv2pnYc66YE2ksB0pUlwSmA8ViP/nHquhHeMqaJ7hzAGqN/IApmDxijXTaLgETaJ5lKCeRyM3qGyiD9Q6VIOa/tcBdUXgv8Y/+5YaBRfp87rsBcgAeokl+G2jg20+bwaJ4DGKHHSPecoXFDpjCUZ8d+8b5xLlweeT6L5ZVVf3j+3cHNVsfnIkug249JDZihTFSvQRcKn6PlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcY+6lhKWoFMKuE0EiNm+GRDj3bSrWO5DJ7mfWHiZPM=;
 b=aivfPfMi2Qk5NOumaJHdktlJcS/uYmnb/efn8kIJ6aFhYtc/AYSqaXCoI9WD9tyci+3H/wJMCLOcybNISRx8M5I2T16hT4knhKJLrIz43luOnpxLXZx4dhVQoZsdVvHIE/roT5JzIUnE/kpnyKJAPGxDHNuO63Ohhu5tw5oPXEZKqmJlx/F7GPcO+GSQaFpq8qqu241+pMMBvYp6cCQBTXjQbyJ0khRfMvZKUi+KtjJwTCBugP827CR6kA5A5c+stJwCs+8LKVPumcWADlwDGzr85Ec0JEdq1eaws5fIYwQgkEzQba/ojLAj1k3Lhs4QkwGMV/uWg+jK9dT2zr+1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcY+6lhKWoFMKuE0EiNm+GRDj3bSrWO5DJ7mfWHiZPM=;
 b=hMYF/e+EDUoSZ2csCbOyPPOq/7gQUSMicraud586R0NsWU90WCplwyRYuqRqT1iiXWeCp+MLNEEreGAkuCtew1JLYVkOCf+dfDLQywJHO5yaWEdOmLot+rSbB8kfkG9B+owuZc3Ev5kX8Iv2M+g27RdiZycg+iLtZmM3Ml4O/uU=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 IA1PR11MB7343.namprd11.prod.outlook.com (2603:10b6:208:424::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 07:24:03 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::cf13:1785:f79d:9eb9]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::cf13:1785:f79d:9eb9%7]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 07:24:03 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <peda@axentia.se>, <du@axentia.se>, <regressions@leemhuis.info>,
        <Ludovic.Desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <dan.j.williams@intel.com>, <Nicolas.Ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 28/33] dmaengine: at_hdmac: Use devm_request_irq()
Thread-Topic: [PATCH 28/33] dmaengine: at_hdmac: Use devm_request_irq()
Thread-Index: AQHY5FTtS51J5v3KG0ym94wpt/4W1g==
Date:   Thu, 20 Oct 2022 07:24:03 +0000
Message-ID: <7d22c3c3-fb39-4b53-e306-acd8f1a0e648@microchip.com>
References: <20220820125717.588722-1-tudor.ambarus@microchip.com>
 <20220820125717.588722-29-tudor.ambarus@microchip.com>
 <Y1Aqfk9iusj51YzJ@matsya>
In-Reply-To: <Y1Aqfk9iusj51YzJ@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|IA1PR11MB7343:EE_
x-ms-office365-filtering-correlation-id: 78ae9925-316f-4d25-4116-08dab26c10c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pT+4sLZjZVkZNd0uQCY1sxjq8Mz6NQ13mcFg9RuttWnaZYqtYVXhTlymtLLJ4wkViIpP2Yz9RMBfi8e98a6k3kYq264qXC3d5g7MUen/J0ngylABo9t3KH85+xT54WcA0WewfjSsvRDHry1KQRdZ9g7KJwTs8LlDypKuZB4si+Eiy9nM0T4Y9B1R8Ank6vpNjTnOVeTYcLKs40dPBEvISSAapizcVjJJ0V9or/iqcK0ICh1xsV/Bnyjr20K8qlaEmOoFQhCQ9n9JM+8fj7cBGGjuOrzvitFVR2QVNJElth9pbv/+XSd4XpfBkAzMtbOSAdmwc4mpCPo7mdW3DENK7XcDH+XiYdFVp8Q7NMXEnia4kVcLBHT1Wks7PZe5z2bnBIPNatSBq09QgdN0E0nlhrnTcdrvePmP2+F28Z0PwyPT5IS0Zj4pVP1atTZs4nfjXUe9shPtQzgjYx3SXN1lI3Wm0ENpOR6zdiLilVzWPfGl4yRhVc8eVB2jukXXEfAn4l/gsPWcuav7IOMLnLBYhNPIcIV1FWLyq4MIHVe2N3FDczZwdUG8S2lfDphLFjKG3frgQlfswbvJAPe4T4eJC8Sih0WmjdYKVuwkwUg+z7aF7BGVfJT3AMup5LBJC8V8VfOsT5Th/Co1qXj5UayM3yOml82nciQiptTEeOtAFqc2gVuMYtXYvFgdDHRD5FgNxqCwjTmZXgKDkU8VB+cRq+eSOVXBxc1a2/IzGSX9Toa8zkzgypiC84gdsqYzsPAigXwdqALlZQvpHVwaR3YQiownz87GxM9RydQD7nnWEuCKF71jjBdeLzwULW3PGMyXN7YaRyLw3qC5F7I1kRa8Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(478600001)(31686004)(6486002)(66556008)(64756008)(66446008)(7416002)(26005)(5660300002)(6512007)(41300700001)(2906002)(8676002)(83380400001)(76116006)(4326008)(91956017)(38070700005)(71200400001)(66946007)(36756003)(8936002)(316002)(53546011)(2616005)(54906003)(38100700002)(31696002)(66476007)(186003)(6506007)(86362001)(6916009)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3NtV3BIL1RDWkZ4djhQZXF4Qms2TlJ6eTNnZU1HZG5ud0JhRWpDWDFMQys0?=
 =?utf-8?B?UVZFMzd3alhobDhoRUpJd0p4U0JwazNWZ0dHaVJkelpyMklGcVVPVlNoOC8w?=
 =?utf-8?B?SW5pUlRNT21SeFdtVFNTRTF1U1R5d3lORFFWRzF6akY0UU1ST09JdWVhVFNV?=
 =?utf-8?B?anRud01URmVWWmlGTS9PbEUvbFI4ZS9pZjdIbkd6bjhUTEhXNG1ONU5xSkNl?=
 =?utf-8?B?ZTB0NnU3M2FDWndtcHF2SVI3WDBHKzRsb1BsZm1BcWEveEVNcHAxaVBISzVE?=
 =?utf-8?B?aUF5bit6KzdPLzNCNmViR3dhVlF1SXVsR2FBTVhrcG5UU3NIcTVBbFdIdGxG?=
 =?utf-8?B?NGcrcmZKdnVHVGFhT1IzTjF5bjM3OGFUclhmRE40cXBJZXQ4RjB0ejNjZlQv?=
 =?utf-8?B?ZnQrRWdDZEZKbTNSbkl3eVlMN1FIVUszNWhhTzM0cGlHNDVER0JRSmpoNVBs?=
 =?utf-8?B?bE44MWVWRXBUWnA4eHZQSzRMdzgvS1J5SE1ZWmxBeU1kSDJwWlFVTWlzR213?=
 =?utf-8?B?aEtWTW5Mb0ZPSkZkRzVOdE8rRXlPalZQSGFhbnQyN2JtcVRqKy9MOGFqcisw?=
 =?utf-8?B?SmxCdEd3Z25US2xVeEVXc1NRdGlKanV5a0RkeXpiQkppVlMyVG5YRGEzN2NR?=
 =?utf-8?B?aUdWZEVQU0FXQ2JKSnN6a0Z0clNlRWxJdnZQbUx3TFNzT0tST2FkRDBHRm9Z?=
 =?utf-8?B?OWlaaXM3S2lqbE9oWHd0MjIybEpqVFMva1ozWEx5L0RtaGxyQ3FSNmk1U0RT?=
 =?utf-8?B?UHFhQUxocWtVMGlsVlVrTjFPbVFtS1dXWnlyK2h0UGd3NlNtYXh1UGZ0ckRq?=
 =?utf-8?B?MzFpOEcwYW13QjBaaW5yUThXQjJxck8xMkVhYklLZFhlV3FNZU1QRXk4VEY5?=
 =?utf-8?B?TmFKQThDeURkWnZnSTdSSmROcG5HS01JQUxienJFblFhREM3VUYwR3dpOGRo?=
 =?utf-8?B?K0ZTdTc4bTJHdnRoNVY1TERTT3p0Z0Q0ajhmUGMwVUFSSXV0LzM2Y1F6Ym93?=
 =?utf-8?B?Q2M4TDllcmd2WXNIL1orZk5oa1M5MVRLV0V1RXBlZGEzWmZqRXFiYWFocHg5?=
 =?utf-8?B?enFydFliU2FtTXduVi9yWUs1SHdQVVR3TjJ6RExFd0dZRGVXMjljVExSNm5W?=
 =?utf-8?B?ZnVpOWRLMnhydmIrekhFeDdTSmpzdlh3cFFGMVpMSTdpc3R5enNzVm03dDJS?=
 =?utf-8?B?aXBrMEQvVVlJS29EV1lYOG5rN05QM1pzblJGTjl2WDhha1ZoQUsvNWplYk9Z?=
 =?utf-8?B?djA2ekNkbmdhTmh1OVlSbFZmUkFNQitUNFE1ajBWTE1ybzRtRFNVZ1NXNkMv?=
 =?utf-8?B?WVRNaWVER3lIampnbWpUeGIxQW5rQjRxS1Z3czV1eXdpRmdBaElyNE55YmVn?=
 =?utf-8?B?RG82UE5Xa29mZ1M1dG1ZL0VZK0VIV2lUZmJ6b0pVZFFGSVVPSlR0Zy94UytC?=
 =?utf-8?B?cE94TmErZzJBcmc3QU5OTDhyYjRDSHh1cnZkd1h3NFpMOFJyNUxndjVWc0lp?=
 =?utf-8?B?b3UraHNRVW83ZGFONWdKL0RveGJ6dU8rL2cyUjZjRmU5OTMzZmI2UVVyY0tj?=
 =?utf-8?B?Sy9nMG50dEtGbkFzL2x2VkpBbDRTcTFuQjRqN0dEa240c21NZ2tnWUdxa0sx?=
 =?utf-8?B?NkIxM2RwVkhPMlZtdm4xaXNHQ2NBa25mcmo2STQwWHJUbmNqNWFqTHpCRFk3?=
 =?utf-8?B?NkZTRk1QUVA1K3U0WUorZktGRWZFMFZIWGFJTWR6aU5FV0NHQXhKaDRxNTZ0?=
 =?utf-8?B?WUVMOUQycnpvaktFNjhIb3RkYllNbTNpb21Idy91N252dCsvcURMMk4wOFQ4?=
 =?utf-8?B?M3RFOGlWTFJWNUl1TWNyOWJtd3pUdWs4S3gzYUlJTUNkcEFDUmxndU1iOTNB?=
 =?utf-8?B?RW1mdzdXQzZ6b0tHNUU2ZWFmMXpiSDJMSVg0WVNWSFZCTzhoVldUR1Nsdnc2?=
 =?utf-8?B?akdjUUdueFZCcHI2RlMzeGQwcTR2eUhFVlEwTS91UEpyQmRpLy9BcHRzUEtC?=
 =?utf-8?B?eFdpbHZBQVJnRFAvcm1wQU9aVlpLWG5pQUlMWlFUbzlTRXM2WEYzLzJaa0s2?=
 =?utf-8?B?ZCs2VVlxTUhncnFmUCtYU0d6TW45M0RjWmV3VDIzZ2tQSWFBZllTSmJEL0Yy?=
 =?utf-8?Q?2LJX9JloIWxCJaVN06LlLrfGs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C722A7E8DD764044994DCC11D58B0B23@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ae9925-316f-4d25-4116-08dab26c10c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 07:24:03.3477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GpjasZ3RS6zzuQlJb72EefewxodTE7tGpvcn8iwaXvnBwGEovYEO/OJ8griHwDpUbucdGnu5M7kDP1B+/0nuUpdVB+aW0ubR9QNQHcsBuCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7343
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTAvMTkvMjIgMTk6NDksIFZpbm9kIEtvdWwgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjAtMDgtMjIsIDE1OjU3LCBUdWRvciBBbWJhcnVz
IHdyb3RlOg0KPj4gSVJRcyByZXF1ZXN0ZWQgd2l0aCB0aGlzIGZ1bmN0aW9uIHdpbGwgYmUgYXV0
b21hdGljYWxseSBmcmVlZCBvbiBkcml2ZXINCj4+IGRldGFjaC4gVXNlIGRldm1fcmVxdWVzdF9p
cnEoKSBhbmQgbWFrZSB0aGUgY29kZSBjbGVhbmVyLg0KPiANCj4gVGhhdCBpcyBub3QgcmVhbGx5
IGdvb2QgaWRlYSENCj4gDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVk
b3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9kbWEvYXRfaGRt
YWMuYyB8IDExICsrKystLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvYXRfaGRt
YWMuYyBiL2RyaXZlcnMvZG1hL2F0X2hkbWFjLmMNCj4+IGluZGV4IDljNDE0ZjE2N2I2Mi4uOTZi
ODg1ZjgzMzc0IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9kbWEvYXRfaGRtYWMuYw0KPj4gKysr
IGIvZHJpdmVycy9kbWEvYXRfaGRtYWMuYw0KPj4gQEAgLTIyNDEsNiArMjI0MSwxMCBAQCBzdGF0
aWMgaW50IF9faW5pdCBhdF9kbWFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4+ICAgICAgIGlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+PiAgICAgICBpZiAo
aXJxIDwgMCkNCj4+ICAgICAgICAgICAgICAgcmV0dXJuIGlycTsNCj4+ICsgICAgIGVyciA9IGRl
dm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgaXJxLCBhdF9kbWFfaW50ZXJydXB0LCAwLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfbmFtZSgmcGRldi0+ZGV2KSwgYXRkbWEp
Ow0KPj4gKyAgICAgaWYgKGVycikNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4+DQo+
PiAgICAgICAvKiBkaXNjb3ZlciB0cmFuc2FjdGlvbiBjYXBhYmlsaXRpZXMgKi8NCj4+ICAgICAg
IGF0ZG1hLT5kbWFfZGV2aWNlLmNhcF9tYXNrID0gcGxhdF9kYXQtPmNhcF9tYXNrOw0KPj4gQEAg
LTIyNTcsMTAgKzIyNjEsNiBAQCBzdGF0aWMgaW50IF9faW5pdCBhdF9kbWFfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgICAgIC8qIGZvcmNlIGRtYSBvZmYsIGp1c3Qg
aW4gY2FzZSAqLw0KPj4gICAgICAgYXRfZG1hX29mZihhdGRtYSk7DQo+Pg0KPj4gLSAgICAgZXJy
ID0gcmVxdWVzdF9pcnEoaXJxLCBhdF9kbWFfaW50ZXJydXB0LCAwLCAiYXRfaGRtYWMiLCBhdGRt
YSk7DQo+PiAtICAgICBpZiAoZXJyKQ0KPj4gLSAgICAgICAgICAgICBnb3RvIGVycl9pcnE7DQo+
IA0KPiBoZXJlIHlvdSBhcmUgcmVhZHkgdG8gcmVjZWl2ZSB0aGUgaXJxLCBidXQgbm93IHlvdSBt
b3ZlZCBpdCBlYXJseSBvbi4uDQo+IGl0IG1heSBjYXVzZSBpc3N1ZXMuLg0KDQpPaCwgeWVzLg0K
DQo+IA0KPj4gLQ0KPj4gICAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgYXRkbWEpOw0K
Pj4NCj4+ICAgICAgIC8qIGNyZWF0ZSBhIHBvb2wgb2YgY29uc2lzdGVudCBtZW1vcnkgYmxvY2tz
IGZvciBoYXJkd2FyZSBkZXNjcmlwdG9ycyAqLw0KPj4gQEAgLTIzNzcsOCArMjM3Nyw2IEBAIHN0
YXRpYyBpbnQgX19pbml0IGF0X2RtYV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPj4gIGVycl9tZW1zZXRfcG9vbF9jcmVhdGU6DQo+PiAgICAgICBkbWFfcG9vbF9kZXN0cm95
KGF0ZG1hLT5kbWFfZGVzY19wb29sKTsNCj4+ICBlcnJfZGVzY19wb29sX2NyZWF0ZToNCj4+IC0g
ICAgIGZyZWVfaXJxKHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCksIGF0ZG1hKTsNCj4+IC1lcnJf
aXJxOg0KPj4gICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGF0ZG1hLT5jbGspOw0KPj4gIGVy
cl9jbGtfcHJlcGFyZToNCj4+ICAgICAgIGNsa19wdXQoYXRkbWEtPmNsayk7DQo+PiBAQCAtMjM5
Nyw3ICsyMzk1LDYgQEAgc3RhdGljIGludCBhdF9kbWFfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+Pg0KPj4gICAgICAgZG1hX3Bvb2xfZGVzdHJveShhdGRtYS0+bWVtc2V0
X3Bvb2wpOw0KPj4gICAgICAgZG1hX3Bvb2xfZGVzdHJveShhdGRtYS0+ZG1hX2Rlc2NfcG9vbCk7
DQo+PiAtICAgICBmcmVlX2lycShwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApLCBhdGRtYSk7DQo+
IA0KPiBOb3cgd2UgaGF2ZSBhbiBhY3RpdmUgaXJxIHdoaWxlIHdlIGFyZSB1bnJvbGxpbmcgZGV2
aWNlLCB3aGljaCBjYW4gYmUNCj4gZmlyZWQgYW5kIGNhdXNlIHRhc2tsZXQgdG8gYWxzbyBnZXQg
c2NoZWR1bGVkLi4uDQo+IA0KPiBZb3UgbmVlZCB0byBtYWtlIHN1cmUgbm93IGlycSBjYW50IGZp
cmUgaGVyZSBhbmQgdGFza2xldCBpcyBraWxsZWQuLg0KDQpyaWdodCwgSSBzaG91bGQgaGF2ZSBk
aXNhYmxlZCB0aGUgaXJxIGhlcmUgYW5kIEkgbWlzc2VkIGl0LiBUaGFua3MsIHdpbGwNCnJlc3Bp
bi4NCg0KPiANCj4+DQo+PiAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoY2hhbiwgX2No
YW4sICZhdGRtYS0+ZG1hX2RldmljZS5jaGFubmVscywNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICBkZXZpY2Vfbm9kZSkgew0KPj4gLS0NCj4+IDIuMjUuMQ0KPiANCj4gLS0NCj4gflZpbm9kDQoN
Ci0tIA0KQ2hlZXJzLA0KdGENCg0K
