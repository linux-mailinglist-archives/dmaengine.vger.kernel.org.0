Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BD96A8F48
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 03:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCCCgf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 21:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCCCge (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 21:36:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1B7474F5;
        Thu,  2 Mar 2023 18:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677810993; x=1709346993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+iN5P7dbVqu8HCuwsKAO+8uaeD7LeRw1St+/5CafXz8=;
  b=K36Ze/MRfM5Q17+M2u3jemkRKlvZLOXYGoH6vlzknnKPEv0BaPwj0osw
   mzbh+KTU5nn8N2p2Lz9SBysb8WJEGzNAQpCTDiHxzh6wBC8p3E7migtEK
   GQ/ra/1meviFLDDOOfxyMrMDA6u11Z4Dho85fXiu9Wbd5RH05DlZF2WDe
   yTGRIeciqyvYar2ZiPW9TZMIIqDNDv7EAPP56FbmpqC8xph2fiLsZf2II
   YD//1mMPhRYo1IvJTZGduk/CiT9zsedFLa3ncJ4QHWJa775uvJRKY0i8H
   HuNPmWV0Y4jOfU3kdF97kSyZ7pEv5sKey/p22xDDlnJp1vyv0QpjMzNvV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="332411002"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="332411002"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 18:36:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="920953566"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="920953566"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2023 18:36:33 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 18:36:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 18:36:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 18:36:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 18:36:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwWi1h4/9qQuI63vtkQZyK+Mq+NNVwLhBqS0xTUaECknBz2k14DHYSR2xIujDjqWb8aU8lEhAwKpL9U2q20QaaJyrSeQqCpwRaU7N4oU8uc5Z1LILAao27/89mRABzFtoqkTN1uD8V66GyjBacYrnFjy/zIKT6GX7F435mkiw+oLTD35Dd25kM4wV5ped7XgcbjJYawkC1B/xhxr0ExDgY63+yDfjR5w6kdNjK0HZve6NqhlQV1Y2Ej2IJGof3iF/YtB7L+/VWdvmXKdq6YHd6XTcSZV6PDdyX8Y6u6MEYW7o5B0HIqLdg482EM9UnijqJsEmPh4nDcUMUgrFyF8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iN5P7dbVqu8HCuwsKAO+8uaeD7LeRw1St+/5CafXz8=;
 b=bS8VeX2KAT1qnD3T8fvhclQwOKZjch94/Gzb4nW1J/9/zR1EFTWaPeY/TJ1nW7sfIksDXLj/LMmue1MoHygL+5jXxcj1GsRmEl+HgXAIVJw9sb9csHYrKay/V2aASbMO2fPRKutX1r9E4Rmdm7x4Xhh2Jw1jE9+Zv5aFCM7+64ixUdmFtti3liBWmyOavQomuU3aJeRPStY1IqHpexk+ne0lE4K/4G2FsqQT5xLNM7CHwTdnd6AxrTzbfxtAptqU9oit4tA7vDeXbcGd1QmuN4R08gFC0e+/SLUOqABCrkRrSwc+HRsff4PmyBVqR/hmPiNLrTXv5D9Z7GluNHXY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7437.namprd11.prod.outlook.com (2603:10b6:806:348::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 02:36:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 02:36:24 +0000
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
Thread-Index: AQHZTKHOquacUFj9QkCYXpGTEWy1oa7nhycAgADP6oA=
Date:   Fri, 3 Mar 2023 02:36:24 +0000
Message-ID: <BN9PR11MB52762957011E60E935E82CC88CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
 <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
In-Reply-To: <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7437:EE_
x-ms-office365-filtering-correlation-id: fbe56193-6c5a-4cf6-87fd-08db1b9014f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvsjnSa5ni4oTk9ZnVUQUQWkfrBwzsu/vkkrQwyDA+goIkEUVEEL4MIW0OG+Zn06+26r7vptFsoXzkHJRXM31H0XRhmybRzNzhGV0HfAsLr8ObeZl/jE630DAo8eUvmD8HODrmUt+4qo8BIsArL/aTU5/36xkTE5OWOUItzGeWZG1H5D/euBlKOTCxuZRNcEOSxBLTTwAaNXce9v6T4yH7KRoqA0WFSVYmg3CBf8OciuA0krGzgB41cKnWcdMvZairuvyU7Z8jJg4DcYIk1HC/V9i+/Z+5ppfrfqzVZGlCRi8rUp+TehLOOS3qfg1dDj0801Edq2Fju5ba60UEsJR8m82O1KNiEDyi4QxVmt1KxsWCNrjK3600koPx0MQJwH5sv/OSTd+ARD7a6wUM+qijh8v8NdC3bFb5ot3eNyL/C5N+LlQGM8LHlg5tirnw9CrH9fUx3Yr8zk39OqZbyS1yHKyaHGz1hqWczu3lf/qGsQ1ixe+R8M/dOhAcsMR71jsvoP1oF0vNqG6jLTACTX5JZ8y7LJb7EkWx5zUkD020ZdpfzQ2wKPVbr0N8HPaKp07sRZLIG4unS9HzBCLDPG2dFJ99bQDOcVXkvuEXEV2FC3ojCQX0SmwGCRZhiyKYs/2+72fLQJVk+FsZMG/eORqJMnnOhbkd+68ZJcjXcTC4OAmODi6eVcZcrSoqz1D4iw0qAQpFuIcTuuWAzSyBvtTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199018)(76116006)(66446008)(4326008)(8676002)(66476007)(66556008)(66946007)(64756008)(86362001)(9686003)(55016003)(38100700002)(38070700005)(82960400001)(122000001)(186003)(110136005)(316002)(54906003)(33656002)(26005)(6506007)(71200400001)(7696005)(478600001)(2906002)(5660300002)(7416002)(4744005)(41300700001)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3Z5YlcxWVVQOTFZQlVLWm1xUFBQUHh6bFYvYkRlbVVZR0x5dURsb2ZOb2Mw?=
 =?utf-8?B?WnV0QlFNZGJabnRqZGk1c2h4SXhMeU9ERjlOT0RwNm80NEpDZlM2cHFEeDBr?=
 =?utf-8?B?VjNXZHl2T2VTVjFXUTdpbDMvV3puUUF2R3B3bnUwNUh6UG9oSGFZaXNOd2lw?=
 =?utf-8?B?T2JVdUJHKzR1SzVZMVVNNG02YzFHcFVBWmNKejQ0RXlXcDZzSEhFRkNySlE3?=
 =?utf-8?B?YmZGYUd6eHV2UWhlcTlJeTViNC9SL3FYQzl2emtJWUdJR2phOThmS2o1WFU1?=
 =?utf-8?B?Mkk1YUlXa3pwREhJdXVOczA4dHcyVWxqT2F3Y0Z2M2M2aHJ2ajV1NHo5ak15?=
 =?utf-8?B?d3RablNYZGVSUWlXQjM0SUFoT0h1NXFyNHZjUDIwdEJEU3dEZkxkU1crNlNY?=
 =?utf-8?B?VWtENndEL3dIMitjK0dXMGR4S0taN3Z3Q3NtTDVSVG9BUWNFWWVqd3B0VWpU?=
 =?utf-8?B?KzY0WXhJblJEY1c2SWFCczdqeWMrbU5jMFBYMDZMNW1YWFRMWGlJVHdBazFE?=
 =?utf-8?B?amkwclJENjhRd3pDak5qRGl2bXRmQXFGVW5nMFFRT1V1bWd3SG1mdTcxUlNR?=
 =?utf-8?B?emtPOFJqYUZxZ0U3MWVVLzllL3VzVjQ4SzF1STYzZDJVcXorTWYyVk1GdlMy?=
 =?utf-8?B?R1lwZFl0MTJ2MkpmWVVyK3pxdEU4Z2JwaTdXZWpMb0llSExyV05LYVk0U3B4?=
 =?utf-8?B?WXJpRFlPaHB2TzkrN1hDc3VzUUh2d1oybk1JUXVXVnFTUVpMOXFqM1dlQ1Rr?=
 =?utf-8?B?a2lPUTNZYkV4ZE5DU0ZUY0kvWFpGOHhTVTdud2cxOFJ2NE51ZUFKV3ZWcUFU?=
 =?utf-8?B?a0ZnOUVvYmZtRW5RZmU1LzhtbzFIVzZaUWVkT2ppOXlxcWZwajFCVEhDdmxY?=
 =?utf-8?B?alJ4TUFBM2RiaEwyVzZmV0dxUkU3Ris0OVFzSTA3bEpycnJHRjdKOW1NbElx?=
 =?utf-8?B?UkJFY3c5Mk03ZUF6Zy9HaEpuMEZxdUVxOFNSSUdoNWwwYXVZMmlBZFczUVZ0?=
 =?utf-8?B?L04yM2hmRUk3bEM2bFFDNnlHbnltWitZWnZYWU9UYUVuTzByZ0NGRTFFRHlZ?=
 =?utf-8?B?UkRUUEhaS3hjY0YrRlZodFVseGoreVMzZHVjNk1ib2VmbDlia0pXWWpPdGd5?=
 =?utf-8?B?QTJTYUVENmdYL1pNV2QySXR1WU9ZMUJBNnhEVUI4Ti84N1JZTDMrVHVIZ3hO?=
 =?utf-8?B?UmNlMTJOdFhVU2R0UFFzMytwdGdLOVJ6bTd5Uk9UTWQ0bWRrVGgzZjBHazBH?=
 =?utf-8?B?TE1FU01HZWlJUTE4MjZzbWo2cElSYXhqa3NWL3hqekhPaHNoS3lzMEtuTXdv?=
 =?utf-8?B?d3d0TDBka1h6M2lNcm8zTnY1czJWOHpDWWVwWHZXSXJ0SXcrU0RNTTdYY3Qz?=
 =?utf-8?B?Qm5zTzljYVhaNDJXVFZXNENZUXNoVGxIZEdDNHZxOGhJbGlsUDhTczk4ZU9u?=
 =?utf-8?B?bEdMSnVvTW04UXZVSEkzZHUvTWJBTFJDUXlpL0ZraG95c2x4ZTJTcDA3ZGFB?=
 =?utf-8?B?WmZhdldSRE5jd29QZmxreGM2bk5zbi9QS1B6TnBZVS9YOXkzS3ZJT0diVDlK?=
 =?utf-8?B?Q1I2cTZ4QTFJS2Jhdm1pVkU5UFZZenRzOG9ZZ1NSR3FYYWJCUkxPcUl1bEht?=
 =?utf-8?B?aU5vOXBrb1pRSVFWNldIK2lnQ0FaOXpxZ2pvQWltUUQ4OFFjSHVTTE8xTGhQ?=
 =?utf-8?B?ZWt4QkFvdEZwRHN3dWJwb0FUdFVYWnlqSHArWGxQb0szM2UxZUZ5THhkbDBq?=
 =?utf-8?B?R3V6bTNBQTIrOWhPSE9ET3N1VjBiVm5hUXRIU1ByTTZNRVRRMFNib0lpQlhV?=
 =?utf-8?B?MURMMlNxMnJKOFp3amMranJkcWR6Z0wyZi9EVEcwcFU2K1BTY3crTWhWbjZJ?=
 =?utf-8?B?a1BDcHZpOEZmSUpvWGlJaHVoOXlIZmF4alpjSmN6Mk5lelZZY29Ib0hxYnF1?=
 =?utf-8?B?WlpSeE5GMURKY2svNlFlRUR1Qi9Cd3Vqdmo1OFZJcnJwMzRKajVSeEpmbjdD?=
 =?utf-8?B?NWVBVi9xbGc4d2Z5djkvNVpIaGZCV2xUb1hXZ1IxNExlYzhuRHVXVTEyTU10?=
 =?utf-8?B?bjQreW5PV1RRQStJTEtyemx3azR5TThzWk5YeFNFUU51cEQwWFhUSmxOK1RV?=
 =?utf-8?Q?wK3jBVvhCw7F9kyfKwyJtpFiC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe56193-6c5a-4cf6-87fd-08db1b9014f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 02:36:24.3620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfjflHIqWWpsVmo15M6aItrKCK4Q4DspDtMp8DUazUFpCODyMT5Z43fYENL9iOy8aqyenwVRxapgMPrMFcJZUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7437
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgTWFyY2ggMiwgMjAyMyAxMDowNyBQTQ0KPiA+ICsNCj4gPiArCWlmICghc21fc3VwcG9y
dGVkKGlvbW11KSB8fCAhaW5mbykNCj4gDQo+IEBpbmZvIGhhcyBiZWVuIHJlZmVyZW5jZWQuICFp
bmZvIGNoZWNrIG1ha2VzIG5vIHNlbnNlLg0KPiANCj4gQWRkIHBhc2lkX3N1cHBvcnRlZChpb21t
dSkuDQo+IA0KPiBEbyB5b3UgbmVlZCB0byBjaGVjayB3aGV0aGVyIHRoZSBkb21haW4gaXMgY29t
cGF0aWJsZSBmb3IgdGhpcyByaWQNCj4gcGFzaWQ/DQoNCndoYXQga2luZCBvZiBjb21wYXRpYmls
aXR5IGlzIGNvbmNlcm5lZCBoZXJlPyBJbiBjb25jZXB0IGEgcGFzaWQNCmNhbiBiZSBhdHRhY2hl
ZCB0byBhbnkgZG9tYWluIGlmIGl0IGhhcyBiZWVuIHN1Y2Nlc3NmdWxseSBhdHRhY2hlZA0KdG8g
cmlkLiBQcm9iYWJseSB3ZSBjYW4gYWRkIGEgY2hlY2sgaGVyZSB0aGF0IFJJRDJQQVNJRCBtdXN0
DQpwb2ludCB0byB0aGUgZG9tYWluIGFscmVhZHkuDQoNCj4gDQo+ID4gKwkJcmV0dXJuIC1FTk9E
RVY7DQo+ID4gKw0KPiA+ICsJaWYgKFdBUk5fT04ocGFzaWQgPT0gUEFTSURfUklEMlBBU0lEKSkN
Cj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+IEFkZCBhIGNhbGwgdG8gZG9tYWluX2F0dGFj
aF9pb21tdSgpIGhlcmUgdG8gZ2V0IGEgcmVmY291bnQgb2YgdGhlIGRvbWFpbg0KPiBJRC4gQW5k
IGNhbGwgZG9tYWluX2RldGFjaF9pb21tdSgpIGluIGludGVsX2lvbW11X3JlbW92ZV9kZXZfcGFz
aWQoKS4NCj4gDQoNCklzIGl0IG5lY2Vzc2FyeT8gaW9tbXUgY29yZSBkb2Vzbid0IGFsbG93IHRh
a2luZyBvd25lcnNoaXANCmlmICF4YV9lbXB0eSgmZ3JvdXAtPnBhc2lkX2FycmF5KSBzbyBpZiB0
aGlzIHBhc2lkIGF0dGFjaCBzdWNjZWVkcw0KdGhpcyBkZXZpY2UgY2Fubm90IGJlIGF0dGFjaGVk
IHRvIGFub3RoZXIgZG9tYWluIGJlZm9yZSBwYXNpZA0KZGV0YWNoIGlzIGRvbmUgb24gdGhlIGN1
cnJlbnQgZG9tYWluLg0K
