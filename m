Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B41C6BC690
	for <lists+dmaengine@lfdr.de>; Thu, 16 Mar 2023 08:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjCPHKV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 03:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCPHKR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 03:10:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1586AF2BB;
        Thu, 16 Mar 2023 00:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678950579; x=1710486579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0oPQA3o2yLn7e0UbEqQMePv4FmoGdq+a9cQQbC9urGU=;
  b=j+4kJm3cF7srGQdil27jYLfz1Yvwe2jQMzd8bVVl7FSgxcZOMtgjSnqW
   8mcQlh9fuX9dJHjnJDk7U48O3y3z9TiZ3mb8ZrM07IawnECrILyJL1azX
   2Yq7+I54LBc/+nd35sp5bz58hEbsjhhCd/rhU17jD4l81Nest/WeyVydj
   jPntzwGDw1j9ymBepXvBqM/p5OePJnrRk5NCuB2f44jDVHIS32x37ozPl
   h771XqsBwGXYPc86qUKotsEq3+vRbmi4Fp9UNvpTNY+CfEo0k0UYOw6K4
   9SKrIrUg5BLPvONj8YMCf5hh9NPwz0EHklN/IXVlkkvV48cRKO+LNUJry
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321750743"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="321750743"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:09:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="657080725"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="657080725"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2023 00:09:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 00:09:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 00:09:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 00:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnDkGL/rBq9IZlorZ6jI9yK+4McePPM+PVnTxePzF1iqbtjr+HCS0oPMxY4LnSB3ypNbsQ9L34k+5eUrOR/Auhba6bzcxxeRvJc8l2YeySNakHe53Bz6uZ1rWczeA7khmvqUqv09O5xLB95Fw7AytW3DgGEMYbZJr6i8Ynkok9eYKoLDNZSpAaicRMwAHpcz+Brm8/aclzEgFK+fBrnK7o4VklN6nMCSiRCfJAiEHbS4Nu/GWDZT4Asyho2QTAuTo12jJJbYZCwW5We/d9Y2K4250oWhvrzind0oXcPk29e1+fz7zenk6QXmDxFGCLqfFD6Kt2lpAYGI+KvLPIXjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvypS1GyG4X1OdGqEBhPhst9hC74jUStT5k0D15a7F8=;
 b=m2QV1pfNjC/jjJ1xiTeITyrfMwHcDLv+5YgMyX56+2ctmI2W/tmB3Cc8SUZOVKtqx5tVU7w0ypN5IbUHJ34kfFAZpGxlHYvdFjIOsbucJ1c8ieUsbmzwDUnNYdmsZoefF9dWRGqbCNAOcKXMiBqhK6AvHxhumFclGfMe62kySIcgo/jCrqITk3b4K+aRfdzM82W12Cnjlv/jJY+a9DubEHwb2mC/QmsaSiBugOYyQ+x3JtV3bB4j6hfUDGNqLerfwQHs+W0iRh5W88aiLMAL6lB9f9h0nORxyAcO6mchw/jZqOVt0sJR7gmio6uZgCJ1/9T7yuwyc6XBQHrkRLWB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 07:09:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 07:09:13 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] iommu/vt-d: Allow SVA with device-specific IOPF
Thread-Topic: [PATCH v2 2/5] iommu/vt-d: Allow SVA with device-specific IOPF
Thread-Index: AQHZUjLz/fR1izFHuk2/yrVkdFkzKa79B8Zw
Date:   Thu, 16 Mar 2023 07:09:12 +0000
Message-ID: <BN9PR11MB5276F50D86F8DA507CC18AF18CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-3-baolu.lu@linux.intel.com>
In-Reply-To: <20230309025639.26109-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB7757:EE_
x-ms-office365-filtering-correlation-id: daf0ba71-8270-40d2-86e3-08db25ed58c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Hit7vWYavZGVuUoBLcdxBCgFXyNP1LO1ZCChZgBxT1kZtKOG5gl62Df7VXnfYbxVL6wuq/pCht++BPnYMdmIkwuGEq9MEMvPd4Bu2QaMVfxVodpeJvcY+ZnoLuzRVG/VDiZdFp3r4Wb08O+Z6PayUvG1xcJbF1nBTQ73wwPcgMHD/wgDWlosrn2BG2I4KkEVmbQfxjWbgU/LzfXfilFWxpm+go085/nTRnXRKG1ZJ2SK/76nT8mTpnNjrHZyIh35svfdXBLg1Zi2KpQRo2kAcCIWBH1voRd0gOLFMmIGuNZGuho2URpQuf3I7v6HAT502fnzn84se3SVxOq5fhhQCvIvuhtxI9WjVcma8QgDk4kegCx6vldDjFJlTLJTKPWll49qjiTtkakHoFuhk05aWkpLnDHD/HEbvg2OcOv/96VxqcyYwWmvguOlut3g51Mo/rOVQzZm2w/HeQMS3dYyFXzohYjHpReZx16wOJ5ZrZY9dPnaWqfQ08RUyHQw2CYZ/8NGxsnBsML2WGRslrnPUub9pIBxBDlZrJgTaCG9wRuReJ/602O2SCLAYWLTofG7/9ZQ+oldkGUfeppUm7JgFxDGwzg8FIGVl5W866rfdKEi/jZXVA5uW42vECJED6iXceSXj6oPgt/Nf7/GEumgsxx9kywbrirX137j21G4hGMHOzmQ4E/ftq+23eqjyWMC9XmjWWk/3LeTzjnCSX9fA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199018)(38070700005)(82960400001)(86362001)(33656002)(122000001)(38100700002)(7696005)(2906002)(52536014)(41300700001)(4744005)(8936002)(5660300002)(55016003)(66556008)(6506007)(26005)(9686003)(186003)(4326008)(316002)(110136005)(54906003)(66946007)(64756008)(8676002)(76116006)(478600001)(66446008)(71200400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OaNtVyiZ6xliu+wwAaomwmK4ZoRWkeJIgxvACj9/pcfNRo/nCqRJseRiTWVF?=
 =?us-ascii?Q?cKKpOpY4F6hA7bGsZcZj3sPuCcdt4S9+rOn9o8qNKbaraeaNFDeVD14pZaGp?=
 =?us-ascii?Q?RKn3pekvoe0gJLd2SyzqBesPUoUkShBg2rBxr8khVR9sTjGrWGEYsAzS06l/?=
 =?us-ascii?Q?I6OuQ0jMooh/0vIONY98etwl82oofmTdXb1qlbegDqD5RJURVRpQhVnZvxI6?=
 =?us-ascii?Q?pUN0OCfIQJLQkf/xBoZxbIxHXzFph0WGu6v07Ez7VItPcyX6TX1fLdP5a/dZ?=
 =?us-ascii?Q?hcSrTFikrYVr+17SUTImvIyPOepgLoN4Fp4XPVaTM429jqMfM8ld0czo/RQf?=
 =?us-ascii?Q?jl/zvpalUi1t75mLY+sb8SzKdxBfEdMwxn0DE1CJFce+JnmTnpErj+XiicyN?=
 =?us-ascii?Q?N4tHjr9FltEIeHOKhpsYXTl4rNF7Nim2nm+E/b6qDZsP1rYlC5Br87IWhtJc?=
 =?us-ascii?Q?Se6fzlNNY2oiku4Xiirj7ndtCZILH8cMKBL8AVlTnIyhxI9TkmQM/MaGvKz6?=
 =?us-ascii?Q?XBmlFuVgQV1LqfIBZbLXsmd+7HomKtZV8jDok44egxRI5kIxt+NsmNoBpp6U?=
 =?us-ascii?Q?OA3mIwlyoGK+5OoYNtdkDj+XwY+myGsKOXtpjbfgou6c69W24HZP2VBvX3x8?=
 =?us-ascii?Q?snDhyyQjzNIapulfMxnbwgRazcxr/EOrYPhgYj44KCNWPJcXl/gHMu/Wzkou?=
 =?us-ascii?Q?d6nuZEOS4fq6h/UMUgs1I1OTZOhRV0D6ROCcwCuqbZpdQ+g6NphopVUkr5tm?=
 =?us-ascii?Q?7/xb4s2BU5/hiHjDUzloijC37trY1MRGixYDignYxvwFfEbxcuh3rEsHtMui?=
 =?us-ascii?Q?5t97MJuFdcSMmV1b7RNlNCNHJGsAKEolP5tRJNNN16r+xoo/oEFe4lHH7UOY?=
 =?us-ascii?Q?etbTD1I29AJfVQ9Ie/w8TNl+ibMRZLfnyZ/3lTL+MfYwvAQCPxhzfJlQcsrR?=
 =?us-ascii?Q?S9O4fjj0/AbyRBbxu3Tcr8trmsF4AHMajHJXF0w7QR6lRgYg3WQu9z+yyaER?=
 =?us-ascii?Q?MBot0RBxzDAeT2HyMp0zt/hWq/dj9L3QGDWrAm+t7hlwiL/kg+WNMLXyypuc?=
 =?us-ascii?Q?7ANkWCUYV0/r7OTrO+0nxFjNusax+dNlsCIFgICNEU4bRx5or0mfOXIrJVX8?=
 =?us-ascii?Q?3pBKZa0okYceBicARwYxrP/WSd/Pmquv4LPIlTWeQNbSUsWjRhWohZzSojIH?=
 =?us-ascii?Q?C4JpAyfNQy8E6dBjeUPEo5bRJ8r3d0DrSkWKbQB1xXAJldJ3nYokx8MbiK1o?=
 =?us-ascii?Q?vMLdvv/dPWpBnQIalyAvkgRMzCoHfRka7VD0ou8PRanZ1jRtKTSvBxxaFbgE?=
 =?us-ascii?Q?973aSj8yvvNw5XZ8upKUtii0MwxFzRWTs4aE8zYhLch5mOgp+BwJPBQVt8K9?=
 =?us-ascii?Q?1rvvBQG5zaQW8svsEur7CWWKBHd1JTyGVdmYr3rE4HuWstRSNmin/lxf7hbb?=
 =?us-ascii?Q?MzMjhSCpfwF4mFFqRhkNLoRx7kOJcw2cDMs0u3W7xAL3gixvLnLxQXMCOzZC?=
 =?us-ascii?Q?jZczfTj/7EKTfGgJuSvkROyBs+oQuwwXRDzG/EfswHxgfwr/ukmJGvcOhSaw?=
 =?us-ascii?Q?69E1pAvCWYIjBWE4Pg4Xv+bRfuX36w4exlglujqR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf0ba71-8270-40d2-86e3-08db25ed58c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 07:09:12.9406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEegI0rrPTayxI7jc5wEzX6TttHmNP0q5JjHC6hOAmC+v83egRFqAAmj9Ao5stgwpARMWdOADSmm5g1839rjVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7757
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, March 9, 2023 10:57 AM
>=20
> @@ -4650,7 +4650,18 @@ static int intel_iommu_enable_sva(struct device
> *dev)
>  	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
>  		return -ENODEV;
>=20
> -	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
> +	if (!info->pasid_enabled)
> +		return -EINVAL;
> +

I think you still want to check ats_enabled even for device specific IOPF.
