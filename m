Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E44C68B47A
	for <lists+dmaengine@lfdr.de>; Mon,  6 Feb 2023 04:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBFD3E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 Feb 2023 22:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBFD3C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 5 Feb 2023 22:29:02 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C9F144B4;
        Sun,  5 Feb 2023 19:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675654141; x=1707190141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ui5yNL3yeJqKPq2v9A4ZH0pKuc/YVHeP7iMqEtoLePM=;
  b=GH+0gjKEu6D7rylJaAzweW+U04ooSDcesLdbN0LanGn5/cN7SgIW+jHZ
   JaAojHtmuGn+LilTEv23vJPPgEmyVj59eXJg/jtX3CsH7MiBaYl112YLq
   w8XxQj6DbuPxXUH/wgd+WpEgbXtsw1ZKGQorxTI18RgcodQUHTTx/AwVO
   o5MhTUpEDEqUNcKQVQWc4Vy8M8/JqkO/ktNEipqFcM1n+S6bVT7oQaBrP
   QoIX5wDOsQSPusVKW9vEjAXaOh5BS1YI0zYadkBo8ArTr3hB6MEUlY8ey
   cp1ZmpZMZwpm+a6mkGOoUoXxgxyYJIAvSqf631h+YYr33/NxWqnk+agaT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="329138003"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="329138003"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 19:29:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="729875395"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="729875395"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 05 Feb 2023 19:29:00 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 5 Feb 2023 19:29:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 5 Feb 2023 19:29:00 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 5 Feb 2023 19:29:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOjVwhk8840Aj++DGBBSSbWOtdT7N5Ey/hmgJwVcO345CbRVSKPJPOLCuGTYodcI5jIpeCwdNNbGRfACZgNtITC0hZW7WYppzX56hm9vTWONpCHFheh9ao8xtNzn8krm0Kz228NhKB6Jl1H0IT9f8k/6MF1UcWYsULoxCEN05zjuGFC0DiN9ukpkLQ0EREEkIqMAVPdHJyW4i7Wa7Po7zQiJB6JIqkkv+g2wMjcbwfL/WATNQVnjRR2XA8a3u9wPjAtdMpdIh7qVAtzeAEPdP7AhUhwEFRak0G6f9xxEN7C/xQkxrqsxbFFvYyVq0M2QBa8JR8trUR8qfE4tEypRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ATtlTKVHZOGT9xYIynjWrxChNByKH1WSWhAWC0KAhI=;
 b=l0xni5ddQTd5JpelXshRLO3IEvORqK7ol2V/GFOjdDBmbLaxxBOSuCVidhypydcm9XjntEO/BNp/CfK7tB/IqyB5NaTPBfJLk6J5/fah69LSyneiaZgxRMLil9kkvn2umWjKxg61Wx1paH/Z+baukHI5BTT17E+9uRqkgsewnTQY5EDuoM43hKHw5ixwoaFws8NrWW+3zE75jRoSWKXsHPePWtNV5u5lhFWOpn1sQ1mB78PcrL8pUbYp2AvJuP11jRxNeVcc1NX5mPPJ6jO7zZUB9AYV30CohPqGQnzikpO8+FzzaLi7zmhX1NGgFRYFFhNLbAjI/Frnq5cbMUNv/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 03:28:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 03:28:53 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iommu/vt-d: Move iopf code from SVA to IOPF enabling
 path
Thread-Topic: [PATCH 2/2] iommu/vt-d: Move iopf code from SVA to IOPF enabling
 path
Thread-Index: AQHZN60EIGh+HMbBFkyBqYknjucFXK7BRJlw
Date:   Mon, 6 Feb 2023 03:28:52 +0000
Message-ID: <BN9PR11MB527659435BA073B21A1291588CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230203084456.469641-1-baolu.lu@linux.intel.com>
 <20230203084456.469641-2-baolu.lu@linux.intel.com>
In-Reply-To: <20230203084456.469641-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4714:EE_
x-ms-office365-filtering-correlation-id: 5e561cd7-ccb9-43b6-baca-08db07f244fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hshqBiEA99DZ5bUpv32kUMY3G+Qsl2gTOHcqaIHEqvr8//QEB3RkBnksA/wJElKAfKo1EiL11ncF0PV/hLHaqeTNhLc+yc453TfmK/RX/Vhw09YWOHExbrMiVBH11+BXOms2md/yKdF783K5FoQ5p7/VDJzr3BDAjR55vCBxkpL+3hpymKZg0vHR9ZcBfBulYldhBF9/N/wdem8xoyF/YhnAIuKRPxSm9DnPGDZ6oDy8A+zmSXdUClxnf7axZzeItiK6GK/kvZCpDAOhcT8a174Wt8apNYQU4jMSBi878ZmIzIrv5+37L9+dWAklHf7+mpHVyjo2Df+cNiFNnFfCiSeL6/vjC0zUJWH+H0ue5MKXrP/ZcC/XZE4Ba17EkY0zxF74VMGQrPTPISi4JtdL30x1KItiEr+IfuRvv8M3yZDG69XQbp0RLN/EMvB5pnbf8SM9XprTFxw1eUeE9b6cmTFU3f70YvazNnQgY+HV2Q6xJBd9LFATDc1pJ7jSglYHkWpHpRJEoBNXZZzsuI0CGvTPBfKEZtPNMr+yVX3buJYBxA7cYF/rmX+FnSVvxnTju2XknA5Tf/Jeul+102UcunN+zAxmduW/yheTRNncXDWsAuYrQ0Ze/TJ1I/uPS5ZoMYLtl437QwTexrqJkreXnjktCyOgpR5NjHergCC03clzPs79km4F0IlvqJpY+3tGbNlO1BABxjiv7bbKCuNUsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199018)(33656002)(7696005)(71200400001)(54906003)(316002)(110136005)(6506007)(8676002)(52536014)(5660300002)(2906002)(66476007)(66556008)(64756008)(66446008)(4326008)(76116006)(66946007)(478600001)(41300700001)(8936002)(82960400001)(26005)(38070700005)(86362001)(38100700002)(55016003)(122000001)(83380400001)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YcK+A//IoCUfrjLymyywB044D6rcnf3pzU4xt68c556XYVH8/8J7J4oUGSK0?=
 =?us-ascii?Q?t5358JUPY7uedDOwWyth7oOq1zwag5toKZ0NGoYTqJPsUb8bXP2nQAOfBlPW?=
 =?us-ascii?Q?HdLniPvVXHYgAF8rocJQt+KZH5eCT989NVrm2OOFblzqTnJfHgVR/ISVi4ke?=
 =?us-ascii?Q?fHg1sbnr1A/ch/XSen6m5Mz1GZ7Duw5NQFSQVrOBN6T8Y1XDz7Om/ll/qpRS?=
 =?us-ascii?Q?TCFteJswTv8B1n8m7LSsv7RXQKO73P88EWEXCIbA6aobokZGCqxlHwub/Zog?=
 =?us-ascii?Q?19ic3Phssevn9uKPtLbWPFQrTrTapxLDTTVVHNle3O33l0bQWrumKsIKMrf1?=
 =?us-ascii?Q?W2SETOvhmXhwi17A5IvU7gCYeSWA4gRCMXVtAlzWdDJFMVDYAtP3b26CY8P1?=
 =?us-ascii?Q?R4wZdlFP8SofXuqH/4HOIHLtfiGOxsGi+V49jhz7zXqCXbtOyHOKgOMt0Ryl?=
 =?us-ascii?Q?SE6O34pXgb9S1GzrkQKEe8ua85sA66sI/foRfdg3JjLzgSRqWPAdQ8Yveu0x?=
 =?us-ascii?Q?/RiuW/LWxdDB8MiXfMyUGhmMiSuSLcDdMw9AUF2H0gL2+MCnUdViBWDq/BPm?=
 =?us-ascii?Q?D/wkhzTjpLmQxG+I+AlnslXCSNmYw0jOcnDYrLBxPCJgkCYviMgVzTleOW8o?=
 =?us-ascii?Q?HHm8dB5zin+d4vHYtnaB3RYMK+kBbPjWNJneORxsBOute+X269Pn71U1sGyk?=
 =?us-ascii?Q?0p9Xlj442QhzKp1oPhpKE4yzP+qZgBwccXcoD/BqGzbvm9HN6gig3Ri1ECER?=
 =?us-ascii?Q?D68LUKKXfmaiKkP2Yw60zKhDUgpDAOcBPymEw5aCsGBkc+C48qzlFDF+wlfo?=
 =?us-ascii?Q?3gkUGc3AyWshX7DTvUYKahPhMbazVurVm1ZWd0Y+QnjCfLofFvuQl0NtSiJF?=
 =?us-ascii?Q?UIg/6uic0oIz8IS5/RKy6tW9He9T/JiQJN5kw7DWdQIV6Mol+/F2FnwECj4g?=
 =?us-ascii?Q?AEAc+nRzzAiHnqZtYlWh6s046NS8mMqAnzLP4mhThsXSo/M/a6piCEDrUMdB?=
 =?us-ascii?Q?fu+Y9JIJ8ZFdaX8NaU5Sw0pp6qcshAuHaIv0uXK0mjAl8tdj8JSRmRj+QseJ?=
 =?us-ascii?Q?lK7kR9LdwGQiV/R5sygmuseOFAAG/AuMMzEHjS2xmdHpoJ5E352hv11K2LWj?=
 =?us-ascii?Q?bUyn4RxQejwOdHT9yn3Dito06onlRVTcbOmIFaDrllKxGJvmKvUDrC2kjh/Z?=
 =?us-ascii?Q?KA8EtvDrlUgCYzte0+X8lpZqz92hRIGz0N8vOcanCo39+lDlX3hfaZIcUMH8?=
 =?us-ascii?Q?OwWRclUOUcEnXLa6oqW2nqSYVWt6PbvKkJze/rXN3FHp+bq7nOCkyFMLMN+u?=
 =?us-ascii?Q?oKUNlIB4XYTDFXTzruG6D4z4imouljRDL5KD4QiDiiYdKG9yE/goXDs/tahn?=
 =?us-ascii?Q?ffHq3dhLta8MeqxKX8DczgLGNeDSTPELHjtyXbQNN09otr5dPo/spWIOrfyo?=
 =?us-ascii?Q?O8CJshlunfkeFsqvM8A66mfPMI9txLOBtTX2yvl/8aXetKUMIXqrc80cS0ZD?=
 =?us-ascii?Q?8chDoF0HiBM1PXB4YkbngP9vRt6uVPrByCQm6avDJL1Ns/vSl5TYbkeA/wCp?=
 =?us-ascii?Q?pddk9NCysLz+pBej9VO3AP13cepOvc2XO9xNo8pk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e561cd7-ccb9-43b6-baca-08db07f244fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 03:28:52.3391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoOl+LaxAreuzyUQ2UCtZcl15T1jsAMKKwUjbz7LLxu/nYY4ln5PgAiEMEZzKEJHsUfgNAVku3USFi1N9KchQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, February 3, 2023 4:45 PM
>=20
> Generally enabling IOMMU_DEV_FEAT_SVA requires
> IOMMU_DEV_FEAT_IOPF, but
> some devices manage I/O Page Faults themselves instead of relying on the
> IOMMU. Move IOPF related code from SVA to IOPF enabling path to make
> the
> driver work for devices that manage IOPF themselves.
>=20
> For the device drivers that relies on the IOMMU for IOPF through PCI/PRI,
> IOMMU_DEV_FEAT_IOPF must be enabled before and disabled after
> IOMMU_DEV_FEAT_SVA.

ARM still handles this differently:

arm_smmu_master_enable_sva()
  arm_smmu_master_sva_enable_iopf():
{
	/*
	 * Drivers for devices supporting PRI or stall should enable IOPF first.
	 * Others have device-specific fault handlers and don't need IOPF.
	 */
	if (!arm_smmu_master_iopf_supported(master))
		return 0;

	if (!master->iopf_enabled)
		return -EINVAL;
}

i.e. device specific IOPF is allowed only when PRI or stall is not supporte=
d.

it's different from what this patch does to allow device specific IOPF even
when PRI is supported.

should we make them consistent given SVA/IOPF capabilities are general
iommu definitions or fine to leave each iommu driver with different
restriction?

>=20
> -	ret =3D iopf_queue_add_device(iommu->iopf_queue, dev);
> -	if (!ret)
> -		ret =3D iommu_register_device_fault_handler(dev,
> iommu_queue_iopf, dev);
> -
> -	return ret;
> +	return 0;
>  }

here and below...

> +	ret =3D iopf_queue_add_device(info->iommu->iopf_queue, dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iommu_register_device_fault_handler(dev, iommu_queue_iopf,
> dev);
> +	if (ret)
> +		iopf_queue_remove_device(info->iommu->iopf_queue, dev);
> +
> +	return ret;
>  }

...indicate a bug fix on error handling. better to have the fix as
a separate patch and then move code.
