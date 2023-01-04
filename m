Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD08965DC7C
	for <lists+dmaengine@lfdr.de>; Wed,  4 Jan 2023 20:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjADTBq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Jan 2023 14:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240158AbjADTBk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Jan 2023 14:01:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACDC248
        for <dmaengine@vger.kernel.org>; Wed,  4 Jan 2023 11:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672858899; x=1704394899;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lfWqD6p2Jj/h+0usIa9uungF2vVwP+OcWh/Or+on5XE=;
  b=msq4sv1eqv/aksibVSIiYgSX7NAo8oOlD8aZf1+p8c0aj6lFDDAbB2qC
   NurKqA7I74d5jaVTUe+Rk3Nlt06ywX9aDppSCK0XcOJhfysTQokV4LaRc
   AbCnZzeqkwfWfcnD9y2UJf3FeMjnFyGLTbK0oBE4RcFyvXgX9hN94w/WB
   KdlN6kC1nZNIauyVCUmLsIQIdIF/TIHya7nzK5mRYbBImmq+20xqWILlO
   2LReKlmWeSDqvFPPICCstTvXwafa2OnhaYQF/xN8woCSBqNDhamHBoybX
   kEF/Jnoi9ze6ar14DMe1zFmq0lYVNKV5QYt7BsLIb2O60Syzt7WXw7DIS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="349238704"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="349238704"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 11:01:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="723749113"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="723749113"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2023 11:01:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 11:01:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 11:01:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 11:01:03 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 11:01:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxvEfvOYuBFfI0h7aKxi2Qp/UnRhU65X0ZfoYky4vDcyS95J1TAHdGdhkSm2qCFcOpODXVtsptyweOUl1pf1TOLo1oVigvM17/KhZunOnWZzHHqv5OKa/v2WLNMq2OzBxTU17oknIFAGXNsMR2kEPcoOxF5J+F4MkScW3pTOI49/1sAKyhrDd0N9IJtqr5flIOy5KORiBXfzdJTPSfOmu/nQOV/4o2Rwg39tcYzDmiuhEnzlJYZFQVhiOdCN+OH7V9yDkZHxqPsviE4ZJJYsuvTvemwqBeYZ3chxX8RqLvE/Rl+ujomyJO1kgakpU5i/HXAlYs8LcT/BgTma6wZo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QHd8L+jSRfg5EWmqOKS8z6rExh2NEqk9Yz8erQNFoY=;
 b=C/CoyEixfs29nP0ClO2t4D+UxDP+VJlg2fvxDndVc5G3XjYwyuOaYOiBVmyHZN6Gqqm5Bzk7tXu1Uogr0I3hFe5FCV7AnzARhJLBl1/hXqi7QbgWuYOR8XKOaHaM7oG2yiU/KZHAPRjQ17vhDRHkCtbT6yW4vNEyjpfyvEOrCtMU4XJXEOxhf4PZ2oAzFtBSk8eajtTwriu3mecuz5zL7WG3b3imn+q/hjDK2i9/a7mLJVtgwj0kztJTxlYiB2sMaLBCVRZmTi/wncH4QsQR3VFIHl6kJWW+ttYYm3gQINA/OWZcf+141r+G2X1/ZQWIHNfgNzXfoGyfSKgiYD9jOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CH3PR11MB8237.namprd11.prod.outlook.com (2603:10b6:610:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 19:00:55 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 19:00:55 +0000
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
Thread-Index: AQHZH5FkNhHM4hOH50a42EHT2Acr4K6M9zQAgAABTYCAAA0YkIAAGukAgACKFVCAAB1UgIAAtOqQ
Date:   Wed, 4 Jan 2023 19:00:55 +0000
Message-ID: <IA1PR11MB6097960B04B064457EABDA5A9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com> <Y7RpuqbTAM11wVQG@lucifer>
 <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y7SMYF8MlzeqDgp+@lucifer>
 <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <87tu16rdea.fsf@nvidia.com>
In-Reply-To: <87tu16rdea.fsf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|CH3PR11MB8237:EE_
x-ms-office365-filtering-correlation-id: baf6bdfc-fe06-4711-000f-08daee860209
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oGwV2u/6VwxJDZxW1BYHw7E1wSoSQ9X28CA+sYOF42znU2Q/rt/wK++L3Hon0KezaFwHgZgiTX7GIalmOEQmtYFR2ahzDfFxvIvtO/xF69ECRxFcHGzJC7nynW3bP1ItJbj/Av1v4jL4dFSEQA/OX5ixBpOScHWT1DaMYA66PObw1mwxD/CSJ3LwhTknrTlAB1/96GSYjVPoZWG24+/+JXBppaS5L0u0g7eGwc55Yi3V6voY5eg6J+9OpA1DLWN0MxYgcTkuAUS9tHDDKp2LUNh+dRpt1tqq8mwNBInMOsDSPZAMg5xLw6dkUDu9BmyD0J+8WkHCOZMKpN+AdNANY5IPp0vm0iY+qq9fSYcTI7fewKgcNPaO9nKalcAteuN1/VDYYrDFDTbOo548EGWfBUMyOy7xDRSaDyIE+b60J24O8RtKUFH+qVt0O6Oy4Ox599KwLoSrp/oH6OXHe1nwb9HAQiI/mjCw4Z3mpTm34xWVSFVL5ANdGo7JcaUpY+OD6+fjHFJlB6oifw0yPgIbVzpEaNC1ftMtCNRGuuRwIDu6uW4ff6oFs3athQnx6n84T53fzVuiPMU1mh81IG9sgSn2/L7c7debp24GDEuAOh3Uzq23zQAus9L/M5jrOfEleAO50Lt3NRVTANgipqI3ZNztmKM0cnL7EEXAfSMEG54UGKUmhjXdC4T06E4WNyEO0cE9B1SLwnOErMjx6PDttg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(9686003)(186003)(26005)(38070700005)(38100700002)(82960400001)(86362001)(122000001)(55016003)(83380400001)(41300700001)(52536014)(8936002)(4326008)(8676002)(5660300002)(66556008)(66446008)(64756008)(66946007)(66476007)(316002)(76116006)(107886003)(478600001)(54906003)(6506007)(6916009)(7696005)(71200400001)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2RouIXy1LRzIrpLsYfSw1u3EkGrZ9SRqnkbiHWhYMrzgexlCU6L4zGFwL1dm?=
 =?us-ascii?Q?dIHO0jH7ZzZBSL67dpU5Xj5SUjkCaPiGJsoqOabVV9SykP8XBnUKq4OuqNPu?=
 =?us-ascii?Q?0j544rKeeED3BwJGACj1CnUbuG3tltt2KuhQ2CXX/4sN+PxrBjOVyezLdJUA?=
 =?us-ascii?Q?m+BNZdnXfxlU1vmM6HQVI5G/Zt0SAfM+GkwVPENMNlMGbc495LZFDleAAX4a?=
 =?us-ascii?Q?Dr/XsSrtKyQG7H6AIm5t5qAKS2GbrLy4zxJV5Q4XnOUKXKlzZ4KLrCnOZ1uV?=
 =?us-ascii?Q?joTSzk16ZVAAiCqwkNA9di6B0mJt858r9VwTNNOCktbJdFL5n8p6gU7hpcwS?=
 =?us-ascii?Q?Pr111ba/o6Uu1vccMjOSQNNs7X/gbmIQVN5p+jSnoINbV9+s+0Ydc/66Ca/Z?=
 =?us-ascii?Q?+wXN1wTw1Rkwc+Q6tIOtDiIDtj1eMWsAtJIFmC7LpEYw3l+ecH33zp1uOkkv?=
 =?us-ascii?Q?Gu30Ij5bpVvmxOzhEqeWhLEJWKGncAJisKQRqhf+P+w0SO0D8IpHnVP+/q/6?=
 =?us-ascii?Q?Z9DGpvuiA45po07DN6oKjVrZfRK+Ds4hZgkYJni2SjVHr+x1C61ttEk4PirJ?=
 =?us-ascii?Q?1aQ0ZiiWasfpBpFGB0qfois6JdtXZhWv5oIWeOOIFFVNS4kGEujRDwV7Khr6?=
 =?us-ascii?Q?KMLFvg0qv9liTdYaCrfY/biL38EoJH1f7WCuMIj9tlaAkVtdw4wyhre4CEzM?=
 =?us-ascii?Q?wTFnD4RS0qz+26tHtmSW82fGLVgY0K0+GSMpKFk8qckCVYgBAFkzc1R3Dr4L?=
 =?us-ascii?Q?zuVrArHQQTOhgz7fxHUjLZCW2hl5t1FD9t1oESywPMcxzROJCl/inWMmAuy3?=
 =?us-ascii?Q?gUbMZVILeYyWFWvI1K0XBOAA5d2s4w9UsoDEJ2QWSj45+mCaHcm2j79ifB34?=
 =?us-ascii?Q?+LsLCgm7RcE8XrrA4SmNjh+HXJ+0Ry3dMjgQKRK6sq+aGWl57mi8AmCqyLpd?=
 =?us-ascii?Q?1Sk4UmX2u7QrCPwvrdpjQs26wZOMEzgeB2IwoxGCivzO8B334ux7m9H9WvQl?=
 =?us-ascii?Q?UkNDCbahcAekTFGO8aamA7B8GAZG8WdSStncXmKOoyejq3a4xtED7O2RU4VI?=
 =?us-ascii?Q?XSjzpiK7pBmuHq+gsDGtywyIQ1OzWql40mOUvmgF7YKUo5KuEF7OgwkdPkjY?=
 =?us-ascii?Q?1vVgpTY+JHwWSEm0X8chvTp0iQeotuu1Pdez/brFIqv8PrN1bLyGXBg0cxOp?=
 =?us-ascii?Q?cV1P+I4OlaegAaG1SLnZuvMYkasCJlQNpFaS8j4TRj3YuHBg90uOr06BooBg?=
 =?us-ascii?Q?UodFZLMoHJAf2jNP6cZeuPVEYJRz0QO9s4SOUTjhCxztbRthLXCTqjWooeve?=
 =?us-ascii?Q?jNtErpuHcySwwC0KBj7NJPC4H8gGIOKWnP01XKiDDe3SKTRsWVWr2zG6/qN6?=
 =?us-ascii?Q?c75tljPH1LN/uuw+TJDWXBuJ4Mjacif/WEcKIN/ykxTtK4JOF+mbcT1OwATB?=
 =?us-ascii?Q?n9TTVcdfe18DhtdJsZg+SQ/Ce/RIdW2OpCXQs7s7XupZH4cQ51qvMt7JQ+mX?=
 =?us-ascii?Q?1AvUDusYziqZlCKnLMbih8gsq38D5zSaFXhe6+Sd8Nuh49er9ySaiKK6UWBX?=
 =?us-ascii?Q?X1jWo/eE8Un+w76Q4zi0si//HJzmTVOkrdBtpbpw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf6bdfc-fe06-4711-000f-08daee860209
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 19:00:55.2894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXNircNDO58QDSRdX7kxk6rfrRhcD/35/WxRXlmaq77889nguEW8c5pn5xD034NDO99AqCIoFflejIDoxz3yHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8237
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

Hi, Alistair and Lorenzo,

> >> > access_remote_vm(mm) directly call __access_remote_vm(mm).
> >> > access_process_vm(tsk) calls mm=3Dget_task_mm() then
> >> __access_remote_vm(mm).
> >> >
> >> > So instead of access_remote_vm(mm), it's access_process_vm(tsk)
> >> > that holds a reference count on the mm, right?
> >>
> >> Indeed!
> >>
> >> >
> >> > > >
> >> > > > Is there a reason you can't use access_process_vm() which is
> >> > > > exported and additionally handles the refrencing?
> >> >
> >> > IDXD interrupt handler starts a work which needs to access remote vm=
.
> >> > The remote mm is found by PASID which is saved in device event log.
> >> >
> >> > In the work, it's hard to get the remote mm from a task because
> >> > mm->owner could be NULL but the mm is still existing.
> >>
> >> That makes sense, however I do feel nervous about exporting something
> >> that that relies on this reference.
> >>
> >> The issue is ensuring that the mm can't be taken from underneath you,
> >> the only user of access_remote_vm(), procfs, does a careful dance
> >> using get_task_mm() and
> >> mm_access() to ensure this can't happen, if _sometimes_ the remote mm
> >> might have an owner and _sometimes_ not it feels like any exported
> >> function needs to be equally careful?
>=20
> I think the point is the remote mm should be valid as long as the PASID i=
s valid
> because it doesn't make sense to have a PASID without associated memory m=
ap.
> iommu_sva_find() does mmget_not_zero() to ensure that.
>=20
> Obviously something must still be holding a mmgrab() though. That should
> happen as part of the PASID allocation done by iommu_sva_bind_device().
>=20
> >> I definitely don't feel as if simply exporting this is a safe option,
> >> and you would in that case need a new function that handles different
> >> scenarios of mm ownership/not.
>=20
> Note this isn't that different from get_user_pages_remote().
>=20
> >> I may be missing something here and I will wait for others to chime
> >> in but I think we would definitely need something more than simply exp=
orting
> this.
> >
> > I may define and export a new wrapper access_remote_vm_ref() which
> > will hold mm's reference count before accessing it:
> > int access_remote_vm_ref(mm)
> > {
> >    int ret;
> >
> >    if (mm =3D=3D &init_mm)
> >         return 0;
> >
> >    mmget(mm);
> >    ret =3D access_remote_vm(mm);
> >    mmput(mm);
> >
> >    return ret;
> > }
> > EXPORT_SYMBOL_GPL(access_remote_vm_ref);
> >
> > IDXD or any driver calls this and holds mm reference count while access=
es the
> mm.
> > This is useful for caller to directly access mm even if mm's owner coul=
d be
> NULL.
>=20
> I'm not sure that helps much. A driver would still need to hold a mm_coun=
t to
> ensure the struct_mm itself can't go away anyway so it may as well do the
> mmget() IMHO (although it really should be mmget_not_zero()).
>=20
> In any case though iommu_sva_find() already takes care of doing
> mmget_not_zero().

That's right. IDXD driver calls iommu_sva_find() which holds mm reference b=
efore
access_remote_vm(mm) and puts the count after.

And comment of access_remote_vm() explicitly says "The caller must hold a r=
eference on @mm.".
IDXD follows the mm reference policy. There is no need to have a different =
wrapper.

So the current patch is good without any change, right?

> I wonder if it makes more sense to define a wrapper (eg.
> iommu_access_pasid) that takes a PASID and does the mm
> lookup/access_vm/mmput?

Currently access_remove_vm() is called only once in IDXD. And the calling c=
ode
is clearly to have mmget() and mmput() already. The proposed
wrapper iommu_access_pasid() may not be very useful. We may add the wrapper
in the future if there are more usages. Is that OK?

Thanks.

-Fenghua
