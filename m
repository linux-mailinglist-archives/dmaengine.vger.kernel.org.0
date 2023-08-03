Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4186376DECC
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 05:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjHCDPj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Aug 2023 23:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjHCDPi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Aug 2023 23:15:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64EB211E;
        Wed,  2 Aug 2023 20:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691032536; x=1722568536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zphCvCd8WbVNgfDdfrElOH1unfg6j0bPkCQVWn8tYKg=;
  b=K8DvcnV8a+I/qcIbUWX0Ha36h7FEu7HGGLoukaO8dwOMsOYhVUstXeAC
   Ev8wXAWO1a2oUWVZfmSYQnpFU/3OwxHHVD4joLxQQhsZ8VHN02c5DsYF2
   Ac+kP5q/GCPcuZNzkKjfFTAcKUsmJuuaKAhonCWva6rE446tlV/9Q7wEs
   EZjxN8dsFYGqrGlTiLgZs/3xGoiKS2FRKv0qptyOWftB0+qpN3X/mhDmF
   5iRWnBb43r8VIu+OnaNokoRRBOHvLNZsVS+OVvVP3Jgmd/bXcAJqInREY
   1YtTcIxI/xWdgu5od4pcKukQ/og4sK+J6GA1wqUmx8/6AANJM5P1fnWxl
   w==;
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="239495503"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 20:15:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 20:15:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 2 Aug 2023 20:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlPgSOwgFRcXBgR/T7N1/uQ+zbfjq012qHV6NYQKArVzhyupJiFgStWKsA2fh77x3DcWt+QC6/5DGFBiBsc1aBnA+b6inBjm4mKAnw/3wnZyD0RRZRxsr03+y9/GU8iwH8I6hZ4iOHwuwvhO4vUMjHGUV9k0cFZA4JScmQN7hiWnmYzG5w+KlVit0d+f2pCo92k+Gs/c3RnTq8GRHj1WqHfrYvTEiJE5kHrRNHDBArGUIEdwBH/tWzEXaa7kFjSmtgNUAl1Kexr5ytgcX06/dh+BISWP/y5VpealiLZLf5ByqPHIPOoXcdzxOV6CemL4SOrwjx1aQzDZbhjK5tv5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zphCvCd8WbVNgfDdfrElOH1unfg6j0bPkCQVWn8tYKg=;
 b=gezGll3Nnv8rvy3Av6ZPqDCZsTnFFIdI5va1wn9+EniG0DQbi9HvDwh+yhs+rHmgvMv78/Qtzx1ibga620eQraEirjqLsl2Zvd8GSCwZJ0hAA+pzK2cMSdKpUe013xvCwF4R5wK68t2l+7aBNui7VhFkGhMC+m8WrYwMhGnWuqWW+FWcpOU/b9DgawLTQ06rf6nc9c2nZXF/v7mxcq1zIvXB8p7vMqeedjAv30PNd5XRM14qEP/oX2Ea39a21fvXId//foSHYs0zA3DYPy1EPRBNMchj1ZXHZdHu5L4742lzzpii2bQiBjMJK69wnt40ftGwunwHxkikmUEEvHNUpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zphCvCd8WbVNgfDdfrElOH1unfg6j0bPkCQVWn8tYKg=;
 b=BmaX9W4ROLBio2+LriCYZqEkdxzysS2oELtsfYWk8gZjyPYyB8CD0mjj/6sgh6EqKVQ5BzSbZSaEKbMTrlANgTg13am9/6bOweBQb6gHh04UyHMrrNjm6iFkbrdh0ujSsvCeaK5xOkFOkgBaS79WwJtfm4b9aJRBOg3iW2vRoUI=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by DM4PR11MB5406.namprd11.prod.outlook.com (2603:10b6:5:395::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 03:15:19 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9dce:ddd6:9ab1:db67]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9dce:ddd6:9ab1:db67%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 03:15:18 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <George.Ge@microchip.com>,
        <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>, <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZwZllP9AErauFFUmKz13YRSBKD6/VzMKAgAIhf4A=
Date:   Thu, 3 Aug 2023 03:15:18 +0000
Message-ID: <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
         <20230728200327.96496-2-kelvin.cao@microchip.com> <ZMlSLXaYaMry7ioA@matsya>
In-Reply-To: <ZMlSLXaYaMry7ioA@matsya>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|DM4PR11MB5406:EE_
x-ms-office365-filtering-correlation-id: 2d74c293-3569-4910-a449-08db93cfdd3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /KFngAclJcL/z7+C+9oWaLmYXmDPvjZ6TrmOMCLDFdS+DKIj5fiNputhSjnNag1MKMFdCJfuzqpt/5w4cyDjb463J4XF/tMXLKt0/36WUdjzjm+YtoY+r9+EQ/txxUohaz21Big4uWZpU5f98inzj07ILajmYWVv07C3Re74hVosPNiAyfb/AYdFRfcvqZBch3pEWWt6rfZYM5bJWe6PMjxpSy0lsaEGsHYE3JAHUGQUi26ZGLZLvF7dWR7rU4AvHxpLGfEgSGG2ne5GgfFdRZFIaMTxq/8rKiK+RjbsdqARN77mDNEidF/LwZcEJFJofIBX7NUehDIfoDVooHORXPgvz0RlC5vuzmIU4Q9nZdBzl5Jpjn+ClXSeoSmx9pQM1kyBrSU0JHXInJA4takfXV+pJpikkP+5F+eKfFayKAxWCmk4ueWCq26y9OvuHtMmHp9XFEs/d47W0tWFFsJ9e9j0/sxeJSjwyoSHL7ynmwB6BCcATEtEnSRjAojUtWqxHk9GT5TeNf59zteqh7rJoiUtdrreRIsLURayjMLDRC0Q5njYQC/Mp9oyFu5/p+tH3af7DjP/HfXtjzEk7BSQlZQYo7b60wWazelgZXHzxai1SYwPoV3ycN5Qxaa2GJu1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(38070700005)(36756003)(86362001)(54906003)(478600001)(38100700002)(122000001)(2616005)(186003)(26005)(83380400001)(6506007)(53546011)(41300700001)(8676002)(8936002)(6512007)(71200400001)(6486002)(316002)(6916009)(64756008)(66446008)(66476007)(66556008)(5660300002)(4326008)(76116006)(66946007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTdlZ2UwK1MzOWRqcEUyWkdxTE1wM3pha1Rrc21JWVp4N29LZUQzVVQ0Wm1C?=
 =?utf-8?B?MUo2TXNxOWJOZkJBVS9OTlpyVWxWWE93dUl4b2hvQ2dESTRTL01hbE9MNWZm?=
 =?utf-8?B?ZFhZM1l2a1ZoVUk3RWNDaHZkK0lyWUNWYWlkNXI0ZHBkRGxJb0xHaGk3K1B2?=
 =?utf-8?B?QVZXKzl5ZklHNTJaMTlnTy9JbFJTbDZ3cXpqZjRnenVob25xZllSYk1CRHRu?=
 =?utf-8?B?RG8yYTBzYWpWWUV3ZHVqYVNGTUFrWW1MUURWQTRmdkhUcUoyVVBEeDhsMm5t?=
 =?utf-8?B?ZDVxVXJlWS9LeGN5S2JqemlDVEttZFVPZEROemE0clFGVVpEY2V0NHZFYWsx?=
 =?utf-8?B?MW0rbXIzRmRtTnVYT0dxUWV5ZzBIaWxaaTJJT01KSlIxNTlTRHNyTHF5bEtj?=
 =?utf-8?B?Sjk1azJDL0UvSkg1d3cwZlFYemlrM2tJcnAwOGtEeTl3ZVNDbTRqZEVhT0sz?=
 =?utf-8?B?WWJIOEFhdFNaMk9QQ3h5RER2RkE5ODBzdTFNVVpmeitsNzhJTmY3OG9iVmth?=
 =?utf-8?B?SGFyaDVoWVJQZ1NPN016YUxLM3dMMndFaW9ROWlIVG53ODBWeDBQb0MwNTlv?=
 =?utf-8?B?ejcwL3FNdkhGREdYRmJYUGozWTlsdHhDQ2FZZzMrTmwwcjJtTlRLTDV1Ly9D?=
 =?utf-8?B?UlhxaUI5dHYxeXUvVjNrOWh6YXh5K214L3pOUTJmM25QZXhuUzFLQlJ0YWNI?=
 =?utf-8?B?a05kUm90U3EybEwyMHEwdTloclhDTnorbGgvRS85cDJiSkxBUmpsVnRyQmcw?=
 =?utf-8?B?Z2d6bFc5bjBkM0ZmOEVEQk83Wk01NEl6ZDlCR2ZaQzdBUy9QaGRNa1RFMEVT?=
 =?utf-8?B?NjlkTE1vK1F1MnRWKzllM1crNzBWTkNWSm91OUtINjBkcXFkOWlpbktnTmtG?=
 =?utf-8?B?c2s0bTFyNnRuVGsvTWtiSFZoREFIMUNwVmQrRlhxYnU2bEM4a2V3TXJkQkNj?=
 =?utf-8?B?QVRFYmMrczFCeVhvZXkrcktUcmFxa0QrMGdUdyt1amladlZSaFphQ3ZqNHJC?=
 =?utf-8?B?bmR5RkRtaFlWMG94NUtpc0NOUlBhVkRSM2JoZTY3Ym9IRjhzc1VQaXNFUjZu?=
 =?utf-8?B?cnBqS3czU0cvZ2RtRDJaYWJkemVkM3VxcThIbVk4TlRLTy9JZ04rYmpMcFZR?=
 =?utf-8?B?RUtDRzE3RzJUY0EvNkp1YTJ1REpWbXM2T09GQitWN1VkZ2hLNEZocytrQitm?=
 =?utf-8?B?MWNkWEMrTFZtWVhRbWVrQlhSVjUrcnluMTVGYjNhU1VySVV6QVZsU2xwUDJ4?=
 =?utf-8?B?Z3Bpajc5N1RrOThrNkRVRVN0bXVGaGVJbWFZaWNtN1J4eGw2R3BhY3hibk1S?=
 =?utf-8?B?SmFDZjBobGVwNGdrTmtwa21TbTRTSklJdWxNRndTc3JkOEx2K0w1YjlINnRp?=
 =?utf-8?B?Q1pZRFVWRzNkZ0lDVWN3RFY0bzV1U1gwWVc1TXlIcFdmb2hlcnBtYVdYYmR0?=
 =?utf-8?B?Um5IQ3RoeTVLd3ZJOVJxdm9yMU5CUkEySkpCU2VmNFZ4bk5nSXE1WVpGakR3?=
 =?utf-8?B?Z2I0UXV5U0drdWFKTHA1aDJ1OVlIQjNZK2NYUWJUWWNwYjY0bnBXdFQzZ2JX?=
 =?utf-8?B?WjE1UUUyQkZYVkhDZ3pNM0JXcEZqTG5zQ3Q2bVNJNVdqUkYvcTlpU0RuSnB6?=
 =?utf-8?B?akRDYjQ4MW8va1VOZEw0MEcrcUpsTlkzYVRudlJiNW44d0g1NXp5UXN2Tm1K?=
 =?utf-8?B?M1g5NFYva05sNVNVL1dEendKdGVIRTRBVUpKMzJYdzdONDJ0b3JhT2sxMFE5?=
 =?utf-8?B?TEc3MktBTmppNjd5UXBLTURrMTlEaXhCUVh6ZGI1enFrcDV3OXEwL0tNRkFD?=
 =?utf-8?B?Lzdxa0NaZURybll4SDZDT1NWR2RKWmkyMUZIS2VMQ0NWZUNoQVgweUgwNUVl?=
 =?utf-8?B?eDI5Tm9hSFFvRUNKRkxqc0pZWERzcGI2YkY3Y1hLMm8zankzcU10a1RNKzZP?=
 =?utf-8?B?ODdEeTVSODAwQ0VxVTRLSC81R0JidSt5YSt6WXd1K1Fhcnp3ODVqNnV0elAv?=
 =?utf-8?B?OU1lSnhqVzN4aGdXQmI2YlhGaFBqVUg2cEhLR1lSZC9rZmR1emdoN0NHK0VX?=
 =?utf-8?B?czIrZE90WEMwV1ppSFg2bGQwd25sSFVMVEtkQnZ0bStTTnN5OFRJdlJHb2Vo?=
 =?utf-8?B?Z3BrWUJkT21JSFpuU1ZoeDlKb1hndEpGOUpMcnJSK0dYVmZoZVVXbnY5elBv?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FD211E53A949841BADF877C052234AE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d74c293-3569-4910-a449-08db93cfdd3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 03:15:18.1936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHrwayc2BqrldWNpuVQI+lvmgvnWH5sdTCWoURNiOjr4syxl6Nn51uZ6JVhHPCRg5WqRxCRIfRpS7zTphtFMVSnmsGdX84oLHT5VcQ9mvNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5406
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTAyIGF0IDAwOjEyICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOgo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91Cj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlCj4gCj4gT24gMjgtMDctMjMsIDEzOjAz
LCBLZWx2aW4gQ2FvIHdyb3RlOgo+IAo+ID4gK3N0YXRpYyBzdHJ1Y3QgZG1hX2FzeW5jX3R4X2Rl
c2NyaXB0b3IgKgo+ID4gK3N3aXRjaHRlY19kbWFfcHJlcF9tZW1jcHkoc3RydWN0IGRtYV9jaGFu
ICpjLCBkbWFfYWRkcl90IGRtYV9kc3QsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZG1hX2FkZHJfdCBkbWFfc3JjLCBzaXplX3QgbGVuLCB1bnNpZ25l
ZAo+ID4gbG9uZyBmbGFncykKPiA+ICvCoMKgwqDCoCBfX2FjcXVpcmVzKHN3ZG1hX2NoYW4tPnN1
Ym1pdF9sb2NrKQo+ID4gK3sKPiA+ICvCoMKgwqDCoCBpZiAobGVuID4gU1dJVENIVEVDX0RFU0Nf
TUFYX1NJWkUpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqIEtlZXAgc3BhcnNlIGhhcHB5IGJ5IHJlc3RvcmluZyBhbiBl
dmVuIGxvY2sgY291bnQKPiA+IG9uCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0
aGlzIGxvY2suCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgX19hY3F1aXJlKHN3ZG1hX2NoYW4tPnN1Ym1pdF9sb2NrKTsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5VTEw7Cj4gPiArwqDCoMKgwqAgfQo+
ID4gKwo+ID4gK8KgwqDCoMKgIHJldHVybiBzd2l0Y2h0ZWNfZG1hX3ByZXBfZGVzYyhjLCBNRU1D
UFksCj4gPiBTV0lUQ0hURUNfSU5WQUxJRF9IRklELAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hX2Rz
dCwKPiA+IFNXSVRDSFRFQ19JTlZBTElEX0hGSUQsIGRtYV9zcmMsCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAwLCBsZW4sIGZsYWdzKTsKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIHN0cnVjdCBkbWFfYXN5
bmNfdHhfZGVzY3JpcHRvciAqCj4gPiArc3dpdGNodGVjX2RtYV9wcmVwX3dpbW1fZGF0YShzdHJ1
Y3QgZG1hX2NoYW4gKmMsIGRtYV9hZGRyX3QKPiA+IGRtYV9kc3QsIHU2NCBkYXRhLAo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVk
IGxvbmcgZmxhZ3MpCj4gCj4gY2FuIHlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0IHRoaXMgd2ltbSBk
YXRhIHJlZmVycyB0by4uLgo+IAo+IEkgdGhpbmsgYWRkaW5nIGltbSBjYWxsYmFjayB3YXMgYSBt
aXN0YWtlLCB3ZSBuZWVkIGEgYmV0dGVyCj4ganVzdGlmaWNhdGlvbiBmb3IgYW5vdGhlciB1c2Vy
IGZvciB0aGlzLCB3aG8gcHJvZ3JhbXMgdGhpcywgd2hhdCBnZXRzCj4gcHJvZ3JhbW1lZCBoZXJl
CgpTdXJlLiBJIHRoaW5rIGl0J3MgYW4gYWx0ZXJuYXRpdmUgbWV0aG9kIHRvIHByZXBfbWVtIGFu
ZCB3b3VsZCBiZSBtb3JlCmNvbnZlbmllbnQgdG8gdXNlIHdoZW4gdGhlIHdyaXRlIGlzIDgtYnl0
ZSBhbmQgdGhlIGRhdGEgdG8gYmUgbW92ZWQgaXMKbm90IGluIGEgRE1BIG1hcHBlZCBtZW1vcnkg
bG9jYXRpb24uIEZvciBleGFtcGxlLCB3ZSB3cml0ZSB0byBhCmRvb3JiZWxsIHJlZ2lzdGVyIHdp
dGggdGhlIHZhbHVlIGZyb20gYSBsb2NhbCB2YXJpYWJsZSB3aGljaCBpcyBub3QKYXNzb2NpYXRl
ZCB3aXRoIGEgRE1BIGFkZHJlc3MgdG8gbm90aWZ5IHRoZSByZWNlaXZlciB0byBjb25zdW1lIHRo
ZQpkYXRhLCBhZnRlciBjb25maXJtaW5nIHRoYXQgdGhlIHByZXZpb3VzbHkgaW5pdGlhdGVkIERN
QSB0cmFuc2FjdGlvbnMKb2YgdGhlIGRhdGEgaGF2ZSBjb21wbGV0ZWQuIEkgYWdyZWUgdGhhdCB0
aGUgdXNlIHNjZW5hcmlvIHdvdWxkIGJlIHZlcnkKbGltaXRlZC4KPiAKPiA+ICvCoMKgwqDCoCBf
X2FjcXVpcmVzKHN3ZG1hX2NoYW4tPnN1Ym1pdF9sb2NrKQo+ID4gK3sKPiA+ICvCoMKgwqDCoCBz
dHJ1Y3Qgc3dpdGNodGVjX2RtYV9jaGFuICpzd2RtYV9jaGFuID0KPiA+IHRvX3N3aXRjaHRlY19k
bWFfY2hhbihjKTsKPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlICpjaGFuX2RldiA9IHRvX2No
YW5fZGV2KHN3ZG1hX2NoYW4pOwo+ID4gK8KgwqDCoMKgIHNpemVfdCBsZW4gPSBzaXplb2YoZGF0
YSk7Cj4gPiArCj4gPiArwqDCoMKgwqAgaWYgKGxlbiA9PSA4ICYmIChkbWFfZHN0ICYgKCgxIDw8
IERNQUVOR0lORV9BTElHTl84X0JZVEVTKSAtCj4gPiAxKSkpIHsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZGV2X2VycihjaGFuX2RldiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICJRVyBXSU1NIGRzdCBhZGRyIDB4JTA4eF8lMDh4IG5vdCBRVwo+
ID4gYWxpZ25lZCFcbiIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB1cHBlcl8zMl9iaXRzKGRtYV9kc3QpLAo+ID4gbG93ZXJfMzJfYml0cyhkbWFfZHN0KSk7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKiBLZWVwIHNwYXJzZSBoYXBweSBieSByZXN0b3JpbmcgYW4gZXZlbiBsb2NrIGNv
dW50Cj4gPiBvbgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdGhpcyBsb2NrLgo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIF9fYWNxdWlyZShzd2RtYV9jaGFuLT5zdWJtaXRfbG9jayk7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOwo+ID4gK8KgwqDCoMKgIH0KPiA+ICsKPiA+ICvC
oMKgwqDCoCByZXR1cm4gc3dpdGNodGVjX2RtYV9wcmVwX2Rlc2MoYywgV0lNTSwKPiA+IFNXSVRD
SFRFQ19JTlZBTElEX0hGSUQsIGRtYV9kc3QsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTV0lUQ0hURUNf
SU5WQUxJRF9IRklELCAwLAo+ID4gZGF0YSwgbGVuLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhZ3Mp
Owo+ID4gK30KPiA+ICsKPiAKPiAuLi4KPiAKPiA+ICtzdGF0aWMgaW50IHN3aXRjaHRlY19kbWFf
YWxsb2NfZGVzYyhzdHJ1Y3Qgc3dpdGNodGVjX2RtYV9jaGFuCj4gPiAqc3dkbWFfY2hhbikKPiA+
ICt7Cj4gPiArwqDCoMKgwqAgc3RydWN0IHN3aXRjaHRlY19kbWFfZGV2ICpzd2RtYV9kZXYgPSBz
d2RtYV9jaGFuLT5zd2RtYV9kZXY7Cj4gPiArwqDCoMKgwqAgc3RydWN0IGNoYW5fZndfcmVncyBf
X2lvbWVtICpjaGFuX2Z3ID0gc3dkbWFfY2hhbi0KPiA+ID5tbWlvX2NoYW5fZnc7Cj4gPiArwqDC
oMKgwqAgc3RydWN0IHBjaV9kZXYgKnBkZXY7Cj4gPiArwqDCoMKgwqAgc3RydWN0IHN3aXRjaHRl
Y19kbWFfZGVzYyAqZGVzYzsKPiA+ICvCoMKgwqDCoCBzaXplX3Qgc2l6ZTsKPiA+ICvCoMKgwqDC
oCBpbnQgcmM7Cj4gPiArwqDCoMKgwqAgaW50IGk7Cj4gPiArCj4gPiArwqDCoMKgwqAgc3dkbWFf
Y2hhbi0+aGVhZCA9IDA7Cj4gPiArwqDCoMKgwqAgc3dkbWFfY2hhbi0+dGFpbCA9IDA7Cj4gPiAr
wqDCoMKgwqAgc3dkbWFfY2hhbi0+Y3FfdGFpbCA9IDA7Cj4gPiArCj4gPiArwqDCoMKgwqAgc2l6
ZSA9IFNXSVRDSFRFQ19ETUFfU1FfU0laRSAqIHNpemVvZigqc3dkbWFfY2hhbi0+aHdfc3EpOwo+
ID4gK8KgwqDCoMKgIHN3ZG1hX2NoYW4tPmh3X3NxID0gZG1hX2FsbG9jX2NvaGVyZW50KHN3ZG1h
X2Rldi0KPiA+ID5kbWFfZGV2LmRldiwgc2l6ZSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAmc3dkbWFfY2hhbi0KPiA+ID5kbWFfYWRkcl9zcSwKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBHRlBfTk9XQUlUKTsKPiA+ICvCoMKgwqDCoCBpZiAoIXN3ZG1hX2No
YW4tPmh3X3NxKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJjID0gLUVOT01FTTsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBmcmVlX2FuZF9leGl0Owo+ID4gK8Kg
wqDCoMKgIH0KPiA+ICsKPiA+ICvCoMKgwqDCoCBzaXplID0gU1dJVENIVEVDX0RNQV9DUV9TSVpF
ICogc2l6ZW9mKCpzd2RtYV9jaGFuLT5od19jcSk7Cj4gPiArwqDCoMKgwqAgc3dkbWFfY2hhbi0+
aHdfY3EgPSBkbWFfYWxsb2NfY29oZXJlbnQoc3dkbWFfZGV2LQo+ID4gPmRtYV9kZXYuZGV2LCBz
aXplLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZzd2RtYV9jaGFuLQo+ID4g
PmRtYV9hZGRyX2NxLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdGUF9OT1dB
SVQpOwo+ID4gK8KgwqDCoMKgIGlmICghc3dkbWFfY2hhbi0+aHdfY3EpIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmMgPSAtRU5PTUVNOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBnb3RvIGZyZWVfYW5kX2V4aXQ7Cj4gPiArwqDCoMKgwqAgfQo+ID4gKwo+ID4gK8KgwqDC
oMKgIC8qIHJlc2V0IGhvc3QgcGhhc2UgdGFnICovCj4gPiArwqDCoMKgwqAgc3dkbWFfY2hhbi0+
cGhhc2VfdGFnID0gMDsKPiA+ICsKPiA+ICvCoMKgwqDCoCBzaXplID0gc2l6ZW9mKCpzd2RtYV9j
aGFuLT5kZXNjX3JpbmcpOwo+ID4gK8KgwqDCoMKgIHN3ZG1hX2NoYW4tPmRlc2NfcmluZyA9IGtj
YWxsb2MoU1dJVENIVEVDX0RNQV9SSU5HX1NJWkUsCj4gPiBzaXplLAo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBHRlBfTk9XQUlUKTsKPiA+ICvCoMKgwqDCoCBpZiAoIXN3ZG1hX2NoYW4tPmRlc2Nfcmlu
Zykgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYyA9IC1FTk9NRU07Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZnJlZV9hbmRfZXhpdDsKPiA+ICvCoMKgwqDCoCB9
Cj4gPiArCj4gPiArwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IFNXSVRDSFRFQ19ETUFfUklOR19T
SVpFOyBpKyspIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVzYyA9IGt6YWxsb2Mo
c2l6ZW9mKCpkZXNjKSwgR0ZQX05PV0FJVCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmICghZGVzYykgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmMgPSAtRU5PTUVNOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBmcmVlX2FuZF9leGl0Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV9hc3luY190eF9kZXNjcmlw
dG9yX2luaXQoJmRlc2MtPnR4ZCwgJnN3ZG1hX2NoYW4tCj4gPiA+ZG1hX2NoYW4pOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXNjLT50eGQudHhfc3VibWl0ID0gc3dpdGNodGVjX2Rt
YV90eF9zdWJtaXQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlc2MtPmh3ID0gJnN3
ZG1hX2NoYW4tPmh3X3NxW2ldOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXNjLT5j
b21wbGV0ZWQgPSB0cnVlOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2Rt
YV9jaGFuLT5kZXNjX3JpbmdbaV0gPSBkZXNjOwo+ID4gK8KgwqDCoMKgIH0KPiA+ICsKPiA+ICvC
oMKgwqDCoCByY3VfcmVhZF9sb2NrKCk7Cj4gPiArwqDCoMKgwqAgcGRldiA9IHJjdV9kZXJlZmVy
ZW5jZShzd2RtYV9kZXYtPnBkZXYpOwo+ID4gK8KgwqDCoMKgIGlmICghcGRldikgewo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByY3VfcmVhZF91bmxvY2soKTsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmMgPSAtRU5PREVWOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBnb3RvIGZyZWVfYW5kX2V4aXQ7Cj4gPiArwqDCoMKgwqAgfQo+ID4gKwo+ID4gK8KgwqDCoMKg
IC8qIHNldCBzcS9jcSAqLwo+ID4gK8KgwqDCoMKgIHdyaXRlbChsb3dlcl8zMl9iaXRzKHN3ZG1h
X2NoYW4tPmRtYV9hZGRyX3NxKSwgJmNoYW5fZnctCj4gPiA+c3FfYmFzZV9sbyk7Cj4gPiArwqDC
oMKgwqAgd3JpdGVsKHVwcGVyXzMyX2JpdHMoc3dkbWFfY2hhbi0+ZG1hX2FkZHJfc3EpLCAmY2hh
bl9mdy0KPiA+ID5zcV9iYXNlX2hpKTsKPiA+ICvCoMKgwqDCoCB3cml0ZWwobG93ZXJfMzJfYml0
cyhzd2RtYV9jaGFuLT5kbWFfYWRkcl9jcSksICZjaGFuX2Z3LQo+ID4gPmNxX2Jhc2VfbG8pOwo+
ID4gK8KgwqDCoMKgIHdyaXRlbCh1cHBlcl8zMl9iaXRzKHN3ZG1hX2NoYW4tPmRtYV9hZGRyX2Nx
KSwgJmNoYW5fZnctCj4gPiA+Y3FfYmFzZV9oaSk7Cj4gPiArCj4gPiArwqDCoMKgwqAgd3JpdGV3
KFNXSVRDSFRFQ19ETUFfU1FfU0laRSwgJnN3ZG1hX2NoYW4tPm1taW9fY2hhbl9mdy0KPiA+ID5z
cV9zaXplKTsKPiA+ICvCoMKgwqDCoCB3cml0ZXcoU1dJVENIVEVDX0RNQV9DUV9TSVpFLCAmc3dk
bWFfY2hhbi0+bW1pb19jaGFuX2Z3LQo+ID4gPmNxX3NpemUpOwo+IAo+IHdoYXQgaXMgd3JpdGUg
aGFwcGVuaW5nIGluIHRoZSBkZXNjcmlwdG9yIGFsbG9jIGNhbGxiYWNrLCB0aGF0IGRvZXMKPiBu
b3QKPiBzb3VuZCBjb3JyZWN0IHRvIG1lCgpBbGwgdGhlIHF1ZXVlIGRlc2NyaXB0b3JzIG9mIGEg
Y2hhbm5lbCBhcmUgcHJlLWFsbG9jYXRlZCwgc28gSSB0aGluawppdCdzIHByb3BlciB0byBjb252
ZXkgdGhlIHF1ZXVlIGFkZHJlc3Mvc2l6ZSB0byBoYXJkd2FyZSBhdCB0aGlzIHBvaW50LgpBZnRl
ciB0aGlzIGluaXRpYWxpemF0aW9uLCB3ZSBvbmx5IG5lZWQgdG8gYXNzaWduIGNvb2tpZSBpbiBz
dWJtaXQgYW5kCnVwZGF0ZSBxdWV1ZSBoZWFkIHRvIGhhcmR3YXJlIGluIGlzc3VlX3BlbmRpbmcu
CgpLZWx2aW4KCg==
