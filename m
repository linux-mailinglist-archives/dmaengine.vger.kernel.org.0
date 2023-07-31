Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F376A482
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 01:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGaXIx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 19:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGaXIw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 19:08:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B69D19A8;
        Mon, 31 Jul 2023 16:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690844929; x=1722380929;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MgeXZ4JKTysPYVwiCfU0we8UL9A2nvtmB6f2gW0o0pY=;
  b=SIlR0Abt+I4WHbDCr4bYwr1WeQ8JVsTpFlwZEFLGxvs5wyo29GyQUZpS
   Jk61k+753NCkE6qELNq1CRgCi3qWLuVf2X2xMC4+bN/G39jusnEoSahfV
   H2kgC5BjEca24ZnNDmYZ5lZDQWXJgme8FGMGdupFmDeLrrs6RzP8+jHQy
   5Xha8+YAryOBmVUjwXSF3il3P6hQ+Y8eavd1vG9iHmDkWTll0pr9bMPGv
   wfCbiEczyifvksa0992UzGHKMRAOIDFfhaQYKHJliYoXUZuHDGaRASHVD
   I4dWcrEaH09Xbn8GnJuyh6kfJGo6T+VBYv2W9jlOSNbWFa+cU95miRiXp
   w==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="239003764"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2023 16:07:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 31 Jul 2023 16:07:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 31 Jul 2023 16:07:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1A2uArViCzrszGcrgQEuExVt/Dos9ew3Zi0aBmsP1FjjgTRi7Ln+wVKotbtnVuYFB1t49f2CbywQpFKK5gE2wm/+rb3eqcM5U0vpF/zqU2vIj9Hd6XAfPMLIwIe2lHxmkCEbn8cSVOkK4Ik8Yzdo4ViFGUB3ENNGPg2r0sLS4vuoXQQpFPvaeffhWw0cN1evgiB7Sg/t7EXt8ngaYF0FER4UsnJ9QwZd4dBQc3/JTo92+DiqTs5Mz9UfzZH8EfINLV/Jl/mC+XfjXCzxQl1z2qKO7NrsYzRGUH+xa5kIboI/AsuRdDAac9IKCfagyB2gR1mL6XuOH1jVDWK5hf5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgeXZ4JKTysPYVwiCfU0we8UL9A2nvtmB6f2gW0o0pY=;
 b=NO45ru+kvmwkMBuMrmzl3xVMu/ykLDxtI9eJOZlU0bnFGtE9uEVkcAGW66g+QT5cM1lmhz1vIkM4Hi//NyuOqHcuNV1++AaeBfIL8D4lFDBRtGMu9UjmcaEfCv4KOrUx7L1v6k4b6LaLaKcw1OeIHQ2YSbAMCIupO6ePTKhWkUki5SBOc94l5Cz3sWv6tVVhsWPoBT6FppOIQHvCbj9LsTyUXSUOwJfhVESQh8TxR4I69qot+OJVe2dfoB2z4d1dmubbqGtSBm9G6VnXQrv3gF+Hd/5gEtEnZIACcUKef1GnZUummFyh7BFsPNXgc5QkAYiEh6+6aiJoXKWDh8LBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgeXZ4JKTysPYVwiCfU0we8UL9A2nvtmB6f2gW0o0pY=;
 b=M5xy0PM8H9UIA3Rl3WUTSa+/J71yIEF8dlZcXf/4Za7NEWJimgYta7Mj0mIR+UTR6YPD7mYkl1f4tl12VeVRjHfs8n6UOGMwvlTdRa8HIpP1oXgxoOlMI1RnmJQCJ+Ke8upwCCMbTc8OpdnDTn4AHUbesdi9T8fUVRX9qzc+AOA=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 23:07:45 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::344a:f9ac:98d2:7e7f]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::344a:f9ac:98d2:7e7f%3]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 23:07:45 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <logang@deltatee.com>, <linux-kernel@vger.kernel.org>
CC:     <George.Ge@microchip.com>, <christophe.jaillet@wanadoo.fr>,
        <hch@infradead.org>
Subject: Re: [PATCH v6 0/1] Switchtec Switch DMA Engine Driver
Thread-Topic: [PATCH v6 0/1] Switchtec Switch DMA Engine Driver
Thread-Index: AQHZwZlXn7KUPI2hn0S/JRIrrYlNFa/UCgMAgAB6a4A=
Date:   Mon, 31 Jul 2023 23:07:45 +0000
Message-ID: <d6e9297ae35641343cefe7ea7a038abef6a3eafb.camel@microchip.com>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
         <ac8b230a-992c-66c0-4a46-f076890ce5d0@deltatee.com>
In-Reply-To: <ac8b230a-992c-66c0-4a46-f076890ce5d0@deltatee.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|BL1PR11MB5399:EE_
x-ms-office365-filtering-correlation-id: 553dd8b4-ac49-4cd5-d0df-08db921af384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qe1TOGgsgWlbS0UVz2saRaGnc6waCSI1mdsOTEoV7rJlnWdqb20c1H14gd5aMzja9JBtrnUw7w6NOaDF/zJNbZ4FYqzvq4eokatNTbBwjzvd42drLcgjRzCqpEIGBy0kKNPB6GIRuSLalmby7jeoGyNtVbTw2MtHziXxLCy0w41QHJjRFydjqOwDYEaON+QUVZxctWdRcbkP3FDfxhHkEI2tyeFnQISJFzPyjMn9OAQKw/DOAxU0cuQgYC/70gdtHaKMtbpp0aiBObtkZJaqkA3fDz05iuFKPUTqwbrwF4luXSr0Y36Zc7BEmUWmO4NWId0uiumHa7Yiob9R2ixrJb1QtRHAhIt29MvpGxkIdcr7jH9H9k1aZbbqvA9kX8H7g6FMNXNZTJlaJPTe3F0qB6LlYW2DI8LM9XIGkNsLlhaf5a6FIbwUaRgzv3pVxiBOASuRMrE/6bYRcQ9Nsf1ZFa8ezWaBpOUS34F4KlhKQYri0+XSIVFRv0S8RPlS9pU5p3gq9n3qcyBY3qwfKxqlaYwPP8oW3UIsOiF0fJhXX3ue4sIbWpxlcCE6ZikA0hRiFdLCZHcsdkmRgizuR0ZP7gna2E3c+z13m3dLUT2xs1qZjGeBAKR1Y2sHp+vXPH9g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(6486002)(38070700005)(6512007)(86362001)(71200400001)(186003)(2616005)(36756003)(6506007)(53546011)(26005)(38100700002)(122000001)(5660300002)(8676002)(66556008)(4326008)(41300700001)(8936002)(76116006)(66946007)(66446008)(66476007)(64756008)(4744005)(316002)(2906002)(478600001)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW5wS2lRTVRUamhveXBQRGlqUmw5UE43eFVRUEUvbzNCUTEzKzZsSXlBM2xv?=
 =?utf-8?B?Zkt6M0tKOVJLY1pGeXhuSmdVS2N5akhsRkN5OVJ0ek9tTE5QcjhiYkpaMTdS?=
 =?utf-8?B?V0VpYWpjVll6N1gyeEpYUmw0bkxudVQ2c3BoY0VDRWF3VFdFUjZLQ1RWZVIy?=
 =?utf-8?B?Y1Z6MzVnWGZNV3NsVmtibzNyUnJPQnl1NFU2cVhKTTg0NmwydHVwREpHSHBo?=
 =?utf-8?B?aFc0NE15NEd6U3hOR0hRMk1VVHF6NmZCam5kK0NONEFWemdtN05STXpjMmFz?=
 =?utf-8?B?R3NkYzJnYnZyUmJRbmxjb0Z4QWpoRy9qSFFhUGFkR3h6YXI3b1hGckRmZWlQ?=
 =?utf-8?B?OW05dnZZOFdraEgxU2h1MnR5NXk4OGxuV0NtMzlYVWJPcDJhY2xleEZ5UEt3?=
 =?utf-8?B?Q2dxQStTNTYwemdNSWw5eEFkT3lheEY2bms4UUxPOUdLdy9UdzNqTis1dVox?=
 =?utf-8?B?TVdaamhKY0Qra0tYbGZiKzdFUlpKc09sanJrdFgzcmtSaFl2ZlpKMFNzb3Q5?=
 =?utf-8?B?TXIrUGx2YUxyREw5UFlmcFZqSjg0dzFPbStSSndKZGhIUk9BZjVrWnkwRG5w?=
 =?utf-8?B?U0dkWEpNRllCbTNLTlpsQ2g5c1U5UjRQaDFYUkZrRzc5UVhTUkNHVTE2Qkxu?=
 =?utf-8?B?aE1teEVZOTRnMTdNZ3BRTFNDRlRNdGJnS2Noc2VIdGZhZVpqTFZxbS9PT2tx?=
 =?utf-8?B?cEZkUEU3K1JTNHd3ZkpXTFFEN2tjTFNpNmVOdWZodG5MQzlLWll3TGpZUWR5?=
 =?utf-8?B?UlI1eVQvejgvOThualRrL052a2p6Szl1bmtqZkc2VHN6SjdBeTNkWGpzWjJq?=
 =?utf-8?B?MXZhbEZjTU9wUU9ReHNuZEdlNEkxMVgxYXRLU3B0c244YWVLVHJ5Si84cU41?=
 =?utf-8?B?LzVMdHFTYzZyYm5KdE1UMEJ2UUJIQ3JrQk4xTGpHUUhVN085ZlNmRXlBblNx?=
 =?utf-8?B?L2JnbWN6TEhWd2U4VWZZUitvS0NSM1pJVm1uUEY4b1BjV0hOd0lkZ2hUb1cw?=
 =?utf-8?B?bXlEUVZSNlJhZlpUUDVweTJHeFdXOXBOdWROd0sxSHhRelNIa3BmTHVSaWUw?=
 =?utf-8?B?TFpmWjBIeDdTMS9Va29ESUZTNmxFRHBvODdaTXR6ZGRud093WmljZFpEQUl1?=
 =?utf-8?B?dEdFOStOTGJ3aWtuVTNBVzNWdFRDQjNtU0tvM3FuUENNZGJiL01DYWdEaVhw?=
 =?utf-8?B?MmdvZW5SdlhHRlRGSU9YRXcrNlZLWEdZMjRwMlVyRmtxd3d3UWYwQUdVTGRE?=
 =?utf-8?B?VGphZE9zbHBEZzNqQXgvWGhPMlorNHNFTTZDdXlMeCtuUG41Yk5XYlFlYnEz?=
 =?utf-8?B?WjB4dDZybzZtMWV5dGY0MEFnTVAzTEtTWDc5ckhEL0tZL1VoVVp1WXlTZlU1?=
 =?utf-8?B?cXlxSStnaW1hU2dlWTBtb0FCNG9rbytQMkpvR2dpVGtQV040ZTlrTDR4ZDZx?=
 =?utf-8?B?aU16NXY5Qk1PNjkzbnduUkw0WnFoWVJud0VIelg4UkxJSnFxK1BQNEFLZ1FC?=
 =?utf-8?B?akRQaTIxb0RqN1FueW1iVDVjUCtsT20rK0MrOTFtY2srdE04b1ljNjBkTHpV?=
 =?utf-8?B?blJwakN3YUNJWlJWTVVIT3BJblNuM0dpVHJTdnlGKzlpdVVYTi95T25FWXk4?=
 =?utf-8?B?ZWRrQWpjczhha1llN01iYUVZYmgvVnlFbTNjdkJiQURwZkEyK3A4R3FrTGVL?=
 =?utf-8?B?d3VnRzJlYVd3WExSb0NVb1hOeVdFekRyTXpvTXlPNldaQk52MWZmQ0d5L0NY?=
 =?utf-8?B?dVErUERYZFl2WStrWk5rRlkxKzdOU3F6TG5FMlE0MG9sT3pXU0NQN21HSXU0?=
 =?utf-8?B?S2dadGt1Z05RYm9BY0ZSTHk4dnVodFVOY3Vsa3U2cm5QaEgyRmN4SDIrRHY0?=
 =?utf-8?B?ZjdGSXhMNEdldFVnZnAzMEZNNGVTbHRzWVREVzZpanlmZU5MUHlLMTdJSEZl?=
 =?utf-8?B?TTlhb0w4QlAxT3ZoSzFxS0toTW9xRDRnMDVTLzg3ZGxjbk5qZzlZUjcwRVc1?=
 =?utf-8?B?eTA0eEVSZlQrRzNSeWlHa0Z1bW83NW5rYXU5ZmlTZnBFamtVN3J1UTdOOUJt?=
 =?utf-8?B?UjRMV0pXUXNSRGYrVUxlSUh1S2hhL0o4eWRyR1MrNnQ4NUNGNFFyTDYyOVQ0?=
 =?utf-8?B?YytkTWhmdUt6YThzM3dXNjk0QVltV1hma0YxTjVTa3dCMlBlcEdGMmcyVmZV?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DD01B1058F6544FB0BB0539ECCE3075@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553dd8b4-ac49-4cd5-d0df-08db921af384
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 23:07:45.5032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cziFlD4PCheWDmITwi+8ZeHPivOB4p+IrC/wrdar3kRAp7NYd7Sh94lKMRVYbzkwJhHuW7i3idyFXkjU/PU1cfKtm5kYm1oassPg5XJA2z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5399
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTMxIGF0IDA5OjQ5IC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjAyMy0w
Ny0yOCAxNDowMywgS2VsdmluIENhbyB3cm90ZToNCj4gPiBUaGlzIHBhdGNoc2V0IGlzIGJhc2Vk
IG9mZiBvZiA2LjUuMC1yYzMuDQo+ID4gDQo+ID4gS2VsdmluIENhbyAoMSk6DQo+ID4gwqAgZG1h
ZW5naW5lOiBzd2l0Y2h0ZWMtZG1hOiBJbnRyb2R1Y2UgU3dpdGNodGVjIERNQSBlbmdpbmUgUENJ
DQo+ID4gZHJpdmVyDQo+ID4gDQo+ID4gwqBNQUlOVEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgwqAgNiArDQo+ID4gwqBkcml2ZXJzL2RtYS9LY29uZmlnwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoMKgIDkgKw0KPiA+IMKgZHJpdmVycy9kbWEvTWFrZWZpbGXCoMKgwqDC
oMKgwqDCoCB8wqDCoMKgIDEgKw0KPiA+IMKgZHJpdmVycy9kbWEvc3dpdGNodGVjX2RtYS5jIHwg
MTU3MA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gwqA0IGZp
bGVzIGNoYW5nZWQsIDE1ODYgaW5zZXJ0aW9ucygrKQ0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvZG1hL3N3aXRjaHRlY19kbWEuYw0KPiA+IA0KPiANCj4gTG9va3MgZ29vZCB0byBt
ZSwgdGhhbmtzIQ0KPiANCj4gUmV2aWV3ZWQtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRl
bHRhdGVlLmNvbT4NCj4gDQo+IExvZ2FuDQoNClRoYW5rcyBMb2dhbiBmb3IgdGhlIHJldmlldyEN
Cg0KS2VsdmluDQo=
