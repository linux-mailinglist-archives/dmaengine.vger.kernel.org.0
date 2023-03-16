Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA776BC67D
	for <lists+dmaengine@lfdr.de>; Thu, 16 Mar 2023 08:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCPHIS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 03:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCPHIR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 03:08:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDE82FCC7;
        Thu, 16 Mar 2023 00:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678950496; x=1710486496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yhe0Nei4JrMQNOUOFYaZ/Sz3fKnuXB+KrhXj8S7Mw+k=;
  b=j63HJAsppHlUE8IztMXCfewY+dvKIXkc46UKYx5Ct9Hj5fPwYsv8Mcib
   YS8vTHNkYq1jyeICfvARI+2waAyg2zUMtHScRx8yLAtcrypRd7VdoVlfI
   vPwsldshOINN6OFlB9oxWJMrI4Ngr6PfG4Ooy7ZfTUIOxuAXzs8/qvEHT
   LLk+vvy7TZqPhpSSKlFwns48uxx3pRdtVsr7+pXfjE/IxXqWEN0kjcmaB
   qW7VtXDtT538cvcgQvOGFn8ESybZj6FbCtaoh4x4ntnqqBD0Gp3LRi0T9
   V4zmCtDBxpvOo1+oo69ZGtf2zfTnlzs+AW8ZmxxQqJZFOG5AocYagPtyi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321750548"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="321750548"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="657080601"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="657080601"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2023 00:08:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 00:08:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 00:08:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 00:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYTi2gnyJnVdix1+owzPJ+jXYDW84bAN1ay+slQ8fBoGx1b7ZBDKg9UF0Y143+qdX1pc0n0sbXgah5FkcQFqzwC7yD8GW0K43a5ANbdGG2J6pAhMVxsQCJoYumKxtNCJNAUsj9ScZjuq0oy2Xo4BDbM7Mj5lCV0zvkSixGkze54t66UASIkWgk/8zv3Nc8+dbuJC/m662+1+Z2E5KLw8XfAx5lZpt2Ao9txxPRB8ItyNGkCk5cX75r7YIpOIyDP+/uNwml/UnRPTdUcQWumP17Hc9w3lK7/dBpi7cWw8c2r/mzRlP/D/1VG55i+B1LSCeL/5xLz5cBgFh8yMbWVyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhe0Nei4JrMQNOUOFYaZ/Sz3fKnuXB+KrhXj8S7Mw+k=;
 b=lTuVdugT3XmQmhOGfz+bltrgSNEsAoC7Nb/pX+eE/LY/Ii4C8nBzO4I1SeYvMNIGzJlSAPqUAtpQPPuxfdWjiuwCkK4kKq3wKHsfMrYMceLdz2eguHRj5CjvHqvfssCCMSHdJG7s4TedmxzcpOdrkzSAgKpYcFRrCZ2ApBdEIX5K5jOdGSU4ahmty1c4SKFHnX6vJ+GSd2s9pV1QTkiTplJNt5dop2b26lw9sZOevciCeCBgMNymBnwXDl7UXautWDf47I9h2R4iVM8h0VZ5FzX4eTPDjSw1L7cEdmM+v9rS7vp0pLoLbsnhQDVA5iMHjLpSEBR/Cw1eyMpbiOmpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 07:08:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 07:08:11 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] dmaengine: idxd: Add enable/disable device IOPF
 feature
Thread-Topic: [PATCH v2 1/5] dmaengine: idxd: Add enable/disable device IOPF
 feature
Thread-Index: AQHZUjLzUw5wB1YKxECK0Mnwfbv4h679B52Q
Date:   Thu, 16 Mar 2023 07:08:11 +0000
Message-ID: <BN9PR11MB5276497A71CA0219FEAED5AA8CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-2-baolu.lu@linux.intel.com>
In-Reply-To: <20230309025639.26109-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB7757:EE_
x-ms-office365-filtering-correlation-id: 32d21066-12ea-4f0e-3cdd-08db25ed33ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hJSfAICrI8WNI+KsyDbt5HTcge8XQzFBj9yaBDkCbsq745lg2HfLbyFz8XOh7/vQUeabuUBMqjeHQA5vBO+59+y1cmV3e4fs599E/8eWg8ySnNYzOrBmGEsJjnxyOIXzWZsn7Q3UJ/hVHWN5tGXqKugzfOmdGIbiD+FmPmUJTS1oyBegrFV4n2/WtM2cVLnGAMQ+no7/Bk4F8CUyONfQtLuhQuoG9HLwIzGLyhRE36OAeNscIxkpJa8DgnRf975uAwO3x3uO+5TQQAYqdXHq3Tjv2rraUoIEfW2BLW7YefLFjr7WPU+pQmisXFNJ9/P8xQJx/r7NIBKbZX/+86KQS8bTE9itXV+fxpHn1OAOnCK7yP6dEEeJkml9p2GvaguxTQBA0qKop2ax3N1iV3fWV3BT1b+IGQ7zNVpmqVpFoINfbXNw/4OknIO2Ckig0LR30P+oYpj7aT3VX85BD1BuhXjKX64Oue7laDjJ/aITlY8i78DhRwX99XSuDI4A7ZEinLbJjjcJHH3vDPV86z+/ZDvu5Ym+Oorwg2IaIBiGUqMyKE8wYOqUSVSjnoD63URDpnBL8PfQvrJ5Srb1TeyuTfUAp0sqzqU2/+Wk4xgRHKsR41G4/fPmkGlHg1pCoUqgRCha0Z1WHpXkRC+avaXMj0NyT9XAXa5auf+q2Xjk0dQlNT09XDiZUvBCt1WM26wzoqAewHkFWOF62X5aOLv4Dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199018)(38070700005)(82960400001)(86362001)(33656002)(122000001)(38100700002)(7696005)(2906002)(52536014)(41300700001)(4744005)(8936002)(5660300002)(55016003)(66556008)(6506007)(26005)(9686003)(186003)(4326008)(316002)(110136005)(54906003)(83380400001)(66946007)(64756008)(8676002)(76116006)(478600001)(66446008)(71200400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BKMAcG5C25UN/k5+FgrhKsWlTXLws5ZlPiAPwqEvT32CmmgNA8kx6rtHBMZr?=
 =?us-ascii?Q?gnxX8b3wa+So2zpMhjvpRVtAElQfN5zhrALK3PoTpoQETviH6e1EnqImhrBk?=
 =?us-ascii?Q?3ySF27dEG4NiO+n0b0afCfEhgOBodCd2N9Zmu9eQF4oMRGpEK/VLqdF0PNzM?=
 =?us-ascii?Q?Vz6cmrgpVS9KZpSaKIAVivCqVuAdDSGK1cayDTXv+kquLZZ6ayucIilk+iaM?=
 =?us-ascii?Q?Osr+N8+ZBJmkRro/Fmk/5oEI6qGSyV8gUN1NBwmEosnYXuD+JV4bpatgAEzo?=
 =?us-ascii?Q?ZoPvQmj06uPUJ9go2zmWatFRHbHZiO8uFKGEJfwnJN9TUg3KuOuZ8Vc/5aZ7?=
 =?us-ascii?Q?OUFJngZlOS5bZz/wHyZQC5moZ1xRn5+ZoZno1mpnkG7Wy/jorHI7tTXOurp+?=
 =?us-ascii?Q?bcYCJn3Q3d5odYe+fc1BdoVDlHvmp0FGWoNQAkswa7sMAaaNYU0eWu0T4u1X?=
 =?us-ascii?Q?LEony7Gkvg07jR9ywZjpCtpqz4OUmpDDPURPQvmq6olGV0tXqPK6wFayUPRn?=
 =?us-ascii?Q?YWpRm3IlMAnXCZb4OA+O7iB1FzjAvCzUuiptn8rsT5mRWu3iHhL0Aemhbld6?=
 =?us-ascii?Q?c+C3aqOxs/V4p+EAbG7QU1NDvwfhTb29NKpQfz5Rti0JyUzNnsD3076uVZ/J?=
 =?us-ascii?Q?OL2Y/uUFIUXiH5fvo3ivx19FywwlVvn1mJXdWh0Aa1xnwDovV692syX9WrBW?=
 =?us-ascii?Q?lEljZAcrdj+e/P3UBQMVtWYj/sm5FxpMcULk6VLcWft8Il8uFkE/aLCcCENp?=
 =?us-ascii?Q?qZfZgZ3d2+x5huFa/KP5Bav/1LzYFFQ7X69H3il33UI98KiUe2BBFfjTIIbH?=
 =?us-ascii?Q?mr+//7oTNYqPsQCyr5cbf7ef5tJKH0MdEoISwwpz4XIb3jOVL5aKNnIFtEZ4?=
 =?us-ascii?Q?lJHDw1hR8Dz86gGvPHNENXZr+WN6QlQcME5NwZw4BrI/yfYuiG0Yxth1hgwa?=
 =?us-ascii?Q?C77FqLLgIoOWaeoYbGP9sV2o+Q/zz+IPCrEwqLsV43YNb2u4Qd+FyZG3hGhV?=
 =?us-ascii?Q?qq7t3gxLlLedoL4+4F6b1m+HxBSQba/w1H4MbQeghUHN9Gq0Pvae+K1ohI0O?=
 =?us-ascii?Q?TTtaPSXHJivf4O2FrpEUIQ52DCFLNWdxwYv3EV/JbmdvPY+WPXXlsXoea3cn?=
 =?us-ascii?Q?0BLmF26hYdWNLvoo+A9fil0TEuIeOB2ckVmO8D3FVdnrGdncEq+1CMrVES4T?=
 =?us-ascii?Q?nEETu1/VLBwlT/HR0xLIPngMdQUa4ZtGsec+FdA/9DIZ7q8txzCgrTYgGEjN?=
 =?us-ascii?Q?YH3TNdMfzGMi69GHeMUq3f/uARX2Qs6RIOLuiKzefO/ANOaNB8FPf4M/G+Hj?=
 =?us-ascii?Q?hzH6e/RxR8NpHEMh4DQPS6r8vH+vr71DBhW3TG1g+A9MCcXiwR4AOOuOf1Dt?=
 =?us-ascii?Q?Rm98GVworXd/1s/H9+hTsraYyMF5yP864n6bzm7+0px47mx4IWgQA9afw6M8?=
 =?us-ascii?Q?FTlyQ70qE793mC670P/JSG+dl9Y2JA7st/wovrlMXoOMwEbQwQmASN3/KF6r?=
 =?us-ascii?Q?J2FoOcPDJbmA7xoKY2BL8BY/uSkXrzNuAoAsVuq2TSsNw6MmRAWwUmD4MlLw?=
 =?us-ascii?Q?Oq6MjPwAslQHYu22wSxEIvGXdYiBsVo727kSVucG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d21066-12ea-4f0e-3cdd-08db25ed33ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 07:08:11.2586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+EZ9sPpzEjprllWqJLP5mzd32+ds/kPZ8pHdjZY4Az3vgqFC65D5SjAVT7lvyBpJOielO4C9USXfVQF5yWWag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7757
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, March 9, 2023 10:57 AM
>=20
> The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled
> before
> and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
> on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in
> this
> driver.
>=20
> At present, missing IOPF enabling/disabling doesn't cause any real issue,
> because the IOMMU driver places the IOPF enabling/disabling in the path
> of SVA feature handling. But this may change.
>=20
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
