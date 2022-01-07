Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B1E487383
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jan 2022 08:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiAGH0Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jan 2022 02:26:24 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:36432 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiAGH0Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jan 2022 02:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641540385; x=1673076385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cYGGCdoW+DUG3yuVQA3vJ62Ee/NFzv/bECXfA1W2Tlg=;
  b=EceJEHWGmAn77B2ARQcY3YzqKAKmJuR5X6kFm63yKBpnaKjx1L3YarBP
   mvkk3/6xYTS6/v/ZqmAdfz44nCltTvM4ggvGRp6v4dLHjQq5RpUM7joJZ
   RIx5aHDC33gjPXN3xQiNZKmbIZ53vgUg2vAh6DFa2g7mJ7cHsTzbUml6R
   dLNk6zlQi0ebLuSMZliLIAZ78oQSduqhYLdhD7TslP8Ere6tJU2wJ9+mo
   X5NglyqWArouW58fw+K0bv6rVjP+TfDVLA6kzRhmAIrNeidybAL8zsWfw
   V7klxhrX6bGKKcHxRmSdhNxQbkInVxNQut4UpTaHNim2toyIVpOagIvnX
   w==;
IronPort-SDR: 3UxvWBAq0MJkMk0sWiT1sl5l3JxQ4iTmEQWGz4sHP3z5dv7p9DWEoGK48iodfef1JDZklRQ8BU
 gA9lxWJG4GALdpIpISIHBnnhui2BmhRdPaUagTWBoxXXzYA6gFOq4e03Z9z12E9Wv6mAVqGv66
 oJzqf2R34IeMLBR4dJIRoODDrpx8by1YYXHyTvGi6BVXzGdUlItB/pxrmVqt0ymXBzoJEIFMaE
 V764pwWW1t2yI+lvJWjAsP5P90YvSsN0q0J1hU8Sx4IzOH4Uff1RYekMp/GCpzY5BwbAc5X6Fg
 1qFZ95xhyXZNyEpd/nRSFOSf
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="148861995"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2022 00:26:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 00:26:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 7 Jan 2022 00:26:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmvV1aHhpdEs+xRnapt04pW6KnBMr6ZTXdx/2k0viMS1zC5qhDa5f1TavZP1mqAv2gvQndhsnGwJWvQFD8lb2KJdK/rrD1oVM/V8NKqf+cinzIZ51NZC9jucGPGz1o59z4EODOcSZwahy/CP17aNilv7UAHNvWqNW3MuP+aW/nAhzYPjjw6czOjjWKsKp9nMVBsZWZyrY6AsEMPn6JBsUWt2YgSn7pv7LMUmzz1zkPezbL2ijbiHbrVUljoltmvQw7FU7IRw7zwL+YWWRbt+f5ILYI75XEBQwxtMYzcsBtjzOvvQ3OI0kIX0ohWqAeOoYz6DyESECfvzklvXCScdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYGGCdoW+DUG3yuVQA3vJ62Ee/NFzv/bECXfA1W2Tlg=;
 b=jchd6tqnxd/clucYN6gLILW0VTYxtnil6r68uXWAD6JvpaIb8hjSvgLv0hK+meRrtlWz6ezFOPlEjuiQARtnVTm2uHmkGseS8f7Lo3n9YAXfWpaijXFv2JBiRDuc6DJzoN1iTlMqpIcrgyXtk9I6gbIItzb0QjQY1N1Tw3KjQrwg1P91m8y+q5tAohBAOw/o7N2PlRzeSXHxoLBam9QCxdDOSXg2Affmu5SNgZqCGHi7kofUg1wHCZStY4uhvRCl1LQfs1F5NrNuWpEoCP/3qTeL+OevzXo1obhRU+P2Z5nLyKSzMAhpJFJ/Wjf9jeaKdMDcqqXFZoPumOOgai6FfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYGGCdoW+DUG3yuVQA3vJ62Ee/NFzv/bECXfA1W2Tlg=;
 b=vhaLVW/5/ahL0rwL3jWmS/MqDc4HjEMz1xQWLlVBLtwt3KEaMU0XJq7XvOdfy+JgpGxYWe/w6IKfrrnnM0lz1ULq8FpZNpPoeiNBaWSpfpDU6KFQxqlbVFWSrqMEzGJ0n07RV4TNFWNLeGutgx0/BOnzDMM/W6GMtP8v86qjQbA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2576.namprd11.prod.outlook.com (2603:10b6:805:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 07:26:16 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 07:26:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <yangyingliang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <Ludovic.Desroches@microchip.com>, <vkoul@kernel.org>
Subject: Re: [PATCH -next] dmaengine: at_xdmac: Fix missing unlock in
 at_xdmac_tasklet()
Thread-Topic: [PATCH -next] dmaengine: at_xdmac: Fix missing unlock in
 at_xdmac_tasklet()
Thread-Index: AQHYA5fbEcGZGrIYjE6JpxumVi1X9w==
Date:   Fri, 7 Jan 2022 07:26:16 +0000
Message-ID: <40d912e2-119b-0772-59d0-7198d6879e50@microchip.com>
References: <20220107024047.1051915-1-yangyingliang@huawei.com>
In-Reply-To: <20220107024047.1051915-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b576e58-f124-499b-6916-08d9d1aefde9
x-ms-traffictypediagnostic: SN6PR11MB2576:EE_
x-microsoft-antispam-prvs: <SN6PR11MB2576425F7D11D06EEF511A96F04D9@SN6PR11MB2576.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b78mTtB0MfgnxPGipj53RV8YdCcA/93DMhnzgvH0XNHVZeyNcCAirPaIQP525D0VJZrybnycz9rSKAU4gtapyRqcQkX5jwfpKzysRdJaljFvw1vZOgCWIVLoBpbJkDlvVc76T2Zi2F4NiQ9BKjnFse5HOtx263F1bQHVlIxPdDp6mJVdelp82SZJ+PTwAx4jF1iOCKoqKTTofxC/GIAzCRM8mztx5Bt/7BFNW+e8xdo/zULSJikeVaW19/B/cA1mcVssBm+7YhZi8XAGkSfUTYRlLBg2tHYqcufKlmvTSlzZBBslMpq9fZHAC3eOWNqOktGlcjfVb3VgTA25mf9ACLE7KvCpTjhh02JJ5BnmQHXEqleUuyv3afkXiUL4PetG9swpnwf0pk/cpBptGM7l3DbLov5MvPyJXl2Z0GKccpOSbxfyFueAXZTpPzzB0rM9fa//aZu7d45Gp9y4Vd4JwWlTGBMcCt8PokLgd6eZFQ0F96tfMelSTd+lfl8q10EhAtP6LuZ7dI7vUk6lCWy9J76JMWHBpI2tT8T3LOQ4cTGtXuVrIkcWL7XS1/le2XoZdv5eAY+whEyHwasYHtbHWp+qrUIeocWURJOVtt89X83rlaf1E9DTNdf6J9AbabzvVugWtdhx3csL+vXbt3GHanAzelP6ioJUbmP6E8PMivRRkCU8maVtik/AE1A38q4dBInIwlG58YLCFgRiL6XD4kLiy2TkVeSk/UpxYAFjNS3y8fZS7l2pDFRI5kbCaPpAFp26SAwI7JiBA3UfeDWH7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(91956017)(76116006)(186003)(38070700005)(26005)(316002)(8936002)(54906003)(110136005)(31696002)(8676002)(66946007)(2906002)(53546011)(66446008)(64756008)(66556008)(66476007)(6506007)(6512007)(6486002)(508600001)(86362001)(71200400001)(5660300002)(83380400001)(38100700002)(36756003)(31686004)(4326008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVNueno4aTRQaW00NktodWVuV1pLTDBlZzJFR2tkMkxCUUhPM1ltanZGQ1BD?=
 =?utf-8?B?RjlVMHZtMFhSZWhuZTEyNGJLMC9MZStraUgzZ1E3SGdkMnB2WU0yZ1J2L1hN?=
 =?utf-8?B?U3hCYm9weHZsQWF2ZjBpbEE4Z3NoRzJJRWRmbDRyUFI5aDZ6cS82MmpCdFdp?=
 =?utf-8?B?K0lvM2k5ay9EaktMdnlsVXVLUjVOQmlwSTF6Wng1cGlNQWdNcHM5V0NLWFY3?=
 =?utf-8?B?bWlrZllIclU4SFpKak9qUkdaT2p5eCtkQk9ZVEpZNVgzNmcvSS9SZ1hZbFJp?=
 =?utf-8?B?THVrM2NvYUVIUEF3V1NBdC8xY1NkaVRLRnVtZy9pL0Q5bWJzcHErN3IxdUF6?=
 =?utf-8?B?MndhR0xpdnhzQTlucW9TWVRJaFhXT1l3VTduRlYxbVRiNE9OcXB0WVcvK1VB?=
 =?utf-8?B?RGV4OS9acGJVb1FNaldEM2V4ZzA1U1kyZ2VUZFkvMDlEcDl2NWw2cE9PMy9t?=
 =?utf-8?B?ejNpbGpiRzFTSTJSdjRSblhuUG1UWlc5WVBNbU9lYW1mcERwQUdvQWlwaFVo?=
 =?utf-8?B?L0F4WFd6cW52MUxpcHl4R0ZrMExhZTBoWTl1ekZJQmc3dGpuODVNQkxEcWhS?=
 =?utf-8?B?cXluSzVseFdibS80M3F5Zm45WTNGRkNTMnRMWXk3Uk1nTjI5Y2NDTmNZQldx?=
 =?utf-8?B?cXhNK2NrbnhNZU9IdXlHbDhRRytuV2NCd3IwczBzd2gxZzVnV2hEcVN4b2JC?=
 =?utf-8?B?OFpna2ZtMFBRY2VRNlFrNzRTMlVWNmQrUm5mekFQN1pXM0VINm9Vbko5d2N3?=
 =?utf-8?B?L0pXUGJ5MzdZS1o1bXJKSEczb0hGR2hGTEwwZWR2b0EyalV3L3JSb25weDJJ?=
 =?utf-8?B?RkJuaG9SSFNZcVpsV2lITk96aWM5YkhqL3BnMm5nb3dnT1Jpb3RMc2RueDVm?=
 =?utf-8?B?cWpXdk5ncVcyM1lBVlBJc2Z2TlZQdy9RdlRBeDRCa2huT2ZPM1NyT0Q2bTJt?=
 =?utf-8?B?ZjIzaTIvK2tDTzgwdnVTZGJuT1JQR0Q4ME14K3ZhR3M5N0d2TGlKV3FQdXFQ?=
 =?utf-8?B?eUdRTUNjbWZUTDVqQklmbWVFREFuL2ZYZWlBcmQrTGFqMGdncVJTOXRzRU05?=
 =?utf-8?B?WTVzQ0lnUDZJTWpldTlUSXI2dGwzSWpSM285aU1nUS9wdG9uUzRWc0pYY2d4?=
 =?utf-8?B?cnNkcXJhQXp0RTVoenpVQUpVNzNtS3JVb0s5N01GaFpYbXViZis1SkVpTWlE?=
 =?utf-8?B?Q25MMUszTVFmU3R4eXh4TXUxK3l0WFB2YTNuOHBzOHFRRnBjdXMvdnBNUlhU?=
 =?utf-8?B?blVrY08vdXJPZk1FbVl2Y1JSeGhQSnA4bFhxVXJzRXlRa0NYdnJ2OEF0OGNN?=
 =?utf-8?B?UWZ4d0pEY2psbFMraDBOWW5HYzh0K0FjeTRkMmZrYzdHYUIzL1lpWjloZmp1?=
 =?utf-8?B?YjdnWHlFSVdpUWNLdWlEZmtjNFNKTWdFSGV4Z0Nidi9nNVJXc3NkTU5rUVlM?=
 =?utf-8?B?aUNOSzRBUU5GOTJ1QmNoT1lFM25aU2t2MUxmNHBER1VIanBlbzZ0NFl0ZWc2?=
 =?utf-8?B?aktrMksyZ2FVbnJPK0lZR3BoM2tzdkRORHpzQzJ0amRobWFpUHZpYm1OU2Mv?=
 =?utf-8?B?cmhHRllBMlNvU24vUzBNRENrNy9GL3gwT3NUb2k3Slh6b3VJcFRiOXRWVnI1?=
 =?utf-8?B?MjlLM3hpV1lrbW9IQ0QycDErc09JVU55TWlwRG80OGhKY1JML25xNVhuTVZs?=
 =?utf-8?B?YURSeFp6SnRZY0ZFeVoybTJRczdHemp0eFROZU5SVUVGUmY4N01zcmdidEl2?=
 =?utf-8?B?ak9QWU5CcFdUSDVZVGdDZ0JFZGlOb3FvZzYzcVAyMmpPQ2Q5WVdPendnYTRT?=
 =?utf-8?B?Z0Y1NUFDd1J5akI2M2RCU0ROVndBOEwxSlVpWVZUWDcyaXZwZ0tSL0NIT080?=
 =?utf-8?B?M3FreEdNRDJldnZrUHlkS2ZQbHZrV25lVDJvNGZtejJKbzNjUkFDYUZENHdm?=
 =?utf-8?B?UXE3b1pObGpJSEYxSWxxT3A4VVFqSGtKRkNjR2l6UlVxcTAzRFo2MlMvRWhO?=
 =?utf-8?B?MWptMDNVdGZBcEVYanVlRFB5aUdiajJsUExlMnZoSHREYzlrSVl5ZW5tdGho?=
 =?utf-8?B?aWdQdDl0VFN0M3Npb0Fib0RUYnp4RWQ2QWh5RjdvWUR1UnU1WmtrTVZMV1Nk?=
 =?utf-8?B?Nng1ODB4SEtJK2dvcG1EY1FzQVJYVGNhVE9TTzhMSmNYc2VTWUlUczd6anli?=
 =?utf-8?B?MW1lbFlIQkxvMnExbWJuSnRwK3VVRjI4STNGRllHVUcyV2RUc0hydmZXYXFx?=
 =?utf-8?B?Sis2emlQaS9WTnNZUkE1d0xpS3h3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A847774D3FBC234FA6422E66BEC42902@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b576e58-f124-499b-6916-08d9d1aefde9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 07:26:16.3495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYwtn7oPBgjaaaeZi0uMRbQMcLh+zwNty9NOTllZzWNlrEqZRYukE7bKSGmVMb6mX1knWmM2eJElUjdDAWUet1DTWTUT9Exh/aqGGHBOzVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2576
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMS83LzIyIDQ6NDAgQU0sIFlhbmcgWWluZ2xpYW5nIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFkZCB0aGUgbWlzc2luZyB1bmxvY2sgYmVmb3Jl
IHJldHVybiBmcm9tIGF0X3hkbWFjX3Rhc2tsZXQoKS4NCj4gDQo+IEZpeGVzOiBlNzdlNTYxOTI1
ZGYgKCJkbWFlbmdpbmU6IGF0X3hkbWFjOiBGaXggcmFjZSBvdmVyIGlycV9zdGF0dXMiKQ0KPiBS
ZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IFlhbmcgWWluZ2xpYW5nIDx5YW5neWluZ2xpYW5nQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9kbWEvYXRfeGRtYWMuYyB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1h
L2F0X3hkbWFjLmMgYi9kcml2ZXJzL2RtYS9hdF94ZG1hYy5jDQo+IGluZGV4IGExZGEyYjRiNmQ3
My4uMTQ3NjE1NmFmNzRiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2RtYS9hdF94ZG1hYy5jDQo+
ICsrKyBiL2RyaXZlcnMvZG1hL2F0X3hkbWFjLmMNCj4gQEAgLTE2ODEsOCArMTY4MSwxMCBAQCBz
dGF0aWMgdm9pZCBhdF94ZG1hY190YXNrbGV0KHN0cnVjdCB0YXNrbGV0X3N0cnVjdCAqdCkNCj4g
ICAgICAgICAgICAgICAgIF9fZnVuY19fLCBhdGNoYW4tPmlycV9zdGF0dXMpOw0KPiANCj4gICAg
ICAgICBpZiAoIShhdGNoYW4tPmlycV9zdGF0dXMgJiBBVF9YRE1BQ19DSVNfTElTKSAmJg0KPiAt
ICAgICAgICAgICAhKGF0Y2hhbi0+aXJxX3N0YXR1cyAmIGVycm9yX21hc2spKQ0KPiArICAgICAg
ICAgICAhKGF0Y2hhbi0+aXJxX3N0YXR1cyAmIGVycm9yX21hc2spKSB7DQo+ICsgICAgICAgICAg
ICAgICBzcGluX3VubG9ja19pcnEoJmF0Y2hhbi0+bG9jayk7DQo+ICAgICAgICAgICAgICAgICBy
ZXR1cm47DQoNCm9oIHllcywgdGhhbmtzIQ0KeW91IGNhbiBkaXJlY3RseSByZXR1cm4gc3Bpbl91
bmxvY2tfaXJxKCZhdGNoYW4tPmxvY2spOyB0byBhdm9pZCB0aGUgZXh0cmEgYnJhY2VzLg0KQW55
d2F5LCBpdCdzIGdvb2Q6DQpSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1
c0BtaWNyb2NoaXAuY29tPg0KDQo+ICsgICAgICAgfQ0KPiANCj4gICAgICAgICBpZiAoYXRjaGFu
LT5pcnFfc3RhdHVzICYgZXJyb3JfbWFzaykNCj4gICAgICAgICAgICAgICAgIGF0X3hkbWFjX2hh
bmRsZV9lcnJvcihhdGNoYW4pOw0KPiAtLQ0KPiAyLjI1LjENCj4gDQoNCg==
