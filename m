Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D6C6A907C
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 06:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCCFgK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 00:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCCFgJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 00:36:09 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFD715C8D;
        Thu,  2 Mar 2023 21:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677821767; x=1709357767;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5GM+P7l/W/RVx+yQ1o288tG4sVBvOwkgbdznC4Xsyx4=;
  b=mZai8cyZSWSz2Ce8tkro1xpAqbyQBpl9MLzocXMVEzDPBAgskKAVQCxK
   mle0YLefXlW+BYkud7+S5KeRqN7dr2yjGm6H69Rq/o6lUBEgUelv8qWHK
   WyNjg76RrtI0yGbDQD2y0KqJE34vTO/HqBt3zTj4ttu+IK5EqO1snZTk3
   rE3b6sO5oMn62IfeCs8ehvc6Di8RR8djLrFpaV83J9OSoX4OLdZaPkhXY
   9GGHPWfc8cjYO94vOCbxc0idIw0n9NWfZzkSchxlVL0E0/Vmb6ZRBSGPf
   AIPbK8nES+A15GmVM5MzvxlrEDCKIHQf2myHskhyOAtfYqjAg40Qjq5Uw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="318783354"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="318783354"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 21:36:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="764292686"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="764292686"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Mar 2023 21:36:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 21:36:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 21:36:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 21:36:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMziXUt4pa+saNPN///9lqlqtWvsn74Q8aKaAb5uKFIlGevky+yI7yOqG0sL0671FJbz9Nugb3dljUSy/2p1GOvFmv0+u4hii1EfWfh5Ypo4fDtmZ//VV2FE22OxaMwMA8jH5vlQtsnJKmarhhoIWnhbYMoTbQMgPd/6eyF/SXCE0yXFhAi6vtE8g9ydTMYL7bAu0/TD1Diefurma1bkeOXDzoqaFZrwSZT+UUahA9gRxlBZ+3v6vbHpcFss1QE/P3CgDF3oad1qnAHgV68D7POny4BbfsVyQZe91eh2OrmAYt/K5U6Pwz8AFKKNU3MQAD3qqI1L05VcskzwJqWJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GM+P7l/W/RVx+yQ1o288tG4sVBvOwkgbdznC4Xsyx4=;
 b=mSQom6ii/uYJZxzuwZOMSW774YIqebgdABKY5vuyhhueCgun2VqCGOMnq6C6N9pK03NfbjS2foND5OC98OffDMoxIdHdqN9bRGq0BafUbuhKO1lftPv8fYIjt2BAeuSTHAqOGVpsyqH+dqkDpBiNcJ5LBSPW4Zs9DYt/A1hcw6HNlLRTt+3b3C/uhsswPJfkE629KCNUsDpcGLJ2EZAvw9TRH+rYLxyB1pHws8jK1SS5MC67p+Kqgx4vaqCJNZ7g79fgoZAXzhBKxNNqjon/CrEuIkEW4JLb2rIQaAcAqKuZPXDY5zTKSghwwaoxUSDsvbjj0KzR9v7rP+5Smb9JZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.25; Fri, 3 Mar 2023 05:35:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 05:35:58 +0000
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
Subject: RE: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for default
 domain
Thread-Topic: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Thread-Index: AQHZTKHOquacUFj9QkCYXpGTEWy1oa7nhycAgADP6oCAAAT4AIAAAWnggAAdQYCAAA+5wA==
Date:   Fri, 3 Mar 2023 05:35:58 +0000
Message-ID: <BN9PR11MB5276E48AA1680C76A3ED66AD8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
 <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
 <BN9PR11MB52762957011E60E935E82CC88CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2c9115d0-f251-c284-63d6-73714edc96b4@linux.intel.com>
 <BN9PR11MB527634EA1ED5067D1FC0D7C68CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7f8983c8-b703-4960-67b5-97f4053329db@linux.intel.com>
In-Reply-To: <7f8983c8-b703-4960-67b5-97f4053329db@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6336:EE_
x-ms-office365-filtering-correlation-id: 6eb3ced2-fdfc-4445-8302-08db1ba92aa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RLuhHianQITN/ifP+5BKMEce3hyeI7ztMfKBnQxTi3o/Pvl87dQVdSXThtvXyIyX21BtnimhA4z2MawFwNeTCrvGjEGEIzO6RJ/LhTAFjfeAVMuB1bfjFVT9/BoNcqMZlHDv12DRFTZMEQPGLhSOHk2o5VYkCJrrwH3HeDniHUCxTggTsnz5PqWQRs7Ofj4JytVSoTJpHFO2rEysLljLECidu74AQKm2yfqIq6Qt4xCLurDzfl5/Undi0NNcnWBNOfEjjFRhsRdCSAnGUGkXrpZ5u263jR7GIW1NY6gxacchp/byyM6p43A9Qp7j8N9rTBWUoWnrEktNIjrCtMZm5ddMFb4YJ4F1k3rG8ZxSGzohCp1ONlNjIbAmOKKQnmF8jJhUYqa4TrfwtPc5qfbkosOODBhMirSM4tK+FFh1oVmlcwSTlwLjrZutOJYW2BrjldGXvotxvsBtyVmmiLTa1JwHXlW1VUjoN6BlhQqYXdb0j8hTtYBxV1jW6/W/kVAdGBGHSgf6jFhnIerwDykfYE2PCNus2PfPHG073gDKzDU9LUxZHw6onsnNygWrYPUy7Iq8nOWi4zdttgYqof4KHgrR1+HMPyyRYDLkYlfjKzB3xnSwsbd0ctVQbmdaN5H9PIdfa+E0MjxulkFgGCwxgz9xfeIwPExEyVig/wHSQkXMOqEV0PNvz1uVVNPJqcLI7OKtlHbz5xAyuGRgcH/5mQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199018)(53546011)(9686003)(6506007)(26005)(186003)(86362001)(33656002)(38070700005)(55016003)(82960400001)(38100700002)(122000001)(41300700001)(66446008)(52536014)(4326008)(66476007)(64756008)(66946007)(8676002)(7416002)(66556008)(76116006)(5660300002)(8936002)(2906002)(71200400001)(7696005)(478600001)(54906003)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVByUk1oNm1rakRMTVgycC9YdWJkSEgrR3FoMDhBTnVvVERJOXhoWlJOZXNa?=
 =?utf-8?B?dVoxLzZiMExkbHlOcVl4SWU1Und0U1VFZURRdjNSbzRCSkxLdDlOSVdpNElT?=
 =?utf-8?B?MDhCZmJEUHRzWjU0WkxCeWxqS1lqdWRIMVBMeW12dUxyRGNvd3Yzc050UVBw?=
 =?utf-8?B?b1U2d1FraTBGUFFTWGxvQnhUeGw2SUF5Mjl6d1BrUFJmSjJlMGFyMnBYM21l?=
 =?utf-8?B?Y0Q2alJjZFlaV3NxZG5TTTdRalp1SGdhcStYUU5SN2ZhNnp5SS8wRkpWbWpD?=
 =?utf-8?B?R2F0WENGYStINVh0TmdrQ2JibHVweUg4RGNQYStQZUFzTm5lQWVPSVpjZkpa?=
 =?utf-8?B?VmxBZjZjMTR1d016K1JadXZwRWd5aW9Sa2kydkRHUmNsMjg5VVcxNlpVL0Z6?=
 =?utf-8?B?TzBzblVZSnRkaHBUTGlNMTB2MXJ4ZStlZXdNdlg2UmZWcHBiUS8yRTVuSFBL?=
 =?utf-8?B?bDI0VDQ5eGFYbkZscDh5S3huWk1FWkFoOEtFalEzeXZTc0JmNWE5YkFsUlB5?=
 =?utf-8?B?TFRIS240QzA4SXFzVmcvSmltSFdZQWQwWDVkaWdVYWVkbTlqaDZnY0FxbXph?=
 =?utf-8?B?QjFDV0xVTHFFbStLQ2dUZHo2UDNUQjdSQ01nSk9hWXErc055YVV2cFZXNGxZ?=
 =?utf-8?B?aU9ybkFEcXduR2NLajFmMVhiampOT1lqcXhBNk0xOGpSUitRak96Tkw2QnRL?=
 =?utf-8?B?eXcwVDUrTzNTaGw3SE5Ga09tWlJpWXFmOVZoQkd2ODRMZFhBdUJ6TGN4RFRG?=
 =?utf-8?B?NW1Hc3FUdXU3RW5SWHZPS2JZWkQ3dHdZeVMxWnZmWjVibUh3TURsbkxlWjNQ?=
 =?utf-8?B?YWZGdHNMVEdWZmJaRkZscXlvY3paWEZQeXZsVEdRN2Q0R05UTS9LRENTbE5o?=
 =?utf-8?B?ajZVUHpzdTF6MmVBY0JPL3VNdTlyUGUrMjlCYWJnYXd2YzNTcEcxZ2d5U3pn?=
 =?utf-8?B?b3E0NXF2Ulh3dGJGc3MrSFRiYzVkS2IzV2YzcmhOekowVVd5cXlONmZrRzl3?=
 =?utf-8?B?RzJxNFlCRkZJdTM0RU5nZHRNNUFhQnNJOHpzNjVGczF6V3RYREFGLzcrNDZJ?=
 =?utf-8?B?RkF4a0M4TTdnZ3hPd0VoeWE3bkh6WDQ5M0VSc0hiRUdSVzRvMnZLSHJHa0Fj?=
 =?utf-8?B?QlA2M2pqSFhUelY3NitDeVBGdjZaZEl4a2FVamhHTmQwTzRkNERldURTdXlq?=
 =?utf-8?B?RUVwMzNQcmNIanlVdGEramtoM205SWZ6MDM2dEpzZDVsUlp1c1BrZlkvMkk2?=
 =?utf-8?B?emFwVWZCV3JkZVYrWk5nVUc0cFRjWXJVWTNsRHlWOHJUWWJMVkJnemhqUmc3?=
 =?utf-8?B?Z0dIUDlPbHNrZmlCWVdoanZId1VlMXgraDZZcXdDUDVMRmZSV01VcDJlTzRw?=
 =?utf-8?B?Y2NiUWNzZ0pROHB5R0dFSnlmZ2EweXNiaHVEYkhUTW9vR3o3YlJweFhWM2RD?=
 =?utf-8?B?K3ZXanZsdnZFd290MVhqQVdBOG5ZcVBNdUp5dFN5R1VzcCtQd2xwUm1IQnlJ?=
 =?utf-8?B?d0cwNTFpRG1sNmlBaXVzNWtHOXNFekNEVVFFV2JpdUZCcEE1UzlZbTFCTmxr?=
 =?utf-8?B?RURlVkJ3Z0I2RGxtSWswQjc5SkhBdVh0QWNFREZrSVpnYW14WGdjRXJUY3h4?=
 =?utf-8?B?T29sN29oemVrd0ovWTVScWloL2lVdlZ4eW9vTFRSRFVEdG5VS0RJbmRGc05m?=
 =?utf-8?B?aXFycjdMUUpSOEtMNEs2Z25DSFdUR0lvNWFOTklId0JQRGxyVktML0pxZ1NC?=
 =?utf-8?B?ZUtzQU10bzloODY5ZG4xRmdpTjBNWXZPQTlyWnFzMU1SY0xtUWNOVUt5aU1C?=
 =?utf-8?B?RGRSZ1pzQkROemF6S1M0UzF3Z3hCZFNiSElwTDJjT3JXeldqeFZyM0crRjZO?=
 =?utf-8?B?akpyZjRZUG9jWmdxTEZiWHJUU3ZGRnFkMUhiVjFlTkx6ZmdhemtQY2VDamhI?=
 =?utf-8?B?YnBwQ3U4N1JraTNMODNrRmxZSitxNVBSTHZ1UFNjTE9rRWNUSmFDc0VKVnpo?=
 =?utf-8?B?dnBON3haUHFKbkcxN1JNSG1keFVqTDdiM2hBdzgwSG8xQjZEejYvc1hyWkNW?=
 =?utf-8?B?RVlISStvKzJaS2dKdVdDWHpTazFKL2Y1TmxoRmxWekdtdVNvWnFzdXBWdmli?=
 =?utf-8?Q?xCsqfSDgRg0cTuOYdnatyYL9c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb3ced2-fdfc-4445-8302-08db1ba92aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 05:35:58.1018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KeRCRn5wch0pPXOc734KG+Um1puRic+DbmvCerdnNuTjBf6a/KHDzz64Wxx6wnxq0yYAjf83wCrBhWWQk9w8/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6336
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE1hcmNoIDMsIDIwMjMgMTI6MzggUE0NCj4gDQo+IE9uIDMvMy8yMyAxMTowMiBBTSwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEJhb2x1IEx1IDxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMywgMjAyMyAxMDo0OSBBTQ0KPiA+Pg0K
PiA+PiBPbiAzLzMvMjMgMTA6MzYgQU0sIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+Pj4+IEZyb206
IEJhb2x1IEx1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4+Pj4gU2VudDogVGh1cnNk
YXksIE1hcmNoIDIsIDIwMjMgMTA6MDcgUE0NCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCWlmICghc21f
c3VwcG9ydGVkKGlvbW11KSB8fCAhaW5mbykNCj4gPj4+Pg0KPiA+Pj4+IEBpbmZvIGhhcyBiZWVu
IHJlZmVyZW5jZWQuICFpbmZvIGNoZWNrIG1ha2VzIG5vIHNlbnNlLg0KPiA+Pj4+DQo+ID4+Pj4g
QWRkIHBhc2lkX3N1cHBvcnRlZChpb21tdSkuDQo+ID4+Pj4NCj4gPj4+PiBEbyB5b3UgbmVlZCB0
byBjaGVjayB3aGV0aGVyIHRoZSBkb21haW4gaXMgY29tcGF0aWJsZSBmb3IgdGhpcyByaWQNCj4g
Pj4+PiBwYXNpZD8NCj4gPj4+DQo+ID4+PiB3aGF0IGtpbmQgb2YgY29tcGF0aWJpbGl0eSBpcyBj
b25jZXJuZWQgaGVyZT8gSW4gY29uY2VwdCBhIHBhc2lkDQo+ID4+PiBjYW4gYmUgYXR0YWNoZWQg
dG8gYW55IGRvbWFpbiBpZiBpdCBoYXMgYmVlbiBzdWNjZXNzZnVsbHkgYXR0YWNoZWQNCj4gPj4+
IHRvIHJpZC4gUHJvYmFibHkgd2UgY2FuIGFkZCBhIGNoZWNrIGhlcmUgdGhhdCBSSUQyUEFTSUQg
bXVzdA0KPiA+Pj4gcG9pbnQgdG8gdGhlIGRvbWFpbiBhbHJlYWR5Lg0KPiA+Pg0KPiA+PiAiLi4u
aWYgaXQgaGFzIGJlZW4gc3VjY2Vzc2Z1bGx5IGF0dGFjaGVkIHRvIHJpZC4uLiINCj4gPj4NCj4g
Pj4gV2Ugc2hvdWxkIG5vdCBoYXZlIHRoaXMgYXNzdW1wdGlvbiBpbiBpb21tdSBkcml2ZXIncyBj
YWxsYmFjay4gVGhlDQo+IGlvbW11DQo+ID4+IGRyaXZlciBoYXMgbm8gKGFuZCBzaG91bGQgbm90
IGhhdmUpIGtub3dsZWRnZSBhYm91dCB0aGUgaGlzdG9yeSBvZiBhbnkNCj4gPj4gZG9tYWluLg0K
PiA+DQo+ID4gYnV0IHRoaXMgaXMgYW4gb3AgZm9yIGRlZmF1bHQgZG9tYWluIHdoaWNoIG11c3Qg
aGF2ZSBiZWVuIGF0dGFjaGVkDQo+ID4gdG8gUklEMlBBU0lEIGFuZCBhbnkgY29tcGF0aWJpbGl0
eSBjaGVjayBiZXR3ZWVuIHRoaXMgZG9tYWluIGFuZCBkZXZpY2UNCj4gPiBzaG91bGQgYmUgcGFz
c2VkLg0KPiANCj4gVGhpcyBpcyBhbiBvcCBmb3IgRE1BLCBETUEtRlEgYW5kIFVOTUFOQUdFRCBk
b21haW4uIFRoZSBJT01NVQ0KPiBkcml2ZXINCj4gZG9lc24ndCBuZWVkIHRvIGludGVycHJldCB0
aGUgZGVmYXVsdCBkb21haW4gY29uY2VwdC4gOi0pDQo+IA0KDQp5ZXMgaWYgd2UgdGFyZ2V0IGEg
Z2VuZXJhbCBjYWxsYmFjayBmb3IgYWxsIHRob3NlIGRvbWFpbiB0eXBlcy4NCg0KYW5kIHByb2Jh
Ymx5IHRoaXMgaXMgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIGFzIGluIHRoZSBlbmQgRE1BIHR5cGUg
d2lsbA0KYmUgcmVtb3ZlZCB3aXRoIEphc29uJ3MgY2xlYW51cA0K
