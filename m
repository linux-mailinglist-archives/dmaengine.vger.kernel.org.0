Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924AA5ED10D
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 01:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiI0Xfa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 19:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiI0Xf2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 19:35:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF16A1CE143
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 16:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664321727; x=1695857727;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=OhdfKJSzsMSqiGSFBO6mnJseBl9DlXtDRWihVciLaLY=;
  b=N2NS7RoYSfiuv/BtbPClJ5GmSIGziy3Z0RgdoKZY6stpRD1mRteg1Ugp
   9gfxQDi7EIdMfaFZR/6ywiTv93TKgsYgHDTTFlLDtExAHeoM6Bm1FJpcA
   ZfYvfpv12PmW7iXDmMXPWwyn/9p/mc7xONbm2wGqWuK4QdKeXQ7u7yan6
   ER0Sv2OP+ftYC0lO9ebt9eswBDEXfEZA3Ba5Y4QomXw5ObK7XiWIAHbou
   BPs6SCOU68UzGNCrUzIx/LueCh9dwCJHPZR7YcTiWe+3o6aUJ3Kpw+3jQ
   UOzQNJWPI98YQ7hSM2Nl5EUrFuVwr0ckPPT8tSYHQFnbDArhfUAzQn+V2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302368317"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="302368317"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 16:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="654908190"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="654908190"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2022 16:35:26 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 16:35:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 16:35:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 16:35:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 16:35:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjxxFWZhPTh1EVFGggzk8jCy1AXwKRi+sRjWEd3R+i2ZIPXOp3c+jpVQr3jXBJv3H7pTD5XIqv93v+uTYbZZJb8a0H+bkXj1MPfTOREYBdOYxYC1peykfGKd/XBix4/iPK1P0DYGTOwGBoyHGjfG4hVx0ZVRyTxrjRTxnO/O3HZabFnG7Yv5bXeXqCq6RitbBTYJ1QgUStySZWCHuRusfOz68VcKrPG/CdG1yEFH8NWT+aG0brgugmK1a4hIphcL+hW9VU3IqkynHV7tYeXgwm4ChG6fzleguJUTv+IDAx4g3Vc/A23WHudtdfzAvL7ab4SVYA5dWrHZo7g+1ADzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhdfKJSzsMSqiGSFBO6mnJseBl9DlXtDRWihVciLaLY=;
 b=QV/kNGcv7K9+Newkj3CsUO9DBgZvGbfVPd0Fie9x6HDOzhiffkqyqS336AbzuvJy8O8uw52s+Za0SiqxgEMzgMW65rqMjIrxVm1A4aab1K8UkWObl5edbFI83F6A4a0TVjQqaL7HUvyohlwSmObXNKQiG7yKnOpY9i6P+ENgOa/dwU4l8h8YOhWHyi9LtYrOs08Kf4ZAO7/78bhLraP8wOFrJWrVdGOnz8SYXtqVpn8WaMqgtRkdVs/b2u5HVflMO636g2EV5AFg9Tr7rtHfX2ysVcNVxElf9liiB6NvZv36rSekcyjmmDCKsOXI7d9PjB/q+FTOEoaEwtWKMMEfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SJ0PR11MB5629.namprd11.prod.outlook.com (2603:10b6:a03:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 23:35:24 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 23:35:23 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Yuan Can <yuancan@huawei.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: idxd: Remove unused struct idxd_fault
Thread-Topic: [PATCH] dmaengine: idxd: Remove unused struct idxd_fault
Thread-Index: AQHY0nasl0fCgTMp2km99PAW03/p+a3z7InQ
Date:   Tue, 27 Sep 2022 23:35:23 +0000
Message-ID: <IA1PR11MB6097DCF0628FC0462656AB109B559@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20220927133711.98184-1-yuancan@huawei.com>
In-Reply-To: <20220927133711.98184-1-yuancan@huawei.com>
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
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|SJ0PR11MB5629:EE_
x-ms-office365-filtering-correlation-id: 86f7f439-f9b1-4dda-70a6-08daa0e0f32f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E3bBNhBuRYD8n9Vyqe0NmX/nDaRdljUNHuICUri2x4pMiy+VJFNHfLq/jqiqN6Qx5o7MK6LBf5hbN3+uEFJA/DzoUGwRNq50NVcO2JMdvTVHe5WowBX3Cq+Li/ATdJoKPwHZRs8ffgeBVOnQ18aB2ho/lLWJr8DUe7eltaKYN1sqG4EER55MtXufCPL3kE//p4jkbE/KWx5UpCFU/ectfesNGEGVnrLQafhWW32fmbCLIgtn/HMq+npJyaO2RwrCdUqQ0yeg9lSlLla6TA5+epd8Slh5EYQPk2O2UesxnTWx3VTYNmRuCsDphKY2km5+YYiSqszyGI87nY4ydil9y7ZB8sV10J8xPiBoWj0TJPl+ibDJc1WnxDWu0wF2WwED2lP0NOPTsXoYesUx9T/VvUTJkpweEfMt5MggGMnyhUGB7k6Y+nPvUlZMhFE55cVaiscSqVXBYQCIOb4jvscMu2DeJLj9VjGMSVr+xsiZ3WKo+KjRF8/ocfvP2CRIkOuClU2aByMZeTm6miig3L47OsMxaP+w+fdrdra3wks5a8uqzkS8YHj1TAik+WuzEM/tXPntRC5fRT+oQtVjYYEO7uwGqxmf8obGXv/0E9EBuTL64MuOP+e8XW7bPDZmDhS72Upwl5GW7B48MlO6xwnbktWk8imPO3G+oC3u5p8MHyE/GmjaVyz3lfFo0rK3ARQ0vFs8mLN/2kKdr8m9gOObbcJ+p+HilfSHPXGGDQILWHhp/8VnNEo9ED+1g72UmCmEBQaz6DmT4ITNol3Z/lSoQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(2906002)(41300700001)(7696005)(8936002)(122000001)(6506007)(186003)(52536014)(5660300002)(38100700002)(4744005)(9686003)(26005)(82960400001)(55016003)(33656002)(38070700005)(86362001)(83380400001)(478600001)(8676002)(316002)(110136005)(66556008)(66946007)(66446008)(66476007)(76116006)(71200400001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tAu1QZMoli2L4ZWlWJyTDAy5h6/AV4FwuJg2t7nvSh7Bh/HeoZ2B4XRUkLEH?=
 =?us-ascii?Q?SQwihuRlRQWOMX4OGCcDtbJlI/RLJrtMCFh74RrlQnsEFp9bW7ZxRNLlzvUN?=
 =?us-ascii?Q?P+auHWg0aBA+B7AhpsNE7FyxraDp0ylYICOcT63xuyYDyyTDmXxsTOSd5sBH?=
 =?us-ascii?Q?VR7tNrcHLs8C3/nrP32UhaDOS0abG3hNFiMZmN9K1npb6BxjoQzt7H/LHXkG?=
 =?us-ascii?Q?hdNvI4M8zhoYg2qHBZaIHcRcZnKDbGFO51wA+8LJFnVXtdIvk5opWwuNsLOB?=
 =?us-ascii?Q?ioSnN4c+EBU7CYIyEvYvdLzF6QdulB2NujgzV5Rx9ncL6DDSPP4M3A0tgs/i?=
 =?us-ascii?Q?ds+gwWN3vFO8pp6fMCv5ntVw2D3GHWvJqwil0qEw5eriS2/OV4X4T1oyW9TT?=
 =?us-ascii?Q?JsGLWFBpNlXCIr29+rbtPn8cohwwIommJ8/CY24OSaJ94b24Z6gmH3e2kS+c?=
 =?us-ascii?Q?OvwJTqwljWllJf/UwWqmG+udm6jJQEYrdh8fk7gI2HADLq48aLEpZHV2el11?=
 =?us-ascii?Q?Dl0OGgt0w8R3YLjkqJHdSAJ/+HN7iV8+njdSOCZSv7acAxCXE5zQJylPFMsc?=
 =?us-ascii?Q?f1KlRe98LYEnd6+HQvd+UKgztmILztjqJbeQf36A19NHQKBandEZGr0EBB2Q?=
 =?us-ascii?Q?DcQeQKS46IsqgDjAT4szJxUJH06wZ62HppOnkSefnB75Y79+mrffRojPjSCt?=
 =?us-ascii?Q?vzJ4Qj0HBUA3q6gJxl++kt55k5KyNOEKkIsLtyIHciSACftJO1gWadPvhHMm?=
 =?us-ascii?Q?3chfUy3OAA3555NtA4YxFHnfC0wmxWeBxF82iDnrkqPmdCLIMtxsIRlGbOxM?=
 =?us-ascii?Q?HBKenQUWkuvtivArn3YHAmvKGx1CGQE6z6ZysWzzq4BlNyXjZXIaBlLJWt3u?=
 =?us-ascii?Q?dGVj2uoKeKpiTjTIPgl8afaP8SmuJusj5XZRJLk+u0SK+gFlzqjpsqEPVG90?=
 =?us-ascii?Q?bt1xY5FTjrT9pIh3GDmiYK408lNsfC39J/9Tm+SpTPaBrkEf052M91Jplz0q?=
 =?us-ascii?Q?Xxi5Imsg7BIHerUVc6x96pTS6PMwIBYGiyORjlDCsqf1P2u+LvqLUwIJxytb?=
 =?us-ascii?Q?T8Tu6/nY4ewbQKoY4UrLAMIqIDwdipRkv0EkD9pp7RZ9jAWpZKsMJimzhexA?=
 =?us-ascii?Q?F6yAtyR+c1BXaMqniFMaSeIRXXCRSnX4trFEDey+HwTDshV+1PjkJ4dZiyrg?=
 =?us-ascii?Q?PcTyMm7sMHj0Gf3ReB0M5PqRIJWkzuiUOuzzlC07213KIdVQKUksjPHLIHib?=
 =?us-ascii?Q?WXOFCrkzYJx/eNSwuuW+kWHhtT2q60p4kLNh5GcQTTyVE1Eokjotw+VIw3A+?=
 =?us-ascii?Q?3bhtKuLF5fCwqu9ltio6l5k1hCkvgu/bU1H7ojXtiiyeBYLUsOxFkZAdvjcH?=
 =?us-ascii?Q?0UBB5r+2+aCxQWenjUQikNuoUVqVtl0gwJoLm37n0fjN+SY/8oMnkAww/4Tx?=
 =?us-ascii?Q?dbWYheL8IXf+fNLI9leylym10+51GZpasEXD9Kl1d0VJtr/biHjrZZwn6M2R?=
 =?us-ascii?Q?IjG2Vb2IDYg2gmDRKbHvgLtBde3FkwAZn9LCZ6OIFRDymUNHm1dI8F0ikhWW?=
 =?us-ascii?Q?oOU72SI7PX1P9oiHRGUcVf9I3sw34KVBqmuNrGBi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f7f439-f9b1-4dda-70a6-08daa0e0f32f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 23:35:23.9281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPBjHHpng9vuSoGaT1ydJtcXegOfzXoJW79aHBpQWOKhHaP6/TLvs9bCqRrlGygfqx7dpHRkWBdOE9P/V/8CRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5629
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Yuan,

> After commit 0e96454ca26c("dmaengine: idxd: remove fault processing code"=
),
> no one use struct idxd_fault, so remove it.

How about this commit message?

Since fault processing code has been removed, struct idxd_fault is not used=
 any more and can be removed as well.

Fixes: commit 0e96454ca26c ("dmaengine: idxd: remove fault processing code"=
)

Thanks.

-Fenghua
