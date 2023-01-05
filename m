Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AA665E33C
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jan 2023 04:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjAEDJH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Jan 2023 22:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjAEDJE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Jan 2023 22:09:04 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B1D11178
        for <dmaengine@vger.kernel.org>; Wed,  4 Jan 2023 19:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672888143; x=1704424143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a5WeDVsVrv4FUi6wsvzK1AiVFLBibVnfjfok4YAAvbg=;
  b=WdLejXqqTohm7Hu6AbTN+XwYp1RnPzRFghbyQ2IVFE2UvHKaOiRjuFyg
   csB6fPoy+pvA+IqwGqiSOtP/bvAYeB+I8JQ9X3zSdEmYTo3hPS8qDxUCf
   hrctMSpjmzcEHoacVR9o47WrF0FkccmBhO44qHjK/KK2QCNuV3cPzvvzz
   X9WpQfDPOxUYmqLVNXamE02Gc4TJODewnoD4hYUNrsVuMcnwfhnRXG9Al
   JQbS6gcEHNIEG9VJ8PkZYRjWhnEqf41TB63brSo7qviHdLaevKNV3m4rz
   FNdMg8mV34glGOvGKVYve/TRz+6/5csxhpp4YuYvfEFyCQ7KZUVVRq6RY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="309872856"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="309872856"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 19:09:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762930007"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="762930007"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2023 19:09:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 19:09:01 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 19:09:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 19:09:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 19:09:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS+PBdQIthg6eiKANvgCgOzy28+p7vOxdRAI+YpXUs4GhCKlBIURubkwodyl0JgHFqO8rsWgDUuBFvB2E2do32T9owgr6MWfc3fXloWfhRcJev7Y3sMReAUSzGnzsaaMKs6vsijZtXQiVvOTSx3rhw3HEsltbfqnyJswG0yym292SfoQfPZ85wmweoI3VQl6shV3Bs+aswsTUDCPziyeY0v+6nVievVsI+BK5kiRHSZjfTQloTtoYBtGksppu7AzWjYzDfzfwNAGT80qMnOc7HeKEBph7oQsNOVRC78N+GC3iN0RF4owN5LKbcTi+374KYGwOPEtMh3NYyHVEHPMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5WeDVsVrv4FUi6wsvzK1AiVFLBibVnfjfok4YAAvbg=;
 b=edcF/FZcbJlTZvBMALF1Qk4Aho717lK395upMhTtqIZxonXguOUzuF4mwfRgIw6vkzlGCBI39WuDgtzD9ImPhNUlHZL8E8QQiG8GFt7hzXLKBedmXyqO2bK5un2mPWUi1ailARn6/hVKiOftsTnUuVfQ4JLcKWktCR/gvXNe2NTITqT9pgGCxJlKc3al+xDR2Bma1ilhPVp+NT7lhIfdgGfEzZgvSdeUtLxy3COsn9UIaCqf/zt+n+5QLqmy6cEvEe3uj2/dwLKEY2fSvqDWKY2osRQY8VNBn9N4X3HSoDcJ2oczRetRYsBVRX8BSpb/AGi4ZpMAmgsocc0blgQ6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SJ1PR11MB6275.namprd11.prod.outlook.com (2603:10b6:a03:456::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:08:58 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 03:08:58 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Alistair Popple <apopple@nvidia.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH 09/17] mm: export access_remote_vm() symbol
Thread-Topic: [PATCH 09/17] mm: export access_remote_vm() symbol
Thread-Index: AQHZH5FkNhHM4hOH50a42EHT2Acr4K6M9zQAgAABTYCAAA0YkIAAGukAgACKFVCAAB1UgIAA5j6AgABDLgCAADO9AA==
Date:   Thu, 5 Jan 2023 03:08:58 +0000
Message-ID: <IA1PR11MB6097336ED90E27E78E069E299BFA9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com> <Y7RpuqbTAM11wVQG@lucifer>
 <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y7SMYF8MlzeqDgp+@lucifer>
 <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <87tu16rdea.fsf@nvidia.com> <Y7XZ8zY3KIRDlu/f@lucifer>
 <87k021vnmw.fsf@nvidia.com>
In-Reply-To: <87k021vnmw.fsf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|SJ1PR11MB6275:EE_
x-ms-office365-filtering-correlation-id: 462b3929-a1ee-4c8a-88d2-08daeeca3001
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOBFsuL+pdWLtPSm6alDTVu2AQsiVh+9q+w/u7D6bH7Q0uHBd+4KirfFF6pxwQbA32r5f0Zx8ALdD+NbGoPMAjAVBwgWF+BA/A3JVVmH7PCm/raIYXJOdb3cRatGRJLyddRl+eWsgJ3P0+MWXKR6xtUoeH87nJmwDiyfOUCq7/ePJrr0beCqNr40rE5yBUVnN+nHiizbd7BPidzFzJ0T9649ujiBi7DbOBpve+GE5kQVfgmIdXdPVFvLJmK9ISYSBE0uXn2lu7bIRE4BkT7BKjKTcahv3Z+0T3yZ1aP/grLehcQi2xvgyZKlRcoWCkg/+b+hRq1QRxZS8d1h1VNF2Qlzp7lfEG/hphYJTVEtmwYRVC0iVqDu8d/3AndRTmunDMnFyyiEq3hHT8wMvxbPC6mpfYULWTlFLirRgpOJS8Pu5cxfLbGkcDFI6rxjTSaqgOLhmiYbmu5Mz2A4UOtL9cYuwWzQDD31CFyeSaR6pCGX9S7x/Bvvcv+QsvTHhUerUEVmpwQx+agUQlKYFpR6Ao4MX77TfKXhX5ea0R4LYBmN9JVHSWqFbopZ3cVakiRe/lvRgMlyUc/s9jpSrQoxvU3LLoWbL/TTXLVScdW1eDwjitTOllos3V+J5ZnTUcm/MK69IOSVigUJTQlMkaAn3P0STZO1GY4C81kd4yv733wJdw2TyW7oO2TGzXeGD8biIVkdC5tY1C9aWcPDpPUW9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(66556008)(66476007)(64756008)(66446008)(55016003)(66946007)(8676002)(76116006)(316002)(38070700005)(110136005)(54906003)(8936002)(52536014)(83380400001)(33656002)(4744005)(122000001)(5660300002)(4326008)(82960400001)(2906002)(38100700002)(6506007)(41300700001)(7696005)(26005)(9686003)(186003)(71200400001)(478600001)(66899015)(107886003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MpBa4GOdwXRUUdqainrB2ES7qsBx0tHgeG4GLOCDdeEp47Ph8s/JRwnE7MRL?=
 =?us-ascii?Q?lunVGqdRzDsPhfbzhoLK8HFB1shl5JKQtsG0nEyPuhs4prC0IgpPhzsIkRjN?=
 =?us-ascii?Q?Py3bQzZJ00Rhew1yrgOYTsxdfjiVDjfMhaH+txZVSmxrnO6qO6p7i4Nf8voI?=
 =?us-ascii?Q?9Y4frRHuw4Cf0p9Hl6wgV4/pYIDAEvJx6fFVUV7VJJbkSdxEQoPCMBKMrrwz?=
 =?us-ascii?Q?RBzMv1JxI4J0iR2M3F8n4foLf82ArCzJg4zhkQr3H7HaDUK17dtL6YiQp7X2?=
 =?us-ascii?Q?Qc3TRxQyT2PLKkuruyudObhKhvTW5dZTxcVfeMQLv/WCx49jWx3bWvutIobc?=
 =?us-ascii?Q?hV2YUoPaxy5tSLvPBGCCPu1krudemwvA+YV+K3isNmK+pEOaJoZ2d7gVKcQE?=
 =?us-ascii?Q?xfzKy+T3WEgaAgRl3+JQsUdF+dPSPccddec/pE8C9fPsB2qBabxn6xTsgArO?=
 =?us-ascii?Q?2ct6ycxRqAcOSMHS6QOogI/KPdwUCH2dcIDtNSbD0yd56DW/LRHqg1zQcLlb?=
 =?us-ascii?Q?yf9aFu1fBMvxH9Mse0B4yeon5SR3cvBAi9dgwYTAaWNCTTXu66IvE/obi0bE?=
 =?us-ascii?Q?MMxJz+j6XTuN9SxRDgv3O4p/iw84jyhWvzaiW9/zL42HQgGQEVpBFtvMkO2/?=
 =?us-ascii?Q?fk0chbLeOMhI7AibLFoi7400gcQTw42qSlWmpgGakOz+mXOkxBf+o8AZnZSl?=
 =?us-ascii?Q?QNxWkxc2rDtOOdspt11Z28hgMFpoVuMBYadmFZmz1KPK4+2Z6TUZRrRbnpsv?=
 =?us-ascii?Q?IR8QYgh+61kJwhSqWsXEqt6okCGOeCI/riorPy43XnGranP/93x7sTHCUVyO?=
 =?us-ascii?Q?j8eEYIlTRVT2o/QBTf54aVRFCWw0C6RyHfvd3DaXoGzCSmChN+JGQv1lX8g1?=
 =?us-ascii?Q?O+u4pPpxlp/rhjevS2djWGUQDPRt+SVezD2cGTrbjX4YoraaeBXVkrztt2mY?=
 =?us-ascii?Q?62f3oQLVVCXD3Mlj4Eml+0Eg5y9yAxuP9dt1BqnfNhWbxR5JNlV/1bECoQUt?=
 =?us-ascii?Q?t7wHc5/aPnH7mBTyAXzFXzKbsdC2zTO82AkNdQ7IoxNDuyDornz1tMa4uBNk?=
 =?us-ascii?Q?tXPkw5RkMIWaVGB3ycgyDxkKzytlWJfjnphLrOz3btfBXqAq9HunMGJELMLA?=
 =?us-ascii?Q?cqplJ4yKDWwfryejPInOuk2rUdXWstuNVaFtvkfmOa5YfoojxzW6CNubW84y?=
 =?us-ascii?Q?mAagM2LfjzeP6ml3/3G6Uz6If4bNJe/9bfkRcWK80i1kSxLYuUrXuXCBZeNC?=
 =?us-ascii?Q?PvQcq+Ug26PCY/O4QzWf0TS+qr+r8vyYLqh7QC2FiTWvVXudofTcit2D+DtJ?=
 =?us-ascii?Q?hRvc0RlzoY/AuCePXicy13vZLvHujWRTrNlZmuzrt807LzeV6Aq6nxXHFOPA?=
 =?us-ascii?Q?aaOfODZpwDEviNOut7VsPs849Qk1msl/aPtJknBSqaQllKv8AY2ukUwFTeSN?=
 =?us-ascii?Q?R1GTI648nAAPzsiE0uFbdoRadD+B2RCSQmmuECP3Pd6wPamcU4c2dkn3R+RK?=
 =?us-ascii?Q?80LgoNRsRaMmOqOTg/YM/TFNaMpauQxM2U3X080Lb0R6WobMMPdVFJphtdyj?=
 =?us-ascii?Q?6W18OfPLZUv1DWo3j2Q1MMweTChsqRi9/2s11rie?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462b3929-a1ee-4c8a-88d2-08daeeca3001
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 03:08:58.2089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8U5F2GMzOpRGijpPOVxQb/he2deIBSa5hGywUmUNkdNufpkenO+I/kl1p+MD0UZ/GMJqqwjDCetjNhTE958vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6275
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Alistair,

> Alistair Popple <apopple@nvidia.com> writes:
> Lorenzo Stoakes <lstoakes@gmail.com> writes:
> > My concern is exposing something highly delicate _which accesses
> > remote mas a public API with implicit assumptions whose one and only
> > (core kernel) user treats with enormous caution. Even if this iommu
> > code were to use it correctly, we'd end up with an interface which coul=
d be
> subject to real risks which other drivers may misuse.
>=20
> Ok, although I think making this an iommu specific wrapper taking a PASID
> rather than mm_struct would make the API more specific and less likely to=
 be
> misused as the mm_count/users lifetime issues could be dealt with inside =
the
> core IOMMU code.

The iommu specific wrapper still needs to call access_remote_vm() which is
in generic mm. We cannot avoid to export access_remote_vm(), right?
Are you saying the iommu specific wrapper doesn't need to the mm code?
=20
Thanks.

-Fenghua
