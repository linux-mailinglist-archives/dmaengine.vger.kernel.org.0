Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820D36CD072
	for <lists+dmaengine@lfdr.de>; Wed, 29 Mar 2023 05:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjC2DEJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 23:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjC2DEH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 23:04:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1A51FCA;
        Tue, 28 Mar 2023 20:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680059046; x=1711595046;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VumKV72JfDFKscSd4OjpFcn/Y9gcAoZ7lmdL24M/jyQ=;
  b=iSa7eoCcc7GtcIUrGjqTwGpwIWzTHUOl1LBRyVh9DbWZ0jdAlHL34xib
   sLDxVVwMwwkGbZjmqBPHrQzknf1EPH5sgMG6ZtbFr/KTJYDKTOCAxnpdR
   v0EO8MDb2NSVz8jKkwUkh+IDPBDhBpDPsnbDf6TIGd6mA0k2XB8+73Uh7
   miuwxlOOzDqr8g9hlkX8tTk3E+k2O9xdsAnU+jchKEU1z/57wke/eVWmr
   U5F4ZZ8MvAH/pStunIzqMTSVqeKwIIrsHrKTI50KMm3XrZMIrTrrryObY
   96tSW2UqCP/p9b163E0l8iIWuo9f8Wj1YIpcsYYsmGClowPl7jqfpsWw/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="321158304"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="321158304"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 20:04:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="661440005"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="661440005"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 28 Mar 2023 20:04:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 20:04:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 20:04:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 20:04:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUtXD3HGRKERuT89OPnkk/3mxS/x7EtJ8Jy4twJUz2czgwvH6UiYpjr9KhxF2B2m1sAX6MBNitrt0ZQbgV2HdBynb+YHc1A+pFWFnvEHb6fvQhsFafYBdA8t/jCepg3uwPUfuYHYHom+2kAfJ+htFpFRP11L8nvoLFG+PkPUiTaJGZqGM4aq0mxlkmVBdIMio8t8QxqrHLdmvZzdLxkTIckH2NGaEnRs2KS3IJgdWSaqRQc+n5h7PvsvQzRXq5BwLh5n/Q32yFwwKJ9QAhMyEpiMIEldiW4kd4zXK639MoF9twysbfGXFcXsztn6ZfvEojT58BGdNCF4g6BE/Di43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VumKV72JfDFKscSd4OjpFcn/Y9gcAoZ7lmdL24M/jyQ=;
 b=kpFACIIgbYh2Yet8bfYQrP/xwXJIfKwKKAWfcKes0yizKCxJR8FABjRuXn5Psnjjx5rUmAJmXQm07I6juxL1Al1l7YAW+0aa5qYRwZ2URSZrk+ZZoNC9k3F6igYWnYcLfOZ+QxiAtCWJ3+Jbv9/kM7vR2Zw0jWP3gr0CZ1RckZOLXu46n/vB5oSFJA1zAaj3b7q9VxsaALZT+qsWC48S3rkesAqjn+Nsho/f70CYnADtU+gLL6GLk7zXHZKi1BxKc0SAeWBTg2YRZ0uGrUlf9M+kiJNDD8b5Jn07XYVgOypwECsqj36nA+Of1gGRJDgYQ9AMkHQ29H0Cy1ebS5ksRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4644.namprd11.prod.outlook.com (2603:10b6:5:28f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 03:04:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%7]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 03:04:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [PATCH v2 6/8] iommu/vt-d: Implement set_dev_pasid domain op
Thread-Topic: [PATCH v2 6/8] iommu/vt-d: Implement set_dev_pasid domain op
Thread-Index: AQHZYQJZG2KyXXm2pk6VVsU4SfiGqq8P0HAwgACEuYCAAL77oA==
Date:   Wed, 29 Mar 2023 03:04:03 +0000
Message-ID: <BN9PR11MB52769E0151C6DDBE0DE355AD8C899@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
        <20230327232138.1490712-7-jacob.jun.pan@linux.intel.com>
        <BN9PR11MB5276B3FF6D21608BB17E32A18C889@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230328084015.5c8c08ca@jacob-builder>
In-Reply-To: <20230328084015.5c8c08ca@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4644:EE_
x-ms-office365-filtering-correlation-id: f4a9a182-9772-4d8d-0f39-08db30024088
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSkogHAzRSnWAsQ/T2FRBXgfn3tfPcTMf0kM4ITvVo5LJOz2n3xqmx+oIJTLJWKu2cPbSTyO6+bY26ZCRWRSeIkT0FuF0GdfzscUlmvo7AGq9fMhGSCm+VKVefVmM65vd6TOcEbUJOtj0mi1Z18gEqtcktChNb2hybKwxzPW9x+E+PYZFbluBULKHkPEiojpMwIx//r46Y5NDgVlq7iTlunqoCd82mTv7Wib+eBc9Zd8XIXVUUWJ6iPRurvyKxOZrgRMGQGARVb5pNR/fb93OtOezc9WyFN3UmIkXM+Vd1oBW/JUDBSJtRdjFtdnY6MNNfjJVhBYqJ7De7PzWCEk5//tNjRIrLgY+cl2aC0BDQJwZdu3OG0jiVg6U23JKJdC0u+32mnYTHiah69mo+9hCpq7s0Yxdp88ea0Tls9hV180YWNx+eqPo1WXomZ5YNQMI+Yj7aETqq9hl7eEw/mlTqY1opYH+mSicQR7O49PhkZRl2Pb7HlqGEpKGnqfc7B9ntT6on7FM4OkB4Sgh4EjIds/hqEub50Vu/VlLEni8FUiziSfTjlkTyQAMpVm3NUgWAXCTebx2FTUCr1PMctDAL0gf+0GIm1JkeEkQyeBsHOTXKPtHF7+UxeY6RbFk8vQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(186003)(54906003)(316002)(9686003)(6506007)(26005)(83380400001)(7696005)(71200400001)(122000001)(478600001)(33656002)(8936002)(38100700002)(38070700005)(7416002)(86362001)(5660300002)(55016003)(52536014)(41300700001)(82960400001)(66476007)(66446008)(76116006)(4326008)(64756008)(66946007)(6916009)(8676002)(66556008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5TrkVBd1OrRrHsUgFXCyj5XZ74RuBsDC9dqrv4qF16WX3Yzxv7q0TZRzlqk9?=
 =?us-ascii?Q?igsbxvO4YLE84V8MzIK64wqJpAARwKJxccz3OcBriKXzCSu+26VQXPIXxPbO?=
 =?us-ascii?Q?1NyR1t8Bf8uJJOQcC4t+0aMTXVprE47EAdhLm6HJN3lNAc221Vc92VAIFusC?=
 =?us-ascii?Q?XUVS4G2hBAdsKZa5suWhnjGlm2P/6WFYUQ1XCVuXBbzHhS2/US1zjrtMybLN?=
 =?us-ascii?Q?Lf9zCOThp/TazKFyGhNfebUBKPPJ/FB+whOZX6yGegFh5NJo7wbVq/UiOjN5?=
 =?us-ascii?Q?Q9AcYlSrxITmR1lK0m5JARUs/aG+K131fhf+BvfBRQxKvO07OPnkqvJTDtDj?=
 =?us-ascii?Q?W4SjyxBXd1YBKXQZsW+YnVHX0/8nw1j0T/PKGfeXL39Lhdza4zkhAbIk18ek?=
 =?us-ascii?Q?VqbgTZry/bM52Eoaagmg4X3aTkRwqH/PcfqVwOtePEqe3r4G6dXU3yhOxT5Q?=
 =?us-ascii?Q?6XhuGAYRtZ5ARnNwOrffCINIm6jjcdi4wy3XuI91cvPb5PVuf93ukEu6Wcv5?=
 =?us-ascii?Q?VWdZGjCIbm/un/CPEnd8HLubbWfhaStvANPR6ahbGWQKzT/bWRo6lp5w/76v?=
 =?us-ascii?Q?QWZXD5PvM/71w5zC9z+OogOLauyqOfrmsYI4f8NmaABNNQfaUjoE6GTL9re/?=
 =?us-ascii?Q?3XJ6R/TtP5VegGL62xwdJO0LlT/Z6V9b3mJH5axa8o1XoLCxzu3WLaNVQOUC?=
 =?us-ascii?Q?NVY7FnNCXxVjrgX58TRQkL8j/PswwR1S6MKZqF88I2broM7j7yGpUWE7xvc6?=
 =?us-ascii?Q?OjLQv18uxreQgdRGeX/7WVWTUN6nIKTKvErjxavcz/CrsgqySmvlRImqD87A?=
 =?us-ascii?Q?/XMPPq0/5yP5jqATB11YZw22TTdwu487xqzYOU1gcTh6E3OfaMVeOjGklnvj?=
 =?us-ascii?Q?c6KUpw7DILAuSa5uWbowhS+zEg55UA0pfRncSrjFYmTP4kxvXGTc72NkB5iZ?=
 =?us-ascii?Q?IVCuKsVCuCj9dMOS4eSLITtLehrJ5IInTLIlYljgqVycugqGEfbIl/1GuDC3?=
 =?us-ascii?Q?pi+6ZClkV1J4xrE1qsC3ZFvoh0jIQU61Aio9nTfHlQL6xub+YmsKokm95DoV?=
 =?us-ascii?Q?fUBegQg8rlKomnpkzzNakBGqkbaiKmZMSb2NfPZy0hN6Lez/TQDV1kUEpAZ9?=
 =?us-ascii?Q?NvnBNZ6Ngjpuhz7ayeKmy0cVWInoANRKVfyvqi+MvCLzXOoZ5DJa5INAW9vP?=
 =?us-ascii?Q?rs1Ul4lkTkoqdQtUf4A/ZcCm3u2dDPHgG3XORF/95NHvLgKv4ovabYCQubKS?=
 =?us-ascii?Q?IcbTWXH3pZkb+q/knfJHopHwUhXNluFh566d6I4KlGVN2nsBystrddr1FF3o?=
 =?us-ascii?Q?KWQcYAE6tse9X0kE8qS4ZQr8wI+vTVAS92WJpap+fMYzKDY/iKmgU2iiRLQa?=
 =?us-ascii?Q?OaF/lnFrBZYRKkkz/msz9oJRCWwahkaSlmu3mSxil90ZPwNDwuWFHicuNEYz?=
 =?us-ascii?Q?RsI4Tuj86yrRSbhUKguX10blht+7R+qVffD16EP3qckxhmlY9C6cyLBDQnWa?=
 =?us-ascii?Q?AamkggN+WpcWu8okMjQMmdZx/XAS+an3PL0TzZlc/YwRS2JzzyRt3wjReo0e?=
 =?us-ascii?Q?YvgQH/7RwxR81noY/u3+xbyYoj/zrPrlxqi7kkYX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a9a182-9772-4d8d-0f39-08db30024088
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 03:04:03.3245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7jDGI8S0NLW/r0HyQBkFuTNJ9qyN73SBdzEXVko4h6gOgRshVZPTbcCcPFmYZaxFFse4EUAQRUJu4U7TUGDsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4644
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
> Sent: Tuesday, March 28, 2023 11:40 PM
>=20
> Hi Kevin,
>=20
> On Tue, 28 Mar 2023 07:47:45 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> wrote:
>=20
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Tuesday, March 28, 2023 7:22 AM
> > >
> > > Devices that use ENQCMDS to submit work on buffers mapped by DMA
> API
> > > must attach a PASID to the default domain of the device. In preparati=
on
> > > for this use case, this patch implements set_dev_pasid() for the
> > > default_domain_ops. Besides PASID attachment, device will also be
> > > attached to the domain as the result of this call if the device has n=
ot
> > > been attached before.
> > >
> >
> > I didn't get the last point. PASID attach should only have the scope
> > for the pasid. RID of the device might be attached to another domain
> > which shouldn't be changed by this call.
> I meant if the RID context has not been set up before attaching this PASI=
D,
> this call will also set up the context, PASID dir etc. In the end, we
> eliminated ordering requirement of attaching device, RID_PASID first, the=
n
> other PASIDs.
> How about:
> "If the device context has not been set up prior to this call, this will
> set up the device context in addition to PASID attachment."
>=20

this is clearer.
