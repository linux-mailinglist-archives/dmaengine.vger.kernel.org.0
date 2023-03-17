Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273496BDD51
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 01:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCQAG1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 20:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQAG0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 20:06:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEA06BDDC;
        Thu, 16 Mar 2023 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679011584; x=1710547584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e0UKyfg8zJBsw2zSpIW0q2HmKBCLCVR41qqtxgQYIlg=;
  b=ULJMgndzMiHAoDKqug+oAcTEEqk5AfFn+28hXcG8ZazXPr3efpjVnjmt
   b1dnqR/vQ7ucsoqhgLpR/rz5VNIf2qEDHxUAymqQBLPIMrFSlH060c4K9
   fk06DWPX01275Ev6L/CUi+PJDLhdKcawzJt14ucO5lszjbG2Owwy3CTl7
   50gr2xUnxle9ZIkJJqZczXMRBusF7jsquGcdioYWPMxV1LSWfRB0I7Y97
   30ORqyBlXXZyECd5Sks5xueZC6Ju8YOlnCDs4QorKNwxYgNrykvYDeT8Q
   i9pAs+81jYQYfqMacSlsUvUtL5elmoBojAcmszlNgB6WUc4avXJak6jAo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="340512268"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="340512268"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 17:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="749056717"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="749056717"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2023 17:06:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 17:06:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 17:06:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 17:06:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 17:06:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezkj89anHFiy4fEPI6zFQwyP4PDmyIAXYswsu7EiEPQYl6EZwV1Tzot7DDbELmqW4OPpOJ5e2mF/QcFnNkpSxBIGHGgItsUpEj3sPCSBBoZCLtq1c6nzkEl2MoSIZHsAAxUjWH3OX6LICA6oJ1yCRefm+hoUWUtr6H0zTzLZJ+h+OgHhywWBQqfM1024HsKndmiKFQHdXxceA3hPH0bGwGLGnG2D73viZOUbgG9mi9joQp+Jw1Kq6Qv0WFb7lZRVH1uKoTnWu9Aw9nMyB8MmY5a2q/Um3BdzeQSnTfmFHvanbBKSxicznUIsaAu4dxE94jFyCCELFqmGY54AWGswNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0UKyfg8zJBsw2zSpIW0q2HmKBCLCVR41qqtxgQYIlg=;
 b=BEtbJKcpdrxFtHNGpS0wEWlp8AvSjWANGwaHGZJgEllnLSczuy2jCcDhTVKnXJReX2+vuS9LyxLgT31fghEKLwdnmur/GxK2cUZ/TqAX0DMVHSBIcDl07oD51wQcuMewYFu3Qd1XODmkwEBYZJcJNBj+56cnbTzE0GAQ/e3+VyvfAnFFJc89Sz+NQ1Qhz0CubCKs4+6FVTv6WARqUEV+BNUILtjLh6pVtox9M4ye9gudCqyVraTmCVyW6ehjiDfQLDXi47l87jLzLDOxzRkxD5GtedDpDxMRhkbldAjv3Bj81Gaj6q7rbtMyIciY4g5rfJU0m0amPyAWRJccQINzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6339.namprd11.prod.outlook.com (2603:10b6:208:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Fri, 17 Mar
 2023 00:06:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 00:06:05 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] iommu/vt-d: Move PRI handling to IOPF feature path
Thread-Topic: [PATCH v2 5/5] iommu/vt-d: Move PRI handling to IOPF feature
 path
Thread-Index: AQHZUjL48KR1g1UW3UyUdTfzF/rwfa79CJVAgAASYQCAAQjEgA==
Date:   Fri, 17 Mar 2023 00:06:05 +0000
Message-ID: <BN9PR11MB527679AADCC5CA762C5BFAA68CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52766D4948FA00CB02D3F2188CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4a9dd732-344d-64f3-0c9c-b21c196bf940@linux.intel.com>
In-Reply-To: <4a9dd732-344d-64f3-0c9c-b21c196bf940@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6339:EE_
x-ms-office365-filtering-correlation-id: 1fb358af-3d30-4f6b-21eb-08db267b671d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IONqTSDDc73l61+3+4beA9PQb1BShnKHzQrIsWhB1HaTIsTBeCq8qpO9wcmqvbzw8405w3nnVdOnWdpZnnkUMtqiyNJV9ewHYwAZSBMfzEcAIaCAR6ZnPLzOX2JISywYGhR7UwnMIsZDnx4ye5rZtxJLB+OsI/lEbS+DucNyqbADx7Y7QKYfurv7S3zAw4iA1bmwrsd48rZHl3TU5xkrN5xRmeRSERI7XkprIABPfNqIY/ECeUuWDjBMPG3fZgnQoRDig/1hzZPgBMWpxXiWu89Gg6cjgTtc2ah0USWA80+njOIo8677g1QnwBSluHwgIao1a0RnpdmRuZx9AQXBXzK5W/8c5znHKx4fXsxMO/IEzcNfDl6KI6vW+rFjR9tgta8wbHI4VQ5eDKHCx/VR8cbSAceknYq0wuuP5oUYy/mX01fjQyJXBMxijC9iny9ownHXgIvjxMIICDigQ0LlSdnQAsu0Kg2pfwi/NJkJSfIkzAS2VxqZ3d1boE/o2PgDx9i01kINfsifgUEXBNLQAGKTNXpq7EG+hcEvi7VqxkTzYY4IItSUAo+YoD3EHcGRJJW5q6dTt5BoRQDbnDexT97ny+QxZ5SRY68bWa1Fkm/WmBjxbYxxny3WAepslQyXBgN0pMJWy8zMY4ixpvSQJPSMMkTrbkpLUKpC/aHsUcW5yzaNVMedEwBcRw59x9p6/UhPyyX4cSNMTDtjbQ8E9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199018)(33656002)(55016003)(316002)(54906003)(110136005)(5660300002)(8936002)(52536014)(71200400001)(7696005)(64756008)(66446008)(8676002)(76116006)(66476007)(66946007)(4326008)(66556008)(2906002)(41300700001)(38070700005)(86362001)(122000001)(38100700002)(6506007)(82960400001)(53546011)(83380400001)(9686003)(26005)(186003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzA1TW1XY1NvbnVhS3Frb1IwcHJLQStJUmNVVFVMbG92TWN0Wk9NRmtSNktV?=
 =?utf-8?B?RFl2VW1KZFBsWTJHMDlhcGFzU3d6bVpYbVBnOWhYbVpGSllocDdLbGJ5MElS?=
 =?utf-8?B?M0VYQWtCWm9TWk5Sb3BCU3FCSWJvZ2Jubkx1VzU3V2dOaTdMOUYvMUVvWFNO?=
 =?utf-8?B?RnhFTTVtODRFS0Q3TE1LeFpQNGlrcTNnZnI1NENNenEyRFBPZnlRSnc5dHN5?=
 =?utf-8?B?Q3JOMWRCcWpSRVNTQUZyYWQrcEFkVHZITGYxbGYwYWw2a01CamxoSDVpS2lp?=
 =?utf-8?B?WEhKMGJCTm9iRTJVd2xsaEZLQ25KSGZnRlZNUGRmU3RJL3hoSzl5VUNUOFpo?=
 =?utf-8?B?SXlBSnVKaWFhNlFFM29taVB0OUZWYnI2NURLTkVDckcxT1RRUjFIY2RraVBE?=
 =?utf-8?B?LzgyNFh6OHI0WXlCaWZFQ0ZCTDc5a3dzbVI0WGh5dlFoclFCSERNU3JxS3Qr?=
 =?utf-8?B?cjl2ajJlVnExOUNFN0pmcW9oOWZyWXFRN0ZGZDRvNVVPalNQREhWYTYwdUo2?=
 =?utf-8?B?WHlEdndneitUd0luQnJSOUovbjlqS2I3b1ovYjdpTE1ZTDcwRllrdGZlYVBB?=
 =?utf-8?B?bFR2MTVKSTgwQUlkazRYdVR0cmk3MHhUZWJEaEdpZWk1SEdEMW9vYVJqajAx?=
 =?utf-8?B?QUVRM0NDWDBkbUZ0RllmYUxobEVzV0ExeW1FR0ZXWU5La0NQWXk1YWt4dmVB?=
 =?utf-8?B?RVphRFdRc3d4R1pOM3JUK0ovZFRWUDVsVHBwZHFwbUZSaUFIMXFWb0FNSXox?=
 =?utf-8?B?Y0JDaTlRQzZvdUt1a214RnpWL0FUWTdTSGRzdmI5ZmVobFhDNXY5blVHQ1p4?=
 =?utf-8?B?WWFSTzJLdHpBRFJGRHdJVlEwNURRbDk0NVlxSmJlMHlQSFc4V2xhYkJCNEQy?=
 =?utf-8?B?UmNpL3gvWXNQRy80Q2tGNVQ1UU9mQVlIdGREMm5zK3lyWmR1UnZiSkpQemNN?=
 =?utf-8?B?b0lIbmRvYTZJWDJpdEtiWmFBOVpiUThxM1lXRTRKZ2NBZnlCV0Vkb3pxVG5Q?=
 =?utf-8?B?dTN5YUlPSEFEUFhFb3psNG9Mdmp6QUxKWU85OFBpNVY5OWdKRS8rSHI1d0ZK?=
 =?utf-8?B?UUxyTnY1SWNyWWg3S2lyUGhDb2hXNmE0MGJDUjJnMWZQL21Ic3ZWTU8vZ3A4?=
 =?utf-8?B?UTdKbnJ3aGp1UTVnRHlsdVh1WFdjaHVhMWg0UE9oTzIzRCtxY2dmQit3cHRO?=
 =?utf-8?B?bXRjKzVoOEJtY0diMjBEYzJrKzJqeUVOTEQrNy8wMStWQUpmSHVMYkJGRGpi?=
 =?utf-8?B?OCt0aWdwRzVyeHBRU0dJM0hIWWV4a1pFRjdmV1BkcXhieDJKOWJ2ZWhXeHJr?=
 =?utf-8?B?c1QxWmVQcVFMMG1GWExWYkx5dHVHWnN0TjVNWDBLMDMrVGpZRDMvK3NlQnFR?=
 =?utf-8?B?MkJaT3BIeGgwNDlXbVN2VVh0Rno2cCswV0pDc2wrVEdCR3ZRRE05THF2YlZO?=
 =?utf-8?B?aFNGOXJZQnZWVlM3LzJSRW5mcEVxTStpSU5XRDl6OWZzWG9uVmZ4VTFBaHNx?=
 =?utf-8?B?Y0E2Y3prdzBqWTdDKzNxZENTZVdWZFN5bVI5NWRPd0I4VUg5L2hyMFJneDhl?=
 =?utf-8?B?QUFtYmVWcXlOemU2UGdEbG9vakRDam9aLytxaUN4c1F2alhHZ0ZoSi9yNmpB?=
 =?utf-8?B?SWVVN3E1T3JWUUVvRm9PZVhRcGZjdExzMXk2Q0U3eEg3WjhQQ0R4QUpxdEVS?=
 =?utf-8?B?N1FsR3BWV05uQVRyM1Rxak9WRWlQczZqRHNFeEhiYzJHeGhMK05hbGZBMHNL?=
 =?utf-8?B?RE5aQnIvM0FRdkZybUdURXljTUFIRTJhNDVMYU5UWHRaZSswWi9kYTloaEU1?=
 =?utf-8?B?SVh5OWRvNnJ4SDhqcis4cXg0WDV0Ly9adE4rckp3ZWE2WjhVM0h3THNLRTVW?=
 =?utf-8?B?Z2QwNFhhRURWRzRuZVV0bk9xZEo5OW01cGNuRXFVeDZiS1dYSGNjd3BkYjU0?=
 =?utf-8?B?TUlOQ2Fkcy93TVZCc2d2dUlNVXptenRHSDY5enk3cjZBYlBYMEdDdi9xVkpy?=
 =?utf-8?B?dGpZakFFeERqN1dmZ2lrZEJ3Ulh5cnlOOUl1U0wvb2J4VitXZkNva0R1UWZn?=
 =?utf-8?B?Nk8wdFR3MFRmRm0wNFlPblRTNUFYdlpzdW1kSXNGWnNrSkJ0TlhRVWZsSzNZ?=
 =?utf-8?Q?e1MF4kobDY0gpO6I/SfO62CTw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb358af-3d30-4f6b-21eb-08db267b671d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 00:06:05.5227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZhPcn6UcaCUzUg9XFuXNkzxwPLByAt9UzufqG9ca6Y2kCvJQn87eqYu8k3ZUiZ4We6BqPiFVCf3VxR6b5pbEdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6339
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgTWFyY2ggMTYsIDIwMjMgNDoxNyBQTQ0KPiANCj4gT24gMjAyMy8zLzE2IDE1OjE3LCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDksIDIwMjMgMTA6NTcgQU0NCj4g
Pj4NCj4gPj4gQEAgLTQ2ODksMTcgKzQ3MDQsMjEgQEAgc3RhdGljIGludCBpbnRlbF9pb21tdV9k
aXNhYmxlX2lvcGYoc3RydWN0DQo+IGRldmljZQ0KPiA+PiAqZGV2KQ0KPiA+PiAgIHsNCj4gPj4g
ICAJc3RydWN0IGRldmljZV9kb21haW5faW5mbyAqaW5mbyA9IGRldl9pb21tdV9wcml2X2dldChk
ZXYpOw0KPiA+PiAgIAlzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11ID0gaW5mby0+aW9tbXU7DQo+
ID4+IC0JaW50IHJldDsNCj4gPj4NCj4gPj4gLQlyZXQgPSBpb21tdV91bnJlZ2lzdGVyX2Rldmlj
ZV9mYXVsdF9oYW5kbGVyKGRldik7DQo+ID4+IC0JaWYgKHJldCkNCj4gPj4gLQkJcmV0dXJuIHJl
dDsNCj4gPj4gKwlpZiAoIWluZm8tPnByaV9lbmFibGVkKQ0KPiA+PiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gPj4NCj4gPj4gLQlyZXQgPSBpb3BmX3F1ZXVlX3JlbW92ZV9kZXZpY2UoaW9tbXUtPmlv
cGZfcXVldWUsIGRldik7DQo+ID4+IC0JaWYgKHJldCkNCj4gPj4gLQkJaW9tbXVfcmVnaXN0ZXJf
ZGV2aWNlX2ZhdWx0X2hhbmRsZXIoZGV2LA0KPiA+PiBpb21tdV9xdWV1ZV9pb3BmLCBkZXYpOw0K
PiA+PiArCXBjaV9kaXNhYmxlX3ByaSh0b19wY2lfZGV2KGRldikpOw0KPiA+PiArCWluZm8tPnBy
aV9lbmFibGVkID0gMDsNCj4gPj4NCj4gPj4gLQlyZXR1cm4gcmV0Ow0KPiA+PiArCS8qDQo+ID4+
ICsJICogV2l0aCBwcmlfZW5hYmxlZCBjaGVja2VkLCB1bnJlZ2lzdGVyaW5nIGZhdWx0IGhhbmRs
ZXIgYW5kDQo+ID4+ICsJICogcmVtb3ZpbmcgZGV2aWNlIGZyb20gaW9wZiBxdWV1ZSBzaG91bGQg
bmV2ZXIgZmFpbC4NCj4gPj4gKwkgKi8NCj4gPj4gKwlpb21tdV91bnJlZ2lzdGVyX2RldmljZV9m
YXVsdF9oYW5kbGVyKGRldik7DQo+ID4+ICsJaW9wZl9xdWV1ZV9yZW1vdmVfZGV2aWNlKGlvbW11
LT5pb3BmX3F1ZXVlLCBkZXYpOw0KPiA+PiArDQo+ID4+ICsJcmV0dXJuIDA7DQo+ID4+ICAgfQ0K
PiA+DQo+ID4gUENJZSBzcGVjIHNheXMgdGhhdCBjbGVhcmluZyB0aGUgZW5hYmxlIGJpdCBkb2Vz
bid0IG1lYW4gaW4tZmx5DQo+ID4gcGFnZSByZXF1ZXN0cyBhcmUgY29tcGxldGVkOg0KPiA+IC0t
DQo+ID4gRW5hYmxlIChFKSAtIFRoaXMgZmllbGQsIHdoZW4gc2V0LCBpbmRpY2F0ZXMgdGhhdCB0
aGUgUGFnZSBSZXF1ZXN0DQo+ID4gSW50ZXJmYWNlIGlzIGFsbG93ZWQgdG8gbWFrZSBwYWdlIHJl
cXVlc3RzLiBJZiB0aGlzIGZpZWxkIGlzIENsZWFyLA0KPiA+IHRoZSBQYWdlIFJlcXVlc3QgSW50
ZXJmYWNlIGlzIG5vdCBhbGxvd2VkIHRvIGlzc3VlIHBhZ2UgcmVxdWVzdHMuDQo+ID4gSWYgYm90
aCB0aGlzIGZpZWxkIGFuZCB0aGUgU3RvcHBlZCBmaWVsZCBhcmUgQ2xlYXIsIHRoZW4gdGhlIFBh
Z2UNCj4gPiBSZXF1ZXN0IEludGVyZmFjZSB3aWxsIG5vdCBpc3N1ZSBuZXcgcGFnZSByZXF1ZXN0
cywgYnV0IGhhcw0KPiA+IG91dHN0YW5kaW5nIHBhZ2UgcmVxdWVzdHMgdGhhdCBoYXZlIGJlZW4g
dHJhbnNtaXR0ZWQgb3IgYXJlDQo+ID4gcXVldWVkIGZvciB0cmFuc21pc3Npb24NCj4gDQo+IFll
cy4gU28gdGhlIGlvbW11IGRyaXZlciBzaG91bGQgZHJhaW4gdGhlIGluLWZseSBQUlFzLg0KPiAN
Cj4gVGhlIEludGVsIFZULWQgaW1wbGVtZW50YXRpb24gZHJhaW5zIHRoZSBQUlFzIHdoZW4gYW55
IFBBU0lEIGlzIHVuYm91bmQNCj4gZnJvbSB0aGUgaW9tbXUgZG9tYWluIChzZWUgaW50ZWxfc3Zt
X2RyYWluX3BycSgpKSBiZWZvcmUgcmV1c2UuIEJlZm9yZQ0KPiBkaXNhYmxpbmcgaW9wZiwgdGhl
IGRldmljZSBkcml2ZXIgc2hvdWxkIHVuYmluZCBwYXNpZCBhbmQgZGlzYWJsZSBzdmEsDQo+IHNv
IHdoZW4gaXQgY29tZXMgaGVyZSwgdGhlIFBSUSBzaG91bGQgaGF2ZSBiZWVuIGRyYWluZWQuDQo+
IA0KPiBQZXJoYXBzIEkgY2FuIGFkZCBiZWxvdyBjb21tZW50cyB0byBtYWtlIHRoaXMgY2xlYXI6
DQo+IA0KPiAgICAgICAgICAvKg0KPiAgICAgICAgICAgKiBQQ0llIHNwZWMgc3RhdGVzIHRoYXQg
YnkgY2xlYXJpbmcgUFJJIGVuYWJsZSBiaXQsIHRoZSBQYWdlDQo+ICAgICAgICAgICAqIFJlcXVl
c3QgSW50ZXJmYWNlIHdpbGwgbm90IGlzc3VlIG5ldyBwYWdlIHJlcXVlc3RzLCBidXQgaGFzDQo+
ICAgICAgICAgICAqIG91dHN0YW5kaW5nIHBhZ2UgcmVxdWVzdHMgdGhhdCBoYXZlIGJlZW4gdHJh
bnNtaXR0ZWQgb3IgYXJlDQo+ICAgICAgICAgICAqIHF1ZXVlZCBmb3IgdHJhbnNtaXNzaW9uLiBU
aGlzIGlzIHN1cHBvc2VkIHRvIGJlIGNhbGxlZCBhZnRlcg0KPiAgICAgICAgICAgKiB0aGUgZGV2
aWNlIGRyaXZlciBoYXMgc3RvcHBlZCBETUEsIGFsbCBQQVNJRHMgaGF2ZSBiZWVuDQo+ICAgICAg
ICAgICAqIHVuYm91bmQgYW5kIHRoZSBvdXRzdGFuZGluZyBQUlFzIGhhdmUgYmVlbiBkcmFpbmVk
Lg0KPiAgICAgICAgICAgKi8NCj4gDQoNCnRoaXMgaXMgZmluZS4gQnV0IGl0IHNob3VsZCBiZSBh
IHNlcGFyYXRlIHBhdGNoIHdoaWNoIHJlbW92ZXMNCmNoZWNrIG9mIHJldHVybiB2YWx1ZS4gSXQn
cyBub3QgY2F1c2VkIGJ5IHRoaXMgUFJJIGhhbmRsaW5nIG1vdmUNCnBhdGNoLg0K
