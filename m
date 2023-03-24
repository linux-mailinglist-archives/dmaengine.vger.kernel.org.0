Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C67A6C75FE
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 03:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCXCpg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Mar 2023 22:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCXCpf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Mar 2023 22:45:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4BF1633E;
        Thu, 23 Mar 2023 19:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679625934; x=1711161934;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=saXE6G/0fJgVaSIZSw42wplsfMPFVi0zr8fKAJSSfS4=;
  b=daenh8fskRw6iXhoU6nXvUp+96WSi9vFcfECaEeMAj75tTOUMOaP+rLD
   rte1xHRWJK/F7V0khEBszN2yfEYZVXXLW/gL3S+5LHbBdGfGjqh7U2aFL
   mrmAvJYftCOzBmnUYBgtkAYxceO3vZdhhT4GuCWpk6v+nokGySqy4dSZW
   RDu+zzzQqyvs7Eo157SejWdkbTnARxW7mpkODyrjRpmmF3eqiwjMl3ZZN
   WM3UtEyrltgE7kTnd/6XU+JAH4AuYEn7qTdU5f84B6B4beM4GNBUyiL0t
   vSrgSEUWNvuegAuB1uP1ltvNafWyrv/I+nrPve7y1cNnWCm4FD+Tcc7c6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="339711094"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="339711094"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 19:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="856710675"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="856710675"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2023 19:45:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 19:45:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 19:45:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 19:45:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 19:45:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSUF2wSheCCMHTcNYaWtg0BmyoyREQCVbHuW8dB+g/DPYan0GjxGtSvPE7rAvGQa2rrXcs9ttwnU//wrmWc4AtPuizjxQMqiLC1keMeokwgg2it8SiAqDjrBTyRAivdnH/9A4naVwrQoa/oPj7MSOepJGTL7xCPBvxpClBP4mwyxdxDu+a082csSKK0yhmjZyZfiIpf9fJVu7zn3y5TOcCyqiVJxIRmCdUmDW1bP1VRQ2yVJ7HT4/R2lW0OVpp/zQ5HMTbR6dmc410ICcbggfxnEoH0S0vYvoTFV1cnkVX1BsmtvhzsjUQDLY9uCUZgtg0/48K/6xml6tebD3WzUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saXE6G/0fJgVaSIZSw42wplsfMPFVi0zr8fKAJSSfS4=;
 b=PpAyZzcJexCClWRVPCb9e8X9cujY56+UELlkterG5gAppPSoYLMe2uZsuiD+bjyMGaMKqjEB+ftXxU16k2fBhSEcUUL7xjFDJg1WU9vV70iO2UWXXg1BYhEM6a09txV1/G5/1mMkcpbrv4T14n/FfUEujaGk6RAN0WRG0s3sSEKJcjTDuPn70cq9A/DeNAmzIpXkvcGRdRTWjF6hhDOJn/b5keDJLOpF2e4DulXIkIjfRFhkE1ZTuB14g4o+PPoJHc7MkipG5CCEbu9PV+Q4TENSIBAT0Xhs6iadAYyVX3DKRMwEAe8gEoGdh7MWhOqdgKRYTWUYdIYKpzuvAK+tpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8363.namprd11.prod.outlook.com (2603:10b6:610:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 02:45:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 02:45:27 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Kirill Shutemov" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v8 3/7] iommu/sva: Remove PASID to mm lookup function
Thread-Topic: [PATCH v8 3/7] iommu/sva: Remove PASID to mm lookup function
Thread-Index: AQHZXPl9t9KqYcxIK0KSMfXuqEaNzK8JO1ow
Date:   Fri, 24 Mar 2023 02:45:27 +0000
Message-ID: <BN9PR11MB5276C5D73B341655C3DA9B908C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
 <20230322200803.869130-4-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230322200803.869130-4-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8363:EE_
x-ms-office365-filtering-correlation-id: 26372a7e-a353-42b7-ed1b-08db2c11d353
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RE8I6z0dXWU1TirjS/z4Ddov22Ch0hM9nnRodWd+BR6yc1GyENkNRvy8qhTXTUm+jBgznnLvzIO7BpA43W087kJscFlUdx0B5LrwaUOOh4QiWTQyai1i5qu9i1rBhrcO72YIiyVJoks/D910aGsnccW6bS0wyYAoh++2TYuSK+jW18gx4mUGma+SyO05fh134mhR4sCuKc6LVxOxUk7aE1D1TxDDKubo61Di/Z3LIdLy9FrQC9znHGN6gVX7LZoAn+YWBpbS69wByP75ATvCNnaN6Ao6wlcwKJeC9xdAR17zI5zNAHKCnNCD4NQsEgs4a+JUuflAVXnEyiohhIROT6FNnJcWzfyJTBI1Gz4+Vs1SbNeHFLZ76UiUDW+gTRo1AgZ9X3LjPz7vsrgFu1M2YEkCIsuHVHR0CRLTNtsqOdNuX/INgqVUnspkEMBIhKHmCLE1qmu/jDnciV/xzlnnU44bwiTJO1eHzlFA8AGWnO7VSrJgbkeDvX62nFpRjRhHBXUck6DCZ216FBXj/0wDQBReCz01dmrM7qAbcJud0nUbPpHmiifs57GouVjQv+i+/yLiqvRzd7ZmOEnmWokCm6osp7nUxub8NK0QlfSV4GWeSBhroWLXklc7o1/91zXZZvU+IhLmOkgbNBJzazUau7v5Z2DazOKB3uP64lUYCKQJ75KOIGgesBor6Ryt0gUGL7f9fkWqhz1Y1AusqlC1oIRxlCzq+l4CSpv80GgjFDw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199018)(38070700005)(55016003)(921005)(38100700002)(2906002)(71200400001)(478600001)(9686003)(186003)(86362001)(33656002)(110136005)(7696005)(54906003)(76116006)(64756008)(52536014)(66446008)(8676002)(4326008)(66556008)(66946007)(66476007)(26005)(6506007)(8936002)(316002)(4744005)(7416002)(122000001)(82960400001)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fkvPB++stE/9HHeDPNNyTn0hFkm4xPrZa34y2z0z1lr55YceDnkwq33OpSDO?=
 =?us-ascii?Q?nS1ISl1kuqjum5xCRx+XFGU2yqrygo/bcOz5tYR0kDaMGpWb+qudK/X6bOYy?=
 =?us-ascii?Q?It9ImZGiDgUx4mdIsiymvY4ugnRA2Tkdi4QE2VmnUXXr1NlHW6GLMo8ifsIx?=
 =?us-ascii?Q?iQqTT2k4iDOuZOw31HD7LsEhgCTwY1AhDjz5AGs72e9mFXAmtzu9wt0wj/Rj?=
 =?us-ascii?Q?6in6JZoPElpWOjloEXC/+eZyys+N0leR9N5V173uvpu6+zeB4hYxAdcHd46G?=
 =?us-ascii?Q?du/3bVaO8tJq/D91QmY/e1TvmCF3lOblBAQyuYd+cSY1RyPVcQ2UDEqjNmT3?=
 =?us-ascii?Q?DKtYgVou6xEudoqub9m7P8OGEEokTLbEbP+l07e0cGsHjBqRnFB1FPVbcFBm?=
 =?us-ascii?Q?PgomKRigDHRJnpEiwepQOst4xRISU+uS7P8oZaPhhc3Gq4MBNQFxovQ2bYDZ?=
 =?us-ascii?Q?C6kG5MegUaGODsHGtx7qDemvmJ39BWluS4LNucYwG7Als2ea2HggC+emcp/T?=
 =?us-ascii?Q?SjyxDiFM7+4s4XKeiZdNJ70nF0J7rcRc9d1agKtdB2zAlwy+z5mGZj9crKa9?=
 =?us-ascii?Q?L5uYtltu5GVM0+TwFvxE3jN8ePVAxeDnt3c87y81iFGD9KaJfXdZ9jgiEqcF?=
 =?us-ascii?Q?1udGiIvtMBiGZ/8iOFHXD9C5Ll02Gk4dkwGacGhQMff1wHDTMHn/QClxE9Ww?=
 =?us-ascii?Q?WwxR/EkfWhMOBPICvo4T7lGhiGc9fNJeRCTNj1oUlGAtRgD/jRTSjZHYl6Y9?=
 =?us-ascii?Q?Zlk3g+KF92Ico00CTfBIFnxnt5ZUwCd6kPqnUQPGppMf9XiwtrBgpvdQHFcO?=
 =?us-ascii?Q?im0OV2xyE93s8U3cAAGKfC27GZYbR4jfWzJmz7h08mUUPTWTRk+wv+nRVdCH?=
 =?us-ascii?Q?w5Dtr2t6s1MkIzvzhhfX5klTLxrIFrsZEmyblwJGrfhK0zz99huCRwdLyCMY?=
 =?us-ascii?Q?olGy719GaD/aw38B0Pe6jR9WfAi8Rq3jRGpboNcGwTDcZEh3pd4MtLhVtsFV?=
 =?us-ascii?Q?eFM0KZc72pQRlZFravfAcjtrgA2lmHFP9nw9jWwf6ZW4DigRepMnNpDi09fQ?=
 =?us-ascii?Q?xHwQZQBeZAAGXsP9hhGBNzvdn0cjtwx29qege97pEtR4sWJubfXDk/qv5NX8?=
 =?us-ascii?Q?9Xd6No8DRuqBSCrRSm70XwRFKK8WH6kHn3toHPDwCUHktJDPRgESOEjgqd9h?=
 =?us-ascii?Q?h/cmd8c+gy3PmNIQC4eLHprPfmhQSbhFSnrJ2AKwIHK/npeH4DfZz7is5uCD?=
 =?us-ascii?Q?xnM6uMHaF5jyTQHjvYX4T2REdeBrjUKlDxVjU/WZiYLFdI4sBt53PiWO44e8?=
 =?us-ascii?Q?HoJHJqlHOdJjGdpiWxieo7vjz2Q4r/+Ei6uEoBYsb9J6NCc7dqkxl95X5LyH?=
 =?us-ascii?Q?A1Uqzx80YmXoIYsWmZcQDsP6MFgn62xg17xj5wBh7XnRTgo7wnPEvtIxslpQ?=
 =?us-ascii?Q?LEnL2vamNXvkTrx5RqWMgGjZ4Gh/el6ieZl4n+GyryV81eWJERjyTef/AiAi?=
 =?us-ascii?Q?woygQAS2SlWMuEVlB4wcj52cyCSsLccT/qGKQWLeO1KPYsIKYCV1fro4soEm?=
 =?us-ascii?Q?9JSyfIu4pqAE4E3h0WKacfszFFIam7uKA6S+H8dM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26372a7e-a353-42b7-ed1b-08db2c11d353
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 02:45:27.4147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rS+xReUIYRwzZIf7pjH6CcWgLFNKnX+7z5yQxlNLDMB7QSoZNBbK5VyOqTELRdYcsAMXbst0111dsO9u6TT9fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8363
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, March 23, 2023 4:08 AM
>=20
> There is no user of iommu_sva_find() function, remove it so that PASID
> allocator can be a simple IDA. Device drivers are expected to store
> and keep track of their own PASID metadata.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
