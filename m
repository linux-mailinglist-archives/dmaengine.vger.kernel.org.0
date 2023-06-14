Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE8872F76B
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjFNIKs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 04:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjFNIKr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 04:10:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0EEB5;
        Wed, 14 Jun 2023 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686730246; x=1718266246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3PywqMd1Uiji4ZhpBYULrR/chn3Ob7fHp5nm+VtE3Rs=;
  b=WLSqPuRC6G+0vo8aYOhY/gVw8poLuEvOFJamE6zq6VWpQwFe3jDxRuUj
   jyVPKS5Xv+uJZ30COQc0YbCJz64o+qPZS45KLEOedPLPivSISpoe8FFiM
   A4WVV+p4JzJuUQL76li3doYB8z8eq8gHCkOD/zF11/lVS2zuYxFV2Z/Qy
   V8enspb/c9D7tfl5orYH6gsvCJxTQO06IPNgxV3bR6MdCPUKJ3rZNpzTE
   ad/GBHCtn/DmUp/8Rf9WIPE50XWKoG8uFBrY/FGsTVetKq7lCXIbkfte3
   auZDV8fJUnpAhktAKD4BU8T2uqWX+a9BG5aXMSKJLBwwUlGnpx5RLoVuE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="422150938"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="422150938"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 01:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="886138340"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="886138340"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 14 Jun 2023 01:10:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 01:10:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 01:10:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 01:10:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mo5trQOVaAAFiJQt+CsK5fAzPbxMhJdNBcCBc6FmPNHU6QriSLK59cO1m/XxnW2nX2FrS+2v1loAo9rAryogapatvPDwdgr7rDiZQxA9zPAfTyjBT9MvaXtU83VXNZu63PgPlNXzPV6wkJcxwLguCLwfzCLR0siQv+cH6QB/Um8ptSq8E35my8I6FPBYejDADnDckv9c1Pp79KhexiPpz4c5CG10rG1YBkJOxorksejYiY6PmowsE3YZwzb5DgDpvR/vt9sE57k0emkDk3tkoCs5v1gV+bHP8o5PnLBW9gAL+VoBMVKM8aXvcTUdVYJHqhYnT0WMO3qFURA8uwb81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PywqMd1Uiji4ZhpBYULrR/chn3Ob7fHp5nm+VtE3Rs=;
 b=TIX8W5MRtflfSvAn35tGKhmkk2AbGhhNCWcYWLL1GhWbyMwtZBw1q9CYxuKY5E7Lqh4dZyxH71NN2o3BT707vQPFpd1C1MjlvJTvxjs6uyRrs+poQYP6japDCGJw934Wq7zzIzPUp7lXDS8Od7XOktyaSMfQrqi3QMahifFdT5+UE3QRQ5supJoGDP+9ulvRKC1AvV58Zwyqp1eNUAHwlWNohl00c2oplm+JF2O+tJj4jmUbm5vSqTINEjm2EEaBnjfcj2SUzsC6nZCCujFtZueWJW2v6CCc+6eZBnV8nsUAfjHllWG4s4X7+H4OwYGJV4IvmQQ2d77xBfyWPQRzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38; Wed, 14 Jun
 2023 08:10:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 08:10:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Ranganathan, Narayan" <narayan.ranganathan@intel.com>
Subject: RE: [PATCH v7 3/4] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Thread-Topic: [PATCH v7 3/4] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Thread-Index: AQHZjZxI8RRUCSa7gUG6SDjy6Qi7Gq9qiM7ggAFTnACAHjetwA==
Date:   Wed, 14 Jun 2023 08:10:42 +0000
Message-ID: <BN9PR11MB5276BB62057559D4EE4C8A588C5AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
 <20230523173451.2932113-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52760139A4844C8DF0EE1BE98C469@BN9PR11MB5276.namprd11.prod.outlook.com>
 <01ed700a-5c20-849e-4f4f-070fc4e1fa12@linux.intel.com>
In-Reply-To: <01ed700a-5c20-849e-4f4f-070fc4e1fa12@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5243:EE_
x-ms-office365-filtering-correlation-id: 19e443d3-34da-4eeb-3e8a-08db6caed8d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+R4FJ4E6MxcJTqUpyJ6qYOSVYTCrSQp9o6E+pNU38xXIqCuXF9zdZM4fiAQR+W/KHUARBVy/qV59ZBn78s+O0BFAJQduP1wTWADXfyTaCggTVt7fxVF+B/eELPoTgS5OJZ6KnbZSBx3kaK/h+Lsc4B1yH9Ss86L6g58/psbXOYTqD9BOmaoN68KhsGjn2i1Kr3xShU5UPJ4F/GY5Dlgaec6OJyWWLBKhEFY/GkzVz+4SWzz5Ffp0mRh0U4k4McneesxuGzSg+xSXk14SzsKR7ZQWXGn+N4bJJ6NaKEB63Nq2MQDptxDveccj+vckNNxp0MPbBrJKpXxZR2m7lTXSTx5K+yhA43sUoVhhxdqCkbp3rflKGLdyciVIzVuoo3UBIo+QTNJiTOQFAVXRl/pKR7RlZH3a4TAyYgDVoRPBaJg4OIuZ+cabmBllz4LEoTn2fihtX+vx8agImK1FTWro8mc7RzaQXBEKVlVrtAj7btoKb6y1BOcFrGgXS+LkbgokvxCxCUgEVxooGz6gfwriugWJp8jCzrdZNwkW2ljLWAevaXiwDu346JP6uvrGK9lEVf44C+Fx8neOgGMIHPUYrLqG1Jq6JJEd5k1j5qzfYc6sO6qaLZ6yl3g9y+pSe5GQSkG7q3Zc90sf0eEvzGLZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(186003)(38070700005)(38100700002)(2906002)(33656002)(4744005)(86362001)(7416002)(9686003)(6506007)(26005)(55016003)(82960400001)(122000001)(921005)(316002)(7696005)(4326008)(71200400001)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(478600001)(41300700001)(54906003)(5660300002)(110136005)(52536014)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TllkSWxSTElyc0FLTVNCTjBnM3IxQm1CVGtwcW5Zb0sxSjllOEQ1ZnhKMTB2?=
 =?utf-8?B?cktQVG01d1lHU3plcWFVVUVsNk9WV3A1eHRERzVZTXJZN0toZ2dvYUI3RFFz?=
 =?utf-8?B?RW5XL2wzaDFRMnVDaWxxVzZ3SGdPNVhYY1VTdS9PMUFWT1dSZWE3OWpCdFlo?=
 =?utf-8?B?VFZ0R2JzNmkyS09ELzYwQjEwS2U1aVFSNmlWZG9zN01sOHl6OFlKcmt5S2dS?=
 =?utf-8?B?VGdvUEx6dmU0RGlqUGtZcVhIQ0QrZ0swQW5vMlFMbi94OTE5Ujd4d3VrK0cr?=
 =?utf-8?B?aCtlV1dQVmM1bjdPdGljTTJsazY1Yko0dVJERDVzdS96WHB1UU5BdkRqUnV0?=
 =?utf-8?B?ZVNrMDZ6OW9iR255RGN0MzY2UkROc0NWTXVBZlROWkQ1QzZJN2VqSmt2TVZS?=
 =?utf-8?B?TnZJWU1EZ1liUFpLVHBkMWlISzd1eU9qU2hJa0ZPWEloYzBwOXBlenlLQm9t?=
 =?utf-8?B?WUVKS3U3UWlmL2lPYy8yK254Q3lWWUNKNSt4OUFXVGNXdndOSHBPRWUxNC8y?=
 =?utf-8?B?Q2IzUmJnejNzTHR2MTJMa3NRRXQ4NWF5OUU3d2xXU3VCV0JFRUI5Y2FPekp4?=
 =?utf-8?B?dm5sTXVzV1UvZUtzYXY0cTVRa0k0Nm0vYkZsazBnV1UwRmxlL056RnZWLzFQ?=
 =?utf-8?B?Z2lmZ1c2MG93eExKb2c5SE9rZGh5WnlydTEwTG8xWkRzT0MxRThjZUVOUlRv?=
 =?utf-8?B?YUYzbUYvRnlDMjJWeDhNZFZKaFRkMDdZVmJQZ29BeFc5Z3l6Sy9MSmpRcHFm?=
 =?utf-8?B?RUFVbXRmRzYyemk3dGN4WFJ6cmhPcXpSQjh5cFhTSFBNb080Ukw3OGplQ2NJ?=
 =?utf-8?B?MVhoZkg5a3ZqVzQ3K1VWek9PQTVkMXhseUJUYzlvQWhCNGs1enZTby9WM3ly?=
 =?utf-8?B?ZkpkV1NNVTZRQTlBUjlkZ3lsejF2WWdDR2hlU2ZSL3dLYXIzZmcreEJwYXE3?=
 =?utf-8?B?VmpYeVdjTHZjd1owbFR6R29vazRIRmVIMldoN3hjMGNDTXBjUG5sWGI5V2Js?=
 =?utf-8?B?R2pzb09EdGZyazBvZCtoVWFIMFVVNHhRTGRaSDdkMG5WM0lBc0wzQ0VSSllB?=
 =?utf-8?B?NUs1bTVpRWRCZjB6emMvNTVHckVVV2V1cW5zVGVwVjFXbDJhczZ0OUh4YjNK?=
 =?utf-8?B?T2pQakl1eWQvSWd6MEJmVk92MFU2N3J3NlNOVC8wNldSL3podWlqcXNLMUtV?=
 =?utf-8?B?YmVJVENJQU5QMlc0L3FOL05LMnhKQjZYbnlGN0tlL1YvQkloK0RoZGwrcDBj?=
 =?utf-8?B?YTdBa04rN3I1UHhSUERLQnRSVlBrcmZPQ2lhRDIveW1SL3p1QTA3eFVFRU1Y?=
 =?utf-8?B?Tmd3YXZhU2cwaUdVWTByc0ZjMGtKQTRJRUx1VjZRSlRIanJrelV3bFlRei96?=
 =?utf-8?B?V2laQ0pWbU9TT0s3Zlc1NHl4VzFva0NwS3N3c09hUVZoQjREQjk5eGYyQjNN?=
 =?utf-8?B?SWs0M1ZiZ0p3Vko5Y053NGR4VldWMTRVZmgrOENEMnBjVWp0UDRJQzB2Uy9r?=
 =?utf-8?B?anhtM1BqWTNUZWhRRklUalM0MnBNOGx0RzZsL1I0Q3FjMVNubWNCbm9Td2t4?=
 =?utf-8?B?Qk51c1NyS1RLcmNnekxLbVNsSVZmR0JXUWlMZzVFdzBKa1VQM0tYY3NuZVdn?=
 =?utf-8?B?cFhxNFk1MU04QnFqMHlQN1ZqZ3NNdW1YZTBVN1BXMW1iODByNkNsMjN3OFNW?=
 =?utf-8?B?bithcTYyeVcxRXN1QjNNQWFHZ1Zac2JBQ3FVRm1KU2hpVGFHdWpSdC9ic2Zu?=
 =?utf-8?B?aktQR1gyQlU1UDAxNTA1K0VnZnBJUWRQWnpZNVlWYzdCUUhKcHFmcXZhTDNl?=
 =?utf-8?B?aHgvUVFtekxqZU1MM3NOSnpYd2preVBQenY5MjFnTzc1OGY5R01tRTNmNHVU?=
 =?utf-8?B?WlhRZGxtUzZOMXp2Q2dIc2s5Wnp2VmVMcEtJZHJ4K1JqdUwwa0ZrY2NhTW1Y?=
 =?utf-8?B?S1cxbzd4Lzc2RS93akxYY2U3WUxEM094d2ZMRlhvdFVqcWNLZkZzWkZXQlhi?=
 =?utf-8?B?NHpPczhTWEVIY3k3MFRKSHUwejZXR3NYNDVZT2JnR1V4Si9CYXNoWlVJWUFH?=
 =?utf-8?B?OFlxeWNoRUhOakpGcW5RYUdGK1g4UUVmQ1pjYjNuK05RdHBZSU9HSXlwRkpq?=
 =?utf-8?Q?JFmHzAHhj5BLZjACjeM8gPRg0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e443d3-34da-4eeb-3e8a-08db6caed8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 08:10:42.0919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0P07/bMiR6XF7HITdSWXcWXud94pD66gPRD9TxP0SX9DnLIA/9NqyhvNDpPpnkVUb2nC+DdTqxl/MltB3WFDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE1heSAyNiwgMjAyMyAxMDo0MyBBTQ0KPiANCj4gPg0KPiA+PiArDQo+ID4+ICsJcmV0ID0g
ZG9tYWluX2F0dGFjaF9pb21tdShkbWFyX2RvbWFpbiwgaW9tbXUpOw0KPiA+PiArCWlmIChyZXQp
DQo+ID4+ICsJCWdvdG8gb3V0X2ZyZWU7DQo+ID4+ICsNCj4gPj4gKwlpZiAoZG9tYWluX3R5cGVf
aXNfc2koZG1hcl9kb21haW4pKQ0KPiA+PiArCQlyZXQgPSBpbnRlbF9wYXNpZF9zZXR1cF9wYXNz
X3Rocm91Z2goaW9tbXUsIGRtYXJfZG9tYWluLA0KPiA+PiArCQkJCQkJICAgICBkZXYsIHBhc2lk
KTsNCj4gPj4gKwllbHNlIGlmIChkbWFyX2RvbWFpbi0+dXNlX2ZpcnN0X2xldmVsKQ0KPiA+PiAr
CQlyZXQgPSBkb21haW5fc2V0dXBfZmlyc3RfbGV2ZWwoaW9tbXUsIGRtYXJfZG9tYWluLA0KPiA+
PiArCQkJCQkgICAgICAgZGV2LCBwYXNpZCk7DQo+ID4+ICsJZWxzZQ0KPiA+PiArCQlyZXQgPSBp
bnRlbF9wYXNpZF9zZXR1cF9zZWNvbmRfbGV2ZWwoaW9tbXUsIGRtYXJfZG9tYWluLA0KPiA+PiAr
CQkJCQkJICAgICBkZXYsIHBhc2lkKTsNCj4gPg0KPiA+IEhlcmUgeW91IGFsbG93IGF0dGFjaGlu
ZyBwYXNpZCB0byBhIGRvbWFpbiB1c2luZyBzZWNvbmQtbGV2ZWwgYnV0IGFsbA0KPiA+IHByaW9y
IGNoYW5nZXMgYXJlIG9ubHkgZm9yIGZpcnN0LWxldmVsLg0KPiANCj4gQXMgZXhwbGFpbmVkLCBw
cmlvciBjaGFuZ2VzIGFyZSBmb3IgcGFzaWQtYmFzZSBpb3RsYiBpbnZhbGlkYXRpb24gZm9yDQo+
IGZpcnN0IGxldmVsIHBhZ2UgdGFibGUgY2hhbmdlLiBPciBwZXJoYXBzIEkgZGlkbid0IGdldCB5
b3UgY29ycmVjdGx5Pw0KPiANCg0KTm8uIHlvdSBhcmUgY29ycmVjdC4NCg==
