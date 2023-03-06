Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EBF6ACD02
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCFStR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjCFStQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:49:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6221ADCF;
        Mon,  6 Mar 2023 10:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128555; x=1709664555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sd152X7t2obY89N7T+yb8zPezpwCa4tk55MFgObrCTU=;
  b=V735mFy/qDCK+WqbISGUpwZ6sszT5h6RHVknW497Bz7hIVhUjThA8PfJ
   86PBGNz4nrgRLms1njemdaDyueYfzNuvyBo6iyGzsq+b4BEaqzQERA27P
   n/JVr/wt26QYwjlX8vfuKwZL89ocnUxSp48wxT0D31Z3kF8u7eYONwYL4
   PTH4rSJi6rv0RcyhyONoBSCF/dW+Fsu76Df2AVLOSD4pAktW1nY8bWgBU
   0qOQho8ZqngKUucfVKWKGesfScxjuNhk4D7l0Qat3HIgTdVV6wumZ1YIF
   wyWUEGvPw6tXT6wfUSIretSSDj86ntB2RTcwPpSe5PCYXArqawQETXlen
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="319472797"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="319472797"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:48:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="678595220"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="678595220"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 06 Mar 2023 10:48:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 10:48:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 10:48:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 10:48:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPKknq8MMo+1i5KkwA87EhcHZaiFgE0W6IrWMxfm31WYFS66GSHUec50YBklu2dpQuIvKRwTzfeJkBw1ZZhiOKqpa/QbNLlSUHuCRzRLrxxvx5okZlce3S0Ahk/jOTH8pNE3cjBkb1HVWKu6VT8KlkvG49BN7ICboPAyezUPh4oy0hvYTiH2hZUhTo0eviw/HpAZzpNpBQFkf0k567NlbaSYA0XgHthSwZXX/OrmoeGmwF/3YJSpEK+5iaTH4yH5RuHyVV+wOFlWcUxnDGiWuCFj1Et/2DMVdudK501xkxeQ1VCpGxZNlTHJ+DAYecjHrpWj9EjfZXZAiZCONt34YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sd152X7t2obY89N7T+yb8zPezpwCa4tk55MFgObrCTU=;
 b=lLBYGBRhffpHwrQ/lKvU7P8jgUn91buErAh4e8Ka0+B64+Pu2SnoUr9wD+sOGgoAngo7yir8h7pqPbBftpdkcWrFM2mAqISpG91ezsakVy6Fr9DiWs0ziwhjqfE3Qu4XpZyGqqLmIavoAaL+x7yumVd6Fr4VoAMpgy/CDj0c8iRqCweN3qqHD0eE7zoUn+mQuPVruQqca+M+fWzYdkIQNRq7Bs0LBNEusOncnKnjD/Vhro8iNvHtyYCE8dqcS099vMy36vZwyPt4/JGK6dE4QZB5qe60J1YbpUnwhb2HcP4cJF8ursgW2BZp9/jCCols1LTECP45DTNeVykwl7PFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW3PR11MB4713.namprd11.prod.outlook.com (2603:10b6:303:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 18:48:43 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%8]) with mapi id 15.20.6156.019; Mon, 6 Mar 2023
 18:48:43 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Thread-Topic: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Thread-Index: AQHZTKHLMpaMrjsH4E2pa8RpL32hkK7nPYCAgAJc2YCABCPvAIAATvUA////3YCAAAQCgIAABegAgAAHJ2A=
Date:   Mon, 6 Mar 2023 18:48:43 +0000
Message-ID: <SJ1PR11MB6083DFA2C1D00B00C3918982FCB69@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230303134753.660d0755@jacob-builder> <ZAXkLN39VUSl+t65@nvidia.com>
 <20230306094408.2d675d5b@jacob-builder> <ZAYmS4Sx6bm+ziDY@nvidia.com>
 <20230306095759.1dd65cca@jacob-builder> <ZAYunPcgSOGFK8Qi@nvidia.com>
In-Reply-To: <ZAYunPcgSOGFK8Qi@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW3PR11MB4713:EE_
x-ms-office365-filtering-correlation-id: 08f1c4d5-7e43-497d-3952-08db1e736918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ExiUh+guc7vnT0Y5teVRQ6Z4m++zoeClIfxzPqaBO97lK3NUbMpX6i5XBDpxIo8PyEQ/JU9OC8mRSQ8rXl0akqwk9su9ZlV3n5ONe0l6zWpqyhSkTGj7HO+eR2yAEtWAulUt3kBPleVmvcRnekzdtxrbGF96HS5MKkWj1cA5kn3gdysRyHzvpS+9T7VveUv1G+imIoGCRUGZUlgTBq5eavyQMLCv5zFXIrqi8zNIyKw8q7uZTE98ncmQEa0uIJfNLHDLqYtIPSDtmTa2jx6scJWaLtCZsmSHbSMad82XLouO+OAClh8rTKEiB2LR00gbaLK+Z4YPrg81N2aZCHu2yJVjEHW0D3hfnbFqSxnu9j6ZlBowoFmatPrSPocOneUPeWGYG1SssN4kbUm69bRyXGXKc842RhkXtdlNApNhnbAi7nSHQy6ire0RRynz00kQ4k6VrJ+ngrVOeHfp3GDtzzVGoU3O/GwrhVrMNpTaY/lJiRADFNdug9RTsEqFPbzfp4ouDvpb8NeQPy3oFsARDyJYcCB0Oz7MH+8H8lp4d7AGtmWghYlAI0dgf2WG+7BkX8s0LKvcwfE0NCpgVfbi5GmZ+AkSwwJcTJsxTAwZXZc9xjgtSNScSoNSs4owSWQvnet0fZ8pTHTigeyBIiL6KfdE/8+5tMYGT93Bd9TpZXIySksTFXyTSnmpm6nR0C+XP5W1xXcjPJK/4DKBd2cxLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199018)(9686003)(186003)(122000001)(38100700002)(38070700005)(52536014)(8936002)(66446008)(66556008)(66946007)(41300700001)(8676002)(2906002)(5660300002)(4744005)(66476007)(4326008)(76116006)(71200400001)(7416002)(7696005)(82960400001)(478600001)(26005)(64756008)(6506007)(316002)(110136005)(54906003)(86362001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KjDZc3Lf2dUX12TAfvEzzpf1hYOg/aZJsk4bxOI6SSnc3Jr+JOm8ZtEQ9qMP?=
 =?us-ascii?Q?vJrb4si7bHYCdVP0j+/gG2BNl8/lYGWftPbEZgmzhItV+3A2etrCEHXpNcI4?=
 =?us-ascii?Q?G/IM50l6R8+JKFQzFgnbxomyh5wjmxHXd9YQmMjqZwIO8jv/dvP9xuQBfUtj?=
 =?us-ascii?Q?+dvyNjomtb7KW2cy/+69YGv8bAcnjidFll34YwXoMCucX7w4ri/CTeg3WGvd?=
 =?us-ascii?Q?gHutUVAW/KuK/zb7jijSft12Ka+3Sr82G8AXZQWiPtW7wysHDDixjR9NhMpS?=
 =?us-ascii?Q?lmVLkHY2iQtsR6V9SzDXPieVDNjzTvRhqgTEX+2u2fYuEdwANlmdZ7+qH3aq?=
 =?us-ascii?Q?gGvKIoPxnlzmNKUvQlHcuGg6It30qkKlCUWMns1LfUNSVXwTJxBpOgHViB2p?=
 =?us-ascii?Q?T3+GKs2avW8hgtJNN7ibfW8p3C8OV4/jn9vibbGJISYLUg4KnllahzLaxpDX?=
 =?us-ascii?Q?PN5LWfWCaDcp5OO4IGRRfenAWnQ9FQYMDiveA0msGngADtk9kxwvqcxerwPU?=
 =?us-ascii?Q?ceyk/dYe9NZ0l0+Fb2nQvdzDFJkUpZNMLqntRJrvVRZOnlOFCNV/Rw8ZWH3f?=
 =?us-ascii?Q?GzjkwFR+llc2etjDxCJrBHrZezjo8oIvoi9+slXcJwfE/rourT+i6didzyL9?=
 =?us-ascii?Q?VEtzOGC0mTlfXEIW/GtJAEz6FWWgH4a/7xYV3ApPibPO6b4IwbK5BzcQdfvM?=
 =?us-ascii?Q?l+M9h5OwRreEWwHQD13OrlUal9iq+XffU8mtzYzh6S95kEI7DKQSJMBXiXnb?=
 =?us-ascii?Q?XuoTYVW4SnYOsbAsS5Cn+4XdgqsHHCc9C0fg5WXf3yBjh4J6lkM91/tOi8VH?=
 =?us-ascii?Q?1mM/QcfTeKhWJ5e7EQyj2Ap8eMxeBhOKFwn8Ytdl5fe88UmSwZ5xw8TarzyV?=
 =?us-ascii?Q?k2Knd8kDJeCk08PaK2WHQQmlZExOvhOj/7PbCuc7ihlKd26/9EHYSQdUCabS?=
 =?us-ascii?Q?J0rUVeV45SETyMV6oxV694s7UrZvcIZeuFz0pDDcUElm7Ygce6z4Y9qH2wNa?=
 =?us-ascii?Q?RygCPWMeLwfQm9pAFxafjudgE7MQDEdalf4CzGKHTK12G9DRoOKUWmWeqnon?=
 =?us-ascii?Q?Ktxxhx2CMckvNj3skwAHbiv64B35mOlGQGEnP7Rx9RAAWzwvGoL6P68QAyDg?=
 =?us-ascii?Q?Pcz+1PXQ97Idzr3m8Nc8IqD3r8CZTcg27J2lMQDyhuwM/H7qgIaFMfmoN0Xl?=
 =?us-ascii?Q?qlnShv9Oq+BrvSlwO6bhlPEkfsBSCYtDAyQ801iTLy/gJLTswyzOwxya/0JH?=
 =?us-ascii?Q?AdAB/CN/eRjIVlC/8VZPQJRBjai4Yd/ggN3wm7nAB//0v1/7MXZOHv3RJzaX?=
 =?us-ascii?Q?qmCw2x91iuuz4Ls5KFVwyrBx86o2GqYxWUj6+sllu8ilxe5k5kzfYqSEMio9?=
 =?us-ascii?Q?BXOPrevsIrzLuoWYeM4juA/LqAVsJRdSmvzirSDJ8UTkPnoP+kEfu1ixP8F2?=
 =?us-ascii?Q?tl3axTNxpxJnyFbi2voWphAH1yfB8hIZmXxtLJp42N/PoryKTbFPMj7YU9uy?=
 =?us-ascii?Q?vDNisrMECipMg3qcG5SPIEhR95vpd/t8cOoLmC2Dlz7WpDjBSqQfMlkMkX99?=
 =?us-ascii?Q?y93e4Je9GI3XqRTOUoQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f1c4d5-7e43-497d-3952-08db1e736918
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 18:48:43.5856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Y+rW7noMNUf/XjG1oavRrRohSt4LWMdsQycnFLp+CsMgRWASBgradtakHMyL3mII+SbCtJAaqVLj0OI1koMFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4713
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

>> ENQCMDS does not have the restriction of using a single CPU MSR to store
>> PASIDs, PASID is supplied to the instruction operand.=20
>
> Huh? That isn't what it says in the programming manual. It says the
> PASID only comes from the IA32_PASID msr and the only two operands are
> the destination MMIO and the memory source for the rest of the payload.

Jason,

Two different instructions with only one letter different in the name.

ENQCMD - ring 3 instruction. The PASID is inserted into the descriptor
pushed to the device from the IA32_PASID MSR.

ENQCMDS - ring 0 instruction (see that trailing "S" for Supervisor mode).
In this case the submitter can include any PASID value they want in the
in-memory copy of the descriptor and ENQCMDS will pass that to the
device.

-Tony
