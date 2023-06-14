Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0A272F77F
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243126AbjFNIOE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 04:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbjFNIOC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 04:14:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9652D1981;
        Wed, 14 Jun 2023 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686730439; x=1718266439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fDU3rk4u9N3hkxtCtAF38rBVi5E5m/NRnNs2YPV7HF0=;
  b=NOHlNSv7hxP28jrYzE7EVGhUdcoVvaNwUCbvLJzVk2nSqz7TMNLGX1V0
   Kfz1eCPHa0WaC6A07PUv63kLZel95Tz6539K/PXmQ12OV53bHD3Aj6F07
   LY12PFIEJBtgeOsxZQzQsGoeiYPY3meCyqQTWZpW6R1AAh3jEagyxie9A
   E51vCs//Kt3lCTPxyxue1jwWY3Yz92fyfEQd+iJqcuB76C3yuL1qFzsSJ
   9RVzB2KnB0uhy/3MXGqKZ1dEbSWb+ICRAqENSpDlGOikZau8sK2TBJ/1k
   4pTnKC+HXYllhtGwPaJp+2Jl3bydYODmtnezeM8ppO59Fn0qMr0kqnRSF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="424439176"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="424439176"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 01:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="662319749"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="662319749"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 14 Jun 2023 01:13:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 01:13:58 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 01:13:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 01:13:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 01:13:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG3AzlvGcExfZy5Fm41J5+UcpbeV3giGqHwz+T27BSllPaLRpUXI6Z6603vXc4TgspCMNZ829iWyIuYIG9s7PYppdmEWMZZUTwLNwUPvsHZkbPnqmnpzYgyefNVmdGT5YnQ1vJiNC4ymOSIn3y40PPbyzLYobC5sFdQR+xATnA+V1ufpyw42IJJawHiGzs8zTI/PrQCNHHdW3BhiE1C2OKTcRODKPc0x1iNwx+9GdBhwGF4oQ3+b8UKF09js38tXbZLjZ8dhJ7jVwoOU9/g7PrtCjdTiQ4PUY39uB9R7+DfxyNMxKTGF8iRWG+kZUYD4AlDYtZC2ik77we8NV+tGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcTTXtY6Ipr7HUd96clykHvID1ZMstRKB9nRGjhfAZw=;
 b=EwVHyJD+NBidbluaKVHF7z3TH2ysGL+UW7PHvscyKx7nDxxkz82g/XtDSpjTh5CFwytvN1ir5z2rth9FK1NJcENiSnKoTrPbHapjp3VOlr5JNqftUMkPP4PMgek9RKjEO3ndh8UGFDUCuRDaSE4ggkxfGcEYE9pSM/1MYGkfUUldEWLz7glmcNDe4OYTTexA76gUqKqHBUWFYlEtnLjh0eX45s1Lm3QowWOghF9J/zSM/gQrorYXRJHSLCWoiovo0ilYbwWxtBIkqzb7Eh1Hol+dnqdMmy645iLsuJ/XmNGw+Uk/EQok4HrccKazuLD6OW91V5HQHrb0Sc0XAS4i/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38; Wed, 14 Jun
 2023 08:13:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 08:13:49 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Will Deacon" <will@kernel.org>,
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
Thread-Index: AQHZjZxI8RRUCSa7gUG6SDjy6Qi7Gq9qiM7ggAiOtACAFv0BcA==
Date:   Wed, 14 Jun 2023 08:13:49 +0000
Message-ID: <BN9PR11MB5276FC89BD8364776498B8AD8C5AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
 <20230523173451.2932113-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52760139A4844C8DF0EE1BE98C469@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZHYtkioNR2YfC18C@nvidia.com>
In-Reply-To: <ZHYtkioNR2YfC18C@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5243:EE_
x-ms-office365-filtering-correlation-id: 1af4c646-8086-46af-e180-08db6caf4885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: di+Dy7y3Rxcx8IaiTHvdZ1MdOH9xbaY1CzAfowWcNoA8pdtDo/gcUijJm7wCkcemRxRE3wcFyqBq762uEdYGDvfkz9+eGvBwjP7mZk7L4fmwJmT7KmkqlzgyCcMF0uNEMwY94HN9vcYXZ/0xTVXYkCHzcrN1EmxA7T7j+gABrpxgtj9EcrZRQuK9RBvOlON18PLYLjEPKMzr3+gNngRWAVszVYCTYMCMFeSKfH3S4uhjX7IvMgQ723IoRojRCwengBPU1FJH5UAqBtoAMuXw3uY6x3LJpd9zT5cbW/G8FZIH3EiX8x1Gr5/ujOl+3jVY8p19rGNcTwpJGs4U8/tTQXGqK4Pdt/QR8+frtMRVK4J1pr36CTBA/coqIowTSZ3KH3eA2nynqxwMcV37R7EYRgMzn8iiFo+4f0muNMSBvID1doL30F7F9EngwxZQbrOoQfjhaILByzfXITWAu8/FKc4YKVdGuzId9do/KZ7I7C27xdHRFIQlBN94Ayo/zz5/yyI7oeOuv10rrRiymmPMxVBOvM9A5zu3bHOQqNc5iS87RKSAiUsF5E2KBuPLBAFR6Dbx26ED8vkRDQIr3ZX5GG3kX3ne5UezvtMYDrJR48RKPB6Yj5mZn+fTl4fS+UGF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(186003)(38070700005)(38100700002)(2906002)(33656002)(4744005)(86362001)(7416002)(9686003)(6506007)(26005)(55016003)(82960400001)(122000001)(316002)(7696005)(4326008)(71200400001)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(6916009)(478600001)(41300700001)(54906003)(5660300002)(52536014)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0AN6LPRojp4dtPPMopdgWB+XANTpvNt+KTvcK6++A4qrxuR6fSqiSreJhXQN?=
 =?us-ascii?Q?vfhcGE0Jhi48E6tsRlc05IM2WFvjdgY5SWxBhBGaq/drZAr4/CdpAcIzYts1?=
 =?us-ascii?Q?43VTA6d2fNlUovy6OVa+VwumtxM2Hhquu4/wGvEJUpEAjugm+xw866yIiXU5?=
 =?us-ascii?Q?G/1lpEl11LvbIHLOy+kzwee9dkiVRFKvlhNCoyFBlCMSwcCbf3bLy1r/m8dr?=
 =?us-ascii?Q?44WvLVaLfP8bCV7aobOA0YHvXeHW3wgf966ncksiqzMP5BbcTt3+s4Wr4a8P?=
 =?us-ascii?Q?UAUbD2tGg2UGQddjLh5dsRNb3DXbP9n2eYxWBh4lMouQzrY/hnzedvKQhgt1?=
 =?us-ascii?Q?I4lvhrE1g686CPpzSrmORPjgqch4DmkrRrDNxYkCwpzLVv6uzSbPRvEMZ1ix?=
 =?us-ascii?Q?TWadxusVty6pj2D6t2CgEBOkOeIh8xpzDCWUy0mE7aQA9X2YQGVSP/Hy4aC2?=
 =?us-ascii?Q?frhrez0SOBKK6bR+EZSQD8lfG/l51PMimQ0IBPWTlX8J9GFfzYycIhQiK7Cu?=
 =?us-ascii?Q?zHX+0cfXU7mp5m9Nha43VyBZOziSnqcxj3iLYqbYJys7hfXxYioVejAuCMCJ?=
 =?us-ascii?Q?CFKaerIxoRtZPwSp4i0JlWdmSga/SYisiAZzSytkWNylsPrVWkOY7I8/cTa+?=
 =?us-ascii?Q?H23I4dIOoCjp/xeDL0ohBVNqv+Kc+tUVSudGqFNVMAmatHN4QoBY5LHCYVCy?=
 =?us-ascii?Q?vB5ta2B7WeyszxXcOlIcB+NVG9JFpCn1jgMpQDKJW7uEihsZOn9cATbk9JeH?=
 =?us-ascii?Q?Mg3Su8ZhF8GhwU2RdIM/tKElG9hP6hi2eSFjE/gHrLQBfGctlrbiiKVvvdzb?=
 =?us-ascii?Q?pf1pwRPDwF3JZ2J4gsqzmGJrntOpTQTy3d1ANT22ch6rf2Md5PBiKXrSdZRV?=
 =?us-ascii?Q?a46dyKGu8bhpLe6JJfgCb6SJ0Akr4ppqKEPlrP/hR6jid5VAioPvYO7YdyzC?=
 =?us-ascii?Q?iR9x2ISmy19LSDVPDtqoPP9g2lLMLFQ47C1OBF5AiXMN+i3xjCyJBgadKwa3?=
 =?us-ascii?Q?V9ygDfHSXGicSt34UsjjJMIsGLyTxRjzJlFsal2DCvrVTmAl+jU2spsmsslz?=
 =?us-ascii?Q?Ak3JkaYRBVOFW1a08I76OL71by+RIbQYbEJ5IHizXOVkFR3g8g/eliBwOK2R?=
 =?us-ascii?Q?PA5S8LGmpAWfAFP24mYHs1OnvJwZL08PJYdkxN5C5K36DB5Dy09Qa4BSDOxK?=
 =?us-ascii?Q?Ncmg9QCnvXvN/8/rQ5tIHDsk0dFmiMdnoHNwL8C8njJM6SDjKgvpSxglVWVH?=
 =?us-ascii?Q?gU3rMrFJJtzr/q+hvV+JHHhPPJL5DXPcP5Uq6M4aB+VsLxtWRWRoIpT2nCGz?=
 =?us-ascii?Q?sHTMnZmnogkomdlxLerltDPrT6WUgjd1IPGXnQUYCYswFZcu7CQoLPzsbbEY?=
 =?us-ascii?Q?Z4m+8FIEqs5fkSRDvryhIdxr+pWXFIXREBioqEHIMSms4AxZOsP5ww1ouKF1?=
 =?us-ascii?Q?/dKxPXZhBk4iSHrQFSY1LmQyKljeq1qasfzrEkfV0TC1JCNr86WqSvzrplKc?=
 =?us-ascii?Q?zLixkFpRsPNUIk5Xd2aEvjqEiSrsH6GuHcfS01sgonfWyVqWA25DQXkMo9tO?=
 =?us-ascii?Q?Ozxn/5nniTr1+2Y9+ziSPBad01RfC/yyiV4NR7nm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af4c646-8086-46af-e180-08db6caf4885
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 08:13:49.4382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZR9znPByTk58SCwHJ+Md172ZnU+TSJ0y7/LjHHspQLDOsmMg3fQnwfw+aBSzNsAbqdJeLmGxYUuK7VsEJ5Zhzw==
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, May 31, 2023 1:09 AM
>=20
>=20
> >  *   2) all SVA domains share a reserved domain id per recommendation
> >  *      from VT-d spec (section 6.2.3.1) so domain_detach_iommu() is
> >  *      not required;
>=20
> The DID should be managed and allocated for the S2 pointer and the
> flushing logic should work genericly by tracking the S2's being used
> and flushing their DIDs when all the S2s fall out of use. The special
> identity S2 just gets a static DID that never falls out of use.
>=20

I'm not sure it's worthwhile to fake a identity S2 for the bare metal
SVA case. It's far simpler to special case the reserved DID value in
the SVM path.
