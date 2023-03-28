Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793856CB891
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjC1HsJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 03:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjC1HsC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 03:48:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EFB1990;
        Tue, 28 Mar 2023 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679989679; x=1711525679;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=45MAmF0iqcU3/QgsmW5rLVKKYgEorhmiGmRTzXakX1g=;
  b=lOpS+dwTh3lPWqD0EBY62PNOmnUMcY5U648fyEdPpI/5LelLYDSbsRqG
   KkKcWaAPa4z9kWD0cP0yXsY1A4XktxStwUxUjE2J7dbPLYsrCIO7kxr3v
   QY6sLMP/O4cZelini6G+9DHq0NpDxSJlkNJ9jOAi3Tigo2lpUdfaacmck
   y+Zjnxg9WIYwzhCryPkEEOP53qjHdrxgItKMQKPBYZUn2Xovxzy8D6hGu
   Zu2JwHlfsM568VsEVEvrcCXj0VioxX25LlFXLrcYgZb3n3jt4ypy8f4h3
   mR+EqZCY6biBR1kGA5/5wHnfdyksz5myz7c1hJSuqRcMdWKv8q4MCmc4f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="324393947"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="324393947"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="714148123"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="714148123"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 28 Mar 2023 00:47:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 00:47:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 00:47:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 00:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2D0I5lzX8RajUtepCZRa8T2pCCIxSQMh0EF21wiPgqAkwI81OReFxpe3V+zy7BNKTJjpsN+S5sLems+LtZkaBOSZo+sP5r1fnwWrn+str1n1lou+GH6J2Rnm44x9ytFYvqMPCPu4Xjk3zOYTbbGLHDOD/3/d3nASvMBJWTC4i8vvFr0842ciyBNpK9n5Ir3IB4CLp3tmFfiPtyoX2oKYS9RSjgOV3mMQNwURDp8y3EbANd94uOe22LzvfVdCqwg4Etoky4KOr2xB1uShBTYzLIz/zGSJUsCiqz8tK2Epsjnt3c2qs5RlpqY5GZqaOnyzLxiBhniy3k1O7wc3YG2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45MAmF0iqcU3/QgsmW5rLVKKYgEorhmiGmRTzXakX1g=;
 b=HE5YL36NcGU+xiviPzPke8eAapmmkECh+DzIwpKhPNR1VazkiXojM3F8do4e1D7HsZY+Nteo8nc0KX4n+4YH4D+/Yj+JlVU75yUvwo6j366ILxJ0iqdzJ+OZWg99wiGLne81vrGnklWw3/DuXpRqx6m4aFDg3fhqyMAQlo+HWT3S6rupzlFNx93q5FXwiqBm5QjbD+vmhoi2RldYtU0nZbGIVY4j4sVKV8gAUbZ8IKlKUG8u9Qariw1dxrb0qPcyJffqXDF3VnuUam9tFFZxH9zm1owMGTvRkdP7yWlGr5MYc0FIZg4iR0kYyiQ0tk7snKL4FX8QnmEJV54IaB0j9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5042.namprd11.prod.outlook.com (2603:10b6:303:99::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 07:47:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%7]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 07:47:45 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [PATCH v2 6/8] iommu/vt-d: Implement set_dev_pasid domain op
Thread-Topic: [PATCH v2 6/8] iommu/vt-d: Implement set_dev_pasid domain op
Thread-Index: AQHZYQJZG2KyXXm2pk6VVsU4SfiGqq8P0HAw
Date:   Tue, 28 Mar 2023 07:47:45 +0000
Message-ID: <BN9PR11MB5276B3FF6D21608BB17E32A18C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-7-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230327232138.1490712-7-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5042:EE_
x-ms-office365-filtering-correlation-id: d752ad30-3946-4981-41b3-08db2f60b7f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rMIZmyqdRE0OeJoY9z2NjYymMwY4mnbBSRiZfRfQtMW85LfKz16ssZk8aFUwmlHOZ8jPn4DKGCi3rgyTr1n2IOuu921q0PltTr6S3SFdiiSmQVPUCnmw0AACMgJvHOxW76+Ng7TRHGSyxXkuiFZ2IUSzsXTv3/o6giVEKvvKe5YQjdEXzmu/8CSnCJ/uTN5XdHNKvVclEMuidm690DXuuLgVgvBEYEBe0vM2PQamVoha1QT7ZAm+8st4VthOyB74a8dRHAmq7TzY907uP/zXOoq1qXfA9lpqvbjo9iQ5Pg5b5QBCo7jrpaU3oaoyTD9OnVQGIlBCee6jj8ptHdSE2KgvkOCBbO8PTtQ51CoGZUY2Tg3zIUcssbv+m5ssBlsKjkRDvf/8KVTX4yc6vhFaaLX14Ff47eHZKEADqgHMrqVbcDTK4uZ4pVigCOc7vWU4X7qGvbxIopDwXonkVxnkqDgv7e1kCkF0ZiOijJZlJ81ep6e/H9b82H1/XgxtadYcRpC0lSk5tI2ACcU7Ocvq9f0at/4MxMmZONWSXFWatsJC97aJr24jnl6FEEJSnJ6Zkr4jdMJxhxk/dZ/Szlj0xddjQxsKjTzx/YzaEJsMyfnF+5pZlYDsFb1wO+q2XBjH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(186003)(6506007)(9686003)(54906003)(110136005)(316002)(26005)(71200400001)(7696005)(5660300002)(55016003)(38100700002)(7416002)(86362001)(33656002)(38070700005)(4744005)(66476007)(66946007)(8676002)(41300700001)(122000001)(52536014)(64756008)(8936002)(66446008)(4326008)(66556008)(478600001)(2906002)(82960400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i1MxQTif7wadC1zX9uUXiru0TDcM2XbH7NbCsO2g85dPFHwp3yJbN5S0SbYI?=
 =?us-ascii?Q?CMioJhvhHb6O2y8ZvYcGpjKqR3Qp7/RIRsxH4MMthuTc8KPN1WZLAUH+Mq+T?=
 =?us-ascii?Q?5S7kHfkL8iJzHXRLll0W17wA8TRuplKPWVQUPL4fjwE3tlapfS+ZeD+GgWvA?=
 =?us-ascii?Q?AegRxxGpNk5CoVUCTAfypoPauRcre7NBoDTEkzaXL4wJ88g7lYHsaAGJMOUX?=
 =?us-ascii?Q?OUuMosf8BIenMa65QASbEbN+VweTGgPl9WWR06NFw1Utb9ylLKaFgBVfRUGQ?=
 =?us-ascii?Q?nQvo6xnYtAdxCEB7jlhgitSxDZz8TSUYGaxSMXAr+UoSAlWLckJ0C2AOD1vH?=
 =?us-ascii?Q?sr88L0ona3pfLIGCpY2yh0xIpdjXGRNgbo7jO6UFVVtkH/ScnpCr+IYDXbNH?=
 =?us-ascii?Q?iEErCmL4vNvXsUGhetPhz5ykTKRW3SVRQp6AwZdfZdt0tXa2mhbCr7gpORMP?=
 =?us-ascii?Q?3dMiFImUl5T5EAsYPvoKw0zk/R5QfaqdFTdD7jg5iNlz2XDnU4YzBkw0+IOR?=
 =?us-ascii?Q?n/EHpDoxHoZDeUK2PDEZTTqoDPSq+eLR++LBg4o8TAWc3kNmSFbu3HPlwAZw?=
 =?us-ascii?Q?sVuXcWvTP+OpoSNOTp6/xz9hRJcFAqs7sltOjQPExjNjZgJPByvR48aj1JM/?=
 =?us-ascii?Q?XDi5koH/MmTE5fRXfQmXfDZkjx9syhlVq+hXamHWSpDAf5A3XgEjm0tbF2ov?=
 =?us-ascii?Q?IYKLuyoM+H7EaoCk+q6eOhbDEqB1kO1hw8+UA0AP893LmiSFBk4TpqA07BSp?=
 =?us-ascii?Q?TEeL4VHAZ8XpDZBVMFtOHKq9d9GBgKz42G+GywJJzCQaFs16r9rnoI318mSA?=
 =?us-ascii?Q?e3w7tkEuWyxt1ETCPwaKUz+QLrS+sYJQ/F6PoHel5hgUWeaYZKrCvTk6OpFZ?=
 =?us-ascii?Q?XpWUaRQ0nz1cMgzUUhoTIGTYCjob0SkCohJwkAP4vqQmdtounvXEN5Jxjqpv?=
 =?us-ascii?Q?hjKNOmDFRbhzwbDwh8W7Ab6rtI9r3Ot4l6gzEFFDYJ8cNEAXn5mlXUEYnpFV?=
 =?us-ascii?Q?ugxPOBw4sw1JWH3yz+AGEyy6pW0U7yHZC/MlBr45h+mMcS7V5QG5d2TD69Ll?=
 =?us-ascii?Q?Hoehvtr/KsyQUNYAowvMh7z8v7+62thAin31H1SmgE3IP1LniL7cCUr8zgnQ?=
 =?us-ascii?Q?b8DmF/Wr4wYhlIX0muTQ4S0PLaOvyl1E7CkhWSO/q93NPFKOd+k0OPUwSTxC?=
 =?us-ascii?Q?L07IaeBJCsHnjVzjrH7zFGxN7BEFWn3K7SigweRaaoNUH62BkvjBkEBcsLrZ?=
 =?us-ascii?Q?pwzrso/HcroQBUDIRG82Hmjx/YmlgYYUG2EZd1pyP7qwZQ5Q64sWSK9/qTcv?=
 =?us-ascii?Q?xugWNWmfi5H+heTJ/K6JzrEfM78DeYxUKueQc4h0s2yAcrEfyJ3WQw3/MpnX?=
 =?us-ascii?Q?ho1ikq1k4MGzgUzPvEyC1FCrn66ADPH4nsXNx17R7f2B062SCy7IipUjfdVP?=
 =?us-ascii?Q?q0KNa4MJCq67er5jL+10XmVrTwaQHNTtl8ea2oCSxTvXqRXQHlUyv4m0Y2bN?=
 =?us-ascii?Q?BoiZ1az6ksBCBtKMCjwhympzwe5KdAWe+P67OliZhx9IkXTWVqRQqwHr8ra0?=
 =?us-ascii?Q?PeIplQa9RsDnF+j7EqBXPHjCFAAJ7xuvcrt53BuP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d752ad30-3946-4981-41b3-08db2f60b7f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 07:47:45.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ykpeCBbp/xMnIHbaiKvgBE3BYzhEMoMczUnPU1l4/pJQiu9VNau6yoXu+jkamLIiY9fVrT+5wNAMaxzQQW9/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5042
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, March 28, 2023 7:22 AM
>=20
> Devices that use ENQCMDS to submit work on buffers mapped by DMA API
> must attach a PASID to the default domain of the device. In preparation
> for this use case, this patch implements set_dev_pasid() for the
> default_domain_ops. Besides PASID attachment, device will also be
> attached to the domain as the result of this call if the device has not
> been attached before.
>=20

I didn't get the last point. PASID attach should only have the scope
for the pasid. RID of the device might be attached to another domain
which shouldn't be changed by this call.
