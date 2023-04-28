Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41D86F1449
	for <lists+dmaengine@lfdr.de>; Fri, 28 Apr 2023 11:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbjD1Jii (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Apr 2023 05:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1Jih (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Apr 2023 05:38:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09F62680;
        Fri, 28 Apr 2023 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682674716; x=1714210716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6+nXLLn+4S9R9tTi2eSuFA+DLq2H+1nN9YrFmSTxpJw=;
  b=hXpyv86O69vip9Lt3/dEdFXtaefKtxcODg1fy3PYBNalIbnzOnACZdra
   Q8zEthdfnI38YdaKUdBQVCP7QNK0ca2tE3oOwnNy44mik1A/VvExzjuDV
   uPPFzpvb8E8WObZVfKSkqsLih3GI6jVC4kjEs6skNq4gISip/jniWemP1
   Q5x9TQjElwcByGMdhZDVOx1etyVz+JZqsix29Gs49xqBdLroSjdAG9AI+
   FogqhfYaVi6cHpD3+RmlKLvhhIAvgAX5qwg2l3q0lfkWl1xRgN58j0cz6
   gI9Q07CNYYcQxOkcTmJvaj7zV76O0i4sT5JzbbJ7UFJmeMhX8WvjDhOE9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="328034061"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="328034061"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 02:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="727468248"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="727468248"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 28 Apr 2023 02:38:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 02:38:35 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 02:38:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 28 Apr 2023 02:38:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 28 Apr 2023 02:38:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4aG7urGvIfYBKtWkz74y01Z19LyxlySO/6nlKsPaLc/6G65T8zDc1s21f0ATZ0YxQypLg+EiX4Ff9fXcnt5lt27SRK+HAv3yHbl99iNZQEqoxjQdkVyCPaFlamH8gjjur4Wthi2Qoj3ZFHH/SPbJvbfO1Il6VxaTNddv8+rmbr3GBZ/VCvNLP+qE+dMZx4kgSj5zxRaIZvKIVcPdVZaDI0UVM53TfR3c32s21t7LOfpRYrtOXvFKHNgggFl98zbZsXnkBqEAWSsR+wakAoZm+PKuG/LuSS4DXGW9rNxaxMAp7JdLPTu3rO25JtyeggGxy7HgRpkF6eL2vmOqb2igw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTXfDiUBrllWMlei2iYiyN+dRnjSMeJP+aDBhgldGkg=;
 b=M0LSkpqs4sonuWVBa76g3qxAM7nPUelBaBsNc0GCs7xUFYH9oeRL9QnPujhWgUHCGsFPy1dUFNkha/YHrB1S0yxbpbAL32l67moVmwG0PjIsp6fCFNWsw2VkV3tRrsM53cmLlEtKR1mzlwDRGFdenXhVr1nGdngurG91ppzJROdDaTHauZbhVgeJM7gWBKFPx0goGzJs/wo1nvobOwspeuLjeyv+NX9mxpzIuaOmIVwP4zASxspRKeanovPtjX4W/7JFGon4HBDrAiu663yS/VQjM2jtSsevdFAs/i3SlI5W3zYJL29XiOg/AtSvyAKo9Rejg8/5+JUiMSqZ+B32GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8273.namprd11.prod.outlook.com (2603:10b6:510:1ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 09:38:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 09:38:32 +0000
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
Subject: RE: [PATCH v5 1/7] iommu: Generalize default PCIe requester ID PASID
Thread-Topic: [PATCH v5 1/7] iommu: Generalize default PCIe requester ID PASID
Thread-Index: AQHZeTASrtonzxFRJk+i3Dzn6cfwy69Ad3fg
Date:   Fri, 28 Apr 2023 09:38:32 +0000
Message-ID: <BN9PR11MB5276FD027EC3D6BAA24046F58C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
 <20230427174937.471668-2-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230427174937.471668-2-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8273:EE_
x-ms-office365-filtering-correlation-id: dc5717c3-04d3-406a-2f8e-08db47cc549a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ofPSF6oFsomdHDbtSyK2KIplbnQVQMEuJvFscx3t/KhrYhUtUGC0FMWzqiIBn7MHPmu6vMGe8kzZSAUIIxJxV/t4/7tEDDbhXiVjmWLwd13hb2dLN3CoPuq5pxb5NPEvD8c7wa/WDdab48zjatuByQQZa1POAaN6PeNPdT8UmLWHmFCD/E2jpELuxcXZIKhtBjv3EeeAsxZb5jSoPq5gW/ss4eC7BxN4yRLfV7Ybvl3NO018Dme+B5Ga0GbyfcguKGMXG0BiKaSysho5wzV0trC9mJZv1dtnDkb+v4bZ5Ys+7GeW0kIks2/frlA49zwmR41lI5GuHuaVN6JIKVBYdlrTbFrBOCHP+MJPPwSxa4TCQWM8svYuU7wVDIxN6gHEuin7xCr8XhDrurFs+VANHUu+dx+xwj+VDdMK304Y1Y6r2sHyYp/3PnGA6TYvVXv9HbUn5sgy2IYF6dgTXebIumZc53xRz1NsvqJcp8ZW68tzKstxEw+spP0wTs0cryVmDX5hDNPIyou/pB9ZPJifRrdLihDPyspfsY/76WehtxVBULBgpqGp449/QQPXxxZEWLJO/7qdHhBvU0VqFiK8fmOobzSAKGYQr3E4EsfmJFj55tutG3rKh5qsaMrKDo9y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(86362001)(7416002)(26005)(9686003)(41300700001)(6506007)(2906002)(55016003)(4744005)(52536014)(5660300002)(122000001)(8936002)(8676002)(38070700005)(33656002)(83380400001)(38100700002)(7696005)(110136005)(186003)(478600001)(54906003)(71200400001)(82960400001)(66556008)(66476007)(4326008)(66446008)(64756008)(316002)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+qZbfgRsVceTb9vikxgHqD62ec6jJByHv7FbctWDw8E2TBgeLNoYCHcVtzv4?=
 =?us-ascii?Q?G7AS754WoSfwh3WAcuu0rZyNBJIxqQNmc+H+bIOXBGJFDS94BI7w8wnqL8Tq?=
 =?us-ascii?Q?V3mRrA4yAYPGG4a/j/Res/88k/OHDHpkYhUfyJTrlhwJzhzRXuTQIuPiDaci?=
 =?us-ascii?Q?H5lwxevd77RV6UaYUNOOI9KZqRXTGerwxFNtn3UuQWRBGszEi1ujYdUi1Ocv?=
 =?us-ascii?Q?d0WlSdDTzzV7WVua4BhEXQuBGJ8zrkJPdGVfcpEsHc5HYn4h/kZ9XC2aR78O?=
 =?us-ascii?Q?5tFzRv32MqTjD4aMNbVzx2pkVRIGxmgWmUV5aBBIaxQ57blYm1saWCu+x5nY?=
 =?us-ascii?Q?/uApcADbmbBaF9GPcREwu+dxe5vFYwsChQboaC+VDjZHSf3zndLZtoR5wpBp?=
 =?us-ascii?Q?VYe8o0X8/jL5kypsuhsAUSBKv9BTv/4MYgcQ/E5Ac0Zn62G13jyMxguMIf0Z?=
 =?us-ascii?Q?nkTas1puNwx+V67U8ShTmyOew066Y6m9mrhiJQJ2c/JLcF2kwFJmaar+DqUL?=
 =?us-ascii?Q?tqu7dY7TsMywtV0Cf/Wlgk5CPcw0IDQnQHVeR36+9Pcna1v5KU0khQWaWpLg?=
 =?us-ascii?Q?XiwZF3e0/KkN5kQKld1mPSbmRN4JIXj0HCV/NlLuo8ddApaM5iqVm0khav3V?=
 =?us-ascii?Q?15uRWYBCiUqA3isud+VZ/GecKiqv5fgm9NmVIhu4WnRpvlrBbxoC4/NRnp9f?=
 =?us-ascii?Q?NYaSnVpsAECUGE58oZRVxy1t0/mxXhcU/IS5ffm66mWnufKuZPY1O/u5a0X2?=
 =?us-ascii?Q?Txu1HnMge18yd5pmAEqepksGPy4XgP42mQuFv8IWSb6rBa0RiSHARh5iewEb?=
 =?us-ascii?Q?gR5XLMltJJllfRb8t6QYrIVOXdMv8p1kJzs56f6/sORrQQzpwDwMsrAVrX8U?=
 =?us-ascii?Q?BsvXeySOnZtDyH1JhQ9/N8DKcIScrPY/IPHdwY+ntSHaEs+8U/Ce0TrDlwY+?=
 =?us-ascii?Q?IGa28loEVbaDxKfRkAdLN/ffqh9/Bo86osPPM89YORLvfRlb5uRqS8BQsW5/?=
 =?us-ascii?Q?LY/ZsO3lsc4JsyrqlgJHTXJpm25A1n0HOkiGf1zqz3FJ2haQCM1tKFNQ4M6b?=
 =?us-ascii?Q?YSqNHu340PxmIH8Hp7DueYqxsie06KHca2cR7NuXVzGGcC0qfsATIXPnF8qB?=
 =?us-ascii?Q?WWMvfpOqWfM/tZHUDbR4uhJpTFMkcpZ80Xfy4qWqQjpQ5n/K/l1i2vxIN6pg?=
 =?us-ascii?Q?Jddq0QEA9x7sFP8oKLZBN1o6zYH5FYUxWAYJwVDrbLGTJMp9A+wECghrdLIk?=
 =?us-ascii?Q?HqAYfVVd7k3QzfOWgtfv3fLqpFVjiJhfx/N1/GqUraOsMHKidy60tEXrSv/5?=
 =?us-ascii?Q?SrGAJPL5DPymWZi6HCC3DKRlFhQtybM1QsJqjR4ifpmpvqdZEEL38EDk7HS8?=
 =?us-ascii?Q?OMWc6tw8b3MktrI79vaGjp6yZxl5wmRv7qc60GHqHWDFXSHyZk1cP78gkti+?=
 =?us-ascii?Q?0XE51iUTduxqmGWP2D+9nXR3IzYB0YbPgYWbc86Cq8z4mPeJ4yLkgAs5gExU?=
 =?us-ascii?Q?jH5qziCJ5dXbJzXY7FdL+kgyHzD5DKjMfMUG5YB+AuEvp99WjVx5jy/op+Bj?=
 =?us-ascii?Q?S/QnWtmtgXyDj2mm0upciVMm5YZFYS+GYruWp83c?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5717c3-04d3-406a-2f8e-08db47cc549a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 09:38:32.0961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MjeCrnRUF0Nyr3QHFRfjeafGlXScZWne+aHMbn+Bm1dvkrxwKYUdy5IKGa7JVlhmOfOZUtjar4XWo22lIKbzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8273
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
> PCIe Process address space ID (PASID) is used to tag DMA traffic, it
> provides finer grained isolation than requester ID (RID).
>=20
> For each RID, 0 is as a special PASID for the legacy DMA (without
> PASID), thus RID_PASID. This is universal across all architectures,
> therefore warranted to be declared in the common header.
> Noting that VT-d could support none-zero RID_PASID, but currently not
> used.
>=20
> By having a common RID_PASID, we can avoid conflicts between different
> use cases in the generic code. e.g. SVA and DMA API with PASIDs.

You intend it to be generic but in the end only vt-d driver is changed
to use it in this series...

> @@ -190,6 +190,7 @@ enum iommu_dev_features {
>  	IOMMU_DEV_FEAT_IOPF,
>  };
>=20
> +#define IOMMU_DEF_RID_PASID	(0U) /* Reserved for DMA w/o PASID
> */

Is RID a general team on other platform?

Would IOMMU_DEF_NO_PASID serve the purpose better?
