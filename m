Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721486F147F
	for <lists+dmaengine@lfdr.de>; Fri, 28 Apr 2023 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345523AbjD1JsF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Apr 2023 05:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345599AbjD1JsD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Apr 2023 05:48:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905524497;
        Fri, 28 Apr 2023 02:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682675282; x=1714211282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bYCgDRb4VZ+Dp5+7mh9XMIweJDkhuIcZxz8vRSccsmU=;
  b=Mc1rqYjXeXTZ9R+JzFm5Egpbisr4pKLL2subNScfYJ1vjtOy97cA/Tp6
   nVVgiV8otphKSxgLwwjhyLqNB7J0XfQpl48/7jw3N4ChzP56tewXKb89u
   vRLGCevROSqmeDZ0WxB5kpo6EtlO7IwjrrMRlEr9emnSnbAtvxNTXQX8G
   SNx7IjTs2dhTgsZuIdAji8nFmICtC96oGajLaDLzFaMiksZ7UxvCvc/zj
   H6QasRZXYj32YBgj4hysLzoVGva0g0qs1SZh8TBxFgqepGsbgbK0tKkYX
   yWBixiJ9e0tVSet02zmW+spO5OvngGaRXwncWZ5DXYkJr22BJTc4X7YYx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="328036616"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="328036616"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 02:47:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="764222586"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="764222586"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 28 Apr 2023 02:47:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 02:47:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 02:47:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 28 Apr 2023 02:47:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 28 Apr 2023 02:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diaTFJhmX4jELLj7LLXTC4Ciiv3qppsjyrbyfkKe8fixIT31QHux15H8zyDdFarYl5QPI6tsRMiIXRophzRNpJLVyOzmAkaUpo8npqcpHhcslKQgGXOOxVOWwlAnR9m0BTXitfStwkZf/PVe61nD8NNNH/u/OHuwTolSx9HfvJP8DGVQyyqiNLdmO7iqJQwy7pgOAG+nOY7FJl6t4w/vCWHKap7MvtAIWKRnC6B8iLl1S4ApK/pSs0QDOiymbykVGkcBGX5fvY3bJoyBInnOm+X9pLHc8V44rjyz38E9IVYL2B+fYVfDyuqjQwyxMFPTZJ/vy5dvfs4z+x/Zszt3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKSYc/7Bs4chqClmOaxlGtu3fPT5p3ow2ZyVDWuWa8U=;
 b=NXapSkqcoIPphIZqrVx9EEgmvZUEl2VHED3f9siEB3x/XZLLmCGwCHXZnIWLHl8jAtnmgbFKmxGdF7FhUKdvKjL4Uc+rOukDvMfmoRYyF0LvWlf+V0dStX9Br9sgh/DIWXA+13ysiR2MIPsfgFVWgXrQcxqMimi3lHenHxTsrP3HXKLOuexZkQ3vsaJAspNLQNopLg3v1Pme7Id/Ls+s1DzqxzhtAMm2jprFfowaMesfoJtWO2J9BVU9EDvkjJII10y0x8qUjgl2wqDjvucoPgEQsgrJ3V+Sb+XblJaGA1ybxAig3UxOCfwNZYlK3LZjqURGM9BBtp9wZ1USpc5+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7018.namprd11.prod.outlook.com (2603:10b6:806:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 09:47:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 09:47:45 +0000
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
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Ranganathan, Narayan" <narayan.ranganathan@intel.com>
Subject: RE: [PATCH v5 4/7] iommu/vt-d: Factoring out PASID set up helper
 function
Thread-Topic: [PATCH v5 4/7] iommu/vt-d: Factoring out PASID set up helper
 function
Thread-Index: AQHZeTAdQSnrcG3HMkmo3hSxYxRHBq9AekBg
Date:   Fri, 28 Apr 2023 09:47:45 +0000
Message-ID: <BN9PR11MB5276726E67301703BD10833B8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
 <20230427174937.471668-5-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230427174937.471668-5-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7018:EE_
x-ms-office365-filtering-correlation-id: b0ca26fd-63c4-4971-143a-08db47cd9e86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mSe8R2enaGBhw6IWrce2MVbZ4X64re7fumgamlDnTlzcmo63MFppbSKalYTGFu4nvIu+6UY2VUBDBy3qALjnMvGBSAS0ja7WxprqAgSXLEfaWyZG2t5f1mlyEOLQ9f3QzhSkngQLq0y7ZxCXfozd5KZt1tk0s2NOZyo9RMYQ+OtRPeq9x1vus7sPThd7JaOkfDODvVoe/88bfzMoJCbqPCuzC3yN+plTYbyxJ33/ip7WTtGoR2on2tAV2iQ2fo5/gdFxkNKUGKYMB0Q7hG/Phx96qaMgPa/ELkUfunmco8NDVoAHc1aNHhbcYmsf5iFdb3RtctSSX3KMBVS1sFtE80Ss3YwRcX/Ym955dW8ctmZVMChqQxUSBJCN5Z2DAkR01grjie+73iBJAnJsdxTyhETdaWEN2xniJtkobotrmjjuicsAfH4Q5uQP/2aOcx7PCFLNfEywIE/wcCaRuEsgWb/2ve2LvpDxzvaaOhhI88WTJX54bvKpqoR45UTAmrV2a4rh7uI/qEYRqfqvfwQkQVk/jW/U0T6UBHQ67ioVSa4RWwJ7CLZl5VGKE4ZE2bSZcjVay1/TJy+sM6Nem+BgjFyK2pvfwjKEL8yHj35PezE3nk/lYhTIpYgdkQbA/R0i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199021)(64756008)(86362001)(66476007)(66446008)(76116006)(66556008)(66946007)(4326008)(122000001)(478600001)(82960400001)(7696005)(33656002)(71200400001)(55016003)(186003)(38100700002)(9686003)(6506007)(26005)(54906003)(110136005)(8676002)(8936002)(41300700001)(5660300002)(38070700005)(7416002)(52536014)(4744005)(316002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IFF9egeMLhi/1Jt4XjSnuHk2uD1F9KsnhhcgRAkBP2jshK76srL1M/RcNVnt?=
 =?us-ascii?Q?7eCKQhkChqwtQIWXtpFcAkj5CdVh2EmXWt1/yyfOIDJlg1W2o9PIRyMzt8mu?=
 =?us-ascii?Q?zkWbiB3IFaEEogrH1AZuozdmvnYeznyt2WoqiADN2C+pcMBNK2FLSnDnsNey?=
 =?us-ascii?Q?VCZvHEWN55TzpnJLltcVO5Nj3JoFlqs9yS19TkFgYHmp7d3dUQdUEHdTi/lM?=
 =?us-ascii?Q?a4B97w+/QrEGcWpCZIGBg2Mt4qQwVWTv/tll9X/O3x+FBSZkDQ4lvPnaKGiq?=
 =?us-ascii?Q?lh7UaZicq/EsYzAJ4xuD8eCax1ix5RU6f5KIvzdXU6A04amRu/jDNvb474pY?=
 =?us-ascii?Q?BwfoBbBiedTngH7kN3652UxqkLvqgIaqzem8k2hGabgCgZoDR7dtlNEIzzsG?=
 =?us-ascii?Q?aeDGGeqjZW4sJcIFwCUjlfzNi+CXR0z3DwlNDuznh+rLOarU3xTaMWdIcgI2?=
 =?us-ascii?Q?+2NbE+jIuRdFXNhStsNyBZxS15rChnQR9pLxfc3BeReZBBTvpgkAYRsY5Prl?=
 =?us-ascii?Q?MGzmuFv39nh6Qs7E5s1SX3tpZp8imwu/lIMhbSVO2t+fBSvR72HyUFRuFXIf?=
 =?us-ascii?Q?fcPUlkDamsMZfSjGcBeHz2AFYbYkhu/5aXuOFxqYKYuxeNmrabBtPF1NhxuS?=
 =?us-ascii?Q?jmW2Ce+hpE5p/uDNTe47koLNMOiVMScGxjA8GUv32VB3XljEXhjrKGjmNkB2?=
 =?us-ascii?Q?wq2FEimwh7fKogulY9V/+D5xnEqexsnlF6XGvDEZXjNz/NVPIpxTu1jne6Bk?=
 =?us-ascii?Q?5DfQvcd6DF7zJ0Of7xzHzqj3x8qntUoTeceQCcgcfTPTilA0ceC3jKSl0o2d?=
 =?us-ascii?Q?0HiCh2+ob63IA7C07CkydtYlQoXIsAPmLUrYgONBDV7HqL3KHoAq1OD3jxFg?=
 =?us-ascii?Q?ivHiyrDbLaJWOrGlu/BgRp5scFGYzv4ntqWrvdyY9JnHoEeI3C1/ouiTOfd+?=
 =?us-ascii?Q?mlpNueRepHWa7pA77K9M9uNlc7Yn84qipXIiMD104dd9JJbASf4QYqoVBApW?=
 =?us-ascii?Q?NkOrS6obK6Jkos5fbuJQxenovU2bfn0b7Tlm2bhY2sdwe7kaoG+4Ntwj8sTL?=
 =?us-ascii?Q?ThDCMYwkxlStIBWCQKKje6xiFzZX74sTODfyrb4ATKyORsJyqgsPHHiEAOu8?=
 =?us-ascii?Q?kHNnpXACDi+ZsYK4gLceV2LiJrFn8Qk4dRO7WYgvpGEK7syBsuLfS9QpQjT+?=
 =?us-ascii?Q?wd/2FoKJ87PcD94nz2iKczswN1jParQelK/XJCFCmNVxh8bcFbAexuvVDC5x?=
 =?us-ascii?Q?yhHzsiAnHT9Ttqbb3fWCARwEiqjcuyHkOVXANF2r7oMfwnrjMwbLdBvDEa/0?=
 =?us-ascii?Q?4wspQKOkilHM71buYNvv0kXrJylp/elCkb5rzPvkN0hAcfBO+u4TbHIWS+OH?=
 =?us-ascii?Q?GGHiOhpYYTZpUtO1fg91sbK/ds19/nO9RKpClW9/kHQA8jt/wmhNJjp9+1u8?=
 =?us-ascii?Q?gqZLynAInac0SOa4n4fMip4kMwEzQIlFtRSDLWjU8J/X9k/FQNEadQSOoBhy?=
 =?us-ascii?Q?kHFA7ETO65yjZQNHOH1ss3JivC7VQSIKzwRBAfSUmeg0JaUJstupJXEImIwn?=
 =?us-ascii?Q?fdQORscI2re2MuJxn6UN9ISHrq1Ylg8LFwJ/L5tY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ca26fd-63c4-4971-143a-08db47cd9e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 09:47:45.6003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TVo9LOYy80UgAB9yNZIL20lZgLE777jkBKPns0dqIe2yK6wyFtQRbEEmbeLJLM4WD01c8vF85y0aVCHZMX+sYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7018
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Friday, April 28, 2023 1:50 AM
>=20
>=20
> +static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
> +					   struct intel_iommu *iommu,
> +					   struct device *dev, ioasid_t pasid)
> +{
> +	int ret;
> +
> +	/* PASID table is mandatory for a PCI device in scalable mode. */
> +	if (!sm_supported(iommu) && dev_is_real_dma_subdevice(dev))
> +		return -EOPNOTSUPP;

"&&" should be "||"

