Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF396A8F9F
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 04:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCCDCp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 22:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjCCDCh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 22:02:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A812258B59;
        Thu,  2 Mar 2023 19:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677812551; x=1709348551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gVnuejYj8gxdEp4LhmWySIfQDyMi7W29tr5dZqunh5w=;
  b=dNpxJJmmKr47xOYb8Svgz5/4vxmE8oAC1rI8h+UXf0nfO5Hrr5zM8dKL
   +JE8AKLVa9Q+7KNwFJ9PjqAH4h83KFcLJHXUmWAAkxF+EjT14Ri27x9n+
   oUhHWKNW+tUpjHbJmnWTSUXaMRjT3L4rCSyKInV9DnfKZjlQ6Xihj0F6n
   pXaFT8Ua8nxKUfQ8Jso2WR53v+9p4H+Iwo0H9EzCQKAeJIE17hciZJuaR
   yZuYiR+WhGN5pJE0A7Fovcrlp0gkFR9WKpuzwV+EbQsiAFLw/elc2ZgNJ
   mlpyQo1iO9fZhGqf1EA5c6uVn8JrmZFQ+5XpAe8jBbpLm1Fh4/Lz7kGVn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="337252217"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="337252217"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 19:02:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="744106116"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="744106116"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2023 19:02:29 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 19:02:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 19:02:26 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 19:02:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 19:02:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHs/2qy+b6YmuaNhP7ex5mQsvsm3MRuSboarvWceSUkc3lTt615EzXIvAKh/93wSxoafQcYNBenWvwVWzpEjsrZu2PBiv9u3ojEQHl7oPBZYhsi5FPA/bexlLsE6W00K19Aj0HHexHHasrfUlPsfB7Iyp4/dU2ogP6NBv3dASH1bsO7jfNBEzZ/bxW5MECdjxBh+FXBHAuQhmef6RFBVzH0ykxXALL+X7HMQX98/rNONzY1LKEdOdcXg+g8Brs1Un8EKSXkmwboXTZfvyxWtl80Pu/jfWxHHoUx2J4rI0ht3LtDrtuq7E8+II8mHd5ePMUadw9SrYfEM23zLxsJElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVnuejYj8gxdEp4LhmWySIfQDyMi7W29tr5dZqunh5w=;
 b=jHOEuAs3QUzCphpzhPqlfpSQ/vNXVau1znp8sFrZHW17wHZ+qcglFORd1n3iMji11TE/msKXf1+KFB3fWP0kmFUKRVGYclHjsSf4Lgc1EXd4Lhq7Ecq1GiuiLyml5GabZzlV2mPlY5ErfDY7dLszO0Cev4q0v8gPfkAByIU78tZMFFxepW+7UDIAgWOtTEZKJWsQ/VsdG2NIsr5ew5MocZRg6fPdEIU9s2lyOdCm280fM4SgDMkNtJWalYIl3hMFxuG6sU0UuL/BOMduMFW+ngn3ad7Tf/Hqtmp4IzxhXzca3icUpavMk7Ry9+GAflW71mpgH6KhhMlE6T067747wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4912.namprd11.prod.outlook.com (2603:10b6:a03:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 03:02:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 03:02:22 +0000
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
Thread-Index: AQHZTKHOquacUFj9QkCYXpGTEWy1oa7nhycAgADP6oCAAAT4AIAAAWng
Date:   Fri, 3 Mar 2023 03:02:22 +0000
Message-ID: <BN9PR11MB527634EA1ED5067D1FC0D7C68CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
 <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
 <BN9PR11MB52762957011E60E935E82CC88CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2c9115d0-f251-c284-63d6-73714edc96b4@linux.intel.com>
In-Reply-To: <2c9115d0-f251-c284-63d6-73714edc96b4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4912:EE_
x-ms-office365-filtering-correlation-id: 48a0b093-0928-4e4a-a4a6-08db1b93b5a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RROkOaSjB/QaJYiLXFnJkyQe8zWprxy3jMM644bT8bHijKATQU05qD3WLORQ8d/GqLNUPr5+84n7/8mwUrBfb3sdRvlijiI0u/9k87lZEavBfYCv3ibizFKglAyPnIkEipF7/4dQkcM4F7+gQ63ft68RW4tpfjAptKgPQLfV0IUao1OwBbOnq8IVdj/B97Izv36QyOE07EW4ecfFhSzYj7twgzA+q/TN5bwFAdLG+PXUQAixhTJDEPQ915Q2m1weLvKkJ9L3ReK2d5UANFJtfZphd8/Sl94KrvusW9+E2Y8xSOmGCpoENkWeTXc8rCT5ex3NO8xF06WST3VS1ZK2VGF2LH6gTcIe9Hs+Goq/UT60v0uLZ9xwR0S7/33axwd96czuEfLpob/ylLnCWcKCJGr7zC9Jo7GVNE9KP4q+c5TLIwOcn4FpZnJOWhCQiermhdP0DJy8KW0KBCJ6Mv2cAZlR1kTUX3QOOP/MnVFourplzdzHFtBlDtQeiKP6rT/m9HlPOzW8iPW41e3WCoxsKQnFkufkJ0wOJVZ5q2UxlJLrtAPwGtySkt+thMHpJMnj/0M/cT+7HROKQckwgZ2ARR9mvws2M5BQYsf5C9byq0qxbYlSn6B+ZiWgtL60TXrRF8uKBKuIlvv2kTRvyHJfH8FaQoJo3t7Z6eqUImh5BbK7z2gF/zvNQhH0y6yjByF+kN/4fSXcoeZHtxLFgFH0VQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199018)(53546011)(6506007)(186003)(26005)(9686003)(316002)(41300700001)(54906003)(110136005)(4326008)(66556008)(64756008)(8676002)(76116006)(66946007)(7696005)(66446008)(66476007)(2906002)(52536014)(5660300002)(7416002)(82960400001)(8936002)(478600001)(38100700002)(33656002)(71200400001)(55016003)(38070700005)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWl5bDM0dkpENk9NRS9wa2IrUHZnVjVnOUFMRXJHdmZoTGprM3Vtbko5bnJa?=
 =?utf-8?B?MUdwN1pBU3cvbHBxdFBCRG85bW9FYkZCUFZzK2cralBIZElrR2dtckwwSW96?=
 =?utf-8?B?R2Q0NDE1a092eUphNVRWWHJyd2ZZT0huK1krMlFmMTVjNy9NRjhwaFU2a20y?=
 =?utf-8?B?SFljNklkTXc4OXlqNnZibzFRZkpmblpEMm84MTE0ZmZZUEV0YWU3MFhLbnRO?=
 =?utf-8?B?K085ZFRhdEE3YmVCZEdlRXh2eG5GUDU3K2JkSHA2Y0grc1R1MG9TRVdpYjFl?=
 =?utf-8?B?Ty9aRnExUlFWZU5LSEFock40V2Fsb3hQNGVOVXM3T1p3TGUxenptbnVrbktJ?=
 =?utf-8?B?cGtRVnFqWlVZek8zZVhzM3NUL0FDRnFVazJxVjFSc3VqUTZ2VUE3ZG9XM2F4?=
 =?utf-8?B?LzFBU3lhY0U5QWVjUkVPYjBNeVZhaE5tSndMdE1WcWV6OUZxaEtiVTFmS2sr?=
 =?utf-8?B?U3BVcWFxL3FINEpHaTJGQmpQcDZYNXlaT0hVMGFIMy9veU1aWStvN0JCV3No?=
 =?utf-8?B?OG1zZ3lBcDVITzMvRzRueURtNUtwM01QYVdnUDkwQVZBc3pZeHNUSHlEZ29z?=
 =?utf-8?B?a1Z4RG90d094RnFSZ2RNMXpMamNyNk01QTArUWRLZEVaNzUwVytDdzhYZzhl?=
 =?utf-8?B?QU1YSXpyK1JMNmlkc0s2RFVqK2FMVWl2TVRQR2g0QlZrUHkxeHdkckh4Vkc1?=
 =?utf-8?B?WE1Gem0wLzRiNzY1UkhNeU5BalIzdHk1b2xPMUNHUzBnY2x2NWtsYWdTY0FX?=
 =?utf-8?B?NjNSYW1GNWxEazdrY0JPNXlEK1pCK1BzZEZrT3Z0R21lT3lEQmlDeW8reUJS?=
 =?utf-8?B?WTBGNjlGZWhvKzZoWUZCV1JSdm9pak91VVArcERYdWpGY0ZOZ2xIR0V4VTNR?=
 =?utf-8?B?MHRlTjlJejJtQzdXczRPWGMrRHVjcVNCQm5ZMCtnQWw2YTJCSjVZZmZYY2Ns?=
 =?utf-8?B?OFB0VmMxSk5sL0U3ZFZhdm5ld2JiWlE3WkN6QkdIRFhkTWRyR2dGNHFocHFj?=
 =?utf-8?B?dXJNWVREdGlRM3dHSGd2NzQ2aVVQTE1la3J3Njl0TXltTTZXdktDb3RDK2Fi?=
 =?utf-8?B?VXZ0Q3FWUDBDNHVFZHdGV2kzZTJEdjlOWHlJU0lZbjE4eklhalZ4T3dGWHBI?=
 =?utf-8?B?NDNrQllxOEhXRkFuWXRoalBURDdMRS8reGovdWF6TGxJR3pSVE1iQ0hBampI?=
 =?utf-8?B?aXdnOGdLd2VBbndUbXFLMDI1N1Zoc1N5cFIvWWNHOXU2NmlEMFlEYTNUdm9u?=
 =?utf-8?B?WmpWVXduL1pXeGt6NnNoejNON1RLQ2swNkxQc0M1aUJMZ1FjandQMXJFeFNn?=
 =?utf-8?B?Wm1BS1RHM1ZvdldTRDVydnphMzZibkhXM2gvaDlwRUlZNTJIWnZCVXZRWVpv?=
 =?utf-8?B?aGVQSlVxWFVYUHlCanpWZy9TdGx4KzVTN2dqRlpnbFltRWI2elFTK1NVVFB6?=
 =?utf-8?B?SzAyZzU1ZVZrVmI5MzQxL1I4MS95OG5veTZOcnBsMitrZ0JaSlRBVERKWVRq?=
 =?utf-8?B?eUdHVFZnL0dLV1Btdi9oandVQitQOGtVOFF6OThLemVOOXgvK3VKcEp5ait5?=
 =?utf-8?B?SUhNYTdtWGNBUjBKaFhZczl0Y3k4ZUQ2NUdyaWdNdnNzbEJuTk41N3o1T3BF?=
 =?utf-8?B?M3hXYnhCUUFtU3JTV1g3Y2hKTFZld2xaN2VDMlUrUFdlc0g5WlI0L0lKamdP?=
 =?utf-8?B?bmxQUUhUeEhxdTdmQkJUdUdQZnl2RjRuUWw1ZjExV3pQbE93alNjallwYzBh?=
 =?utf-8?B?eWkvUHVVUlNOWmdyL2tUdW5vZm9xWFpxVmdMaGNYTmM1VGFFRmN5QzBTa1Bl?=
 =?utf-8?B?ZVR5L0ZCdjNlTU0yam1uWldoR2lSUjBkK3RuRHQ0aENyUnJDd3VUSzlicGFr?=
 =?utf-8?B?Rm5aUjBlbDh3REpSVXFTdlR0NDRYYW56V3B0MHFnQkp6YjhLNEdDajZ4UU5G?=
 =?utf-8?B?TXV3VllQZXJ3K3QzcHJrV3ozTlhKVFAvZkpDaEhnZ0F4STFneDZIWmU2TXBu?=
 =?utf-8?B?MVhOdzFJNlNjb0ltWVZyanB4Ulk0UmZzTDdaOGIxNkpPU1JZNW92YnpKTEVr?=
 =?utf-8?B?MlRTM1NjZkRTRTBVeEZlK1BKaTc5ZWthZ0gzLzhVUDBnVDBlSTRKd2QyWG9k?=
 =?utf-8?Q?4PVIrFgKbFOmv//ZuRX1u3Ghq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a0b093-0928-4e4a-a4a6-08db1b93b5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 03:02:22.4040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWj5GCG3iIMCCRqjZkYREoovNVgDQLTULIsNxKdt8F/YqrsJo/3PHhy+Ph6uQtqmLgO5VpPcTwaMMgIIrm51Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4912
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE1hcmNoIDMsIDIwMjMgMTA6NDkgQU0NCj4gDQo+IE9uIDMvMy8yMyAxMDozNiBBTSwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEJhb2x1IEx1IDxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyLCAyMDIzIDEwOjA3IFBNDQo+ID4+
PiArDQo+ID4+PiArCWlmICghc21fc3VwcG9ydGVkKGlvbW11KSB8fCAhaW5mbykNCj4gPj4NCj4g
Pj4gQGluZm8gaGFzIGJlZW4gcmVmZXJlbmNlZC4gIWluZm8gY2hlY2sgbWFrZXMgbm8gc2Vuc2Uu
DQo+ID4+DQo+ID4+IEFkZCBwYXNpZF9zdXBwb3J0ZWQoaW9tbXUpLg0KPiA+Pg0KPiA+PiBEbyB5
b3UgbmVlZCB0byBjaGVjayB3aGV0aGVyIHRoZSBkb21haW4gaXMgY29tcGF0aWJsZSBmb3IgdGhp
cyByaWQNCj4gPj4gcGFzaWQ/DQo+ID4NCj4gPiB3aGF0IGtpbmQgb2YgY29tcGF0aWJpbGl0eSBp
cyBjb25jZXJuZWQgaGVyZT8gSW4gY29uY2VwdCBhIHBhc2lkDQo+ID4gY2FuIGJlIGF0dGFjaGVk
IHRvIGFueSBkb21haW4gaWYgaXQgaGFzIGJlZW4gc3VjY2Vzc2Z1bGx5IGF0dGFjaGVkDQo+ID4g
dG8gcmlkLiBQcm9iYWJseSB3ZSBjYW4gYWRkIGEgY2hlY2sgaGVyZSB0aGF0IFJJRDJQQVNJRCBt
dXN0DQo+ID4gcG9pbnQgdG8gdGhlIGRvbWFpbiBhbHJlYWR5Lg0KPiANCj4gIi4uLmlmIGl0IGhh
cyBiZWVuIHN1Y2Nlc3NmdWxseSBhdHRhY2hlZCB0byByaWQuLi4iDQo+IA0KPiBXZSBzaG91bGQg
bm90IGhhdmUgdGhpcyBhc3N1bXB0aW9uIGluIGlvbW11IGRyaXZlcidzIGNhbGxiYWNrLiBUaGUg
aW9tbXUNCj4gZHJpdmVyIGhhcyBubyAoYW5kIHNob3VsZCBub3QgaGF2ZSkga25vd2xlZGdlIGFi
b3V0IHRoZSBoaXN0b3J5IG9mIGFueQ0KPiBkb21haW4uDQoNCmJ1dCB0aGlzIGlzIGFuIG9wIGZv
ciBkZWZhdWx0IGRvbWFpbiB3aGljaCBtdXN0IGhhdmUgYmVlbiBhdHRhY2hlZA0KdG8gUklEMlBB
U0lEIGFuZCBhbnkgY29tcGF0aWJpbGl0eSBjaGVjayBiZXR3ZWVuIHRoaXMgZG9tYWluIGFuZCBk
ZXZpY2UNCnNob3VsZCBiZSBwYXNzZWQuDQoNCldlIGNhbiBoYXZlIGFub3RoZXIgc2V0X3Bhc2lk
IGZvciB1bm1hbmFnZWQgd2hpY2ggdGhlbiBuZWVkIHNpbWlsYXINCmNoZWNrIGFzIHByZXBhcmVf
ZG9tYWluX2F0dGFjaF9kZXZpY2UoKSBkb2VzLg0KDQo+IA0KPiA+DQo+ID4+DQo+ID4+PiArCQly
ZXR1cm4gLUVOT0RFVjsNCj4gPj4+ICsNCj4gPj4+ICsJaWYgKFdBUk5fT04ocGFzaWQgPT0gUEFT
SURfUklEMlBBU0lEKSkNCj4gPj4+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+Pg0KPiA+PiBBZGQg
YSBjYWxsIHRvIGRvbWFpbl9hdHRhY2hfaW9tbXUoKSBoZXJlIHRvIGdldCBhIHJlZmNvdW50IG9m
IHRoZQ0KPiBkb21haW4NCj4gPj4gSUQuIEFuZCBjYWxsIGRvbWFpbl9kZXRhY2hfaW9tbXUoKSBp
bg0KPiBpbnRlbF9pb21tdV9yZW1vdmVfZGV2X3Bhc2lkKCkuDQo+ID4+DQo+ID4NCj4gPiBJcyBp
dCBuZWNlc3Nhcnk/IGlvbW11IGNvcmUgZG9lc24ndCBhbGxvdyB0YWtpbmcgb3duZXJzaGlwDQo+
ID4gaWYgIXhhX2VtcHR5KCZncm91cC0+cGFzaWRfYXJyYXkpIHNvIGlmIHRoaXMgcGFzaWQgYXR0
YWNoIHN1Y2NlZWRzDQo+ID4gdGhpcyBkZXZpY2UgY2Fubm90IGJlIGF0dGFjaGVkIHRvIGFub3Ro
ZXIgZG9tYWluIGJlZm9yZSBwYXNpZA0KPiA+IGRldGFjaCBpcyBkb25lIG9uIHRoZSBjdXJyZW50
IGRvbWFpbi4NCj4gDQo+IEl0J3Mgbm90IGFib3V0IHRoZSBwYXNpZCwgYnV0IHRoZSBkb21haW4g
aWQuDQo+IA0KPiBUaGlzIGRvbWFpbidzIGlkIHdpbGwgYmUgc2V0IHRvIGEgZmllbGQgb2YgdGhl
IGRldmljZSdzIHBhc2lkIGVudHJ5LiBJdA0KPiBtdXN0IGdldCBhIHJlZmNvdW50IG9mIHRoYXQg
ZG9tYWluIGlkIHRvIGF2b2lkIHVzZSBhZnRlciBmcmVlLg0KPiANCg0KSWYgdGhlIGRvbWFpbiBz
dGlsbCBoYXMgYXR0YWNoZWQgZGV2aWNlIChkdWUgdG8gdGhpcyBwYXNpZCB1c2FnZSkgaG93IGNv
dWxkDQpkb21haW4gaWQgYmUgZnJlZWQ/DQo=
