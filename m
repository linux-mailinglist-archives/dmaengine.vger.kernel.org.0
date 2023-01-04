Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3465CC83
	for <lists+dmaengine@lfdr.de>; Wed,  4 Jan 2023 06:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjADFGh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Jan 2023 00:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjADFGg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Jan 2023 00:06:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944F0140ED
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 21:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672808795; x=1704344795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DK+zAyg9oejQ1QttmKjFjH1qw762Emv88jmac10UYHw=;
  b=i6HSV9U3WvWmtITzDDZsLJLVFIPuHr+y39BlHSXRWJqPKxSH1ezgVRMB
   rmg2K0reenj6FHwKty+dx2NT+qNCym+7x0LabVf4+gNhNK35Z0k5scc8q
   G1vG+jHjqwmORieOSNB+xgbDT1OQfRRMhwbXQUhQQyEbXpZJJE1w2rs41
   lWpiUxij57QePatJPlr55t5n/Ockv3DM5VHGTUQFFbZrpU/jOi04h6/GR
   unrhMAvaCCB34sG0RGtrybB/htZSl5I+cFIKHdAnTIKAltRMl86r0W7mh
   pJO2+wZcsueD1JMVqRbAignlOADM2g6UeI8YUm1x6f4cX5JvcqpEIrIyW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="349062237"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="349062237"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 21:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="685635957"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="685635957"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2023 21:06:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 21:06:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 21:06:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 21:06:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 21:06:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvuBkx5K425ER89DC5OBj5hUcjGZeQnuJsHbEzoG/hxUpquyrK1Hi2JzFq8KRcwtEQWbqQq6p5Dn1BnhnX+wts3iLT9fsv+mlFUYYdxKeVn7AaSgUWdLZcKwIwD1PXEAyfo21mZAL0Ld3xIbFoAtCHZ8weoDA2hFXjo9X9BnzHMq8NZH6Lptj6PD7DzYJdOsGVOEXVMVj6sEZISYrq77DGREzMlYWL2ugOHfdPpWzSEPm7Pizej67V+2fPD3l9SoEdEOQD/Na8cNr3SsklODtXGS2AE0Bodl6yNenpJbtFrWwqiGZ6ZgrWV2pwW3WwMixdKHZvgH0ojHgNPTYr/c2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT+5VwbSsQTMtBUXUM0SNBxnBDVb/bhQmIDdAAuARVk=;
 b=MZigzvvr5qR9Nx+6se+xRSMEhbXq/7ORQbf0PB9UDR5PTrQP53Bmi9dJnrazPn/bICRhrZyGpsQLTpNU8Hyy3itkOd6s1OnbqHAl9i3FJRH9Gw2Nqk1bfyQGyNGZOHphEJsCbAsJuIN5vyjIha626dhx/lXBd9cwXIW5pWQz0ksGwy3Sj/Nu17laNPUxrcNieU/MWFxSi6C7ivzYBet/GAUoazmVaNCWAzES0bB5qXnvbQS7OYIrrVXbSfjPH3wMnfxH3J9Nq/cBr81VYJIvcuU+GMOc6/Bgc+cJZCOHhY2qb+EjOjglSdtSIXn3m7W3LB8dXHsHH+y6WstCHOSfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB5625.namprd11.prod.outlook.com (2603:10b6:510:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 05:06:29 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 05:06:29 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH 09/17] mm: export access_remote_vm() symbol
Thread-Topic: [PATCH 09/17] mm: export access_remote_vm() symbol
Thread-Index: AQHZH5FkNhHM4hOH50a42EHT2Acr4K6M9zQAgAABTYCAAA0YkIAAGukAgACKFVA=
Date:   Wed, 4 Jan 2023 05:06:29 +0000
Message-ID: <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com> <Y7RpuqbTAM11wVQG@lucifer>
 <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y7SMYF8MlzeqDgp+@lucifer>
In-Reply-To: <Y7SMYF8MlzeqDgp+@lucifer>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|PH0PR11MB5625:EE_
x-ms-office365-filtering-correlation-id: c8093891-b2f8-4e50-978d-08daee11707d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ptrLjs5SJkiyERLGcgkQnACcCp6F5MyL/zLht96Lcs1tpSDQZhbG9gP7EsI/GdJEOFzDjrWBio/uLpLw3Qs9tVCs0Hndb+XP/ANBt2+Q6YGmxFgphoki2wLD+My6cVLJHr3WMl+j+3zQY92yaoT98t2qsPep2hKpZFimW5QJCJv6J/lMzuZMvzh6XSZLILwDrGDdGKWZe3VQswm8OoPq/IdpmtBDq+tB/K6F9ctIIMI5Ywp5ZA62w3DuHDqA6BSGzEgZOpxwZkuoO0Lc8WcnnkBoY7Xpx/yrMeeezaC1JV7Lr4u4QfVqTpo/zrgBPkMzbhHZZR5AXap6MGb8xAEyH3UVc0T71UwVLw0HDNZE3aZw3hgl/ivnvm1mAo7FfEh+pU0vT5U+JCk7eVreT+vbJYlTKB5tcDf7k9rv2l8PVxtVwLm7jUztDzCavpy/K+gf156N6+0dRH2f4jcGBX4+fiYNTps/PxKLajO8bFD9PhTCwsyaGSSe0Isw3nQ42fDFrl3MAFz4QL7D4Dfq+G4+3L0/1+o0Az1mGmKR/G6OMVpvJbRnJ599V6L0azVZox2rsRa0OduMr1Yu1XFyKnwXsVi3/5yHdrik3MxNL0z+/197ROHnAM5ykszq/GNvwzpkbguyRitLoXnAq7DAAn3NwiflygEdGdNf6YJi2DMRq4uHLDOBd7DI+yCFIzGEmuwR+qCIp5OVNXVMP/pknjDuhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(107886003)(6506007)(478600001)(71200400001)(86362001)(55016003)(82960400001)(122000001)(38100700002)(38070700005)(9686003)(186003)(33656002)(83380400001)(26005)(7696005)(8676002)(66556008)(66946007)(4326008)(64756008)(66476007)(66446008)(76116006)(52536014)(8936002)(316002)(2906002)(6916009)(54906003)(41300700001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bCfb54EJeV1JoLNk8DgEGBLweSz0sYUQITdy2xp0TRaGmvKGjxQtm2m0A2T+?=
 =?us-ascii?Q?KgQ3p0YKS5SN5M+4F5vw5DDSBGe61E5c7zaQT2ekLlV/az8p39oQrulHppYI?=
 =?us-ascii?Q?lu6kc/SfelKZIr1SYDMLs53ycUE6GVP2YlZVr70CNpG+bZjQJHuI/EbV6pMj?=
 =?us-ascii?Q?gUgtdrEGM6HRBiOXmUV7spMXLtmdlzDOM6ilgZ3i96SdQN2bOizhMFAky8iQ?=
 =?us-ascii?Q?TMcufPmpXbgN7kEspgsytebCVgy8PnR30z1648H+Kt+YvSeF1/Nft1fnRrZQ?=
 =?us-ascii?Q?gLy9MIB8cd9F10awRhthwoYpDOvUNX10AjUzhcyIa89F8pGgysPosupwFjFp?=
 =?us-ascii?Q?XJKZ+lQSUbnik3nfD6/5Hygq8w1QClksE0MWE7mZl0+NXFRUWMVBd4CXvS50?=
 =?us-ascii?Q?UePJeEr/UGnuzbFodZ+0S91iqSX5nxCghjh6HePLBvoEz9PimnH4WMyn7jjN?=
 =?us-ascii?Q?UQ6/aPHthV5k0GkFhtWNGdu2YtX7tCToAshalfa0Dr5kD9ngNxOrabkCNSEt?=
 =?us-ascii?Q?c/wrvMiR4usYHtBSpuuQp0p8D5Q5j/0dnd8ms6aVEnM+tNMDCyf74SHW67Mc?=
 =?us-ascii?Q?NiywfhxOTCEIE0eFkx7/kFE37UAzLsh+CUimKDfztHQlqjsKLEjGjKGPSeIq?=
 =?us-ascii?Q?XQ9lkz1VD+PUck4E7oRmYvqpRpZ39HdjIKPbnxecIXBdS3gKEbJ+SsiK9o/O?=
 =?us-ascii?Q?i7nVTt5z4VeNBaL2HAaYve0NI5cGBhsG2325SK9x7hSjdM22dUS5OE7QNhuN?=
 =?us-ascii?Q?FDpnSCSzmEoSczxuLdJN31GP1+lbVp1yFgbEozZZv95vWIH0NBS2GOzp8Ea+?=
 =?us-ascii?Q?VP8ps1TdZwNFFVHysRLQ0Yfa5u7TJ+EBmu1xdDg14kIZtDTMqOL+/eISq6yX?=
 =?us-ascii?Q?ae7IHhOqQ1h8xGNa/yriDw+UlJHmytcKj0tjGQ15hj0fHGZPflVRymDQJfjv?=
 =?us-ascii?Q?q9mn8yrPMvPUFcrsOgapk7cofR4TkwcfPkDadTTElCAn86mt7G9tJiUTEMQi?=
 =?us-ascii?Q?OtavM0zfpwGyW9v9PHTkF+XUJp4LBWtUIGfi5jnLOhndtdwSpyQb0+ZuWSIt?=
 =?us-ascii?Q?fW1iw/Ns7w5lRl9vLSJ+gR7G+bqmNxdx+ky4xlcppe/Cnq19jsPt614vvqwO?=
 =?us-ascii?Q?VzKb2svLidjp5dJzXSMG3DBD1ucB30RvSkphYtqJMNj4DwnXrU6ZpFoAlhkn?=
 =?us-ascii?Q?D3vK7x7GGalVio0nzf4tulX+sa+hiytCBvxw5jnFVZlTuDKO2+If4BhYHu/L?=
 =?us-ascii?Q?FEZX03z7byiB0YdgnNaED5UO4PgZHp9/UbfuNGbe5YtEBHYCXAZKYaKUwt7H?=
 =?us-ascii?Q?YnxfZRHFHG5fP94gXbXoS0a3zBgy4q4XG17pEtM1PdbL3GQ31g1GSmoa54AN?=
 =?us-ascii?Q?hc36LBa61+zb98o0FtOBc1dEpLxA3a3+cCl27Nkugo4GDYcPM3dNIGKkVzQp?=
 =?us-ascii?Q?2Y8Wo1sZKGG4XeW5WMVnnklSjL2k20e2j6xtrjomeAo2+CkiTQoCL3sW/Y6C?=
 =?us-ascii?Q?lulUYYbPT1HULDaYUrxrQYT1jOsVlC6GSndD6fpbt4NsuP66IeBg76kQlNZ3?=
 =?us-ascii?Q?PQ2ggGS8jAyFMaVV+ykHCkJfGLyWjChtHj/oXtNq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8093891-b2f8-4e50-978d-08daee11707d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 05:06:29.5167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leHSWEyHVzJhLUcKcIFgmp3+bGgeec7NEJtMxFJdxJ3pCeimfWYpqmj6PQ90i4627QEPvtXjVRXEc7GdY6W/kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5625
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Lorenzo,

> Hey Fenghua :)
>=20
> > access_remote_vm(mm) directly call __access_remote_vm(mm).
> > access_process_vm(tsk) calls mm=3Dget_task_mm() then
> __access_remote_vm(mm).
> >
> > So instead of access_remote_vm(mm), it's access_process_vm(tsk) that
> > holds a reference count on the mm, right?
>=20
> Indeed!
>=20
> >
> > > >
> > > > Is there a reason you can't use access_process_vm() which is
> > > > exported and additionally handles the refrencing?
> >
> > IDXD interrupt handler starts a work which needs to access remote vm.
> > The remote mm is found by PASID which is saved in device event log.
> >
> > In the work, it's hard to get the remote mm from a task because
> > mm->owner could be NULL but the mm is still existing.
>=20
> That makes sense, however I do feel nervous about exporting something tha=
t
> that relies on this reference.
>=20
> The issue is ensuring that the mm can't be taken from underneath you, the=
 only
> user of access_remote_vm(), procfs, does a careful dance using get_task_m=
m()
> and
> mm_access() to ensure this can't happen, if _sometimes_ the remote mm mig=
ht
> have an owner and _sometimes_ not it feels like any exported function nee=
ds to
> be equally careful?
>=20
> I definitely don't feel as if simply exporting this is a safe option, and=
 you would in
> that case need a new function that handles different scenarios of mm
> ownership/not.
>=20
> I may be missing something here and I will wait for others to chime in bu=
t I think
> we would definitely need something more than simply exporting this.

I may define and export a new wrapper access_remote_vm_ref() which will hol=
d
mm's reference count before accessing it:
int access_remote_vm_ref(mm)
{
   int ret;

   if (mm =3D=3D &init_mm)
        return 0;

   mmget(mm);
   ret =3D access_remote_vm(mm);
   mmput(mm);

   return ret;
}
EXPORT_SYMBOL_GPL(access_remote_vm_ref);

IDXD or any driver calls this and holds mm reference count while accesses t=
he mm.
This is useful for caller to directly access mm even if mm's owner could be=
 NULL.

Do you think this is sufficient to take care of the mm reference and is a g=
ood way to go?

Thanks.

-Fenghua
