Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755917D3D2D
	for <lists+dmaengine@lfdr.de>; Mon, 23 Oct 2023 19:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjJWROs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Oct 2023 13:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJWROq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Oct 2023 13:14:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D6310C;
        Mon, 23 Oct 2023 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698081284; x=1729617284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hXwvadPnoYCnPLalzsmh+sBG1m+WcgwJ9jaQtXZEWZg=;
  b=ZNhh8I3iXfIlTbvDeeVGNhSQgwt2+W49KcTJa0yktQvErMcP9N9cijlp
   wAjp4wwfV4MfmgmCTCJnC2q7gRL8Xzmy/rb60bhgRueRkQjyPR0DGm3Bt
   AlOYQve6EILoB/uYpRunZoc0WmD8eOli7ovEdOvVpBj+rVxJxRIqeErwI
   TdlCtSAJL8fXL4jE8Aiy+595dCDPkfS6Se5Ai7WNNmfoyYnI1+8acqqvn
   l32QUtelv2xYbbv9aoJuWPfckrSTglz5S92JBfJUGxrSh/DELFmfGckVo
   UmrxHa9RF0p4n94Jx+ujz2Yr3mHOOXZy+Rnl1nPozm5hrJMfZocSFL9Ke
   g==;
X-CSE-ConnectionGUID: BFFPArKvQgC0CpNpEmrzsw==
X-CSE-MsgGUID: +ZEYZ1HxRTK8uC7yy3agYg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="241215411"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 10:14:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 23 Oct 2023 10:14:22 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 23 Oct 2023 10:14:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPdACFAUsPnP6FdhPaRtO0yLnlKfAWB972XDeKoaXuGTY7j46zKEPhxr0Ng5hF51lhQGZeIKLBhFwGpH0/KZ59p4Yy9HzSSeLTzM06URNoqUcAgEq8BuHDt4m7xJHCnSikQNG9hs++B1oqHHe9/KBC0+kah3h/ouFWnTJOnH+jY7aPjmWQbGYjhpaJ0zeAGbTCDQU03ywd3pCvG3e2vaHB1NhdzvRINPaHgkx0WvucehMRgdljl3sYxjoNOXeUeUOYl5OEp9/r6I6XOEBfhOyB4L8LYkSLKLUEYrG4wDmf79LRWG0O+QYzp0LX3Zr72iV8BdV1tt6jlABx1R1js5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXwvadPnoYCnPLalzsmh+sBG1m+WcgwJ9jaQtXZEWZg=;
 b=RV8n8pad5NA7TOc1ebCme0IDKYJckNiHDuPtCkPPM3JH4/IcMZtXnV4Rmpklc5dx+LFNGElFefkpzQE5khJAFyKn0gjSKqV6zXF1X+gjcPtAQ4H4wtYvOwcacNcyGldQcrZuplnU/N/nyGKP+5D4vaqteTkgek3Ln8f5DRi8aDR0+V0iEs1lKSc+jlF1lAImKS4T7mGhc0FnxhWc0dnHH0sUzZyeOIPmwabgYTu/Eu1jNSKvCOv32ypYYN02+/W1eUnVrvMfSM7DpyEU+ifF7GR029RrTtAlmlmGfgyUkYL80Wkl+VIPJLidtd0nbafASQ0aOlYcc66RkdhKA/s3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXwvadPnoYCnPLalzsmh+sBG1m+WcgwJ9jaQtXZEWZg=;
 b=RxWgfG8zUJW5KeVGjGk6es+0kfbKQeraABvi50aehstGYTDExGRNpDp0FcgrLzBoJk63nrPiaWF2CHwfjQG3z+ffy4Ff5xJdq0DBIGUwXNMiu5yBlpgelqRrgdrSHj/i62byVmeXAz4KegRrCyMKUsxCgRcANxxpmBZZoc3PGNA=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 17:14:20 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::8481:9086:7c95:9376]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::8481:9086:7c95:9376%5]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 17:14:20 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <George.Ge@microchip.com>,
        <christophe.jaillet@wanadoo.fr>, <hch@infradead.org>,
        <linux-kernel@vger.kernel.org>, <logang@deltatee.com>
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZwZllP9AErauFFUmKz13YRSBKD6/VzMKAgAIhf4CAZAP1gIABCsYAgADKTQCAA5sdgIACmkmAgADx6oCAAFB+gIAS5mwA
Date:   Mon, 23 Oct 2023 17:14:20 +0000
Message-ID: <b5158f652d71790209626811eb0df2108384020b.camel@microchip.com>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
         <20230728200327.96496-2-kelvin.cao@microchip.com> <ZMlSLXaYaMry7ioA@matsya>
         <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
         <b0dc3da623dee479386e7cb75841b8b7913c9890.camel@microchip.com>
         <ZR/htuZSKGJP1wgU@matsya>
         <f72b924b8c51a7768b0748848555e395ecbb32eb.camel@microchip.com>
         <ZSORx0SwTerzlasY@matsya>
         <1c677fbf37ac2783f864b523482d4e06d9188861.camel@microchip.com>
         <ZSaLoaenhsEG4/IP@matsya>
         <f6beb06cc707329923cc460545afd6cfe9fa065d.camel@microchip.com>
In-Reply-To: <f6beb06cc707329923cc460545afd6cfe9fa065d.camel@microchip.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|SA1PR11MB8279:EE_
x-ms-office365-filtering-correlation-id: cc7a55a9-f87b-4b20-714b-08dbd3eb7eec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vMtSqKItlcClwAQhnnjvTK/k3dGHWBcrS72Odi8jE7+qCYzDgkLPaziIa5yjdgmNDCJ+b2j+suL0RbQ9dveS8yDf1veVPgnTFehZO6kxim6uFTPWjP4BNftvOXDoLo0596OuCrxTy2oVJTbOMD+wF6NwqbNN4lPFbQE7syjGmlIIpWCujSGgj75w8ue52VkKZi45dnEnFRMDnmyUNij/WqmH6s5c9VzsLhcuuCgRM2/xRz9lgFJw8hFAWOYfs8wPJYPMV54tZxJA/7Zj2SZRHiOuzlewshtNHDwnG9UD129RPkOQ4XHpW4i5PpRKgJoM8bi+lfCT+BkbpA2yXMukLO1y7FixX1fnRNBqMbf8XA0tBeeZeai0ZdYPUnJZU8JwdP9oGbCJzy9cxBNQsGjhu6Q8KspF03EQ3WzyyVSTkKHsLK464mX3Q2ghS+0yTqUXR7tLs4JDt9LD5AzQlCnGnqm0yrzqk+XDzECK/unLAztTX5aN6OaORhze9ymVge49fboamMW/A4MT4//UWLATTzAku74bi2QjPe8dYtw0eIptHB0/m6tbF6fEhevcAD6lLFSP4REr/ARivlO2XQCHuGmqLXRe5rtksVZ/btDOQJzaLo639G0FgTPRkapBSvbG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(38100700002)(76116006)(66476007)(66556008)(6916009)(66946007)(2616005)(66446008)(64756008)(316002)(122000001)(54906003)(6506007)(71200400001)(478600001)(6512007)(53546011)(83380400001)(6486002)(36756003)(5660300002)(41300700001)(86362001)(8936002)(4326008)(8676002)(26005)(38070700009)(4001150100001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHRBU1h0QXdMRG1ma0ZGdHpGcXdkTy9Sa0x6TG5DNkd4R0taYVZiNXRKV3V2?=
 =?utf-8?B?NkdJRXV3UmtocGdvbnEzWDM5MEN2V0xUS3IraFB6K2l3ZGk5eUtvTmNXTUIz?=
 =?utf-8?B?M01GZHZ3UzNrcFoycVdxVHZzL0lhNkszUW50dnhaeEp0eVVTdnJ0Mkt0ZDFp?=
 =?utf-8?B?VGdTTlhzS0N2Z3lUZ2wyOU5PTXhraG5Tbm5JSmovL1RFbXlmcllCSVVTajlM?=
 =?utf-8?B?Y1NZUkdWQm1GaHR2SzYyTStJYS9yVHRiZUwxNllrWkovWmhzMFdPNDAwZXpJ?=
 =?utf-8?B?djVxT25MbFArZjlQU3cyTTRDbmhyS21SUGpPd1FITGd2SFdoMUhURWJneXZr?=
 =?utf-8?B?eW9SOWNhK3JSclN2VGJhcGZ4Um9rUzBOQXRiSnZYeUFDODh5VjhEZDh4ZWRo?=
 =?utf-8?B?VUIzZGc2SlRuV0pmNEVJcVhlTTl5RGVyQTROTGR0Uk5xeEIyYmJuYjZDb3lC?=
 =?utf-8?B?NGhsajNNbmtKQWxVVVN3TXpMbzFodnFXUzMxUW1USUx5QTlpNnVXR0pITE00?=
 =?utf-8?B?K29mb1luRTlXZDZoaHVTb1hSVmVnekRjcENwL3dtQ0cxK2lSYWVVdUMrdGQy?=
 =?utf-8?B?dlhneUMvelptRlpzcjI2WlY5aEtzOEp1Zkw1TjhGQ2JDVUoxS1JFZmtCTUdJ?=
 =?utf-8?B?UHFmSVJMTEdRYnE2VnMybWFncGZZNVV3RDU4TGNKNXhWb3UvbDZLYng1WkNm?=
 =?utf-8?B?RGJtZDQzVlZtdjZKMEdQOGp1VkMwT25DOEE1TWYreDZ6ZDRic0wvOTBzdVJQ?=
 =?utf-8?B?Y0FjdmFuQ3hVUWRkY0UyTUl3ejI3UW9XMUJ6c3VMVlJYTUFXTzQzQ1g2S05R?=
 =?utf-8?B?cHJBYnVjOWlVeHhiVUZZR21iUFJEZzk1ZUJ4YTZCZ1FzaGlHTEhLRDAxSVdV?=
 =?utf-8?B?cGVocWVHQUxWTGNrNEtsRW0xM29tb2FJdkxrVy80a2RmU0hhaWpZb1NEQ0k3?=
 =?utf-8?B?M0xJQ2laUkxqYXBuYVh0TGdmSVVESXNtMGwwa1BIMXBmZ25vQnJtcW4xL21h?=
 =?utf-8?B?N2hISUs5TWplWUc1N0k0bGt0VUxsdEZjKzNnckVzSVZKaURKSzZReUZkMjNr?=
 =?utf-8?B?eWVBY05Za0tIQWorTGlsZlI4VVBEdHRHbHlKWWh5OHJDMGRpNFZYaGc1a0ZE?=
 =?utf-8?B?VzV0cmttdUh2UCs0bmZpOWZYN2llS1o1WllzMENKR2c1MU1nQ0g5d21rSDY3?=
 =?utf-8?B?YTRrZHJBTVk0RlNkVnA1cm1kSGwwNzQrMEd0NTIyQkIrckJPTXg0VHJZZDlZ?=
 =?utf-8?B?bXJlWlE1V2ZLYzRKeUxJQzFjL3BxeHpSQXZwbWUvVlBPczZmTmhFRnFvRU9W?=
 =?utf-8?B?S0J0cTNrYWNyWjU0bzZZbWtoRkZhNHJVbHp4N2VNb2pPQ0wxUmkzdDc2NkhM?=
 =?utf-8?B?RENPcUNWck5RTFBReEVRcW1UNU1MRzYvNlA5eFYwSlFWRlNtWWJzSHE5cW01?=
 =?utf-8?B?K3hxSDBPRnlYTlc1RW11Z2VOU2RVQ0Z0U1JqRFBBUUl5WCtjYzJURGNyRHhh?=
 =?utf-8?B?cmx1Z3VKT0tudERHZW4weHk1NWhwUGVPNFBFUW1HWU8wMDlJUDB0TlVRcjNo?=
 =?utf-8?B?SUQvRk5MR3gzelZrTStuVmdidW5SYmJFSDB2NG40SGh5d2c4U0wrZy96L3N0?=
 =?utf-8?B?L2RGcFlyQnVXRHdXZzBVZ1FvSkZyK1I1UTRUNEVvRDU3bFdyMzdYamNTVG5Q?=
 =?utf-8?B?T3I3S1NXc3FqeEVXdnpNcUwwdnlxejZ4d2cycURhUzdtazBOVVkzQmp6aG9t?=
 =?utf-8?B?RUpieHRaSnZvRXlGcmN6YTlDakNvMkYySjc1L3d6ZXp4U2tVUThZTzZHazN2?=
 =?utf-8?B?V3IxMUlPMkt6TzZlQTIvZGwwWkFNL0JNb1ZvZk92TUFCRzREbGpmQWRWS0NX?=
 =?utf-8?B?WlJjU0xhOFlwQ3p6RTZvN1VJbkNwQ1YwMHE5RDR2UmdDdmh0T01VRzIxR2NI?=
 =?utf-8?B?V1FkNUNpVkV3aENKTGY4Qm02eWhrWGIwWnFuMXNMUlVFYjN6dkFCMWhxZHVy?=
 =?utf-8?B?aFlEaEg3WEVBTTg0UG82MnpIa3lNTXFhcTZZNk1rR21zQUVpd1o5V1ZqcDR5?=
 =?utf-8?B?TlNiV1FURjVyRENrbDdpS2xFY3N5VFZ4cWM0dWdhMjE4Um0vdmh2U3IrVzcx?=
 =?utf-8?B?VUtsd0E0M2RGWFNPT3N6cG9WcHJadHhoZGhadDA1WDVaajloWlZJVmpVTUpx?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1086B17C7FEF8044BD64A470EDAF31EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7a55a9-f87b-4b20-714b-08dbd3eb7eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 17:14:20.3056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8gmtukruuGje+k8n3IEdsURzvs3ILE4eg5V95JTRwrn/EQ2ZoALJAoPBzI0Wsgiv1zofGftSap4/F/2VAae2p9om4M0N7VdbqtmCYZqrw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8279
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTExIGF0IDE2OjM2ICswMDAwLCBLZWx2aW4uQ2FvQG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4g
T24gV2VkLCAyMDIzLTEwLTExIGF0IDE3OjE4ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiA+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91DQo+ID4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+ID4gDQo+ID4gT24gMTAt
MTAtMjMsIDIxOjIzLCBLZWx2aW4uQ2FvQG1pY3JvY2hpcC5jb23CoHdyb3RlOg0KPiA+ID4gT24g
TW9uLCAyMDIzLTEwLTA5IGF0IDExOjA4ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiA+IA0K
PiA+ID4gPiA+IHU2NCBzaXplX3RvX3RyYW5zZmVyOw0KPiA+ID4gPiANCj4gPiA+ID4gV2h5IGNh
bnQgdGhlIGNsaWVudCBkcml2ZXIgd3JpdGUgdG8gZG9vcmJlbGwsIGlzIHRoZXJlIGFueXRoaW5n
DQo+ID4gPiA+IHdoaWNoDQo+ID4gPiA+IHByZXZlbnRzIHVzIGZyb20gZG9pbmcgc28/DQo+ID4g
PiANCj4gPiA+IEkgdGhpbmsgdGhlIHBvdGVudGlhbCBjaGFsbGVuZ2UgaGVyZSBmb3IgdGhlIGNs
aWVudCBkcml2ZXIgdG8NCj4gPiA+IHJpbmcNCj4gPiA+IGRiDQo+ID4gPiBpcyB0aGF0IHRoZSBj
bGllbnQgZHJpdmVyIChob3N0IFJDKSBpcyBhIGRpZmZlcmVudCByZXF1ZXN0ZXIgaW4NCj4gPiA+
IHRoZQ0KPiA+ID4gUENJZSBoaWVyYXJjaHkgY29tcGFyZWQgdG8gRE1BIEVQLCBpbiB3aGljaCBj
YXNlIFBDSWUgb3JkZXJpbmcNCj4gPiA+IG5lZWQNCj4gPiA+IHRvDQo+ID4gPiBiZSBjb25zaWRl
cmVkLg0KPiA+ID4gDQo+ID4gPiBBcyBQQ0llIGVuc3VyZXMgdGhhdCByZWFkcyBkb24ndCBwYXNz
IHdyaXRlcywgd2UgY2FuIGluc2VydCBhDQo+ID4gPiByZWFkDQo+ID4gPiBETUENCj4gPiA+IG9w
ZXJhdGlvbiB3aXRoIERNQV9QUkVQX0ZFTlNFIGZsYWcgaW4gYmV0d2VlbiB0aGUgdHdvIERNQSB3
cml0ZXMNCj4gPiA+IChvbmUNCj4gPiA+IGZvciBkYXRhIHRyYW5zZmVyIGFuZCBvbmUgZm9yIG5v
dGlmaWNhdGlvbikgdG8gZW5zdXJlIHRoZQ0KPiA+ID4gb3JkZXJpbmcNCj4gPiA+IGZvcg0KPiA+
ID4gdGhlIHNhbWUgcmVxdWVzdGVyIERNQSBFUC4gSSdtIG5vdCBzdXJlIGlmIHRoZSBSQyBjb3Vs
ZCBlbnN1cmUNCj4gPiA+IHRoZQ0KPiA+ID4gc2FtZQ0KPiA+ID4gb3JkZXJpbmcgaWYgdGhlIGNs
aWVudCBkcml2ZXIgaXNzdWUgTU1JTyB3cml0ZSB0byBkYiBhZnRlciB0aGUNCj4gPiA+IGRhdGEN
Cj4gPiA+IERNQQ0KPiA+ID4gYW5kIHJlYWQgRE1BIGNvbXBsZXRpb24sIHNvIHRoYXQgdGhlIGNv
bnN1bWVyIGlzIGd1YXJhbnRlZWQgdGhlDQo+ID4gPiB0cmFuc2ZlcnJlZCBkYXRhIGlzIHJlYWR5
IGluIG1lbW9yeSB3aGVuIHRoZSBkYiBpcyB0cmlnZ2VyZWQgYnkNCj4gPiA+IHRoZQ0KPiA+ID4g
Y2xpZW50IE1NSU8gd3JpdGUuIEkgZ3Vlc3MgaXQncyBzdGlsbCBkb2FibGUgd2l0aCBNTUlPIHdy
aXRlIGJ1dA0KPiA+ID4ganVzdA0KPiA+ID4gc29tZSBzcGVjaWFsIGNvbnNpZGVyYXRpb24gbmVl
ZGVkLg0KPiA+IA0KPiA+IEdpdmVuIHRoYXQgaXQgaXMgYSBzaW5nbGUgdmFsdWUsIG92ZXJoZWFk
IG9mIGRvaW5nIGEgbmV3IHR4biB3b3VsZA0KPiA+IGJlDQo+ID4gaGlnaGVyIHRoYW4gYSBtbWlv
IHdyaXRlISBJIHRoaW5rIHRoYXQgc2hvdWxkIGJlIHByZWZlcnJlZA0KPiA+IA0KPiA+IC0tDQo+
IA0KPiBPay4gSSdsbCByZW1vdmUgdGhlIGNhbGxiYWNrIGFuZCBjb21lIHVwIHdpdGggdjcuIFRo
YW5rIHlvdSBWaW5vZCBmb3INCj4geW91ciBjb21tZW50cy4NCj4gDQoNCkhpIFZpbm9kLA0KDQpJ
J3ZlIHN1Ym1pdHRlZCB2NyAodGl0bGU6IFtQQVRDSCB2NyAwLzFdIFN3aXRjaHRlYyBTd2l0Y2gg
RE1BIEVuZ2luZQ0KRHJpdmVyKSB3aGljaCByZW1vdmVkIHRoZSBjYWxsYmFjayBzdXBwb3J0IGZv
ciB3aW1tIGFzIHlvdSBzdWdnZXN0ZWQuDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhhdCBsb29r
cyBnb29kIHRvIHlvdS4gDQoNClRoYW5rcywNCktlbHZpbg0K
