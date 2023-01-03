Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E765C768
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 20:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbjACTY1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 14:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbjACTYL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 14:24:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EF615FF7
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 11:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672773624; x=1704309624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4zGM3TnPy5FpDM2G7Fd777uhj1G8RvnQpAAjZGa6few=;
  b=DIkA7dI8BUYV1rIAJNpLlBLnf+LMpsShF249E7LqrqUDap0Eztx9+X4w
   FwFrWHAXg6F5nSsUIAj4x1pnFtRZzyVOjfJVe7PCPCVf27mJK1e7nHVJ6
   +n5/D9V6pan+o6de7RaQVrgENwSLoKq1COvdQm0KusPwQ8cTPFI9tlg+1
   9CE6BCJqcjlNro755++ChSDAmo0kyu/It9mlcClYmhw1f6bgb0kCMvjcJ
   uEf+7bdt421BT7QKsk89NMYEIO0ACJYCRL/njryUMem8iQm3xHl4jLcEX
   xOXXgML2lBY6du2o2MAF/4InfUxZSkGRo8ZrWeDtZIkCii8B7IVevRfvl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="323729884"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="323729884"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 11:20:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="778972862"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="778972862"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 03 Jan 2023 11:20:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 11:20:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 11:20:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 11:20:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8lPY67GbIzonJVzph37YrhKybhDvaaXn412BqsTcZ3qwuieU/dx9zC0m+EvaWiLirHC7T2Hrv7BHoZrcRiD0dZtjKiRoqapfl9KD5rQFDv7yfErUe68r4nnqVmuQ0ale5a6vfrq4T2/t1zmAk5niPekzsuwKQ1eEf+KIABrylbuM+HhaGT998QOKZXFZFFFVG7PMKbYvP721S4e4gFhvmJzI9Qa/tFJYtD19YgyY3koJXR0K/J3Lgl3ONJm4WT7dd5EM5tD9izdNGImCby+y6DjAehTLa+JtsoDWmrNrP8mN8JGzK1Ac0DeY+8BcdfpyzpidzDLzdIK1fMmXdNUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zGM3TnPy5FpDM2G7Fd777uhj1G8RvnQpAAjZGa6few=;
 b=OeVoDzNIvAglzn/ioHFiDEIc/PXkkYkuuhRTSh9n2MVHsmVjKN5WR2QMG5g9rhABPK5NkLB2fSp3a6k27SLJb0Dp6D3KKLF2Pkit78jCOFCbzAIJUu+hEkZK90UawBHpucaUC5C3M0e88OfqKMYc3Bj1u/5R3m626Dc4oNCt5VveZ/jugsA6rforrGmnNIuei7lm7BW6ONa/yZnEGn2qFGh6ApVwQ+hdFI2YxJpzRLsLtcgduzyf7mQyU4ONqchL/txrXGeyx3HXb9CUHVQdhlWO+8s2nR/SINt54rcM6Ir5rzv/U/+4yAdnhftk9EBibf3bkWoYXYCIerz1svVqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CO6PR11MB5650.namprd11.prod.outlook.com (2603:10b6:5:35a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:20:12 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:20:11 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH 09/17] mm: export access_remote_vm() symbol
Thread-Topic: [PATCH 09/17] mm: export access_remote_vm() symbol
Thread-Index: AQHZH5FkNhHM4hOH50a42EHT2Acr4K6M9zQAgAABTYCAAA0YkA==
Date:   Tue, 3 Jan 2023 19:20:11 +0000
Message-ID: <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com> <Y7RpuqbTAM11wVQG@lucifer>
 <Y7Rq0WRc4p3lCkjk@lucifer>
In-Reply-To: <Y7Rq0WRc4p3lCkjk@lucifer>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|CO6PR11MB5650:EE_
x-ms-office365-filtering-correlation-id: 0e466f6b-f16f-411e-c40d-08daedbf88f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zr73/zFljL/tAfbzdeXBwUTsVIxtXLIQHZRjGaq9omhASUr8iXMJqIsFp/EZ7By0tjbfNYzSyTfg5cYvhMgTtjUxzrkih9E0yi4QpDmdkysXKbuDnotZfZy8OBFRt8zRuH2cjS83hMy68Vxh2nXgAZn9acW6RKEiAkDLgvUsTjYsQkiMasf3BmBlBVAlnZ0li5uJuCHfjDeVQaYwmE9EmD8vLYYJQUDEDLtLj+DekNvz9O8rR/jlnn0yTL3o/I7Kw+TAYQSHFf8UTjGwD8Sl9vDd+3HazlmUTPs3h1cUWCgCytHR7ByyJduGoEpBZhQsTdXhYOcdaMIReBOu/HdfIDC7ntRVKl7zKd0/DwWGddF4I9qtIrPg6xwMnYBQFKzY5j9eBpdVoIwqGaiBiYpNIrTEQAoCoCPObLNzCB8K27iN9oPhILx77rzagCJjtJsxkHGvQE7rFe9h411mc89thXHYAPc/YB+OvQKQhJp2Hbt7sg4B4at0/kYRCVIBsWXGlF2Zw6Ak1n0izW1NjMwm2hXIOwucKSxhnV+gSlQIvtobj3c34vs5HEPUbZVQ6krZd4Gk8zMA7Z/I/97R7DTDAMNAMqs2EKH45QVFj7cJuiG22XLM7mKh8n5FPj+J10LnghjjZAUIq6ANhUe8T/dceS+jAhIScdbSkT2OjoRIprU0V2ER6yT3qLsGtjBXXOnQO5feyHTTY8PMEfWgsv3gPjLcb3i5e6hBED8nu3yAVSU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(5660300002)(52536014)(2906002)(8936002)(8676002)(4326008)(41300700001)(478600001)(316002)(66476007)(76116006)(66946007)(64756008)(66446008)(6916009)(54906003)(66556008)(71200400001)(26005)(9686003)(6506007)(33656002)(7696005)(55016003)(83380400001)(82960400001)(122000001)(186003)(38100700002)(38070700005)(86362001)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y9hOLY0G5PH0zCKnm9eY68EwxfjkV+nAuIZizqALMTP8opu85cee8CMXwwlw?=
 =?us-ascii?Q?5f1DwRtadaCMpRNZMbf3J9zuZ9vtjhfhBkEgrGRlA/39CINpCAzPrKQp1iAg?=
 =?us-ascii?Q?dNztCOmouGZ525DfLBIwtxVFzE54mTFdl4xSrCP3tHm55vaXYiX7MV5VUktb?=
 =?us-ascii?Q?SVoAoQGQ5uLdvwLXha7ofbT6oU//8h8gP827Tjoa0Qnxro/ElSDWI36EFWuU?=
 =?us-ascii?Q?DPGITC1ScUAnfLXLt3nhpZ7qTldktDYagYzKxlvm8jigxgy5f0TUUvYEMOB4?=
 =?us-ascii?Q?fRPqR5CzwUU+Wp10QXy0RqyOQKQ6Zu+e0+JdYkXen943IO5YcMOmv2SEcD+f?=
 =?us-ascii?Q?f+DHjlKmmNgwfhLS4pfuIBGQiEXTbDQJ71zCFz4jRkLW3VCG/7fLB8RPG6hE?=
 =?us-ascii?Q?ryNVOf2leCss830mFPoF7l7BbqLynT84wfXEp5bi3vU7OzGfnja6lhKVDNWJ?=
 =?us-ascii?Q?lH9Xbt6LCosfFaHE0w/BOdUTVHG0phxAZ7MPJGe2bv0eKtMkD66ZfnIE7mOq?=
 =?us-ascii?Q?03jVRqL02Gh3CzRMA2cDpGa7NGs2ppxRfIrMwa2/xgsHttW4J2tcImEg6f3Y?=
 =?us-ascii?Q?u/g72GCSjduhhCh4ruxU/tkW4zOQTgFx939lg4e7TBz6qKSMZssx4y4OCpk3?=
 =?us-ascii?Q?JOW21cfN7V8i9RKKQsCx85yT8+w6q+uQeTd/aNPkE7RD9AF1m88Y8ivjdB2R?=
 =?us-ascii?Q?WkCR/cQ6/Yq6i9KaWOzF11ka6IHXN3YWJCvqw+hAWe44dUdGmANAkxaTiyn4?=
 =?us-ascii?Q?3HX3fVj06nwdUkH46x2bVBuNQANR9P3eAmxXsIcHffDbZzKDKoN9OMj1+ULg?=
 =?us-ascii?Q?6C95BuxYE3Zg3IAZkY5JT2G9P5DejmficLBWtjRwo3M/uaGkBraThS9k8Yek?=
 =?us-ascii?Q?9Sdw3IaVrrv5eVBDQfX92VAp6t6pheMrzQlQDSckYFOjpgzBuveJdEcB5MAV?=
 =?us-ascii?Q?hC62T4yYsL8FQIG7ioYG4OH0uaPhE1S0rbv6EaKlSS5C0JcZ9D18Qu1uj6up?=
 =?us-ascii?Q?1uiGYkLB06Imgg4L77KSM/gXzf5c/NHj5SHMjHXBdj2dr4c2jT7QoFh0A6xe?=
 =?us-ascii?Q?5pUORemxq9u+lvK5qhYrbw0yfttjxdOEIJQj+lXVAjX81YqySa5EErbDj6EI?=
 =?us-ascii?Q?YBcFyxhAxO9RPxaUDiqCi+kmbQUE2chamZVf7/hsdivlymR/Aykyc9s8uudG?=
 =?us-ascii?Q?ISLhzjrAj8fayk4aYY7nXLHCxL8siW2pqeJptvIixkR5ZR9kA6GFeFZ5fMx5?=
 =?us-ascii?Q?/ayrf4GOCIhJkW6c5ajt2IHWfZKQUOwFAN/w98Hhs3NGGQmVc3CYr2xYWnIu?=
 =?us-ascii?Q?xdWbDGOCkllZ+4dSgF2PTv2SshTRkdI1nCqPXByWhCMWkH56LKZ9qmunY11o?=
 =?us-ascii?Q?EtSZHwEXkUb/oxhlUD3pLdGD1bV3wIe+ACqqp9G53IYqt6LpxKsbKqDt7/a8?=
 =?us-ascii?Q?/O3Fnlde8aVLgR5DaFZbOowFnIhfJWn2KIAzqolJTnYAyoF22cRtucCawME4?=
 =?us-ascii?Q?DU0l6Nt/pRlZNjPbsA4SVK9UUYEjbDD2FxiHkwcqRzxAMmeGh+ypNXb8+Xgi?=
 =?us-ascii?Q?qSRFpm88q24SoIN9DCpE0/dwV4fTwEDFZb697jzM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e466f6b-f16f-411e-c40d-08daedbf88f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 19:20:11.8328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HazeXrxZA33EpwKm8vZrDqM8mna/iLgW8RYAyNLb6EMyTNnyYwHdySKEly1jnvrkUo6JekiQ0r3x0pBqGEkkqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5650
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Lorenzo,

> On Tue, Jan 03, 2023 at 09:46:00AM -0800, Lorenzo Stoakes wrote:
> On Tue, Jan 03, 2023 at 05:45:30PM +0000, Lorenzo Stoakes wrote:
> > Can you explain what use case you have for exporting this? Currently
> > this is only used by procfs.
> >
>=20
> Ugh I hit send too soon ! I see you've explained the _why_ (i.e. idxd). T=
he other
> two points remain, however.
>=20
> > Additionally, it relies on a reference count being held on the mm
> > which seems a little risky exposing to a driver.

access_remote_vm(mm) directly call __access_remote_vm(mm).
access_process_vm(tsk) calls mm=3Dget_task_mm() then __access_remote_vm(mm)=
.

So instead of access_remote_vm(mm), it's access_process_vm(tsk) that holds
a reference count on the mm, right?

> >
> > Is there a reason you can't use access_process_vm() which is exported
> > and additionally handles the refrencing?

IDXD interrupt handler starts a work which needs to access remote vm.
The remote mm is found by PASID which is saved in device event log.

In the work, it's hard to get the remote mm from a task because mm->owner c=
ould be NULL
but the mm is still existing.

Thanks.

-Fenghua
