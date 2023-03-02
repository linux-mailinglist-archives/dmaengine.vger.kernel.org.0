Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCB56A7E7E
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 10:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCBJrK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 04:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCBJrG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 04:47:06 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C4D3B3F2;
        Thu,  2 Mar 2023 01:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677750423; x=1709286423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NuFy1cXlCloJ0l6uhGxIyqsBEtqmxhiKXGuilVdaS74=;
  b=nkqdFJ23p6e4DtAcpyIr16d9hQVmzu4DIIjkHL5VLeOeb35a9n9NnSBe
   b6Ii2bSl5TF/hzuU1hrSFueUlemYDEgyE7uTvdqJLjoQt8RYV4cjnEb2J
   L0yiAvNdcGkav64ql21CIQz5+UNum8Vgc0/EQMUnM9/WRdExJDzwwUSQ6
   8Cj4ntbZ3BaXPP4+IWfDteJzjT9ZaixjwMemfpc5CLbvsiyxgGDJE1Wgo
   ilpH9Xq8UCIEAhqakKtFLsNkqOf+apZom5fZXLALQNfii400VYL/qARMw
   x+GkRXJKOAIedk4bQfng0WK2MclMWQeBUTB7csc3bFU0x/sPzzLht7o1/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336974155"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="336974155"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 01:47:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="849015389"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="849015389"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2023 01:47:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 01:47:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 01:47:02 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 01:47:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWSRHQ/zZnYsVoXEjD+zF4lrc6PTw6Js1W89bEYpj8W21Pu2Sf2j4kydqcB8m3bahJYqb9mFhYL+FTtUosVNCUR9e0r3Ze4cx9e9UtHrXA7uAtT/r/c//rymfJLe5FmxMXZaICWiFKZLh5WcU2VZS5pIFz/fC5OGdGu6o2BpwF20qWT36UJGvDQkEH6DIfxECy4ydwVdgHIpgIuIdiaN2pgpb9eLPki7tYRVGO3AQGnIIboz/7MT9ix3vwV/QefBBtMrDC2+FrPogGI7DxnZU9n+6l+wOYzWwMyOVApxZjL0mldqEzD5hR02R6sLKYk0UcAN4uSuOZfkOIX2D4O1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sguzKSS5NaZdkwfEPaGixtl6a3j8tH2kFmkVtcGG6k=;
 b=ADzzxlxPLfHGNZ7EUZwSkVYyR0aVYFjYNFGxFIdVPpvodiF3jQPONg/9rR2nfdssHQXJ3rPetrKQyJZU7NAURYDuoUjPHT9/KjTazjHBYawqy69GDxxl8mu/CXy2chE6/10Rd4H25iN+dHxESgVMny4dR1vDM0XiFr4OWFMujbni5PaFnvvTiynbW4CsFQ3K694qGVe7EBa/s+Kg4jMnD8RTh/LyZr491a1mHm9PYKsiTQtky2BiKUpA084bAudZkWWgxPDfSr4XojVVHmo0kA213lo1zU/f4kW4LjjJAL9Io13WWd1PKt6LIxmpKeQ4cRF6WiBo6qUhb5MoTEK7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 09:47:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 09:47:00 +0000
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
Subject: RE: [PATCH 4/4] dmaengine/idxd: Re-enable kernel workqueue under DMA
 API
Thread-Topic: [PATCH 4/4] dmaengine/idxd: Re-enable kernel workqueue under DMA
 API
Thread-Index: AQHZTKHOo4YPoAQWLUCnTr67pExMoq7nPYdg
Date:   Thu, 2 Mar 2023 09:47:00 +0000
Message-ID: <BN9PR11MB527624EDB9FCD26751C73B128CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7449:EE_
x-ms-office365-filtering-correlation-id: 8a098698-dca0-442c-b75c-08db1b0311df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVD/g7LcPK5qhe4wBGab/UjHvE78FRBVZnlM7AfM5cMkX5tu0xY017WpTnKiNJM4Ah1+5PImQCXVWzKnAtHga0hIoYZUzv5DIoIBNTbfQ9OPql81HF+AXunw7gE4C2yshI2/As0MC7F5dZwWeX3aNuXihzHLduZEpUC71wXidRn8fHNlnICAWiEzTH+u6sZpTgthTR1QexhGnVI1ks10v+QBoRBXib/FpgM1rdinCsUMdOSZIS/wHUN00gS8aBDQZQecm5/GAMGng5IEMDkRRdtvb//tAnIfS2wIYE3h83J7hOG8+Y4LWrqEFiHCXuNWKSZObIX3lcgp62fTGDFXqafNnrA+PoYI8hylGpArhksrP8zcKbb7VbVA8KUrsOwrwrFFD/F9JKqypz+D/hoz/xOOHusVXOrpU3wMD0FekFR75CNPKUF9rfFATCohAR/E1jApYOTlWJRgogcnIbBpzyrlEDNi6MqJQwW3LRTkKUbgaKZB0I66zRgwPmrX+6BZ7nknu5C3H16KmqgMIxsPLNtpTnSn7cpCZKqx5r35xME9pdzkhWvI4D9frWoZEQgy/SzaUW2o/DkERh0nX+QzkfbHBCi7vL3Neyt+DqTJfOQvNYlk0LqpUaUYEx5NI4zqMztBC8B59O0n+ZnZiv8HpseykqtfIEHmPGWJhiOV91SveD51WT56MZdL19UA0q8E73BniC4oPCMUu6TuMAwf/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199018)(86362001)(8936002)(33656002)(66946007)(8676002)(55016003)(66476007)(41300700001)(4326008)(64756008)(7416002)(66556008)(66446008)(5660300002)(2906002)(82960400001)(38070700005)(122000001)(38100700002)(71200400001)(7696005)(52536014)(478600001)(54906003)(316002)(76116006)(9686003)(83380400001)(110136005)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oXV37KzpLG+8kXSXvZZk7noSoallANI0mMNBbHnLdy9sKL+rSRmorA9ILSfg?=
 =?us-ascii?Q?baKhTz3wTpr1980mgLcRKOx2CWq7hlPFH8LqG3kPOU++bVHX/yTMjyZ0DI/+?=
 =?us-ascii?Q?RxEY2NUEUtG9tl0da3B081Y2LYpLVQelGdAIVbFJ4EpqwZseGuvUI2s7cV7w?=
 =?us-ascii?Q?fEdRDvaGxsP+LdHpr1PojmEMtvANQTBDv5RRR72w4N+5SGZcBpvcLTLVdGOY?=
 =?us-ascii?Q?wO874GWlgYa14Dq7AC6VCk4c4P2Msbra0npjJq5b4PfRAGX3xwOLRLPiy6eE?=
 =?us-ascii?Q?NuGIpiCDhCEA6FyNn53YJVCtCls/FK9cK7pTtD5f17UXxoAfKJKlQqa+POWd?=
 =?us-ascii?Q?0svBl5OMZh8dT4QI0DltjFLXY+gUME2/rzqjP9ptd+GSRF3rTR2HYgrRRhaq?=
 =?us-ascii?Q?qTTCKcnrRYhwboRmfPipovFIEsaU9DXB14ec/Zga7kTl/Pjf1vJeg9e78P0B?=
 =?us-ascii?Q?0/S3OREti8sB0Ky2JnvwwtN8OP9QclenETRXHtlygTxEj8a5JdGtCvbIHVJH?=
 =?us-ascii?Q?9SWl2Z81E/3i4wdHwC/vDgsWo0496xrQrlY6vunQ0F/amJUtwCWhXMgqTQ2C?=
 =?us-ascii?Q?3iP6okxY/Xra9qJ8HWEoIffa6lO9c9YRBTcnyHtEUPsUeJ3qRuhUNWLhFjtB?=
 =?us-ascii?Q?KdjZjFRAIOpn7Een7Qu+D/Fz7pRLn1aeJtzlrp5UxXFLbQfc8Jd9MaxyyApi?=
 =?us-ascii?Q?MR4A9EPFlcgeE3hJWe0ekUrjkAc+1VRNHPb9JnRjKfPIhz+sTO+bJRnxsN/z?=
 =?us-ascii?Q?ervUO3wRUokihTWb/9cAe6dmo4Qq+1RK7oqzWcNA18MxnVUIHr1MVY44M7vJ?=
 =?us-ascii?Q?PTnjkmGAbwmgx2cuaNouGWtLiuxXivKZI52XB2q7Wa1fAK8yTOUHqF27ziwH?=
 =?us-ascii?Q?w9DvOk5V8J2D6EKgWmhVr/C0HUfvsijgdZPvDlY8zZjBXqcMr+m97lCITMJh?=
 =?us-ascii?Q?xZVPGxGaRYrRYawQDplcPlhQ8t802rBQRIm+QD76DiKcY+Vuu/liSPtKIWrR?=
 =?us-ascii?Q?ixF1cXKaBpUtaWCbxLg9GpSY930bbIQIVYgCQIj4b06Riear0yqe8A5qyp9Z?=
 =?us-ascii?Q?GjFU6WsYNHYPbsk/hJ1MDgsnZ1+7wv5hwCBS/kKj3icfsbEF207poy3ewg3a?=
 =?us-ascii?Q?WR0KZcmJJC4n8o3aLa4BTeXylCiZg6nV31eMDydUIaG1LdQ29chGwSzgmcPj?=
 =?us-ascii?Q?8WmklpMnHXJsUAKxsSLTYx6wcBb8W1iTB3mDCtkbt7y05bU67Wi91R2/DBty?=
 =?us-ascii?Q?Xjabph9/r0n7wkG1gc0Dpqi4aONtTviCg5wgMOBADo8E0bc7RFXJrYAm6AHM?=
 =?us-ascii?Q?WBYLQMabBflcKZxTssoWUvxQexPDQd3DkSMCrmQHlgTvMPW4WCtGm/tVZ/+9?=
 =?us-ascii?Q?L0MbhCTJ9hf8GNWxq9KRkoYdvRpNvDFQNFj3z1FucevuigS59TVWemyaoGYh?=
 =?us-ascii?Q?qWnPeztzLDWxPkjU6wGg+MFHoSFZYGahO/Xqml6TN6Jrdudoz82RH9Zhb+AE?=
 =?us-ascii?Q?8usaGBGgbtZzeFQygBswXGE/8Qvr4QCY7+1JL8KbP4YilchecKUwKDbG8Qsf?=
 =?us-ascii?Q?/JPiiOb8JAqbA2scDGZ5DBGs8I4ydHYPxg5CFyuU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a098698-dca0-442c-b75c-08db1b0311df
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 09:47:00.1314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7gkzNDzBdjLt1+fOZoACTKF1ZCcUFcJTgkee9PLSR45fEx6JEtz9+iiakTl0CRD7iWQ+GvBWkGaOCN7cx1Jjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, March 2, 2023 9:00 AM
>=20
>  static int idxd_enable_system_pasid(struct idxd_device *idxd)
>  {
> -	return -EOPNOTSUPP;
> +	struct pci_dev *pdev =3D idxd->pdev;
> +	struct device *dev =3D &pdev->dev;
> +	struct iommu_domain *domain;
> +	union gencfg_reg gencfg;
> +	ioasid_t pasid;
> +	int ret;
> +
> +	domain =3D iommu_get_domain_for_dev(dev);
> +	if (!domain || domain->type =3D=3D IOMMU_DOMAIN_BLOCKED)
> +		return -EPERM;

what about UNMANAGED?

> +
> +	pasid =3D iommu_sva_reserve_pasid(1, dev->iommu->max_pasids);
> +	if (pasid =3D=3D IOMMU_PASID_INVALID)
> +		return -ENOSPC;

as commented in last patch we can just pass a device pointer to a
general allocation interface.

> +
> +	ret =3D iommu_attach_device_pasid(domain, dev, pasid);
> +	if (ret) {
> +		dev_err(dev, "failed to attach device pasid %d, domain
> type %d",
> +			pasid, domain->type);
> +		iommu_sva_unreserve_pasid(pasid);
> +		return ret;
> +	}
> +
> +	/* Since we set user privilege for kernel DMA, enable completion IRQ
> */
> +	gencfg.bits =3D ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
> +	gencfg.user_int_en =3D 1;
> +	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
> +	idxd->pasid =3D pasid;

Why does user privilege requires a completion interrupt?

Or instead it's more due to doing kernel DMA itself then we certainly
don't want to poll in the kernel?
