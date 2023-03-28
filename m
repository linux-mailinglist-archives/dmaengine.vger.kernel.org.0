Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36DA6CB8BB
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 09:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjC1HxK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjC1HxC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 03:53:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55EE4480;
        Tue, 28 Mar 2023 00:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679989981; x=1711525981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MMLJ55nzbDuYefjagbKEQ5r4d7wFCEcRJ+uhTX5nBh4=;
  b=WVJNj1E7HQYT82h1jDaXsGvgHR1K86v64G65ywk+0N8wWjpd1Nw9RMXQ
   KSOZfUuSoDkoLYagctGeIWLfNGIQhp49wnD8h09pcGFE4IfbbDFvLvIna
   yP63+Yp/GNAvL1JJjUYM12DyYFD0/zvxXW6slx9hmgmhHaJw0MDiaX9gt
   sr+F9GSde5+A8LB+D72EPvcoQ8129R3tGLvN4odwRM2PHVemHT53pBgVY
   NbXek3Psz3oE0dEp0oTbbhOCH65XA31u7jmqygEhkF6Qjxw1tsxIB12mb
   fKDGRNPZHtUzSqLAciM0Jw8QVkZ5jP+2aHXcah/3jQN4/LDQMxQeX7PR2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320898932"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="320898932"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="807771906"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="807771906"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2023 00:52:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 00:52:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 00:52:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 00:52:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 00:52:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcqMcyqDI4SXFZbZz7+WVcBS9Vt7j4xWjHHaSFnipPnN5V/IM5ovE4QoHKsHudhidrXSycBEfq7J7I/IO/aEIdCu6DNfU8AzGSXkH6F/eUXS1qODifEEXuXfgLyOtOqgwjic/XZXXcX6IjYKHRUXl9VwYuFmfGcIDD03SxhaIqcbBSt8r6Z6GHJlkNRtOriacu3QfsXDv5FSilrReXhqSaDOGQ7GnL1y5iwGMXYc/EQmpOie4Y6zIFv9abhdM1l4p1clHqbh+jhDubt2qBZenERmG5g5t845h4W0gBmwviyOzb+v/+fA5at0tDjDaea8KyPFefsKm2SEYvwXnJ8ldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMLJ55nzbDuYefjagbKEQ5r4d7wFCEcRJ+uhTX5nBh4=;
 b=WDKu5bXMgW+xc87YBjSJ/KF8wtQK7Miif2Y4Tq6Y7JU7QXGHwX0FWVknobOO/sH4bu3OZtoh6lYi1i7WKuYKkYXshIFuEEW/0qcn1vLvQ7IPuX6sorGBOzhvf6vUGgBQDow1nfCpqw2SHt7WyEpQmQjy2WHXVIj9RyZFRK+EZFMmfrL81/12cY/gkQOmrU1gwrvuP9jDIZOoQyuASY51DygCpkuM3OGPq/LH1yclJRROjSyqLH3ueiwNcQIHnciGoYJq2ZGUwPxQLt9w9yhZWh5Yf5Pz1RTVFSqmv7j+J76DO37oWWT+Kt7jXtzyTtFJ/eDdr2YfG//jhXbh31PTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB8197.namprd11.prod.outlook.com (2603:10b6:208:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 28 Mar
 2023 07:52:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%7]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 07:52:24 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [PATCH v2 7/8] iommu: Export iommu_get_dma_domain
Thread-Topic: [PATCH v2 7/8] iommu: Export iommu_get_dma_domain
Thread-Index: AQHZYQJZ/uTBrv6VnUyqe8oLESWJ1K8PtDuAgAAdlnA=
Date:   Tue, 28 Mar 2023 07:52:23 +0000
Message-ID: <BN9PR11MB527623AC2CE25EDA10FF81548C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-8-jacob.jun.pan@linux.intel.com>
 <e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
In-Reply-To: <e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB8197:EE_
x-ms-office365-filtering-correlation-id: 08096a5f-b408-4717-5388-08db2f615e06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0YO0lSSvNbYvInfTFxiQWDDuNCZ2EKLddXFgVKfdmUC8meev75QuROAITLnQtTH4jPMjc36sVMD7YanlucJwDF5IVT+MOk+DD4XUIYLawf10ESYGBK3xIm0XCdDuaEdF55pSi//ugcXaSwbyW0yv+G+8eILhN5hvfrr1qfTpmGfXlSTRtTlNxnJX0vygOlJiHFcRh59p315O66f9QVEYQQ9Cy6Uoi4IjKcl5YuBBngEIuxrRaBfj081P2D/Me2gX5XGpCFgOSe+ug3YpbB4cOvRMAy6GwLlVwpKzUHEzhoi3jh7K5CkHlXsDXv+adT/qiqsm0uUyEcJDSPEnQ5rz5diB4oVsmr94Vzg6VZ3JdOTaJXsuJ1a2Xazt/5i6UPavq3EMCDs/PA5db7kXcx08ARWUan0GHCl3Hp+G6UF5IRm5g5mXa7XtHHfQv3zRxzTos3ujEeOpQ1wcR3WexJ0KFwzz3zdL5dyA5aOUBWu13rcjokZfcaloPLGD1TGKyE8JAA15CFFy342/u2/5rke6hKCb9Hk8X54imhGGTgTA5iNziI+EpkOZdkr/6mADY3XnRVwXkdP+7At7638VMxmE35U0sX2eM6q4w/b6Zz6Cmi+peGqWVHgB4JWly5wjyDcz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(8676002)(55016003)(316002)(38100700002)(66446008)(38070700005)(41300700001)(82960400001)(66946007)(54906003)(122000001)(2906002)(7416002)(5660300002)(76116006)(6506007)(7696005)(71200400001)(52536014)(4326008)(53546011)(33656002)(64756008)(66556008)(86362001)(110136005)(26005)(8936002)(9686003)(66476007)(186003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZndSYlJmODlXdTVkeGRvN1JRYVlXeHdibDY0czliaTFxbE5Vald0dm9aTGVU?=
 =?utf-8?B?bFFiNzg0V0lseVk3MmZJWjhmU290d2FMV3VvTEN4S04vWEFBd09lQnRwd2tN?=
 =?utf-8?B?SEdCZjRBemJvSUdSNkt0Z2orZEJmL1JOSlhNY24rdUpDTVpnRVQ1SVBrQmR6?=
 =?utf-8?B?VzlNUFNuL2hUNlREVTZDbFUxR0JGWTdZZXJkdWVCNDRob01qSkxMS0d0c0dM?=
 =?utf-8?B?YkUzbXlLaUc5WVVjd2llTzFwVkFFODFCaDdDZmlwbm15cTdXc2d4UnREWUxl?=
 =?utf-8?B?czVLNmtNczY4Ty9xK05zUjdXdnhMTWNscUlnZloyMzVoM0t2L1czeUdxMmxp?=
 =?utf-8?B?WmdiZUlhNW1WQmlWcEIzbk1Ia2FwYzZlVnAzNS8xTjNOQjJXVFVUbTZRVk9K?=
 =?utf-8?B?aTlYK28xOWk1T1V1Zkh6OWp6K3NuS0pwZVJEUVdBK0d4M2pNdElsVk9nR2FZ?=
 =?utf-8?B?S0haNDhmOWN0NXdLTVFiNGpnVjdveWxPeUJGSU10MGRVbWpJWktpL01DT0JF?=
 =?utf-8?B?alhZdWJtZ0svMUQvbWVacFpjNWJ2YlpUWHlNU0tmWkVlNXNtQXE5OGN2TFZq?=
 =?utf-8?B?MVg4L1lCbkRVUmJaOWFXSGh0QUhTUGM5MFlIKzNuZHBWakxuU2xFb28xYzk3?=
 =?utf-8?B?VmZWakd3UDFmNEVSY0JmTVJEc0ptYWZWaWZMdURaY2pXMWNqdXhzdjhWL3Qx?=
 =?utf-8?B?ZVk5UzRrMUdTYWc1ZEY3cjB3WTNXdFU0bDNmeldLWU4vWmV3Rm15bXJSOEhY?=
 =?utf-8?B?eVBWT3RWajhOTFprTmZUbjN3b0hKN2NQaVBWY1Y4ZUlQTmJ4NU1CbytyVWh6?=
 =?utf-8?B?MUp4Mzl4bUhLNXdGdy8rclAraFo1ZC84UEthOE1lN2xoZUk3M0hMYndJVUQx?=
 =?utf-8?B?T0IrRmU1elNYOTI5TzZlbVh0NTc3Nk5NVTl4ckVKSTZKeE9XTTFQSEJ3OFdp?=
 =?utf-8?B?cmdhbXcrc0ZtQmdCREptR3RoblBZYzNrL1hWQzJoK0lqZlhuWFd3S05YZVZV?=
 =?utf-8?B?Y3BoZ2FnL2MvamRjR1FQSG5UUVA5dy94RnplVWZyYlNVM08ySmZqT1lFelFI?=
 =?utf-8?B?Nlo0ZzJYMHJpWUFuY2c4Q2JBZmZvMFJBMmJoYXIyWi9VanJNcWhIWko1ekJj?=
 =?utf-8?B?cVcxYW1ITmhGeUFjbEkwMEVFUEJOYTczU3lLWUlyck4wK09mQjdhL3BkNGJS?=
 =?utf-8?B?TUg4MmdabkIwMXpmTDNpWkV6cWhrTWdQTGhxeDhQaXYvWDhMTXMvWW0xbGd3?=
 =?utf-8?B?YXJsa3FvR0pGRzdGMHhmUFlsVytYOUtGWlY4YkdrRm94eExMRzFYU1c1NFdn?=
 =?utf-8?B?MnJETFBwRUszWHZQVnc1S1hLNjVmNGo3cVpMMk5FYTQyZFZVbTZNdTFJejVF?=
 =?utf-8?B?bmZsYkRMZFFQQ2xZa1l1eTZFRTZuWkFSajdteDhxNTVXTkgyRzBoYUk3WUFu?=
 =?utf-8?B?NFRYNHQxVkRSUy9LV2tqZktSaUpGdXZuQXZJQ0Vtb1M0VUlYbytqc0tCc1Nj?=
 =?utf-8?B?WWVIa3ZFNjZHQlE2WFl6TDRLcG9nYk4zV2pQMTN1SisxUEVVbnhhZ0pxUEgy?=
 =?utf-8?B?Q3liWFJPZTVieG8wZnhmK1hheHVHSjF6bzk0RUpTeGNCQWRGdFJQY3AyejUv?=
 =?utf-8?B?UGJ2d285Wit3Nis1N0RsZENYVW5iRDF2UjNwNUxJTnBpSjBiUlQxYTlneisv?=
 =?utf-8?B?ekZFQlVoYjhUUnBsVDQ3MzdrK1N3WG5PaHJKWE5DZGo5c2oweDFxdzRKQVpE?=
 =?utf-8?B?RjdkQVlSZjFyV0l5SkJ1Q3FMRlgxamQyVWJweXFqYTB1L21BbDJVaVByS2w0?=
 =?utf-8?B?TmpKWTNPTS9tRE1jNldYdEkwQVJHV1I4QWhWMW1EVzRWR0JSRnMxSlAyZ1Zi?=
 =?utf-8?B?dHN0Y3k1RkJTTmhwcVFBb0VJWlZiOFZZN0luUU5md2pXSVhiYTVzMzdYeDBS?=
 =?utf-8?B?cDBJaUlpWnJRRVNrZWNGMXB3U0srQTQ3K2granFuM1ZxZ1RkMnY0VkM5KzlJ?=
 =?utf-8?B?QkdXM0U0NVRVU0Zhc0lVWjRyUEtrSnZsVURKRUtiMlpUZGF1QVByL1FQTzJx?=
 =?utf-8?B?RGNGMlRtVVBpenhhcUFvbGZIcE5jZXU5N1gzSlhzWUxUTHhuM2JTaEF2YU4v?=
 =?utf-8?Q?YbDOScRCrBNTbRqtvrjKez+n5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08096a5f-b408-4717-5388-08db2f615e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 07:52:23.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AV5coM7Mvzo8cq11ldtWFWvEqYyMbAMy3k/vrPsU93cOvWNwhWgYayxmACARGc4woIt1RNah2TZSPs1i7qwswQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8197
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBNYXJjaCAyOCwgMjAyMyAyOjA0IFBNDQo+IA0KPiBPbiAzLzI4LzIzIDc6MjEgQU0sIEph
Y29iIFBhbiB3cm90ZToNCj4gPiBEZXZpY2VzIHRoYXQgdXNlIEVOUUNNRFMgdG8gc3VibWl0IHdv
cmsgbmVlZHMgdG8gcmV0cmlldmUgaXRzIERNQQ0KPiA+IGRvbWFpbi4gSXQgY2FuIHRoZW4gYXR0
YWNoIFBBU0lEIHRvIHRoZSBETUEgZG9tYWluIGZvciBzaGFyZWQgbWFwcGluZw0KPiA+ICh3aXRo
IFJJRCkgZXN0YWJsaXNoZWQgYnkgRE1BIEFQSS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEph
Y29iIFBhbjxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRy
aXZlcnMvaW9tbXUvaW9tbXUuYyB8IDEgKw0KPiA+ICAgaW5jbHVkZS9saW51eC9pb21tdS5oIHwg
NSArKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11
LmMNCj4gPiBpbmRleCAxMGRiNjgwYWNhZWQuLmM1MWQzNDNhNzVkMiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2lvbW11L2lvbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMN
Cj4gPiBAQCAtMjExOCw2ICsyMTE4LDcgQEAgc3RydWN0IGlvbW11X2RvbWFpbg0KPiAqaW9tbXVf
Z2V0X2RtYV9kb21haW4oc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAgew0KPiA+ICAgCXJldHVy
biBkZXYtPmlvbW11X2dyb3VwLT5kZWZhdWx0X2RvbWFpbjsNCj4gPiAgIH0NCj4gPiArRVhQT1JU
X1NZTUJPTF9HUEwoaW9tbXVfZ2V0X2RtYV9kb21haW4pOw0KPiANCj4gRGlyZWN0bHkgZXhwb3J0
aW5nIHRoaXMgZnVuY3Rpb24gZm9yIGV4dGVybmFsIHVzZSBzZWVtcyB1bnNhZmUuIElmIHRoZQ0K
PiBjYWxsZXIgaXMgdGhlIGtlcm5lbCBkcml2ZXIgZm9yIHRoaXMgZGV2aWNlLCBpdCdzIGZpbmUg
YmVjYXVzZSBkZWZhdWx0DQo+IGRvbWFpbiByZW1haW5zIHVuY2hhbmdlZCBkdXJpbmcgdGhlIGxp
ZmUgY3ljbGUgb2YgdGhlIGRyaXZlci4gT3RoZXJ3aXNlLA0KPiB1c2luZyB0aGlzIGZ1bmN0aW9u
IG1heSBjYXVzZSBVQUYuIEtlZXAgaW4gbWluZCB0aGF0IGdyb3VwJ3MgZGVmYXVsdA0KPiBkb21h
aW4gY291bGQgYmUgY2hhbmdlZCB0aHJvdWdoIHN5c2ZzLg0KPiANCj4gSG93ZXZlciwgaW9tbXVf
Z2V0X2RvbWFpbl9mb3JfZGV2KCkgaGFzIGFscmVhZHkgZG9uZSBzbyBhbmQgaGFzIGJlZW4NCj4g
ZXhwb3J0ZWQuIE1heWJlIEknbSB3b3JyaWVkIHRvbyBtdWNoLiA6LSkNCj4gDQoNCkFncmVlLiBU
aGUga2VybmVsIGRyaXZlciBtYW5hZ2luZyB0aGUgZGV2aWNlIHdhbnRzIHRvIGdldCB0aGUgY3Vy
cmVudCANCmRvbWFpbiBvZiB0aGUgZGV2aWNlIHRoZW4gaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2
KCkgaXMgdGhlIHJpZ2h0DQppbnRlcmZhY2UuIEl0IGtub3dzIHRoZSBkb21haW4gaXMgdGhlIGRt
YSBkb21haW4uDQo=
