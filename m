Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF25C7105AD
	for <lists+dmaengine@lfdr.de>; Thu, 25 May 2023 08:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjEYG1x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 May 2023 02:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjEYG1w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 May 2023 02:27:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDC7187;
        Wed, 24 May 2023 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684996071; x=1716532071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+mtq0z6sl/ZViRgAmc0+SXz2dtgqXN4LOWfPtloCazg=;
  b=EQn26Hn3URuFOYQfmDWV7Ujg2NGZ380ouU9xCjSk5HXaXg9/we8ie/Iq
   3VYmmnMAM5Ai/cEaKgxSUnkYZwPx+WRFU9jEq1uiUjurLxZ0fAG7IHEKS
   0sQ8bP1Ne6bPYWxTtaixyZ8qF6ykIwJLFfUYIlAE7oTiJD6xHOuB1GWQ+
   13TFjDfLn7vOn6Mytn/T14VutQZFEPRv+zt+TF9Q4Bl99mzu5jAwIdddh
   zjJgQI2RKhcj8chLfmfSRdd+VDoORMQlM73MW4q03PiFX2X1bO1XwXo8p
   TLsvkP4CscUxQ/tYA7Qjse2JnBcv8PchoSya8I6MQCllPFuSZYEMjUv3T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="382045504"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="382045504"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 23:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="1034851631"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="1034851631"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 24 May 2023 23:27:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 23:27:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 23:27:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 23:27:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 23:27:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J75Qwlz7Ampfgd0qBbaLPxzI6wBbzCyv+KM//TNfrB35AI6WD10DPYjXy4nipdI0pc4nJMKGSemK17wKhBZLhMmVCI2WJXMxsjzWDzG7n8tp3ZGLFNJS03S1jUDnKX04Cud8LvQ9AjjIJAqfwLVVvkForc9Efd0mhxbNJZlU7LgYpLhrIpliJw4GPs1Wf9nsRZWBSMXQJO+NApd/3fKbEv4NBqzuwHpbUC7Qk5bLoPvaF+pg9UmmRdpbgzYs6YFa2ZbEUTElV86UusHG+uFk4vPL+QrQDuAM2VEh2TCRTqXJiESNt4ZcglJQHsQJI49dIqfK2YYHdCnLPjLedE8JdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tomI3m8PGq1tFzrepQdnxtm1HwRLpY1hOQoZ5mSxSKw=;
 b=QQvF9xL+fCJwgERGgaoSSlgsE7r4NPghTfOaiGXcxX802WmmetrCJCiKKYN8kmObZhSNAH3LZg28bRWIzzl6A+qpSEDnA4yHChmz30KSapwwv7n7xnR5ypqEhlAhawqDmeU3bkKBKjkpxZv5YUQM4rbueSrzammIhV57J5MaCOpnl2rspmPToZbzgV4VHYSKDyacHsjoqFSwvOWsrQUD4/ErRKxBHc4U0qiPCs/vC88N5LxbUS4N9Wg0TxF1+7vj74K98kVToA5EbSX9B103DHK20xlF40XNKyqOepj9wwKIbowA/NPJAzzIpNKY0A4q7cpgAgj8f8I/wfo6FFJWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5520.namprd11.prod.outlook.com (2603:10b6:5:39f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 06:27:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 06:27:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Ranganathan, Narayan" <narayan.ranganathan@intel.com>
Subject: RE: [PATCH v7 2/4] iommu: Move global PASID allocation from SVA to
 core
Thread-Topic: [PATCH v7 2/4] iommu: Move global PASID allocation from SVA to
 core
Thread-Index: AQHZjZxI9J7I1OJPuUGsmbdFIDhk/q9qiCNQ
Date:   Thu, 25 May 2023 06:27:40 +0000
Message-ID: <BN9PR11MB5276F7D03C5595F03A9A14858C469@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
 <20230523173451.2932113-3-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230523173451.2932113-3-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB5520:EE_
x-ms-office365-filtering-correlation-id: 4638e807-cd85-4241-4659-08db5ce92409
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KlSxxFBUJvPxvb3nzfH/TGBHlFF2WMHFOtH1NcRtf9RNbwKppkLUG6ZgzUUUmF26SQ+ILb504mt4Anv2xoIrU3nuatphraMf+ayIpZqnJcU8pm32ndJc9hHDBKVQnqCdzwogbfjp7Fs2bmCNRURUnTsKuovXU6ctQLkr9TXqdAcjrP4Rop45XE3YWFPUm1sPHqrsY3DnG4FRsmZ67gfEFl1NqE9j3j96auMnLd/64oBEUBpSp+3e8saE4NjtMxLUotU/wk0eNPGGGTZZ0N/3m2R0NuYqHfnxi3HcqXcl25ao4zkzJO7LsgU/3iAB0Er2nxIKoDo6NELShBa/uli4UQK1BG4PRQkbxa/ohwk534FKS2rQegtL2zHZJucPenLtu50GNnYzaWjkG0bXK0mf3vvSTuf0uwFlvTNzYdogZaL8NzgOEVjinPez/3ERAjzArW+j23uKRTkkcj6jfkVgVjHlP4bvGMjAb26YqUTqkSMFHYgF35knkW7mJ5ebekYdmKGARmF4VEeK/UFScraNSurhro574N/3b8kHMH0thO6qyBfl5m66gpHkbJ0U3zObKtEw3Ru/W06GL1jo0WVZSQpTQVi9mJiiK1a+a6ftDLS5ZwRVPlmDkfaBtYbC2q0apLyc8r7hlGMe/l51YyPt6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(54906003)(110136005)(33656002)(2906002)(52536014)(5660300002)(7416002)(8676002)(41300700001)(66946007)(4326008)(66476007)(66446008)(55016003)(66556008)(64756008)(7696005)(76116006)(478600001)(71200400001)(316002)(8936002)(6506007)(26005)(86362001)(82960400001)(9686003)(921005)(122000001)(186003)(38100700002)(83380400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ypGpL+FS0LuzdsxGkhiHkj/1DQKzamOIqZtrMJbZEWXXXVsSz4iY4jPOHwDN?=
 =?us-ascii?Q?rqEGJeEXPUTLp6iX31XE8C+M0LtOHrxPmizLq0Nhh9uLtO9fZdQXioUx8fRt?=
 =?us-ascii?Q?BS0Rc7ndkgp4M+IM7Y5Op5t4wha0DgxGXBjyB2Xj2PIJYqgdWxJ0gBgMkAXT?=
 =?us-ascii?Q?GdOfi2SUg2mM0j7pvs8MmUcdedx9+YtqcNPBYtQRoSNA6Ia+Ei3RwbqW2+kr?=
 =?us-ascii?Q?dRxRVfRkETJhTf2RoWLDFqC0pz03wLf/cVCmMICnngJ07kpeCWH6K7m/1+Op?=
 =?us-ascii?Q?VhaoyjQr/t0AwAOrOYuhCElpjxlBkW+aVSNgfesmV01ZGHDmVIy8YxluoD9M?=
 =?us-ascii?Q?p6U0o+435aIqV2cMgn9h1G2+1ww5G2XtqECEumfQsQ/rgYQtLzVZIFJ5ZHvF?=
 =?us-ascii?Q?Sb3yXDofrOXEfsw535HBmxQkRhgUGko55VUEtVR9sfWWCmwR5QcfuB2CqgpK?=
 =?us-ascii?Q?DO4i547WCJuYicJuLb3STuir4erwJezYSOh4Bo70rfCP3T09pZvGlwLaLryF?=
 =?us-ascii?Q?Pbk6uxPKhXLF/XNs3gmITi8L6QZU+o9qtJh4GSxFkC0bjdSWrARPNRao5nts?=
 =?us-ascii?Q?sMgO2d1MT68aTtWRMm46aRreCxICCIP/WCPKrSvQkbqQyXzb7K6ZDDmO7vXq?=
 =?us-ascii?Q?336d+gkqzZfeCT1/MdkU0bQvQZmBeBiXqgb81PDKCZU9kQPN7cdVWFInSu9A?=
 =?us-ascii?Q?1s8WTuGcn/mJKr6jca03k8KJR4K8ZEzBNGfeNnFGn2wUlryFlhaCJrcmEtlt?=
 =?us-ascii?Q?LuO+GGjNeGY0LuLXkh/fBRBhidG3DxBcqu/FRfITLJjXgPQXqmrO00qv8y4w?=
 =?us-ascii?Q?7rKZS/7Z/raGTmys5CGmS/yzsTMJKnWLqY6VZ9p9LKzPdG/rBPZw0k6b76PP?=
 =?us-ascii?Q?Fib7S0+b87xPsaXgoeXOnNT9KQNwcHIVgDX6Qgm552XrGZb4t7pT7A/DFTeO?=
 =?us-ascii?Q?SzgqeKyl16ijuAXN+QK5qZrN67Er2eLeMPFjkF2Mda3VaGgMbxl4JpKRDbfc?=
 =?us-ascii?Q?iT/9F0uzp0E7XOQeLdO1LOmrpfpDT8QqelUki+lCv0IOn9IiC1/Wp+2nqk2O?=
 =?us-ascii?Q?1YUf3u+/ceUiUa4WwcJMmRcK0pzxplJDPZf5ZDBqK7kfav2f41gP/zg02tz1?=
 =?us-ascii?Q?ad2O6wSZU3brcGBCSlwYQrP0tzA9JeqXwGN/djvkjUqRhTLAxjrgnC3MfyGw?=
 =?us-ascii?Q?ElFuX/pRwUC8olWuTADjBXwQJxWssd+AZ4oAVxvmyBAePYU/TGtqYgCB3BTw?=
 =?us-ascii?Q?Js7RNHsGpjjXQfv7OQWwXLDECuWQHrqZjDUh1WqEH5ZuNGFzU4bua0oGH3gf?=
 =?us-ascii?Q?t0aD6Xbrl7O7hRSuj1qqoyK5iiIRs9vK/N2nS+15J2F3LkBO/3Px5Qy4chnv?=
 =?us-ascii?Q?4wkIwkTf1GAecd3P1+YrUvW9Q6QQvnxO8B6zoJPdA3fvZ3wUSPQ0MBRvJCyJ?=
 =?us-ascii?Q?vre0qJsNZUumZkzoW7VwOb1fv3AwGOUVkkDYc8ejxD6gcm9wgNB5tJEMnvKN?=
 =?us-ascii?Q?YH1jXVoH+0SQWEbAS6zy4vp7L5nHEXD7uj/PpbleRj6NhxIupUODk4KoDScf?=
 =?us-ascii?Q?nXMyJ8MBqQxvJhL5JmrEszmwDu2iLb/Ny3sLfiUT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4638e807-cd85-4241-4659-08db5ce92409
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 06:27:40.4464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klzl5FcftKPOEUNgN+k1pr0xbGSZl/OvS9S1Uiw8cIky40UQl+Hmc7crh0bSe25fNbA5hEXedQ5yFNZMah6TAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Wednesday, May 24, 2023 1:35 AM
>=20
>  /* Allocate a PASID for the mm within range (inclusive) */
> -static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min,
> ioasid_t max)
> +static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *de=
v)
>  {
> +	ioasid_t pasid;
>  	int ret =3D 0;
>=20
> -	if (min =3D=3D IOMMU_PASID_INVALID ||
> -	    max =3D=3D IOMMU_PASID_INVALID ||
> -	    min =3D=3D 0 || max < min)
> -		return -EINVAL;
> -
>  	if (!arch_pgtable_dma_compat(mm))
>  		return -EBUSY;
>=20
>  	mutex_lock(&iommu_sva_lock);
>  	/* Is a PASID already associated with this mm? */
>  	if (mm_valid_pasid(mm)) {
> -		if (mm->pasid < min || mm->pasid > max)
> +		if (mm->pasid > dev->iommu->max_pasids)

">" should be ">=3D"

> +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> +{
> +	int ret;
> +	ioasid_t max;
> +
> +	max =3D dev->iommu->max_pasids;
> +	ret =3D ida_alloc_range(&iommu_global_pasid_ida,
> IOMMU_FIRST_GLOBAL_PASID, max, GFP_KERNEL);

max is inclusive. Here should minus one.

otherwise looks good to me,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
