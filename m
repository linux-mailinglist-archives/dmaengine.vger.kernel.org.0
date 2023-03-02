Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3336F6A7D4B
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 10:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCBJFt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 04:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjCBJFp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 04:05:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F463CE01;
        Thu,  2 Mar 2023 01:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677747943; x=1709283943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZIwVy14DkpyPVjkMETlZF6v3qm6gnPICu2aR8MiXxL0=;
  b=jns2I5TNu2qTXumpwtgQHyOQIn2Ei7qNFH2I/zoCBC8zFoKQxH509mA3
   G9P+jwGgJ6i1oedldtq/tiP5eWRnggWC8xAwZMa+70MvnjM5obNu6jxgS
   wuqD3KA1FodYMdHDpQmljuSQXs8H1XoPPFlh5Rnnb4qAfishnx80OMkJp
   FhnbxY3X9YscbT4L1Z1JwsOUtsdVXGlnwlPU0MhrRfCRkg6A+w+eAFrjF
   zfnJ9VUZMWH2B3lAKyt+p8tWunc3MvKVOj4b/+S1iKZZAkx3SddImtEWL
   f25+Yf3H6qB+ctGJfg3NVS7r1s3bTcjyq0nijfNYlsoDGSb6wBxisP1wi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="318467332"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="318467332"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 01:03:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784731711"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="784731711"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2023 01:03:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 01:03:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 01:03:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 01:03:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 01:03:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD2qmeMZDNXifd/3fpxWjQxqRvrTpG16Izy14HDKSHTRFEjk/1B+f3nfPf0hkF1Qg2Iel0PZSm1t8n0VqI08PwN7bGj670MzGuiEtzZogRqn3v7ejHDb6oWFDcMtd6iJz7YtoXNECix/oma58VvX4wqG3vnK8psFAD/7G28N9FQPLWEALq6X8ORdNZm8J7bgxbB5atBxnAUSWndjSvH77clrEzXjCdLWq56WRZT/89da2Dwf58Ytnire+KzM2GXg17dIyy7JzRg1osaIxoh6lYTAEB7tRjVtDS5Smf+84ZlMHiPUSdZVgnjeFKnmfShdX3EH9RvrhNr3Eo55Gm5NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y10TuUh7fcM9yIfrsNibSYuobyQdCBlfQutsn5Zi+Jo=;
 b=Woqp8VlypMxqU7/2gtVzqNIEsgl1beqnDAF14KZCPRI7qlKcGyoK23vVHWhoA8rRZukpo12FkhPRiI4lqr0oLiqUYQnCGKoOK0MUjCJnXg+GR4GrWuhJkqO/Wqkj2oLEnmq0q8F7vzp7e2BoBjr0BhMBKEIOhua84FChEssaD+JWGs2cZno+nIv7f2b8ytHn244BgcJtCTNJxXaMqVMzhZPA8fasGw0A3R+zl+AvWgWBIn773zBRXJ+00KhL9Ynz5pOKAGLS7Agp3jCjBBCCJ1n+JHSAw3bVfqbhey29X/mpDb3x9xO88i+9ByN1POvxY4pPoBRhueolqpHiMFsglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5379.namprd11.prod.outlook.com (2603:10b6:610:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 09:03:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 09:03:52 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: RE: [PATCH v4 2/6] iommu/sva: Move PASID helpers to sva code
Thread-Topic: [PATCH v4 2/6] iommu/sva: Move PASID helpers to sva code
Thread-Index: AQHZTJj5HnHa9YIa9kO1Q/LNXU7+Oq7nMkNQ
Date:   Thu, 2 Mar 2023 09:03:52 +0000
Message-ID: <BN9PR11MB5276E466C33CB6240B06B0728CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-3-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230301235646.2692846-3-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5379:EE_
x-ms-office365-filtering-correlation-id: b15c8992-6441-4043-519b-08db1afd0b5d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7W5NGPnjUR7rveaf0Tx4SeEL7D6D8kdVif7jC2P5xqtg+qoTEJ6X7svf1Lu79h5579bnyj2hG6PRubumutIV1Tx76xK01N+y6v6X3VfCoCwiqGLt2idV2X5S42Fl/B3/sGKYZtFeKaqQoFKScEr1E3jbwWvO84uyClRjujEFSQqquxwrrogqiq+Q2XuWmw/SfN5QdD6D09tWCaNij7G78eZmiWvn0+EOxZmvPVQWjNzxkSTzxclVwzvHlnS0vBGcGwSBF4zpbT50yrdpflbGvq2dk+GJrauJJ47UPCxn2jvEkbs4PFgx9gdi6YXtG1rPswm8qJAbTRfQZ/g6ccLY6jGBX/V51rJ3KNGh6HfG5VnBu0i5SgGtgrdZMvoPM76o39DOY0OWsDOizHaG6xwWp2WWS21+JX4B0YkZNU+MSFkMDaylnNp9GUVBYLD15gE0HARfJxEAmdsJgKI/8JSAiY5pVezW112zHm++xP6q3QUe5Axd2fIqYzIuGITx4IR5O+/tiB5YbpZjpVX1fVm+kTstyHjies7F/aF7xbqJ/8brdb82jHVXbofMwb5ZvcAr0NGS2FrsClwG7oLKA+A/ErWtYwxJ5vkq1CklGtwo6e+L0l/81BNpsQRLOoinLQR0RtpFdlVMYeQtP5tFGg5PKns8S/HOF0UNWbqzhJoIe9L17UXOjsPcBXIzbwJHQkkPW7zAUasqe42gu1aFwtKVmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199018)(38100700002)(122000001)(5660300002)(478600001)(8936002)(82960400001)(7416002)(921005)(66946007)(33656002)(71200400001)(86362001)(38070700005)(55016003)(26005)(186003)(9686003)(6506007)(64756008)(66446008)(66476007)(66556008)(7696005)(2906002)(4744005)(52536014)(8676002)(76116006)(316002)(41300700001)(4326008)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?08RKR70ScGzzgvurcMJvbSW7SNFxNDtLHupeKflaVwWxL+F63ZnpuRirCg6s?=
 =?us-ascii?Q?aGijFLb6kbBN5XzaGpqHm55g2NKlrSromcJ9tGRk9aVCTB4fJHHc9dZ0YPRc?=
 =?us-ascii?Q?DhSbpEyRJpBPrZZjmAZMhOkC1QDWIX5mNPHjOGBqM4eV+I9/wbhxAwQOGOg2?=
 =?us-ascii?Q?tsV6LhRrOm1+66pT1jcT634KgYmyZyTEy0JhpMQxCBKwSKQgCoq7SYds92d7?=
 =?us-ascii?Q?4psJwaENNWKnKQfW4GKScZS3X4RNUcyo9hPFecnr+SRKNWb1IAqPj7dLU8u/?=
 =?us-ascii?Q?a7m780De6WiS373OmzTo6GjjrHaUkOagHoswTvqvlug36LizNTWZjgk7YZvx?=
 =?us-ascii?Q?+6+yqqjeDpP18TfGdgco+ZdlNqGbuaTEZdbhp+b0hytbkSainNELL0Kudiqa?=
 =?us-ascii?Q?TT2K/5EZPozYtCiSyYgW/ujPPMm5DQ8aeGxdbC5nlSpqSP4AmEqp9ABsB2Tl?=
 =?us-ascii?Q?Z3G/inDY7OuqrBsQPTo3toZ2vbEl7b5cXatGDab3zDAqhQPRr+745lQ5vgU3?=
 =?us-ascii?Q?/Z38KRKeRVv1PW4XzPzMxgyMOIKJMQ3m7RK8oVGUKe3Sbeag3vaYvemX8zQ6?=
 =?us-ascii?Q?njVdNSEn0t/VuDitgzg1h6rP/bIyMjrnyNHMb5pFBFoa/NFIUpDLLJqcHYYz?=
 =?us-ascii?Q?IgRYozKCFMAXnWbu/DOCoa3PlpQdT775XwPei20CvSycEoD3CInu0mDGPt52?=
 =?us-ascii?Q?llxZdL1es073xuSxij6zpLUPqTJwYCztB2vImnpHZIuQunpXmYb/GrSqxqEO?=
 =?us-ascii?Q?gYTaiHcMHvQtlW2CQRJs02+62FV3HKMTdFvajSp+U/xDDlbJGOZvxztAx+6R?=
 =?us-ascii?Q?Kwroy+lWPzngkH+Ncv7Heu351B8kXXekRoxfZcLkHfH1+zl0uoCxrXRR5tuR?=
 =?us-ascii?Q?mY7pehw237RLdaorHv2tboULtOQ9ew/pwPZZvjM3EnD+YlZ1XjbBQatDzMeA?=
 =?us-ascii?Q?V7vV990AcceBKBO1/izpA2izNgtdVLQh2gY82VrSo0bEea2W1BoZiZj5Q9/r?=
 =?us-ascii?Q?7HP1yYk4byGifWQqnGszKYA3FYEhuuEL5AK2nEiWK74GGmeJorCVOiRJvoGv?=
 =?us-ascii?Q?7C3MyoEmw+gqogYfnuEGd/oG70TvoKizbDiy+bbnRvXsZUgRT7TJcd2sD673?=
 =?us-ascii?Q?CGaXu59saoIf/COlAgpohWDZ89nfOGULYdGsZk8Mjhzvm+QEIWNAj1WHJlQ7?=
 =?us-ascii?Q?GM7YrmCLOhkDH/xxUpkI8XihgE1UfG66MMkPz2ZNT5H1gEQsCh0qruK2/CGi?=
 =?us-ascii?Q?iTie+0cPwMt+mi9XkcCP0Tdp57XtGCiNZTeCVTABEHQbutqJy0N8lygfLaOy?=
 =?us-ascii?Q?3r/A0UX+4vaGSZWyur8YRPkVP9u40bz9U/JvtPWVH/xaMWCDk3P4RNrIwCBi?=
 =?us-ascii?Q?s0vxBTPs1YH1uH8cyQBC0VuRcWqyZqr9j4Apzd6zZgIf0WqkvLFDLstKA69P?=
 =?us-ascii?Q?gtb8MIkYVIg0ibKOK5YM+GDtJYHnCxDJrAxIrczy+BXYrdiD8PzwBhbgvUnH?=
 =?us-ascii?Q?AcOLvAhEOvMF0zqs3xmQzEh3UvXFGL6aJ3ST7Keapk3ahD6BBdbu4NxtWnh5?=
 =?us-ascii?Q?+wO6sIdhef0lrLHDpP0zBIB4b4JzIaYLdlYXt0OM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15c8992-6441-4043-519b-08db1afd0b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 09:03:52.2614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yj47OKPRdt/DHw+uBwBfYp2BTS/SFVZ51wtM+st9vYpMZr5mxFgGMRIzmfq7cOM+g6nZARNDt47ZeNoRRMqj7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5379
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, March 2, 2023 7:57 AM
>
> -static inline void mm_pasid_drop(struct mm_struct *mm)
> -{
> -	if (pasid_valid(mm->pasid)) {
> -		ioasid_free(mm->pasid);
> -		mm->pasid =3D INVALID_IOASID;
> -	}
> -}
> +void mm_pasid_drop(struct mm_struct *mm);

Is it good to have a function declared in a header file of one
subsystem while being implemented in another subsystem?
