Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326FE539ADE
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jun 2022 03:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349009AbiFABnd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 21:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiFABnc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 21:43:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4950C72209;
        Tue, 31 May 2022 18:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654047811; x=1685583811;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vCkVqGmETQwWDNuccHHRsLXCWmXPmFhZ7EUpSzzh9u4=;
  b=idOFSkOOIWiCln6SWTUNi/BvscNnEs9Dhd5ycc+UHG2lTn/B4/JJGhOm
   C5qs8J7aK2nCB6LjHR8bGDWneGUJ0zYsRn5IcBRsyUCht+RhQp3gBqQVg
   paWnkmTNW/BMHThlYXOXTEGFH24LH6FV9M04aBiAzxgkZZCT9Ju/SG5DT
   dQ004BXL6Zd1Aav2BAnUHi/MZrJz7Ou8rFGd9kCWOpnJ36khX/Y3H25Nz
   D+zqC2rZ9pXtb1A1BAPkejmkiHXB5x+Sku5PcyBjNN77tWoUh9gelQsyT
   mIprrpJ61BvwPZz9Atjr0LTl/YUGstElXfuJ6zYuZikImWOVi3XS9UNpx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="336096324"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="336096324"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 18:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="823534260"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 31 May 2022 18:43:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 31 May 2022 18:43:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 31 May 2022 18:43:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 31 May 2022 18:43:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 31 May 2022 18:43:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNVFs9QbVP26f4Q1pjn1W8w5MbUpnYnAk6ANg9KPjRdVpMmGmbJ9n+tzDyQiZ3LpIn7YxPa0N5bvmnfPN7jRUR06hzho0q672zrkxJmzVRUKVqlyoGoyiVj7T3C3bp9yWE780qbl8QO0sAa0p9BS1mH6h35/ZHbh/CbxnBMNl4LJP3YzdoyoF9yCFErzgMPgoIEeMdOTUI3hWIlZVovZjH0i5g8/0hcmVXLtfAMLeC53Iy7Sie+xwxfn0CXflnj6EhSjipqDSn8gA7eetfyyAZ0546ovpZ7NQjx5w0KWb/qpFnOGm9Nn2NwNgvxExcsuiWDTWnEYMIFMRUtwB64zYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCkVqGmETQwWDNuccHHRsLXCWmXPmFhZ7EUpSzzh9u4=;
 b=c1SVxRPRbb/abr2Qho7lpgnv6yxlB/osEeUAhOJc1P/c7bhYpf0F1YO0JzfVMN/F38D85gXvKnam0kUY2iy6lp1+5IguGtvZ7l3aW43n6fIrUnqw0A3Z5s8ZHtnOcZgzjzvw3sPEZ9/pVb4vHAit38cHgVwafPtSi407qBx43uz57VNTOyH8/C4eVwBpeNwSaaHPHjTzjoX2LFaI0CRQHQQlHae7V+7zAs+251v9vPlZjVwnd+1DZP1Nuw2PqnbuAd5fPoLTLam4ohaTdXTeHltEGoNRVWqowHW9pPR3ChAcEWqTf6x+8jMSAc9w8a70mvmIu+wSRKKLZbhXTt24UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6090.namprd11.prod.outlook.com (2603:10b6:930:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 01:43:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 01:43:26 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
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
Thread-Index: AQHYauOU3vbab87feU2/ab0rn4lTF60uFLMAgAAYR4CACT0vgIABWQJggAA/qgCAAE95gIAAiHYg
Date:   Wed, 1 Jun 2022 01:43:25 +0000
Message-ID: <BN9PR11MB5276A2B5E849C2153939934C8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
        <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
        <20220524135034.GU1343366@nvidia.com>   <20220524081727.19c2dd6d@jacob-builder>
        <20220530122247.GY1343366@nvidia.com>
        <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
 <20220531102955.6618b540@jacob-builder>
In-Reply-To: <20220531102955.6618b540@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 020ec7f0-f2a4-435f-fd7e-08da43701ee3
x-ms-traffictypediagnostic: CY5PR11MB6090:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY5PR11MB6090E87B7AB052E315EE0AAE8CDF9@CY5PR11MB6090.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +oob4fPCKFl/AUqwyn7fCt/YBfA32phmpOgasPN6E9f4By1Y9jjH2yZgQ+kMFtjZOzKKwrSYyU7xYtkNzRZkcA10BVZiZDX4oX6yO5b3ba9hgmyTMhtpydCDdiIFq010jiICgqSR7vgQd/VtyhKouH0Mb5kwJWqlPDnbPURFw6A5+gvW6ZLb4y5cVpNqyH4aJlFAyqophscDnyqDMmiU17MXJwbM7bMeldjdUEo09AsEPmtxk0nItjCnI0DMrlmtZu1vCVUOdmomTkzPsSUcKv/129p5YWaz/YhUEbt2WM8GwRRMsdnvjxv2TX+Ea2Nu/eEO1w/ydQ0qXA4du5oe3cFhHr3gaOKLt08rQY1k98hhfA35Xvwr4hRafnt4uQvC448FiVppjDpAdd2RZnfLmyQaRXyUEDUqwcMiU5L3hJGgFkSCfYl0ZkpDb/Ra1t4eS5XaslG25DMA8n75wVdS8y/U/Z8xPdwM970HmemGXi9nf5hTnku6qRyQD3oeQQfApdm7PY2uBFcwlEkm8qPnA4P9MS6fJgSpaDaL0rumVrZKpFd6Rt4MyeYdtz4r1lYDuF5IlXr5lbKGRDBsmWrFacBd0Q653WFLpt3ygVG6yLUbKyJGKrihimrInqzFMpdMUkDxrT/4a4lKwbo+B5MX5N8B0DZSxlZFgmHEn8UHo+W6aSaxPVe0tJ6aiS4w59fIL1uFP6a9Pf/lGnTe+Q/4Ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(8936002)(54906003)(55016003)(7416002)(508600001)(122000001)(33656002)(52536014)(5660300002)(71200400001)(9686003)(186003)(38070700005)(2906002)(26005)(7696005)(86362001)(6506007)(4326008)(66476007)(8676002)(66556008)(66446008)(64756008)(66946007)(76116006)(38100700002)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wp7LRMqDEvlYMFMR/hnEPf2CzSanQuh1uDTRtnzI1wEx78aup1Pgi0LnMyEg?=
 =?us-ascii?Q?mdUXnBjS9Ha65TTus2bxAjF5s5nI9xygL96lo4zzMEFKBT5o3ddu6mYbIeQm?=
 =?us-ascii?Q?HTFVI/EOMliXb/BaY4Z1/KJ9WDohHHw40ctrvxXB/GXlgCPEhzf7ceRRHGA4?=
 =?us-ascii?Q?HrCByKC9teERWtCd7j8DykbUfxm/1AQ+losVK33uMqLse+zxWlKmGJPK90zt?=
 =?us-ascii?Q?LmW+l2M75+kbecYXtebeRDAXbeQLdZYdLB4takOlf+gJeLsqm/RrZ6sRRi72?=
 =?us-ascii?Q?6z4AAHNL3ZbKEZiKBbP6ZXfB4dQgnpJ69n7+G47tdrDrqqPGbFa7qgsUoFLo?=
 =?us-ascii?Q?oUUTncDKgOgUrSFfmjPEhdSkYdRIk5Fzl4TXDoZkoi2+Cobd/DucTyjI9C+E?=
 =?us-ascii?Q?Mprh4knyLnxPFZywIvElLfAkRALyfVJD1Bce7Ukn4MoKpV4JM07OBtJCBZ8U?=
 =?us-ascii?Q?b0r/gEzwSC6CbMuVU9mU5CFVLyUq1A4ML6aPwofsW9tQWJDujHn4hz3KPndb?=
 =?us-ascii?Q?G1vu072DpZElsDsVcNWN+05bU5IdsexPk8dWq/rWHGIx0ZO97BOCDGpBSa9Z?=
 =?us-ascii?Q?uVAtLHydZGgmB8AGPSeD6I8gZCWidZJqsWXVXkDjuLlTaMfKGpatp+NNuwof?=
 =?us-ascii?Q?2hSnncMUaJfH1pzmz4TJAz0/h5uC1QrDmz2d9ZKPVqSoIBQPOWgbn/ZWxzwr?=
 =?us-ascii?Q?b0R1SEXVK1DyFCzZNEPqUnpOeuZHFWDTuact3pEkTuvWnYKgI7PfbG/sFqNH?=
 =?us-ascii?Q?Gjt+6Hr4K56/2EPe4LgBK2LEuhM0xdI38/zPjIEubADvF0CExM54Amr2e5rr?=
 =?us-ascii?Q?g3d6+HO09ZTqDdDjDC6H70fR9LU6IlTdbKuv2Q8b6G6YfgBDQxkmq4/NBdGP?=
 =?us-ascii?Q?ObcTSyJrpngAHtQFhAW3xy6lahf2lfTEe/GgXa/zt+L3xQA8YejH59iZPueY?=
 =?us-ascii?Q?CmMV0VfWGJ3InyVubohpvo2mgju17qnZYmnAzm+WEu8dp8xBFRetovavvl8r?=
 =?us-ascii?Q?Pwy8QuVLG1Pps2KZfmaGA19RgAVF38fE7bMll28um3esFkzokz0GlKZc3oXy?=
 =?us-ascii?Q?XCF2o1vpi7k8NE+nPsJ3k4QWvQDDtbFTmAm6JM6G3hjGgDo2d1cu7/GaPBZf?=
 =?us-ascii?Q?fLJbSOVA1+0LGLv97Qh+qi38855u4OvVhp2BPaPlWsihAQaOg+g0wvUzJc5I?=
 =?us-ascii?Q?8mB3qkvognV7NWwvMyVRVPDVQqBFkvGLTzTNAKDMsO9ZCIEx3DhMwv6zXGGs?=
 =?us-ascii?Q?+39HJi5O4b80vaNMngZV89jIDjbD62ljAJ5zK2jWzVGQ3GbANqvYhwyLkSq0?=
 =?us-ascii?Q?y7ZNbh2XQhC7quqKJpZypeVdBx4Bk/+4DutZAJLObIRASFP27BsSCjk1nkuq?=
 =?us-ascii?Q?HuPMBvAtfPfIdKqw1FwNjExd83kqRNXOPkp1915GAG+fgdZ3sK8xPDuxF+8/?=
 =?us-ascii?Q?R0DatXGJFjoZSu37ottDB8+evCTGgvKsiUvtT+O5PrCib+PrYOwisEL/LOgI?=
 =?us-ascii?Q?vt3/9a4oVU8VExkghBcQfdodjVIQGBbJBi1x8ttWED0O6DfmLDsJoLaCS0nF?=
 =?us-ascii?Q?vV6rFSSC1phbPu28e/RgNJNKQzzS0nvisKCGjUGbe9r4JVfFpkyyvTuzKOYS?=
 =?us-ascii?Q?9ALnuWFGia4ojoRauu5obTFiYOlDpOWToRfUyWwwBPXvrf5qzkcZY+wknwg3?=
 =?us-ascii?Q?TD/4xcC0FPi3FVUfSLjGwKvH4V2V8PDE5BjiGCEL8ykgcLcjWF+SDgmbbzJv?=
 =?us-ascii?Q?v9M195ewTw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020ec7f0-f2a4-435f-fd7e-08da43701ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 01:43:25.9690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfpJcU5sjycTtdXBmgn2ky4C+Fkk5Xd2FSmC3Y427XnnwQMuJUM2YL2zYhjew0pZfMGaiRRQxqj5sZoFkOCdTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Wednesday, June 1, 2022 1:30 AM
> > >
> > > In both cases the pasid is stored in the attach data instead of the
> > > domain.
> > >
> So during IOTLB flush for the domain, do we loop through the attach data?

Yes and it's required.

>=20
> > > DMA API pasid is no special from above except it needs to allow
> > > one device attached to the same domain twice (one with RID
> > > and the other with RID+PASID).
> > >
> > > for iommufd those operations are initiated by userspace via
> > > iommufd uAPI.
> >
> > My understanding is that device driver owns its PASID policy. If ENQCMD
> > is supported on the device, the PASIDs should be allocated through
> > ioasid_alloc(). Otherwise, the whole PASID pool is managed by the devic=
e
> > driver.
> >
> It seems the changes we want for this patchset are:
> 1. move ioasid_alloc() from the core to device (allocation scope will be
> based on whether ENQCMD is intended or not)

yes, and the driver can specify whether the allocation is system-wide
or per-device.

> 2. store pasid in the attach data
> 3. use the same iommufd api to attach/set pasid on its default domain

s/iommufd/iommu/
