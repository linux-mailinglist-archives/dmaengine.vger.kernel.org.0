Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8448F65F56F
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jan 2023 21:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjAEU6N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Jan 2023 15:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAEU6M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Jan 2023 15:58:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DB835933
        for <dmaengine@vger.kernel.org>; Thu,  5 Jan 2023 12:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672952291; x=1704488291;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hOKWjXa8yoFACwvopSzOhi93eKiuX/4bQtqNaD6MBa0=;
  b=SiuiSG3b82jlk04FXP40esVXnLBpJw0+E7VX+OjHdWed/ngAbfLiVRCB
   qUFyl4O7gxKLxb5itBL4McI8f299bQMFHwzEAXagQTyz8iParTIa0i9WC
   O6L6eCMiXS7XUsZDYTmT6B6YXKXvuFjfUHF98iOe1mEAdZa9PXx7S0/N9
   a9bw0LzbLPSuGiTuXyjMlCrm6KBJpHIY1lox18Y0Y7SPUVuyFCSXCtCN2
   ckOGseYsV54HnsId8JWT1gcuHju6TxbeURTpW2iV2nMcpktocWYz+vTdZ
   N4P/kFRdYGF0D0/DkJxIbJ/7zLgnvABVJGEu7RPUcWZ9nY+YxfGfS8pQA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="408577089"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="408577089"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 12:58:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="633286297"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="633286297"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 05 Jan 2023 12:58:11 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 12:58:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 12:58:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 12:58:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxAd0oQsU5crzdsaQkrsfvcxwXL012XXJivkToAjCt8PBziwio4W45ZnYz37Gd9VYvPQ0zRRKiU0U/PoEj9Dga/AgLazuzQQBcMsR6bpwBaWldzwGz/ITLO+IiKEy7SWLrqiU3YtyS3o2sYO4H9Lp1VBMTfbDGrRyJugascaIeS2pLi7OKJq8T35vL1x9aPddKZ3s8xMhhO59FDqZBuvL8WHfMCQQzl7ky5eg9bq+1sGVtfaETyKIrHjszoe+w+xhFD80SfHWTa0l7rSrz/m0GI+ZN/X0ndIGNJ7EPy8dP+cVasB5oK1FPXWMTPBKMvI81VjQ8Cst14haIgFZTQMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOKWjXa8yoFACwvopSzOhi93eKiuX/4bQtqNaD6MBa0=;
 b=T+tUhT/D2ose+w7FHzuDRCYoX+V2d2ox9EfFWnZHlF5forFPOU2d5nqTVt1u6gwtQfdUouXuvJFLUITrIYy6aoT5lVxJAmj94Dciax6fwJ1GrwYIGWNlu7Yszwg05/7zvfAMaR47wBOx+wlMW6YhekOZWhxUeEkZvt2qyWTTqc4BmmwaDY2PlqQ6dzSdv2gBVuU/IjH5i6PqqUnhpMcsRPHapKeMA1+snTm2TyVDum6mFxnxa8UipymRa8c7XJG537o3yD4XRMfhEFff0oMcFOu0Weim9Q285g9rB/BjKXy5SJh2TfmLAeYmIes5RNXLCD4xPTt/mWLrGdokqN51Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SN7PR11MB6947.namprd11.prod.outlook.com (2603:10b6:806:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Thu, 5 Jan
 2023 20:58:08 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 20:58:08 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH 09/17] mm: export access_remote_vm() symbol
Thread-Topic: [PATCH 09/17] mm: export access_remote_vm() symbol
Thread-Index: AQHZH5FkNhHM4hOH50a42EHT2Acr4K6M9zQAgAABTYCAAA0YkIAAGukAgACKFVCAAB1UgIAA5j6AgABDLgCAADO9AIAABakAgAEmU9A=
Date:   Thu, 5 Jan 2023 20:58:08 +0000
Message-ID: <IA1PR11MB6097D5C6C3182A3C782E99D89BFA9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com> <Y7RpuqbTAM11wVQG@lucifer>
 <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y7SMYF8MlzeqDgp+@lucifer>
 <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <87tu16rdea.fsf@nvidia.com> <Y7XZ8zY3KIRDlu/f@lucifer>
 <87k021vnmw.fsf@nvidia.com>
 <IA1PR11MB6097336ED90E27E78E069E299BFA9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <87tu15u061.fsf@nvidia.com>
In-Reply-To: <87tu15u061.fsf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|SN7PR11MB6947:EE_
x-ms-office365-filtering-correlation-id: 51b69501-b92e-420a-4a81-08daef5f8c8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfE5VMNjDqcFQEtzWyAoOqWwUylaAmFeQ9ogzoF5UbOYSg7OiwaP3J8wu0NbWXpvBu37wD6HTIYVGKF5YXPOU9bsZ1cPShSCAa4mrqkncf5qIgLm7tqumdowS3pg86KHuNllyc0h+QRwoJqdmxsDh/5VqOtZ6jEbiFxViDZ/wSmZVZJyKg9LyRoQVOyHe11gTcK2fXRtVapoxT+70DYSnaKKXgBc9HvvnUyW2a/igWGNavA1+/HIs47auwBqgeDLRhjKBRJnkirN4E2XlDA/gd5fmdJEzkZooM+7ulVkFI2x4K6oPb2syQEFHkSgsmiuAu3wcXFzalfGnHjyuhgfzEcoldd8SVQt3rGCynUF5bfbw3IejtM+eaeicFiSP+nn0VL5Caw+p+9n1Vipf+cRJyuhNPgdoSp8bCO/71fQ9epmv32Vp9DaQEURy69I5mx221GH+ySiT4XaBet+7LbzQ/ku0hZF3OYE2aeJheccjkaBWNsBktCKsiJmjuJJFiN2EU/xsCOF0YuHV9CVls+ZiILEP2e7AbLnOjwym1JYKnAHUlg4zLax4o1bnnW9wOkUSvmwN2V6o/ixh6aeDmKp8qlhV1iR0Fy5+sY+wR5LFuuoV1gFprIXHyLPxjT3XKB9jdR1O5IofwwgDxsnpSNqjpCVFLwAm63CRUv49ppYEDuy9WIRtjeLiyTkO0J7DqAnOob0q7qiaisDJa01YbtRbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199015)(6506007)(107886003)(7696005)(478600001)(55016003)(26005)(38070700005)(186003)(86362001)(71200400001)(9686003)(83380400001)(33656002)(122000001)(82960400001)(38100700002)(52536014)(76116006)(8676002)(66446008)(66476007)(66556008)(64756008)(5660300002)(8936002)(66946007)(4326008)(316002)(66899015)(41300700001)(54906003)(6916009)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wMPmnXNfMNBnJZBe2x8GILBxky53hOkqaMS88JJPTlk54z4hTlbPPMzes8sp?=
 =?us-ascii?Q?J9Q0e3EMrPDng8Mt0AZmwFUCPnPnUWhLRYy70/xfFYTtJnPOQ5drZ4k3N9Fh?=
 =?us-ascii?Q?+83MGhm3uszJFGjT0Kn4+XE85uXGAVvEx3YurLMPUoS9cFd3hbi0zy+tjcpT?=
 =?us-ascii?Q?MTLwkWOTq9CV0RHzgHJmGLX/FFOrDnn+Qx65dV7+8M5QSjAcLcRalRPPPPnq?=
 =?us-ascii?Q?wEOgSmruhU/a1LQx/cQEOE534VVcCS6b+sCD3zEvOV8XBRqnKYjJVE5H3tjC?=
 =?us-ascii?Q?wR5EaG1SBu+NnQZ5RRu0ykiGRLUgdxrc92H5AqLlg4x3fJdGmSgcGHNQmDru?=
 =?us-ascii?Q?ccbPMSbzwm10OVtimCZZ9vnXDwo4mnjJ+hNs0gQ0ZCXdUBTADE23wChw9Yx7?=
 =?us-ascii?Q?c5Dgr+duAqFlxwKyPbNs+zqhrZLMeQkbhe2CM6mSNkmH11Dt8NJScNEzH6kp?=
 =?us-ascii?Q?CxHzaCc4vZ5T5ZM1NCgcXaY6OgwjBi6EvpoG7BDAfaBKFga16Ay7PaIbUDJd?=
 =?us-ascii?Q?XUc7EcHFQnFQVyyN5AmSvqHGm3e6OAwI9N5Neda+VDx1CzJvD5dLwHK3ymgs?=
 =?us-ascii?Q?fZCj/wzV5qYVfeukX5ykxh1AvZfCUF5QlEUeofGZNOTSrZqzV4PNqlFOgMIL?=
 =?us-ascii?Q?4W7E4SynyC5kdJYQIZEsZ2CsaVlZFFAYwpcM+pMB71OQPbvnhGOdaluUu2nr?=
 =?us-ascii?Q?AQFutYMeUkT8+0wgudNMW+VS/0q2JwfMyQpJxtY4hY2i+H21XwybvdOb8yDE?=
 =?us-ascii?Q?4q99+YPsfWvZrjG/XCCvLWky/5KGYZqu/cQIfbUZnujv1cq1uFz3t2T1YQ9A?=
 =?us-ascii?Q?vnnYjKY7Nq79yzDbrNzw/y+C+CGvJTPMlaRKhfmgGp10OoEOdeYs/KrMxx71?=
 =?us-ascii?Q?SnpIzKDGOxCycO2xB1BWoHnjFNBnK4HREAlaUeSU8tYyQElEAe3C0KNr1lFq?=
 =?us-ascii?Q?Bf6upLLYoA4PiHMS/RBSdzjqZetuMbhv2s28uZdZBbjwziFxUInqqG87TiyZ?=
 =?us-ascii?Q?1Ldx0JO7w9/gZKKEUlOo9YDZczlxbA6dLsja7lgM+bJOXhLjroQp9Rd3j+jm?=
 =?us-ascii?Q?nFnS9u+ftJMJa5GAnxNkgQLWVW6a9IiugDvv4VTY+eabfidT2B7nlRbhqGtN?=
 =?us-ascii?Q?X15Z8yE7RLixs/RJ4v04ctFmgZTb4hhl8eVdeOmneqotC1ki7+/4t1FCyed7?=
 =?us-ascii?Q?UMgfUQi0RfaV/u5Zmgr7G/MVpC12h7kld6AvJjFqA48t7eIJ06xEAC+es42O?=
 =?us-ascii?Q?mDEMGzah9L6JzePp7rpe39WBgfw9+XDT4mOpcqHCPrvyR4tGjPSLO94RkKT7?=
 =?us-ascii?Q?U08utryMOfQ7UM8lCGvmuiB5CVGqBE7HYos4WpyeC+wW9lnlRwTxfBel5Z4O?=
 =?us-ascii?Q?QxnVjJbxQeUsYa6hRKKIABwrYlK+0e8vr+8st7akeaOOoSy6DDOWdV9ZQDBz?=
 =?us-ascii?Q?CPsfKff/nOWb485TRWLqMHDJTcUdL3PmCUKFTpz5TANVzUpnCEg0kkcLsnp3?=
 =?us-ascii?Q?FO5BhGelUCCTXUL2vikQYjIGxwe5saPShuMm56YnldDs4pCHgm66uBCS+n+c?=
 =?us-ascii?Q?GRO10XXXyKRa1QS2oksab9Nss32SG9PtyMjvYQ4K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b69501-b92e-420a-4a81-08daef5f8c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 20:58:08.5226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vMODae7SdzAKOtv9n7FkyC885gY62LT0AIMoG4ZrI87gsoyoBT+Iv4AZYXBb6Yc1c33+snftPY1iGU44Vdx6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Alistair,

> >> Alistair Popple <apopple@nvidia.com> writes:
> >> Lorenzo Stoakes <lstoakes@gmail.com> writes:
> >> > My concern is exposing something highly delicate _which accesses
> >> > remote mas a public API with implicit assumptions whose one and
> >> > only (core kernel) user treats with enormous caution. Even if this
> >> > iommu code were to use it correctly, we'd end up with an interface
> >> > which could be
> >> subject to real risks which other drivers may misuse.
> >>
> >> Ok, although I think making this an iommu specific wrapper taking a
> >> PASID rather than mm_struct would make the API more specific and less
> >> likely to be misused as the mm_count/users lifetime issues could be
> >> dealt with inside the core IOMMU code.
> >
> > The iommu specific wrapper still needs to call access_remote_vm()
> > which is in generic mm. We cannot avoid to export access_remote_vm(), r=
ight?
>=20
> The wrapper still needs to call access_remote_vm(), but that doesn't impl=
y
> access_remote_vm() needs to be exported. I think the logical place to put=
 the
> wrapper would be in iommu-sva.c which isn't built as a module, so you wou=
ld
> only have to EXPORT_SYMBOL_GPL the wrapper and not access_remote_vm().

This looks better than exporting access_remote_vm(). I will remove this pat=
ch
and write the IOMMU wrapper to call access_remote_vm() in v2.

Thanks.

-Fenghua
