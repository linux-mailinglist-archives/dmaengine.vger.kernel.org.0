Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21B161EDFD
	for <lists+dmaengine@lfdr.de>; Mon,  7 Nov 2022 10:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiKGJAO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Nov 2022 04:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGJAN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Nov 2022 04:00:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FBC12AFA;
        Mon,  7 Nov 2022 01:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667811612; x=1699347612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eJRJg4dr6L1XMewhqOoQg2VFwfTUhQIjjDurN4sIL9Q=;
  b=KvCsANrYHi1qRWps0HUhXL8sYJdphZ26A8G/FEaaLL68MMMCpT2fHaV7
   lL6ggW+U2Axk9qmtrBc8pr5C5M8n1o/SokR7UzWoshzln8LwUL3DIToxz
   4iDVNAeqKiS4wDHf6h2n0svCAP/sSBFHIszoarHwKpXkCI+pMOg3t5dsu
   Td/OyMfeLFjK5AAyf5HSHOeK2P94FZ1U/zd1eeRLLhRnAy6L282pE+ix2
   lQCY0N1r6rq0+dlvMXyz2DILkmsC8zrQXhvZkTPi4pgwuF9idX+OwyHEe
   bODXHZbR8iNwARA2ux2mkLB4SCGKHSAASnI2FD3lzzKsXPkenuit7QoHz
   A==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="198685223"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2022 02:00:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 7 Nov 2022 02:00:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 7 Nov 2022 02:00:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFJEOZofiJcwSwwHr8P2Q3Ivvqjsa1Sf3r0X72vYrZJkhPZaYjS7pGRP6F7ltl1148pJ7cyZfCNm715SeJZR8piNxcsQHDnuwDlnDm/aLbemX5Aa3u26x4qHI0gxRMfJwz5+aXEJeBd3Gs7th8bAC3W+9s7yTDG0Bp9YlSt6kYA4IpZ7w4jbiOA5eC519ooMYQ7PONO6Xqf8aPF3bIQk70frh7CmsQdOGm8qGdl0j1momNxcaK2QN3J99aqAmJMldGcKdjl78PZLOMEi3jirk1f/W4ffZdQ+Zs6oJIKcFzXqKpI5G+duFc79iHwWSYZX7eneR4KcQq5QenE5+HfUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJRJg4dr6L1XMewhqOoQg2VFwfTUhQIjjDurN4sIL9Q=;
 b=ZRQoTnFMbIYfZPuJw9wo97RVf3PAVOWaGYPC+jQldIB39IKzEGL/UaDvwPIYM7xQsyarK9sa3UV5Xr0TZVVB53VofeJI4sbq/8TLaeAy7/iRPqBImLyo8BC6Cm06Foc0jM8QZVMWrlZkuGASHslblXQSkxVKArNaZXtd8cAfs7RfYB0R72bZOKJZ0ctPoarwwIDiNINo2LyupkbtUdxvjL3FgVD2HK8ZyYaB+ctme5Gxhdn2OO/fHafXdqYFFf7tVXtRCUlIHBw+gVljtpYNC6qi4N0Xc/Az06DFvkd9MbTqgiqzWab8RoLDvP1QZKsOem2tmM6B2YxNxQ5RVcUp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJRJg4dr6L1XMewhqOoQg2VFwfTUhQIjjDurN4sIL9Q=;
 b=k/hE+F9Kjprz8AI6Nz2162xEH20teS7mQMCtT0J2yUYY0W7qqs5UZEF03VahInK4z7T2qYFwVCvvOKngFfVeQ6KeJPqxVqM7UzeEbShGAL91VnUm+fejlR2tCJVcobO74dMYWcsBebeik+LEIddLE5oWr21uVllbj05+zBt4OEA=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 MN0PR11MB5962.namprd11.prod.outlook.com (2603:10b6:208:371::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 09:00:06 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 09:00:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <peda@axentia.se>, <du@axentia.se>, <maciej.sosnowski@intel.com>,
        <Nicolas.Ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 00/32] dmaengine: at_hdmac: Fix concurrency bugs and
 then convert to virt-dma
Thread-Topic: [PATCH v2 00/32] dmaengine: at_hdmac: Fix concurrency bugs and
 then convert to virt-dma
Thread-Index: AQHY8GAxL57d78lf2Ea0R6kPIjrAlw==
Date:   Mon, 7 Nov 2022 09:00:06 +0000
Message-ID: <da042959-9c87-94cc-990c-27f7d9b8ab29@microchip.com>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
 <Y2USF24O90/dLKz7@matsya>
 <d1035d5f-02f8-a98f-fbfe-bccbdfd3920b@microchip.com>
 <93048355-18a0-df4e-54ad-9c5955933109@microchip.com>
 <Y2VS6xPnTXNvNtf8@matsya> <Y2iKn5CH7IYUxwy8@matsya>
In-Reply-To: <Y2iKn5CH7IYUxwy8@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|MN0PR11MB5962:EE_
x-ms-office365-filtering-correlation-id: 00831814-ecd9-4d1c-0f2a-08dac09e7717
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+hn6xURH7oMQxllYK/fcgRbCCKNh1mMKNfuWk9HhhLUCifHhPsD/5nUMioVv0TNadpSphu9teZTH67aGkF9vKndBYRwkTw/x+A9SA8xXzL1HC5O6fIHMXh/etjtsbvRvxdkqHQCcflsfa2fIhN0nEv72FHA49CmUjtM5OoQ2KHV6iDKbCKa2I45FuEHr3PkvGzgINFBQWYPOV+PLnHkkFbwTC/gN5x+lXEV9k/Tlbtk9Xk8OV6vqaaanwYCHDnNxoAtvmYAmTn4l/TO4b0JCGkIsAW+1JrX2Gy7UQCNfne15uWsX4tVIA7uVkDF1cPJpPaXC1N7lAo1exxxb15ut9VO6CaifTmRqFMZ+duGU7j7PitpTb+R52V6kHaIXrF6WA5r7t7tG2gfrbGnAbwiIRmWUhHU59EfST8mJwWjToLjCVciec47usWsR2sTOecIKb30dHG73jUM8nj8wO8LBvOAczw7bmc4BNNG1TgYl4JsCmNIRaFlx6CN300qtiB6EOdqbSdbnAa6Zk1MgrVSS9H3Ale15wCvIJ7PgkBLacNzktWWbZ2K5ZMy7sGN1qifgfV70HVbIMkgJkZDIJ2eHvNkFbX1B4anmMKkXfAvnUdnymdMH3MgtK3uXfZQtQqzXKCNRfovMxBwesVuDfH910HYkapmJ5Rc6C1NLlR93qAwCCa8dv5fjFJ63/qHgRHsrcKqxmyuiKjOMZBFmbGND0QkpcYkjbkabYs9HalA0mkQ2O22Ag0Qxs/MMXS5YJORNynl0eb98M4eZz3P0B872kZ0RpR5oLurxmKE38u1qY9EJzcvrwFeapQPHdo9pWUKdnFyEsSwYgAbp/W0OJ7FU3HYddgnxzg5g1b8LCrJOkubdU+xznxuV5pqRyPjsyoZ8n0RP+yKWjabfahcjPHLow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199015)(84970400001)(186003)(66946007)(76116006)(66446008)(64756008)(8676002)(66556008)(316002)(66476007)(6916009)(91956017)(4326008)(54906003)(31686004)(478600001)(2906002)(966005)(6486002)(71200400001)(38100700002)(5660300002)(36756003)(8936002)(41300700001)(26005)(53546011)(86362001)(31696002)(6512007)(2616005)(6506007)(38070700005)(83380400001)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0lPdDd0WTN3akJ5aWsyeGZqY3R4Qzhld09xZHFjeUtpMFdVRlM2cDVkRkR0?=
 =?utf-8?B?Z0R6b0VQSUhpNHNZWUpXdkwyN3JtUlUzb05uTXk3cUJzRUJsakU2cEM2bHds?=
 =?utf-8?B?K2dPMWdtTFFGVTFwWTAvUjdiNStLQk50VnF0OGs5RGdXS1NLWGlKdkZWZ1NX?=
 =?utf-8?B?dEZGbERFQnY2RUI0Yi9RNHUxZ3c0WVdoMVgwTmx2RjVXL3hlSUV6bTl1bGRG?=
 =?utf-8?B?WHhleVk1ZzdwWUNMa0EydFZXbUYvNTlXUVpSZlovdmxDQXRCK1pISEJDRHN5?=
 =?utf-8?B?RERTMDBPaG1XSjF1Q2xCbVdVUHA5dEthK1FNVFBTY3RDRENRMnJmcngzc2Jo?=
 =?utf-8?B?TzFoUFpLaTh5T3lja2paWUlVdmdMTTh5SXFLeVpiUXNPRkVFYXdzWnltY09s?=
 =?utf-8?B?dUE2bW1hUkc5WTFzMDNKTmFKT0VyRzNERFEwUklKdlk2Q0FSMy9Wdi9URjAv?=
 =?utf-8?B?MkUzYnRwZW9QOXRiUk1ya2NVVzhMQnM3aWkxZmx6TmFUeDhGcjlmdE5TRFpa?=
 =?utf-8?B?Smo1M0pKMWtHeGdxVXFiZTRMWnZSUG1jcmhra0kwcCtwNGpNQnEzUzJUSnFY?=
 =?utf-8?B?SHR5aVUyb05YTzlCd0VQRHJmN0IyaDRacHhiZlBlbWJ2dW9JRVV5MGF5dzBl?=
 =?utf-8?B?eStrbksxZ1dDbnM1Rjk1NHAxM2g1TWpQd0ZpNWtMNmlRaWVCQ0RDTzdRZ0Ja?=
 =?utf-8?B?OTF3eGFIcnBhMEFPSU5Rby83OG8vWERxZTRWUzJTNU5iTGtQOWNqMm1FMy80?=
 =?utf-8?B?ZTdJWFNlb0lOdTJRL0UzM0dBbEYwaUgrU001QjNyS1RpNG5ndWlmb0k0V1dI?=
 =?utf-8?B?ZDVubkV6UU15Wlh2QXZsd0pMRlp3ZTVoUE12UXQ5b3NBVnFOWUxyU2xBemdC?=
 =?utf-8?B?M0lYOHlzaDJ0dXVBR1JxSWRNVkpiMUg4MFkycnJtN1hBV0JLMXpuNlp3K2hS?=
 =?utf-8?B?OUJHMjdKM2xuWUZmSFo4V3dzbjFReDJKUExhUnVXL2FXdWtLMm5DSkJtOHhQ?=
 =?utf-8?B?MzV0K1dGY3NsMXp5bUFaUWpRUkZVSytldWxnUGszWEpPMVROQ0JNamk2YzBi?=
 =?utf-8?B?YWlZUHN2NGJLVytENEZYZlcrbkMzS2VjOVd6ZUtkVjNoQ29lVXpvUGhqSVBZ?=
 =?utf-8?B?SXhEdk15dmtnOGZrcUpRbHZDbVZWZGR5RTBSYW5kdTZFbUloaWNQQ2V5cDlO?=
 =?utf-8?B?T3RmL3kveDlocTlKUWRvejhCbkk0YjVvMUN3K01IV01XNUZGWENycWs5UWVC?=
 =?utf-8?B?N2ZObGVWQkxjZGhhdEhoZFlmTmN3WkhuZ1ZhYThHbU1SNWJQenNzdVdwWnF6?=
 =?utf-8?B?Ynk1S09kY0pMbUdZVFhhTm00eVBFK0Qxam1yVVF1NzhJbkNTQ3VxMzNjeEVR?=
 =?utf-8?B?OUlYQUd4STlWdURWVzZsaVY2MW53Zy9Nblp4VnJwcTRmVERyZjdodmpSOEhO?=
 =?utf-8?B?NWZlZWI1K3h6dGVCTXBGZ3lKcmdSQ21EOUhOSmh5NDdVendzVmhzNnlYOElU?=
 =?utf-8?B?T2JmeWxIbkRnNGNNOHZ0NVRwdHBaMGg0YVR5TUFXMGhXSkFoVjQ1U3NvRDRr?=
 =?utf-8?B?SEJHM1FoOW9xcVpYa29WcWEwbExxbnE3L3BSUFFiaE5vU2FjMUt5Z1E4QUtY?=
 =?utf-8?B?cUJ2c3ZSa25RWG5hS3BXT1Z4a04wQXlIOW1jYVZ2Y2VUSTNjVnFOWVNrR3Ro?=
 =?utf-8?B?Z1dXb1VpWWxTQldoaDdFSm9yMHlFVktBZDliaFdva2EvWHVFYmQ3NVdKd2VS?=
 =?utf-8?B?ZWRIUG1GdlNDRWIxSFdsR1Zxai92WFROUEs3d1g5aDFRam4xWW5nTGNMam55?=
 =?utf-8?B?RWFzMWprd2pzNVIyVVd6aEZqYmYzRUh3R2VsWDdNQ0dCV2JQYkR5VnFaam1F?=
 =?utf-8?B?WlB1RXVaSnQ5bFlaTVJINEdJUUlldE1qRUpqN0tyTEc1TFlXZTRic1VlUyt6?=
 =?utf-8?B?TU4zZG9URHpIbnViUG1JU2IwK3F1YVQrbEwyd1N4Zld2MEJYTVROYlpIZUVo?=
 =?utf-8?B?cThLU05PSHRSaGsvU1M3Rkx1cm0va2tDRjVBbnhmMFNnRjZuTnQvdUdaNUpk?=
 =?utf-8?B?NTF1cUtUZjdoQzRjdDNxNXoxb1E3TFFsNVRHWjZYVExCWjNERHB6YXZKd2VW?=
 =?utf-8?Q?kzzF1X+5Af/zWPK9voej7NX4f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD6ECF53837FBA4F9FA1FFB9AAAFB380@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00831814-ecd9-4d1c-0f2a-08dac09e7717
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 09:00:06.1243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPEUApOQaAS8TOPb6mwBtZMVgVcsnfZ4SfHnQeIuzqg2d6FAWU371RwqksGsnbNAfyyfrFWv2vKJ9hhfCpCG7Jluv72ib+jUo6/yw6xLDsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5962
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTEvNy8yMiAwNjozMywgVmlub2QgS291bCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwNC0xMS0yMiwgMjM6MjksIFZpbm9kIEtvdWwgd3Jv
dGU6DQo+PiBPbiAwNC0xMS0yMiwgMTU6MjEsIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4+Pg0KPj4+Pj4NCj4+Pj4+IFRoaXMgZG9lcyBub3QgYXBwbHkgb24gZG1hZW5naW5l
LWZpeGVzLCBjYW4geW91IHBsZWFzZSByZWJhc2UgYW5kIHJlc2VuZA0KPj4+Pj4NCj4+Pj4NCj4+
Pj4gU3VyZSwgSSBjYW4sIGJ1dCBvbiBteSBzaWRlIGl0IGFwcGxpZXMganVzdCBmaW5lLCBib3Ro
IG9uIHRoZSBmaXhlcyBhbmQgbmV4dA0KPj4+PiBicmFuY2hlcy4gSSB1c2VkIGdpdDovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC92a291bC9kbWFlbmdpbmUuZ2l0DQo+
Pj4+IFNoYWxsIEkgdXNlIG90aGVyIHRyZWU/DQo+Pg0KPj4gdGhpcyBpcyByaWdodCB0cmVlLCBJ
IHdhcyBvbiBmaXhlcyBicmFuY2ggKGZvciBpbml0aWFsIGZpeGVzKSBhbmQgaQ0KPj4gdGhpbmsg
N3RoIG9yIDh0aCBvbmUgZmFpbGVkIHRvIGFwcGx5IGZvciBtZS4uLg0KPj4NCj4+Pg0KPj4+ICQg
Z2l0IGxvZyAtLW9uZWxpbmUNCj4+PiA3OTAyOWRjMzQxYzcgKEhFQUQsIHZrb3VsLWRtYS9maXhl
cykgZG1hZW5naW5lOiBzdG0zMi1kbWE6IGZpeCBwb3RlbnRpYWwgcmFjZSBiZXR3ZWVuIHBhdXNl
IGFuZCByZXN1bWUNCj4+Pg0KPj4+IFtjdXRdDQo+Pj4NCj4+PiAkIGI0IGFtIDIwMjIxMDI1MDkw
MzA2LjI5Nzg4Ni0xLXR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbQ0KPj4+IExvb2tpbmcgdXAg
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIyMTAyNTA5MDMwNi4yOTc4ODYtMS10dWRvci5h
bWJhcnVzJTQwbWljcm9jaGlwLmNvbQ0KPj4+IEdyYWJiaW5nIHRocmVhZCBmcm9tIGxvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyMjEwMjUwOTAzMDYuMjk3ODg2LTEtdHVkb3IuYW1iYXJ1cyU0MG1pY3Jv
Y2hpcC5jb20vdC5tYm94Lmd6DQo+Pj4gQW5hbHl6aW5nIDM3IG1lc3NhZ2VzIGluIHRoZSB0aHJl
YWQNCj4+PiBDaGVja2luZyBhdHRlc3RhdGlvbiBvbiBhbGwgbWVzc2FnZXMsIG1heSB0YWtlIGEg
bW9tZW50Li4uDQo+IA0KPiBPa2F5IGdyYWJiaW5nIHRoZSBiNCB2ZXJzaW9uIGRpZCB0aGUgdHJp
Y2ssIG5vIHN1cmUgd2h5IG15IGxvY2FsIG9uZQ0KPiBmYWlsZWQuIEkgaGF2ZSBhcHBsaWVkIHRo
ZXNlIG5vdy4gVGhhbmtzDQoNCkNvb2wsIHRoYW5rIHlvdSENCg0K
