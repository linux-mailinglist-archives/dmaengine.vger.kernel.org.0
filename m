Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011146CB876
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 09:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjC1Ho7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 03:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1Ho6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 03:44:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A97FDB;
        Tue, 28 Mar 2023 00:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679989497; x=1711525497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IyCgMs8QkE1idDU9C1Y34S/5B9oQ2RTQw0iMjBb8PEQ=;
  b=QQ8tSO+jRKsKHpP7rmM1AKsKPim4R9b7eG+5rmx/KYGlijLAe77ZRrFV
   AEExOcOo29Y/ivrtw6xoti6sPfZ4L+dplqqTosmPjgwSuerVh2oZEJwDf
   /b49PCMMLDaHsIAxOKmtyFTByIT9CsVwAW7meaEiZhPodX+ECS3+CDNeQ
   3bDLCoBfm+uhxUyD8NAJEfnmci0iYBUPK1MHWCB4ccWmxjOTzGQGaLGTH
   6TKmhAhffk52zTnAIBAT8pC1oSL/0+rOqT3lATIxVjHrjyNNZl9HFmMyb
   oQKIi/jdrzsU73I+ada7YLal+NcnEYnaKF+Sre7mupj8vgDfJQ7DQyzct
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="340521889"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="340521889"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827377557"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="827377557"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2023 00:44:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 00:44:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 00:44:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 00:44:55 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 00:44:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hItYQMK2SYUm3MW4U0ROeLDxnMbo7we3xpuSqcMibaHb7lOJMhME/JActNj1ZJWvOtezBpCD2znnUxyvUS/2rFvkeJRemJb7uV9FMt9W+kSaN/2ytBPuVNThNZ9+K4J+86AiyI9bA9d+15z08mSaqa8nf+Z4fbqUmgJ/QHaAIxNQRSP4QQOgM1W3IXruDXXSGrioc/w82tzkCpWznsagRl6j1kBZopnfdfVB9Hj2uEdJl2QoZBE0EezDliCQ5ciWpCRh8IEJbDb6Q015s0JZFmAHUxIeiNh3nF6wBJclHweQyT4FvQaRnhGH6ZzOKcv4Loes56dNobG6KKjqQxOUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyCgMs8QkE1idDU9C1Y34S/5B9oQ2RTQw0iMjBb8PEQ=;
 b=g7UU8qT6bovaOlxd5e+fDG0VcfI77+Fvv/kCZ/buWFA5E1iZ6D9VOEJEP2ErW6DtjTMSOpE2fQ/YWxnXdELwFlFFNowga8M/xS29QVJPQTlAZO4U39MRqcNPJOFMDBBH4zhERfJ1CChggtgpS4An+AR38pwxodb3sRMEr+hOACIi2BQZOAYwZ/An/mOEkYoAT3DH2pRkCbHSg046+k7AUN4w01WMvdC4doCHpla6o2zzXbgao4Rtrz3Eu54PnWYjRM5qZ/48oy/XPivd8X1rPkWHhBCg9ee/E+ci4kP/LpQsGgU0+GUsyJDhQXUcqFqtqv6Vvalu58Kh4u4nMyneYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5042.namprd11.prod.outlook.com (2603:10b6:303:99::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 07:44:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%7]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 07:44:52 +0000
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
Subject: RE: [PATCH v2 5/8] iommu/vt-d: Make device pasid attachment explicit
Thread-Topic: [PATCH v2 5/8] iommu/vt-d: Make device pasid attachment explicit
Thread-Index: AQHZYQJWPFL4ParjUU2CWitQ6fM5V68PsBQAgAAeAQA=
Date:   Tue, 28 Mar 2023 07:44:52 +0000
Message-ID: <BN9PR11MB5276BCF726D0B813046479A18C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-6-jacob.jun.pan@linux.intel.com>
 <71b60cc2-4ab0-3777-6bc9-3a6a4174f743@linux.intel.com>
In-Reply-To: <71b60cc2-4ab0-3777-6bc9-3a6a4174f743@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5042:EE_
x-ms-office365-filtering-correlation-id: 64727096-e38b-4b58-c3ef-08db2f6050eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B7ZT+vztvFaNzN4zT+AkJK07YegUqfJD71+ffjOiMXJtG+NUiVP4ZcEsHx/pZSEXzH+YAxegJiVaK7uCR6QFH7rgUfxYKth2ZQjQRll6jlPklNSkIwrwXZovzVkHdUOHq8lQsgTJfBatE6dgF1etKPEux0EZlW0pDikP5CA7WKwbpGLB/xXcSXa/+cDboCEcQ8lP1ZcGZ7+Q/y1s+U35PRPW3e6JK4PMtYtXlpbnwMrToIS57CalOAya0hk++rxWet+e6eBLK6mMyHGJzjYighRdmm5YzrcGdw5q6fkDWDWCXgilNp4ORUxKLN5EltUGQRY3ylQlQfAkwvBlvqJ3TW+m9XOKzQkQ7oNCPnqjDbO7pZ+/x1D7QQOfxC1P063WNEH3ynUAL7qhSE2Ej+pRGG9SYb72kF3eg/1gtzM3JkZzEdb+khkS6FhALEz7V+dwwW16ENSoM0EsO6YasPAYfyFAaCn1dlm1wSw8hf1i26zXq4y7Vc/6L1fPpuCxK38//A/1bkz1wuqNERLfNMcScw82WP491P4tdCyctodlej3579WGz+MuXtvVZv0+4SjVwc98SUa3ikR36YP1jgY4QITlSoF08q/yJUHV79VTDAc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(186003)(6506007)(9686003)(53546011)(54906003)(110136005)(316002)(26005)(83380400001)(71200400001)(7696005)(5660300002)(966005)(55016003)(38100700002)(7416002)(86362001)(33656002)(38070700005)(66476007)(66946007)(8676002)(41300700001)(122000001)(52536014)(64756008)(8936002)(66446008)(4326008)(66556008)(478600001)(2906002)(82960400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE9VdE5hY2lBM1VyUjIyNFZXSHBHeDhmZWovalJDQkY0djIxUmt0eXh6R1ZT?=
 =?utf-8?B?SzZubWJyS05hNjI5YmhKRmxtdk5oNFpnRzFqVThhallGejQ1ZjZrVldXdEw1?=
 =?utf-8?B?N0x3QmJ0aHlaZmQ3NWtsdVVtTDZBcDMyQlNKRjA1c3U4ekxpZmxpOXlFOWw3?=
 =?utf-8?B?M3c3MVhpRTV3UmhNTGExc3J3RllOUjIzRnI5U0RtWlY3cWFEOFF3YUlVYW9n?=
 =?utf-8?B?d3gwK1BWajUzQVJTNjdYTlpLZ3pld1dZck9PVHlHRmk0QmxNYUp5MXIyTUh6?=
 =?utf-8?B?VEJhZDU5N1FKNmZlV0RDVlFuVEdmOW9FSlpTMis1Vk51di9kSmpMbVJvcldv?=
 =?utf-8?B?TERJNjg0VUZzdTIyMHowSzVOakV3cXEyUVFHZElsYmxnOFBiRUErNVZ5QUFB?=
 =?utf-8?B?bE5mdTlyd21CZlVQTW4rMUJ1bmJRT2hRNEI5blBJUkR4OHlGWGtCc3lySTNh?=
 =?utf-8?B?cGpLTWs0SkRDZlkzekN5STdVNDd4djdEUFk3cjhmZFNwYWxnTFF5ZHhaMXly?=
 =?utf-8?B?Q28zRGlSdzVyd0pjbmRsUDZhcHByNmsvSFhXaXo2TUVlK0R0QWRqN2s2Um5h?=
 =?utf-8?B?N3RYZFV6eUNGSUxQRTEyaFBnNWYzckV5Y1ZEaFVTZ3pEMUh1MVNiYzQ5NXUr?=
 =?utf-8?B?ait6OHAvaHhKcGhDUkl2UDFWRStWditsNTUxQXdES0dzUUZSVjNPTmNlQlZE?=
 =?utf-8?B?ZUt1emovQ3ZoSkwzNWFWYXZWT1pyOFIwakFCQkpEdFRYYWFHV0FUNXorTGUr?=
 =?utf-8?B?di9CT2tVbWJDdVY1VVZBMzZIKzk4YnlXb3VCMHdKYVhtS2M2Ym9tOEVVWU42?=
 =?utf-8?B?c21MbUlJdXNHa1hPSDhPRkdqZk1Ic1krcHVhRmdVM2VrRkF2WVMzVm1NdXdx?=
 =?utf-8?B?WElzL0dsZTM2MlJ5ajRJd1F5V2lQNmlFeXdGVUN1ZXd1YURySGNPUFQ0VTN0?=
 =?utf-8?B?MGozV0wvUDNTU0NVdjRLejJHeEhJL1FtZmVjTWp2R3ZnME5kTkszVlcwSnNL?=
 =?utf-8?B?OTgrRDU4LzN3TmwrTGszYjR3QnpCcnlQZ00zTmZ6TnV0VlRZZHk1NDRyaTAw?=
 =?utf-8?B?OFd1eGVwMUREcVl4TWRFbHRDbEFRUEYvOEZWMUZSZ25XQTdUQkhNNndlSmpO?=
 =?utf-8?B?aFN3R3FWVWlKQzdWellsRXlHV1Fna2w3VDM1Q0xlSExLYVU4VFRQclROMEFN?=
 =?utf-8?B?ODY2NGVkbmZKanJINENPd2pIZHdmOHRpVWpZcGZCdzhBS28vbnM4UlNaUUJC?=
 =?utf-8?B?MlNwNU9LdjJFaDIzOTVNYUxLOEp6Z21IWEJjdVNsL3Y0eUFEbEdYV0RCSzNK?=
 =?utf-8?B?V01SeFQ0MndCZGFtSWFERkgxdy9KejNTNUJHSnJZdVpSeTNxRzh6VHlRUk9U?=
 =?utf-8?B?Q2taSiswU3dqR0hZMUtpalU3WkZrT0d2dTQzaGsybzhmV2N6aGg5Zjhac2xK?=
 =?utf-8?B?anhzUmtvb2M2MFBwTDNmZDkzejZGdjVOUEUyOGdKV1UvckxaanhIejVyR1hY?=
 =?utf-8?B?bXI4djAxc2I4YUs3SDh2RklOS1NpN0NYVzRZbEZlSGp4ZVczeWJxLzdrVlRy?=
 =?utf-8?B?VEprMUZ5NVRhbFJtQWhIdWpTYXVkaUdhWTE3WmZhbUlzRDUweGY4TWZmWFY5?=
 =?utf-8?B?K3BPTXYwazIyVFU5YVhPVklhaHdnSWRvL0dEVG1yTzlVVDVGWEhQWGUwSFZG?=
 =?utf-8?B?WG9LQitCNFJ3R2s3Mm45bWlSeVh5akhGdFZQL05pS2NObU5XQWRaVDZkM3dZ?=
 =?utf-8?B?eU0zOUFWK2tLbmhha1YxK0ZBU0h5ajNKL3NtVGtCYlVKaWdlNmMvV3lJeUVw?=
 =?utf-8?B?S21OeURlalZ4aW5NUkJJT1NXUVM2U3ExVFJkT3lEeUJ1UnJMOSswZmdvd2RU?=
 =?utf-8?B?bTRjWkh2TXJzbTJGL01uODRXU3FrdzAwUVZwQVZleW1NVjJJSVh5Y0x6WWxl?=
 =?utf-8?B?VWpEWlJhdGo4b1lDcnJZd3MzNm5vTzlPUWNFRWJvajNVcTBRak9DaDVFVXZR?=
 =?utf-8?B?Y1Y5c1JXRy9pUTRzaXk5ZWd1NUxjTDVxWkx2TWpCZ2x6SWR0L1gxMXhLV0Ri?=
 =?utf-8?B?TUpzdFVRWExwVVFUQXl1QzMwbzZrSTVza25ReE9XUXhRbnJnUVIvRlUvMlBu?=
 =?utf-8?Q?e+Xs9rQok9jFMHYpJUY46F21d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64727096-e38b-4b58-c3ef-08db2f6050eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 07:44:52.3658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gB0qQwIvlotW3ARWPQAiHoYhhFZlk5hhKjOzPxEtKg/Dxu0O5rb9al9trAM++WfMp+9TR9PakYlbM746Ry5T5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5042
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
ZGF5LCBNYXJjaCAyOCwgMjAyMyAxOjQ5IFBNDQo+IA0KPiBPbiAzLzI4LzIzIDc6MjEgQU0sIEph
Y29iIFBhbiB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5oIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5oDQo+ID4gaW5kZXggNjViMTViZTcyODc4
Li5iNmMyNmYyNWQxYmEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5oDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5oDQo+ID4gQEAgLTU5NSw2
ICs1OTUsNyBAQCBzdHJ1Y3QgZG1hcl9kb21haW4gew0KPiA+DQo+ID4gICAJc3BpbmxvY2tfdCBs
b2NrOwkJLyogUHJvdGVjdCBkZXZpY2UgdHJhY2tpbmcgbGlzdHMgKi8NCj4gPiAgIAlzdHJ1Y3Qg
bGlzdF9oZWFkIGRldmljZXM7CS8qIGFsbCBkZXZpY2VzJyBsaXN0ICovDQo+ID4gKwlzdHJ1Y3Qg
bGlzdF9oZWFkIGRldl9wYXNpZHM7CS8qIGFsbCBhdHRhY2hlZCBwYXNpZHMgKi8NCj4gPg0KPiA+
ICAgCXN0cnVjdCBkbWFfcHRlCSpwZ2Q7CQkvKiB2aXJ0dWFsIGFkZHJlc3MgKi8NCj4gPiAgIAlp
bnQJCWdhdzsJCS8qIG1heCBndWVzdCBhZGRyZXNzIHdpZHRoICovDQo+ID4gQEAgLTcwOCw2ICs3
MDksNyBAQCBzdHJ1Y3QgZGV2aWNlX2RvbWFpbl9pbmZvIHsNCj4gPiAgIAl1OCBhdHNfc3VwcG9y
dGVkOjE7DQo+ID4gICAJdTggYXRzX2VuYWJsZWQ6MTsNCj4gPiAgIAl1OCBkdGxiX2V4dHJhX2lu
dmFsOjE7CS8qIFF1aXJrIGZvciBkZXZpY2VzIG5lZWQgZXh0cmEgZmx1c2ggKi8NCj4gPiArCXU4
IGRldl9hdHRhY2hlZDoxOwkvKiBEZXZpY2UgY29udGV4dCBhY3RpdmF0ZWQgKi8NCj4gPiAgIAl1
OCBhdHNfcWRlcDsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlICpkZXY7IC8qIGl0J3MgTlVMTCBmb3Ig
UENJZS10by1QQ0kgYnJpZGdlICovDQo+ID4gICAJc3RydWN0IGludGVsX2lvbW11ICppb21tdTsg
LyogSU9NTVUgdXNlZCBieSB0aGlzIGRldmljZSAqLw0KPiA+IEBAIC03MTUsNiArNzE3LDEyIEBA
IHN0cnVjdCBkZXZpY2VfZG9tYWluX2luZm8gew0KPiA+ICAgCXN0cnVjdCBwYXNpZF90YWJsZSAq
cGFzaWRfdGFibGU7IC8qIHBhc2lkIHRhYmxlICovDQo+ID4gICB9Ow0KPiA+DQo+ID4gK3N0cnVj
dCBkZXZpY2VfcGFzaWRfaW5mbyB7DQo+ID4gKwlzdHJ1Y3QgbGlzdF9oZWFkIGxpbmtfZG9tYWlu
OwkvKiBsaW5rIHRvIGRvbWFpbiBzaWJsaW5ncyAqLw0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2
OwkJLyogcGh5c2ljYWwgZGV2aWNlIGRlcml2ZWQgZnJvbSAqLw0KPiA+ICsJaW9hc2lkX3QgcGFz
aWQ7CQkJLyogUEFTSUQgb24gcGh5c2ljYWwgZGV2aWNlICovDQo+ID4gK307DQo+IA0KPiBUaGUg
ZGV2X3Bhc2lkcyBsaXN0IHNlZW1zIHRvIGJlIGR1cGxpY2F0ZSB3aXRoIGlvbW11X2dyb3VwOjpw
YXNpZF9hcnJheS4NCj4gDQo+IFRoZSBwYXNpZF9hcnJheSBpcyBkZSBmYWN0byBwZXItZGV2aWNl
IGFzIHRoZSBQQ0kgc3Vic3lzdGVtIHJlcXVpcmVzIEFDUw0KPiB0byBiZSBlbmFibGVkIG9uIHRo
ZSB1cHN0cmVhbSBwYXRoIHRvIHRoZSByb290IHBvcnQuDQo+IA0KPiBwY2lfZW5hYmxlX3Bhc2lk
KCk6DQo+IDM4NSAgICAgICAgIGlmICghcGNpX2Fjc19wYXRoX2VuYWJsZWQocGRldiwgTlVMTCwg
UENJX0FDU19SUiB8IFBDSV9BQ1NfVUYpKQ0KPiAzODYgICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOw0KPiANCj4gRm9yIHN1Y2ggUENJIHRvcG9sb2d5LCBwY2lfZGV2aWNlX2dyb3VwKCkg
YWx3YXlzIGFzc2lnbnMgYW4gZXhjbHVzaXZlDQo+IGlvbW11IGdyb3VwIChhLmsuYS4gc2luZ2xl
dG9uIGdyb3VwKS4NCj4gDQo+IFNvLCBob3cgYWJvdXQgbW92aW5nIHRoZSBwYXNpZF9hcnJheSBm
cm9tIHN0cnVjdCBpb21tdV9ncm91cCB0byBzdHJ1Y3QNCj4gZGV2X2lvbW11PyBXaXRoIHRoaXMg
cmVmYWN0b3JpbmcsIHRoZSBpbmRpdmlkdWFsIGlvbW11IGRyaXZlciBoYXMgbm8NCj4gbmVlZCB0
byBjcmVhdGUgdGhlaXIgb3duIHBhc2lkIGFycmF5IG9yIGxpc3QuDQo+IA0KPiBJbnN0ZWFkIG9m
IHVzaW5nIGlvbW11X2dyb3VwOjptdXRleCwgcGVyaGFwcyB0aGUgcGFzaWRfYXJyYXkgbmVlZHMg
aXRzDQo+IG93biBsb2NrIGluIHN0cnVjdCBkZXZfaW9tbXUgYWZ0ZXIgbW92aW5nLg0KPiANCg0K
V2hhdCB5b3Ugc3VnZ2VzdGVkIGlzIGEgcmlnaHQgdGhpbmcgYW5kIG1vcmUgZnJpZW5kbHkgdG8g
cGFzaWQgYXR0YWNoDQppbiBpb21tdWZkIFsxXS4NCg0KYnV0IGRldl9wYXNpZHMgbGlzdCBoZXJl
IGlzIGEgZGlmZmVyZW50IHRoaW5nLiBJdCB0cmFja3Mgd2hpY2ggW2RldmljZSwgcGFzaWRdDQpp
cyBhdHRhY2hlZCB0byB0aGUgZG9tYWluLiB3L28gdGhpcyBpbmZvcm1hdGlvbiB5b3UnbGwgaGF2
ZSB0byB3YWxrIHRoZQ0KcGFzaWRfYXJyYXkgb2YgZXZlcnkgYXR0YWNoZWQgZGV2aWNlIHVuZGVy
IHRoZSBkb21haW4gYW5kIHNlYXJjaCBmb3INCmV2ZXJ5IHBhc2lkIGVudHJ5IHBvaW50aW5nIHRv
IHRoZSBzYWlkIGRvbWFpbi4gSXQncyB2ZXJ5IGluZWZmaWNpZW50LiANCg0Kb2YgY291cnNlIGlm
IHRoaXMgY2FuIGJlIGRvbmUgbW9yZSBnZW5lcmFsbHkgaXQnZCBiZSBuaWNlLvCfmIoNCg0KWzFd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11L1pBamJEeFN6eFlQcVNDam9AbnZp
ZGlhLmNvbS8NCg==
