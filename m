Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDE46CB847
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 09:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjC1HhN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 03:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjC1HhC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 03:37:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3D3AB7;
        Tue, 28 Mar 2023 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679988986; x=1711524986;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RzFq/Rl0B7bVlbXtef1+KnYwujCno5zHqhzUJYSQY5s=;
  b=UnBmyYEaL06ILRZzlTtH+EplmAh0CXmttZ8v2nCue/jY9Lqoask5VOcD
   aH7qqyU+oMDBDxCMuo56y9I8IkpZsARVSyyW/3sgfV3VEQaoPetVdbRuU
   NQB3+vD6qthAro0XD/uE4BOWLRHEzCKtrwlS/bB1ER9Ez/78S+E3htDNa
   vskwHWWWG+6HneWxnLgt1cnUYV2k3SiXket9oXSSoDyCoL0mKF2Q8bCO2
   iUbIQxTqxtXdk0myB6ZagV3SXhRgRK/r2ICDWQizcTDkrm0f9vMu9L4v2
   1CRz6vyxkViADEmg7Qmn7sXFtkzDLrIppIwyvu9/dOtH/0pFA6LZbDYdX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320895011"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="320895011"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:35:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="929767963"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="929767963"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 28 Mar 2023 00:35:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 00:35:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 00:35:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 00:35:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwdPW6sF/19PPK1XNu6V0H3+jQdEkpFK7zgob4KMN7C2sCojsqycegd/gS7NbLGZsHg10KSnfKPs/4yyYfSP4kohv3zeLBKaBZaL7Eo+J5KdBPhO5EYppCbvGzssnKuWkrLX/BRXcNcBO6rqj9rIRrMFgC9rx5OmxwJDnPJQs1Wz2Kr8R5YcXh6meIEH5NhQ38G3Wa2WQQss4paIj8QadSyIhRW13FxnhdoRdtluywi/B5EgwKRM1pOFUKqQyUNnIw9lEHz5zRKBOQSAfc/PSFojWoP1L5kjMh9gYYR7W7ltBxAXWYle1gdtEAmGdFHHal/gXv0jgx0Ymo13o/mRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGANPXunflm2l0pg8UAsS7rSCzuO/F6N90/GMk/4OvU=;
 b=bDW/E508Lkm7uku7NUyEN/irKfkre0bVTUJo3IYk3DowfIHyPNCFQEpf5alpkQYlQ6Cn3eQnBnQ94KIKKFTKWylG7VZM2W5veSAKx56xasPIcZ6wJC0k6yIFn0dUCCXytybt5TIWDS/tl7Y2rXw2vP5CPFRTmjFP/Vpapkwms/iCkjiTotIImxNWtfGexWx0twtK4+8+o5YJC69Tu/eEF+AbBFHVs9Q+ctsiwxMmgybaVrEIQ5t2YQOh5pvK6Br+gZsWmdEuuDI4ghDcrH06s0blK6XVGnHIbSTjPWEoNu+lF0jRD6YFR7P3cG8jnvOxjQj6z1LuGQWlQ7Qkp02EdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 07:35:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%7]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 07:35:44 +0000
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
Subject: RE: [PATCH v2 3/8] iommu/sva: Support reservation of global SVA
 PASIDs
Thread-Topic: [PATCH v2 3/8] iommu/sva: Support reservation of global SVA
 PASIDs
Thread-Index: AQHZYQJVCeSxcwpxvEqJIzexBCJ0H68Py18w
Date:   Tue, 28 Mar 2023 07:35:43 +0000
Message-ID: <BN9PR11MB527652D88D15437F52FCE8268C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-4-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230327232138.1490712-4-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4805:EE_
x-ms-office365-filtering-correlation-id: 8a47f9c7-0178-4402-2cec-08db2f5f0a01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RCnF9do+Hwg/cfhntjM02m0tAKEAuxvht/4QcmuQMQPxMNXqekBYann+pdbJbtz/wxJ3pgvLxRlc3hrvUJSLCtVyj2om0toZw6OxUxbAjnlvsY9j0whkYxwyDppK2yKPicXMR9F95X/PC+q0Ah9IcI4KQcIVuC7dDMjVMCk8XuXyAvIo67d7Iiz9RCHEb5cFX+mIvlfSnhj4MIPcRCCUBfR8f3+eT8SeuHZwR2b8piArgp3iYSssESxXFV0/dte4Us7+oMHrn2ELH9+dRuyzdwLl/nTQv/JzsQ0TkIitss8lLBqrBoD3ejfBxFw7Euu15DjW9Tsv8D7uecUJv0yM27pdtu4lUO5uztDcSEQKvU2IP8bEAi1E9ea+vt2Q6BomNBXbULoDBXcJ+JM0SVUBsADFCUruLZm6a1pYjdj50hRqkpSryK6/+Vdto77XfBwz8DL+ovRL+nmFdBpX99xoYVgKZ4SNEMR+lC4PDn8F+FVMFGZG3vpEPnQuWX7NtJPB5EXA8TBEXQ/itSC+0+2PothVPuYXiVTMImTlQr3mq9B34Ki0A0YXAIGOHY4tKYbrFR2cP3rep6jWoE+xFOYSc6rB6f7kV9Atzg0NURGGimxHsvMc+mbq0URXfrcZaIzx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(33656002)(86362001)(55016003)(478600001)(316002)(54906003)(110136005)(4326008)(71200400001)(7696005)(66946007)(64756008)(66446008)(66476007)(66556008)(8676002)(82960400001)(41300700001)(186003)(76116006)(6506007)(26005)(9686003)(83380400001)(2906002)(38070700005)(8936002)(5660300002)(122000001)(7416002)(38100700002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u4ALKOeRuyAgwbKT8yjbo5Kp/UbgoPuMWGbHVpC+WxQVjDaZAV9K0rp0pIH2?=
 =?us-ascii?Q?oAFYp2PHG5rZ+CdkvnLfmRuo5GvPdO2SeUHc0lWEo6rYNlXzyFc+7PjVPPV7?=
 =?us-ascii?Q?21SURmZ91tETiv/XO4Hy6Lw7WgLYJU1aAoHBFM8QUmofCF7NuHObvol+bsQr?=
 =?us-ascii?Q?gYGPMXWiUWnn8L0w31899SymUuBRyFuDvkmQ6qMeMB4hNKMVXt8591gY+GGE?=
 =?us-ascii?Q?HgGUXPB1VydlMWOdyWdX9Nm1aV/8yxODX1dehqf5wmDSZ2OxxvgNRbryxWC9?=
 =?us-ascii?Q?keg1c4oRjLH9+GRZy/ZOHb6SASJ2AeYwnI8k7mARa03r/FKj32zTqs1JIcf6?=
 =?us-ascii?Q?GI9IDlHwjuFj9d65WmvGWmBOcH/TPULB2QJb/Hd6oF4h+AOVEQlQ03ZRsBxs?=
 =?us-ascii?Q?Hba3BwXvPjvk6hOJxN58BsfqnADAmc49vZiUVo54/rJIJNIxgKZgZzGKFUqk?=
 =?us-ascii?Q?LDWnH9yx6pq+tMzTj/YMC6bDuUHeHnd5qaKnCY9OASdlunWpWViAsjg+/B4Q?=
 =?us-ascii?Q?MQpONAP1Cyidi23+9OF2nha9QWm15a8TD91MyIwXFI8KVR6++soIf07tGCFM?=
 =?us-ascii?Q?FAJv+eaH+yH2Zb7lken+Cb3oDn1Bt/aMLu43H3Vv36cjn9EPO0Lc8KrdmMwz?=
 =?us-ascii?Q?+oQemKQHOU6pE/X/R+f1xMIS1pJIKO620AJZ5YtwVYNL2uyP4TEtHigkoBwM?=
 =?us-ascii?Q?KMkNR/Xi5D/h6SP60fYODL8ZvrN4TUhrNeApd2IAeHEbs0F0a84xi1nNIUuD?=
 =?us-ascii?Q?tta9xUqbx2CYlcKzbfgbFgqqIhhzmu77p5H5IHJFOs0DMJXajMYAPsV/KxNG?=
 =?us-ascii?Q?qH1lqDKBkohjXCaHmUKFNz0vwnt7hX9GrEyLPjn8yWDvnWxr8sGps1Iw2RTo?=
 =?us-ascii?Q?PQinkeGivzG+qPGfE4/kuMKaNqVp4pJiIsJp+HXeY2/Yz9grZ7N1jGhey2jq?=
 =?us-ascii?Q?S7HvfE/nikeSfrtU6eSdP32cwS/1pZfPAmAQFKJUciXqR0is4KSCKjN1MoPI?=
 =?us-ascii?Q?peCH5UqGuFA8wmcL7p7MLZgmJff/xMTM+ak7t/vtb/4rQU5P722V0ubsitS3?=
 =?us-ascii?Q?ybWFi+pi+3eQh/I7+EaAC7hxOnazmVyQG+xrkg68JDOfqG7xTiChJGfMgyK+?=
 =?us-ascii?Q?VWGIj7o7xOqkxTe1I2Pk72hB3yieFtRybFXl+LsXjkQz+pu/blwRtaYzxnkW?=
 =?us-ascii?Q?RhYXpAXY2TBUHbwkGmx3kYyEdUPu5WyhJfX4cHAgsCtLf/2x0gOW505rUvtP?=
 =?us-ascii?Q?9lgoieXjLRTsjW9TQ55KTBcnCB9Zks5DgP+EBFkzi6wb6pyWh42Adktbtrle?=
 =?us-ascii?Q?WZz3zFeNjxL7yO+aBCrKjptAb8DSX8IjoUyKomxvCupXRTLtbwsGvXIa0+TJ?=
 =?us-ascii?Q?m0yceUOY0rsJOJiKxFEnVD0HjB7rTvivjA2cBS2+c04mPdf5UxwfJ3Y4eIIw?=
 =?us-ascii?Q?hBgeajb+noNTNTsBdSlEQlrkT45mjpVmjMRAc1uSZgeDfJlJiHzixarAFnmr?=
 =?us-ascii?Q?LREIj53DOpU0Z1ywuhtX4d85jEi+L0otu/4FRSN9o1sAUOWWA/DbxputUoc9?=
 =?us-ascii?Q?QSfFKxGEfXGOhANDStMYAS/GSk2e7d3cZqmfHaxi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a47f9c7-0178-4402-2cec-08db2f5f0a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 07:35:43.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3LPhWxJog2v2hHbIKeILds7Q6mHSotnypQesD6Jqzl2YYuXjbWn4ONbHtWbtMokZNliHmmfwGH/ihce4JBeIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
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
> Sent: Tuesday, March 28, 2023 7:22 AM
>=20
> +/**
> + * @brief
> + *	Reserve a PASID from the SVA global number space.
> + *
> + * @param min starting range, inclusive
> + * @param max ending range, inclusive
> + * @return The reserved PASID on success or IOMMU_PASID_INVALID on
> failure.
> + */
> +ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max)
> +{
> +	int ret;
> +
> +	if (!pasid_valid(min) || !pasid_valid(max) ||
> +	    min =3D=3D 0 || max < min)
> +		return IOMMU_PASID_INVALID;
> +
> +	ret =3D ida_alloc_range(&iommu_global_pasid_ida, min, max,
> GFP_KERNEL);
> +	if (ret < 0)
> +		return IOMMU_PASID_INVALID;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_reserve_pasid);
> +

Look at this function. There is no single word about sva except
in the function name.

sva is just one user of global pasids.

when a driver supports sva it has to always use global pasids even
for non-sva usages like dma pasid.

but this doesn't mean that we should build the API around sva.

it's really about global pasids.

let's just call it clearly as iommu_alloc_global_pasid(min, max).

Then we can define a wrapper iommu_reserve_global_pasid(pasid)
as iommu_alloc_global_pasid(pasid, pasid).

for PASID#0 driver calls iommu_reserve_global_pasid(0).

for dma pasid driver calls iommu_alloc_global_pasid() to get a random
one instead of reserving pasid#1.

this would be future proof when the same driver starts to allocate
more pasids for other usages e..g siov.
