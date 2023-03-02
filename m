Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975B66A7D36
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 10:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCBJB3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 04:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCBJB1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 04:01:27 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE803C79B;
        Thu,  2 Mar 2023 01:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677747667; x=1709283667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ED2gMpykE2yY9rA0rj+nT+uhfOENWr1HDTmzjoiKWbo=;
  b=QGSmDp4MEvc76WNtEhCjcEhSyD0hrRd+djPPi1UJTnXAbgYKfM7KQ8tZ
   1xPq1ag5xoJ1n3vSJ5iotZGDdt2HJiYFRF7A+8RmtZFMA2wkb4G0LlcnM
   AcFpynQQgpqdWRJ0afae11jN5YYCOYtf0PXjQ3YIA3D718ck7CwaGayEF
   txmPnDWN848bqng2zZwUcv4pg6x0wZ9ZbIlw2RC1cZHk/fVa46bZoFin9
   m96k8KQlCa4abPNNj+eLdFt1uDaTi5ufBd4beu2BsG5YgmidviUAQmbCb
   +ajLGQ2Ze4cQoizsueIfDsPNjo+qB8HZz55J9aLTXD9twAz35QKiBTtpl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="314329896"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="314329896"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 01:01:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="817925805"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="817925805"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2023 01:01:06 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 01:01:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 01:01:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 01:01:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOpmbA7ORwScukdQ+trcXBfiuB4kfdIjBrDl7aS1ZD0L/Cn1KFMlKsYcLDj6avpunhNQClpLOPHd0mPkJzUTdxIJdStM0FAkIVmyPMdV3xizT3/O5K3Vrr/piTCA4lU53LQsKO6M3+0u649SHF32U9+tpdpD/whQ6lWLR3j6oqGlO8uApS0LBj1N5J1Fa/EFm8CCpyaAVwqedlfBFyJjvam3yiYkyZzOVr+Z2NdS/rTfqugjv3EEbpiBSXT49T5blWnHasV67iRxTWMHV284kQN/aIRmPnbp0qCEy6MQWg/iLJ5IOpj4gZyuaazuXSGstanM/7caxBkFYaNE96106Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED2gMpykE2yY9rA0rj+nT+uhfOENWr1HDTmzjoiKWbo=;
 b=RAleokTIO36z4JloxQh/uPc7bTb3clz3j8zuuueqMpBEyiuROwIFAMRXN2MEH+u+o0QkhzwJXxef9tu/Wr99w6ukfEuhn41+PSyGdwyhhYDzBrU1Lr05IJLf3KnezZ+xryJUZITRwKuaMsvEAImgR6+wl6PjjPB0HfOcQi6NpqDTGxJV7vI1IVv/SgeooDnpYHntzZC6XXnhGdynmZCRiPwbd/ivyiiJbo8kUy5voqJegRQ/QtJjtdLtlfBm1/Cc1KiHjFPpoRo6zjBuVKn2S7Odffve95wZmTXgUL/Gse0yEyuiSunNr0qHZL97fUWbgIh2K1g0R2C99U2yF0wXKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 09:01:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 09:01:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: RE: [PATCH v4 6/6] iommu: Remove ioasid infrastructure
Thread-Topic: [PATCH v4 6/6] iommu: Remove ioasid infrastructure
Thread-Index: AQHZTJj8H4VtysKIYkWyYoFTqcgc7K7nMb8g
Date:   Thu, 2 Mar 2023 09:01:03 +0000
Message-ID: <BN9PR11MB52761CE74F9BC4CD6F3A6FD18CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-7-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230301235646.2692846-7-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5015:EE_
x-ms-office365-filtering-correlation-id: 41014e27-9e10-4558-35dc-08db1afca6d0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fp5JPZIbftcw7HTMHotyCJRqwgYkLztaRKXstGP0mtvrRNVwosII82gr4ktLzZWCVxkajuK/+g5UOqoMIrBzzfP/wIe2JYMhN8/DYqetGjxIIIy029HaXzXQGh2V4Bvov/jTUsYPU00Hr2E2gF2zBmoGufEzZMnThkiMCER71IE2Fzewimynm+XL5hmu2hWUuw/gsNKjqeWXuQa1OvhtvfoVXFOBCyU4fohIlWYMHuikupy4tUlmbVgaGBSmE+N1i81cUXYJV4dq5Ut29QgyFkYF8kk7tz5GO6YiW6KMFcrRe6ZiyJcooSFoZYRax+LQGZIFOA33Bg6zg3xv4bIV63zxyW+vlZZKg2PlXbOsnAkPZth1lxfn5LXJWf95UqS5hGiNawYVybygG4x2Dyxx3J3ev5ujOF68F2ZBvOsCvUVyIV/sj0E3uPQ+Uogb7mqogpIo5sLxibRlMd6CxXwzhvXDMp8hctuzHCr5iLWriKYG4s0p91ktTz4/ISGLKMFC78FW+p13olus33FOkQsh0kp0kv1uq0Dgk5WfV6ibkMcFzhFryBww5tifJH7KQ1uKZuUP9xEUCo46n/3hRiijnkSyxof5ORgXtxaVHeAfePNoKZp+Z7nytUz4PC0lXXYUHN0zvheaD02mm/82J+lG8BElN/JzlC04ZBliI6EMnM2AdXMPspou2aQq2Hsfos48ZWryjO9w/Ca4xbafRM3TjbgXstzrLk28JmwyfYiJtmI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199018)(83380400001)(33656002)(122000001)(52536014)(5660300002)(8936002)(82960400001)(7416002)(478600001)(921005)(66946007)(558084003)(71200400001)(55016003)(86362001)(38070700005)(38100700002)(26005)(9686003)(186003)(6506007)(76116006)(66556008)(64756008)(2906002)(8676002)(66476007)(7696005)(66446008)(316002)(41300700001)(4326008)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h2aPm1lM39ypyS31JeOFoBqdd0ex+RKiDOH27smakQnDaZhzwSv6Ok1Zsce0?=
 =?us-ascii?Q?s9CAaR2iRSwWt4rMCZOLWksh1FjcRD+IE1ywl0vFoVoNjpCtPJTV7tzAswU4?=
 =?us-ascii?Q?GiOuIhAZ99jiODapZW/FT7EXY6aM2w1eUIHdKJ1wSVfV2kGm3ZhgQOGS6xYU?=
 =?us-ascii?Q?sxAHq47G3Nn/xwiGE76oZ1Yb79kyEAxxFUVB58CZn/SHbmoWp13InKO9KYn3?=
 =?us-ascii?Q?8rnR2ceh29FWdlboBIeoP+l3sh0qJxofQnFMFX3527npmBrJyescEu9NJaAW?=
 =?us-ascii?Q?SMYoY4b6YyqpJ7IENpbGAK8rco3T8iT0EfPcp6K0IxElcwPjNcihXK7FPq27?=
 =?us-ascii?Q?cphxjXy80bOSuhS2o4qCwttBTc0pKQkw6VyZkETbcvZVDaOzajAr/LP9QeNK?=
 =?us-ascii?Q?dyiKFAjJtMMOLh9uO/WXrFShONuVaCU3qXfFdLTXqatFHMviUbjrciWzGbOF?=
 =?us-ascii?Q?FIYSuLCFQ+LQkj42HszOUoSNUw+WqMe/MtzzXw606EoOekjy9RtcOruRMIsd?=
 =?us-ascii?Q?46eTYL9/2sVwkdL3NaM34l+2D4v0yHhttg6wC838EuMRHsHS8WELtnlsR08A?=
 =?us-ascii?Q?EIwc8sykr3B+e5ynJrnFzviVFpeyay0FV3Z/tmQifj9AFLKEVehAfIRvJMRb?=
 =?us-ascii?Q?dgJa+oksqPaMtYqoj58OezZ+0XjUDn1sfN17hRBLKtGgul6Updl1N/5iEOoT?=
 =?us-ascii?Q?e3ek96VCoa1Y13DxGUovGrOXzOjQz3Bg9GACBybJGHmvXb/1CiMzg8NqmBjd?=
 =?us-ascii?Q?eNGcJlfEtgfEtXCevjVMeFJyW79v18QNsFnTu/vDcWaspvPovHDiGfH9hBMP?=
 =?us-ascii?Q?eg/07C9zwIU00IppGuHuv8ZxF8UniuEsazvTgQKKQm1ill2Jwm+rW4SOsBcs?=
 =?us-ascii?Q?BpQOdHmeAPitH3+aH5zjyE9Xzek8XoLgC+SWo5cX+oPAcO3THXqMApHhKNug?=
 =?us-ascii?Q?R9uDAOByPVt+5vf1dtGmmCUONLgv2Ac0cw93RjYeZk1JbAnZRhShVePS6x1/?=
 =?us-ascii?Q?cOPyZscZ3RJoZhVx1pE0E4/TxSYAyKdGOpYBv2CFBJf2Ls3mtTLUGmJlTm4O?=
 =?us-ascii?Q?JHxu112JNqdJxxxQE7wW4TiLBW+Y2NVd34XMqXhU/DhUlT82U3tzimsu/P1s?=
 =?us-ascii?Q?zlAhgEGOLNdNcxIwb1EyVZjk4Wv205xtJPAm5fTS4weROnvxFVI3HE3TgWFJ?=
 =?us-ascii?Q?1UJtYioM/FS0zEgox8PBDyiklJzrOxS+bURqFSADHmw4un7whuNPuc98pwFg?=
 =?us-ascii?Q?BHk3v2QOSTIdvXLrzeirAWeD7RVkgrwwY01cVwL/yDZ8TjuaDrLEC7P/OKwW?=
 =?us-ascii?Q?vE9sbJvBbWcDYyj0Q7H3qTSt3VSsMfMmO7TtoRkungMr9P8TdA6nxPnWDxUq?=
 =?us-ascii?Q?iq8A3B+gAUm2tCdF5/TG7taPabJ6NXZi81qWSkXP7h1ED0JawmGoi0vAMkxh?=
 =?us-ascii?Q?+JyV2QqMi8ikjjokxTQLSAn2MV0af/g+B7tNFAaAn+ggfpOj5Wwt5tx77wRc?=
 =?us-ascii?Q?B9hVPsB3u7pxOYxDqCQgZ25SyuzAZ48KzReHinuni+i5+STCigMegAH8vUl+?=
 =?us-ascii?Q?UwQGa5Fu04kDOMNKVmHw3Oc900fyP8Eiyt0e1SM5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41014e27-9e10-4558-35dc-08db1afca6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 09:01:03.5645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kepd3R/Wr6HmanUuSZ8p0Mew2j8u1icLiMavB7bzC+7EOypt6PTffi4V8b9ADp4uNNwb83aigncu6hGQPT5hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, March 2, 2023 7:57 AM
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> This has no use anymore, delete it all.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
