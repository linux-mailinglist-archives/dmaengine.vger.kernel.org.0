Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9C076035A
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jul 2023 01:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGXXya (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jul 2023 19:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGXXy3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jul 2023 19:54:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EDAE8;
        Mon, 24 Jul 2023 16:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690242868; x=1721778868;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v/6lAKHL49fQltPlR8tQgQxQDCqbVSR7w7GcDejnyhI=;
  b=FKtLP6RE2k0hZMe/imCDy0i4SaEEew26x3dH3aujHgRYOb5RIXtcVNG+
   wiul/3F4W3qKd/hVq+/Ik8jz1b9PJQx/CRYdSc/76d2zhGXEEAdvop5P4
   bm7I8xae4dj4R81s4xqPrxyUJX2Zkcifp8SJjeHnjRnVFcdz3+hntpnI1
   stIHoCJFSJ6rR8mlMMa0HnAoqOGiguEF4KvhJja5oGsqx2lkXCpkl3bZh
   2pYT+6BJ838uwSLB4oYC+VNpuvBfuRTW8TNJElMpHcubq9aP7x6LvXg2b
   QoY6+mKUPF/lS7+0kot1PbLXzMj2C/6LpJKt/+GtsEGv+PzT04/A6xMOG
   g==;
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="224932833"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 16:54:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 24 Jul 2023 16:54:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 24 Jul 2023 16:54:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+bBCl/YgSGPi4FFu5vuWYGbaZ/hdNMD8sCoGXHwLH9aKrGG46i/BcL4wzUviJ+rTKI+a4GV6mcSf6TTf4raE6GqkWnGZzEOISrscfOsbibvO6eMc/m3UXYkRZR4yvGPv6dVPt1n7IO0kxm/ePSNuimb/wL8m3+15Q0sU4ONO8TFU3c5DPpfoR8b+ha2bG2zQj5hArk4zRXiwd2D6KMwMx6A4EXt0TV2ibnBQuzAXAUfESlDCEGkNsAtTO7JbNAEA1zatrqgv25HEMlLub4MXnsBvbYrHJVYWNEzNX+MdgkB0rW/1x4ZTrsby06to1c4ASvdUvtYJcKhSAa2bwx4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/6lAKHL49fQltPlR8tQgQxQDCqbVSR7w7GcDejnyhI=;
 b=d1Epp/BAtKm4p72AEMp1f2eK8K441RIDIy74V+LDV7WXRLYuaaHtb4i3OI75asqS1n3hwF+WlORMf3LrXbYAwstcxQ3SDntx8bgm5ZrpYe21RCFi3Eqbwln5HDKQaQD8VeZHzObL0DNTg5pNOjXfEMKt0pB5StngYbE5o4Yjk5niQDVE+NPOMm6eKB3SYwWgZQAk+fMLkeH5dP5rRPW/EVkUbWqVFeRYb2Ifrk0OtMCpTcSyIg5Z+pcmK7upObVU/cYIevgzTvvxv/LIG1TSFNjdgmaMtorvH8NZrmi9H9ybBI6T/SvUpixWQeGR8PBSOKtzV7ciGadAdD4P5vwqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/6lAKHL49fQltPlR8tQgQxQDCqbVSR7w7GcDejnyhI=;
 b=LdyoKX/KCRGB7pTmjYljRUe4ljWeyrN0y4IqfBXV3hH3tt4q/I4Fb4zx6GwsN95tt2NA5XkGVr0WP3QrG6/XkQlePAWsBIZK7TdfEIPyeBpwsuwDeih88OvPHdIP96DkNF39EJSVUugFr6Q+ZBqiUCbp8dhMAk21g0k9sT0Z+sw=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by SA0PR11MB4525.namprd11.prod.outlook.com (2603:10b6:806:9d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 23:54:25 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::a386:9a15:9c19:3aff]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::a386:9a15:9c19:3aff%3]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 23:54:25 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <hch@infradead.org>
CC:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <George.Ge@microchip.com>, <linux-kernel@vger.kernel.org>,
        <logang@deltatee.com>, <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v5 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v5 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZibSHx5SO3XCpNUCUzf4fdZr/3a9hdPaAgAg5gwCAX9cGAIAAe2+A
Date:   Mon, 24 Jul 2023 23:54:25 +0000
Message-ID: <5b87e9dfd0221c9eea976648ebae420c910746fe.camel@microchip.com>
References: <20230518165920.897620-1-kelvin.cao@microchip.com>
         <20230518165920.897620-2-kelvin.cao@microchip.com>
         <ZGdb8c2JfPTRexJT@matsya>
         <0f04479bc1d0005f80caa984b83743653620555d.camel@microchip.com>
         <ZL6npI5YmWJOXB3d@infradead.org>
In-Reply-To: <ZL6npI5YmWJOXB3d@infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|SA0PR11MB4525:EE_
x-ms-office365-filtering-correlation-id: 8aef0431-66df-456a-3128-08db8ca14f41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lfFhZm3GijvyAks6KMd85jhe5r1WHzgx/EYG1RhuWgg7DkZJkSW39itT/moF5WGlCNENPagaDlYChBg6pqV6Jjz2HOwz8FKXPjsEaobTpBQyxvgpL/wuxvrF2jeHW3ODE/KSPrdicOqLq2GOjUXSsUZn3g+qfnirWt+59HK+Ac89tZpBQZ2OyLyy6fagicIXQyYXz2VuQGJ2j02rz5/OdZO8f6l8t+2p+gnbiboZyVGCsgSCUtFgF6ZYznuh3VRvWNWe55yF5jIno/0lXOWcSeAwfIkRokqJOWFuODY6p2kzRwYZSGxozuCBTrUNK3OOtstazN5Bkf9QGTaYp2FIzIHbOCdNAXZFdk8bB4ie1PLSp2PlZHIXH1XzbZ+3THt1i9ihcOA5dCUf+ffMqBNWxgFETrDWJ+HcsIn5czi1BfWKWIl+mhASIUR5FrfhqbzTzT62n1JLZuQzVcBctOhrAbzaYl50ye16A/XYDJryaOI02yVbzpuydmUazw3wwglpAjclUMEOQdyHHRNW5dVCkNnOo9sVVUzNCopT+c4EtKlg+5j5bdAVNIMD7RnGiobn63wH5I+XZda2a3bm6nOrR2eGvXJGQlICOUQahB6Td7RSclKkcPChxixIvGryKVx9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(2616005)(26005)(186003)(71200400001)(6506007)(83380400001)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(76116006)(6916009)(4326008)(41300700001)(8936002)(6486002)(6512007)(8676002)(5660300002)(2906002)(4744005)(54906003)(478600001)(38100700002)(122000001)(86362001)(36756003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGdHby8zQ0FPekQrV3hrZUFwSEpJYWFWRnFDc0w0dW1XYlNSaW9vdlEyUU5x?=
 =?utf-8?B?TkdYczZXMWp5WW5UUVU5N3ZxZTJoZDgxVkptZDkvY2xCQXRRUmo2MkNhcjBv?=
 =?utf-8?B?VXJaUmFndkpyWTBEZTR1bE1iYk9mSGhzWEVSRW1RYjk4bFhKMFcwOVJ1MTdR?=
 =?utf-8?B?V1l3SmtCeFZFUmFYY0NRMlY2Q0dFMzdpcUR3VlpFN29FZ2pRWjROdzJOS29F?=
 =?utf-8?B?NXAxMXlVbXFEeVF6Q0VaelJYRHBGQUkrSzM0SmlJYnVSRlZRVEtaNkNsYVI1?=
 =?utf-8?B?YjlLMkVMbFBEY3h4UWJQNmNLeXFvQTF4UExGTURKWXRYa284RExob2lXRG51?=
 =?utf-8?B?bEliUmxEaUtFK2FQektaSlFaa0FtZkQ0RjNCNWhXeDFSZUkwMk12VlZEUFZz?=
 =?utf-8?B?UDFQQ3Y2NUhTU2xmVG1LNHZnT2gxRUsxazhwTHhKZi93RmxQTzhndGYrbWZu?=
 =?utf-8?B?amJPMUZ4dlhaWDVYUGlBRnV3NjNiYnk2MW5Sa1dBV2Z4RmFwQW9nMTFSOC9O?=
 =?utf-8?B?QUdydUxPVThFdy9FdUQwWXRER3lhTWY0ampMOTJGT3YyQkxHUCszVHl5NWIv?=
 =?utf-8?B?OGhFK3RIdTZzWVBOMFl6TE91WVdvNlZDOEhKa1p4NDdDaWJlSHM0dU5zRXR6?=
 =?utf-8?B?eXB0NDVWVUhQSEo3SWtQNUpxQWJtWC9jTzRicjBkTWRVUnFlaUJyZytmN3pH?=
 =?utf-8?B?MnBJRTVHZ2JIL1RjYmxWWWIrMytIVklNKzkyRnFWMlBxMHFnOWc3TFpDb2d3?=
 =?utf-8?B?V0NCR2NQOW9HdTVUR0RCZVVhdjVHU0NvUTFjaHdlVkpHenAyYjRKTkxNbGlL?=
 =?utf-8?B?cnhlcjBENUVVdFQ3NGZQcThzQ1I5aW94bmpuMFdoTVJYVTlFN3JhU1VmVlMy?=
 =?utf-8?B?UkRETU1nUmM4bTRZUDQyYzZrRkhVQ1JNY1JhZlpMQ0lPaGRyMWFkVzRyMk1h?=
 =?utf-8?B?TjBIdnM5UHVoWHFCY29VZG5Ca3RzNFNOMVdOQ2llOXYzQ2JBVVZGR0o0Zmlm?=
 =?utf-8?B?amR1UTA4MzBMY2QvN2duVDVzWmMzelRrUk1Ed1dZSmQ2TEE2L2drVVQ3VGR2?=
 =?utf-8?B?UlVYNnNKOCtQalRxS0FlUG1tWnpUUy9ZZmNLaDNBQzUvN2lZT1FrL3owOFdG?=
 =?utf-8?B?bURsb1RjVTduLzQ1bWxpVjZVM3lFV1ZsWTF5U0cwMzZaaVZSVFlUY2N0V2FY?=
 =?utf-8?B?YnBjZ01qK21TUWFwSkJGQ2s5QXR1aFowdWE4QzRKZzM3N0xuWVh2ODVjdE1H?=
 =?utf-8?B?UjJxOGFoaDdaSmtvdm9BNnZJemc4QXE1QUM2ZmdPbWRNUURkSEdITmxxUDRX?=
 =?utf-8?B?QSszQnlLSVh2N3FCeXpRZjZRMEdtL0VDUDZDZ2NZai8rSHg3L0VwaWNSWUZm?=
 =?utf-8?B?c2wxbmZVRzlJWm52Q1dOM1ZzL0Y0UE41eTZya3c2OHB3QVdQQ0xZVitNSlda?=
 =?utf-8?B?c1NYVU9VNlFEcVVmWXU1K1FlNmdYZzQ4VHJJNXRIdEwyRU5ycmtkS0RGd2U2?=
 =?utf-8?B?aGtuZ29sNEE1bmFWNUNLUWlXcUxyWDM2eTJZWC9ETU5OV0Q0NXZDeklrQ2gw?=
 =?utf-8?B?aFI5M2ZoNzh6bFVOUE83ZWE1VktIajQ1WnU3SFZ5TFJpYmdrNVV5M2R3aTZu?=
 =?utf-8?B?TzBHSURTcHBLdERib0xlTkRQbVRRbXAxZkxidzBIeEp6aDFNU0tIL0pwa3cz?=
 =?utf-8?B?bWdyZGQzWHB2T1JnbW42MlFWQTE3K2ZObkRRcm84N2F1VUpwZmVNSVkrdXhJ?=
 =?utf-8?B?UGRoME1nSWJsNms1WWw0OExkTzVoVXE3VlBEc1hwb0NWek1xa2dQNlplSVha?=
 =?utf-8?B?VDN1VXBReEQ5dndadHU3bjlsNW9pRTVMYjRWWWpybG9zWExQcDJMYUZ2Ukk1?=
 =?utf-8?B?L1ZDMkVPUkx2YTNzL05kMU04WUpMaHVJbjFLQzV6NFcxWTdscFIweGMzZTNW?=
 =?utf-8?B?WGs4OU9JMmhRTXUrQW9WazJPazYzdVhlSE1ZV3lTUURnUG5wZEhvcjIzaEdZ?=
 =?utf-8?B?NWZEZmdZS2lPbDdOcXFOWXpMVUpPZmhKNXRzbjM5MUs3RzdkU0d2WW10WWl6?=
 =?utf-8?B?c2JUUnEvRWN0Z1c4cFhyZDZVRWRHdy93eWVuV2lKNjBXZlByMnorMVAreTNY?=
 =?utf-8?B?M3ZQZGoydDlBNVFIanU1dXBUQ2N4ZTBiSmcwOHk1azYxcjBIM1B3TVVMUS9H?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E33695334AC82D44A80C6C271C4B72C7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aef0431-66df-456a-3128-08db8ca14f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 23:54:25.0126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKZU3obfXWfLvtMskFtvVujHiRmTOqkEbPZAJN0RCND+S8UJSHPswveap6X+5ZDaq41dDpGDt/OsHvoNzdaGtfUtLJ8Ho5r+nScrxFtEgHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4525
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTI0IGF0IDA5OjMyIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBLZWx2aW4s
IGNhbiB5b3UgcmVzZW5kIGFuIHVwZGF0ZWQgdmVyc2lvbiBzbyB0aGF0IHdlIGNhbiBmaW5hbGx5
DQo+IGdldCB0aGUgZHJpdmVyIG1lcmdlZCBmb3IgNi42Pw0KPiANCg0KQ2hyaXN0b3BoLCBJIHdh
cyB3YWl0aW5nIGZvciBWaW5vZCdzIGNvbW1lbnQgb24gdGhlIGxhc3QgcmV2aWV3LiBBbmQNCml0
J3MgYmVlbiBhIHdoaWxlLiBTbyB5ZXMsIEknbGwgcmVzZW5kIHRoZSB1cGRhdGVkIHZlcnNpb24g
YW5kIG1heWJlDQppdCdzIGFub3RoZXIgd2F5IHRvIHJlc3VtZSB0aGUgcmV2aWV3Lg0K
