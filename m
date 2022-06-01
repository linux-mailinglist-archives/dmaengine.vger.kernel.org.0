Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C8753A1CC
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jun 2022 12:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351706AbiFAKFj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jun 2022 06:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352024AbiFAKFG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jun 2022 06:05:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43561E0ED;
        Wed,  1 Jun 2022 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654077905; x=1685613905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rivrCNSSYxQG47qs9/XgdeTxICgpSGpwqWm8uePduKE=;
  b=K3C7nL1E5r524BTzUFQ1zYAyQimROiLirSo1RuBPaLH/nNwRPsezT0N9
   WPaQKtX0kn8fMvd/FjWa51To2smzYn68FVU35v8wr0p303q6kP0oC0cU0
   LD2Nx3IDLVnvgan7WReZvPJ0DwuyWM8BgABSCXXJBh0NxXebmj6XoL7WQ
   8TO1DApwwCuMjbZqYSLDUqPCRtAEMreA7B/0pQBmjGvhVSlg4WcX23A5q
   M372a/mhpYA/MIDq97fmjtw/WEFoBBHaCUYbxuq05RA/9mFSJbtoOg7iK
   jtyL74H583uVawFSOQnhR6SYzq1T4aH1ZYSWgwmzrrTeUlaoeeXLN55s4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="300888561"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="300888561"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 03:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="581509682"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jun 2022 03:05:04 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 03:05:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 03:05:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 03:05:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 03:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vd2TfwNM4Vd36F880JTnrr3w8NzjR5I4fONXn06gEKJneWjnEeObwpnKgpGQ3u69F+qe1j2CTxNhog9V68DsE5YCPMkVgrBo9Nl1xjSKSKY5UditoY0/MVY6Yg6SyesOLCSt6kEmkBWsaVVxE9PMHGsHr9HVQodEbf4rwD1EhU5mIyAQZ22xDluSiOpNSV3Wiy18kdyul+XMj3i43V3nbldJGbUEwo6W/H2ZkqgP8mHYmHg2b+khhQebe2YZTt5P8IiODzQjrSSvfQwDs8PmvRLXqBWt5OlakRVStSXDOU/u+Z1J4GFIHRGHzj94/dbnHmOjrgxh9fIafhjU4etCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rivrCNSSYxQG47qs9/XgdeTxICgpSGpwqWm8uePduKE=;
 b=MbgUVmGZuAbrPpBJxGpzNimBrYSaoBOAZ59Zur3GX+NRq7yLIkke8VtfSjkR0EodAJnEwnhV9ThsMRMegDrJHmo21s25pA0fJfG1uTUIzV8pgVyZ3w1iGFgcN7T1DFloyX/RnOnuCBrp3ZUlIaoV1bESjQpILCY/IHQL5ebDtDp8vjhDfQsv8mnYJJzJhbGZByBROdkbNxkKVll/6nInEIOWJv1odFA0rsqg0/kZ+GLMtYevy4Z4HVFKDZEGQ/fS/NQlhUjTWjj0foJ8v5jAyAFUkbGaC9PrqBq9/lpi6GbW7syAkhuQU82cn/2sQIn7Y2eIzKYPHtri7JQHVDHrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4265.namprd11.prod.outlook.com (2603:10b6:5:1de::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 10:05:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 10:05:02 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Christoph Hellwig <hch@infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Thread-Topic: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Thread-Index: AQHYauOU3vbab87feU2/ab0rn4lTF60uFLMAgAAYR4CACT0vgIABWQJggAA/qgCAAE95gIAAiHYggACF24CAAALtYA==
Date:   Wed, 1 Jun 2022 10:05:02 +0000
Message-ID: <BN9PR11MB52764A8126EC1298DEE4CA598CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
 <20220524135034.GU1343366@nvidia.com> <20220524081727.19c2dd6d@jacob-builder>
 <20220530122247.GY1343366@nvidia.com>
 <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
 <20220531102955.6618b540@jacob-builder>
 <BN9PR11MB5276A2B5E849C2153939934C8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <868984fa-c8bc-635c-1788-99bc8e6fd587@linux.intel.com>
In-Reply-To: <868984fa-c8bc-635c-1788-99bc8e6fd587@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bad19fe5-9682-4646-c174-08da43b6319b
x-ms-traffictypediagnostic: DM6PR11MB4265:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB42657E819FB69B111170E5CF8CDF9@DM6PR11MB4265.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFonBVV09aTwHX2dKEz56/0avL6cgYLa4qSA13fVAzXoNdeloHOjaSIEQSHQ52/HLZ4dpL13CeyYvn2FkgWohMeMA+2Y7NVZ1PtyG1roGQU3e6N2+UXvEkLxjpIoCNTJR1tUHlxuNbCBswAo2tvUYm3+d4rk48bdqYGAYshUh3HL8RSu7z9oZkWcsHYyMcVOp3RxA0Dv+Qw9xA85psAGR2bN0vwM4KetTjKNIj60dogtLc9/fbzOLqPAyZ8xEkrUDbZdgwLNuJ+c31BjO7hISXGHplEd1gKzs5ndMzbVlDqoYiOP2Myy+xGHqe8q8ybv0ZoIpEooA+zJV7L2pxkunzOLreXHZ1tjj39igqP2WlpTnHpoMZTprzTL2gdjJmQ7R7ahJWqqnhsvR8fKuNJdkb+2CTBBr6vFC9ng/Wc/MLU/HcrHFK1ICts1x0+YFwJoRnQQN8a9prsvRK47RqPOlzV5ZXdK22cwlZiQQktRQPAnAxhyPEYODUFqkNq3R0DrKjrDhHHCmdpj06s7E/F3ZdjspTN326SelBd4IUQFBgQzZT5JO9Ates/bI4IjJYs6UAruJKLIDxRTh6kRTXKuw3uklxzBKmPBdgO34/Npni+nwVvutQ4vh50rCD/uFeffuGzufiVhHFNeCsS26+h4c9pjieCXO9CMJp3q4Fbh2jYCmaLUVFCp9LvcUehdZaCuFGnnUdjwwNoFwxGL9vxGtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(66476007)(66556008)(122000001)(76116006)(4744005)(64756008)(54906003)(38070700005)(38100700002)(66446008)(110136005)(82960400001)(316002)(71200400001)(186003)(7696005)(5660300002)(86362001)(6506007)(508600001)(55016003)(7416002)(52536014)(26005)(33656002)(2906002)(53546011)(9686003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlNFbTJlL2NuaHJNN0NJai9PWjd3T3Boc1ZXbDJHVDMrTlMwb2dzL0lubklC?=
 =?utf-8?B?a1d1ZGJnMkhWQUFpbDZHNTA5b0phSGtUYmlpV1R0QmtRTkdFZHdhL21NTjFU?=
 =?utf-8?B?S2lDMm1EQmxaZVNramg3VnNKYWxVSHA1Tm85MmFKV1NtQmswdDJHQ1dxd2Ri?=
 =?utf-8?B?TGFuODQ0OHNXOXV3c1ZSamZ6SUtCY3ZxRlVaT2R0c0hMSnIvSmRkMXVDclZC?=
 =?utf-8?B?T1NPMlpkV0FyRHpicEREcmIxc0dndEtWZ1pLNUVFaCt4MkowREM1Wkt3QlEw?=
 =?utf-8?B?bFhKaUJPL0VBNHBrZXNxOXBYenBBLzFVRys2VWZBRUZRTXcwRWpBM0tiSXBB?=
 =?utf-8?B?b3dyMnNNK2xGbEhXRk9kd1lYemJ2MW5JRXQ5c012S2JPQ2pBdGF5UFo0SU1V?=
 =?utf-8?B?T056UmdBaXV5M1pOOXg1MmpHelM3NVBPUWIyRGg4U1dkcjFZZkNKaVJmODJZ?=
 =?utf-8?B?SU1uNGRhT1ZxbmlVTk1LRndsdEIyMHZJWit3Vng4eVJTc0tiYU1ScmZGVE9o?=
 =?utf-8?B?R1d5TFJvT21GdkNqMVgrOXh3QnpSdFFjclJXSG9JWG96YWlvUm5XdGdaMUdD?=
 =?utf-8?B?M3JwbHNsTjEvSjU2eFJFZVc1U1J6WGprMlRRQnIyeURNV3haNzlVWTk1WWhi?=
 =?utf-8?B?czY5ZVZoZlZzOHdtcDV5dWE3ZUdtN2hVdUNWSFExK2g5WWdyMGNMU2hYWUVP?=
 =?utf-8?B?TXRUdk9HU3VhblJjRzR0a01ZdFZ1ekZxYnJRV3c0QWZFeitpMnRnZGw3OUdx?=
 =?utf-8?B?MlFUNjByQXdqRjVyQ1cySWNKMGpBTFNWYnQ5aUprNlo5bnJXSkk1dmMybEdM?=
 =?utf-8?B?d1U0OGZsaGxXeXVRRXkrZHBlVUpFYjZYclFOVHVhdThhdythVG0vekRnZ0R1?=
 =?utf-8?B?ZGdSWTJJYjVHSmVvY0QvTWF6SEhTSEZ1cTF1dUtHaHlKWW1GV05TK1lTVG1j?=
 =?utf-8?B?aFhrWXZVOWFzOVhLL2dCT1MvTUEvNWZOTU9jQmRibVp1a0RId1pGdHk4dlhP?=
 =?utf-8?B?Q1E5T1ZiMytzYy9GZzllZ3JtYlJlMC9KSTV2S0t6RGpQTVBMem1wckY0YUh3?=
 =?utf-8?B?ajRUT3JxUVMwNlFaSmNPRE5YZ1JIYWtWSUI4TFVJU0UrQVd2ekxIbEU2WWxz?=
 =?utf-8?B?d3RlVVNPUlhCaFErY2xWQWc3ckp2WEdVMGM1eVliT2FKUUt2YSsyS0JxVk1S?=
 =?utf-8?B?Yk05N2ZXbWt6OFE5eXBMMGNsaDRFREFlOFRKQ2FLSHFZQytvekZFeCtJREhn?=
 =?utf-8?B?ZDRvNXVodGNRVXEwUncrYjY1Q1RnaTBISnpOR0V2NFlBSG1TUjE3TjBocldE?=
 =?utf-8?B?cmtEQ1NEMUN2ZW1zeGJWa0xkTXBsRWFjczJHS3hGUlBJSXZwYW10cEhneEpC?=
 =?utf-8?B?YVZGSkg0NXdBbHFUbEVQQ2h1RnhZMWg2eStRNUJLYllVc2gvZU14ZDZWMDZF?=
 =?utf-8?B?RlU5bURuaG1EWWRPakJHTlJkSHRheXl0aGs1YmIwN1NSQy9FWDNDamJPNjJZ?=
 =?utf-8?B?a2JyODNMQTJtTmpUUEVQQnFHRmswL0R1Umw0NjRBYU9KSzJQKzdySzhZR0NF?=
 =?utf-8?B?ZXNEV3kyYndZRVUwTHpPdzYxdUxpSnlQd1JrSEVpWFc2N3JnbW5wQThyek93?=
 =?utf-8?B?TWJxQkE4VUQwSXJaWjhzNWZUb1B6QTI2NS9nMXR3UHFrRFh0TElBOVZ1UGtK?=
 =?utf-8?B?cDZQbDY4TGtvUEZkTHVpYnAzbU51S0RWVXJUSnB0ellic3p0bGY3UnR3Tndh?=
 =?utf-8?B?aHpBb0k5UVM5aGl6MVUrK1NBaGd5Z3N4MW1NUTRYenliK0ZEbVFGNGxzdmNZ?=
 =?utf-8?B?R3M4VkhWODNZYnp4TVQvOGdhb0h0bWpiZ0V1YWZkK0xCUnZwbytacjMrcG4v?=
 =?utf-8?B?b0NHY0NVeDRzVVE1b09ubTQ4MkI2WjY2NGlQdDk1a0VsMEhUVHhQeEpYZVFP?=
 =?utf-8?B?REdxQ1ZiVU5mUTlQeEdkMy82cXRlNVhld1VzTm9DY2hyZmFySVBPYWhHQkt0?=
 =?utf-8?B?NTJ4U0xZQnlSdWFGdmlmY3g1VktRSmRJS3NTdEs1TGVsZHV1aWZDWHFsSER3?=
 =?utf-8?B?M1R6MmQxeGxOMnQ5SS9GYWl5QXNZaGVWdGZhOFJGRHFOVHNjRElCYURPSFZl?=
 =?utf-8?B?ZWltRnRrbU1ya3QrMnJybmxoMmtJQXlvYmllOWRVS044aUhoSkJlUzZ2ZnZP?=
 =?utf-8?B?NjdDUFZjbUtEWVlya29Dcjk5UzBHWmo0VEc1MUZ0cGJuMjJyMVB6Z2NyNzZk?=
 =?utf-8?B?SjRDWHR6eWpBbUYyTldJRXNvb3RuUVNROTJJT0o5NmFxZlV2c2NnZ1ZxTjR4?=
 =?utf-8?B?clhTd3FxL1AxTmFWVmZTd1NQTjlHanVrcGlhK0p6bm5jYWZoWkdOUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad19fe5-9682-4646-c174-08da43b6319b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 10:05:02.1434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uTvqFT/hU3yEiEttq9Q4AefZb+91iuBkb93TfMoWLGo6wPm8AxazH43vfGX6cnfXu94fbvXjNCb0yDExCn6Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4265
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEp1bmUgMSwgMjAyMiA1OjM3IFBNDQo+IA0KPiBPbiAyMDIyLzYvMSAwOTo0MywgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEphY29iIFBhbjxqYWNvYi5qdW4ucGFuQGxpbnV4
LmludGVsLmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDEsIDIwMjIgMTozMCBBTQ0K
PiA+Pj4+IEluIGJvdGggY2FzZXMgdGhlIHBhc2lkIGlzIHN0b3JlZCBpbiB0aGUgYXR0YWNoIGRh
dGEgaW5zdGVhZCBvZiB0aGUNCj4gPj4+PiBkb21haW4uDQo+ID4+Pj4NCj4gPj4gU28gZHVyaW5n
IElPVExCIGZsdXNoIGZvciB0aGUgZG9tYWluLCBkbyB3ZSBsb29wIHRocm91Z2ggdGhlIGF0dGFj
aCBkYXRhPw0KPiA+IFllcyBhbmQgaXQncyByZXF1aXJlZC4NCj4gDQo+IFdoYXQgZG9lcyB0aGUg
YXR0YWNoIGRhdGEgbWVhbiBoZXJlPyBEbyB5b3UgbWVhbiBncm91cC0+cGFzaWRfYXJyYXk/DQoN
CmFueSBzdHJ1Y3R1cmUgZGVzY3JpYmluZyB0aGUgYXR0YWNoaW5nIHJlbGF0aW9uc2hpcCBmcm9t
IHtkZXZpY2UsIHBhc2lkfSB0bw0KYSBkb21haW4NCg0KPiANCj4gV2h5IG5vdCB0cmFja2luZyB0
aGUge2RldmljZSwgcGFzaWR9IGluZm8gaW4gdGhlIGlvbW11IGRyaXZlciB3aGVuDQo+IHNldHRp
bmcgZG9tYWluIHRvIHtkZXZpY2UsIHBhc2lkfT8gV2UgaGF2ZSB0cmFja2VkIGRldmljZSBpbiBh
IGxpc3Qgd2hlbg0KPiBzZXR0aW5nIGEgZG9tYWluIHRvIGRldmljZS4NCj4gDQoNClllcywgdGhh
dCB0cmFja2luZyBzdHJ1Y3R1cmUgaXMgdGhlIGF0dGFjaCBkYXRhLiDwn5iKDQo=
