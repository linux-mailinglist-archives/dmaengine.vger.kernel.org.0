Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E0D6DD4BD
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 10:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjDKIE2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Apr 2023 04:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjDKIEU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Apr 2023 04:04:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E69935BB;
        Tue, 11 Apr 2023 01:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681200256; x=1712736256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eo+T9VIPQ0xIrfFDT+kBcizBOIiX1tSZYP1xrcC9nBQ=;
  b=aIf46HRXOA62u4qNAOTljFrYxac+jS1jRD4cx7olYjSpLNLGPQHE+7/r
   pu/ord/zyCR0q0bAPXn/81+I1/9/XDymfSvq1p0LR6zxGC3pO/KSsCA5A
   sUTdVUiZVvnUb1Oc1MVfqJZpkeCYmJN1PlwqxUUNJzLSncrmhNUjQH1cN
   mcuJOF7LoUt1ahWcc75yhP/0fX8dGkPJ0V7IlSm+UywDgk1C0u5K7d36r
   mHPfv5EvlHa7Xm8Y25gu093WjHpr4i0mfBRfh8yQT1Y/xFBpnjIUU/YDi
   tq6ph6Km7+UeYtve10p5NsGA6Dk08hzM4AJH26K9GRLJXcN+idFunAjOe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="323915008"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="323915008"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 01:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018281172"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018281172"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 11 Apr 2023 01:03:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 01:03:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 01:03:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 01:03:36 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 01:02:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsNyf1Hi5vqJ6dfZAkrtq8L2HUpFejvUpp5naV/0wCNmA63wu/AEVGdhry1D2ldG/8ih7R+3L4xk+RUvqEyqLl6soXxqrN3SfndX9vALn2b6JzRvxA2TVheVQFRfy9H5aMdpTfYM+NIg2TRi0TOgE/iuINklteL92bORheu0vcF/b3WwQL49eNhwi+8nu+rI0sDcrXBso2CeA2sG8pfwa0RFn8xxaATWIlsI2WT95WfbnXeKyeWNeTloRdU64c9tmdBSVUOalQxxYQSmic/12sA1SGWllheJ+QiLx46DLCpiVEZbedWjOkCH+ORRwUA0KH6ldCcXeKdRytJBPk5i6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfPTQhfbp3gTKSlX30ZV7BUaW4C9IAn0n8kyjuLKGa4=;
 b=OyH7s6YLWwZWcGdlDSDKFey0GF9f/XlsMZ1J5JAz6DWroTMI3UjiPlNI1qGfUwkZrPWWkeeHJKjPyoMxzsX/0slAB3y5cJEM6ZJOMdelOUIwqR7K7lt6ZrLwNE1+Q8a/LE6UC03itp7bDMXJvbQTMVStPciVqvUZR/ygjJwwM2oDbnLiK9gnxOHOUyWhl6TL6VqdoT7huJ8TcZiUFNQTZQJiO3Kuxtg8QmVETi+z5NdgQ8Enk/YiRVBQ6DAWidhifego9Il8Fa0zrj4/ZM5A2exwC6rvD6SoJRbeK5F2kFA3KLEB0M1e0ivv4SDc/UDQ1FTOAFoICVQ75XnlsBxRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5915.namprd11.prod.outlook.com (2603:10b6:510:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 08:02:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 08:02:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [PATCH v4 3/7] iommu: Support allocation of global PASIDs outside
 SVA
Thread-Topic: [PATCH v4 3/7] iommu: Support allocation of global PASIDs
 outside SVA
Thread-Index: AQHZaXsLtMsZXOkKfUCVQhgiFuDaKa8lvRiA
Date:   Tue, 11 Apr 2023 08:02:55 +0000
Message-ID: <BN9PR11MB5276D09F18BA65AD074777948C9A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
 <20230407180554.2784285-4-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230407180554.2784285-4-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5915:EE_
x-ms-office365-filtering-correlation-id: 85e2f203-e24e-42b4-ba1f-08db3a632851
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /llb4TB2MNqpwX0jtAalHYq3m1Ab3kUMKuceWYIM24DdsTp6K9sVeElWKyM5CNZKK72CcBDH3CpmcaKv11IY9dp3yCr0v7gk0rJ5IOGpBEM5W6XcNpquPRKX4qGICuJabF0Rki5QG718dOrSX0gLxu0JHMrtes2SOu14eP1ahaRJPuWteoqCSJGTxXLoJOYXMRU9Yzt4puDEWvQUUa1DJ3KrNwrsy2fxEeSOu+OgHerbubsY5cd3MZIsGLy60+mnFMxUFYbjmbVfxYJ9emYQ6LXAKhX7ocWvR3dL/OT/g3jCk6mTzeQFGAp3PVtM4+n3wPTqP4e0Inxo0hf/uWesmCBaw2dTNy/nOAWxQSByZvjwvlNbACTUzn9fbweCVJXnsmxkwgonkQz1g46ukp88TzOpnouOFLIzvj72Nu11GgeEgpJlj4LHKFZIZkhGan5949zKpDGr5rPlsE1LcRMIZGl0z21rymeRDhfzSSZ0vo8z8eNc/EOI5zuHIjuFVRFnLUSIV0xTttMVxN34P03G2XdWYKXXPpQaYBm3rvEtksqk5Z5JxdWiv/EbSyhBGOlXiGIWll59381dkyIykylR9wbRaJAeItyNxT2D7uOtL78hzUOiU4BdIgYhvs2jipFj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(41300700001)(9686003)(33656002)(6506007)(2906002)(478600001)(110136005)(55016003)(316002)(26005)(54906003)(186003)(7696005)(71200400001)(86362001)(82960400001)(66476007)(38070700005)(38100700002)(4326008)(8676002)(122000001)(64756008)(76116006)(66556008)(66446008)(66946007)(4744005)(8936002)(7416002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oI/D6F9N9n04cXCgNQojL1e/TaFgJruVIcS98zj/F5/rzJQayoI84qtzs6zU?=
 =?us-ascii?Q?gpitSXuNvPbAARzr5ZW95dqNY2wfhoc/3Wqw3sL6yf8js38dDYw9n7EmCz9b?=
 =?us-ascii?Q?gmwH1Idgm0nElUY1xs0RnJOz2tVzf9cbZvr8XOA3eTdZLJ7RYDmpAiDPrK7o?=
 =?us-ascii?Q?hAVWHnWVXq7pO/XG/kVY+GKoNkIy8UsNv7Wf/YxgZZf3WhvNT2hyb1ljL/G8?=
 =?us-ascii?Q?OvLc0wPqZUTxT4n7q60/zmystbMkdark0Ep6yk5kVLNPgMTfVqx+NhZl3aM5?=
 =?us-ascii?Q?Dztfs9nHO6nBbuRm8VCfuGEMYk7uHUeGZ7qys1dPz8mNDdriZG3NAfdq1AiI?=
 =?us-ascii?Q?QNaBG0wFk4MBUgPGynP5fY7/gsQGjVsvltrE2jtniSzuG0yBaoED6+YdAKvG?=
 =?us-ascii?Q?Zjk4wkXOO9xD2aZidHc8zK8sVyMMH5k8xF+opayXVdpneg/gE08ziZRMaOMl?=
 =?us-ascii?Q?9ENppg2YslWQJLT2/P2ormgfVDIHN6of/cJoiopHGrTnLcgS737WuinVPcSS?=
 =?us-ascii?Q?fq0NDpamDF8ef8DHcIbZxnYSJPJ6kPceuN/1IixoomOKsnFWFgwf4FHRxN1t?=
 =?us-ascii?Q?RbsMsHBWOguiQcqd3UraDbYEOnicCdMxe3SxYpKxPTj7p/qL+aaMiP536giL?=
 =?us-ascii?Q?/QyEwV48BbvNmvEw856CqAdtbxR6mkMH7w7ZEW/uCiM4Cif9t+AjBPTRzzca?=
 =?us-ascii?Q?h2OLfpO76QmB89aSWB6uZXjvMxiFUNii9eGuiTC/BIyc9u5P2s6u3x7XJCFx?=
 =?us-ascii?Q?99yYPXru2DEeLfhbr6S/qvWFAoZyfNMk2q0fLXk+rqKuiYokgVDeKQNAvwEH?=
 =?us-ascii?Q?1GSc2aL+p8imJ3ynZIsIh9LDbTJ2XAa2hSEkZYQ4ND7jiRCwQaJmoSB7ZMCh?=
 =?us-ascii?Q?0QQkUKMkmYjnyOu6361hdydaG12Pajhi9Fz1OLT3l7C1hlijWxKoPkpp4q1z?=
 =?us-ascii?Q?cZ89BxvhfXDGpUY02qtT64NrX55izydi545wuo2xE6ZHy1EdGDpSalpL5O++?=
 =?us-ascii?Q?QfMwBgSbI+gZ3hjcXYfFsBQX4ExDNIdQk/wqV8Y6q2tKwOhvD+xrwR9ukwjS?=
 =?us-ascii?Q?K7Vp+3d5UJ2/uRsjg32QrocWbyWJ0dTAb6m1hCT3PDIwI5j4C+6+dCBHS1ZS?=
 =?us-ascii?Q?wKBqmeYupOpeXZCuzlhVq9Uy5rvKrYsN9FkLNRkdTv/Fv3X2Z6R1l+eEdEC2?=
 =?us-ascii?Q?29WEwB2FLzBPFYwZ/90HCxazSkqJliRiwN4M+i2/Ud0z3Xj3WxjKpXk+POn1?=
 =?us-ascii?Q?SvVtApDzTQx+j3kzqAP31D9zU3p8ZzkcSnwA3iP+9x/QvU1iw7/7KFg3IaGw?=
 =?us-ascii?Q?7VyaJ2+QUVHTBHJxIS2X/MkL7OhtpZIWJIWeYzMoYzbq++3nQp72lSd+F/JA?=
 =?us-ascii?Q?pY+nSE5N+Qb5y5/egIGvCaLrwzb/rp1aU+rtO6zferRFmgoJg6QSn3+bPN8C?=
 =?us-ascii?Q?c3wH/ihqefNP8r6c94cHuCb9E1ucdVYBfMwOtRzzHQsAjhlZkheGCbmfyFVT?=
 =?us-ascii?Q?yPqNEhZqq73IOiQJKEB8iKkxKbqBsREXtwXiTddc9icoykQClyNYRGl3ZsRD?=
 =?us-ascii?Q?HXe+EcRASw+AHonAy39b7ASXSAifmAiawY0lq1a9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e2f203-e24e-42b4-ba1f-08db3a632851
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 08:02:55.5568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: id1bsiS7PH8P9+a2T0mHL6/v+B9lZppF1zVVKlaq3VMDf6x4VV7lowTcaQOOb0vK0Ki51ynwyi319wnNv9fn8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5915
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
> Sent: Saturday, April 8, 2023 2:06 AM
> @@ -28,8 +26,8 @@ static int iommu_sva_alloc_pasid(struct mm_struct
> *mm, ioasid_t min, ioasid_t ma
>  		goto out;
>  	}
>=20
> -	ret =3D ida_alloc_range(&iommu_global_pasid_ida, min, max,
> GFP_KERNEL);
> -	if (ret < min)
> +	ret =3D iommu_alloc_global_pasid(min, max);

I wonder whether this can take a device pointer so dev->iommu->max_pasids
is enforced inside the alloc function.

and do we even need the min/max parameters? With special pasids reserved
then what driver needs is just to get a free pasid from the global space wi=
thin
dev->iommu->max_pasids constraint...

iommu_sva_alloc_pasid() can be reworked to avoid min/max by taking a=20
device pointer too.
