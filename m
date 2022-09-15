Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A469B5B9F8D
	for <lists+dmaengine@lfdr.de>; Thu, 15 Sep 2022 18:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIOQVK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Sep 2022 12:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIOQVJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Sep 2022 12:21:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7419CCCE
        for <dmaengine@vger.kernel.org>; Thu, 15 Sep 2022 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663258869; x=1694794869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pnAW47klNfu5Z3S54BOSyNnHM0J+D4yE9s/8wB9+JdA=;
  b=oBk3EFoaPzrkrm+OaU5zg7xIe+xr0VMspOBs8irMi0WOocUMeTVIMCnu
   bl5FIzvr9wIpnzQK1eZ6Qq2Gg2X4PgMKHPhB8c6UA4DXRf7iouz1JdRIC
   3eaCtepp+YoQT6MzANUCFtVEGaAof2QykpFsPHCgnRTefZkIh/tflsABH
   71U6MFz55u/fjRkULoxrxgc6j5jWUFFSCwLzBqzkvAd8U6rpjJ5AnJpc6
   Xzl9vmnm+ON2HxXO4idwsj6HAH4TjuH/lcySf1w42cLqNXI0CMOnMxmap
   JF/eAdmRzK3b5zYp/GfoEiA4PniN63ijcuNTgjkfqMCvaCbeO0CNqRTH+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="297488602"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="297488602"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 09:21:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="685792374"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 15 Sep 2022 09:21:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 09:21:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 09:21:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 15 Sep 2022 09:21:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 15 Sep 2022 09:21:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewIZLT0aZkiW/SZU881cc6pgfY8OCFBaJes7jVNaq3MJYYLLj2mXldtnAjHYSeA4CIenWTXlZDbfIuE9NjAfE3tFFQ1PazG+2TpphzM98vVVOAMhzPGGnJeD463j9Ksl4S+3jIWDaME/1ZaUhczaJ4Yim4J/b+7XVRCYK1wZyu2vgkQ3t8pkC7UpxQVdIiHQkHCg8V0WYzPCu/x4z+eNL0yyVXF9DYz1zk+VQHQadlBZ3gAVjjXAIajVU19DtVILUf3IZrvf004woXIZSJnHzqgpXJ8e5DeeZS1ISzB7mRFiBQ+6dNMJuu3yGrGE8OceZ2av8Tlc/uvGaV0bdfg4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnAW47klNfu5Z3S54BOSyNnHM0J+D4yE9s/8wB9+JdA=;
 b=ArQQN4WxK3PwZNO21PNP58uT5okozQGL0jp314MjgSwAZgb0PrzA7QrMu7zyCK9ZDTb0x9frDx4yzlOYjBtoxtea0inQL87T3JOmhne4fhwbMgM3LQK8bj1vdYLSJx6jEupXWFm31yOEoYt+vhCFAo4mj082UaN3BueNW4tv5sXzuCS72vzRJ5OOLGaN6126ecn0Vp855z1B9JTVcPBGj54akWpwtNY/vqxigy50zm0Vna1HUKL2OXh7gg41wTrDo5GH3r46zBzUWvGx1Sv8mOy2T/PXU24Aok8Th6MfMm2ppTZJF4jyp25GMSz9RF3Xertt5i0ypgcQC4otH78Frw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SJ0PR11MB6790.namprd11.prod.outlook.com (2603:10b6:a03:483::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Thu, 15 Sep
 2022 16:21:03 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::2d97:942e:8216:766c]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::2d97:942e:8216:766c%4]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 16:21:03 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "Thomas, Ramesh" <ramesh.thomas@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "Jia, Pei P" <pei.p.jia@intel.com>
Subject: RE: [PATCH 0/2] dmaengine: idxd: Fix max batch size issues for Intel
 IAA
Thread-Topic: [PATCH 0/2] dmaengine: idxd: Fix max batch size issues for Intel
 IAA
Thread-Index: AQHYqs5k+3kjkZtlZkS8rDW1hVbuYK3g6C7g
Date:   Thu, 15 Sep 2022 16:21:03 +0000
Message-ID: <IA1PR11MB6097EC13718EEEED2A15A0F09B499@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20220808031922.29751-1-xiaochen.shen@intel.com>
In-Reply-To: <20220808031922.29751-1-xiaochen.shen@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|SJ0PR11MB6790:EE_
x-ms-office365-filtering-correlation-id: b7e4d2e9-e113-4a23-dd8f-08da973648f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YzPPIkXvaeUVvAOsiqB15zme1Zo4v3ygoDarC/vLno45VvV3CBsdmpGlDtxP+bvBoCjQ6yYE8jlsrjkiGhyx4f0whaH+Vlj4mfnpL4QyFvqUDGVud+xUqYTKVf6p5ICRnNQ4vslc7i++so7foU72ce7QVy0Typxl9Dmzogm0qVl7X7uMDihQUu3oAmauGoVg0mF3+3BJLNJ02ByrlC7wyrsuPDawS9SWgqVKfTs6cCyfwG/36aB2dn07UtvvpWUn3m/jl48QHDvHGqlBQy1noIrJhhRKPmGlNoGSvwC9Cfj74j4dDrXIl6H1ZNorXXQ0jjsi32iPGE9Z82FDLQM4fmvi8Ahy46hhPnENaa7UhrzP1L8RzBX5SVL4WqYPcsVuNmqDOK0ocB8Z2s6yLXVrHkF1Z+/K5pVl2TFKQ0Cmn0F+JnMVABe2IwHAPaojPtKF+rkaUW5K2IrEee6onoTeBV/9A1JHHDp4xXtGmttTouEd1rFk7ktmtllGyGKdfN0Xs69uSDeLY1uK8MC2+8h/Gr8M9pnZmaZGF08MgknteizwB3yOLQt7kkbqQxzIEkinjHMgSrLJSyz6P+V2eIkD6lybjALd2Pg5sXeE6xEnE2wMVHCP+Y/RBU/AbUDmJiT6cZGuq7tFPpGdbHH8yJXUmVkw+B7zf6NxHwrhFChIG2qFLQkdnNF2om2rgBAbSeTFk9XK8+05eLQ5jwyLDxH0ZSVf6ux+mYYGhJvD7ymgLWQ5Qh6LgR5/cnSB0RNorl/DwUQhk5KM+AML2QEnoIDM6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(41300700001)(478600001)(71200400001)(186003)(26005)(7696005)(107886003)(6506007)(2906002)(9686003)(316002)(64756008)(55016003)(76116006)(8676002)(54906003)(110136005)(52536014)(66476007)(8936002)(66556008)(66446008)(4326008)(5660300002)(66946007)(122000001)(86362001)(38100700002)(38070700005)(82960400001)(558084003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kONoppyjswWMjQUnWfo/yD+6E+0AVIeIO3tyFEv5R7dGo3jKPUCmVvr8YWCZ?=
 =?us-ascii?Q?sQPGXwvXnh1XuGiYlDuXM0YpPcQ/qHGhjNlPUhkmpQMKtpK6wNg3KevpDF6E?=
 =?us-ascii?Q?h7tJupJU9JZgJRiVG3rq48LMwarCQN6eCnnhX3+YS2bho5SJlU2ZIG/HsONH?=
 =?us-ascii?Q?zZrhXajHJEaejm9jJWwVl/EgmOJ/fxkCqvYQXGeCu9mHtv5tJ/PoX/l2C+fc?=
 =?us-ascii?Q?UiQSpP4+kzDcv+Pa6qxn5MFv7hgf1YZsYCvdaCrHyLfp9F+we7vWB5oxLS3r?=
 =?us-ascii?Q?DKyVGWdH1Zb0HFc6FHIbkahXRyCcnZNRyZ4Uuo80qe7f1qrFS0NL/DHXOoa4?=
 =?us-ascii?Q?94womZCv9M3asWFD7eRmotdTqg+1X9KfEjIF30Vjf9QBwYEp1ONE7dAiptYm?=
 =?us-ascii?Q?XI8nzOu3SBq6pdPQYrcgJJ4ISHAniqOCQHcQWNDHVpRN5yjqdK7GXbbNy8ua?=
 =?us-ascii?Q?tDUtTNT7QH/eHtdi3Aji1zSqLJDXkUMeqQrLthABR6Cfdo8gKGLeHy0HI82n?=
 =?us-ascii?Q?2he/4lDZ1PLXuIKZrxCn3+xGU8j80NasC2yFxmX8sJNH+eJl+IKXg8dsSFA2?=
 =?us-ascii?Q?SpyAhonTBDmv2gU9N4590Y9n6TVwCoOA/Klwr6DkxKFp+3ongpRlmTWhaVpR?=
 =?us-ascii?Q?+v3Iu1ThIa5YqoJ1ivcT6PWFKz9QczyPaWy+OyOUZkwxj4UYZkzNS99Tpgci?=
 =?us-ascii?Q?KNEf7EzsZm/B9OczXb1v8v5JKxIPsKX+NmSaM0kIjY0eYkd29yu6WSkjqQIr?=
 =?us-ascii?Q?poiBFh80IhDB67H4CjxTCoF0IImWabm2+6jh69vONv1VFt32UvnD52eBwXPF?=
 =?us-ascii?Q?+93LmjJNRtMPeWw8DqESC7K8DXlJzSR69CFoQ1i3BvMDfzAXykzmudmdPU5x?=
 =?us-ascii?Q?R1TCpY1N9LH7x8jnVzFhnlKBi3t8kMY47/uCu5m3OG2vj+Eb2M1A2nPy5t8W?=
 =?us-ascii?Q?k2bGFdKGpoe8ff9n+tCTR4iY6TBxsFBqVa31WY9jwtKBioRbRkSW/uP0tDp/?=
 =?us-ascii?Q?nj+OLDX+n+2yKz6h7OFWkIMOs8jKRBlBlzfGGm31bQIePDS5dk2VJ+OCYBdh?=
 =?us-ascii?Q?a21jShQeiatMKZbJWrszxanHfo1QXwLsF+nUbTlhj/F3esfFfk2lUgdD6Ly0?=
 =?us-ascii?Q?Jq641h/QaSD8LAEMEfGDZa+EpyIiFd6WGTUEFvcsZ6gkzpeXbGRaN6sFWI4k?=
 =?us-ascii?Q?l9Ym43m+v9Bqb23KrTFlNRNT1mXZpDMbyJBvYuXMjtws/8zPzzBFquxH09pP?=
 =?us-ascii?Q?5L2aTDGEjnjV6aElOMeL4RwMWU7RHQ6V/WITLeF/MOhEytNzNj62i4AsYmKX?=
 =?us-ascii?Q?stqZjqBymCSnNOyd7p3d69voaevWhyyK0p4jxCgJGhEyJskCQpXpLKug5Yis?=
 =?us-ascii?Q?mun4ET63twt04/f4Jvj73A6qFAO89MsSongA8NxtIXrn/WBZb+zeDynzczQG?=
 =?us-ascii?Q?xhIroKhyVBPcEXNzW78fpU+Buywj8RKS56IjMZiqcIoaf78Q9BlxvAf76SCe?=
 =?us-ascii?Q?j7RuuyDlj+BlIMvSPVpqAgSfgMkk6ZddndzZ99jaKGraLpNV9MhbjvzJf+Re?=
 =?us-ascii?Q?GwJWHTVhRvrbJKHK0t9gEKO6EdMCHxvWPllFMDJD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e4d2e9-e113-4a23-dd8f-08da973648f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 16:21:03.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTPolKwe6dflG92G80y1k3fVQ9mUebZz/LkpQNnvV1JSwpDkT3CcK0PXqBpPqQXTcI1XxKFieTP+GXpS0cARbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6790
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Vinod,

> Fix max batch size related issues for Intel IAA:
> 1. Fix max batch size default values.
> 2. Make max batch size attributes in sysfs invisible.

Any comment on this patch set? Would you apply it?

Thanks.

-Fenghua
