Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00652530CE8
	for <lists+dmaengine@lfdr.de>; Mon, 23 May 2022 12:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiEWJON (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 05:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiEWJOI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 05:14:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF994704F;
        Mon, 23 May 2022 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653297247; x=1684833247;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6ectUPs/2KUPL3GU1cryzVUI5NNdvc4VaQdRQMN6GEU=;
  b=BTEoG7uR/AZk4O1sQHK0Tm6p2OZ28OntYH2TMfhV8g5WO1YtF1Db/GJm
   ecbLKO7YkybluBdOPkBRjsx1fMC0AcLLB2JmKWJxus6lrE9HAaQdiLYe2
   VjI4p0wOe4fWZYhbkysTm+eRGaX5A012yljftDQMS+CtTI1DrQRvvjXfr
   c4tQnjkHbDaXtzWeJMNpPbRJv/CqJ73EQTj4cvE5DxtYlU8wDLHT60ixp
   fvfKwAfqPkjg9zP14r7fEn+72J8YImn+tSrZetn0vhHvP8d0cmZfD40Mw
   eUBhSpTNva7DMMG/bSxAoWWsw2z/cRYFhhM6WkehRW58sBwL+0qbPdfEW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="333801693"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="333801693"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 02:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="608104730"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 23 May 2022 02:14:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 23 May 2022 02:14:06 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 23 May 2022 02:14:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 23 May 2022 02:14:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 23 May 2022 02:14:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUqqQu5qYjvrXITyKjLp95YH9ocnlKcZT8Ax4comf7GudE5bNR7po+8IRjgaLtFB1ES7BT4nMcubEujGxoXn6xTtgUmUToXqyG6vR8TEuFPiP5JRupsSpEt1PcJyhhHrPZkdE/6MRT2VKozuRNHbPAVd5eXoZ8IJ090cnu3Bmbe8C+GiD5R0H2ZfgN2KwjvnVyVE8M3MHIt1InntSOUSArHAcJOMdnWys8zxGfousZK8c/zbW2yh3PDnhtrUF5M2vbXwLlyOTed6ovLlQ0Dws0evsj2+nA6DR/OeOD95vQ+8sD+qK6jM/9EEQYUXva7kyW3sAK+3bmJV26iv3y95Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcBagNmHcCTAjBzjwOzdzvpgZEkJF+uVWKe1f16MYac=;
 b=k84nXSp8/SYe/LFBHNT4hc3yL8cjKKnoTFXGhi6Wzm6x2uKV1dZ7Y6qnnJNiylmYQs0nBsQoe91VaaDmRhzErsE+FMiEe2ck7/zxRPRlkHI7uO5ipvZ8tyh4k3xPzfOxfIvcJZ/i7jb1GPrcDbo+nom/zjSvjYJrdgcXEqXtJFy9/BKVQ2G7gj0SCtivsHUbWi6dAimiyRJ0YZfb7MJeD4Lz8TosOJ4M9/1Uc0GsrEX7D+7e/g0bb0nLeU/j+qoB0zHd81FJic3V4B2oc86pLuEGS34ehSMfErG0cF1m3INHzSbbVYirsjHuFQADjKZUmCvIcimYXDepzNlWk8HtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB5899.namprd11.prod.outlook.com (2603:10b6:806:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Mon, 23 May
 2022 09:14:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 09:14:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from domain
Thread-Topic: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from
 domain
Thread-Index: AQHYauORUoINsxb/TUyuLPLPKASxAK0sHSGAgAAOQbA=
Date:   Mon, 23 May 2022 09:14:04 +0000
Message-ID: <BN9PR11MB5276622272BCA2ED982EE3C18CD49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3e082e9-c241-4604-8b42-08da3c9c9543
x-ms-traffictypediagnostic: SA1PR11MB5899:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA1PR11MB58991D2E27378A9A8264A8E08CD49@SA1PR11MB5899.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GmxR0gzeevLXgAvf7JZ56P9XybODXJZRPENHwBrtvFC6ELnmttX5K+pdWYxbUtGVHYXp2T3FZeaNSSFFqfc2+fK/Wwwsz0lcwZfjFGxQsPAOHH5IaymwUwFF0cdnhf+kHVyXM2lGpmyN137qc/gCUTC5K+JqE3QNdWE7ydvE+b+BbwCT1dBP6KC2TPOiXD66wwJ55SPRIHA4rKba5gvwtSx1L2yZlix9itw616aLCQO2P+GN1GjVBdrJe+NCD88yADHRdll6cmNq0pm+mnh960FcZrsTbpUFoQ5kQfXaqyijDyoTwsfohOc41OLmkfXLD/WspJXHfLi6kZNkVbkjOJZbJ+5lqYEWs0ouqbmnDsEz97N/2STHzKXKhcU4nJcEbiS2Emps3QDJbAlDXLbe1ulxFR/ZbMTdbjMWRv9F59dpydjkCtz9Gyv4y5fzZPO+q4RxizPNI6pDlRM/njuDSwJrYTyCV/YJkjhRCJvrQ1uvbkQb4ouPA0sRIKcus4enz6T9JVvHxRhQwFsvm7ZvEKyyvNNvoKnBMbiftAMTIzJ29e6B4+UeNYxmBy1Idm1iNIERoUrKada9Z9wyjtdKOjqRr3FJ+lM4hqA2wNKGz+YN1NgukHeUqB7MLSfKIAH8poTeqoSou0aO27fWJy6BG02NSW0rF3ayAXl/wZfdKBJ77ENDZjmeIvdZSJn3YAYI+74q+1vBnOcfpLmBUwpbTPbaLzO+8uv5EMTQRQStJZI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(26005)(110136005)(9686003)(122000001)(921005)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(82960400001)(33656002)(7696005)(316002)(4326008)(8676002)(86362001)(6506007)(508600001)(54906003)(2906002)(38100700002)(55016003)(5660300002)(7416002)(186003)(52536014)(38070700005)(8936002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+8BB7FBuyskFwmmZEEf4RZfDXAgtn5iyyTa/6lXc9bHQ11Runn8DX+8XQF5z?=
 =?us-ascii?Q?y5SmewRIpA0xVuqVIJVkt5vs2oaCV3m9eT3T0Lq/sy052OoJn6H2wJga8gQa?=
 =?us-ascii?Q?AssqFEpcqJ5VhgVfRRmgaC0oDAaTaEmYNnujKi6p3S7hRmbdZTpaemSQHYJt?=
 =?us-ascii?Q?SqM4hjRykrRr5RsJd7ZJK2Ha4RqYpsMgh9QrzmPnoC1Q5vSB+zzjRKPFUN3D?=
 =?us-ascii?Q?KAC01rwN8ovJa5W18eOO6QWJREYHVg2PBirVybhcvKopcmsA+FM9lAYcuuI/?=
 =?us-ascii?Q?a9ge6JkYjoZwFd0hVG7pmsH+q6wD3m2VH9WGeM+Jtps5mYTHiN2PdT3waT3G?=
 =?us-ascii?Q?sh2kVnYPTFQzHAmcFsjE20kUWX++zJkzuKFqCSE3sozpmr0mRVfJdiFuTJ01?=
 =?us-ascii?Q?oV6Qn0EO0oTAaJkwiPUXdpunPExH+1DKX1ddpO3LS9BktenuiXg2uuYR2a7k?=
 =?us-ascii?Q?ba+repbvKNWQhaqUxbhp+PrJOYdRONVCtVD7LT1SBJkWjcVFdw/nUDIqkP4E?=
 =?us-ascii?Q?4ACYC+gd1nXwXcheWR2r+Vr9ZxfmG850Xa50ENb3LY4kjEVtaHohiRtXlK7M?=
 =?us-ascii?Q?j758sk02fduE965Qr+fUiEc6xVSWXE99ge/VMYVZM9DDRULQxgFiPNw6tdb/?=
 =?us-ascii?Q?Fkl4MKIi2QbHdNxAvba9z7dyEMWkXYIR0/hd2NuojlsUO72I74psQqxwyACD?=
 =?us-ascii?Q?q4UHhC6mIfxi6LqZlwfejChLcilU8evpNeLm17q4MbJspfluWKukF2L1m3gf?=
 =?us-ascii?Q?mN5j5Rv0jxYGFlT8YsRxH2+QWqgptIs/7pICgYM4uFBjC/iAkZLL1fCEz9g4?=
 =?us-ascii?Q?Lk3xtb2KaZVTYbzX27JWGRDx2WfzxuzsbmXfPFAFLBYDWfqsiwoWj2X7PRXa?=
 =?us-ascii?Q?iwG9St6A5I1KFzHZ20sBbXflF2zgTDDl0zQpdP0b9QLqE8QeT4ETTVdGVVVL?=
 =?us-ascii?Q?AFKmuw+MbNGmD8AX57N7sp2kjqMBBnyk7WTnMB6yD/XujnofhDYeRbxPgW57?=
 =?us-ascii?Q?akMn1e+Pp0vj+GnOok09woT5/+4GDILe1wrF2snfEce5OhN/9g3Eug8mQ7yy?=
 =?us-ascii?Q?TU99CzsHImgHC9eLKkgLP7EAtKWonXU2B9LKqmujCaWHSDsLGhq9fy0slZdB?=
 =?us-ascii?Q?hVd4JPRA6HQB+VA0y1bcayLglpk5db999dLWuLv/NqFQrr4LGjL5V33DHTRI?=
 =?us-ascii?Q?HcfzbFJR74By1uVCPiVgnHGKpdDcdyKkSAu6LFGq2DyAFPaiJsULo9OKH6eD?=
 =?us-ascii?Q?DG+jtN9/rCDc3b3z27IuuJXUXoFbpFH3kAg/+fmO8h4TkuwLgCaFc0/RUl7Z?=
 =?us-ascii?Q?lCnykxZxhT3M11T1+cOtuEHMCL+HjJeprQSkqg4o1vU0MVqanv2bvqTtI9Hi?=
 =?us-ascii?Q?SXk0kfhcRsK5w0IATwhcCJeQ7Dm5QLNRtmWvtevkqbxpbSyVLn3izO0ot0Oa?=
 =?us-ascii?Q?OprU0p3Sjc7sCj74bYmVmMPED4nYhwliL8lGI/wVwFCS8J3glgXhQixjytFs?=
 =?us-ascii?Q?K0I/txdPIf111duI5iQs+xm+wOqL67hVi0O2uDbHKE6gfwBFtarURa7daeYX?=
 =?us-ascii?Q?cKxWMB5lJOu2sc+yTYGOuHrahTa9vPPXDzy4/ZWF2hmsmaTCeZGa056vdac4?=
 =?us-ascii?Q?SIOmmFNwjyuGwNd0ZPOMiqOFAsnMvqUxsrvniLHLdIMIm571Uk05BaywR+yQ?=
 =?us-ascii?Q?jP0sVe+uF1eerH4dqLr7K2XMSUJgJyu+p/e5KxKfBZtcpyOYLm4EPszQ5zQy?=
 =?us-ascii?Q?UkStzCKH3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e082e9-c241-4604-8b42-08da3c9c9543
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 09:14:04.2674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmNuLHEkqZ+0PXfCx5EOXjqRF+hcBrJQ3PN1mQRzrD3jucMF4xM5jYTsGZXWAa/0ALEsc4iXrMsyXlCyAF6zxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5899
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Tian, Kevin
> Sent: Monday, May 23, 2022 3:55 PM
>=20
> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct
> > iommu_domain *domain)
> > +{
> > +	struct iommu_domain *tdomain;
> > +	struct iommu_group *group;
> > +	unsigned long index;
> > +	ioasid_t pasid =3D INVALID_IOASID;
> > +
> > +	group =3D iommu_group_get(dev);
> > +	if (!group)
> > +		return pasid;
> > +
> > +	xa_for_each(&group->pasid_array, index, tdomain) {
> > +		if (domain =3D=3D tdomain) {
> > +			pasid =3D index;
> > +			break;
> > +		}
> > +	}
>=20
> Don't we need to acquire the group lock here?
>=20
> Btw the intention of this function is a bit confusing. Patch01 already
> stores the pasid under domain hence it's redundant to get it
> indirectly from xarray index. You could simply introduce a flag bit
> (e.g. dma_pasid_enabled) in device_domain_info and then directly
> use domain->dma_pasid once the flag is true.
>=20

Just saw your discussion with Jason about v3. While it makes sense
to not specialize DMA domain in iommu driver, the use of this function
should only be that when the call chain doesn't pass down a pasid
value e.g. when doing cache invalidation for domain map/unmap. If
the upper interface already carries a pasid e.g. in detach_dev_pasid()
iommu driver can simply verify that the corresponding pasid xarray=20
entry points to the specified domain instead of using this function to
loop xarray and then verify the returned pasid (as done in patch03/04).

Thanks
Kevin
