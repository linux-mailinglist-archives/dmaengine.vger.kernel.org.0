Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BC3538E8F
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiEaKNJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiEaKNH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 06:13:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7F421BF;
        Tue, 31 May 2022 03:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653991985; x=1685527985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SBAdatblOyjB70Mix2NAQdvnh60UBnzBa5vVbtjoH1Y=;
  b=jrNljtQxabw/rytKbELqYVd7I0ErCgWTJEvpK2jXXfYx26OSPlHAB0Xn
   tqMKvvZ9pIRtUst/Lkc1EUMwKinmpxIEsgNsKXCbgJ5BroONzzfeZbNSS
   p11BOAgPUxjUP+OicTUefj8B73In93LTp2/O6skuXjDOKMklaxmmiLHBK
   5fFDwC7TdxOgCAheIV74qw5IKg47eq4gD5+50jp/f0ZRdIC90XErtZngP
   BLfcCbJZm/Yx7Cq4CP5lt8zR5DJZUXYE9ynxlM79CRdPhU+NfdC43SPjG
   ZedL9HZSbwoiwN5Z+QrXo/jzF9ShA32xvLaunxKjlLi37awpbnZqhD78H
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="274016352"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="274016352"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 03:13:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="529519381"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 31 May 2022 03:13:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 31 May 2022 03:13:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 31 May 2022 03:13:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 31 May 2022 03:12:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0s0sY671itnzbwC2177is1COdg5tCsqfKkEiLHdwcxcBtT21gZfEcnvcDoLyyRBx6IqlxZ15XH+Y8jG9fakMFmF22JVagJIqV05HxMILS9WVHnBWe91ND/9DIBtQpvBTdf1lGKIia4fw4DvVXsaVlCQihQPssFUPHaNzfQ5CH5CNu9MG/fkMfcg9cU2l/Bg/p6Rw7UkyfbypkWXxoztok+DQSlh925Jg0395qqkcRT9HRkwsUSmouCa/HeSBhUBeW3MlB0GO6AZhK/S1tAxrr21nd1+u2W7DMDd6wE1v2Nq4UfhzyZ2Cb3XpzuMx0lmCzG6K/X7xINEW/14CQ3kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC7BvAxeM/ttxhH7TpkhujlDaks5UMcK2GfDkmQcwt4=;
 b=J/MHHsoP+JAn/wrW4dYfujNGIssSuhFCroKdhO/JoISK3JujwdBy/yFdmyULi8QVCOWXBwBp3yF8nUtJcPlotjHkoiL9og0IemLQnJYp1LikcPeFqwfvf6AKSUXJyW4FPx+QVvUqm5/dgE3Dj6F221SLh16/2te6f2ja+6CFANxxzYuXCeVt0CZLWTd7x4i2VjDZR9Zmc42ZkeOIgplN6BKOgH7QaDACGAc62HZwc/1A5tX7BnZjJlqCW83R3XsnDH1VaSrkfxs+mvkQaatQY06dpIBJZe6MDjUcm4vnoh74JImAi8oox1r1YxaMmLFd5X92ySYv+G5AN0Lb2rV/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN7PR11MB2754.namprd11.prod.outlook.com (2603:10b6:406:b3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Tue, 31 May
 2022 10:12:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 10:12:47 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
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
Thread-Index: AQHYauOU3vbab87feU2/ab0rn4lTF60uFLMAgAAYR4CACT0vgIABWQJg
Date:   Tue, 31 May 2022 10:12:47 +0000
Message-ID: <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
 <20220524135034.GU1343366@nvidia.com> <20220524081727.19c2dd6d@jacob-builder>
 <20220530122247.GY1343366@nvidia.com>
In-Reply-To: <20220530122247.GY1343366@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc849b05-fc5c-492b-a9cd-08da42ee1c84
x-ms-traffictypediagnostic: BN7PR11MB2754:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR11MB27545B43174CE30921F1B2968CDC9@BN7PR11MB2754.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n6Q6MB4b580p67TfKNC2e1HN3OZV2TNd3pDA0AbalWTU7KY8c7Ntrn33QbE6rInfRJQK35SDZea1s6ko2IapabIR4KTdwg5wtek+9MYPgr5iESPsfozhzkwT1gHibE+K6dBcGB6Nd5KId0qUvOClVMNFkW8Ubj7UuFm5ljfLrDAa8dtBbbranx3trbUQo1D/PO7arO+4Lcf9MPKr8MmqD9dCUjpDCfa+CgPGUkjL6El0p+GbuUZK9T7RmZ/eEwv8JPF8FyvCEqwPVH3k8XLIqmU/JOxPNxzHhJfUMNqG7sdrWZzPdvToAEteR0QkZu3cRSIpCwqHvBKM+hAxPv9rqNqP4Ej/p1D/AJvtn6bEVF1E/cuOeUVbbgC3cLSKnL5iYoJrDW4xuY9UyeT9PQL6fdH46ufn+LQKlGieOmiphIsRfREvgshW2DsJRTMzsRr1LB8fXJUU6sKTkr6X5xScyQlrdpH08aKxBS48RzRoimoB9yIdo6CRX/MPm4z+6PBIz074rETARkn/O7Lc4C3+sFJ98eb8KwyvBWbJ14yFv0bbZF88TQfplBjAZAcU1VxPwP+DFpGEMJ8Lukr6WpGJ0pCvAHLsQ8NJDAbgiiUJG4ATu9lMw3WNho1rnyi1LoBQMZCtTw4K8i40ZS0mV6E/AuqF1AtKGh/29M0+ypHWXgBPr0NwnGnyuntcYSDApB80Va3GWLF8kNkgYiQSH1OYIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(55016003)(7416002)(122000001)(8936002)(82960400001)(5660300002)(33656002)(508600001)(52536014)(9686003)(83380400001)(186003)(86362001)(26005)(2906002)(38070700005)(7696005)(6506007)(8676002)(64756008)(66446008)(66476007)(76116006)(66556008)(66946007)(38100700002)(4326008)(110136005)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I4WybO6awlusuilPxte/vDFIqS14x34/218RKvAK1F3jz6isB+WOBsBn4KXO?=
 =?us-ascii?Q?LgY/eCmwkIiKCpvMwCJnGuMWwhtiaa+d/hwefZCnMKrUnCQnBRRX2k6rH+/R?=
 =?us-ascii?Q?B3LGJlXOZ7NfEhTsgzvBUL7WD84W/z7HT7y9DbWAIG2zY+JunLiCX6O2bZRJ?=
 =?us-ascii?Q?pHvBgWd7dzwAyVOf/gahRMBh0lcfSVSIRmSEfvKAV5Xpr54f3OCa1pfGjYRI?=
 =?us-ascii?Q?LNs3o4m7wIbIC8i00eWUqWHAhWKzIKFs5uvGKJtL3YuO6gdlwaAi0agW0SqV?=
 =?us-ascii?Q?/Ac1sJvCSpGnmQ8XRaMSrPdq0B6++tImBi08MbSghq7kQXeMNd9ULkc52CY0?=
 =?us-ascii?Q?9RZcRjunq7+rVi4125o0j+o+3OPgeaEdq9BIjpROJeuEnlAG6i/rqIvQs+nj?=
 =?us-ascii?Q?/1RPUrUyIvwiWT9jGI3HRWDjQLN5qlXQp1iKITRvor6wse3FYaPzNY6l5zhU?=
 =?us-ascii?Q?A1HzZ07m0ePw7dgmnJC+/ObtvPaX3L3CVTfxUioNDS1Ai/+Y2RxADEst76Sv?=
 =?us-ascii?Q?m+p5Gg7hvisY4OzxWYJ8Fa9VtGb0JMgDZF7M6i9kW8SSvHjNoWMZbrfPALJS?=
 =?us-ascii?Q?8x2P51eyGzubpldbnWV8TXDg1fkoJCe00EdNUfH6D6RNOTEMJFtRD7YCUsHL?=
 =?us-ascii?Q?QLRIsgemE8Sq7G0KI7pTtkvWqIs6gr/zX9jD6IiPRKaK6399FSXmbCVGaP2j?=
 =?us-ascii?Q?FY8uIna7+iYlNRiJ8Bi2Ca9SbMiynJBmnm+a0lbB2M2kQI8WopjvcF9xhIdL?=
 =?us-ascii?Q?UqHnb2YRrFmB+dXVjE4vvlwpozb0/9Zl/B0NDsFPe36Rmy4x3sDMAXdCUEYq?=
 =?us-ascii?Q?sRSC1rKLNId2z/xWlioU0WZqFvSbS2eEcqreHGcxjL8kNX1PkyZhYPWSBjjC?=
 =?us-ascii?Q?z1fk7pXQD2i/zyl14fMx/SyPXW8O8CZdGnUEfac4bHvztNLJ13POFuSzlsJK?=
 =?us-ascii?Q?HyFgva/4cH/atijgFkPiHMHUHbx3Ys3x9TuI7UOopzg8knUN+NrNOxO+HXAz?=
 =?us-ascii?Q?/efoYoMYW8epbHyOTLfMYp7lVEs/X2dk9OerfORgEOGITGHSjf76gRKkfKVa?=
 =?us-ascii?Q?sF7m1Twicm20ikwAJowAKjzjSiNyz0KLNP2SiRvkggeYJGKusan3ajeIa+0I?=
 =?us-ascii?Q?Zo+83mToeBL7v2jYWcLSQKgRPQ9GJA3o0x3fHurE97ptM1XVZftUqwgqt2/N?=
 =?us-ascii?Q?DA5og8VMoo7GCz0z/0GZnx1G8JYnNE4cmvwXVba/isZeKy37xLQeg4m7rd3P?=
 =?us-ascii?Q?6RYSFpyYwjAIxEPsdxhSEP6GVWbyVunK9qBpvWFbjKI1vcsCEIpitCR56/xg?=
 =?us-ascii?Q?m+d2peK6mkJFRRJS9oUE/gJI/IjoVbac67i3hMXFrtVhJyZSier3hpccw82p?=
 =?us-ascii?Q?Icm0Kn9Zd4cIILZgpraV4AY+DTAAuGaVPBNriw8dhOFO9C2Bh+/Hy2GNQOA3?=
 =?us-ascii?Q?V0kF+htbGgDf1xKvxBhhXn6qFAPGZgJoh5GEx65m98KKV21LCeAUG2ObuBxO?=
 =?us-ascii?Q?h3UQDf5IOKrgNInw2bgQ5pbfyNFDkgpgGIH7aTlDWWTj/DF3IBfeTjKv+cTY?=
 =?us-ascii?Q?ek1ISt9Gd71DGDbRQAeg9xn3yHraK0E3hpzkZde+ie2ccBd1g3s1OyTSFbnw?=
 =?us-ascii?Q?jbs2M+LRI9QuGJuq8Uw4afbnvZ3FPBnlNuogVd/s11WWoWT/Kmv9ks2x1ZB8?=
 =?us-ascii?Q?/Uu5y9ZQkoOIIV4lJsduJirh5/r4JAsYtAQGpTCBOLoxMn98lLxMTbXEXiwY?=
 =?us-ascii?Q?96lnMlmVgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc849b05-fc5c-492b-a9cd-08da42ee1c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 10:12:47.3827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CmPJQUhsa8TIaUUCH09ekhpICYYkFxy3UW80Pu2pziG/9nqeo7F0oHRZRSx5ojBjdvg04s3Kza31/iWtGDyJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2754
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, May 30, 2022 8:23 PM
>=20
> On Tue, May 24, 2022 at 08:17:27AM -0700, Jacob Pan wrote:
> > Hi Jason,
> >
> > On Tue, 24 May 2022 10:50:34 -0300, Jason Gunthorpe <jgg@nvidia.com>
> wrote:
> >
> > > On Wed, May 18, 2022 at 11:21:15AM -0700, Jacob Pan wrote:
> > > > DMA requests tagged with PASID can target individual IOMMU domains.
> > > > Introduce a domain-wide PASID for DMA API, it will be used on the
> same
> > > > mapping as legacy DMA without PASID. Let it be IOVA or PA in case o=
f
> > > > identity domain.
> > >
> > > Huh? I can't understand what this is trying to say or why this patch
> > > makes sense.
> > >
> > > We really should not have pasid's like this attached to the domains..
> > >
> > This is the same "DMA API global PASID" you reviewed in v3, I just
> > singled it out as a standalone patch and renamed it. Here is your previ=
ous
> > review comment.
> >
> > > +++ b/include/linux/iommu.h
> > > @@ -105,6 +105,8 @@ struct iommu_domain {
> > >  	enum iommu_page_response_code (*iopf_handler)(struct
> iommu_fault *fault,
> > >  						      void *data);
> > >  	void *fault_data;
> > > +	ioasid_t pasid;		/* Used for DMA requests with PASID */
> > > +	atomic_t pasid_users;
> >
> > These are poorly named, this is really the DMA API global PASID and
> > shouldn't be used for other things.
> >
> >
> >
> > Perhaps I misunderstood, do you mind explaining more?
>=20
> You still haven't really explained what this is for in this patch,
> maybe it just needs a better commit message, or maybe something is
> wrong.
>=20
> I keep saying the DMA API usage is not special, so why do we need to
> create a new global pasid and refcount? Realistically this is only
> going to be used by IDXD, why can't we just allocate a PASID and
> return it to the driver every time a driver asks for DMA API on PASI
> mode? Why does the core need to do anything special?
>=20

Agree. I guess it was a mistake caused by treating ENQCMD as the
only user although the actual semantics of the invented interfaces
have already evolved to be quite general.

This is very similar to what we have been discussing for iommufd.
a PASID is just an additional routing info when attaching a device
to an I/O address space (DMA API in this context) and by default
it should be a per-device resource except when ENQCMD is
explicitly opt in.

Hence it's right time for us to develop common facility working
for both this DMA API usage and iommufd, i.e.:

for normal PASID attach to a domain, driver:

	allocates a local pasid from device local space;
	attaches the local pasid to a domain;

for PASID attach in particular for ENQCMD, driver:

	allocates a global pasid in system-wide;
	attaches the global pasid to a domain;
	set the global pasid in PASID_MSR;

In both cases the pasid is stored in the attach data instead of the
domain.

DMA API pasid is no special from above except it needs to allow
one device attached to the same domain twice (one with RID
and the other with RID+PASID).

for iommufd those operations are initiated by userspace via
iommufd uAPI.

Thanks
Kevin
