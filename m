Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888D9641008
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 22:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiLBVci (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 16:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiLBVch (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 16:32:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBB76243;
        Fri,  2 Dec 2022 13:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670016755; x=1701552755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KCjUAdUW4cpHOiVAcBk9SXzi8eoHPQRt6RBVo+Wv1h4=;
  b=bFDevXZzggNGisGIUNQA6zNK+vo3pPwWSwsIS6nhZn2DWTnbxQLvJodO
   ZvPZirmH5JJuhksg+zThLsDh9qpQzSzOD7EVEpT9MSZVzL3HXt/cvi3Sk
   xg9LXqNPd++R2mOy7DPV4lz/qRQnJtvMUtzZVhyfwpSrv9VQ+tAR3bfKB
   ltkCFkyKzy/7NgaffI1aDy9Tko1vUVbC6jR+RNjq59hyZZpC1MIU4949D
   2Qi1GLUh+bAdzn4McNcrWLDzLbwKx6HpRA+973eJVljSaTjB7HVH3Fecg
   nr1bSErmdGmZIiX26fmZvQvs7bW6dEAA5L2xRQXIKq5Jn4Cz6HF+M13ow
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313686433"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313686433"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:32:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="733951510"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="733951510"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Dec 2022 13:32:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 13:32:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 13:32:34 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 13:32:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9a9BEuwxh92cW+xgxpXY9oGhJofaDyMn3Pugfr7gGR+8E8WW3N7ULpRQNlOjuedKATRNmPSjb5H0uo+TC++3Kb+ru415ZQJQiN5p7MTgCklYvU161Yf9viKo/BEP5d8LfyBN1+ENFbiVXLy7AFvE4XQFb1y0zFbEGm5jwoxWoaXWm0YWwloUSvckLpv+cmZ4UUSta90T3g0nA/w+UWkrPqD3plZNDCIQvXYQ5Nyh3C1lXNcUzwL2M/Yz+o5stcucnh5wcgkn1jz9CZcjAKpTW1xIxJ17iTK69aeLWoBAk20LRgysp2PnN8j8l9Es+CeJbhhDjuxHUYObEaFQp+Hrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCjUAdUW4cpHOiVAcBk9SXzi8eoHPQRt6RBVo+Wv1h4=;
 b=eQ868aXGFyf8myer6U+vz+lpPV+hx4/xK0FICfUdQvE81bojQctuvV8ZNEAMnJc1e+8s2ZSiafk1j5mrMusxFvcuieylaBqS3OIEautJaUdSW8N0l0keR/zrlrEWNFmxdvJ+Eg8HfuiNeh8T4ZE+jVOI946n0mUi3Bbql8Qcnfk3XE6Q8YyoZCWVF67xVkk0y5U8UqCYfhy50lIMZWw+l4+Bs0xaRLlBuhLDSS687LzAJZVbkDcj+yUGwZ1HjznGIqVvsutvTOgv04tgLV+brSbDAfb9AKY8vPfgwJLRifT2hZc9aSGh309FmHS5fWcCZmkZrNDVNHZpxAx1UEw5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS7PR11MB6200.namprd11.prod.outlook.com (2603:10b6:8:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 21:32:33 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%9]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 21:32:33 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] dmaengine: idxd: Error path fixes
Thread-Topic: [PATCH 0/3] dmaengine: idxd: Error path fixes
Thread-Index: AQHZBnt+WKPm3F7owEOzLuE+W8V8HK5bG5LA
Date:   Fri, 2 Dec 2022 21:32:32 +0000
Message-ID: <IA1PR11MB60975EBC4B91546429A08F699B179@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <cover.1670005163.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1670005163.git.reinette.chatre@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|DS7PR11MB6200:EE_
x-ms-office365-filtering-correlation-id: 5180c064-d377-40bd-596d-08dad4acb903
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P01PTMUp/J0MyuhjTTdPMl7oJamLxrpyA04F6vyrCpMbz8q8Sh2N97tesoknKNYxqurLGExibeAV9cf81Mn4qDF4F+Kw8Vj5FU4uXQ9arMe4OymyFppXrxJ1h1Xv9u/0ZQNSDsn2FttkPR+ziwGGAyV7KCQi/6/S+1ueDo+2Wr67Xs/SiCO49+KSnfq5DhdNM80TaP3t6QRamYvJbmGbK3U/16WEzE2N88d61f4fALvSB7ZpKDjuo962tMFMKWuvIrPLyV4aOXe5VQaFTRisoQH8Rm2ISXcwlP3ZDtGX2cH2h4b9gtySzNsE5aSLXoC8vzTRnCg/PT/sGDYO/kVbez45iZ0aCHZs2Bfj77Gsp0CsM8hg20NpxgC7W184mZBYCJHjIGo+uXikp05PjDRYYvymSPZ6on8iLeNEIq3lavx5GWX2kaDqDjceQPAPMKxuRW2ncfHO4CfTnIpXnn/RME7yVILKAMjPDtaLcFKbzOqkKLpVt4jw0oCF+UKharBpSXYspEwul9tJh4fgjzAn3m50clDbplS0PlEqHes872KLU4tU6Osw3ZjdYFc6wmwLaFBvXzeYCIuhFd/15nvtdLXrVpurSgp2m9FlOGwuQ36E6VVXDmNsqUgKNg4P2djWEmY4uIr8hduiaUgcXvJwZirlxCAT8U3FuYSGYNUJSeUgm9y/T3Rb4yH1LDipJDsOKZQ6Dl3RBoESLBBgcUycxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(33656002)(41300700001)(82960400001)(2906002)(4744005)(66476007)(66946007)(122000001)(4326008)(86362001)(38070700005)(26005)(64756008)(66556008)(110136005)(478600001)(186003)(76116006)(71200400001)(316002)(38100700002)(55016003)(7696005)(5660300002)(8936002)(66446008)(9686003)(52536014)(6506007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nfpADiX2EflT0r4GkfjBg3+eJc0ClZ1SSaP1oR9hhImS4WUYcxNbk4IE8Sot?=
 =?us-ascii?Q?wYDDry7FeJHifa4oosGkBa8BqJaHPo1VvtpKG+U8R0sKMcbsKOqjFJu3ilR/?=
 =?us-ascii?Q?TScS8TgLqTJNJ6ecElinxW+4X6qDet2X/zWB+m2k5F3Pqi+mjpPWIwmHPqzf?=
 =?us-ascii?Q?Q2SEYhgl9HRlKcOzLDWHsE+UPEcJdDfiG8msAEz6krdykO76xtq0FPPt63kh?=
 =?us-ascii?Q?woLssKd77xVwFjvHHSPYg8IXXLLESyEUeL03QHRakoI/stUhvS+nnSKQLNTP?=
 =?us-ascii?Q?aRNV4WpJBAFoYYuRn2bkELQT1bMBaWNR4kSTEImbxtT06WxNuDUgQoqN131b?=
 =?us-ascii?Q?jpxT7/GfqxrZHWqqdnIqvxrQ2zHCmFPhtlN18XuviEhxjL338YO09C6VPcVi?=
 =?us-ascii?Q?mH+oF+8bQDQYCp8CbSFlD+bHCUel7G5oMZkY478eqCi1mRv6z2x6KCxsTA9H?=
 =?us-ascii?Q?+AD+UejF5uPqXRW5kUEbAuuCIjatGtApKsMR/+B+6usvnR4jplLIG2i9L60h?=
 =?us-ascii?Q?M72Jf9F/nzt+qjx83+DsebNZD3WuVVaMqMTaG0EanNRLzTbtpr2KyI3lmW95?=
 =?us-ascii?Q?PZ92nMySZNWtqoWWQKcbp68C8pHZpItvLN/5yTzNqGQOoQrl/DcHDuG+W9oo?=
 =?us-ascii?Q?8b/ky25Q/WXWEk/4E8z8telnrJN+qQYKUzisAh7s96kV6NxRbQX32wDwOeqB?=
 =?us-ascii?Q?bk8FyWWabwqpvhS0zWS0satTiBWkLRAkXUMBDjuTcxczwhFyQhye141vTdeo?=
 =?us-ascii?Q?noTFbbWftAgD98r9vqmX/LDPyF/CLfT+WYL1liPKIJ+BaOvgPBmGQU5FKX4i?=
 =?us-ascii?Q?LijGjaKKWUuUniBqFMFEKX6o9+PUZxFInEAgltl845TXRZS/ZM3pAck97DiQ?=
 =?us-ascii?Q?6OwQ3fGlKLjEfQo6ZoQy8p8RVTFoTiu/xzeDBw0In+JY2dNlrPLqN5G86hxi?=
 =?us-ascii?Q?usf9eg62bw0VykazS+jqePznCHfswGZvf8R0o+KDF93pDWogs/Uyrm62SWt6?=
 =?us-ascii?Q?f6BdfuzPZOPXW/9ecRHLRBdkEKTAQjsW9n1swScNpy/5tT79pXakNLNPWDHM?=
 =?us-ascii?Q?zo5R8zUc9WJ6YnkYS8j7TeimgaIYpHaMW5J67nc6UcdvtNE/Dxi9lrBGS4dM?=
 =?us-ascii?Q?gwIZ3V6TPq6RI/+hQFoRp3OcsKEg1K5D1mcxEqWG8V5M9o1skQKiwEjJ0E1q?=
 =?us-ascii?Q?enhUhQYSkAza80J6hgLszqpKfvu+Z1QsowHm1qd2uNhyKUGfWitXpoih/87t?=
 =?us-ascii?Q?y/cOGj57gAWzCQhq7lA0mJz44BB2Vm/XekKpVu9UC1W0EqtQWSS9l30P9w7W?=
 =?us-ascii?Q?ZlopOs3r+Ikl4h8Aa0VzeErW2VpadB0CO/c0C5CsyJoF9ch94diB/5RRS/ra?=
 =?us-ascii?Q?KNsWJ+cPvLDbIuPvkyCtEB50TSsKwomsX+9uHr9d+nhC6xweyos9mb+iSxpH?=
 =?us-ascii?Q?FKOHRwhM37SAGe7k18xvOhBYV7kKXq4SsE9nYdZHrQ5YEei8HGUa+56vvxeA?=
 =?us-ascii?Q?ottIPfP7aVKIMStow/PaDHvS8+vbqKIx+DpLKiFQk+Ve/C2ByC+kn2AMqsWq?=
 =?us-ascii?Q?ApUYPsQU0n/pGWZ/Y3f9QoGddSRa9K2mhF3g5SKL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5180c064-d377-40bd-596d-08dad4acb903
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 21:32:32.9501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zHnSbrmL3DdSX8YNCNgHFQi/1ERnyeQ67UQ9122hbAUKbligYpGOnFoKVJGpuXzZnsI8AsYEpyuMk777yiq+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6200
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Reinette,

> It is not clear to me if these are appropriate for stable so I am not inc=
luding the
> stable team. Please let me know if you think otherwise and I can add the
> necessary Cc. With the refactoring through the history of the driver I wa=
s not
> able to identify a Fixes: candidate for all. Patch #3 does look to be a p=
otentially
> complicated backport.

It would be better to add Cc: stable because they cause series issues.

In patch 3, you may add Fixes: 403a2e236538. This is in 5.16. 5.17 and late=
r support
SVA. We don't need to backport to too early versions.

Thanks.

-Fenghua
