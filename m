Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D044B530BF2
	for <lists+dmaengine@lfdr.de>; Mon, 23 May 2022 11:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiEWI0E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 04:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiEWIZn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 04:25:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487F42DA8D;
        Mon, 23 May 2022 01:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653294341; x=1684830341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=igM5Ma7k6eALC5kfFd9tq0y+ANq1lCOaYezXzYPWJnE=;
  b=WZbFlL1KKOy3dDuoAtFgXOIOzufFmY2q06oWUFnjzkBWyg9mwskLzGTC
   FKB3pN45sNGoNA3+66G3X9r4yNBfWF/y2lDK12dz912SdVX+R9qjgwRaS
   lOymXxt8Y43JWcsmopJH3NIfN57rZAAmA38G+84zEh05yRgsK214XQHH6
   Iw0J9xQSPi6zMEuWpH3oBtWEJX2DEIXdWVOwaN0RsAKYBMX3AMqbTksFv
   fJ29+wp3DhXcdZ5R8Zh8JtCE9zX8FczUGzJ6D5Xf7uZCrrshUZApxn3Dy
   DNnI1fB/iMGmlDt8DAeYSfdX63EbNFmMBPBUZXU5Kq2c8WKJF9LwoDwGS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="260750720"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="260750720"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 01:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="571965970"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 23 May 2022 01:25:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 23 May 2022 01:25:37 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 23 May 2022 01:25:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 23 May 2022 01:25:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 23 May 2022 01:25:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkbKe7AFEqusPJ2X94EKKSV7HxQ48Yq/JFAP4RMK1kpLEn5YjveDlYi0ecfqRYKKpiglyRjbhVvBIN7RG4k4gGegWq2Ab+QdGg3A25BW5wRXp8HRK+QbFcvn1cPP39j8zyFySlYZbrWeq9flXs6GNhNoRUjZ6LrfIW6Btjn2CxTS1R+2cE/5C4XDd9s4yaMukz3U2eWZ6wpd/Ceo7JIOCkgLABQkLiaTEbiFVPT17+8eIbl1yPzf1hpljtzuzLR8BnL7tPYtN7M5wPhgONTk8xOP7HDTKQboEMYcHeYYVZONw8jy7oe87ToxkAkjd8JMCs/VhsY1yslOJ1vjhYTW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUPcr5MNodFzKyOfga4eJJ75hC8ovKD8iBN7CfRCV1o=;
 b=NTmjLDZ0nW34tvzgNSPAaCDvrSbA9e3RkWLDX38nzbhmjo8EJpGssokauFJP6wZYHn5kobWI6yR0XQkkFJTaNOeG7vyXg4rT0kJD4h+p/pCpvr2cnz4b8t3efIsp85aHgWrMd56acKa+021CnTWnVxJwo0mEZJuSMaZZwQJT4GKYAQb74yVxUUoaRtGO6BNCk0jE5YwuxvpTODMG7H3IpQ20Pju7fsVRWxffIfQeqJ5CxjDdikn5UGRERggyRbAUhczRNvZ3YGceDYCkCWfdXsNfY+/yVOSKH5Q8EDMsyeomxqXZg9dFVV4rJZ+dqSmWNUmoKI9hc7qatdsgQ4OR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM6PR11MB3930.namprd11.prod.outlook.com (2603:10b6:5:197::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 08:25:34 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::3114:d1ec:335e:d303]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::3114:d1ec:335e:d303%3]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 08:25:34 +0000
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
Subject: RE: [PATCH v4 4/6] iommu: Add PASID support for DMA mapping API users
Thread-Topic: [PATCH v4 4/6] iommu: Add PASID support for DMA mapping API
 users
Thread-Index: AQHYauOT13oDIcCFekWTxcG7Uq0rw60sIOpA
Date:   Mon, 23 May 2022 08:25:33 +0000
Message-ID: <BL1PR11MB5271E995E160E0C6A6C0C89A8CD49@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-5-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20220518182120.1136715-5-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96e41911-c5a1-44f1-3f1c-08da3c95ce8e
x-ms-traffictypediagnostic: DM6PR11MB3930:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB393052E3A8AA4035585217AD8CD49@DM6PR11MB3930.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tvZuz15qw5OsqjmiDLi12U60sJIjSvsjn0HTQo5eMMRvB4+AMzqaBYKRL7TfIB23r/D5X7Fuu5Pc7XluATERvRqKmnx36kPheGos7h8aHjn/noA2i8trADvcdq/8H3sAfkoDNUPLXptH2CqWRlsIQqc6qOwK6JkwJda0l/b9wbltSr8AoyzNPaN3VzWZIJHbfcH1snmUWAt9asOxma2xDiQIdACXlbzFU5P0JwEYWlMqgzJ45sHAAZji6Eu883VBm+iVYQMofsGrHxL3lFVfQeS0cnFkkCGFDZTGvTb0DIreGiFcuhUVxkzmHugoMCUUow8nSdcFVwcqKhrHAmmrzundIcGD/2xC8dw6ekH4mhDnM8f+y++9zt60U+KAuHfF3NgJBlev81sU9JPOr7OOFCndVL7h49ceYJSoNLHnsfYGHpSj/otMknkjVyeVJxmFEP+9ZEJleCfpL0QHaiDGbRqJiqOFmJ0YAZUxm23emvAtvZ01421zVoZALOZpOdg+gShkQ3yVQMiEwEfeFiOHmJOHnpDYj8I/iPSpovuu2DN5UMr6s/flaAlyhmlnTAHJ+IYWhkBNGQtwLYV5M+HdMHeENTrxFTW0uhmquooq9VUuSV01FRKLzqLFddgC9R0ykvlZxpUBmUBOyohNAtXK8tEEKNR0fm0YZ0HqSjO2KlS+/wpoUkpff08qzZU/q5mDXa4uRWHahLAu9Y4pSIyAO+RaY/hCxrIDdzUd7+XrCEE7hQdQirgoit44N/RyTK2GR9FwYrkSnrploWHuywvQVjb6Z3C8Y6Jvi7do3O+Y+ms=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(921005)(38100700002)(2906002)(38070700005)(66946007)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(82960400001)(55016003)(52536014)(122000001)(71200400001)(5660300002)(54906003)(110136005)(8936002)(7416002)(316002)(508600001)(9686003)(7696005)(26005)(86362001)(186003)(83380400001)(33656002)(6506007)(26730200005)(19860200003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?44w5/dcusEePT35zys05DpstC2T/PHIwZdlIFDRP4uUm5rrZghlOFSBOeQ2D?=
 =?us-ascii?Q?OqoiDmtV0C1klcabZn4SZjTH8o/P38OUc9wXwJJ3t51aH8/PWvKUZysZQGa6?=
 =?us-ascii?Q?XKBsOP57l/77XdtBrLs32I8JTEKRtlQ2KbSHrIWhmgPgVOAYeDNcOIYJnMAZ?=
 =?us-ascii?Q?+yZtAt7Zvkgy84lpqiiRi2N/4JFjoqOAyXAc/m+5I9nKJ/Y3VxzlvJp+qrqc?=
 =?us-ascii?Q?2hOuo5uJmWgTrFqrUhiDQm3PcyFj/OKMJkvfQbSglAz14J0iXgPIA+jG+glC?=
 =?us-ascii?Q?pMiEhfM1dZ03X++PiWAzWbeyu1wC4nEoy3yCnsi3GsijTfMhCGNumSZbolfR?=
 =?us-ascii?Q?xxf71s5wOwe2DIZhsqvwLONqJ6awHIuCT3TXz8jGf4bnGgnOQioN+sjae/OJ?=
 =?us-ascii?Q?aH8fR9Vaoufff0tJa7yeb+3IL5t9wts/LDx51fj/deeDmCvNV99X7DC4Ho5P?=
 =?us-ascii?Q?RuehCBSWZIV4zUU2rDgc+27pk8JkPnAxQPtJVQREj3aS9bIz7pytPLYs9ULe?=
 =?us-ascii?Q?0kl1rsXXfK9qQmFXzhLDb5kbmt4YhpKiVZJbSHu0Vx14EivBamOY0Q6Di+9h?=
 =?us-ascii?Q?eFUIPpcFchM5F6Arj2ZB7S8A0ZncitO7nJMLQ1j3JimvWQETndl4e0gfu3r3?=
 =?us-ascii?Q?zApJRyYZd/jAb5DVwv4gjtI+vtgn4/0zKShd4xbHr5jaChbCJIVN+10soy2+?=
 =?us-ascii?Q?nzPGnvVCmtUwKiyJOIUFnbikEIGdSGtsMaMYJcdrEScLnqeQ7QSJL7dpHzRs?=
 =?us-ascii?Q?uzrJVAZIflQp8HjUxrxbtfvudF+VO+tlKceb7NU5olHQRESWwgAT2L5cUUeA?=
 =?us-ascii?Q?fnDscte/pjW1Mlz2L6yoEntVvRJ9mad7HmdVK/MbnkPJxSb7ZhtcLJMa6Hpx?=
 =?us-ascii?Q?NHkOsbaJcXvGAIrOaGX4ZFrZeeAIEbByhCNoOCaMkLoi1A+LK+2aYRBlYEor?=
 =?us-ascii?Q?SMJws46zgkNfxzcn/fu3KR2mfKRogd6zbWBMowEUYJCroEAvp+xoIQNw5ZIL?=
 =?us-ascii?Q?MEuIKezCiZl1pN9sY/+CikzTitpgIaJIxu/MZq9fcqUwi/IbvdWKeu0A5nVV?=
 =?us-ascii?Q?yt01/ZGulAU/9DmiShN9A8uKzz4ocJM9vLUppDR8lWaXTTCQR4uFMQwN3jNb?=
 =?us-ascii?Q?KMPEU8e0Lm718HTS/k12ogPX6ytXQ5d/R+SCJOLCW5EbrL+2OZQSoq/2q0rE?=
 =?us-ascii?Q?0HYSKZjF+MOpv44EvkDaW7wOPOj1oaKIK281ViEu8A+JlHSlnWJSyY0pKg4I?=
 =?us-ascii?Q?VMHfdetuj7+LgzXYSizLHzrwj0e3zusU8kFZD9ac6/hPACn/PIkRFPvyTtJ7?=
 =?us-ascii?Q?150FiL0mizIohVxo7Q9V/n0861ceU7B/b52dEsQCNjFzTs1h+PgqinSg/vDc?=
 =?us-ascii?Q?rl1yG76hxmBfSh2a3VZ+LnQtQZVi7CC+GtvVbbWPYkgBoB27FpifblMHa4bz?=
 =?us-ascii?Q?MeNTSjA3nTFMbL5HxxXiT90pT3ppvmCkLU5/65bJC7FC/R95kBRyOGEub8hN?=
 =?us-ascii?Q?MDdrNUWeVqnQfNklxskEHqNbbW6QM+p61rMhwajsczTbIS6yeb6ZPGGEfqPr?=
 =?us-ascii?Q?BiHXDPvpg+U9UbEBQKZgC7u4kvfnOTDbmF3xKONPipYSUqUI8JIKQ3bjVWPD?=
 =?us-ascii?Q?wrsu8ZvrieDmaQFpfstFaujZLWEwqT75/JZ2WHDVJk9+Rv1neme3McJr0aDE?=
 =?us-ascii?Q?E1ZZYcNNknl6kgsL95+ELRdxxS6CrHKn7ABO/QJxhXiDYjLb4VibRN09KIuU?=
 =?us-ascii?Q?NV9MmFa+8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e41911-c5a1-44f1-3f1c-08da3c95ce8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 08:25:33.9412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BE5mP+sEy7vCcPDiUihGcCiA3xcA2PipEHRK4QTGacbgBTmrS7m4Zcs1TNuMVwK8JJWqmKzaRD2lOM5cCt2ydw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, May 19, 2022 2:21 AM
>=20
> DMA mapping API is the de facto standard for in-kernel DMA. It operates
> on a per device/RID basis which is not PASID-aware.
>=20
> Some modern devices such as Intel Data Streaming Accelerator, PASID is
> required for certain work submissions. To allow such devices use DMA
> mapping API, we need the following functionalities:
> 1. Provide device a way to retrieve a PASID for work submission within
> the kernel
> 2. Enable the kernel PASID on the IOMMU for the device
> 3. Attach the kernel PASID to the device's default DMA domain, let it
> be IOVA or physical address in case of pass-through.
>=20
> This patch introduces a driver facing API that enables DMA API
> PASID usage. Once enabled, device drivers can continue to use DMA APIs as
> is. There is no difference in dma_handle between without PASID and with
> PASID.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/dma-iommu.c | 114
> ++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h |   3 +
>  2 files changed, 117 insertions(+)
>=20
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 1ca85d37eeab..6ad7ba619ef0 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -34,6 +34,8 @@ struct iommu_dma_msi_page {
>  	phys_addr_t		phys;
>  };
>=20
> +static DECLARE_IOASID_SET(iommu_dma_pasid);
> +
>  enum iommu_dma_cookie_type {
>  	IOMMU_DMA_IOVA_COOKIE,
>  	IOMMU_DMA_MSI_COOKIE,
> @@ -370,6 +372,118 @@ void iommu_put_dma_cookie(struct
> iommu_domain *domain)
>  	domain->iova_cookie =3D NULL;
>  }
>=20
> +/* Protect iommu_domain DMA PASID data */
> +static DEFINE_MUTEX(dma_pasid_lock);
> +/**
> + * iommu_attach_dma_pasid --Attach a PASID for in-kernel DMA. Use the
> device's
> + * DMA domain.
> + * @dev: Device to be enabled
> + * @pasid: The returned kernel PASID to be used for DMA
> + *
> + * DMA request with PASID will be mapped the same way as the legacy DMA.
> + * If the device is in pass-through, PASID will also pass-through. If th=
e
> + * device is in IOVA, the PASID will point to the same IOVA page table.
> + *
> + * @return err code or 0 on success
> + */
> +int iommu_attach_dma_pasid(struct device *dev, ioasid_t *pasid)

iommu_attach_dma_domain_pasid? 'dma_pasid' is too broad from
a API p.o.v.

> +{
> +	struct iommu_domain *dom;
> +	ioasid_t id, max;
> +	int ret =3D 0;
> +
> +	dom =3D iommu_get_domain_for_dev(dev);
> +	if (!dom || !dom->ops || !dom->ops->attach_dev_pasid)
> +		return -ENODEV;
> +
> +	/* Only support domain types that DMA API can be used */
> +	if (dom->type =3D=3D IOMMU_DOMAIN_UNMANAGED ||
> +	    dom->type =3D=3D IOMMU_DOMAIN_BLOCKED) {
> +		dev_warn(dev, "Invalid domain type %d", dom->type);
> +		return -EPERM;
> +	}

WARN_ON.

and probably we can just check whether domain is default domain here.

> +
> +	mutex_lock(&dma_pasid_lock);
> +	id =3D dom->dma_pasid;
> +	if (!id) {
> +		/*
> +		 * First device to use PASID in its DMA domain, allocate
> +		 * a single PASID per DMA domain is all we need, it is also
> +		 * good for performance when it comes down to IOTLB flush.
> +		 */
> +		max =3D 1U << dev->iommu->pasid_bits;
> +		if (!max) {
> +			ret =3D -EINVAL;
> +			goto done_unlock;
> +		}
> +
> +		id =3D ioasid_alloc(&iommu_dma_pasid, 1, max, dev);
> +		if (id =3D=3D INVALID_IOASID) {
> +			ret =3D -ENOMEM;
> +			goto done_unlock;
> +		}
> +
> +		dom->dma_pasid =3D id;
> +		atomic_set(&dom->dma_pasid_users, 1);

this is always accessed with lock held hence no need to be atomic.

> +	}
> +
> +	ret =3D iommu_attach_device_pasid(dom, dev, id);
> +	if (!ret) {
> +		*pasid =3D id;
> +		atomic_inc(&dom->dma_pasid_users);
> +		goto done_unlock;
> +	}
> +
> +	if (atomic_dec_and_test(&dom->dma_pasid_users)) {
> +		ioasid_free(id);
> +		dom->dma_pasid =3D 0;
> +	}
> +done_unlock:
> +	mutex_unlock(&dma_pasid_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(iommu_attach_dma_pasid);
> +
> +/**
> + * iommu_detach_dma_pasid --Disable in-kernel DMA request with PASID
> + * @dev:	Device's PASID DMA to be disabled
> + *
> + * It is the device driver's responsibility to ensure no more incoming D=
MA
> + * requests with the kernel PASID before calling this function. IOMMU dr=
iver
> + * ensures PASID cache, IOTLBs related to the kernel PASID are cleared a=
nd
> + * drained.
> + *
> + */
> +void iommu_detach_dma_pasid(struct device *dev)
> +{
> +	struct iommu_domain *dom;
> +	ioasid_t pasid;
> +
> +	dom =3D iommu_get_domain_for_dev(dev);
> +	if (WARN_ON(!dom || !dom->ops || !dom->ops->detach_dev_pasid))
> +		return;
> +
> +	/* Only support DMA API managed domain type */
> +	if (WARN_ON(dom->type =3D=3D IOMMU_DOMAIN_UNMANAGED ||
> +		    dom->type =3D=3D IOMMU_DOMAIN_BLOCKED))
> +		return;
> +
> +	mutex_lock(&dma_pasid_lock);
> +	pasid =3D iommu_get_pasid_from_domain(dev, dom);
> +	if (!pasid || pasid =3D=3D INVALID_IOASID) {
> +		dev_err(dev, "No valid DMA PASID attached\n");
> +		mutex_unlock(&dma_pasid_lock);
> +		return;
> +	}

here just use dom->dma_pasid and let iommu driver to figure out
underlying whether this device has been attached to the domain
with the said pasid.

> +	iommu_detach_device_pasid(dom, dev, pasid);
> +	if (atomic_dec_and_test(&dom->dma_pasid_users)) {
> +		ioasid_free(pasid);
> +		dom->dma_pasid =3D 0;
> +	}
> +	mutex_unlock(&dma_pasid_lock);
> +}
> +EXPORT_SYMBOL(iommu_detach_dma_pasid);
> +
>  /**
>   * iommu_dma_get_resv_regions - Reserved region driver helper
>   * @dev: Device from iommu_get_resv_regions()
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 24607dc3c2ac..538650b9cb75 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -18,6 +18,9 @@ int iommu_get_dma_cookie(struct iommu_domain
> *domain);
>  int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t
> base);
>  void iommu_put_dma_cookie(struct iommu_domain *domain);
>=20
> +int iommu_attach_dma_pasid(struct device *dev, ioasid_t *pasid);
> +void iommu_detach_dma_pasid(struct device *dev);
> +
>  /* Setup call for arch DMA mapping code */
>  void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64
> dma_limit);
>  int iommu_dma_init_fq(struct iommu_domain *domain);
> --
> 2.25.1

