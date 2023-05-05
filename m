Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A606F6F7F17
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 10:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjEEI3l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 May 2023 04:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjEEI2r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 May 2023 04:28:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1E818172;
        Fri,  5 May 2023 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683275298; x=1714811298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nHtUAgHBPwgUu6Uedja/OE5sb7xBvmIwwegbmSE8LVU=;
  b=il8ozFSnMm1SYG6KPvw/7rZ0cttUbaO+aqPbnBBJErLrLZV6AoKIu4ax
   73Zks4GjeyBPpAuvbpDTCWCkg0XwuATtc+0bfnw2uLc9IALmXIr38kIMu
   f9lJLdQO/ytA1jMtZpFk/+TTWk6rc67tC/qr1qTewbZntIHWau+QVcdr2
   w2objz64UyecuSOVN7oqA6qzTA3xO8BWQCMyoIlM4fm4YKaIeGh4FIt5v
   /zk39+/7we37AXi0ONI6gJegFAQBieeMc/QXyKyhPusloXMTLK3cHV8Dp
   hzfjCHM3LNE0yQqQId631WIi7i5J2p2d4rj6jxAyVWSTaLYg8hhxyTTVp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="328782813"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="328782813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 01:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="762345705"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="762345705"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 05 May 2023 01:28:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 01:28:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 01:28:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 01:28:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 01:28:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjUgF2fIcQGnLUfgFR4eFHqZhnTzvzs1CvqMqsF0pxzcxJ9Y0LiUGu2FiidRD0dWm/EiTC5o4U9WKLoJsWEcCw1+fHzkrL5NMptUFo65czHFz2bORk0WwimaPODKtKnbQlxQotT16oG6pbQYsDJ8pooPh98kh3808IPeWgXCm0AKg1xd+WdFB9LdLlcibDBmttzMlsS81ppl/SVIxv2qT++7gvvKjhSHZ3ozFfFF3MKup0PdUmaRUcxiNQERrqwEghBM6jHW+Hq+wqBiYRIFZAQq2ysSt4A3XYntAOiU0D9ECvvPLVaJeRwkzxgz60282od6vcaL69rALxjx/S9m3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YhEcGPbyCH9fBNVKhLik2p/VmeIOVpkhplUqGh8EpI=;
 b=FoO8ZCKLleMbcfmzs9TKQIk9eRq+jvAFFloCvE/F09c03q7SfhXlzTP8+TxCbkEKZ4N/39RBCWJ4Due8DkMC+uwJFK9rUpjxK+fKfm4sEarEUfXSHYwwRdx6B/1DS8EKjNrmkP5XSu5XGb9Df8+63yaXBtJh9JWIHYhFqQ3JTeGW2ReuaOonJ/ZezWdFHIHYJbe/HCQZZ3j3KD0++pcFqD+Qqb+NwmqaK63iNLDZfWU+izELYEQ9X6KV2brUMuKx1SIPE2WwRR7IXnHy/aTdGAuc86lFjXcdJNM9pf8h6om5r1ghHO9yTxTpz2frBStaKwooASfDyFJubjPQ+kq0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV8PR11MB8584.namprd11.prod.outlook.com (2603:10b6:408:1f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 08:28:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 08:28:13 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Ranganathan, Narayan" <narayan.ranganathan@intel.com>
Subject: RE: [PATCH v5 1/7] iommu: Generalize default PCIe requester ID PASID
Thread-Topic: [PATCH v5 1/7] iommu: Generalize default PCIe requester ID PASID
Thread-Index: AQHZeTASrtonzxFRJk+i3Dzn6cfwy69Ad3fggABqFYCACoJxgA==
Date:   Fri, 5 May 2023 08:28:13 +0000
Message-ID: <BN9PR11MB5276A1CC0B5FF8D9394F22F98C729@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
        <20230427174937.471668-2-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276FD027EC3D6BAA24046F58C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230428085615.58e437c9@jacob-builder>
In-Reply-To: <20230428085615.58e437c9@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV8PR11MB8584:EE_
x-ms-office365-filtering-correlation-id: ebd51753-7079-48c4-f20d-08db4d42aacf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CWR3lMadIzJYhZQ/5QfutzPTsaT0d/LwU7E45M25kxBWkK380m54QTvIV/ugUVVCQCtzheSfC5lPi/dp49jzx0piaaGW9ZNBWsf0A/UAP3VsYj4m4ZvIaowU/KqIGHGUSBsJewSZO5fDNfgMy8EsEzJJ1CrxEjdGkffEsIGMSLVG7NwQRzydmKF7inNe7lkJxX4QmUwTOwlR4o7GePkFMFc93FAVqIYsF3dnBKjamZe/IiejIMfQaom0612NQJpt02zTBb+75iV9UFfGbS0gWXnz6H0VcYrDqzEJJYtlAOMTA14oHsnvImGauD9QQgaC7PkTssX/HFZOfCtV+vGA/w7uipaLfZvBkB3MkF2zhcfETxqVA1NHo1UgEsvw3MDJZ4gZ2LW4HiuheThmJWsZH1UVJizk4Cchdb9Eq9P+98d6qkacokMbYtkZGkBDBx42eOlaCVcHjBlLhdnTcBbwJBxXm9stU8KZSCmUqb1qTjZHu4YjL/LV1wU4qPcZgOFjgKAVssQtUNlvlFqhiwxChCGELjTE4jhA7MuwISb+XHbt9d4MYAUzAEbMjLM8vGF9TN2A8GKQ/dkbPqPmm9GmfrByFwmK7T2hImlHxQTXmHTtpd2rKiIgqo0+Svbtpv+1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(86362001)(33656002)(54906003)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(7696005)(478600001)(71200400001)(55016003)(8676002)(8936002)(5660300002)(52536014)(2906002)(7416002)(41300700001)(38070700005)(82960400001)(38100700002)(122000001)(186003)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ky2qG/2ZbsX9chtUKcGTzB3hevOLcIBA3rqGQddrtFxI0WPKavZozsi4K6Fu?=
 =?us-ascii?Q?8jGJ7PeDieiFwtdZPWS3+ITbbOe2ddOfUu2Cm1i4mDMFdduARVzjAQsPX5cu?=
 =?us-ascii?Q?jog0yLdl1tEEUjs1uu9rcfrOwQxg6gN2OjeEaycOK5y9dsJStBvnjNaLX8w2?=
 =?us-ascii?Q?c4PBVz8cvM91QLGyRD3dwUPQ/iuZW87xH2iP9Vs7iPazr5J6lINe6eOyaI4p?=
 =?us-ascii?Q?k8VHq/nbq5JJZUkX9vhE7MmQnE5T1X6FPALlFbJ+4qAElLPnrL1t97Mxf8xe?=
 =?us-ascii?Q?lqQCusRXZDlhpohZq0vxJnKX5tZ24bAmulV3pfHfpgQM5G8TZpP/ENJ1oeXT?=
 =?us-ascii?Q?egciNMfJtJz+p+bUIKrKeC3S0trLuddY+JpAaoYHYeW54EcfYoN7bN/AuT84?=
 =?us-ascii?Q?R5npmr9RMubZ6wRfok3bu4v2QpLKlUoklRAm5l/BJx2W9DMW8DGqwJF1TDc6?=
 =?us-ascii?Q?5ZBWJ3cTXZnTu81TD9D2/Ij8dDMhGC1LscfaG7Cd8F7KUk85KvFky2thb/ID?=
 =?us-ascii?Q?1ZVQgtwwEtETMNOwq0/9xUx/X6s/M9gY/8dQC57FehfUySL8IcuXLMqYLLAo?=
 =?us-ascii?Q?wX3iR2TVBb/e20UCaYnFbx0s6pmmriZS2vA6v4Dnm9FNTadx7E70hE3Py3dZ?=
 =?us-ascii?Q?J4JJLqxOBjt6Pz9It6u2mrYljPnTmBrJUO1v5BoEaMv2cPQlOujtIRbw24o6?=
 =?us-ascii?Q?jDHBf9SbbSdd2buAXQZgcABQTUcnmEfjJxE28XICHhfFjnuFh+9G9A9Y2QUX?=
 =?us-ascii?Q?tg1ONHN9q+iB4M7mOOsbC123Ae43LFbNpL2mImt2NR99Ppj/TiqrJ5+d4Wb6?=
 =?us-ascii?Q?B+sjy/ygQtKIrMrjT86SkDZ/Jf0LCp1NyVPdD8nfAkqPSn1EhAQ8hPntDbxS?=
 =?us-ascii?Q?wMfWkUVixQ01965YxlPB+jfhZ3kBdnqVKBl1VoBIX13xZpewiEFoxHRlt/uP?=
 =?us-ascii?Q?3YWABhOZs4aLFM6A62SnS694o3j5X/dh5mA+QgIpK5OtIk6JMz5ojlC4O5gW?=
 =?us-ascii?Q?UhnpphJvYuNJT1S4rE0hvb05B7lWM5bMnvhVNMPyWJDARydZ08fGP0FJcLVb?=
 =?us-ascii?Q?riz+5uTOeFlcBWT5WrEVd/VPyxq8PGnJgYwHndWQf9cVXEdVOS/loTxxI3Mo?=
 =?us-ascii?Q?6iFROzhBLpAUevrx8PwsUDfvfUL5Th5WMpoKXbJeHd9rJJXOaEbm3NI+DXwv?=
 =?us-ascii?Q?INcHafJlitBOLQTDLNUtJhi9Y/1wTTai4xRC27EcxECVh6/0TdyZEGZwlgun?=
 =?us-ascii?Q?xqkZifT5NLsl8JSKKyplO0roV03zSiXMxgZujAI3xHYSyo12Gd4ExwKWwgfj?=
 =?us-ascii?Q?ALBic6qHX06vfrngCVFdeq7Oj9b+Ss7QLmVZMLLYoUunEDUVvWzFoj9OlIMU?=
 =?us-ascii?Q?DINiI3Lsy+spqsA4Ba5fzrbrLqyhNEO9eDT2liSCzY0zGl8DlFCyRBffWKrP?=
 =?us-ascii?Q?KPZu0uiyFS2qQT2RLaL5nf9X94ib1Ucv6GCaZjWtG+oOfdlWi+pUZI02dv1o?=
 =?us-ascii?Q?l6ij/OqFhzQtzQOhUcLo8P0k8vm3Zi31/eT5egogkmTfRt4niNGDmHB9tQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd51753-7079-48c4-f20d-08db4d42aacf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 08:28:13.1358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: grYdsUaupIYZkAa0DsvZvA2hPLVPXTaIgW0u/mnx5BN3U/+KSGgLSSYS0hueNq6kYFB6nN2q5HTZl0RvL8HBiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8584
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Friday, April 28, 2023 11:56 PM
>=20
> Hi Kevin,
>=20
> On Fri, 28 Apr 2023 09:38:32 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> wrote:
>=20
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Friday, April 28, 2023 1:50 AM
> > >
> > > PCIe Process address space ID (PASID) is used to tag DMA traffic, it
> > > provides finer grained isolation than requester ID (RID).
> > >
> > > For each RID, 0 is as a special PASID for the legacy DMA (without
> > > PASID), thus RID_PASID. This is universal across all architectures,
> > > therefore warranted to be declared in the common header.
> > > Noting that VT-d could support none-zero RID_PASID, but currently not
> > > used.
> > >
> > > By having a common RID_PASID, we can avoid conflicts between differen=
t
> > > use cases in the generic code. e.g. SVA and DMA API with PASIDs.
> >
> > You intend it to be generic but in the end only vt-d driver is changed
> > to use it in this series...
> change for SVA is in the patch.

My point was that since it is common why there is no change in arm-smmu
driver to use the common macro?

>=20
> > > @@ -190,6 +190,7 @@ enum iommu_dev_features {
> > >  	IOMMU_DEV_FEAT_IOPF,
> > >  };
> > >
> > > +#define IOMMU_DEF_RID_PASID	(0U) /* Reserved for DMA w/o PASID
> > > */
> >
> > Is RID a general team on other platform?
> RID, aka  requester id is a PCI term. so I this it is common though on SM=
MU
> might be better called stream ID PASID?
>=20
> > Would IOMMU_DEF_NO_PASID serve the purpose better?
> not sure, it is still a PASID. For completeness, might be called
> IOMMU_DEF_PASID_FOR_DMA_NO_PASID :)
>=20
> other suggestions?
>=20

that is even worse. Let's keep the original one and see whether others
have better suggestion.
