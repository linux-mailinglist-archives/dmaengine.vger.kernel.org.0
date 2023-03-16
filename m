Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9406BC701
	for <lists+dmaengine@lfdr.de>; Thu, 16 Mar 2023 08:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCPHZZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 03:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCPHZX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 03:25:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9CA5BD8A;
        Thu, 16 Mar 2023 00:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678951521; x=1710487521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7eXeQDx1R70Uy9CUZfP2EOMqGS3eVg9qeNF/IRaFXZE=;
  b=l6bXIFchzbg6htnSkhxXsvVSfVC86EE1xpbmVCtdKjfJ5N/HlwVFQ6//
   sZS4PjCjGa8BF3zL543bD5sGleb0JLPh62TPCtuPkfKCBv7dz8IhFc6xx
   FpQI5EZDI6ik1lUEIWLhm//KpTEZAa3dD23O/yTf2XoAIjVbvYrLdzJ72
   0ydSDUXgEHYuGRGdzO5+rmmw4QeoRDdcuDoXrMKoAfw8pAYcVdc6jJ8Zt
   LfdDf6XB10o1cDpH8G3EeVfZ78Dk17Yn2dmSmB3WoszeS2etdpn2XwIg/
   YAF146Yn3NhVap0Kde0RYc+Fb8v46AOMrH9XWvrTuxvtmbe75WpKx+Zya
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="317562193"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="317562193"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="673032564"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="673032564"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 16 Mar 2023 00:25:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 00:25:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 00:25:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 00:25:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IleEyWy8LtaAspkid/v3BDSijtKUKbrQaCsaGWr66C2Gcu7AFDFQvKwpQNoVftVan0NdTMx9jptaOlBMREWJ0cMIA8GzWqfjSHw6UFQPfemx4y62lRSi62d2kfj2tVd/l8SK+gS6GaIBnPZrXu8t5QDKEfY87L7H2NHOM/5z5rlHL2nKs0kYjGDwoU0z+8q8/mYn4RO/IdcoRYxEBxQEWChTpA3SGvmYQEAx/rIucB8iJbwVaPV1pxrIfzNrjaV6oCKLwluZZU3CfNCzozPQ3Z5psbAzutZCMTK3jpZis2KK73OOU2nCOxgx7Kby2gqqaoGmXas29htOTWsylWyCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxEnoCDSd6HYoSt7Vns3s5vm5T/kxaJUc4E5MAFGV9U=;
 b=ZZQsLGwGGAJ+ZbliwogItoxNt58/U5DX4mEUkHPtANzSz6SSSN4pJxhpX746iT3TLz8L4BqFFh01qD2UxwPEPw47fUPsuLgYDFVdj5vdlgDpFI6whDNx4YrCszFZqqeNM6tt5PON70jB+zaglIneAm0ahE9nY03sS8KibbqkdOjUu+caFbPx0BE4UnWIJN2CnHHEn9m+LjyKtAwHgLN8Gd8xGgYagyHekqREjhMTO6Z23ajdQZYe58iWDtvNfOSDPtOAzS4QUaBAU5cDPxI4itusz2BwtoGGTRZg+kLN0bMbl7qGOLGHbU1kNIDa0JeK27cYLCHY1/ijcGa0kcdzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6349.namprd11.prod.outlook.com (2603:10b6:8:ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 07:25:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 07:25:17 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Thread-Topic: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Thread-Index: AQHZTKHLpFv8Ca2hQ0+TT/QlO+gFRa7nPClwgAJeMICABCPvAIAATvUA////3YCAAAQCgIAABegAgAAIRICAAAStgIAElbqAgApc9+A=
Date:   Thu, 16 Mar 2023 07:25:17 +0000
Message-ID: <BN9PR11MB5276DE801B64423E7BF3B68E8CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
        <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230303134753.660d0755@jacob-builder> <ZAXkLN39VUSl+t65@nvidia.com>
        <20230306094408.2d675d5b@jacob-builder> <ZAYmS4Sx6bm+ziDY@nvidia.com>
        <20230306095759.1dd65cca@jacob-builder> <ZAYunPcgSOGFK8Qi@nvidia.com>
        <SJ1PR11MB6083DFA2C1D00B00C3918982FCB69@SJ1PR11MB6083.namprd11.prod.outlook.com>
        <ZAY5d2MSXjWRGF0n@nvidia.com> <20230309090623.7ea2c3fe@jacob-builder>
In-Reply-To: <20230309090623.7ea2c3fe@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6349:EE_
x-ms-office365-filtering-correlation-id: 9b4d4402-37f1-4cdf-0477-08db25ef97c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w0kRjBYTLiWNLbK0xD7AGerj+C8eipt+cqjUiYgniBlDmdBY/o8ytRHX+XzW0KPaWBvDbtCspy68vdlp7ue0FAJSPKoGlEZqFeqoYOvz7KvTZSYK8C6AQjcTZj8Ez6U6BiDc6PWg/pmGytjx1fAyGFjT7dlBhp6Jpc0KYW0O6t91YRFap1mdgU49sJ+tJURb4RtCOnP9UwwZl2JDa5P2WPbl1XP50uTQAofZc5xIuithZ5X6kiF40iS84BcsyCBRGla6NNXznvDjBi/kVndFTL+8eyLTY57/hM6XzfHOmiSWgChFsDHtZeRexn2okY4xoq0QimZnLTXsw/VKmKa9A1MmwM0GghyUw5kVlKwYxXkgtZ67zkcE4VofuTB9s5lB8M0Vv8yi6fkemmQMdcUzmZvPeNl3MnbgmYboDm5FSPvmSgXXuQw720/jsk/C3RdVrmacyNJ+8lgqcwVJV7TvLWvVA1Y3iuzmsHUHB9JHYUM9NYY/kqPmYMQTZplThC8aCDHKLj+q+zCR5H4lN7s+O3h2Obwwn88/1BTX8vaAnWKxrMBceCpQkVLfB+83Gg22b3Yz+QyvkTQi6yolcpdN8Z8JRtmn+aNxBjLUQwPfJM4SIPg8JZr54AMxGbDQ2mBUeAAS9JtWDQs2cKf6tU/39AzOvZ33e+L7v8dWmmUImMVHhvd+5SEVybBT8x1S1Y6W19JFZw81m7aVLpeNLL4UYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199018)(38070700005)(86362001)(33656002)(38100700002)(122000001)(82960400001)(2906002)(52536014)(41300700001)(7416002)(8936002)(5660300002)(55016003)(4326008)(6506007)(9686003)(186003)(26005)(54906003)(316002)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(8676002)(64756008)(478600001)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/WhKrfW9ll/oFRsn8Mi1gvPgKpoEmdCjw7JBwL6KOmtCdU1rm7AdAhc6xcjC?=
 =?us-ascii?Q?r6bXMBPyyZzz1KD/SXLjm6KODo6nHegDKYK2NfW8qprNTEUVrSL/R30+CiCh?=
 =?us-ascii?Q?cqK2BUZoFri16TtDL6hRmx43J68lOEAiRpNxkAVAnokPFqeAZDBhN+D/f8Vg?=
 =?us-ascii?Q?lob27t9rr3lSb/oPf6xKTo17irJQ++J60VO7nKCQQlBGtFCAXRKQhyGZaoCc?=
 =?us-ascii?Q?ltNoGK80pOLHt5tfLlluVWaigUJFzLdmb4+ZyIuJtlhLx9u8SJZNdei2gLy3?=
 =?us-ascii?Q?I6+BQqs3E1Ea6NhqojoFkCaZaa3GA9PIJTiOwtWalIbhD/Wl1WpHZZ4WR/tY?=
 =?us-ascii?Q?2BNsYZBXlvLSu34o5e2YPBy5vPw6jLbwNXQJ16KUZMhv9An8Wjk8VWN9gspM?=
 =?us-ascii?Q?abX2jjTuFQ62Igdsgc4iG3rDbJI+ZWtTyGgY+RKkWh2/1ecwDSFyu4P5wMCU?=
 =?us-ascii?Q?u3DKjaZuwDO4sHO69wBuvD2fyATcEfQ3KepAaiPEB7iIZ//oKvYYzNDaCsAb?=
 =?us-ascii?Q?ZwuVoZt70ATBrxZyd85XsJKUXu+2QbBWvKDJTRKd6R3TlS6FEZsm2GIOViLa?=
 =?us-ascii?Q?sV0e3gAMcNwIGztbMrXGtkZrwT/7rE9s3L6K1PYnemI+I1MgRYyg1sjwuwem?=
 =?us-ascii?Q?uFvYgPxtr9Jl+wCHfNK3oL6GKJO6+U2//N4udVUiOtKiUWjC7EPbsUGkznue?=
 =?us-ascii?Q?wB8pG/IfyHLNiczJUy0i9jix/w7YXZy55mGVZtU3BSdGRp7fbBNEfXHDEioe?=
 =?us-ascii?Q?YhUfUyzPNLSApGVfdCkd/azHRIKyfnmK+wWsizkf5TY/R/5Urxa50DDRIk0X?=
 =?us-ascii?Q?uYR0G8rNalUSgihPzt6KwEOqYI8uxgm4OnYpB9r8r2MmOnBD078ipihtSEUf?=
 =?us-ascii?Q?rEf7SbIpPG1FuLWGYrduNSL6LL4xwFdT118NmKhkSYPTOaJB+TFyln1uBXYu?=
 =?us-ascii?Q?KC5f+cniXxQHQ3ZmuY60O24B771b2ElkReqZhreb/QT8IWY6rbR4s2Yi0rfH?=
 =?us-ascii?Q?bl3nzwOOWsb5QjnPEynVxL4r2pttFTd3GNaaQJ4vUXOpZdRqFp1ftqtvZt7X?=
 =?us-ascii?Q?CVLWRLaavXfRq7sy4IzsIsPUm409DJMAvtkMTmlzRHK/jTlYCxzLfZ3Ox1zO?=
 =?us-ascii?Q?TQZydJZiPsRpcz9cFzfp1lqhlDfoOhnJkrCszLzG43chdsExL0zL36/gI7uJ?=
 =?us-ascii?Q?7bfxAzTGbqV+w8zrd0JoTyw1E+HD0puynebrfu07rUU804IxJXFnCxzfiG+K?=
 =?us-ascii?Q?K+ijBmdlzCsVRCEsn+oYtdexx6vS5RvHazFtsXqaO656tFSM22rxmwDzkau/?=
 =?us-ascii?Q?Rh8SvLc3TxnyPeqvRogMlfMCMjd5GI81dgCHBrL0E0HDVIy36BYfw+LlKC7G?=
 =?us-ascii?Q?pjOcwv+3XPEzNVPmcuT1UEm3fapKMmvUWNo+bkT57oX59DCbp4LeAHbTnh53?=
 =?us-ascii?Q?xCx2U0Mbp8RPHVholq76qGPrFJQNk+zJkqXSCR4DBuFSt1rqSIrTY0LCL8iB?=
 =?us-ascii?Q?ACFYkPUhgCwaTDA/KFFbZHJQwrjXQFdqLN1MXBXcheIv7z576qyHiIXdRxvL?=
 =?us-ascii?Q?9LY35jtGi6ZDKkoIckJeC3YNpwVl6iiPT7RJwjLz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4d4402-37f1-4cdf-0477-08db25ef97c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 07:25:17.6140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9scVoDf0tVM5xMbhiHN/+ys+zuL41EqYZ2Wij68mHAtyYlycYLtkoOtMpIXvM192Cw6Y88BdZbNtq4JhhjOuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6349
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Friday, March 10, 2023 1:06 AM
>=20
> Hi Jason,
>=20
> On Mon, 6 Mar 2023 15:05:27 -0400, Jason Gunthorpe <jgg@nvidia.com>
> wrote:
>=20
> > On Mon, Mar 06, 2023 at 06:48:43PM +0000, Luck, Tony wrote:
> > > >> ENQCMDS does not have the restriction of using a single CPU MSR to
> > > >> store PASIDs, PASID is supplied to the instruction operand.
> > > >
> > > > Huh? That isn't what it says in the programming manual. It says the
> > > > PASID only comes from the IA32_PASID msr and the only two operands
> are
> > > > the destination MMIO and the memory source for the rest of the
> > > > payload.
> > >
> > > Jason,
> > >
> > > Two different instructions with only one letter different in the name=
.
> > >
> > > ENQCMD - ring 3 instruction. The PASID is inserted into the descripto=
r
> > > pushed to the device from the IA32_PASID MSR.
> > >
> > > ENQCMDS - ring 0 instruction (see that trailing "S" for Supervisor
> > > mode). In this case the submitter can include any PASID value they wa=
nt
> > > in the in-memory copy of the descriptor and ENQCMDS will pass that to
> > > the device.
> >
> > Ah, well, my comment wasn't talking about ENQCMDS :)
> >
> > If ENQCMDS can take in an arbitary PASID then there is no
> > justification here to use the global allocator.
> >
> > The rational is more like:
> >
> >  IDXD uses PASIDs that come from the SVA allocator. It needs to create
> >  an internal kernel-only PASID that is non-overlapping so allow the SVA
> >  allocator to reserve PASIDs for driver use.
> >
> >  IDXD has to use the global SVA PASID allocator beacuse its userspace
> >  will use ENQCMD which requires global PASIDs.
> >
> yes, great summary. I think that is the same as what I was trying to say
> earlier :)
> "due the unforgiving nature of ENQCMD that requires global PASIDs,
> ENQCMDS
> has no choice but to allocate from the same numberspace to avoid conflict=
."
>=20
> In that sense, I feel the global allocator should be staying with SVA
> instead of moving to iommu core (as Kevin suggested). Because we are tryi=
ng
> to have non-overlapping pasid with SVA.
>=20

I still doubt 'reserve' is the right interface to define.

for DMA domain probably yes as it's static and one-off.

but thinking louder when the same driver starts to support SIOV we
need allocating additional PASIDs on demand which is hardly to be
fit in a reservation interface.
