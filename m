Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A69539AF5
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jun 2022 03:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiFABuo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 21:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiFABun (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 21:50:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E22D87204;
        Tue, 31 May 2022 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654048242; x=1685584242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+St/H0vKOBvOa4Ja1r8WJEtgAhk8M1VZibX2bBfCOcA=;
  b=fPb3g150tfAM4EFQn2nhfJdIHzRsoCWQLATH9u4kxQn4ZVkpUisyy5kY
   6VkYlnhD6Un0qygUSWhVAJZGacKja9VYtbFlfaWx0xwy4vVgkGWjiyLRE
   w22puHBZP7yTk96eHbrjPzPDFOR15Em0r7RftRJzjka+r7e5UEyLkisT4
   rLgt9iLghxps8u1PbJr1og3W97XEB7AT7xHFu9UO9MoihvuiBaQVdrPK4
   XRgWw5es6BRHku4PE7gK9v7B+3RSDy9kFSlPRS4PomI1Aj1kI7d6BnciE
   TxjQ5KBkQPUOFzYqdgA4H6nPuXANH2MMzI5JLa9KYIavt1kTiXw3pnUSE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="300790861"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="300790861"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 18:50:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="706842608"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 31 May 2022 18:50:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 31 May 2022 18:50:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 31 May 2022 18:50:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 31 May 2022 18:50:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 31 May 2022 18:50:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX1xGSdcN+eBTrg7T14rw5rSMtayzvIehO4xMH4yTG8xoH85gOiTXwZOnXIKCruggX2UIjVdWlqiwqiA80zB7u2N2F48oyl3qjHeJ4Zlmh+3eq/Ag+H6V+W/SwEBkjgsqJf0mgmF2XRdxwVwfM1uYcgLoVPdjQLFe8w9P8D4KE1MRtsepvJBOEdZHRF2Z7APoeoHccY3NDNYVvfUFcLviZYkK5tWykPu9RntfZJOgR2vkQOPGah4QRK2tHDrovdlkyK+BRFYBrHUdnd95fVxogOkJ2rkfOVZ98XYdjuzcqlyfpSkWL6HAjKqLo6r3/ts/js37CsEwhOKuFU718bmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+St/H0vKOBvOa4Ja1r8WJEtgAhk8M1VZibX2bBfCOcA=;
 b=EAsG25EBQoHqBOD3sAwhpGpQU7mIKKq858T7bU/n5xNDSJ3hPkVx7JyPfNKOHQo8ASdEQ9pL45/pLD70z/miInQMPoPtuzsIk4rLQcvJi6bOQl2fyOKD8T/+E9tUCcphkbiexNNenkeFlx+ujnPNkNyhX18pGfOa3EVTxeO2AklWsR1XMFHoc3DIAucBgs9Y2oFnQSAY3KSJcDnjUILkRkNKCYCzxA+cqpduShK+ax+xHIfuUXqxUQKUqNyTh0NKXvVQZHHjUF38NNTOKVeJSOTK24qq4piyWVSxkgyZxiiPd0uFEuqyEV3mpSQ8v4/P4YXzYWvFCkdctxuewuR2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL0PR11MB3508.namprd11.prod.outlook.com (2603:10b6:208:73::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 01:50:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 01:50:33 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
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
Thread-Index: AQHYauOU3vbab87feU2/ab0rn4lTF60uFLMAgAAYR4CACT0vgIABWQJggAA/qgCAAE95gIAAGs0AgAAbfgCAAFOycA==
Date:   Wed, 1 Jun 2022 01:50:33 +0000
Message-ID: <BN9PR11MB5276D8B0B6D51EA32A9CA50B8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
        <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
        <20220524135034.GU1343366@nvidia.com>   <20220524081727.19c2dd6d@jacob-builder>
        <20220530122247.GY1343366@nvidia.com>
        <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
        <20220531102955.6618b540@jacob-builder> <20220531190550.GK1343366@nvidia.com>
 <20220531134414.37a62c88@jacob-builder>
In-Reply-To: <20220531134414.37a62c88@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32d04dad-0024-4984-8853-08da43711db4
x-ms-traffictypediagnostic: BL0PR11MB3508:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BL0PR11MB3508AF6CB5056DEA36B550298CDF9@BL0PR11MB3508.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z8SGAkKQdSlQ2IdzHFhVdkyiobWlaP0VXLr2Gn+kiQPtUt4Aj+LmdUHFT/eOJAY1YjzT52/1S9/7nlOUtIiiVIpIh1CvlOEBHiGnxMc5895D02FJ4uOp3A8DY2LRYfBP8vvKP5ZabgXrOB+p+PQpxG8xTwtZpvnzhj/7Ei9hNQTFExK5T6B/GoiA74UvkaXLz1slxUN53jquPRETHa10Esvwi9tSlSRL/m517fSb9UibNprd+4DC0Lm4o9xUv5NuryhHRQFbxyuJR79MnXxJN1KuKKmcbbEPFvQgDU4xOEPf91JtnDEqMCbQ4NrBfIbIHsvk7CoFsYvbJ3E9Al6rzLAN15iSzvclsUvDhLUy2xFprpiiRQvRBArajr08+LJIk0z+mvB5p4yNYce7Ak3VgViwraFdfZeNHW6ZrfQSFkDrbX7NfNajwTcaYTK/L4AR5Mg9/kqyRSrFrZSnfgyu/mUgP/LaW7DykM2AOeOOvJSgEyybkVZiqu/BQJYcxXd2FF5PDRg0+QzkYFtXSJjDlf/2Ew++DPxtyFb0717GZgmFZ5xn3YQCvSc50mPOzHtGgBSspuQMWhtU1tcmS//7W/9aJiOtfYuHvIoNA0dIRnqoJZqhOED86sy5DlIQ0PZJt8BD9iJAvEycN//vRc46s39QO0TRUceoL87YoUff6CUVOeVQZXEBtlOhDormEZ8Jb63mIcaEFouqJwAukTEx4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(7416002)(5660300002)(2906002)(38100700002)(186003)(8936002)(122000001)(316002)(9686003)(38070700005)(7696005)(6506007)(26005)(71200400001)(54906003)(4326008)(64756008)(76116006)(8676002)(66946007)(66446008)(66476007)(110136005)(66556008)(55016003)(33656002)(86362001)(508600001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I/fRtgXzBe2RAtN1vxwZUmZnXcK/+8Vnw4oaA30fPvHxEcyBJqiAfeaEVbuk?=
 =?us-ascii?Q?jeJL9IS0a2Nvu2JRNWA+EA6zW5+3qFZyctnXSIvvFw/iVq/6z9GzV47Dc3pL?=
 =?us-ascii?Q?nt3AcuJLty1ZZTTwwtTYvYqsN3w0Vo80vPSi8zsdpIiDRBKYSTkz30vVzCUO?=
 =?us-ascii?Q?3C/PH1bF+D4Hk2alF04U5F3iiacbXAMU6TW1yLAcNuMtpiSnjG4Nd8nZ3SO4?=
 =?us-ascii?Q?8kl92C+mUOe+PnQmtfkA+OnS1T5mveUjmFRYdr9xi8H9CLIhSE1pLpxmxcQ1?=
 =?us-ascii?Q?9t3p4pyGShrQLwD08ZOlw0rvhiIDQ9Oj96DxwOCJu7kUSsP8OGRMvBXGvIql?=
 =?us-ascii?Q?MQWuT0HjOgbxoYOMBzKu++bO/G7A1gkmKrnbYJbh+FIIGIGOo3/Fs93JDMEB?=
 =?us-ascii?Q?1HjljSXcWikKY/eDzR/oioSRTKC1N81r81ndUZNtdsi7ZFkrRfOFxxgHq7/B?=
 =?us-ascii?Q?wcHOIGjTUDLW5qX89H+x7qrIrLLYicsxoJsglZCydAjTThrxWxVGMSKHNyts?=
 =?us-ascii?Q?pLhJjm1I7m0oMZDoLEbZXzYSp/MwMruph3boZ72RhQXxoBliuWAbsw/Kcfnh?=
 =?us-ascii?Q?gNuKORcRabZc9CNsuNvrEpOu4FWvaD+krhZEP8GZ4DkcMWZzTXxUyJzKkGfq?=
 =?us-ascii?Q?2jotDWxbQ/jrWYxgyeyQRiGAeecwVj3qMKD8qmOik34q3MjOxKPepETxksKX?=
 =?us-ascii?Q?WEKA9X93GNodqmsVnZslg5lmLxaFCGC9aQfnpjXCUT88KaurhME1eHF7jUzE?=
 =?us-ascii?Q?3nBqzTHmuNFKPCzx2GWT6PrpklJNWoDTj6us0+5ElUXu53E/IrKAz+yiyL2o?=
 =?us-ascii?Q?tA81dayHcqXWYTdr5XWcU/vvNXf041vvhRD0xLoJa4lg3TT38P85tmDAcBc8?=
 =?us-ascii?Q?uvOq5khcyIE/5ruSu3W2Tb9bpFAvu2lhLzGoPGeS4mA8pNHPQN5W5sRWlk4G?=
 =?us-ascii?Q?OKNUBOweemOpEx8EcUsKknQ/0HlIATw8A+laMSICYJCYyXZkS4Qj9Eo6qE2o?=
 =?us-ascii?Q?ZGzptWiTjae/EaIxqcxCuM+hAHOSLor4FZX99GrKtzqY70ht7fd4IC53dV7F?=
 =?us-ascii?Q?y0yyj89MCPOXirAA7BqJGRMcr1/zQaXc/AAm4cDCsWp9fPXiyyi1MvKJTxnf?=
 =?us-ascii?Q?TgKCJFnyoDZqVPZMGgdv0e7PQ+04hDJL8e+6WCd3UGAEKjAHSoc+dcc7hV28?=
 =?us-ascii?Q?vga5qs8OvjP3fDg7zB6DDaoLzOwAnvGLJAU9fHJ1BfNgnefob+6jXGqBnw2a?=
 =?us-ascii?Q?JcfMjv22yB0eaZolu+MBxfspN5YoVB4daRrWF6gX3RXe0dpp+A/A5HjZs5GD?=
 =?us-ascii?Q?xvYb/VC070IJRJ8pjtcykCydyVCq0GwUrr0qqAEqNYcrVKCMUrxFJ3+VAAkJ?=
 =?us-ascii?Q?vdVBiMTRCMl4lgDXWxQkavqohMHgrUWyci6gGevp84J2B7OyvVo9TGu2aTjJ?=
 =?us-ascii?Q?GMMpu5WjBC9I5QKBGeJfmFi58DvJ+7yqRfhDwWmdLMij+l14znatr0ZhKOqn?=
 =?us-ascii?Q?1z14YvQRPC9NzPdf46I4mAVpjYDLZw4+u1eW0TOHgxHLvwYMei03n8LoFzyR?=
 =?us-ascii?Q?W/dzY+mQHPEauiikIC0f0+ptwzWkQDNlJHz0GZgW2+lAOekRtcGI76anJQjD?=
 =?us-ascii?Q?P5cMWcssK5BqeDSaHhjsvnlaxbvwkAjfEE0eK+cIbj8vRbhwBLigUs3B4K54?=
 =?us-ascii?Q?s1BcouaISglImBZr3MiLm7HsArx+NUzulhm7LAQsxvMVePyT9AtV/isgPhRJ?=
 =?us-ascii?Q?MaN9wxbuCg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d04dad-0024-4984-8853-08da43711db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 01:50:33.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDkwwuP1yV4s7cRkRp3BAA8/zDzuc1vd2K5BOctNCtDqRmt6ttUX6vTeksKIYKeXheP1KhccoxqmeFubtXtkTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3508
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Wednesday, June 1, 2022 4:44 AM
>=20
> Hi Jason,
>=20
> On Tue, 31 May 2022 16:05:50 -0300, Jason Gunthorpe <jgg@nvidia.com>
> wrote:
>=20
> > On Tue, May 31, 2022 at 10:29:55AM -0700, Jacob Pan wrote:
> >
> > > The reason why I store PASID at IOMMU domain is for IOTLB flush withi=
n
> > > the domain. Device driver is not aware of domain level IOTLB flush. W=
e
> > > also have iova_cookie for each domain which essentially is for
> > > RIDPASID.
> >
> > You need to make the PASID stuff work generically.
> >
> > The domain needs to hold a list of all the places it needs to flush
> > and that list needs to be maintained during attach/detach.
> >
> > A single PASID on the domain is obviously never going to work
> > generically.
> >
> I agree, I did it this way really meant to be part of iommu_domain's
> iommu_dma_cookie, not meant to be global. But for the lack of common
> storage between identity domain and dma domain, I put it here as global.
>=20
> Then should we also extract RIDPASID to become part of the generic API?
> i.e. set pasid, flush IOTLB etc. Right? RIDPASID is not in group's
> pasid_array today.
>=20

RIDPASID is just an alias to RID in the PASID table (similar to pasid#0
on other platforms). it's reserved and not exposed outside the=20
intel-iommu driver. So I don't think it should be managed via the
generic iommu API. But probably you can generalize it with other
pasids within intel-iommu driver if doing so can simplify the logic
there.
