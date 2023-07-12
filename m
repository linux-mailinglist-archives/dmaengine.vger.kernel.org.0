Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E191751429
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jul 2023 01:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjGLXMG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 19:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjGLXMG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 19:12:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA631BD7;
        Wed, 12 Jul 2023 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689203524; x=1720739524;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i9ep4U+51R2Q0GhV3rWBd7ubemsDq3d7NZ4L3W1/H9E=;
  b=LQgKbhSzMOIMKBn5eJc/SozzczUjGxgzkzDhLJCTVVXK5pEFfhcnAw7M
   O00UrurOYRSF4qEUND56p+ym3FS9FGCvhh4OvRw+UgACg/LE5XtH77dKF
   OC8vYDWsJR7ZUUUk7qzkSHwQotC6mPLFlT0DqCZYvYdNk+GsLRW7eEZnN
   r4gFhOlW6xw/0GueJoXWFNBJboeXMDwfn747ZSRiVJ3MWEuSyipwU2Ldi
   2q/dBdqVhlSrtU7fGOb6X4BYymiy/kE8GooicfYFr/5yBOjrZCqJtbWYE
   7Xi2hVOyAWaeIOyWmOZ6+JUDTbKpQVZDt/w0mTzUWM9i9OP1hUbbBx10I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="363897432"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="363897432"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="672048429"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="672048429"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 12 Jul 2023 16:12:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 16:12:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 16:12:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 16:12:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMPopcJDFXS/eQeaFrRGRthmRBxtlnSvdJKgYTCZb1aKAFkRpvClmH+bLkTDo98VlA4l8cu09amOhZ0uZ3rrCGlyrVg5rawgvwULteHAYVnURY2d5mQ2F4+o0k/Rbq9czw7JEGYiSZxRQ09EA+HCcF7EciA3VJJF94l7gN+vfogQNcCCFoiPNwJU1kpGLpl1+wtpwHzo5Qxn4n6wOk2eeb34WMHSqzVLhb9bluTm7WN1HkebYZy4ogX3Eq4KmkrBKSH2cv8LHSp9kHLgOAVR2f+dmibM0hnC34WgGKASTfXNH1ZGX1AqNarI3UngT8xHAUzGlhfm6LeFxS1D0+5yJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9ep4U+51R2Q0GhV3rWBd7ubemsDq3d7NZ4L3W1/H9E=;
 b=YRMNkSA0/Od3fJTaAZIq5c8fyjzMynULUWNyBGNdsmiBLMO8NdLbWoju14/3IaUe3sCnr497TJqVjnt6yl46nL24/DLnoDVzKPSvTS+MJD/HXyeLXVgx4hb1H9nPdqGyH2prsDjJDKxOWs2DVjeuHF+xWH2QhMq23emkegW7Hyjvb9JPWOU6Qqxqu4LhZ2z9mWZslxOi8FLF12fxf5AJmqKaE0bUNk0IvY6ZqZk8hAj/jLICE4QU+8sjEuaGRCze1FdLsqDac1Q9WvxZWXQAQqAxTmBrJCvmC5WJ+GXoW92rKm/IY6lY4IlRXpaetJE0GKndmqTtofiO0m/5XkXFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 23:12:00 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::724:7e04:8501:228d]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::724:7e04:8501:228d%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 23:12:00 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
        "Guilford, James" <james.guilford@intel.com>,
        "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>,
        "Gopal, Vinodh" <vinodh.gopal@intel.com>,
        "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH v7 06/14] dmaengine: idxd: Add wq private data accessors
Thread-Topic: [PATCH v7 06/14] dmaengine: idxd: Add wq private data accessors
Thread-Index: AQHZs2HFUWXbc6Se/0yh0ofzJ7zuRa+2xSdA
Date:   Wed, 12 Jul 2023 23:12:00 +0000
Message-ID: <IA1PR11MB609785D79B54F431526702229B36A@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
 <20230710190654.299639-7-tom.zanussi@linux.intel.com>
In-Reply-To: <20230710190654.299639-7-tom.zanussi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|SA2PR11MB4955:EE_
x-ms-office365-filtering-correlation-id: e76d86ae-442a-4bf9-2210-08db832d65a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +rLjYahOmW9WuXqm4QNchuJKZC90kjDRxwHz79RCfWeWfQPdsIG77S5RoVS7ZtW0h4wmcpcwI0TFJB5Kwlyfk1HMlTHXQr1GKbDMXKc+DwvyvcG75kEq8vbRKyDMDmrr+GBjKeCFIQ3+rz36RVRNBgo1aL4/8oPDrGbASr8tGy1rWb1qxzBWvSOG3s+ETeEioXJ1MoUgCn8YBXwG3MqSv+3VZS2OPzlFLiEOCA0+8f/JWyun5GqYAQKPpZOxPyf8kC56YC11ku6oez75ZUf3ICCcuw8jJx1mxkrtnxBi8Xs0fuOMShpmspMMsENoviA1gMY3Q7ZZTlE0NQvnPda/8ygQlWFz7uYXbrymhbyEUajjXWq+1U5TQv38zSBXICahpOZeB1j+hlVPO1KDIAlp69ha5i2eT6gdC4Why+ly8fcM/CnTQjEA5OxTj0Xja+49igGtC6vYNfI62TJ3jo9wbcDvFsphmWOOjSVnqOhJDvz9K0vSww8dvxL7mjyselQvQ8CaGxgqzL8coaPCDdTab1D8H/VfkIeSvx9D8BLIjqd6uxnbhLKOaSCoyycYv2/4ceeIQq9Sy28SW47DWlSruh9ua3HCRpMNVz6miHNjfnl4h3d0vx5gII7/4/8UFaEp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(71200400001)(7696005)(82960400001)(478600001)(110136005)(122000001)(54906003)(76116006)(8676002)(52536014)(5660300002)(8936002)(2906002)(33656002)(86362001)(38070700005)(4744005)(4326008)(316002)(66476007)(66946007)(55016003)(64756008)(66446008)(66556008)(38100700002)(41300700001)(26005)(9686003)(6506007)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TAa0rsS2i6FDsdgzt3L/BWJBQ7hYJlq9ePpJmEgmcs5mQjxGYFZaI3CZQ1Ja?=
 =?us-ascii?Q?GzBhasQ52kC2paxkUEih9vfH8zhyAzurcwb9Pe8ktZJW0oVPbth77fAjiBwj?=
 =?us-ascii?Q?yI8wvSVx1BftwszKY8eOJCIPh6jaLl7XouExXxBmjSSGm6rA5UPcvCHis9/5?=
 =?us-ascii?Q?tqg3Pa+9ROydGfcawIi0WXZE2XmD5Jp5G2ab+Fs+SfSsHWAqavWf4k/V0NB+?=
 =?us-ascii?Q?9pfTQzzuDKZMsd40Y4jiQnQJILyt+O3DKbs8M3qp60Gd9YzHR8KF8tGAn+c4?=
 =?us-ascii?Q?gVHAVurJElMDcXj6Jq9TRrhEAnAy4RRZUhEobswNGKmLmHZvKxVodwlxECog?=
 =?us-ascii?Q?Bx7GSZbksWCf8jerUWoIFMXx4uZEoSkrp2og4/YLxW70aYnzq6oO6b5U8KxR?=
 =?us-ascii?Q?zQtE+dhpH0dR2rXYhVDUpCzs9n4LJ/+0fAXHJzbt+WlgboRg98+ibv90LCLR?=
 =?us-ascii?Q?lN0x1mBl1UXkvn2e5eAXd+WAuHvVTa1PH157oKrbu3ia2mLl9wpvhQwv0i22?=
 =?us-ascii?Q?ODQWPmG1XVu8fbeuoeKivRZsds/5dg1kltLL1Z8ZYYE2sM9XR/xIWmbuVg+0?=
 =?us-ascii?Q?RMrZkX4w/1h4M2raPWh+BRGvEE49yTL3ypp2VsAxdLT+eUCE0V7VRpMPqjH8?=
 =?us-ascii?Q?vEvLLdQonmBhvTfGIjobtdOSWJw+iV9SUmPT/rtr5JN7mU30TJJoAxK/4AU3?=
 =?us-ascii?Q?n4QOIqR7ZrZL+86gEEEEjpoiT/QpS+gOXIT2pAtCEQznNnG/2+SNu2AW8CxI?=
 =?us-ascii?Q?Sll3JJDYAX47pwtm10J7zNVICdADTkJac2tBbi90tzV0YviDa1FeWFv4pZIK?=
 =?us-ascii?Q?GBgSu5ccVBRjVSgflKwvgkJTjwsFd6AfiJHxU0FEL7JG7wuusjbjaXhLG4ql?=
 =?us-ascii?Q?Rb4SmuDhhYqqZwia4+YaIvSAwHqm5xqsjNKmMpgLpjqZ7l32TqplDcxgx5rY?=
 =?us-ascii?Q?9Deq1zTswSgZtQ71pqoIge5NO+sGitWRvanXMJ0qYnbA+5h0k1PXWekGG/uq?=
 =?us-ascii?Q?tS4/YU/htIkilh/oZVETTpzpUkjsPI98Xfx0mzGt5NzO7UKttTBhYaGskpZQ?=
 =?us-ascii?Q?tQ97CuBPSi0xkZ2jLbmIshKT/LBaBNCrfl7y+hWVwv/8I085WTckhA1M+YbN?=
 =?us-ascii?Q?2aZmnmL3w/IV3oWxfiCMZV7k4fY+OY9OXZS+vOxDaLoV1Jsj+pJKl+Lu9Z07?=
 =?us-ascii?Q?T8VIe58eijWhssMrgQR/CdyjENaAtXCGs1X2tYUxzIuuW3qs3INKxtJ7wpLX?=
 =?us-ascii?Q?RJppKPznSSOuGnM+64+ggmlciauG2WRwrCEWewX6zFIIN4+cbL8TK665TZiD?=
 =?us-ascii?Q?6E7eCa6u9fRHe5py+21KuojtarThyQES8EuFp3W90I1oF0Eegfjt11bo/Ehu?=
 =?us-ascii?Q?rFmbzqoNThQiEgZQTSXhWEi264EYKv4wIEqbXQ/TkCVftEM0WOXYtJXCxqgo?=
 =?us-ascii?Q?8+cFYRhzFJrqgebPPoNdmy4e3UGgCMj+l3I3/E40aiFKaGQt8fj3YoeL7dng?=
 =?us-ascii?Q?odHwCF+wUBrxSYhIQTxJEIC8jNMyTnLy23KYNbAefHP72UBQg8vdhq/sN2d3?=
 =?us-ascii?Q?hNE2SzNkaTNdRV1oIOJqxaHi36xlSCha9qxb5MlB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76d86ae-442a-4bf9-2210-08db832d65a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 23:12:00.4343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuWFbx7HQ2bUU0x3MumRB90/mlDUABdtihKIgqYGHgmh+486NGAFFdg+MP2/cZHNzcyK6pfnZk2v9YqNTbK3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> Add the accessors idxd_wq_set_private() and idxd_wq_get_private() allowin=
g
> users to set and retrieve a private void * associated with an idxd_wq.
>=20
> The private data is stored in the idxd_dev.conf_dev associated with each =
idxd_wq.
>=20
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
